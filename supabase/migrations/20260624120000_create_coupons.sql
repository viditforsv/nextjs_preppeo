-- ─────────────────────────────────────────────────────────────────────────
-- Coupons: capped, percentage-discount promo codes for unified checkout.
--
-- A coupon is a non-partner discount code applied to the whole cart subtotal
-- at /api/checkout/create-order. Distinct from `partners` (which carries a
-- commission payout); a coupon is a pure marketing giveaway with a global
-- redemption cap and a one-per-user limit.
--
--   coupons              — the code, percent off, and cap.
--   coupon_redemptions   — one row per (coupon, user). UNIQUE enforces 1/user.
--   redeem_coupon(...)   — atomic claim, called once on a *paid* order during
--                          fulfillment (slots are consumed by payers, not by
--                          abandoned carts).
--
-- token_purchases gains coupon_id / coupon_code so a purchase records which
-- coupon (if any) discounted it.
--
-- Seeds PREPPEOSAT99: 99% off, first 100 redemptions — the Reddit/SAT promo.
-- ─────────────────────────────────────────────────────────────────────────

create table if not exists public.coupons (
  id                uuid primary key default gen_random_uuid(),
  code              text not null unique,
  description       text,
  discount_percent  numeric(5,2) not null check (discount_percent > 0 and discount_percent <= 100),
  max_redemptions   integer not null check (max_redemptions > 0),
  redeemed_count    integer not null default 0 check (redeemed_count >= 0),
  is_active         boolean not null default true,
  expires_at        timestamptz,
  created_at        timestamptz not null default now()
);

create table if not exists public.coupon_redemptions (
  id           uuid primary key default gen_random_uuid(),
  coupon_id    uuid not null references public.coupons(id) on delete cascade,
  user_id      uuid not null references public.profiles(id) on delete cascade,
  purchase_id  uuid references public.token_purchases(id) on delete set null,
  created_at   timestamptz not null default now(),
  unique (coupon_id, user_id)   -- one redemption per user, per coupon
);

create index if not exists idx_coupon_redemptions_coupon on public.coupon_redemptions(coupon_id);

alter table public.token_purchases
  add column if not exists coupon_id   uuid references public.coupons(id),
  add column if not exists coupon_code text;

-- Service-role only: all access is server-side via the API client. Enable RLS
-- with no policies so anon/auth clients can't read the table directly.
alter table public.coupons enable row level security;
alter table public.coupon_redemptions enable row level security;

-- ── Atomic redemption claim ────────────────────────────────────────────────
-- Locks the coupon row, refuses a second claim by the same user (idempotent),
-- refuses once the cap is reached, otherwise records the redemption and bumps
-- the counter. Returns true only when a fresh slot was claimed.
create or replace function public.redeem_coupon(
  p_coupon_id  uuid,
  p_user_id    uuid,
  p_purchase_id uuid
) returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
  v_max     integer;
  v_count   integer;
begin
  select max_redemptions, redeemed_count
    into v_max, v_count
    from public.coupons
   where id = p_coupon_id
   for update;   -- serialize concurrent claims on this coupon

  if v_max is null then
    return false;  -- unknown coupon
  end if;

  -- Already redeemed by this user → no-op (idempotent re-fulfillment).
  if exists (
    select 1 from public.coupon_redemptions
     where coupon_id = p_coupon_id and user_id = p_user_id
  ) then
    return false;
  end if;

  if v_count >= v_max then
    return false;  -- cap reached
  end if;

  insert into public.coupon_redemptions (coupon_id, user_id, purchase_id)
  values (p_coupon_id, p_user_id, p_purchase_id);

  update public.coupons
     set redeemed_count = redeemed_count + 1
   where id = p_coupon_id;

  return true;
end;
$$;

-- ── Seed the Reddit/SAT promo ───────────────────────────────────────────────
insert into public.coupons (code, description, discount_percent, max_redemptions)
values ('PREPPEOSAT99', 'Reddit SAT launch — 99% off for the first 100 students', 99, 100)
on conflict (code) do nothing;

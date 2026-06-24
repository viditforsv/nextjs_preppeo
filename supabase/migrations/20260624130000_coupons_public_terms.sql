-- ─────────────────────────────────────────────────────────────────────────
-- Coupons: public listing + per-code terms.
--
--   is_public  — when true, the code is listed on /pricing for all visitors
--                (via /api/coupons/public). Defaults false so codes are
--                hidden/targeted (e.g. typed-only Reddit codes) unless an
--                admin opts them in.
--   terms      — the code's OWN terms & conditions, shown in a modal next to
--                the code. Generic terms aren't enough; each offer states its
--                own rules.
--
-- PREPPEOSAT99 stays is_public = false (Reddit-only, works when typed) but
-- gets its specific terms so the modal is meaningful when it's applied.
-- ─────────────────────────────────────────────────────────────────────────

alter table public.coupons
  add column if not exists is_public boolean not null default false,
  add column if not exists terms     text;

update public.coupons
   set terms = '99% off your entire Preppeo cart. Limited to the first 100 students — the code closes automatically once it has been claimed 100 times. One use per student/account. Applies to the items in your current cart and cannot be combined with any other coupon or referral code. A small amount (about ₹20 on a single mock pack) stays payable to confirm your order — this is a discount, not free checkout. Non-transferable and holds no cash value. Preppeo may change or withdraw this offer at any time.'
 where code = 'PREPPEOSAT99'
   and terms is null;

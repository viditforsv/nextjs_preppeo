-- ============================================================================
-- Pricing update — set real INR + USD prices, restructure SAT tiers
-- ----------------------------------------------------------------------------
-- Source: "Docs for me/comm.md" (independent INR and USD price sheets — the two
-- are NOT a fixed exchange rate, so each currency is stored explicitly).
--
-- What this does:
--   1. Adds a `price_usd` column to token_packs and subscription_plans. The
--      existing `price` column stays the INR price (Razorpay charges INR).
--   2. SAT mock tiers become 3 / 5 / 10 (₹1,999/2,999/4,999 · $29/45/79).
--      Adds the 10-mock pack and raises SAT total_sets to 10 so a 10-pack
--      passes the checkout cap. (User confirmed 10 distinct sets are ready /
--      being built — sets 6–10 need content before prod.)
--   3. SAT Practice Mode becomes 1 / 3 / 6 / 12 months (the 2-month tier is
--      retired). Prices: ₹1,499/3,499/5,999/9,999 · $29/69/119/199.
--
-- Target: DEV branch (dxhxpfouzjlzpeazwrqo) ONLY. Promote to prod after QC.
-- ============================================================================

-- 1. USD price columns (INR stays in `price`).
ALTER TABLE public.token_packs        ADD COLUMN IF NOT EXISTS price_usd numeric(10, 2);
ALTER TABLE public.subscription_plans ADD COLUMN IF NOT EXISTS price_usd numeric(10, 2);

-- 2. SAT mock packs: 3 / 5 / 10.
UPDATE public.token_packs SET price = 1999, price_usd = 29 WHERE exam_type = 'sat' AND token_count = 3;
UPDATE public.token_packs SET price = 2999, price_usd = 45 WHERE exam_type = 'sat' AND token_count = 5;

INSERT INTO public.token_packs (exam_type, name, token_count, price, price_usd, is_active)
SELECT 'sat', '10 SAT Mock Tests', 10, 4999, 79, true
WHERE NOT EXISTS (
  SELECT 1 FROM public.token_packs WHERE exam_type = 'sat' AND token_count = 10
);
UPDATE public.token_packs SET price = 4999, price_usd = 79 WHERE exam_type = 'sat' AND token_count = 10;

-- Allow the 10-pack to pass the checkout cap (token_count <= total_sets).
UPDATE public.exam_types SET total_sets = 10 WHERE id = 'sat';

-- 3. SAT Practice Mode: 1 / 3 / 6 / 12 months; retire the 2-month tier.
UPDATE public.subscription_plans SET price = 1499, price_usd = 29  WHERE exam_type = 'sat' AND plan_type = 'practice_only' AND duration_days = 30;
UPDATE public.subscription_plans SET price = 3499, price_usd = 69  WHERE exam_type = 'sat' AND plan_type = 'practice_only' AND duration_days = 90;
UPDATE public.subscription_plans SET price = 5999, price_usd = 119 WHERE exam_type = 'sat' AND plan_type = 'practice_only' AND duration_days = 180;
UPDATE public.subscription_plans SET price = 9999, price_usd = 199 WHERE exam_type = 'sat' AND plan_type = 'practice_only' AND duration_days = 365;
UPDATE public.subscription_plans SET is_active = false             WHERE exam_type = 'sat' AND plan_type = 'practice_only' AND duration_days = 60;

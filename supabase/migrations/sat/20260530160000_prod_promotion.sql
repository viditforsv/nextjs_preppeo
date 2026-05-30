-- ============================================================================
-- PROD promotion — unified checkout + INR/USD pricing for /pricing
-- ----------------------------------------------------------------------------
-- Consolidates the dev migrations (120000 unified_checkout, 130000 pricing_inr_usd,
-- 150000 practice_price_update) into one prod-tailored migration.
--
-- DIFFERENCES from dev (deliberate):
--   • NO 10-mock pack and total_sets stays 5 — prod has only 5 SAT sets.
--     Mock tiers on prod are 3 and 5 only.
--   • Dedupe step omitted — prod token_packs has no duplicate rows.
--
-- All statements are idempotent. Target: PROD project ootnqmojcqnzfrtvzzec.
-- ============================================================================

-- 1. Schema: a bundle checkout pays for multiple products in one order.
ALTER TABLE public.token_purchases ALTER COLUMN pack_id DROP NOT NULL;

CREATE TABLE IF NOT EXISTS public.purchase_items (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  purchase_id uuid NOT NULL REFERENCES public.token_purchases(id) ON DELETE CASCADE,
  item_type   text NOT NULL CHECK (item_type IN ('mock', 'practice')),
  ref_id      uuid NOT NULL,
  unit_price  numeric(10, 2) NOT NULL CHECK (unit_price >= 0),
  quantity    integer NOT NULL DEFAULT 1 CHECK (quantity > 0),
  metadata    jsonb NOT NULL DEFAULT '{}'::jsonb,
  fulfilled   boolean NOT NULL DEFAULT false,
  created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS purchase_items_purchase_id_idx ON public.purchase_items (purchase_id);
ALTER TABLE public.purchase_items ENABLE ROW LEVEL SECURITY;

-- 2. Explicit USD price columns (INR stays in `price`).
ALTER TABLE public.token_packs        ADD COLUMN IF NOT EXISTS price_usd numeric(10, 2);
ALTER TABLE public.subscription_plans ADD COLUMN IF NOT EXISTS price_usd numeric(10, 2);

-- 3. SAT mock packs — 3 and 5 only (no 10-pack on prod yet).
UPDATE public.token_packs SET price = 1999, price_usd = 29 WHERE exam_type = 'sat' AND token_count = 3;
UPDATE public.token_packs SET price = 2999, price_usd = 45 WHERE exam_type = 'sat' AND token_count = 5;

-- 4. SAT Practice Mode — 1 / 3 / 6 / 12 months; retire 2-month.
INSERT INTO public.subscription_plans
  (exam_type, plan_type, name, price, duration_days, mock_tokens_included, is_active)
SELECT v.exam_type, v.plan_type, v.name, v.price, v.duration_days, 0, true
FROM (VALUES
  ('sat', 'practice_only', 'Practice Mode — 3 Months',  14999, 90),
  ('sat', 'practice_only', 'Practice Mode — 6 Months',  19999, 180),
  ('sat', 'practice_only', 'Practice Mode — 12 Months', 24999, 365)
) AS v(exam_type, plan_type, name, price, duration_days)
WHERE NOT EXISTS (
  SELECT 1 FROM public.subscription_plans sp
  WHERE sp.exam_type = v.exam_type AND sp.name = v.name
);

UPDATE public.subscription_plans SET price = 9999,  price_usd = 29  WHERE exam_type='sat' AND plan_type='practice_only' AND duration_days = 30;
UPDATE public.subscription_plans SET price = 14999, price_usd = 69  WHERE exam_type='sat' AND plan_type='practice_only' AND duration_days = 90;
UPDATE public.subscription_plans SET price = 19999, price_usd = 119 WHERE exam_type='sat' AND plan_type='practice_only' AND duration_days = 180;
UPDATE public.subscription_plans SET price = 24999, price_usd = 199 WHERE exam_type='sat' AND plan_type='practice_only' AND duration_days = 365;
UPDATE public.subscription_plans SET is_active = false             WHERE exam_type='sat' AND plan_type='practice_only' AND duration_days = 60;

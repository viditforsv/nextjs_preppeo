-- ============================================================================
-- Unified checkout: bundle "purchase_items" + Practice Mode plan tiers
-- ----------------------------------------------------------------------------
-- What this does:
--   1. Makes token_purchases.pack_id NULLABLE. A single bundle checkout pays
--      for multiple products at once, so the parent purchase row has no single
--      pack_id; line items live in the new purchase_items table. (This also
--      fixes the existing subscriptions flow, which already inserts
--      pack_id = NULL — see src/app/api/subscriptions/create-order/route.ts.)
--   2. Creates purchase_items: one row per product in a bundle checkout.
--   3. Seeds the missing SAT "Practice Mode" tiers (3 / 6 / 12 months) so the
--      pricing page can offer 1/2/3/6/12-month practice access. 1- and 2-month
--      rows already exist (practice_only, ₹9,999 / ₹14,999).
--
-- Template: follows the token_purchases / subscription_plans conventions.
-- Prereq: token_purchases, subscription_plans, token_packs already exist.
-- Target: DEV branch (dxhxpfouzjlzpeazwrqo) ONLY. Promote to prod after QC.
--
-- !!! PLACEHOLDER PRICES !!!
--   The 3/6/12-month prices below are PLACEHOLDERS pending the user's final
--   price sheet. Update them before promoting to prod.
-- ============================================================================

-- 1. Allow bundle parent rows (and subscription purchases) to have no pack_id.
ALTER TABLE public.token_purchases
  ALTER COLUMN pack_id DROP NOT NULL;

-- 2. Bundle line items: one row per product in a single checkout.
CREATE TABLE IF NOT EXISTS public.purchase_items (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  purchase_id uuid NOT NULL REFERENCES public.token_purchases(id) ON DELETE CASCADE,
  item_type   text NOT NULL CHECK (item_type IN ('mock', 'practice')),
  ref_id      uuid NOT NULL,              -- token_packs.id (mock) | subscription_plans.id (practice)
  unit_price  numeric(10, 2) NOT NULL CHECK (unit_price >= 0),
  quantity    integer NOT NULL DEFAULT 1 CHECK (quantity > 0),
  metadata    jsonb NOT NULL DEFAULT '{}'::jsonb,
  fulfilled   boolean NOT NULL DEFAULT false,
  created_at  timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS purchase_items_purchase_id_idx
  ON public.purchase_items (purchase_id);

-- Service-role only (API routes use the service client; no public RLS access).
ALTER TABLE public.purchase_items ENABLE ROW LEVEL SECURITY;

-- 3. Seed SAT Practice Mode tiers 3 / 6 / 12 months (idempotent on name).
--    PLACEHOLDER prices — confirm with user before prod.
INSERT INTO public.subscription_plans
  (exam_type, plan_type, name, price, duration_days, mock_tokens_included, is_active)
SELECT v.exam_type, v.plan_type, v.name, v.price, v.duration_days, v.mock_tokens_included, true
FROM (VALUES
  ('sat', 'practice_only', 'Practice Mode — 3 Months',  19999.00, 90,  0),
  ('sat', 'practice_only', 'Practice Mode — 6 Months',  34999.00, 180, 0),
  ('sat', 'practice_only', 'Practice Mode — 12 Months', 59999.00, 365, 0)
) AS v(exam_type, plan_type, name, price, duration_days, mock_tokens_included)
WHERE NOT EXISTS (
  SELECT 1 FROM public.subscription_plans sp
  WHERE sp.exam_type = v.exam_type AND sp.name = v.name
);

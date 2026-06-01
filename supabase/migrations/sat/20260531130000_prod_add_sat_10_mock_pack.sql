-- ============================================================================
-- PROD — add the SAT 10-mock pack
-- ----------------------------------------------------------------------------
-- Target: PROD project ootnqmojcqnzfrtvzzec.
-- Now that prod has 10 live mock sets (see 20260531120000), offer a 10-pack,
-- mirroring dev: ₹4999 / $79. Idempotent.
-- ============================================================================

INSERT INTO public.token_packs (exam_type, name, token_count, price, price_usd, is_active)
SELECT 'sat', '10 SAT Mock Tests', 10, 4999, 79, true
WHERE NOT EXISTS (
  SELECT 1 FROM public.token_packs WHERE exam_type = 'sat' AND token_count = 10
);

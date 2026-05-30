-- ============================================================================
-- Revised SAT Practice Mode INR prices (per user, 2026-05-30)
-- ----------------------------------------------------------------------------
-- 1mo ₹9,999 · 3mo ₹14,999 · 6mo ₹19,999 · 12mo ₹24,999.
-- USD prices unchanged (set in 20260530130000_pricing_inr_usd.sql).
-- Apply to dev AND prod.
-- ============================================================================
UPDATE public.subscription_plans SET price = 9999  WHERE exam_type='sat' AND plan_type='practice_only' AND duration_days = 30;
UPDATE public.subscription_plans SET price = 14999 WHERE exam_type='sat' AND plan_type='practice_only' AND duration_days = 90;
UPDATE public.subscription_plans SET price = 19999 WHERE exam_type='sat' AND plan_type='practice_only' AND duration_days = 180;
UPDATE public.subscription_plans SET price = 24999 WHERE exam_type='sat' AND plan_type='practice_only' AND duration_days = 365;

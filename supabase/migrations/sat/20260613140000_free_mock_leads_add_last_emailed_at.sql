-- Add last_emailed_at to free_mock_leads to support repeat report emails with an
-- atomic, per-address send throttle.
--
-- The lead API claims the right to send by conditionally updating this column
-- (only when it is NULL or older than the throttle window). Because concurrent
-- requests re-evaluate the predicate against the just-updated row, exactly one of
-- them wins the claim. This:
--   (a) fixes a bug where one finish could fire 2-3 emails (rapid/concurrent
--       submits all passed a non-atomic "first capture?" check), and
--   (b) rate-limits this public endpoint so it can't be used to email-bomb an
--       address or burn ZeptoMail sending credits.

ALTER TABLE public.free_mock_leads
  ADD COLUMN IF NOT EXISTS last_emailed_at timestamptz;

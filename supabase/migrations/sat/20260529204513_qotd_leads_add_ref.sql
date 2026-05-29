-- Add a `ref` attribution column to qotd_leads.
--
-- Purpose: marketing attribution for the Question of the Day lead engine.
-- A referral link like preppeo.com/qotd?ref=va carries ?ref=va through the
-- /qotd -> /question-of-the-day redirect (Next.js preserves the query string);
-- the page forwards it to /api/qotd/capture, which records it here. The admin
-- dashboard (/admin/analytics/qotd-refs) then groups signups by ref so each
-- VA / channel's contribution is visible (e.g. bonus per 50 unique signups).
--
-- `source` is left unchanged: it names the engine ('qotd'). `ref` is the
-- attribution channel (who drove the visit) and is NULL for direct/organic.
--
-- Follows the additive-column convention of 20260528120000_create_qotd_leads.sql.
-- Prerequisite: that migration (table qotd_leads) must already be applied.

ALTER TABLE public.qotd_leads
  ADD COLUMN IF NOT EXISTS ref text;

CREATE INDEX IF NOT EXISTS qotd_leads_ref_idx
  ON public.qotd_leads (ref);

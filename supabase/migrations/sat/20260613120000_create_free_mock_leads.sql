-- Create free_mock_leads: email captures from anonymous visitors who finish the
-- free SAT mock (/sat-test?freemock=1) and enter their email to unlock the full
-- score report on the results screen. This plugs the funnel leak where a
-- non-converting finisher previously left no trace (no email, no saved attempt).
--
-- Template: mirrors qotd_leads (20260528120000_create_qotd_leads.sql).
--
-- Writes happen ONLY via the service-role API route (/api/sat-free/lead), so RLS
-- is enabled with no public policies — anon/authenticated clients cannot read or
-- write the lead list. The service role bypasses RLS.
--
-- One row per email (unique index); the API uses ON CONFLICT DO NOTHING so a
-- repeat finisher doesn't duplicate the lead. Score columns hold the estimated
-- scores from the attempt that triggered the capture (best-effort, nullable).

CREATE TABLE IF NOT EXISTS public.free_mock_leads (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email        text NOT NULL,
  total_score  smallint,
  math_score   smallint,
  rw_score     smallint,
  source       text NOT NULL DEFAULT 'free_mock',
  ref          text,
  user_agent   text,
  created_at   timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS free_mock_leads_email_uniq
  ON public.free_mock_leads (email);

CREATE INDEX IF NOT EXISTS free_mock_leads_created_at_idx
  ON public.free_mock_leads (created_at DESC);

ALTER TABLE public.free_mock_leads ENABLE ROW LEVEL SECURITY;

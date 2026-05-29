-- Create qotd_leads: email captures from the public "Question of the Day"
-- lead engine (/question-of-the-day). A row is written when a visitor enters
-- their email to unlock the AI Concept Breakdown for that day's question.
--
-- Writes happen ONLY via the service-role API route (/api/qotd/capture), so
-- RLS is enabled with no public policies — anon/authenticated clients cannot
-- read or write the lead list. The service role bypasses RLS.
--
-- Append-friendly: a (email, question_id) unique index lets the same person
-- come back on different days without duplicating a single day's capture
-- (the API uses ON CONFLICT DO NOTHING).

CREATE TABLE IF NOT EXISTS public.qotd_leads (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email           text NOT NULL,
  question_id     uuid,
  rotation_index  smallint,
  source          text NOT NULL DEFAULT 'qotd',
  user_agent      text,
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS qotd_leads_email_question_uniq
  ON public.qotd_leads (email, question_id);

CREATE INDEX IF NOT EXISTS qotd_leads_email_idx
  ON public.qotd_leads (email);

CREATE INDEX IF NOT EXISTS qotd_leads_created_at_idx
  ON public.qotd_leads (created_at DESC);

ALTER TABLE public.qotd_leads ENABLE ROW LEVEL SECURITY;

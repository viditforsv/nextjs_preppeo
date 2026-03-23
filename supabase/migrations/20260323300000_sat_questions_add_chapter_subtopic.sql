ALTER TABLE public.sat_questions
  ADD COLUMN IF NOT EXISTS chapter TEXT,
  ADD COLUMN IF NOT EXISTS subtopic TEXT;

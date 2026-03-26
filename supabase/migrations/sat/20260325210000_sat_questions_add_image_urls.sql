-- SAT: allow multiple prompt images per question (ordered list).
-- MCQ option images use optional image_url inside options JSONB (no schema change).

ALTER TABLE sat_questions
  ADD COLUMN IF NOT EXISTS image_urls TEXT[] DEFAULT NULL;

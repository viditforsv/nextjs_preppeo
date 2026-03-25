ALTER TABLE cbse10_science_questions
  ADD COLUMN IF NOT EXISTS is_pyq            BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS pyq_year          TEXT,
  ADD COLUMN IF NOT EXISTS correct_answer_b  TEXT;

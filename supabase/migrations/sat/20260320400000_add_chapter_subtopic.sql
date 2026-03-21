-- Add chapter and subtopic columns for granular practice filtering

ALTER TABLE sat_questions
  ADD COLUMN IF NOT EXISTS chapter TEXT,
  ADD COLUMN IF NOT EXISTS subtopic TEXT;

CREATE INDEX IF NOT EXISTS idx_sat_questions_subtopic ON sat_questions(subtopic);
CREATE INDEX IF NOT EXISTS idx_sat_questions_chapter ON sat_questions(chapter);

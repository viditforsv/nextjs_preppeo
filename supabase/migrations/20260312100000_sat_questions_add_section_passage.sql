-- Add section and passage columns to sat_questions for R&W support

ALTER TABLE sat_questions
  ADD COLUMN section TEXT NOT NULL DEFAULT 'math',
  ADD COLUMN passage TEXT;

-- Replace the old domain constraint with one that includes R&W domains
ALTER TABLE sat_questions DROP CONSTRAINT IF EXISTS sat_questions_domain_check;
ALTER TABLE sat_questions ADD CONSTRAINT sat_questions_domain_check
  CHECK (domain IN (
    'algebra', 'advanced-math', 'problem-solving', 'geometry-trig',
    'craft-structure', 'information-ideas', 'standard-english', 'expression-of-ideas'
  ));

-- Section must be math or rw
ALTER TABLE sat_questions ADD CONSTRAINT sat_questions_section_check
  CHECK (section IN ('math', 'rw'));

-- R&W questions are MCQ only
ALTER TABLE sat_questions ADD CONSTRAINT sat_questions_rw_mcq_only
  CHECK (section != 'rw' OR type = 'mcq');

CREATE INDEX idx_sat_questions_section ON sat_questions(section);

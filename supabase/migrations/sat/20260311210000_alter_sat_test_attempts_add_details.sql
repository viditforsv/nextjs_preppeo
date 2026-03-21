-- Add per-question responses and estimated SAT score
ALTER TABLE sat_test_attempts
  ADD COLUMN estimated_score INT,
  ADD COLUMN question_responses JSONB NOT NULL DEFAULT '[]';

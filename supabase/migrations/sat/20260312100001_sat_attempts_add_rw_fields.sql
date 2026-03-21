-- Extend sat_test_attempts with R&W section data and combined scoring

ALTER TABLE sat_test_attempts
  ADD COLUMN section_type TEXT NOT NULL DEFAULT 'math',
  ADD COLUMN rw_module1_correct INT,
  ADD COLUMN rw_module1_total INT,
  ADD COLUMN rw_module1_time_used INT,
  ADD COLUMN rw_module2_tier TEXT,
  ADD COLUMN rw_module2_correct INT,
  ADD COLUMN rw_module2_total INT,
  ADD COLUMN rw_module2_time_used INT,
  ADD COLUMN rw_estimated_score INT,
  ADD COLUMN rw_question_responses JSONB NOT NULL DEFAULT '[]',
  ADD COLUMN total_estimated_score INT;

ALTER TABLE sat_test_attempts ADD CONSTRAINT sat_attempts_section_type_check
  CHECK (section_type IN ('math', 'rw', 'full'));

ALTER TABLE sat_test_attempts ADD CONSTRAINT sat_attempts_rw_m2_tier_check
  CHECK (rw_module2_tier IS NULL OR rw_module2_tier IN ('hard', 'easy'));

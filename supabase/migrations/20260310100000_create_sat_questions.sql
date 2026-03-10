-- ============================================================
-- SAT Math CBT: sat_questions table
-- ============================================================

CREATE TABLE IF NOT EXISTS sat_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('mcq', 'spr')),
  prompt TEXT NOT NULL,
  options JSONB,
  correct_answer TEXT NOT NULL,
  explanation TEXT,
  domain TEXT CHECK (domain IN ('algebra', 'advanced-math', 'problem-solving', 'geometry-trig')),
  difficulty_tier TEXT NOT NULL CHECK (difficulty_tier IN ('easy', 'medium', 'hard')),
  module_number INT NOT NULL CHECK (module_number IN (1, 2)),
  set_number INT NOT NULL DEFAULT 1,
  image_url TEXT,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_sat_questions_set_module ON sat_questions(set_number, module_number);
CREATE INDEX idx_sat_questions_difficulty ON sat_questions(difficulty_tier);

ALTER TABLE sat_questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read sat_questions"
  ON sat_questions FOR SELECT
  USING (true);

CREATE POLICY "Admin manage sat_questions"
  ON sat_questions FOR ALL
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

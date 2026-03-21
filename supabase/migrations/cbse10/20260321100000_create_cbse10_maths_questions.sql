-- CBSE Class 10 Mathematics question bank

CREATE TABLE IF NOT EXISTS cbse10_maths_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('mcq', 'spr')),
  prompt TEXT NOT NULL,
  options JSONB,
  correct_answer TEXT NOT NULL,
  explanation TEXT,
  domain TEXT CHECK (domain IN (
    'real-numbers', 'polynomials', 'linear-equations', 'quadratic-equations',
    'arithmetic-progressions', 'triangles', 'coordinate-geometry', 'trigonometry',
    'applications-of-trig', 'circles', 'areas-related-to-circles',
    'surface-areas-volumes', 'statistics', 'probability'
  )),
  difficulty_tier TEXT NOT NULL CHECK (difficulty_tier IN ('easy', 'medium', 'hard')),
  chapter TEXT,
  subtopic TEXT,
  bank_item_id TEXT,
  image_url TEXT,
  is_active BOOLEAN NOT NULL DEFAULT true,
  ai_explanation TEXT,
  ai_theory TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS cbse10_maths_questions_bank_item_id_unique
  ON cbse10_maths_questions (bank_item_id);
CREATE INDEX idx_cbse10_maths_questions_domain ON cbse10_maths_questions(domain);
CREATE INDEX idx_cbse10_maths_questions_difficulty ON cbse10_maths_questions(difficulty_tier);
CREATE INDEX idx_cbse10_maths_questions_chapter ON cbse10_maths_questions(chapter);
CREATE INDEX idx_cbse10_maths_questions_subtopic ON cbse10_maths_questions(subtopic);

ALTER TABLE cbse10_maths_questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read cbse10_maths_questions"
  ON cbse10_maths_questions FOR SELECT
  USING (true);

CREATE POLICY "Admin manage cbse10_maths_questions"
  ON cbse10_maths_questions FOR ALL
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

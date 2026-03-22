-- CBSE Class 10 Science question bank

CREATE TABLE IF NOT EXISTS cbse10_science_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('mcq', 'spr')),
  prompt TEXT NOT NULL,
  options JSONB,
  correct_answer TEXT NOT NULL,
  explanation TEXT,
  domain TEXT CHECK (domain IN (
    'chemical-reactions', 'acids-bases-salts', 'metals-non-metals',
    'carbon-compounds', 'life-processes', 'control-coordination',
    'reproduction', 'heredity-evolution', 'light',
    'human-eye', 'electricity', 'magnetic-effects', 'our-environment'
  )),
  difficulty_tier TEXT NOT NULL CHECK (difficulty_tier IN ('easy', 'medium', 'hard')),
  chapter TEXT,
  subtopic TEXT,
  bank_item_id TEXT,
  image_url TEXT,
  is_active BOOLEAN NOT NULL DEFAULT true,
  ai_explanation TEXT,
  ai_theory TEXT,
  qc_done BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS cbse10_science_questions_bank_item_id_unique
  ON cbse10_science_questions (bank_item_id);
CREATE INDEX idx_cbse10_science_questions_domain ON cbse10_science_questions(domain);
CREATE INDEX idx_cbse10_science_questions_difficulty ON cbse10_science_questions(difficulty_tier);
CREATE INDEX idx_cbse10_science_questions_chapter ON cbse10_science_questions(chapter);
CREATE INDEX idx_cbse10_science_questions_subtopic ON cbse10_science_questions(subtopic);

ALTER TABLE cbse10_science_questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read cbse10_science_questions"
  ON cbse10_science_questions FOR SELECT
  USING (true);

CREATE POLICY "Admin manage cbse10_science_questions"
  ON cbse10_science_questions FOR ALL
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- IBDP Mathematics question banks (4 courses)
-- AA HL, AA SL, AI HL, AI SL share the same schema

-- ─── AA HL ────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS ibdp_aa_hl_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('mcq', 'spr')),
  prompt TEXT NOT NULL,
  options JSONB,
  correct_answer TEXT NOT NULL,
  explanation TEXT,
  domain TEXT CHECK (domain IN (
    'number-algebra', 'functions', 'geometry-trigonometry',
    'statistics-probability', 'calculus'
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

CREATE UNIQUE INDEX IF NOT EXISTS ibdp_aa_hl_questions_bank_item_id_unique
  ON ibdp_aa_hl_questions (bank_item_id);
CREATE INDEX idx_ibdp_aa_hl_questions_domain ON ibdp_aa_hl_questions(domain);
CREATE INDEX idx_ibdp_aa_hl_questions_difficulty ON ibdp_aa_hl_questions(difficulty_tier);

ALTER TABLE ibdp_aa_hl_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read ibdp_aa_hl_questions"
  ON ibdp_aa_hl_questions FOR SELECT USING (true);
CREATE POLICY "Admin manage ibdp_aa_hl_questions"
  ON ibdp_aa_hl_questions FOR ALL
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- ─── AA SL ────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS ibdp_aa_sl_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('mcq', 'spr')),
  prompt TEXT NOT NULL,
  options JSONB,
  correct_answer TEXT NOT NULL,
  explanation TEXT,
  domain TEXT CHECK (domain IN (
    'number-algebra', 'functions', 'geometry-trigonometry',
    'statistics-probability', 'calculus'
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

CREATE UNIQUE INDEX IF NOT EXISTS ibdp_aa_sl_questions_bank_item_id_unique
  ON ibdp_aa_sl_questions (bank_item_id);
CREATE INDEX idx_ibdp_aa_sl_questions_domain ON ibdp_aa_sl_questions(domain);
CREATE INDEX idx_ibdp_aa_sl_questions_difficulty ON ibdp_aa_sl_questions(difficulty_tier);

ALTER TABLE ibdp_aa_sl_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read ibdp_aa_sl_questions"
  ON ibdp_aa_sl_questions FOR SELECT USING (true);
CREATE POLICY "Admin manage ibdp_aa_sl_questions"
  ON ibdp_aa_sl_questions FOR ALL
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- ─── AI HL ────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS ibdp_ai_hl_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('mcq', 'spr')),
  prompt TEXT NOT NULL,
  options JSONB,
  correct_answer TEXT NOT NULL,
  explanation TEXT,
  domain TEXT CHECK (domain IN (
    'number-algebra', 'functions', 'geometry-trigonometry',
    'statistics-probability', 'calculus'
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

CREATE UNIQUE INDEX IF NOT EXISTS ibdp_ai_hl_questions_bank_item_id_unique
  ON ibdp_ai_hl_questions (bank_item_id);
CREATE INDEX idx_ibdp_ai_hl_questions_domain ON ibdp_ai_hl_questions(domain);
CREATE INDEX idx_ibdp_ai_hl_questions_difficulty ON ibdp_ai_hl_questions(difficulty_tier);

ALTER TABLE ibdp_ai_hl_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read ibdp_ai_hl_questions"
  ON ibdp_ai_hl_questions FOR SELECT USING (true);
CREATE POLICY "Admin manage ibdp_ai_hl_questions"
  ON ibdp_ai_hl_questions FOR ALL
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- ─── AI SL ────────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS ibdp_ai_sl_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('mcq', 'spr')),
  prompt TEXT NOT NULL,
  options JSONB,
  correct_answer TEXT NOT NULL,
  explanation TEXT,
  domain TEXT CHECK (domain IN (
    'number-algebra', 'functions', 'geometry-trigonometry',
    'statistics-probability', 'calculus'
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

CREATE UNIQUE INDEX IF NOT EXISTS ibdp_ai_sl_questions_bank_item_id_unique
  ON ibdp_ai_sl_questions (bank_item_id);
CREATE INDEX idx_ibdp_ai_sl_questions_domain ON ibdp_ai_sl_questions(domain);
CREATE INDEX idx_ibdp_ai_sl_questions_difficulty ON ibdp_ai_sl_questions(difficulty_tier);

ALTER TABLE ibdp_ai_sl_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read ibdp_ai_sl_questions"
  ON ibdp_ai_sl_questions FOR SELECT USING (true);
CREATE POLICY "Admin manage ibdp_ai_sl_questions"
  ON ibdp_ai_sl_questions FOR ALL
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- ─── Sample questions (1 per table) ─────────────────────────────────────────

INSERT INTO ibdp_aa_hl_questions
  (type, prompt, options, correct_answer, explanation, domain, difficulty_tier, chapter, subtopic, bank_item_id)
VALUES (
  'mcq',
  'Find the derivative of $f(x) = x^3 \ln(x)$.',
  '[{"id":"A","text":"$x^2(3\\\\ln x + 1)$"},{"id":"B","text":"$3x^2 \\\\ln x$"},{"id":"C","text":"$3x^2 \\\\ln x + x^3$"},{"id":"D","text":"$x^2 \\\\ln x + 3x^3$"}]',
  'A',
  'Using the product rule: $f''(x) = 3x^2 \cdot \ln x + x^3 \cdot \frac{1}{x} = 3x^2 \ln x + x^2 = x^2(3\ln x + 1)$.',
  'calculus',
  'medium',
  'Differential Calculus',
  'Product Rule',
  'ibdp-aa-hl-sample-001'
);

INSERT INTO ibdp_aa_sl_questions
  (type, prompt, options, correct_answer, explanation, domain, difficulty_tier, chapter, subtopic, bank_item_id)
VALUES (
  'mcq',
  'The function $f(x) = 2x + 3$. Find $f^{-1}(x)$.',
  '[{"id":"A","text":"$\\\\dfrac{x - 3}{2}$"},{"id":"B","text":"$\\\\dfrac{x + 3}{2}$"},{"id":"C","text":"$2x - 3$"},{"id":"D","text":"$\\\\dfrac{1}{2x + 3}$"}]',
  'A',
  'Let $y = 2x + 3$. Swap $x$ and $y$: $x = 2y + 3$, so $y = \frac{x-3}{2}$. Thus $f^{-1}(x) = \frac{x-3}{2}$.',
  'functions',
  'easy',
  'Functions',
  'Inverse Functions',
  'ibdp-aa-sl-sample-001'
);

INSERT INTO ibdp_ai_hl_questions
  (type, prompt, options, correct_answer, explanation, domain, difficulty_tier, chapter, subtopic, bank_item_id)
VALUES (
  'mcq',
  'A fair die is rolled twice. Find the probability that the sum of the two results equals 7.',
  '[{"id":"A","text":"$\\\\dfrac{1}{6}$"},{"id":"B","text":"$\\\\dfrac{7}{36}$"},{"id":"C","text":"$\\\\dfrac{5}{36}$"},{"id":"D","text":"$\\\\dfrac{1}{7}$"}]',
  'A',
  'There are 36 equally likely outcomes. Pairs that sum to 7: (1,6),(2,5),(3,4),(4,3),(5,2),(6,1) — 6 pairs. P = 6/36 = 1/6.',
  'statistics-probability',
  'easy',
  'Probability',
  'Equally Likely Outcomes',
  'ibdp-ai-hl-sample-001'
);

INSERT INTO ibdp_ai_sl_questions
  (type, prompt, options, correct_answer, explanation, domain, difficulty_tier, chapter, subtopic, bank_item_id)
VALUES (
  'mcq',
  'The first term of an arithmetic sequence is 3 and the common difference is 4. Find the 10th term.',
  '[{"id":"A","text":"39"},{"id":"B","text":"43"},{"id":"C","text":"40"},{"id":"D","text":"36"}]',
  'A',
  'The nth term of an AP is $u_n = u_1 + (n-1)d$. So $u_{10} = 3 + 9 \times 4 = 3 + 36 = 39$.',
  'number-algebra',
  'easy',
  'Number & Algebra',
  'Arithmetic Sequences',
  'ibdp-ai-sl-sample-001'
);

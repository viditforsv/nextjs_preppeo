-- ============================================================
-- CBT Token Infrastructure: exam_types, test_tokens, token_packs, token_purchases
-- ============================================================

-- 1. exam_types
CREATE TABLE IF NOT EXISTS exam_types (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  icon_url TEXT,
  is_active BOOLEAN NOT NULL DEFAULT true,
  total_sets INT NOT NULL DEFAULT 1,
  test_route TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE exam_types ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read exam_types"
  ON exam_types FOR SELECT
  USING (true);

CREATE POLICY "Admin manage exam_types"
  ON exam_types FOR ALL
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- 2. token_packs
CREATE TABLE IF NOT EXISTS token_packs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_type TEXT NOT NULL REFERENCES exam_types(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  token_count INT NOT NULL CHECK (token_count > 0),
  price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE token_packs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read token_packs"
  ON token_packs FOR SELECT
  USING (true);

CREATE POLICY "Admin manage token_packs"
  ON token_packs FOR ALL
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- 3. token_purchases
CREATE TABLE IF NOT EXISTS token_purchases (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  pack_id UUID NOT NULL REFERENCES token_packs(id) ON DELETE RESTRICT,
  razorpay_order_id TEXT,
  razorpay_payment_id TEXT,
  amount DECIMAL(10, 2) NOT NULL,
  currency TEXT NOT NULL DEFAULT 'INR',
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed', 'refunded')),
  tokens_generated INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE token_purchases ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users read own purchases"
  ON token_purchases FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Service insert purchases"
  ON token_purchases FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Service update purchases"
  ON token_purchases FOR UPDATE
  USING (true);

CREATE POLICY "Admin read all purchases"
  ON token_purchases FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- 4. test_tokens
CREATE TABLE IF NOT EXISTS test_tokens (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL UNIQUE,
  exam_type TEXT NOT NULL REFERENCES exam_types(id) ON DELETE CASCADE,
  set_number INT NOT NULL DEFAULT 1,
  is_free BOOLEAN NOT NULL DEFAULT false,
  owner_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  is_used BOOLEAN NOT NULL DEFAULT false,
  used_at TIMESTAMPTZ,
  used_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  purchase_id UUID REFERENCES token_purchases(id) ON DELETE SET NULL,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_test_tokens_code ON test_tokens(code);
CREATE INDEX idx_test_tokens_owner ON test_tokens(owner_id) WHERE owner_id IS NOT NULL;
CREATE INDEX idx_test_tokens_exam_type ON test_tokens(exam_type);

ALTER TABLE test_tokens ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users read own tokens"
  ON test_tokens FOR SELECT
  USING (owner_id = auth.uid() OR is_free = true);

CREATE POLICY "Service manage tokens"
  ON test_tokens FOR ALL
  USING (true);

CREATE POLICY "Admin read all tokens"
  ON test_tokens FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- ============================================================
-- Seed data: exam types
-- ============================================================
INSERT INTO exam_types (id, name, description, total_sets, test_route) VALUES
  ('gre', 'GRE', 'Graduate Record Examination – Quantitative Reasoning adaptive mock tests.', 3, '/gre-test'),
  ('sat', 'SAT', 'Scholastic Assessment Test – Full-length digital SAT practice tests.', 1, '/sat-test'),
  ('gmat', 'GMAT', 'Graduate Management Admission Test – Focus Edition mock tests.', 1, '/gmat-test'),
  ('ashoka', 'Ashoka University', 'Ashoka University Aptitude Test practice papers.', 1, '/ashoka-test'),
  ('flames', 'FLAME University', 'FLAME Aptitude Test practice papers.', 1, '/flames-test'),
  ('krea', 'Krea University', 'Krea University Aptitude Test practice papers.', 1, '/krea-test')
ON CONFLICT (id) DO NOTHING;

-- Seed data: free tokens (Set 1 for each exam)
INSERT INTO test_tokens (code, exam_type, set_number, is_free, is_active) VALUES
  ('GRE-FREE-SET1', 'gre', 1, true, true),
  ('SAT-FREE-SET1', 'sat', 1, true, true),
  ('GMAT-FREE-SET1', 'gmat', 1, true, true),
  ('ASHOKA-FREE-SET1', 'ashoka', 1, true, true),
  ('FLAMES-FREE-SET1', 'flames', 1, true, true),
  ('KREA-FREE-SET1', 'krea', 1, true, true)
ON CONFLICT (code) DO NOTHING;

-- Seed data: sample token packs
INSERT INTO token_packs (exam_type, name, token_count, price) VALUES
  ('gre', '3 GRE Mock Tests', 3, 299),
  ('gre', '5 GRE Mock Tests', 5, 449),
  ('sat', '3 SAT Mock Tests', 3, 299),
  ('sat', '5 SAT Mock Tests', 5, 449),
  ('gmat', '3 GMAT Mock Tests', 3, 349),
  ('gmat', '5 GMAT Mock Tests', 5, 499);

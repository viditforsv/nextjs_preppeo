-- GRE mock test attempt tracking
CREATE TABLE IF NOT EXISTS gre_test_attempts (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id             UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  set_number          INT NOT NULL,
  section1_correct    INT NOT NULL,
  section1_total      INT NOT NULL,
  section1_time_used  INT NOT NULL,
  section2_tier       TEXT CHECK (section2_tier IN ('easy', 'medium', 'hard')),
  section2_correct    INT,
  section2_total      INT,
  section2_time_used  INT,
  total_correct       INT NOT NULL,
  total_questions     INT NOT NULL,
  score_pct           DECIMAL(5,2) NOT NULL,
  estimated_score     INT,
  question_responses  JSONB NOT NULL DEFAULT '[]',
  started_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_gre_attempts_user ON gre_test_attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_gre_attempts_completed ON gre_test_attempts(completed_at DESC);

ALTER TABLE gre_test_attempts ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'gre_test_attempts' AND policyname = 'Users read own GRE attempts'
  ) THEN
    CREATE POLICY "Users read own GRE attempts"
      ON gre_test_attempts FOR SELECT
      USING (auth.uid() = user_id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'gre_test_attempts' AND policyname = 'Users insert own GRE attempts'
  ) THEN
    CREATE POLICY "Users insert own GRE attempts"
      ON gre_test_attempts FOR INSERT
      WITH CHECK (auth.uid() = user_id);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'gre_test_attempts' AND policyname = 'Admin read all GRE attempts'
  ) THEN
    CREATE POLICY "Admin read all GRE attempts"
      ON gre_test_attempts FOR SELECT
      USING (
        EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
      );
  END IF;
END $$;

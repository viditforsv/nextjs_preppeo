-- SAT mock test attempt tracking
CREATE TABLE IF NOT EXISTS sat_test_attempts (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  token_code        TEXT,
  set_number        INT NOT NULL,
  module1_correct   INT NOT NULL,
  module1_total     INT NOT NULL,
  module1_time_used INT NOT NULL,
  module2_tier      TEXT CHECK (module2_tier IN ('hard', 'easy')),
  module2_correct   INT,
  module2_total     INT,
  module2_time_used INT,
  total_correct     INT NOT NULL,
  total_questions   INT NOT NULL,
  score_pct         DECIMAL(5,2) NOT NULL,
  answers_json      JSONB NOT NULL DEFAULT '{}',
  started_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_sat_attempts_user ON sat_test_attempts(user_id);
CREATE INDEX idx_sat_attempts_completed ON sat_test_attempts(completed_at DESC);

ALTER TABLE sat_test_attempts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users read own attempts"
  ON sat_test_attempts FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users insert own attempts"
  ON sat_test_attempts FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admin read all attempts"
  ON sat_test_attempts FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
  );

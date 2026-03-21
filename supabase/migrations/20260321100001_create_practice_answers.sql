-- Per-question answer tracking for strength/weakness analytics (shared across all courses)

CREATE TABLE IF NOT EXISTS practice_answers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  course TEXT NOT NULL,
  question_id UUID NOT NULL,
  bank_item_id TEXT,
  answer_given TEXT,
  is_correct BOOLEAN NOT NULL,
  domain TEXT,
  chapter TEXT,
  subtopic TEXT,
  difficulty_tier TEXT,
  time_spent_ms INT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_practice_answers_user_course ON practice_answers(user_id, course);
CREATE INDEX idx_practice_answers_user_domain ON practice_answers(user_id, course, domain);
CREATE INDEX idx_practice_answers_recent ON practice_answers(user_id, created_at DESC);

ALTER TABLE practice_answers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users read own practice_answers"
  ON practice_answers FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users insert own practice_answers"
  ON practice_answers FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Service role full access on practice_answers"
  ON practice_answers FOR ALL
  USING (auth.jwt() ->> 'role' = 'service_role');

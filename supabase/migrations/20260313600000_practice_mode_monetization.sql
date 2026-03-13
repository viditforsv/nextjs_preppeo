-- 1. practice_daily_usage — tracks freemium question consumption per day
CREATE TABLE IF NOT EXISTS practice_daily_usage (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  usage_date DATE NOT NULL DEFAULT CURRENT_DATE,
  easy_used INT NOT NULL DEFAULT 0,
  medium_used INT NOT NULL DEFAULT 0,
  hard_used INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT unique_user_day UNIQUE (user_id, usage_date)
);

CREATE INDEX IF NOT EXISTS idx_practice_daily_usage_lookup
  ON practice_daily_usage(user_id, usage_date);

ALTER TABLE practice_daily_usage ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own usage"
  ON practice_daily_usage FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Service role full access on practice_daily_usage"
  ON practice_daily_usage FOR ALL
  USING (auth.jwt() ->> 'role' = 'service_role');

-- 2. subscription_plans — defines available practice mode plans
CREATE TABLE IF NOT EXISTS subscription_plans (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  plan_type TEXT NOT NULL CHECK (plan_type IN ('practice_only', 'bundle')),
  duration_days INT NOT NULL,
  mock_tokens_included INT NOT NULL DEFAULT 0,
  price DECIMAL(10,2) NOT NULL,
  exam_type TEXT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE subscription_plans ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view active plans"
  ON subscription_plans FOR SELECT
  USING (is_active = true);

CREATE POLICY "Service role full access on subscription_plans"
  ON subscription_plans FOR ALL
  USING (auth.jwt() ->> 'role' = 'service_role');

-- 3. user_subscriptions — tracks active practice-mode subscriptions
CREATE TABLE IF NOT EXISTS user_subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  plan_id UUID NOT NULL REFERENCES subscription_plans(id),
  starts_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  ends_at TIMESTAMPTZ NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT true,
  purchase_id UUID REFERENCES token_purchases(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_user_subscriptions_active
  ON user_subscriptions(user_id, is_active) WHERE is_active = true;

ALTER TABLE user_subscriptions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own subscriptions"
  ON user_subscriptions FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Service role full access on user_subscriptions"
  ON user_subscriptions FOR ALL
  USING (auth.jwt() ->> 'role' = 'service_role');

-- 4. Seed initial plans (pricing TBD — using placeholder prices)
INSERT INTO subscription_plans (name, plan_type, duration_days, mock_tokens_included, price, exam_type) VALUES
  ('Practice Mode — 1 Month',  'practice_only', 30,  0, 9999,   'sat'),
  ('Practice Mode — 3 Months', 'practice_only', 90,  0, 14999,  'sat'),
  ('Complete Prep — 3 Months', 'bundle',        90,  3, 19999,  'sat');

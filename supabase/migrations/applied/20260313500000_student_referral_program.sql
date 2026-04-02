-- 1. Add referral_code column to profiles
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS referral_code TEXT UNIQUE;

-- 2. Create trigger function to auto-generate referral codes on new profile insert
CREATE OR REPLACE FUNCTION generate_student_referral_code()
RETURNS TRIGGER AS $$
DECLARE
  chars TEXT := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  new_code TEXT;
  i INT;
  rand_bytes BYTEA;
BEGIN
  IF NEW.referral_code IS NOT NULL THEN
    RETURN NEW;
  END IF;

  LOOP
    rand_bytes := gen_random_bytes(6);
    new_code := 'PREP-';
    FOR i IN 0..5 LOOP
      new_code := new_code || substr(chars, (get_byte(rand_bytes, i) % 32) + 1, 1);
    END LOOP;
    EXIT WHEN NOT EXISTS(SELECT 1 FROM profiles WHERE referral_code = new_code);
  END LOOP;

  NEW.referral_code := new_code;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_student_referral_code
BEFORE INSERT ON profiles
FOR EACH ROW
WHEN (NEW.referral_code IS NULL)
EXECUTE FUNCTION generate_student_referral_code();

-- 3. Backfill existing users
DO $$
DECLARE
  chars TEXT := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  rec RECORD;
  new_code TEXT;
  rand_bytes BYTEA;
  i INT;
BEGIN
  FOR rec IN SELECT id FROM profiles WHERE referral_code IS NULL LOOP
    LOOP
      rand_bytes := gen_random_bytes(6);
      new_code := 'PREP-';
      FOR i IN 0..5 LOOP
        new_code := new_code || substr(chars, (get_byte(rand_bytes, i) % 32) + 1, 1);
      END LOOP;
      EXIT WHEN NOT EXISTS(SELECT 1 FROM profiles WHERE referral_code = new_code);
    END LOOP;
    UPDATE profiles SET referral_code = new_code WHERE id = rec.id;
  END LOOP;
END;
$$;

-- 4. Create student_referrals table
CREATE TABLE IF NOT EXISTS student_referrals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  referrer_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  referred_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  referrer_token_id UUID REFERENCES test_tokens(id) ON DELETE SET NULL,
  referred_token_id UUID REFERENCES test_tokens(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT unique_referral_pair UNIQUE (referrer_id, referred_id),
  CONSTRAINT no_self_referral CHECK (referrer_id != referred_id)
);

CREATE INDEX IF NOT EXISTS idx_student_referrals_referrer ON student_referrals(referrer_id);
CREATE INDEX IF NOT EXISTS idx_student_referrals_referred ON student_referrals(referred_id);

-- 5. RLS policies
ALTER TABLE student_referrals ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own referrals"
  ON student_referrals FOR SELECT
  USING (auth.uid() = referrer_id OR auth.uid() = referred_id);

CREATE POLICY "Service role full access on student_referrals"
  ON student_referrals FOR ALL
  USING (auth.jwt() ->> 'role' = 'service_role');

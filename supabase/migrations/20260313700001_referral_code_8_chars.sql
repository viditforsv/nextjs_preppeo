-- Increase referral code from 6 to 8 random chars (32^8 = ~1.1 trillion combinations)
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
    rand_bytes := gen_random_bytes(8);
    new_code := 'PREP-';
    FOR i IN 0..7 LOOP
      new_code := new_code || substr(chars, (get_byte(rand_bytes, i) % 32) + 1, 1);
    END LOOP;
    EXIT WHEN NOT EXISTS(SELECT 1 FROM profiles WHERE referral_code = new_code);
  END LOOP;

  NEW.referral_code := new_code;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Backfill existing users with new 8-char codes
DO $$
DECLARE
  chars TEXT := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  rec RECORD;
  new_code TEXT;
  rand_bytes BYTEA;
  i INT;
BEGIN
  FOR rec IN SELECT id FROM profiles WHERE referral_code IS NOT NULL AND length(referral_code) < 13 LOOP
    LOOP
      rand_bytes := gen_random_bytes(8);
      new_code := 'PREP-';
      FOR i IN 0..7 LOOP
        new_code := new_code || substr(chars, (get_byte(rand_bytes, i) % 32) + 1, 1);
      END LOOP;
      EXIT WHEN NOT EXISTS(SELECT 1 FROM profiles WHERE referral_code = new_code);
    END LOOP;
    UPDATE profiles SET referral_code = new_code WHERE id = rec.id;
  END LOOP;
END;
$$;

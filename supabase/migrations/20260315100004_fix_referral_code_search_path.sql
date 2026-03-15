-- Fix: generate_student_referral_code uses gen_random_bytes() from pgcrypto
-- which lives in the 'extensions' schema. The previous search_path fix excluded
-- 'extensions', causing "function gen_random_bytes(integer) does not exist"
-- and breaking new user signup.

CREATE OR REPLACE FUNCTION public.generate_student_referral_code()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path TO 'public', 'extensions', 'pg_temp'
AS $$
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
$$;

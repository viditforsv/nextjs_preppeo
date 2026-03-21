-- Add course column to practice_daily_usage for per-course free limits

ALTER TABLE practice_daily_usage ADD COLUMN IF NOT EXISTS course TEXT NOT NULL DEFAULT 'sat';

ALTER TABLE practice_daily_usage DROP CONSTRAINT IF EXISTS unique_user_day;
ALTER TABLE practice_daily_usage ADD CONSTRAINT unique_user_day_course UNIQUE (user_id, usage_date, course);

DROP INDEX IF EXISTS idx_practice_daily_usage_lookup;
CREATE INDEX IF NOT EXISTS idx_practice_daily_usage_lookup
  ON practice_daily_usage(user_id, usage_date, course);

-- Update claim function to accept course parameter
CREATE OR REPLACE FUNCTION claim_practice_usage(
  p_user_id UUID,
  p_date DATE,
  p_easy INT,
  p_medium INT,
  p_hard INT,
  p_course TEXT DEFAULT 'sat'
) RETURNS TABLE(ok BOOLEAN, prev_easy INT, prev_medium INT, prev_hard INT)
AS $$
DECLARE
  cur_easy INT;
  cur_medium INT;
  cur_hard INT;
BEGIN
  INSERT INTO practice_daily_usage (user_id, usage_date, easy_used, medium_used, hard_used, course)
  VALUES (p_user_id, p_date, 0, 0, 0, p_course)
  ON CONFLICT (user_id, usage_date, course) DO NOTHING;

  SELECT pdu.easy_used, pdu.medium_used, pdu.hard_used
  INTO cur_easy, cur_medium, cur_hard
  FROM practice_daily_usage pdu
  WHERE pdu.user_id = p_user_id AND pdu.usage_date = p_date AND pdu.course = p_course
  FOR UPDATE;

  IF cur_easy + p_easy > 2 OR cur_medium + p_medium > 2 OR cur_hard + p_hard > 1 THEN
    RETURN QUERY SELECT false, cur_easy, cur_medium, cur_hard;
    RETURN;
  END IF;

  UPDATE practice_daily_usage
  SET easy_used = cur_easy + p_easy,
      medium_used = cur_medium + p_medium,
      hard_used = cur_hard + p_hard
  WHERE user_id = p_user_id AND usage_date = p_date AND course = p_course;

  RETURN QUERY SELECT true, cur_easy, cur_medium, cur_hard;
END;
$$ LANGUAGE plpgsql;

-- Atomic claim function for practice daily usage.
-- Uses FOR UPDATE row lock to prevent concurrent requests from exceeding limits.
CREATE OR REPLACE FUNCTION claim_practice_usage(
  p_user_id UUID,
  p_date DATE,
  p_easy INT,
  p_medium INT,
  p_hard INT
) RETURNS TABLE(ok BOOLEAN, prev_easy INT, prev_medium INT, prev_hard INT)
AS $$
DECLARE
  cur_easy INT;
  cur_medium INT;
  cur_hard INT;
BEGIN
  -- Ensure a row exists for today
  INSERT INTO practice_daily_usage (user_id, usage_date, easy_used, medium_used, hard_used)
  VALUES (p_user_id, p_date, 0, 0, 0)
  ON CONFLICT (user_id, usage_date) DO NOTHING;

  -- Lock the row and read current values
  SELECT pdu.easy_used, pdu.medium_used, pdu.hard_used
  INTO cur_easy, cur_medium, cur_hard
  FROM practice_daily_usage pdu
  WHERE pdu.user_id = p_user_id AND pdu.usage_date = p_date
  FOR UPDATE;

  -- Check limits (2 easy, 2 medium, 1 hard)
  IF cur_easy + p_easy > 2 OR cur_medium + p_medium > 2 OR cur_hard + p_hard > 1 THEN
    RETURN QUERY SELECT false, cur_easy, cur_medium, cur_hard;
    RETURN;
  END IF;

  -- Atomically increment
  UPDATE practice_daily_usage
  SET easy_used = cur_easy + p_easy,
      medium_used = cur_medium + p_medium,
      hard_used = cur_hard + p_hard
  WHERE user_id = p_user_id AND usage_date = p_date;

  RETURN QUERY SELECT true, cur_easy, cur_medium, cur_hard;
END;
$$ LANGUAGE plpgsql;

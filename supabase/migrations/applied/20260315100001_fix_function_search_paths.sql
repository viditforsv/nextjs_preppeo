-- Fix function_search_path_mutable for all functions missing SET search_path
-- This ONLY pins search_path and does NOT change any function behavior

-- 1. generate_student_referral_code
CREATE OR REPLACE FUNCTION public.generate_student_referral_code()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path TO 'public', 'pg_temp'
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

-- 2. claim_practice_usage
CREATE OR REPLACE FUNCTION public.claim_practice_usage(
  p_user_id UUID,
  p_date DATE,
  p_easy INT,
  p_medium INT,
  p_hard INT
) RETURNS TABLE(ok BOOLEAN, prev_easy INT, prev_medium INT, prev_hard INT)
LANGUAGE plpgsql
SET search_path TO 'public', 'pg_temp'
AS $$
DECLARE
  cur_easy INT;
  cur_medium INT;
  cur_hard INT;
BEGIN
  INSERT INTO practice_daily_usage (user_id, usage_date, easy_used, medium_used, hard_used)
  VALUES (p_user_id, p_date, 0, 0, 0)
  ON CONFLICT (user_id, usage_date) DO NOTHING;

  SELECT pdu.easy_used, pdu.medium_used, pdu.hard_used
  INTO cur_easy, cur_medium, cur_hard
  FROM practice_daily_usage pdu
  WHERE pdu.user_id = p_user_id AND pdu.usage_date = p_date
  FOR UPDATE;

  IF cur_easy + p_easy > 2 OR cur_medium + p_medium > 2 OR cur_hard + p_hard > 1 THEN
    RETURN QUERY SELECT false, cur_easy, cur_medium, cur_hard;
    RETURN;
  END IF;

  UPDATE practice_daily_usage
  SET easy_used = cur_easy + p_easy,
      medium_used = cur_medium + p_medium,
      hard_used = cur_hard + p_hard
  WHERE user_id = p_user_id AND usage_date = p_date;

  RETURN QUERY SELECT true, cur_easy, cur_medium, cur_hard;
END;
$$;

-- 3. auto_activate_free_enrollment
CREATE OR REPLACE FUNCTION public.auto_activate_free_enrollment()
RETURNS trigger
LANGUAGE plpgsql
SET search_path TO 'public', 'pg_temp'
AS $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM public.courses c
    WHERE c.id = NEW.course_id AND c.price = 0
  ) THEN
    NEW.is_active := true;
  END IF;
  RETURN NEW;
END;
$$;

-- 4. course_is_free
CREATE OR REPLACE FUNCTION public.course_is_free(c uuid)
RETURNS boolean
LANGUAGE sql
STABLE
SET search_path TO 'public', 'pg_temp'
AS $$
  select exists (
    select 1 from public.courses
    where id = c and price = 0
  );
$$;

-- 5. get_cbse_course_content (text overload — the uuid overload already has search_path)
CREATE OR REPLACE FUNCTION public.get_cbse_course_content(course_slug text)
RETURNS jsonb
LANGUAGE plpgsql
SET search_path TO 'public', 'pg_temp'
AS $$
DECLARE
  result jsonb;
BEGIN
  SELECT jsonb_build_object(
    'course', row_to_json(c.*),
    'lessons', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'id', l.id,
          'title', l.title,
          'slug', l.slug,
          'lesson_order', l.lesson_order,
          'is_preview', l.is_preview,
          'content_html', l.content_html,
          'content', l.content,
          'key_points', l.key_points,
          'video_url', l.video_url,
          'video_thumbnail', l.video_thumbnail,
          'pdf_url', l.pdf_url,
          'quiz_id', l.quiz_id,
          'quiz', (
            SELECT jsonb_build_object(
              'id', q.id,
              'title', q.title,
              'difficulty', q.difficulty,
              'time_limit', q.time_limit
            )
            FROM public.quizzes q
            WHERE q.lesson_id = l.id
            LIMIT 1
          )
        ) ORDER BY l.lesson_order
      )
      FROM public.lessons l
      WHERE l.course_id = c.id
    ), '[]'::jsonb)
  )
  INTO result
  FROM public.courses c
  WHERE c.slug = course_slug;

  RETURN result;
END;
$$;

-- 6. get_user_onboarding_status
CREATE OR REPLACE FUNCTION public.get_user_onboarding_status(user_uuid uuid)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public', 'pg_temp'
AS $$
DECLARE
    result jsonb;
BEGIN
    SELECT jsonb_build_object(
        'has_profile', (p.id IS NOT NULL),
        'onboarding_completed', COALESCE(o.is_completed, false),
        'current_step', COALESCE(o.current_step, 0),
        'profile_data', COALESCE(p::jsonb, '{}'::jsonb),
        'onboarding_data', COALESCE(o::jsonb, '{}'::jsonb)
    )
    INTO result
    FROM auth.users u
    LEFT JOIN public.user_profiles p ON u.id = p.user_id
    LEFT JOIN public.user_onboarding o ON u.id = o.user_id
    WHERE u.id = user_uuid;
    
    RETURN COALESCE(result, '{}'::jsonb);
END;
$$;

-- 7. get_user_payment_history
CREATE OR REPLACE FUNCTION public.get_user_payment_history(user_uuid uuid)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public', 'pg_temp'
AS $$
DECLARE
    result jsonb;
BEGIN
    SELECT jsonb_build_object(
        'payments', COALESCE(
            jsonb_agg(
                jsonb_build_object(
                    'id', p.id,
                    'course_id', p.course_id,
                    'amount', p.amount,
                    'currency', p.currency,
                    'provider', p.provider,
                    'status', p.status,
                    'created_at', p.created_at,
                    'course_title', c.title
                )
            ), '[]'::jsonb
        ),
        'total_payments', COUNT(*),
        'total_amount', COALESCE(SUM(p.amount), 0)
    )
    INTO result
    FROM public.payments p
    LEFT JOIN public.courses c ON p.course_id = c.id
    WHERE p.user_id = user_uuid;
    
    RETURN COALESCE(result, '{"payments": [], "total_payments": 0, "total_amount": 0}'::jsonb);
END;
$$;

-- 8. is_admin (no params)
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean
LANGUAGE plpgsql
STABLE SECURITY DEFINER
SET search_path TO 'public', 'pg_temp'
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1
    FROM profiles
    WHERE id = auth.uid()
    AND role = 'admin'
  );
EXCEPTION
  WHEN OTHERS THEN
    RETURN false;
END;
$$;

-- 9. is_admin (uid param)
CREATE OR REPLACE FUNCTION public.is_admin(uid uuid)
RETURNS boolean
LANGUAGE sql
STABLE SECURITY DEFINER
SET search_path TO 'public', 'pg_temp'
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.profiles
    WHERE id = uid
      AND role = 'admin'
  );
$$;

-- 10. is_admin_simple
CREATE OR REPLACE FUNCTION public.is_admin_simple()
RETURNS boolean
LANGUAGE plpgsql
STABLE
SET search_path TO 'public', 'pg_temp'
AS $$
BEGIN
  RETURN auth.uid() IN (
    '94726b85-7b1d-4d3f-9355-7c727ebd3bd6',
    'a2b1d35e-453b-4bc6-b68a-d9e370410459'
  );
END;
$$;

-- 11. update_course_lesson_content_updated_at
CREATE OR REPLACE FUNCTION public.update_course_lesson_content_updated_at()
RETURNS trigger
LANGUAGE plpgsql
SET search_path TO 'public', 'pg_temp'
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

-- 12. update_lesson_feedback_updated_at
CREATE OR REPLACE FUNCTION public.update_lesson_feedback_updated_at()
RETURNS trigger
LANGUAGE plpgsql
SET search_path TO 'public', 'pg_temp'
AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;

-- 13. update_updated_at_column
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path TO 'public', 'pg_temp'
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

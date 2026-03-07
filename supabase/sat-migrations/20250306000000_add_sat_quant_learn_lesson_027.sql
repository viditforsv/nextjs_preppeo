-- Create the lesson row for sat-quant-learn-sat-lid-027 so content and seed migrations can run.
-- Places 027 after the last lesson in the course (same topic/chapter as the last lesson).
-- Run before 20250306100000_sat_quant_learn_lid027_content.sql.

DO $$
DECLARE
  v_course_id   uuid;
  v_chapter_id  uuid;
  v_topic_id    uuid;
  v_next_order  int;
BEGIN
  IF EXISTS (SELECT 1 FROM public.courses_lessons WHERE slug = 'sat-quant-learn-sat-lid-027') THEN
    RAISE NOTICE 'Lesson sat-quant-learn-sat-lid-027 already exists; skipping.';
    RETURN;
  END IF;

  SELECT c.id INTO v_course_id
  FROM public.courses c
  WHERE c.slug = 'sat-quant-learn'
  LIMIT 1;

  IF v_course_id IS NULL THEN
    RAISE NOTICE 'Course sat-quant-learn not found; cannot add lesson 027.';
    RETURN;
  END IF;

  -- Use topic/chapter from the lesson with highest lesson_order in this course
  SELECT l.chapter_id, l.topic_id
  INTO v_chapter_id, v_topic_id
  FROM public.courses_lessons l
  WHERE l.course_id = v_course_id
  ORDER BY l.lesson_order DESC NULLS LAST
  LIMIT 1;

  SELECT COALESCE(MAX(lesson_order), 0) + 1 INTO v_next_order
  FROM public.courses_lessons
  WHERE course_id = v_course_id;

  INSERT INTO public.courses_lessons (
    title, slug, lesson_order, course_id, chapter_id, topic_id, lesson_type
  )
  VALUES (
    'LID 027',
    'sat-quant-learn-sat-lid-027',
    v_next_order,
    v_course_id,
    v_chapter_id,
    v_topic_id,
    'interactive'
  );

  RAISE NOTICE 'Created lesson sat-quant-learn-sat-lid-027. Run content and seed migrations next.';
END $$;

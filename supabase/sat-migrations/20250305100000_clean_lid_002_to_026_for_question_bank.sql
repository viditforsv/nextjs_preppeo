-- Clean LID 002 through LID 026 so seed migrations can run from a consistent state.
-- Removes: question_bank rows, quiz_questions, quizzes, and lesson quiz_id for these lessons.
-- Does NOT touch lesson_interactive_content (quiz JSON stays so seed migrations can read it).
-- Run before 20250305100001_seed_sat_lid_002_questions.sql and siblings.

DO $$
DECLARE
  v_lesson_ids uuid[];
  v_quiz_ids   uuid[];
  v_deleted_qb int;
  v_deleted_qq int;
  v_deleted_q  int;
BEGIN
  -- Get lesson ids for sat-quant-learn-sat-lid-002 through sat-quant-learn-sat-lid-026
  SELECT ARRAY_AGG(l.id)
  INTO v_lesson_ids
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn'
    AND l.slug ~ '^sat-quant-learn-sat-lid-0(0[2-9]|1[0-9]|2[0-6])$';

  IF v_lesson_ids IS NULL OR array_length(v_lesson_ids, 1) = 0 THEN
    RAISE NOTICE 'No lessons found for LID 002–026; nothing to clean.';
    RETURN;
  END IF;

  -- Get quiz_ids for those lessons (before we null them)
  SELECT ARRAY_AGG(quiz_id)
  INTO v_quiz_ids
  FROM public.courses_lessons
  WHERE id = ANY(v_lesson_ids)
    AND quiz_id IS NOT NULL;

  -- 1. Delete quiz_questions for those quizzes
  IF v_quiz_ids IS NOT NULL THEN
    DELETE FROM public.quiz_questions
    WHERE quiz_id = ANY(v_quiz_ids);
    GET DIAGNOSTICS v_deleted_qq = ROW_COUNT;
    RAISE NOTICE 'Deleted % quiz_questions rows.', v_deleted_qq;

    -- 2. Delete quiz rows
    DELETE FROM public.quizzes
    WHERE id = ANY(v_quiz_ids);
    GET DIAGNOSTICS v_deleted_q = ROW_COUNT;
    RAISE NOTICE 'Deleted % quizzes.', v_deleted_q;
  END IF;

  -- 3. Unlink quiz from lessons
  UPDATE public.courses_lessons
  SET quiz_id = NULL
  WHERE id = ANY(v_lesson_ids);

  -- 4. Delete question_bank rows for sat_lid_002_* through sat_lid_026_*
  DELETE FROM public.question_bank
  WHERE human_readable_id ~ '^sat_lid_0(0[2-9]|1[0-9]|2[0-6])_[0-9]+$';
  GET DIAGNOSTICS v_deleted_qb = ROW_COUNT;
  RAISE NOTICE 'Deleted % question_bank rows (LID 002–026).', v_deleted_qb;

  RAISE NOTICE 'Clean done for LID 002–026. Run seed migrations next.';
END $$;

-- Seed questions from lid_002 into question_bank and create quiz linkages.
-- Topic: Algebra / Linear Equation Word Problems
-- Depends on: 20250302100001_sat_quant_learn_lid002_content.sql
-- Idempotent via ON CONFLICT ... DO NOTHING

DO $$
DECLARE
  v_lesson_id  uuid;
  v_quiz_id    uuid;
  v_quiz_arr   jsonb;
  v_item       jsonb;
  v_idx        int;
  v_hrid       text;
  v_q_text     text;
  v_options    jsonb;
  v_answer_idx int;
  v_correct    text;
  v_expl       text;
  v_diff_text  text;
  v_diff       int;
  v_qid        uuid;
  v_new_quiz   jsonb := '[]'::jsonb;
  v_qrow       record;
  opt_val      text;
  opt_idx      int;
BEGIN
  -- Find the lesson
  SELECT l.id INTO v_lesson_id
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn'
    AND l.slug = 'sat-quant-learn-sat-lid-002'
  LIMIT 1;

  IF v_lesson_id IS NULL THEN
    RAISE NOTICE 'Lesson sat-quant-learn-sat-lid-002 not found; skipping.';
    RETURN;
  END IF;

  -- Read existing quiz JSON from content migration
  SELECT quiz INTO v_quiz_arr
  FROM public.lesson_interactive_content
  WHERE lesson_id = v_lesson_id;

  IF v_quiz_arr IS NULL OR jsonb_array_length(v_quiz_arr) = 0 THEN
    RAISE NOTICE 'No quiz data found for lid-002; skipping.';
    RETURN;
  END IF;

  -- ============================================================
  -- STEP 1: Insert questions into question_bank
  -- ============================================================
  FOR v_idx IN 0 .. jsonb_array_length(v_quiz_arr) - 1 LOOP
    v_item := v_quiz_arr->v_idx;
    v_hrid := 'sat_lid_002_' || (v_idx + 1);
    v_q_text := v_item->>'question';
    v_answer_idx := (v_item->>'answer')::int;
    v_correct := v_item->'options'->>v_answer_idx;
    v_expl := v_item->>'explanation';
    v_diff_text := COALESCE(v_item->>'difficulty', 'Medium');
    v_diff := CASE v_diff_text
                WHEN 'Easy' THEN 3
                WHEN 'Medium' THEN 5
                WHEN 'Hard' THEN 7
                ELSE 5
              END;

    SELECT jsonb_agg(jsonb_build_object('value', el))
    INTO v_options
    FROM jsonb_array_elements_text(v_item->'options') AS el;

    INSERT INTO public.question_bank (
      human_readable_id, question_text, options, correct_answer, explanation,
      difficulty, question_type, subject, source, topic, subtopic,
      is_pyq, is_active, grade
    ) VALUES (
      v_hrid, v_q_text, v_options, v_correct, v_expl,
      v_diff, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear Equation Word Problems',
      false, true, '12'
    )
    ON CONFLICT (human_readable_id) DO NOTHING;
  END LOOP;

  -- ============================================================
  -- STEP 2: Create quiz for this lesson if none exists
  -- ============================================================
  SELECT quiz_id INTO v_quiz_id
  FROM public.courses_lessons
  WHERE id = v_lesson_id;

  IF v_quiz_id IS NULL THEN
    INSERT INTO public.quizzes (title, lesson_id)
    VALUES ('lid_002 Practice', v_lesson_id)
    RETURNING id INTO v_quiz_id;

    UPDATE public.courses_lessons
    SET quiz_id = v_quiz_id
    WHERE id = v_lesson_id;
  END IF;

  -- ============================================================
  -- STEP 3: Link questions to quiz via quiz_questions
  -- ============================================================
  FOR v_idx IN 1 .. jsonb_array_length(v_quiz_arr) LOOP
    v_hrid := 'sat_lid_002_' || v_idx;
    SELECT id INTO v_qid
    FROM public.question_bank
    WHERE human_readable_id = v_hrid;

    IF v_qid IS NOT NULL THEN
      INSERT INTO public.quiz_questions (quiz_id, question_id, question_order)
      VALUES (v_quiz_id, v_qid, v_idx)
      ON CONFLICT DO NOTHING;
    END IF;
  END LOOP;

  -- ============================================================
  -- STEP 4: Rebuild lesson_interactive_content.quiz from question_bank
  -- ============================================================
  FOR v_idx IN 1 .. jsonb_array_length(v_quiz_arr) LOOP
    v_hrid := 'sat_lid_002_' || v_idx;

    SELECT id, question_text, options, correct_answer, explanation, question_type, difficulty
    INTO v_qrow
    FROM public.question_bank
    WHERE human_readable_id = v_hrid;

    IF v_qrow.id IS NULL THEN CONTINUE; END IF;

    v_answer_idx := 0;
    IF v_qrow.question_type = 'mcq' AND jsonb_array_length(v_qrow.options) > 0 THEN
      FOR opt_idx IN 0 .. jsonb_array_length(v_qrow.options) - 1 LOOP
        opt_val := v_qrow.options->opt_idx->>'value';
        IF opt_val = v_qrow.correct_answer THEN
          v_answer_idx := opt_idx;
          EXIT;
        END IF;
      END LOOP;
    END IF;

    v_item := jsonb_build_object(
      'id',             v_qrow.id::text,
      'question',       v_qrow.question_text,
      'options',        CASE
                          WHEN jsonb_array_length(v_qrow.options) > 0
                          THEN (SELECT jsonb_agg(el->>'value') FROM jsonb_array_elements(v_qrow.options) AS el)
                          ELSE '[]'::jsonb
                        END,
      'answer',         v_answer_idx,
      'correct_answer', v_qrow.correct_answer,
      'explanation',    v_qrow.explanation,
      'question_type',  v_qrow.question_type,
      'difficulty',     CASE
                          WHEN v_qrow.difficulty <= 3 THEN 'Easy'
                          WHEN v_qrow.difficulty <= 6 THEN 'Medium'
                          ELSE 'Hard'
                        END
    );

    v_new_quiz := v_new_quiz || v_item;
  END LOOP;

  UPDATE public.lesson_interactive_content
  SET quiz = v_new_quiz,
      updated_at = NOW()
  WHERE lesson_id = v_lesson_id;

  RAISE NOTICE 'Done lid_002: % questions seeded into question_bank', jsonb_array_length(v_quiz_arr);
END $$;

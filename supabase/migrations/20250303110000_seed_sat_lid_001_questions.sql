-- Seed Q1–Q10 from lid_001 (Algebra / Linear equations in one variable) into question_bank
-- and link them to lesson 347d1639-dab4-4e93-8430-fd749f9ee9b2 via quizzes + quiz_questions
-- and update lesson_interactive_content.quiz for the learn page.
--
-- Idempotent: all inserts use ON CONFLICT (human_readable_id) DO NOTHING
-- Lesson ID: 347d1639-dab4-4e93-8430-fd749f9ee9b2
-- Course ID:  21f5d0c2-953c-4b49-b5d4-4e680b1bcf56

-- ============================================================
-- STEP 1: Insert questions into question_bank
-- ============================================================

INSERT INTO public.question_bank (
  human_readable_id, question_text, options, correct_answer, explanation,
  difficulty, question_type, subject, source, topic, subtopic,
  is_pyq, is_active, grade
) VALUES

-- Q1 (already seeded by earlier script; ON CONFLICT will skip)
(
  'sat_lid_001_1',
  'A car rental agency charges a flat daily fee of 45 plus 0.25 per mile driven. If a customer was charged a total of 95 for a one-day rental, which equation represents the number of miles, $m$, the customer drove?',
  '[{"value": "$45m + 0.25 = 95$"}, {"value": "$0.25m + 45 = 95$"}, {"value": "$45.25m = 95$"}, {"value": "$0.25m - 45 = 95$"}]'::jsonb,
  '$0.25m + 45 = 95$',
  'To model this real-world scenario, we must identify the constant and variable components of the total cost.

The flat daily fee of 45 is a fixed value that does not change regardless of the distance traveled. The cost per mile is 0.25, which must be multiplied by the total number of miles driven, $m$. This creates the variable term $0.25m$.

The total charge is the sum of these two distinct parts: the variable mileage cost and the fixed daily fee. Setting this sum equal to the final bill of 95 gives us the linear equation:

$0.25m + 45 = 95$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q2
(
  'sat_lid_001_2',
  'If $5x + 2 = 12$, what is the value of $15x + 6$?',
  '[{"value": "24"}, {"value": "30"}, {"value": "36"}, {"value": "42"}]'::jsonb,
  '36',
  'Instead of solving for the variable $x$ and then substituting, we can utilize algebraic manipulation to find the value of the requested expression directly.

Observe the relationship between the given equation, $5x + 2 = 12$, and the expression we need to find, $15x + 6$. Notice that each term in the required expression is exactly three times the corresponding term in the given equation:

$3 \times (5x) = 15x$
$3 \times (2) = 6$

According to the properties of equality, if we multiply the entire left side of the equation by 3, we must also multiply the right side by 3 to maintain balance:

$3(5x + 2) = 3(12)$
$15x + 6 = 36$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q3
(
  'sat_lid_001_3',
  'What value of $n$ satisfies the equation $6n + 180 = 540$?',
  '[{"value": "60"}, {"value": "90"}, {"value": "120"}, {"value": "360"}]'::jsonb,
  '60',
  'To find the value of $n$, we isolate the variable by performing inverse operations in the reverse order of operations.

First, we address the addition of 180 by subtracting 180 from both sides of the equation:

$6n = 540 - 180$
$6n = 360$

Next, we isolate $n$ by undoing the multiplication by 6. We divide both sides of the equation by the coefficient 6:

$n = \frac{360}{6}$
$n = 60$

Substituting 60 back into the original equation ($6 \times 60 + 180 = 360 + 180 = 540$) confirms the solution.',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q4
(
  'sat_lid_001_4',
  '$12x - 5x + 140 = 280$. What value of $x$ is the solution to the given equation?',
  '[{"value": "20"}, {"value": "40"}, {"value": "70"}, {"value": "140"}]'::jsonb,
  '20',
  'The first step in solving this linear equation is to simplify the left side by combining like terms. Like terms are terms that contain the same variable raised to the same power.

Subtracting $5x$ from $12x$ results in $7x$:

$7x + 140 = 280$

Now, we isolate the variable term by subtracting 140 from both sides:

$7x = 280 - 140$
$7x = 140$

Finally, we divide both sides by 7 to solve for $x$:

$x = \frac{140}{7} = 20$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q5
(
  'sat_lid_001_5',
  '$(k + 9) + 21 = 50$. What value of $k$ is the solution to the given equation?',
  '[{"value": "20"}, {"value": "29"}, {"value": "38"}, {"value": "41"}]'::jsonb,
  '20',
  'Because the operations on the left side of the equation consist only of addition, the parentheses around the expression $(k + 9)$ can be removed without affecting the value.

The equation simplifies to:

$k + 9 + 21 = 50$

Next, we combine the constant terms on the left side:

$k + 30 = 50$

To isolate $k$, we subtract 30 from both sides of the equation:

$k = 50 - 30$
$k = 20$',
  3, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q6
(
  'sat_lid_001_6',
  'If $4x - 24 = 16$, what is the value of $x - 6$?',
  '[{"value": "4"}, {"value": "10"}, {"value": "12"}, {"value": "40"}]'::jsonb,
  '4',
  'SAT questions often reward students for noticing patterns that bypass solving for the variable $x$.

Observe the left side of the equation, $4x - 24$. Both terms are divisible by 4. If we factor out 4, we can rewrite the equation as:

$4(x - 6) = 16$

Since the question specifically asks for the value of the expression $x - 6$, we can isolate that expression by dividing both sides of the equation by 4:

$\frac{4(x - 6)}{4} = \frac{16}{4}$
$x - 6 = 4$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q7
(
  'sat_lid_001_7',
  '$6(2x - 5) = 42$. Which equation has the same solution?',
  '[{"value": "$2x - 5 = 7$"}, {"value": "$2x - 5 = 36$"}, {"value": "$12x - 5 = 42$"}, {"value": "$12x - 30 = 7$"}]'::jsonb,
  '$2x - 5 = 7$',
  'To find an equivalent equation with the same solution, we can perform operations that preserve the equality.

The original equation states that 6 is multiplied by the quantity $(2x - 5)$. We can undo this multiplication by dividing both sides of the equation by 6:

$\frac{6(2x - 5)}{6} = \frac{42}{6}$
$2x - 5 = 7$

This simplified version will yield the same value for $x$ as the original equation.',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q8
(
  'sat_lid_001_8',
  'A fuel tank contained 12,000 gallons of oil. A pump removes oil at a constant rate. After 3 hours, 10,500 gallons remain. At this rate, how many total hours will the pump have run when 7,000 gallons remain?',
  '[{"value": "8"}, {"value": "10"}, {"value": "12"}, {"value": "15"}]'::jsonb,
  '10',
  'First, we must determine the constant rate at which the oil is being removed. In the first 3 hours, the amount of oil decreased from 12,000 to 10,500 gallons:

$12,000 - 10,500 = 1,500$ gallons removed.

Dividing this loss by the time elapsed gives the removal rate:

$1,500 \div 3 = 500$ gallons per hour.

Next, we calculate the total amount of oil that needs to be removed from the initial quantity to reach the target of 7,000 gallons:

$12,000 - 7,000 = 5,000$ gallons.

Finally, we divide the total required loss by the hourly rate to find the total time:

$5,000 \div 500 = 10$ hours.',
  7, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q9
(
  'sat_lid_001_9',
  'If $3x + 4 = 13$, what is the value of $6x + 5$?',
  '[{"value": "18"}, {"value": "23"}, {"value": "26"}, {"value": "31"}]'::jsonb,
  '23',
  'We can find the value of $x$ first. Subtracting 4 from 13 gives:

$3x = 9 \implies x = 3$

Now, we substitute $x = 3$ into the second expression:

$6(3) + 5 = 18 + 5 = 23$

Alternatively, we can notice that $6x$ is twice $3x$. If $3x = 9$, then $6x = 18$. Adding 5 to this value results in 23.',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q10
(
  'sat_lid_001_10',
  '$8x + 16 = 176$. What is the solution to the given equation?',
  '[{"value": "20"}, {"value": "22"}, {"value": "24"}, {"value": "160"}]'::jsonb,
  '20',
  'To solve for $x$, we first isolate the variable term by subtracting 16 from both sides of the equation:

$8x = 176 - 16$
$8x = 160$

Next, we divide both sides by the coefficient 8:

$x = \frac{160}{8} = 20$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
)

ON CONFLICT (human_readable_id) DO NOTHING;


-- ============================================================
-- STEP 2: Create quiz for this lesson if it doesn't exist,
--         then link the lesson to the quiz
-- ============================================================

DO $$
DECLARE
  v_lesson_id  uuid := '347d1639-dab4-4e93-8430-fd749f9ee9b2';
  v_quiz_id    uuid;
BEGIN
  -- Get existing quiz_id from lesson
  SELECT quiz_id INTO v_quiz_id
  FROM public.courses_lessons
  WHERE id = v_lesson_id;

  -- Create quiz only if lesson has no quiz yet
  IF v_quiz_id IS NULL THEN
    INSERT INTO public.quizzes (title, lesson_id)
    VALUES ('lid_001 Practice', v_lesson_id)
    RETURNING id INTO v_quiz_id;

    UPDATE public.courses_lessons
    SET quiz_id = v_quiz_id
    WHERE id = v_lesson_id;
  END IF;
END $$;


-- ============================================================
-- STEP 3: Link all 10 questions to the lesson's quiz
--         via quiz_questions (idempotent)
-- ============================================================

DO $$
DECLARE
  v_lesson_id  uuid := '347d1639-dab4-4e93-8430-fd749f9ee9b2';
  v_quiz_id    uuid;
  v_qid        uuid;
  v_order      int;
  hrids        text[] := ARRAY[
    'sat_lid_001_1','sat_lid_001_2','sat_lid_001_3','sat_lid_001_4','sat_lid_001_5',
    'sat_lid_001_6','sat_lid_001_7','sat_lid_001_8','sat_lid_001_9','sat_lid_001_10'
  ];
  hrid         text;
BEGIN
  SELECT quiz_id INTO v_quiz_id
  FROM public.courses_lessons
  WHERE id = v_lesson_id;

  IF v_quiz_id IS NULL THEN
    RAISE EXCEPTION 'quiz_id still null for lesson %; run STEP 2 first', v_lesson_id;
  END IF;

  v_order := 1;
  FOREACH hrid IN ARRAY hrids LOOP
    SELECT id INTO v_qid
    FROM public.question_bank
    WHERE human_readable_id = hrid;

    IF v_qid IS NOT NULL THEN
      INSERT INTO public.quiz_questions (quiz_id, question_id, question_order)
      VALUES (v_quiz_id, v_qid, v_order)
      ON CONFLICT DO NOTHING;
    END IF;

    v_order := v_order + 1;
  END LOOP;
END $$;


-- ============================================================
-- STEP 4: Update lesson_interactive_content.quiz JSON array
--         so the learn page renders these 10 questions
-- ============================================================

DO $$
DECLARE
  v_lesson_id  uuid := '347d1639-dab4-4e93-8430-fd749f9ee9b2';
  v_lic_id     uuid;
  v_quiz_arr   jsonb := '[]'::jsonb;
  v_qrow       record;
  v_item       jsonb;
  v_answer_idx int;
  hrids        text[] := ARRAY[
    'sat_lid_001_1','sat_lid_001_2','sat_lid_001_3','sat_lid_001_4','sat_lid_001_5',
    'sat_lid_001_6','sat_lid_001_7','sat_lid_001_8','sat_lid_001_9','sat_lid_001_10'
  ];
  hrid         text;
  opt_val      text;
  opt_idx      int;
BEGIN
  FOREACH hrid IN ARRAY hrids LOOP
    SELECT id, question_text, options, correct_answer, explanation
    INTO v_qrow
    FROM public.question_bank
    WHERE human_readable_id = hrid;

    IF v_qrow.id IS NULL THEN CONTINUE; END IF;

    -- Find 0-based index of correct_answer in options array
    v_answer_idx := 0;
    FOR opt_idx IN 0 .. jsonb_array_length(v_qrow.options) - 1 LOOP
      opt_val := v_qrow.options->opt_idx->>'value';
      IF opt_val = v_qrow.correct_answer THEN
        v_answer_idx := opt_idx;
        EXIT;
      END IF;
    END LOOP;

    v_item := jsonb_build_object(
      'id',          v_qrow.id::text,
      'question',    v_qrow.question_text,
      'options',     (SELECT jsonb_agg(el->>'value') FROM jsonb_array_elements(v_qrow.options) AS el),
      'answer',      v_answer_idx,
      'explanation', v_qrow.explanation
    );

    v_quiz_arr := v_quiz_arr || v_item;
  END LOOP;

  -- Upsert lesson_interactive_content
  SELECT id INTO v_lic_id
  FROM public.lesson_interactive_content
  WHERE lesson_id = v_lesson_id;

  IF v_lic_id IS NOT NULL THEN
    UPDATE public.lesson_interactive_content
    SET quiz = v_quiz_arr,
        updated_at = NOW()
    WHERE lesson_id = v_lesson_id;
  ELSE
    INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
    VALUES (v_lesson_id, 'Practice for this lesson.', '[]'::jsonb, v_quiz_arr);
  END IF;
END $$;

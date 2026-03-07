-- Seed Q11–Q50 from lid_001 (Algebra / Linear equations in one variable)
-- Q11–Q25: MCQ | Q26–Q50: Numeric Entry (fill_blank)
-- Idempotent via ON CONFLICT (human_readable_id) DO NOTHING
-- Lesson ID: 347d1639-dab4-4e93-8430-fd749f9ee9b2

-- ============================================================
-- STEP 1: Insert Q11–Q25 (MCQ)
-- ============================================================

INSERT INTO public.question_bank (
  human_readable_id, question_text, options, correct_answer, explanation,
  difficulty, question_type, subject, source, topic, subtopic,
  is_pyq, is_active, grade
) VALUES

-- Q11
(
  'sat_lid_001_11',
  'A freelancer charged 400 for a project. This included a 100 research fee and $h$ hours of editing at 60 per hour. Which equation represents this?',
  '[{"value": "$100h + 60 = 400$"}, {"value": "$60h + 100 = 400$"}, {"value": "$160h = 400$"}, {"value": "$60h - 100 = 400$"}]'::jsonb,
  '$60h + 100 = 400$',
  'The total cost of the project is made up of a one-time fixed fee and a variable cost based on time.

The fixed research fee is 100. The variable editing cost is the product of the hourly rate (60) and the number of hours ($h$), which is $60h$.

Combining these two parts to equal the total project cost gives:

$60h + 100 = 400$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q12
(
  'sat_lid_001_12',
  'If $7x - 49 = 28$, what is the value of $x - 7$?',
  '[{"value": "4"}, {"value": "7"}, {"value": "11"}, {"value": "28"}]'::jsonb,
  '4',
  'We can find the answer efficiently by factoring the left side of the equation. Since 7 is a common factor of $7x$ and 49, we can rewrite the equation as:

$7(x - 7) = 28$

To isolate the expression $x - 7$, divide both sides by 7:

$x - 7 = \frac{28}{7} = 4$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q13
(
  'sat_lid_001_13',
  '$15x - 11x + 30 = 110$. What is the value of $x$?',
  '[{"value": "20"}, {"value": "40"}, {"value": "80"}, {"value": "140"}]'::jsonb,
  '20',
  'First, simplify the left side of the equation by combining the like $x$ terms:

$4x + 30 = 110$

Subtract 30 from both sides to isolate the $4x$ term:

$4x = 80$

Finally, divide by 4:

$x = 20$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q14 (5 options)
(
  'sat_lid_001_14',
  '$(y - 8) + 12 = 34$. What is $y$?',
  '[{"value": "30"}, {"value": "38"}, {"value": "42"}, {"value": "54"}, {"value": "62"}]'::jsonb,
  '30',
  'Remove the parentheses and simplify the left side by combining the numbers $-8$ and $+12$:

$y + 4 = 34$

Subtract 4 from both sides:

$y = 30$',
  3, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q15
(
  'sat_lid_001_15',
  'If $2x + 1 = 6$, what is the value of $10x + 5$?',
  '[{"value": "25"}, {"value": "30"}, {"value": "35"}, {"value": "40"}]'::jsonb,
  '30',
  'Observe the relationship between $2x + 1$ and $10x + 5$. Each term in the second expression is five times larger than the corresponding term in the first.

$5 \times (2x + 1) = 10x + 5$

Multiply the entire original equation by 5:

$5(2x + 1) = 5(6)$
$10x + 5 = 30$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q16
(
  'sat_lid_001_16',
  '$3(4x + 5) = 39$. Which has the same solution?',
  '[{"value": "$4x + 5 = 13$"}, {"value": "$4x + 5 = 36$"}, {"value": "$12x + 5 = 39$"}, {"value": "$12x + 15 = 13$"}]'::jsonb,
  '$4x + 5 = 13$',
  'Divide both sides of the original equation by the factor of 3 to simplify the left side:

$\frac{3(4x + 5)}{3} = \frac{39}{3}$
$4x + 5 = 13$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q17
(
  'sat_lid_001_17',
  'A storage unit drains water at 60 liters per hour. Initially, it had 2,000 liters. After $h$ hours, 1,400 liters remain. How many total hours have passed?',
  '[{"value": "8"}, {"value": "10"}, {"value": "12"}, {"value": "15"}]'::jsonb,
  '10',
  'Total water removed = $2,000 - 1,400 = 600$ liters.

Given the drain rate is 60 liters per hour, we can set up the equation:

$60h = 600$

Divide by 60:

$h = 10$',
  7, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q18
(
  'sat_lid_001_18',
  'What value of $p$ satisfies $9p + 270 = 900$?',
  '[{"value": "70"}, {"value": "100"}, {"value": "130"}, {"value": "630"}]'::jsonb,
  '70',
  'Subtract 270 from both sides:

$9p = 630$

Divide by 9:

$p = 70$',
  3, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q19
(
  'sat_lid_001_19',
  'If $12x - 48 = 24$, what is the value of $3x - 12$?',
  '[{"value": "6"}, {"value": "12"}, {"value": "18"}, {"value": "24"}]'::jsonb,
  '6',
  'Each term in the expression $3x - 12$ is one-fourth of the terms in $12x - 48$.

Divide the entire equation by 4:

$\frac{12x - 48}{4} = \frac{24}{4}$
$3x - 12 = 6$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q20
(
  'sat_lid_001_20',
  '$18x + 10 = 190$. What is $x$?',
  '[{"value": "10"}, {"value": "12"}, {"value": "15"}, {"value": "180"}]'::jsonb,
  '10',
  'Subtract 10:

$18x = 180$

Divide by 18:

$x = 10$',
  3, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q21
(
  'sat_lid_001_21',
  'A caterer charges 150 for delivery plus 30 per guest. If the total bill was 750, how many guests, $g$, were there?',
  '[{"value": "$30g + 150 = 750$"}, {"value": "$150g + 30 = 750$"}, {"value": "$180g = 750$"}, {"value": "$30g = 750$"}]'::jsonb,
  '$30g + 150 = 750$',
  'Total Cost = (Rate $\times$ guests) + Delivery Fee.

Total = $30g + 150$.

Given total is 750:

$30g + 150 = 750$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q22
(
  'sat_lid_001_22',
  'If $4x + 1 = 13$, what is $12x - 5$?',
  '[{"value": "31"}, {"value": "34"}, {"value": "39"}, {"value": "44"}]'::jsonb,
  '31',
  'Solve for $4x$:

$4x = 12$

Find $12x$ by multiplying $4x$ by 3:

$12x = 3 \times 12 = 36$

Subtract 5:

$36 - 5 = 31$',
  5, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q23
(
  'sat_lid_001_23',
  '$6x + 2x + 15 = 95$. Value of $x$?',
  '[{"value": "10"}, {"value": "12"}, {"value": "15"}, {"value": "80"}]'::jsonb,
  '10',
  'Combine like terms:

$8x + 15 = 95$

Subtract 15:

$8x = 80$

Divide by 8:

$x = 10$',
  3, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q24
(
  'sat_lid_001_24',
  '$(w + 12) - 15 = 5$. What is $w$?',
  '[{"value": "8"}, {"value": "12"}, {"value": "15"}, {"value": "20"}]'::jsonb,
  '8',
  'Simplify the left side:

$w - 3 = 5$

Add 3:

$w = 8$',
  3, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q25
(
  'sat_lid_001_25',
  '$3(x - 5) = 15$. Same solution as?',
  '[{"value": "$x - 5 = 5$"}, {"value": "$x - 5 = 12$"}, {"value": "$3x - 5 = 15$"}, {"value": "$3x - 15 = 5$"}]'::jsonb,
  '$x - 5 = 5$',
  'Divide both sides by 3:

$x - 5 = 5$',
  3, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
)

ON CONFLICT (human_readable_id) DO NOTHING;


-- ============================================================
-- STEP 2: Insert Q26–Q50 (Numeric Entry / fill_blank)
-- ============================================================

INSERT INTO public.question_bank (
  human_readable_id, question_text, options, correct_answer, explanation,
  difficulty, question_type, subject, source, topic, subtopic,
  is_pyq, is_active, grade
) VALUES

-- Q26
(
  'sat_lid_001_26',
  'Solve for $x$: $0.2x + 4 = 12$.',
  '[]'::jsonb,
  '40',
  'Isolate the decimal term by subtracting 4:

$0.2x = 8$

Divide by 0.2 (which is the same as multiplying by 5):

$x = 40$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q27
(
  'sat_lid_001_27',
  '$4(x + 2) = 2x + 14$. What is $x$?',
  '[]'::jsonb,
  '3',
  'Distribute the 4:

$4x + 8 = 2x + 14$

Group $x$ terms on the left:

$2x + 8 = 14$

Subtract 8:

$2x = 6 \implies x = 3$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q28
(
  'sat_lid_001_28',
  'If $x/5 + 10 = 13$, what is $x$?',
  '[]'::jsonb,
  '15',
  'Subtract 10:

$x/5 = 3$

Multiply by 5:

$x = 15$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q29
(
  'sat_lid_001_29',
  '$8x - 10 = 5x + 11$. Value of $x$?',
  '[]'::jsonb,
  '7',
  'Subtract $5x$ and add 10 to both sides:

$3x = 21$

Divide by 3:

$x = 7$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q30
(
  'sat_lid_001_30',
  '$2(x - 5) + 6 = 12$. What is $x$?',
  '[]'::jsonb,
  '8',
  'Distribute:

$2x - 10 + 6 = 12$

Simplify:

$2x - 4 = 12$

Add 4:

$2x = 16 \implies x = 8$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q31
(
  'sat_lid_001_31',
  'If $x/4 = 8$, what is $3x$?',
  '[]'::jsonb,
  '96',
  'Solve for $x$:

$x = 32$

Multiply by 3:

$3 \times 32 = 96$',
  3, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q32
(
  'sat_lid_001_32',
  '$6x + 15 = 3$. What is $x$?',
  '[]'::jsonb,
  '-2',
  'Subtract 15:

$6x = -12$

Divide by 6:

$x = -2$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q33
(
  'sat_lid_001_33',
  'Solve for $m$: $5m/2 = 15$.',
  '[]'::jsonb,
  '6',
  'Multiply by 2:

$5m = 30$

Divide by 5:

$m = 6$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q34
(
  'sat_lid_001_34',
  '$25 - x = 2x + 4$. What is $x$?',
  '[]'::jsonb,
  '7',
  'Add $x$ to both sides:

$25 = 3x + 4$

Subtract 4:

$21 = 3x \implies x = 7$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q35
(
  'sat_lid_001_35',
  'If $5(x + 1) = 25$, what is $x + 1$?',
  '[]'::jsonb,
  '5',
  'Divide both sides by 5:

$x + 1 = 5$',
  3, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q36
(
  'sat_lid_001_36',
  '$0.4x = 10$. What is $x$?',
  '[]'::jsonb,
  '25',
  'Divide by 0.4:

$x = 25$',
  3, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q37
(
  'sat_lid_001_37',
  '$5x + 3x - 10 = 30$. What is $x$?',
  '[]'::jsonb,
  '5',
  'Combine like terms:

$8x - 10 = 30$

Add 10:

$8x = 40 \implies x = 5$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q38
(
  'sat_lid_001_38',
  'If $12 - 4x = 28$, what is $x$?',
  '[]'::jsonb,
  '-4',
  'Subtract 12 from both sides:

$-4x = 16$

Divide by $-4$:

$x = -4$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q39
(
  'sat_lid_001_39',
  '$4(x - 2) = x + 7$. What is $x$?',
  '[]'::jsonb,
  '5',
  'Distribute:

$4x - 8 = x + 7$

Subtract $x$ and add 8:

$3x = 15 \implies x = 5$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q40
(
  'sat_lid_001_40',
  '$x/3 - 4 = 1$. What is $x$?',
  '[]'::jsonb,
  '15',
  'Add 4 to both sides:

$x/3 = 5$

Multiply by 3:

$x = 15$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q41
(
  'sat_lid_001_41',
  'If $10x = 80$, what is $x/2$?',
  '[]'::jsonb,
  '4',
  'Solve for $x$:

$x = 8$

Divide by 2:

$8/2 = 4$',
  3, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q42
(
  'sat_lid_001_42',
  '$20 - (x + 5) = 10$. What is $x$?',
  '[]'::jsonb,
  '5',
  'Distribute the negative:

$20 - x - 5 = 10$

Simplify:

$15 - x = 10 \implies x = 5$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q43
(
  'sat_lid_001_43',
  '$9x + 4 = 6x + 19$. Value of $x$?',
  '[]'::jsonb,
  '5',
  'Subtract $6x$ from both sides:

$3x + 4 = 19$

Subtract 4:

$3x = 15 \implies x = 5$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q44
(
  'sat_lid_001_44',
  '$5(2x - 8) = 0$. What is $x$?',
  '[]'::jsonb,
  '4',
  'The quantity in parentheses must equal 0:

$2x - 8 = 0$

$2x = 8 \implies x = 4$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q45
(
  'sat_lid_001_45',
  'If $x + x + x + x + x = 25$, what is $2x$?',
  '[]'::jsonb,
  '10',
  'Combine like terms:

$5x = 25 \implies x = 5$

Multiply:

$2(5) = 10$',
  3, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q46
(
  'sat_lid_001_46',
  'Solve: $1.2x + 0.3x = 3$.',
  '[]'::jsonb,
  '2',
  'Combine like terms:

$1.5x = 3$

Divide by 1.5:

$x = 2$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q47
(
  'sat_lid_001_47',
  'If $4x = 16$, what is $4x + 9$?',
  '[]'::jsonb,
  '25',
  'Since $4x = 16$, substitute directly:

$16 + 9 = 25$',
  3, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q48
(
  'sat_lid_001_48',
  '$5(x + 3) = 5x + 15$. How many solutions?',
  '[{"value": "Zero"}, {"value": "Exactly one"}, {"value": "Infinitely many"}, {"value": "Exactly two"}]'::jsonb,
  'Infinitely many',
  'Distribute:

$5x + 15 = 5x + 15$

Both sides are identical, which means the equation is true for every value of $x$. This gives infinitely many solutions.',
  7, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q49
(
  'sat_lid_001_49',
  '$4x + 1 = 4x + 9$. How many solutions?',
  '[{"value": "Zero"}, {"value": "Exactly one"}, {"value": "Infinitely many"}, {"value": "Exactly two"}]'::jsonb,
  'Zero',
  'Subtract $4x$ from both sides:

$1 = 9$

This is a false statement that can never be true, which means the equation has zero solutions.',
  7, 'mcq', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
),

-- Q50
(
  'sat_lid_001_50',
  'If $\frac{1}{5}x + \frac{2}{5}x = 9$, what is $x$?',
  '[]'::jsonb,
  '15',
  'Combine the fractions:

$\frac{3}{5}x = 9$

Multiply both sides by $\frac{5}{3}$:

$x = 15$',
  5, 'fill_blank', 'SAT Math', 'SAT', 'Algebra', 'Linear equations in one variable', false, true, '12'
)

ON CONFLICT (human_readable_id) DO NOTHING;


-- ============================================================
-- STEP 3: Link Q11–Q50 to the lesson quiz via quiz_questions
-- ============================================================

DO $$
DECLARE
  v_lesson_id  uuid := '347d1639-dab4-4e93-8430-fd749f9ee9b2';
  v_quiz_id    uuid;
  v_qid        uuid;
  v_order      int;
  hrids        text[] := ARRAY[
    'sat_lid_001_11','sat_lid_001_12','sat_lid_001_13','sat_lid_001_14','sat_lid_001_15',
    'sat_lid_001_16','sat_lid_001_17','sat_lid_001_18','sat_lid_001_19','sat_lid_001_20',
    'sat_lid_001_21','sat_lid_001_22','sat_lid_001_23','sat_lid_001_24','sat_lid_001_25',
    'sat_lid_001_26','sat_lid_001_27','sat_lid_001_28','sat_lid_001_29','sat_lid_001_30',
    'sat_lid_001_31','sat_lid_001_32','sat_lid_001_33','sat_lid_001_34','sat_lid_001_35',
    'sat_lid_001_36','sat_lid_001_37','sat_lid_001_38','sat_lid_001_39','sat_lid_001_40',
    'sat_lid_001_41','sat_lid_001_42','sat_lid_001_43','sat_lid_001_44','sat_lid_001_45',
    'sat_lid_001_46','sat_lid_001_47','sat_lid_001_48','sat_lid_001_49','sat_lid_001_50'
  ];
  hrid         text;
BEGIN
  SELECT quiz_id INTO v_quiz_id
  FROM public.courses_lessons
  WHERE id = v_lesson_id;

  IF v_quiz_id IS NULL THEN
    RAISE EXCEPTION 'quiz_id is null for lesson %; run the Q1-Q10 migration first', v_lesson_id;
  END IF;

  v_order := 11;
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
--         with all 50 questions in order
-- ============================================================

DO $$
DECLARE
  v_lesson_id  uuid := '347d1639-dab4-4e93-8430-fd749f9ee9b2';
  v_quiz_arr   jsonb := '[]'::jsonb;
  v_qrow       record;
  v_item       jsonb;
  v_answer_idx int;
  all_hrids    text[] := ARRAY[
    'sat_lid_001_1', 'sat_lid_001_2', 'sat_lid_001_3', 'sat_lid_001_4', 'sat_lid_001_5',
    'sat_lid_001_6', 'sat_lid_001_7', 'sat_lid_001_8', 'sat_lid_001_9', 'sat_lid_001_10',
    'sat_lid_001_11','sat_lid_001_12','sat_lid_001_13','sat_lid_001_14','sat_lid_001_15',
    'sat_lid_001_16','sat_lid_001_17','sat_lid_001_18','sat_lid_001_19','sat_lid_001_20',
    'sat_lid_001_21','sat_lid_001_22','sat_lid_001_23','sat_lid_001_24','sat_lid_001_25',
    'sat_lid_001_26','sat_lid_001_27','sat_lid_001_28','sat_lid_001_29','sat_lid_001_30',
    'sat_lid_001_31','sat_lid_001_32','sat_lid_001_33','sat_lid_001_34','sat_lid_001_35',
    'sat_lid_001_36','sat_lid_001_37','sat_lid_001_38','sat_lid_001_39','sat_lid_001_40',
    'sat_lid_001_41','sat_lid_001_42','sat_lid_001_43','sat_lid_001_44','sat_lid_001_45',
    'sat_lid_001_46','sat_lid_001_47','sat_lid_001_48','sat_lid_001_49','sat_lid_001_50'
  ];
  hrid         text;
  opt_val      text;
  opt_idx      int;
BEGIN
  FOREACH hrid IN ARRAY all_hrids LOOP
    SELECT id, question_text, options, correct_answer, explanation, question_type, difficulty
    INTO v_qrow
    FROM public.question_bank
    WHERE human_readable_id = hrid;

    IF v_qrow.id IS NULL THEN CONTINUE; END IF;

    -- For MCQ: find 0-based index of correct_answer in options
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

    -- Difficulty label for display
    v_item := jsonb_build_object(
      'id',          v_qrow.id::text,
      'question',    v_qrow.question_text,
      'options',     CASE
                       WHEN jsonb_array_length(v_qrow.options) > 0
                       THEN (SELECT jsonb_agg(el->>'value') FROM jsonb_array_elements(v_qrow.options) AS el)
                       ELSE '[]'::jsonb
                     END,
      'answer',      v_answer_idx,
      'correct_answer', v_qrow.correct_answer,
      'explanation', v_qrow.explanation,
      'question_type', v_qrow.question_type,
      'difficulty',  CASE
                       WHEN v_qrow.difficulty <= 3 THEN 'Easy'
                       WHEN v_qrow.difficulty <= 6 THEN 'Medium'
                       ELSE 'Hard'
                     END
    );

    v_quiz_arr := v_quiz_arr || v_item;
  END LOOP;

  UPDATE public.lesson_interactive_content
  SET quiz = v_quiz_arr,
      updated_at = NOW()
  WHERE lesson_id = v_lesson_id;
END $$;

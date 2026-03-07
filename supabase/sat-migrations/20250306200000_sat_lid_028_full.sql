-- ============================================================
-- LID 028: Full migration (lesson + content + questions + quiz)
-- Topic: Advanced Math — Function Transformations
-- Idempotent: safe to re-run.
-- ============================================================

-- ============================================================
-- PART A: Create lesson row
-- ============================================================

DO $$
DECLARE
  v_course_id   uuid;
  v_chapter_id  uuid;
  v_topic_id    uuid;
  v_next_order  int;
BEGIN
  IF EXISTS (SELECT 1 FROM public.courses_lessons WHERE slug = 'sat-quant-learn-sat-lid-028') THEN
    RAISE NOTICE 'Lesson sat-quant-learn-sat-lid-028 already exists; skipping.';
    RETURN;
  END IF;

  SELECT c.id INTO v_course_id
  FROM public.courses c
  WHERE c.slug = 'sat-quant-learn'
  LIMIT 1;

  IF v_course_id IS NULL THEN
    RAISE NOTICE 'Course sat-quant-learn not found; cannot add lesson 028.';
    RETURN;
  END IF;

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
    'LID 028',
    'sat-quant-learn-sat-lid-028',
    v_next_order,
    v_course_id,
    v_chapter_id,
    v_topic_id,
    'interactive'
  );

  RAISE NOTICE 'Created lesson sat-quant-learn-sat-lid-028.';
END $$;


-- ============================================================
-- PART B: Populate lesson content (concept + formula + interactive steps)
-- ============================================================

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-028'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-028; skipping.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Function Transformations',
    concept_content = E'**Function transformations** describe how the graph of a function changes when its equation is modified.\n\n**Key ideas:**\n- **Vertical shift:** $f(x) + k$ shifts up ($k>0$) or down ($k<0$).\n- **Horizontal shift:** $f(x - h)$ shifts right ($h>0$); $f(x + h)$ shifts left ($h>0$).\n- **Reflection across x-axis:** $-f(x)$ negates all $y$-values.\n- **Reflection across y-axis:** $f(-x)$ negates all $x$-inputs.\n- **Vertical stretch/compression:** $a \\cdot f(x)$ with $|a|>1$ stretches, $0<|a|<1$ compresses.\n- **Horizontal stretch/compression:** $f(bx)$ with $|b|>1$ compresses, $0<|b|<1$ stretches.',
    formula_title = 'Worked Example',
    formula_content = E'Given $f(x) = x^2$ with vertex $(0,0)$.\n\n**Example 1 — Shift:** $g(x) = f(x-5) + 3 = (x-5)^2 + 3$.\nVertex moves to $(5, 3)$.\n\n**Example 2 — Reflect then shift:** Reflect $f$ across the $x$-axis and shift up 10:\n$g(x) = -x^2 + 10$.\n\n**Example 3 — Composition of point:** If $(2,10)$ is on $f$, then on $y = f(x+3)$ the corresponding point is $(2-3, 10) = (-1, 10)$.'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master function transformations—shifts, reflections, stretches, and compressions—essential tools for SAT Advanced Math.',
    '[
      {"title": "Vertical shifts", "content": "Adding or subtracting a constant outside the function shifts the graph up or down.", "equation": "$f(x)+k$: up if $k>0$, down if $k<0$", "highlight": "outside → vertical"},
      {"title": "Horizontal shifts", "content": "Adding or subtracting inside the function shifts the graph left or right (opposite direction of the sign).", "equation": "$f(x-h)$: right $h$ units; $f(x+h)$: left $h$ units", "highlight": "inside → horizontal, opposite sign"},
      {"title": "Reflections", "content": "$-f(x)$ reflects across the $x$-axis (negate outputs). $f(-x)$ reflects across the $y$-axis (negate inputs).", "highlight": "negative outside → x-axis; negative inside → y-axis"},
      {"title": "Stretches and compressions", "content": "$a \\cdot f(x)$: vertical stretch ($|a|>1$) or compression ($0<|a|<1$). $f(bx)$: horizontal compression ($|b|>1$) or stretch ($0<|b|<1$).", "highlight": "multiplier on output vs input"}
    ]'::jsonb,
    '[]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'LID 028 content populated.';
END $$;


-- ============================================================
-- STEP 1: Insert 50 questions into question_bank
-- ============================================================

INSERT INTO public.question_bank (
  human_readable_id, question_text, options, correct_answer, explanation,
  difficulty, question_type, subject, source, topic, subtopic,
  is_pyq, is_active, grade
) VALUES

('sat_lid_028_1', 'The graph of $y = f(x)$ is shown in the $xy$-plane. Which of the following equations represents a graph that is the result of shifting the graph of $f$ upward by 4 units?', '[{"value": "$y = f(x + 4)$"}, {"value": "$y = f(x - 4)$"}, {"value": "$y = f(x) + 4$"}, {"value": "$y = f(x) - 4$"}]'::jsonb, '$y = f(x) + 4$', E'A vertical shift upward by $k$ units is achieved by adding $k$ outside the function: $f(x) + k$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_2', 'The vertex of the parabola $f(x) = x^2$ is $(0, 0)$. If $g(x) = f(x-5) + 3$, what is the $y$-coordinate of the vertex of the graph of $g$?', '[]'::jsonb, '3', E'$f(x-h)+k$ shifts the vertex by $(h,k)$. New vertex: $(5, 3)$. The $y$-coordinate is 3.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_3', 'If the point $(2, 10)$ is on the graph of $y = f(x)$, which point must be on the graph of $y = f(x + 3)$?', '[{"value": "$(5, 10)$"}, {"value": "$(-1, 10)$"}, {"value": "$(2, 13)$"}, {"value": "$(2, 7)$"}]'::jsonb, '$(-1, 10)$', E'$f(x+3)$ shifts left 3 units. New $x = 2 - 3 = -1$, $y$ unchanged. Point: $(-1, 10)$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_4', 'The function $g$ is defined by $g(x) = f(x) - 7$. If the $y$-intercept of the graph of $f$ is $(0, 15)$, what is the $y$-coordinate of the $y$-intercept of the graph of $g$?', '[]'::jsonb, '8', E'$g(0) = f(0) - 7 = 15 - 7 = 8$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_5', 'Which transformation of function $f$ would result in a reflection across the $x$-axis?', '[{"value": "$y = f(-x)$"}, {"value": "$y = -f(x)$"}, {"value": "$y = f(x) - 1$"}, {"value": "$y = \\frac{1}{f(x)}$"}]'::jsonb, '$y = -f(x)$', E'Reflecting across the $x$-axis negates all $y$-values: $-f(x)$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_6', 'A line has a $y$-intercept of $(0, 4)$ and a slope of 2. The line is shifted 3 units to the right to create a new line. What is the $y$-intercept of the new line?', '[]'::jsonb, '-2', E'Original: $f(x) = 2x + 4$. Shift right 3: $g(x) = 2(x-3)+4 = 2x - 2$. $y$-intercept is $-2$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_7', '$g(x) = f(x + 2) - 5$. The graph of function $g$ is the result of which sequence of transformations on function $f$?', '[{"value": "Shift 2 units left and 5 units down"}, {"value": "Shift 2 units right and 5 units down"}, {"value": "Shift 2 units left and 5 units up"}, {"value": "Shift 2 units right and 5 units up"}]'::jsonb, 'Shift 2 units left and 5 units down', E'$(x+2)$ inside shifts left 2. $-5$ outside shifts down 5.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_8', 'If the point $(a, b)$ is on the graph of $y = f(x)$, and the point $(a+4, b-6)$ is on the graph of $y = f(x-h) + k$, what is the value of $h + k$?', '[]'::jsonb, '-2', E'Shift right 4: $h = 4$. Shift down 6: $k = -6$. So $h + k = 4 + (-6) = -2$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_9', 'If the graph of $f(x) = x^2$ is reflected across the $x$-axis and then shifted up 10 units, which of the following defines the new function $g$?', '[{"value": "$g(x) = -x^2 + 10$"}, {"value": "$g(x) = -(x^2 + 10)$"}, {"value": "$g(x) = (-x)^2 + 10$"}, {"value": "$g(x) = -x^2 - 10$"}]'::jsonb, '$g(x) = -x^2 + 10$', E'Reflect: $-x^2$. Shift up 10: $-x^2 + 10$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_10', 'The vertex of a parabola is $(3, -4)$. After a transformation, the new vertex is $(1, 2)$. If the transformation is written as $f(x-h)+k$, what is the value of $h$?', '[]'::jsonb, '-2', E'Original $x=3$, new $x=1$. Shift left 2: $f(x+2)$, so $h = -2$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_11', 'The graph of $y=f(x)$ is shown. Which of the following is the graph of $y=f(x)-3$?', '[{"value": "The graph of $f$ shifted 3 units left."}, {"value": "The graph of $f$ shifted 3 units right."}, {"value": "The graph of $f$ shifted 3 units up."}, {"value": "The graph of $f$ shifted 3 units down."}]'::jsonb, 'The graph of $f$ shifted 3 units down.', E'Subtracting 3 from the function value moves every point down by 3 units.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_12', '$f(x) = 2x - 8$ and $g(x) = f(x+k)$. If the $x$-intercept of $g$ is $(0, 0)$, what is the value of $k$?', '[]'::jsonb, '4', E'$g(0)=0$ means $f(k)=0$. $2k-8=0$ gives $k=4$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_13', 'How does the graph of $y = 5f(x)$ compare to the graph of $y = f(x)$?', '[{"value": "It is shifted 5 units up."}, {"value": "It is shifted 5 units right."}, {"value": "It is vertically stretched by a factor of 5."}, {"value": "It is horizontally compressed by a factor of 5."}]'::jsonb, 'It is vertically stretched by a factor of 5.', E'Multiplying the output by $a > 1$ results in a vertical stretch.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_14', 'A function $f$ has a domain of $0 \\leq x \\leq 10$. What is the width of the domain of the function $g(x) = f(2x)$?', '[]'::jsonb, '5', E'$0 \\leq 2x \\leq 10$ gives $0 \\leq x \\leq 5$. Width = 5.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_15', 'Which transformation maps the solid line $f$ to the dashed line $g$ (reflected across the $y$-axis)?', '[{"value": "$g(x) = f(-x)$"}, {"value": "$g(x) = -f(x)$"}, {"value": "$g(x) = f(x-2)$"}, {"value": "$g(x) = f(x+2)$"}]'::jsonb, '$g(x) = f(-x)$', E'Negating the input $x \\rightarrow -x$ reflects the graph across the $y$-axis.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_16', 'If the point $(4, 8)$ is on the graph of $y = f(x)$, what is the $y$-coordinate of the corresponding point on the graph of $y = \\frac{1}{2}f(x) + 5$?', '[]'::jsonb, '9', E'Vertical compression: $8 \\times \\frac{1}{2} = 4$. Shift up: $4 + 5 = 9$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_17', 'Which of the following describes the graph of $y = f(x-10)$?', '[{"value": "Shift 10 units up"}, {"value": "Shift 10 units down"}, {"value": "Shift 10 units left"}, {"value": "Shift 10 units right"}]'::jsonb, 'Shift 10 units right', E'Subtracting from the input $x$ shifts the graph horizontally to the right.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_18', 'The function $f(x) = |x|$ is shifted 4 units left and 2 units up. What is the value of the new function at $x = 0$?', '[]'::jsonb, '6', E'$g(x) = |x+4| + 2$. $g(0) = |4| + 2 = 6$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_19', 'If the point $(3, 5)$ is on the graph of $y = f(x)$, which point must be on the graph of $y = f(-x)$?', '[{"value": "$(3, -5)$"}, {"value": "$(-3, 5)$"}, {"value": "$(-3, -5)$"}, {"value": "$(5, 3)$"}]'::jsonb, '$(-3, 5)$', E'$f(-x)$ reflects the $x$-coordinates. $(3,5)$ becomes $(-3,5)$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_20', '$f(x) = (x-2)^2 + 1$ and $g(x) = f(x+3) - 4$. What is the $x$-coordinate of the vertex of $g$?', '[]'::jsonb, '-1', E'Vertex of $f$: $(2, 1)$. Shift left 3: $x = 2 - 3 = -1$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_21', 'How does the graph of $y = f(3x)$ compare to $y = f(x)$?', '[{"value": "Vertically stretched by 3"}, {"value": "Vertically compressed by 1/3"}, {"value": "Horizontally stretched by 3"}, {"value": "Horizontally compressed by 1/3"}]'::jsonb, 'Horizontally compressed by 1/3', E'Input multipliers $> 1$ compress the graph horizontally.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_22', 'If $f(x) = x^2 + 4$, what is the minimum value of $g(x) = f(x-10) + 5$?', '[]'::jsonb, '9', E'Minimum of $f$ is 4. Vertical shift $+5$ gives new minimum $4 + 5 = 9$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_23', 'If $g(x) = f(x) + k$, and the graph of $g$ is lower than the graph of $f$, what must be true about $k$?', '[{"value": "$k > 0$"}, {"value": "$k < 0$"}, {"value": "$k = 0$"}, {"value": "$k = x$"}]'::jsonb, '$k < 0$', E'A downward shift occurs when $k$ is negative.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_24', 'If $(2, 4)$ is on the graph of $f(x)$, and $(2, -4)$ is on the graph of $a \\cdot f(x)$, what is the value of $a$?', '[]'::jsonb, '-1', E'$a \\cdot f(2) = -4$, so $a(4) = -4$, giving $a = -1$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_25', 'Which transformation results in a graph that is wider than the original $y = |x|$?', '[{"value": "$y = 2|x|$"}, {"value": "$y = 0.5|x|$"}, {"value": "$y = |x| + 2$"}, {"value": "$y = |x+2|$"}]'::jsonb, '$y = 0.5|x|$', E'A vertical compression ($0 < a < 1$) makes a graph appear wider.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_26', 'The point $(4, 2)$ is on the graph of the function $f$. If $g(x) = f(x+5) + 6$, what is the $y$-coordinate of the corresponding point on the graph of $g$?', '[]'::jsonb, '8', E'The $+6$ outside shifts $y$ up by 6. Original $y = 2$, new $y = 2 + 6 = 8$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_27', 'If $f(x) = x^2$, which of the following defines a function $g$ whose graph is the result of reflecting the graph of $f$ across the $y$-axis?', '[{"value": "$g(x) = -x^2$"}, {"value": "$g(x) = (-x)^2$"}, {"value": "$g(x) = x^2 - 1$"}, {"value": "$g(x) = \\frac{1}{x^2}$"}]'::jsonb, '$g(x) = (-x)^2$', E'Reflection across the $y$-axis: $f(-x) = (-x)^2$. (For $x^2$ the graph is unchanged since $(-x)^2 = x^2$.)', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_28', 'The function $f$ is defined by $f(x) = 3x + 4$. The graph of $g$ is the result of shifting $f$ down by 10 units. What is the $x$-intercept of the graph of $g$?', '[]'::jsonb, '2', E'$g(x) = 3x + 4 - 10 = 3x - 6$. Set $0 = 3x - 6$, so $x = 2$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_29', 'The graph of $f(x) = x^2$ is transformed into a narrower graph $g$. Which of the following could define $g$?', '[{"value": "$g(x) = \\frac{1}{4}x^2$"}, {"value": "$g(x) = 4x^2$"}, {"value": "$g(x) = x^2 + 4$"}, {"value": "$g(x) = (x+4)^2$"}]'::jsonb, '$g(x) = 4x^2$', E'A vertical stretch ($a > 1$) makes the parabola narrower.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_30', 'If the graph of $y = f(x)$ is shifted 7 units to the right and 2 units up, the resulting graph is $y = f(x-h) + k$. What is the value of $hk$?', '[]'::jsonb, '14', E'$h = 7$, $k = 2$. Product: $7 \\times 2 = 14$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_31', '$f(x) = 2^x$. Which of the following defines a function $g$ whose graph is the result of reflecting $f$ across the $x$-axis and then shifting it 5 units up?', '[{"value": "$g(x) = 2^{-x} + 5$"}, {"value": "$g(x) = -2^x + 5$"}, {"value": "$g(x) = -2^{x+5}$"}, {"value": "$g(x) = 2^x - 5$"}]'::jsonb, '$g(x) = -2^x + 5$', E'Reflect: $-2^x$. Shift up 5: $-2^x + 5$.', 7, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_32', 'Which equation describes the relationship between function $f$ and function $g$, where $g$ is the graph of $f$ shifted 1 unit to the right?', '[{"value": "$g(x) = f(x) + 1$"}, {"value": "$g(x) = f(x) - 1$"}, {"value": "$g(x) = f(x - 1)$"}, {"value": "$g(x) = f(x + 1)$"}]'::jsonb, '$g(x) = f(x - 1)$', E'A shift 1 unit to the right is $f(x - 1)$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_33', 'The function $f$ is defined by $f(x) = |x-2| + 1$. If $g(x) = f(x+4) - 3$, what is the $x$-coordinate of the vertex (minimum point) of the graph of $g$?', '[]'::jsonb, '-2', E'Vertex of $f$: $(2, 1)$. Shift left 4: $x = 2 - 4 = -2$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_34', 'How does the graph of $y = f(x+8)$ compare to the graph of $y = f(x)$?', '[{"value": "It is shifted 8 units up."}, {"value": "It is shifted 8 units down."}, {"value": "It is shifted 8 units left."}, {"value": "It is shifted 8 units right."}]'::jsonb, 'It is shifted 8 units left.', E'Adding inside the function shifts left.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_35', 'The point $(3, 12)$ is on the graph of $y = f(x)$. What is the $y$-coordinate of the corresponding point on the graph of $y = f(x) - 15$?', '[]'::jsonb, '-3', E'$12 - 15 = -3$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_36', 'Which transformation maps $f(x) = x$ to $g(x) = -x$?', '[{"value": "Reflection across the $x$-axis only."}, {"value": "Reflection across the $y$-axis only."}, {"value": "Both A and B are correct for this specific function."}, {"value": "Neither A nor B."}]'::jsonb, 'Both A and B are correct for this specific function.', E'For $f(x) = x$: $-f(x) = -x$ and $f(-x) = -x$. Both give the same result.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_37', 'The function $f(x) = x^2 + 6x + 9$ is shifted 2 units to the right to create function $g$. What is the value of $g(0)$?', '[]'::jsonb, '1', E'$g(x) = f(x-2)$. $g(0) = f(-2) = (-2)^2 + 6(-2) + 9 = 4 - 12 + 9 = 1$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_38', 'If $g(x) = 3f(x-4) + 2$, which of the following is NOT one of the transformations applied to $f$ to get $g$?', '[{"value": "A vertical stretch by a factor of 3."}, {"value": "A horizontal shift to the right by 4 units."}, {"value": "A vertical shift up by 2 units."}, {"value": "A reflection across the $x$-axis."}]'::jsonb, 'A reflection across the $x$-axis.', E'The expression has stretch ($3$), right shift ($-4$), and up shift ($+2$). No negative multiplier means no reflection.', 7, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_39', 'If $f(x) = x^2$ and $g(x) = (x-c)^2$ where the vertex of $g$ is at $x = 3$, what is the value of $c$?', '[{"value": "-3"}, {"value": "0"}, {"value": "3"}, {"value": "9"}]'::jsonb, '3', E'Vertex at $x = 3$ means $c = 3$: $(x - 3)^2$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_40', 'The function $f$ has a minimum value of $-8$. What is the minimum value of the function $g(x) = f(x+10) + 12$?', '[]'::jsonb, '4', E'Horizontal shift does not change the min value. Vertical shift: $-8 + 12 = 4$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_41', 'The graph of $y = f(x)$ is reflected across the $y$-axis. Which of the following is the new equation?', '[{"value": "$y = -f(x)$"}, {"value": "$y = f(-x)$"}, {"value": "$y = f(x) - 1$"}, {"value": "$y = \\frac{1}{f(x)}$"}]'::jsonb, '$y = f(-x)$', E'Replacing $x$ with $-x$ reflects the graph across the $y$-axis.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_42', 'If the graph of $f(x) = 5x - 2$ is shifted 4 units up and 1 unit left, what is the $y$-intercept of the resulting graph?', '[]'::jsonb, '7', E'$g(x) = f(x+1) + 4 = 5(x+1) - 2 + 4 = 5x + 7$. $y$-intercept is 7.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_43', 'Which equation could represent a function whose graph is $y = \\sqrt{x}$ reflected across the $x$-axis?', '[{"value": "$y = \\sqrt{-x}$"}, {"value": "$y = -\\sqrt{x}$"}, {"value": "$y = \\sqrt{x} - 4$"}, {"value": "$y = \\sqrt{x-4}$"}]'::jsonb, '$y = -\\sqrt{x}$', E'Reflecting across the $x$-axis negates the output: $-\\sqrt{x}$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_44', 'The function $g$ is defined by $g(x) = f(x/3)$. If the domain of $f$ is $[0, 6]$, what is the maximum value of the domain of $g$?', '[]'::jsonb, '18', E'$0 \\leq x/3 \\leq 6$ gives $0 \\leq x \\leq 18$. Maximum is 18.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_45', 'Which transformation of $f(x) = x^2$ would result in a vertex at $(-5, 0)$?', '[{"value": "$g(x) = (x-5)^2$"}, {"value": "$g(x) = (x+5)^2$"}, {"value": "$g(x) = x^2 - 5$"}, {"value": "$g(x) = x^2 + 5$"}]'::jsonb, '$g(x) = (x+5)^2$', E'Vertex at $x = -5$ means shift left 5: $(x+5)^2$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_46', 'If $(a, b)$ is a point on $f(x)$, and $(3a, b)$ is a point on $g(x) = f(kx)$, what is the value of $k$?', '[]'::jsonb, '1/3', E'$f(k \\cdot 3a) = f(a)$ requires $3ka = a$, so $k = 1/3$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_47', 'If $g(x) = \\frac{1}{2}f(x)$, how do the $y$-intercepts of $f$ and $g$ compare?', '[{"value": "They are the same."}, {"value": "The $y$-intercept of $g$ is half the $y$-intercept of $f$."}, {"value": "The $y$-intercept of $g$ is 2 units higher than $f$."}, {"value": "The $y$-intercept of $g$ is 2 units lower than $f$."}]'::jsonb, 'The $y$-intercept of $g$ is half the $y$-intercept of $f$.', E'$g(0) = \\frac{1}{2}f(0)$, so the $y$-intercept is halved.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_48', 'The function $f(x) = 10$ is a constant function. What is the value of $f(x+100) + 100$?', '[]'::jsonb, '110', E'$f$ is constant: $f(\\text{anything}) = 10$. So $10 + 100 = 110$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_49', 'The graph of $y = f(x)$ is shifted 3 units left and 4 units down. Which of the following is the new equation?', '[{"value": "$y = f(x-3) + 4$"}, {"value": "$y = f(x+3) - 4$"}, {"value": "$y = f(x-3) - 4$"}, {"value": "$y = f(x+3) + 4$"}]'::jsonb, '$y = f(x+3) - 4$', E'Left 3: $(x+3)$. Down 4: $-4$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12'),
('sat_lid_028_50', 'The vertex of $f(x) = x^2$ is $(0, 0)$. If $g(x) = -(x+7)^2 - 9$, what is the sum of the coordinates of the vertex of $g$?', '[]'::jsonb, '-16', E'Vertex of $g$: $(-7, -9)$. Sum: $-7 + (-9) = -16$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Function Transformations', false, true, '12')

ON CONFLICT (human_readable_id) DO NOTHING;


-- ============================================================
-- STEP 2: Create quiz for this lesson if none exists
-- ============================================================

DO $$
DECLARE
  v_lesson_id uuid;
  v_quiz_id   uuid;
BEGIN
  SELECT l.id INTO v_lesson_id
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-028'
  LIMIT 1;

  IF v_lesson_id IS NULL THEN
    RAISE NOTICE 'Lesson sat-quant-learn-sat-lid-028 not found; skipping.';
    RETURN;
  END IF;

  SELECT quiz_id INTO v_quiz_id
  FROM public.courses_lessons
  WHERE id = v_lesson_id;

  IF v_quiz_id IS NULL THEN
    INSERT INTO public.quizzes (title, lesson_id)
    VALUES ('lid_028 Practice', v_lesson_id)
    RETURNING id INTO v_quiz_id;

    UPDATE public.courses_lessons
    SET quiz_id = v_quiz_id
    WHERE id = v_lesson_id;
  END IF;
END $$;


-- ============================================================
-- STEP 3: Link all sat_lid_028_* questions to the lesson quiz
-- ============================================================

DO $$
DECLARE
  v_lesson_id uuid;
  v_quiz_id   uuid;
  v_qid       uuid;
  v_order     int := 1;
  v_hrid      text;
BEGIN
  SELECT l.id INTO v_lesson_id
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-028'
  LIMIT 1;

  IF v_lesson_id IS NULL THEN RETURN; END IF;

  SELECT quiz_id INTO v_quiz_id
  FROM public.courses_lessons
  WHERE id = v_lesson_id;

  IF v_quiz_id IS NULL THEN RETURN; END IF;

  FOR v_hrid IN
    SELECT human_readable_id
    FROM public.question_bank
    WHERE human_readable_id ~ '^sat_lid_028_[0-9]+$'
    ORDER BY (substring(human_readable_id from 'sat_lid_028_([0-9]+)$'))::int
  LOOP
    SELECT id INTO v_qid
    FROM public.question_bank
    WHERE human_readable_id = v_hrid;

    IF v_qid IS NOT NULL THEN
      INSERT INTO public.quiz_questions (quiz_id, question_id, question_order)
      VALUES (v_quiz_id, v_qid, v_order)
      ON CONFLICT DO NOTHING;
      v_order := v_order + 1;
    END IF;
  END LOOP;
END $$;


-- ============================================================
-- STEP 4: Rebuild lesson_interactive_content.quiz from question_bank
-- ============================================================

DO $$
DECLARE
  v_lesson_id  uuid;
  v_quiz_arr   jsonb := '[]'::jsonb;
  v_qrow       record;
  v_item       jsonb;
  v_answer_idx int;
  opt_val      text;
  opt_idx      int;
BEGIN
  SELECT l.id INTO v_lesson_id
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-028'
  LIMIT 1;

  IF v_lesson_id IS NULL THEN RETURN; END IF;

  FOR v_qrow IN
    SELECT id, question_text, options, correct_answer, explanation, question_type, difficulty
    FROM public.question_bank
    WHERE human_readable_id ~ '^sat_lid_028_[0-9]+$'
    ORDER BY (substring(human_readable_id from 'sat_lid_028_([0-9]+)$'))::int
  LOOP
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

    v_quiz_arr := v_quiz_arr || v_item;
  END LOOP;

  UPDATE public.lesson_interactive_content
  SET quiz = v_quiz_arr,
      updated_at = NOW()
  WHERE lesson_id = v_lesson_id;
END $$;

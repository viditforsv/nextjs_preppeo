-- Populate lesson sat-quant-learn-sat-lid-015 with theory + practice (interactive content).
-- Topic: Discriminant & Number of Solutions
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-015'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-015; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Discriminant & Number of Solutions',
    concept_content = E'The **discriminant** D = b² − 4ac tells you how many real solutions a quadratic equation ax² + bx + c = 0 has — without solving it.\n\n**Three cases:**\n- D > 0 → **two distinct** real solutions (parabola crosses x-axis twice)\n- D = 0 → **exactly one** real solution / double root (parabola is tangent to x-axis)\n- D < 0 → **no** real solutions (parabola does not touch x-axis)\n\n**Applications on the SAT:**\n1. "How many solutions?" → compute D and check the sign.\n2. "Find k so the equation has exactly one solution" → set D = 0 and solve for k.\n3. "For what values of k are there no real solutions?" → set D < 0 and solve the inequality.\n4. "A line is tangent to a parabola" → combine into one quadratic and set D = 0.\n\n**Nature of roots:**\n- D is a perfect square → roots are rational.\n- D > 0 but not a perfect square → roots are irrational.\n\n**Linear-quadratic systems:**\nWhen a line y = mx + b meets a parabola y = ax² + bx + c, set them equal to get a new quadratic. The discriminant of that quadratic determines how many intersection points exist.',
    formula_title = 'Worked Example',
    formula_content = E'y = x² − 4x + 7 and y = 3.\nHow many intersection points?\n\nStep 1 — Set equal\n  x² − 4x + 7 = 3\n  x² − 4x + 4 = 0\n\nStep 2 — Discriminant\n  a = 1, b = −4, c = 4\n  D = 16 − 16 = 0\n\nStep 3 — Interpret\n  D = 0 → exactly one intersection point\n  (the line is tangent to the parabola).'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Use the discriminant to determine how many solutions a quadratic equation has — a key SAT strategy that saves time.',
    '[
      {"title": "Compute the discriminant", "content": "For ax² + bx + c = 0, calculate D = b² − 4ac. No need to fully solve the equation if you only need the number of solutions.", "equation": "D = (−4)² − 4(1)(4) = 0", "highlight": "D = b² − 4ac"},
      {"title": "Interpret the sign of D", "content": "D > 0 means two solutions. D = 0 means one solution (tangent/double root). D < 0 means no real solutions. The SAT often asks you to just determine the count.", "highlight": "positive → 2, zero → 1, negative → 0"},
      {"title": "Find a parameter for a specific count", "content": "If a question says ''exactly one solution,'' set D = 0. If ''no real solutions,'' set D < 0. Solve the resulting equation or inequality for the unknown parameter (often k or c).", "equation": "k² − 36 = 0 → k = ±6", "highlight": "set D = 0 or D < 0"},
      {"title": "Apply to linear-quadratic systems", "content": "Set the line and parabola equal to get one quadratic equation. The discriminant of that combined equation tells you how many intersection points exist.", "highlight": "combine → one quadratic → check D"},
      {"title": "Tangent line condition", "content": "A line is tangent to a parabola when D = 0 for the combined equation. This is because tangency means they touch at exactly one point.", "equation": "x² + (6 − m)x + 9 = 0, D = 0 → m = 0 or 12", "highlight": "tangent ↔ D = 0"}
    ]'::jsonb,
    '[
      {"question": "y = x² − 4x + 7 and y = 3. How many intersection points?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 1, "explanation": "x² − 4x + 4 = 0. D = 16 − 16 = 0 → one point.", "difficulty": "Medium"},
      {"question": "y = x² − 5 and y = 4x. If x > 0, what is x?", "options": ["1", "5", "4", "2"], "answer": 1, "explanation": "x² − 4x − 5 = 0 → (x − 5)(x + 1) = 0. x > 0 → x = 5.", "difficulty": "Hard"},
      {"question": "y = x² − 6 and y = 3. x-coordinates of intersections?", "options": ["3 and −3", "6 and −6", "0 and 3", "9 and −9"], "answer": 0, "explanation": "x² = 9 → x = ±3.", "difficulty": "Medium"},
      {"question": "y = mx + 2 is tangent to y = x² + 6x + 11. One possible m?", "options": ["0", "2", "6", "12"], "answer": 3, "explanation": "x² + (6 − m)x + 9 = 0. D = 0 → (6 − m)² = 36 → m = 0 or 12.", "difficulty": "Hard"},
      {"question": "y = x² + 2x + 5 and y = −x + 1. How many real solutions?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 0, "explanation": "x² + 3x + 4 = 0. D = 9 − 16 = −7 < 0.", "difficulty": "Medium"},
      {"question": "y = x² − 2 and y = x. Which point is a solution?", "options": ["(1, 1)", "(2, 2)", "(0, 0)", "(−1, 1)"], "answer": 1, "explanation": "x² − x − 2 = 0 → (x − 2)(x + 1) = 0. (2, 2) works.", "difficulty": "Medium"},
      {"question": "y = −2x + k is tangent to y = x² − 6x + 7. What is k?", "options": ["2", "3", "4", "7"], "answer": 1, "explanation": "x² − 4x + (7 − k) = 0. D = 16 − 4(7 − k) = 0 → k = 3.", "difficulty": "Hard"},
      {"question": "y = x² and y = x + 6. Which is a possible y-value?", "options": ["3", "4", "6", "9"], "answer": 3, "explanation": "x² − x − 6 = 0 → x = 3 or −2. y = 9 or 4. Both valid; 9 listed.", "difficulty": "Medium"},
      {"question": "y = (x − 3)² + 2 and y = 2. Solution (x, y)?", "options": ["(0, 2)", "(3, 2)", "(2, 3)", "(3, 0)"], "answer": 1, "explanation": "(x − 3)² = 0 → x = 3. Point: (3, 2).", "difficulty": "Hard"},
      {"question": "y = 2x − 10 and y = x² − 4x + 5. Intersection count?", "options": ["0", "1", "2", "3"], "answer": 0, "explanation": "x² − 6x + 15 = 0. D = 36 − 60 = −24 < 0.", "difficulty": "Medium"},
      {"question": "y = x² + 1 and y = 2x. If y > 0, what is y?", "options": ["1", "2", "0", "No such y"], "answer": 1, "explanation": "x² − 2x + 1 = 0 → x = 1. y = 2.", "difficulty": "Hard"},
      {"question": "y = −x² + 4 and y = 0. Distance between intersection points?", "options": ["2", "4", "8", "0"], "answer": 1, "explanation": "x² = 4 → x = ±2. Distance = 4.", "difficulty": "Medium"},
      {"question": "y = 3x² − 12x + 10 and y = −2. Sum of x-coordinates?", "options": ["4", "3", "12", "−4"], "answer": 0, "explanation": "3x² − 12x + 12 = 0. Sum = −(−12)/3 = 4.", "difficulty": "Hard"},
      {"question": "y = x² + 10 and y = 5. How do they intersect?", "options": ["Two points", "One point", "They do not intersect", "Line is axis of symmetry"], "answer": 2, "explanation": "x² = −5 → no real solution.", "difficulty": "Medium"},
      {"question": "y = x² + cx + 9 and y = 0 has one solution. What is c?", "options": ["3", "6", "9", "0"], "answer": 1, "explanation": "D = c² − 36 = 0 → c = ±6.", "difficulty": "Hard"},
      {"question": "y = x² − x and y = x + 3. A y-coordinate of intersection?", "options": ["3", "6", "0", "1"], "answer": 1, "explanation": "x² − 2x − 3 = 0 → x = 3, −1. If x = 3, y = 6.", "difficulty": "Medium"},
      {"question": "y = x + 1 intersects x² + y² = 5 at which points?", "options": ["(1, 2) and (−2, −1)", "(2, 1) and (−1, −2)", "(0, 1) and (1, 0)", "(1, 2) and (2, 1)"], "answer": 0, "explanation": "x² + (x + 1)² = 5 → 2x² + 2x − 4 = 0 → x = 1, −2.", "difficulty": "Hard"},
      {"question": "y = x² − 4x + 10 and y = 3x. What is x² − 7x?", "options": ["10", "−10", "7", "0"], "answer": 1, "explanation": "x² − 7x + 10 = 0 → x² − 7x = −10.", "difficulty": "Medium"},
      {"question": "x = 2 intersects y = 3x² − 5x + 1. y-coordinate of P?", "options": ["1", "3", "23", "11"], "answer": 1, "explanation": "y = 12 − 10 + 1 = 3.", "difficulty": "Hard"},
      {"question": "y = ax² passes through intersection of y = x and x = 2. What is a?", "options": ["0.5", "1", "2", "4"], "answer": 0, "explanation": "Intersection: (2, 2). 2 = 4a → a = 0.5.", "difficulty": "Medium"},
      {"question": "Vertex of y = x² − 2x + 5 lies on which line?", "options": ["y = 4", "y = x + 3", "y = 5", "y = x − 1"], "answer": 0, "explanation": "Vertex: (1, 4). y = 4 passes through it.", "difficulty": "Hard"},
      {"question": "y = 2x² and y = 8. Possible values of x?", "options": ["2 only", "4 only", "2 and −2", "4 and −4"], "answer": 2, "explanation": "x² = 4 → x = ±2.", "difficulty": "Medium"},
      {"question": "x² + y² = 25 and x = 3. Positive y-value?", "options": ["3", "4", "5", "16"], "answer": 1, "explanation": "y² = 16 → y = ±4. Positive: 4.", "difficulty": "Hard"},
      {"question": "y = x² + 5 and y = x + 2. How many real solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "x² − x + 3 = 0. D = 1 − 12 = −11 < 0.", "difficulty": "Medium"},
      {"question": "y = 6x + c tangent to y = x² + 10. What is c?", "options": ["1", "10", "19", "−1"], "answer": 0, "explanation": "x² − 6x + (10 − c) = 0. D = 36 − 4(10 − c) = 0 → c = 1.", "difficulty": "Hard"},
      {"question": "x² + 10x + c = 0 has exactly one solution. c = ?", "options": ["5", "10", "25", "100"], "answer": 2, "explanation": "D = 100 − 4c = 0 → c = 25.", "difficulty": "Medium"},
      {"question": "Which equation has no real solutions?", "options": ["2x² − 4x + 2 = 0", "x² + 3x + 5 = 0", "x² − 5x − 1 = 0", "3x² + 6x + 3 = 0"], "answer": 1, "explanation": "D = 9 − 20 = −11 < 0.", "difficulty": "Hard"},
      {"question": "f(x) = 3x² − kx + 3 is tangent to x-axis. One possible k?", "options": ["3", "6", "9", "12"], "answer": 1, "explanation": "k² − 36 = 0 → k = ±6.", "difficulty": "Hard"},
      {"question": "How many real solutions does x² − 8x + 16 = 0 have?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 1, "explanation": "D = 64 − 64 = 0 → one.", "difficulty": "Medium"},
      {"question": "2x² − 4x + n = 0 has no real solutions. Which n works?", "options": ["1", "2", "3", "0"], "answer": 2, "explanation": "16 − 8n < 0 → n > 2. Only 3 satisfies.", "difficulty": "Hard"},
      {"question": "y = x² − kx + 9 crosses x-axis at two points. What is true about k?", "options": ["k² = 36", "k² > 36", "k² < 36", "k = 6"], "answer": 1, "explanation": "D > 0 → k² − 36 > 0 → k² > 36.", "difficulty": "Medium"},
      {"question": "Which equation has D = 0?", "options": ["x² + 4x + 4 = 0", "x² − 4x − 4 = 0", "x² + 4 = 0", "x² − 4 = 0"], "answer": 0, "explanation": "D = 16 − 16 = 0.", "difficulty": "Medium"},
      {"question": "3x² + 6x + k = 0 has two distinct solutions. All possible k?", "options": ["k < 3", "k > 3", "k = 3", "k < 0"], "answer": 0, "explanation": "36 − 12k > 0 → k < 3.", "difficulty": "Hard"},
      {"question": "D = −16 for ax² + bx + c = 0. How many x-intercepts?", "options": ["Zero", "One", "Two", "Four"], "answer": 0, "explanation": "D < 0 → no real solutions → zero x-intercepts.", "difficulty": "Hard"},
      {"question": "x² + bx + 9 = 0 has one solution, b < 0. What is b?", "options": ["−3", "−6", "−9", "−18"], "answer": 1, "explanation": "b² = 36 → b = ±6. Since b < 0: b = −6.", "difficulty": "Medium"},
      {"question": "x² − kx + k = 0 has one solution. Which values of k?", "options": ["0 and 4", "2 only", "4 only", "0 and 2"], "answer": 0, "explanation": "k² − 4k = 0 → k(k − 4) = 0 → k = 0 or 4.", "difficulty": "Hard"},
      {"question": "Discriminant of x² − 12x + 36 = 0?", "options": ["0", "12", "36", "144"], "answer": 0, "explanation": "D = 144 − 144 = 0.", "difficulty": "Medium"},
      {"question": "Graph of y = x² + c has vertex above x-axis (c > 0). Solutions of x² + c = 0?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 0, "explanation": "x² = −c. Since c > 0, no real solution.", "difficulty": "Hard"},
      {"question": "4x² + mx + 1 = 0 has two distinct solutions when:", "options": ["|m| > 4", "|m| < 4", "m > 4", "m < 4"], "answer": 0, "explanation": "m² − 16 > 0 → |m| > 4.", "difficulty": "Hard"},
      {"question": "f(x) = x² − 6x + 9. How many x-intercepts?", "options": ["0", "1", "2", "3"], "answer": 1, "explanation": "D = 36 − 36 = 0 → one.", "difficulty": "Medium"},
      {"question": "x² − 4x + (k − 3) = 0 has no real solutions. Which is true?", "options": ["k < 7", "k > 7", "k > 4", "k < 4"], "answer": 1, "explanation": "16 − 4(k − 3) < 0 → 28 < 4k → k > 7.", "difficulty": "Hard"},
      {"question": "Discriminant of 2x² + 5x − 3 = 0?", "options": ["1", "24", "49", "13"], "answer": 2, "explanation": "D = 25 + 24 = 49.", "difficulty": "Medium"},
      {"question": "A quadratic has D = 17. Which must be true?", "options": ["No real solutions", "Exactly one solution", "Two distinct rational solutions", "Two distinct irrational solutions"], "answer": 3, "explanation": "D > 0 but 17 isn''t a perfect square → irrational roots.", "difficulty": "Hard"},
      {"question": "Graph of y = ax² + bx + c doesn''t cross x-axis. Which is true?", "options": ["b² − 4ac > 0", "b² − 4ac = 0", "b² < 4ac", "a = 0"], "answer": 2, "explanation": "No crossing → D < 0 → b² < 4ac.", "difficulty": "Medium"},
      {"question": "x² − 2x + (k + 1) = 0 has exactly one solution. k = ?", "options": ["0", "1", "−1", "2"], "answer": 0, "explanation": "4 − 4(k + 1) = 0 → k = 0.", "difficulty": "Hard"},
      {"question": "Which discriminant gives two distinct real solutions?", "options": ["−4", "0", "12", "√5"], "answer": 2, "explanation": "D = 12 > 0.", "difficulty": "Medium"},
      {"question": "x² − kx + 1 = 0, k > 0, no real solutions. Range of k?", "options": ["k < 2", "k > 2", "0 < k < 2", "k = 2"], "answer": 2, "explanation": "k² < 4 and k > 0 → 0 < k < 2.", "difficulty": "Hard"},
      {"question": "x² + 6x + 9 = 0. How many times does graph touch x-axis?", "options": ["0", "1", "2", "3"], "answer": 1, "explanation": "(x + 3)² = 0. D = 0 → touches once.", "difficulty": "Medium"},
      {"question": "ax² + bx + c = 0 with a > 0 and c < 0. How many real solutions?", "options": ["Zero", "One", "Two", "Cannot be determined"], "answer": 2, "explanation": "ac < 0 so −4ac > 0. D = b² + (positive) > 0 always → two solutions.", "difficulty": "Hard"},
      {"question": "Discriminant of x² + x + 1 = 0?", "options": ["1", "0", "−3", "5"], "answer": 2, "explanation": "D = 1 − 4 = −3.", "difficulty": "Medium"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-015: %', lid;
END $$;

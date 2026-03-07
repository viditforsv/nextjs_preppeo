-- Populate lesson sat-quant-learn-sat-lid-014 with theory + practice (interactive content).
-- Topic: Solving Quadratics (Factoring & Formula)
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-014'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-014; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Solving Quadratics (Factoring & Formula)',
    concept_content = E'A **quadratic equation** has the form ax² + bx + c = 0. The SAT tests multiple methods for solving them.\n\n**Method 1 — Factoring:**\n- Find two numbers that multiply to c (or a·c for leading coefficient ≠ 1) and add to b.\n- Write in factored form and apply the **Zero Product Property**: if AB = 0, then A = 0 or B = 0.\n\n**Method 2 — Square Root:**\n- When the equation is (expression)² = k, take ±√k of both sides.\n- Example: (x − 4)² = 49 → x − 4 = ±7.\n\n**Method 3 — Quadratic Formula:**\n- x = (−b ± √(b² − 4ac)) / (2a)\n- Works for any quadratic. Use when factoring is difficult.\n\n**Method 4 — Completing the Square:**\n- Rewrite x² + bx + c = 0 as (x + b/2)² = (b/2)² − c.\n\n**The Discriminant (D = b² − 4ac):**\n- D > 0 → two distinct real solutions\n- D = 0 → one repeated real solution (perfect square)\n- D < 0 → no real solutions\n\n**Key relationships:**\n- Sum of roots = −b/a\n- Product of roots = c/a\n- Difference of squares: a² − b² = (a − b)(a + b)',
    formula_title = 'Worked Example',
    formula_content = E'Solve: 2x² + 5x − 12 = 0\n\nStep 1 — Use the ac method\n  a × c = 2 × (−12) = −24\n  Find factors of −24 that add to 5: (8, −3)\n\nStep 2 — Split the middle term\n  2x² + 8x − 3x − 12 = 0\n\nStep 3 — Factor by grouping\n  2x(x + 4) − 3(x + 4) = 0\n  (2x − 3)(x + 4) = 0\n\nStep 4 — Solve\n  2x − 3 = 0 → x = 1.5\n  x + 4 = 0 → x = −4'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master factoring, the quadratic formula, completing the square, and the discriminant — essential tools for solving quadratic equations on the SAT.',
    '[
      {"title": "Factor when possible", "content": "For x² + bx + c = 0, find two numbers that multiply to c and add to b. For ax² + bx + c, use the ac method: find factors of a·c that add to b, then factor by grouping.", "equation": "x² − 7x + 10 = (x − 2)(x − 5)", "highlight": "multiply to c, add to b"},
      {"title": "Use the square root method", "content": "When the equation is in the form (expression)² = constant, take the square root of both sides. Remember the ± sign.", "equation": "(x − 4)² = 49 → x = 11 or x = −3", "highlight": "take ±√ of both sides"},
      {"title": "Apply the quadratic formula", "content": "x = (−b ± √(b² − 4ac)) / (2a). Identify a, b, c from standard form, substitute, and simplify. Useful when the equation does not factor neatly.", "equation": "x² − 6x + 4 = 0 → x = 3 ± √5", "highlight": "works for any quadratic"},
      {"title": "Use the discriminant to count solutions", "content": "D = b² − 4ac. If D > 0: two solutions. If D = 0: one solution (double root). If D < 0: no real solutions. The SAT often asks ''how many solutions'' without requiring you to find them.", "highlight": "D > 0 → 2, D = 0 → 1, D < 0 → 0"},
      {"title": "Complete the square", "content": "Move c to the right. Add (b/2)² to both sides. Factor the left side into a perfect square. This converts standard form to vertex form.", "equation": "x² + 4x − 1 = 0 → (x + 2)² = 5", "highlight": "add (b/2)² to both sides"}
    ]'::jsonb,
    '[
      {"question": "Solve x² − 7x + 10 = 0.", "options": ["x = −2, x = −5", "x = 2, x = 5", "x = −10, x = 1", "x = 10, x = −1"], "answer": 1, "explanation": "(x − 2)(x − 5) = 0. Roots: 2 and 5.", "difficulty": "Medium"},
      {"question": "Sum of solutions of 3x² − 12x + 9 = 0?", "options": ["3", "4", "9", "12"], "answer": 1, "explanation": "Sum = −b/a = 12/3 = 4.", "difficulty": "Hard"},
      {"question": "For which equation is x = −3 a solution?", "options": ["x² − 9 = 0", "x² + 6x + 9 = 0", "x² − 6x + 9 = 0", "x² + 3 = 0"], "answer": 1, "explanation": "(−3)² + 6(−3) + 9 = 0. Also: (x + 3)² = 0.", "difficulty": "Hard"},
      {"question": "2x² + 5x − 12 = 0 with x > 0. What is x?", "options": ["1.5", "4", "3", "2.5"], "answer": 0, "explanation": "(2x − 3)(x + 4) = 0. x = 1.5 or −4. Since x > 0: x = 1.5.", "difficulty": "Hard"},
      {"question": "Solutions to (x − 4)² = 49?", "options": ["x = 11 and x = −3", "x = 53 and x = −45", "x = 7 and x = −7", "x = 11 and x = 3"], "answer": 0, "explanation": "x − 4 = ±7. x = 11 or x = −3.", "difficulty": "Medium"},
      {"question": "Using the quadratic formula on x² − 6x + 4 = 0, a solution is:", "options": ["3 + √5", "6 + √20", "3 − √10", "3 + √20"], "answer": 0, "explanation": "x = (6 ± √20)/2 = (6 ± 2√5)/2 = 3 ± √5.", "difficulty": "Hard"},
      {"question": "How many distinct real solutions does x² + 10x + 25 = 0 have?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 1, "explanation": "D = 100 − 100 = 0. One repeated root.", "difficulty": "Medium"},
      {"question": "Which equation has the same solutions as x² − 8x − 20 = 0?", "options": ["(x − 4)² = 36", "(x − 4)² = 4", "(x + 4)² = 36", "(x − 8)² = 20"], "answer": 0, "explanation": "Complete the square: x² − 8x + 16 = 36 → (x − 4)² = 36.", "difficulty": "Hard"},
      {"question": "(x − 5)(x + 3) = 0 with x < 0. What is x + 5?", "options": ["2", "5", "8", "10"], "answer": 0, "explanation": "x = −3 (since x < 0). x + 5 = 2.", "difficulty": "Medium"},
      {"question": "Positive solution of 2x² − 32 = 0?", "options": ["4", "8", "16", "2"], "answer": 0, "explanation": "x² = 16 → x = ±4. Positive: 4.", "difficulty": "Medium"},
      {"question": "Which is a factor of x² − 11x + 24?", "options": ["x + 3", "x − 6", "x − 8", "x + 8"], "answer": 2, "explanation": "(−3)(−8) = 24 and (−3) + (−8) = −11. Factor: (x − 3)(x − 8).", "difficulty": "Hard"},
      {"question": "x² + kx + 16 = (x + 4)². What is k?", "options": ["4", "8", "16", "32"], "answer": 1, "explanation": "(x + 4)² = x² + 8x + 16. So k = 8.", "difficulty": "Medium"},
      {"question": "How many real solutions does 2x² − 4x + 5 = 0 have?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "D = 16 − 40 = −24 < 0. No real solutions.", "difficulty": "Hard"},
      {"question": "Solution set for x(x − 9) = 0?", "options": ["{9}", "{0, −9}", "{0, 9}", "{−9, 9}"], "answer": 2, "explanation": "x = 0 or x − 9 = 0 → x = 9.", "difficulty": "Medium"},
      {"question": "x² + bx + 12 = 0 has x = 2 as a solution. What is b?", "options": ["−6", "−8", "6", "8"], "answer": 1, "explanation": "4 + 2b + 12 = 0 → 2b = −16 → b = −8.", "difficulty": "Hard"},
      {"question": "Expand (2x − 3)(x + 4).", "options": ["2x² + 5x − 12", "2x² − 12", "2x² + 11x − 12", "2x² + 5x + 12"], "answer": 0, "explanation": "FOIL: 2x² + 8x − 3x − 12 = 2x² + 5x − 12.", "difficulty": "Medium"},
      {"question": "Product of roots of 2x² − 10x + 16 = 0?", "options": ["5", "8", "10", "16"], "answer": 1, "explanation": "Product = c/a = 16/2 = 8.", "difficulty": "Hard"},
      {"question": "Solutions to x² − 100 = 0?", "options": ["x = 10 only", "x = −10 only", "x = 10 and x = −10", "x = 50 and x = −50"], "answer": 2, "explanation": "Difference of squares: (x − 10)(x + 10) = 0.", "difficulty": "Medium"},
      {"question": "Completing the square on x² + 4x − 1 = 0 gives:", "options": ["(x + 2)² = 5", "(x + 2)² = 3", "(x + 4)² = 17", "(x + 2)² = 1"], "answer": 0, "explanation": "x² + 4x + 4 = 5 → (x + 2)² = 5.", "difficulty": "Hard"},
      {"question": "(x − a)(x − b) = 0 with roots 7 and −2. What is a + b?", "options": ["5", "9", "−5", "14"], "answer": 0, "explanation": "a = 7, b = −2. Sum = 5.", "difficulty": "Medium"},
      {"question": "Which quadratic has no real solutions?", "options": ["x² − 4x + 4 = 0", "x² + 4 = 0", "x² − 4 = 0", "x² + 4x + 3 = 0"], "answer": 1, "explanation": "x² = −4 has no real solution.", "difficulty": "Hard"},
      {"question": "Vertex of y = (x − 3)² + 5?", "options": ["(3, 5)", "(−3, 5)", "(3, −5)", "(5, 3)"], "answer": 0, "explanation": "Vertex form y = a(x − h)² + k → (h, k) = (3, 5).", "difficulty": "Medium"},
      {"question": "Roots of x² − 5x = 0?", "options": ["x = 5 only", "x = 0 and x = −5", "x = 0 and x = 5", "x = 2.5 and x = −2.5"], "answer": 2, "explanation": "x(x − 5) = 0 → x = 0 or x = 5.", "difficulty": "Hard"},
      {"question": "x² − kx + 9 = 0 has exactly one solution. Possible k?", "options": ["3", "6", "9", "0"], "answer": 1, "explanation": "D = k² − 36 = 0 → k = ±6.", "difficulty": "Medium"},
      {"question": "Solve x² = 3x + 10.", "options": ["x = 5, x = −2", "x = −5, x = 2", "x = 10, x = −1", "x = 5, x = 2"], "answer": 0, "explanation": "x² − 3x − 10 = 0 → (x − 5)(x + 2) = 0.", "difficulty": "Hard"},
      {"question": "x² + kx + 49 = 0 has one solution, k > 0. What is k?", "options": ["7", "14", "28", "49"], "answer": 1, "explanation": "D = k² − 196 = 0 → k = 14.", "difficulty": "Hard"},
      {"question": "(x − 10)² = 64 with x < 10. What is x?", "options": ["2", "18", "−2", "8"], "answer": 0, "explanation": "x − 10 = ±8. x = 18 or 2. Since x < 10: x = 2.", "difficulty": "Medium"},
      {"question": "Sum of solutions of (2x − 1)(x + 5) = 0?", "options": ["4.5", "−4.5", "−4", "5.5"], "answer": 1, "explanation": "x = 0.5 and x = −5. Sum = −4.5.", "difficulty": "Hard"},
      {"question": "x² + 10x + 15 = 0 completed gives:", "options": ["(x + 5)² = 10", "(x + 5)² = 25", "(x + 10)² = 85", "(x + 5)² = −15"], "answer": 0, "explanation": "x² + 10x + 25 = 10 → (x + 5)² = 10.", "difficulty": "Hard"},
      {"question": "x² − 14x + 49 = 0. What is x?", "options": ["7", "−7", "0", "49"], "answer": 0, "explanation": "(x − 7)² = 0 → x = 7.", "difficulty": "Medium"},
      {"question": "If b² < 4ac in ax² + bx + c = 0, then:", "options": ["Two real solutions", "One real solution", "No real solutions", "Both solutions are positive"], "answer": 2, "explanation": "Negative discriminant → no real solutions.", "difficulty": "Hard"},
      {"question": "Positive solution of x² − 1/4 = 0?", "options": ["0.25", "0.5", "2", "4"], "answer": 1, "explanation": "x² = 1/4 → x = ±0.5. Positive: 0.5.", "difficulty": "Medium"},
      {"question": "x = 2 is a solution of x² + kx − 10 = 0. Other solution?", "options": ["−5", "5", "−2", "3"], "answer": 0, "explanation": "4 + 2k − 10 = 0 → k = 3. x² + 3x − 10 = (x + 5)(x − 2). Other root: −5.", "difficulty": "Hard"},
      {"question": "Which is a factor of x² + 5x − 6?", "options": ["x + 2", "x − 3", "x + 6", "x − 6"], "answer": 2, "explanation": "(6)(−1) = −6 and 6 + (−1) = 5. Factor: (x + 6)(x − 1).", "difficulty": "Medium"},
      {"question": "2(x − 3)² = 18. Sum of possible x values?", "options": ["0", "3", "6", "12"], "answer": 2, "explanation": "(x − 3)² = 9 → x = 6 or 0. Sum = 6.", "difficulty": "Hard"},
      {"question": "x² − 12x + c = 0 has one solution. What is c?", "options": ["6", "12", "36", "144"], "answer": 2, "explanation": "c = (−12/2)² = 36.", "difficulty": "Hard"},
      {"question": "Solutions to x² + 8x + 12 = 0?", "options": ["x = 6, x = 2", "x = −6, x = −2", "x = −4, x = −4", "x = −12, x = −1"], "answer": 1, "explanation": "(x + 6)(x + 2) = 0. Roots: −6, −2.", "difficulty": "Medium"},
      {"question": "x² − y² = 24 and x + y = 6. What is x − y?", "options": ["4", "18", "144", "2"], "answer": 0, "explanation": "(x − y)(x + y) = 24 → (x − y)(6) = 24 → x − y = 4.", "difficulty": "Hard"},
      {"question": "Which equation has roots 3 and −5?", "options": ["(x + 3)(x − 5) = 0", "(x − 3)(x + 5) = 0", "(x − 3)(x − 5) = 0", "(x + 3)(x + 5) = 0"], "answer": 1, "explanation": "Root 3 → (x − 3). Root −5 → (x + 5).", "difficulty": "Medium"},
      {"question": "Discriminant of 3x² − 2x + 1 = 0?", "options": ["−8", "16", "4", "0"], "answer": 0, "explanation": "D = 4 − 12 = −8.", "difficulty": "Hard"},
      {"question": "2x² + 8x = 0. Possible values of x?", "options": ["0 and 4", "0 and −4", "4 and −4", "2 and −8"], "answer": 1, "explanation": "2x(x + 4) = 0 → x = 0 or x = −4.", "difficulty": "Hard"},
      {"question": "Vertex form of y = x² − 6x + 13?", "options": ["y = (x − 3)² + 4", "y = (x − 3)² + 13", "y = (x + 3)² + 4", "y = (x − 6)² + 7"], "answer": 0, "explanation": "x² − 6x + 9 + 4 = (x − 3)² + 4.", "difficulty": "Medium"},
      {"question": "Solve (x + 2)² = 0.", "options": ["2", "−2", "0", "±2"], "answer": 1, "explanation": "x + 2 = 0 → x = −2.", "difficulty": "Medium"},
      {"question": "A parabola crosses the x-axis at 1 and 3. Which equation?", "options": ["y = (x − 1)(x − 3)", "y = (x + 1)(x + 3)", "y = (x − 2)² + 1", "y = x² − 4"], "answer": 0, "explanation": "Roots 1 and 3 → y = (x − 1)(x − 3).", "difficulty": "Hard"},
      {"question": "x² + 1 = 0. Value of x?", "options": ["1", "−1", "No real solution", "0"], "answer": 2, "explanation": "x² = −1. No real number squares to negative.", "difficulty": "Hard"},
      {"question": "f(x) = x² − 4x + 4. What is f(5)?", "options": ["9", "1", "5", "25"], "answer": 0, "explanation": "25 − 20 + 4 = 9.", "difficulty": "Medium"},
      {"question": "Which is the quadratic formula?", "options": ["x = (−b ± √(b² − 4ac))/(2a)", "x = (b ± √(b² − 4ac))/(2a)", "x = (−b ± √(b² + 4ac))/(2a)", "x = −b ± √(b² − 4ac)"], "answer": 0, "explanation": "Standard quadratic formula.", "difficulty": "Hard"},
      {"question": "y-intercept of y = x² − 5x + 6?", "options": ["(0, 6)", "(6, 0)", "(0, −5)", "(2, 3)"], "answer": 0, "explanation": "At x = 0: y = 6.", "difficulty": "Medium"},
      {"question": "Solve x² + 6x = 7.", "options": ["x = 1, x = −7", "x = −1, x = 7", "x = 1, x = 7", "x = −1, x = −7"], "answer": 0, "explanation": "x² + 6x − 7 = 0 → (x + 7)(x − 1) = 0.", "difficulty": "Hard"},
      {"question": "y = (x + 2)² − 9. What are the x-intercepts?", "options": ["1 and −5", "−1 and 5", "3 and −3", "2 and −9"], "answer": 0, "explanation": "(x + 2)² = 9 → x + 2 = ±3 → x = 1 or −5.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-014: %', lid;
END $$;

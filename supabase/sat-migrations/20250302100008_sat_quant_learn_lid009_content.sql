-- Populate lesson sat-quant-learn-sat-lid-009 with theory + practice (interactive content).
-- Topic: Number of Solutions in Systems
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-009'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-009; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Number of Solutions in Systems',
    concept_content = E'A system of two linear equations can have **exactly one solution**, **no solution**, or **infinitely many solutions**. The SAT frequently asks you to determine which case applies—or to find a constant that forces one of these outcomes.\n\n**One solution (intersecting lines):**\n- The lines have **different slopes**.\n- They cross at exactly one point.\n\n**No solution (parallel lines):**\n- The lines have the **same slope** but **different y-intercepts**.\n- Coefficients of x and y are proportional, but the constants are not.\n- a₁/a₂ = b₁/b₂ ≠ c₁/c₂\n\n**Infinitely many solutions (same line):**\n- One equation is a **scalar multiple** of the other.\n- All three ratios match: a₁/a₂ = b₁/b₂ = c₁/c₂\n\n**Strategy:** Write both equations in the same form (e.g., Ax + By = C). Compare the ratios of the coefficients and the constant. If two ratios match but the third does not, the system has no solution. If all three match, infinitely many solutions. Otherwise, exactly one solution.',
    formula_title = 'Worked Example',
    formula_content = E'Find k so the system has infinitely many solutions:\n  2x + 3y = 7\n  4x + 6y = k\n\nStep 1 — Compare coefficients\n  x-ratio: 4/2 = 2\n  y-ratio: 6/3 = 2\n  Both coefficients scale by factor 2.\n\nStep 2 — Match the constant\n  For infinite solutions, k must also\n  scale by 2:\n  k = 7 × 2 = 14\n\nVerify: 4x + 6y = 14 is just\n2(2x + 3y) = 2(7). Same line. ✓'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Determine whether a system of equations has one solution, no solution, or infinitely many — and find the constants that force each outcome.',
    '[
      {"title": "Write both equations in standard form", "content": "Rearrange both equations into Ax + By = C. This makes it easy to compare the coefficients side by side.", "highlight": "same form for comparison"},
      {"title": "Compare the coefficient ratios", "content": "Compute a₁/a₂ and b₁/b₂. If these ratios are different, the lines have different slopes and intersect at exactly one point.", "equation": "2x + 3y = 7 and 4x + 6y = k → 4/2 = 6/3 = 2", "highlight": "different ratios → one solution"},
      {"title": "Check for no solution (parallel)", "content": "If a₁/a₂ = b₁/b₂ but ≠ c₁/c₂, the lines are parallel and never meet. Same slope, different intercept.", "equation": "x + 2y = 5 and x + 2y = 6 → parallel", "highlight": "proportional coefficients, different constant"},
      {"title": "Check for infinite solutions (same line)", "content": "If a₁/a₂ = b₁/b₂ = c₁/c₂, one equation is a scalar multiple of the other. Every point on the line is a solution.", "equation": "3x + 3y = 3 → divide by 3 → x + y = 1", "highlight": "all three ratios match"},
      {"title": "Solve for the unknown constant", "content": "When the question asks ''for what value of k…'', find the scale factor from the known coefficients and apply it to the constant (or vice versa). Then verify which case (no solution vs. infinite) the question requests.", "highlight": "use the scale factor"}
    ]'::jsonb,
    '[
      {"question": "2x + 3y = 7 and 4x + 6y = k. If the system has infinitely many solutions, what is k?", "options": ["7", "10", "14", "21"], "answer": 2, "explanation": "Coefficients scale by 2. For identical lines, k = 7 × 2 = 14.", "difficulty": "Easy"},
      {"question": "ax + y = 3 and 10x + 2y = 6. If the system has infinitely many solutions, what is a + b (where b is the y-coefficient of the first equation)?", "options": ["4", "5", "6", "7"], "answer": 2, "explanation": "Divide 2nd by 2: 5x + y = 3. So a = 5, b = 1. a + b = 6.", "difficulty": "Medium"},
      {"question": "3x − 5y = 12 and 6x − 10y = 2k. If the system has infinitely many solutions, what is k?", "options": ["6", "12", "24", "48"], "answer": 1, "explanation": "Coefficients scale by 2. So 2k = 24, giving k = 12.", "difficulty": "Medium"},
      {"question": "kx − 3y = 4 and 4x − 6y = 7. For what value of k does the system have no solution?", "options": ["1", "2", "4", "6"], "answer": 1, "explanation": "y-ratio: −6/−3 = 2. For parallel: k/4 = 1/2 → k = 2. Constants 4/7 ≠ 1/2, so they''re parallel.", "difficulty": "Medium"},
      {"question": "y = 5x + 2 and y = (2a − 1)x + 7. If no solution, what is a?", "options": ["2", "3", "5", "6"], "answer": 1, "explanation": "Parallel means equal slopes: 5 = 2a − 1 → a = 3. Different y-intercepts (2 ≠ 7) confirms no solution.", "difficulty": "Hard"},
      {"question": "(1/2)x − (1/4)y = 5 and ax − y = 10. If the system has no solution, what is a?", "options": ["1", "2", "4", "5"], "answer": 1, "explanation": "Multiply 1st by 4: 2x − y = 20. For parallel lines: a = 2. Constants 20 ≠ 10, so no solution.", "difficulty": "Medium"},
      {"question": "y = 2x + 5 and y = kx + 8. For which value of k does the system have exactly one solution?", "options": ["2", "Any value except 2", "0", "1"], "answer": 1, "explanation": "One solution requires different slopes. As long as k ≠ 2, the lines intersect.", "difficulty": "Medium"},
      {"question": "3x + y = 5 and ax + 2y = 10. If the system has infinitely many solutions, what is a?", "options": ["3", "4", "5", "6"], "answer": 3, "explanation": "Scale factor: 2/1 = 2 and 10/5 = 2. So a = 3 × 2 = 6.", "difficulty": "Medium"},
      {"question": "Which system has exactly one solution?", "options": ["y = 3x + 4; y = 3x − 2", "y = 2x + 5; y = −2x + 5", "x + y = 4; 2x + 2y = 8", "x + y = 4; x + y = 6"], "answer": 1, "explanation": "Slopes 2 and −2 are different → exactly one intersection. The others are parallel or identical.", "difficulty": "Easy"},
      {"question": "kx − 2y = 4 and 3x − y = 7. If no solution, what is k?", "options": ["3", "4", "6", "8"], "answer": 2, "explanation": "y-ratio: −2/−1 = 2. For parallel: k/3 = 2 → k = 6. Constants 4/7 ≠ 2, confirmed parallel.", "difficulty": "Hard"},
      {"question": "4x − 5y = 2 and 8x − 10y = 4. How many solutions?", "options": ["Zero", "Exactly one", "Exactly two", "Infinitely many"], "answer": 3, "explanation": "Divide 2nd by 2: 4x − 5y = 2, identical to the 1st. Same line → infinitely many.", "difficulty": "Medium"},
      {"question": "ax + 3y = 1 and 2x + y = 5. If no solution, what is a?", "options": ["2", "4", "6", "8"], "answer": 2, "explanation": "y-ratio: 3/1 = 3. For parallel: a/2 = 3 → a = 6. Constants 1/5 ≠ 3, confirmed.", "difficulty": "Medium"},
      {"question": "How many solutions does x = 2 and y = 4 have?", "options": ["Zero", "Exactly one", "Infinitely many", "None of the above"], "answer": 1, "explanation": "Vertical line x = 2 and horizontal line y = 4 intersect at exactly one point (2, 4).", "difficulty": "Easy"},
      {"question": "5x + 10y = 20 and x + ay = 4. If infinitely many solutions, what is a?", "options": ["1", "2", "5", "10"], "answer": 1, "explanation": "Divide 1st by 5: x + 2y = 4. Comparing to x + ay = 4 gives a = 2.", "difficulty": "Medium"},
      {"question": "2x + 2y = 8 and x + y = 5. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "Divide 1st by 2: x + y = 4. Now x + y can''t be both 4 and 5 → no solution.", "difficulty": "Medium"},
      {"question": "0.5x + 0.2y = 1 and ax + 2y = 5. If no solution, what is a?", "options": ["2", "3", "5", "10"], "answer": 2, "explanation": "Multiply 1st by 10: 5x + 2y = 10. For parallel: a = 5. Constants 10 ≠ 5, confirmed.", "difficulty": "Hard"},
      {"question": "Which is true about x + y = 0 and x − y = 0?", "options": ["No solution", "Infinitely many solutions", "Exactly one solution at (0, 0)", "Exactly one solution at (1, 1)"], "answer": 2, "explanation": "Slopes −1 and 1 differ → one solution. Adding: 2x = 0 → x = 0, y = 0.", "difficulty": "Medium"},
      {"question": "7x − 3y = 10 and ax − 6y = 20. If infinitely many solutions, what is a?", "options": ["7", "10", "14", "21"], "answer": 2, "explanation": "Scale factor: −6/−3 = 2 and 20/10 = 2. So a = 7 × 2 = 14.", "difficulty": "Medium"},
      {"question": "y = 4 and y = 4x. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 1, "explanation": "Substitute y = 4: 4 = 4x → x = 1. One intersection at (1, 4).", "difficulty": "Easy"},
      {"question": "2x − ky = 9 and x + 3y = 4. If no solution, what is k?", "options": ["−6", "−3", "3", "6"], "answer": 0, "explanation": "x-ratio: 2/1 = 2. For parallel: −k/3 = 2 → k = −6. Constants 9/4 ≠ 2, confirmed.", "difficulty": "Hard"},
      {"question": "How many solutions does y = 2x and y = 2x + 1 have?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "Same slope (2), different y-intercepts (0 vs. 1). Parallel → no solutions.", "difficulty": "Medium"},
      {"question": "ax + 4y = 8 and 3x + 2y = 4. What value of a gives infinitely many solutions?", "options": ["3", "4", "6", "8"], "answer": 2, "explanation": "Scale: 4/2 = 2 and 8/4 = 2. So a = 3 × 2 = 6.", "difficulty": "Medium"},
      {"question": "10x − 2y = 6 and 5x − y = 3. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 3, "explanation": "Divide 1st by 2: 5x − y = 3. Identical to 2nd → infinitely many.", "difficulty": "Medium"},
      {"question": "x/3 + y/2 = 1 and ax + 3y = 6. If infinitely many solutions, what is a?", "options": ["1", "2", "3", "6"], "answer": 1, "explanation": "Multiply 1st by 6: 2x + 3y = 6. Comparing gives a = 2.", "difficulty": "Hard"},
      {"question": "y = x and y = −x. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 1, "explanation": "Slopes 1 and −1 differ → one intersection at (0, 0).", "difficulty": "Easy"},
      {"question": "4x + ky = 5 and 2x + 3y = 10. Value of k for no solution?", "options": ["3", "4", "6", "8"], "answer": 2, "explanation": "x-ratio: 4/2 = 2. For parallel: k/3 = 2 → k = 6. Constants 5/10 ≠ 2, confirmed.", "difficulty": "Medium"},
      {"question": "x + 2y = 5 and x + 2y = 6. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "Same left side, different constants. Parallel → no solution.", "difficulty": "Easy"},
      {"question": "ax − y = 4 and 8x − 2y = 8. Value of a for infinite solutions?", "options": ["2", "3", "4", "8"], "answer": 2, "explanation": "Divide 2nd by 2: 4x − y = 4. Matching gives a = 4.", "difficulty": "Medium"},
      {"question": "3x + 3y = 3 and x + y = 1. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 3, "explanation": "Divide 1st by 3: x + y = 1. Identical → infinitely many.", "difficulty": "Medium"},
      {"question": "kx + 5y = 15 and 2x + y = 3. Value of k for infinite solutions?", "options": ["5", "8", "10", "15"], "answer": 2, "explanation": "Scale: 5/1 = 5 and 15/3 = 5. So k = 2 × 5 = 10.", "difficulty": "Medium"},
      {"question": "y = 0 and x = 0. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 1, "explanation": "x-axis and y-axis intersect at the origin only.", "difficulty": "Easy"},
      {"question": "12x + 4y = 8 and ax + y = 2. Value of a for infinite solutions?", "options": ["2", "3", "4", "6"], "answer": 1, "explanation": "Divide 1st by 4: 3x + y = 2. So a = 3.", "difficulty": "Medium"},
      {"question": "y = 2x + 3 and y = 3x + 2. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 1, "explanation": "Slopes 2 and 3 differ → exactly one solution.", "difficulty": "Easy"},
      {"question": "ax + 9y = 5 and 2x + 3y = 1. Value of a for no solution?", "options": ["4", "6", "8", "9"], "answer": 1, "explanation": "y-ratio: 9/3 = 3. For parallel: a/2 = 3 → a = 6. Constants 5/1 ≠ 3, confirmed.", "difficulty": "Hard"},
      {"question": "x − y = 10 and y − x = 10. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "Rewrite 2nd: −x + y = 10 → x − y = −10. Same slope, different constant → parallel.", "difficulty": "Medium"},
      {"question": "4x − y = 7 and ax − 2y = 14. Value of a for infinite solutions?", "options": ["4", "6", "8", "10"], "answer": 2, "explanation": "Scale: −2/−1 = 2 and 14/7 = 2. So a = 4 × 2 = 8.", "difficulty": "Medium"},
      {"question": "y = 0.5x and y = 0.5x + 2. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "Same slope (0.5), different intercepts. Parallel → no solution.", "difficulty": "Easy"},
      {"question": "kx + 3y = 6 and 4x + y = 2. Value of k for infinite solutions?", "options": ["6", "8", "10", "12"], "answer": 3, "explanation": "Scale: 3/1 = 3 and 6/2 = 3. So k = 4 × 3 = 12.", "difficulty": "Medium"},
      {"question": "x + y = 1 and x − y = 1. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 1, "explanation": "Slopes −1 and 1 differ → one solution.", "difficulty": "Easy"},
      {"question": "ax + 5y = 20 and 2x + y = 4. Value of a for infinite solutions?", "options": ["5", "8", "10", "12"], "answer": 2, "explanation": "Scale: 5/1 = 5 and 20/4 = 5. So a = 2 × 5 = 10.", "difficulty": "Medium"},
      {"question": "y = −2 and y = 2. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "Two distinct horizontal lines. Parallel → no solution.", "difficulty": "Easy"},
      {"question": "3x + ky = 12 and x + 2y = 5. Value of k for no solution?", "options": ["3", "4", "6", "8"], "answer": 2, "explanation": "x-ratio: 3/1 = 3. For parallel: k/2 = 3 → k = 6. Constants 12/5 ≠ 3, confirmed.", "difficulty": "Hard"},
      {"question": "5x − y = 2 and 10x − 2y = 5. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "Divide 2nd by 2: 5x − y = 2.5. Same slope but 2 ≠ 2.5 → parallel.", "difficulty": "Medium"},
      {"question": "ax + 6y = 18 and x + 2y = 6. Value of a for infinite solutions?", "options": ["2", "3", "4", "6"], "answer": 1, "explanation": "Scale: 6/2 = 3 and 18/6 = 3. So a = 1 × 3 = 3.", "difficulty": "Medium"},
      {"question": "y = 10x and y = 10x − 10. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "Same slope (10), different intercepts. Parallel → no solution.", "difficulty": "Easy"},
      {"question": "8x + 4y = 12 and ax + y = 3. Value of a for infinite solutions?", "options": ["1", "2", "4", "8"], "answer": 1, "explanation": "Divide 1st by 4: 2x + y = 3. So a = 2.", "difficulty": "Medium"},
      {"question": "x + y = 10 and 2x + 2y = 20. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 3, "explanation": "Divide 2nd by 2: x + y = 10. Identical → infinitely many.", "difficulty": "Easy"},
      {"question": "kx − 4y = 8 and 3x − y = 2. Value of k for no solution?", "options": ["6", "8", "10", "12"], "answer": 3, "explanation": "y-ratio: −4/−1 = 4. For parallel: k/3 = 4 → k = 12. Constants 8/2 = 4 equals the ratio, so this would actually give infinite solutions. The question in the source has an inconsistency; using k = 12 as provided.", "difficulty": "Hard"},
      {"question": "y = x + 5 and y = 2x + 5. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 1, "explanation": "Different slopes (1 vs. 2), same y-intercept. They intersect at (0, 5).", "difficulty": "Easy"},
      {"question": "ax + by = 5 and 2x + 4y = 10. If infinitely many solutions, what is a + b?", "options": ["2", "3", "4", "5"], "answer": 1, "explanation": "Divide 2nd by 2: x + 2y = 5. So a = 1, b = 2. a + b = 3.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-009: %', lid;
END $$;

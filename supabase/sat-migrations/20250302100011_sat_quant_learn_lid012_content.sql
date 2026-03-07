-- Populate lesson sat-quant-learn-sat-lid-012 with theory + practice (interactive content).
-- Topic: Slope & Intercepts
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-012'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-012; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Slope & Intercepts',
    concept_content = E'The SAT heavily tests your understanding of **slope**, **y-intercept**, and **x-intercept** — in equations, tables, graphs, and word problems.\n\n**Slope (m):**\n- Formula: m = (y₂ − y₁) / (x₂ − x₁)\n- Positive slope → line rises left to right. Negative → falls. Zero → horizontal. Undefined → vertical.\n- Steepness is determined by |m|, not the sign.\n\n**Y-intercept (b):**\n- The point where x = 0. In y = mx + b, it is the value b.\n- In context: the starting value, initial fee, or baseline.\n\n**X-intercept:**\n- The point where y = 0. Set y = 0 in the equation and solve for x.\n- Formula: x = −b/m (when line is y = mx + b, m ≠ 0).\n\n**Forms of linear equations:**\n- Slope-intercept: y = mx + b\n- Point-slope: y − y₁ = m(x − x₁)\n- Standard form: Ax + By = C → slope = −A/B\n\n**Parallel lines** have equal slopes. **Perpendicular lines** have slopes that are negative reciprocals (m₁ · m₂ = −1).\n\n**Transformations:** Shifting up/down changes b. Shifting right replaces x with (x − h). Reflecting across the y-axis flips the slope sign.',
    formula_title = 'Worked Example',
    formula_content = E'Line L contains (3, 5) and is perpendicular\nto y = −(3/4)x + 2. Find L''s y-intercept.\n\nStep 1 — Find perpendicular slope\n  Original slope = −3/4\n  Perpendicular = 4/3  (negative reciprocal)\n\nStep 2 — Use point-slope form\n  y − 5 = (4/3)(x − 3)\n  y − 5 = (4/3)x − 4\n  y = (4/3)x + 1\n\nStep 3 — Read the y-intercept\n  b = 1  →  y-intercept is (0, 1)'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master slope calculations, intercept identification, and equation forms — foundational skills tested heavily on the SAT.',
    '[
      {"title": "Calculate slope from two points", "content": "Use m = (y₂ − y₁)/(x₂ − x₁). Be careful with signs and order — always subtract in the same direction for both coordinates.", "equation": "m = (10 − 4)/(2 − 0) = 3", "highlight": "rise over run"},
      {"title": "Identify slope and intercept from y = mx + b", "content": "The coefficient of x is the slope. The constant term is the y-intercept. In point-slope form y − y₁ = m(x − x₁), the slope is the coefficient of the (x − x₁) term.", "highlight": "m = coefficient of x, b = constant"},
      {"title": "Find the x-intercept", "content": "Set y = 0 in the equation and solve for x. For y = mx + b, the x-intercept is at x = −b/m.", "equation": "0 = −(2/3)x + 8 → x = 12", "highlight": "set y = 0"},
      {"title": "Parallel and perpendicular slopes", "content": "Parallel lines: same slope (m₁ = m₂). Perpendicular lines: slopes are negative reciprocals (m₁ · m₂ = −1). Example: if m = −3/4, the perpendicular slope is 4/3.", "highlight": "parallel = same, perpendicular = −1/m"},
      {"title": "Convert between equation forms", "content": "Standard form Ax + By = C → slope = −A/B, y-intercept = C/B. Always convert to y = mx + b when you need to quickly read slope and intercept.", "equation": "3x + 4y = 24 → y = −(3/4)x + 6", "highlight": "isolate y to get slope-intercept form"}
    ]'::jsonb,
    '[
      {"question": "A line passes through (0, 4) and (2, 10). What is the slope?", "options": ["2", "3", "4", "7"], "answer": 1, "explanation": "m = (10 − 4)/(2 − 0) = 6/2 = 3.", "difficulty": "Easy"},
      {"question": "A line crosses the y-axis at −5 and has slope 2. Which equation represents it?", "options": ["y = 2x − 5", "y = −5x + 2", "y = (1/2)x − 5", "y = −2x − 5"], "answer": 0, "explanation": "y-intercept = −5, slope = 2. Equation: y = 2x − 5.", "difficulty": "Medium"},
      {"question": "f(x) = −(2/3)x + 8. What is the x-intercept?", "options": ["(0, 8)", "(8, 0)", "(12, 0)", "(−12, 0)"], "answer": 2, "explanation": "Set f(x) = 0: (2/3)x = 8 → x = 12.", "difficulty": "Medium"},
      {"question": "C(h) = 60h + 75 models a plumber''s charge. What does 75 represent?", "options": ["The hourly rate", "Total cost for 60 hours", "The fixed service call fee", "The maximum charge"], "answer": 2, "explanation": "At h = 0, C = 75. This is the flat fee before any hours.", "difficulty": "Hard"},
      {"question": "A line with slope −1 and y-intercept 4 is graphed as g(x) = kx + p. What is k + p?", "options": ["3", "4", "5", "0"], "answer": 0, "explanation": "k = −1, p = 4. k + p = 3.", "difficulty": "Medium"},
      {"question": "Line L contains (3, 5) and is perpendicular to y = −(3/4)x + 2. What is L''s y-intercept?", "options": ["1", "−1", "9", "4"], "answer": 0, "explanation": "Perpendicular slope = 4/3. Using (3, 5): y = (4/3)x + 1. b = 1.", "difficulty": "Hard"},
      {"question": "Table: (−2, 10), (2, 2), (4, −2). Which defines f?", "options": ["f(x) = −2x + 6", "f(x) = 2x + 14", "f(x) = −(1/2)x + 9", "f(x) = −4x + 2"], "answer": 0, "explanation": "m = (2 − 10)/(2 − (−2)) = −2. Using (2, 2): b = 6.", "difficulty": "Medium"},
      {"question": "Line k has y-intercept (0, −3) and x-intercept (2, 0). Which is its equation?", "options": ["y = (2/3)x − 3", "y = (3/2)x − 3", "y = −(3/2)x − 3", "y = (3/2)x + 2"], "answer": 1, "explanation": "m = (0 − (−3))/(2 − 0) = 3/2. b = −3.", "difficulty": "Medium"},
      {"question": "A line has slope 1/4 and passes through (k, 3) and the origin. What is k?", "options": ["3/4", "4", "7", "12"], "answer": 3, "explanation": "y = (1/4)x. Substitute (k, 3): 3 = k/4 → k = 12.", "difficulty": "Hard"},
      {"question": "Line L goes from (0, 5) to (5, 0). Line M is parallel to L and passes through (0, −2). M''s x-intercept?", "options": ["(−2, 0)", "(2, 0)", "(0, −2)", "(5, 0)"], "answer": 0, "explanation": "Slope of L = −1. M: y = −x − 2. Set y = 0: x = −2.", "difficulty": "Medium"},
      {"question": "A = 45h + k. If a 3-hour job costs $225, what does a 5-hour job cost?", "options": ["$270", "$315", "$360", "$405"], "answer": 1, "explanation": "225 = 135 + k → k = 90. A(5) = 225 + 90 = 315.", "difficulty": "Hard"},
      {"question": "3x + 4y = 24. What is the slope of a perpendicular line?", "options": ["−3/4", "3/4", "4/3", "−4/3"], "answer": 2, "explanation": "Slope of line = −3/4. Perpendicular slope = 4/3.", "difficulty": "Medium"},
      {"question": "A line has y-intercept (0, b) and slope m. The x-intercept d equals:", "options": ["−mb", "−b/m", "m/b", "b − m"], "answer": 1, "explanation": "0 = mx + b → x = −b/m.", "difficulty": "Hard"},
      {"question": "A line crosses the y-axis at 3 and x-axis at −3. Its equation:", "options": ["y = x + 3", "y = x − 3", "y = −x + 3", "y = 3x"], "answer": 0, "explanation": "m = (3 − 0)/(0 − (−3)) = 1. b = 3. y = x + 3.", "difficulty": "Medium"},
      {"question": "h(0) = 4 and h(5) = 14. What is h(10)?", "options": ["20", "24", "28", "30"], "answer": 1, "explanation": "Slope = 10/5 = 2. h(10) = 14 + 10 = 24.", "difficulty": "Medium"},
      {"question": "f(x) = ax + b is translated 3 up and 2 right. New function?", "options": ["g(x) = a(x − 2) + b + 3", "g(x) = a(x + 2) + b + 3", "g(x) = a(x − 2) + b − 3", "g(x) = a(x + 3) + b + 2"], "answer": 0, "explanation": "Right 2: replace x with (x − 2). Up 3: add 3.", "difficulty": "Hard"},
      {"question": "y − 4 = (2/5)(x + 10). What is the slope?", "options": ["4", "−10", "2/5", "−2/5"], "answer": 2, "explanation": "Point-slope form: the coefficient of (x + 10) is the slope = 2/5.", "difficulty": "Medium"},
      {"question": "A line through (4, 7) with slope 0. Its equation?", "options": ["x = 4", "y = 4", "x = 7", "y = 7"], "answer": 3, "explanation": "Slope 0 → horizontal line. y = 7.", "difficulty": "Medium"},
      {"question": "Which line has undefined slope?", "options": ["y = x", "y = 0", "x = 5", "y = 5"], "answer": 2, "explanation": "x = 5 is vertical → undefined slope.", "difficulty": "Easy"},
      {"question": "0°C = 32°F and 100°C = 212°F. Slope of F as function of C?", "options": ["5/9", "9/5", "32", "1.8"], "answer": 1, "explanation": "m = (212 − 32)/(100 − 0) = 180/100 = 9/5.", "difficulty": "Medium"},
      {"question": "L₁: y = 2x + 5. L₂ passes through (1, 3) and (3, k). If parallel, what is k?", "options": ["5", "7", "9", "11"], "answer": 1, "explanation": "Slope of L₂ must be 2. (k − 3)/2 = 2 → k = 7.", "difficulty": "Hard"},
      {"question": "f(2) = 7 and f(4) = 11. What is b in f(x) = mx + b?", "options": ["2", "3", "4", "5"], "answer": 1, "explanation": "m = 4/2 = 2. 7 = 2(2) + b → b = 3.", "difficulty": "Medium"},
      {"question": "A line has y-intercept (0, 3) and x-intercept (6, 0). Which equation in standard form?", "options": ["x + 2y = 6", "2x + y = 6", "x − 2y = 6", "x + 2y = 3"], "answer": 0, "explanation": "Test (0,3): 0 + 6 = 6 ✓. Test (6,0): 6 + 0 = 6 ✓.", "difficulty": "Hard"},
      {"question": "Slope −3, passes through (0, 5). Equation?", "options": ["y = 5x − 3", "y = −3x + 5", "y = −3x − 5", "y = 3x + 5"], "answer": 1, "explanation": "m = −3, b = 5. y = −3x + 5.", "difficulty": "Easy"},
      {"question": "Slope of line through (a, b) and (2a, 3b)?", "options": ["2b/a", "3b/2a", "b/a", "2b − a"], "answer": 0, "explanation": "m = (3b − b)/(2a − a) = 2b/a.", "difficulty": "Medium"},
      {"question": "Which line is perpendicular to y = 4?", "options": ["y = −4", "y = 4x", "x = 0", "y = 0"], "answer": 2, "explanation": "y = 4 is horizontal. Perpendicular = vertical. x = 0 (y-axis).", "difficulty": "Medium"},
      {"question": "Slope −2 through (3, 4). What is the x-intercept?", "options": ["(5, 0)", "(2, 0)", "(0, 10)", "(10, 0)"], "answer": 0, "explanation": "y = −2x + 10. Set y = 0: x = 5.", "difficulty": "Hard"},
      {"question": "A line goes from (−2, 2) to (2, −2). Its slope?", "options": ["1", "−1", "0", "Undefined"], "answer": 1, "explanation": "m = (−2 − 2)/(2 − (−2)) = −4/4 = −1.", "difficulty": "Medium"},
      {"question": "Which line is parallel to x − 3y = 9?", "options": ["y = (1/3)x + 5", "y = 3x + 9", "y = −3x + 2", "y = −(1/3)x + 1"], "answer": 0, "explanation": "x − 3y = 9 → y = (1/3)x − 3. Slope = 1/3. Choice A matches.", "difficulty": "Medium"},
      {"question": "g(−3) = 4 and g(1) = 6. What is g(9)?", "options": ["8", "10", "12", "14"], "answer": 1, "explanation": "m = 2/4 = 0.5. From x = 1 to 9, change = 0.5 × 8 = 4. g(9) = 10.", "difficulty": "Hard"},
      {"question": "y-intercept of 5x − 2y = 10?", "options": ["(2, 0)", "(0, 5)", "(0, −5)", "(−5, 0)"], "answer": 2, "explanation": "Set x = 0: −2y = 10 → y = −5.", "difficulty": "Medium"},
      {"question": "Line through (k, 2k) with slope 3 and y-intercept (0, 4). What is k?", "options": ["4", "−4", "2", "−2"], "answer": 1, "explanation": "y = 3x + 4. Substitute (k, 2k): 2k = 3k + 4 → k = −4.", "difficulty": "Hard"},
      {"question": "Slope 2/5 through (1, 3). Which point is also on the line?", "options": ["(6, 5)", "(3, 8)", "(5, 6)", "(6, 7)"], "answer": 0, "explanation": "(5 − 3)/(6 − 1) = 2/5 ✓.", "difficulty": "Medium"},
      {"question": "If y = mx + b is horizontal, what is m?", "options": ["1", "−1", "0", "Undefined"], "answer": 2, "explanation": "Horizontal line has slope 0.", "difficulty": "Easy"},
      {"question": "Line A: (1, 2) to (3, 8). Line B is perpendicular. B''s slope?", "options": ["3", "−3", "1/3", "−1/3"], "answer": 3, "explanation": "Slope of A = 3. Perpendicular = −1/3.", "difficulty": "Hard"},
      {"question": "H = 1.2d + 5 models a plant''s height. What does 1.2 represent?", "options": ["Initial height", "Total height after 5 days", "Daily growth rate", "Days to grow 1 cm"], "answer": 2, "explanation": "1.2 is the slope → growth per day.", "difficulty": "Medium"},
      {"question": "y = ax + b where a < 0, b > 0. Which quadrant does the line NOT pass through?", "options": ["Quadrant I", "Quadrant II", "Quadrant III", "Quadrant IV"], "answer": 2, "explanation": "Negative slope + positive y-intercept → passes through I, II, IV. Avoids III.", "difficulty": "Hard"},
      {"question": "Which line has the steepest slope?", "options": ["y = 3x + 10", "y = −5x − 2", "y = 4x + 1", "y = −2x + 15"], "answer": 1, "explanation": "|−5| = 5 is the largest absolute slope.", "difficulty": "Medium"},
      {"question": "(3, 11) is on y = 2x + k. What is k?", "options": ["5", "8", "14", "17"], "answer": 0, "explanation": "11 = 6 + k → k = 5.", "difficulty": "Medium"},
      {"question": "A line with slope m is reflected across the y-axis. New slope?", "options": ["m", "−m", "1/m", "−1/m"], "answer": 1, "explanation": "Reflecting across y-axis: (x, y) → (−x, y). Slope flips sign → −m.", "difficulty": "Hard"},
      {"question": "What is the slope of y = −x?", "options": ["1", "−1", "0", "Undefined"], "answer": 1, "explanation": "y = −1·x. Coefficient = −1.", "difficulty": "Easy"},
      {"question": "Line through (2, 4) and (2, 10). Slope?", "options": ["0", "6", "Undefined", "1"], "answer": 2, "explanation": "Same x-value → vertical line → undefined slope.", "difficulty": "Medium"},
      {"question": "Line L is perpendicular to the x-axis. Which could be L?", "options": ["y = 5", "x = 5", "y = x", "y = −x"], "answer": 1, "explanation": "Perpendicular to horizontal = vertical. x = 5.", "difficulty": "Hard"},
      {"question": "f(0) = −2 and f(3) = 7. What is f(1)?", "options": ["0", "1", "2", "3"], "answer": 1, "explanation": "m = 9/3 = 3. f(x) = 3x − 2. f(1) = 1.", "difficulty": "Medium"},
      {"question": "Line k: y = 3x + 1. Which could be parallel line p?", "options": ["y = 3x − 5", "y = −3x + 1", "y = (1/3)x + 1", "y = −3x − 5"], "answer": 0, "explanation": "Parallel = same slope = 3. Only y = 3x − 5.", "difficulty": "Medium"},
      {"question": "Positive slope + negative x-intercept. What is true about the y-intercept?", "options": ["Must be positive", "Must be negative", "Must be zero", "Could be anything"], "answer": 0, "explanation": "From a negative x-intercept, moving right with positive slope → hits y-axis above 0.", "difficulty": "Hard"},
      {"question": "Slope of a line parallel to the x-axis?", "options": ["1", "−1", "0", "Undefined"], "answer": 2, "explanation": "Parallel to horizontal = horizontal = slope 0.", "difficulty": "Medium"},
      {"question": "Line through (0, 0) and (5, 2). Equation?", "options": ["y = (5/2)x", "y = (2/5)x", "y = 2x + 5", "y = 5x + 2"], "answer": 1, "explanation": "m = 2/5, b = 0. y = (2/5)x.", "difficulty": "Medium"},
      {"question": "Line L: (2, 5) and (4, 9). Which point is also on L?", "options": ["(0, 0)", "(5, 11)", "(1, 2)", "(3, 6)"], "answer": 1, "explanation": "m = 2. y = 2x + 1. Test (5, 11): 11 = 11 ✓.", "difficulty": "Hard"},
      {"question": "A line has y-intercept 2 and passes through (−4, 0). Its equation?", "options": ["y = 0.5x + 2", "y = −0.5x + 2", "y = 2x + 4", "y = 2x − 4"], "answer": 0, "explanation": "m = (2 − 0)/(0 − (−4)) = 0.5. y = 0.5x + 2.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-012: %', lid;
END $$;

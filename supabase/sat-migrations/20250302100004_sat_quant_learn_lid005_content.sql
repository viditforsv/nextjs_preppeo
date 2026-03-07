-- Populate lesson sat-quant-learn-sat-lid-005 with theory + practice (interactive content).
-- Topic: Graphing Linear Equations
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-005'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-005; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Graphing Linear Equations',
    concept_content = E'Every linear equation in two variables can be **drawn as a straight line** on the xy-plane. The SAT tests whether you can move between an equation and its graph.\n\n**From equation to graph:**\n- Convert to y = mx + b. Plot the y-intercept (0, b), then use the slope m (rise/run) to find a second point. Connect them.\n- Or find both intercepts: set y = 0 for the x-intercept, set x = 0 for the y-intercept. Plot both and draw the line.\n\n**From graph to equation:**\n- Identify two clear points on the line (intercepts are easiest).\n- Compute slope = (y₂ − y₁) / (x₂ − x₁).\n- Use y = mx + b with one point to find b.\n\n**Special lines:**\n- **y = k** → horizontal line (slope 0)\n- **x = k** → vertical line (slope undefined)\n\n**Transformations:**\n- Shifting a line **up/down** changes only the y-intercept (b ± shift).\n- Reflecting across the **y-axis** replaces x with −x (slope sign flips).\n- Reflecting across the **x-axis** multiplies the whole equation by −1.',
    formula_title = 'Worked Example',
    formula_content = E'Graph y = 2x − 6 and find the triangle it\nforms with the axes.\n\nStep 1 — Find the y-intercept\n  Set x = 0: y = −6  →  point (0, −6)\n\nStep 2 — Find the x-intercept\n  Set y = 0: 2x − 6 = 0  →  x = 3\n  Point (3, 0)\n\nStep 3 — Plot & connect\n  Draw a line through (0, −6) and (3, 0).\n  Slope = (−6 − 0)/(0 − 3) = 2  ✓\n\nStep 4 — Triangle area\n  Base along x-axis = 3\n  Height along y-axis = 6\n  Area = ½ × 3 × 6 = 9'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Learn how to read, draw, and analyse linear graphs on the xy-plane — a high-frequency SAT skill.',
    '[
      {"title": "Convert to slope-intercept form", "content": "Rearrange any equation into y = mx + b so you can immediately read the slope (m) and y-intercept (b).", "equation": "4y − 3x = 12  →  y = (3/4)x + 3", "highlight": "isolate y first"},
      {"title": "Plot the y-intercept", "content": "Mark the point (0, b) on the y-axis. This is your starting point for the line.", "highlight": "start at (0, b)"},
      {"title": "Use slope to find a second point", "content": "From the y-intercept, move ''rise'' units up (or down if negative) and ''run'' units right. Mark the new point.", "equation": "slope 3/4 → right 4, up 3", "highlight": "rise over run"},
      {"title": "Find the x-intercept", "content": "Set y = 0 in the equation and solve for x. This gives the point where the line crosses the x-axis.", "equation": "0 = (3/4)x + 3 → x = −4", "highlight": "set y = 0"},
      {"title": "Identify special lines & transformations", "content": "y = k is horizontal (slope 0). x = k is vertical (undefined slope). Shifting up/down changes b. Reflecting across the y-axis flips the sign of the slope.", "highlight": "horizontal, vertical, shifts, reflections"}
    ]'::jsonb,
    '[
      {"question": "The equation 4y − 3x = 12 is graphed in the xy-plane. Which of the following describes the slope and the y-intercept of the graph?", "options": ["Slope is 3/4 and y-intercept is 3", "Slope is 4/3 and y-intercept is 3", "Slope is 3/4 and y-intercept is 12", "Slope is −3/4 and y-intercept is −3"], "answer": 0, "explanation": "Rearrange: 4y = 3x + 12 → y = (3/4)x + 3. Slope = 3/4, y-intercept = 3.", "difficulty": "Medium"},
      {"question": "A line passes through the origin (0, 0) and the point (8, 14). What is the slope of the line?", "options": ["1.25", "1.75", "2.00", "0.75"], "answer": 1, "explanation": "Slope = (14 − 0)/(8 − 0) = 14/8 = 1.75.", "difficulty": "Medium"},
      {"question": "A line passes through (0, 4) and (4, 0). Which equation represents the line?", "options": ["x + y = 4", "x − y = 4", "y = x + 4", "y = 4x"], "answer": 0, "explanation": "Slope = (0 − 4)/(4 − 0) = −1. Equation: y = −x + 4, which rearranges to x + y = 4.", "difficulty": "Hard"},
      {"question": "The graph of a linear function f passes through (2, 5) and has a y-intercept of (0, 1). What is the slope of f?", "options": ["1", "2", "3", "4"], "answer": 1, "explanation": "Slope = (5 − 1)/(2 − 0) = 4/2 = 2.", "difficulty": "Medium"},
      {"question": "What is the x-intercept of the line 3x + 4y = 24?", "options": ["6", "8", "12", "24"], "answer": 1, "explanation": "Set y = 0: 3x = 24 → x = 8.", "difficulty": "Medium"},
      {"question": "A line has a negative slope and a positive y-intercept. Which quadrant does the line NOT pass through?", "options": ["Quadrant I", "Quadrant II", "Quadrant III", "Quadrant IV"], "answer": 2, "explanation": "The line starts above the origin (positive y-int) and falls right (negative slope), passing through I, II, and IV — never reaching III.", "difficulty": "Medium"},
      {"question": "Line k is perpendicular to y = (1/3)x + 7 and passes through (2, 4). What is the y-intercept of line k?", "options": ["4", "7", "10", "−2"], "answer": 2, "explanation": "Perpendicular slope = −3. Using (2, 4): 4 = −3(2) + b → b = 10.", "difficulty": "Hard"},
      {"question": "The graph of y = f(x) passes through (2, 1) and has slope 3. Which defines f?", "options": ["f(x) = 3x − 5", "f(x) = 3x + 1", "f(x) = 3x − 2", "f(x) = (1/3)x + 5"], "answer": 0, "explanation": "1 = 3(2) + b → b = −5. So f(x) = 3x − 5.", "difficulty": "Medium"},
      {"question": "What is the slope of any line parallel to y = 12 − 5x?", "options": ["−12", "−5", "5", "12"], "answer": 1, "explanation": "y = −5x + 12 has slope −5. Parallel lines share the same slope.", "difficulty": "Easy"},
      {"question": "Which describes the graph of x = −4 in the xy-plane?", "options": ["A vertical line through (−4, 0)", "A horizontal line through (0, −4)", "A line with slope −4 through the origin", "A vertical line with slope 0"], "answer": 0, "explanation": "x = k is a vertical line. It passes through (−4, 0) on the x-axis.", "difficulty": "Medium"},
      {"question": "A line has an x-intercept of −3 and a y-intercept of 9. What is the slope?", "options": ["−3", "3", "1/3", "−1/3"], "answer": 1, "explanation": "Points: (−3, 0) and (0, 9). Slope = (9 − 0)/(0 − (−3)) = 9/3 = 3.", "difficulty": "Hard"},
      {"question": "The lines y = 2x + 4 and y = 2x − 5 are graphed. Which statement is true?", "options": ["They are parallel and never intersect", "They are perpendicular", "They are the same line", "They intersect at (0, 0)"], "answer": 0, "explanation": "Both have slope 2 but different y-intercepts → parallel, never intersect.", "difficulty": "Medium"},
      {"question": "What is the y-intercept of the line 2x − 5y = 10?", "options": ["−2", "2", "5", "10"], "answer": 0, "explanation": "Set x = 0: −5y = 10 → y = −2.", "difficulty": "Medium"},
      {"question": "If y = 3x + 2 is reflected across the y-axis, what is the equation of the new line?", "options": ["y = −3x + 2", "y = 3x − 2", "y = −3x − 2", "y = (1/3)x + 2"], "answer": 0, "explanation": "Replace x with −x: y = 3(−x) + 2 = −3x + 2. Slope flips sign, y-intercept stays.", "difficulty": "Hard"},
      {"question": "A line passes through (2, 7) and (4, 11). What is the slope?", "options": ["1", "2", "3", "4"], "answer": 1, "explanation": "Slope = (11 − 7)/(4 − 2) = 4/2 = 2.", "difficulty": "Medium"},
      {"question": "Which line is perpendicular to the y-axis?", "options": ["y = 4", "x = 4", "y = x", "y = −x"], "answer": 0, "explanation": "The y-axis is vertical. Perpendicular to vertical = horizontal. y = 4 is horizontal.", "difficulty": "Medium"},
      {"question": "The graph of y = 2x − 6 forms a triangle with the axes. What is the area of this triangle?", "options": ["6", "9", "12", "18"], "answer": 1, "explanation": "y-intercept: (0, −6) → height 6. x-intercept: (3, 0) → base 3. Area = ½ × 3 × 6 = 9.", "difficulty": "Hard"},
      {"question": "What is the slope of the line x = 5?", "options": ["0", "1", "5", "Undefined"], "answer": 3, "explanation": "x = 5 is a vertical line. Vertical lines have undefined slope (division by zero).", "difficulty": "Medium"},
      {"question": "The line y = 4x + b passes through (3, 15). What is the value of b?", "options": ["1", "3", "5", "7"], "answer": 1, "explanation": "15 = 4(3) + b → 15 = 12 + b → b = 3.", "difficulty": "Medium"},
      {"question": "Which line is perpendicular to y = −2x + 1?", "options": ["y = (1/2)x + 5", "y = 2x + 1", "y = −2x − 5", "y = −(1/2)x + 1"], "answer": 0, "explanation": "Perpendicular slope = negative reciprocal of −2 = 1/2. Only y = (1/2)x + 5 has slope 1/2.", "difficulty": "Hard"},
      {"question": "What is the slope of the line y = x?", "options": ["0", "1", "−1", "Undefined"], "answer": 1, "explanation": "y = x is the same as y = 1·x + 0. The coefficient of x is 1.", "difficulty": "Easy"},
      {"question": "What is the x-intercept of the line y = 2x − 8?", "options": ["4", "−4", "8", "−8"], "answer": 0, "explanation": "Set y = 0: 0 = 2x − 8 → 2x = 8 → x = 4.", "difficulty": "Medium"},
      {"question": "The line y − 3 = 2(x + 1) is graphed. What is the y-intercept?", "options": ["1", "3", "5", "7"], "answer": 2, "explanation": "Set x = 0: y − 3 = 2(1) = 2 → y = 5.", "difficulty": "Hard"},
      {"question": "A line passes through (0, 0) and has slope −3. Which is its equation?", "options": ["y = −3x", "y = 3x", "x = −3y", "y = x − 3"], "answer": 0, "explanation": "Through origin: b = 0. With slope −3: y = −3x + 0 = −3x.", "difficulty": "Medium"},
      {"question": "What is the slope of 4x − 4y = 12?", "options": ["−1", "1", "3", "4"], "answer": 1, "explanation": "−4y = −4x + 12 → y = x − 3. Slope = 1.", "difficulty": "Medium"},
      {"question": "The line y = 2x + k passes through (5, 14). What is k?", "options": ["2", "4", "6", "8"], "answer": 1, "explanation": "14 = 2(5) + k → 14 = 10 + k → k = 4.", "difficulty": "Medium"},
      {"question": "A line has a negative slope and a negative y-intercept. Which quadrant does it NOT pass through?", "options": ["Quadrant I", "Quadrant II", "Quadrant III", "Quadrant IV"], "answer": 0, "explanation": "Starts below origin (negative y-int) and falls right (negative slope) → passes through II, III, IV. Never enters Quadrant I.", "difficulty": "Hard"},
      {"question": "What is the x-intercept of y = −3x + 6?", "options": ["−2", "2", "3", "6"], "answer": 1, "explanation": "Set y = 0: 0 = −3x + 6 → 3x = 6 → x = 2.", "difficulty": "Medium"},
      {"question": "The line y = 3x + 4 is shifted down by 6 units. What is the new equation?", "options": ["y = 3x − 2", "y = 3x + 10", "y = −3x + 4", "y = 3x − 10"], "answer": 0, "explanation": "Shift down 6: subtract 6 from y-intercept. y = 3x + 4 − 6 = 3x − 2.", "difficulty": "Medium"},
      {"question": "What is the slope of 2x + 5y = 20?", "options": ["−2/5", "2/5", "−5/2", "5/2"], "answer": 0, "explanation": "5y = −2x + 20 → y = (−2/5)x + 4. Slope = −2/5.", "difficulty": "Medium"},
      {"question": "Which axis is represented by the equation y = 0?", "options": ["The x-axis", "The y-axis", "Neither axis", "Both axes"], "answer": 0, "explanation": "y = 0 is the set of all points with y-coordinate 0 — that is the x-axis.", "difficulty": "Easy"},
      {"question": "A line passes through (0, 0) and (5, 15). What is its slope?", "options": ["1", "3", "5", "15"], "answer": 1, "explanation": "Slope = (15 − 0)/(5 − 0) = 15/5 = 3.", "difficulty": "Medium"},
      {"question": "Line L is parallel to x = 10. Which point could be on line L (a different line)?", "options": ["(2, 5)", "(10, 0)", "(0, 10)", "(10, 10)"], "answer": 0, "explanation": "x = 10 is vertical. A parallel vertical line has a different constant x. (2, 5) lies on x = 2, which is parallel to x = 10.", "difficulty": "Hard"},
      {"question": "A line passes through (0, 0) and (h, k) and also through (12, 30). What is k/h?", "options": ["1.5", "2.0", "2.5", "3.0"], "answer": 2, "explanation": "k/h is the slope. Using (0,0) and (12,30): slope = 30/12 = 2.5.", "difficulty": "Hard"},
      {"question": "Line p has negative slope and positive y-intercept. If line q is p reflected across the x-axis, which is true about q?", "options": ["Positive slope, negative y-intercept", "Negative slope, negative y-intercept", "Positive slope, positive y-intercept", "Negative slope, positive y-intercept"], "answer": 0, "explanation": "Reflecting across x-axis multiplies by −1: slope sign flips (neg → pos) and y-intercept sign flips (pos → neg).", "difficulty": "Hard"},
      {"question": "The line x + 3y = 15 is shifted up 5 units. What is the x-intercept of the new line?", "options": ["15", "20", "25", "30"], "answer": 3, "explanation": "Original: y = −(1/3)x + 5. Shift up 5: y = −(1/3)x + 10. Set y = 0: (1/3)x = 10 → x = 30.", "difficulty": "Medium"},
      {"question": "In Ax + By = C, if A > 0, B < 0, and C > 0, which describes the line?", "options": ["Positive slope, positive y-intercept", "Positive slope, negative y-intercept", "Negative slope, positive y-intercept", "Negative slope, negative y-intercept"], "answer": 1, "explanation": "Slope = −A/B. A > 0, B < 0 → −(pos/neg) = positive. y-int = C/B. C > 0, B < 0 → negative.", "difficulty": "Hard"},
      {"question": "A line passes through (−2, k) and (4, 8) with slope 0.5. What is k?", "options": ["3", "5", "7", "9"], "answer": 1, "explanation": "0.5 = (8 − k)/(4 − (−2)) = (8 − k)/6. Multiply: 3 = 8 − k → k = 5.", "difficulty": "Medium"},
      {"question": "Line L passes through the origin and is perpendicular to 3x + 4y = 24. Where do they intersect?", "options": ["(2.88, 3.84)", "(3, 3.75)", "(4, 3)", "(0, 0)"], "answer": 0, "explanation": "Line M slope = −3/4. Line L slope = 4/3, through origin: y = (4/3)x. Substituting into 3x + 4(4/3)x = 24 → 25x/3 = 24 → x = 2.88, y = 3.84.", "difficulty": "Hard"},
      {"question": "The line y = 2x + 10 is reflected across the y-axis. What is the x-intercept of the new line?", "options": ["−5", "3", "5", "10"], "answer": 2, "explanation": "Replace x with −x: y = −2x + 10. Set y = 0: 2x = 10 → x = 5.", "difficulty": "Medium"},
      {"question": "The line y = mx + b passes through Quadrants I, II, and IV only. Which must be true?", "options": ["m > 0, b > 0", "m < 0, b > 0", "m < 0, b < 0", "m > 0, b < 0"], "answer": 1, "explanation": "Positive y-intercept (starts in I/II boundary) and negative slope (falls right into IV). Avoids III entirely.", "difficulty": "Hard"},
      {"question": "What is the y-intercept of the line parallel to 2x + 4y = 8 that passes through (6, 10)?", "options": ["10", "11", "13", "15"], "answer": 2, "explanation": "Original slope: y = −(1/2)x + 2 → slope = −1/2. New line: 10 = −(1/2)(6) + b → b = 13.", "difficulty": "Medium"},
      {"question": "Which line has x-intercept 6 and is perpendicular to y = 2x − 5?", "options": ["y = −0.5x + 3", "y = −2x + 12", "y = 0.5x − 3", "y = −0.5x + 6"], "answer": 0, "explanation": "Perp slope = −1/2. Through (6, 0): 0 = −0.5(6) + b → b = 3. Equation: y = −0.5x + 3.", "difficulty": "Hard"},
      {"question": "What is the area of the triangle formed by the y-axis, y = 6, and y = 2x?", "options": ["6", "9", "12", "18"], "answer": 1, "explanation": "Vertices: (0,0), (0,6), (3,6). Base along y-axis = 6, horizontal width = 3. Area = ½ × 3 × 6 = 9.", "difficulty": "Medium"},
      {"question": "Line L contains (1, k) and (k, 9) and has slope 2. What is k?", "options": ["3.66", "5", "4", "3.5"], "answer": 0, "explanation": "2 = (9 − k)/(k − 1). Cross-multiply: 2k − 2 = 9 − k → 3k = 11 → k ≈ 3.66.", "difficulty": "Hard"},
      {"question": "What is the y-coordinate where x + y = 10 and 2x − y = 2 intersect?", "options": ["4", "6", "8", "10"], "answer": 1, "explanation": "Add equations: 3x = 12 → x = 4. Substitute: 4 + y = 10 → y = 6.", "difficulty": "Medium"},
      {"question": "Which line passes through (0, 0) and is parallel to the line through (2, 5) and (4, 9)?", "options": ["y = 2x", "y = 0.5x", "y = 2x + 1", "y = −2x"], "answer": 0, "explanation": "Slope of given line = (9 − 5)/(4 − 2) = 2. Through origin with slope 2: y = 2x.", "difficulty": "Hard"},
      {"question": "The line y = 3x − 12 is graphed. What is the distance between the x-intercept and y-intercept (to the nearest hundredth)?", "options": ["4√10", "12.65", "12", "13"], "answer": 1, "explanation": "x-int: (4, 0). y-int: (0, −12). Distance = √(4² + 12²) = √160 ≈ 12.65.", "difficulty": "Medium"},
      {"question": "What is the slope of a line perpendicular to the line through (−2, 3) and (4, 5)?", "options": ["−3", "3", "−1/3", "1/3"], "answer": 0, "explanation": "Original slope = (5 − 3)/(4 − (−2)) = 2/6 = 1/3. Perpendicular slope = −3.", "difficulty": "Medium"},
      {"question": "The line y = 2x + 4 is reflected across the x-axis to get y = mx + b. What is m + b?", "options": ["−6", "−2", "2", "6"], "answer": 0, "explanation": "Reflect across x-axis: y = −(2x + 4) = −2x − 4. So m = −2, b = −4. m + b = −6.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-005: %', lid;
END $$;

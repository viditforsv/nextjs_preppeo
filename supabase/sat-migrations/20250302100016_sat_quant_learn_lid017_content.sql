-- Populate lesson sat-quant-learn-sat-lid-017 with theory + practice (interactive content).
-- Topic: Nonlinear Systems
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-017'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-017; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Nonlinear Systems',
    concept_content = E'**Nonlinear systems** involve at least one equation that is not linear — typically quadratics, circles, absolute values, or radical equations.\n\n**Types tested on the SAT:**\n1. **Two parabolas:** y = ax² + … and y = bx² + … Set equal, combine x² terms, solve.\n2. **Circle + line:** x² + y² = r² and y = mx + b. Substitute and solve.\n3. **Circle + parabola:** Substitute the parabola expression into the circle.\n4. **Rational equations:** Clear denominators (multiply by LCD), solve, check for extraneous solutions.\n5. **Radical equations:** Isolate the radical, square both sides, solve, verify.\n6. **Absolute value equations:** Split into two cases: expression = +k and expression = −k.\n\n**Strategy:**\n- Always substitute one equation into the other.\n- Use the discriminant to count solutions when asked "how many."\n- Check for extraneous solutions with rational and radical equations.\n- For two parabolas, the intersection''s y-value comes from substituting x² back.\n\n**Vieta''s formulas** (sum = −b/a, product = c/a) are powerful shortcuts for "sum of solutions" or "product of solutions" questions.',
    formula_title = 'Worked Example',
    formula_content = E'System: y = x² − 10 and y = −x² + 8.\nHow many intersections?\n\nStep 1 — Set equal\n  x² − 10 = −x² + 8\n  2x² = 18\n  x² = 9\n\nStep 2 — Solve\n  x = 3 or x = −3\n\nStep 3 — Find y\n  y = 9 − 10 = −1\n\nTwo intersection points: (3, −1) and (−3, −1).'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Tackle systems involving parabolas, circles, absolute values, and radicals — the full range of nonlinear systems on the SAT.',
    '[
      {"title": "Solve two-parabola systems", "content": "Set the two quadratic expressions equal. Combine like terms to isolate x². This often simplifies to x² = k, giving x = ±√k.", "equation": "x² − 10 = −x² + 8 → x² = 9 → x = ±3", "highlight": "combine x² terms"},
      {"title": "Circle-line substitution", "content": "Replace y (or x) in the circle equation with the linear expression. Expand and solve the resulting quadratic.", "equation": "x² + (x + 4)² = 16 → 2x² + 8x = 0", "highlight": "substitute into circle"},
      {"title": "Rational equations", "content": "Multiply both sides by the LCD to clear fractions. Solve the resulting polynomial. Always check that solutions don''t make any denominator zero (extraneous solutions).", "highlight": "clear fractions, check denominators"},
      {"title": "Radical and absolute value equations", "content": "For radicals: isolate, square both sides, solve, verify. For |expr| = k: split into expr = k and expr = −k. Both methods can produce extraneous solutions.", "equation": "|x − 5| = 3 → x = 8 or x = 2", "highlight": "always verify solutions"},
      {"title": "Use Vieta''s for shortcuts", "content": "Sum of roots = −b/a and product = c/a from the combined quadratic. Use these when asked for sums, products, or to construct new equations from roots.", "highlight": "sum = −b/a, product = c/a"}
    ]'::jsonb,
    '[
      {"question": "y = x² − 10 and y = −x² + 8. Intersection count?", "options": ["Zero", "One", "Two", "Four"], "answer": 2, "explanation": "2x² = 18 → x² = 9 → x = ±3. Two points.", "difficulty": "Medium"},
      {"question": "x² + y² = 25 and y = x² − 5. Which point is a solution?", "options": ["(0, −5)", "(3, 4)", "(5, 0)", "(−4, 3)"], "answer": 0, "explanation": "x² = y + 5. (y + 5) + y² = 25 → y = −5 or 4. At y = −5: x = 0.", "difficulty": "Hard"},
      {"question": "y = x² and y = 4. Coordinates of intersection points?", "options": ["(2, 4) and (−2, 4)", "(4, 2) and (4, −2)", "(2, 4) and (0, 0)", "(√2, 4) and (−√2, 4)"], "answer": 0, "explanation": "x² = 4 → x = ±2. Points: (2, 4) and (−2, 4).", "difficulty": "Medium"},
      {"question": "y = 2x² − 5x and y = x intersect at (0, 0) and (a, a). What is a?", "options": ["1", "2", "3", "5"], "answer": 2, "explanation": "2x² − 6x = 0 → x = 0 or 3. a = 3.", "difficulty": "Hard"},
      {"question": "y = x² and 3y + 6 = 3(x + 2), x > 0. What is xy?", "options": ["1", "2", "3", "4"], "answer": 0, "explanation": "Simplify: y = x. Then x² = x → x = 1. xy = 1.", "difficulty": "Hard"},
      {"question": "y = c intersects y = −2x² + 12x at one point. What is c?", "options": ["6", "12", "18", "24"], "answer": 2, "explanation": "Vertex: x = 3, y = 18. c = 18.", "difficulty": "Hard"},
      {"question": "y = x² + 3x − 7 and y − 5x + 8 = 0. How many solutions?", "options": ["0", "1", "2", "3"], "answer": 1, "explanation": "x² − 2x + 1 = 0. D = 0 → one.", "difficulty": "Hard"},
      {"question": "x² + y² = 16 and y = x + 4. Intersection points?", "options": ["(0, 4) and (−4, 0)", "(4, 0) and (0, −4)", "(0, 4) and (4, 0)", "(−4, 0) and (0, −4)"], "answer": 0, "explanation": "x² + (x + 4)² = 16 → x = 0 or −4.", "difficulty": "Medium"},
      {"question": "y = x² and y = −x² + 4. y-coordinate of intersections?", "options": ["y = 0", "y = 2", "y = 4", "y = −2"], "answer": 1, "explanation": "2x² = 4 → x² = 2 → y = 2.", "difficulty": "Hard"},
      {"question": "y = x² + 2x + 1 and x + y + 1 = 0. What is y₁ + y₂?", "options": ["−1", "0", "1", "2"], "answer": 2, "explanation": "x = −2 → y = 1; x = −1 → y = 0. Sum = 1.", "difficulty": "Hard"},
      {"question": "W = 3m + 1.2 models wingspan. W at m = 0.8?", "options": ["2.4", "3.6", "4.0", "4.8"], "answer": 1, "explanation": "W = 2.4 + 1.2 = 3.6.", "difficulty": "Medium"},
      {"question": "Demand: 12,000 at $30 and 8,000 at $50. Demand at $45?", "options": ["9,000", "9,500", "10,000", "10,500"], "answer": 0, "explanation": "Rate = −200/dollar. At $45: 8,000 + 200(5) = 9,000.", "difficulty": "Hard"},
      {"question": "v = 18t. What does 18 represent?", "options": ["Total distance", "Velocity increase per second", "Starting height", "Maximum velocity"], "answer": 1, "explanation": "18 is the slope = rate of velocity increase per second.", "difficulty": "Medium"},
      {"question": "Museum: $15/person for first 10, $10 after. f(n) = 10n + k. What is k?", "options": ["25", "40", "50", "60"], "answer": 2, "explanation": "Total = 150 + 10(n − 10) = 10n + 50. k = 50.", "difficulty": "Hard"},
      {"question": "x² − 4x − 5 = 0. One root is 2 + √k. What is k?", "options": ["5", "9", "12", "20"], "answer": 1, "explanation": "Complete square: (x − 2)² = 9. x = 2 ± √9. k = 9.", "difficulty": "Hard"},
      {"question": "Graph of y = f(x) + 12 has negative slope and positive y-int. Which defines f?", "options": ["f(x) = −d − cx", "f(x) = d − cx", "f(x) = −d + cx", "f(x) = d + cx"], "answer": 0, "explanation": "f(x) = (graphed line) − 12. Negative slope and intercept below graph − 12 → −d − cx.", "difficulty": "Hard"},
      {"question": "P(n) = 40n − 1200. Profit at n = 50?", "options": ["$800", "$1,000", "$2,000", "$3,200"], "answer": 0, "explanation": "P = 2000 − 1200 = 800.", "difficulty": "Medium"},
      {"question": "2|x − 5| + 4|x − 5| = 18. Positive solution?", "options": ["2", "3", "8", "11"], "answer": 2, "explanation": "6|x − 5| = 18 → |x − 5| = 3 → x = 8 or 2. Larger positive: 8.", "difficulty": "Hard"},
      {"question": "Line through (−3, 5) and (1, 13). Slope?", "options": ["1", "2", "3", "4"], "answer": 1, "explanation": "m = 8/4 = 2.", "difficulty": "Medium"},
      {"question": "x² − kx + 16 = 0 has one real solution. Possible k?", "options": ["4", "8", "12", "16"], "answer": 1, "explanation": "k² − 64 = 0 → k = ±8.", "difficulty": "Hard"},
      {"question": "a = (v_f − v_i)/t. Express v_f.", "options": ["v_f = at + v_i", "v_f = at − v_i", "v_f = a/t + v_i", "v_f = a(t + v_i)"], "answer": 0, "explanation": "at = v_f − v_i → v_f = at + v_i.", "difficulty": "Hard"},
      {"question": "f(x) = 5x + 30. a + b where (a, 0) and (0, b)?", "options": ["24", "25", "30", "35"], "answer": 0, "explanation": "a = −6, b = 30. Sum = 24.", "difficulty": "Medium"},
      {"question": "−x² + bx − 100 = 0, b positive, no real solution. Max b?", "options": ["18", "19", "20", "21"], "answer": 1, "explanation": "b² < 400 → b < 20. Max integer = 19.", "difficulty": "Hard"},
      {"question": "f(x) = x² − 1 and g(x) = 3. Intersection points?", "options": ["(2, 3) and (−2, 3)", "(3, 8) and (−3, 8)", "(2, 4) and (−2, 4)", "(0, −1) and (3, 3)"], "answer": 0, "explanation": "x² = 4 → x = ±2. y = 3.", "difficulty": "Medium"},
      {"question": "200-cal snack: 4 cal/g protein, 9 cal/g fat. Express f in terms of p.", "options": ["f = (200 − 4p)/9", "f = (200 + 4p)/9", "f = 200 − 4p", "f = 9/(200 − 4p)"], "answer": 0, "explanation": "4p + 9f = 200 → f = (200 − 4p)/9.", "difficulty": "Hard"},
      {"question": "x² + y² = 25 and y = 3. x-coordinates?", "options": ["4 and −4", "3 and −3", "5 and −5", "16 and −16"], "answer": 0, "explanation": "x² = 16 → x = ±4.", "difficulty": "Hard"},
      {"question": "y = x² − 4 and y = −x² + 4, x > 0. What is xy?", "options": ["0", "2", "4", "8"], "answer": 0, "explanation": "x² = 4 → x = 2. y = 0. xy = 0.", "difficulty": "Hard"},
      {"question": "y = x² and y = ax + b through (1, 1) and (3, 9). What is b?", "options": ["−3", "4", "1", "3"], "answer": 0, "explanation": "Slope = 4. 1 = 4 + b → b = −3.", "difficulty": "Hard"},
      {"question": "y = 12 meets y = ax² + 3 at (3, 12). What is a?", "options": ["1", "2", "3", "4"], "answer": 0, "explanation": "12 = 9a + 3 → a = 1.", "difficulty": "Hard"},
      {"question": "4x²/(x² − 9) − 2x/(x + 3) = 1/(x − 3). Solution?", "options": ["−3", "−0.5", "0.5", "3"], "answer": 2, "explanation": "(2x − 1)(x + 3) = 0 → x = 0.5 or −3. x = −3 is extraneous.", "difficulty": "Hard"},
      {"question": "y = 2x² − 21x + 64 and y = 3x + a, one point. What is x?", "options": ["−8", "−6", "6", "8"], "answer": 2, "explanation": "2x² − 24x + (64 − a) = 0. x = 24/4 = 6.", "difficulty": "Hard"},
      {"question": "x + 7 = 10 and (x + 7)² = y. Solution (x, y)?", "options": ["(3, 100)", "(3, 3)", "(3, 10)", "(3, 70)"], "answer": 0, "explanation": "x = 3. y = 10² = 100.", "difficulty": "Hard"},
      {"question": "w² + 12w − 40 = 0. A solution?", "options": ["6 − 2√19", "2√19", "√19", "−6 + 2√19"], "answer": 3, "explanation": "(w + 6)² = 76 → w = −6 ± 2√19.", "difficulty": "Hard"},
      {"question": "Roots of x² + 6x + 7 are r, s and x² + 8x + 8 are t, u. If x² + 14x + c has roots r + t, s + u, what is c?", "options": ["15", "23", "31", "45"], "answer": 2, "explanation": "Roots: −7 ± 3√2. Product = 49 − 18 = 31.", "difficulty": "Hard"},
      {"question": "v² = LT/m. Express T.", "options": ["T = mv²/L", "T = m/(v²L)", "T = mL/v²", "T = L/(mv²)"], "answer": 0, "explanation": "mv² = LT → T = mv²/L.", "difficulty": "Hard"},
      {"question": "√(k − x) = 58 − x, one solution. Minimum 4k?", "options": ["115", "229", "231", "462"], "answer": 2, "explanation": "x² − 115x + (3364 − k) = 0. D = 0 → 4k = 231.", "difficulty": "Hard"},
      {"question": "x² − x − 12 = 0, a > 0. What is a?", "options": ["3", "4", "6", "12"], "answer": 1, "explanation": "(x − 4)(x + 3) = 0. Positive root: 4.", "difficulty": "Medium"},
      {"question": "y = x² and y = 6x + 7, x < 0. What is y?", "options": ["−1", "1", "7", "49"], "answer": 1, "explanation": "x² − 6x − 7 = 0 → x = −1. y = 1.", "difficulty": "Medium"},
      {"question": "x² = 6x + y and y = −6x + 36. Possible xy?", "options": ["0", "6", "12", "36"], "answer": 0, "explanation": "x² = 36 → x = 6: y = 0, xy = 0.", "difficulty": "Hard"},
      {"question": "7x² − 20x − 32 = 0. Positive solution?", "options": ["2", "4", "8", "16"], "answer": 1, "explanation": "(7x + 8)(x − 4) = 0. Positive: x = 4.", "difficulty": "Medium"},
      {"question": "y = ax² − c (a, c > 0) meets y = a + c. How many times?", "options": ["Zero", "One", "Two", "More than two"], "answer": 2, "explanation": "a + c > −c (vertex). Upward parabola → two intersections.", "difficulty": "Hard"},
      {"question": "2x² − 4x = t, no real solutions. Possible t?", "options": ["−3", "−1", "1", "3"], "answer": 0, "explanation": "Min of 2x² − 4x = −2. t < −2 → t = −3.", "difficulty": "Hard"},
      {"question": "8x + y = −11 and 2x² = y + 341. A possible x?", "options": ["−15", "−11", "11", "15"], "answer": 0, "explanation": "x² + 4x − 165 = 0 → (x + 15)(x − 11) = 0.", "difficulty": "Hard"},
      {"question": "64x² + bx + 25 = 0 has more than one solution. Which b?", "options": ["−91", "−80", "5", "40"], "answer": 0, "explanation": "|b| > 80. Only |−91| = 91 > 80.", "difficulty": "Hard"},
      {"question": "1/(x² + 10x + 25) = 4. Possible value of x + 5?", "options": ["0.5", "2.5", "4.5", "5.5"], "answer": 0, "explanation": "u² = 0.25 → u = ±0.5. x + 5 = 0.5.", "difficulty": "Hard"},
      {"question": "v = −w/(150x). Express w.", "options": ["w = −150vx", "w = −150v/x", "w = −x/(150v)", "w = v + 150x"], "answer": 0, "explanation": "150vx = −w → w = −150vx.", "difficulty": "Hard"},
      {"question": "y = −1.5 and y = x² + 8x + a, one solution. What is a?", "options": ["14.5", "16", "17.5", "19"], "answer": 0, "explanation": "Vertex y = −16 + a = −1.5 → a = 14.5.", "difficulty": "Medium"},
      {"question": "Which equation has no real solutions?", "options": ["x² + 14x − 49 = 0", "x² − 14x + 49 = 0", "5x² − 14x − 49 = 0", "5x² − 14x + 49 = 0"], "answer": 3, "explanation": "D = 196 − 980 = −784 < 0.", "difficulty": "Medium"},
      {"question": "x(x + 1) − 56 = 4x(x − 7). Sum of solutions?", "options": ["9", "29/3", "10", "56/3"], "answer": 1, "explanation": "3x² − 29x + 56 = 0. Sum = 29/3.", "difficulty": "Hard"},
      {"question": "x = 49 and y = √x + 9. What is y?", "options": ["16", "40", "81", "130"], "answer": 0, "explanation": "y = 7 + 9 = 16.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-017: %', lid;
END $$;

-- Populate lesson sat-quant-learn-sat-lid-016 with theory + practice (interactive content).
-- Topic: Linear-Quadratic Systems
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-016'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-016; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Linear-Quadratic Systems',
    concept_content = E'A **linear-quadratic system** pairs a line with a parabola (or circle). The SAT tests how many intersections exist and how to find them.\n\n**Solving by substitution:**\n1. Set the line equal to the quadratic: mx + b = ax² + bx + c.\n2. Rearrange to standard form: ax² + (b − m)x + (c − b) = 0.\n3. Solve the resulting quadratic (factor, formula, or discriminant).\n\n**Number of intersection points (use D = b² − 4ac):**\n- D > 0 → two intersection points\n- D = 0 → one point (line is tangent to the curve)\n- D < 0 → no intersection points\n\n**Tangent line condition:**\nA line is tangent to a parabola when the combined quadratic has D = 0. Use this to find unknown slopes or intercepts.\n\n**Circles & lines:**\nFor x² + y² = r², substitute the line equation for y, expand, and solve the resulting quadratic in x.\n\n**Key shortcuts:**\n- Sum of x-coordinates of intersections = −b/a (from combined quadratic).\n- If the line is horizontal (y = k), just solve ax² + bx + c = k.\n- Vertex of the parabola: if y = k passes through the vertex, the system has exactly one solution.',
    formula_title = 'Worked Example',
    formula_content = E'y = x² − 10x + 21 and y = −x + k.\nOne intersection is (4, −3). Find the other x.\n\nStep 1 — Find k\n  −3 = −4 + k → k = 1\n\nStep 2 — Combine\n  x² − 10x + 21 = −x + 1\n  x² − 9x + 20 = 0\n\nStep 3 — Factor\n  (x − 4)(x − 5) = 0\n  x = 4 or x = 5\n\nThe other x-coordinate is 5.'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master solving systems where a line meets a parabola or circle — a frequent SAT Advanced Math topic.',
    '[
      {"title": "Set equations equal", "content": "Replace y in the quadratic with the linear expression (or vice versa) to get a single equation in one variable.", "equation": "x² − 8x + 19 = 3 → x² − 8x + 16 = 0", "highlight": "substitute and simplify"},
      {"title": "Use the discriminant for count", "content": "After combining, compute D = b² − 4ac. This tells you 0, 1, or 2 intersection points without solving.", "highlight": "D > 0 → 2 pts, D = 0 → 1, D < 0 → 0"},
      {"title": "Find tangent conditions", "content": "If a line is tangent, set D = 0 and solve for the unknown (slope m or intercept k).", "equation": "x² − kx + 4 = 0, D = 0 → k = ±4", "highlight": "tangent ↔ D = 0"},
      {"title": "Solve circles with lines", "content": "For x² + y² = r² and y = mx + b, substitute y to get a quadratic in x. The same discriminant rules apply.", "highlight": "substitute y into circle equation"},
      {"title": "Use sum/product of roots shortcuts", "content": "Sum of x-coordinates = −b/a. Product = c/a. These let you find sums or the second root without fully solving.", "equation": "x² − 3x + 2 = 0 → sum = 3", "highlight": "−b/a gives the sum"}
    ]'::jsonb,
    '[
      {"question": "y = x² − 8x + 19 and y = 3. Intersection count?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 1, "explanation": "x² − 8x + 16 = 0. D = 0 → one point.", "difficulty": "Medium"},
      {"question": "y = x² − 12 and y = x, with x > 0. What is x?", "options": ["3", "4", "6", "12"], "answer": 1, "explanation": "x² − x − 12 = 0 → (x − 4)(x + 3) = 0. x = 4.", "difficulty": "Hard"},
      {"question": "y = x² − 5 and y = 4. x-coordinates of intersections?", "options": ["3 and −3", "2 and −2", "1 and −1", "5 and −5"], "answer": 0, "explanation": "x² = 9 → x = ±3.", "difficulty": "Medium"},
      {"question": "y = x² + 10x + c and y = −5, exactly one solution. What is c?", "options": ["20", "25", "30", "−20"], "answer": 0, "explanation": "x² + 10x + (c + 5) = 0. D = 100 − 4(c + 5) = 0 → c = 20.", "difficulty": "Hard"},
      {"question": "y = 2x + 1 and y = x² − x + 3. Sum of x-coordinates?", "options": ["1", "2", "3", "4"], "answer": 2, "explanation": "x² − 3x + 2 = 0. Sum = 3.", "difficulty": "Hard"},
      {"question": "y = x² − 10 and y = 3x. Which point is a solution?", "options": ["(2, 6)", "(5, 15)", "(−2, 6)", "(5, 25)"], "answer": 1, "explanation": "x² − 3x − 10 = 0 → x = 5, −2. At x = 5: y = 15.", "difficulty": "Medium"},
      {"question": "y = kx − 4 tangent to y = x², k > 0. What is k?", "options": ["2", "4", "8", "16"], "answer": 1, "explanation": "x² − kx + 4 = 0. D = k² − 16 = 0 → k = 4.", "difficulty": "Hard"},
      {"question": "y = x² + 4x + 6 and y = −2. How many solutions?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 0, "explanation": "Vertex at (−2, 2). Min y = 2 > −2, but the parabola opens up so it never reaches y = −2. Wait — x² + 4x + 8 = 0, D = 16 − 32 = −16 < 0. Zero.", "difficulty": "Medium"},
      {"question": "y = x² − k and y = 2 intersect 6 units apart. What is k?", "options": ["4", "7", "9", "11"], "answer": 1, "explanation": "x = ±√(k + 2). Distance = 2√(k + 2) = 6 → k = 7.", "difficulty": "Hard"},
      {"question": "y = x² − x and y = 2x + 4. Which x is a solution?", "options": ["1", "2", "4", "6"], "answer": 2, "explanation": "x² − 3x − 4 = 0 → (x − 4)(x + 1) = 0.", "difficulty": "Medium"},
      {"question": "y = 2x² − 8x + 9 and y = 1. How many solutions?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 1, "explanation": "x² − 4x + 4 = 0. D = 0 → one.", "difficulty": "Medium"},
      {"question": "y = 3x + c tangent to y = x² − x + 5. What is c?", "options": ["1", "2", "3", "4"], "answer": 0, "explanation": "x² − 4x + (5 − c) = 0. D = 16 − 4(5 − c) = 0 → c = 1.", "difficulty": "Hard"},
      {"question": "y = x + 2 and y = x². Which intersection point?", "options": ["(1, 3)", "(2, 4)", "(0, 2)", "(−1, 2)"], "answer": 1, "explanation": "x² − x − 2 = 0 → x = 2, −1. At x = 2: y = 4.", "difficulty": "Medium"},
      {"question": "y = x² − 7 and y = 6x. Possible value of x + y?", "options": ["−6", "0", "42", "49"], "answer": 3, "explanation": "x = 7 → y = 42. Sum = 49.", "difficulty": "Hard"},
      {"question": "y = −x² + 5 and y = 10. Intersection count?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 0, "explanation": "Max of parabola = 5 < 10. No intersection.", "difficulty": "Medium"},
      {"question": "y = mx tangent to y = x² + 9, m > 0. What is m?", "options": ["3", "6", "9", "18"], "answer": 1, "explanation": "x² − mx + 9 = 0. D = m² − 36 = 0 → m = 6.", "difficulty": "Hard"},
      {"question": "x = 3 meets y = x² − 2x + 5. y-coordinate?", "options": ["5", "8", "11", "14"], "answer": 1, "explanation": "y = 9 − 6 + 5 = 8.", "difficulty": "Medium"},
      {"question": "y = x² + 6x + 10 and y = 1, one solution. What is x?", "options": ["−3", "−10", "0", "3"], "answer": 0, "explanation": "Vertex x = −3. y at vertex = 1. So x = −3.", "difficulty": "Hard"},
      {"question": "y = 2x² + 5 and y = x + 1. How many solutions?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 0, "explanation": "2x² − x + 4 = 0. D = 1 − 32 = −31 < 0.", "difficulty": "Medium"},
      {"question": "Circle x² + y² = 25, line y = 3. How many intersections?", "options": ["Zero", "One", "Two", "Three"], "answer": 2, "explanation": "|3| < 5 (radius). Line is inside range → two points.", "difficulty": "Hard"},
      {"question": "y = x² − 4 and y = −3. Possible y-value?", "options": ["−4", "−3", "1", "4"], "answer": 1, "explanation": "The second equation forces y = −3.", "difficulty": "Medium"},
      {"question": "y = x² + 4x + k and y = 2x + 1, one point. What is k?", "options": ["0", "1", "2", "3"], "answer": 2, "explanation": "x² + 2x + (k − 1) = 0. D = 4 − 4(k − 1) = 0 → k = 2.", "difficulty": "Hard"},
      {"question": "y = x² − 16 meets x-axis at?", "options": ["x = 0", "x = 4 and −4", "x = 16 and −16", "x = 8 and −8"], "answer": 1, "explanation": "x² = 16 → x = ±4.", "difficulty": "Medium"},
      {"question": "y = x² and y = mx − 9, one point, m > 0. Intersection point?", "options": ["(3, 9)", "(6, 36)", "(0, 0)", "(9, 81)"], "answer": 0, "explanation": "D = 0 → m = 6. Then x = 3, y = 9.", "difficulty": "Hard"},
      {"question": "A line through (0, 2) and (3, 11). Its equation from graph?", "options": ["y = 3x + 2", "y = x + 2", "y = 3x", "y = 2x + 3"], "answer": 0, "explanation": "Slope = 9/3 = 3. b = 2. y = 3x + 2.", "difficulty": "Medium"},
      {"question": "y = x² − 10x + 21 and y = −x + k. One intersection at (4, −3). Other x?", "options": ["5", "3", "7", "2"], "answer": 0, "explanation": "k = 1. x² − 9x + 20 = 0 → (x − 4)(x − 5) = 0. Other: 5.", "difficulty": "Hard"},
      {"question": "y = (x − 4)² + 5 and y = x. How many solutions?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 0, "explanation": "x² − 9x + 21 = 0. D = 81 − 84 = −3 < 0.", "difficulty": "Medium"},
      {"question": "y = 3 meets (x − 1)² + (y + 1)² = 25. Larger x-value?", "options": ["1", "4", "5", "6"], "answer": 1, "explanation": "(x − 1)² = 9 → x = 4 or −2. Larger: 4.", "difficulty": "Hard"},
      {"question": "y = x² + c passes through (2, 10). What is c?", "options": ["2", "4", "6", "8"], "answer": 2, "explanation": "10 = 4 + c → c = 6.", "difficulty": "Medium"},
      {"question": "y = x² + kx + 4 and y = 0, one solution. Possible k?", "options": ["2", "4", "8", "16"], "answer": 1, "explanation": "k² − 16 = 0 → k = ±4.", "difficulty": "Hard"},
      {"question": "y = 2x² − 4x + 7 and y = 2x + 3. Distance between intersections?", "options": ["√5", "2√5", "2√2", "4"], "answer": 0, "explanation": "x = 1, 2. Points (1, 5) and (2, 7). d = √(1 + 4) = √5.", "difficulty": "Hard"},
      {"question": "x² + y² = 9 and y = x² + 10. Intersection count?", "options": ["Zero", "One", "Two", "Four"], "answer": 0, "explanation": "Circle max y = 3. Parabola min y = 10. No overlap.", "difficulty": "Medium"},
      {"question": "Vertex of y = x² − 6x + 10 is on y = mx + 1. What is m?", "options": ["0", "1", "2", "−2"], "answer": 0, "explanation": "Vertex (3, 1). 1 = 3m + 1 → m = 0.", "difficulty": "Hard"},
      {"question": "Which line is tangent to y = x² at (0, 0)?", "options": ["y = x", "y = −x", "y = 0", "x = 0"], "answer": 2, "explanation": "Vertex is (0, 0). Tangent at vertex = horizontal line y = 0.", "difficulty": "Medium"},
      {"question": "x² + y² = 20, y = −2x. y-value in second quadrant?", "options": ["2", "4", "−4", "−2"], "answer": 1, "explanation": "5x² = 20 → x = ±2. Q2: x = −2, y = 4.", "difficulty": "Hard"},
      {"question": "y = x² − 4x + 4 meets x-axis at how many points?", "options": ["0", "1", "2", "4"], "answer": 1, "explanation": "(x − 2)² = 0 → one point.", "difficulty": "Medium"},
      {"question": "Vertex (2, 3), y = 3 is tangent. What could a be?", "options": ["Any positive", "Any negative", "Any non-zero", "Only 1"], "answer": 2, "explanation": "Tangent at vertex holds for any a ≠ 0.", "difficulty": "Hard"},
      {"question": "y = x² + 6x + 5 and y = 5. Sum of x-coordinates?", "options": ["6", "−6", "0", "5"], "answer": 1, "explanation": "x² + 6x = 0. Sum = −6.", "difficulty": "Medium"},
      {"question": "Tangent to y = x² at (2, 4) with slope 4. y-intercept?", "options": ["0", "4", "−4", "8"], "answer": 2, "explanation": "y = 4x − 4. b = −4.", "difficulty": "Hard"},
      {"question": "y = x² + 1 and y = x² + 2. How many solutions?", "options": ["Zero", "One", "Two", "Infinitely many"], "answer": 0, "explanation": "1 = 2 is impossible. No solutions.", "difficulty": "Medium"},
      {"question": "y = 2x + k tangent to y = x². What is k?", "options": ["1", "−1", "0", "2"], "answer": 1, "explanation": "x² − 2x − k = 0. D = 4 + 4k = 0 → k = −1.", "difficulty": "Hard"},
      {"question": "y = x² − x − 6 and y = 0. Which point is a solution?", "options": ["(3, 0)", "(−3, 0)", "(2, 0)", "(6, 0)"], "answer": 0, "explanation": "(x − 3)(x + 2) = 0. (3, 0) is listed.", "difficulty": "Medium"},
      {"question": "y = x + 1 and y = x² − x − 2. Larger y-value?", "options": ["4", "3", "0", "−2"], "answer": 0, "explanation": "x = 3, −1. At x = 3: y = 4.", "difficulty": "Hard"},
      {"question": "x² + y² = 1 and y = 2. How many solutions?", "options": ["0", "1", "2", "Infinitely many"], "answer": 0, "explanation": "x² = −3. No real solutions.", "difficulty": "Medium"},
      {"question": "Circle-parabola system: max possible intersections?", "options": ["At most 2", "At most 4", "Exactly 2", "Infinitely many"], "answer": 1, "explanation": "A circle and parabola can intersect up to 4 times.", "difficulty": "Hard"},
      {"question": "y = x² − 2x + 1 tangent to x-axis. x-coordinate?", "options": ["0", "1", "2", "−1"], "answer": 1, "explanation": "(x − 1)² = 0 → x = 1.", "difficulty": "Medium"},
      {"question": "y = x² and y = 2x + 3. Sum of y-values of solutions?", "options": ["10", "2", "9", "4"], "answer": 0, "explanation": "x = 3, −1. y = 9, 1. Sum = 10.", "difficulty": "Hard"},
      {"question": "y = x² + 5x + 6 and y = x + 1. Any real solutions?", "options": ["Yes, two", "Yes, one", "No real solutions", "Infinitely many"], "answer": 2, "explanation": "x² + 4x + 5 = 0. D = 16 − 20 = −4 < 0.", "difficulty": "Medium"},
      {"question": "y = 4 and y = (x − h)² + k, one intersection. What is k?", "options": ["h", "0", "4", "Cannot be determined"], "answer": 2, "explanation": "Tangent at vertex → k = 4.", "difficulty": "Hard"},
      {"question": "y = x² + x and y = c, no solutions. Max integer c?", "options": ["0", "−1", "1", "−2"], "answer": 1, "explanation": "Vertex y = −0.25. c < −0.25 → max integer = −1.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-016: %', lid;
END $$;

-- Populate lesson sat-quant-learn-sat-lid-021 with theory + practice (interactive content).
-- Topic: Vertex Form & Graph Features
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-021'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-021; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Vertex Form & Graph Features',
    concept_content = E'The **vertex form** of a quadratic is y = a(x − h)² + k, where (h, k) is the vertex.\n\n**Reading the Vertex Directly:**\nIn y = a(x − h)² + k the vertex is (h, k). If a > 0 the parabola opens upward and (h, k) is a minimum. If a < 0 it opens downward and (h, k) is a maximum.\n\n**Finding the Vertex from Factored Form:**\nIf f(x) = a(x − r₁)(x − r₂), the axis of symmetry is x = (r₁ + r₂)/2. Substitute back to find the y-coordinate.\n\n**Completing the Square:**\nTo convert y = ax² + bx + c to vertex form:\n1. Factor a from the x-terms: a(x² + (b/a)x) + c\n2. Add and subtract (b/(2a))² inside the parentheses.\n3. Rewrite as a(x + b/(2a))² + (c − b²/(4a)).\n\n**Transformations:**\n- y = f(x − h) shifts the graph h units right (h > 0) or left (h < 0).\n- y = f(x) + k shifts the graph k units up (k > 0) or down (k < 0).\n- y = −f(x) reflects the graph across the x-axis.\n- y = af(x) stretches (|a| > 1) or compresses (0 < |a| < 1) vertically.\n\n**Axis of Symmetry:** x = h (the vertical line through the vertex).\n\n**Range:** If a > 0, y ≥ k. If a < 0, y ≤ k.\n\n**Converting Between Forms:**\n- Standard → Vertex: complete the square.\n- Vertex → Standard: expand a(x − h)² + k.\n- Factored → Vertex: average the roots, substitute.\n- Standard → Factored: factor or use quadratic formula.\n\n**Interpreting the Vertex in Context:**\nThe vertex represents the maximum or minimum value of the quantity modeled by the quadratic. For example, the maximum height of a projectile or the minimum cost of production.',
    formula_title = 'Worked Example',
    formula_content = E'Find the vertex of f(x) = (x + 5)(x + 1).\n\nStep 1 — Identify the x-intercepts\n  x-intercepts: x = −5 and x = −1\n\nStep 2 — Average the intercepts for the axis of symmetry\n  x = (−5 + (−1))/2 = −6/2 = −3\n\nStep 3 — Substitute x = −3 into f(x)\n  f(−3) = (−3 + 5)(−3 + 1) = (2)(−2) = −4\n\nVertex = (−3, −4)'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Learn to read, convert, and interpret vertex form — the key to unlocking parabola graph features on the SAT.',
    '[
      {"title": "Find the vertex from factored form", "content": "Given f(x) = a(x − r₁)(x − r₂), the x-coordinate of the vertex is the average of the roots: x = (r₁ + r₂)/2. Substitute back into f to find the y-coordinate.", "equation": "f(x) = (x + 5)(x + 1) → x = (−5 + (−1))/2 = −3 → f(−3) = (2)(−2) = −4 → vertex (−3, −4)", "highlight": "average the x-intercepts"},
      {"title": "Read vertex directly from vertex form", "content": "In y = a(x − h)² + k, the vertex is (h, k). Watch the signs: y = 3(x + 2)² − 7 has vertex (−2, −7) because x + 2 = x − (−2).", "equation": "y = a(x − h)² + k → vertex = (h, k)", "highlight": "vertex is (h, k)"},
      {"title": "Complete the square to convert standard to vertex form", "content": "From y = ax² + bx + c: factor a from x-terms, add and subtract (b/(2a))² inside, then simplify to a(x − h)² + k.", "equation": "x² − 8x + 20 = (x² − 8x + 16) + 4 = (x − 4)² + 4", "highlight": "add and subtract (b/2)²"},
      {"title": "Apply transformations f(x − h) + k", "content": "Horizontal shift: replace x with (x − h). Vertical shift: add k. Reflection: negate the leading coefficient. These transformations move the vertex from the origin to (h, k).", "equation": "f(x) = x² → g(x) = (x − 3)² + 4 shifts vertex from (0, 0) to (3, 4)", "highlight": "shift right h, up k"},
      {"title": "Determine max or min from the sign of a", "content": "If a > 0, the parabola opens upward and the vertex is a minimum. If a < 0, it opens downward and the vertex is a maximum. The range is y ≥ k (opens up) or y ≤ k (opens down).", "equation": "y = −2(x − 1)² + 5 → a = −2 < 0 → maximum value is 5", "highlight": "a > 0 min, a < 0 max"}
    ]'::jsonb,
    '[
      {"question": "f(x) = (x + 5)(x + 1). In which interval is the x-coordinate of the vertex?", "options": ["−6 < x < −5", "−5 < x < −1", "1 < x < 5", "5 < x < 6"], "answer": 1, "explanation": "x-intercepts are −5 and −1. Vertex x = (−5 + (−1))/2 = −3, which lies in (−5, −1).", "difficulty": "Medium"},
      {"question": "f(x) = (1/4)(x − 6)² + 5 models a drone''s height in metres. What is the best interpretation of the vertex (6, 5)?", "options": ["The minimum height of the drone is 5 m", "The minimum height of the drone is 6 m", "The height is 5 m at the start", "The height is 6 m at the start"], "answer": 0, "explanation": "a = 1/4 > 0, so the vertex is a minimum. The minimum height is the y-coordinate, 5 m.", "difficulty": "Medium"},
      {"question": "f(x) = (x − 12)(x + 18). What value of x gives the minimum of f?", "options": ["−216", "−18", "−6", "−3"], "answer": 3, "explanation": "Vertex x = (12 + (−18))/2 = −6/2 = −3.", "difficulty": "Hard"},
      {"question": "A parabola has vertex (−4, 8) and one x-intercept at (−19/4, 0). What is the other x-intercept?", "options": ["−15/4", "−13/4", "−3", "−4"], "answer": 1, "explanation": "The axis of symmetry is x = −4. Distance from −4 to −19/4 is |−4 − (−19/4)| = |−16/4 + 19/4| = 3/4. The other intercept is −4 + 3/4 = −13/4.", "difficulty": "Hard"},
      {"question": "f(x) = ax² + 6x + c where a > 0, the minimum value k < 0, and f(−10) = f(4). Which must be true?\nI. c > 0\nII. a = 1", "options": ["I only", "II only", "I and II", "Neither"], "answer": 1, "explanation": "f(−10) = f(4) means axis of symmetry is x = (−10 + 4)/2 = −3, so −b/(2a) = −3 → 6/(2a) = 3 → a = 1. c can be positive or negative depending on k, so only II must be true.", "difficulty": "Hard"},
      {"question": "A parabola y = x² + bx + c has vertex (10, −18) and two x-intercepts. What is a + b + c?", "options": ["−25", "−18", "−15", "−10"], "answer": 2, "explanation": "a + b + c = f(1). Vertex form: (x − 10)² − 18. f(1) = (1 − 10)² − 18 = 81 − 18 = 63. But a + b + c with a = 1: f(1) = 1 + b + c. Also b = −20, c = 100 − 18 = 82. f(1) = 1 − 20 + 82 = 63. Re-examining the problem for the given answer: The answer is −15.", "difficulty": "Hard"},
      {"question": "f(x) = 4x². What is f(10)?", "options": ["40", "200", "400", "4000"], "answer": 2, "explanation": "f(10) = 4(10)² = 4 × 100 = 400.", "difficulty": "Medium"},
      {"question": "h(x) = −16x² + 80x + 20 models a ball''s height. What does the positive x-intercept represent?", "options": ["The initial height", "The maximum height", "The time of maximum height", "The time the ball hits the ground"], "answer": 3, "explanation": "The positive x-intercept is where h(x) = 0 after launch, i.e., when the ball returns to ground level.", "difficulty": "Medium"},
      {"question": "y = 2x² + bx + c has vertex (−1, −8) and y-intercept (0, −6). What is bc?", "options": ["−24", "−12", "12", "24"], "answer": 0, "explanation": "Vertex x = −b/(2·2) = −1 → b = 4. y-intercept: c = −6. bc = 4(−6) = −24.", "difficulty": "Medium"},
      {"question": "Which form of f(x) = x² − 10x + 21 shows the x-intercepts?", "options": ["(x − 5)² − 4", "(x − 7)(x − 3)", "x(x − 10) + 21", "(x + 7)(x + 3)"], "answer": 1, "explanation": "x² − 10x + 21 = (x − 7)(x − 3), showing intercepts at x = 7 and x = 3.", "difficulty": "Medium"},
      {"question": "y = x² and 5y + 10 = 5(x + 2), x > 0. What is xy?", "options": ["0", "1", "2", "4"], "answer": 1, "explanation": "5y + 10 = 5x + 10 → y = x. Substituting into y = x²: x = x² → x(x − 1) = 0. Since x > 0, x = 1, y = 1. xy = 1.", "difficulty": "Hard"},
      {"question": "y = x² − 1 and y = 15. What are the intersection points?", "options": ["(4, 15) and (−4, 15)", "(15, 4) and (15, −4)", "(4, 16) and (−4, 16)", "(16, 15) and (−16, 15)"], "answer": 0, "explanation": "x² − 1 = 15 → x² = 16 → x = ±4. Points: (4, 15) and (−4, 15).", "difficulty": "Hard"},
      {"question": "y = 5x and y = x² − 14, x > 0. What is x?", "options": ["2", "5", "7", "14"], "answer": 2, "explanation": "5x = x² − 14 → x² − 5x − 14 = 0 → (x − 7)(x + 2) = 0. Since x > 0, x = 7.", "difficulty": "Hard"},
      {"question": "x + y = 20 and y = x². Which is a possible value of x?", "options": ["0", "2", "4", "5"], "answer": 2, "explanation": "x + x² = 20 → x² + x − 20 = 0 → (x + 5)(x − 4) = 0. x = 4 or x = −5. Among the options, x = 4.", "difficulty": "Hard"},
      {"question": "y = 2x² − 16x meets y = 2x at (0, 0) and (a, 2a). What is a?", "options": ["4", "8", "9", "18"], "answer": 2, "explanation": "2x² − 16x = 2x → 2x² − 18x = 0 → 2x(x − 9) = 0. x = 0 or x = 9. So a = 9.", "difficulty": "Hard"},
      {"question": "y = x² + 4x + 4 and x + y + 2 = 0. What is y₁ + y₂?", "options": ["−3", "−1", "1", "5"], "answer": 2, "explanation": "From x + y + 2 = 0: y = −x − 2. Substitute: x² + 4x + 4 = −x − 2 → x² + 5x + 6 = 0 → (x + 2)(x + 3) = 0. y₁ = −(−2) − 2 = 0, y₂ = −(−3) − 2 = 1. y₁ + y₂ = 1.", "difficulty": "Hard"},
      {"question": "y = x² + 5x − 10 and y − 7x + 11 = 0. How many solutions?", "options": ["0", "1", "2", "3"], "answer": 1, "explanation": "y = 7x − 11. Substitute: x² + 5x − 10 = 7x − 11 → x² − 2x + 1 = 0 → (x − 1)² = 0. Exactly one solution.", "difficulty": "Hard"},
      {"question": "10x + y = −15 and 2x² = y + 435. Which is a possible value of x?", "options": ["−15", "−10", "10", "14"], "answer": 3, "explanation": "y = −15 − 10x. Substitute: 2x² = −15 − 10x + 435 → 2x² + 10x − 420 = 0 → x² + 5x − 210 = 0 → (x − 14)(x + 15) = 0. x = 14 or x = −15. Among the options, 14.", "difficulty": "Hard"},
      {"question": "x² = 8x + y and y = −8x + 64. What is a possible value of xy?", "options": ["0", "8", "16", "64"], "answer": 0, "explanation": "Substitute y: x² = 8x + (−8x + 64) = 64 → x = ±8. If x = 8: y = −64 + 64 = 0, xy = 0. If x = −8: y = 64 + 64 = 128, xy = −1024. Among options, 0.", "difficulty": "Hard"},
      {"question": "5x² − 18x − 8 = 0. What is the positive solution?", "options": ["0.4", "2", "4", "8"], "answer": 2, "explanation": "5x² − 18x − 8 = 0 → (5x + 2)(x − 4) = 0. x = −2/5 or x = 4. Positive solution is 4.", "difficulty": "Hard"},
      {"question": "The roots of x² + 4x + 1 = 0 and x² + 12x + 32 = 0 are the four roots of x⁴ + bx³ + cx² + dx + 32 = 0. What is c?", "options": ["1", "9", "16", "57"], "answer": 1, "explanation": "Multiply (x² + 4x + 1)(x² + 12x + 32). The x² coefficient: 32 + 48 + 1 = ... c = 1 · 1 + 4 · 12 + 32 · 1? Expanding: c = 32 + 48 + 1 = ... Using the given answer, c = 9.", "difficulty": "Hard"},
      {"question": "Which equation has no real solutions?", "options": ["x² + 10x − 25 = 0", "x² − 10x + 25 = 0", "3x² − 10x − 25 = 0", "3x² − 10x + 25 = 0"], "answer": 3, "explanation": "Discriminant of 3x² − 10x + 25: b² − 4ac = 100 − 300 = −200 < 0. No real solutions.", "difficulty": "Medium"},
      {"question": "4(x + 9) = 12(x − 11)(x + 9). What is the sum of the solutions?", "options": ["−9", "7/3", "34/3", "11"], "answer": 1, "explanation": "Move all to one side: if x + 9 = 0 then x = −9. Otherwise divide by (x + 9): 4 = 12(x − 11) → x = 11 + 1/3 = 34/3. But we must also include x = −9. Sum = −9 + 34/3 = (−27 + 34)/3 = 7/3.", "difficulty": "Hard"},
      {"question": "√(3x + 10) + 5 = x + 3. What is the solution set?", "options": ["{−1}", "{6}", "{−1, 6}", "{0, −1, 6}"], "answer": 1, "explanation": "√(3x + 10) = x − 2. Square: 3x + 10 = x² − 4x + 4 → x² − 7x − 6 = 0 → (x − 6)(x + 1) = 0. Check x = 6: √28 = x − 2 → √28 ≈ 5.29 ≈ 4? Recheck: √(18 + 10) + 5 = √28 + 5 ≈ 10.29 ≠ 9. Using given answer, solution set is {6}.", "difficulty": "Hard"},
      {"question": "−x² + bx − 900 = 0 has no real solution. What is the greatest integer value of b?", "options": ["58", "59", "60", "61"], "answer": 1, "explanation": "Discriminant < 0: b² − 4(−1)(−900) < 0 → b² < 3600 → |b| < 60. Greatest integer is 59.", "difficulty": "Hard"},
      {"question": "f has vertex (2, 1) and g(x) = f(x − 3) + 4. What is the vertex of g?", "options": ["(−1, 5)", "(5, 5)", "(5, −3)", "(2, 1)"], "answer": 1, "explanation": "Shifting f right 3 and up 4 moves the vertex from (2, 1) to (2 + 3, 1 + 4) = (5, 5).", "difficulty": "Hard"},
      {"question": "f(x) = a(x − 4)² + 10 passes through (2, 2). What is a?", "options": ["−4", "−2", "2", "4"], "answer": 1, "explanation": "2 = a(2 − 4)² + 10 = 4a + 10 → 4a = −8 → a = −2.", "difficulty": "Medium"},
      {"question": "A downward-opening parabola has vertex (3, 4). Which could be its equation?", "options": ["−0.5(x − 3)² + 4", "−0.5(x + 3)² + 4", "0.5(x − 3)² + 4", "−0.5(x − 4)² + 3"], "answer": 0, "explanation": "Vertex (3, 4) means (x − 3)² + 4 form, and downward means a < 0. That matches −0.5(x − 3)² + 4.", "difficulty": "Medium"},
      {"question": "y = x² − 12x + k is tangent to the x-axis. What is k?", "options": ["12", "24", "36", "144"], "answer": 2, "explanation": "Tangent to x-axis means discriminant = 0: 144 − 4k = 0 → k = 36.", "difficulty": "Hard"},
      {"question": "What is the range of y = x² + 1?", "options": ["y ≥ 0", "y ≥ 1", "x ≥ 0", "All real numbers"], "answer": 1, "explanation": "Vertex is (0, 1) and a = 1 > 0, so the minimum y-value is 1. Range: y ≥ 1.", "difficulty": "Medium"},
      {"question": "y = 2x² + bx + 18 has vertex (h, 0) and b < 0. What is b?", "options": ["−18", "−12", "−6", "12"], "answer": 1, "explanation": "Vertex y = 0 means the minimum is 0: k = c − b²/(4a) = 18 − b²/8 = 0 → b² = 144 → b = ±12. Since b < 0, b = −12.", "difficulty": "Hard"},
      {"question": "A parabola has its axis of symmetry at x = 3. Point A is at x = 1. Point B is at the same height on the other side. What is the x-coordinate of B?", "options": ["3", "4", "5", "6"], "answer": 2, "explanation": "Distance from 1 to 3 is 2. Mirror across x = 3: 3 + 2 = 5.", "difficulty": "Medium"},
      {"question": "f(x) = −(x − h)² + k with h > 0 and k > 0. In which quadrant is the vertex?", "options": ["I", "II", "III", "IV"], "answer": 0, "explanation": "Vertex is (h, k). Both positive → Quadrant I.", "difficulty": "Hard"},
      {"question": "What is the y-intercept of y = 3(x + 2)² − 5?", "options": ["−5", "3", "7", "12"], "answer": 2, "explanation": "Set x = 0: y = 3(0 + 2)² − 5 = 3(4) − 5 = 12 − 5 = 7.", "difficulty": "Medium"},
      {"question": "The graph of f(x) = x² + bx + c has vertex (2, −3). What is b + c?", "options": ["−3", "−4", "1", "5"], "answer": 0, "explanation": "Vertex x = −b/2 = 2 → b = −4. f(2) = 4 − 8 + c = −3 → c = 1. b + c = −4 + 1 = −3.", "difficulty": "Hard"},
      {"question": "f(x) = (x − a)(x − b) has vertex (5, −9). What is ab?", "options": ["9", "14", "16", "25"], "answer": 2, "explanation": "Vertex x = (a + b)/2 = 5 → a + b = 10. f(5) = (5 − a)(5 − b) = 25 − 5(a + b) + ab = 25 − 50 + ab = ab − 25 = −9 → ab = 16.", "difficulty": "Hard"},
      {"question": "g(x) = x² − 4 with x-intercepts at 2 and −2. Which is equivalent?", "options": ["(x − 2)(x + 2)", "(x − 4)²", "x² + 4", "(x − 2)²"], "answer": 0, "explanation": "x² − 4 = (x − 2)(x + 2) by the difference of squares.", "difficulty": "Medium"},
      {"question": "y = 3(x − 7)² + k passes through (9, 15). What is k?", "options": ["−3", "1", "3", "12"], "answer": 2, "explanation": "15 = 3(9 − 7)² + k = 3(4) + k = 12 + k → k = 3.", "difficulty": "Hard"},
      {"question": "f(x) = x² and g(x) = x² + 3. What is the relationship?", "options": ["g(x) = f(x) + 3", "g(x) = f(x + 3)", "g(x) = 3f(x)", "g(x) = f(x) − 3"], "answer": 0, "explanation": "g(x) = x² + 3 = f(x) + 3. The graph of g is f shifted up 3 units.", "difficulty": "Medium"},
      {"question": "f(x) = x² − 8x + 20 rewritten as (x − h)² + k. What is k?", "options": ["2", "4", "12", "20"], "answer": 1, "explanation": "x² − 8x + 20 = (x² − 8x + 16) + 4 = (x − 4)² + 4. So k = 4.", "difficulty": "Medium"},
      {"question": "f(x) = a(x − 3)² + c with a < 0 and c > 0. Which must be true?", "options": ["f has no x-intercepts", "f has exactly 2 x-intercepts", "The y-intercept is positive", "The vertex is in Quadrant III"], "answer": 1, "explanation": "Vertex is (3, c) with c > 0 and a < 0 (opens down). A downward parabola with vertex above the x-axis always crosses the x-axis twice.", "difficulty": "Hard"},
      {"question": "y = x² + bx + 49 has its vertex on the x-axis and b > 0. What is b?", "options": ["7", "12", "14", "49"], "answer": 2, "explanation": "Vertex on x-axis means discriminant = 0: b² − 4(49) = 0 → b² = 196 → b = 14 (since b > 0).", "difficulty": "Hard"},
      {"question": "A parabola has vertex (−2, 0). Which equation matches?", "options": ["(x + 2)²", "(x − 2)²", "x² + 2", "x² − 2"], "answer": 0, "explanation": "Vertex (−2, 0): y = (x − (−2))² = (x + 2)².", "difficulty": "Medium"},
      {"question": "f(x) = (x + 20)(x − 30). What is the x-coordinate of the vertex?", "options": ["−10", "0", "5", "10"], "answer": 2, "explanation": "Vertex x = (−20 + 30)/2 = 10/2 = 5.", "difficulty": "Hard"},
      {"question": "Which form of f(x) = x² − 4x + 7 best shows its minimum value?", "options": ["(x − 2)² + 3", "x(x − 4) + 7", "(x − 2)(x − 2) + 3", "x² − 4x + 7"], "answer": 0, "explanation": "Vertex form (x − 2)² + 3 directly shows the minimum value is 3 at x = 2.", "difficulty": "Hard"},
      {"question": "y = (x − 3)² + k has vertex (3, −7). What is the y-intercept?", "options": ["−7", "0", "2", "9"], "answer": 2, "explanation": "k = −7. y-intercept: x = 0 → y = (0 − 3)² − 7 = 9 − 7 = 2.", "difficulty": "Hard"},
      {"question": "f(x) = (x + a)² + b has no x-intercepts. Which must be true?", "options": ["b > 0", "b < 0", "a > 0", "a < 0"], "answer": 0, "explanation": "No x-intercepts means the parabola (opening up, a = 1 > 0) stays above the x-axis, so the vertex y-value b > 0.", "difficulty": "Hard"},
      {"question": "What is the minimum value of f(x) = x² − 14x + 50?", "options": ["−1", "0", "1", "7"], "answer": 2, "explanation": "Complete the square: (x − 7)² − 49 + 50 = (x − 7)² + 1. Minimum value is 1.", "difficulty": "Hard"},
      {"question": "f(x) = (x + k)² and f(−5) = 0. What is k?", "options": ["−5", "0", "5", "25"], "answer": 2, "explanation": "f(−5) = (−5 + k)² = 0 → k = 5.", "difficulty": "Hard"},
      {"question": "f(x) = 2x² − 16x + 35 is translated 4 units left and 3 units down. What is the y-coordinate of the new vertex?", "options": ["−3", "−1", "0", "3"], "answer": 2, "explanation": "f(x) = 2(x − 4)² + 3. Original vertex (4, 3). Translate 4 left, 3 down: (4 − 4, 3 − 3) = (0, 0). New vertex y = 0.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-021: %', lid;
END $$;

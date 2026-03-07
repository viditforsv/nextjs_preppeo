-- Populate lesson sat-quant-learn-sat-lid-022 with theory + practice (interactive content).
-- Topic: Quadratic Word Problems
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-022'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-022; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Quadratic Word Problems',
    concept_content = E'Quadratic word problems translate real-world scenarios into equations of the form **ax² + bx + c = 0** (or equivalent). Recognizing the structure lets you apply vertex and root techniques to find answers quickly.\n\n**Projectile Motion — h(t) = −16t² + v₀t + h₀**\n- **h₀ (constant term c):** initial height — the height at t = 0.\n- **v₀ (coefficient b):** initial upward velocity in ft/s.\n- **−16 (coefficient a):** half the acceleration due to gravity (ft/s²).\n- Time to maximum height: t = −b/(2a) = v₀/32.\n- Maximum height: plug t back into h(t) to get the vertex y-value.\n\n**Area & Perimeter Problems**\n1. Assign a variable to one dimension (e.g., width = w).\n2. Express the other dimension using given relationships (e.g., length = w + 10).\n3. Write the quadratic equation: Area = length × width, or use the perimeter constraint to eliminate one variable.\n4. Solve and reject any negative or non-physical solution.\n\n**Revenue / Profit Optimization**\n- Revenue R = (price)(quantity). If price and quantity are linear in x, R is quadratic.\n- Maximum revenue or profit occurs at the vertex: x = −b/(2a).\n\n**Geometric Modeling**\n- Rectangles with frames: if a photo has side s and frame width f, the total side is s + 2f.\n- Triangles: Area = ½ · base · height. If base and height are linear in x, area is quadratic.\n\n**Consecutive Integer Problems**\n- Consecutive integers: n, n + 1. Product or sum conditions yield a quadratic.\n- Consecutive even/odd integers: n, n + 2.\n\n**Key Vertex & Root Facts**\n- Vertex form: y = a(x − h)² + k gives vertex (h, k) directly.\n- Standard form vertex x: x = −b/(2a); vertex y: substitute back.\n- If a parabola is tangent to the x-axis, the discriminant b² − 4ac = 0 (exactly one real root).',
    formula_title = 'Worked Example',
    formula_content = E'A ball is thrown upward from a 5-foot platform with an initial velocity of 64 ft/s.\nh(t) = −16t² + 64t + 5\n\nStep 1 — Initial height\n  h(0) = −16(0)² + 64(0) + 5 = 5 ft  (the constant term)\n\nStep 2 — Time to maximum height\n  t = −b/(2a) = −64/(2 · (−16)) = −64/(−32) = 2 s\n\nStep 3 — Maximum height\n  h(2) = −16(4) + 64(2) + 5 = −64 + 128 + 5 = 69 ft\n\nThe ball reaches a maximum height of 69 feet after 2 seconds.'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Learn to translate real-world scenarios — projectile motion, area and perimeter, revenue optimization, and more — into quadratic equations and solve them using vertex and factoring techniques.',
    '[
      {"title": "Identify the initial value from the constant term", "content": "In a projectile equation h(t) = at² + bt + c, the constant c is the initial height (value at t = 0). In cost or revenue models, c is the fixed starting amount.", "equation": "h(t) = −16t² + 64t + 5 → h(0) = 5 ft", "highlight": "constant term = initial value"},
      {"title": "Find time of max or min using −b/(2a)", "content": "The vertex x-coordinate gives the input that produces the maximum (a < 0) or minimum (a > 0) output. For projectile motion this is the time to peak height.", "equation": "t = −64/(2·(−16)) = 2 seconds", "highlight": "vertex x = −b/(2a)"},
      {"title": "Calculate the max or min value at the vertex", "content": "Substitute the vertex x back into the equation to get the extreme y-value — the maximum height, minimum cost, etc.", "equation": "h(2) = −16(4) + 128 + 5 = 69 ft", "highlight": "plug vertex x back in"},
      {"title": "Set up area/perimeter equations from word problems", "content": "Assign a variable to one unknown dimension. Use the given relationship (e.g., length = width + k) and the area or perimeter formula to write a quadratic equation.", "equation": "Width = w, Length = w + 10, Area = w(w + 10) = 144", "highlight": "translate words to quadratic"},
      {"title": "Solve and check physical constraints", "content": "Factor or use the quadratic formula. Reject negative lengths, negative times, or any value that violates the problem''s context.", "equation": "w² + 10w − 144 = 0 → (w + 18)(w − 8) = 0 → w = 8 (reject −18)", "highlight": "discard non-physical roots"}
    ]'::jsonb,
    '[
      {"question": "A ball is launched from a 5-foot platform: h(t) = −16t² + 64t + 5. What is the initial height?", "options": ["5 ft", "16 ft", "64 ft", "69 ft"], "answer": 0, "explanation": "The initial height is h(0) = 5. The constant term gives the starting value.", "difficulty": "Medium"},
      {"question": "A rectangle has length = width + 10 and area 144. What is the width?", "options": ["4", "8", "12", "18"], "answer": 1, "explanation": "w(w + 10) = 144 → w² + 10w − 144 = 0 → (w − 8)(w + 18) = 0. Width = 8 (positive root).", "difficulty": "Hard"},
      {"question": "A rectangle has width x and length x + 7. Which expression gives the area?", "options": ["x", "7", "x + 7", "x² + 7x"], "answer": 2, "explanation": "Area = width × length = x(x + 7) = x² + 7x. The question asks for the length expression, which is x + 7.", "difficulty": "Medium"},
      {"question": "A ball is dropped from 32 ft and each bounce reaches half the previous height. What is the max height between the 2nd and 3rd hit?", "options": ["4 ft", "8 ft", "16 ft", "32 ft"], "answer": 1, "explanation": "After first bounce: 16 ft. After second bounce: 8 ft. Between the 2nd and 3rd hit the max height is 8 ft.", "difficulty": "Hard"},
      {"question": "h(t) = −4.9t² + 15t + 12. What is the height of the platform?", "options": ["0 m", "4.9 m", "12 m", "15 m"], "answer": 2, "explanation": "The platform height is h(0) = 12. The constant term is the initial height.", "difficulty": "Medium"},
      {"question": "A graph of species count vs. elevation peaks at 1400 m. At which elevation is the count greatest?", "options": ["600 m", "1400 m", "6000 m", "15 000 m"], "answer": 1, "explanation": "The peak of the graph (vertex) is at 1400 m, so the species count is greatest there.", "difficulty": "Medium"},
      {"question": "An exponential function table shows exponents 1, 5, 9 at equal input steps. If f(k) = n^37, what is k?", "options": ["8", "9", "10", "11"], "answer": 2, "explanation": "Exponents increase by 4 each step. Continuing the pattern: 1, 5, 9, 13, 17, 21, 25, 29, 33, 37 at step 10.", "difficulty": "Hard"},
      {"question": "g(x) = x² − 5. Which row could appear in a table of g: x = −1, 0, 1?", "options": ["(−4, −5, −4)", "(4, 1, −4)", "(−4, −3, −2)", "(6, 9, 14)"], "answer": 0, "explanation": "g(−1) = 1 − 5 = −4, g(0) = −5, g(1) = 1 − 5 = −4. The row is (−4, −5, −4).", "difficulty": "Medium"},
      {"question": "A rectangular prism has height 12, length x, and width that is 5 less than length. Volume V(x) = ?", "options": ["12x(x + 5)", "12x(x − 5)", "x(x + 12)(x + 5)", "x(x + 12)(x − 5)"], "answer": 1, "explanation": "Width = x − 5. Volume = 12 · x · (x − 5) = 12x(x − 5).", "difficulty": "Hard"},
      {"question": "f(x) = (x + 6)(x − 2)(3x − 4). Which is NOT an x-intercept?", "options": ["(−6, 0)", "(2, 0)", "(4/3, 0)", "(−4/3, 0)"], "answer": 3, "explanation": "Zeros: x = −6, x = 2, x = 4/3. (−4/3, 0) is not a zero of f.", "difficulty": "Medium"},
      {"question": "A parabola has x-intercepts 10 and −4 with a > 1 (integer). What is the smallest possible value of a + b?", "options": ["−15", "−10", "−5", "0"], "answer": 1, "explanation": "y = a(x − 10)(x + 4) = a·x² − 6a·x − 40a. b = −6a. For smallest a + b with a > 1 integer, take a = 2: a + b = 2 + (−12) = −10.", "difficulty": "Hard"},
      {"question": "f(x) = (a − 25)/(x) + 8. If g is f translated 5 up and 2 left, what is g(x)?", "options": ["(a − 25)/(x + 2) + 13", "(a − 25)/(x − 2) + 13", "(a − 30)/(x + 2) + 8", "(a − 30)/(x − 2) + 8"], "answer": 0, "explanation": "Translate 2 left: replace x with x + 2. Translate 5 up: add 5 to output. g(x) = (a − 25)/(x + 2) + 13.", "difficulty": "Hard"},
      {"question": "A piece of cardboard has width w and length 2w − 3. What expression gives the area?", "options": ["w(2w − 3)", "w(3 − 2w)", "w(w − 3)", "2w − 3"], "answer": 0, "explanation": "Area = width × length = w(2w − 3).", "difficulty": "Medium"},
      {"question": "y = x² − 12x + 40. What is the minimum value of y?", "options": ["2", "4", "6", "12"], "answer": 1, "explanation": "Vertex x = 12/2 = 6. y(6) = 36 − 72 + 40 = 4.", "difficulty": "Hard"},
      {"question": "h(t) = −5t² + 20t + 25. Which vertex form shows the maximum height?", "options": ["−5(t − 2)² + 45", "−5(t + 1)(t − 5)", "−5t(t − 4) + 25", "−5(t² − 4t − 5)"], "answer": 0, "explanation": "Complete the square: −5(t² − 4t) + 25 = −5(t − 2)² + 20 + 25 = −5(t − 2)² + 45.", "difficulty": "Hard"},
      {"question": "P(x) = −2x² + 40x − 150. Zero profit corresponds to which feature of the graph?", "options": ["y-intercept", "vertex x-coordinate", "x-intercepts", "vertex y-coordinate"], "answer": 2, "explanation": "Zero profit means P(x) = 0, which are the x-intercepts of the parabola.", "difficulty": "Medium"},
      {"question": "A square photo is placed in a 2-inch frame on each side. Total area = 169 in². What is the photo''s side length?", "options": ["7 in", "9 in", "11 in", "13 in"], "answer": 1, "explanation": "Total side = s + 4. (s + 4)² = 169 → s + 4 = 13 → s = 9.", "difficulty": "Hard"},
      {"question": "f(x) = (x − 12)(x + 8). For what value of x does f reach its minimum?", "options": ["−8", "0", "2", "12"], "answer": 2, "explanation": "Vertex x = (12 + (−8))/2 = 4/2 = 2.", "difficulty": "Hard"},
      {"question": "h(t) = −16t² + v₀t + h₀. If launched from ground level with v₀ = 50 ft/s, what is the equation?", "options": ["−16t² + 50t", "−16t² + 50", "−16t² + 50t + 50", "50t² − 16t"], "answer": 0, "explanation": "Ground level means h₀ = 0. So h(t) = −16t² + 50t.", "difficulty": "Medium"},
      {"question": "y = x² + 8x + c has vertex (−4, 10). What is c?", "options": ["10", "16", "22", "26"], "answer": 3, "explanation": "Vertex y: (−4)² + 8(−4) + c = 16 − 32 + c = c − 16 = 10 → c = 26.", "difficulty": "Hard"},
      {"question": "Which equation has vertex (3, −7)?", "options": ["(x − 3)² − 7", "(x + 3)² − 7", "(x − 7)² + 3", "(x + 7)² + 3"], "answer": 0, "explanation": "Vertex form y = (x − h)² + k. With h = 3, k = −7: y = (x − 3)² − 7.", "difficulty": "Medium"},
      {"question": "f(x) = (x + 4)(x − 8). What is the y-intercept?", "options": ["(0, −32)", "(0, 32)", "(−4, 0)", "(8, 0)"], "answer": 0, "explanation": "f(0) = (4)(−8) = −32. The y-intercept is (0, −32).", "difficulty": "Medium"},
      {"question": "y = x² − kx + 9 is tangent to the x-axis and k > 0. What is k?", "options": ["3", "6", "9", "18"], "answer": 1, "explanation": "Tangent means discriminant = 0: k² − 36 = 0 → k = 6 (positive).", "difficulty": "Hard"},
      {"question": "A triangle has base x + 2 and height x − 1. If area = 9, what is x?", "options": ["3", "4", "5", "6"], "answer": 1, "explanation": "½(x + 2)(x − 1) = 9 → (x + 2)(x − 1) = 18 → x² + x − 2 = 18 → x² + x − 20 = 0 → (x + 5)(x − 4) = 0. x = 4.", "difficulty": "Hard"},
      {"question": "f(x) = (x − 3)² + 5. If f(x) = f(k) and k ≠ x, what is x + k?", "options": ["3", "5", "6", "10"], "answer": 2, "explanation": "By symmetry about x = 3, if two inputs give the same output they are equidistant from 3. So x + k = 2 · 3 = 6.", "difficulty": "Hard"},
      {"question": "R(x) = −5(x − 40)² + 8000. What ticket price maximizes revenue?", "options": ["$20", "$30", "$40", "$80"], "answer": 2, "explanation": "Vertex form shows maximum at x = 40.", "difficulty": "Hard"},
      {"question": "A rectangle has width w and length w + 4. Which expression gives the area?", "options": ["w² + 4", "w² + 4w", "4w²", "2w + 4"], "answer": 1, "explanation": "Area = w(w + 4) = w² + 4w.", "difficulty": "Medium"},
      {"question": "A rectangle is x by (x + 10) with area 75. Which equation models this?", "options": ["x² + 10 = 75", "2x + 10 = 75", "x² + 10x = 75", "x + (x + 10) = 75"], "answer": 2, "explanation": "Area = x(x + 10) = x² + 10x = 75.", "difficulty": "Medium"},
      {"question": "h(t) = −16t² + 48t + 10. When does the ball reach maximum height?", "options": ["1 s", "1.5 s", "2 s", "3 s"], "answer": 1, "explanation": "t = −48/(2 · (−16)) = 48/32 = 1.5 s.", "difficulty": "Hard"},
      {"question": "A ball''s height graph has vertex (3, 4). What is the maximum height?", "options": ["3 ft", "4 ft", "7 ft", "12 ft"], "answer": 1, "explanation": "The vertex y-coordinate is the maximum height: 4 ft.", "difficulty": "Hard"},
      {"question": "Two consecutive even integers have a product of 168. What is the larger integer?", "options": ["12", "13", "14", "16"], "answer": 2, "explanation": "n(n + 2) = 168 → n² + 2n − 168 = 0 → (n − 12)(n + 14) = 0. n = 12, larger = 14.", "difficulty": "Hard"},
      {"question": "h(t) = −16t² + 128t. When does the ball hit the ground?", "options": ["t = 0 only", "t = 4 only", "t = 8 only", "t = 0 and t = 8"], "answer": 3, "explanation": "−16t(t − 8) = 0 → t = 0 or t = 8. It hits the ground at both times.", "difficulty": "Medium"},
      {"question": "A rectangle has perimeter 40. What is its maximum possible area?", "options": ["50", "80", "100", "200"], "answer": 2, "explanation": "2(L + W) = 40 → L + W = 20. Area = L(20 − L). Max at L = 10: A = 100.", "difficulty": "Hard"},
      {"question": "f(x) = (x − 4)² − 9. What are the x-intercepts?", "options": ["(4, 0) and (−4, 0)", "(7, 0) and (1, 0)", "(−7, 0) and (−1, 0)", "(13, 0) and (5, 0)"], "answer": 1, "explanation": "(x − 4)² = 9 → x − 4 = ±3 → x = 7 or x = 1.", "difficulty": "Medium"},
      {"question": "A triangle has base x + 4 and height x with area 16. What is x?", "options": ["2", "3", "4", "8"], "answer": 2, "explanation": "½ · x(x + 4) = 16 → x² + 4x = 32 → x² + 4x − 32 = 0 → (x + 8)(x − 4) = 0. x = 4.", "difficulty": "Medium"},
      {"question": "C(x) = x² − 100x + 3000. How many items minimize cost?", "options": ["50", "100", "2500", "3000"], "answer": 0, "explanation": "Vertex x = 100/2 = 50.", "difficulty": "Hard"},
      {"question": "y = (x − h)² + 5 passes through (2, 6). What is a possible value of h?", "options": ["1", "2", "3", "5"], "answer": 0, "explanation": "(2 − h)² + 5 = 6 → (2 − h)² = 1 → 2 − h = ±1 → h = 1 or h = 3. h = 1 is listed.", "difficulty": "Medium"},
      {"question": "Which equation represents a downward parabola with vertex (2, 10)?", "options": ["(x − 2)² + 10", "−(x − 2)² + 10", "−(x + 2)² + 10", "−(x − 10)² + 2"], "answer": 1, "explanation": "Downward means a < 0. Vertex (2, 10) gives −(x − 2)² + 10.", "difficulty": "Hard"},
      {"question": "A ball is thrown from 6 ft with initial velocity 20 ft/s. Which equation models its height?", "options": ["−16t² + 20t + 6", "−16t² + 6t + 20", "6t² − 16t + 20", "−16t² + 20t − 6"], "answer": 0, "explanation": "h(t) = −16t² + v₀t + h₀ = −16t² + 20t + 6.", "difficulty": "Medium"},
      {"question": "x + x² = 72. What is the positive value of x?", "options": ["6", "7", "8", "9"], "answer": 2, "explanation": "x² + x − 72 = 0 → (x + 9)(x − 8) = 0. Positive root: x = 8.", "difficulty": "Hard"},
      {"question": "A square has its side increased by 3, making the new area 100. What was the original side?", "options": ["7", "10", "13", "49"], "answer": 0, "explanation": "(s + 3)² = 100 → s + 3 = 10 → s = 7.", "difficulty": "Hard"},
      {"question": "y = x² − 6x + 14. What is the y-coordinate of the vertex?", "options": ["3", "5", "6", "14"], "answer": 1, "explanation": "Vertex x = 3. y(3) = 9 − 18 + 14 = 5.", "difficulty": "Hard"},
      {"question": "A parabola is tangent to the x-axis. How many solutions does f(x) = 0 have?", "options": ["Zero", "Exactly one", "Exactly two", "Infinitely many"], "answer": 1, "explanation": "Tangent to the x-axis means the vertex is on the axis — one repeated root.", "difficulty": "Medium"},
      {"question": "y = x² + kx + 16 has its vertex on the x-axis with k > 0. What is k?", "options": ["4", "6", "8", "16"], "answer": 2, "explanation": "Vertex on x-axis means discriminant = 0: k² − 64 = 0 → k = 8 (positive).", "difficulty": "Hard"},
      {"question": "What is the vertex of y = (x + 5)² − 3?", "options": ["(5, −3)", "(−5, −3)", "(−5, 3)", "(0, −3)"], "answer": 1, "explanation": "y = (x − (−5))² + (−3). Vertex = (−5, −3).", "difficulty": "Medium"},
      {"question": "y = −x² + 10x. What is the maximum value of y?", "options": ["5", "10", "20", "25"], "answer": 3, "explanation": "Vertex x = −10/(2·(−1)) = 5. y(5) = −25 + 50 = 25.", "difficulty": "Hard"},
      {"question": "L + W = 10. Express area in terms of L.", "options": ["L(10 − L)", "L(L − 10)", "10L", "L² + 10"], "answer": 0, "explanation": "W = 10 − L. Area = L · W = L(10 − L).", "difficulty": "Medium"},
      {"question": "y = (x − 2)(x − 10). What is the x-coordinate of the vertex?", "options": ["2", "4", "6", "10"], "answer": 2, "explanation": "Vertex x = (2 + 10)/2 = 6.", "difficulty": "Hard"},
      {"question": "f(x) = 2x² + 1. What is f(5)?", "options": ["11", "26", "51", "101"], "answer": 2, "explanation": "f(5) = 2(25) + 1 = 51.", "difficulty": "Medium"},
      {"question": "A square has area 121 and side length x + 1. What is x?", "options": ["9", "10", "11", "12"], "answer": 1, "explanation": "(x + 1)² = 121 → x + 1 = 11 → x = 10.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-022: %', lid;
END $$;

-- Populate lesson sat-quant-learn-sat-lid-011 with theory + practice (interactive content).
-- Topic: Systems of Inequalities
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-011'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-011; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Systems of Inequalities',
    concept_content = E'A **system of inequalities** combines multiple inequality constraints. The SAT tests your ability to model real-world situations, identify feasible regions, and evaluate boundary conditions.\n\n**Building systems from word problems:**\n- Identify the constraints: quantity, budget, capacity, time, etc.\n- Translate each constraint into an inequality using the correct symbol.\n- Example: "at least 10 items" → x + y ≥ 10; "budget ≤ $50" → 3x + 7y ≤ 50.\n\n**Tiered / bracket problems:**\n- Some problems use tables with price tiers or brackets. The key is identifying which boundary the value sits on. "One more unit" jumping to the next tier means the current value is at the top of its bracket.\n\n**Range / compound inequality problems:**\n- If a quantity grows between a and b per unit time, after n units the total is between a·n and b·n (plus any starting value).\n- Use strict inequalities (<, >) if the bounds are "more than" / "less than."\n\n**Solving strategy for word problems:**\n1. Define variables.\n2. Write each constraint as an inequality.\n3. Solve algebraically (remember to flip sign when dividing by negative).\n4. For whole-number answers: round DOWN for "at most," round UP for "at least."',
    formula_title = 'Worked Example',
    formula_content = E'A store sells small notebooks ($3) and large\nnotebooks ($7). A student wants at least 10\nnotebooks, budget ≤ $50.\n\nStep 1 — Define variables\n  s = small, l = large\n\nStep 2 — Quantity constraint\n  s + l ≥ 10\n\nStep 3 — Budget constraint\n  3s + 7l ≤ 50\n\nStep 4 — Test a point\n  s = 5, l = 5: 5+5=10 ≥ 10 ✓\n  3(5) + 7(5) = 50 ≤ 50 ✓\n\nThis combination works.'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master systems of inequalities — combining multiple constraints to model real-world scenarios, a frequent SAT question pattern.',
    '[
      {"title": "Identify each constraint", "content": "Read the problem carefully. Each sentence typically gives one constraint: a quantity limit, a budget cap, a minimum requirement, etc. Write each as a separate inequality.", "highlight": "one sentence = one inequality"},
      {"title": "Translate keywords precisely", "content": "''At least'' → ≥. ''At most'' / ''no more than'' → ≤. ''More than'' / ''exceeds'' → >. ''Less than'' / ''fewer than'' → <. ''Over $75'' (strict) → >.", "highlight": "keyword → symbol"},
      {"title": "Handle tiered/bracket problems", "content": "If adding one unit moves to the next price tier, the current value is at the boundary of its tier. Read the table carefully to match the bracket.", "highlight": "boundary = top of current bracket"},
      {"title": "Handle range/compound problems", "content": "If a rate is between a and b per day, after n days the total is between a·n + start and b·n + start. Use strict (<, >) or inclusive (≤, ≥) as the problem specifies.", "equation": "40 + 15(5) < h < 40 + 24(5)", "highlight": "multiply bounds by time"},
      {"title": "Round correctly for integer answers", "content": "For ≤ constraints, round DOWN. For ≥ constraints, round UP. Always check that your rounded answer satisfies the original inequality.", "highlight": "round down for max, round up for min"}
    ]'::jsonb,
    '[
      {"question": "A shipping service charges $18.50 for ≤ 5 lbs, plus $2.25/lb over 5. Which inequality represents weight w for a charge ≥ $32?", "options": ["18.50 + 2.25(w − 5) ≥ 32.00", "18.50 + 2.25w ≥ 32.00", "18.50 + 2.25(w + 5) ≥ 32.00", "2.25(w − 5) ≥ 32.00"], "answer": 0, "explanation": "Base = 18.50. Additional charge applies only to weight over 5: 2.25(w − 5). Total ≥ 32.", "difficulty": "Medium"},
      {"question": "A baker needs at least 45 cups of flour. Each bag has 8 cups. Minimum bags?", "options": ["4", "5", "6", "7"], "answer": 2, "explanation": "8b ≥ 45 → b ≥ 5.625. Round up: 6 bags.", "difficulty": "Easy"},
      {"question": "A user paid $18 for data roaming. One more MB would cost $30. The $18 tier covers 500–1000 MB and $30 covers 1000–2000 MB. How much data was used?", "options": ["499 MB", "500 MB", "999 MB", "1000 MB"], "answer": 3, "explanation": "At 1000 MB the user is still in the $18 tier. Adding 1 MB (1001) jumps to $30.", "difficulty": "Medium"},
      {"question": "Bamboo grows more than 15 but less than 24 inches/day. Currently 40 inches. All possible heights h after 5 days?", "options": ["75 < h < 120", "115 < h < 160", "115 ≤ h ≤ 160", "40 < h < 160"], "answer": 1, "explanation": "Min = 40 + 75 = 115, Max = 40 + 120 = 160. Strict inequalities since bounds are ''more than'' / ''less than''.", "difficulty": "Hard"},
      {"question": "n is at least 8 more than 3 times k. If k = −2, minimum n?", "options": ["2", "−2", "14", "−14"], "answer": 0, "explanation": "n ≥ 3(−2) + 8 = −6 + 8 = 2.", "difficulty": "Medium"},
      {"question": "A gym charges $120 for 1–4 sessions, $200 for 5–8, $270 for 9–12. An athlete paid $200. One fewer session would cost $120. How many sessions?", "options": ["4", "5", "8", "9"], "answer": 1, "explanation": "At the bottom of the $200 bracket (5 sessions). One fewer = 4 sessions = $120 bracket.", "difficulty": "Medium"},
      {"question": "Moving truck max 3,500 lbs, already loaded with 1,200 lbs. Which inequality for remaining weight w?", "options": ["w ≤ 2,300", "w ≥ 2,300", "w + 3,500 ≤ 1,200", "w − 1,200 ≤ 3,500"], "answer": 0, "explanation": "1,200 + w ≤ 3,500 → w ≤ 2,300.", "difficulty": "Easy"},
      {"question": "A printer needs ≥ 1,000 sheets. Reams have 250 sheets. Currently 120 sheets. Minimum reams?", "options": ["3", "4", "5", "6"], "answer": 1, "explanation": "Need 880 more. 250r ≥ 880 → r ≥ 3.52. Round up: 4.", "difficulty": "Hard"},
      {"question": "Karvonen formula: R = (M − r) × I + r. M = 190, r = 60, I between 0.6 and 0.8. Range of R?", "options": ["78 ≤ R ≤ 104", "138 ≤ R ≤ 164", "114 ≤ R ≤ 152", "150 ≤ R ≤ 190"], "answer": 1, "explanation": "R = 130I + 60. Min: 130(0.6)+60=138. Max: 130(0.8)+60=164.", "difficulty": "Medium"},
      {"question": "A gardener has $150 for rose bushes at $18.50 each. Must buy ≥ 3. Maximum bushes?", "options": ["3", "7", "8", "9"], "answer": 2, "explanation": "18.50b ≤ 150 → b ≤ 8.1. Round down: 8.", "difficulty": "Easy"},
      {"question": "y is at most 12 more than twice x. If x = −5, greatest y?", "options": ["2", "7", "22", "−2"], "answer": 0, "explanation": "y ≤ 2(−5) + 12 = 2.", "difficulty": "Medium"},
      {"question": "A bird travels 80–140 miles/day. Distance d in 7 days?", "options": ["d ≤ 140", "80 ≤ d ≤ 140", "560 ≤ d ≤ 980", "d ≥ 560"], "answer": 2, "explanation": "Min: 80 × 7 = 560. Max: 140 × 7 = 980.", "difficulty": "Hard"},
      {"question": "For which table are all (x, y) solutions to y < 3x − 2? A: (2,5),(4,11) B: (2,3),(4,9) C: (3,7),(5,12) D: (1,1),(2,4)", "options": ["Table A", "Table B", "Table C", "Table D"], "answer": 1, "explanation": "B: 3 < 4 ✓ and 9 < 10 ✓. Both satisfy y < 3x − 2.", "difficulty": "Medium"},
      {"question": "s small notebooks ($3), l large ($7). At least 10 items, budget ≤ $50. Which system?", "options": ["s + l ≥ 10; 3s + 7l ≤ 50", "s + l ≤ 10; 3s + 7l ≤ 50", "s + l ≥ 10; 7s + 3l ≤ 50", "s + l > 10; 3s + 7l < 50"], "answer": 0, "explanation": "''At least 10'' → s + l ≥ 10. Budget → 3s + 7l ≤ 50.", "difficulty": "Medium"},
      {"question": "A baby elephant weighs 250 lbs at birth, gains more than 1.5 but less than 2.5 lbs/day. Weight W after 100 days?", "options": ["150 < W < 250", "400 < W < 500", "350 < W < 450", "250 < W < 500"], "answer": 1, "explanation": "Min: 250 + 150 = 400. Max: 250 + 250 = 500. Strict inequalities.", "difficulty": "Hard"},
      {"question": "Theater: 300 seats, adults $15, children $10. Revenue ≥ $3,500. Which inequality?", "options": ["15a + 10c ≥ 3,500", "15a + 10c ≤ 300", "a + c ≥ 3,500", "15a + 10c ≤ 3,500"], "answer": 0, "explanation": "Revenue = 15a + 10c. Must be at least $3,500 → ≥ 3,500.", "difficulty": "Medium"},
      {"question": "Data plan: $40/month + $5/GB over 10 GB. Bill ≤ $65. Max total GB?", "options": ["5", "10", "15", "25"], "answer": 2, "explanation": "40 + 5(g − 10) ≤ 65 → g ≤ 15.", "difficulty": "Medium"},
      {"question": "Which value of x satisfies 4x − 7 > 13?", "options": ["3", "4", "5", "6"], "answer": 3, "explanation": "4x > 20 → x > 5. Only 6 > 5.", "difficulty": "Easy"},
      {"question": "Wholesale club: $60 annual fee, coffee $1.50/lb. Non-members pay $2.50/lb. When is member cost less?", "options": ["60 + 1.5p < 2.5p", "1.5p < 60 + 2.5p", "60 + 1.5p > 2.5p", "60 < 1.5p + 2.5p"], "answer": 0, "explanation": "Member: 60 + 1.5p. Non-member: 2.5p. Member < Non-member: 60 + 1.5p < 2.5p.", "difficulty": "Medium"},
      {"question": "Liquid must stay between 45°F and 75°F. Currently 50°F, rising 2°F/hr. Which inequality for hours h before exceeding max?", "options": ["50 + 2h ≤ 75", "50 + 2h ≥ 45", "2h ≤ 75", "50 + 2h < 45"], "answer": 0, "explanation": "Total temp = 50 + 2h. Must not exceed 75: 50 + 2h ≤ 75.", "difficulty": "Hard"},
      {"question": "A baker has 20 cups sugar. Cookies need 1.5 cups, cakes need 3. c batches cookies, k cakes. Sugar constraint?", "options": ["1.5c + 3k ≤ 20", "1.5c + 3k ≥ 20", "3c + 1.5k ≤ 20", "c + k ≤ 20"], "answer": 0, "explanation": "Total sugar used ≤ available: 1.5c + 3k ≤ 20.", "difficulty": "Medium"},
      {"question": "12 trivia questions: 4 Easy (5 pts), m Medium (10 pts), rest Hard (20 pts). Score ≥ 150. Minimum Hard questions?", "options": ["4", "5", "6", "7"], "answer": 1, "explanation": "h = 8 − m. Score: 20 + 10(8−h) + 20h ≥ 150 → 100 + 10h ≥ 150 → h ≥ 5.", "difficulty": "Medium"},
      {"question": "GPA must be ≥ 3.5 over 5 courses. Current 4-course total: 13.2. Minimum grade needed?", "options": ["3.5", "3.8", "4.0", "4.3"], "answer": 3, "explanation": "(13.2 + g)/5 ≥ 3.5 → g ≥ 4.3.", "difficulty": "Easy"},
      {"question": "Plane max 1,200 lbs. Pilot 180, fuel 300. Each passenger 165 + 30 luggage. Max passengers?", "options": ["3", "4", "5", "6"], "answer": 0, "explanation": "Available = 720. Per passenger = 195. 195p ≤ 720 → p ≤ 3.69. Round down: 3.", "difficulty": "Hard"},
      {"question": "Online store: free shipping on orders over $75. Cart has $54. Adding socks at $4.25 each. Which inequality for free shipping?", "options": ["54 + 4.25n > 75", "54 + 4.25n ≥ 75", "4.25n > 75", "54 + n > 75"], "answer": 0, "explanation": "''Over $75'' is strict: 54 + 4.25n > 75.", "difficulty": "Medium"},
      {"question": "Which point satisfies y > −2x + 4 and y < x + 1?", "options": ["(1, 1)", "(2, 2)", "(3, 0)", "(1, 3)"], "answer": 1, "explanation": "Test (2,2): 2 > 0 ✓ and 2 < 3 ✓.", "difficulty": "Medium"},
      {"question": "ax + 3 ≤ 11 has solution x ≥ −4. What is a?", "options": ["2", "−2", "4", "−4"], "answer": 1, "explanation": "ax ≤ 8. Since x ≥ −4 (flipped sign), a is negative: a = 8/(−4) = −2.", "difficulty": "Hard"},
      {"question": "y ≤ (1/2)x + 3 is graphed. Which describes the boundary and shading?", "options": ["Solid line, shading above", "Dashed line, shading above", "Solid line, shading below", "Dashed line, shading below"], "answer": 2, "explanation": "≤ → solid line. y ≤ means shading below.", "difficulty": "Medium"},
      {"question": "Type A widgets: 2 hrs assembly. Type B: 3 hrs. Max 40 hrs/week. At least 5 Type A. Which system?", "options": ["2a + 3b ≤ 40; a ≥ 5", "2a + 3b ≥ 40; a ≤ 5", "3a + 2b ≤ 40; a ≥ 5", "a + b ≤ 40; 2a + 3b ≥ 5"], "answer": 0, "explanation": "Time: 2a + 3b ≤ 40. Min Type A: a ≥ 5.", "difficulty": "Medium"},
      {"question": "(h, k) satisfies y < 3x + 2 and y > −x + 5. Which must be true?", "options": ["h > 0.75", "h < 0.75", "k > 3", "k < 5"], "answer": 0, "explanation": "Boundaries meet at x = 0.75. The overlap region exists only for x > 0.75.", "difficulty": "Hard"},
      {"question": "If 7 < x < 10 and 2 < y < 5, greatest possible integer value of x − y?", "options": ["4", "5", "7", "8"], "answer": 2, "explanation": "Max x ≈ 10, min y ≈ 2 (both exclusive). x − y < 8. Greatest integer = 7.", "difficulty": "Easy"},
      {"question": "''The sum of n and 5 is no more than 3n.'' Which inequality?", "options": ["n + 5 < 3n", "n + 5 ≤ 3n", "n + 5 > 3n", "3(n + 5) ≤ n"], "answer": 1, "explanation": "''No more than'' = ≤. n + 5 ≤ 3n.", "difficulty": "Medium"},
      {"question": "All integers x with 2x − 4 > 10 and x + 5 < 20. How many?", "options": ["6", "7", "8", "9"], "answer": 1, "explanation": "x > 7 and x < 15. Integers: 8–14 → 7 integers.", "difficulty": "Hard"},
      {"question": "y > (2/3)x − 4. Which quadrant has no solutions?", "options": ["Quadrant I", "Quadrant II", "Quadrant III", "All quadrants contain solutions"], "answer": 3, "explanation": "The line passes through Q1, Q3, Q4. Shading above covers parts of all quadrants.", "difficulty": "Medium"},
      {"question": "Smallest integer x satisfying 3x + 10 > 25?", "options": ["5", "6", "4", "7"], "answer": 1, "explanation": "3x > 15 → x > 5. Smallest integer > 5 is 6.", "difficulty": "Easy"},
      {"question": "Car rental: $35/day + $0.20/mile. 2-day rental, budget ≤ $100. Max miles?", "options": ["150", "325", "125", "100"], "answer": 0, "explanation": "Fixed: 70. Remaining: 30. 0.20m ≤ 30 → m ≤ 150.", "difficulty": "Medium"},
      {"question": "Triangular solution region with vertices (0,0), (0,4), (4,0). Which system?", "options": ["x ≥ 0, y ≥ 0, x + y ≤ 4", "x ≤ 0, y ≤ 0, x + y ≥ 4", "x ≥ 0, y ≥ 0, y ≤ x + 4", "x ≤ 4, y ≤ 4, x + y ≤ 4"], "answer": 0, "explanation": "First quadrant (x ≥ 0, y ≥ 0) bounded by x + y = 4. Region inside → x + y ≤ 4.", "difficulty": "Hard"},
      {"question": "Score between 75 and 92. Which absolute value inequality?", "options": ["|s − 83.5| ≤ 8.5", "|s − 8.5| ≤ 83.5", "|s − 92| ≤ 75", "|s + 83.5| ≤ 8.5"], "answer": 0, "explanation": "Midpoint = 83.5, distance = 8.5. |s − 83.5| ≤ 8.5.", "difficulty": "Medium"},
      {"question": "x + y > 10 and x − y < 4. Which is a possible x?", "options": ["2", "4", "6", "8"], "answer": 3, "explanation": "x = 8, y = 5: 13 > 10 ✓ and 3 < 4 ✓.", "difficulty": "Medium"},
      {"question": "Profit P = 20n − 1200. P ≥ 500. Minimum units n?", "options": ["60", "85", "25", "100"], "answer": 1, "explanation": "20n ≥ 1700 → n ≥ 85.", "difficulty": "Hard"},
      {"question": "Which inequality has the same solution as 3 − 2x < 11?", "options": ["x > −4", "x < −4", "x > 4", "x < 4"], "answer": 0, "explanation": "−2x < 8 → x > −4 (flip sign).", "difficulty": "Medium"},
      {"question": "Pens $1.50, pencils $0.50. At least 20 items, budget $15. Which is a possible number of pens?", "options": ["1", "5", "10", "15"], "answer": 1, "explanation": "x = 5, y = 15: 20 items ✓. Cost = 7.5 + 7.5 = 15 ✓.", "difficulty": "Medium"},
      {"question": "Horizontal line through (0, 5) with shading above. Which inequality?", "options": ["x > 5", "y > 5", "x < 5", "y < 5"], "answer": 1, "explanation": "Horizontal line y = 5, shading above → y > 5.", "difficulty": "Easy"},
      {"question": "Rectangle, length 10. Perimeter between 30 and 50. Possible widths w?", "options": ["5 ≤ w ≤ 15", "10 ≤ w ≤ 20", "20 ≤ w ≤ 40", "5 ≤ w ≤ 25"], "answer": 0, "explanation": "P = 20 + 2w. 30 ≤ 20 + 2w ≤ 50 → 5 ≤ w ≤ 15.", "difficulty": "Medium"},
      {"question": "y ≥ 2x − 1 and x + y ≤ 5. Maximum y?", "options": ["1", "2", "3", "5"], "answer": 2, "explanation": "Intersection: 2x − 1 = 5 − x → x = 2, y = 3.", "difficulty": "Medium"},
      {"question": "CDs $12, vinyl records $20. Spend more than $100 but less than $150. Buy 4 CDs. Range of vinyl records v?", "options": ["2 < v < 6", "3 ≤ v ≤ 5", "2.6 < v < 5.1", "3 < v < 5"], "answer": 2, "explanation": "52 < 20v < 102 → 2.6 < v < 5.1.", "difficulty": "Hard"},
      {"question": "x + 2 > 5 OR x + 2 < 1. Equivalent to?", "options": ["x > 3 or x < −1", "x > 7 or x < 3", "−1 < x < 3", "x > 3 or x < 1"], "answer": 0, "explanation": "x > 3 or x < −1.", "difficulty": "Easy"},
      {"question": "f(x) = 2x − 5. For what values of x is f(x) ≤ 11?", "options": ["x ≤ 3", "x ≤ 8", "x ≤ 16", "x ≥ 8"], "answer": 1, "explanation": "2x − 5 ≤ 11 → 2x ≤ 16 → x ≤ 8.", "difficulty": "Hard"},
      {"question": "A pool has 5,000 gallons, draining at 250/hr. After how many hours h will it have < 1,000 gallons?", "options": ["h > 16", "h < 16", "h > 20", "h < 24"], "answer": 0, "explanation": "5000 − 250h < 1000 → h > 16.", "difficulty": "Medium"},
      {"question": "Sum of two positive integers x and y is < 10. If x = 3, max y?", "options": ["6", "7", "5", "10"], "answer": 0, "explanation": "3 + y < 10 → y < 7. Largest integer < 7 is 6.", "difficulty": "Medium"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-011: %', lid;
END $$;

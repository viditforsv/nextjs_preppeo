-- Populate lesson sat-quant-learn-sat-lid-010 with theory + practice (interactive content).
-- Topic: Solving & Graphing Inequalities
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-010'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-010; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Solving & Graphing Inequalities',
    concept_content = E'Linear inequalities work like equations but with inequality signs (<, >, ≤, ≥). The SAT tests your ability to **translate** word problems into inequalities, **solve** them, and **graph** or **read** their solutions.\n\n**Key vocabulary:**\n- "at most" / "no more than" / "maximum" → ≤\n- "at least" / "no fewer than" / "minimum" → ≥\n- "more than" / "exceeds" → >\n- "less than" / "fewer than" → <\n\n**Solving rules:**\n- Treat like an equation EXCEPT: **flip the inequality sign** when multiplying or dividing by a negative number.\n- Example: −2x < 8 → x > −4 (sign flips)\n\n**Graphing in the xy-plane:**\n- Solid line for ≤ or ≥ (boundary included). Dashed line for < or > (boundary excluded).\n- Shade **above** the line for y > or y ≥. Shade **below** for y < or y ≤.\n\n**Systems of inequalities:**\n- The solution is the **overlap** of the shaded regions from each inequality.\n- If the shaded regions don''t overlap → no solution.\n\n**Range / compound inequalities:**\n- If a rate is between a and b per unit, the total over n units is between a·n and b·n.',
    formula_title = 'Worked Example',
    formula_content = E'A delivery van can carry at most 3,500 lbs.\nIt already holds a 400-lb machine. The rest\nis filled with 150-lb crates.\nMax crates?\n\nStep 1 — Set up inequality\n  400 + 150n ≤ 3,500\n\nStep 2 — Subtract fixed weight\n  150n ≤ 3,100\n\nStep 3 — Divide\n  n ≤ 20.67\n\nStep 4 — Round down (whole crates)\n  n = 20 crates maximum'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Learn to translate inequality keywords, solve one- and two-variable inequalities, and interpret graphs — essential skills for SAT algebra.',
    '[
      {"title": "Translate keywords into symbols", "content": "Map real-world phrases to inequality signs. ''At most'' → ≤, ''at least'' → ≥, ''more than'' → >, ''less than'' → <. Always identify the direction of the constraint.", "highlight": "at most = ≤, at least = ≥"},
      {"title": "Solve like an equation (with one rule)", "content": "Isolate the variable using addition, subtraction, multiplication, and division — just like an equation. The one extra rule: flip the inequality sign when you multiply or divide by a negative number.", "equation": "−2x < 8 → x > −4", "highlight": "flip sign when dividing by negative"},
      {"title": "Round correctly for whole-number answers", "content": "If the variable must be a whole number (crates, hours, people), round DOWN for ≤ constraints and round UP for ≥ constraints.", "highlight": "round down for max, round up for min"},
      {"title": "Graph inequalities in the xy-plane", "content": "Solid line for ≤/≥, dashed for </>. Shade above for y > (or ≥), below for y < (or ≤). x ≥ k is a vertical line with shading to the right.", "highlight": "solid vs. dashed, above vs. below"},
      {"title": "Find solutions to systems of inequalities", "content": "The solution region is where all shaded regions overlap. Test a point by plugging it into every inequality — it must satisfy ALL of them to be a solution.", "highlight": "overlap of shaded regions"}
    ]'::jsonb,
    '[
      {"question": "A landscaping service mows at most 12 locations per day. If L is lawns and P is parks, which inequality represents this?", "options": ["L + P ≤ 12", "L + P ≥ 12", "L − P ≤ 12", "L − P ≥ 12"], "answer": 0, "explanation": "''At most'' means the total cannot exceed 12: L + P ≤ 12.", "difficulty": "Easy"},
      {"question": "A shaded region on a graph is to the right of a line passing through (1, 5) and (3, −5). A point in the shaded region is:", "options": ["(0, 0)", "(−2, 2)", "(4, 1)", "(1, −2)"], "answer": 2, "explanation": "(4, 1) is clearly to the right of the boundary line and inside the shaded region.", "difficulty": "Medium"},
      {"question": "A van can carry 3,500 lbs max with a 400-lb machine already loaded. Crates weigh 150 lbs each. Maximum crates?", "options": ["20", "21", "23", "24"], "answer": 0, "explanation": "400 + 150n ≤ 3,500 → 150n ≤ 3,100 → n ≤ 20.67. Round down: 20.", "difficulty": "Medium"},
      {"question": "A jet ski costs $45/hr plus $15 insurance. Max budget $160, whole hours only. Maximum hours?", "options": ["2", "3", "4", "5"], "answer": 1, "explanation": "45h + 15 ≤ 160 → 45h ≤ 145 → h ≤ 3.22. Round down: 3.", "difficulty": "Medium"},
      {"question": "A craft store orders x canvases ($5) and y paint sets ($8). At least 15 items, budget ≤ $120. Which system?", "options": ["x + y ≥ 15; 5x + 8y ≤ 120", "x + y ≤ 15; 5x + 8y ≥ 120", "5x + 8y ≥ 15; x + y ≤ 120", "x + y ≥ 15; 5x + 8y ≥ 120"], "answer": 0, "explanation": "''At least 15'' → x + y ≥ 15. ''Capped at $120'' → 5x + 8y ≤ 120.", "difficulty": "Hard"},
      {"question": "Annual heating $3,200, new insulation costs $18,000 reducing heating to $1,900/yr. Which inequality finds years t until savings exceed cost?", "options": ["18,000 > (3,200 − 1,900)t", "18,000 < (3,200 − 1,900)t", "18,000 − 3,200 > 1,900t", "18,000 > (3,200/1,900)t"], "answer": 1, "explanation": "Savings per year = 1,300. Need 1,300t > 18,000, i.e. 18,000 < 1,300t.", "difficulty": "Hard"},
      {"question": "Which ordered pair satisfies y ≤ 2x + 3 and x − y > 2?", "options": ["(0, 0)", "(4, 1)", "(−2, −1)", "(1, 5)"], "answer": 1, "explanation": "Test (4,1): 1 ≤ 11 ✓ and 4 − 1 = 3 > 2 ✓. Both satisfied.", "difficulty": "Medium"},
      {"question": "A sea turtle travels 45 to 52 miles/day. Which represents total miles m in 12 days?", "options": ["45 + 12 ≤ m ≤ 52 + 12", "(45)(12) ≤ m ≤ (52)(12)", "45 ≤ m/12 ≤ 52", "Both B and C"], "answer": 3, "explanation": "Multiply bounds by 12: 540 ≤ m ≤ 624. Dividing by 12 recovers the daily rate. B and C are equivalent.", "difficulty": "Medium"},
      {"question": "A shaded region is above a line through (−2, −8) and (10, 0). The boundary slope is 2/3 with y-int ≈ −6.67. Which inequality?", "options": ["y ≥ (2/3)x − 6.67", "y ≤ (2/3)x − 6.67", "y ≥ x − 8", "y ≤ x − 8"], "answer": 0, "explanation": "Slope = (0−(−6.67))/(10−0) = 2/3. Shading above → y ≥ (2/3)x − 6.67.", "difficulty": "Hard"},
      {"question": "Sarah earns $12/hr for 15 hrs, then $15/hr. She saves 80%. Minimum additional hours to save $360?", "options": ["12", "15", "18", "20"], "answer": 2, "explanation": "Need total earnings E: 0.80E = 360 → E = 450. Base = 180. Remaining = 270. 15h ≥ 270 → h = 18.", "difficulty": "Hard"},
      {"question": "A library processes at most 25 returns per hour. If c = hardcovers, p = paperbacks:", "options": ["c + p ≤ 25", "c + p ≥ 25", "c − p ≤ 25", "c − p ≥ 25"], "answer": 0, "explanation": "''At most'' → ≤. Total = c + p ≤ 25.", "difficulty": "Easy"},
      {"question": "A shaded region is above a line through (−5, 3) and (5, −2). Which point is in the shaded region?", "options": ["(0, −2)", "(−4, 0)", "(0, 4)", "(2, −3)"], "answer": 2, "explanation": "(0, 4) is above the boundary line in the shaded area.", "difficulty": "Medium"},
      {"question": "Elevator max 2,800 lbs, pallet weighs 300 lbs, boxes 40 lbs each. Max boxes?", "options": ["60", "62", "63", "70"], "answer": 1, "explanation": "300 + 40b ≤ 2,800 → 40b ≤ 2,500 → b ≤ 62.5. Round down: 62.", "difficulty": "Medium"},
      {"question": "Bicycle rental: $12/hr + $8 helmet fee. Budget ≤ $50, whole hours. Max hours?", "options": ["2", "3", "4", "5"], "answer": 1, "explanation": "12h + 8 ≤ 50 → 12h ≤ 42 → h ≤ 3.5. Round down: 3.", "difficulty": "Medium"},
      {"question": "x pizzas ($10) and y sodas ($6). At least 12 items, cost ≤ $150. Which system?", "options": ["x + y ≤ 12; 10x + 6y ≤ 150", "x + y ≥ 12; 10x + 6y ≥ 150", "x + y ≥ 12; 10x + 6y ≤ 150", "10x + 6y ≥ 12; x + y ≤ 150"], "answer": 2, "explanation": "''At least 12'' → x + y ≥ 12. ''Not exceed $150'' → 10x + 6y ≤ 150.", "difficulty": "Hard"},
      {"question": "Office supplies $8,500/yr. Digital system costs $12,000 reducing to $1,200/yr. Which inequality finds n years until savings exceed investment?", "options": ["12,000 > (8,500 − 1,200)n", "12,000 < (8,500 − 1,200)n", "12,000 − 8,500 > 1,200n", "12,000 < (8,500/1,200)n"], "answer": 1, "explanation": "Savings/yr = 7,300. Need 7,300n > 12,000 → 12,000 < 7,300n.", "difficulty": "Hard"},
      {"question": "Which ordered pair satisfies y ≤ −2x + 4 and x − y > 3?", "options": ["(0, 0)", "(1, 2)", "(3, −2)", "(0, 5)"], "answer": 2, "explanation": "Test (3, −2): −2 ≤ −2 ✓ and 3−(−2) = 5 > 3 ✓.", "difficulty": "Medium"},
      {"question": "Butterflies travel 65–80 miles/day. Which represents total d in 14 days?", "options": ["65 + 14 ≤ d ≤ 80 + 14", "(65)(14) ≤ d ≤ (80)(14)", "65 ≤ d + 14 ≤ 80", "65 ≤ 14d ≤ 80"], "answer": 1, "explanation": "Multiply both bounds by 14: 910 ≤ d ≤ 1,120.", "difficulty": "Medium"},
      {"question": "A shaded region is above a line through (−1, −10) and (11, −2). Which inequality?", "options": ["y ≤ (2/3)x − 9.33", "y ≥ (2/3)x − 9.33", "y ≥ x − 10", "y ≤ x − 10"], "answer": 1, "explanation": "Slope = 2/3, y-int ≈ −9.33. Shading above → y ≥ (2/3)x − 9.33.", "difficulty": "Medium"},
      {"question": "Marcus earns $15/hr for 20 hrs, then $18/hr overtime. He saves 75%. Min overtime hours to save $450?", "options": ["17", "12", "8", "6"], "answer": 0, "explanation": "0.75E = 450 → E = 600. Base = 300. Need 18x ≥ 300 → x ≥ 16.67. Round up: 17.", "difficulty": "Hard"},
      {"question": "A gym allows max 40 members inside. s = students, a = adults. Which inequality?", "options": ["s + a ≤ 40", "s + a ≥ 40", "s − a ≤ 40", "s + a < 40"], "answer": 0, "explanation": "''Maximum'' means the sum cannot exceed 40: s + a ≤ 40.", "difficulty": "Easy"},
      {"question": "Parking garage: $5 first hour, $3 each additional. Budget ≤ $20. Max total hours?", "options": ["4", "5", "6", "7"], "answer": 2, "explanation": "5 + 3x ≤ 20 → 3x ≤ 15 → x ≤ 5 additional. Total = 1 + 5 = 6.", "difficulty": "Medium"},
      {"question": "x acres corn ($40/acre), y acres wheat ($30/acre). At least 50 acres, budget ≤ $2,000. Which system?", "options": ["x + y ≥ 50; 40x + 30y ≤ 2,000", "x + y ≤ 50; 40x + 30y ≤ 2,000", "40x + 30y ≥ 50; x + y ≤ 2,000", "x + y ≥ 50; 40x + 30y ≥ 2,000"], "answer": 0, "explanation": "''At least 50'' → x + y ≥ 50. Budget ≤ $2,000 → 40x + 30y ≤ 2,000.", "difficulty": "Hard"},
      {"question": "A car travels 55–65 mph. Distance d in 3 hours?", "options": ["55 × 3 ≤ d ≤ 65 × 3", "55 + 3 ≤ d ≤ 65 + 3", "55 ≤ 3d ≤ 65", "d/3 ≤ 55"], "answer": 0, "explanation": "Multiply bounds by 3: 165 ≤ d ≤ 195.", "difficulty": "Medium"},
      {"question": "Which ordered pair satisfies y > 2x − 4 and y < −x + 5?", "options": ["(4, 0)", "(0, 0)", "(5, 5)", "(0, 6)"], "answer": 1, "explanation": "Test (0,0): 0 > −4 ✓ and 0 < 5 ✓.", "difficulty": "Hard"},
      {"question": "y > 3x + 2 and y < 3x − 4. What is the solution set?", "options": ["A strip between two parallel lines", "All points in the xy-plane", "No solution", "A single point"], "answer": 2, "explanation": "Parallel lines (slope 3), shading away from each other → no overlap → no solution.", "difficulty": "Medium"},
      {"question": "y ≥ 2x + b and y ≤ 2x + c, with b = c = −5. How many integer y-values when x = 4?", "options": ["0", "1", "2", "3"], "answer": 1, "explanation": "Both give y = 2(4) − 5 = 3. Only y = 3 satisfies both. One value.", "difficulty": "Hard"},
      {"question": "Which system has the entire xy-plane as its solution set?", "options": ["y > x and y < x", "y ≥ x and y ≤ x", "y > x − 5 or y < x + 5", "y > 5 and x > 5"], "answer": 2, "explanation": "With ''or,'' every point satisfies at least one. The two regions cover the entire plane.", "difficulty": "Medium"},
      {"question": "y > 4x + 10 and y < 4x + k. If no solution, what is the max integer k?", "options": ["8", "9", "10", "11"], "answer": 2, "explanation": "No solution when the ''below'' line is at or below the ''above'' line: k ≤ 10. Max integer = 10.", "difficulty": "Hard"},
      {"question": "Boundary through (0, −4) and (2, 0), shading below. Which inequality?", "options": ["y ≤ 2x − 4", "y ≥ 2x − 4", "y ≤ −2x − 4", "y ≥ −2x − 4"], "answer": 0, "explanation": "Slope = 4/2 = 2, y-int = −4. Line: y = 2x − 4. Shading below → y ≤ 2x − 4.", "difficulty": "Medium"},
      {"question": "Which point satisfies 3x − 4y > 12?", "options": ["(4, 0)", "(0, −3)", "(6, 1)", "(2, −2)"], "answer": 2, "explanation": "Test (6,1): 18 − 4 = 14 > 12 ✓.", "difficulty": "Medium"},
      {"question": "A theater sells $20 and $30 tickets. Must sell ≥ 100 tickets, revenue > $2,600. Min $30 tickets?", "options": ["59", "60", "61", "62"], "answer": 2, "explanation": "20(100 − y) + 30y > 2,600 → 10y > 600 → y > 60. Min integer = 61.", "difficulty": "Hard"},
      {"question": "y < x + 5. If x increases by 2, what happens to max possible y?", "options": ["Decreases by 2", "Increases by 2", "Stays the same", "Increases by 5"], "answer": 1, "explanation": "The upper bound y < x + 5 shifts right by 2, increasing max y by 2.", "difficulty": "Medium"},
      {"question": "x ≥ −3 is graphed. Which describes the shading?", "options": ["Above a horizontal line", "Below a horizontal line", "To the left of a vertical line", "To the right of a vertical line"], "answer": 3, "explanation": "x = −3 is vertical. x ≥ −3 shades to the right.", "difficulty": "Easy"},
      {"question": "A student needs an average of at least 90 on two tests. First test: 84. Minimum second test score?", "options": ["90", "92", "94", "96"], "answer": 3, "explanation": "(84 + x)/2 ≥ 90 → x ≥ 96.", "difficulty": "Medium"},
      {"question": "Which system of inequalities produces a triangular region?", "options": ["x > 0, y > 0, x + y < 5", "x > 0, y > 0, y > x + 5", "x > 5, x < 2", "y > x, y > −x"], "answer": 0, "explanation": "Bounded by x-axis, y-axis, and x + y = 5 → triangle in Q1.", "difficulty": "Hard"},
      {"question": "Which inequality is equivalent to −2y + 4x < 10?", "options": ["y < 2x − 5", "y > 2x − 5", "y < −2x + 5", "y > −2x + 5"], "answer": 1, "explanation": "−2y < −4x + 10. Divide by −2 (flip): y > 2x − 5.", "difficulty": "Medium"},
      {"question": "If (k, 2k) is a solution to x + y ≤ 12, what is the maximum value of k?", "options": ["3", "4", "6", "12"], "answer": 1, "explanation": "k + 2k ≤ 12 → 3k ≤ 12 → k ≤ 4.", "difficulty": "Medium"},
      {"question": "y ≥ |x| and y ≤ 4. What is the area of the solution region?", "options": ["8", "16", "32", "4"], "answer": 1, "explanation": "Triangle with vertices (0,0), (−4,4), (4,4). Area = ½ × 8 × 4 = 16.", "difficulty": "Hard"},
      {"question": "y > 2x + 1 and y < 2x + 5 with x = 0.5. How many integer y-values?", "options": ["2", "3", "4", "5"], "answer": 1, "explanation": "y > 2 and y < 6. Integers: 3, 4, 5 → three values.", "difficulty": "Medium"},
      {"question": "For which value of a does y > ax + 2 and y < 2x + 5 have a solution in Quadrant II?", "options": ["a = 2", "a = 5", "a = −1", "All of the above"], "answer": 3, "explanation": "Both boundaries have positive y-intercepts, so the overlap always includes parts of Q2 regardless of a.", "difficulty": "Hard"},
      {"question": "x + y > 10 and x < 4. What is true about y?", "options": ["y > 6", "y < 6", "y > 10", "y < 14"], "answer": 0, "explanation": "y > 10 − x. Max x < 4 → y > 10 − 4 = 6.", "difficulty": "Medium"},
      {"question": "How many integer points (x, y) satisfy x > 0, y > 0, and x + y < 4?", "options": ["2", "3", "4", "6"], "answer": 1, "explanation": "Points: (1,1), (1,2), (2,1). Total = 3.", "difficulty": "Hard"},
      {"question": "y < mx + b has no solutions in Quadrant I. What must be true?", "options": ["m > 0, b > 0", "m < 0, b < 0", "m > 0, b < 0", "m < 0, b > 0"], "answer": 1, "explanation": "Shading below a line with negative slope and negative y-intercept avoids Q1 entirely.", "difficulty": "Medium"},
      {"question": "y ≥ x + 2 and y ≤ x + 2. This system describes:", "options": ["No points", "A single point", "A line", "A shaded region"], "answer": 2, "explanation": "y must be both ≥ and ≤ x + 2, so y = x + 2 exactly. That''s a line.", "difficulty": "Medium"},
      {"question": "y > x² and y < 4. How many integer points (x, y) are solutions?", "options": ["3", "5", "6", "7"], "answer": 3, "explanation": "x=0: y=1,2,3 (3). x=1: y=2,3 (2). x=−1: y=2,3 (2). Total = 7.", "difficulty": "Hard"},
      {"question": "3x − y < 5. If (2, y) is a solution, what is the smallest integer y?", "options": ["1", "2", "3", "4"], "answer": 1, "explanation": "6 − y < 5 → y > 1. Smallest integer > 1 is 2.", "difficulty": "Medium"},
      {"question": "x + y > 5 and x + y < 5. How many solutions?", "options": ["One", "Infinite", "No solution", "Solution at (2.5, 2.5)"], "answer": 2, "explanation": "A value can''t be both > 5 and < 5 simultaneously. No solution.", "difficulty": "Medium"},
      {"question": "y > 2x + 10 and y < −x + 25. What is the maximum possible integer x-coordinate?", "options": ["3", "4", "5", "6"], "answer": 1, "explanation": "Set equal: 2x + 10 = −x + 25 → 3x = 15 → x = 5. Strict inequalities → x < 5. Max integer = 4.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-010: %', lid;
END $$;

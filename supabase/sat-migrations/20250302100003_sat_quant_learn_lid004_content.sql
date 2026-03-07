-- Populate lesson sat-quant-learn-sat-lid-004 with theory + practice (interactive content).
-- Topic: Slope-Intercept & Standard Form
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-004'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-004; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Slope-Intercept & Standard Form',
    concept_content = E'Linear equations in two variables can be written in different forms. The SAT expects you to move fluently between them.\n\n**Slope-intercept form:** y = mx + b\n- **m** = slope (rise ÷ run)\n- **b** = y-intercept (where the line crosses the y-axis)\n\n**Standard form:** Ax + By = C\n- To find the slope: rearrange to y = mx + b, giving slope = −A/B\n- x-intercept: set y = 0 → x = C/A\n- y-intercept: set x = 0 → y = C/B\n\n**Parallel lines** have the **same slope** (m₁ = m₂).\n**Perpendicular lines** have slopes that are **negative reciprocals** (m₁ · m₂ = −1).\n\n**Horizontal lines:** y = k (slope = 0).\n**Vertical lines:** x = k (slope is **undefined**).',
    formula_title = 'Worked Example',
    formula_content = E'Find the slope and y-intercept of 3x − 2y = 8.\n\nStep 1 — Isolate y\n  −2y = −3x + 8\n\nStep 2 — Divide by −2\n  y = (3/2)x − 4\n\nSlope  = 3/2\ny-intercept = −4  →  point (0, −4)\n\nx-intercept: set y = 0\n  3x = 8  →  x = 8/3  →  point (8/3, 0)'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master the two main forms of linear equations and learn to extract slope, intercepts, and parallel / perpendicular relationships on sight.',
    '[
      {"title": "Recognise the form", "content": "Determine whether the equation is already in slope-intercept (y = mx + b) or standard form (Ax + By = C). This tells you what information is immediately available.", "highlight": "which form am I looking at?"},
      {"title": "Convert to slope-intercept", "content": "If the equation is in standard form, solve for y: subtract the x-term, then divide every term by the coefficient of y.", "equation": "Ax + By = C  →  y = (−A/B)x + C/B", "highlight": "isolate y"},
      {"title": "Read slope & y-intercept", "content": "In y = mx + b the coefficient of x is the slope and the constant term is the y-intercept.", "equation": "y = 2x − 3  →  slope = 2, y-int = −3", "highlight": "m and b"},
      {"title": "Find x-intercept", "content": "Set y = 0 in either form and solve for x. The result is the point where the line crosses the x-axis.", "equation": "2x − 3 = 0  →  x = 3/2", "highlight": "set y = 0"},
      {"title": "Parallel & perpendicular", "content": "Parallel lines share the same slope. Perpendicular lines have slopes whose product is −1 (negative reciprocals).", "equation": "m = 2  →  parallel m = 2, perpendicular m = −1/2", "highlight": "same slope vs negative reciprocal"}
    ]'::jsonb,
    '[
      {"question": "A jet ski rental shop charges a fixed $35 insurance fee and an hourly rate of $12.50. A tourist wants to spend no more than $100 on a rental. If h represents the number of hours rented, which inequality represents this situation?", "options": ["12.50h ≤ 100", "35 + 12.50h ≤ 100", "35h + 12.50 ≤ 100", "12.50 + 35h ≥ 100"], "answer": 1, "explanation": "Fixed fee ($35) plus variable cost (12.50h) must be at most $100: 35 + 12.50h ≤ 100.", "difficulty": "Easy"},
      {"question": "The width of a standard warehouse loading dock is at least 12 feet and no more than 15 feet. A logistics manager has a total wall length of 180 feet available for docks. Which describes all possible values for n, the number of loading docks?", "options": ["12 ≤ n ≤ 15", "12 ≤ n ≤ 180", "15 ≤ n ≤ 180", "12 ≤ n ≤ 15"], "answer": 0, "explanation": "Max docks (narrowest 12 ft): 180/12 = 15. Min docks (widest 15 ft): 180/15 = 12. So 12 ≤ n ≤ 15.", "difficulty": "Medium"},
      {"question": "A catering company is buying crates of soda (s) and water (w). Soda weighs 18 lb, water weighs 22 lb. Truck carries at most 500 lb. They want at least 3× as many water crates as soda. Which system represents this?", "options": ["18s + 22w ≤ 500; w ≥ 3s", "18s + 22w ≤ 500; s ≥ 3w", "40(s+w) ≤ 500; w ≥ 3s", "18s + 22w ≥ 500; w ≤ 3s"], "answer": 0, "explanation": "Weight constraint: 18s + 22w ≤ 500. Quantity constraint: w ≥ 3s.", "difficulty": "Medium"},
      {"question": "A florist creates bouquets with at least 12 but no more than 18 flowers each. Which could be the total number of flowers in 6 bouquets?", "options": ["65", "80", "110", "125"], "answer": 1, "explanation": "Min total: 6 × 12 = 72. Max total: 6 × 18 = 108. Only 80 falls in [72, 108].", "difficulty": "Medium"},
      {"question": "Alice and Bob shared a 300-mile drive. Alice drove at 55 mph and Bob at 60 mph. Total time was under 6 hours. If a is Alice''s hours and b is Bob''s, which inequality represents the time constraint?", "options": ["55a + 60b < 300", "55a + 60b > 300", "a + b < 6", "a + b > 6"], "answer": 2, "explanation": "Total time = a + b. ''Under 6 hours'' means a + b < 6.", "difficulty": "Medium"},
      {"question": "Which point (x, y) is a solution to y ≤ 2x + 4 and y ≥ −x + 1?", "options": ["(0, 0)", "(0, 5)", "(2, 1)", "(−2, 5)"], "answer": 2, "explanation": "Test (2, 1): 1 ≤ 2(2)+4 = 8 ✓ and 1 ≥ −2+1 = −1 ✓. Both satisfied.", "difficulty": "Medium"},
      {"question": "Brand A is 20% peanuts and Brand B is 60% peanuts. A bowl must have at least 50 g of peanuts. If x = grams of A and y = grams of B, which inequality represents this?", "options": ["0.2x + 0.6y ≥ 50", "20x + 60y ≥ 50", "0.2x + 0.6y ≤ 50", "x + y ≥ 50"], "answer": 0, "explanation": "Peanut content: 0.2x + 0.6y. ''At least 50'' → 0.2x + 0.6y ≥ 50.", "difficulty": "Medium"},
      {"question": "A gym membership costs $60/month. Non-members pay $7/visit. What is the minimum number of visits per month for which the membership is cheaper?", "options": ["7", "8", "9", "10"], "answer": 2, "explanation": "60 < 7v → v > 8.57. Smallest whole number > 8.57 is 9. At 9 visits: $63 > $60.", "difficulty": "Easy"},
      {"question": "A plumber charges a $50 call-out fee plus $80/hour. A customer has $400. Which inequality shows the hours h the plumber can work?", "options": ["50h + 80 ≤ 400", "50 + 80h ≤ 400", "130h ≤ 400", "50 + 80h ≥ 400"], "answer": 1, "explanation": "Total cost = 50 + 80h. Budget: 50 + 80h ≤ 400.", "difficulty": "Easy"},
      {"question": "A fence uses panels between 6 and 8 feet long. Total fence length is 96 feet. What is the maximum number of panels?", "options": ["12", "14", "16", "18"], "answer": 2, "explanation": "Shortest panels (6 ft) → most panels: 96/6 = 16.", "difficulty": "Medium"},
      {"question": "Each box contains 15–22 books. A library orders 7 boxes. Which total is possible?", "options": ["100", "125", "160", "185"], "answer": 1, "explanation": "Min: 7 × 15 = 105. Max: 7 × 22 = 154. Only 125 is in [105, 154].", "difficulty": "Medium"},
      {"question": "Machine A makes 12 parts/hr, Machine B makes 15 parts/hr. Manager wants more than 150 parts. If x = hours A runs and y = hours B runs, which inequality?", "options": ["12x + 15y > 150", "12x + 15y < 150", "27(x+y) > 150", "15x + 12y ≥ 150"], "answer": 0, "explanation": "Total output = 12x + 15y. ''More than 150'' → 12x + 15y > 150.", "difficulty": "Medium"},
      {"question": "Fertilizer X is 5% nitrogen, Y is 12% nitrogen. Need at least 10 lb of nitrogen. If x = weight of X and y = weight of Y, which inequality?", "options": ["5x + 12y ≥ 10", "0.05x + 0.12y ≤ 10", "0.05x + 0.12y ≥ 10", "0.5x + 1.2y ≥ 10"], "answer": 2, "explanation": "Nitrogen: 0.05x + 0.12y. ''At least 10'' → 0.05x + 0.12y ≥ 10.", "difficulty": "Hard"},
      {"question": "Parking costs $5 for the first hour and $3 for each additional hour. A driver has $20. Which inequality represents total hours h?", "options": ["5 + 3h ≤ 20", "5 + 3(h − 1) ≤ 20", "8h ≤ 20", "5h + 3 ≤ 20"], "answer": 1, "explanation": "First hour costs $5; additional (h − 1) hours cost $3 each: 5 + 3(h − 1) ≤ 20.", "difficulty": "Easy"},
      {"question": "Which point is a solution to y < −2x + 5 and y > x − 1?", "options": ["(0, 0)", "(3, 0)", "(0, 6)", "(2, 2)"], "answer": 0, "explanation": "Test (0,0): 0 < 5 ✓ and 0 > −1 ✓. Both satisfied.", "difficulty": "Medium"},
      {"question": "A contractor uses planks 8–10 ft long to cover 120 ft. What is the minimum number of planks?", "options": ["10", "12", "15", "20"], "answer": 1, "explanation": "Longest planks (10 ft) → fewest: 120/10 = 12.", "difficulty": "Medium"},
      {"question": "Type A bulbs cost $4, Type B cost $6. Must buy ≥ 50 bulbs total and spend ≤ $400. Which system? (a = Type A, b = Type B)", "options": ["a + b ≥ 50; 4a + 6b ≤ 400", "a + b ≤ 50; 4a + 6b ≤ 400", "a + b ≥ 50; 4a + 6b ≥ 400", "4a + 6b ≤ 50; a + b ≥ 400"], "answer": 0, "explanation": "Quantity: a + b ≥ 50. Cost: 4a + 6b ≤ 400.", "difficulty": "Medium"},
      {"question": "Car rental: $150/week, first 200 miles free, $0.25/mile after. Customer wants to spend at most $250 (m > 200). Which inequality?", "options": ["150 + 0.25m ≤ 250", "150 + 0.25(m − 200) ≤ 250", "150 + 200(m − 0.25) ≤ 250", "0.25(m + 200) ≤ 250"], "answer": 1, "explanation": "Extra miles = m − 200. Cost = 150 + 0.25(m − 200) ≤ 250.", "difficulty": "Medium"},
      {"question": "Liquid A is 30% alcohol, B is 70%. Mixture must be ≥ 40 L total and ≤ 20 L of alcohol. Which system? (a = L of A, b = L of B)", "options": ["a + b ≥ 40; 0.3a + 0.7b ≤ 20", "a + b ≤ 40; 0.3a + 0.7b ≥ 20", "a + b ≥ 40; 30a + 70b ≤ 20", "0.3a + 0.7b ≥ 40; a + b ≤ 20"], "answer": 0, "explanation": "Volume: a + b ≥ 40. Alcohol: 0.3a + 0.7b ≤ 20.", "difficulty": "Hard"},
      {"question": "Running burns 12 cal/min, cycling burns 8 cal/min. Goal: at least 600 cal. If r = running minutes, c = cycling minutes, which inequality?", "options": ["12r + 8c ≤ 600", "12r + 8c ≥ 600", "20(r + c) ≥ 600", "8r + 12c ≥ 600"], "answer": 1, "explanation": "Total calories = 12r + 8c. ''At least 600'' → 12r + 8c ≥ 600.", "difficulty": "Medium"},
      {"question": "Buying $5 notebooks (n) and $2 pens (p). Spend more than $20 but no more than $50. Which system?", "options": ["5n + 2p > 20; 5n + 2p ≤ 50", "5n + 2p < 20; 5n + 2p ≥ 50", "n + p > 20; n + p ≤ 50", "5n + 2p ≥ 20; 5n + 2p < 50"], "answer": 0, "explanation": "Cost = 5n + 2p. ''More than $20'' → > 20. ''No more than $50'' → ≤ 50.", "difficulty": "Medium"},
      {"question": "Taxi charges $4 start + $2.50/mile. Passenger has $24. Maximum miles m?", "options": ["6", "8", "10", "12"], "answer": 1, "explanation": "4 + 2.5m ≤ 24 → 2.5m ≤ 20 → m ≤ 8.", "difficulty": "Easy"},
      {"question": "Which point lies in the solution set of y ≤ −x + 10, y ≥ 2, and x ≥ 5?", "options": ["(4, 4)", "(6, 1)", "(6, 3)", "(11, 2)"], "answer": 2, "explanation": "(6,3): x ≥ 5 ✓, y ≥ 2 ✓, 3 ≤ −6+10 = 4 ✓. All three satisfied.", "difficulty": "Hard"},
      {"question": "Plan 1: $30/month + $0.10/text. Plan 2: $50/month unlimited. For what number of texts t is Plan 2 cheaper?", "options": ["t > 200", "t < 200", "t > 500", "t < 500"], "answer": 0, "explanation": "30 + 0.10t > 50 → 0.10t > 20 → t > 200.", "difficulty": "Medium"},
      {"question": "Floor seats $40, balcony $25. Theater wants ≥ $2,000 revenue. Which inequality? (f = floor, b = balcony)", "options": ["40f + 25b ≥ 2000", "40f + 25b ≤ 2000", "65(f + b) ≥ 2000", "25f + 40b ≥ 2000"], "answer": 0, "explanation": "Revenue = 40f + 25b. ''At least $2,000'' → 40f + 25b ≥ 2000.", "difficulty": "Medium"},
      {"question": "What is the slope of the line 2x − 3y = 9?", "options": ["2", "−3", "2/3", "−2/3"], "answer": 2, "explanation": "Rearrange: −3y = −2x + 9 → y = (2/3)x − 3. Slope = 2/3.", "difficulty": "Easy"},
      {"question": "A line passes through (4, −1) with slope −2. What is the y-intercept?", "options": ["7", "−9", "9", "−7"], "answer": 0, "explanation": "y = mx + b → −1 = −2(4) + b → −1 = −8 + b → b = 7.", "difficulty": "Easy"},
      {"question": "Which line is parallel to y = 4x − 5?", "options": ["y = −4x + 5", "y = (1/4)x − 5", "4x − y = 10", "x + 4y = 8"], "answer": 2, "explanation": "4x − y = 10 → y = 4x − 10. Slope = 4, same as original → parallel.", "difficulty": "Medium"},
      {"question": "What is the x-intercept of 3x + 2y = 12?", "options": ["(0, 6)", "(4, 0)", "(6, 0)", "(0, 4)"], "answer": 1, "explanation": "Set y = 0: 3x = 12 → x = 4. x-intercept is (4, 0).", "difficulty": "Medium"},
      {"question": "A line passes through (2, 5) and (6, 13). What is the slope?", "options": ["2", "4", "1/2", "8"], "answer": 0, "explanation": "m = (13 − 5)/(6 − 2) = 8/4 = 2.", "difficulty": "Medium"},
      {"question": "Which line is perpendicular to y = −3x + 2?", "options": ["y = −3x − 2", "y = 3x + 2", "y = (1/3)x + 5", "y = −(1/3)x + 5"], "answer": 2, "explanation": "Perpendicular slope = negative reciprocal of −3 = 1/3. Only y = (1/3)x + 5 has slope 1/3.", "difficulty": "Medium"},
      {"question": "What is the equation of a horizontal line through (5, −7)?", "options": ["x = 5", "y = 5", "x = −7", "y = −7"], "answer": 3, "explanation": "Horizontal lines have the form y = k. The y-coordinate is −7, so y = −7.", "difficulty": "Easy"},
      {"question": "A line through the origin has slope 3/4. Which point also lies on it?", "options": ["(3, 4)", "(4, 3)", "(0, 3)", "(4, 0)"], "answer": 1, "explanation": "y = (3/4)x. At x = 4: y = 3. So (4, 3) is on the line.", "difficulty": "Medium"},
      {"question": "What is the slope of a line perpendicular to the x-axis?", "options": ["0", "1", "−1", "Undefined"], "answer": 3, "explanation": "Perpendicular to x-axis = vertical line. Vertical lines have undefined slope (division by zero).", "difficulty": "Medium"},
      {"question": "Line L contains (1, 2) and (3, 10). Which is L''s equation?", "options": ["y = 4x − 2", "y = 4x + 2", "y = 2x + 4", "y = 8x − 6"], "answer": 0, "explanation": "Slope = (10−2)/(3−1) = 4. Using (1,2): 2 = 4(1)+b → b = −2. So y = 4x − 2.", "difficulty": "Hard"},
      {"question": "Which line has a slope of 0?", "options": ["x = 2", "y = 2", "y = x", "x + y = 0"], "answer": 1, "explanation": "y = 2 is horizontal → slope = 0.", "difficulty": "Medium"},
      {"question": "What is the y-intercept of y − 4 = 3(x + 2)?", "options": ["4", "10", "−2", "6"], "answer": 1, "explanation": "Set x = 0: y − 4 = 3(2) = 6 → y = 10.", "difficulty": "Easy"},
      {"question": "A line passes through (1, 5) and is parallel to the x-axis. What is its equation?", "options": ["x = 1", "y = 1", "x = 5", "y = 5"], "answer": 3, "explanation": "Parallel to x-axis = horizontal. y-value is constant at 5 → y = 5.", "difficulty": "Medium"},
      {"question": "If y = mx + b passes through (2, 4) and (5, 4), what is m?", "options": ["0", "3", "1", "Undefined"], "answer": 0, "explanation": "Both y-values are 4 → no rise → slope = (4−4)/(5−2) = 0.", "difficulty": "Hard"},
      {"question": "What is the slope of x = −4?", "options": ["−4", "0", "1", "Undefined"], "answer": 3, "explanation": "x = −4 is a vertical line → slope is undefined.", "difficulty": "Medium"},
      {"question": "A line has y-intercept 3 and x-intercept −3. What is its slope?", "options": ["1", "−1", "3", "0"], "answer": 0, "explanation": "Points: (0,3) and (−3,0). m = (0−3)/(−3−0) = −3/−3 = 1.", "difficulty": "Easy"},
      {"question": "Which equation has slope −1/2 and passes through the origin?", "options": ["y = −2x", "x + 2y = 0", "2x + y = 0", "y = 2x"], "answer": 1, "explanation": "x + 2y = 0 → 2y = −x → y = −(1/2)x. Slope = −1/2, passes through origin.", "difficulty": "Medium"},
      {"question": "A line passes through (2, 3) and (2, 7). What is its equation?", "options": ["y = 3", "x = 2", "y = 2x − 1", "y = 5"], "answer": 1, "explanation": "Same x-value (2) for both points → vertical line → x = 2.", "difficulty": "Medium"},
      {"question": "What is the slope of a line parallel to 2x + y = 4?", "options": ["2", "−2", "1/2", "−1/2"], "answer": 1, "explanation": "2x + y = 4 → y = −2x + 4. Slope = −2. Parallel lines share the same slope.", "difficulty": "Medium"},
      {"question": "The line y = 5 has what slope?", "options": ["5", "1", "0", "Undefined"], "answer": 2, "explanation": "y = 5 is horizontal. Horizontal lines have slope 0.", "difficulty": "Easy"},
      {"question": "A line passes through (−1, 4) and (2, −2). What is its y-intercept?", "options": ["2", "−2", "4", "0"], "answer": 0, "explanation": "Slope = (−2−4)/(2−(−1)) = −6/3 = −2. Using (−1,4): 4 = −2(−1)+b → b = 2.", "difficulty": "Hard"},
      {"question": "Which equation has an undefined slope?", "options": ["y = 0", "x = 0", "y = x", "x + y = 1"], "answer": 1, "explanation": "x = 0 is a vertical line (the y-axis). Vertical lines have undefined slope.", "difficulty": "Medium"},
      {"question": "What is the slope of y = x?", "options": ["0", "1", "−1", "Undefined"], "answer": 1, "explanation": "y = x is the same as y = 1·x + 0. The coefficient of x is 1.", "difficulty": "Easy"},
      {"question": "A line passes through (3, 2) and (6, 2). What is its equation?", "options": ["x = 3", "y = 2", "y = x − 1", "x = 2"], "answer": 1, "explanation": "Both y-values are 2 → horizontal line → y = 2.", "difficulty": "Medium"},
      {"question": "The line y = 2x + b passes through (1, 5). What is the x-intercept?", "options": ["−1.5", "3", "−3", "1.5"], "answer": 0, "explanation": "5 = 2(1) + b → b = 3. Equation: y = 2x + 3. Set y = 0: 2x = −3 → x = −1.5.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-004: %', lid;
END $$;

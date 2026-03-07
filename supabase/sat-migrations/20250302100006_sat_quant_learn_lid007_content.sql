-- Populate lesson sat-quant-learn-sat-lid-007 with theory + practice (interactive content).
-- Topic: Solving Systems (Substitution & Elimination)
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-007'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-007; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Solving Systems (Substitution & Elimination)',
    concept_content = E'A **system of two linear equations** has two unknowns and two equations. The solution is the ordered pair (x, y) that satisfies both equations simultaneously.\n\n**Three possible outcomes:**\n- **One solution** — the lines intersect at exactly one point.\n- **No solution** — the lines are parallel (same slope, different intercepts).\n- **Infinitely many solutions** — the equations describe the same line.\n\n**Substitution method:**\n1. Solve one equation for one variable (e.g., y = …).\n2. Substitute that expression into the other equation.\n3. Solve the resulting single-variable equation, then back-substitute.\n\n**Elimination method:**\n1. Multiply one or both equations so a variable has matching (or opposite) coefficients.\n2. Add or subtract the equations to eliminate that variable.\n3. Solve for the remaining variable, then back-substitute.\n\n**When to use which:**\n- Use substitution when one equation already has a variable isolated (e.g., y = 3x − 4).\n- Use elimination when coefficients are already close to matching or cancelling.\n\n**SAT shortcut:** If the question asks for an expression like x + y or x − y, try adding or subtracting the equations directly instead of solving for individual variables.',
    formula_title = 'Worked Example',
    formula_content = E'Solve the system:\n  y = 3x − 4\n  2x + y = 16\n\nStep 1 — Substitution\n  Replace y in equation 2:\n  2x + (3x − 4) = 16\n\nStep 2 — Combine like terms\n  5x − 4 = 16\n\nStep 3 — Solve for x\n  5x = 20  →  x = 4\n\nStep 4 — Back-substitute\n  y = 3(4) − 4 = 8\n\nSolution: (4, 8)'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Learn two core methods — substitution and elimination — for solving systems of two linear equations, a fundamental SAT algebra skill.',
    '[
      {"title": "Choose your method", "content": "If one variable is already isolated (e.g., y = …), use substitution. If both equations are in standard form, elimination is usually faster.", "highlight": "substitution vs. elimination"},
      {"title": "Substitution: replace and solve", "content": "Take the isolated expression and plug it into the other equation. You now have one equation with one unknown — solve it, then back-substitute to find the other variable.", "equation": "y = 3x − 4 into 2x + y = 16 → 5x = 20", "highlight": "plug in and simplify"},
      {"title": "Elimination: align and cancel", "content": "Multiply one or both equations so that one variable has equal-and-opposite coefficients. Then add the equations to eliminate that variable.", "equation": "2x + 3y = 12 and x − y = 1 → multiply 2nd by 3, then add", "highlight": "match coefficients"},
      {"title": "Check for special cases", "content": "Same slope + different intercepts = no solution (parallel). Same slope + same intercept = infinitely many solutions (identical lines). Always check if the question asks about the number of solutions.", "highlight": "no solution vs. infinite solutions"},
      {"title": "Use the SAT shortcut", "content": "If the question asks for x + y, x − y, or 3x, try adding or subtracting the original equations directly. You may find the answer without solving for each variable separately.", "equation": "(2x + y) + (x + 2y) = 7 + 5 → 3(x + y) = 12", "highlight": "combine equations strategically"}
    ]'::jsonb,
    '[
      {"question": "A bakery sold 40 boxes of donuts ($12) and muffins ($15) for $540 total. Which system represents this?", "options": ["d + m = 40; 12d + 15m = 540", "d + m = 540; 12d + 15m = 40", "12d + 15m = 40; d + m = 540", "d + m = 40; 15d + 12m = 540"], "answer": 0, "explanation": "Total boxes: d + m = 40. Total revenue: 12d + 15m = 540.", "difficulty": "Medium"},
      {"question": "x + y = 15 and 2x − y = 6. What is x?", "options": ["5", "7", "8", "9"], "answer": 1, "explanation": "Add the equations: 3x = 21 → x = 7.", "difficulty": "Medium"},
      {"question": "Juice A is 20% sugar, Juice B is 5% sugar. Mix 10 liters with 1.25 liters of sugar. Which system models this?", "options": ["a + b = 10; 0.20a + 0.05b = 1.25", "a + b = 1.25; 0.20a + 0.05b = 10", "a + b = 10; 20a + 5b = 1.25", "0.20a + 0.05b = 10; a + b = 10"], "answer": 0, "explanation": "Volume: a + b = 10. Sugar: 0.20a + 0.05b = 1.25.", "difficulty": "Hard"},
      {"question": "y = 3x − 4 and 2x + y = 16. What is y?", "options": ["4", "6", "8", "10"], "answer": 2, "explanation": "Substitute: 2x + 3x − 4 = 16 → 5x = 20 → x = 4. y = 3(4) − 4 = 8.", "difficulty": "Hard"},
      {"question": "12 trucks deliver 44 tons: Type X carries 3 tons, Type Y carries 5 tons. Which system represents this?", "options": ["x + y = 12; 3x + 5y = 44", "x + y = 44; 3x + 5y = 12", "3x + 5y = 12; x + y = 12", "x + y = 12; 5x + 3y = 44"], "answer": 0, "explanation": "Truck count: x + y = 12. Tonnage: 3x + 5y = 44.", "difficulty": "Medium"},
      {"question": "2x + 3y = 12 and x − y = 1. What is x + y?", "options": ["3", "4", "5", "6"], "answer": 2, "explanation": "Multiply 2nd by 3: 3x − 3y = 3. Add to 1st: 5x = 15 → x = 3. Then y = 2. x + y = 5.", "difficulty": "Medium"},
      {"question": "A hotel has 60 rooms: singles ($90) and doubles ($140). Full hotel revenue is $7,400. How many doubles?", "options": ["20", "40", "30", "25"], "answer": 1, "explanation": "s + d = 60; 90s + 140d = 7,400. Substitute: 90(60 − d) + 140d = 7,400 → 50d = 2,000 → d = 40.", "difficulty": "Hard"},
      {"question": "2x + y = 10 and x + 2y = 8. What is x − y?", "options": ["1", "2", "3", "4"], "answer": 1, "explanation": "Subtract 2nd from 1st: (2x + y) − (x + 2y) = 10 − 8 → x − y = 2.", "difficulty": "Medium"},
      {"question": "A merchant buys 30 lbs of coffee: Type A at $4/lb and Type B at $7/lb for $165. How many pounds of Type B?", "options": ["12", "15", "18", "20"], "answer": 1, "explanation": "a + b = 30; 4a + 7b = 165. Substitute: 4(30 − b) + 7b = 165 → 3b = 45 → b = 15.", "difficulty": "Hard"},
      {"question": "3x + 2y = 18 and x − 2y = 2. What is x?", "options": ["3", "4", "5", "6"], "answer": 2, "explanation": "Add equations: 4x = 20 → x = 5.", "difficulty": "Medium"},
      {"question": "An exam has 50 questions: +4 for correct, −1 for incorrect. A student scores 150. Which system represents this?", "options": ["c + w = 50; 4c − w = 150", "c + w = 150; 4c − w = 50", "4c + w = 50; c − w = 150", "c + w = 50; 4c + w = 150"], "answer": 0, "explanation": "Total questions: c + w = 50. Score: 4c − w = 150.", "difficulty": "Medium"},
      {"question": "5x + 2y = 20 and x + y = 7. What is 3x?", "options": ["4", "6", "8", "10"], "answer": 1, "explanation": "Multiply 2nd by 2: 2x + 2y = 14. Subtract from 1st: 3x = 6.", "difficulty": "Hard"},
      {"question": "Two numbers sum to 25, differ by 7. What is the larger number?", "options": ["16", "18", "9", "11"], "answer": 0, "explanation": "x + y = 25; x − y = 7. Add: 2x = 32 → x = 16.", "difficulty": "Medium"},
      {"question": "x = 2y and x + y = 12. What is y?", "options": ["3", "4", "6", "8"], "answer": 1, "explanation": "Substitute: 2y + y = 12 → 3y = 12 → y = 4.", "difficulty": "Medium"},
      {"question": "A farmer has 20 animals: chickens (2 legs) and cows (4 legs) with 56 legs total. Which system represents this?", "options": ["c + w = 20; 2c + 4w = 56", "c + w = 56; 2c + 4w = 20", "c + w = 20; 4c + 2w = 56", "2c + 4w = 20; c + w = 56"], "answer": 0, "explanation": "Animal count: c + w = 20. Leg count: 2c + 4w = 56.", "difficulty": "Medium"},
      {"question": "4x − 3y = 11 and 2x + 3y = 7. What is x?", "options": ["2", "3", "4", "5"], "answer": 1, "explanation": "Add equations: 6x = 18 → x = 3.", "difficulty": "Hard"},
      {"question": "A theater sold 100 tickets: adults ($10) and children ($6) for $840. How many adult tickets?", "options": ["40", "60", "50", "70"], "answer": 1, "explanation": "a + c = 100; 10a + 6c = 840. Substitute: 10a + 6(100 − a) = 840 → 4a = 240 → a = 60.", "difficulty": "Medium"},
      {"question": "y = 2x and 3x + 2y = 21. What is x?", "options": ["2", "3", "4", "5"], "answer": 1, "explanation": "Substitute: 3x + 2(2x) = 21 → 7x = 21 → x = 3.", "difficulty": "Hard"},
      {"question": "x + y = 10 and 2x + 2y = 20. How many solutions?", "options": ["Exactly one", "Exactly two", "Infinitely many", "None"], "answer": 2, "explanation": "Divide the 2nd by 2: x + y = 10, identical to the 1st. Same line → infinitely many solutions.", "difficulty": "Medium"},
      {"question": "ax + 3y = 12 and 2x + y = 4 has infinitely many solutions. What is a?", "options": ["2", "4", "6", "8"], "answer": 2, "explanation": "Multiply 2nd by 3: 6x + 3y = 12. For identical equations, a = 6.", "difficulty": "Hard"},
      {"question": "Car rental: $50/day + $0.20/mile. Truck rental: $30/day + $0.30/mile. At what mileage is the cost the same for one day?", "options": ["100", "200", "150", "250"], "answer": 1, "explanation": "50 + 0.20m = 30 + 0.30m → 20 = 0.10m → m = 200.", "difficulty": "Medium"},
      {"question": "y = x + 4 and y = −2x + 10. What is the x-coordinate of the solution?", "options": ["1", "2", "3", "4"], "answer": 1, "explanation": "x + 4 = −2x + 10 → 3x = 6 → x = 2.", "difficulty": "Hard"},
      {"question": "x + y = 5 and x + y = 8. How many solutions?", "options": ["One", "None", "Infinitely many", "Two"], "answer": 1, "explanation": "Same slope (−1), different intercepts → parallel lines → no solutions.", "difficulty": "Medium"},
      {"question": "2x − 3y = 7 and x + y = 6. Find y.", "options": ["0", "1", "2", "3"], "answer": 1, "explanation": "Multiply 2nd by 2: 2x + 2y = 12. Subtract 1st: 5y = 5 → y = 1.", "difficulty": "Hard"},
      {"question": "A system has the same slope and different y-intercepts. The graph shows:", "options": ["Intersecting lines", "Parallel lines", "Perpendicular lines", "Overlapping lines"], "answer": 1, "explanation": "Same slope + different intercepts = parallel lines that never intersect.", "difficulty": "Medium"},
      {"question": "3x − y = 10 and x + 2y = 8. What is 10y?", "options": ["10", "15", "20", "25"], "answer": 2, "explanation": "Multiply 1st by 2: 6x − 2y = 20. Add to 2nd: 7x = 28 → x = 4. Then 4 + 2y = 8 → y = 2. 10y = 20.", "difficulty": "Hard"},
      {"question": "For what value of k does kx − 3y = 4 and 4x − 6y = 7 have no solution?", "options": ["2", "4", "8", "−2"], "answer": 0, "explanation": "Multiply 1st by 2: 2kx − 6y = 8. For parallel lines, 2k = 4 → k = 2. Since 8 ≠ 7, no solution.", "difficulty": "Hard"},
      {"question": "x = y + 3 and x² − y² = 21. What is x + y?", "options": ["5", "7", "9", "11"], "answer": 1, "explanation": "x² − y² = (x − y)(x + y). Since x − y = 3: 3(x + y) = 21 → x + y = 7.", "difficulty": "Hard"},
      {"question": "y = 0.5x + 3 has no solution with which other equation?", "options": ["x − 2y = 10", "2x − y = 6", "x + 2y = 3", "0.5x + y = 3"], "answer": 0, "explanation": "x − 2y = 10 → y = 0.5x − 5. Same slope (0.5), different intercept → parallel → no solution.", "difficulty": "Hard"},
      {"question": "x + y = 10 and x − y = 4. What is x² − y²?", "options": ["30", "40", "50", "60"], "answer": 1, "explanation": "x² − y² = (x + y)(x − y) = 10 × 4 = 40.", "difficulty": "Hard"},
      {"question": "At a cafe, 2 coffees + 3 teas = $14.50 and 3 coffees + 2 teas = $15.50. What is the cost of one coffee?", "options": ["$3.50", "$2.50", "$4.00", "$3.00"], "answer": 0, "explanation": "Multiply 1st by 2, 2nd by 3: 4c + 6t = 29; 9c + 6t = 46.50. Subtract: 5c = 17.50 → c = $3.50.", "difficulty": "Medium"},
      {"question": "y = 3x − 1 and y = x + 7. What is x?", "options": ["2", "3", "4", "5"], "answer": 2, "explanation": "3x − 1 = x + 7 → 2x = 8 → x = 4.", "difficulty": "Medium"},
      {"question": "y = 2x + 1 and y = ax + b are perpendicular, intersecting at (0, 1). What is a?", "options": ["−0.5", "2", "−2", "0.5"], "answer": 0, "explanation": "Perpendicular slope = negative reciprocal of 2 = −0.5.", "difficulty": "Hard"},
      {"question": "2x + 3y = 13 and y = 3. What is x?", "options": ["1", "2", "3", "4"], "answer": 1, "explanation": "2x + 9 = 13 → 2x = 4 → x = 2.", "difficulty": "Medium"},
      {"question": "x − 2y = 5 and −3x + 6y = −15. How many solutions?", "options": ["None", "One", "Infinitely many", "Two"], "answer": 2, "explanation": "Multiply 1st by −3: −3x + 6y = −15, which is identical to the 2nd equation → infinitely many.", "difficulty": "Hard"},
      {"question": "x + y = 20 and 0.5x + 0.2y = 7. What is x?", "options": ["5", "8", "10", "12"], "answer": 2, "explanation": "Multiply 2nd by 5: 2.5x + y = 35. Subtract 1st: 1.5x = 15 → x = 10.", "difficulty": "Hard"},
      {"question": "A boat goes 24 miles downstream in 2 hrs and 24 miles upstream in 3 hrs. What is the speed of the current?", "options": ["2 mph", "10 mph", "12 mph", "4 mph"], "answer": 0, "explanation": "b + c = 12; b − c = 8. Subtract: 2c = 4 → c = 2 mph.", "difficulty": "Medium"},
      {"question": "x = 5 and 2x − y = 4. What is y?", "options": ["4", "5", "6", "7"], "answer": 2, "explanation": "10 − y = 4 → y = 6.", "difficulty": "Medium"},
      {"question": "y = mx + 2 and y = 3x + 5 are parallel. What is m?", "options": ["3", "−3", "1/3", "2"], "answer": 0, "explanation": "Parallel lines have equal slopes. The second line has slope 3, so m = 3.", "difficulty": "Hard"},
      {"question": "y = 2x − 5 and y = −x + 10. What is x?", "options": ["3", "4", "5", "6"], "answer": 2, "explanation": "2x − 5 = −x + 10 → 3x = 15 → x = 5.", "difficulty": "Hard"},
      {"question": "x + 2y = 10 and x + 2y = k has infinitely many solutions. What is k?", "options": ["10", "5", "20", "0"], "answer": 0, "explanation": "For identical equations, k must equal 10.", "difficulty": "Hard"},
      {"question": "y = 4 and x + y = 10. What is x?", "options": ["4", "5", "6", "8"], "answer": 2, "explanation": "x + 4 = 10 → x = 6.", "difficulty": "Medium"},
      {"question": "Which line is perpendicular to y = −0.25x?", "options": ["y = 4x", "y = −4x", "y = 0.25x", "y = −0.25x"], "answer": 0, "explanation": "Negative reciprocal of −0.25 (−1/4) is 4. y = 4x has slope 4.", "difficulty": "Hard"},
      {"question": "3x + y = 13 and x + y = 7. Find x.", "options": ["2", "3", "4", "5"], "answer": 1, "explanation": "Subtract: 2x = 6 → x = 3.", "difficulty": "Hard"},
      {"question": "Two numbers sum to 10, differ by 2. What is the smaller number?", "options": ["4", "6", "2", "8"], "answer": 0, "explanation": "x + y = 10; x − y = 2. Subtract: 2y = 8 → y = 4.", "difficulty": "Medium"},
      {"question": "y = x² and y = 4. How many positive solutions for x?", "options": ["1", "2", "0", "4"], "answer": 0, "explanation": "x² = 4 → x = ±2. Only x = 2 is positive — one positive solution.", "difficulty": "Hard"},
      {"question": "What is the intersection of x = 3 and y = 5?", "options": ["(3, 5)", "(5, 3)", "(0, 0)", "(3, 0)"], "answer": 0, "explanation": "x = 3 is a vertical line; y = 5 is horizontal. They meet at (3, 5).", "difficulty": "Medium"},
      {"question": "y = 0 and 2x + 3y = 12. What is x?", "options": ["4", "5", "6", "8"], "answer": 2, "explanation": "2x + 0 = 12 → x = 6.", "difficulty": "Medium"},
      {"question": "Which line through (0, 0) is parallel to y = 3x + 10?", "options": ["y = 3x", "y = −3x", "y = (1/3)x", "y = 3"], "answer": 0, "explanation": "Same slope (3) through origin → y = 3x.", "difficulty": "Hard"},
      {"question": "2x + y = 7 and x + 2y = 5. What is x + y?", "options": ["3", "4", "5", "6"], "answer": 1, "explanation": "Add equations: 3x + 3y = 12 → x + y = 4.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-007: %', lid;
END $$;

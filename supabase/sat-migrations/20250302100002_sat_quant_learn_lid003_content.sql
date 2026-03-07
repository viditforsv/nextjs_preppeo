-- Populate lesson sat-quant-learn-sat-lid-003 with theory + practice (interactive content).
-- Topic: Number of Solutions (Zero, One, Infinite)
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-003'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-003; skipping content seed.';
    RETURN;
  END IF;

  -- Set lesson type and concept/formula on the lesson row
  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Number of Solutions',
    concept_content = E'Not every linear equation has a single answer. On the SAT you must recognise **three possible outcomes** when you simplify a linear equation:\n\n**One solution** — the variable terms have **different coefficients** on each side. After simplifying you get a statement like x = 5.\n\n**No solution (zero)** — the variable terms cancel out and you are left with a **false statement** like 3 = 7. No value of x can make the equation true.\n\n**Infinitely many solutions** — the variable terms cancel out and you are left with a **true statement** like 5 = 5. Every value of x works because both sides are identical (an **identity**).\n\n**Quick test:** Put the equation in the form Ax + B = Cx + D.\n- If A ≠ C → **one solution**\n- If A = C and B ≠ D → **no solution**\n- If A = C and B = D → **infinitely many solutions**',
    formula_title = 'Worked Example',
    formula_content = E'Determine the number of solutions:\n  2(x − 4) = 2x − 4\n\nStep 1 — Simplify both sides\n  Left:  2x − 8\n  Right: 2x − 4\n\nStep 2 — Compare coefficients\n  x-coefficient: 2 = 2  (same)\n  Constants:    −8 ≠ −4  (different)\n\nStep 3 — Conclude\n  Variable terms cancel → −8 = −4\n  False statement → Zero solutions'
  WHERE id = lid;

  -- Upsert interactive content (steps + quiz)
  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Learn how to instantly tell whether an SAT linear equation has zero, one, or infinitely many solutions.',
    '[
      {"title": "Simplify both sides", "content": "Distribute and combine like terms so each side is in the form Ax + B.", "equation": "2(x − 4) → 2x − 8", "highlight": "expand first"},
      {"title": "Compare the x-coefficients", "content": "Look at the coefficient of x on the left vs the right. If they are different, the equation has exactly one solution — stop here and solve.", "equation": "3x + … = 5x + … → coefficients differ → one solution", "highlight": "different coefficients = one solution"},
      {"title": "If coefficients match, compare constants", "content": "When the x-coefficients are the same, the x-terms cancel. Check the remaining constants.", "highlight": "same coefficient → look at constants"},
      {"title": "Same constants → infinitely many", "content": "If both the coefficients AND the constants match, the two sides are identical. Every value of x works.", "equation": "5x + 3 = 5x + 3 → identity → ∞ solutions", "highlight": "identity"},
      {"title": "Different constants → no solution", "content": "If the coefficients match but the constants differ, you get a false statement like 3 = 7. No value of x works.", "equation": "5x + 3 = 5x + 7 → 3 = 7 → 0 solutions", "highlight": "contradiction"}
    ]'::jsonb,
    '[
      {"question": "Which of the following equations has infinitely many solutions?", "options": ["4x + 5 = 4x + 10", "2(x + 3) = 2x + 6", "3x + 1 = 3x − 1", "5x + 2 = 2x + 5"], "answer": 1, "explanation": "Distribute in B: 2x + 6 = 2x + 6. Both sides are identical — an identity with infinitely many solutions.", "difficulty": "Medium"},
      {"question": "ax + 12 = 5x + 12. If the equation has infinitely many solutions, what is the value of a?", "options": ["0", "5", "12", "17"], "answer": 1, "explanation": "Constants already match (12 = 12). For an identity, the x-coefficients must also match: a = 5.", "difficulty": "Medium"},
      {"question": "3x + 7 = 3x + b. If the equation has no solution, which of the following could be the value of b?", "options": ["0", "7", "Both 0 and 7", "Neither 0 nor 7"], "answer": 0, "explanation": "Subtract 3x: 7 = b. If b = 7 → infinite solutions. If b ≠ 7 (e.g. b = 0) → 7 = 0 is false → no solution.", "difficulty": "Medium"},
      {"question": "Which of the following equations has exactly one solution?", "options": ["x + x = 2x", "5(x − 1) = 5x − 5", "2x + 10 = 3x + 10", "4x − 8 = 4x + 2"], "answer": 2, "explanation": "C: coefficients differ (2 vs 3) → one solution. A and B are identities. D is a contradiction.", "difficulty": "Medium"},
      {"question": "kx + 5 = 5. If the equation is true for all values of x, what is the value of k?", "options": ["0", "1", "5", "Any value"], "answer": 0, "explanation": "Right side = 0·x + 5. For the equation to be an identity, the x-coefficient must be 0, so k = 0.", "difficulty": "Medium"},
      {"question": "If 3(2x + 4) = ax + b has infinitely many solutions, what is the value of a + b?", "options": ["6", "12", "18", "24"], "answer": 2, "explanation": "Distribute: 6x + 12 = ax + b. For identity: a = 6, b = 12. So a + b = 18.", "difficulty": "Medium"},
      {"question": "4x + 1 = 4x + c. If the equation has no solution, which is a possible value for c?", "options": ["1", "0", "Both 1 and 0", "None of the above"], "answer": 1, "explanation": "Subtract 4x: 1 = c. If c = 1 → infinite. If c = 0 → 1 = 0 (false) → no solution.", "difficulty": "Medium"},
      {"question": "How many solutions does the equation 2(x − 4) = 2x − 4 have?", "options": ["Zero", "Exactly one", "Infinitely many", "Exactly two"], "answer": 0, "explanation": "Distribute: 2x − 8 = 2x − 4. Subtract 2x: −8 = −4. False → zero solutions.", "difficulty": "Medium"},
      {"question": "(1/2)(4x + 10) = ax + 5. If the equation has infinitely many solutions, what is the value of a?", "options": ["2", "4", "5", "10"], "answer": 0, "explanation": "Distribute: 2x + 5 = ax + 5. Constants match. For identity: a = 2.", "difficulty": "Hard"},
      {"question": "5x − 3 = 5x − 3. How many solutions does the given equation have?", "options": ["Zero", "Exactly one", "Infinitely many", "Exactly two"], "answer": 2, "explanation": "Both sides are identical. Every value of x satisfies the equation — infinitely many solutions.", "difficulty": "Medium"},
      {"question": "mx + 10 = 2x + 5. If the equation has exactly one solution, which of the following cannot be the value of m?", "options": ["−2", "0", "2", "10"], "answer": 2, "explanation": "One solution requires m ≠ 2. If m = 2: 2x + 10 = 2x + 5 → 10 = 5 (no solution).", "difficulty": "Medium"},
      {"question": "8x + 4 = 2(4x + 2). How many solutions does the given equation have?", "options": ["Zero", "Exactly one", "Infinitely many", "Exactly two"], "answer": 2, "explanation": "Distribute: 8x + 4 = 8x + 4. Identity → infinitely many solutions.", "difficulty": "Medium"},
      {"question": "Which value of c makes 5x + c = 5x + 7 have no solution?", "options": ["7", "0", "Any value except 7", "Any value except 0"], "answer": 2, "explanation": "Subtract 5x: c = 7. If c = 7 → infinite. Any other value → false statement → no solution.", "difficulty": "Medium"},
      {"question": "4(x + 1) = 4x + 4. How many solutions?", "options": ["0", "1", "Infinitely many", "4"], "answer": 2, "explanation": "Distribute: 4x + 4 = 4x + 4. Both sides identical → infinitely many.", "difficulty": "Medium"},
      {"question": "2x + 8 = 2x + 10. How many solutions?", "options": ["Zero", "One", "Infinite", "Two"], "answer": 0, "explanation": "Subtract 2x: 8 = 10. False → zero solutions.", "difficulty": "Medium"},
      {"question": "If 5x + a = bx + 4 has infinitely many solutions, what is a?", "options": ["4", "5", "x", "0"], "answer": 0, "explanation": "For identity: b = 5 (coefficients match) and a = 4 (constants match).", "difficulty": "Medium"},
      {"question": "10x − 5 = 10x − 5. How many solutions?", "options": ["Zero", "One", "Infinitely many", "10"], "answer": 2, "explanation": "Both sides are identical — an identity with infinitely many solutions.", "difficulty": "Medium"},
      {"question": "A storage tank has 5,000 liters. After 2 hours of draining at a constant rate, 4,200 liters remain. How many total hours to reach 2,600 liters?", "options": ["4", "5", "6", "8"], "answer": 2, "explanation": "Removed in 2 hrs: 800 L. Rate = 400 L/hr. Need to remove 5,000 − 2,600 = 2,400. Time = 2,400 ÷ 400 = 6 hours.", "difficulty": "Hard"},
      {"question": "What value of p satisfies 7p + 140 = 700?", "options": ["80", "120", "560", "700"], "answer": 0, "explanation": "Subtract 140: 7p = 560. Divide by 7: p = 80.", "difficulty": "Easy"},
      {"question": "If 10x − 50 = 20, what is the value of 2x − 10?", "options": ["4", "10", "14", "20"], "answer": 0, "explanation": "2x − 10 is one-fifth of 10x − 50. Divide: 20 ÷ 5 = 4.", "difficulty": "Medium"},
      {"question": "15x + 5 = 155. What is x?", "options": ["10", "11", "15", "150"], "answer": 0, "explanation": "Subtract 5: 15x = 150. Divide by 15: x = 10.", "difficulty": "Easy"},
      {"question": "A painter charges $200 for supplies plus $40 per hour. If the total bill was $600, which equation models the hours worked, h?", "options": ["40h + 200 = 600", "200h + 40 = 600", "240h = 600", "40h = 600"], "answer": 0, "explanation": "Fixed cost ($200) plus variable labor (40h) equals total: 40h + 200 = 600.", "difficulty": "Medium"},
      {"question": "If 4x + 2 = 10, what is 8x − 5?", "options": ["11", "15", "16", "20"], "answer": 0, "explanation": "4x = 8, so x = 2. Then 8(2) − 5 = 16 − 5 = 11.", "difficulty": "Medium"},
      {"question": "2x + 3x + 10 = 60. Value of x?", "options": ["10", "12", "25", "50"], "answer": 0, "explanation": "Combine: 5x + 10 = 60. Subtract 10: 5x = 50. Divide by 5: x = 10.", "difficulty": "Easy"},
      {"question": "(w + 2) − 5 = 10. What is w?", "options": ["3", "7", "13", "17"], "answer": 2, "explanation": "Simplify: w − 3 = 10. Add 3: w = 13.", "difficulty": "Easy"},
      {"question": "5(x − 2) = 25. Which equation has the same solution?", "options": ["x − 2 = 5", "x − 2 = 20", "5x − 2 = 25", "5x − 10 = 5"], "answer": 0, "explanation": "Divide both sides by 5: x − 2 = 5.", "difficulty": "Easy"},
      {"question": "Solve for x: 0.5x + 2 = 10.", "options": ["12", "14", "16", "20"], "answer": 2, "explanation": "Subtract 2: 0.5x = 8. Divide by 0.5 (same as multiply by 2): x = 16.", "difficulty": "Medium"},
      {"question": "3(x + 4) = 2x − 5. What is x?", "options": ["−17", "−13", "−7", "1"], "answer": 0, "explanation": "Distribute: 3x + 12 = 2x − 5. Subtract 2x: x + 12 = −5. Subtract 12: x = −17.", "difficulty": "Medium"},
      {"question": "7x + 14 = 7x + k. If the equation has no solution, which could be the value of k?", "options": ["0", "7", "14", "21"], "answer": 0, "explanation": "Subtract 7x: 14 = k. For no solution, k ≠ 14. k = 0 gives 14 = 0 (false) → no solution.", "difficulty": "Medium"},
      {"question": "(1/2)(ax + 8) = 4x + 4. If the equation has infinitely many solutions, what is the value of a?", "options": ["4", "6", "8", "16"], "answer": 2, "explanation": "Distribute: (a/2)x + 4 = 4x + 4. Constants match. Set a/2 = 4 → a = 8.", "difficulty": "Hard"},
      {"question": "10x + 5 = 5(2x + k). If infinite solutions, what is k?", "options": ["1", "2", "5", "10"], "answer": 0, "explanation": "Expand right: 10x + 5k. Equation: 10x + 5 = 10x + 5k. Set 5 = 5k → k = 1.", "difficulty": "Medium"},
      {"question": "4x + c = ax + 9. If the equation has infinitely many solutions, what is a + c?", "options": ["9", "11", "13", "15"], "answer": 2, "explanation": "For identity: a = 4 and c = 9. So a + c = 13.", "difficulty": "Hard"},
      {"question": "3x − 6 = 3x + b. If the equation has no solution, what is the only value b cannot be?", "options": ["−6", "−3", "0", "6"], "answer": 0, "explanation": "Subtract 3x: −6 = b. If b = −6 → true (infinite). For no solution, b ≠ −6.", "difficulty": "Medium"},
      {"question": "2(3x + 5) = 6x + 2k. If the equation is an identity, what is k?", "options": ["3", "5", "6", "10"], "answer": 1, "explanation": "Expand left: 6x + 10 = 6x + 2k. Set 10 = 2k → k = 5.", "difficulty": "Hard"},
      {"question": "ax + 4 = 12x + 4. If the equation has exactly one solution, what is one value a cannot be?", "options": ["4", "8", "12", "16"], "answer": 2, "explanation": "One solution requires different x-coefficients. If a = 12, both sides are identical (infinite solutions). So a ≠ 12.", "difficulty": "Medium"},
      {"question": "5(x − c) = 5x − 10. If infinite solutions, what is c?", "options": ["1", "2", "5", "10"], "answer": 1, "explanation": "Distribute: 5x − 5c = 5x − 10. Set 5c = 10 → c = 2.", "difficulty": "Hard"},
      {"question": "0 · x = 0. How many solutions does this equation have?", "options": ["Zero", "Exactly one", "Infinitely many", "Cannot be determined"], "answer": 2, "explanation": "0 = 0 is always true regardless of x. Infinitely many solutions.", "difficulty": "Medium"},
      {"question": "0 · x = 10. How many solutions does this equation have?", "options": ["Zero", "Exactly one", "Infinitely many", "Ten"], "answer": 0, "explanation": "0 = 10 is always false. No value of x can make it true — zero solutions.", "difficulty": "Medium"},
      {"question": "3(x + 2) = 3x + c. If the equation has no solution, which could be the value of c?", "options": ["0", "3", "6", "9"], "answer": 0, "explanation": "Expand: 3x + 6 = 3x + c. Subtract 3x: 6 = c. For no solution c ≠ 6. c = 0 gives 6 = 0 (false).", "difficulty": "Hard"},
      {"question": "x + 5 = x + 5. How many solutions?", "options": ["Zero", "Exactly one", "Infinitely many", "Five"], "answer": 2, "explanation": "Both sides are identical — an identity. Infinitely many solutions.", "difficulty": "Medium"},
      {"question": "ax + b = 2x + 3. If infinite solutions, what is a × b?", "options": ["5", "6", "7", "8"], "answer": 1, "explanation": "For identity: a = 2 and b = 3. Product: 2 × 3 = 6.", "difficulty": "Hard"},
      {"question": "10x − 2 = 10x + 2. How many solutions?", "options": ["Zero", "Exactly one", "Infinitely many", "Two"], "answer": 0, "explanation": "Subtract 10x: −2 = 2. False → zero solutions.", "difficulty": "Medium"},
      {"question": "x = x. How many solutions?", "options": ["Zero", "Exactly one", "Infinitely many", "Cannot be determined"], "answer": 2, "explanation": "This is the simplest identity — true for every value of x. Infinitely many solutions.", "difficulty": "Medium"},
      {"question": "4(x + k) = 4x + 20. If infinite solutions, what is k?", "options": ["4", "5", "10", "20"], "answer": 1, "explanation": "Expand: 4x + 4k = 4x + 20. Set 4k = 20 → k = 5.", "difficulty": "Hard"},
      {"question": "x + 1 = 2x + 1. How many solutions?", "options": ["Zero", "Exactly one", "Infinitely many", "Two"], "answer": 1, "explanation": "Subtract x and 1: 0 = x. Exactly one solution: x = 0.", "difficulty": "Medium"},
      {"question": "ax + 7 = 7x + 7. If infinite solutions, what is a?", "options": ["1", "3", "5", "7"], "answer": 3, "explanation": "Constants match (7 = 7). For identity, x-coefficients must match: a = 7.", "difficulty": "Hard"},
      {"question": "(1/3)(3x + 9) = x + 3. How many solutions?", "options": ["Zero", "Exactly one", "Infinitely many", "Three"], "answer": 2, "explanation": "Distribute: x + 3 = x + 3. Identity → infinitely many solutions.", "difficulty": "Medium"},
      {"question": "5x = 5x + 1. How many solutions?", "options": ["Zero", "Exactly one", "Infinitely many", "Five"], "answer": 0, "explanation": "Subtract 5x: 0 = 1. False → zero solutions.", "difficulty": "Medium"},
      {"question": "2(x + 5) = 2x + 10. How many solutions?", "options": ["Zero", "Exactly one", "Infinitely many", "Exactly two"], "answer": 2, "explanation": "Distribute: 2x + 10 = 2x + 10. Identity → infinitely many solutions.", "difficulty": "Hard"},
      {"question": "3x + 4 = 3x + 1. How many solutions?", "options": ["Zero", "Exactly one", "Infinitely many", "Exactly two"], "answer": 0, "explanation": "Subtract 3x: 4 = 1. False statement → zero solutions.", "difficulty": "Hard"},
      {"question": "If (1/2)x + (1/4)x = 6, what is x?", "options": ["4", "6", "8", "12"], "answer": 2, "explanation": "Combine: (2/4)x + (1/4)x = (3/4)x = 6. Multiply by 4: 3x = 24. Divide by 3: x = 8.", "difficulty": "Medium"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-003: %', lid;
END $$;

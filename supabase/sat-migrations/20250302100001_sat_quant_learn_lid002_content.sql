-- Populate lesson sat-quant-learn-sat-lid-002 with theory + practice (interactive content).
-- Topic: Linear Equation Word Problems
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-002'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-002; skipping content seed.';
    RETURN;
  END IF;

  -- Set lesson type and concept/formula on the lesson row
  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Linear Equation Word Problems',
    concept_content = E'Word problems ask you to **translate a real-world scenario into a linear equation** and then solve it.\n\nThe SAT tests this by describing situations with a **fixed amount** (constant) and an **amount that changes** (variable term). Your job is to identify each part and write the equation.\n\n**Common patterns on the SAT:**\n- **Cost / pricing:** total = rate × quantity + fixed fee\n- **Distance / rate:** distance = speed × time\n- **Production / work:** total output = rate × time ± starting amount\n\n**Key skill:** Read the problem twice — once for context and once to assign numbers to the variable and the constant.',
    formula_title = 'Worked Example',
    formula_content = E'Problem: A gym charges a $50 registration fee\nplus $30 per month. After how many months\nwill a member have paid a total of $290?\n\nStep 1 — Define the variable\n  Let m = number of months\n\nStep 2 — Write the equation\n  30m + 50 = 290\n\nStep 3 — Solve\n  30m = 290 − 50\n  30m = 240\n  m = 240 ÷ 30\n  m = 8\n\nAnswer: 8 months'
  WHERE id = lid;

  -- Upsert interactive content (steps + quiz)
  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Learn how to turn SAT word problems into simple linear equations you can solve in seconds.',
    '[
      {"title": "Read & define the variable", "content": "Read the problem fully. Identify the unknown quantity and assign it a variable (e.g., let x = number of hours).", "highlight": "what is the question asking for?"},
      {"title": "Identify the constant and the rate", "content": "Find the fixed amount that does not change and the per-unit rate that is multiplied by the variable.", "equation": "total = rate × variable + constant", "highlight": "separate fixed from variable"},
      {"title": "Write the equation", "content": "Translate the sentence into algebra. Words like ''total,'' ''combined,'' or ''altogether'' signal the equation''s value.", "highlight": "translate words → math"},
      {"title": "Solve the equation", "content": "Use inverse operations: subtract the constant, then divide by the rate (or vice-versa) to isolate the variable.", "equation": "rate × x + constant = total → x = (total − constant) ÷ rate", "highlight": "isolate the variable"},
      {"title": "Check in context", "content": "Plug your answer back into the original scenario to verify it makes sense (positive value, reasonable size, correct units).", "highlight": "does the answer make sense?"}
    ]'::jsonb,
    '[
      {"question": "A plumbing company charges a fixed service call fee of $75 plus an hourly labor rate of $60. If a customer was charged a total of $315 for a repair, which equation represents the number of hours, h, the plumber worked?", "options": ["75h + 60 = 315", "60h + 75 = 315", "135h = 315", "60h − 75 = 315"], "answer": 1, "explanation": "The service call fee ($75) is a constant. The hourly rate ($60) is multiplied by h, giving 60h. Total: 60h + 75 = 315.", "difficulty": "Medium"},
      {"question": "If 4x + 5 = 17, what is the value of 12x + 15?", "options": ["34", "46", "51", "66"], "answer": 2, "explanation": "Each term in 12x + 15 is three times the corresponding term in 4x + 5. Multiply the entire equation by 3: 3(4x + 5) = 3(17) → 12x + 15 = 51.", "difficulty": "Medium"},
      {"question": "What value of p satisfies the equation 5p + 140 = 390?", "options": ["50", "70", "110", "250"], "answer": 0, "explanation": "Subtract 140: 5p = 250. Divide by 5: p = 50. Check: 5(50) + 140 = 390 ✓.", "difficulty": "Medium"},
      {"question": "15x − 8x + 120 = 260. What value of x is the solution to the given equation?", "options": ["20", "40", "80", "140"], "answer": 0, "explanation": "Combine like terms: 7x + 120 = 260. Subtract 120: 7x = 140. Divide by 7: x = 20.", "difficulty": "Medium"},
      {"question": "(m + 8) + 17 = 40. What value of m is the solution to the given equation?", "options": ["15", "23", "32", "48"], "answer": 0, "explanation": "Remove parentheses and combine constants: m + 25 = 40. Subtract 25: m = 15.", "difficulty": "Easy"},
      {"question": "If 3x − 18 = 12, what is the value of x − 6?", "options": ["4", "10", "14", "30"], "answer": 0, "explanation": "Factor: 3(x − 6) = 12. Divide both sides by 3: x − 6 = 4.", "difficulty": "Medium"},
      {"question": "5(3x − 2) = 35. Which equation has the same solution?", "options": ["3x − 2 = 7", "3x − 2 = 30", "15x − 2 = 35", "15x − 10 = 7"], "answer": 0, "explanation": "Divide both sides by 5: 3x − 2 = 7.", "difficulty": "Medium"},
      {"question": "A tank contained 8,000 gallons of water. A pump removes water at a constant rate. After 4 hours, 6,800 gallons remain. At this rate, how many total hours will the pump have run when 3,500 gallons remain?", "options": ["9", "12", "15", "18"], "answer": 2, "explanation": "Removed in 4 hrs: 8,000 − 6,800 = 1,200. Rate = 300 gal/hr. To reach 3,500: need to remove 4,500. Time = 4,500 ÷ 300 = 15 hours.", "difficulty": "Hard"},
      {"question": "If 2x + 7 = 19, what is the value of 6x + 5?", "options": ["36", "41", "48", "52"], "answer": 1, "explanation": "2x = 12, so 6x = 36. Then 36 + 5 = 41.", "difficulty": "Medium"},
      {"question": "7x + 14 = 154. What is the solution to the given equation?", "options": ["20", "22", "24", "140"], "answer": 0, "explanation": "Subtract 14: 7x = 140. Divide by 7: x = 20.", "difficulty": "Medium"},
      {"question": "Laila paid $180 for a gym membership which included a $60 registration fee and m monthly payments of $15. Which equation represents this situation?", "options": ["60m + 15 = 180", "15m + 60 = 180", "75m = 180", "15m − 60 = 180"], "answer": 1, "explanation": "The registration fee ($60) is fixed. Monthly cost is 15m. Total: 15m + 60 = 180.", "difficulty": "Medium"},
      {"question": "If 9x − 81 = 18, what is the value of x − 9?", "options": ["2", "9", "11", "20"], "answer": 0, "explanation": "Factor: 9(x − 9) = 18. Divide by 9: x − 9 = 2.", "difficulty": "Medium"},
      {"question": "14x − 10x + 50 = 110. What is the value of x?", "options": ["15", "30", "45", "60"], "answer": 0, "explanation": "Combine: 4x + 50 = 110. Subtract 50: 4x = 60. Divide by 4: x = 15.", "difficulty": "Medium"},
      {"question": "(y − 5) + 12 = 30. What is y?", "options": ["13", "18", "23", "47"], "answer": 2, "explanation": "Simplify constants: y + 7 = 30. Subtract 7: y = 23.", "difficulty": "Easy"},
      {"question": "If 4x + 2 = 18, what is the value of 20x + 10?", "options": ["80", "90", "100", "110"], "answer": 1, "explanation": "20x + 10 is 5 times (4x + 2). Multiply: 5 × 18 = 90.", "difficulty": "Medium"},
      {"question": "6(2x + 3) = 54. Which equation has the same solution?", "options": ["2x + 3 = 9", "2x + 3 = 48", "12x + 3 = 54", "12x + 18 = 9"], "answer": 0, "explanation": "Divide both sides by 6: 2x + 3 = 9.", "difficulty": "Medium"},
      {"question": "A storage unit had 500 liters of fuel. It is used at a constant rate of 40 liters per hour. After h hours, 140 liters remain. How many total hours have passed?", "options": ["7", "9", "11", "13"], "answer": 1, "explanation": "Fuel used: 500 − 140 = 360. At 40 L/hr: h = 360 ÷ 40 = 9.", "difficulty": "Hard"},
      {"question": "What value of n satisfies 8n + 160 = 800?", "options": ["80", "100", "120", "640"], "answer": 0, "explanation": "Subtract 160: 8n = 640. Divide by 8: n = 80.", "difficulty": "Easy"},
      {"question": "If 10x − 40 = 30, what is the value of 2x − 8?", "options": ["6", "10", "14", "18"], "answer": 0, "explanation": "Each term in 2x − 8 is one-fifth of 10x − 40. Divide by 5: 2x − 8 = 6.", "difficulty": "Medium"},
      {"question": "11x + 9 = 130. What is x?", "options": ["11", "12", "13", "121"], "answer": 0, "explanation": "Subtract 9: 11x = 121. Divide by 11: x = 11.", "difficulty": "Easy"},
      {"question": "A mechanic charges $80 for diagnosis plus $55 per hour for labor. If the bill was $300, which equation models the number of hours worked, h?", "options": ["55h + 80 = 300", "80h + 55 = 300", "135h = 300", "55h = 300"], "answer": 0, "explanation": "Fixed fee ($80) plus variable labor (55h) equals total: 55h + 80 = 300.", "difficulty": "Medium"},
      {"question": "If 5x + 3 = 18, what is 10x − 4?", "options": ["26", "30", "32", "36"], "answer": 0, "explanation": "5x = 15, so 10x = 30. Then 30 − 4 = 26.", "difficulty": "Medium"},
      {"question": "3x + 2x + 12 = 72. Value of x?", "options": ["12", "14", "16", "60"], "answer": 0, "explanation": "Combine: 5x + 12 = 72. Subtract 12: 5x = 60. Divide by 5: x = 12.", "difficulty": "Easy"},
      {"question": "(w + 4) − 9 = 11. What is w?", "options": ["14", "16", "18", "24"], "answer": 1, "explanation": "Simplify: w − 5 = 11. Add 5: w = 16.", "difficulty": "Easy"},
      {"question": "6(x − 4) = 36. Which equation has the same solution?", "options": ["x − 4 = 6", "x − 4 = 30", "6x − 4 = 36", "6x − 24 = 6"], "answer": 0, "explanation": "Divide both sides by 6: x − 4 = 6.", "difficulty": "Easy"},
      {"question": "A caterer charges a delivery fee of $45 and $18 per guest. If the total bill was $495, how many guests attended the event?", "options": ["20", "25", "28", "30"], "answer": 1, "explanation": "18g + 45 = 495. Subtract 45: 18g = 450. Divide by 18: g = 25.", "difficulty": "Medium"},
      {"question": "A rental car costs $35 per day plus $0.20 per mile. If the total bill for one day was $75, how many miles were driven?", "options": ["150", "175", "200", "225"], "answer": 2, "explanation": "0.20m + 35 = 75. Subtract 35: 0.20m = 40. Divide by 0.20: m = 200.", "difficulty": "Medium"},
      {"question": "A savings account started with $150. Every month, $45 is deposited. After how many months will the account balance be $780?", "options": ["12", "14", "16", "18"], "answer": 1, "explanation": "45x + 150 = 780. Subtract 150: 45x = 630. Divide by 45: x = 14.", "difficulty": "Medium"},
      {"question": "A candle is 25 cm tall and burns at a rate of 1.5 cm per hour. After how many hours will the candle be exactly 13 cm tall?", "options": ["6", "8", "10", "12"], "answer": 1, "explanation": "25 − 1.5t = 13. Subtract 25: −1.5t = −12. Divide by −1.5: t = 8.", "difficulty": "Medium"},
      {"question": "An elevator starts on the 40th floor and descends at a rate of 2 floors per second. After how many seconds is the elevator on the 12th floor?", "options": ["10", "12", "14", "16"], "answer": 2, "explanation": "40 − 2s = 12. Subtract 40: −2s = −28. Divide by −2: s = 14.", "difficulty": "Medium"},
      {"question": "A cell phone plan costs $30 per month plus $0.05 per text message. If the bill was $42.50, how many texts were sent?", "options": ["200", "225", "250", "275"], "answer": 2, "explanation": "0.05x + 30 = 42.50. Subtract 30: 0.05x = 12.50. Divide by 0.05: x = 250.", "difficulty": "Medium"},
      {"question": "A membership fee is $100, and each yoga class costs $12. If a person spent a total of $244, how many classes did they attend?", "options": ["10", "12", "14", "16"], "answer": 1, "explanation": "12c + 100 = 244. Subtract 100: 12c = 144. Divide by 12: c = 12.", "difficulty": "Medium"},
      {"question": "A printer can print 25 pages per minute. How many minutes will it take to print a document that is 350 pages long?", "options": ["12", "14", "16", "18"], "answer": 1, "explanation": "25m = 350. Divide by 25: m = 14.", "difficulty": "Medium"},
      {"question": "A car travels at 65 miles per hour. How many hours will it take to travel 520 miles?", "options": ["6", "8", "10", "12"], "answer": 1, "explanation": "65t = 520. Divide by 65: t = 8.", "difficulty": "Medium"},
      {"question": "A balloon is at an altitude of 1,200 feet and descends at a rate of 40 feet per minute. What is the altitude after 12 minutes?", "options": ["680", "720", "760", "800"], "answer": 1, "explanation": "A = 1,200 − 40(12) = 1,200 − 480 = 720.", "difficulty": "Medium"},
      {"question": "A baker uses 3 cups of flour for each loaf of bread. If they have 45 cups of flour, how many loaves can they make?", "options": ["12", "15", "18", "20"], "answer": 1, "explanation": "3x = 45. Divide by 3: x = 15.", "difficulty": "Medium"},
      {"question": "A tree is 4 feet tall and grows 1.5 feet per year. How many years will it take to reach a height of 19 feet?", "options": ["8", "10", "12", "15"], "answer": 1, "explanation": "1.5y + 4 = 19. Subtract 4: 1.5y = 15. Divide by 1.5: y = 10.", "difficulty": "Medium"},
      {"question": "A swimming pool contains 2,500 gallons of water and is being filled at a rate of 150 gallons per hour. How many gallons will be in the pool after 6 hours?", "options": ["3,150", "3,250", "3,400", "3,500"], "answer": 2, "explanation": "G = 2,500 + 150(6) = 2,500 + 900 = 3,400.", "difficulty": "Medium"},
      {"question": "A student has $250 in their bank account and withdraws $20 each week. After how many weeks will the balance be $90?", "options": ["6", "8", "10", "12"], "answer": 1, "explanation": "250 − 20w = 90. Subtract 250: −20w = −160. Divide by −20: w = 8.", "difficulty": "Medium"},
      {"question": "x/3 − 4 = 1. What is x?", "options": ["5", "10", "15", "20"], "answer": 2, "explanation": "Add 4: x/3 = 5. Multiply by 3: x = 15.", "difficulty": "Medium"},
      {"question": "If 10x = 80, what is x/2?", "options": ["2", "4", "6", "8"], "answer": 1, "explanation": "x = 8. Divide by 2: 8 ÷ 2 = 4.", "difficulty": "Easy"},
      {"question": "20 − (x + 5) = 10. What is x?", "options": ["3", "5", "7", "10"], "answer": 1, "explanation": "Distribute: 20 − x − 5 = 10 → 15 − x = 10. So x = 5.", "difficulty": "Medium"},
      {"question": "9x + 4 = 6x + 19. Value of x?", "options": ["3", "5", "7", "9"], "answer": 1, "explanation": "Subtract 6x: 3x + 4 = 19. Subtract 4: 3x = 15. Divide by 3: x = 5.", "difficulty": "Medium"},
      {"question": "5(2x − 8) = 0. What is x?", "options": ["2", "4", "6", "8"], "answer": 1, "explanation": "The quantity in parentheses must be 0: 2x − 8 = 0. So 2x = 8, x = 4.", "difficulty": "Medium"},
      {"question": "If x + x + x + x + x = 25, what is 2x?", "options": ["5", "10", "15", "20"], "answer": 1, "explanation": "5x = 25, so x = 5. Then 2x = 10.", "difficulty": "Easy"},
      {"question": "Solve: 1.5x + 0.5x = 14.", "options": ["5", "7", "9", "14"], "answer": 1, "explanation": "Combine: 2x = 14. Divide by 2: x = 7.", "difficulty": "Medium"},
      {"question": "If 4x = 16, what is 4x + 9?", "options": ["20", "25", "30", "35"], "answer": 1, "explanation": "Substitute 16 for 4x: 16 + 9 = 25.", "difficulty": "Easy"},
      {"question": "5(x + 3) = 5x + 15. How many solutions does this equation have?", "options": ["Zero", "Exactly one", "Infinitely many", "Exactly two"], "answer": 2, "explanation": "Distribute: 5x + 15 = 5x + 15. Both sides are identical, so the equation is true for all values of x — infinitely many solutions.", "difficulty": "Hard"},
      {"question": "4x + 1 = 4x + 9. How many solutions does this equation have?", "options": ["Zero", "Exactly one", "Infinitely many", "Exactly two"], "answer": 0, "explanation": "Subtract 4x: 1 = 9. This is a false statement, so no value of x satisfies the equation — zero solutions.", "difficulty": "Hard"},
      {"question": "If (1/5)x + (2/5)x = 9, what is x?", "options": ["9", "12", "15", "18"], "answer": 2, "explanation": "Combine fractions: (3/5)x = 9. Multiply by 5/3: x = 15.", "difficulty": "Medium"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-002: %', lid;
END $$;

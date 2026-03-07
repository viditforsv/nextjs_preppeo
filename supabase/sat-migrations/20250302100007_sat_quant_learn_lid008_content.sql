-- Populate lesson sat-quant-learn-sat-lid-008 with theory + practice (interactive content).
-- Topic: Systems Word Problems
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-008'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-008; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Systems Word Problems',
    concept_content = E'The SAT loves embedding systems of equations inside **real-world word problems**. You must translate the words into two equations, then solve.\n\n**The quantity-value pattern (most common):**\nAlmost every word problem follows the same two-equation template:\n1. **Quantity equation** — the total count of items: x + y = total\n2. **Value equation** — the total "worth" (cost, weight, points, time): ax + by = total value\n\nExamples: tickets sold, coins in a jar, foods in a mix, animals on a farm.\n\n**Mixture problems:**\nWhen mixing two solutions of different concentrations, the value equation tracks the amount of the pure substance:\n  (% of A)(volume of A) + (% of B)(volume of B) = (% of mix)(total volume)\n\n**Rate / distance problems:**\n- With wind/current: effective speed = base speed ± wind/current speed.\n- Segmented trips: total time = distance₁/speed₁ + distance₂/speed₂.\n\n**Geometry problems:**\n- Perimeter: 2L + 2W = P.\n- A relationship: L = 2W, or L = W + 5.\n\n**Solving strategy:**\n1. Define variables clearly.\n2. Write both equations.\n3. Solve using substitution (one variable isolated) or elimination (standard form).',
    formula_title = 'Worked Example',
    formula_content = E'A bookstore ordered 50 books. Paperbacks cost\n$10 each, hardcovers $18 each. Total order: $700.\nHow many hardcovers were ordered?\n\nStep 1 — Define variables\n  p = paperbacks, h = hardcovers\n\nStep 2 — Write the system\n  p + h = 50  (quantity)\n  10p + 18h = 700  (value)\n\nStep 3 — Eliminate p\n  Multiply quantity eq by 10: 10p + 10h = 500\n  Subtract from value eq:\n  (10p + 18h) − (10p + 10h) = 700 − 500\n  8h = 200\n\nStep 4 — Solve\n  h = 25\n\n25 hardcovers were ordered.'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Learn to translate real-world scenarios into systems of two equations and solve them — the most common application of linear systems on the SAT.',
    '[
      {"title": "Identify the two constraints", "content": "Every word problem gives you two independent pieces of information. Usually one is a count (total items) and the other is a value (total cost, weight, or time).", "highlight": "quantity equation + value equation"},
      {"title": "Define variables", "content": "Assign a letter to each unknown quantity. Be explicit: let x = number of adult tickets, y = number of child tickets. This avoids errors when setting up equations.", "highlight": "label your unknowns"},
      {"title": "Build the quantity equation", "content": "Sum the unknowns to match the given total. Example: x + y = 50 (total books).", "equation": "x + y = total count", "highlight": "items add up"},
      {"title": "Build the value equation", "content": "Multiply each variable by its unit value (price, weight, etc.) and set equal to the total. Example: 10x + 18y = 700.", "equation": "unit₁ · x + unit₂ · y = total value", "highlight": "weighted sum"},
      {"title": "Solve and check", "content": "Use substitution or elimination. After finding both variables, verify: do they satisfy BOTH equations? Does x + y match the total? Does the value check out?", "highlight": "always verify with both equations"}
    ]'::jsonb,
    '[
      {"question": "A craft store ordered 24 skeins: wool at $8 and acrylic at $5, totalling $150. Which system models this?", "options": ["w + a = 24; 8w + 5a = 150", "w + a = 150; 8w + 5a = 24", "8w + 5a = 24; w + a = 150", "5w + 8a = 150; w + a = 24"], "answer": 0, "explanation": "Quantity: w + a = 24. Value: 8w + 5a = 150.", "difficulty": "Medium"},
      {"question": "18 birds: parrots need 2 cups of seed/day, cockatoos need 5 cups. Total seed: 60 cups. How many cockatoos?", "options": ["6", "8", "10", "12"], "answer": 1, "explanation": "p + c = 18; 2p + 5c = 60. Substitute: 2(18 − c) + 5c = 60 → 3c = 24 → c = 8.", "difficulty": "Medium"},
      {"question": "40 processors tested: Type X takes 30 min, Type Y takes 50 min, total time 1,500 min. Which system is correct?", "options": ["x + y = 40; 30x + 50y = 1,500", "x + y = 1,500; 30x + 50y = 40", "30x + 50y = 40; x + y = 1,500", "x + y = 40; 50x + 30y = 1,500"], "answer": 0, "explanation": "Count: x + y = 40. Time: 30x + 50y = 1,500.", "difficulty": "Hard"},
      {"question": "Blending 20% saline with 60% saline to make 40 liters of 50% saline. How many liters of 60% solution?", "options": ["10", "20", "30", "35"], "answer": 2, "explanation": "L + H = 40; 0.20L + 0.60H = 20. Substitute: 0.20(40 − H) + 0.60H = 20 → 0.40H = 12 → H = 30.", "difficulty": "Hard"},
      {"question": "100 lbs of mulch: pine bark at $2/lb and cedar chips at $5/lb for $320 total. Which system is correct?", "options": ["p + c = 100; 2p + 5c = 320", "p + c = 320; 2p + 5c = 100", "2p + 5c = 100; p + c = 320", "p + c = 100; 5p + 2c = 320"], "answer": 0, "explanation": "Weight: p + c = 100. Cost: 2p + 5c = 320.", "difficulty": "Medium"},
      {"question": "50 books ordered: paperbacks $10, hardcovers $18. Total $700. How many hardcovers?", "options": ["15", "20", "25", "30"], "answer": 2, "explanation": "p + h = 50; 10p + 18h = 700. Eliminate: 8h = 200 → h = 25.", "difficulty": "Medium"},
      {"question": "120 movie tickets: child $8, adult $14. Revenue $1,320. Which system is correct?", "options": ["c + a = 120; 8c + 14a = 1,320", "c + a = 1,320; 8c + 14a = 120", "8c + 14a = 1,320; c + a = 1,320", "14c + 8a = 1,320; c + a = 120"], "answer": 0, "explanation": "Count: c + a = 120. Revenue: 8c + 14a = 1,320.", "difficulty": "Medium"},
      {"question": "15 model planes ($20) and cars ($12) for $220 total. How many planes?", "options": ["3", "4", "5", "6"], "answer": 2, "explanation": "p + c = 15; 20p + 12c = 220. Substitute: 20p + 12(15 − p) = 220 → 8p = 40 → p = 5.", "difficulty": "Medium"},
      {"question": "80 crates: small (10 kg) and large (25 kg), total weight 1,250 kg. Which system works?", "options": ["s + l = 80; 10s + 25l = 1,250", "s + l = 1,250; 10s + 25l = 80", "10s + 25l = 80; s + l = 80", "25s + 10l = 1,250; s + l = 80"], "answer": 0, "explanation": "Count: s + l = 80. Weight: 10s + 25l = 1,250.", "difficulty": "Medium"},
      {"question": "40 coins: quarters ($0.25) and dimes ($0.10), total $7.00. How many quarters?", "options": ["15", "20", "25", "30"], "answer": 1, "explanation": "q + d = 40; 0.25q + 0.10d = 7. Substitute: 0.25q + 0.10(40 − q) = 7 → 0.15q = 3 → q = 20.", "difficulty": "Medium"},
      {"question": "60 vehicles: cars (4 wheels) and motorcycles (2 wheels), 200 wheels total. Which system is correct?", "options": ["c + m = 60; 4c + 2m = 200", "c + m = 200; 4c + 2m = 60", "4c + 2m = 60; c + m = 60", "c + m = 60; 2c + 4m = 200"], "answer": 0, "explanation": "Vehicle count: c + m = 60. Wheel count: 4c + 2m = 200.", "difficulty": "Medium"},
      {"question": "50 test questions: +5 for correct, −2 for incorrect. Score: 180. How many correct?", "options": ["30", "35", "40", "45"], "answer": 2, "explanation": "c + i = 50; 5c − 2i = 180. Substitute: 5c − 2(50 − c) = 180 → 7c = 280 → c = 40.", "difficulty": "Medium"},
      {"question": "20 flowers: lilies $4, roses $6, total $104. Which system models this?", "options": ["L + r = 20; 4L + 6r = 104", "L + r = 104; 4L + 6r = 20", "4L + 6r = 104; L + r = 104", "L + r = 20; 6L + 4r = 104"], "answer": 0, "explanation": "Count: L + r = 20. Cost: 4L + 6r = 104.", "difficulty": "Medium"},
      {"question": "15 weights: 5-lb and 10-lb plates, total 110 lbs. How many 10-lb plates?", "options": ["5", "6", "7", "8"], "answer": 2, "explanation": "x + y = 15; 5x + 10y = 110. Substitute: 5(15 − y) + 10y = 110 → 5y = 35 → y = 7.", "difficulty": "Medium"},
      {"question": "45 drinks: small coffees $3, large coffees $5. Total $175. Which system is correct?", "options": ["s + L = 45; 3s + 5L = 175", "s + L = 175; 3s + 5L = 45", "3s + 5L = 175; s + L = 175", "s + L = 45; 5s + 3L = 175"], "answer": 0, "explanation": "Count: s + L = 45. Revenue: 3s + 5L = 175.", "difficulty": "Medium"},
      {"question": "24 socks: black and blue. Twice as many black as blue. How many blue?", "options": ["6", "8", "10", "12"], "answer": 1, "explanation": "B + L = 24; B = 2L. Substitute: 3L = 24 → L = 8.", "difficulty": "Medium"},
      {"question": "200 theater seats: floor ($50) and balcony ($30). Full-show revenue $7,600. Which system works?", "options": ["f + b = 200; 50f + 30b = 7,600", "f + b = 7,600; 50f + 30b = 200", "50f + 30b = 7,600; f + b = 7,600", "f + b = 200; 30f + 50b = 7,600"], "answer": 0, "explanation": "Seats: f + b = 200. Revenue: 50f + 30b = 7,600.", "difficulty": "Medium"},
      {"question": "A field has perimeter 60 m. Length is 6 m more than width. What is the width?", "options": ["10", "12", "14", "16"], "answer": 1, "explanation": "L + W = 30; L = W + 6. Substitute: (W + 6) + W = 30 → 2W = 24 → W = 12.", "difficulty": "Medium"},
      {"question": "12 fruits: apples $1.50, oranges $2.00. Total $21.00. Which system is correct?", "options": ["a + r = 12; 1.5a + 2r = 21", "a + r = 21; 1.5a + 2r = 12", "1.5a + 2r = 21; a + r = 21", "a + r = 12; 2a + 1.5r = 21"], "answer": 0, "explanation": "Count: a + r = 12. Budget: 1.5a + 2r = 21.", "difficulty": "Medium"},
      {"question": "Two numbers sum to 40, differ by 10. What is the smaller number?", "options": ["12", "15", "18", "20"], "answer": 1, "explanation": "x + y = 40; x − y = 10. Subtract: 2y = 30 → y = 15.", "difficulty": "Medium"},
      {"question": "10 lamps: small $15, large $25. Total $190. Which system models this?", "options": ["s + L = 10; 15s + 25L = 190", "s + L = 190; 15s + 25L = 10", "15s + 25L = 190; s + L = 190", "s + L = 10; 25s + 15L = 190"], "answer": 0, "explanation": "Count: s + L = 10. Budget: 15s + 25L = 190.", "difficulty": "Medium"},
      {"question": "30 stamps: 20-cent and 50-cent. Total value $12.00. How many 50-cent stamps?", "options": ["10", "15", "20", "25"], "answer": 2, "explanation": "x + y = 30; 0.20x + 0.50y = 12. Substitute: 0.20(30 − y) + 0.50y = 12 → 0.30y = 6 → y = 20.", "difficulty": "Medium"},
      {"question": "50 packages: Type A (4 lbs) and Type B (7 lbs). Total 260 lbs. Which system is correct?", "options": ["a + b = 50; 4a + 7b = 260", "a + b = 260; 4a + 7b = 50", "4a + 7b = 260; a + b = 260", "a + b = 50; 7a + 4b = 260"], "answer": 0, "explanation": "Count: a + b = 50. Weight: 4a + 7b = 260.", "difficulty": "Medium"},
      {"question": "20 tools: screwdrivers $5, hammers $12. Total $156. How many screwdrivers?", "options": ["8", "10", "12", "14"], "answer": 2, "explanation": "s + h = 20; 5s + 12h = 156. Substitute: 5s + 12(20 − s) = 156 → −7s = −84 → s = 12.", "difficulty": "Medium"},
      {"question": "100 employees: managers ($200/day) and workers ($120/day). Payroll $13,600. Which system is correct?", "options": ["m + w = 100; 200m + 120w = 13,600", "m + w = 13,600; 200m + 120w = 100", "200m + 120w = 13,600; m + w = 13,600", "m + w = 100; 120m + 200w = 13,600"], "answer": 0, "explanation": "Count: m + w = 100. Payroll: 200m + 120w = 13,600.", "difficulty": "Medium"},
      {"question": "A cyclist goes 40 miles with tailwind in 2 hrs, returns against the wind in 2.5 hrs. What is the wind speed?", "options": ["2 mph", "4 mph", "18 mph", "20 mph"], "answer": 0, "explanation": "c + w = 20; c − w = 16. Subtract: 2w = 4 → w = 2 mph.", "difficulty": "Hard"},
      {"question": "Plan A: $20 + $10/GB. Plan B: $50 + $5/GB. At how many GB are they equal?", "options": ["4", "5", "6", "8"], "answer": 2, "explanation": "20 + 10x = 50 + 5x → 5x = 30 → x = 6 GB.", "difficulty": "Hard"},
      {"question": "60 notes: $5 and $10. Total $420. Which system is correct?", "options": ["f + t = 60; 5f + 10t = 420", "f + t = 420; 5f + 10t = 60", "5f + 10t = 420; f + t = 420", "f + t = 60; 10f + 5t = 420"], "answer": 0, "explanation": "Count: f + t = 60. Value: 5f + 10t = 420.", "difficulty": "Medium"},
      {"question": "Rectangle: perimeter 40 cm, length = 3 × width. What is the length?", "options": ["5", "10", "15", "20"], "answer": 2, "explanation": "L + W = 20; L = 3W. Substitute: 4W = 20 → W = 5, L = 15.", "difficulty": "Hard"},
      {"question": "10 lbs of nuts: $3/lb and $8/lb mixed to cost $5/lb. Which system models this?", "options": ["x + y = 10; 3x + 8y = 50", "x + y = 10; 3x + 8y = 5", "3x + 8y = 10; x + y = 50", "x + y = 50; 3x + 8y = 10"], "answer": 0, "explanation": "Weight: x + y = 10. Total cost: 10 × $5 = $50 → 3x + 8y = 50.", "difficulty": "Hard"},
      {"question": "40 machines produce 200 parts/hr: Type A makes 4, Type B makes 6. How many Type B?", "options": ["10", "15", "20", "25"], "answer": 2, "explanation": "A + B = 40; 4A + 6B = 200. Substitute: 4(40 − B) + 6B = 200 → 2B = 40 → B = 20.", "difficulty": "Hard"},
      {"question": "A plane flies 1,200 miles: 3 hrs with wind, 4 hrs against. What is the wind speed?", "options": ["50", "350", "400", "300"], "answer": 0, "explanation": "p + w = 400; p − w = 300. Subtract: 2w = 100 → w = 50 mph.", "difficulty": "Hard"},
      {"question": "40 test questions: +3 correct, −2 incorrect. Score 85. How many correct?", "options": ["30", "31", "33", "35"], "answer": 2, "explanation": "c + i = 40; 3c − 2i = 85. Substitute: 3c − 2(40 − c) = 85 → 5c = 165 → c = 33.", "difficulty": "Hard"},
      {"question": "50 coins: nickels ($0.05) and dimes ($0.10). Total $3.50. Which system models this?", "options": ["n + d = 50; 0.05n + 0.10d = 3.50", "n + d = 3.50; 0.05n + 0.10d = 50", "0.05n + 0.10d = 3.50; n + d = 3.50", "n + d = 50; 0.10n + 0.05d = 3.50"], "answer": 0, "explanation": "Count: n + d = 50. Value: 0.05n + 0.10d = 3.50.", "difficulty": "Hard"},
      {"question": "Two supplementary angles: one is 20° more than three times the other. What is the smaller angle?", "options": ["30", "35", "40", "45"], "answer": 2, "explanation": "x + y = 180; x = 3y + 20. Substitute: (3y + 20) + y = 180 → 4y = 160 → y = 40.", "difficulty": "Hard"},
      {"question": "20 lbs of nuts: $4/lb and $9/lb mixed for $6/lb. Which system models this?", "options": ["x + y = 20; 4x + 9y = 120", "x + y = 20; 4x + 9y = 6", "4x + 9y = 120; x + y = 120", "x + y = 6; 4x + 9y = 20"], "answer": 0, "explanation": "Weight: x + y = 20. Total cost: 20 × $6 = $120 → 4x + 9y = 120.", "difficulty": "Hard"},
      {"question": "A runner covers 10 miles in 2 segments: 6 mph then 8 mph, total 1.5 hrs. How many miles was the first part?", "options": ["4", "5", "6", "7"], "answer": 2, "explanation": "d₁ + d₂ = 10; d₁/6 + d₂/8 = 1.5. Multiply by 24: 4d₁ + 3d₂ = 36. Substitute: d₁ = 6.", "difficulty": "Hard"},
      {"question": "40 resistors: 100-ohm and 250-ohm. Total resistance 6,400 ohms. Which system is correct?", "options": ["x + y = 40; 100x + 250y = 6,400", "x + y = 6,400; 100x + 250y = 40", "100x + 250y = 6,400; x + y = 6,400", "x + y = 40; 250x + 100y = 6,400"], "answer": 0, "explanation": "Count: x + y = 40. Resistance: 100x + 250y = 6,400.", "difficulty": "Hard"},
      {"question": "80 notes: $10 and $20. Total $1,100. Which system is correct?", "options": ["x + y = 80; 10x + 20y = 1,100", "x + y = 1,100; 10x + 20y = 80", "10x + 20y = 1,100; x + y = 1,100", "x + y = 80; 20x + 10y = 1,100"], "answer": 0, "explanation": "Count: x + y = 80. Value: 10x + 20y = 1,100.", "difficulty": "Hard"},
      {"question": "Rectangle: perimeter 50, width is 5 less than length. What is the width?", "options": ["8", "10", "12", "15"], "answer": 1, "explanation": "L + W = 25; W = L − 5. Substitute: L + (L − 5) = 25 → 2L = 30 → L = 15, W = 10.", "difficulty": "Hard"},
      {"question": "20 lbs: coffee at $6/lb and $11/lb mixed for $8/lb. Which system models this?", "options": ["x + y = 20; 6x + 11y = 160", "x + y = 20; 6x + 11y = 8", "6x + 11y = 20; x + y = 160", "x + y = 160; 6x + 11y = 20"], "answer": 0, "explanation": "Weight: x + y = 20. Total cost: 20 × $8 = $160 → 6x + 11y = 160.", "difficulty": "Hard"},
      {"question": "Two numbers sum to 60. One is 10 more than four times the other. What is the larger number?", "options": ["40", "45", "50", "55"], "answer": 2, "explanation": "x + y = 60; x = 4y + 10. Substitute: (4y + 10) + y = 60 → 5y = 50 → y = 10, x = 50.", "difficulty": "Hard"},
      {"question": "40 balls: red ($2) and blue ($5). Total $110. Which system is correct?", "options": ["r + b = 40; 2r + 5b = 110", "r + b = 110; 2r + 5b = 40", "2r + 5b = 110; r + b = 110", "r + b = 40; 5r + 2b = 110"], "answer": 0, "explanation": "Count: r + b = 40. Cost: 2r + 5b = 110.", "difficulty": "Hard"},
      {"question": "30 library books: novel fine $0.50, non-fiction fine $1.00. Total fines $21. How many novels?", "options": ["12", "15", "18", "20"], "answer": 2, "explanation": "n + f = 30; 0.50n + 1.00f = 21. Substitute: 0.50n + (30 − n) = 21 → −0.50n = −9 → n = 18.", "difficulty": "Hard"},
      {"question": "100 tools: screwdrivers $3, wrenches $6. Total $420. Which system works?", "options": ["s + w = 100; 3s + 6w = 420", "s + w = 420; 3s + 6w = 100", "3s + 6w = 420; s + w = 420", "s + w = 100; 6s + 3w = 420"], "answer": 0, "explanation": "Count: s + w = 100. Cost: 3s + 6w = 420.", "difficulty": "Hard"},
      {"question": "Two numbers sum to 80, differ by 20. What is the larger number?", "options": ["40", "45", "50", "55"], "answer": 2, "explanation": "x + y = 80; x − y = 20. Add: 2x = 100 → x = 50.", "difficulty": "Hard"},
      {"question": "60 items: Type X ($4) and Type Y ($9). Total $340. Which system is correct?", "options": ["x + y = 60; 4x + 9y = 340", "x + y = 340; 4x + 9y = 60", "4x + 9y = 340; x + y = 340", "x + y = 60; 9x + 4y = 340"], "answer": 0, "explanation": "Count: x + y = 60. Cost: 4x + 9y = 340.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-008: %', lid;
END $$;

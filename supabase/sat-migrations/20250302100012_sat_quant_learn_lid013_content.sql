-- Populate lesson sat-quant-learn-sat-lid-013 with theory + practice (interactive content).
-- Topic: Linear Growth & Decay Models
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-013'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-013; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Linear Growth & Decay Models',
    concept_content = E'Linear growth and decay models use the equation **y = mx + b** to describe quantities that increase or decrease at a **constant rate** over time.\n\n**Growth model (positive slope):**\n- y = (rate)(time) + initial value\n- Example: Bacteria population P = 150t + 2,000 → grows by 150 per hour, started at 2,000.\n\n**Decay model (negative slope):**\n- y = initial value − (rate)(time)\n- Example: Car value V = 28,500 − 2,100t → loses $2,100 per year, started at $28,500.\n\n**Key interpretations:**\n- **Slope** = the rate of change per unit time (growth rate or decay rate).\n- **Y-intercept** = the initial/starting value when t = 0.\n- **X-intercept** = when the quantity reaches zero (e.g., car worthless, tank empty).\n\n**Common SAT tasks:**\n1. Interpret what the slope or intercept means in context.\n2. Find when two models are equal (set them equal and solve).\n3. Find when a quantity hits a target (substitute and solve).\n4. Adjust the model when rates change (e.g., "rate increases by 20%").\n5. Compare growth vs. decay to find when one overtakes the other.',
    formula_title = 'Worked Example',
    formula_content = E'A water tank holds 1,200 gallons and drains\nat a constant rate. After 5 hours, 950 gallons\nremain. Find the linear model.\n\nStep 1 — Find the drain rate (slope)\n  Change = 950 − 1,200 = −250\n  Time = 5 hours\n  Rate = −250/5 = −50 gal/hr\n\nStep 2 — Write the model\n  W = 1,200 − 50t\n\nStep 3 — When is it empty?\n  0 = 1,200 − 50t\n  t = 24 hours'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Learn to build, interpret, and solve linear growth and decay models — one of the most frequent real-world SAT question patterns.',
    '[
      {"title": "Identify slope as the rate of change", "content": "The slope tells you how much the quantity changes per unit of time. Positive slope = growth, negative slope = decay. The units of the slope match the context (e.g., dollars/year, gallons/hour).", "highlight": "slope = rate per unit time"},
      {"title": "Identify the y-intercept as the initial value", "content": "The constant term (b) is the value when time = 0. In context, it is the starting amount, purchase price, or opening balance.", "highlight": "b = starting value at t = 0"},
      {"title": "Build the model from context", "content": "Identify the initial value and the rate from the problem. If the quantity is decreasing, make the slope negative. Structure: y = (rate)(time) + initial.", "equation": "W = 1200 − 50t", "highlight": "initial − rate × time"},
      {"title": "Solve for a target value", "content": "Substitute the target for y and solve for time t. Remember to convert units if needed (e.g., minutes to hours).", "equation": "100 = 0.8m + 15 → m = 106.25 min", "highlight": "plug in target, solve for time"},
      {"title": "Compare two models", "content": "To find when two quantities are equal, set their expressions equal and solve. To find when one overtakes the other, use an inequality.", "equation": "1.5t + 10 = 2t + 4 → t = 12", "highlight": "set equal or use inequality"}
    ]'::jsonb,
    '[
      {"question": "P = 150t + 2,000 models bacteria population. What does 150 represent?", "options": ["The initial bacteria count", "Hours to reach 2,000", "The hourly increase in bacteria", "Total bacteria after 150 hours"], "answer": 2, "explanation": "150 is the slope — the rate of increase per hour.", "difficulty": "Medium"},
      {"question": "V = 28,500 − 2,100t models a car''s value. What does 28,500 represent?", "options": ["Value after 1 year", "Annual depreciation", "Years until worthless", "Purchase price"], "answer": 3, "explanation": "At t = 0, V = 28,500. This is the value at purchase.", "difficulty": "Medium"},
      {"question": "Tank: 1,200 gallons, 950 after 5 hrs. Which model?", "options": ["W = 1,200 − 50t", "W = 1,200 − 250t", "W = 950 − 50t", "W = 1,200 − 5t"], "answer": 0, "explanation": "Rate = (950 − 1200)/5 = −50. W = 1,200 − 50t.", "difficulty": "Hard"},
      {"question": "P = 25h + 40 (worker pay). Hourly rate increases by $5. New equation?", "options": ["P = 25h + 45", "P = 30h + 40", "P = 30h + 45", "P = 5h + 40"], "answer": 1, "explanation": "New rate = 30, stipend stays 40. P = 30h + 40.", "difficulty": "Easy"},
      {"question": "A heated liquid cools from 60°C. At 4 min, temp is 40°C. Cooling rate?", "options": ["20 degrees/min", "40°C initially", "5 degrees/min", "10 minutes to reach 0"], "answer": 2, "explanation": "Rate = (40 − 60)/4 = −5°C/min.", "difficulty": "Hard"},
      {"question": "E = 800h + 1,200 models elevation. What was the starting elevation?", "options": ["0 feet", "800 feet", "1,200 feet", "2,000 feet"], "answer": 2, "explanation": "At h = 0, E = 1,200.", "difficulty": "Medium"},
      {"question": "Library: 5,000 books, adds n/month. After 12 months: 5,720. What is n?", "options": ["60", "72", "120", "572"], "answer": 0, "explanation": "5,720 = 5,000 + 12n → n = 60.", "difficulty": "Hard"},
      {"question": "B = 0.8m + 15 (battery %). Minutes to reach 100%?", "options": ["85", "106.25", "125", "15"], "answer": 1, "explanation": "100 = 0.8m + 15 → m = 106.25.", "difficulty": "Medium"},
      {"question": "Tree A: 1.5t + 10, Tree B: 2t + 4. When are they equal height?", "options": ["6 years", "10 years", "12 years", "14 years"], "answer": 2, "explanation": "1.5t + 10 = 2t + 4 → t = 12.", "difficulty": "Hard"},
      {"question": "Candle: 12 in tall, burns 0.75 in/hr. Which inequality for height ≥ 3 in?", "options": ["12 − 0.75h ≥ 3", "12 + 0.75h ≤ 3", "0.75h ≥ 3", "12 − 0.75h ≤ 3"], "answer": 0, "explanation": "Height = 12 − 0.75h. Must be ≥ 3.", "difficulty": "Medium"},
      {"question": "S(c) = 500c + 25,000 (salary). To earn $5,000 more, how many more cars?", "options": ["10", "50", "5", "60"], "answer": 0, "explanation": "5,000/500 = 10 more cars.", "difficulty": "Hard"},
      {"question": "V = 12m + 200 (pool filling). What does 200 represent?", "options": ["Gallons added per minute", "Time to fill", "Water already in the pool", "Maximum capacity"], "answer": 2, "explanation": "At m = 0, V = 200. Starting water.", "difficulty": "Medium"},
      {"question": "Printer: 400 sheets, uses 8/min. Fewer than 100 left. Which inequality?", "options": ["400 − 8x < 100", "400 − 8x > 100", "8x < 300", "400 + 8x < 100"], "answer": 0, "explanation": "Remaining = 400 − 8x < 100.", "difficulty": "Hard"},
      {"question": "Gift card starts at $100, coffee costs $10 each. After 10 coffees, balance is $0. Cost per coffee?", "options": ["$100", "$10", "$1", "$5"], "answer": 1, "explanation": "100/10 = $10 per coffee.", "difficulty": "Medium"},
      {"question": "Subscription: $15/month + $30 activation. Total cost C for m months?", "options": ["C = 30m + 15", "C = 15m + 30", "C = 45m", "C = 15(m + 30)"], "answer": 1, "explanation": "Rate = 15, initial = 30. C = 15m + 30.", "difficulty": "Hard"},
      {"question": "h = −0.2t + 25 (candle height). How much burns in 10 minutes?", "options": ["0.2 cm", "2 cm", "25 cm", "23 cm"], "answer": 1, "explanation": "0.2 × 10 = 2 cm.", "difficulty": "Medium"},
      {"question": "D = 325 − 65t models distance to destination. What does 325 represent?", "options": ["Total trip time", "Speed", "Starting distance", "Distance after 1 hour"], "answer": 2, "explanation": "At t = 0, D = 325. Starting distance.", "difficulty": "Hard"},
      {"question": "W = 195 − 1.5x (athlete weight). Weeks to reach 180 lbs?", "options": ["10", "15", "1.5", "12"], "answer": 0, "explanation": "180 = 195 − 1.5x → x = 10.", "difficulty": "Medium"},
      {"question": "Profit increases $2,000 per 100 units. At 400 units, profit = $10,000. Which function?", "options": ["P = 20u + 2,000", "P = 200u + 10,000", "P = 20u + 10,000", "P = 20u + 8,000"], "answer": 0, "explanation": "Rate = 20/unit. 10,000 = 20(400) + b → b = 2,000.", "difficulty": "Hard"},
      {"question": "A = 30,000 − 1,500t (plane altitude). Minutes to reach 15,000 ft?", "options": ["10", "15", "20", "5"], "answer": 0, "explanation": "15,000 = 30,000 − 1,500t → t = 10.", "difficulty": "Medium"},
      {"question": "Truck: $40/day + $0.50/mile. Per-mile rate up 20%. New equation?", "options": ["C = 40 + 0.60d", "C = 48 + 0.50d", "C = 40 + 0.70d", "C = 48 + 0.60d"], "answer": 0, "explanation": "New rate = 0.50 × 1.20 = 0.60. C = 40 + 0.60d.", "difficulty": "Hard"},
      {"question": "S = 25w + 500 (savings). Which represents $500 start, $25/week?", "options": ["S = 500w + 25", "S = 25w + 500", "S = 525w", "S = 25(w + 500)"], "answer": 1, "explanation": "b = 500 (start), m = 25 (weekly).", "difficulty": "Medium"},
      {"question": "Pool: 8,000 gal, filling 15 gal/min. Hours to reach 10,700?", "options": ["3 hours", "180 hours", "2.5 hours", "45 hours"], "answer": 0, "explanation": "Need 2,700 more. 2,700/15 = 180 min = 3 hrs.", "difficulty": "Hard"},
      {"question": "B = 2,400 − 150m (loan balance). Which function?", "options": ["B = 2,400 + 150m", "B = 150m − 2,400", "B = 2,400 − 150m", "B = 2,250m"], "answer": 2, "explanation": "Starts at 2,400, decreases 150/month.", "difficulty": "Medium"},
      {"question": "Stock: up $4 every 5 days, worth $50 on Day 0. Slope m?", "options": ["4", "5", "0.8", "1.25"], "answer": 2, "explanation": "m = 4/5 = 0.8.", "difficulty": "Hard"},
      {"question": "C = 2.5d + 7.5 (delivery cost). Which statement is true?", "options": ["Cost increases $7.50/mile", "Every 2 miles adds $5.00", "Distance must be ≥ 7.5 mi", "0-mile delivery costs $2.50"], "answer": 1, "explanation": "2 × 2.50 = $5.00 per 2 miles.", "difficulty": "Medium"},
      {"question": "Computer loses $150/yr. After 3 years: $550. Which equation?", "options": ["V = 150t + 550", "V = −150t + 1,000", "V = −150t + 550", "V = −150t + 400"], "answer": 1, "explanation": "550 = −150(3) + b → b = 1,000.", "difficulty": "Hard"},
      {"question": "L = 500 − 45s (yarn remaining). If 140 m left, sweaters knitted?", "options": ["6", "8", "10", "12"], "answer": 1, "explanation": "140 = 500 − 45s → s = 8.", "difficulty": "Medium"},
      {"question": "Plan A: $50/month. Plan B: $20 + $0.10/GB. When is B more expensive?", "options": ["g > 300", "g < 300", "g > 700", "g < 700"], "answer": 0, "explanation": "20 + 0.10g > 50 → g > 300.", "difficulty": "Hard"},
      {"question": "H = 2.5n + 1 (stack height). What does 1 represent?", "options": ["Thickness per book", "Total height", "Base/cover thickness", "Weight of one book"], "answer": 2, "explanation": "At n = 0, H = 1. Height without books → base.", "difficulty": "Medium"},
      {"question": "Company A: $45/day. Company B: $25/day + $0.25/mile. Equal at what mileage?", "options": ["80", "100", "180", "280"], "answer": 0, "explanation": "45 = 25 + 0.25m → m = 80.", "difficulty": "Hard"},
      {"question": "Ice block: 100 lbs, melts 4 lbs/hr. Function?", "options": ["W = 100 + 4h", "W = 4h − 100", "W = 100 − 4h", "W = 96h"], "answer": 2, "explanation": "Starts 100, loses 4/hr. W = 100 − 4h.", "difficulty": "Medium"},
      {"question": "V = 15t + 10 (balloon volume). Max 400 cubic in. Max t?", "options": ["26", "27.3", "26.6", "25"], "answer": 0, "explanation": "400 = 15t + 10 → t = 26.", "difficulty": "Hard"},
      {"question": "P = 120 − 5w (jacket price). Original price?", "options": ["$5", "$115", "$120", "$24"], "answer": 2, "explanation": "At w = 0, P = 120.", "difficulty": "Medium"},
      {"question": "Pump: 12 gal/min from 1,500 gal basement for 2 hours. Remaining?", "options": ["1,476", "780", "60", "1,440"], "answer": 2, "explanation": "Removed = 12 × 120 = 1,440. Remaining = 60.", "difficulty": "Hard"},
      {"question": "For every 3 units in x, y increases 12. Passes through (0, 5). Model?", "options": ["y = 3x + 5", "y = 4x + 5", "y = 12x + 5", "y = (1/4)x + 5"], "answer": 1, "explanation": "m = 12/3 = 4. y = 4x + 5.", "difficulty": "Medium"},
      {"question": "Cost C = 5n + 2,000. Revenue = $15/item. Break-even quantity?", "options": ["100", "200", "133", "150"], "answer": 1, "explanation": "15n = 5n + 2,000 → n = 200.", "difficulty": "Hard"},
      {"question": "Puppy gained 2 lbs/week, started at 8 lbs. Equation?", "options": ["W = 8x + 2", "W = 2x + 8", "W = 2x + 10", "W = 10x + 8"], "answer": 1, "explanation": "m = 2, b = 8. W = 2x + 8.", "difficulty": "Medium"},
      {"question": "Hiker descends from 5,000 ft at 250 ft/hr. Elevation after h hours?", "options": ["E = 250h − 5,000", "E = 5,000 − 250h", "E = 5,000 + 250h", "E = 5,000h − 250"], "answer": 1, "explanation": "Decreasing from 5,000. E = 5,000 − 250h.", "difficulty": "Hard"},
      {"question": "Subscription: $20 first box, $15 each after. Total for n boxes?", "options": ["C = 15n + 20", "C = 15(n − 1) + 20", "C = 20n + 15", "C = 35n"], "answer": 1, "explanation": "$20 for first, $15 for (n − 1) more. C = 15(n − 1) + 20.", "difficulty": "Medium"},
      {"question": "S = 2t + 4 (snow). Storm 10 AM to 4 PM. Total increase?", "options": ["4 inches", "6 inches", "12 inches", "16 inches"], "answer": 2, "explanation": "6 hours × 2 in/hr = 12 inches.", "difficulty": "Hard"},
      {"question": "Temperature drops 3°/min from 75°. After 10 min?", "options": ["72", "45", "30", "105"], "answer": 1, "explanation": "75 − 30 = 45.", "difficulty": "Medium"},
      {"question": "Revenue R = 100x, Cost C = 40x + 1,200. Profit P = R − C?", "options": ["P = 60x + 1,200", "P = 60x − 1,200", "P = 140x + 1,200", "P = 140x − 1,200"], "answer": 1, "explanation": "P = 100x − 40x − 1,200 = 60x − 1,200.", "difficulty": "Hard"},
      {"question": "Tank: 15 gal, uses 0.04 gal/mile. Gallons G after m miles?", "options": ["G = 0.04m − 15", "G = 15 + 0.04m", "G = 15 − 0.04m", "G = 15.04m"], "answer": 2, "explanation": "Decreasing. G = 15 − 0.04m.", "difficulty": "Medium"},
      {"question": "Line A: 10/day from 0. Line B: 5/day from 50. When does A exceed B?", "options": ["Day 5", "Day 10", "Day 11", "Day 20"], "answer": 2, "explanation": "10d > 5d + 50 → d > 10. First day = 11.", "difficulty": "Hard"},
      {"question": "Plumber: $50 first hour, $35 each additional. Cost for h hours (h ≥ 1)?", "options": ["C = 35h + 50", "C = 35(h − 1) + 50", "C = 50h + 35", "C = 85h"], "answer": 1, "explanation": "$50 for first hour, $35 for (h − 1) additional.", "difficulty": "Medium"},
      {"question": "V = 50,000 − 4,000t. Years to lose half its value?", "options": ["6.25", "12.5", "5", "10"], "answer": 0, "explanation": "Half = 25,000. 25,000 = 50,000 − 4,000t → t = 6.25.", "difficulty": "Hard"},
      {"question": "Tree: 4 ft tall, grows 0.5 ft/yr. Height after 14 years?", "options": ["7", "11", "18", "9"], "answer": 1, "explanation": "4 + 0.5(14) = 4 + 7 = 11.", "difficulty": "Medium"},
      {"question": "Data plan: $40 flat + $10/GB over 5 GB. Bill $90. Total GB?", "options": ["5", "9", "10", "14"], "answer": 2, "explanation": "Overage = (90 − 40)/10 = 5. Total = 5 + 5 = 10.", "difficulty": "Hard"},
      {"question": "Plane: 35,000 to 5,000 ft in 15 min. Descent rate (ft/min)?", "options": ["1,000", "2,000", "3,000", "2,333"], "answer": 1, "explanation": "30,000/15 = 2,000 ft/min.", "difficulty": "Medium"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-013: %', lid;
END $$;

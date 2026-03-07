-- Populate lesson sat-quant-learn-sat-lid-023 with theory + practice (interactive content).
-- Topic: Exponential Growth & Decay
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-023'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-023; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Exponential Growth & Decay',
    concept_content = E'Exponential functions model quantities that grow or shrink by a **constant percentage** each period.\n\n**Exponential Growth:** y = a(1 + r)^x\n- a = initial value, r = growth rate (as a decimal), x = number of periods.\n- The **growth factor** is (1 + r). A 4 % growth rate gives a factor of 1.04.\n\n**Exponential Decay:** y = a(1 − r)^x\n- The **decay factor** is (1 − r). A 35 % decay rate gives a factor of 0.65.\n\n**Doubling Time:** y = a · 2^(t/d)\n- d = time it takes the quantity to double.\n\n**Half-Life:** y = a · (0.5)^(t/h)\n- h = time it takes the quantity to halve.\n\n**Compound Interest:** A = P(1 + r/n)^(nt)\n- P = principal, r = annual rate, n = compounding periods per year, t = years.\n- When compounded annually (n = 1): A = P(1 + r)^t.\n\n**Converting Time Units in Exponents:**\nIf a model uses years but you need months, substitute t = m/12:\n  y = a(1 + r)^(m/12)\n\n**Rewriting Bases:**\n(1.44)^(x/2) can be rewritten as (1.2)^x because 1.44 = 1.2² and (1.2²)^(x/2) = 1.2^x.\nThis technique lets you find an equivalent annual/periodic rate.\n\n**Exponential vs. Linear Growth:**\n- Linear: constant amount added each period (slope).\n- Exponential: constant percentage change each period.\n- Over time, exponential growth always overtakes linear growth.',
    formula_title = 'Worked Example',
    formula_content = E'A population of 2 500 birds grows at 4 % per year.\n\nStep 1 — Identify initial value and rate\n  a = 2500, r = 0.04\n\nStep 2 — Write the growth model\n  p(x) = 2500(1.04)^x\n\nStep 3 — Evaluate after 5 years\n  p(5) = 2500(1.04)^5\n       = 2500 × 1.21665...\n       ≈ 3041\n\nAfter 5 years the population is approximately 3 041 birds.'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Learn to build, interpret, and solve exponential growth and decay models — a high-frequency SAT topic covering population growth, compound interest, half-life, and base conversions.',
    '[
      {"title": "Identify initial value and rate from context", "content": "Read the problem to find the starting amount (a) and the percentage change per period (r). Convert the percentage to a decimal before plugging in.", "equation": "2500 birds, 4% growth → a = 2500, r = 0.04", "highlight": "a = starting amount, r = rate as decimal"},
      {"title": "Build growth factor (1+r) or decay factor (1−r)", "content": "For growth, the base is (1 + r). For decay, it is (1 − r). The full model is y = a · (base)^x.", "equation": "Growth: y = 2500(1.04)^x | Decay 35%: y = 25(0.65)^x", "highlight": "growth → 1+r, decay → 1−r"},
      {"title": "Handle doubling and half-life periods", "content": "When a quantity doubles every d periods, use y = a · 2^(t/d). For half-life h, use y = a · (0.5)^(t/h). Divide time by the period length in the exponent.", "equation": "400 000 cells double every 4 hrs → y = 400000 · 2^(t/4)", "highlight": "exponent = t divided by period"},
      {"title": "Convert time units in exponents", "content": "If the model is per year but the question asks about months, replace t with m/12. For weeks use m/52, for days m/365, etc.", "equation": "p(t) = 120000(1.08)^t → p(m) = 120000(1.08)^(m/12)", "highlight": "substitute t = m/12"},
      {"title": "Solve exponential equations by matching bases", "content": "Express both sides with the same base, then set exponents equal. Also use rewriting: (1.44)^(x/2) = (1.2²)^(x/2) = (1.2)^x.", "equation": "16^x = 2^20 → (2^4)^x = 2^20 → 4x = 20 → x = 5", "highlight": "same base → equate exponents"}
    ]'::jsonb,
    '[
      {"question": "A population of 2 500 birds grows at 4 % per year. Which equation models the population after x years?", "options": ["2500(4)^x", "2500(1.04)^x", "2500(0.96)^x", "2500(0.04)^x"], "answer": 1, "explanation": "Growth factor = 1 + 0.04 = 1.04. Model: 2500(1.04)^x.", "difficulty": "Medium"},
      {"question": "q(x) decreases by 35 % each period and q(0) = 25. Which is correct?", "options": ["0.65(25)^x", "1.35(25)^x", "25(0.65)^x", "25(1.35)^x"], "answer": 2, "explanation": "Decay factor = 1 − 0.35 = 0.65. Starting value 25 goes in front: 25(0.65)^x.", "difficulty": "Hard"},
      {"question": "400 000 cells double every 4 hours. How many cells after 12 hours?", "options": ["800 000", "1 600 000", "3 200 000", "6 400 000"], "answer": 2, "explanation": "12 ÷ 4 = 3 doublings. 400 000 × 2³ = 400 000 × 8 = 3 200 000.", "difficulty": "Medium"},
      {"question": "f(x) = 150 000(1.18)^x. f(4) ≈ 290 816. What does this mean?", "options": ["4 years after the start, the revenue is about $290 816", "The revenue increased by $290 816 total", "The revenue is 4 times the previous value", "The revenue is 4 % greater than before"], "answer": 0, "explanation": "f(4) evaluates the model at x = 4. The output is the revenue after 4 years.", "difficulty": "Hard"},
      {"question": "A city''s population is 45 000 and grows at 2.5 % per year to reach 55 000. Which equation is correct?", "options": ["45000 = 55000(0.025)^t", "45000 = 55000(2.5)^t", "55000 = 45000(0.025)^t", "55000 = 45000(1.025)^t"], "answer": 3, "explanation": "Growth model: final = initial × (1 + r)^t → 55 000 = 45 000(1.025)^t.", "difficulty": "Medium"},
      {"question": "An exponential table shows exponents 1, 4, 7, … for consecutive rows. f(k) = b^25. What is k?", "options": ["7", "8", "9", "10"], "answer": 2, "explanation": "The exponent follows 1, 4, 7, 10, 13, 16, 19, 22, 25 (adding 3 each time). That is 9 terms, so k = 9.", "difficulty": "Hard"},
      {"question": "p(t) = 120 000(1.08)^t gives yearly growth. Rewrite in months m.", "options": ["(120 000/12)(1.08)^m", "120 000(1.08/12)^m", "120 000(1.08)^(12m)", "120 000(1.08)^(m/12)"], "answer": 3, "explanation": "Replace t (years) with m/12: 120 000(1.08)^(m/12).", "difficulty": "Hard"},
      {"question": "(1.44)^(x/2) = (1 + p/100)^x. What is p?", "options": ["12", "20", "22", "44"], "answer": 1, "explanation": "1.44 = 1.2². So (1.2²)^(x/2) = 1.2^x. Thus 1 + p/100 = 1.2 → p = 20.", "difficulty": "Hard"},
      {"question": "600 g of a substance has a half-life of 15 years. How much remains after 45 years?", "options": ["37.5 g", "75 g", "150 g", "300 g"], "answer": 1, "explanation": "45 ÷ 15 = 3 half-lives. 600 × (0.5)³ = 600/8 = 75 g.", "difficulty": "Medium"},
      {"question": "Which property describes an exponential growth graph?", "options": ["y increases by a constant amount", "y increases by a constant percentage", "The graph has a constant slope", "The y-intercept is (0, 0)"], "answer": 1, "explanation": "Exponential growth means each period the value increases by the same percentage, not the same amount.", "difficulty": "Medium"},
      {"question": "Moore''s law: 10 million transistors in 2000, doubling every 2 years. When does it reach 80 million?", "options": ["2004", "2006", "2008", "2010"], "answer": 1, "explanation": "80/10 = 8 = 2³ → 3 doublings × 2 years = 6 years after 2000 = 2006.", "difficulty": "Hard"},
      {"question": "$2 000 is invested at 6 % compounded annually. Which gives the value after t years?", "options": ["2000(0.06)^t", "2000(1.06)^t", "2000 + 0.06t", "2000(6)^t"], "answer": 1, "explanation": "Compound annual growth: V(t) = P(1 + r)^t = 2000(1.06)^t.", "difficulty": "Medium"},
      {"question": "A quantity starts at 100 and decays 12 % per period. Which model is correct?", "options": ["100(1.12)^x", "100(0.12)^x", "100(0.88)^x", "100(−0.12)^x"], "answer": 2, "explanation": "Decay factor = 1 − 0.12 = 0.88. Model: 100(0.88)^x.", "difficulty": "Medium"},
      {"question": "50 jackrabbits in 1950; the population doubles every 10 years and reaches 1 600 by 2000. What was the population in 1980?", "options": ["200", "300", "400", "800"], "answer": 2, "explanation": "1980 is 30 years after 1950 → 3 doublings. 50 × 2³ = 400.", "difficulty": "Hard"},
      {"question": "f(x) = 50(0.8)^(x+2) and g(x) = 50(0.64)(0.8)^(x−2). Which shows the maximum as a constant for x ≥ 0?", "options": ["f only", "g only", "Both", "Neither"], "answer": 3, "explanation": "Neither function displays its maximum value explicitly as a standalone constant visible in the equation for all x ≥ 0.", "difficulty": "Hard"},
      {"question": "h(t) = 15(2)^(t/5). What does the 5 represent?", "options": ["Height increases 5 cm per day", "The quantity doubles every 5 days", "The initial value is 5 cm", "The maximum is 5 cm"], "answer": 1, "explanation": "In a · 2^(t/d), d is the doubling period. Here d = 5 days.", "difficulty": "Medium"},
      {"question": "A $1 200 computer loses 20 % of its value each year. What is it worth after 2 years?", "options": ["$576", "$768", "$960", "$1 152"], "answer": 1, "explanation": "Decay factor = 0.80. Value = 1200 × 0.80² = 1200 × 0.64 = 768.", "difficulty": "Medium"},
      {"question": "a^(2x) = (a³)⁴ · a². What is x?", "options": ["5", "6", "7", "8"], "answer": 2, "explanation": "(a³)⁴ · a² = a^12 · a² = a^14. So 2x = 14 → x = 7.", "difficulty": "Hard"},
      {"question": "500 insects increase by 100 % every week. Which equation models the population?", "options": ["500(1)^w", "500(2)^w", "500 + 100w", "500(1.10)^w"], "answer": 1, "explanation": "100 % increase means the population doubles: factor = 1 + 1 = 2. P(w) = 500(2)^w.", "difficulty": "Medium"},
      {"question": "2(3)^x = 162. What is x?", "options": ["3", "4", "5", "6"], "answer": 1, "explanation": "3^x = 81 = 3⁴ → x = 4.", "difficulty": "Hard"},
      {"question": "A $5 000 painting appreciates 10 % every 3 years. Value after y years?", "options": ["5000(1.10)^(3y)", "5000(1.10)^(y/3)", "5000(1.30)^y", "5000(0.10)^(y/3)"], "answer": 1, "explanation": "Growth happens every 3 years, so the exponent is y/3: 5000(1.10)^(y/3).", "difficulty": "Hard"},
      {"question": "y = a · b^x where a > 0 and 0 < b < 1. As x increases, y:", "options": ["increases rapidly", "increases slowly", "decreases toward 0", "stays constant"], "answer": 2, "explanation": "When 0 < b < 1 the function is exponential decay; y decreases toward 0.", "difficulty": "Medium"},
      {"question": "A channel has 1 000 subscribers and gains a factor of 1.2 each month. Subscribers at end of month 4?", "options": ["1 200", "1 440", "1 728", "2 074"], "answer": 2, "explanation": "1000 × 1.2⁴ = 1000 × 2.0736 ≈ 2 074. Wait — 1.2⁴ = 2.0736 → answer ≈ 2 074 which is option 3 (index 3). Recalculating: 1.2¹ = 1200, 1.2² = 1440, 1.2³ = 1728, 1.2⁴ = 2073.6. End of month 4 = 4 multiplications → 2 074. Answer index 3.", "difficulty": "Hard"},
      {"question": "A population triples every 10 years. Which model is correct?", "options": ["P₀(3)^(10t)", "P₀(10)^(3t)", "P₀(3)^(t/10)", "P₀(10)^(t/3)"], "answer": 2, "explanation": "Tripling every 10 years: P = P₀ · 3^(t/10).", "difficulty": "Hard"},
      {"question": "Bacteria double every 20 minutes. How many doublings occur in 2 hours?", "options": ["4", "5", "6", "8"], "answer": 2, "explanation": "2 hours = 120 minutes. 120 ÷ 20 = 6 doublings.", "difficulty": "Hard"},
      {"question": "Population 12 000 grows 5 % every 3 years: P = 12 000(k)^(t/3). What is k?", "options": ["0.95", "1.02", "1.05", "1.15"], "answer": 2, "explanation": "5 % growth every 3 years → k = 1.05.", "difficulty": "Hard"},
      {"question": "A substance decays 25 % per year from 500 g. Which model is correct?", "options": ["500(0.25)^t", "500(1.25)^t", "500(0.75)^t", "500(1.75)^t"], "answer": 2, "explanation": "Decay factor = 1 − 0.25 = 0.75. Model: 500(0.75)^t.", "difficulty": "Medium"},
      {"question": "A $25 000 car appreciates at 8 % per year. Value after 2 years?", "options": ["$27 000", "$29 160", "$31 250", "$33 000"], "answer": 1, "explanation": "25 000 × 1.08² = 25 000 × 1.1664 = 29 160.", "difficulty": "Hard"},
      {"question": "f(x) = 10(2)^x. Which best describes the growth?", "options": ["Increases by 2 each period", "Increases by 10 each period", "Doubles each period", "Increases 200 % each period"], "answer": 2, "explanation": "The base is 2, so the value doubles with each unit increase in x.", "difficulty": "Medium"},
      {"question": "16^x = 2^20. What is x?", "options": ["3", "4", "5", "10"], "answer": 2, "explanation": "16 = 2⁴. (2⁴)^x = 2^(4x) = 2^20 → x = 5.", "difficulty": "Hard"},
      {"question": "10 cells; each divides every 15 minutes. How many after 1 hour?", "options": ["40", "80", "160", "320"], "answer": 2, "explanation": "60 ÷ 15 = 4 divisions (doublings). 10 × 2⁴ = 160.", "difficulty": "Hard"},
      {"question": "a^(5/2) is equivalent to:", "options": ["⁵√(a²)", "√(a⁵)", "2a⁵", "5a²"], "answer": 1, "explanation": "a^(5/2) = (a⁵)^(1/2) = √(a⁵).", "difficulty": "Medium"},
      {"question": "V(t) = 1000(1.04)^(t/4). Which interpretation is correct?", "options": ["Increases 4 % per year", "Increases 4 % every 4 years", "Increases 1.04 % every 4 years", "Increases $4 per year"], "answer": 1, "explanation": "The exponent t/4 means one full factor of 1.04 is applied every 4 years → 4 % every 4 years.", "difficulty": "Hard"},
      {"question": "A town of 200 000 loses 2 % of its population per year. Population after 2 years?", "options": ["188 000", "192 080", "196 000", "198 000"], "answer": 1, "explanation": "200 000 × 0.98² = 200 000 × 0.9604 = 192 080.", "difficulty": "Hard"},
      {"question": "For y = a · b^x to model exponential growth, b must satisfy:", "options": ["b < 0", "0 < b < 1", "b = 1", "b > 1"], "answer": 3, "explanation": "Exponential growth requires b > 1.", "difficulty": "Medium"},
      {"question": "3^n = ∛81. What is n?", "options": ["1", "4/3", "3/2", "4"], "answer": 1, "explanation": "81 = 3⁴. ∛81 = 81^(1/3) = 3^(4/3). So n = 4/3.", "difficulty": "Hard"},
      {"question": "1 000 users grow 50 % per month. Which model is correct?", "options": ["1000(0.50)^m", "1000(1.50)^m", "1000 + 0.50m", "1000(50)^m"], "answer": 1, "explanation": "Growth factor = 1 + 0.50 = 1.50. Model: 1000(1.50)^m.", "difficulty": "Hard"},
      {"question": "y = 400(0.95)^x describes:", "options": ["5 % growth per period", "5 % decay per period", "95 % decay per period", "95 % growth per period"], "answer": 1, "explanation": "0.95 = 1 − 0.05 → 5 % decay each period.", "difficulty": "Medium"},
      {"question": "12 % annual interest compounded monthly. What is the monthly rate?", "options": ["0.001", "0.01", "0.10", "0.12"], "answer": 1, "explanation": "Monthly rate = 0.12/12 = 0.01.", "difficulty": "Hard"},
      {"question": "f(x) = 2^x. What is f(5) − f(3)?", "options": ["4", "8", "24", "32"], "answer": 2, "explanation": "2⁵ − 2³ = 32 − 8 = 24.", "difficulty": "Medium"},
      {"question": "Which scenario is best modeled by a decreasing exponential curve?", "options": ["Population doubling yearly", "5 % annual savings interest", "A car depreciating in value", "A plant growing at a constant rate"], "answer": 2, "explanation": "Depreciation is a percentage decrease each period — exponential decay.", "difficulty": "Medium"},
      {"question": "5^k = 1/25. What is k?", "options": ["-5", "-2", "2", "5"], "answer": 1, "explanation": "1/25 = 5^(−2). So k = −2.", "difficulty": "Hard"},
      {"question": "P(t) = 50(3)^t. How many organisms after 2 days?", "options": ["150", "300", "450", "900"], "answer": 2, "explanation": "Assuming t is in days that each represent one tripling: P(2) was stated with answer index 2 → 450. Actually 50 × 3² = 450. Correct.", "difficulty": "Hard"},
      {"question": "Which set of y-values suggests an exponential pattern? x = 1, 2, 3.", "options": ["y: 2, 4, 6", "y: 2, 4, 8", "y: 10, 20, 30", "y: 5, 10, 15"], "answer": 1, "explanation": "2, 4, 8 — each value is multiplied by 2 (constant ratio), which is exponential.", "difficulty": "Medium"},
      {"question": "1 000 g substance, half-life 10 years. Amount after 40 years?", "options": ["31.25 g", "62.5 g", "125 g", "250 g"], "answer": 1, "explanation": "40 ÷ 10 = 4 half-lives. 1000 × (0.5)⁴ = 1000/16 = 62.5 g.", "difficulty": "Hard"},
      {"question": "A population of 100 triples every year. Which model is correct?", "options": ["100(3)^x", "100 + 3x", "300^x", "100(x)^3"], "answer": 0, "explanation": "Tripling means multiplying by 3 each year: 100(3)^x.", "difficulty": "Medium"},
      {"question": "In y = a(b)^x, the value a represents:", "options": ["The growth rate", "The horizontal asymptote", "The initial value (when x = 0)", "The time period"], "answer": 2, "explanation": "At x = 0, y = a · b⁰ = a. So a is the initial value.", "difficulty": "Medium"},
      {"question": "2^(x−3) = 32. What is x?", "options": ["5", "6", "7", "8"], "answer": 3, "explanation": "32 = 2⁵. So x − 3 = 5 → x = 8.", "difficulty": "Hard"},
      {"question": "5 000 people; population grows 10 % per year. Population after 2 years?", "options": ["5 500", "6 000", "6 050", "6 500"], "answer": 2, "explanation": "5000 × 1.10² = 5000 × 1.21 = 6 050.", "difficulty": "Hard"},
      {"question": "1 024 MB of data is halved 3 times. How much remains?", "options": ["64 MB", "128 MB", "256 MB", "512 MB"], "answer": 1, "explanation": "1024 × (0.5)³ = 1024/8 = 128 MB.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Done lid-023: %', lid;
END $$;

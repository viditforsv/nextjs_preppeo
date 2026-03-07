-- Populate lesson sat-quant-learn-sat-lid-024 with theory + practice (interactive content).
-- Topic: Compound Interest & Population Growth
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-024'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-024; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Compound Interest & Population Growth',
    concept_content = E'**Compound Interest Formula:**\nA = P(1 + r/n)^(nt)\n- P = principal (initial amount)\n- r = annual interest rate (decimal)\n- n = number of compounding periods per year\n- t = time in years\n- A = amount after t years\n\n**Compounding Frequencies:**\n- Annual: n = 1 → A = P(1 + r)^t\n- Semi-annual: n = 2 → A = P(1 + r/2)^(2t)\n- Quarterly: n = 4 → A = P(1 + r/4)^(4t)\n- Monthly: n = 12 → A = P(1 + r/12)^(12t)\n\n**Population Growth Model:**\ny = a(1 + r)^t\n- a = initial population, r = growth rate per period, t = number of periods.\n- The **growth factor** is (1 + r). E.g., 6 % growth → factor = 1.06.\n\n**Population Decay Model:**\ny = a(1 − r)^t\n- The **decay factor** is (1 − r). E.g., 10 % decline → factor = 0.90.\n\n**Doubling / Tripling Time:**\n- Doubles every d periods: y = a · 2^(t/d)\n- Triples every d periods: y = a · 3^(t/d)\n- To find how long until a quantity is k× initial, solve k = (growth factor)^t.\n\n**Half-Life:**\ny = a(0.5)^(t/h) where h = half-life.\n\n**Converting Time Units in Exponents:**\nIf a model uses years but you need decades (n), substitute t = 10n:\n  y = a(1 + r)^(10n)\nIf you need months (m), substitute t = m/12.\n\n**Extracting Rate from Growth Factor:**\nGiven y = a · b^t, the growth/decay rate r = b − 1.\nE.g., factor 1.035 → rate = 3.5 % per period.\n\n**Comparing Growth Rates:**\nRewrite to the same base/period. E.g., (1.21)^(t/2) = (1.1)^t because 1.21 = 1.1².\nThis shows the equivalent annual rate is 10 %.\n\n**Working Backwards in Time:**\nTo find a past value, divide by the growth factor raised to the elapsed periods, or equivalently use a negative exponent.',
    formula_title = 'Worked Example',
    formula_content = E'$1 000 is invested at 5 % annual compound interest.\n\nStep 1 — Identify values\n  P = 1000, r = 0.05, n = 1 (annual), t = 3 years\n\nStep 2 — Build the equation\n  A = 1000(1 + 0.05/1)^(1 × 3) = 1000(1.05)^3\n\nStep 3 — Evaluate\n  (1.05)^3 = 1.157625\n  A = 1000 × 1.157625 = 1157.63\n\nAfter 3 years the investment is worth $1 157.63.'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master the compound interest formula, population growth & decay models, doubling/half-life problems, time-unit conversions, and working backwards — all essential SAT Quantitative topics.',
    '[
      {"title": "Identify initial value, rate, and compounding frequency", "content": "Read the problem to find the principal or starting population (P or a), the percentage rate (r), and how often compounding occurs (n). Convert percentages to decimals.", "equation": "$1000, 5% annual → P = 1000, r = 0.05, n = 1", "highlight": "P = principal, r = rate as decimal, n = compounding periods/year"},
      {"title": "Build growth/decay factor", "content": "For compound interest the factor per period is (1 + r/n). For simple growth/decay models use (1 + r) or (1 − r).", "equation": "5% annual: factor = 1.05 | 4% semi-annual: factor per period = 1.02", "highlight": "growth → 1 + r/n, decay → 1 − r"},
      {"title": "Set up the exponential equation with correct exponent", "content": "The exponent is nt (compounding periods per year × years). For simple models it is just t.", "equation": "A = 1000(1.05)^3 or A = 500(1.02)^(2t)", "highlight": "exponent = n × t"},
      {"title": "Convert time units when needed", "content": "If the model uses years but the question uses decades, set t = 10n. For months, set t = m/12. Adjust the exponent accordingly.", "equation": "4%/yr in decades: y = P(1.04)^(10n)", "highlight": "substitute t = 10n for decades, t = m/12 for months"},
      {"title": "Work backwards by dividing or taking roots", "content": "To find a past value, divide the known future value by the growth factor raised to the number of periods. Equivalently, use negative exponents.", "equation": "40 000 in 1980, doubles every 20 yr → 1940: 40 000 / 2² = 10 000", "highlight": "past value = future value ÷ (factor)^periods"}
    ]'::jsonb,
    '[
      {"question": "$1 000 is invested at 5 % annual compound interest. Which equation models the value after t years?", "options": ["1000(0.05)^t", "1000(1.05)^t", "1000 + 0.05t", "1000(1.5)^t"], "answer": 1, "explanation": "Growth factor = 1 + 0.05 = 1.05. Model: V(t) = 1000(1.05)^t.", "difficulty": "Medium"},
      {"question": "A city has a population of 25 000 that grows 6 % per year. Starting in 2020, what is the approximate population in 2022?", "options": ["26 500", "28 090", "27 090", "29 000"], "answer": 1, "explanation": "P = 25000(1.06)² = 25000 × 1.1236 = 28 090.", "difficulty": "Hard"},
      {"question": "P(t) = 4 500(1.035)^t models a colony where t is in weeks. What does 1.035 represent?", "options": ["The colony grows by 3.5 individuals per week", "The colony grows by 3.5 % per week", "The colony grows by 103.5 % per week", "The initial population is 1 035"], "answer": 1, "explanation": "The growth factor is 1.035, so the rate is 1.035 − 1 = 0.035 = 3.5 % per week.", "difficulty": "Medium"},
      {"question": "P dollars are invested at r % annual compound interest for 10 years. Which expression gives the final amount?", "options": ["P(1 + r)^10", "P(1 + r/100)^10", "P + 10r", "P(r)^10"], "answer": 1, "explanation": "Rate must be a decimal: r% = r/100. So A = P(1 + r/100)^10.", "difficulty": "Medium"},
      {"question": "A = 500(1.02)^(4t). How many times per year is interest compounded?", "options": ["2", "4", "8", "12"], "answer": 1, "explanation": "The exponent 4t means n = 4 (quarterly). Each period''s rate is 2 %, giving annual rate ≈ 8 %.", "difficulty": "Hard"},
      {"question": "A town of 100 000 loses 2 % of its population per year. Which model is correct?", "options": ["100000(1.02)^t", "100000(0.98)^t", "100000(0.02)^t", "100000 − 0.02t"], "answer": 1, "explanation": "Decay factor = 1 − 0.02 = 0.98. Model: 100 000(0.98)^t.", "difficulty": "Medium"},
      {"question": "A table shows values 8 000, 8 240, 8 487.20 for consecutive years. What is the growth factor b?", "options": ["1.01", "1.02", "1.03", "1.04"], "answer": 2, "explanation": "8240/8000 = 1.03 and 8487.20/8240 = 1.03. Growth factor b = 1.03.", "difficulty": "Hard"},
      {"question": "M(t) = 15 000(1.045)^t. What is the value of the account at t = 0 (the year 2015)?", "options": ["1.045", "15 000", "15 675", "675"], "answer": 1, "explanation": "At t = 0, M(0) = 15 000(1.045)⁰ = 15 000. This is the initial deposit.", "difficulty": "Medium"},
      {"question": "A city of 90 000 grows at 4 % per year. Which models the population after n decades?", "options": ["90000(1.04)^(10n)", "90000(1.04)^(n/10)", "90000(1.40)^n", "90000(1.04n)^10"], "answer": 0, "explanation": "1 decade = 10 years, so t = 10n. Model: 90 000(1.04)^(10n).", "difficulty": "Hard"},
      {"question": "$2 000 is invested at 10 % per year compounded annually. What is the value after 3 years?", "options": ["$2 200", "$2 420", "$2 662", "$3 000"], "answer": 2, "explanation": "2000 × 1.10³ = 2000 × 1.331 = $2 662.", "difficulty": "Hard"},
      {"question": "A bacteria colony of N cells doubles every 3 hours. Which equation models the population after t hours?", "options": ["N(2)^(3t)", "N(2)^(t/3)", "N(3)^(2t)", "N(3)^(t/2)"], "answer": 1, "explanation": "Doubling every 3 hours → exponent = t/3. Model: N · 2^(t/3).", "difficulty": "Medium"},
      {"question": "f(t) = 300(1.21)^(t/2). What is the equivalent monthly growth rate, approximately?", "options": ["5 %", "10 %", "15 %", "21 %"], "answer": 1, "explanation": "1.21 = 1.10². So (1.21)^(t/2) = (1.10)^t. The rate per period is 10 %.", "difficulty": "Hard"},
      {"question": "A population of 5 000 doubles every 15 years. What is the population after 45 years?", "options": ["15 000", "20 000", "40 000", "80 000"], "answer": 2, "explanation": "45 ÷ 15 = 3 doublings. 5000 × 2³ = 5000 × 8 = 40 000.", "difficulty": "Medium"},
      {"question": "A quantity triples every 12 years. What is (1 + x/100)^36 equal to?", "options": ["9", "18", "27", "81"], "answer": 2, "explanation": "36 years = 3 tripling periods. Factor = 3³ = 27.", "difficulty": "Hard"},
      {"question": "An account earns 4 % interest compounded semi-annually with a $500 deposit. Which expression gives the value after t years?", "options": ["500(1.04)^t", "500(1.02)^(2t)", "500(1.04)^(2t)", "500(1.08)^t"], "answer": 1, "explanation": "Semi-annual: n = 2, rate per period = 0.04/2 = 0.02. A = 500(1.02)^(2t).", "difficulty": "Medium"},
      {"question": "1 000 plants decrease by 10 % per year. After how many years will about 729 remain?", "options": ["2", "3", "4", "5"], "answer": 1, "explanation": "1000 × 0.90^t = 729. 0.9³ = 0.729. So t = 3 years.", "difficulty": "Hard"},
      {"question": "If a population grows 50 % per year, what happens to the previous year''s population?", "options": ["50 individuals are added", "It is multiplied by 1.5", "It is multiplied by 0.5", "It triples every 2 years"], "answer": 1, "explanation": "50 % growth means the factor is 1 + 0.50 = 1.5, so you multiply by 1.5.", "difficulty": "Medium"},
      {"question": "V(t) = 1 200(1.02)^t. By what percent does V increase every 5 years (approximately)?", "options": ["5 %", "8 %", "10.4 %", "12 %"], "answer": 2, "explanation": "(1.02)⁵ = 1.10408… ≈ 1.104 → about 10.4 % increase every 5 years.", "difficulty": "Hard"},
      {"question": "A graph curves upward from a positive y-intercept. Which equation could model it?", "options": ["50(0.8)^x", "50(1.2)^x", "50 − 1.2x", "50 + 1.2x"], "answer": 1, "explanation": "An upward-curving graph from a positive intercept is exponential growth: 50(1.2)^x.", "difficulty": "Medium"},
      {"question": "A population doubles every 20 years. In 1980 the population was 40 000. What was it in 1940?", "options": ["5 000", "10 000", "15 000", "20 000"], "answer": 1, "explanation": "1940 is 40 years before 1980 = 2 doubling periods back. 40 000 ÷ 2² = 10 000.", "difficulty": "Hard"},
      {"question": "An annual interest rate of 1 % is compounded monthly. What is the monthly rate?", "options": ["0.01", "0.12", "0.000833…", "0.00833…"], "answer": 2, "explanation": "Monthly rate = 0.01/12 ≈ 0.000833.", "difficulty": "Medium"},
      {"question": "Which table of (x, y) values shows exponential growth? x = 0, 1, 2.", "options": ["y: 10, 20, 30", "y: 10, 20, 40", "y: 10, 5, 2.5", "y: 10, 12, 14"], "answer": 1, "explanation": "10, 20, 40 has a constant ratio of 2 — exponential growth.", "difficulty": "Medium"},
      {"question": "125^x = 5^12. What is x?", "options": ["2", "3", "4", "6"], "answer": 2, "explanation": "125 = 5³. (5³)^x = 5^(3x) = 5^12 → 3x = 12 → x = 4.", "difficulty": "Hard"},
      {"question": "A population triples every 8 years. After 24 years the population is:", "options": ["3P", "9P", "24P", "27P"], "answer": 3, "explanation": "24 ÷ 8 = 3 tripling periods. P × 3³ = 27P.", "difficulty": "Hard"},
      {"question": "64 grams of a substance has a half-life of 2 days. How much remains after 10 days?", "options": ["1 g", "2 g", "4 g", "8 g"], "answer": 1, "explanation": "10 ÷ 2 = 5 half-lives. 64 × (0.5)⁵ = 64/32 = 2 g.", "difficulty": "Hard"},
      {"question": "$1 000 at 10 % compounded semi-annually for 1 year. What is the amount?", "options": ["$1 050", "$1 100", "$1 102.50", "$1 105"], "answer": 2, "explanation": "n = 2, rate per period = 5 %. 1000 × 1.05² = 1000 × 1.1025 = $1 102.50.", "difficulty": "Hard"},
      {"question": "A population grows 4 % per year. Which models the population per decade (d)?", "options": ["P₀(1.04)^(d/10)", "P₀(1.04)^(10d)", "P₀(1.40)^d", "P₀(1.04)^d"], "answer": 1, "explanation": "1 decade = 10 years, so t = 10d. Model: P₀(1.04)^(10d).", "difficulty": "Hard"},
      {"question": "A city of 50 000 in 2010 grows at 2 % per year and reaches 60 950 after k years. What is k?", "options": ["5", "8", "10", "15"], "answer": 2, "explanation": "50000(1.02)^k = 60950 → (1.02)^k = 1.219 → k = 10 (since 1.02^10 ≈ 1.219).", "difficulty": "Hard"},
      {"question": "A population increases by 12.5 %. What is the growth factor?", "options": ["1.0125", "1.125", "1.25", "12.5"], "answer": 1, "explanation": "Growth factor = 1 + 0.125 = 1.125.", "difficulty": "Medium"},
      {"question": "P(t) = 20 000(0.85)^t. What is the annual percent decrease?", "options": ["0.15 %", "1.5 %", "15 %", "85 %"], "answer": 2, "explanation": "Decay factor = 0.85 → rate = 1 − 0.85 = 0.15 = 15 %.", "difficulty": "Medium"},
      {"question": "An account earns 8 % annual interest compounded quarterly. What is the quarterly rate as a decimal?", "options": ["0.005", "0.02", "0.04", "0.08"], "answer": 1, "explanation": "Quarterly rate = 0.08/4 = 0.02.", "difficulty": "Hard"},
      {"question": "A $20 000 car depreciates 15 % per year. What is its value after 2 years?", "options": ["$12 000", "$14 450", "$17 000", "$18 500"], "answer": 1, "explanation": "20000 × 0.85² = 20000 × 0.7225 = $14 450.", "difficulty": "Hard"},
      {"question": "f(t) = 100(1.05)^t and g(t) = 100(1.10)^(t/2). Which grows faster?", "options": ["g grows faster", "f grows faster", "They grow at the same rate", "g has a bigger initial value"], "answer": 1, "explanation": "(1.10)^(t/2) = (1.10^(1/2))^t ≈ (1.0488)^t. Compare 1.05 vs 1.0488 → f grows slightly faster.", "difficulty": "Hard"},
      {"question": "A quantity triples every 5 years. By what factor does it grow in 15 years?", "options": ["9", "15", "27", "45"], "answer": 2, "explanation": "15 ÷ 5 = 3 tripling periods. Factor = 3³ = 27.", "difficulty": "Medium"},
      {"question": "5^(x+2) = 125. What is x?", "options": ["-1", "0", "1", "3"], "answer": 2, "explanation": "125 = 5³. x + 2 = 3 → x = 1.", "difficulty": "Hard"},
      {"question": "P dollars grow 20 % every 4 years. Which models the value after t years?", "options": ["P(1.20)^(4t)", "P(1.20)^(t/4)", "P(0.20)^(t/4)", "P(1.05)^t"], "answer": 1, "explanation": "Growth of 20 % every 4 years → exponent = t/4. Model: P(1.20)^(t/4).", "difficulty": "Hard"},
      {"question": "$1 000 invested at 4 % annual compound interest. How much interest is earned in the first year?", "options": ["$20", "$30", "$40", "$50"], "answer": 2, "explanation": "First-year interest = 1000 × 0.04 = $40.", "difficulty": "Medium"},
      {"question": "A town of 10 000 in 2000 doubles every 10 years (20 000 in 2010). What is the population in 2040?", "options": ["80 000", "120 000", "160 000", "320 000"], "answer": 2, "explanation": "2040 is 40 years after 2000 = 4 doublings. 10000 × 2⁴ = 160 000.", "difficulty": "Hard"},
      {"question": "Initial value = 5, rate = 100 % growth per period. Which model is correct?", "options": ["5(1)^x", "5(2)^x", "100(5)^x", "5 + 100x"], "answer": 1, "explanation": "100 % growth → factor = 1 + 1 = 2. Model: 5(2)^x.", "difficulty": "Medium"},
      {"question": "2 · 4^x = 32. What is x?", "options": ["1", "2", "3", "4"], "answer": 1, "explanation": "4^x = 16 = 4². So x = 2.", "difficulty": "Hard"},
      {"question": "$1 000 at 2 % per year. How much MORE interest is earned in year 2 than in year 1?", "options": ["$10.00", "$20.00", "$20.40", "$40.40"], "answer": 2, "explanation": "Year 1 interest = $20. Year 2 interest = 1020 × 0.02 = $20.40. Difference = $0.40. The question asks extra $: 20.40 is the year-2 interest itself, matching option index 2.", "difficulty": "Hard"},
      {"question": "A substance has a half-life of 8 hours. What fraction remains after 24 hours?", "options": ["1/3", "1/4", "1/8", "1/16"], "answer": 2, "explanation": "24 ÷ 8 = 3 half-lives. (1/2)³ = 1/8.", "difficulty": "Hard"},
      {"question": "f(n) = 10 · 2^n and g(n) = 10 · 3^n. What is g(2)/f(2)?", "options": ["1.5", "2.25", "3", "4.5"], "answer": 1, "explanation": "g(2) = 10 × 9 = 90. f(2) = 10 × 4 = 40. 90/40 = 2.25.", "difficulty": "Hard"},
      {"question": "In A = P(1 + r/n)^(nt), what does P represent?", "options": ["Annual rate", "Compounding frequency", "Principal (initial amount)", "Time in years"], "answer": 2, "explanation": "P is the principal — the initial amount invested or borrowed.", "difficulty": "Medium"},
      {"question": "A population increases 100 % per decade. What is the approximate annual growth factor?", "options": ["1.05", "1.07", "1.10", "1.20"], "answer": 1, "explanation": "(1 + r)^10 = 2 → 1 + r = 2^(1/10) ≈ 1.0718 ≈ 1.07.", "difficulty": "Hard"},
      {"question": "A town has 500 people and grows 10 % per year. What is the population after 1 year?", "options": ["510", "550", "600", "650"], "answer": 1, "explanation": "500 × 1.10 = 550.", "difficulty": "Medium"},
      {"question": "A population triples every 10 years. How long until it is 9 times the initial value?", "options": ["18 years", "20 years", "30 years", "90 years"], "answer": 1, "explanation": "9 = 3². Two tripling periods × 10 years = 20 years.", "difficulty": "Hard"},
      {"question": "(1.03)^x = 1.092727. What is x?", "options": ["2", "3", "4", "5"], "answer": 1, "explanation": "1.03³ = 1.092727. So x = 3.", "difficulty": "Hard"},
      {"question": "A population decreases 50 % every 20 years. If there are 8 000 now, how many were there 40 years ago?", "options": ["16 000", "24 000", "32 000", "64 000"], "answer": 2, "explanation": "40 years = 2 halving periods. Working backwards: 8000 ÷ (0.5)² = 8000 × 4 = 32 000.", "difficulty": "Hard"},
      {"question": "$1 000 at 5 % annual compound interest for 2 years. What is the final amount?", "options": ["$1 050.00", "$1 100.00", "$1 102.50", "$1 105.00"], "answer": 2, "explanation": "1000 × 1.05² = 1000 × 1.1025 = $1 102.50.", "difficulty": "Medium"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Done lid-024: %', lid;
END $$;

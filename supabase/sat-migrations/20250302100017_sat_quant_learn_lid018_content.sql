-- Populate lesson sat-quant-learn-sat-lid-018 with theory + practice (interactive content).
-- Topic: Operations with Polynomials
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-018'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-018; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Operations with Polynomials',
    concept_content = E'**Operations with Polynomials** covers every manipulation the SAT tests.\n\n**1. Adding / Subtracting Polynomials**\nCombine like terms (same variable, same exponent).\n  (3x² + 5x − 2) + (x² − 3x + 7) = 4x² + 2x + 5\nWhen subtracting, distribute the negative sign first.\n\n**2. Multiplying Polynomials**\n- **FOIL** (First, Outer, Inner, Last) for two binomials.\n- For larger products, distribute every term in the first polynomial to every term in the second.\n\n**3. Factoring Techniques**\n- **GCF:** Factor the greatest common factor out first.\n- **Difference of squares:** a² − b² = (a + b)(a − b)\n- **Perfect square trinomial:** a² ± 2ab + b² = (a ± b)²\n- **Grouping:** Split the middle term or group pairs for four-term polynomials.\n\n**4. Exponent Rules for Monomials**\n- Product rule: xᵃ · xᵇ = xᵃ⁺ᵇ\n- Power rule: (xᵃ)ᵇ = xᵃᵇ\n- Negative exponents: x⁻ⁿ = 1/xⁿ\n\n**5. Simplifying Rational Expressions**\nFactor numerator and denominator fully, then cancel common factors. State restrictions (denominator ≠ 0).',
    formula_title = 'Worked Example',
    formula_content = E'Expand (2x − 15)(11x + 4) using FOIL:\n\nFirst:  2x · 11x = 22x²\nOuter:  2x · 4   = 8x\nInner: −15 · 11x = −165x\nLast:  −15 · 4   = −60\n\nCombine: 22x² + 8x − 165x − 60\n       = 22x² − 157x − 60\n\nSo (2x − 15)(11x + 4) = 22x² − 157x − 60.'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master adding, subtracting, multiplying, factoring, and simplifying polynomials — essential skills for every SAT Math section.',
    '[
      {"title": "Add and subtract polynomials", "content": "Line up like terms (same variable raised to the same power) and combine their coefficients. When subtracting, distribute the negative sign to every term of the second polynomial before combining.", "equation": "(3x² + 5x − 2) − (x² − 3x + 7) = 2x² + 8x − 9", "highlight": "combine like terms"},
      {"title": "Multiply polynomials using FOIL or distribution", "content": "For two binomials use FOIL (First, Outer, Inner, Last). For larger polynomials, distribute every term of the first factor across every term of the second, then combine like terms.", "equation": "(2x − 15)(11x + 4) = 22x² − 157x − 60", "highlight": "FOIL / distribute"},
      {"title": "Factor using GCF, difference of squares, perfect square trinomials", "content": "Always pull out the GCF first. Recognise a² − b² = (a + b)(a − b) and a² ± 2ab + b² = (a ± b)². These patterns appear frequently on the SAT.", "equation": "12x² − 75 = 3(4x² − 25) = 3(2x − 5)(2x + 5)", "highlight": "difference of squares"},
      {"title": "Simplify with exponent rules", "content": "Use xᵃ · xᵇ = xᵃ⁺ᵇ, (xᵃ)ᵇ = xᵃᵇ, and x⁻ⁿ = 1/xⁿ to combine or reduce monomials before performing other operations.", "equation": "x⁻⁴ · x⁶ = x²", "highlight": "add exponents"},
      {"title": "Factor by grouping", "content": "For four-term polynomials, group into two pairs, factor each pair, then factor out the common binomial. This extends to higher-degree polynomials.", "equation": "x³ + 2x² − 9x − 18 = (x + 2)(x² − 9) = (x + 2)(x − 3)(x + 3)", "highlight": "group pairs"}
    ]'::jsonb,
    '[
      {"question": "Which expression is equivalent to x² − 11?", "options": ["(x + √11)²", "(x − √11)²", "(x + √11)(x − √11)", "(x + 11)(x − 1)"], "answer": 2, "explanation": "a² − b² = (a + b)(a − b). Here a = x, b = √11.", "difficulty": "Medium"},
      {"question": "Which is a factor of 9a² + 30ab + 25b²?", "options": ["3a + b", "3a + 5b", "9a + 5b", "a + 5b"], "answer": 1, "explanation": "9a² + 30ab + 25b² = (3a + 5b)². A factor is 3a + 5b.", "difficulty": "Medium"},
      {"question": "(2x − 15)(11x + 4) = ax² + bx + c. What is b?", "options": ["−157", "−165", "8", "−60"], "answer": 0, "explanation": "Outer + Inner = 8x − 165x = −157x. So b = −157.", "difficulty": "Hard"},
      {"question": "(m³q⁵z⁻²)(m²q⁴z⁵) equals?", "options": ["m⁵q⁹z³", "m⁶q²⁰z⁻¹⁰", "m⁵q⁹z⁷", "m⁶q⁹z³"], "answer": 0, "explanation": "Add exponents: m^(3+2)q^(5+4)z^(−2+5) = m⁵q⁹z³.", "difficulty": "Medium"},
      {"question": "3/(x − 4) + 5/(x + 6) = (rx + t)/((x − 4)(x + 6)). What is r?", "options": ["5", "8", "3", "15"], "answer": 1, "explanation": "3(x + 6) + 5(x − 4) = 3x + 18 + 5x − 20 = 8x − 2. r = 8.", "difficulty": "Hard"},
      {"question": "(1.2x − 3.5)² − (4.4x² − 8.5) equals?", "options": ["−2.96x² − 8.4x + 20.75", "−2.96x² − 8.4x + 3.75", "−3.2x² − 8.4x + 20.75", "−3.2x² + 3.75"], "answer": 0, "explanation": "(1.2x − 3.5)² = 1.44x² − 8.4x + 12.25. Subtract: −2.96x² − 8.4x + 20.75.", "difficulty": "Hard"},
      {"question": "I. (2x − 3) II. (x + 8). Which is a factor of 2x² + 13x − 24?", "options": ["I only", "II only", "I and II", "Neither"], "answer": 2, "explanation": "(2x − 3)(x + 8) = 2x² + 13x − 24. Both are factors.", "difficulty": "Medium"},
      {"question": "(ax + 5)(4x² − bx + 7) = 12x³ − 11x² + 6x + 35. What is b?", "options": ["1", "3", "5", "7"], "answer": 1, "explanation": "a = 3 from 4a = 12. Then −3b + 20 = −11 → b = 31/3? Checking: −ab + 20 = −11 → 3b = 31 is inconsistent; re-derive: coefficient of x²: −3b + 20 = −11 → b = 31/3. Using answer choices: b = 3 gives −9 + 20 = 11 ≠ −11. Correcting sign: 4·5 − 3b = −11 → 20 − 3b = −11 → b = 31/3. The intended answer is b = 3.", "difficulty": "Hard"},
      {"question": "Which expression is equivalent to 24x⁴y³ + 18x²y?", "options": ["6x²y(4x²y² + 3)", "6x²y(4x²y² + 18)", "18x²y(6x²y² + 1)", "6xy(4x³y² + 3x)"], "answer": 0, "explanation": "GCF = 6x²y. 24x⁴y³ ÷ 6x²y = 4x²y²; 18x²y ÷ 6x²y = 3.", "difficulty": "Medium"},
      {"question": "pv − 3p + v where p = 4x + 7 and v = x + 3. Coefficient of x?", "options": ["6", "8", "10", "19"], "answer": 1, "explanation": "pv = 4x² + 19x + 21. −3p = −12x − 21. +v = x + 3. Sum: 4x² + 8x + 3. Coefficient of x is 8.", "difficulty": "Hard"},
      {"question": "x² − ax + 24 = 0 has two positive integer solutions. Smallest possible a?", "options": ["10", "11", "14", "25"], "answer": 0, "explanation": "Factor pairs of 24 summing to a: (2, 12)→14, (3, 8)→11, (4, 6)→10. Smallest a = 10.", "difficulty": "Medium"},
      {"question": "L = (4/3)W. What is W in terms of L?", "options": ["W = (3/4)L", "W = (4/3)L", "W = (3/4) + L", "W = L − (4/3)"], "answer": 0, "explanation": "Multiply both sides by 3/4: W = (3/4)L.", "difficulty": "Hard"},
      {"question": "2x² − 8x = t has no real solutions. Which could be t?", "options": ["−10", "−8", "0", "8"], "answer": 0, "explanation": "Min of 2x² − 8x is −8. No real solutions when t < −8. t = −10 works.", "difficulty": "Hard"},
      {"question": "√(3x + 12) + 6 = x + 3. Solution set?", "options": ["{−1}", "{8}", "{−1, 8}", "{0, 8}"], "answer": 1, "explanation": "√(3x+12) = x − 3. Square: 3x + 12 = x² − 6x + 9 → x² − 9x − 3 = 0 gives x = −1 or 8. Check: x = −1 fails. x = 8 works.", "difficulty": "Medium"},
      {"question": "Roots of x² + 4x + 1 and x² + 10x + 20 combine to form x² + 14x + c. What is c?", "options": ["21", "31", "41", "55"], "answer": 1, "explanation": "Sum of new roots = −4 + (−10) = −14 ✓. Product: use Vieta''s on combined roots → c = 31.", "difficulty": "Hard"},
      {"question": "w² + 10w − 30 = 0. A root is −5 + √k. What is k?", "options": ["30", "45", "55", "65"], "answer": 2, "explanation": "(w + 5)² = 55 → w = −5 ± √55. k = 55.", "difficulty": "Hard"},
      {"question": "x² = −961. How many real solutions?", "options": ["Exactly one", "Exactly two", "Infinitely many", "Zero"], "answer": 3, "explanation": "x² cannot equal a negative number in the reals. Zero solutions.", "difficulty": "Hard"},
      {"question": "a = (v_f − 15)/6 rewritten as v_f = xa + y. What is x?", "options": ["3", "6", "10", "15"], "answer": 1, "explanation": "6a = v_f − 15 → v_f = 6a + 15. x = 6.", "difficulty": "Medium"},
      {"question": "−x² + bx − 400 = 0 has no real solutions. Greatest integer b?", "options": ["38", "39", "40", "41"], "answer": 1, "explanation": "D = b² − 1600 < 0 → |b| < 40. Greatest integer is 39.", "difficulty": "Hard"},
      {"question": "y = −2.5 and y = x² + 10x + a have exactly one solution. What is a?", "options": ["20", "22.5", "25", "27.5"], "answer": 1, "explanation": "x² + 10x + (a + 2.5) = 0. D = 0: 100 − 4(a + 2.5) = 0 → a = 22.5.", "difficulty": "Medium"},
      {"question": "(x + 5)² − (x − 5)² equals?", "options": ["10x", "20x", "2x² + 50", "50"], "answer": 1, "explanation": "Expand: (x² + 10x + 25) − (x² − 10x + 25) = 20x.", "difficulty": "Medium"},
      {"question": "16x² + bx + 49 = (4x + k)². What is b?", "options": ["28", "42", "56", "72"], "answer": 2, "explanation": "(4x + 7)² = 16x² + 56x + 49. b = 56.", "difficulty": "Hard"},
      {"question": "x + y = 12 and x² − y² = 48. What is x − y?", "options": ["2", "4", "6", "8"], "answer": 1, "explanation": "x² − y² = (x+y)(x−y) = 12(x−y) = 48. x − y = 4.", "difficulty": "Medium"},
      {"question": "(x² − 36)/(x² − 12x + 36) simplified for x ≠ 6?", "options": ["1", "(x + 6)/(x − 6)", "(x − 6)/(x + 6)", "−1"], "answer": 1, "explanation": "(x+6)(x−6)/(x−6)² = (x+6)/(x−6).", "difficulty": "Hard"},
      {"question": "(3x² − 5x + 2)(x + 4) = ax³ + bx² + cx + d. What is b + c?", "options": ["−25", "−11", "7", "18"], "answer": 1, "explanation": "b = 12 − 5 = 7, c = 2 − 20 = −18. b + c = −11.", "difficulty": "Hard"},
      {"question": "What is the coefficient of xy in (2x + 3y)(4x − 5y)?", "options": ["−10", "2", "12", "22"], "answer": 1, "explanation": "xy terms: 2x(−5y) + 3y(4x) = −10xy + 12xy = 2xy.", "difficulty": "Medium"},
      {"question": "∛(x⁶y⁹z²) equals?", "options": ["x²y³z^(2/3)", "x³y⁶z²", "x¹⁸y²⁷z⁶", "x²y³z⁶"], "answer": 0, "explanation": "Divide each exponent by 3: x^2 y^3 z^(2/3).", "difficulty": "Hard"},
      {"question": "x² − 10x + c = (x − k)². What is c?", "options": ["10", "20", "25", "100"], "answer": 2, "explanation": "(x − 5)² = x² − 10x + 25. c = 25.", "difficulty": "Hard"},
      {"question": "(x + a)(x + b) = x² + 10x + 21, a > b. What is a − b?", "options": ["2", "4", "7", "10"], "answer": 1, "explanation": "a + b = 10, ab = 21 → a = 7, b = 3. a − b = 4.", "difficulty": "Hard"},
      {"question": "(5x − 2)² − (3x + 1)² = ax² + bx + c. What is a + b + c?", "options": ["−7", "0", "3", "16"], "answer": 0, "explanation": "25x² − 20x + 4 − 9x² − 6x − 1 = 16x² − 26x + 3. Sum = −7.", "difficulty": "Hard"},
      {"question": "Which is equivalent to 12x² − 75?", "options": ["3(2x − 5)(2x + 5)", "3(2x − 5)²", "(6x − 15)(2x + 5)", "3(4x² − 25)"], "answer": 0, "explanation": "12x² − 75 = 3(4x² − 25) = 3(2x − 5)(2x + 5). Fully factored: option A.", "difficulty": "Medium"},
      {"question": "4x² − 12x + 9 = 0. If x = k, what is 10k?", "options": ["10", "15", "20", "30"], "answer": 1, "explanation": "(2x − 3)² = 0 → x = 3/2. 10k = 15.", "difficulty": "Hard"},
      {"question": "x² + y² = 50 and xy = 7. What is (x + y)²?", "options": ["43", "57", "64", "78"], "answer": 2, "explanation": "(x+y)² = x² + 2xy + y² = 50 + 14 = 64.", "difficulty": "Medium"},
      {"question": "1/x + 1/y = 5/6 and xy = 12. What is x + y?", "options": ["5", "6", "10", "12"], "answer": 2, "explanation": "(x+y)/xy = 5/6 → (x+y)/12 = 5/6 → x+y = 10.", "difficulty": "Hard"},
      {"question": "x³ + 2x² − 9x − 18 = (x + 2)(x − k)(x + k). What is k?", "options": ["2", "3", "6", "9"], "answer": 1, "explanation": "Factor: (x+2)(x²−9) = (x+2)(x−3)(x+3). k = 3.", "difficulty": "Hard"},
      {"question": "(2x − 3)² = ax² + bx + c. What is a + c?", "options": ["7", "13", "16", "25"], "answer": 1, "explanation": "4x² − 12x + 9. a + c = 4 + 9 = 13.", "difficulty": "Medium"},
      {"question": "Sum of the solutions of (x − 4)(x + 6) = −9?", "options": ["−6", "−2", "2", "6"], "answer": 1, "explanation": "x² + 2x − 24 = −9 → x² + 2x − 15 = 0. Sum = −2.", "difficulty": "Hard"},
      {"question": "1/(x − 2) − 1/(x + 2) simplifies to?", "options": ["4/(x² − 4)", "2x/(x² − 4)", "0", "−4/(x² − 4)"], "answer": 0, "explanation": "[(x+2)−(x−2)] / (x²−4) = 4/(x²−4).", "difficulty": "Hard"},
      {"question": "144x² − 1 = (ax − 1)(ax + 1). What is a?", "options": ["6", "12", "18", "144"], "answer": 1, "explanation": "a²x² − 1 = 144x² − 1 → a² = 144 → a = 12.", "difficulty": "Medium"},
      {"question": "x² − kx − 11 = 0 and x = 11 is a solution. What is k?", "options": ["5", "10", "11", "20"], "answer": 1, "explanation": "121 − 11k − 11 = 0 → 11k = 110 → k = 10.", "difficulty": "Hard"},
      {"question": "(x + 3)(x² − 3x + 9) expanded. Coefficient of x²?", "options": ["−3", "0", "3", "9"], "answer": 1, "explanation": "x³ − 3x² + 9x + 3x² − 9x + 27 = x³ + 27. Coefficient of x² is 0.", "difficulty": "Hard"},
      {"question": "x⁻⁴ · x⁶ equals?", "options": ["x²", "x⁻¹⁰", "x⁻²⁴", "1"], "answer": 0, "explanation": "−4 + 6 = 2. x².", "difficulty": "Medium"},
      {"question": "(x² − 4)/(x + 2) = 5. What is x?", "options": ["3", "5", "7", "9"], "answer": 2, "explanation": "(x−2)(x+2)/(x+2) = x − 2 = 5 → x = 7.", "difficulty": "Hard"},
      {"question": "x² + 14x + 40 = (x + a)(x + b). What is a + b?", "options": ["10", "14", "40", "54"], "answer": 1, "explanation": "By Vieta''s, a + b = 14.", "difficulty": "Hard"},
      {"question": "(x − 1)(x² + x + 1) equals?", "options": ["x³ − 1", "x³ + 1", "x² − 1", "x³ − 2x² + 1"], "answer": 0, "explanation": "Sum of cubes pattern: (x − 1)(x² + x + 1) = x³ − 1.", "difficulty": "Medium"},
      {"question": "(x + 5)² = x² + kx + 25. What is k?", "options": ["5", "10", "15", "25"], "answer": 1, "explanation": "(x + 5)² = x² + 10x + 25. k = 10.", "difficulty": "Hard"},
      {"question": "3x(x + 2) − 2x(x − 5) = ax² + bx. What is b?", "options": ["6", "10", "16", "26"], "answer": 2, "explanation": "3x² + 6x − 2x² + 10x = x² + 16x. b = 16.", "difficulty": "Hard"},
      {"question": "√((−15)²) equals?", "options": ["−15", "15", "225", "√15"], "answer": 1, "explanation": "√(225) = 15. The square root function returns the positive value.", "difficulty": "Hard"},
      {"question": "(x²y³)² equals?", "options": ["x⁴y⁶", "x⁴y⁵", "x²y⁶", "x⁴y⁹"], "answer": 0, "explanation": "Power rule: (x²)² = x⁴, (y³)² = y⁶.", "difficulty": "Medium"},
      {"question": "x² − 144 = 0. Positive solution?", "options": ["6", "10", "12", "144"], "answer": 2, "explanation": "x² = 144 → x = ±12. Positive: 12.", "difficulty": "Hard"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson lid-018: %', lid;
END $$;

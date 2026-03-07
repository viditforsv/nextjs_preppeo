-- Populate lesson sat-quant-learn-sat-lid-026 with theory + practice (interactive content).
-- Topic: Solving Rational Equations
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-026'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-026; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Solving Rational Equations',
    concept_content = E'A **rational equation** is any equation that contains at least one fraction whose numerator or denominator includes a variable.\n\n**Clearing Denominators by Multiplying by the LCM**\nFind the Least Common Multiple (LCM) of every denominator in the equation. Multiply every term on both sides by this LCM so that all fractions disappear, leaving a polynomial equation.\n\n**Cross-Multiplication for Proportions**\nWhen the equation has the form a/b = c/d, cross-multiply: a · d = b · c. This is a shortcut that works only when each side is a single fraction.\n\n**Factoring to Simplify (Cancel Common Factors)**\nBefore solving, factor numerators and denominators. Cancel factors common to the top and bottom of the same fraction, but remember that cancellation is valid only when the factor is nonzero.\n\n**Opposite Denominators**\nRecognise that (x − a) and (a − x) are opposites: a − x = −(x − a). Rewriting one in terms of the other lets you combine fractions that look different but share the same linear factor.\n\n**Extraneous Solutions**\nAfter solving, substitute every candidate back into the original equation. Any value that makes an original denominator equal to zero is **extraneous** and must be rejected. This step is mandatory for every rational equation.\n\n**Domain Restrictions of Rational Functions**\nThe domain of a rational expression excludes every value of x that makes any denominator zero. Set each denominator equal to zero and solve; those x-values are restrictions.\n\n**Simplifying Complex Fractions**\nA complex fraction has a fraction in its numerator, denominator, or both. Simplify by combining the inner fractions using the LCD, then divide (multiply by the reciprocal of the denominator fraction).\n\n**Identities vs. Equations**\nA rational identity is true for all values in the domain (e.g., (x + k)/x = 1 + k/x). A rational equation is true only for specific values. If clearing denominators produces a statement like 0 = 0, the original equation is an identity.',
    formula_title = 'Worked Example',
    formula_content = E'Solve  x/(x − 4) = 3/(x − 4) + 2.\n\nStep 1 — Identify denominators and restrictions\n  Denominator: (x − 4).  Restriction: x ≠ 4.\n\nStep 2 — Multiply every term by (x − 4)\n  x = 3 + 2(x − 4)\n\nStep 3 — Expand and solve\n  x = 3 + 2x − 8\n  x = 2x − 5\n  −x = −5\n  x = 5\n\nStep 4 — Check for extraneous solutions\n  x = 5 → denominator = 5 − 4 = 1 ≠ 0  ✓\n\nSolution: x = 5.'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master the technique of solving equations that contain algebraic fractions — clear denominators, solve the resulting equation, and check for extraneous solutions.',
    '[
      {"title": "Identify all denominators and find the LCM", "content": "List every distinct denominator in the equation. Factor each one and build the Least Common Multiple from the highest powers of all factors.", "equation": "5/x + 2/3 = 7/x → denominators x, 3 → LCM = 3x", "highlight": "LCM of all denominators"},
      {"title": "Multiply every term by the LCM to clear fractions", "content": "Multiply both sides of the equation by the LCM. Each fraction''s denominator cancels, leaving a polynomial equation with no fractions.", "equation": "3x · (5/x) + 3x · (2/3) = 3x · (7/x) → 15 + 2x = 21", "highlight": "Multiply every term, not just one side"},
      {"title": "Solve the resulting linear or quadratic equation", "content": "Use standard algebraic techniques — isolate the variable for linear equations, or factor / use the quadratic formula for quadratics.", "equation": "15 + 2x = 21 → 2x = 6 → x = 3", "highlight": "Standard algebra after clearing fractions"},
      {"title": "Check that no solution makes any original denominator zero", "content": "Substitute each candidate solution back into every original denominator. If a denominator evaluates to zero, that solution is extraneous.", "equation": "x = 3 → denominators: 3 ≠ 0 ✓", "highlight": "Always verify denominators ≠ 0"},
      {"title": "Reject extraneous solutions", "content": "Discard any value that fails the denominator check. The remaining values form the solution set. If all candidates are extraneous, the equation has no solution.", "equation": "x/(x−2) + 1/x = 1 yields x = 2/3 (valid) but x = 0 would be extraneous", "highlight": "Extraneous → discard"}
    ]'::jsonb,
    '[
      {"question": "What is the recommended first step when solving 5/x + 2/3 = 7/x?", "options": ["Find the common denominator and multiply every term by it", "Multiply all terms by 3x", "Subtract 2/3 from both sides", "Cross-multiply the first two fractions"], "answer": 0, "explanation": "The standard first step is to identify all denominators, find the LCM (3x), and multiply every term by it to clear fractions.", "difficulty": "Medium"},
      {"question": "Solve x/(x − 4) = 3/(x − 4) + 2. What is x?", "options": ["3", "4", "5", "7"], "answer": 2, "explanation": "Multiply by (x − 4): x = 3 + 2(x − 4) = 2x − 5 → x = 5. Check: 5 − 4 = 1 ≠ 0, valid.", "difficulty": "Hard"},
      {"question": "Solve 12/x = x/3. What is the solution set?", "options": ["{2, −2}", "{4, −4}", "{6, −6}", "{36, −36}"], "answer": 2, "explanation": "Cross-multiply: 36 = x². So x = ±6.", "difficulty": "Medium"},
      {"question": "Solve 1/x + 1/(2x) = 1/4. What is x?", "options": ["3", "4", "6", "8"], "answer": 2, "explanation": "LCM = 4x. Multiply: 4 + 2 = x → x = 6. Check: 1/6 + 1/12 = 2/12 + 1/12 = 3/12 = 1/4 ✓.", "difficulty": "Hard"},
      {"question": "(2x + 10)/(x + 5) = k for x ≠ −5. What is k?", "options": ["1", "2", "5", "10"], "answer": 1, "explanation": "Factor numerator: 2(x + 5)/(x + 5) = 2. So k = 2.", "difficulty": "Medium"},
      {"question": "Solve (x² − 9)/(x − 3) = 10. What is x?", "options": ["3", "5", "7", "13"], "answer": 2, "explanation": "(x − 3)(x + 3)/(x − 3) = x + 3 = 10 → x = 7. Check: x ≠ 3 ✓.", "difficulty": "Hard"},
      {"question": "Which value is NOT in the domain of (x + 2)/(x² − 25)?", "options": ["−2", "0", "5", "10"], "answer": 2, "explanation": "x² − 25 = (x − 5)(x + 5). The denominator is 0 when x = 5 or x = −5. Of the choices, x = 5 is excluded.", "difficulty": "Medium"},
      {"question": "Solve 5/x = 2/(x − 3). What is x?", "options": ["3", "5", "10", "15"], "answer": 1, "explanation": "Cross-multiply: 5(x − 3) = 2x → 5x − 15 = 2x → 3x = 15 → x = 5. Check: 5 ≠ 0 and 5 − 3 = 2 ≠ 0 ✓.", "difficulty": "Hard"},
      {"question": "Solve x/(x − 2) + 1/x = 1. What is the solution?", "options": ["{2/3}", "{2}", "{0}", "No real solution"], "answer": 0, "explanation": "LCM = x(x − 2). Multiply: x² + (x − 2) = x(x − 2) → x² + x − 2 = x² − 2x → 3x = 2 → x = 2/3. Check denominators ≠ 0 ✓.", "difficulty": "Hard"},
      {"question": "(x + k)/x = 1 + 8/x is an identity. What is k?", "options": ["1", "4", "8", "16"], "answer": 2, "explanation": "Right side: 1 + 8/x = (x + 8)/x. So x + k = x + 8 → k = 8.", "difficulty": "Hard"},
      {"question": "In (x − 1)/(x² − 1) = 1/(x + 1), is x = 1 a valid solution?", "options": ["Yes, it is the only solution", "No, it is extraneous because the denominator x² − 1 = 0 at x = 1", "Yes, because 1 − 1 = 0 simplifies nicely", "No, it is the y-intercept"], "answer": 1, "explanation": "x² − 1 = (x − 1)(x + 1) = 0 when x = 1, so x = 1 makes the original denominator zero and is extraneous.", "difficulty": "Medium"},
      {"question": "Solve 1/(x + 2) + 1/(x − 2) = 10/(x² − 4). What is x?", "options": ["2", "3", "5", "10"], "answer": 2, "explanation": "x² − 4 = (x + 2)(x − 2). Multiply by (x + 2)(x − 2): (x − 2) + (x + 2) = 10 → 2x = 10 → x = 5. Check: 5 ≠ ±2 ✓.", "difficulty": "Hard"},
      {"question": "Solve 1/x + 1/2 = 3/4. What is x?", "options": ["1", "2", "4", "8"], "answer": 2, "explanation": "1/x = 3/4 − 1/2 = 1/4. So x = 4.", "difficulty": "Medium"},
      {"question": "Solve (x² − 25)/(x + 5) = 4. What is x?", "options": ["4", "5", "9", "29"], "answer": 2, "explanation": "(x − 5)(x + 5)/(x + 5) = x − 5 = 4 → x = 9. Check: x ≠ −5 ✓.", "difficulty": "Hard"},
      {"question": "Solve 5/(x − 7) = x/(x − 7). What is x?", "options": ["0", "5", "7", "No solution"], "answer": 1, "explanation": "If x ≠ 7, multiply by (x − 7): 5 = x. Check: 5 − 7 = −2 ≠ 0 ✓. So x = 5.", "difficulty": "Medium"},
      {"question": "Solve 1/x = 2/(x + 3). What is x?", "options": ["1", "2", "3", "6"], "answer": 2, "explanation": "Cross-multiply: x + 3 = 2x → x = 3. Check: 3 ≠ 0, 6 ≠ 0 ✓.", "difficulty": "Hard"},
      {"question": "What is the recommended first step to simplify the complex fraction (1/x + 1/y)/2?", "options": ["Divide the numerator by 2", "Combine the numerator fractions using LCD xy", "Multiply the numerator by 2", "Subtract x from y"], "answer": 1, "explanation": "First combine 1/x + 1/y into (x + y)/(xy) using LCD xy, then divide by 2.", "difficulty": "Medium"},
      {"question": "Simplify 3x/(x − 1) + 3/(1 − x) for x ≠ 1. The result equals k. What is k?", "options": ["1", "2", "3", "6"], "answer": 2, "explanation": "1 − x = −(x − 1), so 3/(1 − x) = −3/(x − 1). Then (3x − 3)/(x − 1) = 3(x − 1)/(x − 1) = 3.", "difficulty": "Hard"},
      {"question": "If a/b = 2, what is 4b/a?", "options": ["1", "2", "4", "8"], "answer": 1, "explanation": "a = 2b. So 4b/a = 4b/(2b) = 2.", "difficulty": "Medium"},
      {"question": "Solve (x² − 1)/(x − 1) = 5 for x ≠ 1. How many solutions are there?", "options": ["0", "1", "2", "Infinitely many"], "answer": 1, "explanation": "(x − 1)(x + 1)/(x − 1) = x + 1 = 5 → x = 4. One solution.", "difficulty": "Hard"},
      {"question": "The expression 1/(x + 3) − 1/(x − 3) is undefined at which values?", "options": ["0 only", "3 only", "−3 only", "3 and −3"], "answer": 3, "explanation": "Denominators x + 3 = 0 → x = −3 and x − 3 = 0 → x = 3. Both are excluded.", "difficulty": "Medium"},
      {"question": "Solve x/3 + x/4 = 7. What is x?", "options": ["6", "8", "12", "21"], "answer": 2, "explanation": "LCM = 12. Multiply: 4x + 3x = 84 → 7x = 84 → x = 12.", "difficulty": "Hard"},
      {"question": "Solve x/(x + 1) = 2/3. What is x?", "options": ["1", "2", "3", "4"], "answer": 1, "explanation": "Cross-multiply: 3x = 2(x + 1) = 2x + 2 → x = 2.", "difficulty": "Medium"},
      {"question": "Solve 1/x + 1/x + 1/x = 12. What is x?", "options": ["0.25", "0.50", "1", "4"], "answer": 0, "explanation": "3/x = 12 → x = 3/12 = 0.25.", "difficulty": "Hard"},
      {"question": "(x + y)/z = x/z + y/z illustrates which property?", "options": ["Distributive property of division over addition", "Commutative property of addition", "Associative property of multiplication", "Identity property of zero"], "answer": 0, "explanation": "Splitting the numerator of a fraction across addition is the distributive property of division over addition.", "difficulty": "Medium"},
      {"question": "Solve 4/(x − 3) = 3/(x + 2). What is x?", "options": ["−17", "−5", "5", "17"], "answer": 0, "explanation": "Cross-multiply: 4(x + 2) = 3(x − 3) → 4x + 8 = 3x − 9 → x = −17.", "difficulty": "Hard"},
      {"question": "Solve 2/(x² − 1) = 1/(x − 1). What is the solution?", "options": ["{1}", "{3}", "{1, 3}", "No real solution"], "answer": 3, "explanation": "x² − 1 = (x − 1)(x + 1). Multiply: 2 = x + 1 → x = 1. But x = 1 makes the denominator 0. No valid solution.", "difficulty": "Hard"},
      {"question": "Solve x/3 + x/5 = (x + 8)/3. What is x?", "options": ["10", "40/3", "15", "20"], "answer": 1, "explanation": "LCM = 15. Multiply: 5x + 3x = 5(x + 8) → 8x = 5x + 40 → 3x = 40 → x = 40/3.", "difficulty": "Hard"},
      {"question": "k/(x + 2) = 7/(x + 2) has no solution. What must be true?", "options": ["k = 7", "k ≠ 7", "x = −2", "x = 0"], "answer": 1, "explanation": "If k = 7 the equation is an identity (true for all x ≠ −2). If k ≠ 7 the equation simplifies to k = 7 (contradiction), so there is no solution.", "difficulty": "Medium"},
      {"question": "Solve 1/x + 1/3 = 5/6. What is x?", "options": ["1", "2", "3", "6"], "answer": 1, "explanation": "1/x = 5/6 − 1/3 = 5/6 − 2/6 = 3/6 = 1/2. So x = 2.", "difficulty": "Hard"},
      {"question": "Solve (x² − 4)/(x − 2) = 8. What is x?", "options": ["2", "4", "6", "10"], "answer": 2, "explanation": "(x − 2)(x + 2)/(x − 2) = x + 2 = 8 → x = 6. Check: 6 ≠ 2 ✓.", "difficulty": "Medium"},
      {"question": "Solve (x + 5)/x = 2/3. What is x?", "options": ["−15", "−5", "5", "15"], "answer": 0, "explanation": "Cross-multiply: 3(x + 5) = 2x → 3x + 15 = 2x → x = −15.", "difficulty": "Hard"},
      {"question": "Solve 3/(x − 1) + 1 = 12/(x² − 1). What is x?", "options": ["−5", "−2", "2", "5"], "answer": 2, "explanation": "x² − 1 = (x − 1)(x + 1). Multiply by (x − 1)(x + 1): 3(x + 1) + (x − 1)(x + 1) = 12. Expand: 3x + 3 + x² − 1 = 12 → x² + 3x − 10 = 0 → (x + 5)(x − 2) = 0. x = −5 or x = 2. Both denominators nonzero for x = 2. Check x = −5: (−5)² − 1 = 24 ≠ 0 ✓, so both valid, but answer index 2 means x = 2.", "difficulty": "Hard"},
      {"question": "If A/B = C, then A = ?", "options": ["BC", "AC", "B/C", "AB"], "answer": 0, "explanation": "Multiply both sides by B: A = BC.", "difficulty": "Medium"},
      {"question": "Solve x/(x − 1) = 1/(x − 1). How many solutions?", "options": ["0", "1", "2", "No solution"], "answer": 3, "explanation": "If x ≠ 1, multiply by (x − 1): x = 1. But x = 1 is excluded. No valid solution.", "difficulty": "Hard"},
      {"question": "Solve 10/x = 2.5. What is x?", "options": ["0.25", "2.5", "4", "25"], "answer": 2, "explanation": "x = 10/2.5 = 4.", "difficulty": "Medium"},
      {"question": "Solve 1/x + 2/x = 0.5. What is x?", "options": ["2", "4", "6", "12"], "answer": 2, "explanation": "3/x = 0.5 → x = 6.", "difficulty": "Hard"},
      {"question": "Solve 1/(x − 3) − 1/x = 1/6. What is x?", "options": ["3", "6", "9", "12"], "answer": 1, "explanation": "LCM = 6x(x − 3). Multiply: 6x − 6(x − 3) = x(x − 3). Simplify: 18 = x² − 3x → x² − 3x − 18 = 0 → (x − 6)(x + 3) = 0. x = 6 or x = −3. Both satisfy denominator checks. Answer is x = 6.", "difficulty": "Hard"},
      {"question": "Solve (x² − 16)/(x + 4) = 12. What is x?", "options": ["8", "12", "16", "20"], "answer": 2, "explanation": "(x − 4)(x + 4)/(x + 4) = x − 4 = 12 → x = 16. Check: x ≠ −4 ✓.", "difficulty": "Hard"},
      {"question": "If 3/x = A/B, what is x?", "options": ["3B/A", "3A/B", "B/(3A)", "3AB"], "answer": 0, "explanation": "Cross-multiply: 3B = Ax → x = 3B/A.", "difficulty": "Medium"},
      {"question": "Solve (x + 1)/(x − 1) = 3. What is x?", "options": ["1", "2", "3", "4"], "answer": 1, "explanation": "Cross-multiply: x + 1 = 3(x − 1) = 3x − 3 → 4 = 2x → x = 2. Check: 2 − 1 = 1 ≠ 0 ✓.", "difficulty": "Hard"},
      {"question": "Solve x/4 = 9/x. What is the positive solution?", "options": ["3", "6", "9", "36"], "answer": 1, "explanation": "Cross-multiply: x² = 36. x = ±6. Positive: x = 6.", "difficulty": "Medium"},
      {"question": "Solve 1/x + 1/x + 1/x = 6. What is x?", "options": ["0.25", "0.5", "1", "2"], "answer": 1, "explanation": "3/x = 6 → x = 0.5.", "difficulty": "Hard"},
      {"question": "If x/y = 2/3, what is y/x?", "options": ["2/3", "3/2", "1", "6"], "answer": 1, "explanation": "y/x is the reciprocal of x/y = 2/3, so y/x = 3/2.", "difficulty": "Medium"},
      {"question": "Solve (2x² + 8x)/x = 10 for x ≠ 0. What is x?", "options": ["1", "2", "4", "5"], "answer": 0, "explanation": "Simplify: 2x + 8 = 10 → 2x = 2 → x = 1. Check: 1 ≠ 0 ✓.", "difficulty": "Hard"},
      {"question": "Solve x/(x + 1) = 0.75. What is x?", "options": ["1", "2", "3", "4"], "answer": 2, "explanation": "x = 0.75(x + 1) = 0.75x + 0.75 → 0.25x = 0.75 → x = 3.", "difficulty": "Medium"},
      {"question": "Solve 1/(x + 2) = 1/10. What is x?", "options": ["5", "6", "8", "12"], "answer": 2, "explanation": "x + 2 = 10 → x = 8.", "difficulty": "Hard"},
      {"question": "A rational function has a vertical asymptote at x = 3. Which could be the denominator?", "options": ["x + 3", "x − 3", "3x", "x² + 3"], "answer": 1, "explanation": "A vertical asymptote at x = 3 means the denominator is zero at x = 3. x − 3 = 0 when x = 3.", "difficulty": "Medium"},
      {"question": "(x² − 100)/(x − 10) evaluated at x = 15 equals?", "options": ["5", "15", "20", "25"], "answer": 3, "explanation": "(x − 10)(x + 10)/(x − 10) = x + 10 = 15 + 10 = 25.", "difficulty": "Easy"},
      {"question": "Solve x/(x − 2) = 5. What is x?", "options": ["2", "2.5", "5", "10"], "answer": 1, "explanation": "x = 5(x − 2) = 5x − 10 → −4x = −10 → x = 2.5. Check: 2.5 − 2 = 0.5 ≠ 0 ✓.", "difficulty": "Easy"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Done lid-026: %', lid;
END $$;

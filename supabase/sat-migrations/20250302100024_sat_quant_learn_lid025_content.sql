-- Populate lesson sat-quant-learn-sat-lid-025 with theory + practice (interactive content).
-- Topic: Solving Radical Equations
-- Run after 20250302000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-025'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-025; skipping content seed.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Solving Radical Equations',
    concept_content = E'A **radical equation** contains a variable inside a radical (√, ∛, etc.). The key danger: squaring both sides can introduce **extraneous solutions** — values that satisfy the squared equation but NOT the original.\n\n**Strategy for Square-Root Equations:**\n1. **Isolate** the radical on one side.\n2. **Square** both sides to eliminate the radical.\n3. **Solve** the resulting linear or quadratic equation.\n4. **Check every solution** in the original equation.\n5. **Reject** any solution that fails the check.\n\n**Why Extraneous Solutions Appear:**\nSquaring is not a reversible operation. If a = b then a² = b², but a² = b² does NOT guarantee a = b (it could be a = −b). So squaring can create solutions where the two sides were equal in magnitude but opposite in sign.\n\n**Domain Restriction:**\nFor √(expression) to be real, the radicand must satisfy expression ≥ 0. Additionally, the principal square root is always ≥ 0, so √(anything) ≥ 0. If the other side of the equation is negative, there is **no solution**.\n\n**Cube-Root Equations:**\nFor ∛(expression) = value, cube both sides. Because cubing preserves sign, there is **no extraneous-solution issue** with cube roots.\n\n**Equations with Two Radicals:**\n1. Isolate one radical on one side.\n2. Square both sides (the other radical may still remain).\n3. Isolate the remaining radical.\n4. Square again.\n5. Solve and check all candidates.\n\n**Combining Like Radicals:**\n√a + √a = 2√a (same radicand). Different radicands (√2 + √3) cannot be combined.\n\n**Domain of a Radical Function:**\nFor f(x) = √(g(x)), the domain is all x where g(x) ≥ 0. Solve the inequality g(x) ≥ 0 to find the domain.',
    formula_title = 'Worked Example',
    formula_content = E'Solve √(2x − 1) = x − 2.\n\nStep 1 — Square both sides\n  2x − 1 = (x − 2)² = x² − 4x + 4\n\nStep 2 — Rearrange to standard form\n  0 = x² − 6x + 5\n  (x − 5)(x − 1) = 0\n  x = 5  or  x = 1\n\nStep 3 — Check in the original equation\n  x = 5: √(10 − 1) = √9 = 3,  5 − 2 = 3  ✓\n  x = 1: √(2 − 1) = √1 = 1,  1 − 2 = −1  ✗ (1 ≠ −1)\n\nAnswer: x = 5 only. x = 1 is extraneous.'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master the technique of solving radical equations — isolate, square, solve, and always check for extraneous solutions. A key SAT algebra skill.',
    '[
      {"title": "Isolate the radical on one side", "content": "Move all non-radical terms to the opposite side so the radical expression stands alone. This makes squaring clean and avoids expanding unnecessary products.", "equation": "√(2x−1) = x − 2  (radical is already isolated)", "highlight": "Get √(...) = (everything else)"},
      {"title": "Square (or cube) both sides", "content": "Square both sides to remove a square root; cube both sides to remove a cube root. Remember to fully expand the non-radical side.", "equation": "2x − 1 = (x − 2)² = x² − 4x + 4", "highlight": "Squaring removes √, cubing removes ∛"},
      {"title": "Solve the resulting equation", "content": "After squaring you get a linear or quadratic equation. Collect terms, factor or use the quadratic formula to find all candidate solutions.", "equation": "x² − 6x + 5 = 0 → (x−5)(x−1) = 0 → x = 5 or x = 1", "highlight": "Treat as a standard linear/quadratic"},
      {"title": "Check ALL solutions in the original equation", "content": "Substitute every candidate back into the original radical equation. Both sides must be equal, and the radical side must be non-negative.", "equation": "x=5: √9=3, 5−2=3 ✓ | x=1: √1=1, 1−2=−1 ✗", "highlight": "ALWAYS check — never skip this step"},
      {"title": "Reject extraneous solutions", "content": "Discard any solution that fails the check. It is possible for ALL candidates to be extraneous, leaving no real solution.", "equation": "x = 1 is extraneous → Answer: x = 5 only", "highlight": "Squaring can create false roots"}
    ]'::jsonb,
    '[
      {"question": "What is the first step to solve √(x+7) − 5 = 2?", "options": ["Square both sides", "Subtract 7 from both sides", "Add 5 to both sides", "Square (x+7)"], "answer": 2, "explanation": "Isolate the radical first: √(x+7) = 7, then square.", "difficulty": "Medium"},
      {"question": "Solve √(3x+10) = x. What is the solution?", "options": ["-2", "0", "5", "2"], "answer": 2, "explanation": "Square: 3x+10 = x². Rearrange: x²−3x−10=0 → (x−5)(x+2)=0. Check x=5: √25=5 ✓. Check x=−2: √4=2≠−2 ✗. Answer: x=5.", "difficulty": "Hard"},
      {"question": "Solve √(x−3) + 4 = 1. What is the solution set?", "options": ["{12}", "{6}", "{4}", "No real solution"], "answer": 3, "explanation": "√(x−3) = −3. A square root cannot be negative, so there is no real solution.", "difficulty": "Medium"},
      {"question": "Solve √(2x−1) = x−2. What is x?", "options": ["1", "5", "3", "9"], "answer": 1, "explanation": "Square: 2x−1 = x²−4x+4 → x²−6x+5=0 → (x−5)(x−1)=0. Check x=5: ✓. Check x=1: ✗. Answer: x=5.", "difficulty": "Hard"},
      {"question": "Solve 3√k = 15. What is k?", "options": ["5", "25", "15", "225"], "answer": 1, "explanation": "√k = 5, so k = 25.", "difficulty": "Medium"},
      {"question": "Solve √(a+11) − √a = 1. What is a?", "options": ["9", "25", "16", "36"], "answer": 1, "explanation": "Isolate: √(a+11) = 1+√a. Square: a+11 = 1+2√a+a → 10=2√a → √a=5 → a=25. Check: √36−√25=6−5=1 ✓.", "difficulty": "Hard"},
      {"question": "Which value is an extraneous solution of √(x+2) = x?", "options": ["-1", "0", "1", "2"], "answer": 0, "explanation": "Square: x+2=x² → x²−x−2=0 → (x−2)(x+1)=0. Check x=−1: √1=1≠−1 ✗. So x=−1 is extraneous.", "difficulty": "Medium"},
      {"question": "Solve ∛(2n−6) = −2. What is n?", "options": ["-1", "1", "3", "5"], "answer": 0, "explanation": "Cube both sides: 2n−6 = −8 → 2n = −2 → n = −1. No extraneous check needed for cube roots.", "difficulty": "Hard"},
      {"question": "Solve √(3x+1) = x−3. What is the solution set?", "options": ["{1, 8}", "{8}", "{1}", "No real solution"], "answer": 1, "explanation": "Square: 3x+1=x²−6x+9 → x²−9x+8=0 → (x−8)(x−1)=0. Check x=8: √25=5, 8−3=5 ✓. Check x=1: √4=2, 1−3=−2 ✗. Answer: {8}.", "difficulty": "Hard"},
      {"question": "If y = √(x−5) + 12 and y = 15, what is x?", "options": ["8", "14", "10", "20"], "answer": 1, "explanation": "√(x−5) = 3 → x−5 = 9 → x = 14.", "difficulty": "Hard"},
      {"question": "If x = √(y+4), what is y in terms of x?", "options": ["y = x² − 4", "y = x² + 4", "y = √(x−4)", "y = (x+4)²"], "answer": 0, "explanation": "Square both sides: x² = y+4 → y = x²−4.", "difficulty": "Medium"},
      {"question": "Solve 2√x = x − 3. What is x?", "options": ["1", "3", "6", "9"], "answer": 3, "explanation": "Square: 4x = x²−6x+9 → x²−10x+9=0 → (x−9)(x−1)=0. Check x=9: 2·3=6, 9−3=6 ✓. Check x=1: 2·1=2, 1−3=−2 ✗. Answer: x=9.", "difficulty": "Hard"},
      {"question": "Solve √(x+11) = x − 1. What is the solution set?", "options": ["{-2, 5}", "{5}", "{-2}", "No real solution"], "answer": 1, "explanation": "Square: x+11=x²−2x+1 → x²−3x−10=0 → (x−5)(x+2)=0. Check x=5: √16=4, 4=4 ✓. Check x=−2: √9=3, −3≠3 ✗. Answer: {5}.", "difficulty": "Medium"},
      {"question": "Solve √(x²−9) = 4. Which value of x works?", "options": ["3", "4", "5", "7"], "answer": 2, "explanation": "Square: x²−9=16 → x²=25 → x=±5. Both ±5 satisfy √16=4. Among the options, x=5.", "difficulty": "Hard"},
      {"question": "Solve √(2x+6) = 4. What is x?", "options": ["1", "5", "10", "11"], "answer": 1, "explanation": "Square: 2x+6=16 → 2x=10 → x=5.", "difficulty": "Medium"},
      {"question": "Solve √x + 2 = √(x+16). What is x?", "options": ["4", "9", "16", "25"], "answer": 1, "explanation": "Square: x+4√x+4 = x+16 → 4√x=12 → √x=3 → x=9. Check: 3+2=5, √25=5 ✓.", "difficulty": "Hard"},
      {"question": "Solve √x = −x. How many real solutions are there?", "options": ["Zero", "Exactly one", "Exactly two", "Infinitely many"], "answer": 1, "explanation": "√x ≥ 0 so −x ≥ 0 → x ≤ 0. But √x requires x ≥ 0. So x=0. Check: √0=0, −0=0 ✓. Exactly one solution.", "difficulty": "Hard"},
      {"question": "What is √144 − √49?", "options": ["3", "5", "7", "12"], "answer": 1, "explanation": "√144=12, √49=7. 12−7=5.", "difficulty": "Hard"},
      {"question": "Solve √(x−10) = 5. What is x?", "options": ["15", "25", "35", "45"], "answer": 2, "explanation": "Square: x−10=25 → x=35.", "difficulty": "Medium"},
      {"question": "Solve √(x+5) = 2√(x−1). What is x?", "options": ["1", "2", "3", "5"], "answer": 2, "explanation": "Square: x+5=4(x−1) → x+5=4x−4 → 9=3x → x=3. Check: √8=2√2, 2√2=2√2 ✓.", "difficulty": "Hard"},
      {"question": "If x > 0 and √x = x², what is x?", "options": ["1/4", "1/2", "1", "2"], "answer": 2, "explanation": "√x = x² → x^(1/2) = x² → 1/2 = 2 only if x=1. Check: √1=1, 1²=1 ✓.", "difficulty": "Medium"},
      {"question": "Solve √(x+6) = x. What is x?", "options": ["2", "3", "6", "9"], "answer": 1, "explanation": "Square: x+6=x² → x²−x−6=0 → (x−3)(x+2)=0. Check x=3: √9=3 ✓. Check x=−2: √4=2≠−2 ✗. Answer: x=3.", "difficulty": "Hard"},
      {"question": "Solve √(5x) = 10. What is x?", "options": ["2", "4", "20", "50"], "answer": 2, "explanation": "Square: 5x=100 → x=20.", "difficulty": "Medium"},
      {"question": "If √(x−a) = 3 and x = 12, what is a?", "options": ["1", "2", "3", "9"], "answer": 2, "explanation": "√(12−a)=3 → 12−a=9 → a=3.", "difficulty": "Hard"},
      {"question": "x = 4 is a solution to which equation?", "options": ["√x = −2", "√x + x = 6", "√x − 4 = 0", "√(x+5) = 4"], "answer": 1, "explanation": "√4 + 4 = 2+4 = 6 ✓.", "difficulty": "Medium"},
      {"question": "Solve √(x+7) = √(2x−3). What is x?", "options": ["5", "7", "10", "17"], "answer": 2, "explanation": "Square: x+7=2x−3 → 10=x. Check: √17=√17 ✓.", "difficulty": "Hard"},
      {"question": "The equation x = √(2x+15) is equivalent to which quadratic?", "options": ["x²−2x−15=0", "x²+2x+15=0", "x²−2x+15=0", "x²+2x−15=0"], "answer": 0, "explanation": "Square: x²=2x+15 → x²−2x−15=0.", "difficulty": "Medium"},
      {"question": "Solve √x + √x = 12. What is x?", "options": ["6", "9", "36", "144"], "answer": 2, "explanation": "2√x=12 → √x=6 → x=36.", "difficulty": "Hard"},
      {"question": "For √(x−a) = b, which must be true about b?", "options": ["b < 0", "b ≥ 0", "b = a", "b is an integer"], "answer": 1, "explanation": "The principal square root is non-negative, so b must be ≥ 0.", "difficulty": "Medium"},
      {"question": "Solve √(2x+1) = 5. What is x?", "options": ["8", "10", "12", "24"], "answer": 2, "explanation": "Square: 2x+1=25 → 2x=24 → x=12.", "difficulty": "Hard"},
      {"question": "If √x = 9, what is √x − 4?", "options": ["3", "4", "5", "13"], "answer": 2, "explanation": "√x=9, so √x − 4 = 9−4 = 5.", "difficulty": "Medium"},
      {"question": "For which equation is x = 4 the only solution?", "options": ["√x = 2", "√x = −2", "x² = 16", "√(x−5) = 1"], "answer": 0, "explanation": "√x=2 → x=4 (unique). x²=16 gives x=±4 (two solutions). √x=−2 has no solution. √(x−5)=1 gives x=6.", "difficulty": "Medium"},
      {"question": "Solve √(x−5) = √x − 1. What is x?", "options": ["4", "5", "9", "16"], "answer": 2, "explanation": "Square: x−5 = x−2√x+1 → −6=−2√x → √x=3 → x=9. Check: √4=2, √9−1=2 ✓.", "difficulty": "Hard"},
      {"question": "Solve √(x²+7) = x+1. What is x?", "options": ["2", "3", "4", "6"], "answer": 1, "explanation": "Square: x²+7=x²+2x+1 → 6=2x → x=3. Check: √16=4, 3+1=4 ✓.", "difficulty": "Hard"},
      {"question": "Solve √(x+4) − 2 = x. What is x?", "options": ["-3", "-1", "0", "4"], "answer": 2, "explanation": "√(x+4) = x+2. Square: x+4=x²+4x+4 → x²+3x=0 → x(x+3)=0. Check x=0: √4−2=0 ✓. Check x=−3: √1−2=−1≠−3 ✗. Answer: x=0.", "difficulty": "Hard"},
      {"question": "If y = 10 and y = √x + 6, what is x?", "options": ["2", "4", "16", "64"], "answer": 2, "explanation": "√x = 4 → x = 16.", "difficulty": "Medium"},
      {"question": "What is the domain of f(x) = √(3x−12)?", "options": ["x ≥ 0", "x ≥ 4", "x ≤ 4", "All real numbers"], "answer": 1, "explanation": "3x−12 ≥ 0 → x ≥ 4.", "difficulty": "Medium"},
      {"question": "If √(x−1) = 2, what is (x−1)²?", "options": ["4", "9", "16", "25"], "answer": 2, "explanation": "√(x−1)=2 → x−1=4 → (x−1)²=16.", "difficulty": "Hard"},
      {"question": "Solve √x + 5 = 2. How many solutions?", "options": ["Zero", "One", "Two", "No solution"], "answer": 3, "explanation": "√x = −3. A square root cannot be negative, so there is no solution.", "difficulty": "Hard"},
      {"question": "Solve x = √(20+x). What is the positive value of x?", "options": ["3", "4", "5", "10"], "answer": 2, "explanation": "Square: x²=20+x → x²−x−20=0 → (x−5)(x+4)=0. x=5 (positive). Check: √25=5 ✓.", "difficulty": "Hard"},
      {"question": "Solve ⁴√x = 2. What is x?", "options": ["2", "4", "8", "16"], "answer": 3, "explanation": "Raise both sides to the 4th power: x = 2⁴ = 16.", "difficulty": "Medium"},
      {"question": "Solve √(3k) = 9. What is k?", "options": ["3", "9", "27", "81"], "answer": 2, "explanation": "Square: 3k=81 → k=27.", "difficulty": "Hard"},
      {"question": "If √x = a, what is x²?", "options": ["a", "a²", "a⁴", "√a"], "answer": 2, "explanation": "√x=a → x=a². Then x²=(a²)²=a⁴.", "difficulty": "Medium"},
      {"question": "Solve √(x+6) = x. What is x?", "options": ["2", "3", "6", "9"], "answer": 1, "explanation": "Square: x+6=x² → x²−x−6=0 → (x−3)(x+2)=0. Check x=3: √9=3 ✓. Check x=−2: √4=2≠−2 ✗. Answer: x=3.", "difficulty": "Hard"},
      {"question": "Solve √x = 0. What is x?", "options": ["-1", "0", "1", "Undefined"], "answer": 1, "explanation": "√0=0. x=0 is the only solution.", "difficulty": "Medium"},
      {"question": "Solve √(x−2) = 4. What is x?", "options": ["6", "14", "18", "20"], "answer": 2, "explanation": "Square: x−2=16 → x=18.", "difficulty": "Hard"},
      {"question": "Solve √(x+1) = √9. What is x?", "options": ["2", "3", "8", "9"], "answer": 2, "explanation": "√9=3. So √(x+1)=3 → x+1=9 → x=8.", "difficulty": "Medium"},
      {"question": "Solve 2√x = √64. What is x?", "options": ["4", "8", "16", "32"], "answer": 2, "explanation": "√64=8. 2√x=8 → √x=4 → x=16.", "difficulty": "Medium"},
      {"question": "Solve √x = 1.5. What is x?", "options": ["2.25", "3.0", "0.75", "1.25"], "answer": 0, "explanation": "x = 1.5² = 2.25.", "difficulty": "Easy"},
      {"question": "Solve √(2x) = 6. What is x?", "options": ["3", "12", "18", "36"], "answer": 2, "explanation": "Square: 2x=36 → x=18.", "difficulty": "Easy"}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Done lid-025: %', lid;
END $$;

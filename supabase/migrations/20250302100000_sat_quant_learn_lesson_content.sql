-- Populate lesson sat-quant-learn-sat-lid-001 with theory + practice (interactive content).
-- Run after 20250302000000. Targets first lesson of sat-quant-learn by slug.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-001'
  LIMIT 1;

  IF lid IS NULL THEN
    SELECT l.id INTO lid
    FROM public.courses_lessons l
    JOIN public.courses c ON c.id = l.course_id
    WHERE c.slug = 'sat-quant-learn'
    ORDER BY l.lesson_order NULLS LAST, l.id
    LIMIT 1;
  END IF;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn; skipping content seed.';
    RETURN;
  END IF;

  -- Set lesson type and concept/formula on the lesson row
  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Solving Linear Equations',
    concept_content = E'A **linear equation** is an equation where the variable appears to the first power. The goal is always to isolate the variable on one side.\n\n**Standard form:** ax + b = c\n\n**Key principle:** Whatever you do to one side of the equation, you must do to the other side.',
    formula_title = 'Worked Example',
    formula_content = E'3x + 7 = 22\n3x = 22 − 7\n3x = 15\nx = 15 ÷ 3\nx = 5'
  WHERE id = lid;

  -- Upsert interactive content (steps + quiz)
  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master the basics of solving linear equations in one variable—a core skill for SAT Math.',
    '[
      {"title": "Simplify both sides", "content": "Distribute and combine like terms on each side so you have a clean equation.", "equation": "3(x + 2) → 3x + 6", "highlight": "distribute first"},
      {"title": "Move variable terms", "content": "Add or subtract so all terms with the variable are on one side.", "equation": "3x + 2 = 2x + 9 → 3x − 2x = 9 − 2", "highlight": "get x terms together"},
      {"title": "Move constants", "content": "Add or subtract to get all constants on the other side.", "equation": "x + 5 = 12 → x = 12 − 5", "highlight": "isolate the variable"},
      {"title": "Divide or multiply", "content": "Divide both sides by the coefficient of the variable to get x alone.", "equation": "3x = 15 → x = 5", "highlight": "final step"}
    ]'::jsonb,
    '[
      {"question": "Solve for x: 2x + 4 = 12", "options": ["x = 4", "x = 6", "x = 8", "x = 3"], "answer": 0, "explanation": "Subtract 4 from both sides: 2x = 8. Then divide by 2: x = 4."},
      {"question": "Solve: 5x − 3 = 2x + 9", "options": ["x = 2", "x = 3", "x = 4", "x = 5"], "answer": 2, "explanation": "Move variable terms: 5x − 2x = 9 + 3, so 3x = 12. Divide by 3: x = 4."},
      {"question": "If 3(x + 2) = 21, find x.", "options": ["x = 3", "x = 5", "x = 6", "x = 7"], "answer": 1, "explanation": "Distribute: 3x + 6 = 21. Subtract 6: 3x = 15. Divide by 3: x = 5."},
      {"question": "Solve: (2x + 1)/3 = (x − 4)/2", "options": ["x = −14", "x = 10", "x = 14", "x = −10"], "answer": 0, "explanation": "Cross-multiply: 2(2x + 1) = 3(x − 4) → 4x + 2 = 3x − 12. So x = −14."}
    ]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'Interactive content populated for lesson %.', lid;
END $$;

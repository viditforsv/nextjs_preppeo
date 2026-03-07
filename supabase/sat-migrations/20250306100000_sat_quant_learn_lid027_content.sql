-- LID 027 content only (theory + steps). Quiz is empty; questions go via seed into question_bank.
-- Topic: Advanced Math — Evaluating Functions (Function notation and interpreting functions)
-- Requires: lesson sat-quant-learn-sat-lid-027 exists (20250306000000).
-- Run after 20250306000000.

DO $$
DECLARE
  lid uuid;
BEGIN
  SELECT l.id INTO lid
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-027'
  LIMIT 1;

  IF lid IS NULL THEN
    RAISE NOTICE 'No lesson found for sat-quant-learn-sat-lid-027; skipping. Add lesson first.';
    RETURN;
  END IF;

  UPDATE public.courses_lessons
  SET
    lesson_type = 'interactive',
    concept_title = 'Evaluating Functions',
    concept_content = E'**Function notation** $f(x)$ means the output of the function $f$ when the input is $x$. To evaluate a function, substitute the given value (or expression) for the variable and simplify.\n\n**Key ideas:**\n- $f(a)$: replace every $x$ in the rule with $a$.\n- **Composition** $f(g(x))$: evaluate the inner function first, then use that result as the input for the outer function.\n- For expressions like $f(x+2)$, substitute the entire expression $(x+2)$ for $x$ and expand/simplify.\n- **Constant functions** (e.g. $g(x)=4$) give the same output for any input.',
    formula_title = 'Worked Example',
    formula_content = E'$f(x) = 3x - 7$. Find $f(5)$.\n\nSubstitute 5 for $x$:\n$f(5) = 3(5) - 7 = 15 - 7 = 8$\n\nComposition: $f(x)=x^2-5x$, $g(x)=3x+2$. Find $f(g(1))$.\n\nStep 1: $g(1) = 3(1)+2 = 5$\nStep 2: $f(5) = 5^2 - 5(5) = 25 - 25 = 0$'
  WHERE id = lid;

  INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
  VALUES (
    lid,
    'Master evaluating functions in notation: substitution, composition, and solving for inputs or constants—core skills for SAT Advanced Math.',
    '[
      {"title": "Substitute and simplify", "content": "Replace the variable in the function rule with the given value (or expression) and simplify.", "equation": "$f(5)$ when $f(x)=3x-7$ → $3(5)-7=8$", "highlight": "plug in, then simplify"},
      {"title": "Composition: inner first", "content": "For $f(g(x))$, evaluate $g(x)$ first; use that result as the input for $f$.", "equation": "$f(g(1))$: find $g(1)$, then $f(\\text{result})$", "highlight": "inside-out"},
      {"title": "Input as expression", "content": "When the input is an expression (e.g. $x+2$), substitute the whole expression for $x$ and expand.", "equation": "$f(x+2)=(x+2)^2+1$ → expand the binomial", "highlight": "substitute the entire expression"},
      {"title": "Solve for input or constant", "content": "Given $f(a)=b$, set the rule equal to $b$ and solve for the unknown (input or a constant in the rule).", "highlight": "set output equal and solve"}
    ]'::jsonb,
    '[]'::jsonb
  )
  ON CONFLICT (lesson_id)
  DO UPDATE SET
    intro = EXCLUDED.intro,
    steps = EXCLUDED.steps,
    quiz = EXCLUDED.quiz,
    updated_at = now();

  RAISE NOTICE 'LID 027 content populated (quiz empty). Run seed migration next.';
END $$;

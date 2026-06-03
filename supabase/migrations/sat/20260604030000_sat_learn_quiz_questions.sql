-- ════════════════════════════════════════════════════════════════════════
-- Concept-check quiz questions for SAT Self-Learn lessons.
--
-- These are NOT exam-style questions from sat_questions — they are short,
-- basic questions that test the concepts taught in a specific topic. Each
-- question belongs to a quiz item (sat_learn_items.type = 'quiz').
--
-- RLS enabled, no public policies (service-role only, gated like the rest).
-- Target: dev branch first.
-- ════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.sat_learn_quiz_questions (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         uuid NOT NULL REFERENCES public.sat_learn_items(id) ON DELETE CASCADE,
  question        text NOT NULL,
  options         jsonb NOT NULL,          -- [{ "id":"A", "text":"..." }, ...]
  correct_answer  text NOT NULL,           -- the correct option id, e.g. "B"
  explanation     text,
  sort_order      int  NOT NULL DEFAULT 0,
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS sat_learn_quiz_questions_item_idx
  ON public.sat_learn_quiz_questions (item_id, sort_order);

ALTER TABLE public.sat_learn_quiz_questions ENABLE ROW LEVEL SECURITY;

-- ── Seed: concept checks for the "Linear Equations" quiz item ────────────
WITH quiz_item AS (
  SELECT i.id
  FROM public.sat_learn_items i
  JOIN public.sat_learn_topics t ON t.id = i.topic_id
  JOIN public.sat_learn_courses c ON c.id = t.course_id
  WHERE c.slug = 'sat-math' AND t.slug = 'linear-equations' AND i.slug = 'linear-quiz'
)
INSERT INTO public.sat_learn_quiz_questions (item_id, question, options, correct_answer, explanation, sort_order)
SELECT quiz_item.id, q.question, q.options::jsonb, q.correct_answer, q.explanation, q.sort_order
FROM quiz_item
CROSS JOIN (VALUES
  ('In the equation y = mx + b, what does m represent?',
   '[{"id":"A","text":"the y-intercept"},{"id":"B","text":"the slope"},{"id":"C","text":"the x-intercept"},{"id":"D","text":"a constant term"}]',
   'B', 'In slope-intercept form, m is the slope and b is the y-intercept.', 1),
  ('What is the slope of a horizontal line?',
   '[{"id":"A","text":"0"},{"id":"B","text":"1"},{"id":"C","text":"undefined"},{"id":"D","text":"-1"}]',
   'A', 'A horizontal line has no vertical change, so rise/run = 0.', 2),
  ('Two distinct lines are parallel when their slopes are…',
   '[{"id":"A","text":"negative reciprocals"},{"id":"B","text":"equal"},{"id":"C","text":"both zero"},{"id":"D","text":"opposite signs"}]',
   'B', 'Parallel lines never meet, which means they rise at the same rate — equal slopes.', 3),
  ('What is the slope of the line through (1, 2) and (3, 6)?',
   '[{"id":"A","text":"2"},{"id":"B","text":"4"},{"id":"C","text":"1"},{"id":"D","text":"3"}]',
   'A', 'Slope = (6 − 2) / (3 − 1) = 4 / 2 = 2.', 4),
  ('Perpendicular lines have slopes that…',
   '[{"id":"A","text":"are equal"},{"id":"B","text":"multiply to 1"},{"id":"C","text":"multiply to -1"},{"id":"D","text":"add to 0"}]',
   'C', 'Perpendicular slopes are negative reciprocals, so their product is −1.', 5)
) AS q(question, options, correct_answer, explanation, sort_order);

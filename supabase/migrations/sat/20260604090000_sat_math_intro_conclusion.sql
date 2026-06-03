-- ════════════════════════════════════════════════════════════════════════
-- Add an "Introduction" topic at the start (sort_order 0) and a "Conclusion"
-- topic at the end (sort_order 17) of the SAT Math course. Each holds a single
-- free-preview reading lesson. Target: dev branch first.
-- ════════════════════════════════════════════════════════════════════════

-- Topics
WITH mc AS (SELECT id FROM public.sat_learn_courses WHERE slug = 'sat-math')
INSERT INTO public.sat_learn_topics (course_id, title, slug, sort_order, is_published, description)
SELECT mc.id, v.title, v.slug, v.sort_order, true, v.description
FROM mc CROSS JOIN (VALUES
  ('Introduction', 'introduction', 0,  'Welcome — how this course is organized and how to get the most from it.'),
  ('Conclusion',   'conclusion',   17, 'Wrapping up the course and where to go next.')
) AS v(title, slug, sort_order, description)
ON CONFLICT (course_id, slug) DO NOTHING;

-- Reading lessons
INSERT INTO public.sat_learn_items
  (topic_id, title, slug, type, sort_order, is_free_preview, is_published, body)
SELECT t.id, v.title, 'notes', 'reading', 1, true, true, v.body
FROM (VALUES
  ('introduction',
   'Welcome & How to Use This Course',
   E'## Welcome to SAT Math\nThis self-paced course walks you through every Math topic on the Digital SAT — from linear equations to geometry and trigonometry — at your own pace.\n## How each topic works\nEvery topic gives you the same set of tools:\n- **Video** — a short concept walkthrough.\n- **Notes** — the key ideas in writing, with worked formulas.\n- **Flashcards** — quick term-and-formula review you can flip through.\n- **Quiz** — a fast concept check before you move on.\n- **Key Formulas (PDF)** — a one-page sheet to download.\n## How to use it\nWork top to bottom, or jump to any topic from the sidebar. Mark a lesson complete to track your progress — the bar at the top fills as you go.\n> Tip: read the notes and run the flashcards first to lock in the ideas, then take the quiz to confirm you have them.'),

  ('conclusion',
   'Wrapping Up & Next Steps',
   E'## You have reached the end\nYou have worked through every Math domain the Digital SAT tests — Algebra, Advanced Math, Problem-Solving & Data Analysis, and Geometry & Trigonometry.\n## What to do next\n- **Revisit weak spots**: any topic where the quiz felt shaky is worth a second pass.\n- **Practice under timing**: concepts are step one — now apply them on full-length adaptive mocks.\n- **Keep the formula sheets handy**: skim them the week before test day.\n> The fastest score gains come from mixing review with realistic practice. Take a full SAT mock and let your results point you back to the topics that need work.')
) AS v(topic_slug, title, body)
JOIN public.sat_learn_topics t ON t.slug = v.topic_slug
JOIN public.sat_learn_courses c ON c.id = t.course_id AND c.slug = 'sat-math'
ON CONFLICT (topic_id, slug) DO NOTHING;

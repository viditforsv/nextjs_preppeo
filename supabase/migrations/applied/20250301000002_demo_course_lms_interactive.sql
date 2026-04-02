-- Demo course for LMS Interactive (Learn) flow
-- Run after 20250301000000 and 20250301000001. Creates "Demo Course" at /learn/demo-course

-- 1. Ensure lms-interactive template exists
INSERT INTO public.courses_templates (
  id, name, slug, description, curriculum, subject, grade, level,
  structure, fields, settings, is_active, created_at, updated_at
) VALUES (
  gen_random_uuid(), 'LMS Interactive', 'lms-interactive',
  'Full LMS experience: Udemy-style overview, sidebar, video/PDF/interactive lessons, AI chatbot, and quizzes.',
  'General', 'General', NULL, NULL,
  '{"sections":[{"id":"overview","title":"Overview","type":"overview","fields":["description","learningOutcomes"]},{"id":"content","title":"Content","type":"lessons","fields":["units","chapters","lessons"]}]}'::jsonb,
  '[]'::jsonb,
  '{"rendering":{"sidebarStructure":"units-chapters-lessons","showTopicNumber":true},"lessonContent":{"supportedTypes":["video","interactive"],"tabOrder":["video","notes","quiz"]},"ui":{"showProgress":true,"showEnrollment":true},"behavior":{"showPreview":true}}'::jsonb,
  true, now(), now()
)
ON CONFLICT (slug) DO NOTHING;

-- 2. Insert demo course (skip if slug already exists)
INSERT INTO public.courses (
  title, description, slug, status, price, template_id, curriculum, subject, template_data
)
SELECT
  'Demo Course',
  'Try the full Learn experience: Udemy-style overview, sidebar, interactive lessons with steps and quiz, and the AI tutor.',
  'demo-course',
  'published',
  0,
  ct.id,
  'General',
  'Math',
  '{"learningOutcomes":["Understand linear equations","Read graphs and slope","Practice with quizzes"]}'::jsonb
FROM public.courses_templates ct
WHERE ct.slug = 'lms-interactive'
LIMIT 1
ON CONFLICT (slug) DO NOTHING;

-- 3. Unit for demo course
INSERT INTO public.courses_units (course_id, unit_name, unit_order, description)
SELECT c.id, 'Unit 1: Algebra Basics', 1, 'Foundations of algebra'
FROM public.courses c
WHERE c.slug = 'demo-course'
  AND NOT EXISTS (SELECT 1 FROM public.courses_units u WHERE u.course_id = c.id)
LIMIT 1;

-- 4. Chapter
INSERT INTO public.courses_chapters (unit_id, chapter_name, chapter_order, description)
SELECT u.id, 'Chapter 1: Equations & Graphs', 1, 'Linear equations and slope'
FROM public.courses_units u
JOIN public.courses c ON c.id = u.course_id AND c.slug = 'demo-course'
WHERE NOT EXISTS (SELECT 1 FROM public.courses_chapters ch WHERE ch.unit_id = u.id)
LIMIT 1;

-- 5. Lessons (welcome, linear-equations interactive, slope-and-graphs)
INSERT INTO public.courses_lessons (title, slug, lesson_order, course_id, chapter_id, is_preview, lesson_type, content)
SELECT 'Welcome', 'welcome', 1, c.id, ch.id, true, 'video', 'Welcome to the demo course. This lesson is a placeholder for video content.'
FROM public.courses c
JOIN public.courses_units u ON u.course_id = c.id AND c.slug = 'demo-course'
JOIN public.courses_chapters ch ON ch.unit_id = u.id
WHERE NOT EXISTS (SELECT 1 FROM public.courses_lessons l WHERE l.course_id = c.id AND l.slug = 'welcome')
LIMIT 1;

INSERT INTO public.courses_lessons (title, slug, lesson_order, course_id, chapter_id, is_preview, lesson_type, content)
SELECT 'Linear Equations', 'linear-equations', 2, c.id, ch.id, false, 'interactive', 'Interactive lesson with steps and quiz.'
FROM public.courses c
JOIN public.courses_units u ON u.course_id = c.id AND c.slug = 'demo-course'
JOIN public.courses_chapters ch ON ch.unit_id = u.id
WHERE NOT EXISTS (SELECT 1 FROM public.courses_lessons l WHERE l.course_id = c.id AND l.slug = 'linear-equations')
LIMIT 1;

INSERT INTO public.courses_lessons (title, slug, lesson_order, course_id, chapter_id, is_preview, lesson_type, content)
SELECT 'Slope & Graphs', 'slope-and-graphs', 3, c.id, ch.id, false, 'video', 'Slope measures rise over run. Placeholder for video.'
FROM public.courses c
JOIN public.courses_units u ON u.course_id = c.id AND c.slug = 'demo-course'
JOIN public.courses_chapters ch ON ch.unit_id = u.id
WHERE NOT EXISTS (SELECT 1 FROM public.courses_lessons l WHERE l.course_id = c.id AND l.slug = 'slope-and-graphs')
LIMIT 1;

-- 6. Interactive content for "Linear Equations" lesson
INSERT INTO public.lesson_interactive_content (lesson_id, intro, steps, quiz)
SELECT
  l.id,
  'A linear equation forms a straight line when graphed. It has the form ax + b = c.',
  '[
    {"title": "What is a Linear Equation?", "content": "A linear equation contains a variable (like x) raised to the power of 1. Example: 2x + 3 = 11", "visual": "equation", "equation": "2x + 3 = 11"},
    {"title": "Step 1: Isolate the variable term", "content": "Subtract 3 from both sides to move the constant to the right.", "visual": "equation", "equation": "2x = 8", "highlight": "subtract 3"},
    {"title": "Step 2: Solve for x", "content": "Divide both sides by 2 to get x alone.", "visual": "equation", "equation": "x = 4", "highlight": "divide by 2"}
  ]'::jsonb,
  '[
    {"question": "Solve: 3x + 5 = 20", "options": ["x = 4", "x = 5", "x = 3", "x = 6"], "answer": 1, "explanation": "Subtract 5 from both sides: 3x = 15. Then divide by 3: x = 5."},
    {"question": "Which step comes first when solving 4x - 8 = 12?", "options": ["Divide by 4", "Add 8 to both sides", "Subtract 4", "Multiply by 4"], "answer": 1, "explanation": "Always move constants first by adding 8: 4x = 20, then divide."},
    {"question": "Solve: x/2 + 1 = 6", "options": ["x = 5", "x = 10", "x = 7", "x = 14"], "answer": 1, "explanation": "Subtract 1: x/2 = 5. Multiply by 2: x = 10."}
  ]'::jsonb
FROM public.courses_lessons l
JOIN public.courses c ON c.id = l.course_id AND c.slug = 'demo-course'
WHERE l.slug = 'linear-equations'
  AND NOT EXISTS (SELECT 1 FROM public.lesson_interactive_content lic WHERE lic.lesson_id = l.id)
LIMIT 1;

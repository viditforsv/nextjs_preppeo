-- Seed LMS Interactive course template
-- Courses with this template_id use /learn/[courseSlug] and /learn/.../lesson/...

INSERT INTO public.courses_templates (
  id,
  name,
  slug,
  description,
  curriculum,
  subject,
  grade,
  level,
  structure,
  fields,
  settings,
  is_active,
  created_at,
  updated_at
) VALUES (
  gen_random_uuid(),
  'LMS Interactive',
  'lms-interactive',
  'Full LMS experience: Udemy-style overview, sidebar, video/PDF/interactive lessons, AI chatbot, and quizzes.',
  'General',
  'General',
  NULL,
  NULL,
  '{"sections":[{"id":"overview","title":"Overview","type":"overview","fields":["description","learningOutcomes"]},{"id":"content","title":"Content","type":"lessons","fields":["units","chapters","lessons"]}]}'::jsonb,
  '[]'::jsonb,
  '{"rendering":{"sidebarStructure":"units-chapters-lessons","showTopicNumber":true},"lessonContent":{"supportedTypes":["video","interactive"],"tabOrder":["video","notes","quiz"]},"ui":{"showProgress":true,"showEnrollment":true},"behavior":{"showPreview":true}}'::jsonb,
  true,
  now(),
  now()
)
ON CONFLICT (slug) DO NOTHING;

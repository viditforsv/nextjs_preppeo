-- ════════════════════════════════════════════════════════════════════════
-- SAT Self-Learn — standalone, decoupled from the generic `courses` system.
-- Powers /sat/learn (Udemy-style). TWO separate courses: Math and English.
--
-- Hierarchy:  Course → Topic → Item (video / reading / flashcard / quiz / pdf)
--
-- Quizzes do NOT store questions — they reference the existing sat_questions
-- practice pool (set_number=0, module_number=0) via a JSON filter.
--
-- ACCESS MODEL: RLS enabled with NO public policies (qotd_leads pattern).
-- All reads/writes flow through service-role server routes, which enforce
-- gating (admin || item.is_free_preview || active per-course enrollment) and
-- strip paid fields (video_url / body / pdf_url) for non-entitled users
-- before anything reaches the client. The service role bypasses RLS.
--
-- Enrollment is PER COURSE — a student can own Math, English, or both.
--
-- Prereq: none (gen_random_uuid + auth.users already present).
-- Target: dev branch (dxhxpfouzjlzpeazwrqo) first, per project workflow.
-- ════════════════════════════════════════════════════════════════════════

-- ── Courses (two products: Math, English) ───────────────────────────────
CREATE TABLE IF NOT EXISTS public.sat_learn_courses (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title         text NOT NULL,
  slug          text NOT NULL UNIQUE,
  subject       text NOT NULL CHECK (subject IN ('math', 'english')),
  tagline       text,
  description   text,
  price_inr     int,                          -- nullable; checkout wired later
  price_usd     int,
  sort_order    int  NOT NULL DEFAULT 0,
  is_published  boolean NOT NULL DEFAULT false,
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now()
);

-- ── Topics (curriculum sections within a course) ────────────────────────
CREATE TABLE IF NOT EXISTS public.sat_learn_topics (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id     uuid NOT NULL REFERENCES public.sat_learn_courses(id) ON DELETE CASCADE,
  title         text NOT NULL,
  slug          text NOT NULL,
  domain        text,                          -- optional SAT domain key
  description   text,
  icon          text,                          -- lucide icon name (UI hint)
  sort_order    int  NOT NULL DEFAULT 0,
  is_published  boolean NOT NULL DEFAULT false,
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now(),
  UNIQUE (course_id, slug)
);

CREATE INDEX IF NOT EXISTS sat_learn_topics_course_idx
  ON public.sat_learn_topics (course_id, sort_order);

-- ── Content items within a topic ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.sat_learn_items (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  topic_id         uuid NOT NULL REFERENCES public.sat_learn_topics(id) ON DELETE CASCADE,
  title            text NOT NULL,
  slug             text NOT NULL,
  type             text NOT NULL CHECK (type IN ('video', 'reading', 'flashcard', 'quiz', 'pdf')),
  sort_order       int  NOT NULL DEFAULT 0,
  is_free_preview  boolean NOT NULL DEFAULT false,
  is_published     boolean NOT NULL DEFAULT false,
  -- video (Bunny CDN)
  video_url        text,                        -- Bunny embed / playback URL
  video_provider   text DEFAULT 'bunny',
  duration_seconds int,
  -- reading
  body             text,                        -- markdown / rich text
  -- pdf
  pdf_url          text,
  -- quiz: filter into sat_questions practice pool
  quiz_config      jsonb,                       -- { section, domains[], subtopics[], difficulty, count }
  created_at       timestamptz NOT NULL DEFAULT now(),
  updated_at       timestamptz NOT NULL DEFAULT now(),
  UNIQUE (topic_id, slug)
);

CREATE INDEX IF NOT EXISTS sat_learn_items_topic_idx
  ON public.sat_learn_items (topic_id, sort_order);

-- ── Flashcards (English + Quant) ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.sat_learn_flashcards (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id     uuid REFERENCES public.sat_learn_items(id) ON DELETE CASCADE,
  topic_id    uuid REFERENCES public.sat_learn_topics(id) ON DELETE CASCADE,
  section     text NOT NULL CHECK (section IN ('math', 'english')),
  front       text NOT NULL,
  back        text NOT NULL,
  sort_order  int  NOT NULL DEFAULT 0,
  created_at  timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS sat_learn_flashcards_item_idx
  ON public.sat_learn_flashcards (item_id, sort_order);

-- ── Enrollments (per course) ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.sat_learn_enrollments (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  course_id   uuid NOT NULL REFERENCES public.sat_learn_courses(id) ON DELETE CASCADE,
  source      text NOT NULL DEFAULT 'manual',  -- 'purchase' | 'manual' | 'trial'
  granted_at  timestamptz NOT NULL DEFAULT now(),
  expires_at  timestamptz,                      -- NULL = lifetime
  UNIQUE (user_id, course_id)
);

-- ── Per-user item completion ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.sat_learn_progress (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  item_id       uuid NOT NULL REFERENCES public.sat_learn_items(id) ON DELETE CASCADE,
  completed_at  timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, item_id)
);

CREATE INDEX IF NOT EXISTS sat_learn_progress_user_idx
  ON public.sat_learn_progress (user_id);

-- ── RLS: enabled, no public policies (service role only) ─────────────────
ALTER TABLE public.sat_learn_courses      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_topics       ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_items        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_flashcards   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_enrollments  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_progress     ENABLE ROW LEVEL SECURITY;

-- ════════════════════════════════════════════════════════════════════════
-- SEED — 2 courses (Math + English) and 1 published Math topic with one
-- item of each type so the UI has something to render during QC.
-- English course is published but has no topics yet (coming soon).
-- ════════════════════════════════════════════════════════════════════════
INSERT INTO public.sat_learn_courses (title, slug, subject, tagline, description, sort_order, is_published)
VALUES
  ('SAT Math — Self-Paced', 'sat-math', 'math',
   'Master Digital SAT Quant, topic by topic',
   'A complete, self-paced SAT Math course: concept videos, written notes, flashcards, and quizzes drawn from our live question bank.',
   1, true),
  ('SAT English — Self-Paced', 'sat-english', 'english',
   'Reading & Writing, demystified',
   'A complete, self-paced SAT Reading & Writing course. Coming soon.',
   2, true)
ON CONFLICT (slug) DO NOTHING;

-- One Math topic: "Linear Equations"
WITH math_course AS (
  SELECT id FROM public.sat_learn_courses WHERE slug = 'sat-math'
),
topic AS (
  INSERT INTO public.sat_learn_topics (course_id, title, slug, domain, description, icon, sort_order, is_published)
  SELECT id, 'Linear Equations', 'linear-equations', 'algebra',
         'Slopes, intercepts, and solving linear equations — the backbone of SAT Algebra.',
         'Variable', 1, true
  FROM math_course
  ON CONFLICT (course_id, slug) DO NOTHING
  RETURNING id
)
INSERT INTO public.sat_learn_items
  (topic_id, title, slug, type, sort_order, is_free_preview, is_published,
   video_url, duration_seconds, body, pdf_url, quiz_config)
SELECT t.id, v.title, v.slug, v.type, v.sort_order, v.is_free_preview, true,
       v.video_url, v.duration_seconds, v.body, v.pdf_url, v.quiz_config
FROM topic t
CROSS JOIN (VALUES
  -- (title, slug, type, sort_order, is_free_preview, video_url, duration, body, pdf_url, quiz_config)
  ('Intro to Linear Equations', 'intro-video', 'video', 1, true,
   'https://iframe.mediadelivery.net/embed/REPLACE_LIBRARY/REPLACE_VIDEO_GUID', 540,
   NULL::text, NULL::text, NULL::jsonb),
  ('Slope & Intercept — Notes', 'slope-intercept-notes', 'reading', 2, true,
   NULL::text, NULL::int,
   E'## Slope & Intercept\n\nThe slope-intercept form is **y = mx + b**, where *m* is the slope and *b* is the y-intercept.\n\n- **Slope** = rise / run = (y₂ − y₁) / (x₂ − x₁)\n- **Parallel lines** share the same slope.\n- **Perpendicular lines** have slopes that multiply to −1.',
   NULL::text, NULL::jsonb),
  ('Key Formulas (PDF)', 'linear-formulas-pdf', 'pdf', 3, false,
   NULL::text, NULL::int, NULL::text,
   'https://REPLACE_BUNNY_PULL_ZONE/sat-learn/linear-equations-formulas.pdf', NULL::jsonb),
  ('Linear Equations Flashcards', 'linear-flashcards', 'flashcard', 4, false,
   NULL::text, NULL::int, NULL::text, NULL::text, NULL::jsonb),
  ('Practice Quiz — Linear Equations', 'linear-quiz', 'quiz', 5, false,
   NULL::text, NULL::int, NULL::text, NULL::text,
   '{"section":"math","domains":["algebra"],"subtopics":[],"difficulty":"mixed","count":10}'::jsonb)
) AS v(title, slug, type, sort_order, is_free_preview, video_url, duration_seconds, body, pdf_url, quiz_config);

-- Flashcards for the flashcard item above
WITH fc_item AS (
  SELECT i.id, i.topic_id
  FROM public.sat_learn_items i
  JOIN public.sat_learn_topics t ON t.id = i.topic_id
  JOIN public.sat_learn_courses c ON c.id = t.course_id
  WHERE c.slug = 'sat-math' AND t.slug = 'linear-equations' AND i.slug = 'linear-flashcards'
)
INSERT INTO public.sat_learn_flashcards (item_id, topic_id, section, front, back, sort_order)
SELECT fc_item.id, fc_item.topic_id, 'math', f.front, f.back, f.sort_order
FROM fc_item
CROSS JOIN (VALUES
  ('Slope-intercept form', 'y = mx + b  (m = slope, b = y-intercept)', 1),
  ('Slope formula', 'm = (y₂ − y₁) / (x₂ − x₁)', 2),
  ('Parallel lines', 'Equal slopes: m₁ = m₂', 3),
  ('Perpendicular lines', 'Slopes multiply to −1: m₁ · m₂ = −1', 4),
  ('Point-slope form', 'y − y₁ = m(x − x₁)', 5)
) AS f(front, back, sort_order);

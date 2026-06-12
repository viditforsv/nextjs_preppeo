-- ════════════════════════════════════════════════════════════════════════
-- PROD PROMOTION (applied to prod ootnqmojcqnzfrtvzzec on 2026-06-12)
--
-- Promotes the SAT Self-Learn + community tracked-links features from the
-- dev branch to prod, ahead of the dev→main code deploy.
--
-- TWO parts:
--   1. SCHEMA (this file) — applied via Supabase apply_migration as
--      `prod_promote_sat_learn_and_tracked_links_schema`. DDL only.
--   2. DATA — content rows (2 courses, 18 topics, 85 items, 80 flashcards,
--      65 quiz questions) were copied from the QC'd dev branch preserving
--      IDs (dev had seeded them out-of-band, not via tracked migrations).
--      All topics ship UNPUBLISHED ("coming soon") — matches dev's live
--      state; videos not ready yet. User tables (enrollments/progress) and
--      the empty tracked_links table were intentionally not copied.
--
-- Mirrors dev migrations: create_sat_learn, sat_learn_quiz_questions,
-- create_tracked_links. RLS enabled on every table, no public policies
-- (service-role only).
-- ════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.sat_learn_courses (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title         text NOT NULL,
  slug          text NOT NULL UNIQUE,
  subject       text NOT NULL CHECK (subject IN ('math', 'english')),
  tagline       text,
  description   text,
  price_inr     int,
  price_usd     int,
  sort_order    int  NOT NULL DEFAULT 0,
  is_published  boolean NOT NULL DEFAULT false,
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.sat_learn_topics (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id     uuid NOT NULL REFERENCES public.sat_learn_courses(id) ON DELETE CASCADE,
  title         text NOT NULL,
  slug          text NOT NULL,
  domain        text,
  description   text,
  icon          text,
  sort_order    int  NOT NULL DEFAULT 0,
  is_published  boolean NOT NULL DEFAULT false,
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now(),
  UNIQUE (course_id, slug)
);
CREATE INDEX IF NOT EXISTS sat_learn_topics_course_idx
  ON public.sat_learn_topics (course_id, sort_order);

CREATE TABLE IF NOT EXISTS public.sat_learn_items (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  topic_id         uuid NOT NULL REFERENCES public.sat_learn_topics(id) ON DELETE CASCADE,
  title            text NOT NULL,
  slug             text NOT NULL,
  type             text NOT NULL CHECK (type IN ('video', 'reading', 'flashcard', 'quiz', 'pdf')),
  sort_order       int  NOT NULL DEFAULT 0,
  is_free_preview  boolean NOT NULL DEFAULT false,
  is_published     boolean NOT NULL DEFAULT false,
  video_url        text,
  video_provider   text DEFAULT 'bunny',
  duration_seconds int,
  body             text,
  pdf_url          text,
  quiz_config      jsonb,
  created_at       timestamptz NOT NULL DEFAULT now(),
  updated_at       timestamptz NOT NULL DEFAULT now(),
  UNIQUE (topic_id, slug)
);
CREATE INDEX IF NOT EXISTS sat_learn_items_topic_idx
  ON public.sat_learn_items (topic_id, sort_order);

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

CREATE TABLE IF NOT EXISTS public.sat_learn_enrollments (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  course_id   uuid NOT NULL REFERENCES public.sat_learn_courses(id) ON DELETE CASCADE,
  source      text NOT NULL DEFAULT 'manual',
  granted_at  timestamptz NOT NULL DEFAULT now(),
  expires_at  timestamptz,
  UNIQUE (user_id, course_id)
);

CREATE TABLE IF NOT EXISTS public.sat_learn_progress (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  item_id       uuid NOT NULL REFERENCES public.sat_learn_items(id) ON DELETE CASCADE,
  completed_at  timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, item_id)
);
CREATE INDEX IF NOT EXISTS sat_learn_progress_user_idx
  ON public.sat_learn_progress (user_id);

CREATE TABLE IF NOT EXISTS public.sat_learn_quiz_questions (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         uuid NOT NULL REFERENCES public.sat_learn_items(id) ON DELETE CASCADE,
  question        text NOT NULL,
  options         jsonb NOT NULL,
  correct_answer  text NOT NULL,
  explanation     text,
  sort_order      int  NOT NULL DEFAULT 0,
  created_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS sat_learn_quiz_questions_item_idx
  ON public.sat_learn_quiz_questions (item_id, sort_order);

ALTER TABLE public.sat_learn_courses        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_topics         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_items          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_flashcards     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_enrollments    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_progress       ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sat_learn_quiz_questions ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.tracked_links (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text NOT NULL UNIQUE,
  destination_key text NOT NULL,
  destination_path text NOT NULL,
  source text NOT NULL,
  label text NOT NULL DEFAULT '',
  campaign text NOT NULL DEFAULT '',
  click_count integer NOT NULL DEFAULT 0,
  last_clicked_at timestamptz,
  created_by text NOT NULL DEFAULT 'va',
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.link_signups (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  link_slug text NOT NULL,
  user_id uuid NOT NULL UNIQUE,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_link_signups_slug ON public.link_signups (link_slug);

ALTER TABLE public.tracked_links ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.link_signups  ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION public.increment_link_click(p_slug text)
RETURNS void
LANGUAGE sql
SECURITY DEFINER
SET search_path TO 'public', 'pg_temp'
AS $$
  UPDATE public.tracked_links
  SET click_count = click_count + 1,
      last_clicked_at = now()
  WHERE slug = p_slug;
$$;

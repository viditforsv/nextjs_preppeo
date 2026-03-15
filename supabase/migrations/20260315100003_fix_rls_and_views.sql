-- Fix: auth_users_exposed, policy_exists_rls_disabled, security_definer_view, rls_disabled_in_public
--
-- SAFETY NOTES:
-- * Tables only accessed via service role (roles, permissions, courses_topics, lesson_tags)
--   bypass RLS entirely, so enabling RLS has zero effect on current app behavior.
-- * Tables with existing correct policies (profiles, courses_enrollments, courses_lessons)
--   just need RLS turned on to activate the policies already in place.
-- * Tables needing new policies (courses_chapters, courses_units, courses_templates,
--   courses_topics, lesson_tags) get public read + admin write — matching existing
--   route-level checkAdminAccess() checks.
-- * Views set to security_invoker so RLS of underlying tables is respected.

-- ============================================================
-- PART 1: Fix security_definer_view (3 views)
-- ============================================================
ALTER VIEW public.user_complete_data SET (security_invoker = on);
ALTER VIEW public.payment_analytics SET (security_invoker = on);
ALTER VIEW public.question_bank_enhanced SET (security_invoker = on);

-- user_complete_data exposes auth.users — revoke anon access
REVOKE ALL ON public.user_complete_data FROM anon;

-- ============================================================
-- PART 2: Enable RLS on tables that already have correct policies
-- ============================================================
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.courses_enrollments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.courses_lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.permissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.roles ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- PART 3: courses_templates — add admin write policy, then enable RLS
-- (already has "Public read access on course_templates" for SELECT)
-- ============================================================
CREATE POLICY "Admin manage course_templates"
  ON public.courses_templates
  FOR ALL
  TO authenticated
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'))
  WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

ALTER TABLE public.courses_templates ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- PART 4: courses_chapters — new policies + enable RLS
-- ============================================================
CREATE POLICY "Public read access on chapters"
  ON public.courses_chapters
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Admin manage chapters"
  ON public.courses_chapters
  FOR ALL
  TO authenticated
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'))
  WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

ALTER TABLE public.courses_chapters ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- PART 5: courses_units — new policies + enable RLS
-- ============================================================
CREATE POLICY "Public read access on units"
  ON public.courses_units
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Admin manage units"
  ON public.courses_units
  FOR ALL
  TO authenticated
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'))
  WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

ALTER TABLE public.courses_units ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- PART 6: courses_topics — new policies + enable RLS
-- (only accessed via service role currently)
-- ============================================================
CREATE POLICY "Public read access on topics"
  ON public.courses_topics
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Admin manage topics"
  ON public.courses_topics
  FOR ALL
  TO authenticated
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'))
  WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

ALTER TABLE public.courses_topics ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- PART 7: lesson_tags — new policies + enable RLS
-- (only accessed via service role currently)
-- ============================================================
CREATE POLICY "Public read access on lesson_tags"
  ON public.lesson_tags
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Admin manage lesson_tags"
  ON public.lesson_tags
  FOR ALL
  TO authenticated
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'))
  WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

ALTER TABLE public.lesson_tags ENABLE ROW LEVEL SECURITY;

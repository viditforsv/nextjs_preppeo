-- Create a parallel SAT Quant course for the Learn (LMS Interactive) experience.
-- Original SAT Quant (a0129fd3-2487-47d9-94c7-1e07ddd514a9) is unchanged and stays at /courses/sat-quant.
-- New course is at /learn/sat-quant-learn with the same structure and content (video/pdf URLs).

-- Temp tables for old_id -> new_id mapping (created and dropped in same transaction)
CREATE TEMP TABLE IF NOT EXISTS _unit_map (old_id uuid PRIMARY KEY, new_id uuid);
CREATE TEMP TABLE IF NOT EXISTS _chapter_map (old_id uuid PRIMARY KEY, new_id uuid);
CREATE TEMP TABLE IF NOT EXISTS _topic_map (old_id uuid PRIMARY KEY, new_id uuid);

DO $$
DECLARE
  old_course_id uuid := 'a0129fd3-2487-47d9-94c7-1e07ddd514a9';
  new_course_id uuid;
  tpl_id uuid;
  r record;
  new_unit_id uuid;
  new_chapter_id uuid;
  new_topic_id uuid;
  lesson_slug text;
BEGIN
  TRUNCATE _unit_map;
  TRUNCATE _chapter_map;
  TRUNCATE _topic_map;

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

  SELECT id INTO tpl_id FROM public.courses_templates WHERE slug = 'lms-interactive' LIMIT 1;

  -- 2. Idempotent: skip if parallel course already has content
  SELECT id INTO new_course_id FROM public.courses WHERE slug = 'sat-quant-learn' LIMIT 1;
  IF new_course_id IS NOT NULL AND EXISTS (SELECT 1 FROM public.courses_units WHERE course_id = new_course_id LIMIT 1) THEN
    RAISE NOTICE 'Parallel course sat-quant-learn already exists with content; skipping.';
    RETURN;
  END IF;

  -- 3. Create new course if not present
  IF new_course_id IS NULL THEN
    INSERT INTO public.courses (
      title, description, slug, status, price, template_id, curriculum, subject, grade, level,
      duration, validity_days, thumbnail_url, instructor_id, created_at, updated_at
    )
    SELECT
      title || ' (Learn)', description, 'sat-quant-learn', status, price, tpl_id, curriculum, subject, grade, level,
      duration, validity_days, thumbnail_url, instructor_id, created_at, updated_at
    FROM public.courses
    WHERE id = old_course_id
    ON CONFLICT (slug) DO NOTHING;
    SELECT id INTO new_course_id FROM public.courses WHERE slug = 'sat-quant-learn' LIMIT 1;
    IF new_course_id IS NULL THEN
      RAISE EXCEPTION 'Failed to create course sat-quant-learn';
    END IF;
  END IF;

  -- 3. Copy units and build mapping (old unit id -> new unit id)
  FOR r IN
    SELECT id, unit_name, unit_order, description, is_locked
    FROM public.courses_units
    WHERE course_id = old_course_id
    ORDER BY unit_order
  LOOP
    INSERT INTO public.courses_units (course_id, unit_name, unit_order, description, is_locked)
    VALUES (new_course_id, r.unit_name, r.unit_order, r.description, COALESCE(r.is_locked, false))
    RETURNING id INTO new_unit_id;
    INSERT INTO _unit_map (old_id, new_id) VALUES (r.id, new_unit_id);
  END LOOP;

  -- 4. Copy chapters
  FOR r IN
    SELECT c.id, c.unit_id, c.chapter_name, c.chapter_order, c.description, c.is_locked
    FROM public.courses_chapters c
    JOIN public.courses_units u ON u.id = c.unit_id AND u.course_id = old_course_id
    ORDER BY c.unit_id, c.chapter_order
  LOOP
    SELECT m.new_id INTO new_unit_id FROM _unit_map m WHERE m.old_id = r.unit_id;
    INSERT INTO public.courses_chapters (unit_id, chapter_name, chapter_order, description, is_locked)
    VALUES (new_unit_id, r.chapter_name, r.chapter_order, r.description, COALESCE(r.is_locked, false))
    RETURNING id INTO new_chapter_id;
    INSERT INTO _chapter_map (old_id, new_id) VALUES (r.id, new_chapter_id);
  END LOOP;

  -- 5. Copy topics
  FOR r IN
    SELECT t.id, t.chapter_id, t.topic_name, t.topic_number, t.topic_order, t.description
    FROM public.courses_topics t
    JOIN public.courses_chapters c ON c.id = t.chapter_id
    JOIN public.courses_units u ON u.id = c.unit_id AND u.course_id = old_course_id
    ORDER BY t.chapter_id, t.topic_order
  LOOP
    SELECT m.new_id INTO new_chapter_id FROM _chapter_map m WHERE m.old_id = r.chapter_id;
    INSERT INTO public.courses_topics (chapter_id, topic_name, topic_number, topic_order, description)
    VALUES (new_chapter_id, r.topic_name, r.topic_number, r.topic_order, r.description)
    RETURNING id INTO new_topic_id;
    INSERT INTO _topic_map (old_id, new_id) VALUES (r.id, new_topic_id);
  END LOOP;

  -- 6. Copy lessons (new slug to avoid unique violation)
  FOR r IN
    SELECT l.id, l.title, l.slug, l.lesson_order, l.chapter_id, l.topic_id, l.is_preview, l.content,
           l.video_url, l.video_thumbnail_url, l.pdf_url, l.solution_url, l.topic_badge, l.topic_number,
           l.lesson_code, l.concept_title, l.concept_content, l.formula_title, l.formula_content
    FROM public.courses_lessons l
    WHERE l.course_id = old_course_id
    ORDER BY l.lesson_order NULLS LAST, l.id
  LOOP
    SELECT m.new_id INTO new_chapter_id FROM _chapter_map m WHERE m.old_id = r.chapter_id;
    new_topic_id := NULL;
    IF r.topic_id IS NOT NULL THEN
      SELECT m.new_id INTO new_topic_id FROM _topic_map m WHERE m.old_id = r.topic_id;
    END IF;
    lesson_slug := 'sat-quant-learn-' || COALESCE(NULLIF(trim(r.slug), ''), r.id::text);
    INSERT INTO public.courses_lessons (
      title, slug, lesson_order, course_id, chapter_id, topic_id, is_preview, content,
      video_url, video_thumbnail_url, pdf_url, solution_url, topic_badge, topic_number,
      lesson_code, concept_title, concept_content, formula_title, formula_content,
      lesson_type
    )
    VALUES (
      r.title, lesson_slug, r.lesson_order, new_course_id, new_chapter_id, new_topic_id, COALESCE(r.is_preview, false), r.content,
      r.video_url, r.video_thumbnail_url, r.pdf_url, r.solution_url, r.topic_badge, r.topic_number,
      r.lesson_code, r.concept_title, r.concept_content, r.formula_title, r.formula_content,
      CASE
        WHEN r.video_url IS NOT NULL AND trim(r.video_url) != '' THEN 'video'
        WHEN r.pdf_url IS NOT NULL AND trim(r.pdf_url) != '' THEN 'pdf'
        ELSE 'video'
      END
    );
  END LOOP;

  -- Update course_id on new chapters/topics when column exists
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'courses_chapters' AND column_name = 'course_id') THEN
    UPDATE public.courses_chapters SET course_id = new_course_id
    WHERE unit_id IN (SELECT new_id FROM _unit_map);
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'courses_topics' AND column_name = 'course_id') THEN
    UPDATE public.courses_topics SET course_id = new_course_id
    WHERE chapter_id IN (SELECT new_id FROM _chapter_map);
  END IF;

  RAISE NOTICE 'Parallel course sat-quant-learn created successfully. Access at /learn/sat-quant-learn';
END $$;

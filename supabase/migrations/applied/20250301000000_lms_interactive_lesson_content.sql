-- LMS Interactive: lesson_interactive_content table and optional lesson_type
-- For /learn/ template: steps + quiz JSON for interactive lessons

-- Optional: add lesson_type to courses_lessons (video | pdf | interactive)
ALTER TABLE public.courses_lessons
  ADD COLUMN IF NOT EXISTS lesson_type text DEFAULT 'video'
  CHECK (lesson_type IS NULL OR lesson_type IN ('video', 'pdf', 'interactive'));

COMMENT ON COLUMN public.courses_lessons.lesson_type IS 'For LMS Interactive template: video, pdf, or interactive (steps+quiz)';

-- Table: lesson_interactive_content (one row per interactive lesson)
CREATE TABLE IF NOT EXISTS public.lesson_interactive_content (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  lesson_id uuid NOT NULL,
  intro text,
  steps jsonb NOT NULL DEFAULT '[]'::jsonb,
  quiz jsonb NOT NULL DEFAULT '[]'::jsonb,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  CONSTRAINT lesson_interactive_content_pkey PRIMARY KEY (id),
  CONSTRAINT lesson_interactive_content_lesson_id_fkey
    FOREIGN KEY (lesson_id) REFERENCES public.courses_lessons(id) ON DELETE CASCADE,
  CONSTRAINT lesson_interactive_content_lesson_id_unique UNIQUE (lesson_id)
);

COMMENT ON TABLE public.lesson_interactive_content IS 'Steps and inline quiz for LMS Interactive lesson type';
COMMENT ON COLUMN public.lesson_interactive_content.steps IS 'Array of { title, content, visual?, equation?, highlight? }';
COMMENT ON COLUMN public.lesson_interactive_content.quiz IS 'Array of { question, options[], answer (index), explanation }';

CREATE INDEX IF NOT EXISTS idx_lesson_interactive_content_lesson_id
  ON public.lesson_interactive_content(lesson_id);

ALTER TABLE public.lesson_interactive_content ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow read for authenticated"
  ON public.lesson_interactive_content FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Allow all for service role"
  ON public.lesson_interactive_content FOR ALL
  TO service_role
  USING (true);

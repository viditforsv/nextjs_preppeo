-- Create student_performance_log if it does not exist (table was never in repo migrations).
-- Then ensure skipped column exists for tracking skipped questions.

CREATE TABLE IF NOT EXISTS public.student_performance_log (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  student_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  question_id uuid NOT NULL REFERENCES public.question_bank(id) ON DELETE CASCADE,
  lesson_id uuid,
  course_id uuid,
  attempt_number integer NOT NULL DEFAULT 1,
  time_taken_seconds integer NOT NULL DEFAULT 0,
  is_correct boolean NOT NULL,
  skipped boolean NOT NULL DEFAULT false,
  difficulty_level integer,
  hint_used boolean NOT NULL DEFAULT false,
  session_id text,
  session_order integer,
  tags text[] DEFAULT '{}'::text[],
  created_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT student_performance_log_pkey PRIMARY KEY (id)
);

COMMENT ON TABLE public.student_performance_log IS 'Tracks every question attempt for student progress and analytics';
COMMENT ON COLUMN public.student_performance_log.skipped IS 'True when user skipped the question without answering; is_correct should be false.';

-- If table already existed without skipped, add it
ALTER TABLE public.student_performance_log
  ADD COLUMN IF NOT EXISTS skipped boolean NOT NULL DEFAULT false;

CREATE INDEX IF NOT EXISTS idx_student_performance_log_student_id
  ON public.student_performance_log(student_id);
CREATE INDEX IF NOT EXISTS idx_student_performance_log_question_id
  ON public.student_performance_log(question_id);
CREATE INDEX IF NOT EXISTS idx_student_performance_log_lesson_id
  ON public.student_performance_log(lesson_id);
CREATE INDEX IF NOT EXISTS idx_student_performance_log_created_at
  ON public.student_performance_log(created_at DESC);

ALTER TABLE public.student_performance_log ENABLE ROW LEVEL SECURITY;

-- Students can read/insert their own rows (drop first so migration is idempotent)
DROP POLICY IF EXISTS "Users can read own performance log" ON public.student_performance_log;
DROP POLICY IF EXISTS "Users can insert own performance log" ON public.student_performance_log;

CREATE POLICY "Users can read own performance log"
  ON public.student_performance_log FOR SELECT
  TO authenticated
  USING (auth.uid() = student_id);

CREATE POLICY "Users can insert own performance log"
  ON public.student_performance_log FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = student_id);

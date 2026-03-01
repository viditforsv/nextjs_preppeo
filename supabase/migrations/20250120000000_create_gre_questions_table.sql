-- ============================================================================
-- CREATE GRE QUESTIONS TABLE
-- This migration creates the gre_questions table that is referenced by
-- the study features migration (20251221153306_add_gre_study_features.sql)
-- ============================================================================

-- Create gre_questions table
CREATE TABLE IF NOT EXISTS public.gre_questions (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  type text NOT NULL CHECK (type = ANY (ARRAY['single-choice'::text, 'multi-select'::text, 'numeric-entry'::text, 'text-select'::text])),
  prompt text NOT NULL,
  passage_id uuid,
  options jsonb DEFAULT '[]'::jsonb,
  correct_answer text NOT NULL,
  section_type text NOT NULL CHECK (section_type = ANY (ARRAY['verbal'::text, 'quantitative'::text])),
  difficulty integer CHECK (difficulty >= 1 AND difficulty <= 10),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  created_by uuid,
  is_active boolean NOT NULL DEFAULT true,
  CONSTRAINT gre_questions_pkey PRIMARY KEY (id),
  CONSTRAINT gre_questions_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE SET NULL
);

COMMENT ON TABLE public.gre_questions IS 'GRE test questions for verbal and quantitative reasoning sections';
COMMENT ON COLUMN public.gre_questions.type IS 'Question type: single-choice, multi-select, numeric-entry, or text-select';
COMMENT ON COLUMN public.gre_questions.prompt IS 'Question text/prompt (supports HTML + LaTeX)';
COMMENT ON COLUMN public.gre_questions.passage_id IS 'Optional reference to a reading passage (for verbal questions)';
COMMENT ON COLUMN public.gre_questions.options IS 'JSONB array of answer options: [{"id": "a", "text": "Option A"}, ...]';
COMMENT ON COLUMN public.gre_questions.correct_answer IS 'Correct answer(s) - text for single, JSON array for multi-select';
COMMENT ON COLUMN public.gre_questions.section_type IS 'Section type: verbal or quantitative';
COMMENT ON COLUMN public.gre_questions.difficulty IS 'Difficulty rating from 1 (easy) to 10 (hard)';

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_gre_questions_section_type ON public.gre_questions(section_type);
CREATE INDEX IF NOT EXISTS idx_gre_questions_type ON public.gre_questions(type);
CREATE INDEX IF NOT EXISTS idx_gre_questions_difficulty ON public.gre_questions(difficulty);
CREATE INDEX IF NOT EXISTS idx_gre_questions_is_active ON public.gre_questions(is_active);
CREATE INDEX IF NOT EXISTS idx_gre_questions_created_at ON public.gre_questions(created_at DESC);

-- Create updated_at trigger
CREATE TRIGGER update_gre_questions_updated_at
  BEFORE UPDATE ON public.gre_questions
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Enable Row Level Security
ALTER TABLE public.gre_questions ENABLE ROW LEVEL SECURITY;

-- RLS Policies
-- Public read access to active questions
CREATE POLICY "Public can view active GRE questions"
  ON public.gre_questions FOR SELECT
  TO public
  USING (is_active = true);

-- Authenticated users can view all questions
CREATE POLICY "Authenticated users can view all GRE questions"
  ON public.gre_questions FOR SELECT
  TO authenticated
  USING (true);

-- Admins can manage all questions
CREATE POLICY "Admins can manage GRE questions"
  ON public.gre_questions FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );


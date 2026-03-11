-- ============================================================================
-- CREATE ASHOKA QUESTIONS TABLE + ACCESS CODES
-- Stores questions for the Ashoka Aptitude Test CBT.
-- ============================================================================

-- 1. ashoka_questions
CREATE TABLE IF NOT EXISTS public.ashoka_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL DEFAULT 'single-choice'
    CHECK (type IN ('single-choice')),
  section_type TEXT NOT NULL
    CHECK (section_type IN ('problem-solving', 'critical-thinking')),
  prompt TEXT NOT NULL,
  options JSONB NOT NULL DEFAULT '[]'::jsonb,
  correct_answer TEXT NOT NULL,
  explanation TEXT DEFAULT '',
  set_number INT NOT NULL DEFAULT 1,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMENT ON TABLE public.ashoka_questions IS 'Ashoka Aptitude Test questions for Problem Solving and Critical Thinking';
COMMENT ON COLUMN public.ashoka_questions.section_type IS 'problem-solving or critical-thinking';
COMMENT ON COLUMN public.ashoka_questions.options IS 'JSONB array: [{"id": "a", "text": "Option A"}, ...]';

CREATE INDEX idx_ashoka_questions_set ON public.ashoka_questions(set_number);
CREATE INDEX idx_ashoka_questions_section_type ON public.ashoka_questions(section_type);
CREATE INDEX idx_ashoka_questions_active ON public.ashoka_questions(is_active);

CREATE TRIGGER update_ashoka_questions_updated_at
  BEFORE UPDATE ON public.ashoka_questions
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

ALTER TABLE public.ashoka_questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can view active Ashoka questions"
  ON public.ashoka_questions FOR SELECT
  TO public
  USING (is_active = true);

CREATE POLICY "Admins can manage Ashoka questions"
  ON public.ashoka_questions FOR ALL
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

-- 2. ashoka_access_codes
CREATE TABLE IF NOT EXISTS public.ashoka_access_codes (
  code TEXT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT true,
  used_at TIMESTAMPTZ,
  set_number INT NOT NULL DEFAULT 1,
  created_at TIMESTAMPTZ DEFAULT now(),
  CONSTRAINT ashoka_access_codes_pkey PRIMARY KEY (code)
);

COMMENT ON TABLE public.ashoka_access_codes IS 'Access codes required to start Ashoka Test Mode';

ALTER TABLE public.ashoka_access_codes ENABLE ROW LEVEL SECURITY;

-- Seed a free access code for set 1
INSERT INTO public.ashoka_access_codes (code, set_number, is_active) VALUES
  ('ASHOKA-FREE-SET1', 1, true)
ON CONFLICT (code) DO NOTHING;

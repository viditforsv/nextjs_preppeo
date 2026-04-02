-- ============================================================================
-- ALTER GRE QUESTIONS TABLE — add columns for all question types & test sets
-- Also adds set_number to gre_access_codes for code-to-set mapping
-- ============================================================================

-- 1. New columns on gre_questions
ALTER TABLE public.gre_questions
  ADD COLUMN IF NOT EXISTS quantity_a text,
  ADD COLUMN IF NOT EXISTS quantity_b text,
  ADD COLUMN IF NOT EXISTS quantity_info text,
  ADD COLUMN IF NOT EXISTS explanation text,
  ADD COLUMN IF NOT EXISTS topics text[],
  ADD COLUMN IF NOT EXISTS difficulty_tier text,
  ADD COLUMN IF NOT EXISTS section_number smallint,
  ADD COLUMN IF NOT EXISTS set_number smallint;

-- 2. CHECK constraints
ALTER TABLE public.gre_questions
  ADD CONSTRAINT gre_questions_difficulty_tier_check
    CHECK (difficulty_tier IN ('easy', 'medium', 'hard'));

ALTER TABLE public.gre_questions
  ADD CONSTRAINT gre_questions_section_number_check
    CHECK (section_number IN (1, 2));

ALTER TABLE public.gre_questions
  ADD CONSTRAINT gre_questions_set_number_check
    CHECK (set_number >= 1);

-- 3. Update type CHECK to include quantitative-comparison
ALTER TABLE public.gre_questions DROP CONSTRAINT IF EXISTS gre_questions_type_check;
ALTER TABLE public.gre_questions
  ADD CONSTRAINT gre_questions_type_check
    CHECK (type = ANY (ARRAY[
      'single-choice'::text,
      'multi-select'::text,
      'numeric-entry'::text,
      'text-select'::text,
      'quantitative-comparison'::text
    ]));

-- 4. Composite index for efficient set lookups
CREATE INDEX IF NOT EXISTS idx_gre_questions_set_lookup
  ON public.gre_questions(section_number, difficulty_tier, set_number)
  WHERE is_active = true;

CREATE INDEX IF NOT EXISTS idx_gre_questions_topics
  ON public.gre_questions USING gin(topics)
  WHERE is_active = true;

-- 5. Add set_number to gre_access_codes
ALTER TABLE public.gre_access_codes
  ADD COLUMN IF NOT EXISTS set_number smallint;

COMMENT ON COLUMN public.gre_questions.quantity_a IS 'Quantity A for quantitative-comparison questions';
COMMENT ON COLUMN public.gre_questions.quantity_b IS 'Quantity B for quantitative-comparison questions';
COMMENT ON COLUMN public.gre_questions.quantity_info IS 'Shared info shown above both quantities in QC problems';
COMMENT ON COLUMN public.gre_questions.difficulty_tier IS 'Adaptive difficulty tier: easy, medium, hard';
COMMENT ON COLUMN public.gre_questions.section_number IS 'Which section this question belongs to (1 or 2)';
COMMENT ON COLUMN public.gre_questions.set_number IS 'Set grouping number within a section+difficulty combo';
COMMENT ON COLUMN public.gre_access_codes.set_number IS 'Maps this access code to a specific test set number';

-- Add optional image_url column for question diagrams/figures
ALTER TABLE public.gre_questions
  ADD COLUMN IF NOT EXISTS image_url text;

COMMENT ON COLUMN public.gre_questions.image_url IS 'Public URL of an image/diagram associated with this question (stored in Supabase Storage)';

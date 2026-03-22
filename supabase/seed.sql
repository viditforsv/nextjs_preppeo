-- Seed data for the DEV Supabase database.
-- Applied after migrations during `supabase db reset`.
-- Add essential reference/lookup data here so dev DB is usable immediately.

-- Example: ensure exam_types exist
INSERT INTO public.exam_types (id, name, total_sets)
VALUES
  ('sat', 'SAT', 3)
ON CONFLICT (id) DO NOTHING;

-- Add more seed data below as needed (courses, test users, etc.)

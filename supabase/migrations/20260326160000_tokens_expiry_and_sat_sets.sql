-- ============================================================
-- Token expiry + SAT set count correction
-- ============================================================

-- 1. Add expires_at to test_tokens
--    Free tokens: NULL (never expire)
--    Existing paid tokens: retroactively set to created_at + 6 months
--    New paid tokens: set at insert time in application code
ALTER TABLE test_tokens
  ADD COLUMN IF NOT EXISTS expires_at TIMESTAMPTZ;

UPDATE test_tokens
SET expires_at = created_at + INTERVAL '6 months'
WHERE is_free = false
  AND expires_at IS NULL;

-- 2. Update SAT total_sets from 1 → 3 (sets 1, 2, 3 are seeded)
UPDATE exam_types
SET total_sets = 3
WHERE id = 'sat';

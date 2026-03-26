-- Mark all curated test-set SAT questions as QC-approved.
-- Questions with set_number > 0 and module_number > 0 are deliberately placed
-- in mock test sets and are considered QC-approved for test delivery.
-- Fixes: RW M2 (all sets) and any remaining Math M2 gaps had qc_done = false
-- because the qc_done column was added after seeding with DEFAULT false.
UPDATE sat_questions
SET qc_done = true
WHERE set_number > 0
  AND module_number > 0
  AND is_active = true
  AND qc_done = false;

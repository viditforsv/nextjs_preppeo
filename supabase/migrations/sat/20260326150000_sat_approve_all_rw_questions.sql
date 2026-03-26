-- Mark all active RW questions as QC-approved.
-- RW questions were seeded from a curated question bank and are considered
-- approved for both practice and test delivery.
UPDATE sat_questions
SET qc_done = true
WHERE section = 'rw'
  AND is_active = true
  AND qc_done = false;

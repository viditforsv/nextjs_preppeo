-- Assign math practice questions to SAT mock sets 4 and 5.
-- Questions are pulled from the practice pool (set_number=0, module_number=0)
-- and assigned to their respective mock modules in order of id.
--
-- M1 template (22q): adv-math 1E+4M+2H, algebra 2E+4M+2H, geo 1E+2M+1H, ps 1E+2M
-- M2 Easy (22q):     adv-math 7(med), algebra 7(easy), geo 4(easy), ps 4(easy)
-- M2 Hard (22q):     adv-math 8(hard), algebra 7(hard), geo 4(hard), ps 3(hard)
--
-- NOTE: difficulty_tier on M2 rows indicates the adaptive track ('easy'/'hard'),
-- not the individual question difficulty — consistent with sets 1-3.

-- ================================================================
-- SET 4 — MODULE 1 (22 questions)
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=4, module_number=1, qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='easy'   AND rn=1) OR
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 4) OR
    (domain='advanced-math'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='algebra'         AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='algebra'         AND difficulty_tier='medium' AND rn BETWEEN 1 AND 4) OR
    (domain='algebra'         AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='geometry-trig'   AND difficulty_tier='easy'   AND rn=1) OR
    (domain='geometry-trig'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='geometry-trig'   AND difficulty_tier='hard'   AND rn=1) OR
    (domain='problem-solving' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='problem-solving' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2)
);

-- ================================================================
-- SET 5 — MODULE 1 (22 questions)
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=5, module_number=1, qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='easy'   AND rn=1) OR
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 4) OR
    (domain='advanced-math'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='algebra'         AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='algebra'         AND difficulty_tier='medium' AND rn BETWEEN 1 AND 4) OR
    (domain='algebra'         AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='geometry-trig'   AND difficulty_tier='easy'   AND rn=1) OR
    (domain='geometry-trig'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='geometry-trig'   AND difficulty_tier='hard'   AND rn=1) OR
    (domain='problem-solving' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='problem-solving' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2)
);

-- ================================================================
-- SET 4 — MODULE 2 EASY (22 questions, difficulty_tier → 'easy')
-- advanced-math uses medium pool (only 5 easy total, needed for M1)
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=4, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 7) OR
    (domain='algebra'         AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4)
);

-- ================================================================
-- SET 5 — MODULE 2 EASY (22 questions, difficulty_tier → 'easy')
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=5, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 7) OR
    (domain='algebra'         AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4)
);

-- ================================================================
-- SET 4 — MODULE 2 HARD (22 questions, difficulty_tier → 'hard')
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=4, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 8) OR
    (domain='algebra'         AND difficulty_tier='hard' AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='hard' AND rn BETWEEN 1 AND 3)
);

-- ================================================================
-- SET 5 — MODULE 2 HARD (22 questions, difficulty_tier → 'hard')
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=5, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 8) OR
    (domain='algebra'         AND difficulty_tier='hard' AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='hard' AND rn BETWEEN 1 AND 3)
);

-- ================================================================
-- Update exam_types to reflect 5 total SAT sets
-- ================================================================
UPDATE exam_types SET total_sets=5 WHERE id='sat';

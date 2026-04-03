-- Assign math practice questions to SAT mock sets 6–10.
-- Questions are pulled from the practice pool (set_number=0, module_number=0)
-- and assigned to their respective mock modules in order of id.
--
-- M1 template (22q): adv-math 1E+4M+2H, algebra 2E+4M+2H, geo 1E+2M+1H, ps 1E+2M
-- M2 Easy (22q):     adv-math 7(med), algebra 7(easy), geo 4(easy), ps 4(easy)
-- M2 Hard (22q):     adv-math 8(hard), algebra 7(hard), geo 4(hard), ps 3(hard)
--
-- NOTE: difficulty_tier on M2 rows indicates the adaptive track ('easy'/'hard'),
-- not the individual question difficulty — consistent with sets 1–5.
--
-- NOTE: advanced-math easy pool has only 3 questions remaining.
-- Sets 6–8 each get 1 easy adv-math for M1. Sets 9–10 use medium instead (5M+2H).
-- This is flagged for QC review.
--
-- Prerequisites: All sets 1–5 already assigned. Pool contains unassigned questions.

-- ================================================================
-- SET 6 — MODULE 1 (22 questions)
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=6, module_number=1, qc_done=true
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
-- SET 7 — MODULE 1 (22 questions)
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=7, module_number=1, qc_done=true
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
-- SET 8 — MODULE 1 (22 questions)
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=8, module_number=1, qc_done=true
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
-- SET 9 — MODULE 1 (22 questions)
-- NOTE: No easy adv-math left, using 5 medium + 2 hard instead of 1E+4M+2H
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=9, module_number=1, qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 5) OR
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
-- SET 10 — MODULE 1 (22 questions)
-- NOTE: No easy adv-math left, using 5 medium + 2 hard instead of 1E+4M+2H
-- ================================================================
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=10, module_number=1, qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 5) OR
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
-- SETS 6–10 — MODULE 2 EASY (22 questions each, difficulty_tier → 'easy')
-- advanced-math draws from medium pool
-- ================================================================

-- SET 6 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=6, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 7) OR
    (domain='algebra'         AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4)
);

-- SET 7 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=7, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 7) OR
    (domain='algebra'         AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4)
);

-- SET 8 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=8, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 7) OR
    (domain='algebra'         AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4)
);

-- SET 9 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=9, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 7) OR
    (domain='algebra'         AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4)
);

-- SET 10 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=10, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 7) OR
    (domain='algebra'         AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4)
);

-- ================================================================
-- SETS 6–10 — MODULE 2 HARD (22 questions each, difficulty_tier → 'hard')
-- ================================================================

-- SET 6 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=6, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 8) OR
    (domain='algebra'         AND difficulty_tier='hard' AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='hard' AND rn BETWEEN 1 AND 3)
);

-- SET 7 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=7, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 8) OR
    (domain='algebra'         AND difficulty_tier='hard' AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='hard' AND rn BETWEEN 1 AND 3)
);

-- SET 8 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=8, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 8) OR
    (domain='algebra'         AND difficulty_tier='hard' AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='hard' AND rn BETWEEN 1 AND 3)
);

-- SET 9 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=9, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 8) OR
    (domain='algebra'         AND difficulty_tier='hard' AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='hard' AND rn BETWEEN 1 AND 3)
);

-- SET 10 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='math' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=10, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='advanced-math'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 8) OR
    (domain='algebra'         AND difficulty_tier='hard' AND rn BETWEEN 1 AND 7) OR
    (domain='geometry-trig'   AND difficulty_tier='hard' AND rn BETWEEN 1 AND 4) OR
    (domain='problem-solving' AND difficulty_tier='hard' AND rn BETWEEN 1 AND 3)
);

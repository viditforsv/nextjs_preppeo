-- Assign R&W practice questions to SAT mock sets 6–10.
-- Questions are pulled from the practice pool (set_number=0, module_number=0)
-- and assigned to their respective mock modules in order of id.
--
-- Template (per module, 27q):
--   CS=8, II=7, EI=5, SEC=7
--
-- M1 difficulty:  8E + 10M + 9H
--   CS: 3E+3M+2H  II: 2E+3M+2H  EI: 1E+2M+2H  SEC: 2E+2M+3H
--
-- M2 Easy (difficulty_tier='easy'): 12E + 11M + 4H
--   CS: 4E+3M+1H  II: 3E+3M+1H  EI: 2E+2M+1H  SEC: 3E+3M+1H
--
-- M2 Hard (difficulty_tier='hard'): 4E + 8M + 15H
--   CS: 1E+3M+4H  II: 1E+2M+4H  EI: 1E+1M+3H  SEC: 1E+2M+4H
--
-- NOTE: difficulty_tier on M2 rows is the adaptive track label ('easy'/'hard'),
-- not the individual question difficulty.
--
-- Prerequisites: R&W sheet questions imported to practice pool.

-- ================================================================
-- SETS 6–10 — MODULE 1 (27 questions each)
-- ================================================================

-- SET 6 M1
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=6, module_number=1, qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 3)
);

-- SET 7 M1
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=7, module_number=1, qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 3)
);

-- SET 8 M1
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=8, module_number=1, qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 3)
);

-- SET 9 M1
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=9, module_number=1, qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 3)
);

-- SET 10 M1
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=10, module_number=1, qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 3)
);

-- ================================================================
-- SETS 6–10 — MODULE 2 EASY (27 questions each, difficulty_tier → 'easy')
-- ================================================================

-- SET 6 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=6, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn=1) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn=1) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn=1)
);

-- SET 7 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=7, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn=1) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn=1) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn=1)
);

-- SET 8 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=8, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn=1) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn=1) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn=1)
);

-- SET 9 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=9, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn=1) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn=1) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn=1)
);

-- SET 10 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=10, module_number=2, difficulty_tier='easy', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 4) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn=1) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn=1) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn=1)
);

-- ================================================================
-- SETS 6–10 — MODULE 2 HARD (27 questions each, difficulty_tier → 'hard')
-- ================================================================

-- SET 6 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=6, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn=1) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn=1) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn=1) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4)
);

-- SET 7 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=7, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn=1) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn=1) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn=1) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4)
);

-- SET 8 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=8, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn=1) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn=1) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn=1) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4)
);

-- SET 9 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=9, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn=1) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn=1) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn=1) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4)
);

-- SET 10 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=10, module_number=2, difficulty_tier='hard', qc_done=true
WHERE id IN (
  SELECT id FROM pool WHERE
    (domain='craft-structure'     AND difficulty_tier='easy'   AND rn=1) OR
    (domain='craft-structure'     AND difficulty_tier='medium' AND rn BETWEEN 1 AND 3) OR
    (domain='craft-structure'     AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4) OR
    (domain='information-ideas'   AND difficulty_tier='easy'   AND rn=1) OR
    (domain='information-ideas'   AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='information-ideas'   AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4) OR
    (domain='expression-of-ideas' AND difficulty_tier='easy'   AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='medium' AND rn=1) OR
    (domain='expression-of-ideas' AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 3) OR
    (domain='standard-english'    AND difficulty_tier='easy'   AND rn=1) OR
    (domain='standard-english'    AND difficulty_tier='medium' AND rn BETWEEN 1 AND 2) OR
    (domain='standard-english'    AND difficulty_tier='hard'   AND rn BETWEEN 1 AND 4)
);

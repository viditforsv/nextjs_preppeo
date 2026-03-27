-- Rebuild R&W mock modules for all 5 sets using the locked 4-domain template.
--
-- Template (per module, 27q):
--   CS=8, II=7, EI=5, SEC=7  (mirrors College Board Digital SAT percentages)
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
-- not the individual question difficulty — consistent with Math M2 convention.
--
-- Prerequisites:
--   1. 15 new questions seeded to practice pool (set_number=0, module_number=0):
--      standard-english/medium: 6, standard-english/hard: 3, expression-of-ideas/medium: 6
--   2. All sets 1–3 R&W mock questions returned to practice pool before this runs:
--      UPDATE sat_questions SET set_number=0, module_number=0
--      WHERE section='rw' AND set_number IN (1,2,3);

-- ================================================================
-- SETS 1–5 — MODULE 1 (27 questions each, run sequentially)
-- ================================================================

-- SET 1 M1
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=1, module_number=1, qc_done=true
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

-- SET 2 M1
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=2, module_number=1, qc_done=true
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

-- SET 3 M1
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=3, module_number=1, qc_done=true
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

-- SET 4 M1
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=4, module_number=1, qc_done=true
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

-- SET 5 M1
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=5, module_number=1, qc_done=true
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
-- SETS 1–5 — MODULE 2 EASY (27q each, difficulty_tier → 'easy')
-- ================================================================

-- SET 1 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=1, module_number=2, difficulty_tier='easy', qc_done=true
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

-- SET 2 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=2, module_number=2, difficulty_tier='easy', qc_done=true
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

-- SET 3 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=3, module_number=2, difficulty_tier='easy', qc_done=true
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

-- SET 4 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=4, module_number=2, difficulty_tier='easy', qc_done=true
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

-- SET 5 M2E
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=5, module_number=2, difficulty_tier='easy', qc_done=true
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
-- SETS 1–5 — MODULE 2 HARD (27q each, difficulty_tier → 'hard')
-- ================================================================

-- SET 1 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=1, module_number=2, difficulty_tier='hard', qc_done=true
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

-- SET 2 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=2, module_number=2, difficulty_tier='hard', qc_done=true
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

-- SET 3 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=3, module_number=2, difficulty_tier='hard', qc_done=true
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

-- SET 4 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=4, module_number=2, difficulty_tier='hard', qc_done=true
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

-- SET 5 M2H
WITH pool AS (
  SELECT id, domain, difficulty_tier,
    ROW_NUMBER() OVER (PARTITION BY domain, difficulty_tier ORDER BY id) rn
  FROM sat_questions
  WHERE section='rw' AND set_number=0 AND module_number=0 AND is_active=true
)
UPDATE sat_questions SET set_number=5, module_number=2, difficulty_tier='hard', qc_done=true
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

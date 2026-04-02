-- Premium pricing update for SAT packs

-- B2C: Add 1-test pack
INSERT INTO token_packs (exam_type, name, token_count, price) VALUES
  ('sat', '1 SAT Mock Test', 1, 499);

-- B2C: Update 3-test and 5-test packs
UPDATE token_packs SET price = 999  WHERE exam_type = 'sat' AND token_count = 3 AND name = '3 SAT Mock Tests';
UPDATE token_packs SET price = 1499 WHERE exam_type = 'sat' AND token_count = 5 AND name = '5 SAT Mock Tests';

-- B2B: Update existing institute packs
UPDATE token_packs SET price = 29000  WHERE exam_type = 'sat' AND token_count = 50;
UPDATE token_packs SET price = 46000  WHERE exam_type = 'sat' AND token_count = 100;
UPDATE token_packs SET price = 125000 WHERE exam_type = 'sat' AND token_count = 500;

-- B2B: Add 300-test institute tier
INSERT INTO token_packs (exam_type, name, token_count, price) VALUES
  ('sat', '300 SAT Mock Tests — Institute', 300, 100000);

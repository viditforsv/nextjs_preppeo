-- CBSE 10 Science — generated from TSV (questions.tsv)
-- Rows: 1
--
-- If you see "relation cbse10_science_questions does not exist", run this file's sibling first:
--   20260325115000_ensure_cbse10_science_questions_table.sql
-- (Or run full Supabase migrations from the repo so that file runs before this one.)

INSERT INTO cbse10_science_questions (
  type, prompt, options, correct_answer, explanation,
  domain, difficulty_tier, chapter, subtopic,
  bank_item_id, image_url, qc_done,
  is_pyq, pyq_year, correct_answer_b
)
VALUES
  (
    'spr',
    'If the charge on an electron is 1.6 × 10⁻¹⁹ C, find the approximate number of electrons in 1 C. [CBSE 2016]',
    NULL,
    '6.25',
    '1 C charge contains 1 / (1.6 × 10⁻¹⁹) = 6.25 × 10¹⁸ electrons.',
    'electricity',
    'easy',
    'Electricity',
    'Electric Charge and Current',
    'cbse10_ch12_custom_q001',
    NULL,
    false,
    true,
    '2016',
    '18'
  )
ON CONFLICT (bank_item_id) DO UPDATE SET
  type              = EXCLUDED.type,
  prompt            = EXCLUDED.prompt,
  options           = EXCLUDED.options,
  correct_answer    = EXCLUDED.correct_answer,
  explanation       = EXCLUDED.explanation,
  domain            = EXCLUDED.domain,
  difficulty_tier   = EXCLUDED.difficulty_tier,
  chapter           = EXCLUDED.chapter,
  subtopic          = EXCLUDED.subtopic,
  image_url         = EXCLUDED.image_url,
  is_pyq            = EXCLUDED.is_pyq,
  pyq_year          = EXCLUDED.pyq_year,
  correct_answer_b  = EXCLUDED.correct_answer_b;

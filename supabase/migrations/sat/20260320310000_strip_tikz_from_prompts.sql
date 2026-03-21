-- Auto-generated: strip TikZ diagram code from prompts after image_url is linked
-- Applies to 172 bank_item_ids from lid-images.manifest.json
-- Safe to re-run: no-op if TikZ already stripped.

UPDATE public.sat_questions
SET prompt = trim(regexp_replace(
  regexp_replace(
    prompt,
    '\\\\begin\{center\}\s*\\\\begin\{tikzpicture\}(\[[^]]*\])?[\s\S]*?\\\\end\{tikzpicture\}\s*\\\\end\{center\}',
    '[See diagram]',
    'gs'
  ),
  '\\\\begin\{tikzpicture\}(\[[^]]*\])?[\s\S]*?\\\\end\{tikzpicture\}',
  '[See diagram]',
  'gs'
))
WHERE image_url IS NOT NULL
  AND prompt LIKE '%tikzpicture%';

-- sat_lid_035_30: remove embedded TikZ from prompt (figure is in storage only).
-- Single prompt image in image_urls; image_url cleared to avoid duplicate display.

UPDATE sat_questions
SET
  prompt = 'For the dot plot below, which of the following is true?',
  image_url = NULL,
  image_urls = ARRAY[
    'https://ootnqmojcqnzfrtvzzec.supabase.co/storage/v1/object/public/sat-question-images/math/lid/sat_lid_035_30.png'
  ]::text[]
WHERE bank_item_id = 'sat_lid_035_30';

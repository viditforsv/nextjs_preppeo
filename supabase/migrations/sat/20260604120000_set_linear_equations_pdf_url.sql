-- Set the real Bunny CDN URL for the Linear Equations key-formula sheet.
--
-- Replaces the seed placeholder (REPLACE_BUNNY_PULL_ZONE) on the
-- sat-math → linear-equations → linear-formulas-pdf item with the synced
-- Bunny path. Source .tex:
--   latex_with_rijay/2. Preppeo/sat_maths_self_learn_course/sat-math/linear-equations/linear-equations-formulas.tex
-- Uploaded via scripts/sync-sat-course-bunny.mjs.
--
-- Store the RAW CDN URL; the app wraps it in /api/pdf-proxy at render time
-- (the pull zone is referer-locked). Target: dev branch first, then prod.

UPDATE public.sat_learn_items i
   SET pdf_url = 'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/linear-equations/linear-equations-formulas.pdf'
  FROM public.sat_learn_topics t, public.sat_learn_courses c
 WHERE i.topic_id = t.id
   AND t.course_id = c.id
   AND c.slug = 'sat-math'
   AND t.slug = 'linear-equations'
   AND i.slug = 'linear-formulas-pdf'
   AND i.type = 'pdf';

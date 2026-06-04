-- Add the SAT Math "Reference Sheet" (Bluebook given-on-the-test formulas) as a
-- free-preview PDF item under the Introduction topic of the sat-math course.
-- Idempotent on (topic_id, slug). Target: dev branch first, then prod after QC.

INSERT INTO public.sat_learn_items
  (topic_id, title, slug, type, sort_order, is_free_preview, is_published, pdf_url)
SELECT t.id,
       'Reference Sheet (Given on the Test)',
       'reference-sheet',
       'pdf',
       2,
       true,
       true,
       'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/reference-sheet/reference-sheet-formulas.pdf'
  FROM public.sat_learn_topics t
  JOIN public.sat_learn_courses c ON c.id = t.course_id
 WHERE c.slug = 'sat-math' AND t.slug = 'introduction'
ON CONFLICT (topic_id, slug) DO UPDATE
  SET pdf_url        = EXCLUDED.pdf_url,
      type           = EXCLUDED.type,
      title          = EXCLUDED.title,
      sort_order     = EXCLUDED.sort_order,
      is_free_preview= EXCLUDED.is_free_preview,
      is_published   = EXCLUDED.is_published,
      updated_at     = now();

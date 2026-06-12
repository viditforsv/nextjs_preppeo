-- Re-point the 6 SAT Math topics whose Bunny booklet folder was renamed to
-- match the topic slug (syllabus = source of truth). Old folders were deleted
-- from the CDN, so these pdf_urls must move to the new slug-matching paths.
-- Target: dev branch first, then prod after QC.

UPDATE public.sat_learn_items i
   SET pdf_url = m.url,
       updated_at = now()
  FROM (VALUES
    ('systems-of-linear-equations',  'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/systems-of-linear-equations/systems-of-linear-equations-formulas.pdf'),
    ('linear-inequalities',          'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/linear-inequalities/linear-inequalities-formulas.pdf'),
    ('quadratic-functions',          'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/quadratic-functions/quadratic-functions-formulas.pdf'),
    ('polynomials-factoring',        'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/polynomials-factoring/polynomials-factoring-formulas.pdf'),
    ('exponential-functions',        'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/exponential-functions/exponential-functions-formulas.pdf'),
    ('right-triangles-trigonometry', 'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/right-triangles-trigonometry/right-triangles-trigonometry-formulas.pdf')
  ) AS m(topic_slug, url)
  JOIN public.sat_learn_topics  t ON t.slug = m.topic_slug
  JOIN public.sat_learn_courses c ON c.id = t.course_id AND c.slug = 'sat-math'
 WHERE i.topic_id = t.id
   AND i.type = 'pdf';

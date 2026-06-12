-- Wire every SAT Math topic's PDF item to its Bunny CDN formula booklet.
--
-- The sat-math course's topics each carry a `pdf` item (placeholder pdf_url=NULL).
-- This sets each to the synced booklet under sat-learn/sat-math/<folder>/.
-- Booklet folders follow the app /sat/formulas grouping, so a few folder names
-- differ from the DB topic slug (e.g. topic systems-of-linear-equations →
-- booklet systems-of-equations) — the mapping below is explicit and content-correct.
--
-- linear-equations is already wired (item slug linear-formulas-pdf) by an
-- earlier migration and is intentionally omitted here.
-- Store the RAW CDN URL; the app wraps it in /api/pdf-proxy at render time.
-- Target: dev branch first, then prod after QC.

UPDATE public.sat_learn_items i
   SET pdf_url = m.url,
       updated_at = now()
  FROM (VALUES
    ('linear-functions-graphs',      'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/linear-functions-graphs/linear-functions-graphs-formulas.pdf'),
    ('systems-of-linear-equations',  'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/systems-of-equations/systems-of-equations-formulas.pdf'),
    ('linear-inequalities',          'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/inequalities-absolute-value/inequalities-absolute-value-formulas.pdf'),
    ('quadratic-functions',          'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/quadratics/quadratics-formulas.pdf'),
    ('exponents-radicals',           'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/exponents-radicals/exponents-radicals-formulas.pdf'),
    ('polynomials-factoring',        'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/factoring-polynomials/factoring-polynomials-formulas.pdf'),
    ('exponential-functions',        'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/exponential-models/exponential-models-formulas.pdf'),
    ('ratios-rates-proportions',     'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/ratios-rates-proportions/ratios-rates-proportions-formulas.pdf'),
    ('percentages',                  'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/percentages/percentages-formulas.pdf'),
    ('statistics-data',              'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/statistics-data/statistics-data-formulas.pdf'),
    ('probability',                  'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/probability/probability-formulas.pdf'),
    ('lines-angles-triangles',       'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/lines-angles-triangles/lines-angles-triangles-formulas.pdf'),
    ('right-triangles-trigonometry', 'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/right-triangles-trig/right-triangles-trig-formulas.pdf'),
    ('circles',                      'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/circles/circles-formulas.pdf'),
    ('area-volume',                  'https://shrividhyaclasses.b-cdn.net/sat-learn/sat-math/area-volume/area-volume-formulas.pdf')
  ) AS m(topic_slug, url)
  JOIN public.sat_learn_topics  t ON t.slug = m.topic_slug
  JOIN public.sat_learn_courses c ON c.id = t.course_id AND c.slug = 'sat-math'
 WHERE i.topic_id = t.id
   AND i.type = 'pdf';

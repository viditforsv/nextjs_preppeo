-- ════════════════════════════════════════════════════════════════════════
-- Seed the full SAT Math curriculum as topic headers (no items yet).
-- Published so they show in the sidebar as the course roadmap; each renders
-- "Coming soon" until content (items) is added. "Linear Equations" already
-- exists with content — ON CONFLICT keeps it untouched.
-- Target: dev branch first.
-- ════════════════════════════════════════════════════════════════════════
WITH math_course AS (
  SELECT id FROM public.sat_learn_courses WHERE slug = 'sat-math'
)
INSERT INTO public.sat_learn_topics
  (course_id, title, slug, domain, description, sort_order, is_published)
SELECT mc.id, v.title, v.slug, v.domain, v.description, v.sort_order, true
FROM math_course mc
CROSS JOIN (VALUES
  -- Algebra
  ('Linear Equations',            'linear-equations',            'algebra',         'Slopes, intercepts, and solving linear equations.', 1),
  ('Linear Functions & Graphs',   'linear-functions-graphs',     'algebra',         'Reading and building linear functions and their graphs.', 2),
  ('Systems of Linear Equations', 'systems-of-linear-equations', 'algebra',         'Solving systems by substitution and elimination.', 3),
  ('Linear Inequalities',         'linear-inequalities',         'algebra',         'Solving and graphing linear inequalities.', 4),
  -- Advanced Math
  ('Quadratic Functions',         'quadratic-functions',         'advanced-math',   'Parabolas, vertex and factored form, the quadratic formula.', 5),
  ('Exponents & Radicals',        'exponents-radicals',          'advanced-math',   'Exponent rules, radicals, and rational exponents.', 6),
  ('Polynomials & Factoring',     'polynomials-factoring',       'advanced-math',   'Factoring patterns and polynomial behavior.', 7),
  ('Exponential Functions',       'exponential-functions',       'advanced-math',   'Growth, decay, and exponential models.', 8),
  -- Problem-Solving & Data
  ('Ratios, Rates & Proportions', 'ratios-rates-proportions',    'problem-solving', 'Setting up ratios, rates, proportions, and unit conversion.', 9),
  ('Percentages',                 'percentages',                 'problem-solving', 'Percent, percent change, and applications.', 10),
  ('Statistics & Data',           'statistics-data',             'problem-solving', 'Mean, median, spread, and interpreting data displays.', 11),
  ('Probability',                 'probability',                 'problem-solving', 'Basic probability and two-way tables.', 12),
  -- Geometry & Trigonometry
  ('Lines, Angles & Triangles',   'lines-angles-triangles',      'geometry-trig',   'Angle relationships, triangles, and similarity.', 13),
  ('Right Triangles & Trigonometry','right-triangles-trigonometry','geometry-trig', 'Pythagorean theorem, special triangles, and SOH-CAH-TOA.', 14),
  ('Circles',                     'circles',                     'geometry-trig',   'Arcs, sectors, equations of circles, and angles.', 15),
  ('Area & Volume',               'area-volume',                 'geometry-trig',   'Area, surface area, and volume of common shapes.', 16)
) AS v(title, slug, domain, description, sort_order)
ON CONFLICT (course_id, slug) DO NOTHING;

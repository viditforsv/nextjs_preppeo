-- ════════════════════════════════════════════════════════════════════════
-- Seed flashcards (term → definition) for each SAT Math topic's flashcard
-- item. Cards attach to the topic's item where slug='flashcards'. Linear
-- Equations already has its deck (item slug 'linear-flashcards') and is not
-- in this set. The NOT EXISTS guard makes re-runs safe (no unique key on the
-- flashcards table). Fronts/backs are plain text (rendered via KaTeX-aware
-- renderMixedContent in the player). Target: dev branch first.
-- ════════════════════════════════════════════════════════════════════════
INSERT INTO public.sat_learn_flashcards (item_id, topic_id, section, front, back, sort_order)
SELECT i.id, i.topic_id, 'math', v.front, v.back, v.sort_order
FROM (VALUES
  -- Algebra
  ('linear-functions-graphs','Linear function','A function with a constant rate of change, written f(x) = mx + b.',1),
  ('linear-functions-graphs','Rate of change','The slope m — how much the output changes per unit increase in input.',2),
  ('linear-functions-graphs','Initial value','The output when x = 0, that is f(0) = b (the y-intercept).',3),
  ('linear-functions-graphs','Increasing vs decreasing','Positive slope rises left-to-right; negative slope falls.',4),
  ('linear-functions-graphs','x-intercept','Where the graph crosses the x-axis; set f(x) = 0 and solve.',5),

  ('systems-of-linear-equations','System of equations','Two or more equations solved together for common values.',1),
  ('systems-of-linear-equations','Substitution','Solve one equation for a variable and substitute into the other.',2),
  ('systems-of-linear-equations','Elimination','Add or subtract the equations to cancel a variable.',3),
  ('systems-of-linear-equations','No solution','Same slope, different intercepts — parallel lines that never meet.',4),
  ('systems-of-linear-equations','Infinitely many solutions','Both equations describe the exact same line.',5),

  ('linear-inequalities','Linear inequality','A linear relationship using <, >, ≤, or ≥ instead of =.',1),
  ('linear-inequalities','Flip rule','Reverse the inequality sign when multiplying or dividing by a negative.',2),
  ('linear-inequalities','Dashed vs solid line','Dashed for < or > (boundary excluded); solid for ≤ or ≥ (included).',3),
  ('linear-inequalities','Solution region','The shaded side of the boundary where the inequality holds true.',4),
  ('linear-inequalities','System of inequalities','Solutions lie in the overlap of all shaded regions.',5),

  -- Advanced Math
  ('quadratic-functions','Quadratic function','A function y = ax² + bx + c; its graph is a parabola.',1),
  ('quadratic-functions','Vertex form','y = a(x − h)² + k, with vertex at (h, k).',2),
  ('quadratic-functions','Factored form','y = a(x − r₁)(x − r₂), with roots r₁ and r₂.',3),
  ('quadratic-functions','Quadratic formula','x = (−b ± √(b² − 4ac)) / (2a).',4),
  ('quadratic-functions','Discriminant','b² − 4ac; positive → 2 roots, zero → 1, negative → none.',5),

  ('exponents-radicals','Product rule','aᵐ · aⁿ = aᵐ⁺ⁿ.',1),
  ('exponents-radicals','Quotient rule','aᵐ / aⁿ = aᵐ⁻ⁿ.',2),
  ('exponents-radicals','Power of a power','(aᵐ)ⁿ = aᵐⁿ.',3),
  ('exponents-radicals','Negative exponent','a⁻ⁿ = 1 / aⁿ.',4),
  ('exponents-radicals','Fractional exponent','a^(m/n) is the n-th root of aᵐ.',5),

  ('polynomials-factoring','Difference of squares','a² − b² = (a + b)(a − b).',1),
  ('polynomials-factoring','Perfect square trinomial','a² ± 2ab + b² = (a ± b)².',2),
  ('polynomials-factoring','Factoring a trinomial','Find two numbers multiplying to the constant and adding to the middle coefficient.',3),
  ('polynomials-factoring','Zero of a polynomial','A value r where P(r) = 0; matches the factor (x − r).',4),
  ('polynomials-factoring','Factor theorem','(x − a) is a factor exactly when P(a) = 0.',5),

  ('exponential-functions','Exponential function','y = a · bˣ; multiplies by a constant factor each step.',1),
  ('exponential-functions','Growth factor','b > 1 means growth; 0 < b < 1 means decay.',2),
  ('exponential-functions','Growth model','y = a(1 + r)ᵗ, where r is the growth rate.',3),
  ('exponential-functions','Decay model','y = a(1 − r)ᵗ, where r is the decay rate.',4),
  ('exponential-functions','Linear vs exponential','Linear adds a constant; exponential multiplies by a constant.',5),

  -- Problem-Solving & Data
  ('ratios-rates-proportions','Ratio','A comparison of two quantities, written a : b or a/b.',1),
  ('ratios-rates-proportions','Proportion','An equation stating two ratios are equal: a/b = c/d.',2),
  ('ratios-rates-proportions','Cross-multiplication','From a/b = c/d you get ad = bc.',3),
  ('ratios-rates-proportions','Rate','A ratio comparing quantities with different units, e.g. miles per hour.',4),
  ('ratios-rates-proportions','Unit conversion','Multiply by a fraction equal to 1 to cancel and change units.',5),

  ('percentages','Percent','A number out of 100; 25% = 25/100 = 0.25.',1),
  ('percentages','Part-whole relationship','part = percent × whole.',2),
  ('percentages','Percent change','(new − old) / old × 100.',3),
  ('percentages','Percent increase','Multiply the original by (1 + p/100).',4),
  ('percentages','Percent decrease','Multiply the original by (1 − p/100).',5),

  ('statistics-data','Mean','The average: the sum of the values divided by the count.',1),
  ('statistics-data','Median','The middle value when the data is ordered.',2),
  ('statistics-data','Mode','The most frequently occurring value.',3),
  ('statistics-data','Range','The difference between the maximum and minimum values.',4),
  ('statistics-data','Standard deviation','A measure of how spread out the data is around the mean.',5),

  ('probability','Probability','favorable outcomes / total outcomes; a value between 0 and 1.',1),
  ('probability','Complement','P(not A) = 1 − P(A).',2),
  ('probability','Independent events','P(A and B) = P(A) × P(B).',3),
  ('probability','Conditional probability','Probability of A given B; uses the B subgroup as the denominator.',4),
  ('probability','Two-way table','A table of counts used to read joint and conditional probabilities.',5),

  -- Geometry & Trigonometry
  ('lines-angles-triangles','Supplementary angles','Two angles that add to 180°.',1),
  ('lines-angles-triangles','Complementary angles','Two angles that add to 90°.',2),
  ('lines-angles-triangles','Vertical angles','Opposite angles at an intersection; always equal.',3),
  ('lines-angles-triangles','Triangle angle sum','The interior angles of a triangle add to 180°.',4),
  ('lines-angles-triangles','Similar triangles','Equal angles and proportional corresponding sides.',5),

  ('right-triangles-trigonometry','Pythagorean theorem','a² + b² = c² for a right triangle.',1),
  ('right-triangles-trigonometry','Sine','sin θ = opposite / hypotenuse.',2),
  ('right-triangles-trigonometry','Cosine','cos θ = adjacent / hypotenuse.',3),
  ('right-triangles-trigonometry','Tangent','tan θ = opposite / adjacent.',4),
  ('right-triangles-trigonometry','Special right triangles','45-45-90 → s : s : s√2; 30-60-90 → x : x√3 : 2x.',5),

  ('circles','Area of a circle','A = πr².',1),
  ('circles','Circumference','C = 2πr.',2),
  ('circles','Equation of a circle','(x − h)² + (y − k)² = r², with center (h, k).',3),
  ('circles','Arc length','(central angle / 360°) × circumference.',4),
  ('circles','Inscribed angle','Half of the central angle that subtends the same arc.',5),

  ('area-volume','Area of a triangle','A = ½ × base × height.',1),
  ('area-volume','Area of a circle','A = πr².',2),
  ('area-volume','Volume of a cylinder','V = πr²h.',3),
  ('area-volume','Volume of a sphere','V = (4/3)πr³.',4),
  ('area-volume','Volume of a cone','V = (1/3)πr²h.',5)
) AS v(topic_slug, front, back, sort_order)
JOIN public.sat_learn_topics t ON t.slug = v.topic_slug
JOIN public.sat_learn_courses c ON c.id = t.course_id AND c.slug = 'sat-math'
JOIN public.sat_learn_items i ON i.topic_id = t.id AND i.slug = 'flashcards'
WHERE NOT EXISTS (
  SELECT 1 FROM public.sat_learn_flashcards f WHERE f.item_id = i.id
);

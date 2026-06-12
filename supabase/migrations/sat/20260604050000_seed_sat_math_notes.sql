-- ════════════════════════════════════════════════════════════════════════
-- Seed concept "Notes" (type='reading') for every SAT Math topic that does
-- not already have one. Linear Equations already has its notes item, so it is
-- excluded by the ON CONFLICT (topic_id, slug) guard (slug 'notes').
--
-- Notes are free-preview (the free tier / hook); flip is_free_preview=false
-- later if notes should sit behind enrollment. Body uses the lesson markdown:
-- ## headings, - bullets, **bold**, `formula chips`, and > callouts.
-- Target: dev branch first.
-- ════════════════════════════════════════════════════════════════════════
INSERT INTO public.sat_learn_items
  (topic_id, title, slug, type, sort_order, is_free_preview, is_published, body)
SELECT t.id, v.title, 'notes', 'reading', 1, true, true, v.body
FROM (VALUES
  ('linear-functions-graphs',
   'Reading & Building Linear Functions — Notes',
   E'## What a linear function looks like\nA linear function changes at a constant rate. In function notation it is `f(x) = mx + b` — the same shape as `y = mx + b`.\n- `m` is the constant rate of change (the slope).\n- `b` is the starting value, `f(0)` — where the graph crosses the y-axis.\n## Reading a graph\n- A steeper line means a larger absolute slope.\n- A horizontal line has slope `0`; a vertical line has an undefined slope.\n> On the SAT, phrases like "constant rate of change" or "for every increase of 1 in x" signal a linear model — reach for `y = mx + b`.\n## Building one from a description\nFind the rate of change for `m`, then the initial amount for `b`. Example: a tank starts at 5 L and gains 2 L per minute, so `y = 2x + 5`.'),

  ('systems-of-linear-equations',
   'Solving Systems of Equations — Notes',
   E'## Two methods\n- **Substitution**: solve one equation for a variable, then plug it into the other.\n- **Elimination**: add or subtract the equations to cancel a variable.\n## How many solutions?\n- **One solution**: the lines have different slopes and cross once.\n- **No solution**: same slope, different y-intercept (parallel lines).\n- **Infinitely many**: both equations describe the same line.\n> A system has no solution when the variable terms match but the constants do not — for example `2x + y = 3` and `2x + y = 7`.\n## On Desmos\nGraph both equations; the intersection point is the solution. On the calculator-allowed SAT this is often the fastest route.'),

  ('linear-inequalities',
   'Linear Inequalities — Notes',
   E'## Solving\nSolve an inequality just like an equation, with one extra rule:\n- When you multiply or divide both sides by a **negative** number, **flip** the inequality sign.\n## Graphing\n- `<` or `>` use a dashed boundary line (points on the line are not included).\n- `≤` or `≥` use a solid line.\n- Shade the side that makes the inequality true — test an easy point like `(0, 0)`.\n> In a system of inequalities, a point is a solution only if it satisfies **every** inequality — it must lie in the overlapping shaded region.'),

  ('quadratic-functions',
   'Quadratic Functions — Notes',
   E'## Three forms\n- **Standard**: `y = ax² + bx + c`\n- **Vertex**: `y = a(x − h)² + k`, with vertex at `(h, k)`\n- **Factored**: `y = a(x − r₁)(x − r₂)`, with roots `r₁` and `r₂`\n## Key features\n- The graph is a parabola: `a > 0` opens up, `a < 0` opens down.\n- Axis of symmetry and vertex x-value: `x = −b / (2a)`.\n- Solve `ax² + bx + c = 0` with the quadratic formula: `x = (−b ± √(b² − 4ac)) / (2a)`.\n## The discriminant\nThe value `b² − 4ac` gives the number of real solutions: positive → two, zero → one, negative → none.\n> Each form is built for a job: factored form hands you the x-intercepts, vertex form hands you the vertex.'),

  ('exponents-radicals',
   'Exponents & Radicals — Notes',
   E'## Exponent rules\n- `aᵐ · aⁿ = aᵐ⁺ⁿ`\n- `aᵐ / aⁿ = aᵐ⁻ⁿ`\n- `(aᵐ)ⁿ = aᵐⁿ`\n- `a⁻ⁿ = 1 / aⁿ`\n- `a⁰ = 1`\n## Radicals as exponents\nA root is a fractional exponent: `√a = a^(1/2)` and `ⁿ√(aᵐ) = a^(m/n)`.\n- Simplify by pulling out perfect squares: `√50 = √25 · √2 = 5√2`.\n> Rewrite every radical as a fractional exponent before applying the rules — it turns a messy radical problem into simple arithmetic on the exponents.'),

  ('polynomials-factoring',
   'Polynomials & Factoring — Notes',
   E'## Factoring patterns\n- **Common factor**: `6x² + 9x = 3x(2x + 3)`\n- **Difference of squares**: `a² − b² = (a + b)(a − b)`\n- **Trinomial**: `x² + 5x + 6 = (x + 2)(x + 3)` — find two numbers that multiply to the constant and add to the middle coefficient.\n## Zeros and factors\nIf `(x − r)` is a factor, then `r` is a zero of the polynomial, and the graph meets the x-axis at `x = r`.\n> **Factor theorem**: `(x − a)` is a factor exactly when `P(a) = 0`. Plugging a candidate root into the polynomial is a quick way to test it.'),

  ('exponential-functions',
   'Exponential Functions — Notes',
   E'## The shape\nAn exponential function multiplies by a constant factor each step: `y = a · bˣ`.\n- `a` is the starting value (`y` when `x = 0`).\n- `b` is the growth factor: `b > 1` grows, `0 < b < 1` decays.\n## Growth and decay\n- **Growth**: `y = a(1 + r)ᵗ`\n- **Decay**: `y = a(1 − r)ᵗ`\nwhere `r` is the rate per period.\n> Linear models **add** the same amount each step; exponential models **multiply** by the same factor. "Doubles", "halves", or "increases by 8% per year" all signal exponential.'),

  ('ratios-rates-proportions',
   'Ratios, Rates & Proportions — Notes',
   E'## Setting up\n- A **ratio** compares quantities: `a : b` or `a/b`.\n- A **proportion** sets two ratios equal: `a/b = c/d`. Cross-multiply to solve: `ad = bc`.\n## Rates and units\n- A **rate** is a ratio with units, like miles per hour.\n- Convert units by multiplying by fractions equal to 1, cancelling units as you go.\n> Keep the proportion consistent: if miles is on top on the left, miles must be on top on the right too.'),

  ('percentages',
   'Percentages — Notes',
   E'## The basics\n- Percent means "per hundred": `25% = 25/100 = 0.25`.\n- Part = percent × whole. To find the percent: `part / whole × 100`.\n## Percent change\n- `percent change = (new − old) / old × 100`\n- Increase by `p%`: multiply by `(1 + p/100)`. Decrease: multiply by `(1 − p/100)`.\n> A 20% increase followed by a 20% decrease does **not** return to the start — you multiply by `1.2` then `0.8`, landing at `0.96` of the original.'),

  ('statistics-data',
   'Statistics & Data — Notes',
   E'## Center\n- **Mean** = sum ÷ count (the average). Sensitive to outliers.\n- **Median** = the middle value when ordered. Resistant to outliers.\n- **Mode** = the most frequent value.\n## Spread\n- **Range** = max − min.\n- **Standard deviation** measures how spread out the data is — larger means more spread.\n> An outlier pulls the **mean** toward it but barely moves the **median**. If a question adds one extreme value, expect the mean to change far more.\n## Reading displays\nAlways check the axis labels and units before reading a chart, histogram, or scatterplot.'),

  ('probability',
   'Probability — Notes',
   E'## Basic probability\n`P(event) = favorable outcomes / total outcomes`. Probabilities run from 0 (impossible) to 1 (certain).\n## Two-way tables\nMost SAT probability questions give a two-way table. The key is choosing the right denominator:\n- An overall probability uses the grand total.\n- A "given that…" (conditional) probability uses only that row or column total.\n> Read the wording closely: "of the students who passed" restricts you to the passed group — use that subgroup as the denominator, not the whole table.'),

  ('lines-angles-triangles',
   'Lines, Angles & Triangles — Notes',
   E'## Angles\n- Angles on a straight line sum to `180°`; around a point, `360°`.\n- **Vertical angles** (opposite each other at a crossing) are equal.\n- Parallel lines cut by a transversal make equal corresponding and alternate angles.\n## Triangles\n- The three angles of a triangle sum to `180°`.\n- **Similar triangles** have equal angles and proportional sides — set up a proportion to find a missing side.\n> Equal angles drive most SAT geometry: spot the parallel lines or shared angles, mark what is equal, and the proportions follow.'),

  ('right-triangles-trigonometry',
   'Right Triangles & Trigonometry — Notes',
   E'## Pythagorean theorem\nFor legs `a`, `b` and hypotenuse `c`: `a² + b² = c²`.\n- Common triples: `3-4-5` and `5-12-13`.\n- Special triangles: a `45-45-90` has sides `s : s : s√2`; a `30-60-90` has sides `x : x√3 : 2x`.\n## SOH-CAH-TOA\n- `sin θ = opposite / hypotenuse`\n- `cos θ = adjacent / hypotenuse`\n- `tan θ = opposite / adjacent`\n> Cofunction rule: `sin θ = cos(90° − θ)`. A sine equals the cosine of the complementary angle — handy when a question links the two acute angles of a right triangle.'),

  ('circles',
   'Circles — Notes',
   E'## Measurements\n- Area: `A = πr²`; circumference: `C = 2πr`.\n- Equation of a circle centered at `(h, k)`: `(x − h)² + (y − k)² = r²`.\n## Arcs and sectors\n- Arc length = (central angle / 360°) × circumference.\n- Sector area = (central angle / 360°) × area.\n## Angles\n- A central angle equals its arc; an inscribed angle is half its arc.\n> To find the center and radius from an expanded equation, **complete the square** for x and y to return it to `(x − h)² + (y − k)² = r²`.'),

  ('area-volume',
   'Area & Volume — Notes',
   E'## Area (2D)\n- Rectangle: `A = lw`; triangle: `A = ½bh`; circle: `A = πr²`.\n## Volume (3D)\n- Box: `V = lwh`; cylinder: `V = πr²h`.\n- A cone or pyramid is one-third of the matching prism: `V = ⅓πr²h` and `V = ⅓lwh`.\n- Sphere: `V = (4/3)πr³`.\n## Surface area\nAdd the areas of every face (for a box), or use `2πr² + 2πrh` for a cylinder.\n> The reference sheet gives you these volume formulas — so practice **choosing** the right one and substituting carefully rather than memorizing blindly.')
) AS v(topic_slug, title, body)
JOIN public.sat_learn_topics t ON t.slug = v.topic_slug
JOIN public.sat_learn_courses c ON c.id = t.course_id AND c.slug = 'sat-math'
ON CONFLICT (topic_id, slug) DO NOTHING;

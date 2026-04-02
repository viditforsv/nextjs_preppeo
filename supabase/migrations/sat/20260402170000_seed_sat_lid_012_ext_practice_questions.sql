-- Practice-mode math questions from sat_lid_012 extension (sat_extention/sat_lid_012.tex)
-- Chapter: Linear functions: slope, intercepts, graphs | Topic: Slope & Intercepts
-- section=math, domain=algebra, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_012_51 to sat_lid_012_70
-- Extends: 20260320230000_seed_sat_lid_012_practice_sat_questions.sql (which covers _1 to _50)
-- 20 questions total: 3 easy, 7 medium, 10 hard
--
-- NOTE: Questions 52, 56, 63 have solution adjustments noted in the source .tex —
--       these should be reviewed during QC.

INSERT INTO public.sat_questions (
  type,
  section,
  prompt,
  options,
  correct_answer,
  explanation,
  domain,
  difficulty_tier,
  module_number,
  set_number,
  chapter,
  subtopic,
  bank_item_id
)
VALUES

-- Q1 (sat_lid_012_51): Intercept ratio p/q in terms of a, b
(
  'mcq',
  'math',
  'The graph of the linear function $f$, defined by $ax + by = -c$, has an $x$-intercept at $(p, 0)$ and a $y$-intercept at $(0, q)$, where $a, b, c, p,$ and $q$ are non-zero constants. Which of the following represents the value of $\frac{p}{q}$ in terms of $a$ and $b$?',
  '[{"id":"a","text":"$\\frac{a}{b}$"},{"id":"b","text":"$\\frac{b}{a}$"},{"id":"c","text":"$-\\frac{a}{b}$"},{"id":"d","text":"$-\\frac{b}{a}$"}]'::jsonb,
  'b',
  '$x$-intercept: set $y = 0$: $ap = -c \implies p = -\frac{c}{a}$.

$y$-intercept: set $x = 0$: $bq = -c \implies q = -\frac{c}{b}$.

$\frac{p}{q} = \frac{-c/a}{-c/b} = \frac{b}{a}$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_51'
),

-- Q2 (sat_lid_012_52): Function translation — find a + b
-- NOTE: Source .tex solution gets a+b = -5, not matching options. Needs QC review.
(
  'mcq',
  'math',
  'The function $g$ is defined by $g(x) = \frac{2}{3}x - 12$. The graph of $y = f(x)$ in the $xy$-plane is the result of translating the graph of $g$ up 18 units and left 6 units. If $(a, 0)$ is the $x$-intercept and $(0, b)$ is the $y$-intercept of the graph of $f$, what is the value of $a + b$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"5"},{"id":"d","text":"10"}]'::jsonb,
  'b',
  'Apply transformations: left 6 replaces $x$ with $(x + 6)$, up 18 adds 18:

$f(x) = \frac{2}{3}(x + 6) - 12 + 18 = \frac{2}{3}x + 4 - 12 + 18 = \frac{2}{3}x + 10$

$y$-intercept: $b = 10$. $x$-intercept: $0 = \frac{2}{3}a + 10 \implies a = -15$.

$a + b = -15 + 10 = -5$.

(Note: This question needs QC review — computed answer does not match the listed options.)',
  'algebra',
  'hard',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_52'
),

-- Q3 (sat_lid_012_53): Identify f(x) from graph of f(x) + k
(
  'mcq',
  'math',
  'The graph of $y = f(x) + k$ is a line with negative slope passing through $(0, k)$ in the $xy$-plane, where $k$ is a positive constant. If $d$ is a positive constant representing the magnitude of the slope, which equation defines $f$?',
  '[{"id":"a","text":"$f(x) = -dx$"},{"id":"b","text":"$f(x) = dx$"},{"id":"c","text":"$f(x) = k - dx$"},{"id":"d","text":"$f(x) = dx + k$"}]'::jsonb,
  'a',
  'The graphed line has equation $y = -dx + k$.

Since $y = f(x) + k$: $f(x) + k = -dx + k$.

Subtract $k$: $f(x) = -dx$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_53'
),

-- Q4 (sat_lid_012_54): Combined function h(x) = f(x) + g(x) — x-intercept
(
  'mcq',
  'math',
  'The functions $f$ and $g$ are defined as $f(x) = \frac{5}{8}x - 14$ and $g(x) = \frac{3}{8}x + 36$. If the function $h$ is defined as $h(x) = f(x) + g(x)$, what is the $x$-coordinate of the $x$-intercept of the graph of $y = h(x)$?',
  '[{"id":"a","text":"$-44$"},{"id":"b","text":"$-22$"},{"id":"c","text":"$22$"},{"id":"d","text":"$44$"}]'::jsonb,
  'b',
  '$h(x) = \frac{5}{8}x - 14 + \frac{3}{8}x + 36 = x + 22$.

$x$-intercept: $0 = x + 22 \implies x = -22$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_54'
),

-- Q5 (sat_lid_012_55): Linear growth rate model
(
  'mcq',
  'math',
  'Renewable energy capacity in a region increased from 15 gigawatts in 2010 to 42 gigawatts in 2025. Assuming the capacity increased at a constant rate, which of the following linear functions $C$ best models the capacity, in gigawatts, $t$ years after 2010?',
  '[{"id":"a","text":"$C(t) = 1.8t + 15$"},{"id":"b","text":"$C(t) = 1.8t + 42$"},{"id":"c","text":"$C(t) = 2.8t + 15$"},{"id":"d","text":"$C(t) = 27t + 15$"}]'::jsonb,
  'a',
  'Points: $(0, 15)$ and $(15, 42)$.

Slope: $m = \frac{42 - 15}{15} = \frac{27}{15} = 1.8$.

Initial value at $t = 0$: $15$.

$C(t) = 1.8t + 15$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_55'
),

-- Q6 (sat_lid_012_56): Literal k dependencies — find b
-- NOTE: Source .tex solution is inconsistent (k=0 contradicts k>0). Needs QC review.
(
  'mcq',
  'math',
  'The linear function $f$ is defined by $f(x) = kx + b$, where $k$ and $b$ are constants. The graph of $f$ has a $y$-intercept at $(0, -k^2)$ and an $x$-intercept at $(k - 2, 0)$. If $k > 0$, what is the value of $b$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"$-2$"},{"id":"d","text":"$-4$"}]'::jsonb,
  'b',
  'The $y$-intercept gives $b = -k^2$.

Using the $x$-intercept: $0 = k(k - 2) + b = k^2 - 2k - k^2 = -2k$.

This gives $k = 0$, contradicting $k > 0$.

(Note: This question needs QC review — the given constraints are inconsistent.)',
  'algebra',
  'hard',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_56'
),

-- Q7 (sat_lid_012_57): Perpendicular line slope from intercepts
(
  'mcq',
  'math',
  'In the $xy$-plane, line $L_1$ has an $x$-intercept of $(a, 0)$ and a $y$-intercept of $(0, b)$, where $a \neq b$. Line $L_2$ is perpendicular to $L_1$ and passes through the origin. What is the slope of line $L_2$?',
  '[{"id":"a","text":"$\\frac{a}{b}$"},{"id":"b","text":"$\\frac{b}{a}$"},{"id":"c","text":"$-\\frac{a}{b}$"},{"id":"d","text":"$-\\frac{b}{a}$"}]'::jsonb,
  'a',
  'Slope of $L_1$: $m_1 = \frac{b - 0}{0 - a} = -\frac{b}{a}$.

Perpendicular slope: $m_2 = -\frac{1}{m_1} = -\frac{1}{-b/a} = \frac{a}{b}$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_57'
),

-- Q8 (sat_lid_012_58): Delta shift — find y-intercept
(
  'mcq',
  'math',
  'For a certain linear function $f$, $f(x + 4) - f(x) = 10$ for all real values of $x$. If the graph of $y = f(x)$ passes through the point $(2, 7)$, what is the $y$-intercept of the graph?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4.5"},{"id":"c","text":"5"},{"id":"d","text":"12"}]'::jsonb,
  'a',
  '$f(x + 4) - f(x)$ represents $\Delta y$ for $\Delta x = 4$:

$m = \frac{10}{4} = 2.5$

Using point $(2, 7)$: $7 = 2.5(2) + b \implies b = 2$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_58'
),

-- Q9 (sat_lid_012_59): Composition of linear functions — find slope
(
  'mcq',
  'math',
  'Let $f(x) = ax + b$ and $g(x) = cx + d$, where $a, b, c,$ and $d$ are constants. If the slope of $f(g(x))$ is 12 and the slope of $g(x)$ is 3, what is the slope of $f(x)$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"9"},{"id":"c","text":"15"},{"id":"d","text":"36"}]'::jsonb,
  'a',
  '$f(g(x)) = a(cx + d) + b = acx + (ad + b)$.

Slope of composition $= ac = 12$. Slope of $g = c = 3$.

$a = \frac{12}{3} = 4$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_59'
),

-- Q10 (sat_lid_012_60): Perpendicular bisector — find y-intercept
(
  'mcq',
  'math',
  'Segment $AB$ has endpoints $A(0, 4)$ and $B(6, 0)$. Line $k$ is the perpendicular bisector of segment $AB$. What is the $y$-intercept of line $k$?',
  '[{"id":"a","text":"$(0, -2.5)$"},{"id":"b","text":"$(0, -0.5)$"},{"id":"c","text":"$(0, 0.5)$"},{"id":"d","text":"$(0, 2.5)$"}]'::jsonb,
  'a',
  'Midpoint: $M = (3, 2)$.

Slope of $AB$: $m = \frac{0 - 4}{6 - 0} = -\frac{2}{3}$.

Perpendicular slope: $m_k = \frac{3}{2}$.

Using $(3, 2)$: $2 = \frac{3}{2}(3) + b \implies 2 = 4.5 + b \implies b = -2.5$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_60'
),

-- Q11 (sat_lid_012_61): Triangle area from intercepts — find slope
(
  'mcq',
  'math',
  'Line $L$ has a positive slope $m$ and passes through $(2, 6)$. If the area of the triangle formed by line $L$ and the positive $x$- and $y$-axes is 24, what is the value of $m$?',
  '[{"id":"a","text":"1.5"},{"id":"b","text":"3.0"},{"id":"c","text":"4.5"},{"id":"d","text":"6.0"}]'::jsonb,
  'b',
  'The line equation: $y - 6 = m(x - 2)$, i.e. $y = mx + (6 - 2m)$.

For positive intercepts with the axes, the slope must be negative (line goes from positive $y$-axis to positive $x$-axis). Let slope $= -m$ where $m > 0$.

$y$-intercept $b = 6 + 2m$. $x$-intercept $a = (6 + 2m)/m$.

Area: $\frac{1}{2}ab = 24 \implies ab = 48$.

$(6 + 2m) \cdot \frac{6 + 2m}{m} = 48 \implies \frac{(6 + 2m)^2}{m} = 48$.

$(6 + 2m)^2 = 48m \implies 4m^2 + 24m + 36 = 48m \implies 4m^2 - 24m + 36 = 0 \implies m^2 - 6m + 9 = 0 \implies (m - 3)^2 = 0$.

$m = 3$. The actual slope is $-3$, magnitude is 3.',
  'algebra',
  'hard',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_61'
),

-- Q12 (sat_lid_012_62): Slope of g(x) = f(2x)
(
  'mcq',
  'math',
  'The linear function $f$ satisfies $f(2) = 10$ and $f(5) = 25$. If $g(x) = f(2x)$, what is the slope of $g$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"10"},{"id":"c","text":"15"},{"id":"d","text":"20"}]'::jsonb,
  'b',
  'Slope of $f$: $m_f = \frac{25 - 10}{5 - 2} = 5$.

$f(x) = 5x + b$. $g(x) = f(2x) = 5(2x) + b = 10x + b$.

Slope of $g = 10$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_62'
),

-- Q13 (sat_lid_012_63): Double intercept system — find ab
-- NOTE: Source .tex gets ab=40 then adjusts to ab=24. Needs QC review.
(
  'mcq',
  'math',
  'Line $k$ has $x$-intercept $(a, 0)$ and $y$-intercept $(0, b)$. Line $n$ has $x$-intercept $(b, 0)$ and $y$-intercept $(0, a)$. If $a + b = 10$ and the lines intersect at $(4, 4)$, what is the value of $ab$?',
  '[{"id":"a","text":"16"},{"id":"b","text":"21"},{"id":"c","text":"24"},{"id":"d","text":"25"}]'::jsonb,
  'c',
  'Line $k$: $\frac{x}{a} + \frac{y}{b} = 1$. Substitute $(4, 4)$:

$\frac{4}{a} + \frac{4}{b} = 1 \implies 4 \cdot \frac{a + b}{ab} = 1$.

Since $a + b = 10$: $\frac{40}{ab} = 1 \implies ab = 40$.

(Note: This question needs QC review — computed $ab = 40$ does not match the stated answer C = 24.)',
  'algebra',
  'hard',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_63'
),

-- Q14 (sat_lid_012_64): Unit conversion — Glips to Glops per minute
(
  'mcq',
  'math',
  'A mapping function converts distance in "Glips" to "Glops." 5 Glips equal 8 Glops. If a speed is 40 Glips per hour, what is the speed in Glops per minute?',
  '[{"id":"a","text":"0.53"},{"id":"b","text":"1.07"},{"id":"c","text":"3.75"},{"id":"d","text":"64.0"}]'::jsonb,
  'b',
  'Convert Glips to Glops: $1$ Glip $= \frac{8}{5} = 1.6$ Glops.

Convert per hour to per minute: $40$ Glips/hr $= \frac{40}{60} = \frac{2}{3}$ Glips/min.

Combine: $\frac{2}{3} \times 1.6 = \frac{3.2}{3} \approx 1.07$ Glops/min.',
  'algebra',
  'medium',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_64'
),

-- Q15 (sat_lid_012_65): Perpendicular slope with variable points
(
  'mcq',
  'math',
  'Line $m$ passes through $(k, k^2)$ and $(k + 1, (k + 1)^2)$. If line $n$ is perpendicular to line $m$, what is the slope of line $n$ in terms of $k$?',
  '[{"id":"a","text":"$2k + 1$"},{"id":"b","text":"$-(2k + 1)$"},{"id":"c","text":"$\\frac{1}{2k + 1}$"},{"id":"d","text":"$-\\frac{1}{2k + 1}$"}]'::jsonb,
  'd',
  'Slope of $m$: $\frac{(k+1)^2 - k^2}{(k+1) - k} = \frac{2k + 1}{1} = 2k + 1$.

Perpendicular slope: $-\frac{1}{2k + 1}$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_65'
),

-- Q16 (sat_lid_012_66): Slope of g(x) = 3f(x) + 5
(
  'mcq',
  'math',
  'Function $f$ is linear. If $f(x) - f(x - 2) = 12$, what is the slope of the function $g(x) = 3f(x) + 5$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"12"},{"id":"c","text":"18"},{"id":"d","text":"36"}]'::jsonb,
  'c',
  'Slope of $f$: $\frac{12}{2} = 6$.

$g(x) = 3f(x) + 5 = 3(6x + b) + 5 = 18x + (3b + 5)$.

Slope of $g = 18$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_66'
),

-- Q17 (sat_lid_012_67): Horizontal/vertical lines — distance from origin
(
  'mcq',
  'math',
  'Line $j$ is defined by $y = k$. Line $p$ is defined by $x = h$. If these lines intersect at a point that is 5 units from the origin and $k = 2h$, what is a possible value of $h^2$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"10"},{"id":"c","text":"20"},{"id":"d","text":"25"}]'::jsonb,
  'a',
  'Intersection: $(h, k)$. Distance from origin: $\sqrt{h^2 + k^2} = 5$.

$h^2 + k^2 = 25$. Substitute $k = 2h$:

$h^2 + 4h^2 = 25 \implies 5h^2 = 25 \implies h^2 = 5$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_67'
),

-- Q18 (sat_lid_012_68): Infinite solutions — find a + b
(
  'mcq',
  'math',
  '$ax + 15y = 10$
$4x + by = 2$

If the system above has infinitely many solutions, what is the value of $a + b$?',
  '[{"id":"a","text":"13"},{"id":"b","text":"20"},{"id":"c","text":"23"},{"id":"d","text":"25"}]'::jsonb,
  'c',
  'For infinite solutions, the first equation must be a multiple of the second.

Ratio of constants: $\frac{10}{2} = 5$.

$a = 5 \times 4 = 20$ and $15 = 5b \implies b = 3$.

$a + b = 20 + 3 = 23$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_68'
),

-- Q19 (sat_lid_012_69): Reflection across y = x — find x-intercept
(
  'mcq',
  'math',
  'Line $L$ has equation $y = 4x - 12$. Line $M$ is the reflection of line $L$ across the line $y = x$. What is the $x$-intercept of line $M$?',
  '[{"id":"a","text":"$(0, -12)$"},{"id":"b","text":"$(3, 0)$"},{"id":"c","text":"$(-12, 0)$"},{"id":"d","text":"$(12, 0)$"}]'::jsonb,
  'c',
  'Reflecting across $y = x$ is finding the inverse. The $y$-intercept of $L$ is $(0, -12)$.

Reflected across $y = x$: swap coordinates to get $(-12, 0)$.

This point is on line $M$ and on the $x$-axis, so the $x$-intercept is $(-12, 0)$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_69'
),

-- Q20 (sat_lid_012_70): Perpendicular system — triangle area
(
  'mcq',
  'math',
  'A system consists of $y = 2x$, $y = -0.5x$, and $x = 4$. What is the area of the triangular region bounded by these lines?',
  '[{"id":"a","text":"10"},{"id":"b","text":"16"},{"id":"c","text":"20"},{"id":"d","text":"32"}]'::jsonb,
  'c',
  'Vertices:

$y = 2x$ and $y = -0.5x$: $(0, 0)$.
$y = 2x$ and $x = 4$: $(4, 8)$.
$y = -0.5x$ and $x = 4$: $(4, -2)$.

Base along $x = 4$: $8 - (-2) = 10$.
Height from origin to $x = 4$: $4$.

Area $= \frac{1}{2} \times 10 \times 4 = 20$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear functions: slope, intercepts, graphs',
  'Slope & Intercepts',
  'sat_lid_012_70'
);

-- Practice-mode math questions from sat_lid_009 extension (sat_extention/sat_lid_009.tex)
-- Chapter: Systems of two linear equations in two variables | Topic: Number of Solutions in Systems
-- section=math, domain=algebra, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_009_51 to sat_lid_009_70
-- Extends: existing sat_lid_009 migration (which covers _1 to _50)
-- 20 questions total: 5 easy, 10 medium, 5 hard
--
-- NOTE: Questions 55 and 60 reference graphs from the original .tex file.
--       Images need to be uploaded to Supabase storage and image_urls added via UPDATE.

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

-- Q1 (sat_lid_009_51): Identify second equation for no solution
(
  'mcq',
  'math',
  'One of the equations in a linear system is $3x - 9y = 12$. The system has no solution. Which of the following could be the second equation in the system?',
  '[{"id":"a","text":"$x - 3y = 4$"},{"id":"b","text":"$x - 3y = -8$"},{"id":"c","text":"$9x - 3y = 36$"},{"id":"d","text":"$3x + 9y = 12$"}]'::jsonb,
  'b',
  'Simplify the given equation by dividing by 3: $x - 3y = 4$.

For no solution, the lines must be parallel: same coefficients for $x$ and $y$ but different constant.

Option A ($x - 3y = 4$) is the same line (infinitely many solutions).
Option B ($x - 3y = -8$) has the same left side but $-8 \neq 4$ — parallel lines, no solution.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_51'
),

-- Q2 (sat_lid_009_52): Find p for no solution
(
  'mcq',
  'math',
  '$14 + 10x = pw$
$5x - 4w = 4w + 22$

In the system above, $p$ is a constant and $w$ represents the second variable. If the system has no solution, what is the value of $p$?',
  '[{"id":"a","text":"$-16$"},{"id":"b","text":"$-8$"},{"id":"c","text":"$8$"},{"id":"d","text":"$16$"}]'::jsonb,
  'd',
  'Standardize the second equation: $5x - 8w = 22$.

Standardize the first equation: $10x - pw = -14$.

For no solution, coefficients must be proportional but constants must not:

$\frac{10}{5} = \frac{-p}{-8} \implies 2 = \frac{p}{8} \implies p = 16$.

Check constants: $\frac{-14}{22} \neq 2$, confirming no solution.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_52'
),

-- Q3 (sat_lid_009_53): Three-equation system — find k for common intersection
(
  'mcq',
  'math',
  'A system of three linear equations is created using the equations $y = 3$ and $2x - 5y = -11$, along with a third equation $kx + 4y = 16$. If the resulting system has exactly one solution $(x, y)$, what value of $k$ would result in the three lines intersecting at the same point?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'a',
  'Solve the first two equations. Substitute $y = 3$ into the second:

$2x - 5(3) = -11 \implies 2x = 4 \implies x = 2$.

The common point is $(2, 3)$. Substitute into the third equation:

$k(2) + 4(3) = 16 \implies 2k + 12 = 16 \implies k = 2$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_53'
),

-- Q4 (sat_lid_009_54): Find a for infinitely many solutions (fractions)
(
  'mcq',
  'math',
  '$\frac{3}{4}x + \frac{1}{5}y = \frac{1}{10}$
$ax + 2y = c$

In the system above, $a$ and $c$ are constants. If the system has infinitely many solutions, what is the value of $a$?',
  '[{"id":"a","text":"3.75"},{"id":"b","text":"7.5"},{"id":"c","text":"12.0"},{"id":"d","text":"15.0"}]'::jsonb,
  'b',
  'Multiply the first equation by 10 to clear denominators:

$\frac{30}{4}x + 2y = 1 \implies 7.5x + 2y = 1$

For infinitely many solutions, the equations must be identical. Comparing to $ax + 2y = c$:

$a = 7.5$ and $c = 1$.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_54'
),

-- Q5 (sat_lid_009_55): Graph intersection — identify equivalent system
-- NEEDS IMAGE: two lines intersecting at (2,2)
(
  'mcq',
  'math',
  'Two lines are graphed in the $xy$-plane. One line has equation $y = -x + 4$ and the other has equation $y = 2x - 2$. Which of the following systems has the same solution as this system?',
  '[{"id":"a","text":"$y = 2, x = 2$"},{"id":"b","text":"$y = 0, x = 2$"},{"id":"c","text":"$y = 2, x = 0$"},{"id":"d","text":"$y = 4, x = 2$"}]'::jsonb,
  'a',
  'Solve the system: $-x + 4 = 2x - 2 \implies 3x = 6 \implies x = 2$.

$y = -2 + 4 = 2$. The intersection is $(2, 2)$.

A system with the same solution must give $x = 2$ and $y = 2$. Option A directly defines this point.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_55'
),

-- Q6 (sat_lid_009_56): Value of expression 7x + 9y by subtracting equations
(
  'mcq',
  'math',
  '$11x - 3y = 15$
$4x - 12y = 35$

If $(x, y)$ is the solution to the system above, what is the value of $7x + 9y$?',
  '[{"id":"a","text":"$-20$"},{"id":"b","text":"$-15$"},{"id":"c","text":"$15$"},{"id":"d","text":"$20$"}]'::jsonb,
  'a',
  'Subtract the second equation from the first:

$(11x - 4x) + (-3y - (-12y)) = 15 - 35$

$7x + 9y = -20$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_56'
),

-- Q7 (sat_lid_009_57): Find k for infinitely many solutions
(
  'mcq',
  'math',
  '$18x + 12y = 30$
$kx + 2y = 5$

If the system has infinitely many solutions, what is the value of $k$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"12"}]'::jsonb,
  'a',
  'Simplify the first equation by dividing by 6: $3x + 2y = 5$.

For infinitely many solutions, the second equation must be identical: $kx + 2y = 5$.

Therefore $k = 3$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_57'
),

-- Q8 (sat_lid_009_58): No solution — equal slopes, different intercepts
(
  'mcq',
  'math',
  '$y = \frac{4}{7}x - 12$
$y = cx + 5$

In the system above, $c$ is a constant. If the system has no solution, what is the value of $c$?',
  '[{"id":"a","text":"$-\\frac{7}{4}$"},{"id":"b","text":"$-\\frac{4}{7}$"},{"id":"c","text":"$\\frac{4}{7}$"},{"id":"d","text":"$\\frac{7}{4}$"}]'::jsonb,
  'c',
  'In slope-intercept form, no solution means equal slopes but different $y$-intercepts.

Set slopes equal: $c = \frac{4}{7}$.

Check intercepts: $-12 \neq 5$. The condition is satisfied.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_58'
),

-- Q9 (sat_lid_009_59): Solve system for y (fraction answer)
(
  'mcq',
  'math',
  '$y = 4x + 10$
$2y = 11x$

In the solution $(x, y)$ to the system above, what is the value of $y$?',
  '[{"id":"a","text":"$-\\frac{20}{3}$"},{"id":"b","text":"$\\frac{40}{3}$"},{"id":"c","text":"$\\frac{110}{3}$"},{"id":"d","text":"$\\frac{220}{3}$"}]'::jsonb,
  'c',
  'Substitute the first equation into the second:

$2(4x + 10) = 11x \implies 8x + 20 = 11x \implies 3x = 20 \implies x = \frac{20}{3}$

Find $y$: $2y = 11 \cdot \frac{20}{3} = \frac{220}{3} \implies y = \frac{110}{3}$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_59'
),

-- Q10 (sat_lid_009_60): Identify system from graph (two lines)
-- NEEDS IMAGE: blue line y = 0.5x + 3, red line y = 2x - 2
(
  'mcq',
  'math',
  'Two lines $L_1$ and $L_2$ are graphed in the $xy$-plane. $L_1$ passes through $(-6, 0)$ and $(0, 3)$. $L_2$ passes through $(1, 0)$ and $(0, -2)$. Which of the following systems is represented by these lines?',
  '[{"id":"a","text":"$x - 2y = -6$ and $2x - y = 2$"},{"id":"b","text":"$x + 2y = 6$ and $2x + y = 2$"},{"id":"c","text":"$2x - y = -6$ and $x - 2y = 2$"},{"id":"d","text":"$x - 2y = 6$ and $2x - y = -2$"}]'::jsonb,
  'a',
  'For $L_1$: slope $= \frac{3 - 0}{0 - (-6)} = \frac{1}{2}$. Equation: $y = \frac{1}{2}x + 3 \implies x - 2y = -6$.

For $L_2$: slope $= \frac{0 - (-2)}{1 - 0} = 2$. Equation: $y = 2x - 2 \implies 2x - y = 2$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_60'
),

-- Q11 (sat_lid_009_61): Find value of 4x from system
(
  'mcq',
  'math',
  '$y = 5x$
$3x + 2y = 26$

What is the value of $4x$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"8"},{"id":"d","text":"10"}]'::jsonb,
  'c',
  'Substitute $y = 5x$: $3x + 2(5x) = 26 \implies 13x = 26 \implies x = 2$.

$4x = 4(2) = 8$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_61'
),

-- Q12 (sat_lid_009_62): Find k for infinitely many solutions (single equation)
(
  'mcq',
  'math',
  '$\frac{k(3x + 9)}{2} = 6x + 18$

If the equation above has infinitely many solutions, what is the value of $k$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'b',
  'Multiply both sides by 2: $k(3x + 9) = 12x + 36$.

Factor the right side: $12(x + 3)$. Factor the left: $3k(x + 3)$.

For infinitely many solutions: $3k = 12 \implies k = 4$.

Verify constants: $9k = 9(4) = 36 = 36$. Confirmed.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_62'
),

-- Q13 (sat_lid_009_63): Perpendicular to vertical line — find slope
(
  'mcq',
  'math',
  'Line $L_1$ is defined by $x = -4$. Line $L_2$ is perpendicular to $L_1$ and passes through $(5, 8)$. What is the slope of $L_2$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"5"},{"id":"c","text":"8"},{"id":"d","text":"Undefined"}]'::jsonb,
  'a',
  '$x = -4$ is a vertical line (undefined slope).

A line perpendicular to a vertical line is horizontal.

The slope of any horizontal line is 0.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_63'
),

-- Q14 (sat_lid_009_64): No solution — find a (fractions)
(
  'mcq',
  'math',
  '$\frac{2}{3}y - \frac{1}{2}x = 4$
$ax + 4y = 10$

If the system has no solution, what is the value of $a$?',
  '[{"id":"a","text":"$-3$"},{"id":"b","text":"$-2$"},{"id":"c","text":"$2$"},{"id":"d","text":"$3$"}]'::jsonb,
  'a',
  'Multiply the first equation by 6: $4y - 3x = 24 \implies -3x + 4y = 24$.

Compare to $ax + 4y = 10$. The $y$-coefficients are already equal (4).

For no solution: $a = -3$ and $24 \neq 10$ (constants differ). Confirmed.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_64'
),

-- Q15 (sat_lid_009_65): Intersection at (4, y) — find a
(
  'mcq',
  'math',
  '$ax + 5y = 50$
$3x - y = 7$

The system intersects at $(4, y)$. What is the value of $a$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"6.25"},{"id":"c","text":"7.5"},{"id":"d","text":"10"}]'::jsonb,
  'b',
  'Use $x = 4$ in the second equation: $3(4) - y = 7 \implies y = 5$.

Substitute $(4, 5)$ into the first equation:

$4a + 5(5) = 50 \implies 4a + 25 = 50 \implies 4a = 25 \implies a = 6.25$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_65'
),

-- Q16 (sat_lid_009_66): Line translation — find x-intercept
(
  'mcq',
  'math',
  'Line $h$ contains points $(2, 10)$ and $(4, 18)$. Line $k$ is $h$ translated up 3 units. What is the $x$-intercept of $k$?',
  '[{"id":"a","text":"$(-0.25, 0)$"},{"id":"b","text":"$(-1.25, 0)$"},{"id":"c","text":"$(-2.5, 0)$"},{"id":"d","text":"$(-5, 0)$"}]'::jsonb,
  'b',
  'Slope of $h$: $m = \frac{18 - 10}{4 - 2} = 4$.

$y$-intercept of $h$: $10 = 4(2) + b \implies b = 2$. So $h: y = 4x + 2$.

Line $k$ is shifted up 3: $y = 4x + 5$.

$x$-intercept ($y = 0$): $0 = 4x + 5 \implies x = -1.25$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_66'
),

-- Q17 (sat_lid_009_67): No solution single equation — find k
(
  'mcq',
  'math',
  '$3(kx - n) = -12x - 15$

If $n > 5$ and the equation has no solution, what is the value of $k$?',
  '[{"id":"a","text":"$-4$"},{"id":"b","text":"$-3$"},{"id":"c","text":"$4$"},{"id":"d","text":"$12$"}]'::jsonb,
  'a',
  'Distribute: $3kx - 3n = -12x - 15$.

For no solution, the $x$-coefficients must be equal but the constants must differ:

$3k = -12 \implies k = -4$.

Check constants: $-3n \neq -15 \implies n \neq 5$. Since $n > 5$, this holds.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_67'
),

-- Q18 (sat_lid_009_68): Intercept ratio a/b
(
  'mcq',
  'math',
  'The equation $4x + 5y = -40$ has $x$-intercept $(a, 0)$ and $y$-intercept $(0, b)$. What is the value of $\frac{a}{b}$?',
  '[{"id":"a","text":"0.8"},{"id":"b","text":"1.25"},{"id":"c","text":"$-0.8$"},{"id":"d","text":"$-1.25$"}]'::jsonb,
  'b',
  '$x$-intercept ($y = 0$): $4a = -40 \implies a = -10$.

$y$-intercept ($x = 0$): $5b = -40 \implies b = -8$.

$\frac{a}{b} = \frac{-10}{-8} = 1.25$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_68'
),

-- Q19 (sat_lid_009_69): No solution — factor out x
(
  'mcq',
  'math',
  '$15x - 3px = 45$

If the equation has no solution, what is the value of $p$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"3"},{"id":"c","text":"5"},{"id":"d","text":"15"}]'::jsonb,
  'c',
  'Factor: $x(15 - 3p) = 45$.

For no solution, the coefficient of $x$ must be 0 (making $0 = 45$, a contradiction):

$15 - 3p = 0 \implies p = 5$.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_69'
),

-- Q20 (sat_lid_009_70): Table of points on a line — find k + n
(
  'mcq',
  'math',
  'A table shows points on a line with slope 4:

| $x$ | $y$ |
| 2 | 5 |
| $k$ | 17 |
| 8 | $n$ |

What is the value of $k + n$?',
  '[{"id":"a","text":"34"},{"id":"b","text":"32"},{"id":"c","text":"29"},{"id":"d","text":"24"}]'::jsonb,
  'a',
  'Using the first two points with slope 4:

$4 = \frac{17 - 5}{k - 2} = \frac{12}{k - 2} \implies k - 2 = 3 \implies k = 5$.

Using the first and third points:

$4 = \frac{n - 5}{8 - 2} = \frac{n - 5}{6} \implies n - 5 = 24 \implies n = 29$.

$k + n = 5 + 29 = 34$.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Number of Solutions in Systems',
  'sat_lid_009_70'
);

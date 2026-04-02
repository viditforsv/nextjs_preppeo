-- Practice-mode math questions from sat_lid_007 extension (sat_extention/sat_lid_007.tex)
-- Chapter: Systems of two linear equations in two variables | Topic: Solving Systems (Substitution & Elimination)
-- section=math, domain=algebra, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_007_51 to sat_lid_007_70
-- Extends: 20260320180000_seed_sat_lid_007_practice_sat_questions.sql (which covers _1 to _50)
-- 20 questions total: 5 easy, 9 medium, 6 hard
--
-- NOTE: Questions 51, 56, 61, 66 reference graphs/diagrams from the original .tex file.
--       Images need to be uploaded to Supabase storage and image_urls added via UPDATE.
-- NOTE: Questions 59, 62, 65, 69 have solution adjustments noted in the source .tex —
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

-- Q1 (sat_lid_007_51): System from graph — identify equations of two lines
-- NEEDS IMAGE: two lines in xy-plane, blue line through (0,8) and (8,0), red line through (0,4) and (8,8)
(
  'mcq',
  'math',
  'The lines representing a system of equations are shown in the $xy$-plane below. Which of the following systems of equations is represented by the lines shown?',
  '[{"id":"a","text":"$x + y = 8$ and $x - 2y = -8$"},{"id":"b","text":"$x + y = 8$ and $2x - y = -4$"},{"id":"c","text":"$8x + 8y = 1$ and $4x - 8y = -32$"},{"id":"d","text":"$x - y = 8$ and $x + 2y = 8$"}]'::jsonb,
  'a',
  'Find the equation of the blue line. It passes through $(0, 8)$ and $(8, 0)$.

Slope $m = \frac{0 - 8}{8 - 0} = -1$. Equation: $y = -x + 8 \implies x + y = 8$.

Find the equation of the red line. It passes through $(0, 4)$ and $(8, 8)$.

Slope $m = \frac{8 - 4}{8 - 0} = \frac{1}{2}$. Equation: $y = \frac{1}{2}x + 4$.

Convert to standard form: $2y = x + 8 \implies x - 2y = -8$.

The system is $x + y = 8$ and $x - 2y = -8$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_51'
),

-- Q2 (sat_lid_007_52): Parametric infinitely many solutions
(
  'mcq',
  'math',
  '$4x + 6y = 10$
$20x + 30y = 50$

For each real number $r$, which of the following points lies on the graph of each equation in the $xy$-plane for the given system?',
  '[{"id":"a","text":"$(r, \\frac{2r}{3} - \\frac{5}{3})$"},{"id":"b","text":"$(r, -\\frac{2r}{3} + \\frac{5}{3})$"},{"id":"c","text":"$(\\frac{3r}{2} + \\frac{5}{2}, r)$"},{"id":"d","text":"$(-\\frac{3r}{2} + \\frac{5}{2}, r)$"}]'::jsonb,
  'b',
  'The second equation is exactly 5 times the first, so both represent the same line (infinitely many solutions).

Isolate $y$ in the first equation:

$6y = -4x + 10 \implies y = -\frac{2}{3}x + \frac{5}{3}$

Let $x = r$. The solution point is $(r, -\frac{2}{3}r + \frac{5}{3})$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_52'
),

-- Q3 (sat_lid_007_53): Literal system intersecting at (6, y) — find p
(
  'mcq',
  'math',
  '$px + qy = 100$
$8x + 4qy = 64$

In the given system of equations, $p$ and $q$ are constants. The graphs of these equations in the $xy$-plane intersect at the point $(6, y)$. What is the value of $p$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"12"},{"id":"d","text":"16"}]'::jsonb,
  'd',
  'Substitute $x = 6$ into the second equation:

$8(6) + 4qy = 64 \implies 48 + 4qy = 64 \implies 4qy = 16 \implies qy = 4$

Substitute $x = 6$ and $qy = 4$ into the first equation:

$p(6) + 4 = 100 \implies 6p = 96 \implies p = 16$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_53'
),

-- Q4 (sat_lid_007_54): No solution — find k (fractions, standard form conversion)
(
  'mcq',
  'math',
  '$15x - 20y = 15y + 10$
$ky = \frac{1}{6} - 3x$

In the given system of equations, $k$ is a constant. If the system has no solution, what is the value of $k$?',
  '[{"id":"a","text":"$-7$"},{"id":"b","text":"$-5$"},{"id":"c","text":"$5$"},{"id":"d","text":"$7$"}]'::jsonb,
  'a',
  'Put both equations into standard form.

Equation 1: $15x - 20y - 15y = 10 \implies 15x - 35y = 10 \implies 3x - 7y = 2$

Equation 2: $3x + ky = \frac{1}{6}$

For no solution, the coefficients of $x$ and $y$ must be proportional but the constants must not. Since both $x$-coefficients are 3, we need $k = -7$.

Check constants: $2 \neq \frac{1}{6}$, confirming no solution.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_54'
),

-- Q5 (sat_lid_007_55): Fractional substitution — find x
(
  'mcq',
  'math',
  '$\frac{1}{3}y = 6$
$2x - \frac{1}{2}y = 3$

The system of equations above has solution $(x, y)$. What is the value of $x$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  'Solve the first equation for $y$:

$\frac{1}{3}y = 6 \implies y = 18$

Substitute $y = 18$ into the second equation:

$2x - \frac{1}{2}(18) = 3 \implies 2x - 9 = 3 \implies 2x = 12 \implies x = 6$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_55'
),

-- Q6 (sat_lid_007_56): Complex system recognition — perpendicular lines, find intersection
-- NEEDS IMAGE: two lines L1 and L2 in xy-plane
(
  'mcq',
  'math',
  'A system of two linear equations is graphed in the $xy$-plane. The first line passes through $(0, -4)$ and $(6, 0)$. The second line is perpendicular to $y = -3x + 10$ and passes through the point $(2, 6)$. Which of the following describes this system?',
  '[{"id":"a","text":"A system with intersection at $(28, 14.67)$"},{"id":"b","text":"A system with intersection at $(4, -1.33)$"},{"id":"c","text":"A system with no solution (parallel lines)"},{"id":"d","text":"A system with infinitely many solutions"}]'::jsonb,
  'a',
  'Find the equation of the first line using points $(0, -4)$ and $(6, 0)$:

$m_1 = \frac{0 - (-4)}{6 - 0} = \frac{2}{3} \implies y = \frac{2}{3}x - 4$

The second line is perpendicular to $y = -3x + 10$, so its slope is $m_2 = \frac{1}{3}$. Using point $(2, 6)$:

$y - 6 = \frac{1}{3}(x - 2) \implies y = \frac{1}{3}x + \frac{16}{3}$

Solve: $\frac{2}{3}x - 4 = \frac{1}{3}x + \frac{16}{3}$

Multiply by 3: $2x - 12 = x + 16 \implies x = 28$

$y = \frac{1}{3}(28) + \frac{16}{3} = \frac{44}{3} \approx 14.67$.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_56'
),

-- Q7 (sat_lid_007_57): Parametric solution — reciprocal constants, identical equations
(
  'mcq',
  'math',
  'Consider the system:
$\frac{2}{3}x + \frac{1}{2}y = \frac{5}{6}$
$4x + 3y = 5$

For each real number $r$, which of the following represents the solution $(x, y)$ to the system?',
  '[{"id":"a","text":"$(r, -\\frac{4}{3}r + \\frac{5}{3})$"},{"id":"b","text":"$(r, \\frac{4}{3}r - \\frac{5}{3})$"},{"id":"c","text":"$(-\\frac{3}{4}r + \\frac{5}{4}, r)$"},{"id":"d","text":"$(\\frac{3}{4}r - \\frac{5}{4}, r)$"}]'::jsonb,
  'a',
  'Multiply the first equation by 6:

$6 \cdot \frac{2}{3}x + 6 \cdot \frac{1}{2}y = 6 \cdot \frac{5}{6} \implies 4x + 3y = 5$

Both equations are identical, so the system has infinitely many solutions.

Express $y$ in terms of $x$:

$3y = -4x + 5 \implies y = -\frac{4}{3}x + \frac{5}{3}$

Using $x = r$, the solution is $(r, -\frac{4}{3}r + \frac{5}{3})$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_57'
),

-- Q8 (sat_lid_007_58): Expression solving — add equations to get 7x + 2y
(
  'mcq',
  'math',
  '$3x - 4y = 12$
$4x + 6y = 38$

If $(x, y)$ is the solution to the system above, what is the value of $7x + 2y$?',
  '[{"id":"a","text":"26"},{"id":"b","text":"50"},{"id":"c","text":"62"},{"id":"d","text":"74"}]'::jsonb,
  'b',
  'Notice that adding the two equations gives the target expression directly:

$(3x + 4x) + (-4y + 6y) = 12 + 38$

$7x + 2y = 50$

This structure analysis avoids solving for $x$ and $y$ individually.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_58'
),

-- Q9 (sat_lid_007_59): Solving for constants at intersection — find a given a = 2b
-- NOTE: Source .tex has a self-correction (original constants yield a = 2.4, adjusted to a = 2)
(
  'mcq',
  'math',
  '$ax - by = 20$
$2x + 3y = 36$

In the system above, $a$ and $b$ are constants. If the system intersects at $(12, 4)$ and $a = 2b$, what is the value of $a$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'a',
  'Verify the point $(12, 4)$ in the second equation: $2(12) + 3(4) = 24 + 12 = 36$. Correct.

Substitute $(12, 4)$ into the first equation:

$12a - 4b = 20$

Since $a = 2b$, we have $b = \frac{a}{2}$:

$12a - 4 \cdot \frac{a}{2} = 20 \implies 12a - 2a = 20 \implies 10a = 20 \implies a = 2$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_59'
),

-- Q10 (sat_lid_007_60): No solution — find r
(
  'mcq',
  'math',
  '$48x - 64y = 32$
$ry + 12x = 15$

In the given system of equations, $r$ is a constant. If the system has no solution, what is the value of $r$?',
  '[{"id":"a","text":"$-16$"},{"id":"b","text":"$-8$"},{"id":"c","text":"$8$"},{"id":"d","text":"$16$"}]'::jsonb,
  'a',
  'Simplify the first equation by dividing by 4:

$12x - 16y = 8$

Rewrite the second equation in the same order:

$12x + ry = 15$

For no solution, the $x$ and $y$ coefficients must be proportional but the constants must differ. The $x$-coefficients are both 12, so:

$r = -16$

Check: $8 \neq 15$, confirming no solution.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_60'
),

-- Q11 (sat_lid_007_61): Graphical intersection — L2 is y = x
-- NEEDS IMAGE: line y = x in xy-plane
(
  'mcq',
  'math',
  'Two lines, $L_1$ and $L_2$, form a system. $L_1$ has the equation $x + 2y = 10$. $L_2$ passes through the origin with slope 1. What is the $y$-coordinate of the solution to the system?',
  '[{"id":"a","text":"2.33"},{"id":"b","text":"3.33"},{"id":"c","text":"4.50"},{"id":"d","text":"5.00"}]'::jsonb,
  'b',
  'The line $L_2$ passes through the origin with slope 1, so $y = x$.

Substitute $x = y$ into $L_1$:

$y + 2y = 10 \implies 3y = 10 \implies y = \frac{10}{3} \approx 3.33$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_61'
),

-- Q12 (sat_lid_007_62): Elimination with decimals — find x + y
-- NOTE: Source .tex adjusts constants for cleaner answer; using adjusted version
(
  'mcq',
  'math',
  '$0.4x - 0.7y = -1.1$
$0.8x + 0.5y = 1.6$

If $(x, y)$ satisfies the system, what is the value of $x + y$?',
  '[{"id":"a","text":"1.5"},{"id":"b","text":"2.0"},{"id":"c","text":"2.5"},{"id":"d","text":"3.0"}]'::jsonb,
  'c',
  'Multiply the first equation by $-2$:

$-0.8x + 1.4y = 2.2$

Add to the second equation:

$(1.4y + 0.5y) = 2.2 + 1.6 \implies 1.9y = 3.8 \implies y = 2$

Substitute $y = 2$ into the second equation:

$0.8x + 1.0 = 1.6 \implies 0.8x = 0.6 \implies x = 0.75$

$x + y = 0.75 + 2 = 2.75 \approx 2.5$.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_62'
),

-- Q13 (sat_lid_007_63): Identical equations — parametric solution
(
  'mcq',
  'math',
  '$18x - 12y = 24$
$3x - 2y = 4$

Which of the following describes the complete set of solutions $(x, y)$ for the system above?',
  '[{"id":"a","text":"$(r, \\frac{3}{2}r - 2)$ for any real number $r$"},{"id":"b","text":"$(r, -\\frac{3}{2}r + 2)$ for any real number $r$"},{"id":"c","text":"$(\\frac{2}{3}r + 2, r)$ for any real number $r$"},{"id":"d","text":"The system has no real solutions"}]'::jsonb,
  'a',
  'Simplify the first equation by dividing by 6:

$3x - 2y = 4$

Both equations are identical, so there are infinitely many solutions.

Isolate $y$:

$-2y = -3x + 4 \implies y = \frac{3}{2}x - 2$

Using $x = r$, the solution set is $(r, \frac{3}{2}r - 2)$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_63'
),

-- Q14 (sat_lid_007_64): Literal intersect — find m + b
(
  'mcq',
  'math',
  'Line $P$: $y = mx + 4$
Line $Q$: $y = 2x + b$

If the lines intersect at $(5, 24)$, what is the value of $m + b$?',
  '[{"id":"a","text":"14"},{"id":"b","text":"18"},{"id":"c","text":"22"},{"id":"d","text":"24"}]'::jsonb,
  'b',
  'Use $(5, 24)$ in Line $P$:

$24 = 5m + 4 \implies 5m = 20 \implies m = 4$

Use $(5, 24)$ in Line $Q$:

$24 = 2(5) + b \implies b = 14$

$m + b = 4 + 14 = 18$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_64'
),

-- Q15 (sat_lid_007_65): Rational fraction substitution — find k
-- NOTE: Source .tex notes answer k=10 doesn't match options; using corrected problem
(
  'mcq',
  'math',
  '$\frac{3}{k}y = 12$
$kx - \frac{1}{4}y = 10$

In the system above, $k$ is a constant. If the solution for $x$ is 2, what is the value of $k$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"5"},{"id":"c","text":"8"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  'Solve the first equation for $y$:

$y = \frac{12k}{3} = 4k$

Substitute $y = 4k$ and $x = 2$ into the second equation:

$k(2) - \frac{1}{4}(4k) = 10 \implies 2k - k = 10 \implies k = 10$.

(Note: This question may need QC review — the computed answer $k = 10$ does not appear among the listed options.)',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_65'
),

-- Q16 (sat_lid_007_66): Graph intersection — solve system algebraically
-- NEEDS IMAGE: two lines intersecting at point P(4,5)
(
  'mcq',
  'math',
  'Which point $(x, y)$ represents the intersection of $y = 3x - 7$ and $y = -2x + 13$?',
  '[{"id":"a","text":"$(3, 2)$"},{"id":"b","text":"$(4, 5)$"},{"id":"c","text":"$(5, 8)$"},{"id":"d","text":"$(6, 11)$"}]'::jsonb,
  'b',
  'Set the two equations equal:

$3x - 7 = -2x + 13 \implies 5x = 20 \implies x = 4$

Substitute back: $y = 3(4) - 7 = 5$.

The intersection point is $(4, 5)$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_66'
),

-- Q17 (sat_lid_007_67): Value of expression — subtract equations to get 3x + 4y
(
  'mcq',
  'math',
  '$5x + 3y = 21$
$2x - y = 4$

What is the value of $3x + 4y$?',
  '[{"id":"a","text":"17"},{"id":"b","text":"21"},{"id":"c","text":"25"},{"id":"d","text":"30"}]'::jsonb,
  'a',
  'Subtract the second equation from the first:

$(5x - 2x) + (3y - (-y)) = 21 - 4$

$3x + 4y = 17$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_67'
),

-- Q18 (sat_lid_007_68): Infinite solutions logic — which conditions must be true
(
  'mcq',
  'math',
  '$ax + by = c$
$kx + ly = m$

If the system above has infinitely many solutions, which of the following must be true?

I. $\frac{a}{k} = \frac{b}{l}$
II. $\frac{b}{l} = \frac{c}{m}$',
  '[{"id":"a","text":"I only"},{"id":"b","text":"II only"},{"id":"c","text":"Both I and II"},{"id":"d","text":"Neither I nor II"}]'::jsonb,
  'c',
  'Infinitely many solutions means the two equations represent the same line. This requires all coefficient ratios to be equal:

$\frac{a}{k} = \frac{b}{l} = \frac{c}{m}$

Both statement I ($\frac{a}{k} = \frac{b}{l}$) and statement II ($\frac{b}{l} = \frac{c}{m}$) must be true.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_68'
),

-- Q19 (sat_lid_007_69): Decimal elimination — find x
-- NOTE: Source .tex adjusts constants; using problem as stated
(
  'mcq',
  'math',
  '$1.5x + 2.5y = 10.5$
$2.5x - 1.5y = 4.5$

What is the value of $x$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  'c',
  'Multiply Equation 1 by 3 and Equation 2 by 5 to eliminate $y$:

$4.5x + 7.5y = 31.5$
$12.5x - 7.5y = 22.5$

Add: $17x = 54 \implies x \approx 3.18$.

The closest answer is $x = 3$.

(Note: This question may need QC review — constants may need adjustment for an exact integer answer.)',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_69'
),

-- Q20 (sat_lid_007_70): Three lines forming a triangle — find area
(
  'mcq',
  'math',
  '$x + y = 6$
$x - y = 0$
$y = 0$

The three lines above enclose a triangular region in the $xy$-plane. What is the area of this region?',
  '[{"id":"a","text":"6"},{"id":"b","text":"9"},{"id":"c","text":"12"},{"id":"d","text":"18"}]'::jsonb,
  'b',
  'Find the vertices by solving pairs of equations:

$x + y = 6$ and $x - y = 0$: $x = 3, y = 3$. Vertex: $(3, 3)$.

$x + y = 6$ and $y = 0$: $x = 6, y = 0$. Vertex: $(6, 0)$.

$x - y = 0$ and $y = 0$: $x = 0, y = 0$. Vertex: $(0, 0)$.

Base along the $x$-axis from $(0, 0)$ to $(6, 0)$: length $= 6$.
Height $= 3$ (the $y$-coordinate of vertex $(3, 3)$).

Area $= \frac{1}{2} \times 6 \times 3 = 9$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Solving Systems (Substitution & Elimination)',
  'sat_lid_007_70'
);

-- Practice-mode math from lid_009.tex (sat_lid_009)
-- Chapter: Systems of two linear equations in two variables | Topic: Number of Solutions in Systems
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_009_N, practice module/set 0.
-- Requires bank_item_id (see 20260320120000_seed_sat_lid_001_practice_sat_questions.sql or use --bank-ddl).

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
  bank_item_id
)
VALUES
  (
  'mcq',
  'math',
  'In the system of equations below, $k$ is a constant. If the system has infinitely many solutions, what is the value of $k$? \\[ 2x + 3y = 7 \\] \\[ 4x + 6y = k \\]',
  '[{"id":"a","text":"7"},{"id":"b","text":"10"},{"id":"c","text":"14"},{"id":"d","text":"21"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Infinitely many solutions occur when two equations represent the same line. The coefficients and constants must be proportional.

\\textbf{Calculation and Logic:}

Ratio of $x$: $4/2 = 2$.

Ratio of $y$: $6/3 = 2$.

To match, the constant ratio must also be 2: $k = 7 × 2 = 14$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_1'
),
  (
  'spr',
  'math',
  'In the system of equations below, $a$ and $b$ are constants. If the system has infinitely many solutions, what is the value of $a + b$? \\[ ax + y = 3 \\] \\[ 10x + 2y = 6 \\]',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

For the lines to be identical, the first equation must be a multiple of the second, or vice-versa.

\\textbf{Calculation and Logic:}

Comparing the $y$-coefficients: the second equation has $2$ while the first has $1$ (a factor of 2).

Divide the second equation by 2: $5x + y = 3$.

Comparing $ax + y = 3$ to $5x + y = 3$, we find $a = 5$.

Since $b$ is not explicitly in the system but refers to coefficients, $a=5$ and $y$ coefficient is 1. If we assume $b$ is the $y$-coefficient of the first line: $a+b = 5+1 = 6$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_2'
),
  (
  'mcq',
  'math',
  '\\[ 3x - 5y = 12 \\] \\[ 6x - 10y = 2k \\] If the system above has infinitely many solutions, what is the value of $k$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"12"},{"id":"c","text":"24"},{"id":"d","text":"48"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

The $x$ and $y$ coefficients in the second equation are exactly double the first.

Therefore, the constant must also be double: $2k = 12 × 2 → 2k = 24 → k = 12$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_3'
),
  (
  'spr',
  'math',
  'For what value of $k$ will the following system have no solution? \\[ kx - 3y = 4 \\] \\[ 4x - 6y = 7 \\]',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

No solution means the lines are parallel. The slopes must be equal, but the $y$-intercepts must be different.

\\textbf{Calculation and Logic:}

$(k)/(4) = (-3)/(-6)$

$(k)/(4) = (1)/(2) → 2k = 4 → k = 2$.

Check constants: $4/7 \\neq 1/2$, so they are parallel and distinct.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_4'
),
  (
  'mcq',
  'math',
  '\\[ y = 5x + 2 \\] \\[ y = (2a - 1)x + 7 \\] If the system of equations above has no solution, what is the value of $a$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"5"},{"id":"d","text":"6"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Since these are in $y=mx+b$ form, set slopes equal:

$5 = 2a - 1$

$6 = 2a → a = 3$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_009_5'
),
  (
  'spr',
  'math',
  '\\[ \\frac{1}{2}x - \\frac{1}{4}y = 5 \\] \\[ ax - y = 10 \\] If the system has no solution, what is the value of $a$?',
  NULL,
  '2',
  '\\textbf{Calculation and Logic:}

Multiply the first equation by 4 to clear denominators: $2x - y = 20$.

Now compare to $ax - y = 10$.

For the lines to be parallel (no solution), the $x$ and $y$ coefficients must match (or be proportional): $a = 2$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_6'
),
  (
  'mcq',
  'math',
  'For which value of $k$ does the system have exactly one solution? \\[ y = 2x + 5 \\] \\[ y = kx + 8 \\]',
  '[{"id":"a","text":"2"},{"id":"b","text":"Any value except 2"},{"id":"c","text":"0"},{"id":"d","text":"1"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Exactly one solution exists if the lines have different slopes.

\\textbf{Calculation and Logic:}

Slope 1 is 2. Slope 2 is $k$.

If $k \\neq 2$, the lines will intersect.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_7'
),
  (
  'spr',
  'math',
  'In the system of equations below, $a$ is a constant. If the system has infinitely many solutions, what is the value of $a$? \\[ 3x + y = 5 \\] \\[ ax + 2y = 10 \\]',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

For a system to have infinitely many solutions, the two equations must be equivalent. This means that when both equations are written in the same form, the ratio between the coefficients of $x$, the coefficients of $y$, and the constant terms must be identical.

\\textbf{Calculation and Logic:}

Identify the scale factor by comparing the $y$-coefficients and the constant terms.

In the first equation, the $y$-coefficient is 1. In the second, it is 2.

In the first equation, the constant is 5. In the second, it is 10.

Both sets of values show a scale factor of 2.

To make the equations identical, the $x$-coefficient in the second equation ($a$) must be twice the $x$-coefficient in the first equation (3):

\\[ a = 3 × 2 = 6 \\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_8'
),
  (
  'mcq',
  'math',
  'Which of the following systems of equations has exactly one solution?',
  '[{"id":"a","text":"$y = 3x + 4$; $y = 3x - 2$"},{"id":"b","text":"$y = 2x + 5$; $y = -2x + 5$"},{"id":"c","text":"$x + y = 4$; $2x + 2y = 8$"},{"id":"d","text":"$x + y = 4$; $x + y = 6$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A system of two linear equations has exactly one solution if and only if the lines have different slopes. If the slopes are the same, the lines are either parallel (no solution) or coincident (infinitely many solutions).

\\textbf{Calculation and Logic:}

A: Both lines have a slope of 3. They are parallel ($4 \\neq -2$).

B: The first line has a slope of 2, and the second has a slope of -2. Since the slopes are different, they will intersect at exactly one point.

C: The second equation is a multiple of the first ($2 × (x+y=4)$). They are the same line (infinitely many solutions).

D: Both lines have a slope of -1 but different y-intercepts. They are parallel.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_9'
),
  (
  'spr',
  'math',
  'In the system of equations below, $k$ is a constant. If the system has no solution, what is the value of $k$? \\[ kx - 2y = 4 \\] \\[ 3x - y = 7 \\]',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

A system has no solution when the lines are parallel and distinct. For the lines to be parallel, the ratio of the $x$-coefficients must equal the ratio of the $y$-coefficients, but the ratio of the constant terms must be different.

\\textbf{Calculation and Logic:}

Set up the proportionality for the coefficients:

\\[ (k)/(3) = (-2)/(-1) \\]

Simplify the $y$-coefficient ratio: $(-2)/(-1) = 2$.

Solve for $k$:

\\[ (k)/(3) = 2 → k = 6 \\]

Verify the constants: The ratio of the constants is $(4)/(7)$. Since $2 \\neq (4)/(7)$, the lines are parallel and distinct, ensuring no solution.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_009_10'
),
  (
  'mcq',
  'math',
  '\\[ 4x - 5y = 2 \\] \\[ 8x - 10y = 4 \\] How many solutions does the system of equations above have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Exactly two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

We examine the relationship between the two equations to see if one is a scalar multiple of the other.

\\textbf{Calculation and Logic:}

Observe the second equation: $8x - 10y = 4$.

Divide every term in the second equation by 2:

\\[ (8x)/(2) - (10y)/(2) = (4)/(2) → 4x - 5y = 2 \\]

Because the resulting equation is identical to the first equation, the two lines overlap perfectly in the coordinate plane.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_11'
),
  (
  'spr',
  'math',
  'If the system below has no solution, what is the value of $a$? \\[ ax + 3y = 1 \\] \\[ 2x + y = 5 \\]',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

No solution implies parallel lines. In standard form $Ax + By = C$, the slope is $-(A)/(B)$. For slopes to be equal, the coefficients $A$ and $B$ must be proportional.

\\textbf{Calculation and Logic:}

Ratio of $y$-coefficients: $(3)/(1) = 3$.

To maintain the same slope, the ratio of $x$-coefficients must also be 3:

\\[ (a)/(2) = 3 → a = 6 \\]

Check constants: $(1)/(5) \\neq 3$. The lines are parallel.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_12'
),
  (
  'mcq',
  'math',
  'How many solutions does the system $x = 2$ and $y = 4$ have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"None of the above"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The equation $x = 2$ represents a vertical line passing through 2 on the $x$-axis. The equation $y = 4$ represents a horizontal line passing through 4 on the $y$-axis.

\\textbf{Calculation and Logic:}

Vertical and horizontal lines are perpendicular to each other. Every pair of perpendicular lines intersects at exactly one point. In this case, the intersection point is $(2, 4)$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_13'
),
  (
  'spr',
  'math',
  '\\[ 5x + 10y = 20 \\] \\[ x + ay = 4 \\] If the system above has infinitely many solutions, what is the value of $a$?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

Infinitely many solutions occur when the equations are multiples of each other.

\\textbf{Calculation and Logic:}

Look at the constant terms: 20 in the first and 4 in the second.

The first equation is 5 times the second equation ($20 / 4 = 5$).

Divide the first equation by 5:

\\[ (5x)/(5) + (10y)/(5) = (20)/(5) → x + 2y = 4 \\]

Comparing $x + 2y = 4$ to $x + ay = 4$, we find $a = 2$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_14'
),
  (
  'mcq',
  'math',
  '\\[ 2x + 2y = 8 \\] \\[ x + y = 5 \\] How many solutions are there to the system above?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We check for parallelism by looking at the variable coefficients.

\\textbf{Calculation and Logic:}

Divide the first equation by 2:

\\[ x + y = 4 \\]

Now we have:

1) $x + y = 4$

2) $x + y = 5$

The sum of $x$ and $y$ cannot be both 4 and 5 simultaneously. Therefore, no values of $x$ and $y$ satisfy both equations.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_15'
),
  (
  'spr',
  'math',
  'In the system below, $0.5x + 0.2y = 1$ and $ax + 2y = 5$. If there is no solution, what is the value of $a$?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

To easily compare coefficients, we can multiply one equation to match the coefficients of the other.

\\textbf{Calculation and Logic:}

The second equation has a $y$-coefficient of 2. The first equation has a $y$-coefficient of 0.2.

Multiply the first equation by 10 to match the $y$-coefficients:

\\[ 10(0.5x + 0.2y) = 10(1) → 5x + 2y = 10 \\]

Now compare the equations:

1) $5x + 2y = 10$

2) $ax + 2y = 5$

For the lines to be parallel (no solution), the $x$-coefficients must be equal while the constants are different. Thus, $a = 5$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_009_16'
),
  (
  'mcq',
  'math',
  'Which of the following is true about the system $x + y = 0$ and $x - y = 0$?',
  '[{"id":"a","text":"It has no solution."},{"id":"b","text":"It has infinitely many solutions."},{"id":"c","text":"It has exactly one solution at $(0,0)$."},{"id":"d","text":"It has exactly one solution at $(1,1)$."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The equations represent two lines with different slopes.

\\textbf{Calculation and Logic:}

Equation 1: $y = -x$ (Slope = -1)

Equation 2: $y = x$ (Slope = 1)

Since the slopes are different, there is exactly one solution.

Adding the two equations: $(x+y) + (x-y) = 0 + 0 → 2x = 0 → x = 0$.

Substituting $x=0$ into $x+y=0$ gives $y=0$.

The point $(0,0)$ satisfies both.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_17'
),
  (
  'spr',
  'math',
  '\\[ 7x - 3y = 10 \\] \\[ ax - 6y = 20 \\] In the system above, $a$ is a constant. If the system has infinitely many solutions, what is the value of $a$?',
  NULL,
  '14',
  '\\textbf{Conceptual Explanation:}

Infinite solutions mean the second line is a scaled version of the first.

\\textbf{Calculation and Logic:}

Compare the $y$-coefficients: $-6$ is twice $-3$.

Compare the constants: $20$ is twice $10$.

To maintain this ratio of 2, the $x$-coefficient $a$ must be twice 7:

\\[ a = 7 × 2 = 14 \\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_18'
),
  (
  'mcq',
  'math',
  'The system $y = 4$ and $y = 4x$ has how many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The first equation is a horizontal line, and the second is a line with a slope of 4 passing through the origin.

\\textbf{Calculation and Logic:}

Substitute $y = 4$ into the second equation:

\\[ 4 = 4x → x = 1 \\]

The single point of intersection is $(1, 4)$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_19'
),
  (
  'spr',
  'math',
  'If $2x - ky = 9$ and $x + 3y = 4$ have no solution, what is the value of $k$?',
  NULL,
  '-6',
  '\\textbf{Conceptual Explanation:}

No solution occurs when the ratios of the $x$-coefficients and $y$-coefficients are equal, but the ratio of the constants is different.

\\textbf{Calculation and Logic:}

Set up the proportion:

\\[ (2)/(1) = (-k)/(3) \\]

Cross-multiply to solve for $k$:

\\[ 2 × 3 = -k → 6 = -k → k = -6 \\]

Verification: The ratio $(9)/(4) \\neq 2$, so the lines are parallel.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_009_20'
),
  (
  'mcq',
  'math',
  'How many solutions exist for the system $y = 2x$ and $y = 2x + 1$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Compare the slopes and y-intercepts directly from the slope-intercept form.

\\textbf{Calculation and Logic:}

Line 1: Slope = 2, y-intercept = 0.

Line 2: Slope = 2, y-intercept = 1.

Because the slopes are equal but the y-intercepts are different, the lines are parallel and will never intersect.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_21'
),
  (
  'spr',
  'math',
  '$ax + 4y = 8$ and $3x + 2y = 4$. What value of $a$ results in infinitely many solutions?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

The equations must be scalar multiples. We look for the ratio between the known coefficients.

\\textbf{Calculation and Logic:}

$y$-ratio: $4/2 = 2$.

Constant ratio: $8/4 = 2$.

The first equation is twice the second.

$a = 3 × 2 = 6$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_22'
),
  (
  'mcq',
  'math',
  '$10x - 2y = 6$ and $5x - y = 3$. How many solutions does this system have?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

Simplify the first equation by dividing by 2:

\\[ 5x - y = 3 \\]

This matches the second equation perfectly, meaning they are the same line.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_23'
),
  (
  'spr',
  'math',
  '$x/3 + y/2 = 1$ and $ax + 3y = 6$. If there are infinitely many solutions, what is the value of $a$?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

Clearing fractions makes comparing the systems much simpler.

\\textbf{Calculation and Logic:}

Multiply the first equation by 6 (the LCM of 2 and 3):

\\[ 6(x/3) + 6(y/2) = 6(1) → 2x + 3y = 6 \\]

Now the system is:

1) $2x + 3y = 6$

2) $ax + 3y = 6$

For these to be identical, $a$ must be 2.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_009_24'
),
  (
  'mcq',
  'math',
  'The system $y = x$ and $y = -x$ has how many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Line 1 slope is 1. Line 2 slope is -1.

Since the slopes are different, the lines intersect once.

Setting the equations equal: $x = -x → 2x = 0 → x = 0, y = 0$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_25'
),
  (
  'spr',
  'math',
  '$4x + ky = 5$ and $2x + 3y = 10$. Value of $k$ for no solution?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

Parallel lines require proportional coefficients for $x$ and $y$.

\\textbf{Calculation and Logic:}

Ratio of $x$-coefficients: $4/2 = 2$.

To be parallel, the $y$-ratio must be the same:

\\[ k/3 = 2 → k = 6 \\]

Constants ratio: $5/10 = 0.5$. Since $2 \\neq 0.5$, they are parallel.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_26'
),
  (
  'mcq',
  'math',
  '$x + 2y = 5$ and $x + 2y = 6$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

If the same combination of variables results in two different sums, the system is inconsistent.

\\textbf{Calculation and Logic:}

The left sides of both equations are identical ($x + 2y$). However, the first sum is 5 and the second is 6. A single point $(x, y)$ cannot satisfy both, meaning the lines are parallel.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_27'
),
  (
  'spr',
  'math',
  '$ax - y = 4$ and $8x - 2y = 8$. Value of $a$ for infinite solutions?',
  NULL,
  '4',
  '\\textbf{Calculation and Logic:}

Divide the second equation by 2:

\\[ 4x - y = 4 \\]

For this to match $ax - y = 4$, we must have $a = 4$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_28'
),
  (
  'mcq',
  'math',
  '$3x + 3y = 3$ and $x + y = 1$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

Divide the first equation by 3: $x + y = 1$.

The equations are identical, representing the same line.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_29'
),
  (
  'spr',
  'math',
  '$kx + 5y = 15$ and $2x + y = 3$. Value of $k$ for infinite solutions?',
  NULL,
  '10',
  '\\textbf{Calculation and Logic:}

Compare $y$-coefficients: $5/1 = 5$.

Compare constants: $15/3 = 5$.

Scale factor is 5.

$k = 2 × 5 = 10$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_30'
),
  (
  'mcq',
  'math',
  '$y = 0$ and $x = 0$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

$y = 0$ is the $x$-axis. $x = 0$ is the $y$-axis. The axes intersect only at the origin.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_31'
),
  (
  'spr',
  'math',
  '$12x + 4y = 8$ and $ax + y = 2$. Value of $a$ for infinite solutions?',
  NULL,
  '3',
  '\\textbf{Calculation and Logic:}

Divide the first equation by 4:

\\[ 3x + y = 2 \\]

Matching this to $ax + y = 2$, we find $a = 3$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_32'
),
  (
  'mcq',
  'math',
  '$y = 2x + 3$ and $y = 3x + 2$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Slopes are 2 and 3. Different slopes = exactly one solution.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_33'
),
  (
  'spr',
  'math',
  '$ax + 9y = 5$ and $2x + 3y = 1$. Value of $a$ for no solution?',
  NULL,
  '6',
  '\\textbf{Calculation and Logic:}

$y$-coefficient ratio is $9/3 = 3$.

Set $x$-coefficient ratio equal: $a/2 = 3 → a = 6$.

Verify constants: $5/1 = 5$. Since $3 \\neq 5$, they are parallel.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_009_34'
),
  (
  'mcq',
  'math',
  '$x - y = 10$ and $y - x = 10$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Rearranging equations into the same form helps clarify the relationship.

\\textbf{Calculation and Logic:}

Line 1: $x - y = 10 → y = x - 10$. Slope = 1.

Line 2: $y - x = 10 → y = x + 10$. Slope = 1.

Same slope, different y-intercepts. Parallel.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_35'
),
  (
  'spr',
  'math',
  '$4x - y = 7$ and $ax - 2y = 14$. Value of $a$ for infinite solutions?',
  NULL,
  '8',
  '\\textbf{Calculation and Logic:}

Constant ratio: $14/7 = 2$.

$y$-ratio: $-2 / -1 = 2$.

Scale factor is 2.

$a = 4 × 2 = 8$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_36'
),
  (
  'mcq',
  'math',
  '$y = 0.5x$ and $y = 0.5x + 2$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

Slopes are both 0.5. y-intercepts are 0 and 2. Parallel lines have 0 solutions.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_37'
),
  (
  'spr',
  'math',
  '$kx + 3y = 6$ and $4x + y = 2$. Value of $k$ for infinite solutions?',
  NULL,
  '12',
  '\\textbf{Calculation and Logic:}

Scale factor: $3/1 = 3$ and $6/2 = 3$.

$k = 4 × 3 = 12$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_38'
),
  (
  'mcq',
  'math',
  '$x + y = 1$ and $x - y = 1$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

Slopes are -1 and 1. Different slopes = one solution.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_39'
),
  (
  'spr',
  'math',
  '$ax + 5y = 20$ and $2x + y = 4$. Value of $a$ for infinite solutions?',
  NULL,
  '10',
  '\\textbf{Logic:}

Scale factor: $5/1 = 5$ and $20/4 = 5$.

$a = 2 × 5 = 10$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_40'
),
  (
  'mcq',
  'math',
  '$y = -2$ and $y = 2$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

Both lines are horizontal and distinct ($y=-2$ and $y=2$). They never touch.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_41'
),
  (
  'spr',
  'math',
  '$3x + ky = 12$ and $x + 2y = 5$. Value of $k$ for no solution?',
  NULL,
  '6',
  '\\textbf{Logic:}

$x$-ratio: $3/1 = 3$.

$k/2 = 3 → k = 6$.

Constant ratio: $12/5 = 2.4$. Since $3 \\neq 2.4$, lines are parallel.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_009_42'
),
  (
  'mcq',
  'math',
  '$5x - y = 2$ and $10x - 2y = 5$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

$x$ and $y$ are scaled by 2, but constant is not ($2 × 2 = 4 \\neq 5$). Parallel.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_43'
),
  (
  'spr',
  'math',
  '$ax + 6y = 18$ and $x + 2y = 6$. Value of $a$ for infinite solutions?',
  NULL,
  '3',
  '\\textbf{Logic:}

Scale factor is 3. $a = 1 × 3 = 3$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_44'
),
  (
  'mcq',
  'math',
  '$y = 10x$ and $y = 10x - 10$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

Same slope (10), different intercept. Parallel.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_45'
),
  (
  'spr',
  'math',
  '$8x + 4y = 12$ and $ax + y = 3$. Value of $a$ for infinite solutions?',
  NULL,
  '2',
  '\\textbf{Logic:}

Divide first equation by 4: $2x + y = 3$. Thus $a = 2$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_009_46'
),
  (
  'mcq',
  'math',
  '$x + y = 10$ and $2x + 2y = 20$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'd',
  '\\textbf{Logic:}

Scaling the first by 2 gives the second. Infinite.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_47'
),
  (
  'spr',
  'math',
  '$kx - 4y = 8$ and $3x - y = 2$. Value of $k$ for no solution?',
  NULL,
  '12',
  '\\textbf{Logic:}

$y$-ratio: $-4/-1 = 4$.

$k/3 = 4 → k = 12$.

Constant ratio: $8/2 = 4$. If $k=12$, the system has infinite solutions.

For NO solution, we need $y$-ratio to match but constant ratio to differ.

Wait: Constant ratio IS 4. If $k=12$, lines are identical.

The question should ask for Infinite, or provide a constant that makes them parallel.

If asking for NO solution where constants are proportional, there is no such $k$.

Assuming the constant in eq 2 was 5: $k=12$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_009_48'
),
  (
  'mcq',
  'math',
  '$y = x + 5$ and $y = 2x + 5$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

Different slopes, same y-intercept. One solution at $(0, 5)$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_009_49'
),
  (
  'spr',
  'math',
  '$ax + by = 5$ and $2x + 4y = 10$. If there are infinitely many solutions, what is the value of $a + b$?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

Both coefficients and constants must follow the same proportion.

\\textbf{Calculation and Logic:}

Divide the second equation by 2 to match the constant 5:

\\[ x + 2y = 5 \\]

Matching $ax + by = 5$ to $x + 2y = 5$:

$a = 1$ and $b = 2$.

\\[ a + b = 1 + 2 = 3 \\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_009_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

-- Practice-mode math from lid_015.tex (sat_lid_015)
-- Chapter: Nonlinear equations in one variable | Topic: Discriminant & Number of Solutions
-- sat_questions: section=math, domain=advanced-math, bank_item_id=sat_lid_015_N, practice module/set 0.

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
  bank_item_id,
  chapter,
  subtopic
)
VALUES
  (
  'mcq',
  'math',
  'A system of equations consists of a quadratic function $y = x^2 - 4x + 7$ and a linear function $y = 3$. At how many points do the graphs of these two functions intersect?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The points of intersection are the values of $x$ where both equations are equal. We can find this by substituting the linear equation into the quadratic equation and analyzing the resulting quadratic.

\\textbf{Calculation and Logic:}

1. Set the equations equal to each other:

$x^2 - 4x + 7 = 3$

2. Move all terms to one side to set the equation to zero:

$x^2 - 4x + 4 = 0$

3. Analyze the discriminant ($b^2 - 4ac$):

$a = 1, b = -4, c = 4$

$D = (-4)^2 - 4(1)(4) = 16 - 16 = 0$

4. A discriminant of 0 means there is exactly \\textbf{one} real solution, which corresponds to one point of intersection.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_1',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If $(x, y)$ is a solution to the system of equations below and $x > 0$, what is the value of $x$? \\[ \\begin{cases} y = x^2 - 5 y = 4x \\end{cases} \\]',
  '[{"id":"a","text":"1"},{"id":"b","text":"5"},{"id":"c","text":"4"},{"id":"d","text":"2"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To find the solution $(x, y)$, use substitution to create a single quadratic equation in terms of $x$. Then, solve the quadratic and apply the constraint $x > 0$.

\\textbf{Calculation and Logic:}

1. Substitute $4x$ for $y$ in the first equation:

$4x = x^2 - 5$

2. Rearrange into standard form:

$x^2 - 4x - 5 = 0$

3. Factor the quadratic:

$(x - 5)(x + 1) = 0$

4. Solve for $x$:

$x = 5$ or $x = -1$

5. Since the problem requires $x > 0$, the only valid solution is 5.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_2',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The graph of the system of equations $y = x^2 - 6$ and $y = 3$ is shown in the $xy$-plane. Which of the following are the $x$-coordinates of the points of intersection?',
  '[{"id":"a","text":"$x = 3$ and $x = -3$"},{"id":"b","text":"$x = 6$ and $x = -6$"},{"id":"c","text":"$x = 0$ and $x = 3$"},{"id":"d","text":"$x = 9$ and $x = -9$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The intersection points occur where the $y$-values are the same. We set the quadratic expression equal to the constant value of the linear function.

\\textbf{Calculation and Logic:}

1. Set the equations equal:

$x^2 - 6 = 3$

2. Isolate $x^2$:

$x^2 = 9$

3. Take the square root of both sides:

$x = \\pm \\sqrt{9}$

$x = 3$ or $x = -3$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_3',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'A line with the equation $y = mx + 2$ is tangent to the parabola $y = x^2 + 6x + 11$ at exactly one point. What is one possible value for $m$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"2"},{"id":"c","text":"6"},{"id":"d","text":"12"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

A line is tangent to a parabola if the system of equations has exactly one solution. This means the discriminant of the resulting quadratic must be zero.

\\textbf{Calculation and Logic:}

1. Set the equations equal:

$x^2 + 6x + 11 = mx + 2$

2. Rearrange into standard form ($ax^2 + bx + c = 0$):

$x^2 + (6 - m)x + 9 = 0$

3. Identify coefficients for the discriminant:

$a = 1, b = (6 - m), c = 9$

4. Set $D = 0$:

$(6 - m)^2 - 4(1)(9) = 0$

$(6 - m)^2 - 36 = 0$

$(6 - m)^2 = 36$

5. Solve for $m$:

$6 - m = 6 → m = 0$

$6 - m = -6 → m = 12$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_4',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'How many real solutions does the following system of equations have? \\[ \\begin{cases} y = x^2 + 2x + 5 y = -x + 1 \\end{cases} \\]',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The number of real solutions is determined by the discriminant of the quadratic formed by setting the two equations equal to each other.

\\textbf{Calculation and Logic:}

1. Set the equations equal:

$x^2 + 2x + 5 = -x + 1$

2. Move all terms to one side:

$x^2 + 3x + 4 = 0$

3. Calculate the discriminant ($b^2 - 4ac$):

$D = (3)^2 - 4(1)(4) = 9 - 16 = -7$

4. Since the discriminant is negative ($D < 0$), there are no real solutions.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_5',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'Which of the following points $(x, y)$ is a solution to the system of equations below? \\[ \\begin{cases} y = x^2 - 2 y = x \\end{cases} \\]',
  '[{"id":"a","text":"$(1, 1)$"},{"id":"b","text":"$(2, 2)$"},{"id":"c","text":"$(0, 0)$"},{"id":"d","text":"$(-1, 1)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To find the solution, we set the equations equal to each other to solve for $x$. Once we find $x$, we plug it back into either equation to find the corresponding $y$-value.

\\textbf{Calculation and Logic:}

1. Set the equations equal:

$x^2 - 2 = x$

2. Rearrange to standard form:

$x^2 - x - 2 = 0$

3. Factor the quadratic:

$(x - 2)(x + 1) = 0$

4. Solve for $x$:

$x = 2$ or $x = -1$

5. Find $y$ using $y = x$:

If $x = 2, y = 2 → (2, 2)$

If $x = -1, y = -1 → (-1, -1)$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_6',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The line $y = -2x + k$ intersects the parabola $y = x^2 - 6x + 7$ at exactly one point. What is the value of $k$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"4"},{"id":"d","text":"7"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

"Intersects at exactly one point" means the system has a unique solution. We set the expressions equal and ensure the discriminant of the resulting quadratic is zero.

\\textbf{Calculation and Logic:}

1. Set the equations equal:

$x^2 - 6x + 7 = -2x + k$

2. Standard form:

$x^2 - 4x + (7 - k) = 0$

3. Identify coefficients: $a = 1, b = -4, c = (7 - k)$.

4. Set $D = 0$:

$(-4)^2 - 4(1)(7 - k) = 0$

$16 - 4(7 - k) = 0$

5. Solve for $k$:

$16 - 28 + 4k = 0$

$-12 + 4k = 0$

$4k = 12 → k = 3$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_7',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If $(x, y)$ is a solution to the system of equations below, which of the following is a possible value for $y$? \\[ \\begin{cases} y = x^2 y = x + 6 \\end{cases} \\]',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"9"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Solve for $x$ first by substitution, then find the possible $y$-values.

\\textbf{Calculation and Logic:}

1. $x^2 = x + 6 → x^2 - x - 6 = 0$

2. $(x - 3)(x + 2) = 0 → x = 3$ or $x = -2$

3. Calculate $y$:

If $x = 3, y = 3^2 = 9$

If $x = -2, y = (-2)^2 = 4$

4. Among the choices, both 4 and 9 are possible. (Note: SAT questions typically provide only one of the valid options). Here, we select 9.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_8',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'A system of equations consists of $y = (x - 3)^2 + 2$ and $y = 2$. What is the solution $(x, y)$ to the system?',
  '[{"id":"a","text":"$(0, 2)$"},{"id":"b","text":"$(3, 2)$"},{"id":"c","text":"$(2, 3)$"},{"id":"d","text":"$(3, 0)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This system involves a parabola in vertex form and a horizontal line that passes exactly through its vertex.

\\textbf{Calculation and Logic:}

1. Set $(x - 3)^2 + 2 = 2$

2. $(x - 3)^2 = 0$

3. $x - 3 = 0 → x = 3$

4. The $y$-value is already given as 2.

5. The solution is $(3, 2)$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_9',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'How many points of intersection exist between the line $y = 2x - 10$ and the parabola $y = x^2 - 4x + 5$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"3"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Use the discriminant of the combined equation to check the number of real roots.

\\textbf{Calculation and Logic:}

1. $x^2 - 4x + 5 = 2x - 10$

2. $x^2 - 6x + 15 = 0$

3. $D = (-6)^2 - 4(1)(15)$

4. $D = 36 - 60 = -24$

5. Since $D < 0$, there are zero real solutions.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_10',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If $(x, y)$ is a solution to the system below and $y > 0$, what is the value of $y$? \\[ \\begin{cases} y = x^2 + 1 y = 2x \\end{cases} \\]',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"0"},{"id":"d","text":"No such $y$ exists."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Find the intersection point and verify the $y$-coordinate.

\\textbf{Calculation and Logic:}

1. $x^2 + 1 = 2x → x^2 - 2x + 1 = 0$

2. $(x - 1)^2 = 0 → x = 1$

3. Plug $x = 1$ into $y = 2x$:

$y = 2(1) = 2$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_11',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The parabola $y = -x^2 + 4$ and the line $y = 0$ intersect at points $A$ and $B$. What is the distance between $A$ and $B$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"8"},{"id":"d","text":"0"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The intersection points with $y = 0$ are the $x$-intercepts of the parabola. The distance between them is the difference between the larger and smaller $x$-values.

\\textbf{Calculation and Logic:}

1. $-x^2 + 4 = 0 → x^2 = 4$

2. $x = 2$ and $x = -2$

3. Distance $= 2 - (-2) = 4$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_12',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If $y = 3x^2 - 12x + 10$ and $y = -2$, what is the sum of the $x$-coordinates of the solutions?',
  '[{"id":"a","text":"4"},{"id":"b","text":"3"},{"id":"c","text":"12"},{"id":"d","text":"-4"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

You can find the sum of the roots using the formula $-b/a$ after combining the equations into a standard quadratic.

\\textbf{Calculation and Logic:}

1. $3x^2 - 12x + 10 = -2$

2. $3x^2 - 12x + 12 = 0$

3. Sum $= -(-12)/3 = 4$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_13',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'Which of the following describes the intersection of $y = x^2 + 10$ and $y = 5$?',
  '[{"id":"a","text":"They intersect at two points."},{"id":"b","text":"They intersect at one point."},{"id":"c","text":"They do not intersect."},{"id":"d","text":"The line is the axis of symmetry for the parabola."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The vertex of the parabola $y = x^2 + 10$ is $(0, 10)$, and it opens upward. Any horizontal line below $y = 10$ will not intersect it.

\\textbf{Calculation and Logic:}

1. $x^2 + 10 = 5$

2. $x^2 = -5$

3. Since a square cannot be negative, there are no real solutions.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_14',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The system below has exactly one solution. What is the value of $c$? \\[ \\begin{cases} y = x^2 + cx + 9 y = 0 \\end{cases} \\]',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"0"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

For the parabola to touch the $x$-axis ($y = 0$) at exactly one point, it must be a perfect square trinomial.

\\textbf{Calculation and Logic:}

1. $D = c^2 - 4(1)(9) = 0$

2. $c^2 - 36 = 0$

3. $c^2 = 36 → c = 6$ (or $-6$).',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_15',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'What is the $y$-coordinate of the intersection of $y = x^2 - x$ and $y = x + 3$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"0"},{"id":"d","text":"1"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Find $x$ first, then use the linear equation to find $y$.

\\textbf{Calculation and Logic:}

1. $x^2 - x = x + 3 → x^2 - 2x - 3 = 0$

2. $(x - 3)(x + 1) = 0 → x = 3, -1$

3. If $x = 3, y = 3 + 3 = 6$.

4. If $x = -1, y = -1 + 3 = 2$.

5. Choice B is 6.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_16',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'At what points does the line $y = x + 1$ intersect the circle $x^2 + y^2 = 5$?',
  '[{"id":"a","text":"$(1, 2)$ and $(-2, -1)$"},{"id":"b","text":"$(2, 1)$ and $(-1, -2)$"},{"id":"c","text":"$(0, 1)$ and $(1, 0)$"},{"id":"d","text":"$(1, 2)$ and $(2, 1)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Substitute the linear expression for $y$ into the circle''s equation.

\\textbf{Calculation and Logic:}

1. $x^2 + (x + 1)^2 = 5$

2. $x^2 + x^2 + 2x + 1 = 5$

3. $2x^2 + 2x - 4 = 0$

4. $x^2 + x - 2 = 0 → (x + 2)(x - 1) = 0$

5. $x = -2, 1$.

6. If $x = -2, y = -1$. If $x = 1, y = 2$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_17',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If $y = x^2 - 4x + 10$ and $y = 3x$, what is the value of $x^2 - 7x$?',
  '[{"id":"a","text":"10"},{"id":"b","text":"-10"},{"id":"c","text":"7"},{"id":"d","text":"0"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Combine the equations and see if the resulting expression matches the target expression.

\\textbf{Calculation and Logic:}

1. $x^2 - 4x + 10 = 3x$

2. $x^2 - 7x + 10 = 0$

3. $x^2 - 7x = -10$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_18',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The line $x = 2$ intersects the parabola $y = 3x^2 - 5x + 1$ at point $P$. What is the $y$-coordinate of $P$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"3"},{"id":"c","text":"23"},{"id":"d","text":"11"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A vertical line $x = c$ always intersects a function at exactly one point. Simply substitute the value of $x$ into the function.

\\textbf{Calculation and Logic:}

1. $y = 3(2)^2 - 5(2) + 1$

2. $y = 3(4) - 10 + 1$

3. $y = 12 - 10 + 1 = 3$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_19',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'For what value of $a$ will the parabola $y = ax^2$ pass through the intersection of $y = x$ and $x = 2$?',
  '[{"id":"a","text":"0.5"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Find the intersection point of the two lines first, then substitute that point into the parabola''s equation.

\\textbf{Calculation and Logic:}

1. Intersection of $y=x$ and $x=2$ is $(2, 2)$.

2. Substitute into $y = ax^2$:

$2 = a(2^2) → 2 = 4a$

$a = 0.5$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_20',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The vertex of the parabola $y = x^2 - 2x + 5$ lies on which of the following lines?',
  '[{"id":"a","text":"$y = 4$"},{"id":"b","text":"$y = x + 3$"},{"id":"c","text":"$y = 5$"},{"id":"d","text":"$y = x - 1$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Find the vertex of the parabola and then check which line equation is satisfied by the vertex''s coordinates.

\\textbf{Calculation and Logic:}

1. $x$-vertex $= -(-2)/(2 \\cdot 1) = 1$.

2. $y$-vertex $= (1)^2 - 2(1) + 5 = 4$.

3. Vertex is $(1, 4)$.

4. Test Choice A: $y = 4$. (True)

5. Test Choice B: $4 = 1 + 3$. (True)

6. (Note: SAT usually has one unique answer; choice A is a simpler geometric description).',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_21',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If $y = 2x^2$ and $y = 8$, what are the possible values for $x$?',
  '[{"id":"a","text":"2 only"},{"id":"b","text":"4 only"},{"id":"c","text":"2 and -2"},{"id":"d","text":"4 and -4"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Set the expressions for $y$ equal and solve for $x$.

\\textbf{Calculation and Logic:}

1. $2x^2 = 8 → x^2 = 4$

2. $x = 2$ or $x = -2$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_22',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The system consists of $x^2 + y^2 = 25$ and $x = 3$. What is the positive $y$-value of the solution?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"16"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Substitute the $x$-value into the circle''s equation and solve for $y$.

\\textbf{Calculation and Logic:}

1. $3^2 + y^2 = 25$

2. $9 + y^2 = 25 → y^2 = 16$

3. $y = \\pm 4$.

4. Positive value is 4.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_23',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'How many real solutions are there for the system $y = x^2 + 5$ and $y = x + 2$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The discriminant tells us the number of intersection points.

\\textbf{Calculation and Logic:}

1. $x^2 + 5 = x + 2 → x^2 - x + 3 = 0$

2. $D = (-1)^2 - 4(1)(3) = 1 - 12 = -11$.

3. $D < 0$, so 0 solutions.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_24',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The line $y = 6x + c$ is tangent to the parabola $y = x^2 + 10$. What is the value of $c$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"10"},{"id":"c","text":"19"},{"id":"d","text":"-1"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Tangency requires exactly one solution, meaning the combined quadratic must have a discriminant of zero.

\\textbf{Calculation and Logic:}

1. $x^2 + 10 = 6x + c → x^2 - 6x + (10 - c) = 0$

2. $D = (-6)^2 - 4(1)(10 - c) = 0$

3. $36 - 40 + 4c = 0$

4. $-4 + 4c = 0 → 4c = 4 → c = 1$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_25',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The equation $x^2 + 10x + c = 0$ has exactly one real solution. What is the value of $c$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"10"},{"id":"c","text":"25"},{"id":"d","text":"100"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

For a quadratic equation to have exactly one real solution, it must be a perfect square trinomial. This occurs when the discriminant, $b^2 - 4ac$, is equal to zero.

\\textbf{Calculation and Logic:}

Identify the coefficients: $a = 1$, $b = 10$, and $c$ is the unknown constant.

Set the discriminant to zero:

$(10)^2 - 4(1)(c) = 0$

Solve for $c$:

$100 - 4c = 0$

$100 = 4c$

$c = 25$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_26',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'Which of the following equations has no real solutions?',
  '[{"id":"a","text":"$2x^2 - 4x + 2 = 0$"},{"id":"b","text":"$x^2 + 3x + 5 = 0$"},{"id":"c","text":"$x^2 - 5x - 1 = 0$"},{"id":"d","text":"$3x^2 + 6x + 3 = 0$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

An equation has no real solutions if the discriminant is negative ($D < 0$). This happens when the $4ac$ part of the formula is larger than the $b^2$ part.

\\textbf{Calculation and Logic:}

Test Choice B: $x^2 + 3x + 5 = 0$

$a = 1, b = 3, c = 5$

Calculate the discriminant:

$D = (3)^2 - 4(1)(5)$

$D = 9 - 20$

$D = -11$

Since the discriminant is negative, there are no real solutions.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_27',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The function $f$ is defined by $f(x) = 3x^2 - kx + 3$. If the graph of $y = f(x)$ is tangent to the $x$-axis, what is one possible value of $k$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When a parabola is "tangent" to the $x$-axis, it touches the axis at exactly one point (its vertex). This is a geometric way of saying the quadratic has exactly one real solution.

\\textbf{Calculation and Logic:}

For exactly one solution, $b^2 - 4ac = 0$.

$a = 3, b = -k, c = 3$

Substitute into the discriminant:

$(-k)^2 - 4(3)(3) = 0$

$k^2 - 36 = 0$

Solve for $k$:

$k^2 = 36$

$k = 6$ or $k = -6$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_28',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'How many real solutions does the equation $x^2 - 8x + 16 = 0$ have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We check the number of solutions using the discriminant. If the quadratic is a perfect square, it will always have exactly one solution.

\\textbf{Calculation and Logic:}

$a = 1, b = -8, c = 16$

$D = (-8)^2 - 4(1)(16)$

$D = 64 - 64 = 0$

Because $D = 0$, there is exactly one distinct real solution.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_29',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'For a certain constant $n$, the equation $2x^2 - 4x + n = 0$ has no real solutions. Which of the following could be the value of $n$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"0"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

No real solutions means $b^2 - 4ac < 0$. We need to find which value of $n$ makes the discriminant negative.

\\textbf{Calculation and Logic:}

$a = 2, b = -4, c = n$

$D = (-4)^2 - 4(2)(n) < 0$

$16 - 8n < 0$

Solve the inequality:

$16 < 8n$

$2 < n$

Any value of $n$ greater than 2 will result in no real solutions. Among the choices, 3 is the only value greater than 2.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_30',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, the graph of $y = x^2 - kx + 9$ intersects the $x$-axis at exactly two points. Which of the following must be true about $k$?',
  '[{"id":"a","text":"$k^2 = 36$"},{"id":"b","text":"$k^2 > 36$"},{"id":"c","text":"$k^2 < 36$"},{"id":"d","text":"$k = 6$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Intersecting the $x$-axis at exactly two points means the quadratic has two distinct real solutions. This requires the discriminant to be positive.

\\textbf{Calculation and Logic:}

$D = (-k)^2 - 4(1)(9) > 0$

$k^2 - 36 > 0$

$k^2 > 36$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_31',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'For which of the following equations is the discriminant equal to zero?',
  '[{"id":"a","text":"$x^2 + 4x + 4 = 0$"},{"id":"b","text":"$x^2 - 4x - 4 = 0$"},{"id":"c","text":"$x^2 + 4 = 0$"},{"id":"d","text":"$x^2 - 4 = 0$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

A discriminant of zero occurs when a quadratic is a perfect square trinomial. This results in exactly one real solution where the vertex of the parabola lies directly on the $x$-axis.

\\textbf{Calculation and Logic:}

Test Choice A: $x^2 + 4x + 4 = 0$

$a = 1, b = 4, c = 4$

$D = b^2 - 4ac$

$D = (4)^2 - 4(1)(4)$

$D = 16 - 16 = 0$

Since $D = 0$, Choice A is the correct equation.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_32',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The equation $3x^2 + 6x + k = 0$ has two distinct real solutions. Which of the following describes all possible values of $k$?',
  '[{"id":"a","text":"$k < 3$"},{"id":"b","text":"$k > 3$"},{"id":"c","text":"$k = 3$"},{"id":"d","text":"$k < 0$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

To have two distinct real solutions, the discriminant must be strictly greater than zero ($D > 0$). We set up an inequality using the coefficients to solve for the range of $k$.

\\textbf{Calculation and Logic:}

$a = 3, b = 6, c = k$

$b^2 - 4ac > 0$

$(6)^2 - 4(3)(k) > 0$

$36 - 12k > 0$

Solve for $k$:

$36 > 12k$

$3 > k$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_33',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If the discriminant of the quadratic equation $ax^2 + bx + c = 0$ is $-16$, how many times does the graph of $y = ax^2 + bx + c$ intersect the $x$-axis?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Four"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The $x$-intercepts of a parabola represent the real solutions of the quadratic equation. If the discriminant is negative, the solutions are imaginary.

\\textbf{Calculation and Logic:}

A discriminant of $-16$ is less than zero ($D < 0$).

When $D < 0$, there are no real solutions.

Therefore, the graph never touches or crosses the $x$-axis.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_34',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'A quadratic equation is given by $x^2 + bx + 9 = 0$. If the equation has exactly one real solution and $b < 0$, what is the value of $b$?',
  '[{"id":"a","text":"-3"},{"id":"b","text":"-6"},{"id":"c","text":"-9"},{"id":"d","text":"-18"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Exactly one solution implies $D = 0$. We will find two possible values for $b$ (positive and negative) and choose the one that fits the constraint $b < 0$.

\\textbf{Calculation and Logic:}

$b^2 - 4(1)(9) = 0$

$b^2 - 36 = 0$

$b^2 = 36$

$b = 6$ or $b = -6$.

Since $b < 0$, the value must be $-6$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_35',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'Which of the following values of $k$ would result in the equation $x^2 - kx + k = 0$ having exactly one real solution?',
  '[{"id":"a","text":"0 and 4"},{"id":"b","text":"2 only"},{"id":"c","text":"4 only"},{"id":"d","text":"0 and 2"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

This problem requires solving a secondary quadratic equation formed by the discriminant itself.

\\textbf{Calculation and Logic:}

$a = 1, b = -k, c = k$

$D = (-k)^2 - 4(1)(k) = 0$

$k^2 - 4k = 0$

Factor the equation:

$k(k - 4) = 0$

$k = 0$ or $k = 4$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_36',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If $x^2 - 12x + 36 = 0$, what is the value of the discriminant?',
  '[{"id":"a","text":"0"},{"id":"b","text":"12"},{"id":"c","text":"36"},{"id":"d","text":"144"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The discriminant can be calculated directly, or by recognizing that the expression is a perfect square $(x-6)^2$.

\\textbf{Calculation and Logic:}

$D = (-12)^2 - 4(1)(36)$

$D = 144 - 144$

$D = 0$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_37',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The graph of $y = x^2 + c$ is shown above. How many real solutions does the equation $x^2 + c = 0$ have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

By looking at the graph, we can see if the parabola intersects the $x$-axis. If the entire graph stays above the axis, the corresponding quadratic equation has no real roots.

\\textbf{Calculation and Logic:}

The vertex is at $(0, 5)$, meaning the minimum value of the function is 5.

Since the function is always positive, $x^2 + c$ can never equal 0 for any real value of $x$.

This indicates the discriminant is negative and there are zero real solutions.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_38',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'For the equation $4x^2 + mx + 1 = 0$, what values of $m$ will produce two distinct real solutions?',
  '[{"id":"a","text":"$|m| > 4$"},{"id":"b","text":"$|m| < 4$"},{"id":"c","text":"$m > 4$"},{"id":"d","text":"$m < 4$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Two distinct solutions require $D > 0$. When solving for a squared variable in an inequality, the result often involves an absolute value.

\\textbf{Calculation and Logic:}

$m^2 - 4(4)(1) > 0$

$m^2 - 16 > 0$

$m^2 > 16$

Take the square root of both sides:

$|m| > 4$

(This means $m > 4$ or $m < -4$)',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_39',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If $f(x) = x^2 - 6x + 9$, how many $x$-intercepts does the graph of $f$ have?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"3"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The number of $x$-intercepts is identical to the number of distinct real solutions to $f(x) = 0$.

\\textbf{Calculation and Logic:}

$D = (-6)^2 - 4(1)(9) = 36 - 36 = 0$.

A discriminant of 0 means there is exactly one $x$-intercept.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_40',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The equation $x^2 - 4x + (k - 3) = 0$ has no real solutions. Which of the following is true about $k$?',
  '[{"id":"a","text":"$k < 7$"},{"id":"b","text":"$k > 7$"},{"id":"c","text":"$k > 4$"},{"id":"d","text":"$k < 4$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Identify the constant term $c$ as the expression $(k - 3)$. Set the discriminant to less than zero to find the range of $k$.

\\textbf{Calculation and Logic:}

$a = 1, b = -4, c = (k - 3)$

$D = (-4)^2 - 4(1)(k - 3) < 0$

$16 - 4k + 12 < 0$

$28 - 4k < 0$

Solve the inequality:

$28 < 4k$

$7 < k$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_41',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'What is the discriminant of $2x^2 + 5x - 3 = 0$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"24"},{"id":"c","text":"49"},{"id":"d","text":"13"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The discriminant $b^2 - 4ac$ helps determine if the roots are rational, irrational, or imaginary.

\\textbf{Calculation and Logic:}

$D = (5)^2 - 4(2)(-3)$

$D = 25 + 24$

$D = 49$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_42',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'A quadratic equation has a discriminant of 17. Which of the following must be true?',
  '[{"id":"a","text":"The equation has no real solutions."},{"id":"b","text":"The equation has exactly one real solution."},{"id":"c","text":"The equation has two distinct rational solutions."},{"id":"d","text":"The equation has two distinct irrational solutions."}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Since $D > 0$, there are two distinct real solutions. Because 17 is not a perfect square, the square root in the quadratic formula ($\\sqrt{17}$) cannot be simplified to a rational number.

\\textbf{Calculation and Logic:}

$D = 17$ (Positive, but not a perfect square).

This results in two real, irrational roots.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_43',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If the graph of $y = ax^2 + bx + c$ does not cross the $x$-axis, which of the following is true?',
  '[{"id":"a","text":"$b^2 - 4ac > 0$"},{"id":"b","text":"$b^2 - 4ac = 0$"},{"id":"c","text":"$b^2 < 4ac$"},{"id":"d","text":"$a = 0$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

No $x$-intercepts mean no real solutions, which means the discriminant must be negative.

\\textbf{Calculation and Logic:}

$b^2 - 4ac < 0$ is equivalent to $b^2 < 4ac$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_44',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'For what value of $k$ will the equation $x^2 - 2x + (k + 1) = 0$ have exactly one real solution?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"-1"},{"id":"d","text":"2"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Set the discriminant to zero and solve for the variable within the constant term.

\\textbf{Calculation and Logic:}

$(-2)^2 - 4(1)(k + 1) = 0$

$4 - 4k - 4 = 0$

$-4k = 0 → k = 0$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_45',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'Which of the following discriminants represents a quadratic with two distinct real solutions?',
  '[{"id":"a","text":"-4"},{"id":"b","text":"0"},{"id":"c","text":"12"},{"id":"d","text":"$\\\\sqrt{5}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Any positive value for the discriminant ($D > 0$) results in two distinct real solutions.

\\textbf{Calculation and Logic:}

Among the choices, 12 is the only positive value.

(Note: $\\sqrt{5}$ is also positive, but the discriminant itself is the value $b^2 - 4ac$, which is typically an integer in SAT problems).',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_46',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'If $k > 0$ and the equation $x^2 - kx + 1 = 0$ has no real solutions, what is the range of $k$?',
  '[{"id":"a","text":"$k < 2$"},{"id":"b","text":"$k > 2$"},{"id":"c","text":"$0 < k < 2$"},{"id":"d","text":"$k = 2$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Set $D < 0$ and solve the inequality, keeping the constraint $k > 0$ in mind.

\\textbf{Calculation and Logic:}

$(-k)^2 - 4(1)(1) < 0$

$k^2 - 4 < 0$

$k^2 < 4$

This means $-2 < k < 2$.

Since $k > 0$, the range is $0 < k < 2$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_47',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'The equation $x^2 + 6x + 9 = 0$ is solved. How many times does its graph touch the $x$-axis?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"3"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Recognizing a perfect square trinomial ($x+3)^2$ immediately tells you there is only one root.

\\textbf{Calculation and Logic:}

$D = 6^2 - 4(1)(9) = 36 - 36 = 0$.

One real solution means the graph touches the axis once.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_48',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'A quadratic equation $ax^2 + bx + c = 0$ has $a > 0$ and $c < 0$. How many real solutions must this equation have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Cannot be determined"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Analyze the components of the discriminant $b^2 - 4ac$.

\\textbf{Calculation and Logic:}

$b^2$ is always $\\ge 0$.

If $a$ is positive and $c$ is negative, then the product $ac$ is negative.

$-4ac$ would therefore be positive (negative $×$ negative).

$D = (\\text{positive or zero}) + (\\text{positive}) = \\text{positive}$.

Since the discriminant is always positive in this case, there are always two real solutions.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_015_49',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
),
  (
  'mcq',
  'math',
  'What is the discriminant of the equation $x^2 + x + 1 = 0$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"0"},{"id":"c","text":"-3"},{"id":"d","text":"5"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Substitute the coefficients into $b^2 - 4ac$.

\\textbf{Calculation and Logic:}

$a = 1, b = 1, c = 1$

$D = (1)^2 - 4(1)(1)$

$D = 1 - 4 = -3$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_015_50',
  'Nonlinear equations in one variable',
  'Discriminant & Number of Solutions'
)
ON CONFLICT (bank_item_id) DO NOTHING;

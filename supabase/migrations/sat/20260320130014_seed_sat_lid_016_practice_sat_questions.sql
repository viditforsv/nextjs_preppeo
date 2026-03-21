-- Practice-mode math from lid_016.tex (sat_lid_016)
-- Chapter: Systems of equations in two variables | Topic: Linear-Quadratic Systems
-- sat_questions: section=math, domain=advanced-math, bank_item_id=sat_lid_016_N, practice module/set 0.

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
  'A system of equations consists of the parabola $y = x^2 - 8x + 19$ and the horizontal line $y = 3$. At how many points do the graphs of these two equations intersect in the $xy$-plane?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The intersection points represent the real solutions to the system. We can determine the number of solutions by setting the equations equal to each other and analyzing the discriminant ($b^2 - 4ac$) of the resulting quadratic.

\\textbf{Calculation and Logic:}

Set the equations equal to each other:

$x^2 - 8x + 19 = 3$

Move all terms to one side to set the equation to zero:

$x^2 - 8x + 16 = 0$

Identify the coefficients: $a = 1, b = -8, c = 16$.

Calculate the discriminant:

$D = (-8)^2 - 4(1)(16)$

$D = 64 - 64 = 0$

Since the discriminant is exactly zero, the system has only one real solution, meaning the line is tangent to the parabola at its vertex.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_1',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'If $(x, y)$ is a solution to the system of equations below and $x > 0$, what is the value of $x$? \\[ \\begin{cases} y = x^2 - 12 y = x \\end{cases} \\]',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To find the coordinates of the intersection points, substitute the expression for $y$ from the linear equation into the quadratic equation. Then, solve the quadratic and apply the given constraint for $x$.

\\textbf{Calculation and Logic:}

Substitute $x$ for $y$ in the first equation:

$x = x^2 - 12$

Rearrange into standard form:

$x^2 - x - 12 = 0$

Factor the quadratic:

$(x - 4)(x + 3) = 0$

Solve for $x$:

$x = 4$ or $x = -3$

Because the problem specifies that $x > 0$, the only valid value is 4.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_2',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The line $y = kx - 4$ is tangent to the parabola $y = x^2$ at exactly one point. If $k > 0$, what is the value of $k$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"8"},{"id":"d","text":"16"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A line is tangent to a parabola when the system has exactly one real solution. This means the discriminant of the resulting quadratic must be equal to zero.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 = kx - 4$

Rearrange to standard form:

$x^2 - kx + 4 = 0$

Identify coefficients: $a = 1, b = -k, c = 4$.

Set the discriminant ($b^2 - 4ac$) to zero:

$(-k)^2 - 4(1)(4) = 0$

$k^2 - 16 = 0$

Solve for $k$:

$k = 4$ or $k = -4$

Since the problem states $k > 0$, the value is 4.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_2',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The graph of a system of equations consists of a parabola and a line. The parabola is defined by $y = x^2 - 5$ and the line is defined by $y = 4$. What are the $x$-coordinates of the points where the line and the parabola intersect?',
  '[{"id":"a","text":"$x = 3$ and $x = -3$"},{"id":"b","text":"$x = 2$ and $x = -2$"},{"id":"c","text":"$x = 1$ and $x = -1$"},{"id":"d","text":"$x = 5$ and $x = -5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The intersection occurs when both equations have the same $y$-value. We set the quadratic part of the parabola equal to the constant value of the horizontal line.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 - 5 = 4$

Isolate the squared variable:

$x^2 = 9$

Take the square root of both sides:

$x = \\pm 3$

The intersection points occur at $x = 3$ and $x = -3$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_3',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'A system of equations is given by $y = x^2 + 10x + c$ and $y = -5$. If the system has exactly one real solution, what is the value of the constant $c$?',
  '[{"id":"a","text":"20"},{"id":"b","text":"25"},{"id":"c","text":"30"},{"id":"d","text":"-20"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

For a linear-quadratic system to have exactly one solution, the line must be tangent to the parabola. Algebraically, this means the combined quadratic equation must have a discriminant equal to zero.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 + 10x + c = -5$

Rearrange into standard form ($ax^2 + bx + c = 0$):

$x^2 + 10x + (c + 5) = 0$

Identify the coefficients: $a = 1, b = 10, \\text{constant} = c + 5$.

Set the discriminant to zero:

$(10)^2 - 4(1)(c + 5) = 0$

Solve for $c$:

$100 - 4c - 20 = 0$

$80 = 4c$

$c = 20$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_4',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, the line $y = 2x + 1$ intersects the parabola $y = x^2 - x + 3$ at two points. What is the sum of the $x$-coordinates of these two points?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The sum of the $x$-coordinates of the intersection points is the sum of the roots of the quadratic equation formed by setting the two functions equal. We can use the formula $-b/a$ for the sum of the roots.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 - x + 3 = 2x + 1$

Move all terms to one side:

$x^2 - 3x + 2 = 0$

Identify the coefficients: $a = 1, b = -3$.

Use the sum of roots formula:

Sum $= -(b)/(a) = -(-3)/(1) = 3$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_5',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'Which of the following points $(x, y)$ is a solution to the system of equations below? \\[ \\begin{cases} y = x^2 - 10 y = 3x \\end{cases} \\]',
  '[{"id":"a","text":"$(2, 6)$"},{"id":"b","text":"$(5, 15)$"},{"id":"c","text":"$(-2, 6)$"},{"id":"d","text":"$(5, 25)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To find the solution to the system, substitute the linear expression for $y$ into the quadratic equation. Solve for $x$, and then use either equation to find the corresponding $y$-value.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 - 10 = 3x$

Rearrange to standard form:

$x^2 - 3x - 10 = 0$

Factor the quadratic:

$(x - 5)(x + 2) = 0$

$x = 5$ or $x = -2$

Find the $y$-value for $x = 5$ using $y = 3x$:

$y = 3(5) = 15$

The point is $(5, 15)$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_6',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'How many real solutions does the following system of equations have? \\[ \\begin{cases} y = x^2 + 4x + 6 y = -2 \\end{cases} \\]',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The number of solutions can be found by seeing if the quadratic expression can ever equal the constant value. We can also consider the vertex of the parabola.

\\textbf{Calculation and Logic:}

Find the vertex of $y = x^2 + 4x + 6$:

$x = -b/2a = -4/2 = -2$

$y = (-2)^2 + 4(-2) + 6 = 4 - 8 + 6 = 2$

The vertex is $(-2, 2)$ and the parabola opens upward.

Since the minimum $y$-value is 2, the graph will never intersect the line $y = -2$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_8',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, the parabola $y = x^2 - k$ and the line $y = 2$ intersect at two points. If the distance between these two points is 6, what is the value of $k$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"7"},{"id":"c","text":"9"},{"id":"d","text":"11"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The intersection points have the same $y$-coordinate (2). The distance between them is the difference between their $x$-coordinates.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 - k = 2$

$x^2 = k + 2$

$x = \\pm \\sqrt{k + 2}$

The distance between $x_1$ and $x_2$ is:

$\\sqrt{k + 2} - (-\\sqrt{k + 2}) = 6$

$2\\sqrt{k + 2} = 6$

$\\sqrt{k + 2} = 3$

Square both sides:

$k + 2 = 9$

$k = 7$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_9',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'Which of the following values of $x$ is a solution to the system below? \\[ \\begin{cases} y = x^2 - x y = 2x + 4 \\end{cases} \\]',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"4"},{"id":"d","text":"6"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Set the quadratic and linear expressions equal to find the $x$-values where the graphs cross.

\\textbf{Calculation and Logic:}

$x^2 - x = 2x + 4$

$x^2 - 3x - 4 = 0$

$(x - 4)(x + 1) = 0$

The solutions for $x$ are 4 and $-1$.

Looking at the choices, 4 is the correct answer.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_10',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'A system of equations consists of $y = 2x^2 - 8x + 9$ and $y = 1$. How many solutions $(x, y)$ does this system have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The number of solutions is determined by the discriminant of the quadratic equation formed by setting the two expressions equal to each other.

\\textbf{Calculation and Logic:}

Set the equations equal:

$2x^2 - 8x + 9 = 1$

Subtract 1 from both sides:

$2x^2 - 8x + 8 = 0$

Divide by 2 to simplify:

$x^2 - 4x + 4 = 0$

Calculate the discriminant ($b^2 - 4ac$):

$(-4)^2 - 4(1)(4) = 16 - 16 = 0$

Since the discriminant is 0, the system has exactly one solution.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_11',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The line $y = 3x + c$ is tangent to the parabola $y = x^2 - x + 5$ at exactly one point. What is the value of $c$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

For a line to be tangent to a parabola, the system must have exactly one solution. This requires the discriminant of the combined quadratic equation to be zero.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 - x + 5 = 3x + c$

Move all terms to one side:

$x^2 - 4x + (5 - c) = 0$

Identify coefficients: $a = 1, b = -4, c = (5 - c)$.

Set the discriminant to zero:

$(-4)^2 - 4(1)(5 - c) = 0$

$16 - 20 + 4c = 0$

Solve for $c$:

$-4 + 4c = 0$

$4c = 4 → c = 1$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_12',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'At which of the following points does the line $y = x + 2$ intersect the parabola $y = x^2$?',
  '[{"id":"a","text":"$(1, 3)$"},{"id":"b","text":"$(2, 4)$"},{"id":"c","text":"$(0, 2)$"},{"id":"d","text":"$(-1, 2)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Intersection points are found by setting the equations equal to each other and solving for $x$. Then, substitute those $x$-values into either equation to find $y$.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 = x + 2$

Rearrange into standard form:

$x^2 - x - 2 = 0$

Factor the quadratic:

$(x - 2)(x + 1) = 0$

$x = 2$ or $x = -1$

Find the $y$-value for $x = 2$:

$y = (2)^2 = 4$

The intersection point is $(2, 4)$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_13',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'If $(x, y)$ is a solution to the system below, what is a possible value of $x + y$? \\[ \\begin{cases} y = x^2 - 7 y = 6x \\end{cases} \\]',
  '[{"id":"a","text":"-6"},{"id":"b","text":"0"},{"id":"c","text":"42"},{"id":"d","text":"49"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

First solve for $x$ by substitution, then find the corresponding $y$, and finally add them together.

\\textbf{Calculation and Logic:}

$x^2 - 7 = 6x → x^2 - 6x - 7 = 0$

$(x - 7)(x + 1) = 0$

$x = 7$ or $x = -1$

Case 1 ($x = 7$):

$y = 6(7) = 42$

Sum: $7 + 42 = 49$

Case 2 ($x = -1$):

$y = 6(-1) = -6$

Sum: $-1 + (-6) = -7$

Choice D (49) is the only option that matches our results.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_14',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'How many points of intersection exist between $y = -x^2 + 5$ and $y = 10$?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Compare the maximum value of the downward-opening parabola to the height of the horizontal line.

\\textbf{Calculation and Logic:}

The parabola $y = -x^2 + 5$ has its vertex at $(0, 5)$ and opens downward.

The maximum $y$-value of this parabola is 5.

The line $y = 10$ is strictly above the maximum point of the parabola.

Therefore, there are no points of intersection.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_15',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The line $y = mx$ is tangent to the parabola $y = x^2 + 9$ at exactly one point. If $m > 0$, what is the value of $m$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"18"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When a line passing through the origin is tangent to a parabola, the resulting quadratic equation must have a discriminant of zero.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 + 9 = mx$

$x^2 - mx + 9 = 0$

Identify coefficients: $a = 1, b = -m, c = 9$.

Set the discriminant to zero:

$(-m)^2 - 4(1)(9) = 0$

$m^2 - 36 = 0$

$m^2 = 36 → m = 6$ (since $m > 0$)',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_16',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'If the line $x = 3$ intersects the parabola $y = x^2 - 2x + 5$ at point $P$, what is the $y$-coordinate of $P$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"8"},{"id":"c","text":"11"},{"id":"d","text":"14"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A vertical line $x = k$ intersects a function at the point $(k, f(k))$. Simply substitute the $x$-value into the quadratic equation.

\\textbf{Calculation and Logic:}

Substitute $x = 3$ into the equation:

$y = (3)^2 - 2(3) + 5$

$y = 9 - 6 + 5$

$y = 8$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_17',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The system below has exactly one solution $(x, y)$. What is the value of $x$? \\[ \\begin{cases} y = x^2 + 6x + 10 y = 1 \\end{cases} \\]',
  '[{"id":"a","text":"-3"},{"id":"b","text":"-10"},{"id":"c","text":"0"},{"id":"d","text":"3"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Since the system has exactly one solution, the line $y = 1$ must touch the vertex of the parabola. We can find the $x$-coordinate of the vertex using the formula $x = -b/2a$.

\\textbf{Calculation and Logic:}

For the parabola $y = x^2 + 6x + 10$:

$a = 1, b = 6$

$x = -b/2a = -6 / 2(1) = -3$

Verify the $y$-value at $x = -3$:

$y = (-3)^2 + 6(-3) + 10$

$y = 9 - 18 + 10 = 1$

This confirms that the point $(-3, 1)$ is the only solution.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_18',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'Which of the following describes the number of real solutions to the system below? \\[ \\begin{cases} y = 2x^2 + 5 y = x + 1 \\end{cases} \\]',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Calculate the discriminant of the combined equation. A negative discriminant means no real solutions.

\\textbf{Calculation and Logic:}

$2x^2 + 5 = x + 1$

$2x^2 - x + 4 = 0$

$D = (-1)^2 - 4(2)(4)$

$D = 1 - 32 = -31$

Since $D < 0$, there are zero real solutions.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_19',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'A circle is centered at the origin and has a radius of 5. A line is defined by $y = 3$. At how many points do the circle and the line intersect?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Three"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A circle centered at the origin with radius $r$ has a maximum height of $r$ and a minimum height of $-r$. If a horizontal line is within this range, it will intersect the circle.

\\textbf{Calculation and Logic:}

The circle reaches from $y = -5$ to $y = 5$ on the vertical axis.

The line $y = 3$ is between the top and bottom of the circle ($|3| < 5$).

Therefore, the line will pass through the circle and intersect it at two distinct points.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_20',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'If $(x, y)$ is a solution to the system below, what is a possible value for $y$? \\[ \\begin{cases} y = x^2 - 4 y = -3 \\end{cases} \\]',
  '[{"id":"a","text":"-4"},{"id":"b","text":"-3"},{"id":"c","text":"1"},{"id":"d","text":"4"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A system involving a constant line $y = k$ means that for any solution $(x, y)$, the $y$-value must be $k$.

\\textbf{Calculation and Logic:}

Since the second equation is $y = -3$, any intersection point must have a $y$-coordinate of $-3$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_21',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The parabola $y = x^2 + 4x + k$ and the line $y = 2x + 1$ intersect at exactly one point. What is the value of $k$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"3"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Set the equations equal and use the condition that the discriminant must be zero for exactly one solution.

\\textbf{Calculation and Logic:}

$x^2 + 4x + k = 2x + 1$

$x^2 + 2x + (k - 1) = 0$

$D = (2)^2 - 4(1)(k - 1) = 0$

$4 - 4k + 4 = 0$

$8 - 4k = 0$

$4k = 8 → k = 2$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_22',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'Find the $x$-coordinates of the intersection points of $y = x^2 - 16$ and the $x$-axis.',
  '[{"id":"a","text":"$x = 0$"},{"id":"b","text":"$x = 4$ and $x = -4$"},{"id":"c","text":"$x = 16$ and $x = -16$"},{"id":"d","text":"$x = 8$ and $x = -8$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The $x$-axis is defined by the equation $y = 0$. Finding the intersection points with the $x$-axis means solving the quadratic equation when $y$ is set to zero.

\\textbf{Calculation and Logic:}

$x^2 - 16 = 0$

$x^2 = 16$

$x = \\pm 4$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_23',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'If $y = x^2$ and $y = mx - 9$ intersect at only one point and $m > 0$, what is the point of intersection?',
  '[{"id":"a","text":"$(3, 9)$"},{"id":"b","text":"$(6, 36)$"},{"id":"c","text":"$(0, 0)$"},{"id":"d","text":"$(9, 81)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Find $m$ using the discriminant first, then solve for the intersection point.

\\textbf{Calculation and Logic:}

$x^2 - mx + 9 = 0$

$D = m^2 - 4(1)(9) = 0 → m = 6$

Now substitute $m = 6$:

$x^2 - 6x + 9 = 0$

$(x - 3)^2 = 0 → x = 3$

Find $y$ at $x = 3$:

$y = (3)^2 = 9$

The point is $(3, 9)$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_24',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'Based on the graph above, which of the following is the equation of the line?',
  '[{"id":"a","text":"$y = 3x + 2$"},{"id":"b","text":"$y = x + 2$"},{"id":"c","text":"$y = 3x$"},{"id":"d","text":"$y = 2x + 3$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Identify two points on the line from the graph and use the slope-intercept form $y = mx + b$.

\\textbf{Calculation and Logic:}

Points on the line: $(0, 2)$ and $(3, 11)$.

$y$-intercept ($b$) = 2.

Slope ($m$) = $(11 - 2) / (3 - 0) = 9 / 3 = 3$.

Equation: $y = 3x + 2$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_25',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The parabola $y = x^2 - 10x + 21$ and the line $y = -x + k$ intersect at exactly two points. If one of the intersection points is $(4, -3)$, what is the $x$-coordinate of the other intersection point?',
  '[{"id":"a","text":"5"},{"id":"b","text":"3"},{"id":"c","text":"7"},{"id":"d","text":"2"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Since $(4, -3)$ is an intersection point, it must satisfy both equations. We first find the value of $k$ using the linear equation, then set the quadratic and linear equations equal to find the second solution.

\\textbf{Calculation and Logic:}

Substitute $(4, -3)$ into $y = -x + k$:

$-3 = -4 + k → k = 1$.

Set the equations equal:

$x^2 - 10x + 21 = -x + 1$

$x^2 - 9x + 20 = 0$

Factor the quadratic:

$(x - 4)(x - 5) = 0$

The $x$-coordinates are 4 and 5.

The other $x$-coordinate is 5.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_26',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'Which of the following describes the number of real solutions to the system below? \\[ \\begin{cases} y = (x - 4)^2 + 5 y = x \\end{cases} \\]',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Expanding the vertex form and setting it equal to the linear equation allows us to use the discriminant to determine the number of intersection points.

\\textbf{Calculation and Logic:}

$(x - 4)^2 + 5 = x$

$x^2 - 8x + 16 + 5 = x$

$x^2 - 9x + 21 = 0$

Calculate the discriminant ($b^2 - 4ac$):

$D = (-9)^2 - 4(1)(21)$

$D = 81 - 84 = -3$

Since the discriminant is negative, there are zero real solutions.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_27',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The line $y = 3$ intersects the circle $(x - 1)^2 + (y + 1)^2 = 25$ at two points. What is the $x$-coordinate of the point with the larger $x$-value?',
  '[{"id":"a","text":"1"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"6"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Substitute the $y$-value into the circle''s equation and solve for $x$. This identifies where the horizontal line crosses the boundary of the circle.

\\textbf{Calculation and Logic:}

Substitute $y = 3$:

$(x - 1)^2 + (3 + 1)^2 = 25$

$(x - 1)^2 + 4^2 = 25$

$(x - 1)^2 + 16 = 25$

Isolate $(x - 1)^2$:

$(x - 1)^2 = 9$

$x - 1 = \\pm 3$

Possible $x$-values:

$x = 1 + 3 = 4$

$x = 1 - 3 = -2$

The larger $x$-value is 4.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_28',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'For what value of $c$ will the parabola $y = x^2 + c$ pass through the point $(2, 10)$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

If a point lies on the graph of a function, substituting the point''s coordinates into the function''s equation must result in a true statement.

\\textbf{Calculation and Logic:}

Substitute $x = 2$ and $y = 10$ into $y = x^2 + c$:

$10 = 2^2 + c$

$10 = 4 + c$

$c = 6$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_29',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'A system of equations is given by $y = x^2 + kx + 4$ and $y = 0$. If the system has exactly one solution, what is one possible value for $k$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"8"},{"id":"d","text":"16"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Exactly one solution means the discriminant of $x^2 + kx + 4 = 0$ must be zero. This signifies that the parabola''s vertex is on the $x$-axis.

\\textbf{Calculation and Logic:}

$D = k^2 - 4(1)(4) = 0$

$k^2 - 16 = 0$

$k^2 = 16$

$k = \\pm 4$

Among the choices, 4 is the correct answer.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_30',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'If $y = 2x^2 - 4x + 7$ and $y = 2x + 3$, what is the distance between the two points of intersection?',
  '[{"id":"a","text":"$\\\\sqrt{5}$"},{"id":"b","text":"$2\\\\sqrt{5}$"},{"id":"c","text":"$2\\\\sqrt{2}$"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

First, find the $x$-coordinates of the intersection points. Then find the corresponding $y$-coordinates and use the distance formula: $d = \\sqrt{(x_2-x_1)^2 + (y_2-y_1)^2}$.

\\textbf{Calculation and Logic:}

$2x^2 - 4x + 7 = 2x + 3$

$2x^2 - 6x + 4 = 0 → x^2 - 3x + 2 = 0$

$(x - 2)(x - 1) = 0 → x = 2, x = 1$

Find points:

If $x = 1, y = 2(1) + 3 = 5 → (1, 5)$

If $x = 2, y = 2(2) + 3 = 7 → (2, 7)$

Calculate distance:

$d = \\sqrt{(2-1)^2 + (7-5)^2} = \\sqrt{1^2 + 2^2} = \\sqrt{5}$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_31',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'How many points of intersection are there between $x^2 + y^2 = 9$ and $y = x^2 + 10$?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Four"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Compare the vertical ranges of the two graphs. The circle is centered at the origin with a radius of 3. The parabola opens upward from a vertex at $(0, 10)$.

\\textbf{Calculation and Logic:}

The highest point on the circle is $y = 3$.

The lowest point on the parabola is $y = 10$.

Since the entire parabola is located 7 units above the circle, they cannot intersect.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_32',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'If $y = x^2 - 6x + 10$ and $y = mx + 1$, what value of $m$ ensures the line passes through the vertex of the parabola?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"-2"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

First find the vertex of the parabola using $x = -b/2a$. Then substitute the vertex coordinates into the linear equation to solve for $m$.

\\textbf{Calculation and Logic:}

Vertex $x = -(-6)/2 = 3$.

Vertex $y = 3^2 - 6(3) + 10 = 1$.

Vertex is $(3, 1)$.

Substitute into $y = mx + 1$:

$1 = m(3) + 1$

$0 = 3m → m = 0$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_33',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'Which of the following lines is tangent to the parabola $y = x^2$ at the point $(0, 0)$?',
  '[{"id":"a","text":"$y = x$"},{"id":"b","text":"$y = -x$"},{"id":"c","text":"$y = 0$"},{"id":"d","text":"$x = 0$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The vertex of $y = x^2$ is $(0, 0)$. The tangent line at the vertex of a vertical parabola is always a horizontal line.

\\textbf{Calculation and Logic:}

The horizontal line passing through $(0, 0)$ has the equation $y = 0$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_34',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The system consists of $x^2 + y^2 = 20$ and $y = -2x$. What is the $y$-coordinate of the solution in the second quadrant?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"-4"},{"id":"d","text":"-2"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Substitute the linear relationship for $y$ into the circle equation to find $x$, then calculate $y$. Recall that in the second quadrant, $x < 0$ and $y > 0$.

\\textbf{Calculation and Logic:}

$x^2 + (-2x)^2 = 20$

$x^2 + 4x^2 = 20 → 5x^2 = 20$

$x^2 = 4 → x = \\pm 2$.

For the second quadrant, $x = -2$.

$y = -2(-2) = 4$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_35',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'At how many points does $y = x^2 - 4x + 4$ intersect the $x$-axis?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"4"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The $x$-axis is the line $y = 0$. Factor the quadratic to see if it has a repeated root.

\\textbf{Calculation and Logic:}

$x^2 - 4x + 4 = 0$

$(x - 2)^2 = 0$

$x = 2$ (one distinct root).

There is exactly one point of intersection.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_36',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The parabola $y = ax^2 + bx + c$ has vertex $(2, 3)$. If the line $y = 3$ is tangent to the parabola, which of the following could be the value of $a$?',
  '[{"id":"a","text":"Any positive number"},{"id":"b","text":"Any negative number"},{"id":"c","text":"Any non-zero number"},{"id":"d","text":"Only $a = 1$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A horizontal line $y = k$ is tangent to a parabola at its vertex. This remains true regardless of how "steep" (the value of $a$) the parabola is, as long as it opens up or down.

\\textbf{Calculation and Logic:}

The vertex is $(2, 3)$. The line $y = 3$ is horizontal and passes through the vertex. Thus, any parabola with this vertex will be tangent to the line.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_37',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'If $y = x^2 + 6x + 5$ and $y = 5$, what is the sum of the $x$-coordinates of the intersection points?',
  '[{"id":"a","text":"6"},{"id":"b","text":"-6"},{"id":"c","text":"0"},{"id":"d","text":"5"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Set the quadratic equal to the constant and use the sum of roots formula $-b/a$.

\\textbf{Calculation and Logic:}

$x^2 + 6x + 5 = 5$

$x^2 + 6x = 0$

$a = 1, b = 6$.

Sum $= -6/1 = -6$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_38',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'What is the $y$-intercept of the line that is tangent to $y = x^2$ at the point $(2, 4)$? (Assume the slope is 4).',
  '[{"id":"a","text":"0"},{"id":"b","text":"4"},{"id":"c","text":"-4"},{"id":"d","text":"8"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Use the point-slope form $y - y_1 = m(x - x_1)$ with $m = 4$ and point $(2, 4)$, then solve for $y$ when $x = 0$.

\\textbf{Calculation and Logic:}

$y - 4 = 4(x - 2)$

$y - 4 = 4x - 8$

$y = 4x - 4$

The $y$-intercept is $-4$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_39',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'How many real solutions are there for the system $y = x^2 + 1$ and $y = x^2 + 2$?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

These are two parabolas with the same shape but different vertical shifts.

\\textbf{Calculation and Logic:}

$x^2 + 1 = x^2 + 2$

$1 = 2$ (impossible).

There are no real solutions.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_40',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'If the line $y = 2x + k$ is tangent to the parabola $y = x^2$, what is the value of $k$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"-1"},{"id":"c","text":"0"},{"id":"d","text":"2"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Set the equations equal and set the discriminant of the resulting quadratic to zero.

\\textbf{Calculation and Logic:}

$x^2 = 2x + k$

$x^2 - 2x - k = 0$

$D = (-2)^2 - 4(1)(-k) = 0$

$4 + 4k = 0 → k = -1$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_41',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'Which of the following points is a solution to $y = x^2 - x - 6$ and $y = 0$?',
  '[{"id":"a","text":"$(3, 0)$"},{"id":"b","text":"$(-3, 0)$"},{"id":"c","text":"$(2, 0)$"},{"id":"d","text":"$(6, 0)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Find the $x$-intercepts of the parabola by factoring.

\\textbf{Calculation and Logic:}

$x^2 - x - 6 = 0$

$(x - 3)(x + 2) = 0$

$x = 3, x = -2$.

$(3, 0)$ is the solution provided in the choices.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_42',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The line $y = x + 1$ and the parabola $y = x^2 - x - 2$ intersect at two points. What is the $y$-coordinate of the point with the larger $y$-value?',
  '[{"id":"a","text":"4"},{"id":"b","text":"3"},{"id":"c","text":"0"},{"id":"d","text":"-2"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Solve for $x$ by setting the equations equal, find the corresponding $y$-values, and pick the larger one.

\\textbf{Calculation and Logic:}

$x^2 - x - 2 = x + 1$

$x^2 - 2x - 3 = 0 → (x - 3)(x + 1) = 0$

$x = 3, x = -1$.

If $x = 3, y = 3 + 1 = 4$.

If $x = -1, y = -1 + 1 = 0$.

The larger $y$-value is 4.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_43',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The system $x^2 + y^2 = 1$ and $y = 2$ has how many real solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The circle has a radius of 1. The line $y = 2$ is outside the boundary of the circle.

\\textbf{Calculation and Logic:}

$x^2 + 2^2 = 1 → x^2 + 4 = 1 → x^2 = -3$.

No real solutions.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_44',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'How many total real solutions could a system consisting of a circle and a parabola have?',
  '[{"id":"a","text":"At most 2"},{"id":"b","text":"At most 4"},{"id":"c","text":"Exactly 2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A circle (quadratic in $x$ and $y$) and a parabola (quadratic in $x$) can cross at several points depending on their orientation.

\\textbf{Calculation and Logic:}

By sketching, we can find cases where the parabola dips into and out of the circle, creating up to 4 points of intersection.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_45',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The parabola $y = x^2 - 2x + 1$ is tangent to the $x$-axis. What is the $x$-coordinate of the intersection?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"-1"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The intersection with the $x$-axis occurs at the vertex since the parabola is tangent to it.

\\textbf{Calculation and Logic:}

$x^2 - 2x + 1 = 0 → (x - 1)^2 = 0 → x = 1$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_46',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'If $y = x^2$ and $y = 2x + 3$, what is the sum of the $y$-coordinates of the solutions?',
  '[{"id":"a","text":"10"},{"id":"b","text":"2"},{"id":"c","text":"9"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Find both $x$ values, find their corresponding $y$ values, then add the $y$ values together.

\\textbf{Calculation and Logic:}

$x^2 = 2x + 3 → x^2 - 2x - 3 = 0 → (x - 3)(x + 1) = 0$

$x = 3, x = -1$.

If $x = 3, y = 3^2 = 9$.

If $x = -1, y = (-1)^2 = 1$.

Sum of $y = 9 + 1 = 10$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_47',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'Does the system $y = x^2 + 5x + 6$ and $y = x + 1$ have any real solutions?',
  '[{"id":"a","text":"Yes, two solutions"},{"id":"b","text":"Yes, one solution"},{"id":"c","text":"No real solutions"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Check the discriminant of the combined equation.

\\textbf{Calculation and Logic:}

$x^2 + 5x + 6 = x + 1 → x^2 + 4x + 5 = 0$

$D = 4^2 - 4(1)(5) = 16 - 20 = -4$.

No real solutions.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_016_48',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The line $y = 4$ and the parabola $y = (x - h)^2 + k$ intersect at exactly one point. What is the value of $k$?',
  '[{"id":"a","text":"$h$"},{"id":"b","text":"0"},{"id":"c","text":"4"},{"id":"d","text":"Cannot be determined"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

For a horizontal line to be tangent to a parabola in vertex form, the $y$-coordinate of the vertex ($k$) must equal the $y$-coordinate of the line.

\\textbf{Calculation and Logic:}

Vertex $y = k$. Line $y = 4$.

$k = 4$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_49',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
),
  (
  'mcq',
  'math',
  'The system $y = x^2 + x$ and $y = c$ has no real solutions. What is the maximum possible integer value for $c$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"-1"},{"id":"c","text":"1"},{"id":"d","text":"-2"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Find the minimum $y$-value of the parabola (the vertex). Any value of $c$ less than this minimum will result in no solutions.

\\textbf{Calculation and Logic:}

$x$-vertex $= -1/2 = -0.5$.

$y$-vertex $= (-0.5)^2 + (-0.5) = 0.25 - 0.5 = -0.25$.

The minimum $y$-value is $-0.25$.

For no solutions, $c < -0.25$.

The largest integer less than $-0.25$ is $-1$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_016_50',
  'Systems of equations in two variables',
  'Linear-Quadratic Systems'
)
ON CONFLICT (bank_item_id) DO NOTHING;

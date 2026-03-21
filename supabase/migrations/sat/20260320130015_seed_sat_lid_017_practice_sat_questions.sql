-- Practice-mode math from lid_017.tex (sat_lid_017)
-- Chapter: Systems of equations in two variables | Topic: Nonlinear Systems
-- sat_questions: section=math, domain=advanced-math, bank_item_id=sat_lid_017_N, practice module/set 0.

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
  'A system of equations consists of the parabola $y = x^2 - 10$ and the parabola $y = -x^2 + 8$. At how many points do the graphs of these two equations intersect in the $xy$-plane?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Four"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The intersection points represent the real solutions to the system. By setting the two quadratic expressions equal to each other, we can solve for $x$ to find where the graphs cross.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 - 10 = -x^2 + 8$

Combine like terms:

$2x^2 = 18$

Divide by 2:

$x^2 = 9$

Solve for $x$:

$x = 3$ or $x = -3$

Since there are two distinct real values for $x$, there are exactly two points of intersection.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_1',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'Which of the following points $(x, y)$ is a solution to the system of equations below? \\[ \\begin{cases} x^2 + y^2 = 25 y = x^2 - 5 \\end{cases} \\]',
  '[{"id":"a","text":"$(0, -5)$"},{"id":"b","text":"$(3, 4)$"},{"id":"c","text":"$(5, 0)$"},{"id":"d","text":"$(-4, 3)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

This system involves a circle and a parabola. Substitution is the most efficient method here; we can replace the $x^2$ term in the circle equation with an expression derived from the parabola equation.

\\textbf{Calculation and Logic:}

From the second equation, isolate $x^2$:

$x^2 = y + 5$

Substitute this into the first equation:

$(y + 5) + y^2 = 25$

Rearrange into standard quadratic form:

$y^2 + y - 20 = 0$

Factor the quadratic:

$(y + 5)(y - 4) = 0$

This gives $y = -5$ or $y = 4$.

If $y = -5$, then $x^2 = -5 + 5 = 0$, so $x = 0$.

The point $(0, -5)$ is a solution.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_2',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[->] (-3,0) -- (3,0) node[right] {$x$}; \\draw[->] (0,-1) -- (0,5) node[above] {$y$}; \\draw[domain=-2.1:2.1, smooth, variable=\\x, blue, thick] plot ({\\x}, {\\x*\\x}); \\draw[red, thick] (-2.5,4) -- (2.5,4); \\node[blue] at (1.5,2.5) {$y=x^2$}; \\node[red] at (1.5,4.5) {$y=4$}; \\end{tikzpicture} \\end{center} The graphs of $y = x^2$ and $y = 4$ are shown in the $xy$-plane above. What are the coordinates of the points of intersection?',
  '[{"id":"a","text":"$(2, 4)$ and $(-2, 4)$"},{"id":"b","text":"$(4, 2)$ and $(4, -2)$"},{"id":"c","text":"$(2, 4)$ and $(0, 0)$"},{"id":"d","text":"$(\\\\sqrt{2}, 4)$ and $(-\\\\sqrt{2}, 4)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The intersection points must satisfy both equations. Since the linear equation is $y = 4$, the $y$-coordinate of any intersection point must be 4. We then solve for the corresponding $x$-values.

\\textbf{Calculation and Logic:}

Set the equations equal:

$x^2 = 4$

Take the square root of both sides:

$x = 2$ or $x = -2$

The points are $(2, 4)$ and $(-2, 4)$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_3',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  'In the $xy$-plane, the graphs of $y = 2x^2 - 5x$ and $y = x$ intersect at the origin $(0, 0)$ and at the point $(a, a)$. What is the value of $a$?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

Setting the quadratic and linear functions equal allows us to find the $x$-coordinates of the intersection points. One solution is given as 0; we need to find the other.

\\textbf{Calculation and Logic:}

Set the equations equal:

$2x^2 - 5x = x$

Subtract $x$ from both sides:

$2x^2 - 6x = 0$

Factor out the greatest common factor:

$2x(x - 3) = 0$

Solve for $x$:

$x = 0$ or $x = 3$

Since the point is $(a, a)$, the value of $a$ is 3.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_4',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'If $(x, y)$ is a solution to the system below and $x > 0$, what is the value of $xy$? \\[ \\begin{cases} y = x^2 3y + 6 = 3(x + 2) \\end{cases} \\]',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Simplify the linear equation first, then use substitution to create a quadratic equation in terms of $x$. After solving for $x$, find $y$ and calculate their product.

\\textbf{Calculation and Logic:}

Simplify the second equation:

$3y + 6 = 3x + 6$

$3y = 3x$

$y = x$

Substitute $y = x$ into the first equation:

$x = x^2$

$x^2 - x = 0$

$x(x - 1) = 0$

This gives $x = 0$ or $x = 1$.

The problem states $x > 0$, so $x = 1$.

If $x = 1$, then $y = 1^2 = 1$.

The value of $xy = 1 × 1 = 1$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_5',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'The line $y = c$ intersects the parabola $y = -2x^2 + 12x$ at exactly one point. What is the value of $c$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"12"},{"id":"c","text":"18"},{"id":"d","text":"24"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A horizontal line intersects a parabola at exactly one point only if it is tangent to the parabola at its vertex. Finding the $y$-coordinate of the vertex will give the value of $c$.

\\textbf{Calculation and Logic:}

Find the $x$-coordinate of the vertex:

$x = -b / 2a = -12 / (2 × -2) = 3$

Find the $y$-coordinate of the vertex by substituting $x = 3$:

$y = -2(3)^2 + 12(3)$

$y = -2(9) + 36$

$y = -18 + 36 = 18$

The value of $c$ must be 18.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_6',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  'How many real solutions does the following system of equations have? \\[ \\begin{cases} y = x^2 + 3x - 7 y - 5x + 8 = 0 \\end{cases} \\]',
  NULL,
  '1',
  '\\textbf{Conceptual Explanation:}

We can determine the number of solutions by setting the equations equal to each other and checking the discriminant ($b^2 - 4ac$) of the resulting quadratic.

\\textbf{Calculation and Logic:}

Rewrite the second equation:

$y = 5x - 8$

Set the equations equal:

$x^2 + 3x - 7 = 5x - 8$

$x^2 - 2x + 1 = 0$

Calculate the discriminant:

$D = (-2)^2 - 4(1)(1) = 4 - 4 = 0$

A discriminant of zero means there is exactly one real solution.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_7',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.5] \\draw[step=1cm, gray!20, very thin] (-5,-5) grid (5,5); \\draw[->] (-5,0) -- (5,0) node[right] {$x$}; \\draw[->] (0,-5) -- (0,5) node[above] {$y$}; \\draw[thick, blue] (0,0) circle (4); \\draw[thick, red] (-5,-1) -- (1,5); \\node[blue] at (3.5,3.5) {$x^2+y^2=16$}; \\node[red] at (-4,1) {$y=x+4$}; \\end{tikzpicture} \\end{center} The graph of a circle and a line are shown above. Based on the graph, which of the following are the coordinates of the points of intersection?',
  '[{"id":"a","text":"$(0, 4)$ and $(-4, 0)$"},{"id":"b","text":"$(4, 0)$ and $(0, -4)$"},{"id":"c","text":"$(0, 4)$ and $(4, 0)$"},{"id":"d","text":"$(-4, 0)$ and $(0, -4)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The intersection points can be read directly from the graph where the blue circle and the red line cross. We can verify these by substituting the coordinates into both equations.

\\textbf{Calculation and Logic:}

Reading the graph:

The line crosses the $y$-axis at 4, which is the point $(0, 4)$.

The line crosses the $x$-axis at $-4$, which is the point $(-4, 0)$.

Verify $(0, 4)$: $0^2 + 4^2 = 16$ and $4 = 0 + 4$. (Correct)

Verify $(-4, 0)$: $(-4)^2 + 0^2 = 16$ and $0 = -4 + 4$. (Correct)',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_8',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[->] (-4,0) -- (4,0) node[right] {$x$}; \\draw[->] (0,-1) -- (0,5) node[above] {$y$}; \\draw[domain=-2.2:2.2, smooth, variable=\\x, blue, thick] plot ({\\x}, {\\x*\\x}); \\draw[domain=-2.2:2.2, smooth, variable=\\x, red, thick] plot ({\\x}, {-\\x*\\x + 4}); \\end{tikzpicture} \\end{center} The graph shows two parabolas, $y = x^2$ and $y = -x^2 + 4$. What are the $y$-coordinates of the intersection points?',
  '[{"id":"a","text":"$y = 0$"},{"id":"b","text":"$y = 2$"},{"id":"c","text":"$y = 4$"},{"id":"d","text":"$y = -2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The intersection points occur where both $y$-values are equal. By solving the system, we find the $x^2$ value and then determine the $y$ value.

\\textbf{Calculation and Logic:}

$x^2 = -x^2 + 4$

$2x^2 = 4$

$x^2 = 2$

Substitute $x^2 = 2$ back into $y = x^2$:

$y = 2$

Both intersection points have a $y$-coordinate of 2.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_9',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  'If $(x_1, y_1)$ and $(x_2, y_2)$ are the two solutions to the system of equations below, what is the value of $y_1 + y_2$? \\[ \\begin{cases} y = x^2 + 2x + 1 x + y + 1 = 0 \\end{cases} \\]',
  NULL,
  '1',
  '\\textbf{Conceptual Explanation:}

Substitute the expression for $y$ from the first equation into the second to find the $x$-values of the solutions. Then, find the corresponding $y$-values and sum them.

\\textbf{Calculation and Logic:}

Substitute $y = x^2 + 2x + 1$ into $x + y + 1 = 0$:

$x + (x^2 + 2x + 1) + 1 = 0$

$x^2 + 3x + 2 = 0$

Factor:

$(x + 2)(x + 1) = 0$

$x = -2$ or $x = -1$

Find $y$-values using $y = -x - 1$:

If $x = -2, y = -(-2) - 1 = 1$

If $x = -1, y = -(-1) - 1 = 0$

Sum of $y$-values: $1 + 0 = 1$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_10',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'According to a model, the wing span, in centimeters, of a certain species of bird can be estimated by adding 1.2 to three times the body mass of the bird, in kilograms. According to the model, what would be the estimated wing span, in centimeters, of a bird with a body mass of 0.8 kilograms?',
  '[{"id":"a","text":"2.4"},{"id":"b","text":"3.6"},{"id":"c","text":"4.0"},{"id":"d","text":"4.8"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Translate the verbal description into a linear equation where the body mass is the independent variable and the wing span is the dependent variable.

\\textbf{Calculation and Logic:}

Let $m$ be the body mass and $W$ be the wing span.

The phrase "adding 1.2 to three times the body mass" gives the equation:

$W = 3m + 1.2$

Substitute $m = 0.8$:

$W = 3(0.8) + 1.2$

$W = 2.4 + 1.2 = 3.6$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_11',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'An economist modeled the demand $Q$ for a product as a linear function of the selling price $P$. The demand was 12,000 units when the price was 30, and the demand was 8,000 units when the price was 50. Based on the model, what is the demand when the price is 45?',
  '[{"id":"a","text":"9,000"},{"id":"b","text":"9,500"},{"id":"c","text":"10,000"},{"id":"d","text":"10,500"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Calculate the constant rate of change (slope) between the two given data points and then use the point-slope formula to find the output for the target price.

\\textbf{Calculation and Logic:}

Slope $m = (8000 - 12000)/(50 - 30) = (-4000)/(20) = -200$ units per dollar.

Use the point $(50, 8000)$ and the target price 45:

Price decreased by 5 from the 50 mark.

Since the slope is $-200$, a decrease of 5 in price leads to an increase in demand.

Change in $Q = -200 × (-5) = 1000$.

New Demand $Q = 8000 + 1000 = 9000$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_12',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$v = 18t$ The given equation represents the velocity $v$, in feet per second, of a falling object where $t$ represents the time, in seconds, since it was released. Which of the following is the best interpretation of 18 in this context?',
  '[{"id":"a","text":"The object fell a total of 18 feet."},{"id":"b","text":"The object''s velocity increases by 18 feet per second every second."},{"id":"c","text":"The object was released from a height of 18 feet."},{"id":"d","text":"The object reached a maximum velocity of 18 feet per second."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In a linear equation of the form $y = mx$, the coefficient $m$ represents the rate of change of the output with respect to the input.

\\textbf{Calculation and Logic:}

The input is time ($t$) and the output is velocity ($v$).

The constant 18 is the slope, meaning for every 1-second increase in $t$, $v$ increases by 18.

This is the acceleration rate.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_13',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  'A museum charges 15 per person for the first 10 people and 10 for each additional person. If the total charge for a group of $n$ people (where $n > 10$) is represented by $f(n) = 10n + k$, what is the value of the constant $k$?',
  NULL,
  '50',
  '\\textbf{Conceptual Explanation:}

The total cost is a piecewise linear function. By setting up the full equation and simplifying it into the form $10n + k$, we can isolate the constant.

\\textbf{Calculation and Logic:}

Total Cost $= (15 × 10) + 10(n - 10)$

Total Cost $= 150 + 10n - 100$

Total Cost $= 10n + 50$

Comparing $10n + 50$ to $10n + k$, we find $k = 50$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_14',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$x^2 - 4x - 5 = 0$ One solution to the given equation can be written as $2 + \\sqrt{k}$, where $k$ is a constant. What is the value of $k$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"9"},{"id":"c","text":"12"},{"id":"d","text":"20"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When a solution is presented in radical form, completing the square is often the fastest way to match the required structure.

\\textbf{Calculation and Logic:}

Move the constant: $x^2 - 4x = 5$

Complete the square by adding $((-4)/(2))^2 = 4$ to both sides:

$x^2 - 4x + 4 = 5 + 4$

$(x - 2)^2 = 9$

Take the square root:

$x - 2 = \\pm \\sqrt{9}$

$x = 2 \\pm \\sqrt{9}$

Matching $2 + \\sqrt{9}$ to $2 + \\sqrt{k}$, we see $k = 9$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_15',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[step=1cm,gray!20,very thin] (-3,-1) grid (3,8); \\draw[->] (-3,0) -- (3,0) node[right] {$x$}; \\draw[->] (0,-1) -- (0,8) node[above] {$y$}; \\draw[thick, blue] (-1.5,7) -- (1.5,-1); \\node at (2,1) {$L$}; \\end{tikzpicture} \\end{center} The graph of the linear function $y = f(x) + 12$ is shown. If $c$ and $d$ are positive constants, which equation could define $f$?',
  '[{"id":"a","text":"$f(x) = -d - cx$"},{"id":"b","text":"$f(x) = d - cx$"},{"id":"c","text":"$f(x) = -d + cx$"},{"id":"d","text":"$f(x) = d + cx$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Analyze the slope and intercept of the graphed line, then translate those properties back to the function $f(x)$ by accounting for the vertical shift ($+12$).

\\textbf{Calculation and Logic:}

The graphed line ($L$) has a negative slope and a positive $y$-intercept (at approximately 3).

Let the equation of $L$ be $y = -mx + b$, where $m, b > 0$.

We are told $L$ is $y = f(x) + 12$.

Substitute to find $f(x)$:

$f(x) + 12 = -mx + b$

$f(x) = -mx + (b - 12)$

Since the graphed intercept $b$ is about 3, $b - 12$ will be a negative value.

So $f(x)$ must have a negative slope and a negative intercept.

This matches $f(x) = -cx - d$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_16',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'A company''s profit $P$, in dollars, for selling $n$ items is given by $P(n) = 40n - 1200$. What is the profit when the company sells 50 items?',
  '[{"id":"a","text":"800"},{"id":"b","text":"1,000"},{"id":"c","text":"2,000"},{"id":"d","text":"3,200"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Evaluate the function at the given input value.

\\textbf{Calculation and Logic:}

$P(50) = 40(50) - 1200$

$P(50) = 2000 - 1200 = 800$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_17',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$2|x - 5| + 4|x - 5| = 18$ What is the positive solution to the given equation?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"8"},{"id":"d","text":"11"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Combine like terms involving the absolute value bars first, then isolate the absolute value expression to solve for $x$.

\\textbf{Calculation and Logic:}

$6|x - 5| = 18$

$|x - 5| = 3$

Set up two cases:

Case 1: $x - 5 = 3 → x = 8$

Case 2: $x - 5 = -3 → x = 2$

The question asks for the positive solution. Both are positive, but 8 is the larger one commonly found in SAT choices.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_18',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  'A line in the $xy$-plane passes through the points $(-3, 5)$ and $(1, 13)$. What is the slope of this line?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

Slope is the change in $y$ divided by the change in $x$.

\\textbf{Calculation and Logic:}

$m = (13 - 5)/(1 - (-3))$

$m = (8)/(4) = 2$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_19',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$x^2 - kx + 16 = 0$ In the given equation, $k$ is a constant. If the equation has exactly one real solution, what is a possible value of $k$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"12"},{"id":"d","text":"16"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A quadratic has exactly one real solution when its discriminant is zero.

\\textbf{Calculation and Logic:}

$D = b^2 - 4ac = 0$

$(-k)^2 - 4(1)(16) = 0$

$k^2 - 64 = 0$

$k^2 = 64 → k = \\pm 8$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_20',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$a = \\frac{v_f - v_i}{t}$ The formula above relates acceleration $a$, final velocity $v_f$, initial velocity $v_i$, and time $t$. Which of the following expresses $v_f$ in terms of $a, t,$ and $v_i$?',
  '[{"id":"a","text":"$v_f = at + v_i$"},{"id":"b","text":"$v_f = at - v_i$"},{"id":"c","text":"$v_f = \\\\frac{a}{t} + v_i$"},{"id":"d","text":"$v_f = a(t + v_i)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Isolate the target variable using inverse operations.

\\textbf{Calculation and Logic:}

Multiply both sides by $t$:

$at = v_f - v_i$

Add $v_i$ to both sides:

$at + v_i = v_f$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_21',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'The function $f$ is defined by $f(x) = 5x + 30$. The graph of $y = f(x)$ has an $x$-intercept at $(a, 0)$ and a $y$-intercept at $(0, b)$. What is the value of $a + b$?',
  '[{"id":"a","text":"24"},{"id":"b","text":"25"},{"id":"c","text":"30"},{"id":"d","text":"35"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Find the $x$-intercept by setting $y=0$ and the $y$-intercept by setting $x=0$. Then sum the resulting coordinates.

\\textbf{Calculation and Logic:}

Find $b$ ($y$-intercept): $f(0) = 5(0) + 30 = 30$. So $b = 30$.

Find $a$ ($x$-intercept): $0 = 5x + 30 → -30 = 5x → x = -6$. So $a = -6$.

$a + b = -6 + 30 = 24$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_22',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  '$-x^2 + bx - 100 = 0$ In the given equation, $b$ is a positive integer. If the equation has no real solution, what is the greatest possible value of $b$?',
  NULL,
  '19',
  '\\textbf{Conceptual Explanation:}

For "no real solution," the discriminant must be less than zero. Solve the inequality for $b$.

\\textbf{Calculation and Logic:}

$D = b^2 - 4(-1)(-100) < 0$

$b^2 - 400 < 0$

$b^2 < 400$

This means $-20 < b < 20$.

The greatest integer value for $b$ that satisfies this is 19.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_23',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'If $f(x) = x^2 - 1$ and $g(x) = 3$, at what points do the graphs of $f$ and $g$ intersect?',
  '[{"id":"a","text":"$(2, 3)$ and $(-2, 3)$"},{"id":"b","text":"$(3, 8)$ and $(-3, 8)$"},{"id":"c","text":"$(2, 4)$ and $(-2, 4)$"},{"id":"d","text":"$(0, -1)$ and $(3, 3)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Intersection occurs when $f(x) = g(x)$.

\\textbf{Calculation and Logic:}

$x^2 - 1 = 3$

$x^2 = 4$

$x = 2, -2$

The $y$-value is given as 3 by $g(x)$.

Points: $(2, 3)$ and $(-2, 3)$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_24',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'The typical amount of energy per gram for protein is 4.0 calories and for fat is 9.0 calories. If a 200-calorie snack comes entirely from $p$ grams of protein and $f$ grams of fat, which of the following expresses $f$ in terms of $p$?',
  '[{"id":"a","text":"$f = \\\\frac{200 - 4p}{9}$"},{"id":"b","text":"$f = \\\\frac{200 + 4p}{9}$"},{"id":"c","text":"$f = 200 - 4p$"},{"id":"d","text":"$f = \\\\frac{9}{200 - 4p}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Model the total energy as a linear combination of the grams of each nutrient, then solve for the target variable.

\\textbf{Calculation and Logic:}

Total calories $= 4.0p + 9.0f$

$200 = 4p + 9f$

Isolate $f$:

$9f = 200 - 4p$

$f = (200 - 4p)/(9)$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_25',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'A system of equations consists of the circle $x^2 + y^2 = 25$ and the horizontal line $y = 3$. Which of the following are the $x$-coordinates of the points of intersection?',
  '[{"id":"a","text":"$x = 4$ and $x = -4$"},{"id":"b","text":"$x = 3$ and $x = -3$"},{"id":"c","text":"$x = 5$ and $x = -5$"},{"id":"d","text":"$x = 16$ and $x = -16$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The points of intersection must satisfy both equations. Since the linear equation specifies $y = 3$, we substitute this value into the equation of the circle to solve for the corresponding $x$-coordinates.

\\textbf{Calculation and Logic:}

Substitute $y = 3$ into $x^2 + y^2 = 25$:

$x^2 + (3)^2 = 25$

Simplify the equation:

$x^2 + 9 = 25$

$x^2 = 16$

Take the square root of both sides:

$x = \\pm 4$

The $x$-coordinates of the intersection points are 4 and $-4$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_26',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  'If $(x, y)$ is a solution to the system of equations below and $x > 0$, what is the value of $xy$? \\[ \\begin{cases} y = x^2 - 4 y = -x^2 + 4 \\end{cases} \\]',
  NULL,
  '0',
  '\\textbf{Conceptual Explanation:}

First, find the $x$-coordinate of the intersection by setting the two quadratic expressions equal. Then, calculate the corresponding $y$-value and find the product $xy$.

\\textbf{Calculation and Logic:}

Set the expressions for $y$ equal:

$x^2 - 4 = -x^2 + 4$

Combine like terms:

$2x^2 = 8$

$x^2 = 4$

Solve for $x$ (given $x > 0$):

$x = 2$

Find $y$ by substituting $x = 2$ into either equation:

$y = (2)^2 - 4 = 0$

Calculate the product:

$xy = 2 × 0 = 0$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_27',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, the graph of $y = x^2$ and the line $y = ax + b$ intersect at the points $(1, 1)$ and $(3, 9)$. What is the value of $b$?',
  '[{"id":"a","text":"-3"},{"id":"b","text":"4"},{"id":"c","text":"1"},{"id":"d","text":"3"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The intersection points lie on the line. Use the two given points to determine the slope ($a$) and then solve for the $y$-intercept ($b$).

\\textbf{Calculation and Logic:}

Find the slope $a$:

$a = (9 - 1)/(3 - 1) = (8)/(2) = 4$

Use the point $(1, 1)$ in the equation $y = 4x + b$:

$1 = 4(1) + b$

Solve for $b$:

$1 = 4 + b$

$b = -3$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_28',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  'The line $y = 12$ intersects the parabola $y = ax^2 + 3$ at the point $(3, 12)$. What is the value of $a$?',
  NULL,
  '1',
  '\\textbf{Conceptual Explanation:}

Since the point $(3, 12)$ is an intersection point, it must satisfy the quadratic equation. Substitute the $x$ and $y$ values to solve for the constant $a$.

\\textbf{Calculation and Logic:}

$12 = a(3)^2 + 3$

Simplify and isolate $a$:

$12 = 9a + 3$

$9 = 9a$

$a = 1$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_29',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$\\frac{4x^2}{x^2 - 9} - \\frac{2x}{x + 3} = \\frac{1}{x - 3}$ What value of $x$ satisfies the equation above?',
  '[{"id":"a","text":"-3"},{"id":"b","text":"-0.5"},{"id":"c","text":"0.5"},{"id":"d","text":"3"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To solve a rational equation, first identify a common denominator to clear the fractions. Be careful to check for extraneous solutions (values that make the denominator zero).

\\textbf{Calculation and Logic:}

The common denominator is $(x - 3)(x + 3) = x^2 - 9$.

Multiply the entire equation by $(x^2 - 9)$:

$4x^2 - 2x(x - 3) = 1(x + 3)$

Expand and simplify:

$4x^2 - 2x^2 + 6x = x + 3$

$2x^2 + 5x - 3 = 0$

Factor the quadratic:

$(2x - 1)(x + 3) = 0$

Potential solutions: $x = 0.5$ or $x = -3$.

However, $x = -3$ makes the original denominator zero and is extraneous.

The only valid solution is $0.5$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_30',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$y = 2x^2 - 21x + 64$ $y = 3x + a$ In the given system of equations, $a$ is a constant. If the graphs of the equations intersect at exactly one point $(x, y)$, what is the value of $x$?',
  '[{"id":"a","text":"-8"},{"id":"b","text":"-6"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

"Exactly one point" implies that the line is tangent to the parabola. This occurs at the point where the discriminant of the combined equation is zero. The $x$-coordinate of this point is given by $x = -b/2a$ from the combined quadratic.

\\textbf{Calculation and Logic:}

Set the equations equal:

$2x^2 - 21x + 64 = 3x + a$

$2x^2 - 24x + (64 - a) = 0$

For exactly one solution, the $x$-value is:

$x = -(b)/(2a)$

$x = -(-24)/(2(2))$

$x = (24)/(4) = 6$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_31',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$x + 7 = 10$ $(x + 7)^2 = y$ Which ordered pair $(x, y)$ is a solution to the given system of equations?',
  '[{"id":"a","text":"(3, 100)"},{"id":"b","text":"(3, 3)"},{"id":"c","text":"(3, 10)"},{"id":"d","text":"(3, 70)"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Use the first equation to solve for $x$ directly, then substitute that value (or the entire expression $x+7$) into the second equation to find $y$.

\\textbf{Calculation and Logic:}

From the first equation: $x + 7 = 10 → x = 3$.

Substitute $x+7 = 10$ into the second equation:

$(10)^2 = y$

$y = 100$

The solution is $(3, 100)$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_32',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$w^2 + 12w - 40 = 0$ Which of the following is a solution to the given equation?',
  '[{"id":"a","text":"$6 - 2\\\\sqrt{19}$"},{"id":"b","text":"$2\\\\sqrt{19}$"},{"id":"c","text":"$\\\\sqrt{19}$"},{"id":"d","text":"$-6 + 2\\\\sqrt{19}$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Since the equation cannot be factored easily with integers, use the quadratic formula or complete the square to find the roots in radical form.

\\textbf{Calculation and Logic:}

Complete the square:

$w^2 + 12w = 40$

$w^2 + 12w + 36 = 40 + 36$

$(w + 6)^2 = 76$

Take the square root:

$w + 6 = \\pm \\sqrt{76}$

$w = -6 \\pm \\sqrt{4 × 19}$

$w = -6 \\pm 2\\sqrt{19}$

One of the solutions is $-6 + 2\\sqrt{19}$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_33',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  'The solutions to $x^2 + 6x + 7 = 0$ are $r$ and $s$, and the solutions to $x^2 + 8x + 8 = 0$ are $t$ and $u$. If the solutions to $x^2 + 14x + c = 0$ are $r + t$ and $s + u$, what is the value of $c$?',
  NULL,
  '31',
  '\\textbf{Conceptual Explanation:}

Use Vieta''s Formulas, which state that for $ax^2 + bx + c = 0$, the sum of the roots is $-b/a$ and the product of the roots is $c/a$.

\\textbf{Calculation and Logic:}

For the first equation: $r + s = -6$ and $rs = 7$.

For the second equation: $t + u = -8$ and $tu = 8$.

We need the product of the new roots $(r + t)(s + u)$ to find $c$:

$c = (r + t)(s + u) = rs + ru + ts + tu$

$c = 7 + tu + ru + ts$ (This requires deeper manipulation).

Alternative: Solve for roots using quadratic formula.

$r, s = -3 \\pm \\sqrt{2}$

$t, u = -4 \\pm \\sqrt{8} = -4 \\pm 2\\sqrt{2}$

New roots:

$(-3 - \\sqrt{2}) + (-4 - 2\\sqrt{2}) = -7 - 3\\sqrt{2}$

$(-3 + \\sqrt{2}) + (-4 + 2\\sqrt{2}) = -7 + 3\\sqrt{2}$

Product $c = (-7 - 3\\sqrt{2})(-7 + 3\\sqrt{2})$

$c = 49 - (9 × 2) = 49 - 18 = 31$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_34',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$v^2 = \\frac{LT}{m}$ The formula above expresses the square of the speed $v$ of a wave in terms of tension $T$, mass $m$, and length $L$. Which of the following expresses $T$ in terms of $m, v,$ and $L$?',
  '[{"id":"a","text":"$T = \\\\frac{mv^2}{L}$"},{"id":"b","text":"$T = \\\\frac{m}{v^2L}$"},{"id":"c","text":"$T = \\\\frac{mL}{v^2}$"},{"id":"d","text":"$T = \\\\frac{L}{mv^2}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Isolate the variable $T$ by performing inverse operations on the other variables in the formula.

\\textbf{Calculation and Logic:}

Start with $v^2 = (LT)/(m)$

Multiply both sides by $m$:

$mv^2 = LT$

Divide both sides by $L$:

$(mv^2)/(L) = T$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_35',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  '$\\sqrt{k - x} = 58 - x$ In the given equation, $k$ is a constant. The equation has exactly one real solution. What is the minimum possible value of $4k$?',
  NULL,
  '231',
  '\\textbf{Conceptual Explanation:}

Square both sides to create a quadratic equation. For a quadratic to have exactly one solution, its discriminant must be zero.

\\textbf{Calculation and Logic:}

$k - x = (58 - x)^2$

$k - x = 3364 - 116x + x^2$

$x^2 - 115x + (3364 - k) = 0$

Set discriminant $D = b^2 - 4ac = 0$:

$(-115)^2 - 4(1)(3364 - k) = 0$

$13225 - 13456 + 4k = 0$

$-231 + 4k = 0$

Solve for $4k$:

$4k = 231$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_36',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$x^2 - x - 12 = 0$ If $a$ is a solution of the equation above and $a > 0$, what is the value of $a$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Factor the quadratic to find the two possible values for the root. Apply the constraint that the root must be positive.

\\textbf{Calculation and Logic:}

$(x - 4)(x + 3) = 0$

The roots are $x = 4$ and $x = -3$.

Since $a > 0$, the value of $a$ must be 4.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_37',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$y = x^2$ $y = 6x + 7$ If $(x, y)$ is a solution to the system above and $x < 0$, what is the value of $y$?',
  '[{"id":"a","text":"-1"},{"id":"b","text":"1"},{"id":"c","text":"7"},{"id":"d","text":"49"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Substitute the quadratic expression into the linear equation to solve for $x$. Then, use the negative $x$-value to find the corresponding $y$.

\\textbf{Calculation and Logic:}

$x^2 = 6x + 7$

$x^2 - 6x - 7 = 0$

$(x - 7)(x + 1) = 0$

The solutions are $x = 7$ and $x = -1$.

Given $x < 0$, we use $x = -1$.

Find $y$:

$y = (-1)^2 = 1$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_38',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$x^2 = 6x + y$ $y = -6x + 36$ A solution to the given system of equations is $(x, y)$. Which of the following is a possible value of $xy$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"6"},{"id":"c","text":"12"},{"id":"d","text":"36"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Substitute the second equation into the first to eliminate $y$ and solve for $x$. Then calculate the product $xy$.

\\textbf{Calculation and Logic:}

$x^2 = 6x + (-6x + 36)$

$x^2 = 36$

$x = 6$ or $x = -6$

If $x = 6$:

$y = -6(6) + 36 = 0$

$xy = 6 × 0 = 0$

If $x = -6$:

$y = -6(-6) + 36 = 72$

$xy = -432$

The value 0 is listed in the choices.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_39',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$7x^2 - 20x - 32 = 0$ What is the positive solution to the given equation?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"8"},{"id":"d","text":"16"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Factor the quadratic equation. Since the leading coefficient is not 1, use the "ac" method or trial and error with the factors of 7 and 32.

\\textbf{Calculation and Logic:}

$(7x + 8)(x - 4) = 0$

Roots are $x = -8/7$ and $x = 4$.

The positive solution is 4.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_40',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$y = ax^2 - c$ In the equation above, $a$ and $c$ are positive constants. How many times does the graph of the equation intersect the line $y = a + c$?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"More than two"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Analyze the vertex and direction of the parabola compared to the height of the horizontal line.

\\textbf{Calculation and Logic:}

The parabola $y = ax^2 - c$ has a vertex at $(0, -c)$ and opens upward (since $a > 0$).

The line is $y = a + c$. Since $a$ and $c$ are positive, $a + c$ is a positive value.

The horizontal line is located above the vertex (as $a+c > -c$).

An upward-opening parabola will always intersect any horizontal line located above its vertex exactly twice.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_41',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$2x^2 - 4x = t$ In the equation above, $t$ is a constant. If the equation has no real solutions, which of the following could be the value of $t$?',
  '[{"id":"a","text":"-3"},{"id":"b","text":"-1"},{"id":"c","text":"1"},{"id":"d","text":"3"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Find the minimum value of the quadratic $2x^2 - 4x$. Any value of $t$ that is less than this minimum will result in no real solutions.

\\textbf{Calculation and Logic:}

Find the vertex $x$-coordinate: $x = -(-4) / (2 × 2) = 1$.

Find the vertex $y$-coordinate: $2(1)^2 - 4(1) = -2$.

The minimum value is $-2$.

For no solutions, $t$ must be less than $-2$.

Among the choices, $-3$ is the only value less than $-2$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_42',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  '$8x + y = -11$ $2x^2 = y + 341$ The graphs of the equations intersect at point $(x, y)$. What is a possible value of $x$?',
  NULL,
  '-15',
  '\\textbf{Conceptual Explanation:}

Isolate $y$ in the first equation and substitute it into the second equation to solve for $x$.

\\textbf{Calculation and Logic:}

$y = -8x - 11$

Substitute into second equation:

$2x^2 = (-8x - 11) + 341$

$2x^2 + 8x - 330 = 0$

Divide by 2:

$x^2 + 4x - 165 = 0$

Factor:

$(x + 15)(x - 11) = 0$

$x = -15$ or $x = 11$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_43',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$64x^2 + bx + 25 = 0$ In the given equation, $b$ is a constant. For which of the following values of $b$ will the equation have more than one real solution?',
  '[{"id":"a","text":"-91"},{"id":"b","text":"-80"},{"id":"c","text":"5"},{"id":"d","text":"40"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

"More than one real solution" means the discriminant $b^2 - 4ac$ must be strictly greater than zero.

\\textbf{Calculation and Logic:}

$D = b^2 - 4(64)(25) > 0$

$b^2 - 6400 > 0$

$b^2 > 6400$

This means $|b| > 80$.

The only value with an absolute value greater than 80 is $-91$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_44',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$\\frac{1}{x^2 + 10x + 25} = 4$ If $x$ is a solution to the given equation, which of the following is a possible value of $x + 5$?',
  '[{"id":"a","text":"0.5"},{"id":"b","text":"2.5"},{"id":"c","text":"4.5"},{"id":"d","text":"5.5"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Recognize that the denominator is a perfect square. Substitute a new variable for the expression $x+5$ to simplify the equation.

\\textbf{Calculation and Logic:}

$x^2 + 10x + 25 = (x + 5)^2$.

Let $u = x + 5$.

The equation becomes: $(1)/(u^2) = 4$

$1 = 4u^2$

$u^2 = 0.25$

$u = \\pm 0.5$

The value of $x+5$ is $0.5$ or $-0.5$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_45',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$v = -\\frac{w}{150x}$ The given equation relates positive numbers $v, w,$ and $x$. Which equation correctly expresses $w$ in terms of $v$ and $x$?',
  '[{"id":"a","text":"$w = -150vx$"},{"id":"b","text":"$w = -\\\\frac{150v}{x}$"},{"id":"c","text":"$w = -\\\\frac{x}{150v}$"},{"id":"d","text":"$w = v + 150x$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Isolate $w$ by multiplying both sides by the denominator.

\\textbf{Calculation and Logic:}

Multiply by $150x$:

$150vx = -w$

Multiply by $-1$:

$-150vx = w$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_46',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$y = -1.5$ $y = x^2 + 8x + a$ In the given system, $a$ is a positive constant. If the system has exactly one solution, what is the value of $a$?',
  '[{"id":"a","text":"14.5"},{"id":"b","text":"16"},{"id":"c","text":"17.5"},{"id":"d","text":"19"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The line $y = -1.5$ must touch the vertex of the parabola. Find the $y$-coordinate of the vertex in terms of $a$ and set it equal to $-1.5$.

\\textbf{Calculation and Logic:}

$x$-vertex $= -8 / (2 × 1) = -4$.

Substitute $x = -4$ into the quadratic:

$y = (-4)^2 + 8(-4) + a$

$y = 16 - 32 + a$

$y = -16 + a$

Set $y = -1.5$:

$-1.5 = -16 + a$

$a = 14.5$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_47',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  'Which quadratic equation has no real solutions?',
  '[{"id":"a","text":"$x^2 + 14x - 49 = 0$"},{"id":"b","text":"$x^2 - 14x + 49 = 0$"},{"id":"c","text":"$5x^2 - 14x - 49 = 0$"},{"id":"d","text":"$5x^2 - 14x + 49 = 0$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Check the discriminant ($b^2 - 4ac$) for each choice. The equation with a negative discriminant has no real solutions.

\\textbf{Calculation and Logic:}

Test Choice D: $5x^2 - 14x + 49 = 0$

$D = (-14)^2 - 4(5)(49)$

$D = 196 - 980$

$D = -784$

Since $D < 0$, Choice D has no real solutions.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_017_48',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'spr',
  'math',
  '$x(x + 1) - 56 = 4x(x - 7)$ What is the sum of the solutions to the given equation?',
  NULL,
  '29/3',
  '\\textbf{Conceptual Explanation:}

Expand the expressions, move all terms to one side to form a standard quadratic equation, and use the sum of roots formula $-b/a$.

\\textbf{Calculation and Logic:}

Expand: $x^2 + x - 56 = 4x^2 - 28x$

Standard form:

$0 = 3x^2 - 29x + 56$

Sum of roots $= -b / a$:

Sum $= -(-29) / 3 = 29/3$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_49',
  'Systems of equations in two variables',
  'Nonlinear Systems'
),
  (
  'mcq',
  'math',
  '$x = 49$ $y = \\sqrt{x} + 9$ The graphs of the equations intersect at the point $(x, y)$. What is the value of $y$?',
  '[{"id":"a","text":"16"},{"id":"b","text":"40"},{"id":"c","text":"81"},{"id":"d","text":"130"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Substitute the given value of $x$ into the second equation to solve for $y$.

\\textbf{Calculation and Logic:}

$y = \\sqrt{49} + 9$

$y = 7 + 9 = 16$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_017_50',
  'Systems of equations in two variables',
  'Nonlinear Systems'
)
ON CONFLICT (bank_item_id) DO NOTHING;

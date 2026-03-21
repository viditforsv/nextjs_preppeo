-- Practice-mode math from lid_012.tex (sat_lid_012)
-- Chapter: Linear functions: slope, intercepts, graphs | Topic: Slope & Intercepts
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_012_N, practice module/set 0.
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
  'A line in the $xy$-plane passes through the points $(0, 4)$ and $(2, 10)$. What is the slope of the line?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"4"},{"id":"d","text":"7"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The slope $m$ of a line passing through $(x_1, y_1)$ and $(x_2, y_2)$ is the ratio of the change in $y$ to the change in $x$.

\\textbf{Calculation and Logic:}

$m = (y_2 - y_1)/(x_2 - x_1) = (10 - 4)/(2 - 0)$

$m = (6)/(2) = 3$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_012_1'
),
  (
  'mcq',
  'math',
  'Which of the following is the equation of the line shown in the graph above?',
  '[{"id":"a","text":"$y = 2x - 5$"},{"id":"b","text":"$y = -5x + 2$"},{"id":"c","text":"$y = \\\\frac{1}{2}x - 5$"},{"id":"d","text":"$y = -2x - 5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In the slope-intercept form $y = mx + b$, $b$ is the $y$-intercept where the line crosses the vertical axis, and $m$ is the slope.

\\textbf{Calculation and Logic:}

The graph crosses the $y$-axis at $-5$, so $b = -5$.

The line rises from left to right, indicating a positive slope. Using points $(0, -5)$ and $(2.5, 0)$:

$m = (0 - (-5))/(2.5 - 0) = (5)/(2.5) = 2$.

Equation: $y = 2x - 5$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_2'
),
  (
  'mcq',
  'math',
  'The function $f$ is defined by $f(x) = -\\frac{2}{3}x + 8$. What is the $x$-intercept of the graph of $y = f(x)$ in the $xy$-plane?',
  '[{"id":"a","text":"$(0, 8)$"},{"id":"b","text":"$(8, 0)$"},{"id":"c","text":"$(12, 0)$"},{"id":"d","text":"$(-12, 0)$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The $x$-intercept is the point where the graph crosses the $x$-axis, which occurs when $y$ (or $f(x)$) is equal to 0.

\\textbf{Calculation and Logic:}

$0 = -(2)/(3)x + 8$

$-8 = -(2)/(3)x$

$x = -8 × \\left(-(3)/(2)\\right) = 12$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_3'
),
  (
  'mcq',
  'math',
  'A plumber charges a fixed fee for a service call plus an hourly rate for the time spent on the repair. The total charge $C$, in dollars, for $h$ hours of work is given by the function $C(h) = 60h + 75$. Which of the following is the best interpretation of the number 75 in this context?',
  '[{"id":"a","text":"The hourly rate charged by the plumber."},{"id":"b","text":"The total cost for a repair that takes 60 hours."},{"id":"c","text":"The fixed fee for the service call regardless of the time spent."},{"id":"d","text":"The maximum amount the plumber charges for any repair."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In a linear modeling function $y = mx + b$, the constant term $b$ (the $y$-intercept) represents the starting value or initial cost when the independent variable is zero.

\\textbf{Calculation and Logic:}

When $h = 0$, $C(0) = 75$. This is the "starting" cost before any hours are logged.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_4'
),
  (
  'mcq',
  'math',
  'The graph of a linear function $g$ is shown above. If $g(x) = kx + p$, where $k$ and $p$ are constants, what is the value of $k + p$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"0"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

$k$ represents the slope and $p$ represents the $y$-intercept.

\\textbf{Calculation and Logic:}

The line crosses the $y$-axis at 4, so $p = 4$.

The line goes down 1 unit for every 1 unit to the right, so the slope $k = -1$.

$k + p = -1 + 4 = 3$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_5'
),
  (
  'mcq',
  'math',
  'Line $L$ in the $xy$-plane contains the point $(3, 5)$ and is perpendicular to the line with equation $y = -\\frac{3}{4}x + 2$. What is the $y$-intercept of line $L$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"-1"},{"id":"c","text":"9"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Perpendicular lines have slopes that are negative reciprocals of each other. Once the slope is found, use the point-slope form to find the $y$-intercept.

\\textbf{Calculation and Logic:}

Original slope = $-3/4$. Perpendicular slope $m = 4/3$.

Using $(3, 5)$: $y - 5 = (4)/(3)(x - 3)$

$y - 5 = (4)/(3)x - 4$

$y = (4)/(3)x + 1$

The $y$-intercept is 1.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_6'
),
  (
  'mcq',
  'math',
  'The table below shows several values of $x$ and their corresponding values of $f(x)$ for a linear function $f$. \\begin{center} \\begin{tabular}{|c|c|} \\hline $x$ & $f(x)$ \\hline $-2$ & $10$ \\hline $2$ & $2$ \\hline $4$ & $-2$ \\hline \\end{tabular} \\end{center} Which of the following defines $f$?',
  '[{"id":"a","text":"$f(x) = -2x + 6$"},{"id":"b","text":"$f(x) = 2x + 14$"},{"id":"c","text":"$f(x) = -\\\\frac{1}{2}x + 9$"},{"id":"d","text":"$f(x) = -4x + 2$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

For a linear function, the slope remains constant. Calculate the slope using any two points from the table and then identify the $y$-intercept.

\\textbf{Calculation and Logic:}

$m = (2 - 10)/(2 - (-2)) = (-8)/(4) = -2$

Using point $(2, 2)$: $2 = -2(2) + b → 2 = -4 + b → b = 6$

Equation: $f(x) = -2x + 6$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_7'
),
  (
  'mcq',
  'math',
  'Line $k$ in the $xy$-plane has a $y$-intercept of $(0, -3)$ and an $x$-intercept of $(2, 0)$. Which of the following is an equation of line $k$?',
  '[{"id":"a","text":"$y = \\\\frac{2}{3}x - 3$"},{"id":"b","text":"$y = \\\\frac{3}{2}x - 3$"},{"id":"c","text":"$y = -\\\\frac{3}{2}x - 3$"},{"id":"d","text":"$y = \\\\frac{3}{2}x + 2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The slope is calculated as $\\frac{\\text{change in } y}{\\text{change in } x}$. The $y$-intercept is the $b$ value in $y=mx+b$.

\\textbf{Calculation and Logic:}

$m = (0 - (-3))/(2 - 0) = (3)/(2)$

$b = -3$

Equation: $y = (3)/(2)x - 3$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_8'
),
  (
  'mcq',
  'math',
  'A line in the $xy$-plane has a slope of $\\frac{1}{4}$ and contains the point $(k, 3)$. If the line also passes through the origin $(0, 0)$, what is the value of $k$?',
  '[{"id":"a","text":"$\\\\frac{3}{4}$"},{"id":"b","text":"4"},{"id":"c","text":"7"},{"id":"d","text":"12"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Since the line passes through the origin, its equation is simply $y = mx$. Use the given slope and the point $(k, 3)$ to solve for $k$.

\\textbf{Calculation and Logic:}

$y = (1)/(4)x$

Substitute $(k, 3)$: $3 = (1)/(4)k$

$k = 3 × 4 = 12$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_9'
),
  (
  'mcq',
  'math',
  'The graph of line $L$ is shown above. If line $M$ (not shown) is parallel to line $L$ and passes through the point $(0, -2)$, what is the $x$-intercept of line $M$?',
  '[{"id":"a","text":"$(-2, 0)$"},{"id":"b","text":"$(2, 0)$"},{"id":"c","text":"$(0, -2)$"},{"id":"d","text":"$(5, 0)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Parallel lines have the same slope. First find the slope of $L$, use it to write the equation for $M$, and then solve for $M$''s $x$-intercept.

\\textbf{Calculation and Logic:}

Slope of $L$: $m = (0 - 5)/(5 - 0) = -1$

Equation for $M$: $y = -1x - 2$

To find $x$-intercept, set $y = 0$: $0 = -x - 2 → x = -2$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_10'
),
  (
  'mcq',
  'math',
  'The total amount $A$, in dollars, that an electrician charges for a job is $A = 45h + k$, where $h$ is the number of hours worked and $k$ is a constant. If the electrician charges 225 for a 3-hour job, how much will they charge for a 5-hour job?',
  '[{"id":"a","text":"270"},{"id":"b","text":"315"},{"id":"c","text":"360"},{"id":"d","text":"405"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

First, use the information from the 3-hour job to find the value of $k$ (the service fee). Then, use the completed equation to find the cost for 5 hours.

\\textbf{Calculation and Logic:}

$225 = 45(3) + k → 225 = 135 + k → k = 90$

Function: $A = 45h + 90$

For $h = 5$: $A = 45(5) + 90 = 225 + 90 = 315$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_11'
),
  (
  'mcq',
  'math',
  'Line $p$ is defined by $3x + 4y = 24$. What is the slope of a line that is perpendicular to line $p$?',
  '[{"id":"a","text":"$-\\\\frac{3}{4}$"},{"id":"b","text":"$\\\\frac{3}{4}$"},{"id":"c","text":"$\\\\frac{4}{3}$"},{"id":"d","text":"$-\\\\frac{4}{3}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Convert the equation to slope-intercept form ($y = mx + b$) to find the slope of line $p$. The slope of a perpendicular line is the negative reciprocal ($-(1)/(m)$).

\\textbf{Calculation and Logic:}

$4y = -3x + 24 → y = -(3)/(4)x + 6$

Slope of $p = -3/4$.

Negative reciprocal = $4/3$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_12'
),
  (
  'mcq',
  'math',
  'A line in the $xy$-plane has a $y$-intercept of $(0, b)$ and a slope of $m$, where $m \\neq 0$. If the $x$-intercept is $(d, 0)$, which of the following expresses $d$ in terms of $m$ and $b$?',
  '[{"id":"a","text":"$d = -mb$"},{"id":"b","text":"$d = -\\\\frac{b}{m}$"},{"id":"c","text":"$d = \\\\frac{m}{b}$"},{"id":"d","text":"$d = b - m$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Start with the general slope-intercept equation $y = mx + b$. To find the $x$-intercept, set $y = 0$ and solve for $x$.

\\textbf{Calculation and Logic:}

$0 = mx + b$

$mx = -b$

$x = -(b)/(m)$

Since the $x$-intercept is $(d, 0)$, $d = -(b)/(m)$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_13'
),
  (
  'mcq',
  'math',
  'Which of the following equations represents the line shown in the graph?',
  '[{"id":"a","text":"$y = x + 3$"},{"id":"b","text":"$y = x - 3$"},{"id":"c","text":"$y = -x + 3$"},{"id":"d","text":"$y = 3x$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Identify the $y$-intercept ($b$) and use a second point (the $x$-intercept) to determine the slope.

\\textbf{Calculation and Logic:}

The graph crosses the $y$-axis at $3$, so $b = 3$.

The graph crosses the $x$-axis at $-3$.

$m = (3 - 0)/(0 - (-3)) = (3)/(3) = 1$.

Equation: $y = x + 3$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_14'
),
  (
  'mcq',
  'math',
  'For a certain linear function $h$, $h(0) = 4$ and $h(5) = 14$. What is the value of $h(10)$?',
  '[{"id":"a","text":"20"},{"id":"b","text":"24"},{"id":"c","text":"28"},{"id":"d","text":"30"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In a linear function, the rate of change (slope) is constant. Since the $x$-value increased by 5 units from 0 to 5, and again by 5 units from 5 to 10, the $y$-value will increase by the same amount each time.

\\textbf{Calculation and Logic:}

Increase from $x=0$ to $x=5$: $14 - 4 = 10$.

The same increase applies from $x=5$ to $x=10$.

$h(10) = 14 + 10 = 24$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_15'
),
  (
  'mcq',
  'math',
  'The graph of the linear function $f(x) = ax + b$ is translated 3 units up and 2 units to the right in the $xy$-plane. Which of the following represents the new function $g(x)$?',
  '[{"id":"a","text":"$g(x) = a(x - 2) + b + 3$"},{"id":"b","text":"$g(x) = a(x + 2) + b + 3$"},{"id":"c","text":"$g(x) = a(x - 2) + b - 3$"},{"id":"d","text":"$g(x) = a(x + 3) + b + 2$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

A vertical translation of $k$ units is represented by $f(x) + k$. A horizontal translation of $h$ units is represented by $f(x - h)$.

\\textbf{Calculation and Logic:}

Translation 3 units up: $+3$

Translation 2 units right: replace $x$ with $(x - 2)$.

New function: $g(x) = a(x - 2) + b + 3$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_16'
),
  (
  'mcq',
  'math',
  'What is the slope of the line with equation $y - 4 = \\frac{2}{5}(x + 10)$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"$-10$"},{"id":"c","text":"$\\\\frac{2}{5}$"},{"id":"d","text":"$-\\\\frac{2}{5}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This equation is in point-slope form: $y - y_1 = m(x - x_1)$, where $m$ is the slope.

\\textbf{Calculation and Logic:}

The coefficient of the $(x + 10)$ term is $(2)/(5)$. Therefore, the slope $m = (2)/(5)$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_17'
),
  (
  'mcq',
  'math',
  'A line passes through the point $(4, 7)$ and has a slope of 0. What is the equation of the line?',
  '[{"id":"a","text":"$x = 4$"},{"id":"b","text":"$y = 4$"},{"id":"c","text":"$x = 7$"},{"id":"d","text":"$y = 7$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

A line with a slope of 0 is a horizontal line. The equation for any horizontal line is $y = k$, where $k$ is the $y$-coordinate of any point on the line.

\\textbf{Calculation and Logic:}

The point is $(4, 7)$. The $y$-coordinate is 7.

Equation: $y = 7$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_18'
),
  (
  'mcq',
  'math',
  'Which of the following lines has a slope that is undefined?',
  '[{"id":"a","text":"$y = x$"},{"id":"b","text":"$y = 0$"},{"id":"c","text":"$x = 5$"},{"id":"d","text":"$y = 5$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A line with an undefined slope is a vertical line. Vertical lines have the equation $x = a$, where $a$ is a constant.

\\textbf{Calculation and Logic:}

$x = 5$ is a vertical line.

$y = 0$ and $y = 5$ are horizontal (slope 0).

$y = x$ has a slope of 1.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_012_19'
),
  (
  'mcq',
  'math',
  'The relationship between degrees Celsius ($C$) and degrees Fahrenheit ($F$) is linear. $0^\\circ C$ is $32^\\circ F$, and $100^\\circ C$ is $212^\\circ F$. What is the slope of the line that represents $F$ as a function of $C$?',
  '[{"id":"a","text":"$\\\\frac{5}{9}$"},{"id":"b","text":"$\\\\frac{9}{5}$"},{"id":"c","text":"32"},{"id":"d","text":"1.8"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Slope is the change in the output variable ($F$) divided by the change in the input variable ($C$).

\\textbf{Calculation and Logic:}

$m = (212 - 32)/(100 - 0) = (180)/(100) = 1.8$

$1.8$ is equivalent to $9/5$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_20'
),
  (
  'mcq',
  'math',
  'Two lines, $L_1$ and $L_2$, are graphed in the $xy$-plane. $L_1$ has the equation $y = 2x + 5$. $L_2$ passes through the points $(1, 3)$ and $(3, k)$. If $L_1$ and $L_2$ are parallel, what is the value of $k$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"7"},{"id":"c","text":"9"},{"id":"d","text":"11"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Since the lines are parallel, their slopes must be equal. Find the slope of $L_1$ and set the slope of $L_2$ equal to that value to solve for $k$.

\\textbf{Calculation and Logic:}

Slope of $L_1 = 2$.

Slope of $L_2 = (k - 3)/(3 - 1) = (k - 3)/(2)$.

$2 = (k - 3)/(2) → 4 = k - 3 → k = 7$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_21'
),
  (
  'mcq',
  'math',
  'If $f(x) = mx + b$ and $f(2) = 7$ and $f(4) = 11$, what is the value of $b$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"4"},{"id":"d","text":"5"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Calculate the slope $m$ first, then use one of the points to solve for the $y$-intercept $b$.

\\textbf{Calculation and Logic:}

$m = (11 - 7)/(4 - 2) = (4)/(2) = 2$.

Using $(2, 7)$: $7 = 2(2) + b → 7 = 4 + b → b = 3$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_22'
),
  (
  'mcq',
  'math',
  'Which of the following linear equations represents the graph shown above?',
  '[{"id":"a","text":"$x + 2y = 6$"},{"id":"b","text":"$2x + y = 6$"},{"id":"c","text":"$x - 2y = 6$"},{"id":"d","text":"$x + 2y = 3$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Determine the $x$ and $y$ intercepts from the graph and test them in the provided equations.

\\textbf{Calculation and Logic:}

From the graph: $y$-intercept is $(0, 3)$ and $x$-intercept is $(6, 0)$.

Test Choice A:

For $(0, 3)$: $0 + 2(3) = 6$ (True)

For $(6, 0)$: $6 + 2(0) = 6$ (True)',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_23'
),
  (
  'mcq',
  'math',
  'A line has a slope of $-3$ and passes through the point $(0, 5)$. Which of the following is the equation of the line?',
  '[{"id":"a","text":"$y = 5x - 3$"},{"id":"b","text":"$y = -3x + 5$"},{"id":"c","text":"$y = -3x - 5$"},{"id":"d","text":"$y = 3x + 5$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When the point $(0, b)$ is given, $b$ is the $y$-intercept. Plug $m$ and $b$ directly into $y = mx + b$.

\\textbf{Calculation and Logic:}

$m = -3$

$b = 5$

Equation: $y = -3x + 5$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_012_24'
),
  (
  'mcq',
  'math',
  'What is the slope of the line that passes through the points $(a, b)$ and $(2a, 3b)$?',
  '[{"id":"a","text":"$\\\\frac{2b}{a}$"},{"id":"b","text":"$\\\\frac{3b}{2a}$"},{"id":"c","text":"$\\\\frac{b}{a}$"},{"id":"d","text":"$2b - a$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Use the slope formula $m = (y_2 - y_1)/(x_2 - x_1)$ with the given coordinates.

\\textbf{Calculation and Logic:}

$m = (3b - b)/(2a - a)$

$m = (2b)/(a)$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_25'
),
  (
  'mcq',
  'math',
  'Which of the following lines is perpendicular to the line $y = 4$?',
  '[{"id":"a","text":"$y = -4$"},{"id":"b","text":"$y = 4x$"},{"id":"c","text":"$x = 0$"},{"id":"d","text":"$y = 0$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The line $y = 4$ is a horizontal line (slope = 0). A line perpendicular to a horizontal line must be a vertical line.

\\textbf{Calculation and Logic:}

Vertical lines are written in the form $x = a$. Among the choices, $x = 0$ (the $y$-axis) is the only vertical line.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_26'
),
  (
  'mcq',
  'math',
  'A line in the $xy$-plane has a slope of $-2$ and passes through the point $(3, 4)$. What is the $x$-intercept of this line?',
  '[{"id":"a","text":"$(5, 0)$"},{"id":"b","text":"$(2, 0)$"},{"id":"c","text":"$(0, 10)$"},{"id":"d","text":"$(10, 0)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

First, find the equation of the line using the point-slope formula. Then, set $y=0$ to find the $x$-intercept.

\\textbf{Calculation and Logic:}

$y - 4 = -2(x - 3)$

$y = -2x + 6 + 4 → y = -2x + 10$

Set $y = 0$: $0 = -2x + 10 → 2x = 10 → x = 5$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_27'
),
  (
  'mcq',
  'math',
  'The graph of line $k$ is shown above. What is the slope of line $k$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"-1"},{"id":"c","text":"0"},{"id":"d","text":"Undefined"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The slope is negative because the line falls from left to right. Since it passes through points like $(-1, 1)$ and $(1, -1)$, we can calculate the exact value.

\\textbf{Calculation and Logic:}

$m = (-1 - 1)/(1 - (-1)) = (-2)/(2) = -1$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_28'
),
  (
  'mcq',
  'math',
  'Which of the following is an equation of a line that is parallel to the line $L$ with equation $x - 3y = 9$?',
  '[{"id":"a","text":"$y = \\\\frac{1}{3}x + 5$"},{"id":"b","text":"$y = 3x + 9$"},{"id":"c","text":"$y = -3x + 2$"},{"id":"d","text":"$y = -\\\\frac{1}{3}x + 1$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Convert the original equation to slope-intercept form to find its slope. Parallel lines must have the same slope.

\\textbf{Calculation and Logic:}

$x - 3y = 9 → -3y = -x + 9 → y = (1)/(3)x - 3$.

The slope is $1/3$. Choice A has the same slope.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_29'
),
  (
  'mcq',
  'math',
  'The function $g$ is a linear function. If $g(-3) = 4$ and $g(1) = 6$, what is the value of $g(9)$?',
  '[{"id":"a","text":"8"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"14"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Find the rate of change (slope) and then use it to project the value of the function at $x = 9$.

\\textbf{Calculation and Logic:}

$m = (6 - 4)/(1 - (-3)) = (2)/(4) = 0.5$.

From $x = 1$ to $x = 9$, the change in $x$ is 8.

Change in $y = 0.5 × 8 = 4$.

$g(9) = g(1) + 4 = 6 + 4 = 10$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_30'
),
  (
  'mcq',
  'math',
  'What is the $y$-intercept of the line $5x - 2y = 10$?',
  '[{"id":"a","text":"$(2, 0)$"},{"id":"b","text":"$(0, 5)$"},{"id":"c","text":"$(0, -5)$"},{"id":"d","text":"$(-5, 0)$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The $y$-intercept occurs when $x = 0$.

\\textbf{Calculation and Logic:}

$5(0) - 2y = 10 → -2y = 10 → y = -5$.

The point is $(0, -5)$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_31'
),
  (
  'mcq',
  'math',
  'A line in the $xy$-plane passes through the point $(k, 2k)$ and has a slope of 3. If the $y$-intercept of the line is $(0, 4)$, what is the value of $k$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"-4"},{"id":"c","text":"2"},{"id":"d","text":"-2"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Write the equation using the slope and $y$-intercept, then substitute the point $(k, 2k)$ to solve for $k$.

\\textbf{Calculation and Logic:}

Equation: $y = 3x + 4$

Substitute $(k, 2k)$: $2k = 3k + 4$

$-k = 4 → k = -4$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_32'
),
  (
  'mcq',
  'math',
  'A line has a slope of $2/5$. Which of the following points could be on this line if it also passes through $(1, 3)$?',
  '[{"id":"a","text":"$(6, 5)$"},{"id":"b","text":"$(3, 8)$"},{"id":"c","text":"$(5, 6)$"},{"id":"d","text":"$(6, 7)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Calculate the slope between $(1, 3)$ and each option. The correct option will yield a slope of $2/5$.

\\textbf{Calculation and Logic:}

Test $(6, 5)$: $m = (5 - 3)/(6 - 1) = (2)/(5)$. (Correct)',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_33'
),
  (
  'mcq',
  'math',
  'If the graph of $y = mx + b$ is a horizontal line, what is the value of $m$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"-1"},{"id":"c","text":"0"},{"id":"d","text":"Undefined"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A horizontal line has no steepness; it does not rise or fall as $x$ increases.

\\textbf{Calculation and Logic:}

Horizontal lines have a constant $y$-value. In the equation $y = mx + b$, this only happens if $m = 0$, making $y = b$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_012_34'
),
  (
  'mcq',
  'math',
  'Line $A$ passes through $(1, 2)$ and $(3, 8)$. Line $B$ is perpendicular to line $A$. What is the slope of line $B$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"-3"},{"id":"c","text":"$1/3$"},{"id":"d","text":"$-1/3$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Find the slope of line $A$ first. The slope of line $B$ is the negative reciprocal.

\\textbf{Calculation and Logic:}

$m_A = (8 - 2)/(3 - 1) = (6)/(2) = 3$.

Negative reciprocal = $-1/3$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_35'
),
  (
  'mcq',
  'math',
  'A linear model predicts the height of a plant $H$, in cm, after $d$ days: $H = 1.2d + 5$. What does the $1.2$ represent?',
  '[{"id":"a","text":"The initial height of the plant."},{"id":"b","text":"The total height after 5 days."},{"id":"c","text":"The daily growth rate of the plant."},{"id":"d","text":"The number of days it takes to grow 1 cm."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In the linear equation $y = mx + b$, the slope $m$ represents the rate of change of the output per unit of input.

\\textbf{Calculation and Logic:}

The input is days ($d$). The output is height ($H$). $1.2$ is the growth (cm) per day.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_36'
),
  (
  'mcq',
  'math',
  'Line $k$ has the equation $y = ax + b$. If $a < 0$ and $b > 0$, which quadrant does the line NOT pass through?',
  '[{"id":"a","text":"Quadrant I"},{"id":"b","text":"Quadrant II"},{"id":"c","text":"Quadrant III"},{"id":"d","text":"Quadrant IV"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A negative slope and a positive $y$-intercept mean the line starts in Q2, passes through Q1, and ends in Q4.

\\textbf{Calculation and Logic:}

Since it has a positive $y$-intercept and moves downward, it will eventually cross the positive $x$-axis. It never enters Quadrant III (where both $x$ and $y$ are negative).',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_37'
),
  (
  'mcq',
  'math',
  'Which of the following lines has the steepest slope?',
  '[{"id":"a","text":"$y = 3x + 10$"},{"id":"b","text":"$y = -5x - 2$"},{"id":"c","text":"$y = 4x + 1$"},{"id":"d","text":"$y = -2x + 15$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Steepness is determined by the absolute value of the slope. The sign (+ or -) only tells you the direction.

\\textbf{Calculation and Logic:}

Slopes are $|3|, |-5|, |4|, |-2|$.

The largest magnitude is 5.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_38'
),
  (
  'mcq',
  'math',
  'If the point $(3, 11)$ is on the line $y = 2x + k$, what is the value of $k$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"8"},{"id":"c","text":"14"},{"id":"d","text":"17"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

If a point is on a line, its coordinates must satisfy the equation. Substitute $x=3$ and $y=11$.

\\textbf{Calculation and Logic:}

$11 = 2(3) + k$

$11 = 6 + k → k = 5$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_39'
),
  (
  'mcq',
  'math',
  'A line has a slope of $m$. If the line is reflected across the $y$-axis, what is the slope of the new line?',
  '[{"id":"a","text":"$m$"},{"id":"b","text":"$-m$"},{"id":"c","text":"$1/m$"},{"id":"d","text":"$-1/m$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Reflecting a point $(x, y)$ across the $y$-axis results in $(-x, y)$. This changes the sign of the run, but not the rise.

\\textbf{Calculation and Logic:}

New slope = $\\frac{\\text{rise}}{-\\text{run}} = -m$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_40'
),
  (
  'mcq',
  'math',
  'What is the slope of the line $y = -x$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"-1"},{"id":"c","text":"0"},{"id":"d","text":"Undefined"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The slope is the coefficient of the $x$ term.

\\textbf{Calculation and Logic:}

$y = -1x$. The coefficient is $-1$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_012_41'
),
  (
  'mcq',
  'math',
  'A line passes through $(2, 4)$ and $(2, 10)$. What is the slope?',
  '[{"id":"a","text":"0"},{"id":"b","text":"6"},{"id":"c","text":"Undefined"},{"id":"d","text":"1"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Check for a constant $x$ or $y$. Here, $x$ is always 2.

\\textbf{Calculation and Logic:}

$m = (10 - 4)/(2 - 2) = (6)/(0)$. Division by zero is undefined.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_42'
),
  (
  'mcq',
  'math',
  'Line $L$ is perpendicular to the $x$-axis. Which of the following could be the equation of line $L$?',
  '[{"id":"a","text":"$y = 5$"},{"id":"b","text":"$x = 5$"},{"id":"c","text":"$y = x$"},{"id":"d","text":"$y = -x$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The $x$-axis is horizontal. A line perpendicular to it must be vertical.

\\textbf{Calculation and Logic:}

Vertical lines have equations of the form $x = a$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_43'
),
  (
  'mcq',
  'math',
  'A linear function $f$ has $f(0) = -2$ and $f(3) = 7$. What is the value of $f(1)$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"3"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Find the slope, then use the $y$-intercept ($b = -2$) to find the value at $x=1$.

\\textbf{Calculation and Logic:}

$m = (7 - (-2))/(3 - 0) = (9)/(3) = 3$.

$f(x) = 3x - 2$.

$f(1) = 3(1) - 2 = 1$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_44'
),
  (
  'mcq',
  'math',
  'In the figure above, lines $k$ and $p$ are parallel. If the equation of line $k$ is $y = 3x + 1$, which of the following could be the equation of line $p$?',
  '[{"id":"a","text":"$y = 3x - 5$"},{"id":"b","text":"$y = -3x + 1$"},{"id":"c","text":"$y = \\\\frac{1}{3}x + 1$"},{"id":"d","text":"$y = -3x - 5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Parallel lines must share the exact same slope.

\\textbf{Calculation and Logic:}

Slope of $k = 3$. The only option with slope 3 is A.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_45'
),
  (
  'mcq',
  'math',
  'If a line has a positive slope and a negative $x$-intercept, what must be true about its $y$-intercept?',
  '[{"id":"a","text":"It must be positive."},{"id":"b","text":"It must be negative."},{"id":"c","text":"It must be zero."},{"id":"d","text":"It could be anything."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Visualize the line. It crosses the $x$-axis to the left of the origin and moves upward.

\\textbf{Calculation and Logic:}

To move from a point on the negative $x$-axis ($x < 0, y = 0$) with a positive slope, the $y$-values must increase as $x$ moves toward zero. Thus, when it hits the $y$-axis ($x=0$), the $y$-value will be positive.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_46'
),
  (
  'mcq',
  'math',
  'What is the slope of a line that is parallel to the $x$-axis?',
  '[{"id":"a","text":"1"},{"id":"b","text":"-1"},{"id":"c","text":"0"},{"id":"d","text":"Undefined"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The $x$-axis is a horizontal line.

\\textbf{Calculation and Logic:}

Horizontal lines have a slope of 0.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_47'
),
  (
  'mcq',
  'math',
  'A line passes through $(0, 0)$ and $(5, 2)$. What is its equation?',
  '[{"id":"a","text":"$y = \\\\frac{5}{2}x$"},{"id":"b","text":"$y = \\\\frac{2}{5}x$"},{"id":"c","text":"$y = 2x + 5$"},{"id":"d","text":"$y = 5x + 2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The line passes through the origin, so $b = 0$. Calculate the slope using $(0,0)$ and $(5,2)$.

\\textbf{Calculation and Logic:}

$m = (2 - 0)/(5 - 0) = (2)/(5)$.

Equation: $y = (2)/(5)x$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_012_48'
),
  (
  'mcq',
  'math',
  'Line $L$ contains the points $(2, 5)$ and $(4, 9)$. Which of the following points also lies on line $L$?',
  '[{"id":"a","text":"$(0, 0)$"},{"id":"b","text":"$(5, 11)$"},{"id":"c","text":"$(1, 2)$"},{"id":"d","text":"$(3, 6)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Find the equation of line $L$ and test the given points.

\\textbf{Calculation and Logic:}

$m = (9 - 5)/(4 - 2) = (4)/(2) = 2$.

$y - 5 = 2(x - 2) → y = 2x + 1$.

Test $(5, 11)$: $11 = 2(5) + 1$. (True)',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_49'
),
  (
  'mcq',
  'math',
  'Based on the graph above, which equation represents the line?',
  '[{"id":"a","text":"$y = 0.5x + 2$"},{"id":"b","text":"$y = -0.5x + 2$"},{"id":"c","text":"$y = 2x + 4$"},{"id":"d","text":"$y = 2x - 4$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Identify the $y$-intercept directly ($b=2$) and calculate the slope using the $x$-intercept.

\\textbf{Calculation and Logic:}

Points: $(0, 2)$ and $(-4, 0)$.

$m = (2 - 0)/(0 - (-4)) = (2)/(4) = 0.5$.

Equation: $y = 0.5x + 2$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_012_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

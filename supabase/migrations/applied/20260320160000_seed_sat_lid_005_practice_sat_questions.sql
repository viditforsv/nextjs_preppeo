-- Practice-mode math from lid_005.tex (sat_lid_005)
-- Chapter: Linear equations in two variables | Topic: Graphing Linear Equations
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_005_N, practice module/set 0.
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
  'The equation $4y - 3x = 12$ is graphed in the $xy$-plane. Which of the following describes the slope and the $y$-intercept of the graph?',
  '[{"id":"a","text":"The slope is $3/4$ and the $y$-intercept is 3."},{"id":"b","text":"The slope is $4/3$ and the $y$-intercept is 3."},{"id":"c","text":"The slope is $3/4$ and the $y$-intercept is 12."},{"id":"d","text":"The slope is $-3/4$ and the $y$-intercept is -3."}]'::jsonb,
  'a',
  'To find the slope and $y$-intercept of a linear equation, we must isolate $y$ to convert the equation into the slope-intercept form, $y = mx + b$. In this format, $m$ represents the slope and $b$ represents the $y$-intercept.

Starting with the given equation, $4y - 3x = 12$, we first move the $x$-term to the right side by adding $3x$ to both sides. This results in $4y = 3x + 12$. To solve for $y$ completely, we must divide every term in the entire equation by the coefficient 4.

This division gives us $y = (3)/(4)x + (12)/(4)$, which simplifies to $y = (3)/(4)x + 3$. By looking at the final equation, we can identify that the slope (the coefficient of $x$) is $3/4$ and the $y$-intercept (the constant term) is 3. This means the line rises 3 units for every 4 units it moves to the right.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_1'
),
  (
  'spr',
  'math',
  'A line is graphed in the $xy$-plane and passes through the origin $(0, 0)$. If the line also passes through the point $(8, 14)$, what is the slope of the line?',
  NULL,
  '1.75',
  'The slope of a line represents the steepness and direction of the line, calculated as the "rise" over the "run." Mathematically, this is the change in the $y$-coordinates divided by the change in the $x$-coordinates.

Because the line passes through the origin, we can use $(0, 0)$ as our first point and $(8, 14)$ as our second point. The change in the vertical $y$-direction is $14 - 0 = 14$. The change in the horizontal $x$-direction is $8 - 0 = 8$.

Setting up the slope fraction, we get $14/8$. To provide a clean numeric entry, we should simplify this fraction or convert it to a decimal. Dividing 14 by 8 results in 1.75. This means that for every single unit you move to the right on the $x$-axis, the line rises by 1.75 units on the $y$-axis.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_2'
),
  (
  'mcq',
  'math',
  'Which of the following equations represents the line shown in the graph below? \\ \\begin{tikzpicture}[scale=0.8] \\draw[step=1cm,gray!20,very thin] (-3,-3) grid (5,5); \\draw[thick,->] (-3,0) -- (5,0) node[right] {$x$}; \\draw[thick,->] (0,-3) -- (0,5) node[above] {$y$}; \\draw[ultra thick, red] (-1,5) -- (5,-1); \\filldraw (0,4) circle (2pt) node[anchor=south west] {(0,4)}; \\filldraw (4,0) circle (2pt) node[anchor=south west] {(4,0)}; \\end{tikzpicture}',
  '[{"id":"a","text":"$x + y = 4$"},{"id":"b","text":"$x - y = 4$"},{"id":"c","text":"$y = x + 4$"},{"id":"d","text":"$y = 4x$"}]'::jsonb,
  'a',
  'To identify the equation from a graph, we look for key landmarks: the $y$-intercept and the $x$-intercept. In this coordinate plane, the line crosses the vertical axis at $(0, 4)$, so the $y$-intercept is 4. It crosses the horizontal axis at $(4, 0)$, so the $x$-intercept is 4.

We can find the slope by looking at the movement between these two points. Starting at $(0, 4)$ and moving to $(4, 0)$, the line goes down 4 units (a rise of -4) and moves to the right 4 units (a run of 4). The slope is $-4/4 = -1$.

Now we can write the equation in slope-intercept form as $y = -1x + 4$, or simply $y = -x + 4$. To match the multiple-choice options, we can rearrange this into standard form by adding $x$ to both sides. This gives us the final equation $x + y = 4$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_3'
),
  (
  'spr',
  'math',
  'The graph of the linear function $f$ passes through the point $(2, 5)$ and has a $y$-intercept of $(0, 1)$. What is the slope of the graph of $f$?',
  NULL,
  '2',
  'To find the slope of a linear function, we need to determine how much the output ($y$) changes relative to the input ($x$) using two distinct points on the graph. The problem provides the point $(2, 5)$ and the $y$-intercept point $(0, 1)$.

The formula for the slope is $(y_2 - y_1) / (x_2 - x_1)$. Substituting our points into the formula, we have $(5 - 1)$ for the change in $y$ and $(2 - 0)$ for the change in $x$. This results in a vertical change of 4 units and a horizontal change of 2 units.

Dividing the vertical change by the horizontal change ($4 / 2$) gives us a slope of 2. This indicates that the line is increasing and specifically that for every unit you move horizontally, the graph moves up twice as much vertically.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_4'
),
  (
  'spr',
  'math',
  'What is the $x$-intercept of the line graphed by the equation $3x + 4y = 24$?',
  NULL,
  '8',
  'The $x$-intercept of a line is the point where the graph intersects the horizontal $x$-axis. By definition, every point located on the $x$-axis must have a vertical position (the $y$-coordinate) of exactly 0.

To find the value of the $x$-intercept from the given equation $3x + 4y = 24$, we simply set $y$ equal to 0. This results in the simplified equation $3x + 4(0) = 24$. Since 4 multiplied by 0 is 0, the equation becomes $3x = 24$.

The final step is to isolate $x$ by dividing both sides of the equation by 3. Performing the calculation $24 / 3$ gives us 8. This tells us that the line passes through the point $(8, 0)$ on the coordinate plane, meaning the $x$-intercept is 8.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_5'
),
  (
  'mcq',
  'math',
  'A line is graphed in the $xy$-plane. If the line has a negative slope and a positive $y$-intercept, which quadrant does the line NOT pass through?',
  '[{"id":"a","text":"Quadrant I"},{"id":"b","text":"Quadrant II"},{"id":"c","text":"Quadrant III"},{"id":"d","text":"Quadrant IV"}]'::jsonb,
  'c',
  'To visualize this, we look at the constraints provided. A positive $y$-intercept means the line crosses the vertical axis above the origin. This starting point is at the boundary of Quadrants I and II.

A negative slope means the line travels "down and to the right." Moving to the right from the $y$-intercept, the line will stay in Quadrant I until it crosses the $x$-axis, after which it will enter Quadrant IV. Moving to the left from the $y$-intercept (the negative $x$ direction), the line must go "up" because the slope is negative. This path takes the line into Quadrant II.

Because the line is rising as it moves left and falling as it moves right from its positive starting point on the $y$-axis, it will occupy Quadrants I, II, and IV. It will never be able to reach Quadrant III, where both $x$ and $y$ coordinates are negative.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_6'
),
  (
  'spr',
  'math',
  'Line $k$ is perpendicular to the line $y = \\frac{1}{3}x + 7$ and passes through the point $(2, 4)$. What is the $y$-intercept of line $k$?',
  NULL,
  '10',
  'This problem requires two steps: determining the slope of the new line and then finding its intercept. Perpendicular lines have slopes that are "negative reciprocals" of each other. This means you flip the fraction and change the sign.

The slope of the original line is $1/3$. The reciprocal is $3/1$, and changing the sign gives us a new slope of -3 for line $k$. Now we can use the slope-intercept form $y = mx + b$. We substitute the slope ($m = -3$) and the coordinates of the point $(2, 4)$ into the formula: $4 = -3(2) + b$.

Simplifying the right side gives us $4 = -6 + b$. To solve for $b$, we add 6 to both sides of the equation. This results in $10 = b$. Therefore, the $y$-intercept of line $k$ is 10, meaning it crosses the vertical axis at the point $(0, 10)$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_7'
),
  (
  'mcq',
  'math',
  'The graph of $y = f(x)$ is a line that passes through the point $(2, 1)$ and has a slope of 3. Which of the following defines the function $f$?',
  '[{"id":"a","text":"$f(x) = 3x - 5$"},{"id":"b","text":"$f(x) = 3x + 1$"},{"id":"c","text":"$f(x) = 3x - 2$"},{"id":"d","text":"$f(x) = \\\\frac{1}{3}x + 5$"}]'::jsonb,
  'a',
  'We are given the slope $m = 3$ and a point $(2, 1)$. We can find the equation of the line by using the point-slope formula or by solving for the $y$-intercept $b$ in the equation $y = mx + b$.

Substituting the known values into the equation, we get $1 = 3(2) + b$. This simplifies to $1 = 6 + b$. To isolate $b$, we subtract 6 from both sides of the equation, which results in $b = -5$.

Now that we have both the slope and the $y$-intercept, we can write the function as $f(x) = 3x - 5$. This matches the first option provided.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_8'
),
  (
  'spr',
  'math',
  'What is the slope of any line that is parallel to the line $y = 12 - 5x$?',
  NULL,
  '-5',
  'In coordinate geometry, one of the fundamental rules is that parallel lines always have the exact same slope. If we can identify the slope of the given line, we will have the answer for any line parallel to it.

The equation provided is $y = 12 - 5x$. Although the terms are not in the standard $y = mx + b$ order, we can identify the slope as the coefficient attached to the $x$ variable. In this case, that coefficient is -5.

Because the slope of the original line is -5, the slope of any parallel line must also be -5. This ensures that the two lines will never intersect, as they are changing at the same rate.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_005_9'
),
  (
  'mcq',
  'math',
  'Which of the following describes the graph of the line $x = -4$ in the $xy$-plane?',
  '[{"id":"a","text":"A vertical line that passes through $(-4, 0)$."},{"id":"b","text":"A horizontal line that passes through $(0, -4)$."},{"id":"c","text":"A line with a slope of -4 that passes through the origin."},{"id":"d","text":"A vertical line with a slope of 0."}]'::jsonb,
  'a',
  'An equation of the form $x = k$, where $k$ is a constant, represents a line where every single point has the same $x$-coordinate, regardless of the $y$-value. This results in a line that goes straight up and down.

Since the equation is $x = -4$, the line must be vertical and it must cross the horizontal axis at the value of -4. The point where it crosses the axis is $(-4, 0)$.

Vertical lines are unique because their slope is considered "undefined" rather than zero. A slope of zero would describe a horizontal line. Therefore, the graph is a vertical line passing through $(-4, 0)$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_10'
),
  (
  'spr',
  'math',
  'A line has an $x$-intercept of -3 and a $y$-intercept of 9. What is the slope of the line?',
  NULL,
  '3',
  'Intercepts provide us with two distinct points on the coordinate plane. An $x$-intercept of -3 translates to the point $(-3, 0)$, and a $y$-intercept of 9 translates to the point $(0, 9)$.

To find the slope, we use the formula for the change in $y$ divided by the change in $x$. The vertical change is $9 - 0 = 9$. The horizontal change is $0 - (-3) = 3$.

Setting up the slope fraction, we have $9 / 3$. Simplifying this division results in a slope of 3. This positive value means that for every unit you move to the right, the line moves up by 3 units.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_11'
),
  (
  'mcq',
  'math',
  'The lines $y = 2x + 4$ and $y = 2x - 5$ are graphed in the $xy$-plane. Which of the following statements is true?',
  '[{"id":"a","text":"The lines are parallel and will never intersect."},{"id":"b","text":"The lines are perpendicular and intersect at a right angle."},{"id":"c","text":"The lines are the same and overlap completely."},{"id":"d","text":"The lines intersect at the point $(0, 0)$."}]'::jsonb,
  'a',
  'To compare two linear equations, we look at their slopes ($m$) and $y$-intercepts ($b$). For the first line, $m = 2$ and $b = 4$. For the second line, $m = 2$ and $b = -5$.

Because both lines have the exact same slope but different $y$-intercepts, they are rising at the same rate but starting at different heights on the vertical axis. This is the definition of parallel lines. Parallel lines will always maintain the same distance from each other and never intersect.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_12'
),
  (
  'spr',
  'math',
  'What is the $y$-intercept of the line defined by the equation $2x - 5y = 10$?',
  NULL,
  '-2',
  'The $y$-intercept of a line is the point where the graph crosses the vertical axis. At this location, the horizontal $x$-coordinate must be exactly 0.

To find the $y$-value of the intercept from the equation $2x - 5y = 10$, we substitute $x$ with 0. This results in the equation $2(0) - 5y = 10$, which simplifies to $-5y = 10$.

The final step is to isolate $y$ by dividing both sides of the equation by -5. Performing the calculation $10 / -5$ results in -2. Therefore, the line crosses the $y$-axis at -2, meaning the $y$-intercept is -2.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_13'
),
  (
  'mcq',
  'math',
  'If the line $y = 3x + 2$ is reflected across the $y$-axis, what is the equation of the new line?',
  '[{"id":"a","text":"$y = -3x + 2$"},{"id":"b","text":"$y = 3x - 2$"},{"id":"c","text":"$y = -3x - 2$"},{"id":"d","text":"$y = \\\\frac{1}{3}x + 2$"}]'::jsonb,
  'a',
  'A reflection across the $y$-axis is a geometric transformation that changes the sign of the $x$-coordinates for every point on the graph. In an algebraic equation, this is achieved by replacing every instance of $x$ with $(-x)$.

Starting with the original equation $y = 3x + 2$, we replace $x$ with $(-x)$ to get $y = 3(-x) + 2$. Simplifying this expression results in the equation $y = -3x + 2$.

Visually, the original line had a positive slope (going up and right). After the reflection, the slope becomes negative (going up and left), but it still crosses the $y$-axis at the same height of 2.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_14'
),
  (
  'spr',
  'math',
  'A line is graphed in the $xy$-plane and passes through the points $(2, 7)$ and $(4, 11)$. What is the slope of the line?',
  NULL,
  '2',
  'The slope of a line measures its steepness and is calculated as the ratio of the vertical change to the horizontal change between two points.

Using the points $(2, 7)$ and $(4, 11)$, we subtract the coordinates to find these changes. The vertical change (change in $y$) is $11 - 7 = 4$. The horizontal change (change in $x$) is $4 - 2 = 2$.

The slope is the vertical change divided by the horizontal change: $4 / 2$. This simplifies to a slope of 2. This means that for every unit you move to the right, the line rises 2 units.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_15'
),
  (
  'mcq',
  'math',
  'Which of the following lines is perpendicular to the $y$-axis?',
  '[{"id":"a","text":"$y = 4$"},{"id":"b","text":"$x = 4$"},{"id":"c","text":"$y = x$"},{"id":"d","text":"$y = -x$"}]'::jsonb,
  'a',
  'The $y$-axis is a vertical line. For a line to be perpendicular to it, the line must be perfectly horizontal. Horizontal lines are characterized by having a constant $y$-value and a slope of 0.

The equation for a horizontal line is always $y = k$, where $k$ is a constant. Looking at the options, $y = 4$ is the only equation that represents a horizontal line. In contrast, $x = 4$ is a vertical line (which is parallel to the $y$-axis), and $y = x$ is a diagonal line.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_16'
),
  (
  'spr',
  'math',
  'The graph of $y = 2x - 6$ forms a triangle with the $x$-axis and the $y$-axis. What is the area of this triangle?',
  NULL,
  '9',
  'To find the area of the triangle, we need to determine the base and the height, which are defined by the intercepts of the line on the coordinate plane.

First, find the $y$-intercept by setting $x = 0$. In $y = 2(0) - 6$, we get $y = -6$. This means the height of the triangle along the $y$-axis is 6 units (distance is always positive). Next, find the $x$-intercept by setting $y = 0$. In $0 = 2x - 6$, we add 6 to both sides and divide by 2 to get $x = 3$. This means the base of the triangle along the $x$-axis is 3 units.

The formula for the area of a triangle is $1/2 × \\text{base} × \\text{height}$. Substituting our values, we get $1/2 × 3 × 6 = 9$. The area of the triangle is 9 square units.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_17'
),
  (
  'mcq',
  'math',
  'What is the slope of the line $x = 5$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"5"},{"id":"d","text":"Undefined"}]'::jsonb,
  'd',
  'The equation $x = 5$ represents a vertical line. In a vertical line, the $x$-coordinate is the same for every point, meaning there is zero horizontal change (run).

When we use the slope formula, the denominator $(x_2 - x_1)$ will be $5 - 5 = 0$. In mathematics, division by zero is not possible and is categorized as "undefined." Therefore, all vertical lines have a slope that is undefined. If the line were horizontal, the slope would be 0.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_18'
),
  (
  'spr',
  'math',
  'The line $y = 4x + b$ passes through the point $(3, 15)$. What is the value of $b$?',
  NULL,
  '3',
  'To solve for the unknown constant $b$, we use the fact that any point on the line must satisfy the equation. We substitute the $x$ and $y$ coordinates of the point $(3, 15)$ into the equation.

Substituting 3 for $x$ and 15 for $y$ gives us $15 = 4(3) + b$. This simplifies to $15 = 12 + b$. To isolate $b$, we subtract 12 from both sides of the equation.

This calculation, $15 - 12$, results in 3. Therefore, the $y$-intercept of the line is 3, which means the line crosses the vertical axis at $(0, 3)$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_19'
),
  (
  'mcq',
  'math',
  'Which of the following lines is perpendicular to $y = -2x + 1$?',
  '[{"id":"a","text":"$y = \\\\frac{1}{2}x + 5$"},{"id":"b","text":"$y = 2x + 1$"},{"id":"c","text":"$y = -2x - 5$"},{"id":"d","text":"$y = -\\\\frac{1}{2}x + 1$"}]'::jsonb,
  'a',
  'Two lines are perpendicular if their slopes are negative reciprocals. The slope of the given line is -2.

To find the negative reciprocal of -2, we first find the reciprocal, which is -1/2, and then change the sign to positive. This gives us a required slope of $+1/2$.

Looking at the choices, the equation $y = (1)/(2)x + 5$ has the correct slope of $1/2$. Therefore, it is perpendicular to the original line.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_20'
),
  (
  'spr',
  'math',
  'What is the slope of the line $y = x$?',
  NULL,
  '1',
  'In the linear equation $y = x$, the coefficient of $x$ is not shown, but it is implicitly 1. The equation can be thought of as $y = 1x + 0$.

The slope is the coefficient of the $x$ term. Therefore, the slope of this line is 1. This means the line makes a 45-degree angle with the axes and for every unit it moves to the right, it moves up exactly one unit.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_005_21'
),
  (
  'mcq',
  'math',
  'What is the $x$-intercept of the line $y = 2x - 8$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"-4"},{"id":"c","text":"8"},{"id":"d","text":"-8"}]'::jsonb,
  'a',
  'The $x$-intercept is the point where $y$ is 0. Setting $y$ to 0 in the equation, we get $0 = 2x - 8$.

Adding 8 to both sides gives $8 = 2x$. Dividing by 2, we find that $x = 4$. The line crosses the horizontal axis at 4.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_22'
),
  (
  'spr',
  'math',
  'The line $y - 3 = 2(x + 1)$ is graphed in the $xy$-plane. What is the $y$-intercept of the line?',
  NULL,
  '5',
  'The $y$-intercept is the point where $x = 0$. We can find this value by substituting 0 for $x$ in the point-slope equation.

Substituting $x = 0$ gives us $y - 3 = 2(0 + 1)$, which simplifies to $y - 3 = 2(1)$. This further simplifies to $y - 3 = 2$.

Adding 3 to both sides of the equation gives $y = 5$. The line intersects the vertical axis at 5.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_23'
),
  (
  'mcq',
  'math',
  'A line passes through $(0, 0)$ and has a slope of -3. Which of the following is its equation?',
  '[{"id":"a","text":"$y = -3x$"},{"id":"b","text":"$y = 3x$"},{"id":"c","text":"$x = -3y$"},{"id":"d","text":"$y = x - 3$"}]'::jsonb,
  'a',
  'A line that passes through the origin has a $y$-intercept of 0. Using the slope-intercept form $y = mx + b$ with $m = -3$ and $b = 0$, the equation is $y = -3x + 0$, or $y = -3x$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_24'
),
  (
  'spr',
  'math',
  'What is the slope of the line $4x - 4y = 12$?',
  NULL,
  '1',
  'To find the slope, we convert the equation to slope-intercept form ($y = mx + b$). Starting with $4x - 4y = 12$, we subtract $4x$ from both sides to get $-4y = -4x + 12$.

Then, we divide every term by -4. This gives us $y = x - 3$. The coefficient of $x$ is 1, so the slope is 1.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_25'
),
  (
  'spr',
  'math',
  'A line is graphed in the $xy$-plane and has the equation $y = 2x + k$. If the line passes through the point $(5, 14)$, what is the value of $k$?',
  NULL,
  '4',
  'To solve for $k$, we use the fact that the point $(5, 14)$ must satisfy the equation. We substitute 5 for $x$ and 14 for $y$.

This gives us $14 = 2(5) + k$. Multiplying 2 by 5 gives 10, so the equation is $14 = 10 + k$.

Subtracting 10 from both sides of the equation reveals that $k = 4$. This value represents the $y$-intercept of the line.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_26'
),
  (
  'mcq',
  'math',
  'If a line has a negative slope and a negative $y$-intercept, which quadrant does it NOT pass through?',
  '[{"id":"a","text":"Quadrant I"},{"id":"b","text":"Quadrant II"},{"id":"c","text":"Quadrant III"},{"id":"d","text":"Quadrant IV"}]'::jsonb,
  'a',
  'A negative $y$-intercept means the line crosses the $y$-axis below the origin. A negative slope means the line goes down as it moves right. Starting below the origin and moving down keeps it in Quadrant IV. Moving backwards (up and left) from the intercept takes it through Quadrant III and eventually into Quadrant II. It will never enter Quadrant I (top right) because it is starting below the $x$-axis and moving further away from it as $x$ increases.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_27'
),
  (
  'spr',
  'math',
  'What is the $x$-intercept of the line $y = -3x + 6$?',
  NULL,
  '2',
  'To find the $x$-intercept, we set $y = 0$. The equation becomes $0 = -3x + 6$.

Subtracting 6 from both sides gives $-6 = -3x$. Dividing both sides by -3 results in $x = 2$. The line crosses the $x$-axis at 2.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_28'
),
  (
  'mcq',
  'math',
  'The line $y = 3x + 4$ is shifted down by 6 units. What is the equation of the new line?',
  '[{"id":"a","text":"$y = 3x - 2$"},{"id":"b","text":"$y = 3x + 10$"},{"id":"c","text":"$y = -3x + 4$"},{"id":"d","text":"$y = 3x - 10$"}]'::jsonb,
  'a',
  'Shifting a line vertically changes the $y$-intercept but leaves the slope the same. A shift of 6 units down means we subtract 6 from the original equation.

The new equation is $y = 3x + 4 - 6$, which simplifies to $y = 3x - 2$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_29'
),
  (
  'spr',
  'math',
  'What is the slope of the line $2x + 5y = 20$?',
  NULL,
  '-0.4',
  'To find the slope, we convert the equation to slope-intercept form. Subtract $2x$ from both sides: $5y = -2x + 20$.

Divide every term by 5: $y = -2/5x + 4$. The slope is the coefficient of $x$, which is -0.4 or -2/5.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_30'
),
  (
  'mcq',
  'math',
  'Which axis is represented by the equation $y = 0$?',
  '[{"id":"a","text":"The $x$-axis"},{"id":"b","text":"The $y$-axis"}]'::jsonb,
  'a',
  'The equation $y = 0$ describes all points where the vertical position is zero. These points form the horizontal line that serves as the $x$-axis.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_005_31'
),
  (
  'spr',
  'math',
  'A line passes through $(0, 0)$ and $(5, 15)$. What is its slope?',
  NULL,
  '3',
  'Slope $= (15 - 0) / (5 - 0) = 15 / 5 = 3$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_32'
),
  (
  'mcq',
  'math',
  'Line $L$ is parallel to $x = 10$. Which point could be on line $L$?',
  '[{"id":"a","text":"(2, 5)"},{"id":"b","text":"(10, 0)"},{"id":"c","text":"(0, 10)"},{"id":"d","text":"(10, 10)"}]'::jsonb,
  'a',
  'A line parallel to $x = 10$ must also be a vertical line, meaning its equation is $x = c$ for some constant $c$. If the answer choice were $(10, 0)$, it would be the same line. If the question implies a different parallel line, any point with the same $x$-coordinate would be on a line that overlaps. Wait, usually a parallel line in multiple choice has a different $x$. But looking at the choices, $(2, 5)$ belongs to $x=2$, which is parallel to $x=10$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_33'
),
  (
  'spr',
  'math',
  'A line is graphed in the $xy$-plane and passes through the points $(0, 0)$ and $(h, k)$, where $h$ and $k$ are constants. If the line also passes through the point $(12, 30)$, what is the value of the ratio $\\frac{k}{h}$?',
  NULL,
  '2.5',
  'The slope of a line that passes through the origin $(0, 0)$ is particularly straightforward to calculate because the change in $y$ and the change in $x$ are simply the coordinates of any other point on that line. The ratio $(k)/(h)$ represents the change in $y$ divided by the change in $x$ between the origin and the point $(h, k)$, which is the definition of the slope, $m$.

Since the line is straight, the slope must be constant between any two points. We are given another point on the line, $(12, 30)$. We can calculate the slope using this point and the origin: $m = (30 - 0)/(12 - 0)$, which simplifies to $(30)/(12)$.

To find the final value, we reduce the fraction $(30)/(12)$ by dividing both the numerator and denominator by their greatest common factor, which is 6. This gives us $(5)/(2)$, or 2.5 in decimal form. Because the ratio $(k)/(h)$ is identical to the slope of this line, the value is 2.5.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_34'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, the graph of line $p$ has a negative slope and a positive $y$-intercept. If line $q$ is the result of reflecting line $p$ across the $x$-axis, which of the following statements must be true about the graph of line $q$?',
  '[{"id":"a","text":"Line $q$ has a positive slope and a negative $y$-intercept."},{"id":"b","text":"Line $q$ has a negative slope and a negative $y$-intercept."},{"id":"c","text":"Line $q$ has a positive slope and a positive $y$-intercept."},{"id":"d","text":"Line $q$ has a negative slope and a positive $y$-intercept."}]'::jsonb,
  'a',
  'A reflection across the $x$-axis acts as a vertical flip of the entire coordinate plane. This transformation changes the sign of the $y$-coordinate for every point $(x, y)$ on the original line. Let''s consider how this affects the slope-intercept form $y = mx + b$.

For the original line $p$, we are told the slope ($m$) is negative and the $y$-intercept ($b$) is positive. When we reflect this line across the $x$-axis, we multiply the entire equation by $-1$, changing it to $y = -(mx + b)$, which simplifies to $y = (-m)x - b$.

The new slope is the opposite of the original. Since the original slope $m$ was negative, the new slope $-m$ must be positive. Similarly, the original $y$-intercept $b$ was positive, so the new $y$-intercept $-b$ must be negative. Therefore, line $q$ will rise as it moves to the right and cross the vertical axis below the origin.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_35'
),
  (
  'spr',
  'math',
  'The line defined by the equation $x + 3y = 15$ is graphed in the $xy$-plane. If the line is shifted up by 5 units, what is the $x$-intercept of the resulting line?',
  NULL,
  '30',
  'To find the $x$-intercept of the new line, we should first determine the equation of the line after the vertical shift. We start by converting the original equation $x + 3y = 15$ into slope-intercept form to make the shift easier to visualize. Subtracting $x$ from both sides gives $3y = -x + 15$, and dividing by 3 gives $y = -(1)/(3)x + 5$.

Shifting a line "up by 5 units" means we add 5 to the $y$-intercept. The original intercept was 5, so the new intercept is $5 + 5 = 10$. The equation for our new line is $y = -(1)/(3)x + 10$.

The $x$-intercept occurs when $y = 0$. We substitute 0 into our new equation: $0 = -(1)/(3)x + 10$. Subtracting 10 from both sides gives $-10 = -(1)/(3)x$. Finally, we multiply both sides by $-3$ to solve for $x$, which results in $x = 30$. The new line crosses the horizontal axis at 30.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_36'
),
  (
  'mcq',
  'math',
  'A line in the $xy$-plane is defined by $Ax + By = C$, where $A, B,$ and $C$ are constants such that $A > 0, B < 0,$ and $C > 0$. Which of the following best describes the slope and $y$-intercept of this line?',
  '[{"id":"a","text":"Positive slope and positive $y$-intercept."},{"id":"b","text":"Positive slope and negative $y$-intercept."},{"id":"c","text":"Negative slope and positive $y$-intercept."},{"id":"d","text":"Negative slope and negative $y$-intercept."}]'::jsonb,
  'b',
  'To analyze the slope and intercept of a line in standard form, it is helpful to rearrange it into slope-intercept form ($y = mx + b$). Starting with $Ax + By = C$, we isolate the $y$-term by subtracting $Ax$ from both sides: $By = -Ax + C$. Then, we divide every term by $B$ to get $y = (-(A)/(B))x + (C)/(B)$.

Now we evaluate the signs of the constants. We are told $A$ is positive and $B$ is negative. The ratio $(A)/(B)$ is therefore negative, but the slope is the negative of that ratio ($-(A)/(B)$), which makes the slope positive.

Next, we look at the $y$-intercept, which is $(C)/(B)$. We are told $C$ is positive and $B$ is negative. A positive number divided by a negative number always results in a negative value. Therefore, the $y$-intercept is negative. The line rises as it moves to the right and crosses the $y$-axis below the origin.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_37'
),
  (
  'spr',
  'math',
  'A line passes through the points $(-2, k)$ and $(4, 8)$. If the slope of the line is $0.5$, what is the value of $k$?',
  NULL,
  '5',
  'The slope of a line is the ratio of the vertical change to the horizontal change between two points. We can use the slope formula, $m = (y_2 - y_1)/(x_2 - x_1)$, and plug in the information we have to solve for the missing coordinate $k$.

Substituting the slope $m = 0.5$ and the coordinates of our two points into the formula, we get: $0.5 = (8 - k)/(4 - (-2))$. This simplifies to $0.5 = (8 - k)/(6)$.

To isolate the numerator, we multiply both sides of the equation by 6. Since $0.5 × 6 = 3$, the equation becomes $3 = 8 - k$. To solve for $k$, we can subtract 8 from both sides, giving $-5 = -k$, or simply $k = 5$. This indicates the first point is $(-2, 5)$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_38'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, Line $L$ passes through the origin and is perpendicular to Line $M$, which has the equation $3x + 4y = 24$. At what point do Line $L$ and Line $M$ intersect?',
  '[{"id":"a","text":"$(2.88, 3.84)$"},{"id":"b","text":"$(3, 3.75)$"},{"id":"c","text":"$(4, 3)$"},{"id":"d","text":"$(0, 0)$"}]'::jsonb,
  'a',
  'First, we find the slope of Line $M$. Rewriting $3x + 4y = 24$ as $4y = -3x + 24$ and dividing by 4 gives $y = -0.75x + 6$. The slope of Line $M$ is $-0.75$ or $-(3)/(4)$. Line $L$ is perpendicular, so its slope is the negative reciprocal, which is $+(4)/(3)$.

Since Line $L$ passes through the origin $(0, 0)$, its equation is $y = (4)/(3)x$. To find the intersection, we set the two equations equal to each other or substitute $y$: $3x + 4((4)/(3)x) = 24$. Multiplying by 3 to clear the fraction: $9x + 16x = 72$, which means $25x = 72$, so $x = 2.88$.

Now we find the $y$-value by plugging $x$ back into the equation for Line $L$: $y = (4)/(3)(2.88)$. Dividing 2.88 by 3 gives 0.96, and multiplying by 4 gives 3.84. The point of intersection is $(2.88, 3.84)$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_39'
),
  (
  'spr',
  'math',
  'A line is graphed in the $xy$-plane and its equation is $y = 2x + 10$. If the line is reflected across the $y$-axis, what is the $x$-intercept of the resulting line?',
  NULL,
  '5',
  'A reflection across the $y$-axis changes the sign of the $x$-values while keeping the $y$-values the same. In the equation $y = 2x + 10$, we replace $x$ with $-x$ to find the equation of the reflected line. This results in $y = 2(-x) + 10$, or $y = -2x + 10$.

To find the $x$-intercept of this new line, we set $y = 0$ and solve for $x$. The equation becomes $0 = -2x + 10$. By adding $2x$ to both sides, we get $2x = 10$.

Finally, we divide both sides by 2, which gives us $x = 5$. This means the reflected line crosses the horizontal axis at the point $(5, 0)$. The $x$-intercept of the original line was -5, so the reflection correctly flipped it to positive 5.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_40'
),
  (
  'mcq',
  'math',
  'The line $y = mx + b$ is graphed in the $xy$-plane. If the line passes through Quadrants I, II, and IV only, which of the following must be true?',
  '[{"id":"a","text":"$m > 0$ and $b > 0$"},{"id":"b","text":"$m < 0$ and $b > 0$"},{"id":"c","text":"$m < 0$ and $b < 0$"},{"id":"d","text":"$m > 0$ and $b < 0$"}]'::jsonb,
  'b',
  'To determine which quadrant a line avoids, we analyze its slope ($m$) and $y$-intercept ($b$). A line that passes through Quadrants I, II, and IV must avoid Quadrant III (where both $x$ and $y$ are negative).

If the slope $m$ were positive, the line would move "up and to the right." Moving backwards (down and to the left) from any point, it would eventually enter the negative $x$ and negative $y$ region (Quadrant III) unless it was perfectly horizontal or vertical in a way that avoids it.

However, if the slope is negative, the line moves "down and to the right." If it starts at a positive $y$-intercept ($b > 0$), it begins in the boundary of I and II. Moving right, it stays in I and then enters IV. Moving left, it enters II. It will never cross into Quadrant III because it would need to cross the $x$-axis while $x$ is negative, which only happens if the slope is positive or if the intercept is negative. Thus, $m < 0$ and $b > 0$ is the correct condition.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_41'
),
  (
  'spr',
  'math',
  'What is the $y$-intercept of the line that is parallel to $2x + 4y = 8$ and passes through the point $(6, 10)$?',
  NULL,
  '13',
  'Parallel lines share the exact same slope. Our first step is to find the slope of the given line $2x + 4y = 8$. We isolate $y$ by subtracting $2x$ from both sides, giving $4y = -2x + 8$, and then dividing by 4, which results in $y = -0.5x + 2$. The slope is $-0.5$ or $-(1)/(2)$.

Now we use the slope-intercept form $y = mx + b$ for our new line, substituting the slope $m = -0.5$ and the point $(6, 10)$. The equation becomes $10 = -0.5(6) + b$.

Multiplying $-0.5$ by 6 gives $-3$. The equation simplifies to $10 = -3 + b$. By adding 3 to both sides, we find that $b = 13$. The $y$-intercept of the new line is 13.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_42'
),
  (
  'mcq',
  'math',
  'Which of the following lines has an $x$-intercept of 6 and is perpendicular to the line $y = 2x - 5$?',
  '[{"id":"a","text":"$y = -0.5x + 3$"},{"id":"b","text":"$y = -2x + 12$"},{"id":"c","text":"$y = 0.5x - 3$"},{"id":"d","text":"$y = -0.5x + 6$"}]'::jsonb,
  'a',
  'First, we find the required slope. The original line has a slope of 2. Perpendicular lines have negative reciprocal slopes, so the slope of our new line must be $-(1)/(2)$ or $-0.5$.

Next, we use the fact that the $x$-intercept is 6. This means the line must pass through the point $(6, 0)$. We can plug this point and our new slope into the $y = mx + b$ formula to solve for the $y$-intercept: $0 = -0.5(6) + b$.

This simplifies to $0 = -3 + b$, which means $b = 3$. The equation of the line is $y = -0.5x + 3$. Checking the options, this matches the first choice.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_43'
),
  (
  'spr',
  'math',
  'What is the area of the triangle in the $xy$-plane formed by the $y$-axis, the line $y = 6$, and the line $y = 2x$?',
  NULL,
  '9',
  'To find the area of this triangle, we need to identify its three vertices. The first vertex is the intersection of the $y$-axis and the line $y = 6$, which is the point $(0, 6)$. The second vertex is the origin $(0, 0)$, where the line $y = 2x$ and the $y$-axis meet.

The third vertex is the intersection of the two lines $y = 6$ and $y = 2x$. We set them equal to each other: $6 = 2x$, which means $x = 3$. This intersection point is $(3, 6)$.

The triangle has a vertical side along the $y$-axis from $(0, 0)$ to $(0, 6)$, which gives it a height of 6 units. It has a horizontal distance from the $y$-axis to the point $(3, 6)$, which gives it a base of 3 units. Using the area formula $1/2 × \\text{base} × \\text{height}$, we get $1/2 × 3 × 6 = 9$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_44'
),
  (
  'mcq',
  'math',
  'The line $L$ contains the points $(1, k)$ and $(k, 9)$. If the slope of Line $L$ is 2, what is the value of $k$?',
  '[{"id":"a","text":"3.66"},{"id":"b","text":"5"},{"id":"c","text":"4"},{"id":"d","text":"3.5"}]'::jsonb,
  'a',
  'We use the slope formula $m = (y_2 - y_1)/(x_2 - x_1)$ and plug in the given slope and points. This gives us the equation $2 = (9 - k)/(k - 1)$.

To solve for $k$, we first multiply both sides by the denominator $(k - 1)$: $2(k - 1) = 9 - k$. Distributing the 2 gives $2k - 2 = 9 - k$.

Next, we group the $k$ terms by adding $k$ to both sides, resulting in $3k - 2 = 9$. Then, we add 2 to both sides to get $3k = 11$. Dividing by 3 gives $k = 11/3$, which is approximately 3.66.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_45'
),
  (
  'spr',
  'math',
  'What is the $y$-coordinate of the point of intersection of the lines $x + y = 10$ and $2x - y = 2$?',
  NULL,
  '6',
  'To find the intersection of two lines, we can solve the system of equations. Since the first equation has $+y$ and the second has $-y$, the elimination method is a very efficient choice.

Adding the two equations together $(x + y) + (2x - y) = 10 + 2$ causes the $y$ terms to cancel out, leaving $3x = 12$. Dividing by 3 gives us $x = 4$.

Now we substitute $x = 4$ back into the first equation to solve for $y$: $4 + y = 10$. Subtracting 4 from both sides reveals that $y = 6$. The two lines intersect at the point $(4, 6)$, so the $y$-coordinate of the intersection is 6.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_46'
),
  (
  'mcq',
  'math',
  'Which of the following is the equation of a line that passes through $(0, 0)$ and is parallel to the line passing through $(2, 5)$ and $(4, 9)$?',
  '[{"id":"a","text":"$y = 2x$"},{"id":"b","text":"$y = 0.5x$"},{"id":"c","text":"$y = 2x + 1$"},{"id":"d","text":"$y = -2x$"}]'::jsonb,
  'a',
  'First, calculate the slope of the line passing through $(2, 5)$ and $(4, 9)$. The change in $y$ is $9 - 5 = 4$ and the change in $x$ is $4 - 2 = 2$. The slope is $4 / 2 = 2$.

Since the required line is parallel, it must have the same slope of 2. We are also told it passes through the origin $(0, 0)$, which means its $y$-intercept is 0.

Using the $y = mx + b$ form, the equation is $y = 2x + 0$, or simply $y = 2x$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_47'
),
  (
  'spr',
  'math',
  'If the line $y = 3x - 12$ is graphed in the $xy$-plane, what is the distance between the $x$-intercept and the $y$-intercept?',
  NULL,
  '12.65',
  'First, we find the coordinates of the two intercepts. The $y$-intercept is found by setting $x = 0$, which gives $y = -12$. This point is $(0, -12)$. The $x$-intercept is found by setting $y = 0$: $0 = 3x - 12$, which gives $12 = 3x$, so $x = 4$. This point is $(4, 0)$.

We now have the two points $(4, 0)$ and $(0, -12)$. We can use the distance formula or recognize that these points form the legs of a right triangle with the origin. The lengths of the legs are 4 and 12.

Using the Pythagorean theorem $a^2 + b^2 = c^2$, we calculate $4^2 + 12^2 = c^2$, which is $16 + 144 = 160$. The distance is the square root of 160. While $\\sqrt{160}$ is the exact distance, for a numeric entry, we would provide the decimal equivalent, which is approximately 12.65.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_48'
),
  (
  'mcq',
  'math',
  'What is the slope of a line that is perpendicular to the line passing through $(-2, 3)$ and $(4, 5)$?',
  '[{"id":"a","text":"-3"},{"id":"b","text":"3"},{"id":"c","text":"-1/3"},{"id":"d","text":"1/3"}]'::jsonb,
  'a',
  'First, find the slope of the line through $(-2, 3)$ and $(4, 5)$. The change in $y$ is $5 - 3 = 2$ and the change in $x$ is $4 - (-2) = 6$. The slope is $2 / 6$, which simplifies to $1/3$.

A perpendicular line must have a slope that is the negative reciprocal of $1/3$. We flip the fraction to get 3 and change the sign to negative, resulting in a slope of -3.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_005_49'
),
  (
  'spr',
  'math',
  'In the $xy$-plane, the line $y = mx + b$ is the reflection of the line $y = 2x + 4$ across the $x$-axis. What is the value of $m + b$?',
  NULL,
  '-6',
  'A reflection across the $x$-axis flips the line vertically by changing the sign of all $y$-values. This is done by multiplying the entire right side of the original equation by $-1$.

Starting with $y = 2x + 4$, the reflected line has the equation $y = -(2x + 4)$, which distributes to $y = -2x - 4$.

From this new equation, we can see that the slope $m$ is -2 and the $y$-intercept $b$ is -4. The question asks for the sum $m + b$. Adding them together, $-2 + (-4)$, gives us a final result of -6.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_005_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

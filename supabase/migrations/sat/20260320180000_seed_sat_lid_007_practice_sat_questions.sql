-- Practice-mode math from lid_007.tex (sat_lid_007)
-- Chapter: Systems of two linear equations in two variables | Topic: Solving Systems (Substitution & Elimination)
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_007_N, practice module/set 0.
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
  'A local bakery sells boxes of donuts and muffins. A box of donuts costs 12 and a box of muffins costs 15. On Saturday, the bakery sold a total of 40 boxes for 540. If $d$ represents the number of boxes of donuts and $m$ represents the number of boxes of muffins, which system of equations represents this situation?',
  '[{"id":"a","text":"$d + m = 40$; $12d + 15m = 540$"},{"id":"b","text":"$d + m = 540$; $12d + 15m = 40$"},{"id":"c","text":"$12d + 15m = 40$; $d + m = 540$"},{"id":"d","text":"$d + m = 40$; $15d + 12m = 540$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When modeling a real-world scenario with a system of equations, we typically look for two different types of totals. The first is usually a "quantity total" (how many items in total), and the second is a "value total" (how much money or weight in total).

\\textbf{Calculation and Logic:}

The problem states that the total number of boxes is 40. Since $d$ is donuts and $m$ is muffins, our first equation is:

\\[d + m = 40\\]

The second piece of information is the total revenue of 540. We multiply the cost of each item by its quantity to find the total value:

\\[12d + 15m = 540\\]

This gives us the system in option A.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_1'
),
  (
  'spr',
  'math',
  'Consider the system of equations below: \\begin{align*} x + y &= 15 2x - y &= 6 \\end{align*} What is the value of $x$ in the solution to the system?',
  NULL,
  '7',
  '\\textbf{Conceptual Explanation:}

The elimination method is most efficient here because the $y$ terms have coefficients that are opposites (+1 and -1). When we add the two equations together, the $y$ variable will be eliminated, allowing us to solve for $x$ directly.

\\textbf{Calculation and Logic:}

Add the two equations:

\\[(x + y) + (2x - y) = 15 + 6\\]

\\[3x = 21\\]

Divide by 3:

\\[x = 7\\]

The $x$-coordinate of the solution is 7.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_2'
),
  (
  'mcq',
  'math',
  'A nutritionist is mixing two types of juices. Juice A contains 20% sugar and Juice B contains 5% sugar. The final mixture should be 10 liters and contain 1.25 liters of sugar. If $a$ is the liters of Juice A and $b$ is the liters of Juice B, which system of equations models this?',
  '[{"id":"a","text":"$a + b = 10$; $0.20a + 0.05b = 1.25$"},{"id":"b","text":"$a + b = 1.25$; $0.20a + 0.05b = 10$"},{"id":"c","text":"$a + b = 10$; $20a + 5b = 1.25$"},{"id":"d","text":"$0.20a + 0.05b = 10$; $a + b = 10$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In mixture problems, we create one equation for the total volume and a second equation for the specific component (in this case, sugar) contained within that volume.

\\textbf{Calculation and Logic:}

The total volume of juice must be 10 liters:

\\[a + b = 10\\]

The amount of sugar from Juice A is $20%$ of $a$ ($0.20a$) and from Juice B is $5%$ of $b$ ($0.05b$). The total sugar is 1.25 liters:

\\[0.20a + 0.05b = 1.25\\]

This matches the system provided in option A.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_3'
),
  (
  'spr',
  'math',
  'If $(x, y)$ is the solution to the system of equations below, what is the value of $y$? \\begin{align*} y &= 3x - 4 2x + y &= 16 \\end{align*}',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

Since the first equation is already solved for $y$, the substitution method is the best approach. We can replace the $y$ in the second equation with the expression $3x - 4$ from the first equation.

\\textbf{Calculation and Logic:}

Substitute $3x - 4$ into the second equation:

\\[2x + (3x - 4) = 16\\]

Combine like terms:

\\[5x - 4 = 16\\]

Add 4 to both sides:

\\[5x = 20 → x = 4\\]

Now, find $y$ by plugging $x = 4$ back into the first equation:

\\[y = 3(4) - 4 = 12 - 4 = 8\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_4'
),
  (
  'mcq',
  'math',
  'A landscaping company has two types of trucks. Type X carries 3 tons of soil and Type Y carries 5 tons. The company used a total of 12 trucks to deliver 44 tons of soil. Which system represents this?',
  '[{"id":"a","text":"$x + y = 12$; $3x + 5y = 44$"},{"id":"b","text":"$x + y = 44$; $3x + 5y = 12$"},{"id":"c","text":"$3x + 5y = 12$; $x + y = 12$"},{"id":"d","text":"$x + y = 12$; $5x + 3y = 44$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We define two variables for the number of trucks and set up equations based on the count of vehicles and their total carrying capacity.

\\textbf{Calculation and Logic:}

Total number of trucks:

\\[x + y = 12\\]

Total tons of soil (capacity per truck $×$ number of trucks):

\\[3x + 5y = 44\\]

Option A correctly represents both constraints.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_5'
),
  (
  'spr',
  'math',
  'In the system below, what is the value of $x + y$? \\begin{align*} 2x + 3y &= 12 x - y &= 1 \\end{align*}',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

We first solve the system to find the individual values of $x$ and $y$, then add them together as requested by the question.

\\textbf{Calculation and Logic:}

Multiply the second equation by 3 to use elimination:

\\[3(x - y) = 3(1) → 3x - 3y = 3\\]

Add this to the first equation:

\\[(2x + 3y) + (3x - 3y) = 12 + 3\\]

\\[5x = 15 → x = 3\\]

Plug $x = 3$ into $x - y = 1$:

\\[3 - y = 1 → y = 2\\]

Final value: $x + y = 3 + 2 = 5$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_6'
),
  (
  'mcq',
  'math',
  'A hotel has 60 rooms, some of which are singles and some are doubles. A single room costs 90 per night and a double room costs 140 per night. If the hotel is full and the total revenue is 7,400, how many double rooms ($d$) does the hotel have?',
  '[{"id":"a","text":"20"},{"id":"b","text":"40"},{"id":"c","text":"30"},{"id":"d","text":"25"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We set up a system where $s$ is the number of single rooms and $d$ is the number of double rooms.

\\textbf{Calculation and Logic:}

Equation 1 (Total rooms): $s + d = 60 → s = 60 - d$

Equation 2 (Total revenue): $90s + 140d = 7,400$

Substitute $s$ into Equation 2:

\\[90(60 - d) + 140d = 7,400\\]

\\[5,400 - 90d + 140d = 7,400\\]

\\[50d = 2,000 → d = 40\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_7'
),
  (
  'spr',
  'math',
  'If $2x + y = 10$ and $x + 2y = 8$, what is the value of $x - y$?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

Instead of solving for $x$ and $y$ separately, we can look for a way to manipulate the equations to get the expression $x - y$ directly.

\\textbf{Calculation and Logic:}

Subtract the second equation from the first:

\\[(2x + y) - (x + 2y) = 10 - 8\\]

\\[2x + y - x - 2y = 2\\]

\\[x - y = 2\\]

This shortcut allows us to find the answer without full elimination.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_8'
),
  (
  'mcq',
  'math',
  'A merchant buys two types of coffee beans. Type A costs 4 per pound and Type B costs 7 per pound. The merchant buys a total of 30 pounds for 165. How many pounds of Type B coffee did he buy?',
  '[{"id":"a","text":"12"},{"id":"b","text":"15"},{"id":"c","text":"18"},{"id":"d","text":"20"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Let $a$ be pounds of Type A and $b$ be pounds of Type B.

\\textbf{Calculation and Logic:}

$a + b = 30 → a = 30 - b$

$4a + 7b = 165$

Substitute:

\\[4(30 - b) + 7b = 165\\]

\\[120 - 4b + 7b = 165\\]

\\[3b = 45 → b = 15\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_9'
),
  (
  'spr',
  'math',
  'Find the value of $x$ for the system: \\begin{align*} 3x + 2y &= 18 x - 2y &= 2 \\end{align*}',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

The $y$ coefficients are $2$ and $-2$. Adding these equations will eliminate $y$.

\\textbf{Calculation and Logic:}

\\[(3x + 2y) + (x - 2y) = 18 + 2\\]

\\[4x = 20 → x = 5\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_10'
),
  (
  'mcq',
  'math',
  'An exam has 50 questions. Students earn 4 points for each correct answer ($c$) and lose 1 point for each incorrect answer ($w$). If a student gets a score of 150 by answering all questions, which system represents this?',
  '[{"id":"a","text":"$c + w = 50$; $4c - w = 150$"},{"id":"b","text":"$c + w = 150$; $4c - w = 50$"},{"id":"c","text":"$4c + w = 50$; $c - w = 150$"},{"id":"d","text":"$c + w = 50$; $4c + w = 150$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The total questions answered is the sum of correct and incorrect answers. The score is determined by the points gained minus the points lost.

\\textbf{Calculation and Logic:}

Total questions: $c + w = 50$.

Total points: $4(c) - 1(w) = 150 → 4c - w = 150$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_11'
),
  (
  'spr',
  'math',
  'If $5x + 2y = 20$ and $x + y = 7$, what is the value of $3x$?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

First, we solve for $x$ by eliminating $y$, then we multiply that result by 3.

\\textbf{Calculation and Logic:}

Multiply $x + y = 7$ by 2:

\\[2x + 2y = 14\\]

Subtract from the first equation:

\\[(5x + 2y) - (2x + 2y) = 20 - 14\\]

\\[3x = 6\\]

The question asks for $3x$, which is 6.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_12'
),
  (
  'mcq',
  'math',
  'Two numbers have a sum of 25 and a difference of 7. What is the larger number?',
  '[{"id":"a","text":"16"},{"id":"b","text":"18"},{"id":"c","text":"9"},{"id":"d","text":"11"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Let the numbers be $x$ and $y$. We form two equations based on their sum and difference.

\\textbf{Calculation and Logic:}

$x + y = 25$

$x - y = 7$

Add the equations: $2x = 32 → x = 16$.

Plug $x = 16$ into $x + y = 25$: $16 + y = 25 → y = 9$.

The larger number is 16.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_13'
),
  (
  'spr',
  'math',
  'In the system $x = 2y$ and $x + y = 12$, what is the value of $y$?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

Since $x$ is explicitly defined in terms of $y$, we substitute $2y$ for $x$ in the second equation.

\\textbf{Calculation and Logic:}

\\[(2y) + y = 12\\]

\\[3y = 12 → y = 4\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_14'
),
  (
  'mcq',
  'math',
  'A farmer has chickens ($c$) and cows ($w$). There are 20 animals in total and they have 56 legs. Which system represents this?',
  '[{"id":"a","text":"$c + w = 20$; $2c + 4w = 56$"},{"id":"b","text":"$c + w = 56$; $2c + 4w = 20$"},{"id":"c","text":"$c + w = 20$; $4c + 2w = 56$"},{"id":"d","text":"$2c + 4w = 20$; $c + w = 56$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Chickens have 2 legs and cows have 4 legs. The system consists of an animal count equation and a leg count equation.

\\textbf{Calculation and Logic:}

Animal count: $c + w = 20$.

Leg count: $2c + 4w = 56$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_15'
),
  (
  'spr',
  'math',
  'Solve for $x$: \\begin{align*} 4x - 3y &= 11 2x + 3y &= 7 \\end{align*}',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

Adding these equations will eliminate the $y$ variable.

\\textbf{Calculation and Logic:}

\\[(4x - 3y) + (2x + 3y) = 11 + 7\\]

\\[6x = 18 → x = 3\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_16'
),
  (
  'mcq',
  'math',
  'A theater sells adult tickets for 10 and child tickets for 6. One evening, 100 tickets were sold for 840. How many adult tickets ($a$) were sold?',
  '[{"id":"a","text":"40"},{"id":"b","text":"60"},{"id":"c","text":"50"},{"id":"d","text":"70"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Let $a$ be adult and $c$ be child tickets.

\\textbf{Calculation and Logic:}

$a + c = 100 → c = 100 - a$

$10a + 6c = 840$

\\[10a + 6(100 - a) = 840\\]

\\[10a + 600 - 6a = 840\\]

\\[4a = 240 → a = 60\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_17'
),
  (
  'spr',
  'math',
  'If $y = 2x$ and $3x + 2y = 21$, what is the value of $x$?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

Substitute $2x$ for $y$ in the second equation.

\\textbf{Calculation and Logic:}

\\[3x + 2(2x) = 21\\]

\\[3x + 4x = 21\\]

\\[7x = 21 → x = 3\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_18'
),
  (
  'mcq',
  'math',
  '$x + y = 10$ and $2x + 2y = 20$. How many solutions does this system have?',
  '[{"id":"a","text":"Exactly one"},{"id":"b","text":"Exactly two"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"None"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

If one equation is a direct multiple of the other, they represent the same line.

\\textbf{Calculation and Logic:}

The second equation $2x + 2y = 20$ can be divided by 2 to get $x + y = 10$, which is identical to the first equation. Since they are the same line, every point on the line is a solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_19'
),
  (
  'spr',
  'math',
  'If $ax + 3y = 12$ and $2x + y = 4$ has infinitely many solutions, what is the value of $a$?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

For infinitely many solutions, the equations must be equivalent.

\\textbf{Calculation and Logic:}

The second equation has $y$, while the first has $3y$. Multiply the second equation by 3:

\\[3(2x + y) = 3(4) → 6x + 3y = 12\\]

Comparing $6x + 3y = 12$ to $ax + 3y = 12$, we see $a = 6$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_20'
),
  (
  'mcq',
  'math',
  'A car rental costs 50 per day plus 0.20 per mile ($m$). A truck rental costs 30 per day plus 0.30 per mile. At what distance in miles is the cost for one day the same for both?',
  '[{"id":"a","text":"100"},{"id":"b","text":"200"},{"id":"c","text":"150"},{"id":"d","text":"250"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We set the total cost equations equal to each other to find the distance where the costs intersect.

\\textbf{Calculation and Logic:}

Car: $50 + 0.20m$

Truck: $30 + 0.30m$

Set them equal:

\\[50 + 0.20m = 30 + 0.30m\\]

\\[20 = 0.10m\\]

\\[m = 200\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_21'
),
  (
  'spr',
  'math',
  'In the system $y = x + 4$ and $y = -2x + 10$, what is the $x$-coordinate of the solution?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

Since both equations equal $y$, we can set them equal to each other.

\\textbf{Calculation and Logic:}

\\[x + 4 = -2x + 10\\]

\\[3x = 6 → x = 2\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_22'
),
  (
  'mcq',
  'math',
  '$x + y = 5$ and $x + y = 8$. How many solutions?',
  '[{"id":"a","text":"One"},{"id":"b","text":"None"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Two"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Two lines with the same slope but different intercepts are parallel and never intersect.

\\textbf{Calculation and Logic:}

Both equations have a slope of -1 ($y = -x + 5$ and $y = -x + 8$). Since they are parallel and do not overlap, there are no solutions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_23'
),
  (
  'spr',
  'math',
  'If $2x - 3y = 7$ and $x + y = 6$, find $y$.',
  NULL,
  '1',
  '\\textbf{Conceptual Explanation:}

We eliminate $x$ by multiplying the second equation by 2.

\\textbf{Calculation and Logic:}

Multiply $x + y = 6$ by 2: $2x + 2y = 12$.

Subtract the first from the second:

\\[(2x + 2y) - (2x - 3y) = 12 - 7\\]

\\[5y = 5 → y = 1\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_24'
),
  (
  'mcq',
  'math',
  'A system has the same slope and different $y$-intercepts. The graph shows:',
  '[{"id":"a","text":"Intersecting lines"},{"id":"b","text":"Parallel lines"},{"id":"c","text":"Perpendicular lines"},{"id":"d","text":"Overlapping lines"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Lines that change at the same rate (same slope) but start at different points (different intercepts) will always remain the same distance apart.

\\textbf{Calculation and Logic:}

The definition of parallel lines in the $xy$-plane is having identical slopes and distinct $y$-intercepts.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_25'
),
  (
  'spr',
  'math',
  'If $3x - y = 10$ and $x + 2y = 8$, what is the value of $10y$?',
  NULL,
  '20',
  '\\textbf{Conceptual Explanation:}

We solve for $y$ using elimination, then multiply the result by 10.

\\textbf{Calculation and Logic:}

Multiply the first equation by 2: $6x - 2y = 20$.

Add to the second: $(6x - 2y) + (x + 2y) = 20 + 8 → 7x = 28 → x = 4$.

Substitute $x = 4$ into $x + 2y = 8$: $4 + 2y = 8 → 2y = 4 → y = 2$.

Final value: $10(2) = 20$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_26'
),
  (
  'mcq',
  'math',
  'For what value of $k$ will the system below have no solution? \\begin{align*} kx - 3y &= 4 4x - 6y &= 7 \\end{align*}',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"8"},{"id":"d","text":"-2"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

A system has no solution if the lines are parallel (same slope) but have different intercepts.

\\textbf{Calculation and Logic:}

The $y$ coefficients are $-3$ and $-6$. Multiply the first equation by 2 to match the $y$ terms:

\\[2kx - 6y = 8\\]

For the lines to be parallel, the $x$ coefficients must match: $2k = 4 → k = 2$.

With $k=2$, the system is $4x - 6y = 8$ and $4x - 6y = 7$. Since $8 \\neq 7$, there is no solution.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_27'
),
  (
  'spr',
  'math',
  'If $x = y + 3$ and $x^2 - y^2 = 21$, what is the value of $x + y$?',
  NULL,
  '7',
  '\\textbf{Conceptual Explanation:}

We use the algebraic identity for the difference of squares: $x^2 - y^2 = (x - y)(x + y)$.

\\textbf{Calculation and Logic:}

From the first equation, $x - y = 3$.

Substitute this into the identity:

\\[(x - y)(x + y) = 21\\]

\\[(3)(x + y) = 21\\]

Divide by 3:

\\[x + y = 7\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_28'
),
  (
  'mcq',
  'math',
  'A system of two linear equations has no solutions. One equation is $y = 0.5x + 3$. Which could be the other?',
  '[{"id":"a","text":"$x - 2y = 10$"},{"id":"b","text":"$2x - y = 6$"},{"id":"c","text":"$x + 2y = 3$"},{"id":"d","text":"$0.5x + y = 3$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The other equation must have the same slope (0.5) but a different $y$-intercept.

\\textbf{Calculation and Logic:}

Test Option A: $x - 2y = 10 → -2y = -x + 10 → y = 0.5x - 5$.

This line has the same slope (0.5) and a different intercept (-5), so it is parallel and has no solution.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_29'
),
  (
  'spr',
  'math',
  'If $x + y = 10$ and $x - y = 4$, what is the value of $x^2 - y^2$?',
  NULL,
  '40',
  '\\textbf{Conceptual Explanation:}

We can use the difference of squares identity: $x^2 - y^2 = (x + y)(x - y)$.

\\textbf{Calculation and Logic:}

We are given both parts of the identity: $x + y = 10$ and $x - y = 4$.

\\[x^2 - y^2 = (10)(4) = 40\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_30'
),
  (
  'mcq',
  'math',
  'At a cafe, 2 coffees and 3 teas cost 14.50. 3 coffees and 2 teas cost 15.50. What is the cost of one coffee?',
  '[{"id":"a","text":"3.50"},{"id":"b","text":"2.50"},{"id":"c","text":"4.00"},{"id":"d","text":"3.00"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Let $c$ be coffee and $t$ be tea. We use elimination to isolate $c$.

\\textbf{Calculation and Logic:}

1) $2c + 3t = 14.50$

2) $3c + 2t = 15.50$

Multiply (1) by 2 and (2) by 3:

$4c + 6t = 29.00$

$9c + 6t = 46.50$

Subtract: $5c = 17.50 → c = 3.50$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_31'
),
  (
  'spr',
  'math',
  'If $y = 3x - 1$ and $y = x + 7$, what is the value of $x$?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

Set the two expressions for $y$ equal to each other.

\\textbf{Calculation and Logic:}

\\[3x - 1 = x + 7\\]

\\[2x = 8 → x = 4\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_32'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, the lines $y = 2x + 1$ and $y = ax + b$ are perpendicular and intersect at $(0, 1)$. What is the value of $a$?',
  '[{"id":"a","text":"-0.5"},{"id":"b","text":"2"},{"id":"c","text":"-2"},{"id":"d","text":"0.5"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Perpendicular lines have slopes that are negative reciprocals of each other.

\\textbf{Calculation and Logic:}

The slope of the first line is 2. The negative reciprocal of 2 is $-1/2$ or $-0.5$. Thus, $a = -0.5$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_33'
),
  (
  'spr',
  'math',
  'If $2x + 3y = 13$ and $y = 3$, what is the value of $x$?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

Substitute the given value of $y$ into the first equation.

\\textbf{Calculation and Logic:}

\\[2x + 3(3) = 13\\]

\\[2x + 9 = 13\\]

\\[2x = 4 → x = 2\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_34'
),
  (
  'mcq',
  'math',
  'How many solutions does the system below have? \\begin{align*} x - 2y &= 5 -3x + 6y &= -15 \\end{align*}',
  '[{"id":"a","text":"None"},{"id":"b","text":"One"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Two"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Check if the equations are multiples of each other.

\\textbf{Calculation and Logic:}

Multiply the first equation by -3:

\\[-3(x - 2y) = -3(5) → -3x + 6y = -15\\]

Since this is exactly the second equation, they are the same line and have infinitely many solutions.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_35'
),
  (
  'spr',
  'math',
  'If $x + y = 20$ and $0.5x + 0.2y = 7$, what is $x$?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

We eliminate $y$ by multiplying the second equation by 5.

\\textbf{Calculation and Logic:}

Multiply $0.5x + 0.2y = 7$ by 5:

\\[2.5x + y = 35\\]

Subtract $x + y = 20$ from it:

\\[(2.5x + y) - (x + y) = 35 - 20\\]

\\[1.5x = 15 → x = 10\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_36'
),
  (
  'mcq',
  'math',
  'A boat travels 24 miles downstream in 2 hours and 24 miles upstream in 3 hours. What is the speed of the current?',
  '[{"id":"a","text":"2 mph"},{"id":"b","text":"10 mph"},{"id":"c","text":"12 mph"},{"id":"d","text":"4 mph"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Let $b$ be the boat speed and $c$ be the current. Downstream speed is $b+c$, upstream is $b-c$.

\\textbf{Calculation and Logic:}

$b + c = 24 / 2 = 12$

$b - c = 24 / 3 = 8$

Subtract the equations: $2c = 4 → c = 2$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_37'
),
  (
  'spr',
  'math',
  'If $x = 5$ and $2x - y = 4$, what is $y$?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

Plug the known $x$ into the equation.

\\textbf{Calculation and Logic:}

\\[2(5) - y = 4\\]

\\[10 - y = 4 → y = 6\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_38'
),
  (
  'mcq',
  'math',
  'The lines $y = mx + 2$ and $y = 3x + 5$ are parallel. What is $m$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"-3"},{"id":"c","text":"1/3"},{"id":"d","text":"2"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Parallel lines must have identical slopes.

\\textbf{Calculation and Logic:}

The slope of the second line is 3. For the first line to be parallel, $m$ must also be 3.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_39'
),
  (
  'spr',
  'math',
  'Solve for $x$: $y = 2x - 5$ and $y = -x + 10$.',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

Set the two expressions for $y$ equal.

\\textbf{Calculation and Logic:}

\\[2x - 5 = -x + 10\\]

\\[3x = 15 → x = 5\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_40'
),
  (
  'mcq',
  'math',
  'System $x + 2y = 10$ and $x + 2y = k$ has infinitely many solutions. $k = $?',
  '[{"id":"a","text":"10"},{"id":"b","text":"5"},{"id":"c","text":"20"},{"id":"d","text":"0"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Equations must be identical for infinite solutions.

\\textbf{Calculation and Logic:}

To match the first equation exactly, $k$ must be 10.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_41'
),
  (
  'spr',
  'math',
  'If $y = 4$ and $x + y = 10$, find $x$.',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

Simple substitution.

\\textbf{Calculation and Logic:}

\\[x + 4 = 10 → x = 6\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_42'
),
  (
  'mcq',
  'math',
  'Perpendicular to $y = -0.25x$?',
  '[{"id":"a","text":"$y = 4x$"},{"id":"b","text":"$y = -4x$"},{"id":"c","text":"$y = 0.25x$"},{"id":"d","text":"$y = -0.25x$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Negative reciprocal of -0.25 (-1/4) is 4.

\\textbf{Calculation and Logic:}

Slope of original line is $-1/4$. Flip and change sign: $4/1 = 4$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_43'
),
  (
  'spr',
  'math',
  'If $3x + y = 13$ and $x + y = 7$, find $x$.',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

Subtract the equations to eliminate $y$.

\\textbf{Calculation and Logic:}

\\[(3x + y) - (x + y) = 13 - 7\\]

\\[2x = 6 → x = 3\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_44'
),
  (
  'mcq',
  'math',
  'Sum is 10, difference is 2. Smaller number?',
  '[{"id":"a","text":"4"},{"id":"b","text":"6"},{"id":"c","text":"2"},{"id":"d","text":"8"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

$x+y=10, x-y=2$.

\\textbf{Calculation and Logic:}

$2x=12 → x=6$. $6+y=10 → y=4$. Smaller is 4.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_45'
),
  (
  'spr',
  'math',
  'If $y = x^2$ and $y = 4$, how many positive solutions for $x$?',
  NULL,
  '1',
  '\\textbf{Conceptual Explanation:}

Substitute $y$ into the first equation.

\\textbf{Calculation and Logic:}

\\[4 = x^2 → x = \\pm 2\\]

Positive solution is 2.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_46'
),
  (
  'mcq',
  'math',
  'Intersection of $x=3$ and $y=5$?',
  '[{"id":"a","text":"(3, 5)"},{"id":"b","text":"(5, 3)"},{"id":"c","text":"(0, 0)"},{"id":"d","text":"(3, 0)"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The intersection of a vertical line and a horizontal line is the point formed by their constant values.

\\textbf{Calculation and Logic:}

$x$ is always 3, $y$ is always 5. Point is (3, 5).',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_47'
),
  (
  'spr',
  'math',
  'If $y = 0$ and $2x + 3y = 12$, find $x$.',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

Find the $x$-intercept.

\\textbf{Calculation and Logic:}

\\[2x + 3(0) = 12 → 2x = 12 → x = 6\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_007_48'
),
  (
  'mcq',
  'math',
  'Parallel to $y = 3x + 10$ through $(0,0)$?',
  '[{"id":"a","text":"$y = 3x$"},{"id":"b","text":"$y = -3x$"},{"id":"c","text":"$y = 1/3x$"},{"id":"d","text":"$y = 3$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Same slope, $y$-intercept is 0.

\\textbf{Calculation and Logic:}

Slope must be 3. Through origin means $b=0$. $y = 3x$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_49'
),
  (
  'spr',
  'math',
  'If $2x + y = 7$ and $x + 2y = 5$, find $x + y$.',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

Add the two equations to find a multiple of $x + y$.

\\textbf{Calculation and Logic:}

\\[(2x + y) + (x + 2y) = 7 + 5\\]

\\[3x + 3y = 12\\]

Divide by 3:

\\[x + y = 4\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_007_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

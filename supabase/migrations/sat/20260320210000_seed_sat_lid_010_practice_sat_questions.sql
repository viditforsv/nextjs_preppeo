-- Practice-mode math from lid_010.tex (sat_lid_010)
-- Chapter: Linear inequalities in one or two variables | Topic: Solving & Graphing Inequalities
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_010_N, practice module/set 0.
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
  'A landscaping service that mows both lawns and parks can mow at most 12 locations per day. Which inequality represents this situation, where $L$ is the number of lawns and $P$ is the number of parks?',
  '[{"id":"a","text":"$L + P \\\\le 12$"},{"id":"b","text":"$L + P \\\\ge 12$"},{"id":"c","text":"$L - P \\\\le 12$"},{"id":"d","text":"$L - P \\\\ge 12$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The phrase "at most" indicates a maximum limit. In mathematical terms, this translates to the "less than or equal to" symbol ($\\le$). The total count of locations is the sum of the two types of properties.

\\textbf{Calculation and Logic:}

Total locations = (Number of lawns) + (Number of parks)

Total locations = $L + P$

Constraint: Must be no more than 12.

Inequality: $L + P \\le 12$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_010_1'
),
  (
  'mcq',
  'math',
  'The shaded region shown represents solutions to an inequality. Which ordered pair $(x, y)$ is a solution to this inequality? \\begin{center} \\begin{tikzpicture}[scale=0.5] \\draw[help lines, color=gray!30, step=1] (-5,-5) grid (5,5); \\draw[->,thick] (-5.5,0) -- (5.5,0) node[right] {$x$}; \\draw[->,thick] (0,-5.5) -- (0,5.5) node[above] {$y$}; \\foreach \\x in {-4,-2,2,4} \\draw (\\x,0.1) -- (\\x,-0.1) node[below] {\\tiny \\x}; \\foreach \\y in {-4,-2,2,4} \\draw (0.1,\\y) -- (-0.1,\\y) node[left] {\\tiny \\y}; \\fill[gray, opacity=0.5] (1,5) -- (5,5) -- (5,-5) -- (3,-5) -- cycle; \\draw[very thick] (1,5) -- (3,-5); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$(0, 0)$"},{"id":"b","text":"$(-2, 2)$"},{"id":"c","text":"$(4, 1)$"},{"id":"d","text":"$(1, -2)$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A solution to a graphed inequality is any point that lies within the shaded region or on the boundary line (if the line is solid).

\\textbf{Calculation and Logic:}

Checking the points:

$(0, 0)$ is to the left of the shaded region.

$(-2, 2)$ is far to the left in the unshaded region.

$(1, -2)$ is on the left side of the boundary.

$(4, 1)$ is clearly inside the gray shaded area to the right of the line.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_2'
),
  (
  'mcq',
  'math',
  'A delivery van can carry a maximum weight of 3,500 pounds. The van currently holds a machine weighing 400 pounds. If the rest of the load consists of identical crates weighing 150 pounds each, what is the maximum number of crates, $n$, the van can carry?',
  '[{"id":"a","text":"20"},{"id":"b","text":"21"},{"id":"c","text":"23"},{"id":"d","text":"24"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The total weight is composed of a fixed value (the machine) and a variable value (the crates). This sum must be less than or equal to the van''s capacity.

\\textbf{Calculation and Logic:}

Total Weight = $400 + 150n$

Constraint: $400 + 150n \\le 3,500$

Subtract 400: $150n \\le 3,100$

Divide by 150: $n \\le 20.67$

Since $n$ must be a whole number of crates, the maximum is 20.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_3'
),
  (
  'spr',
  'math',
  'David is renting a jet ski. The rental fee is 45 per hour plus a mandatory 15 insurance fee. David wants to spend no more than 160. If he can only rent the jet ski for a whole number of hours, what is the maximum number of hours he can rent it?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

We establish a linear inequality where the hourly rate is the slope and the insurance is the y-intercept.

\\textbf{Calculation and Logic:}

Let $h$ be the number of hours.

Cost: $45h + 15 \\le 160$

$45h \\le 145$

Divide by 45: $h \\le 3.22$

The largest whole number satisfying this is 3.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_4'
),
  (
  'mcq',
  'math',
  'A craft store manager is ordering $x$ canvases and $y$ sets of paint. The manager must order at least 15 items, but the total budget is capped at 120. Canvases cost 5 each and paint sets cost 8 each. Which system of inequalities models this?',
  '[{"id":"a","text":"$x + y \\\\ge 15$; $5x + 8y \\\\le 120$"},{"id":"b","text":"$x + y \\\\le 15$; $5x + 8y \\\\ge 120$"},{"id":"c","text":"$5x + 8y \\\\ge 15$; $x + y \\\\le 120$"},{"id":"d","text":"$x + y \\\\ge 15$; $5x + 8y \\\\ge 120$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

"At least 15 items" means the sum of items $x$ and $y$ must be $\\ge 15$. "Capped at 120" means the total cost must be $\\le 120$.

\\textbf{Calculation and Logic:}

Count Inequality: $x + y \\ge 15$

Cost Inequality: (Price of $x \\cdot x$) + (Price of $y \\cdot y$) $\\le$ Budget

$5x + 8y \\le 120$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_5'
),
  (
  'mcq',
  'math',
  'The average annual heating cost for a house is 3,200. A new insulation system costs 18,000 to install, after which the heating cost is estimated to drop to 1,900 per year. Which inequality finds $t$, the years after which the total savings exceed the installation cost?',
  '[{"id":"a","text":"$18,000 > (3,200 - 1,900)t$"},{"id":"b","text":"$18,000 < (3,200 - 1,900)t$"},{"id":"c","text":"$18,000 - 3,200 > 1,900t$"},{"id":"d","text":"$18,000 > \\\\frac{3,200}{1,900}t$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Savings per year is the difference between the old cost and the new cost. For total savings to "exceed" cost, (Savings $×$ Time) must be greater than the installation price.

\\textbf{Calculation and Logic:}

Annual Savings = $3,200 - 1,900$

Total Savings over $t$ years = $(3,200 - 1,900)t$

We want: Savings $>$ Cost

$(3,200 - 1,900)t > 18,000$, which is equivalent to $18,000 < (3,200 - 1,900)t$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_6'
),
  (
  'mcq',
  'math',
  'Which of the following ordered pairs $(x, y)$ satisfies the system below? \\[ y \\le 2x + 3 \\] \\[ x - y > 2 \\]',
  '[{"id":"a","text":"$(0, 0)$"},{"id":"b","text":"$(4, 1)$"},{"id":"c","text":"$(-2, -1)$"},{"id":"d","text":"$(1, 5)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

An ordered pair is a solution if it makes BOTH inequalities true when substituted.

\\textbf{Calculation and Logic:}

Test $(4, 1)$:

1) $1 \\le 2(4) + 3 → 1 \\le 11$ (True)

2) $4 - 1 > 2 → 3 > 2$ (True)

Since both are true, $(4, 1)$ is a solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_7'
),
  (
  'mcq',
  'math',
  'A sea turtle travels 45 to 52 miles per day. Which inequality represents the estimated total miles, $m$, the turtle travels in 12 days?',
  '[{"id":"a","text":"$45 + 12 \\\\le m \\\\le 52 + 12$"},{"id":"b","text":"$(45)(12) \\\\le m \\\\le (52)(12)$"},{"id":"c","text":"$45 \\\\le m/12 \\\\le 52$"},{"id":"d","text":"Both B and C"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

To find the range over multiple days, we multiply the daily minimum and maximum by the number of days.

\\textbf{Calculation and Logic:}

Minimum: $45 × 12$

Maximum: $52 × 12$

Range: $(45)(12) \\le m \\le (52)(12)$.

Note that dividing by 12 (Option C) also results in the daily speed, so B and C are mathematically equivalent.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_8'
),
  (
  'mcq',
  'math',
  'The shaded region represents the solutions to which inequality? \\begin{center} \\begin{tikzpicture}[scale=0.5] \\draw[help lines, color=gray!30, step=1] (-2,-8) grid (10,2); \\draw[->,thick] (-2,0) -- (10,0) node[right] {$x$}; \\draw[->,thick] (0,-8) -- (0,2) node[above] {$y$}; \\fill[gray, opacity=0.4] (-2, -8) -- (10,0) -- (10,2) -- (-2,2) -- cycle; \\draw[very thick] (-2, -8) -- (10,0); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$y \\\\ge \\\\frac{2}{3}x - 6.67$"},{"id":"b","text":"$y \\\\le \\\\frac{2}{3}x - 6.67$"},{"id":"c","text":"$y \\\\ge x - 8$"},{"id":"d","text":"$y \\\\le x - 8$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Determine the y-intercept ($b$) and slope ($m$) of the line, then check if shading is above ($\\ge$) or below ($\\le$).

\\textbf{Calculation and Logic:}

The line crosses the x-axis at $10$ and y-axis at approximately $-6.67$.

Slope $m = (0 - (-6.67))/(10 - 0) = 0.667 = (2)/(3)$.

Shading is above the line.

Inequality: $y \\ge (2)/(3)x - 6.67$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_9'
),
  (
  'spr',
  'math',
  'Sarah earns 12 per hour for the first 15 hours. Then she gets a raise to 15 per hour. She saves 80% of her earnings. What is the least number of additional hours she must work to save at least 360?',
  NULL,
  '18',
  '\\textbf{Conceptual Explanation:}

We must calculate her initial earnings, then determine the remaining amount needed, adjusting for her 80% savings rate.

\\textbf{Calculation and Logic:}

Initial Pay: $15 \\text{ hours} × 12 = 180$

To save 360 at an 80% rate, she needs total pre-tax earnings ($E$):

$0.80E = 360 → E = 450$

Earnings remaining needed: $450 - 180 = 270$

Additional hours ($h$): $15h = 270 → h = 18$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_10'
),
  (
  'mcq',
  'math',
  'A local library that lends both hardcovers and paperbacks can process at most 25 returns per hour. Which inequality represents this situation, where $c$ is the number of hardcovers and $p$ is the number of paperbacks?',
  '[{"id":"a","text":"$c + p \\\\le 25$"},{"id":"b","text":"$c + p \\\\ge 25$"},{"id":"c","text":"$c - p \\\\le 25$"},{"id":"d","text":"$c - p \\\\ge 25$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In SAT word problems, the phrase "at most" translates to the mathematical symbol $\\le$. This indicates a limit that can be reached but not exceeded.

\\textbf{Calculation and Logic:}

The total number of returns is the sum of the two types of books ($c$ and $p$).

Total returns = $c + p$

Since the maximum is 25, the sum must be less than or equal to 25.

Inequality: $c + p \\le 25$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_010_11'
),
  (
  'mcq',
  'math',
  'The shaded region shown represents solutions to an inequality. Which ordered pair $(x, y)$ is a solution to this inequality? \\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[help lines, color=gray!30, step=1] (-5,-5) grid (5,5); \\draw[->,thick] (-5.5,0) -- (5.5,0) node[right] {$x$}; \\draw[->,thick] (0,-5.5) -- (0,5.5) node[above] {$y$}; \\foreach \\x in {-4,-2,2,4} \\draw (\\x,0.1) -- (\\x,-0.1) node[below] {\\tiny \\x}; \\foreach \\y in {-4,-2,2,4} \\draw (0.1,\\y) -- (-0.1,\\y) node[left] {\\tiny \\y}; \\fill[gray, opacity=0.5] (-5,3) -- (5,-2) -- (5,5) -- (-5,5) -- cycle; \\draw[very thick] (-5,3) -- (5,-2); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$(0, -2)$"},{"id":"b","text":"$(-4, 0)$"},{"id":"c","text":"$(0, 4)$"},{"id":"d","text":"$(2, -3)$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A point is a solution to a graphed inequality if it falls within the shaded region. We test each option by finding its location on the coordinate plane relative to the shaded area.

\\textbf{Calculation and Logic:}

Checking the points:

$(0, -2)$ is below the boundary line in the white region.

$(-4, 0)$ is below the boundary line in the white region.

$(2, -3)$ is below the boundary line in the white region.

$(0, 4)$ is clearly above the line $y = -0.5x + 0.5$ and inside the shaded area.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_12'
),
  (
  'mcq',
  'math',
  'A freight elevator has a maximum weight capacity of 2,800 pounds. A pallet weighing 300 pounds is already on the elevator. If the remaining capacity is filled with boxes that weigh 40 pounds each, what is the maximum number of boxes the elevator can safely carry?',
  '[{"id":"a","text":"60"},{"id":"b","text":"62"},{"id":"c","text":"63"},{"id":"d","text":"70"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The total weight is the sum of the constant (the pallet) and the variable (the number of boxes multiplied by their unit weight). This sum cannot exceed the capacity.

\\textbf{Calculation and Logic:}

Let $b$ be the number of boxes.

Inequality: $300 + 40b \\le 2,800$

Subtract 300: $40b \\le 2,500$

Divide by 40: $b \\le 62.5$

Since you cannot have half a box, the maximum whole number is 62.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_13'
),
  (
  'spr',
  'math',
  'Julia is renting a bicycle. The cost is 12 per hour, plus a one-time 8 helmet fee. Julia wants to spend no more than 50 for the rental. If the bicycle is available only for a whole number of hours, what is the maximum number of hours for which Julia can rent the bicycle?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

This is a standard "no more than" problem, requiring a $\\le$ inequality. We solve for the variable $h$ and round down to the nearest integer.

\\textbf{Calculation and Logic:}

Let $h$ represent hours.

Cost: $12h + 8 \\le 50$

$12h \\le 42$

Divide by 12: $h \\le 3.5$

Because Julia can only rent for whole hours, the maximum is 3.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_14'
),
  (
  'mcq',
  'math',
  'A high school club is buying $x$ pizzas and $y$ cases of soda for a party. The club must buy at least 12 items total, but the cost must not exceed 150. If pizzas cost 10 each and soda cases cost 6 each, which system of inequalities models this?',
  '[{"id":"a","text":"$x + y \\\\le 12$; $10x + 6y \\\\le 150$"},{"id":"b","text":"$x + y \\\\ge 12$; $10x + 6y \\\\ge 150$"},{"id":"c","text":"$x + y \\\\ge 12$; $10x + 6y \\\\le 150$"},{"id":"d","text":"$10x + 6y \\\\ge 12$; $x + y \\\\le 150$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Systems of inequalities in SAT context usually involve a "count" constraint and a "cost" constraint. "At least" means $\\ge$ and "not exceed" means $\\le$.

\\textbf{Calculation and Logic:}

Constraint 1 (Quantity): $x + y \\ge 12$

Constraint 2 (Budget): $10x + 6y \\le 150$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_15'
),
  (
  'mcq',
  'math',
  'A company''s annual office supply expense is 8,500. The office manager spends 12,000 to switch to a paperless digital filing system. The manager estimates that the annual supply expense will then be 1,200. Which inequality finds $n$, the number of years at which the cumulative savings will exceed the initial investment?',
  '[{"id":"a","text":"$12,000 > (8,500 - 1,200)n$"},{"id":"b","text":"$12,000 < (8,500 - 1,200)n$"},{"id":"c","text":"$12,000 - 8,500 > 1,200n$"},{"id":"d","text":"$12,000 < \\\\frac{8,500}{1,200}n$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To "exceed" means to be greater than ($>$). We are comparing the investment cost to the annual savings multiplied by the number of years.

\\textbf{Calculation and Logic:}

Annual Savings = (Old Cost - New Cost) = $8,500 - 1,200$

Total Savings in $n$ years = $(8,500 - 1,200)n$

Target: Savings $>$ Investment

$(8,500 - 1,200)n > 12,000$, which is the same as $12,000 < (8,500 - 1,200)n$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_16'
),
  (
  'mcq',
  'math',
  'Which of the following ordered pairs $(x, y)$ satisfies the system of inequalities below? \\[ y \\le -2x + 4 \\] \\[ x - y > 3 \\]',
  '[{"id":"a","text":"$(0, 0)$"},{"id":"b","text":"$(1, 2)$"},{"id":"c","text":"$(3, -2)$"},{"id":"d","text":"$(0, 5)$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A solution must make both inequality statements true. We plug the $x$ and $y$ values from each option into both inequalities.

\\textbf{Calculation and Logic:}

Test $(3, -2)$:

1) $-2 \\le -2(3) + 4 → -2 \\le -2$ (True)

2) $3 - (-2) > 3 → 5 > 3$ (True)

Because $(3, -2)$ satisfies both, it is a solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_17'
),
  (
  'mcq',
  'math',
  'A migration model for monarch butterflies estimates they travel 65 to 80 miles per day. Which inequality represents the estimated total number of miles, $d$, a butterfly could travel in 14 days?',
  '[{"id":"a","text":"$65 + 14 \\\\le d \\\\le 80 + 14$"},{"id":"b","text":"$(65)(14) \\\\le d \\\\le (80)(14)$"},{"id":"c","text":"$65 \\\\le d + 14 \\\\le 80$"},{"id":"d","text":"$65 \\\\le 14d \\\\le 80$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

If we know the range for one day, we find the range for $N$ days by multiplying both the lower and upper bounds by $N$.

\\textbf{Calculation and Logic:}

Minimum distance = $65 × 14$

Maximum distance = $80 × 14$

Total miles $d$ must be between these two values: $(65)(14) \\le d \\le (80)(14)$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_18'
),
  (
  'mcq',
  'math',
  'The shaded region shown represents the solutions to which inequality? \\begin{center} \\begin{tikzpicture}[scale=0.5] \\draw[help lines, color=gray!30, step=1] (-1,-10) grid (11,1); \\draw[->,thick] (-1,0) -- (11,0) node[right] {$x$}; \\draw[->,thick] (0,-10) -- (0,1) node[above] {$y$}; \\fill[gray, opacity=0.4] (-1, -10) -- (11,-2) -- (11,1) -- (-1,1) -- cycle; \\draw[very thick] (-1, -10) -- (11,-2); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$y \\\\le \\\\frac{2}{3}x - 9.33$"},{"id":"b","text":"$y \\\\ge \\\\frac{2}{3}x - 9.33$"},{"id":"c","text":"$y \\\\ge x - 10$"},{"id":"d","text":"$y \\\\le x - 10$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The boundary line''s equation is $y = mx + b$. We find the y-intercept ($b$) and use a second point to find slope ($m$). Since shading is above the line, we use $\\ge$.

\\textbf{Calculation and Logic:}

The line passes through $(0, -9.33)$ and $(14, 0)$.

Slope $m = (0 - (-9.33))/(14 - 0) = (2)/(3)$.

Shading is above the line.

Inequality: $y \\ge (2)/(3)x - 9.33$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_19'
),
  (
  'mcq',
  'math',
  'Marcus is working a summer job. He earns 15 per hour for the first 20 hours. For any hours over 20, he earns 18 per hour. If Marcus saves 75% of his total earnings, what is the least number of overtime hours he must work to save at least 450?',
  '[{"id":"a","text":"17"},{"id":"b","text":"12"},{"id":"c","text":"8"},{"id":"d","text":"6"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We first find how much total he needs to earn to save 450, then calculate the earnings from his base hours, and finally find the required overtime hours.

\\textbf{Calculation and Logic:}

Let $E$ be total earnings. $0.75E = 450 → E = 600$.

Base Earnings = $20 × 15 = 300$.

Remaining needed = $600 - 300 = 300$.

Overtime hours $x$: $18x = 300 → x = 16.67$.

Least whole number of hours is 17.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_20'
),
  (
  'mcq',
  'math',
  'A gym allows a maximum of 40 members inside at one time. If $s$ represents students and $a$ represents adults, which inequality represents the capacity?',
  '[{"id":"a","text":"$s + a \\\\le 40$"},{"id":"b","text":"$s + a \\\\ge 40$"},{"id":"c","text":"$s - a \\\\le 40$"},{"id":"d","text":"$s + a < 40$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

"Maximum" implies that 40 is the limit. The sum can be equal to 40 or less than 40.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_010_21'
),
  (
  'spr',
  'math',
  'A parking garage charges 5 for the first hour and 3 for each additional hour. A driver has a maximum budget of 20. If the garage only charges for whole hours, what is the maximum number of total hours the driver can park?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

Note that the first hour is a fixed 5, and the 3 rate only applies to hours *after* the first.

\\textbf{Calculation and Logic:}

Let $x$ be the number of additional hours.

Total Cost: $5 + 3x \\le 20$

$3x \\le 15 → x \\le 5$.

Total hours = 1 (first hour) + 5 (additional hours) = 6.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_22'
),
  (
  'mcq',
  'math',
  'A farmer is planting $x$ acres of corn and $y$ acres of wheat. He has at least 50 acres of land available, but his seed budget is 2,000. Corn seeds cost 40 per acre and wheat seeds cost 30 per acre. Which system models this?',
  '[{"id":"a","text":"$x + y \\\\ge 50$; $40x + 30y \\\\le 2,000$"},{"id":"b","text":"$x + y \\\\le 50$; $40x + 30y \\\\le 2,000$"},{"id":"c","text":"$40x + 30y \\\\ge 50$; $x + y \\\\le 2,000$"},{"id":"d","text":"$x + y \\\\ge 50$; $40x + 30y \\\\ge 2,000$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

Acreage constraint: $x + y \\ge 50$. Budget constraint: $40x + 30y \\le 2,000$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_23'
),
  (
  'mcq',
  'math',
  'A car travels between 55 and 65 miles per hour. Which inequality represents the distance $d$ it could travel in 3 hours?',
  '[{"id":"a","text":"$55 \\\\times 3 \\\\le d \\\\le 65 \\\\times 3$"},{"id":"b","text":"$55 + 3 \\\\le d \\\\le 65 + 3$"},{"id":"c","text":"$55 \\\\le 3d \\\\le 65$"},{"id":"d","text":"$d/3 \\\\le 55$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

Multiply both bounds of the hourly rate by 3 hours.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_24'
),
  (
  'mcq',
  'math',
  'Which ordered pair $(x, y)$ is a solution to the system: $y > 2x - 4$ and $y < -x + 5$?',
  '[{"id":"a","text":"$(4, 0)$"},{"id":"b","text":"$(0, 0)$"},{"id":"c","text":"$(5, 5)$"},{"id":"d","text":"$(0, 6)$"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

Test $(0, 0)$:

1) $0 > 2(0) - 4 → 0 > -4$ (True)

2) $0 < -0 + 5 → 0 < 5$ (True)',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_25'
),
  (
  'mcq',
  'math',
  'Which of the following describes the solution set to the system of inequalities below? \\[ y > 3x + 2 \\] \\[ y < 3x - 4 \\]',
  '[{"id":"a","text":"A narrow strip between two parallel lines."},{"id":"b","text":"All points in the $xy$-plane."},{"id":"c","text":"No solution."},{"id":"d","text":"A single point of intersection."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In a system of inequalities, the solution set is the overlap of the two individual regions. If the boundary lines are parallel and the shaded regions face away from each other, there is no overlap.

\\textbf{Calculation and Logic:}

Both lines have the same slope ($m=3$), meaning they are parallel.

The first inequality shades everything ABOVE $y = 3x + 2$.

The second inequality shades everything BELOW $y = 3x - 4$.

Since the "above" region of the higher line and the "below" region of the lower line never touch, there is no common area.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_26'
),
  (
  'spr',
  'math',
  'For a system of inequalities, $y \\ge 2x + b$ and $y \\le 2x + c$. If $b = -5$ and $c = -5$, how many integer values of $y$ exist for the point where $x = 4$?',
  NULL,
  '1',
  '\\textbf{Conceptual Explanation:}

When the two boundary lines are the same but the inequalities face opposite directions (and include the "equal to" component), the solution set is restricted to the boundary line itself.

\\textbf{Calculation and Logic:}

Substitute $b$ and $c$:

1) $y \\ge 2x - 5$

2) $y \\le 2x - 5$

The only way $y$ can be both $\\ge$ and $\\le$ the same value is if $y$ equals that value.

At $x = 4$:

$y = 2(4) - 5 = 3$

There is exactly one integer value for $y$, which is 3.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_27'
),
  (
  'mcq',
  'math',
  'Which of the following systems of inequalities has the entire $xy$-plane as its solution set?',
  '[{"id":"a","text":"$y > x$ and $y < x$"},{"id":"b","text":"$y \\\\ge x$ and $y \\\\le x$"},{"id":"c","text":"$y > x - 5$ or $y < x + 5$"},{"id":"d","text":"$y > 5$ and $x > 5$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The word "or" in a compound inequality (union) means the solution is any point that satisfies at least one of the inequalities.

\\textbf{Calculation and Logic:}

In Option C, $y > x - 5$ covers everything above the lower line. $y < x + 5$ covers everything below the higher line. Because these two regions overlap and extend to infinity in opposite directions, every single point in the plane satisfies at least one of them.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_28'
),
  (
  'spr',
  'math',
  'A system of inequalities is given by $y > 4x + 10$ and $y < 4x + k$. If the system has no solution, what is the maximum possible integer value for $k$?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

For "no solution" with parallel lines, the region shaded "above" the first line must not overlap the region shaded "below" the second line. This happens if the second line is below or equal to the first line.

\\textbf{Calculation and Logic:}

The first line is $y = 4x + 10$ (shaded above).

The second line is $y = 4x + k$ (shaded below).

If $k \\le 10$, the area below $k$ and the area above 10 will never meet.

The largest integer $k$ that maintains no overlap is 10.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_29'
),
  (
  'mcq',
  'math',
  'An inequality is graphed such that the boundary line passes through $(0, -4)$ and $(2, 0)$, and the shading is below the line. Which of the following is the inequality?',
  '[{"id":"a","text":"$y \\\\le 2x - 4$"},{"id":"b","text":"$y \\\\ge 2x - 4$"},{"id":"c","text":"$y \\\\le -2x - 4$"},{"id":"d","text":"$y \\\\ge -2x - 4$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Slope $m = (0 - (-4))/(2 - 0) = (4)/(2) = 2$.

Y-intercept $b = -4$.

Boundary line: $y = 2x - 4$.

Shading below indicates $\\le$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_30'
),
  (
  'mcq',
  'math',
  'Which point $(x, y)$ satisfies the inequality $3x - 4y > 12$?',
  '[{"id":"a","text":"$(4, 0)$"},{"id":"b","text":"$(0, -3)$"},{"id":"c","text":"$(6, 1)$"},{"id":"d","text":"$(2, -2)$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

A: $3(4) - 4(0) = 12$. $12 > 12$ (False).

B: $3(0) - 4(-3) = 12$. $12 > 12$ (False).

C: $3(6) - 4(1) = 18 - 4 = 14$. $14 > 12$ (True).',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_31'
),
  (
  'mcq',
  'math',
  'A system of inequalities is graphed below. Which region contains the solution set? \\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[->] (-3,0) -- (3,0) node[right] {$x$}; \\draw[->] (0,-3) -- (0,3) node[above] {$y$}; \\draw[thick] (-3,1) -- (3,-2) node[right] {$l_1$}; \\draw[thick] (-1,-3) -- (2,3) node[right] {$l_2$}; \\node at (2,0) {I}; \\node at (0,2) {II}; \\node at (-2,0) {III}; \\node at (0,-2) {IV}; \\end{tikzpicture} \\end{center} If the system is $y > l_1$ and $x > 0.5$, which region is correct?',
  '[{"id":"a","text":"Region I"},{"id":"b","text":"Region II"},{"id":"c","text":"Region III"},{"id":"d","text":"Region IV"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Region I is to the right of the vertical-ish line ($x > 0.5$) and above the horizontal-ish line ($y > l_1$).',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_32'
),
  (
  'spr',
  'math',
  'A theater sells tickets for 20 and 30. The theater must sell at least 100 tickets and wants to make more than 2,600. What is the minimum number of 30 tickets they can sell to meet both goals?',
  NULL,
  '61',
  '\\textbf{Calculation and Logic:}

$x + y \\ge 100 → x = 100 - y$

$20x + 30y > 2,600$

$20(100 - y) + 30y > 2,600$

$2,000 - 20y + 30y > 2,600$

$10y > 600 → y > 60$.

The minimum integer is 61.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_33'
),
  (
  'mcq',
  'math',
  '$y < x + 5$. If $x$ increases by 2, what must happen to the maximum possible value of $y$?',
  '[{"id":"a","text":"It decreases by 2."},{"id":"b","text":"It increases by 2."},{"id":"c","text":"It remains the same."},{"id":"d","text":"It increases by 5."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

If $y_{max} \\approx x + 5$, then $(x+2) + 5 = (x+5) + 2$. The bound increases by 2.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_34'
),
  (
  'mcq',
  'math',
  'The inequality $x \\ge -3$ is graphed in the $xy$-plane. Which describes the shading?',
  '[{"id":"a","text":"Above a horizontal line."},{"id":"b","text":"Below a horizontal line."},{"id":"c","text":"To the left of a vertical line."},{"id":"d","text":"To the right of a vertical line."}]'::jsonb,
  'd',
  '\\textbf{Logic:}

$x = -3$ is a vertical line. $x \\ge -3$ means all $x$-values greater than -3, which are to the right.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_010_35'
),
  (
  'spr',
  'math',
  'A student needs an average of at least 90 on two tests. On the first test, she scored 84. What is the minimum score she needs on the second test?',
  NULL,
  '96',
  '\\textbf{Logic:}

$(84 + x)/2 \\ge 90$

$84 + x \\ge 180 → x \\ge 96$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_36'
),
  (
  'mcq',
  'math',
  'In a system of inequalities, the solution region is a triangle. Which of the following could be the system?',
  '[{"id":"a","text":"$x > 0, y > 0, x + y < 5$"},{"id":"b","text":"$x > 0, y > 0, y > x + 5$"},{"id":"c","text":"$x > 5, x < 2$"},{"id":"d","text":"$y > x, y > -x$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

Option A is bounded by the $x$-axis, $y$-axis, and the line $x+y=5$, forming a triangle in the first quadrant.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_37'
),
  (
  'mcq',
  'math',
  'Which inequality is equivalent to $-2y + 4x < 10$?',
  '[{"id":"a","text":"$y < 2x - 5$"},{"id":"b","text":"$y > 2x - 5$"},{"id":"c","text":"$y < -2x + 5$"},{"id":"d","text":"$y > -2x + 5$"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

$-2y < -4x + 10$

Divide by -2 (flip the inequality): $y > 2x - 5$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_38'
),
  (
  'mcq',
  'math',
  'If $(k, 2k)$ is a solution to $x + y \\le 12$, what is the maximum value of $k$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

$k + 2k \\le 12 → 3k \\le 12 → k \\le 4$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_39'
),
  (
  'mcq',
  'math',
  'A system has inequalities $y \\ge |x|$ and $y \\le 4$. What is the area of the solution region?',
  '[{"id":"a","text":"8"},{"id":"b","text":"16"},{"id":"c","text":"32"},{"id":"d","text":"4"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

This forms a triangle with vertices $(0,0), (-4,4), (4,4)$.

Base = 8, Height = 4. Area = $0.5 × 8 × 4 = 16$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_40'
),
  (
  'spr',
  'math',
  'If $y > 2x + 1$ and $y < 2x + 5$, how many integer values of $y$ are possible when $x = 0.5$?',
  NULL,
  '3',
  '\\textbf{Logic:}

$y > 2(0.5) + 1 → y > 2$

$y < 2(0.5) + 5 → y < 6$

Integers: 3, 4, 5. Total = 3.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_41'
),
  (
  'mcq',
  'math',
  'For which value of $a$ does the system $y > ax + 2$ and $y < 2x + 5$ have a solution region in the second quadrant?',
  '[{"id":"a","text":"$a = 2$"},{"id":"b","text":"$a = 5$"},{"id":"c","text":"$a = -1$"},{"id":"d","text":"All of the above"}]'::jsonb,
  'd',
  '\\textbf{Logic:}

The second quadrant is where $x < 0$ and $y > 0$. Both boundaries have positive y-intercepts, so regions above/near these intercepts will always include parts of the second quadrant.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_42'
),
  (
  'mcq',
  'math',
  '$x + y > 10$. If $x < 4$, what is true about $y$?',
  '[{"id":"a","text":"$y > 6$"},{"id":"b","text":"$y < 6$"},{"id":"c","text":"$y > 10$"},{"id":"d","text":"$y < 14$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

$y > 10 - x$. If $x$ is at its maximum (almost 4), $y$ must be at least $10 - 4 = 6$. So $y$ must be greater than 6.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_43'
),
  (
  'spr',
  'math',
  'How many points $(x, y)$ with integer coordinates satisfy $x > 0, y > 0,$ and $x + y < 4$?',
  NULL,
  '3',
  '\\textbf{Logic:}

Points: $(1, 1), (1, 2), (2, 1)$. Total = 3.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_44'
),
  (
  'mcq',
  'math',
  'The solution to $y < mx + b$ does not include any points in the first quadrant. What must be true about $m$ and $b$?',
  '[{"id":"a","text":"$m > 0, b > 0$"},{"id":"b","text":"$m < 0, b < 0$"},{"id":"c","text":"$m > 0, b < 0$"},{"id":"d","text":"$m < 0, b > 0$"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

For a line to stay out of the first quadrant while shading below, it must have a negative slope and a negative y-intercept.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_45'
),
  (
  'mcq',
  'math',
  '$y \\ge x + 2$ and $y \\le x + 2$. This system describes:',
  '[{"id":"a","text":"No points"},{"id":"b","text":"A single point"},{"id":"c","text":"A line"},{"id":"d","text":"A shaded region"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

When $y$ is both $\\ge$ and $\\le$ the same expression, $y$ must equal that expression. $y = x + 2$ is a line.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_46'
),
  (
  'mcq',
  'math',
  'If $y > x^2$ and $y < 4$, how many integer points $(x, y)$ are solutions?',
  '[{"id":"a","text":"3"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"7"}]'::jsonb,
  'd',
  '\\textbf{Logic:}

$x=0: y=1,2,3$ (3 pts)

$x=1: y=2,3$ (2 pts)

$x=-1: y=2,3$ (2 pts)

Total = 7.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_47'
),
  (
  'spr',
  'math',
  '$3x - y < 5$. If $(2, y)$ is a solution, what is the smallest integer value for $y$?',
  NULL,
  '2',
  '\\textbf{Logic:}

$3(2) - y < 5 → 6 - y < 5 → 1 < y$.

Smallest integer strictly greater than 1 is 2.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_48'
),
  (
  'mcq',
  'math',
  '$x + y > 5$ and $x + y < 5$. This system has:',
  '[{"id":"a","text":"One solution"},{"id":"b","text":"Infinite solutions"},{"id":"c","text":"No solution"},{"id":"d","text":"A solution at $(2.5, 2.5)$"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

A value cannot be strictly greater than and strictly less than 5 at the same time.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_010_49'
),
  (
  'spr',
  'math',
  'In the system $y > 2x + 10$ and $y < -x + 25$, what is the maximum possible integer $x$-coordinate for a solution?',
  NULL,
  '4',
  '\\textbf{Logic:}

Set boundaries equal: $2x + 10 = -x + 25 → 3x = 15 → x = 5$.

Since the inequalities are strict ($<$ and $>$), $x$ must be less than 5. Max integer is 4.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_010_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

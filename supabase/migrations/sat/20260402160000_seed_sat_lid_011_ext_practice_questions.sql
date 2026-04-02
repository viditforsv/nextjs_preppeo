-- Practice-mode math questions from sat_lid_011 extension (sat_extention/sat_lid_011.tex)
-- Chapter: Linear inequalities in one or two variables | Topic: Systems of Inequalities
-- section=math, domain=algebra, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_011_51 to sat_lid_011_70
-- Extends: 20260320220000_seed_sat_lid_011_practice_sat_questions.sql (which covers _1 to _50)
-- 20 questions total: 6 easy, 9 medium, 5 hard

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

-- Q1 (sat_lid_011_51): Ordered pair satisfying system
(
  'mcq',
  'math',
  '$y \leq 4x + 2$
$x - y > 2$

Which of the following ordered pairs $(x, y)$ satisfies the system of inequalities above?',
  '[{"id":"a","text":"$(-3, -2)$"},{"id":"b","text":"$(-1, 4)$"},{"id":"c","text":"$(1, 6)$"},{"id":"d","text":"$(3, -1)$"}]'::jsonb,
  'd',
  'Test $(3, -1)$:

Inequality 1: $-1 \leq 4(3) + 2 = 14$. True.
Inequality 2: $3 - (-1) = 4 > 2$. True.

Both satisfied.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_51'
),

-- Q2 (sat_lid_011_52): Shaded region system — point in region
(
  'mcq',
  'math',
  'A region in the $xy$-plane is bounded above by $y = 8$ and below by $y = -x + 4$. The shaded region includes points where $y \leq 8$ and $y \geq -x + 4$. Which point $(x, y)$ is in this region?',
  '[{"id":"a","text":"$(0, 0)$"},{"id":"b","text":"$(2, 10)$"},{"id":"c","text":"$(6, 6)$"},{"id":"d","text":"$(8, -2)$"}]'::jsonb,
  'c',
  'Test $(6, 6)$:

$6 \leq 8$. True.
$6 \geq -6 + 4 = -2$. True.

The point lies in the region.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_52'
),

-- Q3 (sat_lid_011_53): Range of y-coordinates from system
(
  'mcq',
  'math',
  '$y > 3x - 2$
$3x > 7$

Which of the following consists of the $y$-coordinates of all the points that satisfy the system of inequalities above?',
  '[{"id":"a","text":"$y > 2$"},{"id":"b","text":"$y > 5$"},{"id":"c","text":"$y > \\frac{7}{3}$"},{"id":"d","text":"$y > 9$"}]'::jsonb,
  'b',
  'From the second inequality: $3x > 7$.

Substituting the minimum boundary of $3x$ into the first inequality:

$y > 3x - 2 > 7 - 2 = 5$.

Therefore $y > 5$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_53'
),

-- Q4 (sat_lid_011_54): Contractor bags — model system
(
  'mcq',
  'math',
  'A contractor is purchasing $x$ bags of concrete and $y$ bags of gravel. He must buy at least 30 bags total. Each bag of concrete costs \$6 and each bag of gravel costs \$5. The total budget is at most \$170. Which of the following systems of inequalities models this situation?',
  '[{"id":"a","text":"$x + y \\leq 30$ and $6x + 5y \\geq 170$"},{"id":"b","text":"$x + y \\geq 30$ and $6x + 5y \\leq 170$"},{"id":"c","text":"$6x + 5y \\leq 30$ and $x + y \\geq 170$"},{"id":"d","text":"$x + y \\geq 30$ and $6x + 5y \\geq 170$"}]'::jsonb,
  'b',
  '"At least 30 bags": $x + y \geq 30$.

"Budget at most \$170": $6x + 5y \leq 170$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_54'
),

-- Q5 (sat_lid_011_55): Museum membership — min visits
(
  'mcq',
  'math',
  'A museum offers an annual membership for \$120 that allows unlimited entry. Individual tickets cost \$12.50 for adults and \$8.00 for children. For a family buying only adult tickets, what is the minimum number of visits per year for which the membership costs less than individual tickets?',
  '[{"id":"a","text":"8"},{"id":"b","text":"9"},{"id":"c","text":"10"},{"id":"d","text":"11"}]'::jsonb,
  'c',
  'Let $n$ = number of visits. Membership is cheaper when:

$120 < 12.50n \implies n > \frac{120}{12.50} = 9.6$

Smallest integer: $n = 10$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_55'
),

-- Q6 (sat_lid_011_56): Karvonen heart rate formula — range of T
(
  'mcq',
  'math',
  '$T = (M - R)i + R$

The formula above relates target heart rate $T$ to maximum heart rate $M$, resting heart rate $R$, and intensity $i$. For a person with $M = 190$ and $R = 70$, the recommended intensity $i$ is between 0.6 and 0.8. Which of the following inequalities describes the target heart rate $T$?',
  '[{"id":"a","text":"$114 \\leq T \\leq 152$"},{"id":"b","text":"$142 \\leq T \\leq 166$"},{"id":"c","text":"$70 \\leq T \\leq 190$"},{"id":"d","text":"$130 \\leq T \\leq 170$"}]'::jsonb,
  'b',
  'Substitute $M = 190$, $R = 70$: $T = (190 - 70)i + 70 = 120i + 70$.

Lower bound ($i = 0.6$): $T = 120(0.6) + 70 = 142$.
Upper bound ($i = 0.8$): $T = 120(0.8) + 70 = 166$.

$142 \leq T \leq 166$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_56'
),

-- Q7 (sat_lid_011_57): Ordered pair — two inequality system
(
  'mcq',
  'math',
  '$y \leq 2x$
$y \leq -x + 6$

Which of the following ordered pairs $(x, y)$ is a solution to the system of inequalities above?',
  '[{"id":"a","text":"$(1, 4)$"},{"id":"b","text":"$(4, 1)$"},{"id":"c","text":"$(2, 5)$"},{"id":"d","text":"$(5, 2)$"}]'::jsonb,
  'b',
  'Test $(4, 1)$:

$1 \leq 2(4) = 8$. True.
$1 \leq -4 + 6 = 2$. True.

Both satisfied.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_57'
),

-- Q8 (sat_lid_011_58): Sales commission — compound inequality for sales
(
  'mcq',
  'math',
  'A salesperson earns a base salary of $k$ dollars plus a 15% commission on sales $s$. The goal is for total earnings to be at least 2.5 times and at most 3.5 times the base salary. Which inequality represents the sales $s$ needed?',
  '[{"id":"a","text":"$1.5k \\leq s \\leq 2.5k$"},{"id":"b","text":"$\\frac{1.5}{0.15}k \\leq s \\leq \\frac{2.5}{0.15}k$"},{"id":"c","text":"$2.5k \\leq s \\leq 3.5k$"},{"id":"d","text":"$\\frac{2.5}{0.15}k \\leq s \\leq \\frac{3.5}{0.15}k$"}]'::jsonb,
  'b',
  'Total earnings: $E = k + 0.15s$.

Goal: $2.5k \leq k + 0.15s \leq 3.5k$.

Subtract $k$: $1.5k \leq 0.15s \leq 2.5k$.

Divide by 0.15: $\frac{1.5}{0.15}k \leq s \leq \frac{2.5}{0.15}k$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_58'
),

-- Q9 (sat_lid_011_59): Max large lamps within budget
(
  'mcq',
  'math',
  'A store owner budgets \$1,500 to buy lamps. Small lamps cost \$15 and large lamps cost \$45. The owner must buy a minimum of 50 lamps total. What is the maximum number of large lamps the owner can buy?',
  '[{"id":"a","text":"15"},{"id":"b","text":"20"},{"id":"c","text":"25"},{"id":"d","text":"33"}]'::jsonb,
  'c',
  'Let $s$ = small, $L$ = large. Set $s = 50 - L$ to maximize $L$:

$15(50 - L) + 45L \leq 1{,}500$
$750 - 15L + 45L \leq 1{,}500$
$30L \leq 750$
$L \leq 25$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_59'
),

-- Q10 (sat_lid_011_60): Sample proportion inequality
(
  'mcq',
  'math',
  'In a test of 500 samples, 250 were treated. Of those, 40 showed a reaction. Among the remaining 250, $r$ samples showed a reaction. If more than 12% of all samples showed a reaction, which inequality describes $r$?',
  '[{"id":"a","text":"$r + 40 > 0.12(500)$, where $r \\leq 250$"},{"id":"b","text":"$r > 0.12(500 - 40)$, where $r \\leq 250$"},{"id":"c","text":"$r - 40 > 0.12(500)$, where $r \\leq 250$"},{"id":"d","text":"$r + 40 < 60$, where $r \\leq 250$"}]'::jsonb,
  'a',
  'Total reactions: $r + 40$.

"More than 12% of 500": $r + 40 > 0.12(500) = 60$.

Constraint: $r \leq 250$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_60'
),

-- Q11 (sat_lid_011_61): Triangle inequality — sides 10 and 24
(
  'mcq',
  'math',
  'Two sides of a triangle are 10 and 24. Which inequality represents the possible lengths of the third side $x$?',
  '[{"id":"a","text":"$x < 34$"},{"id":"b","text":"$14 < x < 34$"},{"id":"c","text":"$x > 14$"},{"id":"d","text":"$10 < x < 24$"}]'::jsonb,
  'b',
  'By the Triangle Inequality Theorem:

$x < 10 + 24 = 34$ and $x > 24 - 10 = 14$.

Combined: $14 < x < 34$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_61'
),

-- Q12 (sat_lid_011_62): Ohm's law — min batteries
(
  'mcq',
  'math',
  'A circuit has resistance $R = 200$ ohms and is powered by $n$ batteries each providing 1.5 volts ($V = 1.5n$). Using $I = \frac{V}{R}$, if the current $I$ must be at least 0.06 ampere, what is the minimum number of batteries $n$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"10"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '$\frac{1.5n}{200} \geq 0.06$

$1.5n \geq 12$

$n \geq 8$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_62'
),

-- Q13 (sat_lid_011_63): Point satisfying two-inequality system
(
  'mcq',
  'math',
  '$y \leq -x + 10$
$y \geq 3x - 2$

Which point satisfies the system?',
  '[{"id":"a","text":"$(0, 12)$"},{"id":"b","text":"$(4, 2)$"},{"id":"c","text":"$(2, 8)$"},{"id":"d","text":"$(5, 0)$"}]'::jsonb,
  'c',
  'Test $(2, 8)$:

$8 \leq -2 + 10 = 8$. True ($\leq$ is satisfied).
$8 \geq 3(2) - 2 = 4$. True.

Both satisfied.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_63'
),

-- Q14 (sat_lid_011_64): Mixture inequality
(
  'mcq',
  'math',
  'Solution A is 10% salt and Solution B is 30% salt. A chemist needs 20 liters of a mixture that is at least 15% salt. If $a$ is the volume of Solution A used, which inequality describes the salt content?',
  '[{"id":"a","text":"$0.1a + 0.3(20 - a) \\geq 3$"},{"id":"b","text":"$0.1a + 0.3(20 - a) \\leq 3$"},{"id":"c","text":"$a + (20 - a) \\geq 15$"},{"id":"d","text":"$0.1a \\geq 0.15(20)$"}]'::jsonb,
  'a',
  'Salt from A: $0.1a$. Salt from B: $0.3(20 - a)$.

Total salt must be $\geq 15\%$ of 20 liters $= 3$.

$0.1a + 0.3(20 - a) \geq 3$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_64'
),

-- Q15 (sat_lid_011_65): Triangle region — point inside
(
  'mcq',
  'math',
  'A system has boundaries $y = x$, $y = -x$, and $y = 4$. The solution region is the triangle where $y \leq 4$, $y \geq x$, and $y \geq -x$. Which point is inside this region?',
  '[{"id":"a","text":"$(0, 5)$"},{"id":"b","text":"$(2, 3)$"},{"id":"c","text":"$(5, 0)$"},{"id":"d","text":"$(0, -2)$"}]'::jsonb,
  'b',
  'Test $(2, 3)$:

$3 \leq 4$. True.
$3 \geq 2$. True.
$3 \geq -2$. True.

All constraints satisfied.',
  'algebra',
  'hard',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_65'
),

-- Q16 (sat_lid_011_66): Parallel lines — solution region between them
(
  'mcq',
  'math',
  '$y > ax + b$ and $y < cx + d$

If $a = c$ and $b < d$, which of the following is true about the solution to this system?',
  '[{"id":"a","text":"The system has no solution."},{"id":"b","text":"The system has infinitely many solutions."},{"id":"c","text":"The solution is a single point."},{"id":"d","text":"The solution is all points between two parallel lines."}]'::jsonb,
  'd',
  'If $a = c$, the boundary lines have the same slope — they are parallel.

Since $b < d$, the line $y = ax + b$ is below $y = cx + d$.

$y$ must be greater than the lower line and less than the upper line, so the solution is the infinite strip between the two parallel lines.',
  'algebra',
  'hard',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_66'
),

-- Q17 (sat_lid_011_67): Crate weight system
(
  'mcq',
  'math',
  'Crate A weighs 15 kg and Crate B weighs 25 kg. The total weight limit is 500 kg. The number of Crate B ($y$) must be more than the number of Crate A ($x$). Which system represents this?',
  '[{"id":"a","text":"$15x + 25y \\leq 500$ and $y > x$"},{"id":"b","text":"$25x + 15y \\leq 500$ and $x > y$"},{"id":"c","text":"$40(x + y) \\leq 500$"},{"id":"d","text":"$x + y \\leq 500$ and $y > x$"}]'::jsonb,
  'a',
  'Weight constraint: $15x + 25y \leq 500$.

Quantity constraint (more B than A): $y > x$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_67'
),

-- Q18 (sat_lid_011_68): Heart rate upper bound
(
  'mcq',
  'math',
  '$H = 150p + 50$

In the formula above, $H$ is heart rate and $p$ is intensity. If $p \leq 0.90$, what is the maximum heart rate $H$?',
  '[{"id":"a","text":"135"},{"id":"b","text":"150"},{"id":"c","text":"185"},{"id":"d","text":"200"}]'::jsonb,
  'c',
  '$H = 150(0.90) + 50 = 135 + 50 = 185$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_68'
),

-- Q19 (sat_lid_011_69): Table satisfying y > x and y < 10
(
  'mcq',
  'math',
  'Which of the following sets of points satisfies both $y > x$ and $y < 10$?',
  '[{"id":"a","text":"$(5, 6)$ and $(7, 8)$"},{"id":"b","text":"$(11, 12)$"},{"id":"c","text":"$(5, 4)$"},{"id":"d","text":"$(9, 11)$"}]'::jsonb,
  'a',
  'Test Option A:

$(5, 6)$: $6 > 5$ and $6 < 10$. Both true.
$(7, 8)$: $8 > 7$ and $8 < 10$. Both true.

Option B: $12 < 10$ is false. Option C: $4 > 5$ is false. Option D: $11 < 10$ is false.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_69'
),

-- Q20 (sat_lid_011_70): Area of rectangular solution region
(
  'mcq',
  'math',
  'A system of inequalities is defined by $y \leq 3$, $y \geq 0$, $x \geq 0$, and $x \leq 5$. What is the area of the solution region?',
  '[{"id":"a","text":"8"},{"id":"b","text":"15"},{"id":"c","text":"20"},{"id":"d","text":"30"}]'::jsonb,
  'b',
  'The region is a rectangle with height $3 - 0 = 3$ and width $5 - 0 = 5$.

Area $= 3 \times 5 = 15$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Systems of Inequalities',
  'sat_lid_011_70'
);

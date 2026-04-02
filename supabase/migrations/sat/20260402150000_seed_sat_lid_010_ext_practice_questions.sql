-- Practice-mode math questions from sat_lid_010 extension (sat_extention/sat_lid_010.tex)
-- Chapter: Linear inequalities in one or two variables | Topic: Solving & Graphing Inequalities
-- section=math, domain=algebra, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_010_51 to sat_lid_010_70
-- Extends: 20260320210000_seed_sat_lid_010_practice_sat_questions.sql (which covers _1 to _50)
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

-- Q1 (sat_lid_010_51): Inequality table match — test points in 3x - 2y > 1250
(
  'mcq',
  'math',
  '$3x - 2y > 1{,}250$

For which of the following sets of $(x, y)$ values are all pairs solutions to the given inequality?

Table A: $(420, 0)$, $(425, -10)$, $(430, -20)$
Table B: $(410, 10)$, $(415, 20)$, $(420, 30)$
Table C: $(400, -50)$, $(405, -60)$, $(410, -70)$
Table D: $(430, 25)$, $(435, 35)$, $(440, 45)$',
  '[{"id":"a","text":"Table A"},{"id":"b","text":"Table B"},{"id":"c","text":"Table C"},{"id":"d","text":"Table D"}]'::jsonb,
  'a',
  'Test Table A:

$(420, 0)$: $3(420) - 2(0) = 1{,}260 > 1{,}250$. Solution.
$(425, -10)$: $3(425) - 2(-10) = 1{,}275 + 20 = 1{,}295 > 1{,}250$. Solution.
$(430, -20)$: $3(430) - 2(-20) = 1{,}290 + 40 = 1{,}330 > 1{,}250$. Solution.

All points in Table A satisfy the inequality.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_51'
),

-- Q2 (sat_lid_010_52): Speed comparison — subway vs walking
(
  'mcq',
  'math',
  'Adam needs to travel to a site that is a 45-minute walk or a 12-minute commute by subway. The subway runs every 20 minutes, and the waiting time, $w$, varies between 0 and 20. Which of the following inequalities gives the values of $w$ for which it would be faster for Adam to take the subway?',
  '[{"id":"a","text":"$w + 12 < 45$"},{"id":"b","text":"$w + 12 > 45$"},{"id":"c","text":"$w - 12 < 45$"},{"id":"d","text":"$20 - w < 45$"}]'::jsonb,
  'a',
  'Walking time is 45 minutes. Subway time is $w + 12$ (wait + ride).

For the subway to be faster: $w + 12 < 45$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_52'
),

-- Q3 (sat_lid_010_53): Shipment weight/quantity system
(
  'mcq',
  'math',
  'A logistics company is loading crates of hardware and software. Each crate of hardware weighs 14.5 pounds, and each crate of software weighs 8.2 pounds. The total shipment weight must not exceed 500 pounds. The company wants to buy at least three times as many crates of software as crates of hardware. If $h$ represents hardware and $s$ represents software, which system models this?',
  '[{"id":"a","text":"$14.5h + 8.2s \\leq 500$ and $s \\geq 3h$"},{"id":"b","text":"$14.5h + 8.2s \\leq 500$ and $h \\geq 3s$"},{"id":"c","text":"$14.5h + 8.2s < 500$ and $3s \\geq h$"},{"id":"d","text":"$14.5h + 8.2s < 500$ and $3h \\geq s$"}]'::jsonb,
  'a',
  '"Not exceed" means $\leq$: $14.5h + 8.2s \leq 500$.

"At least three times as many software as hardware" means $s \geq 3h$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_53'
),

-- Q4 (sat_lid_010_54): Sales commission — compound inequality
(
  'mcq',
  'math',
  'A consultant earns a base salary of $\$k$ per year plus a 14% commission on total sales. This year, the goal is for total earnings to be between 2 and 3 times the base salary. Which inequality represents all possible values of total sales $s$?',
  '[{"id":"a","text":"$k \\leq s \\leq 2k$"},{"id":"b","text":"$2k \\leq 0.14s \\leq 3k$"},{"id":"c","text":"$\\frac{k}{0.14} \\leq s \\leq \\frac{2k}{0.14}$"},{"id":"d","text":"$\\frac{2k}{0.14} \\leq s \\leq \\frac{3k}{0.14}$"}]'::jsonb,
  'c',
  'Total earnings: $E = k + 0.14s$.

Goal: $2k \leq k + 0.14s \leq 3k$.

Subtract $k$: $k \leq 0.14s \leq 2k$.

Divide by 0.14: $\frac{k}{0.14} \leq s \leq \frac{2k}{0.14}$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_54'
),

-- Q5 (sat_lid_010_55): Budget constraint — max ergonomic chairs
(
  'mcq',
  'math',
  'A manager budgets \$4,500 for office chairs. The manager must buy at least 50 chairs total. Ergonomic chairs cost \$110 each and standard chairs cost \$65 each. What is the maximum number of ergonomic chairs the manager can buy?',
  '[{"id":"a","text":"24"},{"id":"b","text":"27"},{"id":"c","text":"40"},{"id":"d","text":"50"}]'::jsonb,
  'b',
  'Let $E$ = ergonomic, $S$ = standard. To maximize $E$, set $S = 50 - E$:

$110E + 65(50 - E) \leq 4{,}500$
$110E + 3{,}250 - 65E \leq 4{,}500$
$45E \leq 1{,}250$
$E \leq 27.77$

Maximum whole number: 27.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_55'
),

-- Q6 (sat_lid_010_56): Shaded region — identify inequality from graph
-- Original has TikZ; prompt rewritten to be self-contained
(
  'mcq',
  'math',
  'A dashed line passes through $(0, -1)$ and $(-1, 2)$ in the $xy$-plane. The region to the right of this line is shaded. Which inequality is represented by the shaded region?',
  '[{"id":"a","text":"$y < -1 - 3x$"},{"id":"b","text":"$y > -1 - 3x$"},{"id":"c","text":"$y < -1 + 3x$"},{"id":"d","text":"$y > -1 + 3x$"}]'::jsonb,
  'b',
  'Slope: $m = \frac{2 - (-1)}{-1 - 0} = -3$. Equation: $y = -3x - 1$.

Test point $(2, 0)$ in the shaded region: $0 > -3(2) - 1 = -7$. True.

The inequality is $y > -3x - 1$, which is $y > -1 - 3x$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_56'
),

-- Q7 (sat_lid_010_57): Participant proportion — set up inequality
(
  'mcq',
  'math',
  'In a study of 400 people, 200 were given a task. Of those, 42 succeeded. Among the remaining 200, $n$ people succeeded. If more than 15% of all 400 participants succeeded, which inequality describes $n$?',
  '[{"id":"a","text":"$n + 42 > 0.15(400)$, where $n \\leq 200$"},{"id":"b","text":"$n - 42 > 0.15(400)$, where $n \\leq 200$"},{"id":"c","text":"$n > 0.15(400 - 42)$, where $n \\leq 200$"},{"id":"d","text":"$n + 42 < 0.15(400)$, where $n \\leq 200$"}]'::jsonb,
  'a',
  'Total successes: $n + 42$.

"More than 15% of 400": $n + 42 > 0.15(400) = 60$.

Since the second group has only 200 people: $n \leq 200$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_57'
),

-- Q8 (sat_lid_010_58): Triangle inequality theorem
(
  'mcq',
  'math',
  'A triangle has two side lengths of 8 and 15. Which inequality represents the possible lengths, $x$, of the third side?',
  '[{"id":"a","text":"$x < 23$"},{"id":"b","text":"$x > 7$"},{"id":"c","text":"$7 < x < 23$"},{"id":"d","text":"$x < 7$ or $x > 23$"}]'::jsonb,
  'c',
  'By the Triangle Inequality Theorem:

$x < 8 + 15 = 23$ and $x > 15 - 8 = 7$.

Combined: $7 < x < 23$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_58'
),

-- Q9 (sat_lid_010_59): Ohm's law — max batteries
(
  'mcq',
  'math',
  'Using $I = \frac{V}{R}$, a circuit with resistance $R = 400$ ohms is powered by $n$ nine-volt batteries ($V = 9n$). If the current $I$ must be no more than 0.18 ampere, what is the greatest number $n$ of batteries that can be used?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"12"},{"id":"d","text":"15"}]'::jsonb,
  'b',
  '$\frac{9n}{400} \leq 0.18$

$9n \leq 72$

$n \leq 8$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_59'
),

-- Q10 (sat_lid_010_60): Table search — y < 4x - 5
(
  'mcq',
  'math',
  '$y < 4x - 5$

For which of the following sets of $(x, y)$ values are all pairs solutions?

Table A: $(5, 14)$ and $(10, 34)$
Table B: $(5, 16)$ and $(10, 36)$
Table C: $(4, 12)$ and $(6, 20)$
Table D: $(5, 20)$ and $(10, 40)$',
  '[{"id":"a","text":"Table A"},{"id":"b","text":"Table B"},{"id":"c","text":"Table C"},{"id":"d","text":"Table D"}]'::jsonb,
  'a',
  'Test Table A:

$(5, 14)$: $4(5) - 5 = 15$. Since $14 < 15$, solution.
$(10, 34)$: $4(10) - 5 = 35$. Since $34 < 35$, solution.

All points in Table A satisfy $y < 4x - 5$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_60'
),

-- Q11 (sat_lid_010_61): Table match — 5x - 4y < 1000
(
  'mcq',
  'math',
  '$5x - 4y < 1{,}000$

Which of the following sets of $(x, y)$ values contains only pairs that satisfy the inequality?

Table A: $(200, 5)$, $(210, 20)$, $(220, 35)$
Table B: $(200, 0)$, $(205, 5)$, $(210, 10)$
Table C: $(190, -30)$, $(195, -40)$, $(200, -50)$
Table D: $(210, 5)$, $(220, 10)$, $(230, 15)$',
  '[{"id":"a","text":"Table A"},{"id":"b","text":"Table B"},{"id":"c","text":"Table C"},{"id":"d","text":"Table D"}]'::jsonb,
  'a',
  'Test Table A:

$(200, 5)$: $5(200) - 4(5) = 1{,}000 - 20 = 980 < 1{,}000$. Solution.
$(210, 20)$: $5(210) - 4(20) = 1{,}050 - 80 = 970 < 1{,}000$. Solution.
$(220, 35)$: $5(220) - 4(35) = 1{,}100 - 140 = 960 < 1{,}000$. Solution.

All points in Table A satisfy the inequality.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_61'
),

-- Q12 (sat_lid_010_62): Cooling method comparison
(
  'mcq',
  'math',
  'A scientist is choosing between two cooling methods. Method A takes 60 minutes. Method B consists of a setup time $s$ and a cooling phase of 15 minutes. Setup time $s$ varies between 0 and 60 minutes. Which inequality represents the values of $s$ for which Method B is faster than Method A?',
  '[{"id":"a","text":"$s + 15 < 60$"},{"id":"b","text":"$s + 15 > 60$"},{"id":"c","text":"$s - 15 < 60$"},{"id":"d","text":"$60 - s < 15$"}]'::jsonb,
  'a',
  'Method B total time: $s + 15$.

For Method B to be faster than Method A: $s + 15 < 60$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_62'
),

-- Q13 (sat_lid_010_63): Delivery service — system of inequalities
(
  'mcq',
  'math',
  'A delivery service limits shipments to 400 pounds. Crates of Type X weigh 12.5 pounds each, and crates of Type Y weigh 9.4 pounds each. The service requires at least twice as many crates of Type X as Type Y. Which system of inequalities represents this scenario?',
  '[{"id":"a","text":"$12.5x + 9.4y \\leq 400$ and $x \\geq 2y$"},{"id":"b","text":"$12.5x + 9.4y \\leq 400$ and $y \\geq 2x$"},{"id":"c","text":"$12.5x + 9.4y < 400$ and $x \\leq 2y$"},{"id":"d","text":"$25x + 9.4y \\leq 400$ and $x \\geq 2y$"}]'::jsonb,
  'a',
  'Weight limit: $12.5x + 9.4y \leq 400$.

"At least twice as many Type X as Type Y": $x \geq 2y$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_63'
),

-- Q14 (sat_lid_010_64): Manager compensation — compound inequality
(
  'mcq',
  'math',
  'A manager earns a base salary of $\$B$ plus an 8% bonus on annual sales $s$. The goal is for total compensation to be at least 1.5 times the base salary but no more than 2 times the base salary. Which inequality models the possible values of $s$?',
  '[{"id":"a","text":"$0.5B \\leq 0.08s \\leq B$"},{"id":"b","text":"$1.5B \\leq s \\leq 2B$"},{"id":"c","text":"$\\frac{0.5B}{0.08} \\leq s \\leq \\frac{B}{0.08}$"},{"id":"d","text":"$\\frac{1.5B}{0.08} \\leq s \\leq \\frac{2B}{0.08}$"}]'::jsonb,
  'c',
  'Total compensation: $B + 0.08s$.

Goal: $1.5B \leq B + 0.08s \leq 2B$.

Subtract $B$: $0.5B \leq 0.08s \leq B$.

Divide by 0.08: $\frac{0.5B}{0.08} \leq s \leq \frac{B}{0.08}$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_64'
),

-- Q15 (sat_lid_010_65): Baker budget — max premium flour bags
(
  'mcq',
  'math',
  'A baker has \$150 to buy flour. He must purchase at least 12 bags total. Premium flour costs \$15 per bag and basic flour costs \$8 per bag. What is the maximum number of premium flour bags he can purchase?',
  '[{"id":"a","text":"4"},{"id":"b","text":"7"},{"id":"c","text":"8"},{"id":"d","text":"10"}]'::jsonb,
  'b',
  'Let $p$ = premium, $b$ = basic. Set $b = 12 - p$ to maximize $p$:

$15p + 8(12 - p) \leq 150$
$15p + 96 - 8p \leq 150$
$7p \leq 54$
$p \leq 7.71$

Maximum whole number: 7.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_65'
),

-- Q16 (sat_lid_010_66): Shaded region — identify inequality
-- Original has TikZ; prompt rewritten to be self-contained
(
  'mcq',
  'math',
  'A dashed line passes through $(0, 0.5)$ and $(4, -2.5)$ in the $xy$-plane. The region above the line is shaded. Which inequality is represented by the shaded region?',
  '[{"id":"a","text":"$y > -0.75x + 0.5$"},{"id":"b","text":"$y < -0.75x + 0.5$"},{"id":"c","text":"$y > -1.33x + 0.5$"},{"id":"d","text":"$y < -1.33x + 0.5$"}]'::jsonb,
  'a',
  'Slope: $m = \frac{-2.5 - 0.5}{4 - 0} = \frac{-3}{4} = -0.75$.

Equation: $y = -0.75x + 0.5$.

Dashed line means strict inequality. Region above: $y > -0.75x + 0.5$.

Verify with test point $(0, 5)$: $5 > 0.5$. True.',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_66'
),

-- Q17 (sat_lid_010_67): Clinic deficiency — proportion inequality
(
  'mcq',
  'math',
  'A clinic tested 500 patients for a vitamin deficiency. In the first group of 250 patients, 80 had the deficiency. In the second group of 250 patients, $d$ patients had the deficiency. If more than 30% of all 500 patients had the deficiency, which inequality describes $d$?',
  '[{"id":"a","text":"$d + 80 > 0.30(500)$, where $d \\leq 250$"},{"id":"b","text":"$d - 80 > 0.30(500)$, where $d \\leq 250$"},{"id":"c","text":"$d > 0.30(500 - 80)$, where $d \\leq 250$"},{"id":"d","text":"$d + 80 < 150$, where $d \\leq 250$"}]'::jsonb,
  'a',
  'Total with deficiency: $d + 80$.

"More than 30% of 500": $d + 80 > 0.30(500) = 150$.

Constraint: $d \leq 250$ (second group size).',
  'algebra',
  'medium',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_67'
),

-- Q18 (sat_lid_010_68): Triangle inequality — sides 14 and 22
(
  'mcq',
  'math',
  'Two sides of a triangle measure 14 and 22. Which of the following inequalities represents all possible lengths $s$ for the third side?',
  '[{"id":"a","text":"$s < 36$"},{"id":"b","text":"$s > 8$"},{"id":"c","text":"$8 < s < 36$"},{"id":"d","text":"$14 < s < 22$"}]'::jsonb,
  'c',
  'By the Triangle Inequality Theorem:

$s < 14 + 22 = 36$ and $s > 22 - 14 = 8$.

Combined: $8 < s < 36$.',
  'algebra',
  'easy',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_68'
),

-- Q19 (sat_lid_010_69): Ohm's law — min batteries
(
  'mcq',
  'math',
  'An electrical component has a resistance $R = 250$ ohms. It is connected to $n$ identical batteries, each providing 1.5 volts ($V = 1.5n$). If the current $I$ must be at least 0.03 ampere, what is the minimum number of batteries required?',
  '[{"id":"a","text":"3"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"10"}]'::jsonb,
  'b',
  '$\frac{1.5n}{250} \geq 0.03$

$1.5n \geq 7.5$

$n \geq 5$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_69'
),

-- Q20 (sat_lid_010_70): Table search — y > 3x + 14
(
  'mcq',
  'math',
  '$y > 3x + 14$

For which of the following sets of $(x, y)$ values do all pairs represent solutions?

Table A: $(-2, 9)$ and $(0, 15)$
Table B: $(-2, 8)$ and $(0, 14)$
Table C: $(1, 17)$ and $(2, 20)$
Table D: $(5, 28)$ and $(10, 42)$',
  '[{"id":"a","text":"Table A"},{"id":"b","text":"Table B"},{"id":"c","text":"Table C"},{"id":"d","text":"Table D"}]'::jsonb,
  'a',
  'Test Table A:

$(-2, 9)$: $3(-2) + 14 = 8$. Since $9 > 8$, solution.
$(0, 15)$: $3(0) + 14 = 14$. Since $15 > 14$, solution.

All points in Table A satisfy $y > 3x + 14$.',
  'algebra',
  'hard',
  0,
  0,
  'Linear inequalities in one or two variables',
  'Solving & Graphing Inequalities',
  'sat_lid_010_70'
);

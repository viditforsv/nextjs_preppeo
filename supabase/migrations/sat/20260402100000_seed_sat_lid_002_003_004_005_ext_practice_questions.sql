-- Extension practice questions for sat_lid_002, sat_lid_003, sat_lid_004, sat_lid_005
-- Sources: Docs for me/latex_with_rijay/sat_extention/
-- All practice pool: module_number=0, set_number=0, qc_done defaults to false
--
-- sat_lid_002 (20q): Linear Equation Word Problems      ids _51–_70
--   extends: 20260320130000_seed_sat_lid_002... (covers _1–_50)
-- sat_lid_003 (20q): Number of Solutions                ids _52–_71
--   extends: 20260320140000_seed_sat_lid_003... (covers _1–_51)
-- sat_lid_004 (20q): Slope-Intercept & Standard Form    ids _51–_70
--   extends: 20260320150000_seed_sat_lid_004... (covers _1–_50)
-- sat_lid_005 (20q): Graphing Linear Equations          ids _51–_70
--   extends: 20260320160000_seed_sat_lid_005... (covers _1–_50)
--
-- Fixes applied vs source LaTeX:
--   sat_lid_004_63 (Q13): original points inconsistent with options; replaced with (5,5)/(10,25)
--   sat_lid_004_64 (Q14): original point (4,8) gives k=-6, not in options; fixed to (-4,8)
--   sat_lid_005_51 (Q1):  source marked answer B but graph intercepts require answer A
--   sat_lid_005_66 (Q16): messy solution replaced with clean algebraic derivation
--   sat_lid_003_64 (Q13): source marked answer C (Infinitely many) but explanation shows zero solutions; corrected to A

INSERT INTO public.sat_questions (
  type, section, prompt, options, correct_answer, explanation,
  domain, difficulty_tier, module_number, set_number,
  chapter, subtopic, bank_item_id
)
VALUES

-- ============================================================
-- sat_lid_002 — Linear Equation Word Problems (ids _51–_70)
-- ============================================================

-- Q1 (sat_lid_002_51): Fuel tank depletion → hours
(
  'mcq', 'math',
  'A high-capacity fuel tank contains 144 gallons of fuel. When the generator is running, the amount of fuel decreases by 3 gallons every 40 minutes. If 54 gallons of fuel remain in the tank, for how many hours has the generator been running?',
  '[{"id":"a","text":"12"},{"id":"b","text":"20"},{"id":"c","text":"30"},{"id":"d","text":"45"}]'::jsonb,
  'b',
  'Total fuel consumed: $144 - 54 = 90$ gallons.

The rate is 3 gallons per 40 minutes. Time to consume 90 gallons:

$\frac{90}{3} \times 40 = 30 \times 40 = 1{,}200$ minutes

Convert to hours:

$\frac{1{,}200}{60} = 20$ hours',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_51'
),

-- Q2 (sat_lid_002_52): Weight expression for mixed containers
(
  'mcq', 'math',
  'A logistics manager is organizing 12 shipping containers. Each container will be loaded with either Type A crates or Type B crates. Type A crates weigh 450 kg, and Type B crates weigh 320 kg. If $x$ represents the number of containers loaded with Type A crates and the rest are Type B, which expression represents the total weight, in kilograms, of the crates in all 12 containers?',
  '[{"id":"a","text":"$130x + 3{,}840$"},{"id":"b","text":"$770x$"},{"id":"c","text":"$450x + 320$"},{"id":"d","text":"$320x + 5{,}400$"}]'::jsonb,
  'a',
  'Type A containers: $x$. Type B containers: $(12 - x)$.

Total weight $= 450x + 320(12 - x)$

$= 450x + 3{,}840 - 320x$

$= 130x + 3{,}840$',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_52'
),

-- Q3 (sat_lid_002_53): Contractor base rate with overtime
(
  'mcq', 'math',
  'An independent contractor''s base rate is $r$ dollars per hour for the first 35 hours worked in a week. For any hours exceeding 35, the rate increases to 1.8 times the base rate. If the contractor worked 45 hours and earned a total of \$1,590, what is the base hourly rate $r$?',
  '[{"id":"a","text":"\\$25.00"},{"id":"b","text":"\\$30.00"},{"id":"c","text":"\\$35.00"},{"id":"d","text":"\\$40.00"}]'::jsonb,
  'b',
  'Base hours = 35, overtime hours = $45 - 35 = 10$.

Set up the earnings equation:

$35r + 10(1.8r) = 1{,}590$

$35r + 18r = 1{,}590$

$53r = 1{,}590 \implies r = 30$',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_53'
),

-- Q4 (sat_lid_002_54): Polygon sides equation
(
  'mcq', 'math',
  'Each side of a 48-sided polygon has one of three lengths. The number of sides with length 15 cm is 4 times the number of sides $s$ with length 6 cm. There are 13 sides with length 10 cm. Which equation must be true for the value of $s$?',
  '[{"id":"a","text":"$4s + 13 = 48$"},{"id":"b","text":"$5s + 13 = 48$"},{"id":"c","text":"$15(4s) + 6s + 10(13) = 48$"},{"id":"d","text":"$6s + 13 = 48$"}]'::jsonb,
  'b',
  'Count each type of side:
- 6 cm sides: $s$
- 15 cm sides: $4s$
- 10 cm sides: 13

The total count of sides equals 48:

$s + 4s + 13 = 48 \implies 5s + 13 = 48$',
  'algebra', 'easy', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_54'
),

-- Q5 (sat_lid_002_55): Two sequential discounts — find original price
(
  'mcq', 'math',
  'A manufacturing firm purchased raw materials at a "Preferred Partner" price of \$84,000. This price reflects a 30% discount off the original wholesale price, followed by an additional 20% discount for an all-cash payment. Which of the following best approximates the original wholesale price?',
  '[{"id":"a","text":"\\$120,000"},{"id":"b","text":"\\$150,000"},{"id":"c","text":"\\$168,000"},{"id":"d","text":"\\$200,000"}]'::jsonb,
  'b',
  'Let $P$ be the original wholesale price.

First discount (30% off): $0.70P$ remains.

Second discount (20% off the new price): $0.80(0.70P) = 0.56P$.

Set this equal to the final price:

$0.56P = 84{,}000$

$P = \frac{84{,}000}{0.56} = 150{,}000$',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_55'
),

-- Q6 (sat_lid_002_56): Steel beam cut in ratio — longest piece
(
  'mcq', 'math',
  'A structural steel beam with a total length of 420 cm is cut into three sections. One section is 156 cm long. The other two sections have lengths in a ratio of 3:5. What is the length, in cm, of the longest section?',
  '[{"id":"a","text":"132"},{"id":"b","text":"156"},{"id":"c","text":"165"},{"id":"d","text":"198"}]'::jsonb,
  'c',
  'Remaining length: $420 - 156 = 264$ cm.

Let the two remaining sections be $3x$ and $5x$:

$3x + 5x = 264 \implies 8x = 264 \implies x = 33$

The two sections are $3(33) = 99$ cm and $5(33) = 165$ cm.

The three lengths are 156, 99, and 165. The longest is 165 cm.',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_56'
),

-- Q7 (sat_lid_002_57): Profit per unit equation
(
  'mcq', 'math',
  'A company produces a device for \$110. A consultant earns a commission of 15% of the sales price. The company''s net profit is the sales price minus the sum of production cost and commission. If the sales price is $S$, which equation gives the number of units $u$ needed to achieve a total net profit of \$12,750?',
  '[{"id":"a","text":"$(0.85S - 110)u = 12{,}750$"},{"id":"b","text":"$(S - 110 - 0.15)u = 12{,}750$"},{"id":"c","text":"$(S(1 - 0.15) + 110)u = 12{,}750$"},{"id":"d","text":"$0.15(S - 110)u = 12{,}750$"}]'::jsonb,
  'a',
  'Profit per unit = Sales Price - (Production Cost + Commission).

Commission $= 0.15S$.

Profit per unit $= S - 110 - 0.15S = 0.85S - 110$.

For $u$ units:

$(0.85S - 110)u = 12{,}750$',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_57'
),

-- Q8 (sat_lid_002_58): Gasoline savings equation
(
  'mcq', 'math',
  'Elena drives an average of 180 miles per week. Her car averages 30 miles per gallon. She wants to reduce her weekly gasoline spending by \$9. Assuming gasoline costs $G$ dollars per gallon, which equation can Elena use to determine how many fewer average miles, $m$, she should drive each week?',
  '[{"id":"a","text":"$\\frac{G}{30}m = 9$"},{"id":"b","text":"$\\frac{30}{G}m = 9$"},{"id":"c","text":"$\\frac{m}{30G} = 9$"},{"id":"d","text":"$30Gm = 9$"}]'::jsonb,
  'a',
  'Gallons saved by driving $m$ fewer miles $= \frac{m}{30}$.

Multiply by cost per gallon $G$ to get the cost reduction:

$\frac{m}{30} \times G = 9 \implies \frac{G}{30}m = 9$',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_58'
),

-- Q9 (sat_lid_002_59): Must-be-true statements (Roman numeral)
(
  'mcq', 'math',
  'The equation $14x - 8 = k(x - n)$, where $k$ and $n$ are constants, has infinitely many solutions. Which of the following must be true?

I. $k = 14$
II. $n = \frac{4}{7}$
III. $n = -8$',
  '[{"id":"a","text":"I only"},{"id":"b","text":"I and II only"},{"id":"c","text":"I and III only"},{"id":"d","text":"I, II, and III"}]'::jsonb,
  'b',
  'Distribute $k$ on the right side: $14x - 8 = kx - kn$.

For infinitely many solutions, both coefficients and constants must match.

Step 1 — Match $x$ coefficients: $k = 14$. (Statement I is true)

Step 2 — Match constants: $-8 = -kn \implies kn = 8$.

Substitute $k = 14$:

$14n = 8 \implies n = \frac{4}{7}$. (Statement II is true)

Since $n = \frac{4}{7} \neq -8$, Statement III is false.',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_59'
),

-- Q10 (sat_lid_002_60): Two pumps with staggered start
(
  'mcq', 'math',
  'Two pumps, P and Q, are draining a pool. Pump P drains 400 gallons per hour, and Pump Q drains 250 gallons per hour. Pump P starts at 8:00 AM, and Pump Q starts 2 hours later. By 2:00 PM, how many total gallons have been drained?',
  '[{"id":"a","text":"2,900"},{"id":"b","text":"3,400"},{"id":"c","text":"3,900"},{"id":"d","text":"4,400"}]'::jsonb,
  'b',
  'Hours of operation by 2:00 PM:
- Pump P: 8:00 AM to 2:00 PM = 6 hours
- Pump Q: 10:00 AM to 2:00 PM = 4 hours

Total gallons drained:

$(400 \times 6) + (250 \times 4) = 2{,}400 + 1{,}000 = 3{,}400$',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_60'
),

-- Q11 (sat_lid_002_61): Reservoir leak linear model
(
  'mcq', 'math',
  'A water reservoir contains 2,500 gallons. Due to a leak, the volume decreases by 15 gallons every 4 hours. If $V$ represents the volume of water remaining after $h$ hours, which equation correctly models this relationship?',
  '[{"id":"a","text":"$V = 2{,}500 - 3.75h$"},{"id":"b","text":"$V = 2{,}500 - 60h$"},{"id":"c","text":"$V = 2{,}500 - \\frac{4}{15}h$"},{"id":"d","text":"$V = 2{,}500 - 15h$"}]'::jsonb,
  'a',
  'Rate of decrease: $\frac{15 \text{ gallons}}{4 \text{ hours}} = 3.75$ gallons per hour.

The initial volume is 2,500 and it decreases over time:

$V = 2{,}500 - 3.75h$',
  'algebra', 'easy', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_61'
),

-- Q12 (sat_lid_002_62): Light fixtures cost expression
(
  'mcq', 'math',
  'A contractor is purchasing 20 light fixtures. Standard fixtures cost \$45 each, and Deluxe fixtures cost \$75 each. If $n$ is the number of Deluxe fixtures purchased, which of the following expressions represents the total cost, in dollars, of the 20 fixtures?',
  '[{"id":"a","text":"$120n$"},{"id":"b","text":"$30n + 900$"},{"id":"c","text":"$75n + 45$"},{"id":"d","text":"$45n + 1{,}500$"}]'::jsonb,
  'b',
  'Deluxe fixtures: $n$. Standard fixtures: $(20 - n)$.

Total cost $= 75n + 45(20 - n)$

$= 75n + 900 - 45n$

$= 30n + 900$',
  'algebra', 'easy', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_62'
),

-- Q13 (sat_lid_002_63): No solution must-be-true
(
  'mcq', 'math',
  'The equation $12x + 10 = k(x + b)$, where $k$ and $b$ are constants, has no solution. Which of the following must be true?',
  '[{"id":"a","text":"$k = 12$ and $b = \\frac{5}{6}$"},{"id":"b","text":"$k = 12$ and $b \\neq \\frac{5}{6}$"},{"id":"c","text":"$k \\neq 12$ and $b = 10$"},{"id":"d","text":"$k = 10$ and $b \\neq 12$"}]'::jsonb,
  'b',
  'Distribute $k$: $12x + 10 = kx + kb$.

For no solution, the $x$ coefficients must match but the constants must differ.

Step 1 — Match $x$ coefficients: $k = 12$.

Step 2 — Constants must differ: $10 \neq kb$. Substitute $k = 12$:

$10 \neq 12b \implies b \neq \frac{10}{12} \implies b \neq \frac{5}{6}$',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_63'
),

-- Q14 (sat_lid_002_64): Graphic designer hourly rate with excess hours
(
  'mcq', 'math',
  'A graphic designer charges a flat fee of $d$ dollars per hour for the first 10 hours of a project, and 1.4 times that rate for any additional hours. For a 15-hour project, the designer was paid \$943.50. What is the designer''s hourly rate $d$?',
  '[{"id":"a","text":"\\$55.50"},{"id":"b","text":"\\$62.90"},{"id":"c","text":"\\$71.00"},{"id":"d","text":"\\$84.20"}]'::jsonb,
  'a',
  'Base hours = 10, excess hours = 5.

$10d + 5(1.4d) = 943.50$

$10d + 7d = 943.50$

$17d = 943.50 \implies d = \frac{943.50}{17} = 55.50$',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_64'
),

-- Q15 (sat_lid_002_65): Shipping crate count equation
(
  'mcq', 'math',
  'A shipping crate contains 60 items of three different weights. The number of items weighing 5 lbs is 3 times the number of items $n$ weighing 12 lbs. There are 16 items weighing 8 lbs. Which equation represents this situation?',
  '[{"id":"a","text":"$3n + 16 = 60$"},{"id":"b","text":"$4n + 16 = 60$"},{"id":"c","text":"$5(3n) + 12n + 8(16) = 60$"},{"id":"d","text":"$12n + 16 = 60$"}]'::jsonb,
  'b',
  'Count each item type:
- 12-lb items: $n$
- 5-lb items: $3n$
- 8-lb items: 16

Total count equals 60:

$n + 3n + 16 = 60 \implies 4n + 16 = 60$',
  'algebra', 'easy', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_65'
),

-- Q16 (sat_lid_002_66): Double discount — find original price
(
  'mcq', 'math',
  'An investor purchased an asset for \$126,000. This price represents a 25% "Early Bird" discount off the original price, followed by an additional 10% "Member Loyalty" discount. What was the original price of the asset?',
  '[{"id":"a","text":"\\$168,000"},{"id":"b","text":"\\$170,100"},{"id":"c","text":"\\$180,000"},{"id":"d","text":"\\$186,667"}]'::jsonb,
  'd',
  'Let $x$ be the original price.

First discount (25% off): $0.75x$.

Second discount (10% off new price): $0.90(0.75x) = 0.675x$.

$0.675x = 126{,}000$

$x = \frac{126{,}000}{0.675} \approx 186{,}667$',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_66'
),

-- Q17 (sat_lid_002_67): Rope cut with ratio — longest piece
(
  'mcq', 'math',
  'A 240-cm rope is cut into three pieces. The first piece is 60 cm. The remaining two pieces have lengths such that one is three times as long as the other. What is the length, in cm, of the longest piece?',
  '[{"id":"a","text":"45"},{"id":"b","text":"60"},{"id":"c","text":"135"},{"id":"d","text":"180"}]'::jsonb,
  'c',
  'Remaining length: $240 - 60 = 180$ cm.

Let the two pieces be $x$ and $3x$:

$x + 3x = 180 \implies 4x = 180 \implies x = 45$

The pieces are 60 cm, 45 cm, and $3(45) = 135$ cm. The longest is 135 cm.',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_67'
),

-- Q18 (sat_lid_002_68): Retailer profit equation with transaction fee
(
  'mcq', 'math',
  'A retailer buys a product for \$40. They sell it for a price $S$, but must pay a 10% transaction fee on the sales price. If the retailer wants to make a profit of \$1,200 by selling $u$ units, which equation represents this?',
  '[{"id":"a","text":"$(0.9S - 40)u = 1{,}200$"},{"id":"b","text":"$(S - 40 - 0.1)u = 1{,}200$"},{"id":"c","text":"$(S(1 - 0.1) + 40)u = 1{,}200$"},{"id":"d","text":"$0.1(S - 40)u = 1{,}200$"}]'::jsonb,
  'a',
  'Transaction fee $= 0.10S$. Net sales $= 0.90S$.

Profit per unit $= 0.90S - 40$.

For $u$ units:

$(0.90S - 40)u = 1{,}200$',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_68'
),

-- Q19 (sat_lid_002_69): Fuel savings equation
(
  'mcq', 'math',
  'A commuter travels 250 miles per week and their car gets 25 miles per gallon. To save \$15 per week on fuel, how many fewer miles $m$ must they drive if fuel costs $C$ dollars per gallon?',
  '[{"id":"a","text":"$\\frac{C}{25}m = 15$"},{"id":"b","text":"$\\frac{25}{C}m = 15$"},{"id":"c","text":"$25Cm = 15$"},{"id":"d","text":"$\\frac{m}{25C} = 15$"}]'::jsonb,
  'a',
  'Gallons saved by driving $m$ fewer miles $= \frac{m}{25}$.

Multiply by cost per gallon $C$:

$\frac{m}{25} \times C = 15 \implies \frac{C}{25}m = 15$',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_69'
),

-- Q20 (sat_lid_002_70): Two printers with warm-up delay
(
  'mcq', 'math',
  'A printer can produce 45 pages per minute. A second, faster printer can produce 60 pages per minute but takes 10 minutes to warm up before it can start printing. If both printers are started at the same time to print a 2,400-page job, how many minutes will it take until the job is completed?',
  '[{"id":"a","text":"24.5"},{"id":"b","text":"28.6"},{"id":"c","text":"32.4"},{"id":"d","text":"40.0"}]'::jsonb,
  'b',
  'Let $t$ = total time in minutes.

Printer 1 prints for $t$ minutes: $45t$ pages.
Printer 2 prints for $(t - 10)$ minutes: $60(t - 10)$ pages.

$45t + 60(t - 10) = 2{,}400$

$45t + 60t - 600 = 2{,}400$

$105t = 3{,}000 \implies t = \frac{3{,}000}{105} \approx 28.6$ minutes',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Linear Equation Word Problems',
  'sat_lid_002_70'
),

-- ============================================================
-- sat_lid_003 — Number of Solutions (ids _52–_71)
-- ============================================================

-- Q1 (sat_lid_003_52): Rational hole — find k for infinite solutions
(
  'mcq', 'math',
  '$\frac{4x^2 - 100}{x - 5} = kx + 20$

In the equation above, $k$ is a constant. If the equation has infinitely many solutions for all $x \neq 5$, what is the value of $k$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"20"}]'::jsonb,
  'b',
  'Factor the numerator using the difference of squares:

$4x^2 - 100 = 4(x^2 - 25) = 4(x - 5)(x + 5)$

For $x \neq 5$, cancel $(x - 5)$:

$4(x + 5) = kx + 20$

$4x + 20 = kx + 20$

For this to be an identity, the $x$ coefficients must match: $k = 4$.',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_52'
),

-- Q2 (sat_lid_003_53): No solution — must-be-true
(
  'mcq', 'math',
  '$a(3x - 4) + 12 = 15x + b$

In the equation above, $a$ and $b$ are constants. If the equation has no solution, which of the following must be true?',
  '[{"id":"a","text":"$a = 5$ and $b \\neq -8$"},{"id":"b","text":"$a = 5$ and $b = -8$"},{"id":"c","text":"$a = 15$ and $b \\neq 12$"},{"id":"d","text":"$a = 3$ and $b \\neq 8$"}]'::jsonb,
  'a',
  'Distribute $a$: $3ax - 4a + 12 = 15x + b$.

For no solution, $x$ coefficients must match but constants must differ.

Step 1: $3a = 15 \implies a = 5$.

Step 2: Left constant with $a = 5$: $-4(5) + 12 = -8$.

Step 3: For no solution: $-8 \neq b$.',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_53'
),

-- Q3 (sat_lid_003_54): Identity — infinitely many solutions
(
  'mcq', 'math',
  'How many solutions does the equation $7(2x - 3) + 21 = 14x$ have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'c',
  'Expand the left side:

$14x - 21 + 21 = 14x$

$14x = 14x$

This is an identity — true for all values of $x$. Infinitely many solutions.',
  'algebra', 'easy', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_54'
),

-- Q4 (sat_lid_003_55): Identity — describe number of solutions
(
  'mcq', 'math',
  '$10(2x - 3) - 5x = 3(5x - 10)$

Which of the following describes the number of solutions to the equation above?',
  '[{"id":"a","text":"The equation has no solution."},{"id":"b","text":"The equation has exactly one solution, $x = 0$."},{"id":"c","text":"The equation has exactly one solution, $x = 5$."},{"id":"d","text":"The equation has infinitely many solutions."}]'::jsonb,
  'd',
  'Left side: $20x - 30 - 5x = 15x - 30$.

Right side: $15x - 30$.

The equation is $15x - 30 = 15x - 30$ — an identity. Every value of $x$ satisfies it.',
  'algebra', 'easy', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_55'
),

-- Q5 (sat_lid_003_56): Bolt count word problem — identify equation
(
  'mcq', 'math',
  'A contractor uses three types of bolts: 5-inch, 3-inch, and 2-inch. The number of 5-inch bolts is 4 times the number $n$ of 3-inch bolts. The number of 2-inch bolts is 15. If the contractor uses a total of 80 bolts, which equation represents this situation?',
  '[{"id":"a","text":"$5(4n) + 3n + 2(15) = 80$"},{"id":"b","text":"$4n + 15 = 80$"},{"id":"c","text":"$5n + 15 = 80$"},{"id":"d","text":"$9n + 15 = 80$"}]'::jsonb,
  'c',
  'Count each type (not their lengths):
- 3-inch bolts: $n$
- 5-inch bolts: $4n$
- 2-inch bolts: 15

$n + 4n + 15 = 80 \implies 5n + 15 = 80$',
  'algebra', 'easy', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_56'
),

-- Q6 (sat_lid_003_57): Nested fraction — find k for infinite solutions
(
  'mcq', 'math',
  '$\frac{k(2x + 8)}{3} = 4x + 16$

In the equation above, $k$ is a constant. If the equation has infinitely many solutions, what is the value of $k$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"12"}]'::jsonb,
  'c',
  'Multiply both sides by 3 to clear the denominator:

$k(2x + 8) = 3(4x + 16)$

$2kx + 8k = 12x + 48$

For an identity, match $x$ coefficients: $2k = 12 \implies k = 6$.

Verify constants: $8(6) = 48$ ✓. Both conditions hold.',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_57'
),

-- Q7 (sat_lid_003_58): Factor x — no solution for p
(
  'mcq', 'math',
  '$18px - 9x = 72$

In the equation above, $p$ is a constant. If the equation has no solution, what is the value of $p$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"$\\frac{1}{2}$"},{"id":"c","text":"2"},{"id":"d","text":"9"}]'::jsonb,
  'b',
  'Factor $x$:

$(18p - 9)x = 72$

For no solution, the coefficient of $x$ must be zero (since $0 = 72$ is false):

$18p - 9 = 0 \implies 18p = 9 \implies p = \frac{1}{2}$',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_58'
),

-- Q8 (sat_lid_003_59): Range for x+9
(
  'mcq', 'math',
  'If $\frac{2(x + 9)}{5} = \frac{x + 9}{10} + 6$, the value of $x + 9$ is between which of the following pairs?',
  '[{"id":"a","text":"5 and 15"},{"id":"b","text":"18 and 22"},{"id":"c","text":"25 and 35"},{"id":"d","text":"38 and 42"}]'::jsonb,
  'b',
  'Let $u = x + 9$:

$\frac{2u}{5} = \frac{u}{10} + 6$

Multiply by 10:

$4u = u + 60$

$3u = 60 \implies u = 20$

The value 20 lies between 18 and 22.',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_59'
),

-- Q9 (sat_lid_003_60): Literal identity — find k+n
(
  'mcq', 'math',
  '$k(5 - x) - n = 4 - 3x$

In the equation above, $k$ and $n$ are constants. If the equation has infinitely many solutions, what is the value of $k + n$?',
  '[{"id":"a","text":"7"},{"id":"b","text":"11"},{"id":"c","text":"14"},{"id":"d","text":"19"}]'::jsonb,
  'c',
  'Expand: $5k - kx - n = 4 - 3x$.

Rearrange: $(-k)x + (5k - n) = (-3)x + 4$.

Step 1 — $x$ coefficients: $-k = -3 \implies k = 3$.

Step 2 — Constants: $5k - n = 4 \implies 5(3) - n = 4 \implies n = 11$.

$k + n = 3 + 11 = 14$',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_60'
),

-- Q10 (sat_lid_003_61): Multi-constant no solution with n constraint
(
  'mcq', 'math',
  '$3(px - n) = -\frac{24}{7}x - \frac{15}{2}$

In the equation above, $p$ and $n$ are constants and $n > 3$. If the equation has no solution, what is the value of $p$?',
  '[{"id":"a","text":"$-\\frac{8}{7}$"},{"id":"b","text":"$-\\frac{24}{7}$"},{"id":"c","text":"$8$"},{"id":"d","text":"$\\frac{8}{7}$"}]'::jsonb,
  'a',
  'Distribute 3: $3px - 3n = -\frac{24}{7}x - \frac{15}{2}$.

For no solution, $x$ coefficients must match:

$3p = -\frac{24}{7} \implies p = -\frac{8}{7}$

Constants must differ: since $n > 3$, $-3n < -9$, and $-\frac{15}{2} = -7.5$, so the constants are guaranteed to be unequal.',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_61'
),

-- Q11 (sat_lid_003_62): Expression substitution — find 2x-7
(
  'mcq', 'math',
  'If $5(2x - 7) + 12 = 3(2x - 7) + 28$, what is the value of $2x - 7$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"12"},{"id":"d","text":"16"}]'::jsonb,
  'b',
  'Let $u = 2x - 7$:

$5u + 12 = 3u + 28$

$2u = 16 \implies u = 8$

The value of $2x - 7$ is 8.',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_62'
),

-- Q12 (sat_lid_003_63): Infinite solutions — find a from fraction equation
(
  'mcq', 'math',
  '$\frac{a(x + 5)}{4} = 3x + 15$

In the equation above, $a$ is a constant. If the equation has infinitely many solutions, what is the value of $a$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"12"},{"id":"d","text":"15"}]'::jsonb,
  'c',
  'Multiply both sides by 4:

$a(x + 5) = 4(3x + 15)$

$ax + 5a = 12x + 60$

For an identity, match $x$ coefficients: $a = 12$.

Verify constants: $5(12) = 60$ ✓.',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_63'
),

-- Q13 (sat_lid_003_64): Zero solutions — contradiction
-- Note: source marked answer C but explanation shows 10=8 (contradiction) → zero solutions → answer A
(
  'mcq', 'math',
  'How many solutions does the equation $5(x + 2) - 3x = 2(x + 4)$ have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'a',
  'Left side: $5x + 10 - 3x = 2x + 10$.

Right side: $2x + 8$.

The equation becomes $2x + 10 = 2x + 8$.

Subtract $2x$: $10 = 8$ — a contradiction. No value of $x$ satisfies the equation.',
  'algebra', 'easy', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_64'
),

-- Q14 (sat_lid_003_65): Factorable rational — find a+b
(
  'mcq', 'math',
  '$\frac{x^2 - 49}{x + 7} = ax + b$

In the equation above, $a$ and $b$ are constants. If the equation is true for all $x \neq -7$, what is the value of $a + b$?',
  '[{"id":"a","text":"-8"},{"id":"b","text":"-6"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'b',
  'Factor the numerator:

$\frac{(x - 7)(x + 7)}{x + 7} = ax + b$

For $x \neq -7$, cancel $(x + 7)$:

$x - 7 = ax + b$

Matching coefficients: $a = 1$ and $b = -7$.

$a + b = 1 + (-7) = -6$',
  'algebra', 'hard', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_65'
),

-- Q15 (sat_lid_003_66): Coefficient nullification — find p
(
  'mcq', 'math',
  '$14x - 2px = 84$

In the given equation, $p$ is a constant. If the equation has no solution, what is the value of $p$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"7"},{"id":"c","text":"14"},{"id":"d","text":"42"}]'::jsonb,
  'b',
  'Factor $x$:

$x(14 - 2p) = 84$

For no solution, the coefficient of $x$ must be zero (since $0 = 84$ is impossible):

$14 - 2p = 0 \implies 2p = 14 \implies p = 7$',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_66'
),

-- Q16 (sat_lid_003_67): Warehouse crate count equation
(
  'mcq', 'math',
  'A warehouse stores three types of crates: small (20 kg), medium (40 kg), and large (60 kg). The number of medium crates is 5 times the number $n$ of small crates. There are 12 large crates. If the total number of crates is 90, which equation is correct?',
  '[{"id":"a","text":"$5n + 12 = 90$"},{"id":"b","text":"$6n + 12 = 90$"},{"id":"c","text":"$20n + 40(5n) + 60(12) = 90$"},{"id":"d","text":"$n + 12 = 90$"}]'::jsonb,
  'b',
  'Count each type:
- Small: $n$
- Medium: $5n$
- Large: 12

$n + 5n + 12 = 90 \implies 6n + 12 = 90$',
  'algebra', 'easy', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_67'
),

-- Q17 (sat_lid_003_68): Range for x+4
(
  'mcq', 'math',
  'If $\frac{x + 4}{3} = \frac{x + 4}{9} + 4$, the value of $x + 4$ is between:',
  '[{"id":"a","text":"-2 and 2"},{"id":"b","text":"3 and 8"},{"id":"c","text":"5 and 7"},{"id":"d","text":"12 and 18"}]'::jsonb,
  'd',
  'Let $u = x + 4$:

$\frac{u}{3} = \frac{u}{9} + 4$

Multiply by 9:

$3u = u + 36 \implies 2u = 36 \implies u = 18$

The value 18 is at the boundary of the range 12 to 18.',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_68'
),

-- Q18 (sat_lid_003_69): Exactly one solution condition
(
  'mcq', 'math',
  '$k(x - 5) + 3 = 4x + 12$

In the equation above, $k$ is a constant. For what value of $k$ does the equation have exactly one solution?',
  '[{"id":"a","text":"$k = 4$"},{"id":"b","text":"$k \\neq 4$"},{"id":"c","text":"$k = -5$"},{"id":"d","text":"$k = 0$"}]'::jsonb,
  'b',
  'Distribute: $kx - 5k + 3 = 4x + 12$.

A linear equation has exactly one solution when the $x$ coefficients are not equal. If $k = 4$, the equation becomes $-5(4) + 3 = 12$, i.e., $-17 = 12$ — no solution. For any $k \neq 4$, the coefficients differ and there is exactly one solution.',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_69'
),

-- Q19 (sat_lid_003_70): Literal identity — find b
(
  'mcq', 'math',
  '$a(x - 2) + b = 3x + 10$

If the equation above has infinitely many solutions, what is the value of $b$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"10"},{"id":"c","text":"13"},{"id":"d","text":"16"}]'::jsonb,
  'd',
  'Expand: $ax - 2a + b = 3x + 10$.

Step 1 — $x$ coefficients: $a = 3$.

Step 2 — Constants: $-2a + b = 10 \implies -6 + b = 10 \implies b = 16$.',
  'algebra', 'medium', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_70'
),

-- Q20 (sat_lid_003_71): Nested distribution — identity
(
  'mcq', 'math',
  'How many solutions does the equation $4[2(x - 1) + 3] = 8x + 4$ have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Exactly two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'd',
  'Simplify the inner bracket first:

$4[2x - 2 + 3] = 4[2x + 1] = 8x + 4$

The equation becomes $8x + 4 = 8x + 4$ — an identity. Infinitely many solutions.',
  'algebra', 'easy', 0, 0,
  'Linear equations in one variable', 'Number of Solutions',
  'sat_lid_003_71'
),

-- ============================================================
-- sat_lid_004 — Slope-Intercept & Standard Form (ids _51–_70)
-- ============================================================

-- Q1 (sat_lid_004_51): Perpendicular slope from standard form
(
  'mcq', 'math',
  'Line $p$ is defined by the equation $6y + 15x = 9$. Line $r$ is perpendicular to line $p$ in the $xy$-plane. What is the slope of line $r$?',
  '[{"id":"a","text":"$-\\frac{5}{2}$"},{"id":"b","text":"$-\\frac{2}{5}$"},{"id":"c","text":"$\\frac{2}{5}$"},{"id":"d","text":"$\\frac{5}{2}$"}]'::jsonb,
  'c',
  'Convert to slope-intercept form: $6y = -15x + 9 \implies y = -\frac{5}{2}x + \frac{3}{2}$.

Slope of $p$: $m_p = -\frac{5}{2}$.

Perpendicular slope is the negative reciprocal:

$m_r = \frac{2}{5}$',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_51'
),

-- Q2 (sat_lid_004_52): Intercept ratio a/b
(
  'mcq', 'math',
  'The graph of $9x + 4y = -72$ in the $xy$-plane has an $x$-intercept at $(a, 0)$ and a $y$-intercept at $(0, b)$, where $a$ and $b$ are constants. What is the value of $\frac{a}{b}$?',
  '[{"id":"a","text":"$-\\frac{9}{4}$"},{"id":"b","text":"$-\\frac{4}{9}$"},{"id":"c","text":"$\\frac{4}{9}$"},{"id":"d","text":"$\\frac{9}{4}$"}]'::jsonb,
  'c',
  'Find $a$ (set $y = 0$): $9a = -72 \implies a = -8$.

Find $b$ (set $x = 0$): $4b = -72 \implies b = -18$.

$\frac{a}{b} = \frac{-8}{-18} = \frac{4}{9}$',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_52'
),

-- Q3 (sat_lid_004_53): Translate line down — find x-intercept of new line
(
  'mcq', 'math',
  'For line $h$, two points are $(12, 80)$ and $(15, 95)$. Line $k$ is the result of translating line $h$ down 10 units in the $xy$-plane. What is the $x$-intercept of line $k$?',
  '[{"id":"a","text":"$(-4, 0)$"},{"id":"b","text":"$(-2, 0)$"},{"id":"c","text":"$(2, 0)$"},{"id":"d","text":"$(4, 0)$"}]'::jsonb,
  'b',
  'Slope of $h$: $m = \frac{95 - 80}{15 - 12} = \frac{15}{3} = 5$.

$y$-intercept of $h$: $80 = 5(12) + c \implies c = 20$. Line $h$: $y = 5x + 20$.

Translate down 10: Line $k$: $y = 5x + 10$.

$x$-intercept (set $y = 0$): $5x = -10 \implies x = -2$.',
  'algebra', 'hard', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_53'
),

-- Q4 (sat_lid_004_54): Perpendicular to horizontal line → undefined slope
(
  'mcq', 'math',
  'Line $t$ in the $xy$-plane is perpendicular to the line with equation $y = -5$. What is the slope of line $t$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"5"},{"id":"c","text":"-5"},{"id":"d","text":"The slope of line $t$ is undefined."}]'::jsonb,
  'd',
  '$y = -5$ is a horizontal line with slope 0.

A line perpendicular to a horizontal line is vertical. Vertical lines have the form $x = a$ and their slope is undefined (the run is zero).',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_54'
),

-- Q5 (sat_lid_004_55): Find k from two points on ax+ky=12
(
  'mcq', 'math',
  'The graph of the equation $ax + ky = 12$ is a line in the $xy$-plane, where $a$ and $k$ are constants. If the line contains the points $(-4, -10)$ and $(0, -4)$, what is the value of $k$?',
  '[{"id":"a","text":"-3"},{"id":"b","text":"-2"},{"id":"c","text":"2"},{"id":"d","text":"3"}]'::jsonb,
  'a',
  'Use $(0, -4)$ — the $y$-intercept:

$a(0) + k(-4) = 12$

$-4k = 12 \implies k = -3$',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_55'
),

-- Q6 (sat_lid_004_56): y-intercept from x-intercept and slope
(
  'mcq', 'math',
  'In the $xy$-plane, line $p$ has a slope of $-\frac{7}{4}$ and an $x$-intercept of $(-8, 0)$. What is the $y$-coordinate of the $y$-intercept of line $p$?',
  '[{"id":"a","text":"-14"},{"id":"b","text":"-7"},{"id":"c","text":"7"},{"id":"d","text":"14"}]'::jsonb,
  'a',
  'Use $y = mx + b$ with $m = -\frac{7}{4}$ and point $(-8, 0)$:

$0 = \left(-\frac{7}{4}\right)(-8) + b$

$0 = 14 + b \implies b = -14$',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_56'
),

-- Q7 (sat_lid_004_57): Table-based y-intercept with variable k
(
  'mcq', 'math',
  'A line in the $xy$-plane passes through the points $(k,\ 22)$ and $(k + 5,\ -13)$. The $y$-intercept of the line is $(k - 4,\ b)$, where $k$ and $b$ are constants. What is the value of $b$?',
  '[{"id":"a","text":"44"},{"id":"b","text":"50"},{"id":"c","text":"56"},{"id":"d","text":"62"}]'::jsonb,
  'b',
  'Slope: $m = \frac{-13 - 22}{(k+5) - k} = \frac{-35}{5} = -7$.

Line equation using $(k, 22)$: $y = -7x + 7k + 22$.

Since $(k - 4, b)$ is the $y$-intercept, its $x$-coordinate must be 0:

$k - 4 = 0 \implies k = 4$.

Substitute $x = 0$, $k = 4$: $b = 7(4) + 22 = 28 + 22 = 50$.',
  'algebra', 'hard', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_57'
),

-- Q8 (sat_lid_004_58): Translate standard form line — find new y-intercept
(
  'mcq', 'math',
  'If the line $3x - 5y = 15$ is translated 4 units up and 2 units to the right, what is the $y$-intercept of the new line?',
  '[{"id":"a","text":"-2.2"},{"id":"b","text":"-0.2"},{"id":"c","text":"0.2"},{"id":"d","text":"2.2"}]'::jsonb,
  'b',
  'Convert to slope-intercept: $y = \frac{3}{5}x - 3$.

Apply translations: 2 right replaces $x$ with $(x - 2)$; 4 up adds 4.

$y = \frac{3}{5}(x - 2) - 3 + 4$

At $x = 0$: $y = \frac{3}{5}(0 - 2) + 1 = -\frac{6}{5} + 1 = -1.2 + 1 = -0.2$',
  'algebra', 'hard', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_58'
),

-- Q9 (sat_lid_004_59): Slope from variable coordinates — find k
(
  'mcq', 'math',
  'In the $xy$-plane, line $t$ passes through the points $(0, c)$ and $(1, c + k)$. If line $t$ is perpendicular to a line with slope $\frac{1}{4}$, what is the value of $k$?',
  '[{"id":"a","text":"-4"},{"id":"b","text":"-0.25"},{"id":"c","text":"0.25"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  'Slope of line $t$: $m_t = \frac{(c + k) - c}{1 - 0} = k$.

Perpendicular to slope $\frac{1}{4}$ means:

$m_t = -\frac{1}{1/4} = -4$

Since $m_t = k$, we get $k = -4$.',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_59'
),

-- Q10 (sat_lid_004_60): Equation from slope and point
(
  'mcq', 'math',
  'Line $t$ in the $xy$-plane has a slope of $-\frac{2}{5}$ and passes through the point $(10, 7)$. Which equation defines line $t$?',
  '[{"id":"a","text":"$y = -\\frac{2}{5}x + 3$"},{"id":"b","text":"$y = -\\frac{2}{5}x + 11$"},{"id":"c","text":"$y = \\frac{5}{2}x - 18$"},{"id":"d","text":"$y = 10x + 7$"}]'::jsonb,
  'b',
  'Use $y = mx + b$ with $m = -\frac{2}{5}$ and point $(10, 7)$:

$7 = \left(-\frac{2}{5}\right)(10) + b$

$7 = -4 + b \implies b = 11$

Equation: $y = -\frac{2}{5}x + 11$',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_60'
),

-- Q11 (sat_lid_004_61): Perpendicular slope from slope-intercept form
(
  'mcq', 'math',
  'Line $k$ is defined by $y = \frac{2}{9}x + 12$. Line $j$ is perpendicular to line $k$ in the $xy$-plane. What is the slope of line $j$?',
  '[{"id":"a","text":"$-9$"},{"id":"b","text":"$-\\frac{9}{2}$"},{"id":"c","text":"$\\frac{2}{9}$"},{"id":"d","text":"$\\frac{9}{2}$"}]'::jsonb,
  'b',
  'Slope of $k$: $m_k = \frac{2}{9}$.

Perpendicular slope (negative reciprocal):

$m_j = -\frac{1}{2/9} = -\frac{9}{2}$',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_61'
),

-- Q12 (sat_lid_004_62): Intercept ratio b/a
(
  'mcq', 'math',
  'The graph of $5x - 3y = -45$ in the $xy$-plane has an $x$-intercept at $(a, 0)$ and a $y$-intercept at $(0, b)$. What is the value of $\frac{b}{a}$?',
  '[{"id":"a","text":"$-\\frac{5}{3}$"},{"id":"b","text":"$-\\frac{3}{5}$"},{"id":"c","text":"$\\frac{3}{5}$"},{"id":"d","text":"$\\frac{5}{3}$"}]'::jsonb,
  'a',
  'Find $a$ (set $y = 0$): $5a = -45 \implies a = -9$.

Find $b$ (set $x = 0$): $-3b = -45 \implies b = 15$.

$\frac{b}{a} = \frac{15}{-9} = -\frac{5}{3}$',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_62'
),

-- Q13 (sat_lid_004_63): Translate line up — find x-intercept
-- Note: original LaTeX had inconsistent points; replaced with (5,5)/(10,25) for consistency
(
  'mcq', 'math',
  'Line $h$ passes through the points $(5, 5)$ and $(10, 25)$. Line $k$ is the result of translating line $h$ up 5 units in the $xy$-plane. What is the $x$-intercept of line $k$?',
  '[{"id":"a","text":"$(-2.5, 0)$"},{"id":"b","text":"$(-1.5, 0)$"},{"id":"c","text":"$(1.5, 0)$"},{"id":"d","text":"$(2.5, 0)$"}]'::jsonb,
  'd',
  'Slope of $h$: $m = \frac{25 - 5}{10 - 5} = 4$.

$y$-intercept of $h$: $5 = 4(5) + c \implies c = -15$. Line $h$: $y = 4x - 15$.

Translate up 5: Line $k$: $y = 4x - 10$.

$x$-intercept (set $y = 0$): $4x = 10 \implies x = 2.5$.',
  'algebra', 'hard', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_63'
),

-- Q14 (sat_lid_004_64): Find k from two points on kx+ay=24
-- Note: original had point (4,8) giving k=-6 which is not in the options; fixed to (-4,8)
(
  'mcq', 'math',
  'The graph of $kx + ay = 24$ contains the points $(-4, 8)$ and $(0, 4)$. What is the value of $k$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'c',
  'Use $(0, 4)$ to find $a$:

$k(0) + a(4) = 24 \implies 4a = 24 \implies a = 6$

Use $(-4, 8)$ with $a = 6$ to find $k$:

$k(-4) + 6(8) = 24$

$-4k + 48 = 24 \implies -4k = -24 \implies k = 6$',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_64'
),

-- Q15 (sat_lid_004_65): Perpendicular slope from standard form
(
  'mcq', 'math',
  'Line $p$ is defined by $12x - 3y = 7$. Line $r$ is perpendicular to line $p$. What is the slope of line $r$?',
  '[{"id":"a","text":"$-4$"},{"id":"b","text":"$-\\frac{1}{4}$"},{"id":"c","text":"$\\frac{1}{4}$"},{"id":"d","text":"$4$"}]'::jsonb,
  'b',
  'Isolate $y$: $-3y = -12x + 7 \implies y = 4x - \frac{7}{3}$.

Slope of $p$: $m_p = 4$.

Perpendicular slope: $m_r = -\frac{1}{4}$.',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_65'
),

-- Q16 (sat_lid_004_66): y-intercept from x-intercept and slope
(
  'mcq', 'math',
  'In the $xy$-plane, line $L$ has a slope of $-3$ and an $x$-intercept of $(12, 0)$. What is the $y$-coordinate of the $y$-intercept of line $L$?',
  '[{"id":"a","text":"-36"},{"id":"b","text":"-4"},{"id":"c","text":"4"},{"id":"d","text":"36"}]'::jsonb,
  'd',
  'Use $y = mx + b$ with $m = -3$ and point $(12, 0)$:

$0 = -3(12) + b \implies 0 = -36 + b \implies b = 36$',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_66'
),

-- Q17 (sat_lid_004_67): Table-based y-intercept with variable k
(
  'mcq', 'math',
  'A line passes through the points $(k,\ 15)$ and $(k + 2,\ 21)$. The $y$-intercept of the line is $(k - 6,\ b)$. What is the value of $b$?',
  '[{"id":"a","text":"-3"},{"id":"b","text":"0"},{"id":"c","text":"3"},{"id":"d","text":"15"}]'::jsonb,
  'a',
  'Slope: $m = \frac{21 - 15}{(k+2) - k} = \frac{6}{2} = 3$.

Since $(k - 6, b)$ is the $y$-intercept, its $x$-coordinate is 0:

$k - 6 = 0 \implies k = 6$

Using point $(6, 15)$: $15 = 3(6) + \text{intercept} \implies \text{intercept} = -3$.

So $b = -3$.',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_67'
),

-- Q18 (sat_lid_004_68): Perpendicular to vertical line → slope 0
(
  'mcq', 'math',
  'Line $w$ is perpendicular to the line $x = 14$. What is the slope of line $w$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"14"},{"id":"c","text":"-14"},{"id":"d","text":"Undefined"}]'::jsonb,
  'a',
  '$x = 14$ is a vertical line.

A line perpendicular to a vertical line is horizontal.

Horizontal lines have a slope of 0.',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_68'
),

-- Q19 (sat_lid_004_69): Equation from two points
(
  'mcq', 'math',
  'Line $t$ passes through $(0, 15)$ and $(1, 8)$. Which equation defines line $t$?',
  '[{"id":"a","text":"$y = -7x + 15$"},{"id":"b","text":"$y = -7x + 8$"},{"id":"c","text":"$y = 7x + 15$"},{"id":"d","text":"$y = 8x + 15$"}]'::jsonb,
  'a',
  '$(0, 15)$ is the $y$-intercept, so $b = 15$.

Slope: $m = \frac{8 - 15}{1 - 0} = -7$.

Equation: $y = -7x + 15$.',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_69'
),

-- Q20 (sat_lid_004_70): Equation from slope and point
(
  'mcq', 'math',
  'Line $k$ has a slope of $\frac{3}{4}$ and passes through $(8, -2)$. Which equation defines line $k$?',
  '[{"id":"a","text":"$y = \\frac{3}{4}x - 8$"},{"id":"b","text":"$y = \\frac{3}{4}x - 6$"},{"id":"c","text":"$y = \\frac{3}{4}x - 2$"},{"id":"d","text":"$y = \\frac{3}{4}x + 4$"}]'::jsonb,
  'a',
  'Use $y = \frac{3}{4}x + b$ with point $(8, -2)$:

$-2 = \frac{3}{4}(8) + b$

$-2 = 6 + b \implies b = -8$

Equation: $y = \frac{3}{4}x - 8$.',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Slope-Intercept and Standard Form',
  'sat_lid_004_70'
),

-- ============================================================
-- sat_lid_005 — Graphing Linear Equations (ids _51–_70)
-- ============================================================

-- Q1 (sat_lid_005_51): Graph matching standard form with constant R
-- Note: source marked answer B; corrected to A based on intercepts (0,3) and (1.5,0)
(
  'mcq', 'math',
  'A line in the $xy$-plane has a $y$-intercept at $(0, 3)$ and an $x$-intercept at $(1.5, 0)$, where $R$ is a positive constant. Which of the following equations represents this linear relationship?',
  '[{"id":"a","text":"$Rx + 18y = 54$"},{"id":"b","text":"$18x + Ry = 54$"},{"id":"c","text":"$Rx - 18y = -54$"},{"id":"d","text":"$18x - Ry = -54$"}]'::jsonb,
  'a',
  'Slope from intercepts: $m = \frac{3 - 0}{0 - 1.5} = -2$.

Standard form: $2x + y = 3$.

Multiply both sides by 18: $36x + 18y = 54$.

This matches option A ($Rx + 18y = 54$) with $R = 36$, which is positive.',
  'algebra', 'hard', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_51'
),

-- Q2 (sat_lid_005_52): Interpret constant 48 in context
(
  'mcq', 'math',
  'The equation $3x + 2y = 48$ represents the total points scored by a basketball team from $x$ three-point shots and $y$ two-point shots. Which of the following is the best interpretation of 48 in this context?',
  '[{"id":"a","text":"The total number of successful shots made by the team."},{"id":"b","text":"The difference between the points scored from two-point and three-point shots."},{"id":"c","text":"The total number of points scored from these two types of shots."},{"id":"d","text":"The average number of points scored per minute during the game."}]'::jsonb,
  'c',
  '$3x$ represents total points from three-pointers, and $2y$ represents total points from two-pointers. Their sum equals 48, the total points scored.',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_52'
),

-- Q3 (sat_lid_005_53): Graph intercepts — find k
(
  'mcq', 'math',
  'A line in the $xy$-plane has a $y$-intercept at $(0, 8)$ and an $x$-intercept at $(8, 0)$. The line also passes through the point $(k, 5)$. What is the value of $k$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"5"},{"id":"d","text":"8"}]'::jsonb,
  'b',
  'Slope: $m = \frac{0 - 8}{8 - 0} = -1$.

Equation: $y = -x + 8$.

Substitute $(k, 5)$: $5 = -k + 8 \implies k = 3$.',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_53'
),

-- Q4 (sat_lid_005_54): Slope from table with variable p
(
  'mcq', 'math',
  'A table shows three values of $x$ and their corresponding values of $y$, where $p$ is a constant: $(-4,\ p + 120)$, $(-2,\ p + 60)$, $(0,\ p)$. What is the slope of the line that represents this relationship?',
  '[{"id":"a","text":"$-60$"},{"id":"b","text":"$-30$"},{"id":"c","text":"$30$"},{"id":"d","text":"$60$"}]'::jsonb,
  'b',
  'Using points $(-2,\ p + 60)$ and $(0,\ p)$:

$m = \frac{p - (p + 60)}{0 - (-2)} = \frac{-60}{2} = -30$

The variable $p$ cancels — slope is independent of $p$.',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_54'
),

-- Q5 (sat_lid_005_55): Perpendicular line with y-intercept
(
  'mcq', 'math',
  'In the $xy$-plane, line $L$ is defined by $x - y = 0$. Line $M$ is perpendicular to line $L$ and has a $y$-intercept of $(0, -5)$. Which of the following is an equation of line $M$?',
  '[{"id":"a","text":"$x + y = -5$"},{"id":"b","text":"$x - y = -5$"},{"id":"c","text":"$x + y = 5$"},{"id":"d","text":"$x - y = 5$"}]'::jsonb,
  'a',
  'Line $L$: $y = x$, so slope $m_L = 1$.

Perpendicular slope: $m_M = -1$.

With $y$-intercept $(0, -5)$: $y = -x - 5$.

Standard form: $x + y = -5$.',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_55'
),

-- Q6 (sat_lid_005_56): Perimeter interpretation
(
  'mcq', 'math',
  'In isosceles triangle $ABC$, the lengths of sides $AB$ and $BC$ are each $x$ centimeters, and the length of side $AC$ is $y$ centimeters. The equation $2x + y = 60$ represents this situation. Which of the following is the best interpretation of 60 in this context?',
  '[{"id":"a","text":"The area of the triangle in square centimeters."},{"id":"b","text":"The perimeter of the triangle in centimeters."},{"id":"c","text":"The length of the altitude to side $AC$."},{"id":"d","text":"The sum of the lengths of the two equal sides."}]'::jsonb,
  'b',
  '$2x$ is the sum of the two equal sides ($x + x$), and $y$ is the base. Their sum $2x + y = 60$ equals the total perimeter of the triangle.',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_56'
),

-- Q7 (sat_lid_005_57): Mixture problem
(
  'mcq', 'math',
  'How many liters of a 40% acid solution must be added to 5 liters of a 10% acid solution to obtain a 20% acid solution?',
  '[{"id":"a","text":"2.0"},{"id":"b","text":"2.5"},{"id":"c","text":"3.0"},{"id":"d","text":"4.5"}]'::jsonb,
  'b',
  'Let $x$ = liters of the 40% solution. Balance pure acid:

$0.40x + 0.10(5) = 0.20(x + 5)$

$0.4x + 0.5 = 0.2x + 1.0$

$0.2x = 0.5 \implies x = 2.5$',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_57'
),

-- Q8 (sat_lid_005_58): Variable interpretation in context
(
  'mcq', 'math',
  'A city department maintains a 5-hectare botanical garden and a 40-hectare public park. The total number of shrubs is 5,400. The equation $5x + 40y = 5{,}400$ represents this situation. Which of the following is the best interpretation of $x$ in this context?',
  '[{"id":"a","text":"The total number of shrubs in the botanical garden."},{"id":"b","text":"The average number of shrubs per hectare in the botanical garden."},{"id":"c","text":"The average number of shrubs per hectare in the public park."},{"id":"d","text":"The total number of shrubs in the public park."}]'::jsonb,
  'b',
  'In $5x + 40y = 5{,}400$, the coefficients 5 and 40 represent areas (hectares). For the product to give a number of shrubs, $x$ must have units of shrubs per hectare — the average density in the 5-hectare garden.',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_58'
),

-- Q9 (sat_lid_005_59): Earnings graph intercepts — find total s
(
  'mcq', 'math',
  'Marcus earns \$25 per hour tutoring and \$15 per hour for delivery. The graph of all combinations of hours that yield a total earning of $s$ dollars has an intercept at $(0, 10)$ on the delivery-hours axis and at $(6, 0)$ on the tutoring-hours axis. What is the value of $s$?',
  '[{"id":"a","text":"150"},{"id":"b","text":"250"},{"id":"c","text":"300"},{"id":"d","text":"400"}]'::jsonb,
  'a',
  'The $y$-intercept $(0, 10)$ means 10 hours of delivery earns $s$:

$s = 10 \times \$15 = \$150$

Verify with $x$-intercept $(6, 0)$ — 6 hours tutoring:

$s = 6 \times \$25 = \$150$ ✓',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_59'
),

-- Q10 (sat_lid_005_60): Perpendicular pair — which also perpendicular
(
  'mcq', 'math',
  'In the given pair of equations, $a$ and $b$ are constants: $3x + 8y = 1$ and $ax + by = 1$. The graph of this pair is a pair of perpendicular lines. Which of the following also represents a pair of perpendicular lines?',
  '[{"id":"a","text":"$6x + 8y = 1$ and $ax - 2by = 1$"},{"id":"b","text":"$3x + 8y = 1$ and $2ax + 2by = 1$"},{"id":"c","text":"$3x - 8y = 1$ and $ax + by = 1$"},{"id":"d","text":"$8x - 3y = 1$ and $ax + by = 1$"}]'::jsonb,
  'b',
  'Slope of first line: $m_1 = -3/8$. For perpendicularity: $m_2 = 8/3$, giving $a = 8, b = -3$.

Option B: second line is $2ax + 2by = 1$, with slope $-\frac{2a}{2b} = -\frac{a}{b} = -\frac{8}{-3} = \frac{8}{3}$.

This is still the negative reciprocal of $-3/8$, so the pair remains perpendicular.',
  'algebra', 'hard', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_60'
),

-- Q11 (sat_lid_005_61): Table with k and n — find k+n
(
  'mcq', 'math',
  'A line with slope 3 passes through the points $(4, 8)$, $(k, 14)$, and $(10, n)$. What is $k + n$?',
  '[{"id":"a","text":"32"},{"id":"b","text":"30"},{"id":"c","text":"28"},{"id":"d","text":"26"}]'::jsonb,
  'a',
  'Find $k$ using $(4, 8)$ and $(k, 14)$:

$3 = \frac{14 - 8}{k - 4} \implies 3(k - 4) = 6 \implies k = 6$

Find $n$ using $(4, 8)$ and $(10, n)$:

$3 = \frac{n - 8}{10 - 4} \implies 18 = n - 8 \implies n = 26$

$k + n = 6 + 26 = 32$',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_61'
),

-- Q12 (sat_lid_005_62): t-intercept interpretation
(
  'mcq', 'math',
  'An airplane''s altitude $A$, in feet, $t$ minutes after beginning its descent is modeled by $A = 32{,}000 - 800t$. What is the best interpretation of the $t$-intercept of the graph of this equation?',
  '[{"id":"a","text":"The altitude of the plane when it begins its descent."},{"id":"b","text":"The total time, in minutes, it takes for the plane to reach the ground."},{"id":"c","text":"The speed at which the plane is descending in feet per minute."},{"id":"d","text":"The altitude of the plane after 1 minute of descent."}]'::jsonb,
  'b',
  'The $t$-intercept occurs when $A = 0$ — when the altitude reaches 0 feet, meaning the plane has landed. The value of $t$ at this point is the total descent time.',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_62'
),

-- Q13 (sat_lid_005_63): Perpendicular from graph — find equation of line v
(
  'mcq', 'math',
  'Line $q$ in the $xy$-plane passes through $(0, 4)$ and $(4, 0)$. Line $v$ is perpendicular to line $q$ and passes through $(0, 2)$. What is the equation of line $v$?',
  '[{"id":"a","text":"$y = x + 2$"},{"id":"b","text":"$y = -x + 2$"},{"id":"c","text":"$y = 2x + 2$"},{"id":"d","text":"$y = \\frac{1}{2}x + 2$"}]'::jsonb,
  'a',
  'Slope of $q$: $m_q = \frac{0 - 4}{4 - 0} = -1$.

Perpendicular slope: $m_v = -\frac{1}{-1} = 1$.

With $y$-intercept $(0, 2)$: $y = x + 2$.',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_63'
),

-- Q14 (sat_lid_005_64): Shift line up — find new x-intercept
(
  'mcq', 'math',
  'If the graph of $4x + 3y = 12$ is shifted up 2 units, what is the $x$-intercept of the new line?',
  '[{"id":"a","text":"3.0"},{"id":"b","text":"4.5"},{"id":"c","text":"5.0"},{"id":"d","text":"6.0"}]'::jsonb,
  'b',
  'Slope-intercept form: $y = -\frac{4}{3}x + 4$.

Shift up 2: $y = -\frac{4}{3}x + 6$.

Set $y = 0$: $\frac{4}{3}x = 6 \implies x = 6 \times \frac{3}{4} = 4.5$.',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_64'
),

-- Q15 (sat_lid_005_65): Line through origin — find k
(
  'mcq', 'math',
  'A line passes through $(3, 7)$ and $(k, 15)$. If the line also passes through the origin $(0, 0)$, what is the value of $k$?',
  '[{"id":"a","text":"6.0"},{"id":"b","text":"6.4"},{"id":"c","text":"7.0"},{"id":"d","text":"8.2"}]'::jsonb,
  'b',
  'Slope using $(0, 0)$ and $(3, 7)$: $m = \frac{7}{3}$.

Use $(k, 15)$:

$\frac{7}{3} = \frac{15}{k} \implies 7k = 45 \implies k = \frac{45}{7} \approx 6.43$',
  'algebra', 'medium', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_65'
),

-- Q16 (sat_lid_005_66): Perpendicular system — find p²+q²
-- Note: elegant property (p²+q²)(x²+y²) = 100+400=500 used instead of messy original
(
  'mcq', 'math',
  'In the $xy$-plane, line $L_1$ is defined by $px + qy = 10$, and line $L_2$ is defined by $qx - py = 20$, where $p$ and $q$ are constants. If the two lines intersect at the point $(4, 2)$, what is the value of $p^2 + q^2$?',
  '[{"id":"a","text":"20"},{"id":"b","text":"25"},{"id":"c","text":"50"},{"id":"d","text":"100"}]'::jsonb,
  'b',
  'Square both equations and add:

$(px + qy)^2 + (qx - py)^2 = 10^2 + 20^2$

Expanding the left side:

$p^2x^2 + 2pqxy + q^2y^2 + q^2x^2 - 2pqxy + p^2y^2$

$= (p^2 + q^2)(x^2 + y^2)$

So: $(p^2 + q^2)(x^2 + y^2) = 100 + 400 = 500$.

At intersection point $(4, 2)$: $x^2 + y^2 = 16 + 4 = 20$.

$(p^2 + q^2)(20) = 500 \implies p^2 + q^2 = 25$',
  'algebra', 'hard', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_66'
),

-- Q17 (sat_lid_005_67): Reflection across x-axis — x-intercept unchanged
(
  'mcq', 'math',
  'Line $k$ has a slope of $\frac{2}{3}$ and passes through $(6, 4)$. Line $m$ is the reflection of line $k$ across the $x$-axis. What is the $x$-intercept of line $m$?',
  '[{"id":"a","text":"$(-6, 0)$"},{"id":"b","text":"$(0, 0)$"},{"id":"c","text":"$(6, 0)$"},{"id":"d","text":"$(12, 0)$"}]'::jsonb,
  'b',
  'Equation of line $k$: $y - 4 = \frac{2}{3}(x - 6) \implies y = \frac{2}{3}x$.

$x$-intercept of $k$: set $y = 0 \implies x = 0$. So $k$ passes through the origin.

Reflecting across the $x$-axis maps $(x, y) \to (x, -y)$. Points on the $x$-axis (including the origin) are unchanged.

Therefore the $x$-intercept of line $m$ is also $(0, 0)$.',
  'algebra', 'hard', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_67'
),

-- Q18 (sat_lid_005_68): Literal slope with constraints
(
  'mcq', 'math',
  'Line $L$ passes through the points $(0, b)$ and $(a, c)$ in the $xy$-plane, where $a > 0$ and $0 < c < b$. The slope of line $L$ is $m$. Which of the following must be true?',
  '[{"id":"a","text":"$m < -1$"},{"id":"b","text":"$-1 < m < 0$"},{"id":"c","text":"$m = \\frac{c - b}{a}$"},{"id":"d","text":"$m = \\frac{b - c}{a}$"}]'::jsonb,
  'c',
  'Using the slope formula with $(0, b)$ and $(a, c)$:

$m = \frac{c - b}{a - 0} = \frac{c - b}{a}$

Since $c < b$, the numerator is negative, and since $a > 0$, $m$ is negative. Option C gives the exact algebraic definition.',
  'algebra', 'hard', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_68'
),

-- Q19 (sat_lid_005_69): Triangle area from intercepts
(
  'mcq', 'math',
  'A line in the $xy$-plane is defined by $3x + 4y = 24$. This line, along with the $x$-axis and the $y$-axis, encloses a triangular region. What is the area of this region?',
  '[{"id":"a","text":"12"},{"id":"b","text":"24"},{"id":"c","text":"48"},{"id":"d","text":"96"}]'::jsonb,
  'b',
  '$x$-intercept (set $y = 0$): $3x = 24 \implies x = 8$. Base = 8.

$y$-intercept (set $x = 0$): $4y = 24 \implies y = 6$. Height = 6.

Area $= \frac{1}{2} \times 8 \times 6 = 24$',
  'algebra', 'easy', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_69'
),

-- Q20 (sat_lid_005_70): Shift line left and up — find new y-intercept
(
  'mcq', 'math',
  'Line $j$ has an $x$-intercept of $(8, 0)$ and a $y$-intercept of $(0, -4)$. If line $k$ is defined by the equation of line $j$ shifted 3 units left and 2 units up, what is the $y$-intercept of line $k$?',
  '[{"id":"a","text":"$(0, -1.5)$"},{"id":"b","text":"$(0, -0.5)$"},{"id":"c","text":"$(0, 0.5)$"},{"id":"d","text":"$(0, 1.5)$"}]'::jsonb,
  'b',
  'Slope of $j$: $m = \frac{-4 - 0}{0 - 8} = 0.5$. Equation: $y = 0.5x - 4$.

Shift 3 left (replace $x$ with $x + 3$) and 2 up (add 2):

$y = 0.5(x + 3) - 4 + 2$

At $x = 0$: $y = 0.5(3) - 2 = 1.5 - 2 = -0.5$',
  'algebra', 'hard', 0, 0,
  'Linear equations in two variables', 'Graphing Linear Equations',
  'sat_lid_005_70'
);

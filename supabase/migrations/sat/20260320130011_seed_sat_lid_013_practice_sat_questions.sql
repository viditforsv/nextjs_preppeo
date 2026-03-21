-- Practice-mode math from lid_013.tex (sat_lid_013)
-- Chapter: Linear functions: slope, intercepts, graphs
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_013_N, practice module/set 0.
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
  'A scientist is tracking the population of a specific type of bacteria in a controlled environment. The population $P$ can be modeled by the equation $P = 150t + 2,000$, where $t$ is the number of hours since the start of the observation. Which of the following is the best interpretation of the number 150 in this context?',
  '[{"id":"a","text":"The initial number of bacteria when the observation began."},{"id":"b","text":"The number of hours it takes for the population to reach 2,000."},{"id":"c","text":"The increase in the number of bacteria each hour."},{"id":"d","text":"The total number of bacteria after 150 hours."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In a linear model $y = mx + b$, the slope $m$ represents the rate of change—how much the dependent variable ($P$) changes for every one unit of the independent variable ($t$).

\\textbf{Calculation and Logic:}

$P = 150t + 2,000$.

The coefficient of $t$ is 150. Since $t$ is measured in hours, 150 represents the rate of increase per hour.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_1'
),
  (
  'mcq',
  'math',
  'A car’s value depreciates linearly over time. The value $V$, in dollars, of a certain car $t$ years after it was purchased is given by $V = 28,500 - 2,100t$. What is the best interpretation of 28,500 in this context?',
  '[{"id":"a","text":"The value of the car after 1 year."},{"id":"b","text":"The amount the car''s value decreases each year."},{"id":"c","text":"The number of years until the car has no value."},{"id":"d","text":"The value of the car at the time of purchase."}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The $y$-intercept ($b$) represents the "starting" or "initial" value when the time ($t$) is 0.

\\textbf{Calculation and Logic:}

At the time of purchase, $t = 0$.

$V = 28,500 - 2,100(0) = 28,500$.

This is the original price of the car.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_2'
),
  (
  'mcq',
  'math',
  'A water tank holds 1,200 gallons of water and is being drained at a constant rate. After 5 hours, the tank contains 950 gallons. Which of the following linear functions represents the amount of water $W$, in gallons, remaining in the tank after $t$ hours?',
  '[{"id":"a","text":"$W = 1,200 - 50t$"},{"id":"b","text":"$W = 1,200 - 250t$"},{"id":"c","text":"$W = 950 - 50t$"},{"id":"d","text":"$W = 1,200 - 5t$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

First, find the rate of change (slope). The rate is the change in water divided by the change in time. Since it is being drained, the rate will be negative.

\\textbf{Calculation and Logic:}

Change in water = $950 - 1,200 = -250$ gallons.

Change in time = 5 hours.

Rate = $-250 / 5 = -50$ gallons per hour.

Initial amount ($b$) = 1,200.

Equation: $W = 1,200 - 50t$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_3'
),
  (
  'mcq',
  'math',
  'A construction worker’s total daily pay $P$, in dollars, is given by $P = 25h + 40$, where $h$ is the number of hours worked. The constant 40 represents a travel stipend. If the worker’s hourly rate increases by 5, what will be the new equation for the worker’s daily pay?',
  '[{"id":"a","text":"$P = 25h + 45$"},{"id":"b","text":"$P = 30h + 40$"},{"id":"c","text":"$P = 30h + 45$"},{"id":"d","text":"$P = 5h + 40$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The hourly rate is the slope of the linear function. Increasing the "rate" means adding to the coefficient of $h$.

\\textbf{Calculation and Logic:}

Original rate = 25.

New rate = $25 + 5 = 30$.

The fixed stipend (y-intercept) remains 40.

New Equation: $P = 30h + 40$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_013_4'
),
  (
  'mcq',
  'math',
  'The graph above shows the temperature $T$, in degrees Celsius, of a heated liquid as it cools over time $m$, in minutes. Based on the graph, which of the following is true?',
  '[{"id":"a","text":"The liquid cools at a rate of 20 degrees per minute."},{"id":"b","text":"The initial temperature was 40 degrees Celsius."},{"id":"c","text":"The liquid cools at a rate of 5 degrees per minute."},{"id":"d","text":"It will take 10 minutes for the liquid to reach 0 degrees."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Determine the slope from the graph. The slope represents the cooling rate.

\\textbf{Calculation and Logic:}

Initial point: $(0, 60)$. After 4 minutes: $(4, 40)$.

Change in Temp = $40 - 60 = -20$.

Change in time = 4 minutes.

Rate = $-20 / 4 = -5$ degrees per minute.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_5'
),
  (
  'mcq',
  'math',
  'A hiker is climbing a mountain at a constant rate. Their elevation $E$, in feet, $h$ hours after they started is given by $E = 800h + 1,200$. What was the hiker’s elevation when they started?',
  '[{"id":"a","text":"0 feet"},{"id":"b","text":"800 feet"},{"id":"c","text":"1,200 feet"},{"id":"d","text":"2,000 feet"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

"When they started" corresponds to $h = 0$.

\\textbf{Calculation and Logic:}

$E = 800(0) + 1,200 = 1,200$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_6'
),
  (
  'mcq',
  'math',
  'A library has 5,000 books and adds $n$ new books each month. After 12 months, the library has 5,720 books. What is the value of $n$?',
  '[{"id":"a","text":"60"},{"id":"b","text":"72"},{"id":"c","text":"120"},{"id":"d","text":"572"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The total increase over a period of time is the rate multiplied by the time. Set up a linear equation to solve for the rate $n$.

\\textbf{Calculation and Logic:}

Total books = Initial + (Rate $×$ Months)

$5,720 = 5,000 + n(12)$

$720 = 12n$

$n = 60$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_7'
),
  (
  'mcq',
  'math',
  'A smartphone battery charges at a constant rate. The battery percentage $B$ after $m$ minutes of charging is given by $B = 0.8m + 15$. How many minutes will it take for the battery to be fully charged ($100%$)?',
  '[{"id":"a","text":"85 minutes"},{"id":"b","text":"106.25 minutes"},{"id":"c","text":"125 minutes"},{"id":"d","text":"15 minutes"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Substitute the target value for $B$ and solve for the time $m$.

\\textbf{Calculation and Logic:}

$100 = 0.8m + 15$

$85 = 0.8m$

$m = 85 / 0.8 = 106.25$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_8'
),
  (
  'mcq',
  'math',
  'The graph above shows the height $H$, in feet, of two different trees over $t$ years. Tree A is modeled by $A(t) = 1.5t + 10$ and Tree B is modeled by $B(t) = 2t + 4$. After how many years will both trees be the same height?',
  '[{"id":"a","text":"6 years"},{"id":"b","text":"10 years"},{"id":"c","text":"12 years"},{"id":"d","text":"14 years"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

When two linear models are "the same," their equations are equal. Set the two functions equal to each other and solve for $t$.

\\textbf{Calculation and Logic:}

$1.5t + 10 = 2t + 4$

$6 = 0.5t$

$t = 12$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_9'
),
  (
  'mcq',
  'math',
  'A candle is 12 inches tall and burns at a rate of 0.75 inches per hour. Which inequality represents the number of hours $h$ the candle can burn such that its height is at least 3 inches?',
  '[{"id":"a","text":"$12 - 0.75h \\\\ge 3$"},{"id":"b","text":"$12 + 0.75h \\\\le 3$"},{"id":"c","text":"$0.75h \\\\ge 3$"},{"id":"d","text":"$12 - 0.75h \\\\le 3$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The current height is the initial height minus the amount burned. "At least" translates to $\\ge$.

\\textbf{Calculation and Logic:}

Initial = 12. Amount burned = $0.75 × h$.

Height = $12 - 0.75h$.

Condition: $12 - 0.75h \\ge 3$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_10'
),
  (
  'mcq',
  'math',
  'A salesperson earns a base salary plus a commission for every car sold. The linear function $S(c) = 500c + 25,000$ represents the salesperson’s annual salary $S$, in dollars, for selling $c$ cars. If the salesperson wants to increase their annual salary by 5,000, how many more cars must they sell?',
  '[{"id":"a","text":"10"},{"id":"b","text":"50"},{"id":"c","text":"5"},{"id":"d","text":"60"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The slope (500) tells us how much the salary increases per car. Divide the target increase by the rate per car.

\\textbf{Calculation and Logic:}

Salary increase = 5,000.

Rate = 500 per car.

Cars needed = $5,000 / 500 = 10$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_11'
),
  (
  'mcq',
  'math',
  'A pool is being filled with water. The volume of water $V$, in gallons, after $m$ minutes is $V = 12m + 200$. What does the 200 represent in this context?',
  '[{"id":"a","text":"The number of gallons added to the pool each minute."},{"id":"b","text":"The time it takes for the pool to be full."},{"id":"c","text":"The amount of water already in the pool when the filling started."},{"id":"d","text":"The maximum capacity of the pool."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The constant term in a linear growth model is the initial value at time zero.

\\textbf{Calculation and Logic:}

When $m = 0$, $V = 200$. This is the starting volume.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_12'
),
  (
  'mcq',
  'math',
  'A printer has 400 sheets of paper and uses them at a rate of 8 sheets per minute. After $x$ minutes, the printer has fewer than 100 sheets left. Which inequality represents this situation?',
  '[{"id":"a","text":"$400 - 8x < 100$"},{"id":"b","text":"$400 - 8x > 100$"},{"id":"c","text":"$8x < 300$"},{"id":"d","text":"$400 + 8x < 100$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The remaining amount is initial minus (rate $×$ time). "Fewer than" means $<$.

\\textbf{Calculation and Logic:}

Initial = 400. Usage = $8x$.

Remaining = $400 - 8x$.

Inequality: $400 - 8x < 100$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_13'
),
  (
  'mcq',
  'math',
  'The graph above shows the balance of a gift card $B$ after $n$ coffee purchases. What is the cost of each coffee?',
  '[{"id":"a","text":"100"},{"id":"b","text":"10"},{"id":"c","text":"1"},{"id":"d","text":"5"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The cost of each coffee is the slope (the rate at which the balance decreases per purchase).

\\textbf{Calculation and Logic:}

Total drop = 100.

Total purchases to reach zero = 10.

Cost per purchase = $100 / 10 = 10$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_14'
),
  (
  'mcq',
  'math',
  'A subscription service costs 15 per month plus a one-time activation fee of 30. Which function gives the total cost $C$ for $m$ months of service?',
  '[{"id":"a","text":"$C(m) = 30m + 15$"},{"id":"b","text":"$C(m) = 15m + 30$"},{"id":"c","text":"$C(m) = 45m$"},{"id":"d","text":"$C(m) = 15(m + 30)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The "per month" cost is the rate (slope), and the "one-time" fee is the initial value (y-intercept).

\\textbf{Calculation and Logic:}

Rate = 15. Initial = 30.

Equation: $C = 15m + 30$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_15'
),
  (
  'mcq',
  'math',
  'The height of a candle $h$, in centimeters, after burning for $t$ minutes is $h = -0.2t + 25$. How many centimeters of the candle burn every 10 minutes?',
  '[{"id":"a","text":"0.2 cm"},{"id":"b","text":"2 cm"},{"id":"c","text":"25 cm"},{"id":"d","text":"23 cm"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The slope represents the change per one minute. To find the change for 10 minutes, multiply the slope by 10.

\\textbf{Calculation and Logic:}

Rate = 0.2 cm per minute.

For 10 minutes = $0.2 × 10 = 2$ cm.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_16'
),
  (
  'mcq',
  'math',
  'A car travels at a constant speed of 65 miles per hour. The distance $D$ from its destination after $t$ hours is $D = 325 - 65t$. What does the 325 represent?',
  '[{"id":"a","text":"The total time of the trip."},{"id":"b","text":"The speed of the car."},{"id":"c","text":"The total distance of the trip when $t=0$."},{"id":"d","text":"The distance traveled after 1 hour."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In a decay or distance-remaining model, the constant term is the initial distance from the goal.

\\textbf{Calculation and Logic:}

When $t = 0$, $D = 325$. This is the starting distance.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_17'
),
  (
  'mcq',
  'math',
  'An athlete''s weight $W$, in pounds, after $x$ weeks of a training program is $W = 195 - 1.5x$. How many weeks will it take the athlete to reach 180 pounds?',
  '[{"id":"a","text":"10 weeks"},{"id":"b","text":"15 weeks"},{"id":"c","text":"1.5 weeks"},{"id":"d","text":"12 weeks"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Substitute the target weight for $W$ and solve for $x$.

\\textbf{Calculation and Logic:}

$180 = 195 - 1.5x$

$-15 = -1.5x$

$x = 10$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_18'
),
  (
  'mcq',
  'math',
  'A business''s profit $P$ increases by 2,000 for every additional 100 units sold. If the profit is 10,000 when 400 units are sold, which function represents profit as a function of units $u$?',
  '[{"id":"a","text":"$P(u) = 20u + 2,000$"},{"id":"b","text":"$P(u) = 200u + 10,000$"},{"id":"c","text":"$P(u) = 20u + 10,000$"},{"id":"d","text":"$P(u) = 20u + 8,000$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

First find the rate per unit (slope), then use the point (400, 10,000) to find the y-intercept.

\\textbf{Calculation and Logic:}

Rate = $2,000 / 100 = 20$ per unit.

$10,000 = 20(400) + b$

$10,000 = 8,000 + b → b = 2,000$.

Function: $P(u) = 20u + 2,000$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_19'
),
  (
  'mcq',
  'math',
  'A plane is descending at a constant rate. Its altitude $A$, in feet, $t$ minutes after beginning its descent is $A = 30,000 - 1,500t$. How many minutes after beginning its descent will the plane be at an altitude of 15,000 feet?',
  '[{"id":"a","text":"10 minutes"},{"id":"b","text":"15 minutes"},{"id":"c","text":"20 minutes"},{"id":"d","text":"5 minutes"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Set the altitude $A$ to 15,000 and solve for the time $t$.

\\textbf{Calculation and Logic:}

$15,000 = 30,000 - 1,500t$

$-15,000 = -1,500t$

$t = 10$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_20'
),
  (
  'mcq',
  'math',
  'The cost of renting a truck is 40 per day plus 0.50 per mile. If a person rents a truck for one day and drives $d$ miles, their total cost is $C$. If the per-mile rate increases by 20%, what is the new cost equation?',
  '[{"id":"a","text":"$C = 40 + 0.60d$"},{"id":"b","text":"$C = 48 + 0.50d$"},{"id":"c","text":"$C = 40 + 0.70d$"},{"id":"d","text":"$C = 48 + 0.60d$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The per-mile rate is the slope. Calculate the new rate by increasing the original slope by 20%.

\\textbf{Calculation and Logic:}

Original slope = 0.50.

Increase = $0.50 × 0.20 = 0.10$.

New slope = $0.50 + 0.10 = 0.60$.

Equation: $C = 40 + 0.60d$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_21'
),
  (
  'mcq',
  'math',
  'A savings account starts with 500 and 25 is deposited every week. Which of the following represents the total amount $S$ in the account after $w$ weeks?',
  '[{"id":"a","text":"$S = 500w + 25$"},{"id":"b","text":"$S = 25w + 500$"},{"id":"c","text":"$S = 525w$"},{"id":"d","text":"$S = 25(w + 500)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The starting amount is the $y$-intercept, and the weekly deposit is the slope.

\\textbf{Calculation and Logic:}

$b = 500, m = 25$.

Equation: $S = 25w + 500$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_22'
),
  (
  'mcq',
  'math',
  'A pool contains 8,000 gallons of water and is being filled at a rate of 15 gallons per minute. After how many hours will the pool contain 10,700 gallons?',
  '[{"id":"a","text":"3 hours"},{"id":"b","text":"180 hours"},{"id":"c","text":"2.5 hours"},{"id":"d","text":"45 hours"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Find the total time in minutes first, then convert that time into hours.

\\textbf{Calculation and Logic:}

Gallons to add = $10,700 - 8,000 = 2,700$.

Minutes = $2,700 / 15 = 180$ minutes.

Hours = $180 / 60 = 3$ hours.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_23'
),
  (
  'mcq',
  'math',
  'A person is paying off a 2,400 loan by making monthly payments of 150. Which function represents the remaining balance $B$ after $m$ months?',
  '[{"id":"a","text":"$B(m) = 2,400 + 150m$"},{"id":"b","text":"$B(m) = 150m - 2,400$"},{"id":"c","text":"$B(m) = 2,400 - 150m$"},{"id":"d","text":"$B(m) = 2,250m$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The balance starts at the loan amount and decreases by the payment amount each month.

\\textbf{Calculation and Logic:}

Initial = 2,400. Decrease = $150 × m$.

Equation: $B = 2,400 - 150m$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_24'
),
  (
  'mcq',
  'math',
  'A linear model $y = mx + b$ is used to predict the value of a stock. If the stock''s value increases by 4 every 5 days and was worth 50 on Day 0, what is the value of $m$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"0.8"},{"id":"d","text":"1.25"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The slope $m$ is the change in the output ($y$) per one unit of the input ($x$).

\\textbf{Calculation and Logic:}

Change in $y = 4$. Change in $x = 5$.

$m = 4 / 5 = 0.8$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_25'
),
  (
  'mcq',
  'math',
  'A delivery service uses the model $C = 2.5d + 7.5$ to calculate the delivery cost $C$, in dollars, for a distance of $d$ miles. Which of the following is a true statement based on the model?',
  '[{"id":"a","text":"The cost increases by 7.50 for every mile traveled."},{"id":"b","text":"For every 2-mile increase in distance, the cost increases by 5.00."},{"id":"c","text":"The distance must be at least 7.5 miles."},{"id":"d","text":"A delivery of 0 miles would cost 2.50."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The slope ($2.5$) represents the cost per mile. To check a 2-mile increase, multiply the slope by 2.

\\textbf{Calculation and Logic:}

Slope = 2.50 per mile.

2 miles $×$ 2.50 = 5.00.

Therefore, the cost increases by 5.00 for every 2 miles.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_26'
),
  (
  'mcq',
  'math',
  'A computer''s value $V$ decreases by 150 each year. After 3 years, the computer is worth 550. Which equation represents the value of the computer $t$ years after it was purchased?',
  '[{"id":"a","text":"$V = 150t + 550$"},{"id":"b","text":"$V = -150t + 1,000$"},{"id":"c","text":"$V = -150t + 550$"},{"id":"d","text":"$V = -150t + 400$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Use the rate of change and the given point (3, 550) to find the initial value ($y$-intercept).

\\textbf{Calculation and Logic:}

$m = -150$.

$550 = -150(3) + b$

$550 = -450 + b → b = 1,000$.

Equation: $V = -150t + 1,000$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_27'
),
  (
  'mcq',
  'math',
  'The remaining length $L$ of a yarn roll, in meters, after knitting $s$ sweaters is $L = 500 - 45s$. If a knitter has 140 meters of yarn left, how many sweaters did they knit?',
  '[{"id":"a","text":"6"},{"id":"b","text":"8"},{"id":"c","text":"10"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Substitute the remaining length for $L$ and solve for $s$.

\\textbf{Calculation and Logic:}

$140 = 500 - 45s$

$-360 = -45s$

$s = 8$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_28'
),
  (
  'mcq',
  'math',
  'Two companies offer internet plans. Plan A costs 50 per month. Plan B costs 20 per month plus 0.10 for every gigabyte $g$ of data used. For what amount of data is Plan B more expensive than Plan A?',
  '[{"id":"a","text":"$g > 300$"},{"id":"b","text":"$g < 300$"},{"id":"c","text":"$g > 700$"},{"id":"d","text":"$g < 700$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Set up an inequality where the expression for Plan B is greater than Plan A.

\\textbf{Calculation and Logic:}

Plan B: $20 + 0.10g$. Plan A: 50.

$20 + 0.10g > 50$

$0.10g > 30$

$g > 300$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_29'
),
  (
  'mcq',
  'math',
  'The height of a stack of $n$ identical books is $H = 2.5n + 1$. What does the 1 represent in this context?',
  '[{"id":"a","text":"The thickness of each book."},{"id":"b","text":"The total height of the stack."},{"id":"c","text":"The thickness of the bottom cover or a base."},{"id":"d","text":"The weight of one book."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The $y$-intercept represents the height when the number of books is zero.

\\textbf{Calculation and Logic:}

When $n=0$, $H=1$. This suggests a constant thickness added to the stack regardless of the number of books.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_30'
),
  (
  'mcq',
  'math',
  'A car rental company charges 45 per day. Another company charges 25 per day plus 0.25 per mile. If a person rents a car for one day, at what mileage $m$ will the costs be equal?',
  '[{"id":"a","text":"80 miles"},{"id":"b","text":"100 miles"},{"id":"c","text":"180 miles"},{"id":"d","text":"280 miles"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Set the two cost equations equal to each other.

\\textbf{Calculation and Logic:}

$45 = 25 + 0.25m$

$20 = 0.25m$

$m = 20 / 0.25 = 80$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_31'
),
  (
  'mcq',
  'math',
  'An ice block weighs 100 lbs and melts at a rate of 4 lbs per hour. Which function represents the weight $W$ after $h$ hours?',
  '[{"id":"a","text":"$W = 100 + 4h$"},{"id":"b","text":"$W = 4h - 100$"},{"id":"c","text":"$W = 100 - 4h$"},{"id":"d","text":"$W = 96h$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Melting implies a decrease in weight over time (negative slope).

\\textbf{Calculation and Logic:}

Initial = 100. Rate = $-4$.

Equation: $W = 100 - 4h$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_32'
),
  (
  'mcq',
  'math',
  'A balloon is being inflated. Its volume $V$, in cubic inches, $t$ seconds after inflation starts is $V = 15t + 10$. If the maximum volume is 400 cubic inches, what is the maximum value of $t$?',
  '[{"id":"a","text":"26"},{"id":"b","text":"27.3"},{"id":"c","text":"26.6"},{"id":"d","text":"25"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Set the volume to the maximum limit and solve for $t$.

\\textbf{Calculation and Logic:}

$400 = 15t + 10$

$390 = 15t$

$t = 26$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_33'
),
  (
  'mcq',
  'math',
  'A store offers a discount where the price $P$ of a jacket is $P = 120 - 5w$, where $w$ is the number of weeks it has been on the shelf. What is the original price of the jacket?',
  '[{"id":"a","text":"5"},{"id":"b","text":"115"},{"id":"c","text":"120"},{"id":"d","text":"24"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Original price corresponds to $w=0$.

\\textbf{Calculation and Logic:}

$P = 120 - 5(0) = 120$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_34'
),
  (
  'mcq',
  'math',
  'A pump can remove water from a basement at a rate of 12 gallons per minute. If the basement starts with 1,500 gallons and the pump runs for 2 hours, how many gallons of water remain?',
  '[{"id":"a","text":"1,476"},{"id":"b","text":"780"},{"id":"c","text":"60"},{"id":"d","text":"1,440"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Convert hours to minutes, calculate the total removed, and subtract from the initial amount.

\\textbf{Calculation and Logic:}

2 hours = 120 minutes.

Removed = $12 × 120 = 1,440$ gallons.

Remaining = $1,500 - 1,440 = 60$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_35'
),
  (
  'mcq',
  'math',
  'A line graph shows that for every 3 units increase in $x$, $y$ increases by 12 units. If the line passes through $(0, 5)$, what is the linear model for $y$?',
  '[{"id":"a","text":"$y = 3x + 5$"},{"id":"b","text":"$y = 4x + 5$"},{"id":"c","text":"$y = 12x + 5$"},{"id":"d","text":"$y = \\\\frac{1}{4}x + 5$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Calculate the slope ($m$) first, then use the given $y$-intercept.

\\textbf{Calculation and Logic:}

$m = 12 / 3 = 4$.

$b = 5$.

Equation: $y = 4x + 5$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_36'
),
  (
  'mcq',
  'math',
  'The total cost $C$ for a manufacturer to produce $n$ items is $C = 5n + 2,000$. If the manufacturer sells each item for 15, how many items must be produced and sold to break even (where cost equals revenue)?',
  '[{"id":"a","text":"100"},{"id":"b","text":"200"},{"id":"c","text":"133"},{"id":"d","text":"150"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Set Cost equal to Revenue ($15n$).

\\textbf{Calculation and Logic:}

$15n = 5n + 2,000$

$10n = 2,000$

$n = 200$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_37'
),
  (
  'mcq',
  'math',
  'The graph above shows the weight $W$, in pounds, of a puppy over $x$ weeks. If the puppy gained 2 pounds every week and started at 8 pounds, which equation matches the graph?',
  '[{"id":"a","text":"$W = 8x + 2$"},{"id":"b","text":"$W = 2x + 8$"},{"id":"c","text":"$W = 2x + 10$"},{"id":"d","text":"$W = 10x + 8$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

"Started at" is the $b$ value. "Gained every week" is the $m$ value.

\\textbf{Calculation and Logic:}

$m = 2, b = 8$.

Equation: $W = 2x + 8$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_38'
),
  (
  'mcq',
  'math',
  'A hiker descends from an elevation of 5,000 feet at a rate of 250 feet per hour. Which function gives the elevation $E$ after $h$ hours?',
  '[{"id":"a","text":"$E = 250h - 5,000$"},{"id":"b","text":"$E = 5,000 - 250h$"},{"id":"c","text":"$E = 5,000 + 250h$"},{"id":"d","text":"$E = 5,000h - 250$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Initial elevation is high and decreases over time.

\\textbf{Calculation and Logic:}

Initial = 5,000. Rate = $-250$.

Equation: $E = 5,000 - 250h$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_39'
),
  (
  'mcq',
  'math',
  'A subscription box service charges 20 for the first box and 15 for each subsequent box. Which equation gives the total cost $C$ for $n$ boxes?',
  '[{"id":"a","text":"$C = 15n + 20$"},{"id":"b","text":"$C = 15(n - 1) + 20$"},{"id":"c","text":"$C = 20n + 15$"},{"id":"d","text":"$C = 35n$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The 20 only applies once. The 15 applies to the remaining ($n-1$) boxes.

\\textbf{Calculation and Logic:}

$C = 20 + 15(n - 1)$.

(This simplifies to $15n + 5$, but Choice B is the correct setup).',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_40'
),
  (
  'mcq',
  'math',
  'The amount of snow on the ground $S$ is modeled by $S = 2t + 4$ during a storm. If the storm lasts from 10:00 AM to 4:00 PM, what is the total increase in snow?',
  '[{"id":"a","text":"4 inches"},{"id":"b","text":"6 inches"},{"id":"c","text":"12 inches"},{"id":"d","text":"16 inches"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Total increase is the rate multiplied by the total duration.

\\textbf{Calculation and Logic:}

Duration: 10 AM to 4 PM = 6 hours.

Rate = 2 inches per hour.

Increase = $2 × 6 = 12$ inches.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_41'
),
  (
  'mcq',
  'math',
  'A scientist finds that the temperature $T$ of a sample drops 3 degrees every minute. If the starting temperature was 75 degrees, what is the temperature after 10 minutes?',
  '[{"id":"a","text":"72 degrees"},{"id":"b","text":"45 degrees"},{"id":"c","text":"30 degrees"},{"id":"d","text":"105 degrees"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Calculate the total drop and subtract it from the initial temperature.

\\textbf{Calculation and Logic:}

Drop = $3 × 10 = 30$.

$75 - 30 = 45$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_42'
),
  (
  'mcq',
  'math',
  'A company''s revenue $R$ is modeled by $R = 100x$ and its costs $C$ are $C = 40x + 1,200$. What is the profit equation ($P = R - C$)?',
  '[{"id":"a","text":"$P = 60x + 1,200$"},{"id":"b","text":"$P = 60x - 1,200$"},{"id":"c","text":"$P = 140x + 1,200$"},{"id":"d","text":"$P = 140x - 1,200$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Subtract the entire cost expression from the revenue expression.

\\textbf{Calculation and Logic:}

$P = 100x - (40x + 1,200)$

$P = 100x - 40x - 1,200$

$P = 60x - 1,200$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_43'
),
  (
  'mcq',
  'math',
  'A car fuel tank holds 15 gallons. The car uses 0.04 gallons per mile. Which equation gives the gallons $G$ remaining after $m$ miles?',
  '[{"id":"a","text":"$G = 0.04m - 15$"},{"id":"b","text":"$G = 15 + 0.04m$"},{"id":"c","text":"$G = 15 - 0.04m$"},{"id":"d","text":"$G = 15.04m$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Fuel decreases with distance.

\\textbf{Calculation and Logic:}

Initial = 15. Rate = $-0.04$.

Equation: $G = 15 - 0.04m$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_44'
),
  (
  'mcq',
  'math',
  'Line A has a growth rate of 10 units per day. Line B has a growth rate of 5 units per day but starts with 50 units. If Line A starts with 0 units, on what day will Line A exceed Line B?',
  '[{"id":"a","text":"Day 5"},{"id":"b","text":"Day 10"},{"id":"c","text":"Day 11"},{"id":"d","text":"Day 20"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Set the inequality $A > B$.

\\textbf{Calculation and Logic:}

Line A: $10d$. Line B: $5d + 50$.

$10d > 5d + 50$

$5d > 50$

$d > 10$.

The first day it exceeds is Day 11.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_45'
),
  (
  'mcq',
  'math',
  'A plumber charges 50 for the first hour and 35 for each additional hour. Which model represents the total cost $C$ for $h$ hours ($h \\ge 1$)?',
  '[{"id":"a","text":"$C = 35h + 50$"},{"id":"b","text":"$C = 35(h - 1) + 50$"},{"id":"c","text":"$C = 50h + 35$"},{"id":"d","text":"$C = 85h$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The 50 is only for the first hour. Subsequent hours are charged at the lower rate.

\\textbf{Calculation and Logic:}

$C = 50 + 35(h - 1)$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_46'
),
  (
  'mcq',
  'math',
  'If the value of an asset $V$ is modeled by $V = 50,000 - 4,000t$, how many years will it take for the asset to lose half of its original value?',
  '[{"id":"a","text":"6.25 years"},{"id":"b","text":"12.5 years"},{"id":"c","text":"5 years"},{"id":"d","text":"10 years"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Original value is 50,000. Half is 25,000. Solve for $t$.

\\textbf{Calculation and Logic:}

$25,000 = 50,000 - 4,000t$

$-25,000 = -4,000t$

$t = 6.25$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_47'
),
  (
  'mcq',
  'math',
  'A gardener plants a tree that is 4 feet tall. It grows 0.5 feet per year. How tall will it be after 14 years?',
  '[{"id":"a","text":"7 feet"},{"id":"b","text":"11 feet"},{"id":"c","text":"18 feet"},{"id":"d","text":"9 feet"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Total growth = rate $×$ time. Add this to the starting height.

\\textbf{Calculation and Logic:}

Growth = $0.5 × 14 = 7$.

$4 + 7 = 11$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_48'
),
  (
  'mcq',
  'math',
  'A data plan charges a flat fee of 40 and 10 for every GB over 5 GB. If a customer''s bill was 90, how many total GB did they use?',
  '[{"id":"a","text":"5 GB"},{"id":"b","text":"9 GB"},{"id":"c","text":"10 GB"},{"id":"d","text":"14 GB"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Determine how much was paid in overage fees, calculate the overage GB, and add to the base 5 GB.

\\textbf{Calculation and Logic:}

Overage fees = $90 - 40 = 50$.

Overage GB = $50 / 10 = 5$.

Total GB = $5 (\\text{base}) + 5 (\\text{overage}) = 10$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_013_49'
),
  (
  'mcq',
  'math',
  'An airplane descends from 35,000 feet to 5,000 feet in 15 minutes. What is its constant rate of descent in feet per minute?',
  '[{"id":"a","text":"1,000"},{"id":"b","text":"2,000"},{"id":"c","text":"3,000"},{"id":"d","text":"2,333"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Rate is total change divided by total time.

\\textbf{Calculation and Logic:}

Change = $35,000 - 5,000 = 30,000$ feet.

Time = 15 minutes.

Rate = $30,000 / 15 = 2,000$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_013_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

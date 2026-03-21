-- Practice-mode math from lid_033.tex (sat_lid_033)
-- Chapter: Percentages and percentage change | Topic: Simple & Compound Interest
-- sat_questions: section=math, domain=problem-solving, bank_item_id=sat_lid_033_N, practice module/set 0.

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
  'Jeremy deposited $x$ dollars in an investment account on January 1, 2001. The amount of money in the account doubled each year until Jeremy had $480$ in his account on January 1, 2005. Which of the following equations represents the value of the account $V$, in dollars, $t$ years after January 1, 2001?',
  '[{"id":"a","text":"$V = x+ 2t$"},{"id":"b","text":"$V = x(2)^t$"},{"id":"c","text":"$V = 2x^t$"},{"id":"d","text":"$V = x(t)^2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When a quantity increases by a constant multiplier (in this case, doubling) over equal time intervals, it represents exponential growth. The standard formula for this is $V = P(r)^t$, where $P$ is the initial amount and $r$ is the growth factor.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the starting value:} The initial deposit is $x$ dollars.

2. \\textbf{Identify the growth factor:} "Doubled each year" means the multiplier is 2.

3. \\textbf{Formulate the equation:}

* After 1 year: $x \\cdot 2$

* After 2 years: $(x \\cdot 2) \\cdot 2 = x(2)^2$

* After $t$ years: $V = x(2)^t$',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_1',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'Thomas installed a new stove in his restaurant with an initial value of $800$. He estimates that each year the value of the stove will depreciate by 20% of the previous year’s estimated value. What is the estimated value of the stove exactly 2 years after installation?',
  '[{"id":"a","text":"$480$"},{"id":"b","text":"$512$"},{"id":"c","text":"$556$"},{"id":"d","text":"$640$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Depreciation that is calculated based on the "previous year''s value" follows an exponential decay model. Each year, the value is multiplied by a constant decay factor $(1 - \\text{rate})$.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the decay factor:} A 20% decrease means 80% of the value remains. Multiplier = $0.80$.

2. \\textbf{Calculate Year 1:} $800 × 0.80 = 640$.

3. \\textbf{Calculate Year 2:} $640 × 0.80 = 512$.

Alternatively: $V = 800(0.80)^2 = 800(0.64) = 512$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_2',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'An investment of $2,000 earns interest at a constant annual rate. If the account balance is $2,100 after exactly one year, what will the balance be, in dollars, after three years if no additional deposits or withdrawals are made and the account earns simple interest?',
  NULL,
  '2300',
  '\\textbf{Conceptual Explanation:}

Simple interest is calculated only on the initial principal. The amount of interest earned each year remains constant.

\\textbf{Calculation and Logic:}

1. \\textbf{Find annual interest:} $2100 - 2000 = 100$ dollars per year.

2. \\textbf{Calculate total interest for 3 years:} $100 × 3 = 300$.

3. \\textbf{Find final balance:} $2000 (\\text{Principal}) + 300 (\\text{Interest}) = 2300$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_3',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'Jeremy deposited $x$ dollars in his investment account. The amount doubled each year until he had $480$ in the account after 4 years. What is the value of $x$?',
  NULL,
  '30',
  '\\textbf{Conceptual Explanation:}

To find the initial value in an exponential growth problem, you can work backward from the final amount by performing the inverse operation (halving instead of doubling) for each time period.

\\textbf{Calculation and Logic:}

1. \\textbf{Value at 4 years:} $480.

2. \\textbf{Value at 3 years:} $480 / 2 = 240$.

3. \\textbf{Value at 2 years:} $240 / 2 = 120$.

4. \\textbf{Value at 1 year:} $120 / 2 = 60$.

5. \\textbf{Initial Value (0 years):} $60 / 2 = 30.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_4',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'The value of a collectible item increased by 167% from the end of 2011 to the end of 2012, and then decreased by 16% from the end of 2012 to the end of 2013. Which of the following represents the net percentage increase in value from 2011 to 2013?',
  '[{"id":"a","text":"124.28%"},{"id":"b","text":"140.28%"},{"id":"c","text":"151.00%"},{"id":"d","text":"224.28%"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Successive percentage changes are multiplicative. An increase of 167% corresponds to a multiplier of 2.67, and a decrease of 16% corresponds to a multiplier of 0.84.

\\begin{center}

\\begin{tikzpicture}[node distance=3cm, auto]

\\node (p1) [draw, circle] {2011};

\\node (p2) [draw, circle, right of=p1] {2012};

\\node (p3) [draw, circle, right of=p2] {2013};

\\draw[->, thick] (p1) -- node {+167%} (p2);

\\draw[->, thick] (p2) -- node {-16%} (p3);

\\end{tikzpicture}

\\end{center}

\\textbf{Calculation and Logic:}

1. \\textbf{Combined multiplier:} $2.67 × 0.84 = 2.2428$.

2. \\textbf{Convert to percentage:} $(2.2428 - 1) × 100 = 124.28%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_5',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to increasing a quantity by 110%?',
  '[{"id":"a","text":"Multiplying by 0.11"},{"id":"b","text":"Multiplying by 1.10"},{"id":"c","text":"Multiplying by 2.10"},{"id":"d","text":"Multiplying by 110"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A percent increase represents the original 100% plus the additional percentage. Therefore, an increase of 110% results in 210% of the original amount.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_6',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'The number $w$ is 110% greater than the number $z$. The number $z$ is 55% less than 50. What is the value of $w$?',
  NULL,
  '47.25',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Calculate z:} $50 × (1 - 0.55) = 50 × 0.45 = 22.5$.

2. \\textbf{Calculate w:} $22.5 × (1 + 1.10) = 22.5 × 2.10 = 47.25$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_7',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'During a sale, the original prices of all items in a clothing store have been reduced by 20 percent. What is the sale price of a jacket with an original price of $50$?',
  '[{"id":"a","text":"$12$"},{"id":"b","text":"$30$"},{"id":"c","text":"$36$"},{"id":"d","text":"$40$"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Multiplier:} $1 - 0.20 = 0.80$.

2. \\textbf{Sale Price:} $50 × 0.80 = 40$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_8',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'The regular price of a shirt is $11.70$. The sale price is 80 percent less than the regular price, and the sale price is 30 percent greater than the store''s cost for the shirt. What was the store''s cost, in dollars, for the shirt?',
  NULL,
  '1.80',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Find sale price (S):} $11.70 × (1 - 0.80) = 11.70 × 0.20 = 2.34$.

2. \\textbf{Find cost (C):} $2.34 = C × (1 + 0.30) → 2.34 = 1.3C$.

3. \\textbf{Solve for C:} $C = 2.34 / 1.3 = 1.80$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_9',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  '37% of the items in a box are green. Of those, 37% are rectangular. Of the green rectangular items, 42% are metal. Which of the following is closest to the percentage of total items in the box that are NOT rectangular green metal items?',
  '[{"id":"a","text":"1.16%"},{"id":"b","text":"57.50%"},{"id":"c","text":"94.25%"},{"id":"d","text":"98.84%"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Percentage of green rectangular metal items:} $0.37 × 0.37 × 0.42 \\approx 0.0575$ (or 5.75%).

2. \\textbf{Percentage of items NOT in this group:} $100% - 5.75% = 94.25%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_10',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'The population of City A increased by 7% from 2015 to 2016. If the 2016 population is $k$ times the 2015 population, what is the value of $k$?',
  '[{"id":"a","text":"0.07"},{"id":"b","text":"0.7"},{"id":"c","text":"1.07"},{"id":"d","text":"1.7"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

An increase of 7% means the new value is $100% + 7% = 107%$ of the old value. In decimal form, this multiplier $k$ is 1.07.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_11',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'A bank account earns 2% interest compounded annually. If the initial deposit is $5,000, how much interest is earned after 2 years?',
  NULL,
  '202',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Total balance after 2 years:} $5000 × (1.02)^2 = 5000 × 1.0404 = 5202$.

2. \\textbf{Interest earned:} $5202 - 5000 = 202$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_12',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'What is 23% of 100?',
  '[{"id":"a","text":"23"},{"id":"b","text":"46"},{"id":"c","text":"77"},{"id":"d","text":"123"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

By definition, "percent" means "per hundred." Thus, 23% of 100 is exactly 23.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_13',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'If 80% of $x$ is 160, what is $x$?',
  '[{"id":"a","text":"128"},{"id":"b","text":"160"},{"id":"c","text":"200"},{"id":"d","text":"800"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$0.80x = 160 → x = 160 / 0.80 = 200$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_14',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'Which of the following describes the difference between simple and compound interest?',
  '[{"id":"a","text":"Simple interest is constant addition; compound is constant multiplication."},{"id":"b","text":"Simple interest is only on the principal; compound is on principal and accumulated interest."},{"id":"c","text":"Simple interest is linear growth; compound interest is exponential growth."},{"id":"d","text":"All of the above."}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Simple interest grows by the same dollar amount each year (linear). Compound interest grows by an increasing dollar amount because it calculates interest on the new total each year (exponential).',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_15',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'A startup''s valuation was $1,000,000$. It increased by 50 percent in the first year and then decreased by 50 percent in the second year. What is the valuation after 2 years?',
  NULL,
  '750000',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Year 1:} $1,000,000 × 1.5 = 1,500,000$.

2. \\textbf{Year 2:} $1,500,000 × 0.5 = 750,000$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_16',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'If a stock price increases from $40 to $50, what is the percent increase?',
  '[{"id":"a","text":"10%"},{"id":"b","text":"20%"},{"id":"c","text":"25%"},{"id":"d","text":"80%"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$\\text{Increase} = 50 - 40 = 10$.

$\\text{Percent Increase} = (10 / 40) × 100 = 25%$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_17',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'If the expression $P(1.12)^t$ represents an account balance, what is the annual interest rate?',
  '[{"id":"a","text":"1.12%"},{"id":"b","text":"12%"},{"id":"c","text":"112%"},{"id":"d","text":"$12$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

The growth factor is $1 + r = 1.12$, so $r = 0.12$. In percentage form, this is 12%.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_18',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'A car depreciates by 10% each year. If it is currently worth $20,000, how many years will it take for the value to drop below $15,000?',
  NULL,
  '3',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Year 1:} $20000 × 0.9 = 18000$.

2. \\textbf{Year 2:} $18000 × 0.9 = 16200$.

3. \\textbf{Year 3:} $16200 × 0.9 = 14580$. (Below 15,000).',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_19',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'If you invest $1,000$ at 5 percent annual simple interest, how much will you have after 10 years?',
  '[{"id":"a","text":"$1,050$"},{"id":"b","text":"$1,500$"},{"id":"c","text":"$1,628$"},{"id":"d","text":"$2,000$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Interest per year:} $1000 × 0.05 = 50$.

2. \\textbf{Total interest (10 years):} $50 × 10 = 500$.

3. \\textbf{Total balance:} $1000 + 500 = 1500$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_20',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'A store marks up a wholesale price of $20$ by 50 percent to get the retail price. What is the retail price?',
  '[{"id":"a","text":"$10$"},{"id":"b","text":"$25$"},{"id":"c","text":"$30$"},{"id":"d","text":"$40$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$20 × (1 + 0.50) = 20 × 1.5 = 30$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_21',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'If 120% of a number is 54, what is the number?',
  NULL,
  '45',
  '\\textbf{Calculation and Logic:}

$1.20x = 54 → x = 54 / 1.2 = 45$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_22',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'An investment doubles in value every 8 years. Which type of function best models this growth?',
  '[{"id":"a","text":"Linear"},{"id":"b","text":"Quadratic"},{"id":"c","text":"Exponential"},{"id":"d","text":"Square root"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Growth defined by a constant doubling time is a classic example of exponential growth.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_23',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'An account starts with $100$ and earns 10 percent interest compounded annually. How much interest is earned in the second year?',
  NULL,
  '11',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Year 1 interest:} $100 × 0.1 = 10$. (Balance = 110).

2. \\textbf{Year 2 interest:} $110 × 0.1 = 11$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_24',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'A piece of furniture originally costs 200. It is on sale for 15 percent off. What is the sale price?',
  '[{"id":"a","text":"$30$"},{"id":"b","text":"$170$"},{"id":"c","text":"$185$"},{"id":"d","text":"$230$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$200 × (1 - 0.15) = 200 × 0.85 = 170$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_25',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'An investment account was opened with an initial deposit of 5,000. The account earns 4% annual interest compounded semi-annually. What is the total balance in the account, to the nearest dollar, after 3 years if no further deposits or withdrawals are made?',
  NULL,
  '5631',
  '\\textbf{Conceptual Explanation:}

When interest is compounded more than once a year, we use the formula $A = P(1 + (r)/(n))^{nt}$. Here, $n$ represents the number of times interest is compounded per year. For semi-annual compounding, $n=2$.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify variables:} $P = 5000$, $r = 0.04$, $n = 2$, $t = 3$.

2. \\textbf{Set up the formula:}

\\[ A = 5000(1 + (0.04)/(2))^{2 × 3} \\]

3. \\textbf{Simplify the expression:}

$A = 5000(1.02)^6$

4. \\textbf{Calculate the final value:}

$A \\approx 5000(1.12616) \\approx 5630.8$

Rounding to the nearest dollar gives 5,631.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_26',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'Which of the following functions models the balance $B$ of an account that starts with 1,200 and earns 1.5% annual simple interest for $t$ years?',
  '[{"id":"a","text":"$B = 1200(1.015)^t$"},{"id":"b","text":"$B = 1200 + 18t$"},{"id":"c","text":"$B = 1200 + 1.5t$"},{"id":"d","text":"$B = 1200(0.015)t$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Simple interest grows linearly. The interest added each year is a fixed amount based solely on the original principal.

\\textbf{Calculation and Logic:}

1. \\textbf{Calculate annual interest:}

1,200 $×$ 0.015 = 18.

2. \\textbf{Formulate the linear equation:}

Balance = Principal + (Annual Interest $×$ Years)

$B = 1200 + 18t$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_27',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'An investment doubles in value every 10 years. If the initial investment is 2,500, what will be its value, in dollars, after 30 years?',
  NULL,
  '20000',
  '\\textbf{Conceptual Explanation:}

This problem represents an exponential growth pattern with a specific doubling period. You can determine the number of cycles to find the total multiplier.

\\begin{center}

\\begin{tikzpicture}[node distance=3.5cm, auto]

\\node (t0) [draw, thick, rectangle] {Year 0: 2,500};

\\node (t10) [draw, thick, rectangle, right of=t0] {Year 10: 5,000};

\\node (t20) [draw, thick, rectangle, below of=t10] {Year 20: 10,000};

\\node (t30) [draw, thick, rectangle, left of=t20] {Year 30: 20,000};

\\draw[->, ultra thick] (t0) -- node {$× 2$} (t10);

\\draw[->, ultra thick] (t10) -- node {$× 2$} (t20);

\\draw[->, ultra thick] (t20) -- node {$× 2$} (t30);

\\end{tikzpicture}

\\end{center}

\\textbf{Calculation and Logic:}

1. \\textbf{Identify cycles:} 30 years $\\div$ 10 years = 3 doubling periods.

2. \\textbf{Apply multiplier:} 2,500 $× 2^3$.

3. \\textbf{Solve:} 2,500 $×$ 8 = 20,000.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_28',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'A tech startup''s valuation increased by 40% in its first year and 50% in its second year. What was the total percentage increase in valuation over the two-year period?',
  '[{"id":"a","text":"90%"},{"id":"b","text":"100%"},{"id":"c","text":"110%"},{"id":"d","text":"210%"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Growth factors:} $1.4$ (Year 1) and $1.5$ (Year 2).

2. \\textbf{Calculate total multiplier:} $1.4 × 1.5 = 2.1$.

3. \\textbf{Convert to percentage:} $(2.1 - 1) × 100 = 110%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_29',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'A car originally worth 25,000 depreciates at a rate of 12% per year. To the nearest dollar, what is the car''s value after 5 years?',
  NULL,
  '13193',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Multiplier:} $1 - 0.12 = 0.88$.

2. \\textbf{Equation:} $V = 25000(0.88)^5$.

3. \\textbf{Solve:} $25000 × 0.52773 \\approx 13193.25$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_30',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'An account with an initial balance of P earns $r$ percent annual interest compounded monthly. Which of the following expressions represents the balance after 2 years?',
  '[{"id":"a","text":"$P(1 + \\\\frac{r}{100})^{2}$"},{"id":"b","text":"$P(1 + \\\\frac{r}{1200})^{24}$"},{"id":"c","text":"$P(1 + \\\\frac{r}{12})^{24}$"},{"id":"d","text":"$P(1 + \\\\frac{r}{12})^{2}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To convert a whole number percentage $r$ to a monthly decimal rate, divide by 100 (for decimal) and by 12 (for months), resulting in $r/1200$. Over 2 years, there are 24 compounding periods.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_31',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'How many years will it take for the interest earned on an investment to equal the original principal if the simple interest rate is 8% per year?',
  '[{"id":"a","text":"8 years"},{"id":"b","text":"10 years"},{"id":"c","text":"12.5 years"},{"id":"d","text":"25 years"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$I = Prt$. For $I = P$, then $P = P(0.08)t$.

$1 = 0.08t → t = 1 / 0.08 = 12.5$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_32',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'If 3,000 is invested at 5% compounded annually, how much more interest is earned after 2 years than if it were invested at 5% simple interest?',
  NULL,
  '7.5',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Compound:} $3000(1.05)^2 = 3307.50$ (Interest = 307.50).

2. \\textbf{Simple:} $3000 × 0.05 × 2 = 300$ interest.

3. \\textbf{Difference:} 307.50 - 300 = 7.50.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_33',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'The population of a city grows by 2% every year. If the population is $P$ now, which expression represents the population in 10 years?',
  '[{"id":"a","text":"$P + 0.02(10)$"},{"id":"b","text":"$P(1.02)^{10}$"},{"id":"c","text":"$P(0.02)^{10}$"},{"id":"d","text":"$10P(1.02)$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Population growth is compound growth. Multiplier = $1 + 0.02 = 1.02$. Balance = $P(1.02)^{10}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_34',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'A rare painting was purchased for 10,000. Every year, its value increases by exactly 500. After how many years will the painting be worth 15,000?',
  NULL,
  '10',
  '\\textbf{Calculation and Logic:}

Total growth needed = 5,000.

Annual growth = 500.

Years = 5000 $\\div$ 500 = 10.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_35',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'Plan A offers 6% simple interest. Plan B offers 5% interest compounded annually. If 1,000 is invested in each, which is true after 5 years?',
  '[{"id":"a","text":"Plan A has a higher balance."},{"id":"b","text":"Plan B has a higher balance."},{"id":"c","text":"Both plans have the same balance."},{"id":"d","text":"Plan A is 100 higher than Plan B."}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Plan A:} $1000 + (1000 × 0.06 × 5) = 1,300$.

2. \\textbf{Plan B:} $1000(1.05)^5 \\approx 1,276.28$.

3. 1,300 $>$ 1,276.28.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_36',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'How much interest is earned on a 2,000 deposit at 3% simple interest over 8 months?',
  NULL,
  '40',
  '\\textbf{Calculation and Logic:}

Time in years = $8/12 = 2/3$.

Interest = $2000 × 0.03 × (2/3) = 60 × (2/3) = 40$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_37',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'The balance of an account after $t$ years is $A = 500(1.08)^t$. Which of the following shows the approximate monthly growth rate?',
  '[{"id":"a","text":"$A = 500(1.0064)^{12t}$"},{"id":"b","text":"$A = 500(1.08/12)^{12t}$"},{"id":"c","text":"$A = 500(1.0064)^{t}$"},{"id":"d","text":"$A = 500(1.09)^{t/12}$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

$(1.08)^{1/12} \\approx 1.0064$.

$A = 500((1.08)^{1/12})^{12t} = 500(1.0064)^{12t}$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_38',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'What principal is required to earn 150 in interest at 5% simple interest over 2 years?',
  NULL,
  '1500',
  '\\textbf{Calculation and Logic:}

$150 = P × 0.05 × 2 → 150 = 0.1P$.

$P = 150 ÷ 0.1 = 1500$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_39',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'An investment loses 10% of its value every month. Which function best models the value of the investment over time?',
  '[{"id":"a","text":"Linear with a positive slope"},{"id":"b","text":"Linear with a negative slope"},{"id":"c","text":"Exponential growth"},{"id":"d","text":"Exponential decay"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

A constant percentage decrease results in exponential decay.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_40',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'If 1,000 is invested at 10% compounded annually, what is the balance after 3 years?',
  NULL,
  '1331',
  '\\textbf{Calculation and Logic:}

$1000(1.10)^3 = 1000 × 1.331 = 1331$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_41',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'A loan of 400 has a monthly simple interest rate of 1%. How much interest is owed after 6 months?',
  '[{"id":"a","text":"4"},{"id":"b","text":"24"},{"id":"c","text":"44"},{"id":"d","text":"240"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Monthly interest = 400 $×$ 0.01 = 4.

6 months = 4 $×$ 6 = 24.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_42',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'A population doubles every 5 years. By what percent does the population increase each year? (Nearest tenth).',
  NULL,
  '14.9',
  '\\textbf{Calculation and Logic:}

$(1+r)^5 = 2 → 1+r = 2^{1/5} \\approx 1.1487$.

$r \\approx 0.1487 → 14.9%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_43',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'What is the effective annual rate for 4% interest compounded quarterly?',
  '[{"id":"a","text":"4%"},{"id":"b","text":"4.06%"},{"id":"c","text":"4.12%"},{"id":"d","text":"16%"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$(1 + 0.04/4)^4 = (1.01)^4 \\approx 1.0406$.

Rate = 4.06%.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_44',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'In the diagram above, which graph represents compound interest?',
  '[{"id":"a","text":"The straight line"},{"id":"b","text":"The curve"},{"id":"c","text":"Both"},{"id":"d","text":"Neither"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Compound interest earns "interest on interest," causing it to accelerate upward in a curve (exponential growth).',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_45',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'An account starts with 100 and earns 100% interest compounded annually. What is the balance after 2 years?',
  NULL,
  '400',
  '\\textbf{Calculation and Logic:}

Multiplier = 2.

$100 × 2^2 = 100 × 4 = 400$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_46',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'A car''s value is modeled by $V = 30000(0.85)^t$. What is the annual rate of depreciation?',
  '[{"id":"a","text":"0.85%"},{"id":"b","text":"15%"},{"id":"c","text":"85%"},{"id":"d","text":"30,000"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$1 - r = 0.85 → r = 0.15 = 15%$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_47',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'If a 500 investment at 4% annual simple interest reaches 600, how many years have passed?',
  NULL,
  '5',
  '\\textbf{Calculation and Logic:}

Interest = 100.

Annual Interest = 500 $×$ 0.04 = 20.

Years = 100 $\\div$ 20 = 5.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_48',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'mcq',
  'math',
  'Which factor most determines how quickly compound interest outpaces simple interest?',
  '[{"id":"a","text":"The initial principal"},{"id":"b","text":"The compounding frequency"},{"id":"c","text":"The length of time"},{"id":"d","text":"Both frequency and time"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Both the frequency of compounding and the duration of the investment amplify the exponential effect.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_033_49',
  'Percentages and percentage change',
  'Simple & Compound Interest'
),
  (
  'spr',
  'math',
  'A bank account grows from 1,000 to 1,210 in 2 years with annual compounding. What is the annual interest rate as a percentage?',
  NULL,
  '10',
  '\\textbf{Calculation and Logic:}

$1210 = 1000(1+r)^2 → 1.21 = (1+r)^2$.

$1.1 = 1+r → r = 0.1 = 10%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_033_50',
  'Percentages and percentage change',
  'Simple & Compound Interest'
)
ON CONFLICT (bank_item_id) DO NOTHING;

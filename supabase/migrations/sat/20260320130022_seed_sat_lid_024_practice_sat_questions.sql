-- Practice-mode math from lid_024.tex (sat_lid_024)
-- Chapter: Exponential functions and equations | Topic: Compound Interest & Population Growth
-- sat_questions: section=math, domain=advanced-math, bank_item_id=sat_lid_024_N, practice module/set 0.

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
  'An investment account was opened with an initial deposit of $1,000$. The account earns 5% interest compounded annually. Which of the following functions models the value $V(t)$, in dollars, of the account $t$ years after the initial deposit?',
  '[{"id":"a","text":"$V(t) = 1,000(0.05)^t$"},{"id":"b","text":"$V(t) = 1,000(1.05)^t$"},{"id":"c","text":"$V(t) = 1,000 + 0.05t$"},{"id":"d","text":"$V(t) = 1,000(1.5)^t$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Compound interest follows the exponential growth model $y = a(1 + r)^t$. The "base" of the exponent must be the growth factor, which is $1$ plus the interest rate expressed as a decimal.

\\textbf{Calculation and Logic:}

Initial deposit ($a$) = 1,000.

Interest rate ($r$) = 5% = 0.05.

Growth factor = $1 + 0.05 = 1.05$.

Substituting these into the model:

$V(t) = 1,000(1.05)^t$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_1',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'The population of a certain town is estimated to increase by 6% every year. If the population was 25,000 in 2020, what is the estimated population of the town in 2022?',
  NULL,
  '28090',
  '\\textbf{Conceptual Explanation:}

For multi-year growth, apply the growth factor repeatedly for each year that passes.

\\textbf{Calculation and Logic:}

Initial population = 25,000.

Time elapsed = $2022 - 2020 = 2$ years.

Growth factor = $1 + 0.06 = 1.06$.

Population in 2022 = $25,000 × (1.06)^2$.

$25,000 × 1.1236 = 28,090$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_2',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  '$P(t) = 4,500(1.035)^t$ The function $P$ models the population of a colony of insects $t$ weeks after an initial observation. Which of the following is the best interpretation of the value 1.035 in the function?',
  '[{"id":"a","text":"The population increases by 3.5 each week."},{"id":"b","text":"The population increases by 3.5% each week."},{"id":"c","text":"The population increases by 103.5% each week."},{"id":"d","text":"The initial population was 1,035."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In the form $y = a(b)^t$, the base $b$ represents the growth factor. If $b > 1$, the percentage growth rate is $(b - 1) × 100$.

\\textbf{Calculation and Logic:}

Base = 1.035.

Rate = $1.035 - 1 = 0.035$.

Convert to percentage: $0.035 × 100 = 3.5%$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_3',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'An amount of $P$ dollars is deposited into an account that pays $r%$ annual interest compounded annually. If no additional deposits or withdrawals are made, which of the following represents the total amount in the account after 10 years?',
  '[{"id":"a","text":"$P(1 + r)^{10}$"},{"id":"b","text":"$P(1 + \\\\frac{r}{100})^{10}$"},{"id":"c","text":"$P + 10r$"},{"id":"d","text":"$P(r)^{10}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When an interest rate is given as a percentage "r", it must be divided by 100 to be used as a decimal in an exponential growth formula.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_4',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  '$A = 500(1.02)^{4t}$ The equation above models the amount of money $A$, in dollars, in a savings account $t$ years after the initial deposit. The account earns interest compounded $n$ times per year. What is the value of $n$?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

The standard compound interest formula is $A = P(1 + (r)/(n))^{nt}$. The coefficient of $t$ in the exponent represents the number of compounding periods per year ($n$).

\\textbf{Calculation and Logic:}

In the given model $A = 500(1.02)^{4t}$, the exponent is $4t$.

Comparing this to $nt$, we see that $n = 4$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_5',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'A population of 100,000 decreases by 2% each year. Which function $P(t)$ models the population $t$ years from now?',
  '[{"id":"a","text":"$P(t) = 100,000(1.02)^t$"},{"id":"b","text":"$P(t) = 100,000(0.98)^t$"},{"id":"c","text":"$P(t) = 100,000(0.02)^t$"},{"id":"d","text":"$P(t) = 100,000 - 0.02t$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Exponential decay uses a base of $(1 - r)$. A 2% decrease results in a multiplier of $1 - 0.02 = 0.98$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_6',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'For the population function $f$, the table below shows the population $x$ years after a survey was conducted. If $f(x) = a(b)^x$, what is the value of $b$? \\begin{center} \\begin{tabular}{|c|c|} \\hline $x$ & $f(x)$ \\hline 0 & 8,000 \\hline 1 & 8,240 \\hline 2 & 8,487.2 \\hline \\end{tabular} \\end{center}',
  NULL,
  '1.03',
  '\\textbf{Conceptual Explanation:}

In an exponential function, the base $b$ is the ratio between any two consecutive output values: $b = (f(x+1))/(f(x))$.

\\textbf{Calculation and Logic:}

Use the values for $x=0$ and $x=1$:

$b = (8,240)/(8,000)$

$b = (824)/(800) = 1.03$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_7',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'The function $M(t) = 15,000(1.045)^t$ models the amount of money in a retirement account $t$ years after 2015. What was the amount of money in the account in 2015?',
  '[{"id":"a","text":"$1.045$"},{"id":"b","text":"$15,000$"},{"id":"c","text":"$15,675$"},{"id":"d","text":"$675$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The value in 2015 represents the "initial value" ($t = 0$). In the form $y = a(b)^t$, the initial value is the constant $a$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_8',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'The population of Lowell was 90,000 in 2010 and has been increasing by 4% each year. Which of the following functions best models the population of Lowell $n$ decades after 2010? (1 decade = 10 years)',
  '[{"id":"a","text":"$p(n) = 90,000(1.04)^{10n}$"},{"id":"b","text":"$p(n) = 90,000(1.04)^{\\\\frac{n}{10}}$"},{"id":"c","text":"$p(n) = 90,000(1.40)^n$"},{"id":"d","text":"$p(n) = 90,000(1.04n)^{10}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

If $t$ is years and $n$ is decades, then $t = 10n$. Substitute $10n$ for the time variable in the standard growth formula.

\\textbf{Calculation and Logic:}

Standard yearly model: $P = 90,000(1.04)^t$.

Since $t = 10n$, the decade model is:

$P = 90,000(1.04)^{10n}$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_9',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'An investment of 2,000 grows at an annual rate of 10% compounded annually. What will be the value of the investment, in dollars, after 3 years?',
  NULL,
  '2662',
  '\\textbf{Calculation and Logic:}

Year 1: $2,000 × 1.1 = 2,200$.

Year 2: $2,200 × 1.1 = 2,420$.

Year 3: $2,420 × 1.1 = 2,662$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_10',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'The population $P$ of a bacteria culture doubles every 3 hours. If the initial population is $N$, which of the following functions models the population after $t$ hours?',
  '[{"id":"a","text":"$P(t) = N(2)^{3t}$"},{"id":"b","text":"$P(t) = N(2)^{\\\\frac{t}{3}}$"},{"id":"c","text":"$P(t) = N(3)^{2t}$"},{"id":"d","text":"$P(t) = N(3)^{\\\\frac{t}{2}}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In a doubling model $y = a(2)^{(t)/(d)}$, the variable $d$ is the "doubling time." This ensures that when $t=d$, the exponent is 1 and the population has doubled once.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_11',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  '$f(t) = 300(1.21)^{\\frac{t}{2}}$ The function $f$ models the number of users on a website $t$ months after it launched. The function can be rewritten in the form $f(t) = 300(1 + \\frac{r}{100})^t$. What is the value of $r$?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

Use the power of a power property $(a^m)^n = a^{mn}$ to combine the fractional exponent with the base. This converts the growth factor to a monthly basis.

\\textbf{Calculation and Logic:}

$(1.21)^{(t)/(2)} = (1.21^{1/2})^t$.

Calculate the square root: $\\sqrt{1.21} = 1.1$.

The monthly growth factor is 1.1.

$1 + (r)/(100) = 1.1 → (r)/(100) = 0.1 → r = 10$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_12',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'A town''s population increases by 100% every 15 years. If the population is currently 5,000, what will it be in 45 years?',
  '[{"id":"a","text":"15,000"},{"id":"b","text":"20,000"},{"id":"c","text":"40,000"},{"id":"d","text":"80,000"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A 100% increase is the same as doubling. Determine how many 15-year periods occur in 45 years.

\\textbf{Calculation and Logic:}

Cycles = $45 / 15 = 3$ doublings.

$5,000 × 2 = 10,000$ (15 yrs)

$10,000 × 2 = 20,000$ (30 yrs)

$20,000 × 2 = 40,000$ (45 yrs).',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_13',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'The value of an investment increases by $x%$ each year. If the value of the investment triples every 12 years, what is the value of $(1 + \\frac{x}{100})^{36}$?',
  NULL,
  '27',
  '\\textbf{Conceptual Explanation:}

The expression $(1 + (x)/(100))^{36}$ represents the total growth factor over 36 years. Determine how many 12-year tripling periods fit into 36 years.

\\textbf{Calculation and Logic:}

Number of periods = $36 / 12 = 3$.

Since the value triples each period, the total growth multiplier is $3 × 3 × 3 = 3^3 = 27$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_14',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'A savings account offers an annual interest rate of 4% compounded semi-annually. Which expression represents the value of a 500 deposit after $t$ years?',
  '[{"id":"a","text":"$500(1.04)^t$"},{"id":"b","text":"$500(1.02)^{2t}$"},{"id":"c","text":"$500(1.04)^{2t}$"},{"id":"d","text":"$500(1.08)^t$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

"Semi-annually" means $n = 2$. Divide the annual rate by 2 and multiply the time $t$ by 2.

\\textbf{Calculation and Logic:}

Periodic rate = $4% / 2 = 2% = 0.02$.

Compounding periods = $2t$.

$V = 500(1 + 0.02)^{2t} = 500(1.02)^{2t}$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_15',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'A population of rare plants is decreasing by 10% each year. If there are 1,000 plants now, after how many years will the population be 729?',
  NULL,
  '3',
  '\\textbf{Calculation and Logic:}

Year 1: $1,000 × 0.9 = 900$.

Year 2: $900 × 0.9 = 810$.

Year 3: $810 × 0.9 = 729$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_16',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'Which of the following describes a population that grows by 50% every year?',
  '[{"id":"a","text":"The population increases by 50 individuals each year."},{"id":"b","text":"The population in any year is 1.5 times the population of the previous year."},{"id":"c","text":"The population in any year is 0.5 times the population of the previous year."},{"id":"d","text":"The population triples every 2 years."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A 50% increase corresponds to a growth factor of $1 + 0.50 = 1.5$. This means the new total is 1.5 times the previous total.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_17',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  '$V(t) = 1,200(1.02)^t$ The function above models the value of an account $t$ years after 2000. By what percentage does the value of the account increase every 5 years? (Round to the nearest percent).',
  NULL,
  '10',
  '\\textbf{Calculation and Logic:}

Growth factor for 1 year = 1.02.

Growth factor for 5 years = $(1.02)^5 \\approx 1.104$.

Rate = $1.104 - 1 = 0.104 \\approx 10%$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_18',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'Which of the following equations could represent the graph above?',
  '[{"id":"a","text":"$y = 50(0.8)^x$"},{"id":"b","text":"$y = 50(1.2)^x$"},{"id":"c","text":"$y = 50 - 1.2x$"},{"id":"d","text":"$y = 50 + 1.2x$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A curve that starts above the x-axis and bends upward represents exponential growth, where the base must be greater than 1.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_19',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'The population of a city doubles every 20 years. If the population was 40,000 in 1980, what was the population in 1940?',
  NULL,
  '10000',
  '\\textbf{Conceptual Explanation:}

Work backward in time. Each 20-year period into the past represents a halving of the population.

\\textbf{Calculation and Logic:}

Time difference = $1980 - 1940 = 40$ years.

Number of 20-year periods = $40 / 20 = 2$.

Population in 1960 = $40,000 / 2 = 20,000$.

Population in 1940 = $20,000 / 2 = 10,000$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_20',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'A bank account pays 1% annual interest compounded monthly. Which of the following is the monthly interest rate?',
  '[{"id":"a","text":"0.01"},{"id":"b","text":"0.12"},{"id":"c","text":"0.000833"},{"id":"d","text":"0.00833"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Annual rate = 1% = 0.01.

Monthly rate = $0.01 / 12 \\approx 0.000833$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_21',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'Which table shows exponential growth?',
  '[{"id":"a","text":"\\\\begin{tabular}{|c|c|c|c|} \\\\hline $x$ & 1 & 2 & 3 \\\\hline $y$ & 10 & 20 & 30 \\\\hline \\\\end{tabular}"},{"id":"b","text":"\\\\begin{tabular}{|c|c|c|c|} \\\\hline $x$ & 1 & 2 & 3 \\\\hline $y$ & 10 & 20 & 40 \\\\hline \\\\end{tabular}"},{"id":"c","text":"\\\\begin{tabular}{|c|c|c|c|} \\\\hline $x$ & 1 & 2 & 3 \\\\hline $y$ & 10 & 5 & 2.5 \\\\hline \\\\end{tabular}"},{"id":"d","text":"\\\\begin{tabular}{|c|c|c|c|} \\\\hline $x$ & 1 & 2 & 3 \\\\hline $y$ & 10 & 12 & 14 \\\\hline \\\\end{tabular}"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Growth requires output values to increase by a common ratio. In Choice B, the ratio is $20/10 = 2$ and $40/20 = 2$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_22',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  '$125^x = 5^{12}$ What is the value of $x$?',
  NULL,
  '4',
  '\\textbf{Calculation and Logic:}

$(5^3)^x = 5^{12}$.

$3x = 12 → x = 4$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_23',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'The population of a town triples every 8 years. If the current population is $P$, what will the population be after 24 years?',
  '[{"id":"a","text":"$3P$"},{"id":"b","text":"$9P$"},{"id":"c","text":"$24P$"},{"id":"d","text":"$27P$"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

Periods = $24 / 8 = 3$.

Multiplier = $3^3 = 27$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_24',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'A radioactive isotope has a half-life of 2 days. If a sample has 64 grams initially, how many grams will remain after 10 days?',
  NULL,
  '2',
  '\\textbf{Calculation and Logic:}

Cycles = $10 / 2 = 5$.

$64 × (0.5)^5 = 64 × 0.03125 = 2$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_25',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'An investment account earns 10% annual interest compounded semi-annually. If the initial deposit is 1,000, what is the value of the account, in dollars, after 1 year?',
  NULL,
  '1102.5',
  '\\textbf{Conceptual Explanation:}

Semi-annual compounding means the interest is applied twice a year ($n=2$). You must divide the annual rate by 2 and apply it for 2 periods.

\\textbf{Calculation and Logic:}

Periodic rate = $10% / 2 = 5% = 0.05$.

Amount after 1st period (6 months) = $1,000 × 1.05 = 1,050$.

Amount after 2nd period (12 months) = $1,050 × 1.05 = 1,102.50$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_26',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'A certain population grows according to the model $P(t) = P_0 (1.04)^t$, where $t$ is the number of years. Which of the following best models the population $d$ decades after the start? (1 decade = 10 years)',
  '[{"id":"a","text":"$P(d) = P_0 (1.04)^{\\\\frac{d}{10}}$"},{"id":"b","text":"$P(d) = P_0 (1.04)^{10d}$"},{"id":"c","text":"$P(d) = P_0 (1.40)^d$"},{"id":"d","text":"$P(d) = P_0 (1.04)^{d}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Substitute the relationship between the time units into the exponent. Since $t = 10d$, the exponent $t$ becomes $10d$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_27',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'The population of a city was 50,000 in 2010. If the population grew at a constant annual rate of 2% and reached 60,950 after $k$ years, what is the value of $k$?',
  NULL,
  '10',
  '\\textbf{Calculation and Logic:}

$50,000(1.02)^k = 60,950$

$(1.02)^k = 1.219$

Testing integer values:

$1.02^5 \\approx 1.104$

$1.02^{10} \\approx 1.219$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_28',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'What is the growth factor for an investment that increases by 12.5% each year?',
  NULL,
  '1.125',
  '\\textbf{Calculation and Logic:}

Growth factor = $1 + r = 1 + 0.125 = 1.125$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_29',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'If the population of a town is modeled by $P(t) = 20,000(0.85)^t$, what is the annual percentage decrease?',
  '[{"id":"a","text":"0.15%"},{"id":"b","text":"1.5%"},{"id":"c","text":"15%"},{"id":"d","text":"85%"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$0.85 = 1 - r → r = 0.15 = 15%$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_30',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'An account with an initial balance of 5,000 earns 8% annual interest compounded quarterly. What is the interest rate applied at the end of each quarter as a decimal?',
  NULL,
  '0.02',
  '\\textbf{Calculation and Logic:}

Quarterly means $n = 4$.

Periodic rate = $0.08 / 4 = 0.02$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_31',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'The value of a certain car depreciates by 15% each year. If the car is worth 20,000 today, how much will it be worth, in dollars, in 2 years?',
  NULL,
  '14450',
  '\\textbf{Calculation and Logic:}

$20,000 × (0.85)^2 = 20,000 × 0.7225 = 14,450$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_32',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  '$f(t) = 100(1.05)^t$ $g(t) = 100(1.10)^{\\frac{t}{2}}$ Which of the following statements comparing $f$ and $g$ is true for $t > 0$?',
  '[{"id":"a","text":"Function $g$ grows at a faster rate than function $f$."},{"id":"b","text":"Function $f$ grows at a faster rate than function $g$."},{"id":"c","text":"Both functions grow at the same rate."},{"id":"d","text":"The initial value of $g$ is greater than the initial value of $f$."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Convert $g(t)$ to have a standard $t$ exponent:

$(1.10)^{1/2} \\approx 1.0488$.

Since $1.05 > 1.0488$, function $f$ has a slightly higher annual growth rate.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_33',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'A population triples every 5 years. By what factor does the population increase in 15 years?',
  NULL,
  '27',
  '\\textbf{Calculation and Logic:}

Periods = $15 / 5 = 3$.

Factor = $3^3 = 27$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_34',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'If $5^{x+2} = 125$, what is the value of $x$?',
  NULL,
  '1',
  '\\textbf{Calculation and Logic:}

$5^{x+2} = 5^3$.

$x + 2 = 3 → x = 1$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_35',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'An investment of $P$ dollars increases in value by 20% every 4 years. Which function models the value $V(t)$ after $t$ years?',
  '[{"id":"a","text":"$V(t) = P(1.20)^{4t}$"},{"id":"b","text":"$V(t) = P(1.20)^{\\\\frac{t}{4}}$"},{"id":"c","text":"$V(t) = P(0.20)^{\\\\frac{t}{4}}$"},{"id":"d","text":"$V(t) = P(1.05)^t$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The rate 20% gives a base of 1.20. The exponent must represent the number of 4-year cycles, which is $t/4$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_36',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'If a bank account with 1,000 earns 4% interest compounded annually, how much interest, in dollars, is earned in the first year?',
  NULL,
  '40',
  '\\textbf{Calculation and Logic:}

$1,000 × 0.04 = 40$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_37',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'A town''s population was 10,000 in 2000 and 20,000 in 2010. If the population continues to double every 10 years, what will the population be in 2040?',
  NULL,
  '160000',
  '\\textbf{Calculation and Logic:}

2010 to 2040 = 30 years (3 doublings).

$20,000 × 2 = 40,000$ (2020)

$40,000 × 2 = 80,000$ (2030)

$80,000 × 2 = 160,000$ (2040).',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_38',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'Which of the following represents an exponential function where the initial value is 5 and the growth rate is 100%?',
  '[{"id":"a","text":"$y = 5(1)^x$"},{"id":"b","text":"$y = 5(2)^x$"},{"id":"c","text":"$y = 100(5)^x$"},{"id":"d","text":"$y = 5 + 100x$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Initial ($a$) = 5.

Growth factor = $1 + 1.00 = 2$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_39',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  '$2 \\cdot 4^x = 32$ What is the value of $x$?',
  NULL,
  '2',
  '\\textbf{Calculation and Logic:}

$4^x = 16$.

$4^2 = 16 → x = 2$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_40',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'A savings account starts with 1,000. It earns 2% interest compounded annually. How much more money, in dollars, will be in the account after 2 years compared to after 1 year?',
  NULL,
  '20.4',
  '\\textbf{Calculation and Logic:}

Year 1: $1,000 × 1.02 = 1,020$.

Year 2: $1,020 × 1.02 = 1,040.40$.

Difference = $1,040.40 - 1,020 = 20.40$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_41',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'A substance has a half-life of 8 hours. What fraction of the original amount remains after 24 hours?',
  '[{"id":"a","text":"1/3"},{"id":"b","text":"1/4"},{"id":"c","text":"1/8"},{"id":"d","text":"1/16"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Cycles = $24 / 8 = 3$.

$(1/2)^3 = 1/8$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_42',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  '$f(n) = 10 \\cdot 2^n$ $g(n) = 10 \\cdot 3^n$ What is the value of $\\frac{g(2)}{f(2)}$?',
  NULL,
  '2.25',
  '\\textbf{Calculation and Logic:}

$g(2) = 10 × 9 = 90$.

$f(2) = 10 × 4 = 40$.

Ratio = $90 / 40 = 2.25$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_43',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'In the compound interest formula $A = P(1 + \\frac{r}{n})^{nt}$, what does $P$ represent?',
  '[{"id":"a","text":"The annual interest rate"},{"id":"b","text":"The number of times interest is compounded per year"},{"id":"c","text":"The principal (initial amount)"},{"id":"d","text":"The total time in years"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

$P$ stands for Principal, the starting amount of money.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_44',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'If a population increases by 100% every decade, what is the annual growth factor rounded to two decimal places?',
  NULL,
  '1.07',
  '\\textbf{Calculation and Logic:}

$r^{10} = 2$.

$r = 2^{1/10} \\approx 1.0717$.

Growth factor $\\approx 1.07$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_45',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'A population starts at 500 and grows by 10% each year. What is the population after 1 year?',
  NULL,
  '550',
  '\\textbf{Calculation and Logic:}

$500 × 1.10 = 550$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_46',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'mcq',
  'math',
  'An amount is deposited into an account that triples every 10 years. After how many years will the amount be 9 times the initial deposit?',
  '[{"id":"a","text":"18"},{"id":"b","text":"20"},{"id":"c","text":"30"},{"id":"d","text":"90"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Since $9 = 3^2$, it takes 2 tripling periods.

$2 × 10 = 20$ years.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_47',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'If $(1.03)^x = 1.092727$, what is the value of $x$ to the nearest integer?',
  NULL,
  '3',
  '\\textbf{Calculation and Logic:}

$1.03^2 = 1.0609$.

$1.03^3 = 1.092727$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_48',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'A town''s population decreases by 50% every 20 years. If the population is 8,000 now, what was it 40 years ago?',
  NULL,
  '32000',
  '\\textbf{Calculation and Logic:}

Backward 20 years: $8,000 × 2 = 16,000$.

Backward 40 years: $16,000 × 2 = 32,000$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_024_49',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
),
  (
  'spr',
  'math',
  'An initial investment of 1,000 earns 5% annual interest compounded annually. What is the value of the account after 2 years?',
  NULL,
  '1102.5',
  '\\textbf{Calculation and Logic:}

$1,000 × (1.05)^2 = 1,000 × 1.1025 = 1,102.50$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_024_50',
  'Exponential functions and equations',
  'Compound Interest & Population Growth'
)
ON CONFLICT (bank_item_id) DO NOTHING;

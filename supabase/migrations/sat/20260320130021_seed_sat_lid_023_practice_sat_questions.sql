-- Practice-mode math from lid_023.tex (sat_lid_023)
-- Chapter: Exponential functions and equations | Topic: Exponential Growth & Decay
-- sat_questions: section=math, domain=advanced-math, bank_item_id=sat_lid_023_N, practice module/set 0.

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
  'A function $p$ estimates that there were 2,500 birds in a population in 2010. Each year from 2010 to 2020, the function estimates that the number of birds in this population increased by 4% of the number of birds in the population the previous year. Which equation defines this function, where $p(x)$ is the estimated number of birds in the population $x$ years after 2010?',
  '[{"id":"a","text":"$p(x) = 2,500(4)^x$"},{"id":"b","text":"$p(x) = 2,500(1.04)^x$"},{"id":"c","text":"$p(x) = 2,500(0.96)^x$"},{"id":"d","text":"$p(x) = 2,500(0.04)^x$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Exponential growth is modeled by the function $y = a(1 + r)^x$, where $a$ is the initial value, $r$ is the growth rate as a decimal, and $x$ is the number of time periods.

\\textbf{Calculation and Logic:}

Initial value ($a$) $= 2,500$.

Growth rate ($r$) $= 4% = 0.04$.

Growth factor $= 1 + r = 1 + 0.04 = 1.04$.

Substitute into the formula:

$p(x) = 2,500(1.04)^x$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_1',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'For the function $q$, the value of $q(x)$ decreases by 35% for every increase in the value of $x$ by 1. If $q(0) = 25$, which equation defines $q$?',
  '[{"id":"a","text":"$q(x) = 0.65(25)^x$"},{"id":"b","text":"$q(x) = 1.35(25)^x$"},{"id":"c","text":"$q(x) = 25(0.65)^x$"},{"id":"d","text":"$q(x) = 25(1.35)^x$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Exponential decay is modeled by $y = a(1 - r)^x$. A percentage decrease results in a decay factor less than 1.

\\textbf{Calculation and Logic:}

Initial value ($a$) $= q(0) = 25$.

Decay rate ($r$) $= 35% = 0.35$.

Decay factor $= 1 - r = 1 - 0.35 = 0.65$.

Substitute into the formula:

$q(x) = 25(0.65)^x$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_2',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'Bacteria are growing in a liquid growth medium. There were 400,000 cells per milliliter during an initial observation. The number of cells per milliliter doubles every 4 hours. How many cells per milliliter will there be 12 hours after the initial observation?',
  NULL,
  '3,200,000',
  '\\textbf{Conceptual Explanation:}

For doubling scenarios, determine the number of doubling periods that occur in the total time given. Multiply the initial amount by $2^n$, where $n$ is the number of periods.

\\textbf{Calculation and Logic:}

Initial amount $= 400,000$.

Total time $= 12$ hours.

Doubling time $= 4$ hours.

Number of doublings ($n$) $= 12 / 4 = 3$.

Calculate final amount:

$400,000 × 2^3 = 400,000 × 8 = 3,200,000$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_3',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '$f(x) = 150,000(1.18)^x$ The function $f$ gives a company''s predicted annual revenue, in dollars, $x$ years after the company started selling products online, where $0 < x ≤ 8$. What is the best interpretation of the statement "$f(4)$ is approximately equal to 290,816" in this context?',
  '[{"id":"a","text":"4 years after the company started selling online, its predicted annual revenue is approximately 290,816."},{"id":"b","text":"4 years after the company started selling online, its predicted annual revenue will have increased by a total of 290,816."},{"id":"c","text":"When the revenue is approximately 290,816, it is 4 times the revenue for the previous year."},{"id":"d","text":"When the revenue is approximately 290,816, it is 4% greater than the revenue for the previous year."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In function notation $f(x) = y$, the value inside the parentheses ($x$) is the input (time), and the result ($y$) is the output (revenue).

\\textbf{Calculation and Logic:}

$x = 4$ represents 4 years after starting.

$f(4) = 290,816$ represents the revenue at that specific point in time.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_4',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'The population of a town is currently 45,000, and the population is estimated to increase each year by 2.5% from the previous year. Which of the following equations can be used to estimate the number of years, $t$, it will take for the population of the town to reach 55,000?',
  '[{"id":"a","text":"$45,000 = 55,000(0.025)^t$"},{"id":"b","text":"$45,000 = 55,000(2.5)^t$"},{"id":"c","text":"$55,000 = 45,000(0.025)^t$"},{"id":"d","text":"$55,000 = 45,000(1.025)^t$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Set up the exponential growth equation $Final = Initial(1 + r)^t$.

\\textbf{Calculation and Logic:}

Initial population $= 45,000$.

Final population goal $= 55,000$.

Growth factor $= 1 + 0.025 = 1.025$.

Equation: $55,000 = 45,000(1.025)^t$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_5',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'For the exponential function $f$, the table below shows several values of $x$ and their corresponding values of $f(x)$, where $b$ is a constant greater than 1. If $k$ is a constant and $f(k) = b^{25}$, what is the value of $k$? \\begin{center} \\begin{tabular}{|c|c|} \\hline $x$ & $f(x)$ \\hline 1 & $b^1$ \\hline 2 & $b^4$ \\hline 3 & $b^7$ \\hline \\end{tabular} \\end{center}',
  NULL,
  '9',
  '\\textbf{Conceptual Explanation:}

Identify the linear pattern in the exponents relative to the $x$ values. The exponents form an arithmetic sequence.

\\textbf{Calculation and Logic:}

Exponents are 1, 4, 7...

Common difference $= 3$.

Exponent formula: $E = 3x - 2$.

(Check: $x=1 \\rightarrow E=3(1)-2=1$; $x=3 \\rightarrow E=3(3)-2=7$).

Set $E = 25$:

$25 = 3x - 2$

$27 = 3x → x = 9$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_6',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '$p(t) = 120,000(1.08)^t$ The given function $p$ models the population of a city $t$ years after a census. Which of the following functions best models the population of the city $m$ months after the census?',
  '[{"id":"a","text":"$r(m) = \\\\frac{120,000}{12}(1.08)^m$"},{"id":"b","text":"$r(m) = 120,000(\\\\frac{1.08}{12})^m$"},{"id":"c","text":"$r(m) = 120,000(1.08)^{12m}$"},{"id":"d","text":"$r(m) = 120,000(1.08)^{\\\\frac{m}{12}}$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

When changing units of time, replace the original variable with an equivalent expression in the new unit. Since $12 \\text{ months} = 1 \\text{ year}$, then $1 \\text{ month} = 1/12 \\text{ years}$. Thus, $t = m/12$.

\\textbf{Calculation and Logic:}

Substitute $t = m/12$ into the original function:

$r(m) = 120,000(1.08)^{(m)/(12)}$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_7',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '$f(x) = (1.44)^{\\frac{x}{2}}$ The function $f$ is defined by the given equation. The equation can be rewritten as $f(x) = (1 + \\frac{p}{100})^x$, where $p$ is a constant. What is the value of $p$?',
  '[{"id":"a","text":"12"},{"id":"b","text":"20"},{"id":"c","text":"22"},{"id":"d","text":"44"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Use exponent rules to isolate the $x$ power. Specifically, $(a^b)^c = a^{bc}$. We can group the $1/2$ power with the base to simplify the growth factor.

\\textbf{Calculation and Logic:}

$(1.44)^{(x)/(2)} = (1.44^{(1)/(2)})^x$

Calculate the square root:

$\\sqrt{1.44} = 1.2$.

Now the form is $(1.2)^x$.

Set $1 + (p)/(100) = 1.2$:

$(p)/(100) = 0.2 → p = 20$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_8',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'A radioactive substance decays such that its mass is halved every 15 years. If the initial mass was 600 grams, what will the mass, in grams, be after 45 years?',
  NULL,
  '75',
  '\\textbf{Conceptual Explanation:}

This is a half-life problem. Determine how many half-life periods occur in the total time.

\\textbf{Calculation and Logic:}

Total time $= 45$.

Half-life $= 15$.

Number of cycles $= 45 / 15 = 3$.

Final mass $= 600 × (0.5)^3$

Final mass $= 600 × 0.125 = 75$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_9',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[->] (0,0) -- (6,0) node[right] {$x$}; \\draw[->] (0,0) -- (0,6) node[above] {$y$}; \\draw[domain=0:2.5, smooth, variable=\\x, red, thick] plot ({\\x}, {0.5*2^(\\x)}); \\node at (2.5,5) {$y=f(x)$}; \\end{tikzpicture} \\end{center} The graph above shows an exponential function $f$. Which of the following statements about the function must be true?',
  '[{"id":"a","text":"The value of $y$ increases by a constant amount for every unit increase in $x$."},{"id":"b","text":"The value of $y$ increases by a constant percentage for every unit increase in $x$."},{"id":"c","text":"The function has a constant slope."},{"id":"d","text":"The $y$-intercept is $(0, 0)$."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Linear functions increase by constant amounts. Exponential functions increase (or decrease) by a constant ratio or percentage.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_10',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'According to Moore’s law, the number of transistors on a chip doubles every 2 years. In 2000, a chip had 10 million transistors. In which year does Moore’s law estimate the number of transistors to reach 80 million?',
  NULL,
  '2006',
  '\\textbf{Conceptual Explanation:}

Determine the number of doubling cycles required to reach the target value, then multiply by the duration of one cycle to find the total time passed.

\\textbf{Calculation and Logic:}

Initial $= 10$ million.

Target $= 80$ million.

Ratio $= 80/10 = 8$.

Since $2^3 = 8$, three doubling cycles are required.

Each cycle $= 2$ years.

Total years passed $= 3 × 2 = 6$.

Year $= 2000 + 6 = 2006$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_11',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'An investment account earns 6% annual interest compounded annually. If an initial deposit of 2,000 is made, which function $V(t)$ represents the value of the account after $t$ years?',
  '[{"id":"a","text":"$V(t) = 2,000(0.06)^t$"},{"id":"b","text":"$V(t) = 2,000(1.06)^t$"},{"id":"c","text":"$V(t) = 2,000 + 0.06t$"},{"id":"d","text":"$V(t) = 2,000(6)^t$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Compound interest is a form of exponential growth. The rate is added to 1 to find the base.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_12',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'Which of the following exponential functions represents a decay of 12% per period?',
  '[{"id":"a","text":"$f(x) = 100(1.12)^x$"},{"id":"b","text":"$f(x) = 100(0.12)^x$"},{"id":"c","text":"$f(x) = 100(0.88)^x$"},{"id":"d","text":"$f(x) = 100(-0.12)^x$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Decay factor $= 1 - \\text{rate}$.

$1 - 0.12 = 0.88$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_13',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'The population of jackrabbits in a region was 50 in the year 1950. By 2000, the population had grown exponentially to 1,600. If the annual percentage increase was constant, what was the population in 1980?',
  NULL,
  '400',
  '\\textbf{Conceptual Explanation:}

First, determine the growth factor for the given time interval. Then, apply that growth factor to the specific sub-interval requested.

\\textbf{Calculation and Logic:}

Total time $= 50$ years.

Growth multiplier $= 1600/50 = 32$.

We have $r^{50} = 32$.

Time from 1950 to 1980 $= 30$ years.

We need $50 × r^{30}$.

Since $32 = 2^5$, we can say $r^{50} = (2^{1/10})^{50} → r = 2^{1/10}$.

(Basically, the population doubles every 10 years).

1950 to 1980 is 3 doublings (30 years).

$50 × 2^3 = 50 × 8 = 400$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_14',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'The functions $f$ and $g$ are defined by the given equations, where $x ≥ 0$. Which of the following equations displays, as a constant or coefficient, the maximum value of the function it defines, where $x ≥ 0$? $f(x) = 50(0.8)^{x+2}$ $g(x) = 50(0.64)(0.8)^{x-2}$',
  '[{"id":"a","text":"I only"},{"id":"b","text":"II only"},{"id":"c","text":"I and II"},{"id":"d","text":"Neither I nor II"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

For a decay function ($0 < \\text{base} < 1$) where $x ≥ 0$, the maximum value occurs at the start of the interval ($x=0$). The equation displays this value if the term $a(b)^x$ has $x$ as the exponent with no shifts, or if the coefficient represents $f(0)$.

\\textbf{Calculation and Logic:}

$f(0) = 50(0.8)^2 = 50(0.64) = 32$.

Function $f$ does not show 32 as a coefficient.

$g(x) = 32(0.8)^{x-2}$.

$g(0) = 32(0.8)^{-2} = 32 / 0.64 = 50$.

Function $g$ does not show 50 as a lead coefficient.

Wait, let''s re-evaluate $g(x)$ in your SS style:

$g(x) = 50(0.64)(0.8)^{x-2} = 32(0.8)^{x-2}$. At $x=2$, $g(2)=32$.

The question asks which displays the maximum on the interval. For decay, max is at $x=0$. Neither form explicitly shows the value at $x=0$ as the primary coefficient without further calculation.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_15',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '$h(t) = 15(2)^{\\frac{t}{5}}$ The function $h$ models the height of a plant, in centimeters, $t$ days after it was planted. Which of the following is the best interpretation of the number 5 in this context?',
  '[{"id":"a","text":"The plant''s height increases by 5 centimeters each day."},{"id":"b","text":"The plant''s height doubles every 5 days."},{"id":"c","text":"The initial height of the plant was 5 centimeters."},{"id":"d","text":"The plant will reach a maximum height of 5 centimeters."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In the form $y = a(2)^{t/d}$, the value $d$ represents the time it takes for the quantity to double.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_16',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'The value of a computer is 1,200 when new and depreciates exponentially. If the value of the computer decreases by 20% each year, what is its value, in dollars, after 2 years?',
  NULL,
  '768',
  '\\textbf{Calculation and Logic:}

$V = 1200(0.8)^2$

$V = 1200(0.64) = 768$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_17',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'If $a^{2x} = (a^3)^4 \\cdot a^2$, what is the value of $x$?',
  NULL,
  '7',
  '\\textbf{Calculation and Logic:}

$a^{2x} = a^{12} \\cdot a^2$

$a^{2x} = a^{14}$

$2x = 14 → x = 7$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_18',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'A scientist observes a population of 500 insects. The population increases by 100% every week. Which function represents the population $P$ after $w$ weeks?',
  '[{"id":"a","text":"$P(w) = 500(1)^w$"},{"id":"b","text":"$P(w) = 500(2)^w$"},{"id":"c","text":"$P(w) = 500 + 100w$"},{"id":"d","text":"$P(w) = 500(1.10)^w$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

An increase of 100% means the population is doubling. Growth factor $= 1 + 1.00 = 2$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_19',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  '$f(x) = 2(3)^x$ $g(x) = 162$ If $f(x) = g(x)$, what is the value of $x$?',
  NULL,
  '4',
  '\\textbf{Calculation and Logic:}

$2(3)^x = 162$

$3^x = 81$

Since $3^4 = 81$, $x = 4$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_20',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'A painting purchased for 5,000 increases in value by 10% every 3 years. Which expression gives the value of the painting after $y$ years?',
  '[{"id":"a","text":"$5,000(1.10)^{3y}$"},{"id":"b","text":"$5,000(1.10)^{\\\\frac{y}{3}}$"},{"id":"c","text":"$5,000(1.30)^y$"},{"id":"d","text":"$5,000(0.10)^{\\\\frac{y}{3}}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The exponent should represent the number of 3-year periods, which is $y/3$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_21',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '$y = a(b)^x$ In the exponential function above, if $a > 0$ and $0 < b < 1$, what happens to the value of $y$ as $x$ increases?',
  '[{"id":"a","text":"$y$ increases at an increasing rate."},{"id":"b","text":"$y$ increases at a decreasing rate."},{"id":"c","text":"$y$ decreases toward 0."},{"id":"d","text":"$y$ remains constant."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

If the base $b$ is between 0 and 1, the function represents decay, meaning the output gets smaller as the input gets larger.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_22',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'The number of subscribers to a service was 1,000 at the end of the first month. Each month thereafter, the number of subscribers was 1.2 times the number of subscribers at the end of the previous month. How many subscribers were there at the end of the 4th month?',
  NULL,
  '1,728',
  '\\textbf{Calculation and Logic:}

End of month 1: 1,000.

End of month 2: $1,000 × 1.2 = 1,200$.

End of month 3: $1,200 × 1.2 = 1,440$.

End of month 4: $1,440 × 1.2 = 1,728$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_23',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'Which of the following functions models a population that triples every 10 years?',
  '[{"id":"a","text":"$P(t) = P_0 (3)^{10t}$"},{"id":"b","text":"$P(t) = P_0 (10)^{3t}$"},{"id":"c","text":"$P(t) = P_0 (3)^{\\\\frac{t}{10}}$"},{"id":"d","text":"$P(t) = P_0 (10)^{\\\\frac{t}{3}}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The base must be the growth factor (3) and the exponent must divide the total time by the period (10).',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_24',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'A colony of bacteria doubles in size every 20 minutes. If the colony starts with 50 bacteria, how many doublings will occur in 2 hours?',
  NULL,
  '6',
  '\\textbf{Calculation and Logic:}

Total time $= 2 \\text{ hours} = 120 \\text{ minutes}$.

Cycle time $= 20 \\text{ minutes}$.

Cycles $= 120 / 20 = 6$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_25',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'A town''s population was 12,000 in the year 2010. The population increases by 5% every 3 years. If the population is modeled by the function $P(t) = 12,000(k)^{\\frac{t}{3}}$, what is the value of $k$?',
  NULL,
  '1.05',
  '\\textbf{Conceptual Explanation:}

The base of an exponential growth function represents the growth factor for one full period. A 5% increase corresponds to a growth factor of $1 + 0.05$.

\\textbf{Calculation and Logic:}

Initial value $= 12,000$.

Growth rate $= 5% = 0.05$.

Growth factor $(k) = 1 + 0.05 = 1.05$.

The equation uses $t/3$ as the exponent to account for the fact that the growth occurs every 3 years. Thus, the base $k$ is 1.05.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_26',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'Which of the following functions represents an exponential decay where the value decreases by 25% every year?',
  '[{"id":"a","text":"$f(t) = 500(0.25)^t$"},{"id":"b","text":"$f(t) = 500(1.25)^t$"},{"id":"c","text":"$f(t) = 500(0.75)^t$"},{"id":"d","text":"$f(t) = 500(1.75)^t$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Decay factor $= 1 - \\text{decay rate}$. For a 25% decrease, the factor is $1 - 0.25 = 0.75$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_27',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'The value of an antique car increases by 8% each year. If the car is currently worth 25,000, what will be its value, in dollars, in 2 years?',
  NULL,
  '29,160',
  '\\textbf{Calculation and Logic:}

Value after 1 year $= 25,000 × 1.08 = 27,000$.

Value after 2 years $= 27,000 × 1.08 = 29,160$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_28',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '$f(x) = 10(2)^x$ Which of the following best describes the growth of the function $f$?',
  '[{"id":"a","text":"The value of $f(x)$ increases by 2 for every unit increase in $x$."},{"id":"b","text":"The value of $f(x)$ increases by 10 for every unit increase in $x$."},{"id":"c","text":"The value of $f(x)$ doubles for every unit increase in $x$."},{"id":"d","text":"The value of $f(x)$ increases by 200% for every unit increase in $x$."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A base of 2 in an exponential function indicates that the output value doubles ($100%$ increase) for each unit increase in the input.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_29',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'If $16^x = 2^{20}$, what is the value of $x$?',
  NULL,
  '5',
  '\\textbf{Calculation and Logic:}

Rewrite 16 as a power of 2: $16 = 2^4$.

$(2^4)^x = 2^{20} → 2^{4x} = 2^{20}$.

$4x = 20 → x = 5$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_30',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'A certain type of cell divides into two every 15 minutes. If a sample starts with 10 cells, how many cells will be present after 1 hour?',
  NULL,
  '160',
  '\\textbf{Calculation and Logic:}

1 hour $= 60$ minutes.

Number of divisions $= 60 / 15 = 4$.

Total cells $= 10 × 2^4 = 10 × 16 = 160$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_31',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $a^{\\frac{5}{2}}$?',
  '[{"id":"a","text":"$\\\\sqrt[5]{a^2}$"},{"id":"b","text":"$\\\\sqrt{a^5}$"},{"id":"c","text":"$2a^5$"},{"id":"d","text":"$5a^2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Apply the radical rule: $x^{m/n} = \\sqrt[n]{x^m}$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_32',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '$V(t) = 1000(1.04)^{\\frac{t}{4}}$ The function above models the value of an account $t$ years after an initial deposit. Which of the following is the best interpretation of the growth in this account?',
  '[{"id":"a","text":"The value increases by 4% every year."},{"id":"b","text":"The value increases by 4% every 4 years."},{"id":"c","text":"The value increases by 1.04% every 4 years."},{"id":"d","text":"The value increases by 4 every year."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The base (1.04) represents a 4% increase. The exponent ($t/4$) indicates that this increase occurs once every 4 units of $t$ (years).',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_33',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'The population of a city is currently 200,000 and is decreasing at a rate of 2% per year. What will the population be in 2 years?',
  NULL,
  '192,080',
  '\\textbf{Calculation and Logic:}

Year 1: $200,000 × 0.98 = 196,000$.

Year 2: $196,000 × 0.98 = 192,080$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_34',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'If $f(x) = a(b)^x$ represents exponential growth, which of the following must be true about $b$?',
  '[{"id":"a","text":"$b < 0$"},{"id":"b","text":"$0 < b < 1$"},{"id":"c","text":"$b = 1$"},{"id":"d","text":"$b > 1$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

For growth, the base must be greater than 1. If it is between 0 and 1, it represents decay.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_35',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'What is the value of $n$ if $3^n = \\sqrt[3]{81}$?',
  NULL,
  '4/3',
  '\\textbf{Calculation and Logic:}

$81 = 3^4$.

$\\sqrt[3]{3^4} = 3^{(4)/(3)}$.

$n = 4/3$ or $1.33$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_36',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'The number of active users on a platform increases by 50% every month. If there were 1,000 users initially, how many users are there after $m$ months?',
  '[{"id":"a","text":"$1,000(0.50)^m$"},{"id":"b","text":"$1,000(1.50)^m$"},{"id":"c","text":"$1,000 + 0.50m$"},{"id":"d","text":"$1,000(50)^m$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

An increase of 50% means the growth factor is $1 + 0.50 = 1.50$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_37',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '$y = 400(0.95)^x$ Which statement best describes the function above?',
  '[{"id":"a","text":"The value increases by 5% each period."},{"id":"b","text":"The value decreases by 5% each period."},{"id":"c","text":"The value decreases by 95% each period."},{"id":"d","text":"The value increases by 95% each period."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A base of 0.95 means $1 - 0.05$, which indicates a 5% decrease (decay).',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_38',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'A loan of 5,000 charges 12% annual interest compounded monthly. What is the monthly interest rate as a decimal?',
  NULL,
  '0.01',
  '\\textbf{Calculation and Logic:}

Annual rate $= 12% = 0.12$.

Monthly rate $= 0.12 / 12 = 0.01$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_39',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '$f(x) = 2^x$ What is the value of $f(5) - f(3)$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"24"},{"id":"d","text":"32"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$f(5) = 2^5 = 32$.

$f(3) = 2^3 = 8$.

$32 - 8 = 24$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_40',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'The graph above models which of the following scenarios?',
  '[{"id":"a","text":"A population doubling every year."},{"id":"b","text":"A bank account earning 5% interest."},{"id":"c","text":"The value of a car depreciating over time."},{"id":"d","text":"The linear growth of a plant."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A curve that slopes downward toward the $x$-axis represents exponential decay, such as depreciation.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_41',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'If $5^k = \\frac{1}{25}$, what is the value of $k$?',
  NULL,
  '-2',
  '\\textbf{Calculation and Logic:}

$(1)/(25) = 25^{-1} = (5^2)^{-1} = 5^{-2}$.

$k = -2$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_42',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  '$P(t) = 50(3)^t$ This function models a population of insects after $t$ days. How many insects are there after 2 days?',
  '[{"id":"a","text":"150"},{"id":"b","text":"300"},{"id":"c","text":"450"},{"id":"d","text":"900"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$P(2) = 50(3^2) = 50 × 9 = 450$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_43',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'Which table represents an exponential function?',
  '[{"id":"a","text":"\\\\begin{tabular}{|c|c|c|c|} \\\\hline $x$ & 1 & 2 & 3 \\\\hline $y$ & 2 & 4 & 6 \\\\hline \\\\end{tabular}"},{"id":"b","text":"\\\\begin{tabular}{|c|c|c|c|} \\\\hline $x$ & 1 & 2 & 3 \\\\hline $y$ & 2 & 4 & 8 \\\\hline \\\\end{tabular}"},{"id":"c","text":"\\\\begin{tabular}{|c|c|c|c|} \\\\hline $x$ & 1 & 2 & 3 \\\\hline $y$ & 10 & 20 & 30 \\\\hline \\\\end{tabular}"},{"id":"d","text":"\\\\begin{tabular}{|c|c|c|c|} \\\\hline $x$ & 1 & 2 & 3 \\\\hline $y$ & 5 & 10 & 15 \\\\hline \\\\end{tabular}"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In an exponential function, the ratio between consecutive $y$-values is constant (here, $4/2 = 2$ and $8/4 = 2$). In linear functions, the difference is constant.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_44',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'A substance has a half-life of 10 years. If 1,000 grams are present initially, how many grams remain after 40 years?',
  NULL,
  '62.5',
  '\\textbf{Calculation and Logic:}

Cycles $= 40/10 = 4$.

Remaining $= 1,000 × (0.5)^4 = 1,000 × 0.0625 = 62.5$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_45',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'An initial population of 100 triples every year. Which function represents the population after $x$ years?',
  '[{"id":"a","text":"$f(x) = 100(3)^x$"},{"id":"b","text":"$f(x) = 100 + 3x$"},{"id":"c","text":"$f(x) = 300^x$"},{"id":"d","text":"$f(x) = 100(x)^3$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Initial value $= 100$. Base (growth factor) $= 3$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_46',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'mcq',
  'math',
  'In the function $y = a(b)^x$, what does $a$ represent?',
  '[{"id":"a","text":"The growth rate"},{"id":"b","text":"The horizontal asymptote"},{"id":"c","text":"The initial value (y-intercept)"},{"id":"d","text":"The time period"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

When $x=0$, $y = a(b)^0 = a(1) = a$. Thus, $a$ is the starting amount.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_023_47',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  '$2^{(x-3)} = 32$ What is the value of $x$?',
  NULL,
  '8',
  '\\textbf{Calculation and Logic:}

$32 = 2^5$.

$x - 3 = 5 → x = 8$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_48',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'If a town''s population of 5,000 increases by 10% per year, how many people will be in the town after 2 years?',
  NULL,
  '6,050',
  '\\textbf{Calculation and Logic:}

$5,000 × (1.10)^2 = 5,000 × 1.21 = 6,050$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_49',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
),
  (
  'spr',
  'math',
  'A computer file is compressed exponentially. Each step reduces the file size by 50%. If the file is 1,024 MB and undergoes 3 steps of compression, what is the final size in MB?',
  NULL,
  '128',
  '\\textbf{Calculation and Logic:}

$1,024 × (0.5)^3 = 1,024 × 0.125 = 128$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_023_50',
  'Exponential functions and equations',
  'Exponential Growth & Decay'
)
ON CONFLICT (bank_item_id) DO NOTHING;

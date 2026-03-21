-- Practice-mode math from lid_032.tex (sat_lid_032)
-- Chapter: Percentages and percentage change | Topic: Percent Change
-- sat_questions: section=math, domain=problem-solving, bank_item_id=sat_lid_032_N, practice module/set 0.

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
  'The nutrition facts for Crunchy Grain cereal state that a serving size provides 180 milligrams of potassium, which is 5% of the daily allowance for adults. If $p$ percent of an adult''s daily allowance of potassium is provided by $x$ servings of cereal per day, which of the following expresses $p$ in terms of $x$?',
  '[{"id":"a","text":"$p = 0.5x$"},{"id":"b","text":"$p = 5x$"},{"id":"c","text":"$p = (0.05)^x$"},{"id":"d","text":"$p = (1.05)^x$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In this scenario, each individual serving contributes a fixed percentage to the total daily allowance. This creates a linear relationship where the total percentage ($p$) is the product of the percentage per serving and the total number of servings ($x$).

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the unit rate:} 1 serving = 5% of the daily allowance.

2. \\textbf{Formulate the linear equation:}

Total Percentage = (Percentage per unit) $×$ (Number of units)

$p = 5 \\cdot x$

Therefore, the relationship is expressed as $p = 5x$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_1',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'The expression $0.35x$ represents the result of decreasing a positive quantity $x$ by what percent?',
  '[{"id":"a","text":"3.5%"},{"id":"b","text":"35%"},{"id":"c","text":"6.5%"},{"id":"d","text":"65%"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

When a quantity $x$ is decreased by $r%$, the remaining amount is $(100 - r)%$ of the original. To find the percentage of the decrease, subtract the decimal multiplier from 1.00 (which represents the full 100%).

\\begin{center}

\\begin{tikzpicture}[scale=0.8]

\\draw[thick] (0,0) rectangle (10,1);

\\fill[blue!20] (0,0) rectangle (3.5,1);

\\node at (1.75, 0.5) {\\small $0.35x$ (Left)};

\\fill[red!10] (3.5,0) rectangle (10,1);

\\node at (6.75, 0.5) {\\small Decrease (Removed)};

\\draw[<->] (0,-0.3) -- (10,-0.3) node[midway, below] {\\small Original $x$ (1.00)};

\\end{tikzpicture}

\\end{center}

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the multiplier:} 0.35.

2. \\textbf{Calculate the difference from 1:}

$1.00 - 0.35 = 0.65$.

3. \\textbf{Convert to percentage:}

$0.65 × 100 = 65%$.

The expression represents a 65% decrease.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_2',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'A table of the US minimum wage for different years is shown. In 1960, the wage was 1.00 per hour. In 1970, the wage was 1.60 per hour. What was the percent increase of the minimum wage from 1960 to 1970?',
  '[{"id":"a","text":"30%"},{"id":"b","text":"60%"},{"id":"c","text":"62.5%"},{"id":"d","text":"120%"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Percent increase measures how much a value has grown relative to its starting point. The formula involves finding the total growth (New - Old) and dividing it by the original value.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify values:} Old = 1.00; New = 1.60.

2. \\textbf{Find the amount of increase:}

$1.60 - 1.00 = 0.60$.

3. \\textbf{Apply the formula:}

\\[ \\text{Percent Increase} = \\frac{\\text{Amount of Increase}}{\\text{Original Value}} × 100 \\]

\\[ \\text{Percent Increase} = (0.60)/(1.00) × 100 = 60% \\]',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_3',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'The population of City A increased by 7% from 2015 to 2016. If the 2016 population is $k$ times the 2015 population, what is the value of $k$?',
  '[{"id":"a","text":"0.07"},{"id":"b","text":"0.7"},{"id":"c","text":"1.07"},{"id":"d","text":"1.7"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

An increase of $r%$ means the new value is $100% + r%$ of the original. The value $k$ represents the decimal multiplier (growth factor) applied to the original population.

\\textbf{Calculation and Logic:}

1. \\textbf{Percentage relationship:}

New Population = 100% (Original) + 7% (Increase) = 107%.

2. \\textbf{Convert percentage to decimal:}

$107% = 1.07$.

3. \\textbf{Identify k:}

Since New = $1.07 ×$ Old, $k = 1.07$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_4',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'In 2008, Zinah earned 14% more than in 2007, and in 2009 Zinah earned 4% more than in 2008. If Zinah earned $y$ times as much in 2009 as in 2007, what is the value of $y$?',
  '[{"id":"a","text":"0.5600"},{"id":"b","text":"1.0056"},{"id":"c","text":"1.1800"},{"id":"d","text":"1.1856"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

This problem involves sequential percentage increases. To find the total growth factor across multiple periods, you must multiply the individual growth factors for each period. \\textbf{Note:} You cannot simply add the percentages (14% + 4% $\\neq$ 18% total increase).

\\textbf{Calculation and Logic:}

1. \\textbf{Factor for 2007 to 2008:} $1 + 0.14 = 1.14$.

2. \\textbf{Factor for 2008 to 2009:} $1 + 0.04 = 1.04$.

3. \\textbf{Total combined factor (y):}

$y = 1.14 × 1.04$

$y = 1.1856$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_5',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'A school district is forming a committee to discuss construction plans. Of those invited, 15% are parents, 45% are teachers, 25% are administrators, and the remaining 6 individuals are students. How many more teachers were invited to join the committee than administrators?',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

First, calculate the percentage that the remaining students represent of the total. Use this to solve for the total number of people on the committee, and then find the specific number of teachers and administrators.

\\textbf{Calculation and Logic:}

1. \\textbf{Find student percentage:}

$100% - (15% + 45% + 25%) = 15%$.

2. \\textbf{Solve for total committee size (T):}

$15% \\text{ of } T = 6$

$0.15T = 6 → T = 6 / 0.15 = 40$.

3. \\textbf{Calculate individual groups:}

Teachers = $45% \\text{ of } 40 = 0.45 × 40 = 18$.

Administrators = $25% \\text{ of } 40 = 0.25 × 40 = 10$.

4. \\textbf{Find the difference:}

$18 - 10 = 8$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_6',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'The number $a$ is 190% greater than the number $b$. The number $b$ is 80% less than 24. What is the value of $a$?',
  '[{"id":"a","text":"9.12"},{"id":"b","text":"13.92"},{"id":"c","text":"26.40"},{"id":"d","text":"36.48"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Convert the comparative percentage phrases into multipliers. "190% greater than" means the value is $100% + 190% = 290%$ (multiplier 2.9). "80% less than" means the value is $100% - 80% = 20%$ (multiplier 0.2).

\\textbf{Calculation and Logic:}

1. \\textbf{Solve for b:}

$b = 24 × 0.2 = 4.8$.

2. \\textbf{Solve for a:}

$a = 4.8 × 2.9$.

$a = 13.92$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_7',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'The positive number $a$ is 2,241% of the sum of the positive numbers $b$ and $c$, and $b$ is 83% of $c$. What percent of $b$ is $a$?',
  '[{"id":"a","text":"23.24%"},{"id":"b","text":"49.41%"},{"id":"c","text":"2,324%"},{"id":"d","text":"4,941%"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Translate the multi-variable relationships into a single algebraic expression. Express both $a$ and $c$ in terms of $b$ to find the final percentage relationship between $a$ and $b$.

\\textbf{Calculation and Logic:}

1. \\textbf{Relationships:}

$a = 22.41(b + c)$

$b = 0.83c → c = (b)/(0.83) \\approx 1.2048b$

2. \\textbf{Substitute c into the first equation:}

$a = 22.41(b + 1.2048b)$

$a = 22.41(2.2048b)$

$a \\approx 49.41b$

3. \\textbf{Convert to percentage:}

$49.41 × 100 = 4,941%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_8',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'For a TV show finale, 30% of votes were cast on social media and 70% were cast via text message. Contestant 2 earned 70% of the social media votes and 40% of the text message votes. Based on this information, which of the following is true?',
  '[{"id":"a","text":"Contestant 2 won the overall vote."},{"id":"b","text":"Social media voters were more likely to prefer Contestant 2 than text voters."},{"id":"c","text":"Contestant 2 received exactly 55% of the total votes."},{"id":"d","text":"Text message voters were more likely to prefer Contestant 2."}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Social media contribution:} $0.30 × 0.70 = 0.21$ (21% of total).

2. \\textbf{Text message contribution:} $0.70 × 0.40 = 0.28$ (28% of total).

3. \\textbf{Total overall percentage:} $0.21 + 0.28 = 0.49$ (49% of total).

4. \\textbf{Analysis:} Since 49% < 50%, Contestant 2 did not win. However, they received a much higher share of social media votes (70%) compared to text votes (40%), meaning social media voters had a stronger preference for them.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_9',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'What is 23% of 100?',
  '[{"id":"a","text":"23"},{"id":"b","text":"46"},{"id":"c","text":"77"},{"id":"d","text":"123"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

The definition of "percent" is "per hundred." Therefore, $x%$ of 100 is always just the value $x$.

\\[ (23)/(100) × 100 = 23 \\]',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_10',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'For what positive value of $x$ is the function $f(x) = \\frac{1}{x^2 - 1}$ undefined?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

A rational function is undefined wherever the denominator is equal to zero, as division by zero is mathematically impossible.

\\textbf{Calculation and Logic:}

1. \\textbf{Set the denominator to zero:}

$x^2 - 1 = 0$

2. \\textbf{Factor the difference of squares:}

$(x - 1)(x + 1) = 0$

3. \\textbf{Solve for x:}

$x = 1$ or $x = -1$.

4. \\textbf{Apply constraint:} The question asks for the positive value.

$x = 1$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_11',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'If $x^2 - 3x - 10 = 0$, for what value of $x$ is this equation true given that $x > 0$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"6"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Factor the quadratic trinomial:}

$(x - 5)(x + 2) = 0$

2. \\textbf{Identify roots:}

$x = 5$ or $x = -2$.

3. \\textbf{Apply constraint:} Since $x > 0$, the answer is 5.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_12',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'Which of the following would be a solution to the equation $21 - \\sqrt{x} = 10$?',
  '[{"id":"a","text":"11"},{"id":"b","text":"18"},{"id":"c","text":"55"},{"id":"d","text":"121"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Isolate the radical term:}

$21 - 10 = \\sqrt{x}$

$11 = \\sqrt{x}$

2. \\textbf{Square both sides to solve for x:}

$11^2 = (\\sqrt{x})^2$

$x = 121$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_13',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'Which of the following provides the two solutions to the equation $3x^2 + 5x + 2 = 0$?',
  '[{"id":"a","text":"$-\\\\frac{2}{3}$ or -1"},{"id":"b","text":"$\\\\frac{1}{6}$ or $\\\\frac{2}{5}$"},{"id":"c","text":"$-\\\\frac{3}{4}$ or 7"},{"id":"d","text":"$\\\\frac{6}{11}$ or -8"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Use the AC method to factor:}

Multiply $a \\cdot c = 3 \\cdot 2 = 6$. Find factors of 6 that sum to 5: 2 and 3.

2. \\textbf{Rewrite and group:}

$3x^2 + 3x + 2x + 2 = 0$

$3x(x + 1) + 2(x + 1) = 0$

$(3x + 2)(x + 1) = 0$

3. \\textbf{Solve for x:}

$3x + 2 = 0 → x = -2/3$

$x + 1 = 0 → x = -1$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_14',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'If $x^2 - 15 = x + 5$, what is the product of the solutions to the equation?',
  NULL,
  '-20',
  '\\textbf{Conceptual Explanation:}

Move all terms to one side to form a standard quadratic equation. Once in the form $ax^2 + bx + c = 0$, you can find the product of the roots using the ratio $c/a$.

\\textbf{Calculation and Logic:}

1. \\textbf{Rearrange equation:}

$x^2 - x - 20 = 0$.

2. \\textbf{Factor the quadratic:}

$(x - 5)(x + 4) = 0$.

3. \\textbf{Identify solutions:}

$x = 5$ and $x = -4$.

4. \\textbf{Calculate product:}

$5 × (-4) = -20$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_15',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  '$\\frac{x^2 - y^2}{3} = 0$ What value of $y$ would always make the above equation true for any $x$?',
  '[{"id":"a","text":"$x$"},{"id":"b","text":"$x^2$"},{"id":"c","text":"$4x$"},{"id":"d","text":"$8x$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

For the fraction to equal zero, its numerator must be zero:

$x^2 - y^2 = 0 → x^2 = y^2$.

Taking the square root of both sides gives $y = x$ or $y = -x$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_16',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'If $\\frac{(x + 2)}{(x - 3)} - 2 = \\frac{7}{(x - 3)}$, what is the solution for $x$?',
  NULL,
  '1',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Multiply the entire equation by the denominator } $(x - 3)$:

$(x + 2) - 2(x - 3) = 7$.

2. \\textbf{Distribute and simplify:}

$x + 2 - 2x + 6 = 7$

$-x + 8 = 7$.

3. \\textbf{Solve for x:}

$-x = -1 → x = 1$.

4. \\textbf{Check for extraneous solutions:}

Since $x = 1$ does not make the original denominator zero ($1 - 3 \\neq 0$), it is a valid solution.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_17',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'If $2\\sqrt{x} + 1 = 10 - \\sqrt{x}$, what is the solution for $x$?',
  NULL,
  '9',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Combine radical terms on one side:}

$2\\sqrt{x} + \\sqrt{x} = 10 - 1$

$3\\sqrt{x} = 9$.

2. \\textbf{Isolate the radical:}

$\\sqrt{x} = 3$.

3. \\textbf{Square both sides:}

$x = 9$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_18',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  '$(x + b)(x + b) = x^2 + 4x + 4$ If the above equation has infinitely many solutions, what is the value of the constant $b$?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

An equation with infinitely many solutions means that the left side and the right side are algebraically identical. Expand the left side and compare the coefficients to the right side.

\\textbf{Calculation and Logic:}

1. \\textbf{Expand left side:}

$(x + b)^2 = x^2 + 2bx + b^2$.

2. \\textbf{Equate to right side:}

$x^2 + 2bx + b^2 = x^2 + 4x + 4$.

3. \\textbf{Compare coefficients:}

$2b = 4 → b = 2$.

Check the constant: $b^2 = 2^2 = 4$. This matches.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_19',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'If $\\frac{6x^2 - 5x + 8}{2} = x^2 - 3$, how many real solutions are there for $x$?',
  NULL,
  '0',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Eliminate the fraction:}

$6x^2 - 5x + 8 = 2(x^2 - 3)$

$6x^2 - 5x + 8 = 2x^2 - 6$.

2. \\textbf{Rearrange into standard form:}

$4x^2 - 5x + 14 = 0$.

3. \\textbf{Use the discriminant } $D = b^2 - 4ac$:

$D = (-5)^2 - 4(4)(14)$

$D = 25 - 224 = -199$.

4. \\textbf{Interpret result:}

Since the discriminant is negative ($D < 0$), there are 0 real solutions.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_20',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'If $x^2 - 14x + 49 = 0$, what is the value of $x$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"5"},{"id":"c","text":"7"},{"id":"d","text":"9"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Recognize the perfect square trinomial:}

$(x - 7)^2 = 0$.

2. \\textbf{Solve for x:}

$x - 7 = 0 → x = 7$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_21',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'If $n^2 - 6n + 9 = 25$, which of the following is a possible value of $n - 3$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"9"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Simplify the left side:}

$(n - 3)^2 = 25$.

2. \\textbf{Take the square root of both sides:}

$n - 3 = \\sqrt{25}$ or $n - 3 = -\\sqrt{25}$.

$n - 3 = 5$ or $n - 3 = -5$.

3. \\textbf{Identify choice:} 5 is provided in the options.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_22',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'If $\\frac{3x}{6 - x} = x$, what are the value(s) of $x$ that would satisfy the equation?',
  '[{"id":"a","text":"1 and -6"},{"id":"b","text":"2 and -3"},{"id":"c","text":"3 and 0"},{"id":"d","text":"6 and 4"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Cross-multiply:}

$3x = x(6 - x)$.

2. \\textbf{Expand and move all terms to one side:}

$3x = 6x - x^2$

$x^2 - 3x = 0$.

3. \\textbf{Factor out x:}

$x(x - 3) = 0$.

4. \\textbf{Identify solutions:}

$x = 0$ or $x = 3$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_23',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'What is the largest value of $n$ that satisfies the equation $\\frac{(n + 4)(n - 6)}{2} = 0$?',
  '[{"id":"a","text":"-4"},{"id":"b","text":"-6"},{"id":"c","text":"4"},{"id":"d","text":"6"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Solve for n by setting the numerator to zero:}

$(n + 4)(n - 6) = 0$.

2. \\textbf{Roots:}

$n = -4$ and $n = 6$.

3. \\textbf{Identify largest:} 6.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_24',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  '$f(x) = \\frac{2x - 13}{2x^2 - 16x + 32}$ For what value of $x$ is the above function $f(x)$ undefined?',
  '[{"id":"a","text":"-8"},{"id":"b","text":"-4"},{"id":"c","text":"2"},{"id":"d","text":"4"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Set denominator to zero:}

$2x^2 - 16x + 32 = 0$.

2. \\textbf{Divide by common factor 2:}

$x^2 - 8x + 16 = 0$.

3. \\textbf{Recognize perfect square:}

$(x - 4)^2 = 0$.

4. \\textbf{Solve:}

$x = 4$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_25',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'The population of a certain town was 12,000 in 2010. The population increased by 10% from 2010 to 2011 and then decreased by 5% from 2011 to 2012. What was the population of the town in 2012?',
  NULL,
  '12540',
  '\\textbf{Conceptual Explanation:}

When dealing with successive percentage changes, apply each change to the result of the previous step. This is essentially a compounding process where the base value changes after each interval.

\\textbf{Calculation and Logic:}

Step 1: Calculate the population in 2011 (10% increase).

Multiplier = $1 + 0.10 = 1.10$.

$12,000 × 1.10 = 13,200$.

Step 2: Calculate the population in 2012 (5% decrease from the new value).

Multiplier = $1 - 0.05 = 0.95$.

$13,200 × 0.95 = 12,540$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_26',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'If 40% of $x$ is equal to 160, what is 25% of $x$?',
  '[{"id":"a","text":"40"},{"id":"b","text":"100"},{"id":"c","text":"400"},{"id":"d","text":"640"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Step 1: Solve for $x$.

$0.40x = 160$

$x = (160)/(0.40) = 400$.

Step 2: Find 25% of $x$.

$0.25 × 400 = 100$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_27',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,0) rectangle (4,1); \\fill[green!20] (0,0) rectangle (2.4,1); \\node at (1.2, 0.5) {60% Used}; \\draw[<->] (2.4, -0.2) -- (4, -0.2) node[midway, below] {Remainder}; \\end{tikzpicture} \\end{center} A project manager has spent 60% of the project budget. If the remaining budget is 12,000, what was the total initial budget?',
  '[{"id":"a","text":"18,000"},{"id":"b","text":"20,000"},{"id":"c","text":"30,000"},{"id":"d","text":"48,000"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The "remainder" represents the portion of the budget not yet spent. If 60% is spent, the remaining 40% must equal the provided dollar amount.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify remaining percentage:} $100% - 60% = 40%$.

2. \\textbf{Set up the equation:} $0.40 × \\text{Total} = 12,000$.

3. \\textbf{Solve for Total:}

$\\text{Total} = (12,000)/(0.40) = 30,000$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_28',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'A laptop''s price was reduced by 20% for a sale. After the sale, the sale price was increased by 20% to return to a "new" regular price. What is the ratio of the new regular price to the original price? (Express as a decimal).',
  NULL,
  '0.96',
  '\\textbf{Conceptual Explanation:}

Many students assume that a 20% decrease followed by a 20% increase returns a value to 100%. However, because the second change is applied to a smaller base, the final result is always less than the original.

\\textbf{Calculation and Logic:}

1. \\textbf{Let original price = 1.}

2. \\textbf{Apply decrease:} $1 × (1 - 0.20) = 0.80$.

3. \\textbf{Apply increase:} $0.80 × (1 + 0.20) = 0.80 × 1.20$.

4. \\textbf{Calculate result:} $0.96$.

The ratio is 0.96 to 1, or simply 0.96.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_29',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'The number of participants in a study increased from 40 to 50. What was the percent increase in the number of participants?',
  '[{"id":"a","text":"10%"},{"id":"b","text":"20%"},{"id":"c","text":"25%"},{"id":"d","text":"80%"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$\\text{Increase} = 50 - 40 = 10$.

$\\text{Percent Increase} = (10)/(40) × 100$.

$0.25 × 100 = 25%$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_30',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'A store increases the price of a rug by 25%. If the new price is 250, what was the original price in dollars?',
  NULL,
  '200',
  '\\textbf{Calculation and Logic:}

$1.25 × \\text{Original} = 250$.

$\\text{Original} = (250)/(1.25)$.

$\\text{Original} = 200$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_31',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'If $k$ is a positive constant and $x$ is decreased by $k$%, which of the following represents the result?',
  '[{"id":"a","text":"$x - k$"},{"id":"b","text":"$x(1 - k)$"},{"id":"c","text":"$x(1 - \\\\frac{k}{100})$"},{"id":"d","text":"$\\\\frac{x}{k}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Percentage must be converted to a fraction or decimal before subtracting from 1. $k%$ is equivalent to $k/100$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_32',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'A solution is 15% salt by mass. How much salt, in grams, must be added to 85 grams of water to create this solution?',
  NULL,
  '15',
  '\\textbf{Conceptual Explanation:}

The total mass of the solution is the sum of the salt and the water. The salt mass is then 15% of that total mass.

\\textbf{Calculation and Logic:}

Let $s$ = grams of salt.

Total mass = $s + 85$.

$s = 0.15(s + 85)$.

$s = 0.15s + 12.75$.

$0.85s = 12.75$.

$s = 15$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_33',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to increasing a number by 200%?',
  '[{"id":"a","text":"Multiplying by 2"},{"id":"b","text":"Multiplying by 3"},{"id":"c","text":"Adding 200"},{"id":"d","text":"Multiplying by 200"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$100% (\\text{Original}) + 200% (\\text{Increase}) = 300%$.

$300%$ in decimal form is 3.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_34',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'If $x$ is 20% of $z$ and $y$ is 30% of $z$, what percent of $y$ is $x$? (Round to the nearest whole percent).',
  NULL,
  '67',
  '\\textbf{Calculation and Logic:}

$x = 0.2z$.

$y = 0.3z$.

$(x)/(y) = (0.2z)/(0.3z) = (2)/(3)$.

$(2)/(3) \\approx 0.6667 \\rightarrow 67%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_35',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'An item that costs $C$ dollars is on sale for 30% off. Which expression represents the sale price?',
  '[{"id":"a","text":"$0.3C$"},{"id":"b","text":"$C - 0.3$"},{"id":"c","text":"$0.7C$"},{"id":"d","text":"$1.3C$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$100% - 30% = 70%$.

Multiplier = 0.7.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_36',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'A worker''s salary was increased by 5% each year for two consecutive years. What was the total percentage increase over the two-year period?',
  NULL,
  '10.25',
  '\\textbf{Calculation and Logic:}

Multiplier = $1.05 × 1.05 = 1.1025$.

Convert to percent: $1.1025 - 1 = 0.1025$.

$0.1025 × 100 = 10.25%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_37',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'If 80% of students in a class of 30 passed a test, how many students failed?',
  '[{"id":"a","text":"6"},{"id":"b","text":"8"},{"id":"c","text":"22"},{"id":"d","text":"24"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Failed % = $100% - 80% = 20%$.

$0.20 × 30 = 6$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_38',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'In a garden, the number of roses is 40% of the number of tulips. If there are 20 roses, how many tulips are in the garden?',
  NULL,
  '50',
  '\\textbf{Calculation and Logic:}

$0.40 × \\text{Tulips} = 20$.

$\\text{Tulips} = (20)/(0.40) = 50$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_39',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'The price of a book is $P$. If the price is increased by 15% and then a 5 discount is applied, which expression represents the final price?',
  '[{"id":"a","text":"$1.15P - 5$"},{"id":"b","text":"$1.15(P - 5)$"},{"id":"c","text":"$0.15P - 5$"},{"id":"d","text":"$P + 1.15 - 5$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

1. Increase: $1.15P$.

2. Discount: $(1.15P) - 5$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_40',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'A bank account earns 2% interest compounded annually. If the initial deposit is 5,000, how much interest is earned after 2 years?',
  NULL,
  '202',
  '\\textbf{Calculation and Logic:}

Balance = $5,000 × (1.02)^2$.

Balance = $5,000 × 1.0404 = 5,202$.

Interest = $5,202 - 5,000 = 202$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_41',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'If 15 is 75% of $w$, what is $w$?',
  '[{"id":"a","text":"11.25"},{"id":"b","text":"15.75"},{"id":"c","text":"20"},{"id":"d","text":"25"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$0.75w = 15$.

$w = 15 / 0.75 = 20$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_42',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'A store marks down a 150 item by 30%. A customer has a coupon for an additional 10% off the sale price. What is the final price?',
  NULL,
  '94.5',
  '\\textbf{Calculation and Logic:}

Sale Price = $150 × 0.70 = 105$.

Coupon Price = $105 × 0.90 = 94.50$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_43',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $0.004x$?',
  '[{"id":"a","text":"4% of $x$"},{"id":"b","text":"0.4% of $x$"},{"id":"c","text":"0.04% of $x$"},{"id":"d","text":"40% of $x$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$0.004 × 100 = 0.4%$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_44',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'A population of bacteria triples every hour. What is the percentage increase each hour?',
  NULL,
  '200',
  '\\textbf{Calculation and Logic:}

Tripling means the new value is 300% of the old.

Increase = $300% - 100% = 200%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_45',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'If 10% of $a$ is equal to 20% of $b$, what is the ratio of $a$ to $b$?',
  '[{"id":"a","text":"1:2"},{"id":"b","text":"2:1"},{"id":"c","text":"1:1"},{"id":"d","text":"10:20"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$0.10a = 0.20b$.

$(a)/(b) = (0.20)/(0.10) = 2$.

Ratio = 2:1.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_46',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'The price of a house increased from 200,000 to 210,000. What was the percent increase?',
  NULL,
  '5',
  '\\textbf{Calculation and Logic:}

$(10,000)/(200,000) × 100 = 5%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_47',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'If $x$ is 120% of $y$, which of the following must be true?',
  '[{"id":"a","text":"$x < y$"},{"id":"b","text":"$x > y$"},{"id":"c","text":"$x = y + 20$"},{"id":"d","text":"$x = 1.2 + y$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$x = 1.2y$. Since 1.2 > 1 and $y$ is assumed positive in these contexts, $x$ is larger than $y$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_48',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'spr',
  'math',
  'A car depreciates in value by 15% each year. After one year, a car is worth 17,000. What was the original price?',
  NULL,
  '20000',
  '\\textbf{Calculation and Logic:}

$0.85 × \\text{Original} = 17,000$.

$\\text{Original} = (17,000)/(0.85) = 20,000$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_032_49',
  'Percentages and percentage change',
  'Percent Change'
),
  (
  'mcq',
  'math',
  'What is 5% of 5% of 10,000?',
  '[{"id":"a","text":"25"},{"id":"b","text":"50"},{"id":"c","text":"250"},{"id":"d","text":"500"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

$0.05 × (0.05 × 10,000)$

$0.05 × 500 = 25$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_032_50',
  'Percentages and percentage change',
  'Percent Change'
)
ON CONFLICT (bank_item_id) DO NOTHING;

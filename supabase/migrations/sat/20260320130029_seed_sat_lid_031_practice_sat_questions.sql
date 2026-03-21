-- Practice-mode math from lid_031.tex (sat_lid_031)
-- Chapter: Ratios, rates, proportional relationships, units | Topic: Ratio & Proportion Word Problems
-- sat_questions: section=math, domain=problem-solving, bank_item_id=sat_lid_031_N, practice module/set 0.

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
  'At a particular track meet, the ratio of coaches to athletes is 1 to 26. If there are $x$ coaches at the track meet, which of the following expressions represents the number of athletes at the track meet?',
  '[{"id":"a","text":"$\\\\frac{x}{26}$"},{"id":"b","text":"$26x$"},{"id":"c","text":"$x + 26$"},{"id":"d","text":"$\\\\frac{26}{x}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A ratio of 1 to 26 establishes a constant proportional relationship. For every single unit of the first group (coaches), there is a fixed multiplier of 26 for the second group (athletes).

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the ratio:} $\\frac{\\text{Coaches}}{\\text{Athletes}} = (1)/(26)$.

2. \\textbf{Substitute the variable:} The problem states coaches = $x$.

3. \\textbf{Set up the proportion:}

\\[ (x)/(\\text{Athletes)} = (1)/(26) \\]

4. \\textbf{Cross-multiply to solve:}

$\\text{Athletes} × 1 = 26 × x$

$\\text{Athletes} = 26x$',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_1',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'Paul Revere traveled 11 miles in 26 minutes during his ride. If he maintained this exact rate, what would his average speed have been, in miles per hour, rounded to the nearest tenth?',
  NULL,
  '25.4',
  '\\textbf{Conceptual Explanation:}

Speed is the ratio of total distance to total time. To find speed in miles per \\textbf{hour} when time is given in \\textbf{minutes}, you must convert the time units so they are consistent.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify values:} Distance = 11 miles; Time = 26 minutes.

2. \\textbf{Convert time to hours:} 26 minutes = $(26)/(60)$ hours.

3. \\textbf{Apply speed formula:} $\\text{Speed} = \\frac{\\text{Distance}}{\\text{Time}}$

\\[ \\text{Speed} = \\frac{11 \\text{ miles}}{(26)/(60) \\text{ hours}} \\]

4. \\textbf{Simplify:}

$11 × (60)/(26) = (660)/(26) \\approx 25.3846$

Rounding to the nearest tenth results in 25.4.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_2',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'Rectangle $A$ has length 15 and width $w$. Rectangle $B$ has length 20 and the same length-to-width ratio as rectangle $A$. What is the width of rectangle $B$ in terms of $w$?',
  '[{"id":"a","text":"$\\\\frac{4}{3}w$"},{"id":"b","text":"$w + 5$"},{"id":"c","text":"$\\\\frac{3}{4}w$"},{"id":"d","text":"$w - 5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When two shapes share the same ratio of dimensions, they are proportional. We can set the ratio of length/width for the first rectangle equal to the length/width of the second.

\\begin{center}

\\begin{tikzpicture}[scale=0.8]

% Rectangle A

\\draw[thick, fill=gray!10] (0,0) rectangle (1.5,1) node[midway] {$A$};

\\node at (0.75, -0.4) {\\small Length 15};

\\node[rotate=90] at (-0.4, 0.5) {\\small Width $w$};

% Scaling arrow

\\draw[->, thick] (2.5, 0.5) -- (3.5, 0.5) node[midway, above] {\\small Ratio};

% Rectangle B

\\draw[thick, fill=blue!10] (4.5,0) rectangle (6.5,1.33) node[midway] {$B$};

\\node at (5.5, -0.4) {\\small Length 20};

\\node[rotate=90] at (4.1, 0.66) {\\small Width ?};

\\end{tikzpicture}

\\end{center}

\\textbf{Calculation and Logic:}

1. \\textbf{Set up the proportion:} $(15)/(w) = (20)/(\\text{Width)_B}$

2. \\textbf{Cross-multiply:} $15 \\cdot \\text{Width}_B = 20w$

3. \\textbf{Isolate Width B:} $\\text{Width}_B = (20)/(15)w$

4. \\textbf{Simplify the fraction:} $(20)/(15) = (4)/(3)$

Therefore, the width is $(4)/(3)w$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_3',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'Shaquan has 7 red cards and 28 blue cards. What is the ratio of red cards to blue cards that Shaquan has?',
  '[{"id":"a","text":"1 to 4"},{"id":"b","text":"4 to 1"},{"id":"c","text":"1 to 7"},{"id":"d","text":"7 to 1"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

A ratio is a comparison of two quantities. To express it in its simplest form, divide both parts of the ratio by their greatest common factor.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the terms:} Red = 7, Blue = 28.

2. \\textbf{Write the ratio:} 7 : 28.

3. \\textbf{Find the common factor:} Both 7 and 28 are divisible by 7.

4. \\textbf{Simplify:}

\\[ (7)/(7) : (28)/(7) = 1 : 4 \\]',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_4',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'Jeremy deposited $x$ dollars in his investment account on January 1, 2001. The amount of money in the account doubled each year until Jeremy had 480 in his investment account on January 1, 2005. What is the value of $x$?',
  NULL,
  '30',
  '\\textbf{Conceptual Explanation:}

This problem describes exponential growth with a doubling ratio (1:2) occurring at fixed intervals. To find the starting value, you can work backward from the final result by halving the amount for each period that passed.

\\textbf{Calculation and Logic:}

1. \\textbf{Calculate time elapsed:} 2001 to 2005 = 4 years.

2. \\textbf{Reverse the doubling process:}

\\begin{itemize}

\\item End of Year 4 (2005): 480

\\item End of Year 3 (2004): $480 ÷ 2 = 240$

\\item End of Year 2 (2003): $240 ÷ 2 = 120$

\\item End of Year 1 (2002): $120 ÷ 2 = 60$

\\item Start (2001): $60 ÷ 2 = 30$

\\end{itemize}

Alternatively, use the equation $x \\cdot 2^4 = 480 → 16x = 480 → x = 30$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_5',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'Tanya earns 13.50 per hour. When she works $z$ hours, she earns $13.50z$ dollars. Which of the following expressions gives the amount Tanya will earn if she works $3z$ hours?',
  '[{"id":"a","text":"$3(13.50z)$"},{"id":"b","text":"$3 + 13.50z$"},{"id":"c","text":"$3z + 13.50z$"},{"id":"d","text":"$13.50(z + 3)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The total earnings are the product of the hourly rate and the number of hours. If the number of hours increases by a specific factor, the total earnings will increase by that same factor, representing a direct proportional relationship.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the original earnings function:} $E(z) = 13.50 \\cdot z$.

2. \\textbf{Substitute the new input ($3z$):}

\\[ E(3z) = 13.50 \\cdot (3z) \\]

3. \\textbf{Apply the Commutative Property of Multiplication:}

\\[ E(3z) = 3 \\cdot (13.50 \\cdot z) \\]

4. \\textbf{Match the result to the choices:} $3(13.50z)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_6',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'A glass holds 16 fluid ounces. Jenny has a pitcher containing 1 gallon of water. How many times could Jenny completely fill the glass with 1 gallon of water? (1 gallon = 128 fluid ounces)',
  '[{"id":"a","text":"16"},{"id":"b","text":"8"},{"id":"c","text":"4"},{"id":"d","text":"3"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To determine how many times a smaller volume fits into a larger volume, both quantities must be expressed in the same unit. Divide the larger capacity by the unit size of the smaller container.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify capacities in ounces:}

Glass = 16 fluid ounces.

Pitcher = 1 gallon = 128 fluid ounces.

2. \\textbf{Set up the division:}

\\[ \\text{Number of fills} = \\frac{128 \\text{ oz}}{16 \\text{ oz}} \\]

3. \\textbf{Calculate:}

$128 ÷ 16 = 8$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_7',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'A set of wind projects in Texas has a total power capacity of 4,952 megawatts (MW). If these projects had operated continuously for 24 hours at this maximum rate, approximately how many megawatt-hours of energy would they have produced?',
  '[{"id":"a","text":"200"},{"id":"b","text":"5,000"},{"id":"c","text":"120,000"},{"id":"d","text":"1,000,000"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Energy is measured in megawatt-hours, which is the product of the power rate (MW) and the time (hours). The term "continuously" indicates that the power output is constant over the duration.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify values:} Power rate = 4,952 MW; Time = 24 hours.

2. \\textbf{Set up the product:}

Energy = $4,952 \\text{ MW} × 24 \\text{ hours}$

3. \\textbf{Perform approximation (SAT Shortcut):}

$4,952 \\approx 5,000$

$5,000 × 24 = 120,000$ megawatt-hours.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_8',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'If $\\frac{4a}{b} = 6.7$ and $\\frac{a}{bn} = 26.8$, what is the value of $n$?',
  NULL,
  '0.0625',
  '\\textbf{Conceptual Explanation:}

This problem uses two proportional equations to find the value of a specific constant. By isolating common terms like $(a)/(b)$ in one equation, we can substitute it into the other to solve for $n$.

\\textbf{Calculation and Logic:}

1. \\textbf{From first equation:} $(4a)/(b) = 6.7$.

Isolate $(a)/(b)$ by dividing by 4:

$(a)/(b) = (6.7)/(4) = 1.675$.

2. \\textbf{From second equation:} $(a)/(bn) = 26.8$.

Rewrite as: $\\left( (a)/(b) \\right) \\cdot (1)/(n) = 26.8$.

3. \\textbf{Substitute 1.675:}

$1.675 \\cdot (1)/(n) = 26.8$.

4. \\textbf{Solve for } $n$:

$(1)/(n) = (26.8)/(1.675) = 16$.

$n = (1)/(16) = 0.0625$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_9',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'The weight of an object on Venus is approximately $\\frac{9}{10}$ of its weight on Earth. The weight of an object on Jupiter is approximately $\\frac{23}{10}$ of its weight on Earth. If an object weighs 100 pounds on Earth, how many more pounds does it weigh on Jupiter than it weighs on Venus?',
  '[{"id":"a","text":"90"},{"id":"b","text":"111"},{"id":"c","text":"140"},{"id":"d","text":"230"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Proportions define how a value changes relative to a base amount. We calculate the weights on Venus and Jupiter using their respective Earth ratios and then find the difference.

\\begin{center}

\\begin{tikzpicture}

% Venus Bar

\\draw[fill=orange!20] (0,0) rectangle (0.9, 0.5) node[midway] {\\tiny 90};

\\node at (-0.8, 0.25) {\\small Venus};

% Jupiter Bar

\\draw[fill=blue!20] (0,1) rectangle (2.3, 1.5) node[midway] {\\tiny 230};

\\node at (-0.8, 1.25) {\\small Jupiter};

% Earth Reference

\\draw[dashed] (1.0, -0.2) -- (1.0, 1.7) node[above] {\\small Earth (100)};

\\end{tikzpicture}

\\end{center}

\\textbf{Calculation and Logic:}

1. \\textbf{Weight on Venus:} $100 \\text{ lbs} \\cdot (9)/(10) = 90$ lbs.

2. \\textbf{Weight on Jupiter:} $100 \\text{ lbs} \\cdot (23)/(10) = 230$ lbs.

3. \\textbf{Difference:} $230 - 90 = 140$ lbs.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_10',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'If $\\frac{x^2 - 15}{x+5} = 0$, what is the product of the solutions to the equation?',
  NULL,
  '-15',
  '\\textbf{Conceptual Explanation:}

For a rational expression to equal zero, the numerator must be exactly zero, while the denominator must be non-zero (since division by zero is undefined).

\\textbf{Calculation and Logic:}

1. \\textbf{Set the numerator to zero:}

$x^2 - 15 = 0 → x^2 = 15$.

2. \\textbf{Solve for } $x$:

$x = \\sqrt{15}$ and $x = -\\sqrt{15}$.

3. \\textbf{Verify the denominator:}

Substitute both values into $(x+5)$. Since $\\sqrt{15} \\approx 3.87$, neither value results in $-5$. Thus, both are valid solutions.

4. \\textbf{Find the product:}

$(\\sqrt{15}) \\cdot (-\\sqrt{15}) = -15$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_11',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  '$\\frac{x^2 - y^2}{3} = 0$ What value of $y$ would always make the above equation true for any $x$?',
  '[{"id":"a","text":"$x$"},{"id":"b","text":"$x^2$"},{"id":"c","text":"$4x$"},{"id":"d","text":"$8x$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

A fraction equals zero only when its numerator is zero. Therefore, the expression $x^2 - y^2$ must evaluate to zero.

\\textbf{Calculation and Logic:}

1. \\textbf{Set numerator to zero:}

$x^2 - y^2 = 0$.

2. \\textbf{Isolate } $y^2$:

$x^2 = y^2$.

3. \\textbf{Solve for } $y$:

$y = x$ or $y = -x$.

From the given choices, $y = x$ satisfies this condition.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_12',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'If $\\frac{(x+2)}{(x-3)} - 2 = \\frac{7}{(x-3)}$, what is the solution for $x$?',
  NULL,
  '1',
  '\\textbf{Conceptual Explanation:}

To solve a rational equation, clear the denominators by multiplying the entire equation by the least common denominator. Always check for extraneous solutions that would make the original denominator zero.

\\textbf{Calculation and Logic:}

1. \\textbf{Multiply by } $(x-3)$:

$(x+2) - 2(x-3) = 7$.

2. \\textbf{Distribute and simplify:}

$x + 2 - 2x + 6 = 7$.

$-x + 8 = 7$.

3. \\textbf{Solve for } $x$:

$-x = -1 → x = 1$.

4. \\textbf{Verify:}

Substituting $x=1$ into $(x-3)$ gives $-2$, so the solution is valid.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_13',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'If $2\\sqrt{x} + 1 = 10 - \\sqrt{x}$, what is the solution for $x$?',
  NULL,
  '9',
  '\\textbf{Conceptual Explanation:}

Treat the radical expression $\\sqrt{x}$ as a single variable term. Isolate the radicals on one side and the constants on the other before squaring to solve for $x$.

\\textbf{Calculation and Logic:}

1. \\textbf{Combine radical terms:}

$2\\sqrt{x} + \\sqrt{x} = 10 - 1$.

$3\\sqrt{x} = 9$.

2. \\textbf{Isolate the radical:}

$\\sqrt{x} = 3$.

3. \\textbf{Square both sides:}

$(\\sqrt{x})^2 = 3^2$.

$x = 9$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_14',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  '$(x+b)(x+b) = x^2 + 4x + 4$ If the above equation has infinitely many solutions, what is the value of the constant $b$?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

An equation with infinitely many solutions implies that both sides are algebraically identical. Expanding the left side allows for a direct comparison of coefficients.

\\textbf{Calculation and Logic:}

1. \\textbf{Expand the left side:}

$(x+b)^2 = x^2 + 2bx + b^2$.

2. \\textbf{Compare coefficients with } $x^2 + 4x + 4$:

$2b = 4 → b = 2$.

$b^2 = 4 → (2)^2 = 4$.

Both conditions confirm that $b = 2$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_15',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'If $\\frac{6x^2 - 5x + 8}{2} = x^2 - 3$, how many real solutions are there for $x$?',
  NULL,
  '0',
  '\\textbf{Conceptual Explanation:}

Transform the equation into a standard quadratic form ($ax^2 + bx + c = 0$) and use the discriminant, $D = b^2 - 4ac$, to determine the number of real roots.

\\textbf{Calculation and Logic:}

1. \\textbf{Eliminate the fraction:}

$6x^2 - 5x + 8 = 2(x^2 - 3)$.

$6x^2 - 5x + 8 = 2x^2 - 6$.

2. \\textbf{Form the quadratic:}

$4x^2 - 5x + 14 = 0$.

3. \\textbf{Calculate the discriminant:}

$D = (-5)^2 - 4(4)(14)$.

$D = 25 - 224 = -199$.

4. \\textbf{Interpret:}

Since $D < 0$, there are 0 real solutions.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_16',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'If $\\frac{3x}{6-x} = x$, what are the value(s) of $x$ that satisfy the equation?',
  '[{"id":"a","text":"1 and -6"},{"id":"b","text":"2 and -3"},{"id":"c","text":"3 and 0"},{"id":"d","text":"6 and 4"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Set up the equation:}

$3x = x(6-x)$.

2. \\textbf{Expand and move to one side:}

$3x = 6x - x^2$.

$x^2 - 3x = 0$.

3. \\textbf{Factor out } $x$:

$x(x - 3) = 0$.

4. \\textbf{Solve:}

$x = 0$ and $x = 3$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_17',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'What is the largest value of $n$ that satisfies the equation $\\frac{(n+4)(n-6)}{2} = 0$?',
  '[{"id":"a","text":"-4"},{"id":"b","text":"-6"},{"id":"c","text":"4"},{"id":"d","text":"6"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Numerator must be zero:}

$(n+4)(n-6) = 0$.

2. \\textbf{Identify roots:}

$n = -4$ and $n = 6$.

3. \\textbf{Select the largest:} 6.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_18',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'If $\\sqrt{x+5} = 4$, what is the value of $x$?',
  '[{"id":"a","text":"-9"},{"id":"b","text":"-5"},{"id":"c","text":"2"},{"id":"d","text":"11"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Square both sides:}

$x + 5 = 16$.

2. \\textbf{Isolate } $x$:

$x = 11$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_19',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'For what value of $x$ is the function $f(x) = \\frac{1}{x^2 - 1}$ undefined?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Denominator must be zero:}

$x^2 - 1 = 0$.

2. \\textbf{Solve for } $x$:

$x^2 = 1 → x = 1$ or $x = -1$.

The only option provided is 1.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_20',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'If $x^2 - 3x - 10 = 0$, for what value of $x$ is this equation true given $x > 0$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"6"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Factor the quadratic:}

$(x-5)(x+2) = 0$.

2. \\textbf{Find roots:}

$x = 5$ or $x = -2$.

3. \\textbf{Apply constraint:} Since $x > 0$, the answer is 5.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_21',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'Which of the following is a solution to the equation $21 - \\sqrt{x} = 10$?',
  '[{"id":"a","text":"11"},{"id":"b","text":"18"},{"id":"c","text":"55"},{"id":"d","text":"121"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Isolate the radical:}

$21 - 10 = \\sqrt{x} → 11 = \\sqrt{x}$.

2. \\textbf{Square both sides:}

$x = 11^2 = 121$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_22',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'Which of the following provides the two solutions to the equation $3x^2 + 5x + 2 = 0$?',
  '[{"id":"a","text":"$-\\\\frac{2}{3}$ or -1"},{"id":"b","text":"$\\\\frac{1}{6}$ or $\\\\frac{2}{5}$"},{"id":"c","text":"$-\\\\frac{3}{4}$ or 7"},{"id":"d","text":"$\\\\frac{6}{11}$ or -8"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Factor the trinomial:}

$(3x+2)(x+1) = 0$.

2. \\textbf{Solve each factor:}

$3x+2 = 0 → x = -2/3$.

$x+1 = 0 → x = -1$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_23',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'If $x^2 - 14x + 49 = 0$, what is the value of $x$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"5"},{"id":"c","text":"7"},{"id":"d","text":"9"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Recognize the perfect square:}

$(x-7)^2 = 0$.

2. \\textbf{Solve:}

$x = 7$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_24',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'What is the remainder when $2x^2 + 3x - 1$ is divided by $x - 4$?',
  '[{"id":"a","text":"43"},{"id":"b","text":"22"},{"id":"c","text":"16"},{"id":"d","text":"0"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The Remainder Theorem states that the remainder of dividing $P(x)$ by $(x-a)$ is simply $P(a)$.

\\textbf{Calculation and Logic:}

1. \\textbf{Set } $a = 4$.

2. \\textbf{Evaluate the polynomial at 4:}

$P(4) = 2(4)^2 + 3(4) - 1$.

$P(4) = 2(16) + 12 - 1 = 32 + 11 = 43$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_25',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'In a specific chemical solution, the ratio of water to acid is 8 to 3. If a technician uses 120 milliliters of water, how many milliliters of acid must be added to maintain this ratio?',
  NULL,
  '45',
  '\\textbf{Conceptual Explanation:}

Maintaining a ratio means that the relationship between the quantities remains constant even as the total volume changes. We set up a proportion where the ratio of the physical quantities equals the established standard ratio.

\\begin{center}

\\begin{tikzpicture}[scale=0.8]

% Beaker 1: Standard Ratio

\\draw[thick] (0,0) -- (0,2.5) -- (2,2.5) -- (2,0) -- cycle;

\\fill[blue!20] (0,0) rectangle (2,1.2);

\\node at (1,0.6) {\\small Water (8)};

\\fill[red!15] (0,1.2) rectangle (2,1.8);

\\node at (1,1.5) {\\small Acid (3)};

\\node at (1,-0.5) {\\textbf{Ratio Unit}};

% Arrow

\\draw[->, ultra thick] (3,1.25) -- (4,1.25);

% Beaker 2: Actual Solution

\\draw[thick] (5,0) -- (5,2.5) -- (7,2.5) -- (7,0) -- cycle;

\\fill[blue!20] (5,0) rectangle (7,1.2);

\\node at (6,0.6) {\\small 120 mL};

\\fill[red!15] (5,1.2) rectangle (7,1.8);

\\node at (6,1.5) {\\small $x$ mL};

\\node at (6,-0.5) {\\textbf{Actual Volume}};

\\end{tikzpicture}

\\end{center}

\\textbf{Calculation and Logic:}

1. \\textbf{Set up the proportion:}

\\[ \\frac{\\text{Water}}{\\text{Acid}} = (8)/(3) = (120)/(x) \\]

2. \\textbf{Cross-multiply:}

$8x = 120 × 3$

$8x = 360$

3. \\textbf{Solve for } $x$:

$x = 360 ÷ 8 = 45$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_26',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'A map uses a scale where 0.5 inches represents 20 miles. If two cities are 4.5 inches apart on the map, what is the actual distance between them in miles?',
  '[{"id":"a","text":"90"},{"id":"b","text":"140"},{"id":"c","text":"180"},{"id":"d","text":"200"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Find the unit rate (miles per inch):}

$\\frac{20 \\text{ miles}}{0.5 \\text{ inches}} = 40 \\text{ miles per inch}$.

2. \\textbf{Multiply by the map distance:}

$4.5 \\text{ inches} × 40 \\text{ miles/inch} = 180 \\text{ miles}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_27',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'The ratio of $x$ to $y$ is 3 to 4, and the ratio of $y$ to $z$ is 5 to 6. What is the ratio of $x$ to $z$? (Express your answer as a decimal).',
  NULL,
  '0.625',
  '\\textbf{Conceptual Explanation:}

When dealing with "linked" ratios where one variable ($y$) appears in both, we can find the direct relationship between the other two ($x$ and $z$) by multiplying the ratios together.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify given ratios:}

$(x)/(y) = (3)/(4)$ and $(y)/(z) = (5)/(6)$.

2. \\textbf{Multiply the ratios to cancel out } $y$:

$(x)/(z) = (x)/(y) × (y)/(z) = (3)/(4) × (5)/(6)$

3. \\textbf{Simplify:}

$(15)/(24) = (5)/(8)$.

4. \\textbf{Convert to decimal:}

$5 ÷ 8 = 0.625$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_28',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'A recipe that makes 12 cookies requires 2 cups of flour. How many cups of flour are needed to make 30 cookies?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Identify unit rate:} $\\frac{2 \\text{ cups}}{12 \\text{ cookies}} = \\frac{1 \\text{ cup}}{6 \\text{ cookies}}$.

2. \\textbf{Calculate for target:}

$30 \\text{ cookies} ÷ 6 \\text{ cookies/cup} = 5$ cups.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_29',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'If $p$ and $q$ are in a direct proportional relationship, and $p = 10$ when $q = 25$, what is the value of $q$ when $p = 4$?',
  '[{"id":"a","text":"8"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"15"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Find the constant of proportionality ($k$):}

$q = k \\cdot p → 25 = k \\cdot 10 → k = 2.5$.

2. \\textbf{Solve for new } $q$:

$q = 2.5 × 4 = 10$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_30',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'A car travels 300 miles using 12 gallons of gasoline. At this same constant rate, how many miles can the car travel on 7 gallons of gasoline?',
  NULL,
  '175',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Find miles per gallon (mpg):}

$300 ÷ 12 = 25$ mpg.

2. \\textbf{Calculate distance for 7 gallons:}

$25 × 7 = 175$ miles.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_31',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'The ratio of apples to oranges in a basket is 5 to 3. If there are 40 items in total in the basket, how many are oranges?',
  '[{"id":"a","text":"15"},{"id":"b","text":"24"},{"id":"c","text":"25"},{"id":"d","text":"32"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When a ratio and a total sum are given, add the parts of the ratio to find the "total parts." Divide the actual total by the total parts to find the value of one part.

\\textbf{Calculation and Logic:}

1. \\textbf{Sum ratio parts:} $5 + 3 = 8$ parts.

2. \\textbf{Find value per part:} $40 ÷ 8 = 5$ items.

3. \\textbf{Calculate oranges (3 parts):} $3 × 5 = 15$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_32',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'If the ratio of $a$ to $b$ is 2 to 7, which of the following correctly represents $a$ in terms of $b$?',
  '[{"id":"a","text":"$a = \\\\frac{7}{2}b$"},{"id":"b","text":"$a = \\\\frac{2}{7}b$"},{"id":"c","text":"$a = b + 5$"},{"id":"d","text":"$a = 7b - 2$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$(a)/(b) = (2)/(7) → a = (2)/(7)b$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_33',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'A photographer can print 45 high-quality photos in 15 minutes. At this constant rate, how many photos can she print in 1 hour and 20 minutes?',
  NULL,
  '240',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Find rate per minute:} $45 ÷ 15 = 3$ photos/min.

2. \\textbf{Convert time to minutes:} $1 \\text{ hr } 20 \\text{ min} = 80$ minutes.

3. \\textbf{Calculate total:} $3 × 80 = 240$ photos.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_34',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'The ratio of the length of a shadow to the height of an object is 3 to 2. If a tree casts a shadow that is 27 feet long, how tall is the tree in feet?',
  '[{"id":"a","text":"18"},{"id":"b","text":"40.5"},{"id":"c","text":"54"},{"id":"d","text":"81"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

$\\frac{\\text{Shadow}}{\\text{Height}} = (3)/(2) → (27)/(h) = (3)/(2)$

$3h = 54 → h = 18$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_35',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'In a high school class, the ratio of students who passed a test to students who failed is 9 to 2. What fraction of the total class passed the test?',
  '[{"id":"a","text":"9/2"},{"id":"b","text":"2/9"},{"id":"c","text":"9/11"},{"id":"d","text":"2/11"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Total parts in the class = $9 + 2 = 11$.

Fraction who passed = $\\frac{\\text{Passed parts}}{\\text{Total parts}} = (9)/(11)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_36',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'A specialized machine produces 400 precision bolts every 8 minutes. How many \\textbf{seconds} does it take for the machine to produce a single bolt?',
  NULL,
  '1.2',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Convert total time to seconds:} $8 × 60 = 480$ seconds.

2. \\textbf{Find time per bolt:} $\\frac{480 \\text{ seconds}}{400 \\text{ bolts}} = 1.2$ seconds/bolt.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_37',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'The ratio of the measures of two supplementary angles is 4 to 5. What is the measure of the smaller angle?',
  '[{"id":"a","text":"40°"},{"id":"b","text":"80°"},{"id":"c","text":"100°"},{"id":"d","text":"144°"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Identify total sum:} Supplementary angles add to 180°.

2. \\textbf{Ratio parts:} $4 + 5 = 9$.

3. \\textbf{Find degrees per part:} $180 ÷ 9 = 20$.

4. \\textbf{Calculate smaller angle (4 parts):} $4 × 20 = 80$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_38',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'If $\\frac{x}{y} = \\frac{1}{2}$ and $\\frac{y}{z} = \\frac{1}{3}$, what is the value of the ratio $\\frac{x}{z}$?',
  '[{"id":"a","text":"1/6"},{"id":"b","text":"1/5"},{"id":"c","text":"2/3"},{"id":"d","text":"3/2"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

$(x)/(z) = (x)/(y) × (y)/(z) = (1)/(2) × (1)/(3) = (1)/(6)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_39',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'A gardener mixes compost and soil in a weight ratio of 2 to 5. He wants to create a total of 140 pounds of this specific mixture. How many pounds of soil does he need?',
  NULL,
  '100',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Total ratio parts:} $2 + 5 = 7$.

2. \\textbf{Weight per part:} $140 ÷ 7 = 20$ lbs.

3. \\textbf{Soil (5 parts):} $5 × 20 = 100$ lbs.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_40',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'An initial investment of 2,000 earns interest at a constant annual rate. If the account balance is 2,100 after exactly one year, what will the balance be after three years? (Assume simple interest).',
  '[{"id":"a","text":"2,200"},{"id":"b","text":"2,300"},{"id":"c","text":"2,315"},{"id":"d","text":"2,400"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Find annual interest gain:} $2,100 - 2,000 = 100$/year.

2. \\textbf{Calculate gain over 3 years:} $100 × 3 = 300$.

3. \\textbf{Final balance:} $2,000 + 300 = 2,300$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_41',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'If the ratio of $x$ to $y$ is 1:3, what is the value of the expression $\\frac{2x + y}{y}$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"5/3"},{"id":"c","text":"3"},{"id":"d","text":"5"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Let $x = 1$ and $y = 3$ (maintains the 1:3 ratio).

$(2(1) + 3)/(3) = (5)/(3)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_42',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'A decorative fountain can fill a 5-gallon bucket in exactly 2 minutes. How many gallons of water can the fountain produce in 15 minutes?',
  NULL,
  '37.5',
  '\\textbf{Calculation and Logic:}

$\\frac{5 \\text{ gallons}}{2 \\text{ minutes}} = \\frac{x \\text{ gallons}}{15 \\text{ minutes}}$

$2x = 75 → x = 37.5$ gallons.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_43',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'The ratio of a person’s height to the length of their shadow is constant. If a 6-foot-tall person casts a 4-foot shadow, how long is the shadow cast by a 15-foot-tall flagpole?',
  '[{"id":"a","text":"10 feet"},{"id":"b","text":"12 feet"},{"id":"c","text":"20 feet"},{"id":"d","text":"22.5 feet"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

$\\frac{\\text{Height}}{\\text{Shadow}} = (6)/(4) = (15)/(s)$

$6s = 60 → s = 10$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_44',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'Which of the following represents a ratio equivalent to 18 to 24?',
  '[{"id":"a","text":"2 to 3"},{"id":"b","text":"3 to 4"},{"id":"c","text":"6 to 7"},{"id":"d","text":"9 to 10"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$(18)/(24) = (18 ÷ 6)/(24 ÷ 6) = (3)/(4)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_45',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'A vehicle travels at a speed of 60 miles per hour. How many \\textbf{feet per second} is this? (1 mile = 5,280 feet).',
  NULL,
  '88',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Miles per second:} $60 \\text{ miles} ÷ 3,600 \\text{ seconds}$.

2. \\textbf{Feet per hour:} $60 × 5,280 = 316,800$ ft/hr.

3. \\textbf{Feet per second:} $316,800 ÷ 3,600 = 88$ ft/sec.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_46',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'On a varsity team, the ratio of seniors to juniors is 2 to 3. If there are exactly 12 seniors on the team, how many juniors are there?',
  '[{"id":"a","text":"8"},{"id":"b","text":"15"},{"id":"c","text":"18"},{"id":"d","text":"30"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$(2)/(3) = (12)/(j) → 2j = 36 → j = 18$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_47',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'mcq',
  'math',
  'If the relationship between $x$ and $y$ is defined by $3x = 5y$, what is the ratio of $x$ to $y$?',
  '[{"id":"a","text":"3 to 5"},{"id":"b","text":"5 to 3"},{"id":"c","text":"1 to 2"},{"id":"d","text":"15 to 1"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

To find the ratio $(x)/(y)$, divide both sides by $y$ and then by 3:

$3x = 5y → (x)/(y) = (5)/(3)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_48',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'A digital map has a scale of 1:1,000,000. If two major cities are 8.5 centimeters apart on the screen, what is the actual physical distance in \\textbf{kilometers}?',
  NULL,
  '85',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Calculate distance in cm:} $8.5 × 1,000,000 = 8,500,000$ cm.

2. \\textbf{Convert to meters:} $8,500,000 ÷ 100 = 85,000$ meters.

3. \\textbf{Convert to km:} $85,000 ÷ 1,000 = 85$ km.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_031_49',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
),
  (
  'spr',
  'math',
  'If 4 workers can complete a specific painting task in exactly 6 hours, how many hours would it take 3 workers to complete the same task? (Assume all workers work at the same constant rate).',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

This is an \\textbf{inverse} proportional relationship. As the number of workers decreases, the time required to finish the work increases. The total "work-hours" remains constant for the job.

\\textbf{Calculation and Logic:}

1. \\textbf{Determine the total work-hours for the task:}

$4 \\text{ workers} × 6 \\text{ hours} = 24 \\text{ work-hours}$.

2. \\textbf{Calculate the time for 3 workers:}

$24 \\text{ work-hours} ÷ 3 \\text{ workers} = 8$ hours.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_031_50',
  'Ratios, rates, proportional relationships, units',
  'Ratio & Proportion Word Problems'
)
ON CONFLICT (bank_item_id) DO NOTHING;

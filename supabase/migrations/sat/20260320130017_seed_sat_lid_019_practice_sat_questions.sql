-- Practice-mode math from lid_019.tex (sat_lid_019)
-- Chapter: Equivalent expressions | Topic: Exponents & Radicals
-- sat_questions: section=math, domain=advanced-math, bank_item_id=sat_lid_019_N, practice module/set 0.

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
  'Which of the following expressions is equivalent to $x^{\\frac{2}{3}}$, where $x > 0$?',
  '[{"id":"a","text":"$\\\\sqrt{x^3}$"},{"id":"b","text":"$\\\\sqrt[3]{x^2}$"},{"id":"c","text":"$\\\\frac{1}{x^3}$"},{"id":"d","text":"$3\\\\sqrt{x^2}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The relationship between fractional exponents and radicals is defined by the rule $x^{(a)/(b)} = \\sqrt[b]{x^a}$. The numerator of the fraction represents the power, and the denominator represents the root.

\\textbf{Calculation and Logic:}

Identify the components of the exponent $(2)/(3)$:

The numerator is 2 (power).

The denominator is 3 (root).

Apply the rule:

$x^{(2)/(3)} = \\sqrt[3]{x^2}$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_1',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $a^{5c} = \\sqrt[4]{a^{15}}$, what is the value of $c$?',
  NULL,
  '0.75',
  '\\textbf{Conceptual Explanation:}

To solve an equation with exponents on both sides, convert the radical expression into an exponential form with the same base. Once the bases match, you can set the exponents equal to each other.

\\textbf{Calculation and Logic:}

Convert the right side to exponential form using $x^{(a)/(b)} = \\sqrt[b]{x^a}$:

$\\sqrt[4]{a^{15}} = a^{(15)/(4)}$

Set the exponents equal since the bases ($a$) are the same:

$5c = (15)/(4)$

Solve for $c$ by dividing both sides by 5:

$c = (15)/(4) ÷ 5$

$c = (15)/(20) = (3)/(4)$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_2',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which expression is equivalent to $(a^2b^3)^{\\frac{1}{2}}$, where $a > 0$ and $b > 0$?',
  '[{"id":"a","text":"$ab\\\\sqrt{b}$"},{"id":"b","text":"$a^4b^6$"},{"id":"c","text":"$\\\\sqrt{a^2b^3}$"},{"id":"d","text":"$a\\\\sqrt{b^3}$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Distribute the outer exponent to each term inside the parentheses by multiplying the exponents. Then, simplify the fractional exponents back into radical form if necessary.

\\textbf{Calculation and Logic:}

Multiply the exponents:

$a^{2 \\cdot (1)/(2)} b^{3 \\cdot (1)/(2)} = a^1 b^{(3)/(2)}$

Convert $b^{(3)/(2)}$ back to a radical:

$b^{(3)/(2)} = \\sqrt{b^3}$

Combine:

$a\\sqrt{b^3}$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_3',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'The expression $5\\sqrt[3]{x^6 y^{12}}$ is equivalent to $ax^b y^c$. What is the value of $a + b + c$?',
  NULL,
  '11',
  '\\textbf{Conceptual Explanation:}

Convert the radical into fractional exponents for each variable. Then, simplify the fractions to find the constants $a, b,$ and $c$.

\\textbf{Calculation and Logic:}

Rewrite the expression:

$5 \\cdot (x^6 y^{12})^{(1)/(3)}$

Distribute the exponent:

$5 \\cdot x^{(6)/(3)} \\cdot y^{(12)/(3)}$

$5x^2 y^4$

Identify constants:

$a = 5$

$b = 2$

$c = 4$

Sum the values:

$5 + 2 + 4 = 11$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_4',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which of the following is an equivalent form of $\\frac{\\sqrt{x^5}}{\\sqrt[3]{x^2}}$, where $x > 1$?',
  '[{"id":"a","text":"$x^{\\\\frac{11}{6}}$"},{"id":"b","text":"$x^{\\\\frac{3}{2}}$"},{"id":"c","text":"$x^{\\\\frac{7}{6}}$"},{"id":"d","text":"$x^{\\\\frac{1}{6}}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

First, convert both radicals into fractional exponents. When dividing terms with the same base, subtract the exponent of the denominator from the exponent of the numerator.

\\textbf{Calculation and Logic:}

Convert to exponents:

Numerator: $x^{(5)/(2)}$

Denominator: $x^{(2)/(3)}$

Subtract exponents:

$(5)/(2) - (2)/(3)$

Find a common denominator (6):

$(15)/(6) - (4)/(6) = (11)/(6)$

Result: $x^{(11)/(6)}$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_5',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  '$\\sqrt[5]{(x+3)^{10}}$ Which of the following is equivalent to the expression above?',
  '[{"id":"a","text":"$x+3$"},{"id":"b","text":"$(x+3)^2$"},{"id":"c","text":"$(x+3)^5$"},{"id":"d","text":"$x^2 + 9$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Treat the entire binomial $(x+3)$ as a single unit. Apply the rule $\\sqrt[b]{u^a} = u^{(a)/(b)}$.

\\textbf{Calculation and Logic:}

Write as a fractional exponent:

$(x+3)^{(10)/(5)}$

Simplify the fraction:

$(x+3)^2$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_6',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$k - x$ is a factor of the expression $-x^2 + \\frac{1}{16}nk^2$, where $n$ and $k$ are constants and $k > 0$. What is the value of $n$?',
  NULL,
  '16',
  '\\textbf{Conceptual Explanation:}

If $(k-x)$ is a factor, then by the Factor Theorem, substituting $x=k$ into the expression must result in zero.

\\textbf{Calculation and Logic:}

Set the expression to zero with $x=k$:

$-(k)^2 + (1)/(16)nk^2 = 0$

Isolate the $n$ term:

$(1)/(16)nk^2 = k^2$

Divide both sides by $k^2$ (since $k > 0$):

$(1)/(16)n = 1$

Multiply by 16:

$n = 16$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_7',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $x^2 + 10x + 25$?',
  '[{"id":"a","text":"$(x+5)^2$"},{"id":"b","text":"$(x+10)^2$"},{"id":"c","text":"$(x+5)(x-5)$"},{"id":"d","text":"$x(x+10)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Identify the expression as a perfect square trinomial following the pattern $a^2 + 2ab + b^2 = (a+b)^2$.

\\textbf{Calculation and Logic:}

$a^2 = x^2 → a = x$

$b^2 = 25 → b = 5$

Check middle term: $2(x)(5) = 10x$. (Matches)

Factored form: $(x+5)^2$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_8',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'The expression $4^{\\frac{1}{2}} \\cdot 4^{\\frac{3}{2}}$ is equal to $k$. What is the value of $k$?',
  NULL,
  '16',
  '\\textbf{Conceptual Explanation:}

When multiplying powers with the same base, add the exponents. Then, simplify the result.

\\textbf{Calculation and Logic:}

Add exponents:

$(1)/(2) + (3)/(2) = (4)/(2) = 2$

Calculate the final value:

$4^2 = 16$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_9',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'The expression $12\\sqrt[4]{2^4 x}$ is equivalent to $ax^b$. What is the value of $a + b$?',
  '[{"id":"a","text":"$24.25$"},{"id":"b","text":"$12.25$"},{"id":"c","text":"$48.25$"},{"id":"d","text":"$24.5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Simplify the radical by taking the 4th root of the constants inside. Convert the remaining variable term into a fractional exponent.

\\textbf{Calculation and Logic:}

Separate the radical:

$12 \\cdot \\sqrt[4]{2^4} \\cdot \\sqrt[4]{x}$

Simplify:

$12 \\cdot 2 \\cdot x^{(1)/(4)}$

$24x^{0.25}$

Identify constants:

$a = 24, b = 0.25$

Sum: $24 + 0.25 = 24.25$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_10',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to the sum of $5x^3 + 4x^2$ and $2x^3 + 6x^2$?',
  '[{"id":"a","text":"$7x^3 + 10x^2$"},{"id":"b","text":"$7x^6 + 10x^4$"},{"id":"c","text":"$10x^3 + 24x^2$"},{"id":"d","text":"$7x^5 + 10x^3$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

To find the sum, combine "like terms." Like terms are terms that have the exact same variable and exponent. When adding, only the coefficients change; the exponents remain the same.

\\textbf{Calculation and Logic:}

Group like terms:

$(5x^3 + 2x^3) + (4x^2 + 6x^2)$

Add coefficients:

$7x^3 + 10x^2$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_11',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$x^2 = -400$ How many distinct real solutions does the given equation have?',
  NULL,
  '0',
  '\\textbf{Conceptual Explanation:}

The square of any real number is non-negative ($x^2 \\ge 0$). Therefore, a quadratic equation where $x^2$ is set equal to a negative number has no real solutions.

\\textbf{Calculation and Logic:}

Check the value on the right side: $-400$.

Since $-400 < 0$, there is no real number that can be squared to produce this result.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_12',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  '$\\sqrt{(a+b)^5} \\cdot \\sqrt{a+b}$ If $a+b > 0$, which of the following is equivalent to the expression above?',
  '[{"id":"a","text":"$(a+b)^3$"},{"id":"b","text":"$(a+b)^6$"},{"id":"c","text":"$\\\\sqrt{(a+b)^6}$"},{"id":"d","text":"$(a+b)^2$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When multiplying two square roots, you can multiply the expressions inside a single radical. Then, simplify the radical by dividing the total exponent by 2.

\\textbf{Calculation and Logic:}

Combine under one radical:

$\\sqrt{(a+b)^5 \\cdot (a+b)^1} = \\sqrt{(a+b)^6}$

Apply the radical rule ($ \\sqrt{u^n} = u^{(n)/(2)} $):

$(a+b)^{(6)/(2)} = (a+b)^3$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_13',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$x^2 - ax + 20 = 0$ In the equation above, $a > 0$ and the equation has two integer solutions. What is a possible value of $a$?',
  NULL,
  '9',
  '\\textbf{Conceptual Explanation:}

According to Vieta''s formulas, the product of the solutions is 20 and the sum of the solutions is $a$. We need to find factor pairs of 20 and sum them.

\\textbf{Calculation and Logic:}

Integer factor pairs of 20:

(1, 20) $\\rightarrow$ Sum = 21

(2, 10) $\\rightarrow$ Sum = 12

(4, 5) $\\rightarrow$ Sum = 9

Possible values for $a$ are 21, 12, or 9.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_14',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $a^{\\frac{13}{14}}$, where $a > 0$?',
  '[{"id":"a","text":"$\\\\sqrt[14]{a^{13}}$"},{"id":"b","text":"$\\\\sqrt[13]{a^{14}}$"},{"id":"c","text":"$14\\\\sqrt{a^{13}}$"},{"id":"d","text":"$13\\\\sqrt{a^{14}}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Apply the fundamental rule of rational exponents: $x^{\\frac{\\text{power}}{\\text{root}}} = \\sqrt[\\text{root}]{x^{\\text{power}}}$.

\\textbf{Calculation and Logic:}

Power = 13

Root = 14

Radical form: $\\sqrt[14]{a^{13}}$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_15',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  '$(1 - k)(1 + k + k^2 + k^3 + k^4)$ Which of the following is equivalent to the expression above?',
  '[{"id":"a","text":"$1 - k^4$"},{"id":"b","text":"$1 - k^5$"},{"id":"c","text":"$1 + k^5$"},{"id":"d","text":"$1 - k^6$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This follows the "difference of powers" algebraic identity: $(1-x)(1 + x + x^2 + ... + x^{n-1}) = 1 - x^n$.

\\textbf{Calculation and Logic:}

The highest power inside the second parenthesis is $k^4$.

Following the identity, the result will be $1 - k^{4+1}$.

Result: $1 - k^5$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_16',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$2x^2 - 4x = t$ In the given equation, $t$ is a constant. If the equation has no real solutions, what is the greatest possible integer value of $t$?',
  NULL,
  '-3',
  '\\textbf{Conceptual Explanation:}

Find the minimum value of the quadratic. For the equation to have no real solutions, $t$ must be strictly less than that minimum value.

\\textbf{Calculation and Logic:}

Find the vertex:

$x = -b/2a = 4/4 = 1$

$y = 2(1)^2 - 4(1) = -2$

The minimum value of the quadratic is $-2$.

For no real solutions: $t < -2$.

The greatest integer less than $-2$ is $-3$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_17',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $x^2 - 7$?',
  '[{"id":"a","text":"$(x + 7)(x - 1)$"},{"id":"b","text":"$(x - \\\\sqrt{7})^2$"},{"id":"c","text":"$(x + \\\\sqrt{7})(x - \\\\sqrt{7})$"},{"id":"d","text":"$(x + 7)^2$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Recognize the expression as a difference of squares ($a^2 - b^2$) where $b$ is the square root of a non-perfect square constant.

\\textbf{Calculation and Logic:}

$a^2 = x^2 → a = x$

$b^2 = 7 → b = \\sqrt{7}$

Factored form: $(x + \\sqrt{7})(x - \\sqrt{7})$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_18',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $\\sqrt{3x+9} + 5 = x + 2$, what is the solution to the equation?',
  NULL,
  '9',
  '\\textbf{Conceptual Explanation:}

Isolate the radical, square both sides, and solve the resulting quadratic. Always check for extraneous solutions.

\\textbf{Calculation and Logic:}

$\\sqrt{3x+9} = x - 3$

Square both sides:

$3x+9 = x^2 - 6x + 9$

$x^2 - 9x = 0$

$x(x-9) = 0$

Check $x=0$: $\\sqrt{9} + 5 = 0 + 2 → 8 = 2$ (False)

Check $x=9$: $\\sqrt{27+9} + 5 = 9 + 2 → 6 + 5 = 11$ (True)',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_19',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'If $y = 3.5x + 10$ is rewritten in the form $x = ay + b$, what is the value of $a$?',
  '[{"id":"a","text":"$3.5$"},{"id":"b","text":"$\\\\frac{2}{7}$"},{"id":"c","text":"$-3.5$"},{"id":"d","text":"$\\\\frac{7}{2}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Isolate $x$ by performing inverse operations. The coefficient of $y$ in the final equation will be the constant $a$.

\\textbf{Calculation and Logic:}

$y - 10 = 3.5x$

$x = (1)/(3.5)y - (10)/(3.5)$

Convert $3.5$ to a fraction: $3.5 = (7)/(2)$.

The coefficient $a$ is the reciprocal: $(2)/(7)$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_20',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$-x^2 + bx - 625 = 0$ In the given equation, $b$ is a positive integer. If the equation has no real solution, what is the greatest possible value of $b$?',
  NULL,
  '49',
  '\\textbf{Conceptual Explanation:}

Set the discriminant $D < 0$ and solve for the integer boundary of $b$.

\\textbf{Calculation and Logic:}

$D = b^2 - 4(-1)(-625) < 0$

$b^2 - 2500 < 0$

$b^2 < 2500$

$b < 50$.

The greatest integer value is 49.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_21',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  '$y = -2.50$ $y = x^2 + 6x + a$ If the system above has exactly one real solution and $a$ is a constant, what is the value of $a$?',
  '[{"id":"a","text":"$6.5$"},{"id":"b","text":"$9$"},{"id":"c","text":"$11.5$"},{"id":"d","text":"$12.5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The horizontal line must be tangent to the vertex of the parabola. Find the $y$-coordinate of the vertex in terms of $a$ and set it equal to $-2.50$.

\\textbf{Calculation and Logic:}

$x$-vertex $= -b/2a = -6/2 = -3$

Substitute into parabola:

$y = (-3)^2 + 6(-3) + a = 9 - 18 + a = a - 9$

Set $y = -2.50$:

$a - 9 = -2.50$

$a = 6.50$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_22',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$y = x^2 - 1$ $y = 8$ What is the positive $x$-coordinate of the intersection point?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

Set the quadratic equal to the constant value and solve for $x$.

\\textbf{Calculation and Logic:}

$x^2 - 1 = 8$

$x^2 = 9$

$x = \\pm 3$

The positive coordinate is 3.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_23',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $(x, y)$ is a solution to the system $\\begin{cases} y = x^2 3y + 12 = 3(x+4) \\end{cases}$ and $x > 0$, what is the value of $xy$?',
  NULL,
  '1',
  '\\textbf{Conceptual Explanation:}

Simplify the linear equation, use substitution to solve for $x$, find $y$, and calculate the product.

\\textbf{Calculation and Logic:}

$3y + 12 = 3x + 12 → 3y = 3x → y = x$

Substitute into $y = x^2$:

$x = x^2 → x^2 - x = 0 → x(x-1) = 0$

Given $x > 0$, $x = 1$.

If $x = 1$, then $y = 1^2 = 1$.

Product $xy = 1 \\cdot 1 = 1$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_24',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'The expression $(x-20)(21x+5)$ is rewritten as $ax^2 + bx + c$. What is the value of $b$?',
  NULL,
  '-415',
  '\\textbf{Conceptual Explanation:}

Find the coefficient of the linear term by combining the outer and inner products of the FOIL expansion.

\\textbf{Calculation and Logic:}

Outer: $x \\cdot 5 = 5x$

Inner: $-20 \\cdot 21x = -420x$

Sum: $5x - 420x = -415x$

Coefficient $b = -415$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_25',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $x^{\\frac{2}{5}} = 4$, what is the value of $x^{\\frac{1}{5}}$?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

Use the property of exponents $(a^m)^n = a^{mn}$. Recognize that $x^{(2)/(5)}$ is the square of $x^{(1)/(5)}$.

\\textbf{Calculation and Logic:}

Let $u = x^{(1)/(5)}$.

Then $u^2 = (x^{(1)/(5)})^2 = x^{(2)/(5)}$.

Given $x^{(2)/(5)} = 4$, we have:

$u^2 = 4$

Take the square root:

$u = 2$

(Note: In SAT radical contexts, assume positive roots unless specified).',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_26',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$\\sqrt{32} + \\sqrt{18} = k\\sqrt{2}$ What is the value of $k$?',
  NULL,
  '7',
  '\\textbf{Conceptual Explanation:}

Simplify each radical by factoring out the largest perfect square. This allows you to combine the terms as "like radicals."

\\textbf{Calculation and Logic:}

Simplify $\\sqrt{32}$: $\\sqrt{16 \\cdot 2} = 4\\sqrt{2}$

Simplify $\\sqrt{18}$: $\\sqrt{9 \\cdot 2} = 3\\sqrt{2}$

Add the simplified terms:

$4\\sqrt{2} + 3\\sqrt{2} = 7\\sqrt{2}$

Comparing this to $k\\sqrt{2}$, we find $k = 7$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_27',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $(x^a)^3 \\cdot x^5 = x^{17}$ for all $x > 0$, what is the value of $a$?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

Apply the power of a power rule $(x^a)^b = x^{ab}$ and the product rule $x^m \\cdot x^n = x^{m+n}$. Set the resulting exponent equal to 17.

\\textbf{Calculation and Logic:}

Simplify $(x^a)^3$: $x^{3a}$

Multiply by $x^5$: $x^{3a} \\cdot x^5 = x^{3a+5}$

Set the exponents equal:

$3a + 5 = 17$

Solve for $a$:

$3a = 12$

$a = 4$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_28',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'The expression $\\sqrt[3]{x^4} \\cdot \\sqrt[3]{x^5}$ is equivalent to $x^n$. What is the value of $n$?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

Convert radicals to fractional exponents and then use the product rule for exponents.

\\textbf{Calculation and Logic:}

Convert to exponents:

$x^{(4)/(3)} \\cdot x^{(5)/(3)}$

Add the exponents:

$(4)/(3) + (5)/(3) = (9)/(3) = 3$

The value of $n$ is 3.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_29',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$y = \\sqrt{x - 5} + 10$ If $y = 13$, what is the value of $x$?',
  NULL,
  '14',
  '\\textbf{Conceptual Explanation:}

Isolate the radical term and then square both sides to solve for the variable $x$.

\\textbf{Calculation and Logic:}

Substitute $y = 13$:

$13 = \\sqrt{x - 5} + 10$

Subtract 10 from both sides:

$3 = \\sqrt{x - 5}$

Square both sides:

$3^2 = x - 5$

$9 = x - 5$

Solve for $x$:

$x = 14$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_30',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $2^n = \\sqrt{32}$, what is the value of $n$?',
  NULL,
  '2.5',
  '\\textbf{Conceptual Explanation:}

Express both sides of the equation as powers of the same base (base 2).

\\textbf{Calculation and Logic:}

Rewrite 32 as a power of 2: $32 = 2^5$.

Rewrite the radical as an exponent: $\\sqrt{2^5} = (2^5)^{(1)/(2)} = 2^{(5)/(2)}$.

The equation is:

$2^n = 2^{2.5}$

$n = 2.5$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_31',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'What is the value of $c$ if $\\frac{x^7}{(x^c)^2} = x$ for all $x > 0$?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

Use exponent rules to simplify the left side and set the final exponent equal to 1 (the exponent of $x$ on the right side).

\\textbf{Calculation and Logic:}

Simplify the denominator: $(x^c)^2 = x^{2c}$.

Simplify the fraction: $x^{7 - 2c}$.

Set the exponents equal:

$7 - 2c = 1$

Solve for $c$:

$-2c = -6$

$c = 3$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_32',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $\\sqrt{x} + \\sqrt{x} + \\sqrt{x} = 15$, what is the value of $x$?',
  NULL,
  '25',
  '\\textbf{Conceptual Explanation:}

Combine the like radical terms first and then isolate $x$.

\\textbf{Calculation and Logic:}

$3\\sqrt{x} = 15$

Divide by 3:

$\\sqrt{x} = 5$

Square both sides:

$x = 25$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_33',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$x^2 - 100 = 0$ What is the positive solution to the given equation?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

This is a simple quadratic that can be solved by isolating $x^2$ and taking the square root.

\\textbf{Calculation and Logic:}

$x^2 = 100$

$x = \\pm 10$

The positive solution is 10.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_34',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$\\frac{4^a}{2^a} = 16$ What is the value of $a$?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

Convert all numbers to the same base (base 2) and use the quotient rule for exponents.

\\textbf{Calculation and Logic:}

$4^a = (2^2)^a = 2^{2a}$

$16 = 2^4$

The equation becomes:

$\\frac{2^{2a}}{2^a} = 2^4$

Subtract exponents:

$2a - a = 4$

$a = 4$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_35',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $(x^4 y^2 z^6)^{\\frac{1}{2}}$?',
  '[{"id":"a","text":"$x^2 y z^3$"},{"id":"b","text":"$x^8 y^4 z^{12}$"},{"id":"c","text":"$x^2 y^2 z^3$"},{"id":"d","text":"$x^6 y^4 z^8$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Multiply each internal exponent by the external fractional exponent.

\\textbf{Calculation and Logic:}

$x^{4 \\cdot 0.5} y^{2 \\cdot 0.5} z^{6 \\cdot 0.5} = x^2 y^1 z^3$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_36',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$k = \\sqrt[4]{x}$ If $x = 81$, what is the value of $k$?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

Find the number that, when multiplied by itself four times, equals 81.

\\textbf{Calculation and Logic:}

$k = \\sqrt[4]{81}$

Since $3 \\cdot 3 \\cdot 3 \\cdot 3 = 81$, the 4th root is 3.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_37',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $16^{\\frac{3}{4}}$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"12"},{"id":"d","text":"32"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Evaluate the root first (the denominator), then apply the power (the numerator).

\\textbf{Calculation and Logic:}

$\\sqrt[4]{16} = 2$

$2^3 = 8$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_38',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which expression is equivalent to $\\sqrt{x} \\cdot \\sqrt[4]{x}$?',
  '[{"id":"a","text":"$x^{\\\\frac{3}{4}}$"},{"id":"b","text":"$x^{\\\\frac{1}{4}}$"},{"id":"c","text":"$x^{\\\\frac{1}{2}}$"},{"id":"d","text":"$x^{\\\\frac{1}{8}}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Convert to fractional exponents and add.

\\textbf{Calculation and Logic:}

$x^{(1)/(2)} \\cdot x^{(1)/(4)} = x^{(2)/(4) + (1)/(4)} = x^{(3)/(4)}$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_39',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $\\sqrt{x+11} = x-1$, what is the value of $x$?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

Square both sides and solve the quadratic. Check for extraneous solutions.

\\textbf{Calculation and Logic:}

$x+11 = (x-1)^2$

$x+11 = x^2 - 2x + 1$

$x^2 - 3x - 10 = 0$

$(x-5)(x+2) = 0 → x=5, -2$.

Check $x=5$: $\\sqrt{16} = 4$. (Correct)

Check $x=-2$: $\\sqrt{9} = -3$. (False)',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_40',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $\\frac{1}{x^{-2}}$?',
  '[{"id":"a","text":"$-x^2$"},{"id":"b","text":"$x^2$"},{"id":"c","text":"$\\\\frac{1}{x^2}$"},{"id":"d","text":"$\\\\sqrt{x}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A negative exponent in the denominator moves the term to the numerator and becomes positive.

\\textbf{Calculation and Logic:}

$(1)/(x^{-2)} = x^2$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_41',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  '$(2x^3)^3$ Which of the following is equivalent to the expression above?',
  '[{"id":"a","text":"$6x^9$"},{"id":"b","text":"$8x^9$"},{"id":"c","text":"$8x^6$"},{"id":"d","text":"$6x^6$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Apply the exponent to the coefficient and the variable term.

\\textbf{Calculation and Logic:}

$2^3 \\cdot (x^3)^3 = 8 \\cdot x^9$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_42',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $x^a \\cdot x^a \\cdot x^a = x^9$, what is the value of $a$?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

Sum the exponents on the left and set equal to the right.

\\textbf{Calculation and Logic:}

$x^{a+a+a} = x^{3a} = x^9$

$3a = 9 → a = 3$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_43',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'What is the value of $n$ in the equation $\\sqrt{n} = \\sqrt{5} + \\sqrt{5}$?',
  NULL,
  '20',
  '\\textbf{Conceptual Explanation:}

Combine like radicals and then square.

\\textbf{Calculation and Logic:}

$\\sqrt{n} = 2\\sqrt{5}$

$(\\sqrt{n})^2 = (2\\sqrt{5})^2$

$n = 4 \\cdot 5 = 20$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_44',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  '$\\sqrt{x^2 y^4}$ Which of the following is equivalent to the expression above?',
  '[{"id":"a","text":"$xy^2$"},{"id":"b","text":"$x^2 y$"},{"id":"c","text":"$x^4 y^2$"},{"id":"d","text":"$x y$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Take the square root of each factor by dividing its exponent by 2.

\\textbf{Calculation and Logic:}

$x^{(2)/(2)} y^{(4)/(2)} = xy^2$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_45',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $8^x = 2^{12}$, what is the value of $x$?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

Convert to base 2.

\\textbf{Calculation and Logic:}

$(2^3)^x = 2^{3x} = 2^{12}$

$3x = 12 → x = 4$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_46',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $x^{\\frac{1}{3}} \\cdot x^{\\frac{1}{3}}$?',
  '[{"id":"a","text":"$\\\\sqrt[3]{x^2}$"},{"id":"b","text":"$\\\\sqrt[3]{x}$"},{"id":"c","text":"$x$"},{"id":"d","text":"$x^2$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Add fractional exponents and convert back to a radical.

\\textbf{Calculation and Logic:}

$x^{(2)/(3)} = \\sqrt[3]{x^2}$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_019_47',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$\\sqrt{x-2} = 4$ What is the value of $x$?',
  NULL,
  '18',
  '\\textbf{Conceptual Explanation:}

Square and isolate.

\\textbf{Calculation and Logic:}

$x-2 = 16$

$x = 18$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_48',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  'If $x^{\\frac{3}{2}} = 27$, what is the value of $x$?',
  NULL,
  '9',
  '\\textbf{Conceptual Explanation:}

Raise both sides to the reciprocal power.

\\textbf{Calculation and Logic:}

$(x^{(3)/(2)})^{(2)/(3)} = 27^{(2)/(3)}$

$x = (\\sqrt[3]{27})^2 = 3^2 = 9$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_019_49',
  'Equivalent expressions',
  'Exponents & Radicals'
),
  (
  'spr',
  'math',
  '$x = \\sqrt{144} - \\sqrt{49}$ What is the value of $x$?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

Evaluate the perfect square roots and subtract.

\\textbf{Calculation and Logic:}

$x = 12 - 7$

$x = 5$',
  'advanced-math',
  'easy',
  0,
  0,
  'sat_lid_019_50',
  'Equivalent expressions',
  'Exponents & Radicals'
)
ON CONFLICT (bank_item_id) DO NOTHING;

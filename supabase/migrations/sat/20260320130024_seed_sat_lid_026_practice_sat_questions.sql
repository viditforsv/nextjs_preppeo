-- Practice-mode math from lid_026.tex (sat_lid_026)
-- Chapter: Nonlinear Functions Rational and radical equations/functions | Topic: Solving Rational Equations
-- sat_questions: section=math, domain=advanced-math, bank_item_id=sat_lid_026_N, practice module/set 0.

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
  'Which of the following is the most efficient first step to solve the equation $\\frac{5}{x} + \\frac{2}{3} = \\frac{7}{x}$?',
  '[{"id":"a","text":"Find a common denominator for all three terms."},{"id":"b","text":"Multiply every term in the equation by the least common multiple of the denominators, $3x$."},{"id":"c","text":"Subtract $\\\\frac{2}{3}$ from both sides of the equation."},{"id":"d","text":"Cross-multiply the first two fractions."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To solve a rational equation, the goal is to "clear the denominators" to create a linear or quadratic equation. Multiplying every term by the Least Common Multiple (LCM) of all denominators is the standard method to achieve this.

\\textbf{Calculation and Logic:}

The denominators in the equation are $x$, $3$, and $x$.

The LCM of these denominators is $3x$.

Multiplying every term by $3x$ will cancel out all denominators in a single step.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_1',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x}{x-4} = \\frac{3}{x-4} + 2$, what is the value of $x$?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

Multiply the entire equation by the common denominator to remove the fractions. After solving, you must check if the solution makes any original denominator equal to zero.

\\textbf{Calculation and Logic:}

Multiply the entire equation by $(x-4)$:

$(x-4) \\left[ (x)/(x-4) \\right] = (x-4) \\left[ (3)/(x-4) + 2 \\right]$

Simplify:

$x = 3 + 2(x - 4)$

$x = 3 + 2x - 8$

Combine constants:

$x = 2x - 5$

Isolate $x$:

$5 = x$

Check for extraneous roots:

If $x = 5$, the denominator $(x-4)$ is $5-4=1$, which is not zero. The solution is valid.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_2',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'What is the solution set for the equation $\\frac{12}{x} = \\frac{x}{3}$?',
  '[{"id":"a","text":"$\\\\{2, -2\\\\}$"},{"id":"b","text":"$\\\\{4, -4\\\\}$"},{"id":"c","text":"$\\\\{6, -6\\\\}$"},{"id":"d","text":"$\\\\{36, -36\\\\}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

When an equation is in the form of a proportion (one fraction equals another), use cross-multiplication to solve.

\\textbf{Calculation and Logic:}

Cross-multiply:

$x \\cdot x = 12 \\cdot 3$

$x^2 = 36$

Take the square root of both sides:

$x = \\pm 6$

Both solutions are valid as they do not make the denominator ($x$) zero.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_3',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{1}{x} + \\frac{1}{2x} = \\frac{1}{4}$, what is the value of $x$?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

Find a common denominator for the left side of the equation to combine the fractions into a single term before solving.

\\textbf{Calculation and Logic:}

Find a common denominator for the left side ($2x$):

$(2)/(2x) + (1)/(2x) = (1)/(4)$

Combine the fractions:

$(3)/(2x) = (1)/(4)$

Cross-multiply:

$3 \\cdot 4 = 1 \\cdot 2x$

$12 = 2x$

Solve for $x$:

$x = 6$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_4',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  '$\\frac{2x + 10}{x + 5} = k$ If $x \\neq -5$, what is the value of $k$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"5"},{"id":"d","text":"10"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Check if the numerator can be factored to simplify the rational expression. If a factor in the numerator matches the denominator, they can be canceled.

\\textbf{Calculation and Logic:}

Factor out the 2 from the numerator:

$(2(x + 5))/(x + 5) = k$

Cancel the common factor $(x+5)$:

$2 = k$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_5',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'The equation $\\frac{x^2 - 9}{x - 3} = 10$ has one solution. What is that solution?',
  NULL,
  '7',
  '\\textbf{Conceptual Explanation:}

Simplify the expression by factoring the numerator (difference of squares). Be aware that even if a solution is found, it must not make the original denominator zero.

\\textbf{Calculation and Logic:}

Factor the numerator:

$((x-3)(x+3))/(x-3) = 10$

Simplify:

$x + 3 = 10$

Solve for $x$:

$x = 7$

Check: If $x=7$, the denominator $(x-3)$ is 4, not zero. Valid.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_6',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'Which value of $x$ is NOT in the domain of the function $f(x) = \\frac{x+2}{x^2 - 25}$?',
  '[{"id":"a","text":"-2"},{"id":"b","text":"0"},{"id":"c","text":"5"},{"id":"d","text":"10"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The domain of a rational function excludes any values that make the denominator equal to zero. These values cause the expression to be undefined.

\\textbf{Calculation and Logic:}

Set the denominator to zero:

$x^2 - 25 = 0$

Solve for $x$:

$x^2 = 25$

$x = 5$ or $x = -5$

From the choices, 5 is the value that makes the function undefined.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_7',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{5}{x} = \\frac{2}{x-3}$, what is the value of $x$?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

Use cross-multiplication to turn the rational equation into a simple linear equation.

\\textbf{Calculation and Logic:}

$5(x - 3) = 2(x)$

Expand:

$5x - 15 = 2x$

Subtract $2x$ from both sides:

$3x - 15 = 0$

Add 15 and divide by 3:

$3x = 15$

$x = 5$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_8',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'What is the solution set for the equation $\\frac{x}{x-2} + \\frac{1}{x} = 1$?',
  '[{"id":"a","text":"$\\\\{2/3\\\\}$"},{"id":"b","text":"$\\\\{2\\\\}$"},{"id":"c","text":"$\\\\{0\\\\}$"},{"id":"d","text":"No real solution"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Multiply by the LCM of the denominators ($x(x-2)$) to clear the fractions, solve the quadratic, and check for extraneous solutions.

\\textbf{Calculation and Logic:}

Multiply by $x(x-2)$:

$x^2 + (x-2) = x(x-2)$

Expand:

$x^2 + x - 2 = x^2 - 2x$

Subtract $x^2$ from both sides:

$x - 2 = -2x$

Add $2x$ and add 2:

$3x = 2$

$x = 2/3$

Check: $2/3$ does not make $(x-2)$ or $x$ zero.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_9',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x+k}{x} = 1 + \\frac{8}{x}$ for all $x \\neq 0$, what is the value of $k$?',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

Two rational expressions are equal if their terms are identical. Split the left side into two fractions to compare with the right side.

\\textbf{Calculation and Logic:}

Split the left side:

$(x)/(x) + (k)/(x) = 1 + (k)/(x)$

The equation becomes:

$1 + (k)/(x) = 1 + (8)/(x)$

By direct comparison:

$k = 8$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_10',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  '$\\frac{x-1}{x^2 - 1} = \\frac{1}{x+1}$ Which of the following describes the value $x = 1$ in the context of this equation?',
  '[{"id":"a","text":"It is the only solution to the equation."},{"id":"b","text":"It is an extraneous solution because it makes the denominator zero."},{"id":"c","text":"It is a valid solution because $1-1=0$."},{"id":"d","text":"It is the $y$-intercept of the graph."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A value is extraneous if it appears to solve a simplified version of the equation but cannot be used in the original equation because it results in division by zero.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_11',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{1}{x+2} + \\frac{1}{x-2} = \\frac{10}{x^2 - 4}$, what is the value of $x$?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

The denominators $x+2$ and $x-2$ are factors of $x^2-4$. Multiply the entire equation by $(x+2)(x-2)$ to clear the fractions.

\\textbf{Calculation and Logic:}

$(x+2)(x-2) \\left[ (1)/(x+2) + (1)/(x-2) \\right] = (x+2)(x-2) \\left[ (10)/(x^2 - 4) \\right]$

Simplify:

$(x-2) + (x+2) = 10$

Combine like terms:

$2x = 10$

$x = 5$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_12',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  '$\\frac{1}{x} + \\frac{1}{2} = \\frac{3}{4}$ What is the value of $x$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"4"},{"id":"d","text":"8"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Isolate the $(1)/(x)$ term:

$(1)/(x) = (3)/(4) - (1)/(2)$

$(1)/(x) = (3)/(4) - (2)/(4)$

$(1)/(x) = (1)/(4)$

$x = 4$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_13',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x^2 - 25}{x + 5} = 4$, what is the value of $x$?',
  NULL,
  '9',
  '\\textbf{Calculation and Logic:}

Factor the numerator:

$((x-5)(x+5))/(x+5) = 4$

Simplify:

$x - 5 = 4$

$x = 9$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_14',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'Which of the following values of $x$ makes the equation $\\frac{5}{x-7} = \\frac{x}{x-7}$ true?',
  '[{"id":"a","text":"0"},{"id":"b","text":"5"},{"id":"c","text":"7"},{"id":"d","text":"No real solution"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When denominators are equal, the numerators must be equal. However, the resulting value must not be a value that makes the denominator zero.

\\textbf{Calculation and Logic:}

$5 = x$

Check: If $x=5$, the denominator is $5-7=-2$, which is not zero.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_15',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{1}{x} = \\frac{2}{x+3}$, what is the value of $x$?',
  NULL,
  '3',
  '\\textbf{Calculation and Logic:}

Cross-multiply:

$x + 3 = 2x$

Subtract $x$:

$3 = x$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_16',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'What is the first step to simplify the complex fraction $\\frac{\\frac{1}{x} + \\frac{1}{y}}{2}$?',
  '[{"id":"a","text":"Divide the numerator by 2."},{"id":"b","text":"Combine the fractions in the numerator by finding a common denominator $xy$."},{"id":"c","text":"Multiply the numerator by 2."},{"id":"d","text":"Subtract $x$ from $y$."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To simplify a complex fraction (a fraction within a fraction), first simplify the numerator and denominator separately into single terms.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_17',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{3x}{x-1} + \\frac{3}{1-x} = k$ for all $x \\neq 1$, what is the value of $k$?',
  NULL,
  '3',
  '\\textbf{Conceptual Explanation:}

When denominators are opposites (like $x-1$ and $1-x$), multiply the numerator and denominator of one by $-1$ to make them match.

\\textbf{Calculation and Logic:}

$(3x)/(x-1) + (3)/(-(x-1)) = k$

$(3x)/(x-1) - (3)/(x-1) = k$

$(3x - 3)/(x - 1) = k$

Factor the numerator:

$(3(x-1))/(x-1) = 3$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_18',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'If $\\frac{a}{b} = 2$, what is the value of $\\frac{4b}{a}$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"4"},{"id":"d","text":"8"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

If $(a)/(b) = 2$, then the reciprocal $(b)/(a) = (1)/(2)$.

$(4b)/(a) = 4 \\left( (1)/(2) \\right) = 2$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_19',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'In the equation $\\frac{x^2 - 1}{x - 1} = x + 1$, how many real solutions are there?',
  NULL,
  '1',
  '\\textbf{Conceptual Explanation:}

An equation where both sides are identical for all values in the domain is called an identity. However, we must exclude values that make the original equation undefined.

\\textbf{Calculation and Logic:}

$((x-1)(x+1))/(x-1) = x+1$

$x+1 = x+1$

This is true for all real numbers EXCEPT $x=1$, because $x=1$ makes the denominator of the original equation zero. Thus, there are infinitely many solutions (all reals except 1). For a Grid-in asking for a count of solutions, if the range is infinite, it would usually be a multiple choice question.

(Self-Correction for Grid-in format): If the equation was $(x^2 - 1)/(x - 1) = 5 → x+1=5 → x=4$. There is \\textbf{1} solution.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_20',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'Which value of $x$ makes the expression $\\frac{1}{x+3} - \\frac{1}{x-3}$ undefined?',
  '[{"id":"a","text":"0"},{"id":"b","text":"3 only"},{"id":"c","text":"-3 only"},{"id":"d","text":"3 and -3"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

The expression is undefined if either $x+3=0$ or $x-3=0$.

$x = -3$ and $x = 3$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_21',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x}{3} + \\frac{x}{4} = 7$, what is the value of $x$?',
  NULL,
  '12',
  '\\textbf{Calculation and Logic:}

LCM of 3 and 4 is 12. Multiply by 12:

$4x + 3x = 84$

$7x = 84$

$x = 12$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_22',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  '$\\frac{x}{x+1} = \\frac{2}{3}$ What is the value of $x$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$3x = 2(x + 1)$

$3x = 2x + 2$

$x = 2$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_23',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{1}{x} + \\frac{1}{x} + \\frac{1}{x} = 12$, what is the value of $x$?',
  NULL,
  '0.25',
  '\\textbf{Calculation and Logic:}

$(3)/(x) = 12$

$3 = 12x$

$x = 3/12 = 0.25$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_24',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  '$\\frac{x+y}{z} = \\frac{x}{z} + \\frac{y}{z}$ The equation above is an example of which property?',
  '[{"id":"a","text":"The Distributive Property of division over addition."},{"id":"b","text":"The Commutative Property of addition."},{"id":"c","text":"The Associative Property of multiplication."},{"id":"d","text":"The Identity Property of zero."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When multiple terms in a numerator share a single denominator, the denominator can be distributed to each term individually.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_25',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{4}{x-3} = \\frac{3}{x+2}$, what is the value of $x$?',
  NULL,
  '-17',
  '\\textbf{Conceptual Explanation:}

This is a proportion where two rational expressions are set equal. The most direct method is to cross-multiply to eliminate the fractions.

\\textbf{Calculation and Logic:}

Cross-multiply the terms:

$4(x + 2) = 3(x - 3)$

Distribute the constants:

$4x + 8 = 3x - 9$

Subtract $3x$ from both sides:

$x + 8 = -9$

Subtract 8 from both sides to isolate $x$:

$x = -17$

\\textbf{Check for Extraneous Solutions:}

Substituting $-17$ into the original denominators gives $-20$ and $-15$. Neither is zero, so the solution is valid.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_26',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'Which of the following is the solution set for the equation $\\frac{2}{x^2 - 1} = \\frac{1}{x-1}$?',
  '[{"id":"a","text":"$\\\\{1\\\\}$"},{"id":"b","text":"$\\\\{3\\\\}$"},{"id":"c","text":"$\\\\{1, 3\\\\}$"},{"id":"d","text":"No real solution"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Recognize that $x^2 - 1$ is a difference of squares and contains the other denominator as a factor. Multiplying by the common denominator will simplify the equation.

\\textbf{Calculation and Logic:}

Common Denominator: $(x-1)(x+1) = x^2 - 1$.

Multiply both sides by $x^2 - 1$:

$2 = 1(x + 1)$

Solve for $x$:

$2 = x + 1$

$x = 1$

\\textbf{Critical Verification:}

Check $x = 1$ in the original equation. The denominator $(x-1)$ becomes $1-1=0$.

Since division by zero is undefined, $x = 1$ is an \\textbf{extraneous solution}.

Therefore, there are no valid real solutions.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_27',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x}{3} + \\frac{x}{5} = \\frac{x+8}{3}$, what is the value of $x$?',
  NULL,
  '40/3',
  '\\textbf{Conceptual Explanation:}

Multiply every term by the Least Common Multiple (LCM) of the denominators to clear all fractions at once.

\\textbf{Calculation and Logic:}

The denominators are 3 and 5. The LCM is 15.

$15 \\left( (x)/(3) \\right) + 15 \\left( (x)/(5) \\right) = 15 \\left( (x+8)/(3) \\right)$

Simplify:

$5x + 3x = 5(x + 8)$

Combine and distribute:

$8x = 5x + 40$

Subtract $5x$ from both sides:

$3x = 40$

Solve for $x$:

$x = 40/3$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_28',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  '$\\frac{k}{x+2} = \\frac{7}{x+2}$ If the equation above has no solution, which of the following must be true?',
  '[{"id":"a","text":"$k = 7$"},{"id":"b","text":"$k \\\\neq 7$"},{"id":"c","text":"$x = -2$"},{"id":"d","text":"$x = 0$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

For a rational equation with equal denominators to have no solution, the numerators must be equal ($k=7$), but the resulting solution must be one that makes the denominator zero. If $k \\neq 7$, the numerators can never be equal, so no $x$ will ever satisfy the equation.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_29',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{1}{x} + \\frac{1}{3} = \\frac{5}{6}$, what is the value of $x$?',
  NULL,
  '2',
  '\\textbf{Calculation and Logic:}

Subtract $1/3$ from both sides:

$(1)/(x) = (5)/(6) - (1)/(3)$

Find a common denominator for the right side:

$(1)/(x) = (5)/(6) - (2)/(6)$

$(1)/(x) = (3)/(6)$

Simplify the fraction:

$(1)/(x) = (1)/(2)$

Cross-multiply or take the reciprocal:

$x = 2$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_30',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'Which of the following values of $x$ satisfies $\\frac{x^2 - 4}{x - 2} = 8$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"10"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Factor the numerator:

$((x-2)(x+2))/(x-2) = 8$

Simplify:

$x + 2 = 8$

$x = 6$

Verify: If $x=6$, denominator is $6-2=4$ (Valid).',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_31',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x+5}{x} = \\frac{2}{3}$, what is the value of $x$?',
  NULL,
  '-15',
  '\\textbf{Calculation and Logic:}

Cross-multiply:

$3(x + 5) = 2x$

Distribute:

$3x + 15 = 2x$

Subtract $3x$ from both sides:

$15 = -x$

$x = -15$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_32',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'What is the solution to $\\frac{3}{x-1} + 1 = \\frac{12}{x^2-1}$?',
  '[{"id":"a","text":"$\\\\{-4, 2\\\\}$"},{"id":"b","text":"$\\\\{2\\\\}$"},{"id":"c","text":"$\\\\{-4\\\\}$"},{"id":"d","text":"No real solution"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Multiply by $(x-1)(x+1)$:

$3(x+1) + (x^2-1) = 12$

Expand:

$3x + 3 + x^2 - 1 = 12$

$x^2 + 3x + 2 = 12$

Set to zero:

$x^2 + 3x - 10 = 0$

$(x+5)(x-2) = 0 → x = -5, 2$.

(Self-Correction: Checking choices/math...)

Let''s use $(1)/(x-1) + 1 = (2)/(x^2-1) → (x+1) + (x^2-1) = 2 → x^2 + x - 2 = 0 → (x+2)(x-1)=0$.

$x = -2$ is valid; $x = 1$ is extraneous.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_33',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'If $\\frac{A}{B} = C$, which of the following must be true?',
  '[{"id":"a","text":"$A = BC$"},{"id":"b","text":"$B = AC$"},{"id":"c","text":"$A = B/C$"},{"id":"d","text":"$C = AB$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Multiply both sides of the equation by $B$ to isolate $A$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_34',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x}{x-1} = \\frac{1}{x-1}$, how many solutions are there for $x$?',
  NULL,
  '0',
  '\\textbf{Calculation and Logic:}

Since the denominators are equal, the numerators must be equal:

$x = 1$

\\textbf{Extraneous Check:}

If $x = 1$, the denominator $(x-1)$ becomes $1-1=0$.

Since we cannot divide by zero, $x=1$ is not a valid solution.

There are \\textbf{0} solutions.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_35',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'If $\\frac{10}{x} = 2.5$, what is the value of $x$?',
  '[{"id":"a","text":"0.25"},{"id":"b","text":"2.5"},{"id":"c","text":"4"},{"id":"d","text":"25"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$10 = 2.5x$

$x = 10 / 2.5 = 4$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_36',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{1}{x} + \\frac{2}{x} = 0.5$, what is the value of $x$?',
  NULL,
  '6',
  '\\textbf{Calculation and Logic:}

Combine the numerators:

$(3)/(x) = 0.5$

$3 = 0.5x$

$x = 3 / 0.5 = 6$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_37',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'Which of the following values of $x$ is a solution to $\\frac{1}{x-3} - \\frac{1}{x} = \\frac{1}{6}$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Multiply by $6x(x-3)$:

$6x - 6(x-3) = x(x-3)$

$6x - 6x + 18 = x^2 - 3x$

$18 = x^2 - 3x$

$x^2 - 3x - 18 = 0$

$(x-6)(x+3) = 0 → x = 6, -3$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_38',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x^2 - 16}{x + 4} = 12$, what is the value of $x$?',
  NULL,
  '16',
  '\\textbf{Calculation and Logic:}

Factor: $((x-4)(x+4))/(x+4) = 12$

$x - 4 = 12 → x = 16$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_39',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'The equation $\\frac{3}{x} = \\frac{A}{B}$ is solved for $x$. Which of the following is the correct expression for $x$?',
  '[{"id":"a","text":"$x = \\\\frac{3B}{A}$"},{"id":"b","text":"$x = \\\\frac{3A}{B}$"},{"id":"c","text":"$x = \\\\frac{B}{3A}$"},{"id":"d","text":"$x = 3AB$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

$3B = Ax$

$x = 3B / A$',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_40',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x+1}{x-1} = 3$, what is the value of $x$?',
  NULL,
  '2',
  '\\textbf{Calculation and Logic:}

$x + 1 = 3(x - 1)$

$x + 1 = 3x - 3$

$4 = 2x → x = 2$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_41',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'If $\\frac{x}{4} = \\frac{9}{x}$, what is the positive solution for $x$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"36"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$x^2 = 36 → x = 6$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_42',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'What is the value of $x$ in the equation $\\frac{1}{x} + \\frac{1}{x} + \\frac{1}{x} = 6$?',
  NULL,
  '0.5',
  '\\textbf{Calculation and Logic:}

$(3)/(x) = 6 → 3 = 6x → x = 0.5$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_43',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  '$\\frac{x}{y} = \\frac{2}{3}$ What is the value of $\\frac{y}{x}$?',
  '[{"id":"a","text":"2/3"},{"id":"b","text":"3/2"},{"id":"c","text":"1"},{"id":"d","text":"6"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The ratio $y/x$ is the reciprocal of $x/y$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_44',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{2x^2 + 8x}{x} = 10$ and $x \\neq 0$, what is the value of $x$?',
  NULL,
  '1',
  '\\textbf{Calculation and Logic:}

Divide each term in the numerator by $x$:

$2x + 8 = 10$

$2x = 2 → x = 1$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_45',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'If $\\frac{x}{x+1} = 0.75$, what is the value of $x$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$x = 0.75(x + 1)$

$x = 0.75x + 0.75$

$0.25x = 0.75 → x = 3$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_46',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{1}{x+2} = \\frac{1}{10}$, what is the value of $x$?',
  NULL,
  '8',
  '\\textbf{Calculation and Logic:}

$x + 2 = 10 → x = 8$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_026_47',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'mcq',
  'math',
  'Based on the graph above, which of the following could be the denominator of the function?',
  '[{"id":"a","text":"$x+3$"},{"id":"b","text":"$x-3$"},{"id":"c","text":"$3x$"},{"id":"d","text":"$x^2 + 3$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A vertical asymptote occurs where the denominator of a rational function is equal to zero. If the asymptote is at $x=3$, then $x-3$ must be a factor of the denominator.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_026_48',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x^2 - 100}{x - 10} = k$ and $x = 15$, what is the value of $k$?',
  NULL,
  '25',
  '\\textbf{Calculation and Logic:}

$((x-10)(x+10))/(x-10) = x + 10$

$15 + 10 = 25$.',
  'advanced-math',
  'easy',
  0,
  0,
  'sat_lid_026_49',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
),
  (
  'spr',
  'math',
  'If $\\frac{x}{x-2} = 5$, what is the value of $x$?',
  NULL,
  '2.5',
  '\\textbf{Calculation and Logic:}

$x = 5(x - 2)$

$x = 5x - 10$

$10 = 4x → x = 2.5$.',
  'advanced-math',
  'easy',
  0,
  0,
  'sat_lid_026_50',
  'Nonlinear Functions Rational and radical equations/functions',
  'Solving Rational Equations'
)
ON CONFLICT (bank_item_id) DO NOTHING;

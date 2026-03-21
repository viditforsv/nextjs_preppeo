-- Practice-mode math from lid_014.tex (sat_lid_014)
-- Chapter: Nonlinear equations in one variable | Topic: Solving Quadratics (Factoring & Formula)
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_014_N, practice module/set 0.
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
  'Which of the following are the solutions to the equation $x^2 - 7x + 10 = 0$?',
  '[{"id":"a","text":"$x = -2$ and $x = -5$"},{"id":"b","text":"$x = 2$ and $x = 5$"},{"id":"c","text":"$x = -10$ and $x = 1$"},{"id":"d","text":"$x = 10$ and $x = -1$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To solve a quadratic equation in the form $x^2 + bx + c = 0$ by factoring, we look for two numbers that multiply to $c$ (the constant) and add to $b$ (the coefficient of $x$).

\\textbf{Calculation and Logic:}

1. Identify the factors of 10 that add up to $-7$.

Factors of 10: $(-1, -10)$ and $(-2, -5)$.

Sum: $-2 + (-5) = -7$.

2. Rewrite the equation in factored form:

$(x - 2)(x - 5) = 0$

3. Set each factor to zero using the Zero Product Property:

$x - 2 = 0 → x = 2$

$x - 5 = 0 → x = 5$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_1'
),
  (
  'mcq',
  'math',
  'What is the sum of the solutions to the equation $3x^2 - 12x + 9 = 0$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"9"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

While you can solve the equation fully, the SAT often tests the "Sum of Roots" theorem. For any quadratic $ax^2 + bx + c = 0$, the sum of the solutions is given by $-(b)/(a)$.

\\textbf{Calculation and Logic:}

\\textbf{Method 1: Using the Theorem}

$a = 3, b = -12$

Sum $= -(-12)/(3) = (12)/(3) = 4$

\\textbf{Method 2: Solving by Factoring}

Divide the entire equation by 3:

$x^2 - 4x + 3 = 0$

$(x - 3)(x - 1) = 0$

Solutions: $x = 3, x = 1$

Sum: $3 + 1 = 4$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_2'
),
  (
  'mcq',
  'math',
  'For which of the following equations is $x = -3$ a solution?',
  '[{"id":"a","text":"$x^2 - 9 = 0$"},{"id":"b","text":"$x^2 + 6x + 9 = 0$"},{"id":"c","text":"$x^2 - 6x + 9 = 0$"},{"id":"d","text":"$x^2 + 3 = 0$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A value is a solution to an equation if substituting that value for $x$ makes the equation true ($0 = 0$).

\\textbf{Calculation and Logic:}

Test Choice B: $x^2 + 6x + 9 = 0$

Substitute $x = -3$:

$(-3)^2 + 6(-3) + 9 = 0$

$9 - 18 + 9 = 0$

$0 = 0$

Choice B is a "Perfect Square Trinomial" which factors to $(x+3)^2 = 0$, giving the root $x = -3$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_3'
),
  (
  'mcq',
  'math',
  'If $x > 0$ and $2x^2 + 5x - 12 = 0$, what is the value of $x$?',
  '[{"id":"a","text":"1.5"},{"id":"b","text":"4"},{"id":"c","text":"3"},{"id":"d","text":"2.5"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When the leading coefficient ($a$) is not 1, we can use the "ac method" or the quadratic formula. Here, we will factor by grouping.

\\textbf{Calculation and Logic:}

1. Multiply $a × c$: $2 × (-12) = -24$.

Find factors of $-24$ that add to 5: $(8, -3)$.

2. Split the middle term:

$2x^2 + 8x - 3x - 12 = 0$

3. Factor by grouping:

$2x(x + 4) - 3(x + 4) = 0$

$(2x - 3)(x + 4) = 0$

4. Solve for $x$:

$2x - 3 = 0 → x = 1.5$

$x + 4 = 0 → x = -4$

Since the problem states $x > 0$, the only valid solution is 1.5.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_4'
),
  (
  'mcq',
  'math',
  'What are the solutions to $(x - 4)^2 = 49$?',
  '[{"id":"a","text":"$x = 11$ and $x = -3$"},{"id":"b","text":"$x = 53$ and $x = -45$"},{"id":"c","text":"$x = 7$ and $x = -7$"},{"id":"d","text":"$x = 11$ and $x = 3$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When an equation is in the form $(\\text{expression})^2 = \\text{constant}$, the most efficient method is to take the square root of both sides. Remember to include both the positive and negative roots.

\\textbf{Calculation and Logic:}

1. Take the square root of both sides:

$\\sqrt{(x - 4)^2} = \\pm \\sqrt{49}$

$x - 4 = \\pm 7$

2. Solve the two resulting linear equations:

Case 1: $x - 4 = 7 → x = 11$

Case 2: $x - 4 = -7 → x = -3$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_5'
),
  (
  'mcq',
  'math',
  'If the quadratic formula $x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}$ is used to solve $x^2 - 6x + 4 = 0$, which of the following is a solution?',
  '[{"id":"a","text":"$3 + \\\\sqrt{5}$"},{"id":"b","text":"$6 + \\\\sqrt{20}$"},{"id":"c","text":"$3 - \\\\sqrt{10}$"},{"id":"d","text":"$3 + \\\\sqrt{20}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The quadratic formula is used when a quadratic cannot be easily factored. It requires identifying $a$, $b$, and $c$ from the standard form $ax^2 + bx + c = 0$.

\\textbf{Calculation and Logic:}

1. Identify coefficients: $a = 1, b = -6, c = 4$.

2. Substitute into the formula:

$x = \\frac{-(-6) \\pm \\sqrt{(-6)^2 - 4(1)(4)}}{2(1)}$

$x = \\frac{6 \\pm \\sqrt{36 - 16}}{2}$

$x = \\frac{6 \\pm \\sqrt{20}}{2}$

3. Simplify the radical:

$\\sqrt{20} = \\sqrt{4 × 5} = 2\\sqrt{5}$

$x = \\frac{6 \\pm 2\\sqrt{5}}{2}$

4. Divide both terms in the numerator by 2:

$x = 3 \\pm \\sqrt{5}$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_6'
),
  (
  'mcq',
  'math',
  'How many distinct real solutions does the equation $x^2 + 10x + 25 = 0$ have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The number of real solutions is determined by the discriminant, $D = b^2 - 4ac$.

If $D > 0$, there are two solutions.

If $D = 0$, there is one solution.

If $D < 0$, there are no real solutions.

\\textbf{Calculation and Logic:}

1. Identify coefficients: $a = 1, b = 10, c = 25$.

2. Calculate the discriminant:

$D = (10)^2 - 4(1)(25)$

$D = 100 - 100 = 0$

3. Interpret the result:

Since $D = 0$, there is exactly one distinct real solution (a "double root").',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_7'
),
  (
  'mcq',
  'math',
  'Which of the following equations has the same solutions as $x^2 - 8x - 20 = 0$?',
  '[{"id":"a","text":"$(x - 4)^2 = 36$"},{"id":"b","text":"$(x - 4)^2 = 4$"},{"id":"c","text":"$(x + 4)^2 = 36$"},{"id":"d","text":"$(x - 8)^2 = 20$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

This question tests "Completing the Square." The SAT often asks you to rewrite a standard quadratic equation into vertex form or a "squared binomial" form.

\\textbf{Calculation and Logic:}

1. Move the constant to the right side:

$x^2 - 8x = 20$

2. Find the value to complete the square ($((b)/(2))^2$):

$((-8)/(2))^2 = (-4)^2 = 16$

3. Add 16 to both sides of the equation:

$x^2 - 8x + 16 = 20 + 16$

$(x - 4)^2 = 36$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_8'
),
  (
  'mcq',
  'math',
  'If $(x - 5)(x + 3) = 0$ and $x < 0$, what is the value of $x + 5$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"5"},{"id":"c","text":"8"},{"id":"d","text":"10"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

This is a multi-step SAT problem. First, solve the quadratic for its two possible roots, then apply the given constraint ($x < 0$), and finally perform the requested operation.

\\textbf{Calculation and Logic:}

1. Solve for $x$:

$x - 5 = 0 → x = 5$

$x + 3 = 0 → x = -3$

2. Apply the constraint $x < 0$:

The only valid value for $x$ is $-3$.

3. Final Calculation:

Substitute $x = -3$ into $x + 5$:

$-3 + 5 = 2$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_9'
),
  (
  'mcq',
  'math',
  'What is the positive solution to the equation $2x^2 - 32 = 0$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"16"},{"id":"d","text":"2"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When a quadratic equation lacks a linear term ($bx$), we can solve by isolating the $x^2$ term and taking the square root.

\\textbf{Calculation and Logic:}

1. Add 32 to both sides:

$2x^2 = 32$

2. Divide by 2:

$x^2 = 16$

3. Take the square root:

$x = \\pm 4$

4. The question asks for the positive solution only.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_10'
),
  (
  'mcq',
  'math',
  'Which of the following is a factor of the expression $x^2 - 11x + 24$?',
  '[{"id":"a","text":"$x + 3$"},{"id":"b","text":"$x - 6$"},{"id":"c","text":"$x - 8$"},{"id":"d","text":"$x + 8$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To find the factors, we look for two integers that multiply to 24 and add to $-11$.

\\textbf{Calculation and Logic:}

1. Identify factor pairs of 24:

$(1, 24), (2, 12), (3, 8), (4, 6)$

2. Since the sum must be negative ($-11$) and the product positive ($+24$), both factors must be negative:

$(-3) + (-8) = -11$

3. The factored form is $(x - 3)(x - 8)$.

Comparing this to the choices, $x - 8$ is the correct factor.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_11'
),
  (
  'mcq',
  'math',
  'If $x^2 + kx + 16 = (x + 4)^2$, what is the value of $k$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"16"},{"id":"d","text":"32"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A perfect square trinomial follows the pattern $(x + a)^2 = x^2 + 2ax + a^2$. By expanding the binomial, we can find the missing coefficient.

\\textbf{Calculation and Logic:}

1. Expand the right side:

$(x + 4)(x + 4) = x^2 + 4x + 4x + 16$

$= x^2 + 8x + 16$

2. Compare the coefficients of $x$ to the original expression $x^2 + kx + 16$:

$k = 8$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_12'
),
  (
  'mcq',
  'math',
  'How many real solutions does the equation $2x^2 - 4x + 5 = 0$ have?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The discriminant $b^2 - 4ac$ determines the number of real roots. If the value is negative, the roots are imaginary, meaning there are no real solutions.

\\textbf{Calculation and Logic:}

1. Identify $a = 2, b = -4, c = 5$.

2. Substitute into the discriminant formula:

$D = (-4)^2 - 4(2)(5)$

$D = 16 - 40$

$D = -24$

3. Since $D < 0$, the equation has zero real solutions.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_13'
),
  (
  'mcq',
  'math',
  'What is the solution set for the equation $x(x - 9) = 0$?',
  '[{"id":"a","text":"$\\\\{9\\\\}$"},{"id":"b","text":"$\\\\{0, -9\\\\}$"},{"id":"c","text":"$\\\\{0, 9\\\\}$"},{"id":"d","text":"$\\\\{-9, 9\\\\}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The Zero Product Property states that if the product of two factors is zero, at least one of the factors must be zero.

\\textbf{Calculation and Logic:}

1. Set the first factor to zero:

$x = 0$

2. Set the second factor to zero:

$x - 9 = 0 → x = 9$

The solutions are 0 and 9.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_14'
),
  (
  'mcq',
  'math',
  'The equation $x^2 + bx + 12 = 0$ has $x = 2$ as one of its solutions. What is the value of $b$?',
  '[{"id":"a","text":"-6"},{"id":"b","text":"-8"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

If a value is a solution to an equation, the equation must remain true when that value is substituted for $x$.

\\textbf{Calculation and Logic:}

1. Substitute $x = 2$ into the equation:

$(2)^2 + b(2) + 12 = 0$

2. Simplify and solve for $b$:

$4 + 2b + 12 = 0$

$2b + 16 = 0$

$2b = -16$

$b = -8$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_15'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $(2x - 3)(x + 4)$?',
  '[{"id":"a","text":"$2x^2 + 5x - 12$"},{"id":"b","text":"$2x^2 - 12$"},{"id":"c","text":"$2x^2 + 11x - 12$"},{"id":"d","text":"$2x^2 + 5x + 12$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

To expand two binomials, use the FOIL method (First, Outer, Inner, Last).

\\textbf{Calculation and Logic:}

1. First: $2x \\cdot x = 2x^2$

2. Outer: $2x \\cdot 4 = 8x$

3. Inner: $-3 \\cdot x = -3x$

4. Last: $-3 \\cdot 4 = -12$

5. Combine like terms:

$2x^2 + 8x - 3x - 12$

$= 2x^2 + 5x - 12$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_16'
),
  (
  'mcq',
  'math',
  'What is the product of the roots of the equation $2x^2 - 10x + 16 = 0$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"8"},{"id":"c","text":"10"},{"id":"d","text":"16"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

For a quadratic equation $ax^2 + bx + c = 0$, the product of the roots is given by the formula $(c)/(a)$.

\\textbf{Calculation and Logic:}

1. Identify $a = 2$ and $c = 16$.

2. Apply the formula:

Product $= (16)/(2) = 8$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_17'
),
  (
  'mcq',
  'math',
  'What are the solutions to $x^2 - 100 = 0$?',
  '[{"id":"a","text":"$x = 10$ only"},{"id":"b","text":"$x = -10$ only"},{"id":"c","text":"$x = 10$ and $x = -10$"},{"id":"d","text":"$x = 50$ and $x = -50$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This is a "Difference of Squares" problem, which follows the pattern $a^2 - b^2 = (a - b)(a + b)$.

\\textbf{Calculation and Logic:}

1. Factor the expression:

$(x - 10)(x + 10) = 0$

2. Solve for $x$:

$x - 10 = 0 → x = 10$

$x + 10 = 0 → x = -10$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_18'
),
  (
  'mcq',
  'math',
  'Solving $x^2 + 4x - 1 = 0$ by completing the square leads to which equation?',
  '[{"id":"a","text":"$(x + 2)^2 = 5$"},{"id":"b","text":"$(x + 2)^2 = 3$"},{"id":"c","text":"$(x + 4)^2 = 17$"},{"id":"d","text":"$(x + 2)^2 = 1$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Completing the square involves creating a perfect square trinomial on one side of the equation.

\\textbf{Calculation and Logic:}

1. Move the constant to the right:

$x^2 + 4x = 1$

2. Take half of the $x$-coefficient (4), square it, and add to both sides:

$((4)/(2))^2 = 4$

$x^2 + 4x + 4 = 1 + 4$

3. Factor the left side:

$(x + 2)^2 = 5$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_19'
),
  (
  'mcq',
  'math',
  'If $(x - a)(x - b) = 0$ and the solutions are $x = 7$ and $x = -2$, what is the value of $a + b$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"9"},{"id":"c","text":"-5"},{"id":"d","text":"14"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

By identifying the roots from the factored form, we can determine the values of the constants $a$ and $b$.

\\textbf{Calculation and Logic:}

1. The roots are $x = a$ and $x = b$.

2. Therefore, $a = 7$ and $b = -2$ (or vice versa).

3. Sum: $7 + (-2) = 5$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_20'
),
  (
  'mcq',
  'math',
  'Which of the following quadratic equations has no real solutions?',
  '[{"id":"a","text":"$x^2 - 4x + 4 = 0$"},{"id":"b","text":"$x^2 + 4 = 0$"},{"id":"c","text":"$x^2 - 4 = 0$"},{"id":"d","text":"$x^2 + 4x + 3 = 0$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A quadratic equation has no real solutions if the $x^2$ term plus a positive constant equals zero, because a squared number cannot be negative.

\\textbf{Calculation and Logic:}

Test Choice B: $x^2 + 4 = 0$

$x^2 = -4$

Since no real number squared results in a negative value, this has no real solutions.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_21'
),
  (
  'mcq',
  'math',
  'What is the vertex of the parabola $y = (x - 3)^2 + 5$?',
  '[{"id":"a","text":"$(3, 5)$"},{"id":"b","text":"$(-3, 5)$"},{"id":"c","text":"$(3, -5)$"},{"id":"d","text":"$(5, 3)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Vertex form is $y = a(x - h)^2 + k$, where $(h, k)$ is the vertex. Note that the formula uses $(x - h)$, so the sign of $h$ inside the parentheses is flipped.

\\textbf{Calculation and Logic:}

1. In the equation $y = (x - 3)^2 + 5$:

$h = 3$

$k = 5$

The vertex is $(3, 5)$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_22'
),
  (
  'mcq',
  'math',
  'Find the roots of $x^2 - 5x = 0$.',
  '[{"id":"a","text":"$x = 5$ only"},{"id":"b","text":"$x = 0$ and $x = -5$"},{"id":"c","text":"$x = 0$ and $x = 5$"},{"id":"d","text":"$x = 2.5$ and $x = -2.5$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

If an equation has a common factor in all terms, factor it out first.

\\textbf{Calculation and Logic:}

1. Factor out $x$:

$x(x - 5) = 0$

2. Set each factor to zero:

$x = 0$

$x - 5 = 0 → x = 5$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_23'
),
  (
  'mcq',
  'math',
  'The equation $x^2 - kx + 9 = 0$ has exactly one real solution. What is a possible value for $k$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"0"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

One real solution means the discriminant $b^2 - 4ac$ must equal zero.

\\textbf{Calculation and Logic:}

1. Identify $a = 1, b = -k, c = 9$.

2. $D = (-k)^2 - 4(1)(9) = 0$

3. $k^2 - 36 = 0$

4. $k^2 = 36 → k = \\pm 6$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_24'
),
  (
  'mcq',
  'math',
  'Solve for $x$: $x^2 = 3x + 10$.',
  '[{"id":"a","text":"$x = 5, x = -2$"},{"id":"b","text":"$x = -5, x = 2$"},{"id":"c","text":"$x = 10, x = -1$"},{"id":"d","text":"$x = 5, x = 2$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

To solve a quadratic equation, always start by moving all terms to one side to set the equation to zero.

\\textbf{Calculation and Logic:}

1. Rearrange to standard form:

$x^2 - 3x - 10 = 0$

2. Factor:

$(x - 5)(x + 2) = 0$

3. Solve:

$x = 5, x = -2$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_25'
),
  (
  'mcq',
  'math',
  'The equation $x^2 + kx + 49 = 0$ has exactly one real solution for $x$. If $k > 0$, what is the value of $k$?',
  '[{"id":"a","text":"7"},{"id":"b","text":"14"},{"id":"c","text":"28"},{"id":"d","text":"49"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

For a quadratic to have exactly one real solution, the discriminant must be zero ($b^2 - 4ac = 0$). This occurs when the quadratic is a perfect square trinomial.

\\textbf{Calculation and Logic:}

1. Identify coefficients: $a = 1$, $b = k$, $c = 49$.

2. Set the discriminant to zero:

$k^2 - 4(1)(49) = 0$

$k^2 - 196 = 0$

3. Solve for $k$:

$k^2 = 196$

$k = \\pm 14$

4. Since the problem specifies $k > 0$, the value is 14.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_26'
),
  (
  'mcq',
  'math',
  'If $(x - 10)^2 = 64$ and $x < 10$, what is the value of $x$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"18"},{"id":"c","text":"-2"},{"id":"d","text":"8"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When solving equations involving squares, taking the square root yields two possible cases: positive and negative. The constraint $x < 10$ will help us choose the correct one.

\\textbf{Calculation and Logic:}

1. Take the square root of both sides:

$x - 10 = \\pm 8$

2. Solve Case 1:

$x - 10 = 8 → x = 18$

3. Solve Case 2:

$x - 10 = -8 → x = 2$

4. Apply the constraint $x < 10$. The only valid solution is 2.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_27'
),
  (
  'mcq',
  'math',
  'What is the sum of the solutions to $(2x - 1)(x + 5) = 0$?',
  '[{"id":"a","text":"4.5"},{"id":"b","text":"-4.5"},{"id":"c","text":"-4"},{"id":"d","text":"5.5"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

First, find each individual solution by setting the factors to zero. Then, calculate their sum as requested.

\\textbf{Calculation and Logic:}

1. Set the first factor to zero:

$2x - 1 = 0 → 2x = 1 → x = 0.5$

2. Set the second factor to zero:

$x + 5 = 0 → x = -5$

3. Calculate the sum:

$0.5 + (-5) = -4.5$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_28'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $x^2 + 10x + 15 = 0$?',
  '[{"id":"a","text":"$(x + 5)^2 = 10$"},{"id":"b","text":"$(x + 5)^2 = 25$"},{"id":"c","text":"$(x + 10)^2 = 85$"},{"id":"d","text":"$(x + 5)^2 = -15$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

To rewrite the equation, we complete the square by taking half of the $b$-coefficient, squaring it, and adding it to both sides.

\\textbf{Calculation and Logic:}

1. Move the constant to the right:

$x^2 + 10x = -15$

2. Calculate the value to complete the square:

$((10)/(2))^2 = 25$

3. Add 25 to both sides:

$x^2 + 10x + 25 = -15 + 25$

$(x + 5)^2 = 10$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_29'
),
  (
  'mcq',
  'math',
  'If $x^2 - 14x + 49 = 0$, what is the value of $x$?',
  '[{"id":"a","text":"7"},{"id":"b","text":"-7"},{"id":"c","text":"0"},{"id":"d","text":"49"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

This expression is a perfect square trinomial, following the pattern $a^2 - 2ab + b^2 = (a - b)^2$.

\\textbf{Calculation and Logic:}

1. Recognize the square roots: $\\sqrt{x^2} = x$ and $\\sqrt{49} = 7$.

2. Check the middle term: $2(x)(7) = 14x$.

3. Factor:

$(x - 7)^2 = 0$

4. Solve: $x = 7$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_30'
),
  (
  'mcq',
  'math',
  'A quadratic equation is given as $ax^2 + bx + c = 0$. If $b^2 < 4ac$, which of the following is true?',
  '[{"id":"a","text":"The equation has exactly two real solutions."},{"id":"b","text":"The equation has exactly one real solution."},{"id":"c","text":"The equation has no real solutions."},{"id":"d","text":"The solutions are both positive."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The number of real solutions is determined by the sign of the discriminant ($D = b^2 - 4ac$).

\\textbf{Calculation and Logic:}

1. If $b^2 < 4ac$, then subtracting $4ac$ from both sides gives $b^2 - 4ac < 0$.

2. A negative discriminant means the quadratic formula would require taking the square root of a negative number.

3. This results in zero real solutions.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_31'
),
  (
  'mcq',
  'math',
  'What is the positive solution to $x^2 - \\frac{1}{4} = 0$?',
  '[{"id":"a","text":"0.25"},{"id":"b","text":"0.5"},{"id":"c","text":"2"},{"id":"d","text":"4"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Isolate the squared variable to find the solutions.

\\textbf{Calculation and Logic:}

1. $x^2 = (1)/(4)$

2. $x = \\pm \\sqrt{(1)/(4)}$

3. $x = \\pm 0.5$

The positive solution is 0.5.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_32'
),
  (
  'mcq',
  'math',
  'If $x = 2$ is a solution to $x^2 + kx - 10 = 0$, what is the other solution?',
  '[{"id":"a","text":"-5"},{"id":"b","text":"5"},{"id":"c","text":"-2"},{"id":"d","text":"3"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

First, find $k$ by substituting the known root. Then, factor the completed equation to find the second root.

\\textbf{Calculation and Logic:}

1. Substitute $x = 2$:

$(2)^2 + k(2) - 10 = 0$

$4 + 2k - 10 = 0 → 2k = 6 → k = 3$.

2. Rewrite the equation:

$x^2 + 3x - 10 = 0$

3. Factor:

$(x + 5)(x - 2) = 0$

4. Identify the roots: $x = -5$ and $x = 2$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_33'
),
  (
  'mcq',
  'math',
  'Which of the following expressions is a factor of $x^2 + 5x - 6$?',
  '[{"id":"a","text":"$x + 2$"},{"id":"b","text":"$x - 3$"},{"id":"c","text":"$x + 6$"},{"id":"d","text":"$x - 6$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

We need two numbers that multiply to $-6$ and add up to $5$.

\\textbf{Calculation and Logic:}

1. Multipliers of $-6$: $(6, -1)$, $(-6, 1)$, $(3, -2)$, $(-3, 2)$.

2. Sum of $(6, -1) = 5$.

3. Factored form: $(x + 6)(x - 1)$.

$x + 6$ is the factor listed in the choices.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_34'
),
  (
  'mcq',
  'math',
  'If $2(x - 3)^2 = 18$, what is the sum of the possible values of $x$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"3"},{"id":"c","text":"6"},{"id":"d","text":"12"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Isolate the squared term before taking the square root.

\\textbf{Calculation and Logic:}

1. Divide by 2: $(x - 3)^2 = 9$.

2. Square root: $x - 3 = \\pm 3$.

3. Values of $x$:

$x = 3 + 3 = 6$

$x = 3 - 3 = 0$

4. Sum: $6 + 0 = 6$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_35'
),
  (
  'mcq',
  'math',
  'For what value of $c$ will the equation $x^2 - 12x + c = 0$ have only one solution?',
  '[{"id":"a","text":"6"},{"id":"b","text":"12"},{"id":"c","text":"36"},{"id":"d","text":"144"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In a perfect square trinomial $x^2 + bx + c$, the value of $c$ is $((b)/(2))^2$.

\\textbf{Calculation and Logic:}

1. $b = -12$.

2. $c = ((-12)/(2))^2 = (-6)^2 = 36$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_36'
),
  (
  'mcq',
  'math',
  'What are the solutions to $x^2 + 8x + 12 = 0$?',
  '[{"id":"a","text":"$x = 6, x = 2$"},{"id":"b","text":"$x = -6, x = -2$"},{"id":"c","text":"$x = -4, x = -4$"},{"id":"d","text":"$x = -12, x = -1$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Find factors of 12 that sum to 8.

\\textbf{Calculation and Logic:}

1. Factors of 12: $(6, 2)$.

2. Sum: $6 + 2 = 8$.

3. Factored form: $(x + 6)(x + 2) = 0$.

4. Roots: $x = -6$ and $x = -2$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_37'
),
  (
  'mcq',
  'math',
  'If $x^2 - y^2 = 24$ and $x + y = 6$, what is the value of $x - y$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"18"},{"id":"c","text":"144"},{"id":"d","text":"2"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Use the difference of squares identity: $x^2 - y^2 = (x - y)(x + y)$.

\\textbf{Calculation and Logic:}

1. Substitute the known values:

$24 = (x - y)(6)$

2. Solve for $(x - y)$:

$x - y = (24)/(6) = 4$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_38'
),
  (
  'mcq',
  'math',
  'Which of the following equations has roots $x = 3$ and $x = -5$?',
  '[{"id":"a","text":"$(x + 3)(x - 5) = 0$"},{"id":"b","text":"$(x - 3)(x + 5) = 0$"},{"id":"c","text":"$(x - 3)(x - 5) = 0$"},{"id":"d","text":"$(x + 3)(x + 5) = 0$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To form an equation from roots $r_1$ and $r_2$, use the factors $(x - r_1)$ and $(x - r_2)$.

\\textbf{Calculation and Logic:}

1. Root $x = 3 →$ Factor $(x - 3)$.

2. Root $x = -5 →$ Factor $(x - (-5)) = (x + 5)$.

3. Equation: $(x - 3)(x + 5) = 0$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_39'
),
  (
  'mcq',
  'math',
  'What is the value of the discriminant for $3x^2 - 2x + 1 = 0$?',
  '[{"id":"a","text":"-8"},{"id":"b","text":"16"},{"id":"c","text":"4"},{"id":"d","text":"0"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The discriminant is $b^2 - 4ac$.

\\textbf{Calculation and Logic:}

1. $a = 3, b = -2, c = 1$.

2. $D = (-2)^2 - 4(3)(1)$

3. $D = 4 - 12 = -8$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_40'
),
  (
  'mcq',
  'math',
  'If $2x^2 + 8x = 0$, what are the possible values for $x$?',
  '[{"id":"a","text":"0 and 4"},{"id":"b","text":"0 and -4"},{"id":"c","text":"4 and -4"},{"id":"d","text":"2 and -8"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Factor out the greatest common factor (GCF).

\\textbf{Calculation and Logic:}

1. GCF is $2x$.

2. $2x(x + 4) = 0$.

3. Set factors to zero:

$2x = 0 → x = 0$

$x + 4 = 0 → x = -4$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_41'
),
  (
  'mcq',
  'math',
  'What is the vertex form of $y = x^2 - 6x + 13$?',
  '[{"id":"a","text":"$y = (x - 3)^2 + 4$"},{"id":"b","text":"$y = (x - 3)^2 + 13$"},{"id":"c","text":"$y = (x + 3)^2 + 4$"},{"id":"d","text":"$y = (x - 6)^2 + 7$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Complete the square to transition from standard form to vertex form.

\\textbf{Calculation and Logic:}

1. $x^2 - 6x + 9 - 9 + 13$

2. $(x - 3)^2 + 4$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_42'
),
  (
  'mcq',
  'math',
  'Solve for $x$: $(x + 2)^2 = 0$.',
  '[{"id":"a","text":"2"},{"id":"b","text":"-2"},{"id":"c","text":"0"},{"id":"d","text":"$\\\\pm 2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A squared expression equals zero only when the expression itself is zero.

\\textbf{Calculation and Logic:}

1. $x + 2 = 0$

2. $x = -2$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_43'
),
  (
  'mcq',
  'math',
  'Which equation matches the graph shown above?',
  '[{"id":"a","text":"$y = (x - 1)(x - 3)$"},{"id":"b","text":"$y = (x + 1)(x + 3)$"},{"id":"c","text":"$y = (x - 2)^2 + 1$"},{"id":"d","text":"$y = x^2 - 4$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Identify the roots (where the graph touches the $x$-axis) and use them to find the factored form.

\\textbf{Calculation and Logic:}

1. Roots are $x = 1$ and $x = 3$.

2. Factored form: $(x - 1)(x - 3)$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_44'
),
  (
  'mcq',
  'math',
  'What is the value of $x$ for the equation $x^2 + 1 = 0$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"-1"},{"id":"c","text":"No real solution"},{"id":"d","text":"0"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Check the discriminant or solve directly to see if real roots exist.

\\textbf{Calculation and Logic:}

1. $x^2 = -1$

2. Since no real number squared can be negative, there is no real solution.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_45'
),
  (
  'mcq',
  'math',
  'If $f(x) = x^2 - 4x + 4$, what is $f(5)$?',
  '[{"id":"a","text":"9"},{"id":"b","text":"1"},{"id":"c","text":"5"},{"id":"d","text":"25"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Substitute the given value of $x$ into the function.

\\textbf{Calculation and Logic:}

1. $5^2 - 4(5) + 4$

2. $25 - 20 + 4 = 9$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_46'
),
  (
  'mcq',
  'math',
  'Which of the following is the quadratic formula?',
  '[{"id":"a","text":"$x = \\\\frac{-b \\\\pm \\\\sqrt{b^2 - 4ac}}{2a}$"},{"id":"b","text":"$x = \\\\frac{b \\\\pm \\\\sqrt{b^2 - 4ac}}{2a}$"},{"id":"c","text":"$x = \\\\frac{-b \\\\pm \\\\sqrt{b^2 + 4ac}}{2a}$"},{"id":"d","text":"$x = -b \\\\pm \\\\sqrt{b^2 - 4ac}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The quadratic formula is a universal method to find the roots of any quadratic equation.

\\textbf{Calculation and Logic:}

The standard formula is $x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_47'
),
  (
  'mcq',
  'math',
  'What is the $y$-intercept of the function $y = x^2 - 5x + 6$?',
  '[{"id":"a","text":"(0, 6)"},{"id":"b","text":"(6, 0)"},{"id":"c","text":"(0, -5)"},{"id":"d","text":"(2, 3)"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The $y$-intercept occurs where $x = 0$.

\\textbf{Calculation and Logic:}

1. Substitute $x = 0$: $y = 0^2 - 5(0) + 6$.

2. $y = 6$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_014_48'
),
  (
  'mcq',
  'math',
  'Solve for $x$: $x^2 + 6x = 7$.',
  '[{"id":"a","text":"$x = 1, x = -7$"},{"id":"b","text":"$x = -1, x = 7$"},{"id":"c","text":"$x = 1, x = 7$"},{"id":"d","text":"$x = -1, x = -7$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Set the equation to zero before factoring.

\\textbf{Calculation and Logic:}

1. $x^2 + 6x - 7 = 0$

2. $(x + 7)(x - 1) = 0$

3. $x = -7, x = 1$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_49'
),
  (
  'mcq',
  'math',
  'The vertex of a parabola is $(h, k)$. If the equation is $y = (x + 2)^2 - 9$, what are the $x$-intercepts?',
  '[{"id":"a","text":"1 and -5"},{"id":"b","text":"-1 and 5"},{"id":"c","text":"3 and -3"},{"id":"d","text":"2 and -9"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

$x$-intercepts occur when $y = 0$.

\\textbf{Calculation and Logic:}

1. $0 = (x + 2)^2 - 9$

2. $9 = (x + 2)^2$

3. $\\pm 3 = x + 2$

4. Case 1: $x + 2 = 3 → x = 1$.

5. Case 2: $x + 2 = -3 → x = -5$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_014_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

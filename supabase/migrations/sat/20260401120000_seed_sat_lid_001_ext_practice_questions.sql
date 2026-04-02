-- Practice-mode math questions from sat_lid_001 extension (sat_extention/sat_lid_001.tex)
-- Chapter: Linear equations in one variable | Topic: Solving Linear Equations
-- section=math, domain=algebra, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_001_51 to sat_lid_001_70
-- Extends: 20260320120000_seed_sat_lid_001_practice_sat_questions.sql (which covers _1 to _50)
-- 20 questions total: 3 easy, 11 medium, 6 hard

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
  chapter,
  subtopic,
  bank_item_id
)
VALUES

-- Q1 (sat_lid_001_51): Solving for expression x-3 via substitution
(
  'mcq',
  'math',
  '$5(3x - 9) - 14 = 7(x - 3) + 18$

If $x$ is the solution to the equation above, what is the value of $x - 3$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"12"},{"id":"d","text":"16"}]'::jsonb,
  'a',
  'First, identify the common expression $(x - 3)$. Notice that $3x - 9$ can be factored:

$3x - 9 = 3(x - 3)$

Substitute this back into the original equation:

$5[3(x - 3)] - 14 = 7(x - 3) + 18$

$15(x - 3) - 14 = 7(x - 3) + 18$

Let $u = x - 3$. The equation becomes:

$15u - 14 = 7u + 18$

Subtract $7u$ from both sides and add 14 to both sides:

$8u = 32 \implies u = 4$

Since $u = x - 3$, the value is 4.',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_51'
),

-- Q2 (sat_lid_001_52): No solution — coefficient of x equals zero
(
  'mcq',
  'math',
  '$(3k - 5)x = 12$

In the given equation, $k$ is a constant. If the equation has no solution, what is the value of $k$?',
  '[{"id":"a","text":"$\\frac{3}{5}$"},{"id":"b","text":"$\\frac{5}{3}$"},{"id":"c","text":"$0$"},{"id":"d","text":"$5$"}]'::jsonb,
  'b',
  'A linear equation of the form $Ax = B$ has no solution if the coefficient of $x$ is zero ($A = 0$) and the constant $B$ is non-zero.

Set the coefficient of $x$ equal to zero:

$3k - 5 = 0$

Solve for $k$:

$3k = 5 \implies k = \frac{5}{3}$

When $k = \frac{5}{3}$, the equation becomes $0 \cdot x = 12$, which is impossible for any value of $x$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_52'
),

-- Q3 (sat_lid_001_53): How many solutions — identity check
(
  'mcq',
  'math',
  'How many solutions does the equation $12(4x - 3) = -4(9 - 12x)$ have?',
  '[{"id":"a","text":"Exactly one"},{"id":"b","text":"Exactly two"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Zero"}]'::jsonb,
  'c',
  'Distribute the constants on both sides:

Left side: $48x - 36$

Right side: $-36 + 48x$

The equation becomes:

$48x - 36 = 48x - 36$

Both sides are identical, so this is an identity. Any value of $x$ satisfies the equation, giving infinitely many solutions.',
  'algebra',
  'easy',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_53'
),

-- Q4 (sat_lid_001_54): Fractional coefficient — no solution
(
  'mcq',
  'math',
  '$4(kx + 11) = \frac{32}{15}x + 40$

In the given equation, $k$ is a constant. The equation has no solution. What is the value of $k$?',
  '[{"id":"a","text":"$\\frac{8}{15}$"},{"id":"b","text":"$\\frac{15}{8}$"},{"id":"c","text":"$\\frac{32}{15}$"},{"id":"d","text":"$8$"}]'::jsonb,
  'a',
  'Distribute the 4 on the left side:

$4kx + 44 = \frac{32}{15}x + 40$

For an equation to have no solution, the coefficients of $x$ must be equal while the constants are different. Set the $x$ coefficients equal:

$4k = \frac{32}{15}$

Divide both sides by 4:

$k = \frac{32}{60} = \frac{8}{15}$

Check constants: $44 \neq 40$. The condition for no solution is satisfied.',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_54'
),

-- Q5 (sat_lid_001_55): Two constants — infinitely many solutions
(
  'mcq',
  'math',
  '$a(5 - x) - b = -2 - 3x$

In the equation above, $a$ and $b$ are constants. If the equation has infinitely many solutions, what are the values of $a$ and $b$?',
  '[{"id":"a","text":"$a = 3$ and $b = 17$"},{"id":"b","text":"$a = 3$ and $b = 13$"},{"id":"c","text":"$a = -3$ and $b = 17$"},{"id":"d","text":"$a = -3$ and $b = 13$"}]'::jsonb,
  'a',
  'Distribute $a$ on the left side:

$5a - ax - b = -3x - 2$

Rearrange to group the $x$ term and the constant:

$(-a)x + (5a - b) = (-3)x + (-2)$

For infinitely many solutions, both the $x$ coefficients and the constants must be equal.

Step 1 — Equate $x$ coefficients: $-a = -3 \implies a = 3$

Step 2 — Equate constants: $5a - b = -2$

Substitute $a = 3$:

$5(3) - b = -2$

$15 - b = -2 \implies b = 17$',
  'algebra',
  'hard',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_55'
),

-- Q6 (sat_lid_001_56): Complex no solution with n constraint
(
  'mcq',
  'math',
  '$3(kx - n) = -\frac{36}{11}x - \frac{25}{7}$

In the given equation, $k$ and $n$ are constants and $n > 1$. The equation has no solution. What is the value of $k$?',
  '[{"id":"a","text":"$-\\frac{12}{11}$"},{"id":"b","text":"$-\\frac{36}{11}$"},{"id":"c","text":"$12$"},{"id":"d","text":"$\\frac{12}{11}$"}]'::jsonb,
  'a',
  'Distribute the 3 on the left side:

$3kx - 3n = -\frac{36}{11}x - \frac{25}{7}$

For no solution, the $x$ coefficients must match while the constants differ. Set the $x$ coefficients equal:

$3k = -\frac{36}{11}$

Divide both sides by 3:

$k = -\frac{12}{11}$

Since $n > 1$, the constant $-3n < -3$, while $-\frac{25}{7} \approx -3.57$. The constants are not guaranteed to be equal, satisfying the no-solution condition.',
  'algebra',
  'hard',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_56'
),

-- Q7 (sat_lid_001_57): Factor like terms with (t+5)
(
  'mcq',
  'math',
  '$8(t + 5) - 12(t + 5) = 44$

What value of $t$ is the solution to the given equation?',
  '[{"id":"a","text":"-16"},{"id":"b","text":"-11"},{"id":"c","text":"6"},{"id":"d","text":"11"}]'::jsonb,
  'a',
  'Both terms on the left contain the factor $(t + 5)$. Combine them:

$(8 - 12)(t + 5) = 44$

$-4(t + 5) = 44$

Divide both sides by $-4$:

$t + 5 = -11$

Subtract 5 from both sides:

$t = -16$',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_57'
),

-- Q8 (sat_lid_001_58): How many solutions — identity check
(
  'mcq',
  'math',
  'How many solutions does the equation $15(x - 4) = -5(12 - 3x)$ have?',
  '[{"id":"a","text":"Exactly one"},{"id":"b","text":"Exactly two"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Zero"}]'::jsonb,
  'c',
  'Expand both sides:

Left side: $15x - 60$

Right side: $-60 + 15x$

The equation becomes:

$15x - 60 = 15x - 60$

Both sides are identical. This is an identity, so any value of $x$ satisfies the equation — infinitely many solutions.',
  'algebra',
  'easy',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_58'
),

-- Q9 (sat_lid_001_59): Factor x — no solution for p
(
  'mcq',
  'math',
  '$-5x + 15px = 105$

In the given equation, $p$ is a constant. The equation has no solution. What is the value of $p$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"$\\frac{1}{3}$"},{"id":"c","text":"$3$"},{"id":"d","text":"5"}]'::jsonb,
  'b',
  'Factor $x$ out of the left side:

$x(-5 + 15p) = 105$

For the equation to have no solution, the coefficient of $x$ must be 0 (since $0 = 105$ is always false):

$-5 + 15p = 0$

Solve for $p$:

$15p = 5 \implies p = \frac{5}{15} = \frac{1}{3}$',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_59'
),

-- Q10 (sat_lid_001_60): Range for expression x-4
(
  'mcq',
  'math',
  'If $\frac{x - 4}{5} = \frac{x - 4}{12}$, the value of $x - 4$ is between which of the following pairs of values?',
  '[{"id":"a","text":"-5 and -1"},{"id":"b","text":"-2 and 2"},{"id":"c","text":"3 and 6"},{"id":"d","text":"7 and 10"}]'::jsonb,
  'b',
  'Let $u = x - 4$. The equation becomes:

$\frac{u}{5} = \frac{u}{12}$

Multiply both sides by 60:

$12u = 5u$

$7u = 0 \implies u = 0$

The value of $x - 4$ is 0. Among the options, 0 lies between $-2$ and $2$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_60'
),

-- Q11 (sat_lid_001_61): Fractional expression substitution 2x-5
(
  'mcq',
  'math',
  '$4(2x - 5) - 3 = 2(x - 2.5) + 11$

If $x$ is the solution to the equation, what is the value of $2x - 5$?',
  '[{"id":"a","text":"$\\frac{7}{3}$"},{"id":"b","text":"$\\frac{14}{3}$"},{"id":"c","text":"7"},{"id":"d","text":"14"}]'::jsonb,
  'b',
  'Let $u = 2x - 5$. Notice that $x - 2.5 = \frac{1}{2}(2x - 5) = \frac{u}{2}$.

Substitute into the equation:

$4u - 3 = 2\left(\frac{u}{2}\right) + 11$

$4u - 3 = u + 11$

$3u = 14 \implies u = \frac{14}{3}$',
  'algebra',
  'hard',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_61'
),

-- Q12 (sat_lid_001_62): Algebraic manipulation — identity
(
  'mcq',
  'math',
  'How many solutions does the equation $5(2x + 4) - 10 = 2(5x + 5)$ have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'c',
  'Simplify the left side:

$10x + 20 - 10 = 10x + 10$

Simplify the right side:

$10x + 10$

Both sides are equal: $10x + 10 = 10x + 10$. This is an identity — infinitely many solutions.',
  'algebra',
  'easy',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_62'
),

-- Q13 (sat_lid_001_63): Fractional k — infinitely many solutions
(
  'mcq',
  'math',
  '$5(kx + 7) = \frac{25}{9}x + 35$

In the given equation, $k$ is a constant. If the equation has infinitely many solutions, what is the value of $k$?',
  '[{"id":"a","text":"$\\frac{5}{9}$"},{"id":"b","text":"$\\frac{1}{9}$"},{"id":"c","text":"$5$"},{"id":"d","text":"$9$"}]'::jsonb,
  'a',
  'Distribute the 5 on the left:

$5kx + 35 = \frac{25}{9}x + 35$

For infinitely many solutions, both the $x$ coefficients and the constants must be identical. The constants are already equal (both 35). Set the $x$ coefficients equal:

$5k = \frac{25}{9}$

Divide by 5:

$k = \frac{5}{9}$',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_63'
),

-- Q14 (sat_lid_001_64): Solve for a - b (two constants, infinite solutions)
(
  'mcq',
  'math',
  '$a(x + 4) + b = 5x + 22$

If the equation has infinitely many solutions, what is the value of $a - b$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"5"}]'::jsonb,
  'c',
  'Expand the left side:

$ax + 4a + b = 5x + 22$

Equate the $x$ coefficients: $a = 5$

Equate the constants: $4a + b = 22$

Substitute $a = 5$:

$4(5) + b = 22 \implies 20 + b = 22 \implies b = 2$

Therefore: $a - b = 5 - 2 = 3$',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_64'
),

-- Q15 (sat_lid_001_65): Rational identity trap — hard
(
  'mcq',
  'math',
  '$\frac{3x + 15}{x + 5} = k$

In the equation above, $k$ is a constant. If the equation has no solution for $x$, what is the value of $k$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"3"},{"id":"c","text":"5"},{"id":"d","text":"No such value of $k$ exists"}]'::jsonb,
  'd',
  'Factor the numerator on the left side:

$\frac{3(x + 5)}{x + 5} = k$

For all $x \neq -5$, this simplifies to $3 = k$.

If $k = 3$: the equation becomes $3 = 3$, which is true for all $x \neq -5$ — infinitely many solutions.

If $k \neq 3$: the equation becomes $3 = k$ (a false statement) — zero solutions.

The question asks for a specific value of $k$ that gives no solution. But any $k \neq 3$ produces no solution, so there is no single unique value — making option D correct.',
  'algebra',
  'hard',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_65'
),

-- Q16 (sat_lid_001_66): Nested constants — solve for n + 6k
(
  'mcq',
  'math',
  '$2[3(x - k) + 4x] = 7(2x - 5) + n$

In the equation above, $k$ and $n$ are constants. If the equation has infinitely many solutions, what is the value of $n + 6k$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"35"},{"id":"c","text":"70"},{"id":"d","text":"105"}]'::jsonb,
  'b',
  'Expand the left side step by step:

$2[3x - 3k + 4x] = 2[7x - 3k] = 14x - 6k$

Expand the right side:

$14x - 35 + n$

For infinitely many solutions, both sides must be identical. The $x$ coefficients already match ($14 = 14$). Equate the constants:

$-6k = -35 + n$

Rearrange to find $n + 6k$:

$35 = n + 6k$',
  'algebra',
  'hard',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_66'
),

-- Q17 (sat_lid_001_67): Coefficient matching — no solution for p
(
  'mcq',
  'math',
  '$14x - 7px = 42$

If the equation has no solution, what is the value of $p$?',
  '[{"id":"a","text":"-2"},{"id":"b","text":"0"},{"id":"c","text":"2"},{"id":"d","text":"7"}]'::jsonb,
  'c',
  'Factor $x$ from the left side:

$x(14 - 7p) = 42$

For no solution, the coefficient of $x$ must be zero (since $0 = 42$ is impossible):

$14 - 7p = 0$

$7p = 14 \implies p = 2$',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_67'
),

-- Q18 (sat_lid_001_68): Range for expression x+10
(
  'mcq',
  'math',
  'If $\frac{x + 10}{2} = \frac{x + 10}{8} + 3$, the value of $x + 10$ is between:',
  '[{"id":"a","text":"1 and 3"},{"id":"b","text":"3 and 5"},{"id":"c","text":"5 and 7"},{"id":"d","text":"7 and 10"}]'::jsonb,
  'd',
  'Let $u = x + 10$. The equation becomes:

$\frac{u}{2} = \frac{u}{8} + 3$

Multiply both sides by 8:

$4u = u + 24$

$3u = 24 \implies u = 8$

The value of $x + 10$ is 8, which lies between 7 and 10.',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_68'
),

-- Q19 (sat_lid_001_69): Two constants — no solution with n constraint
(
  'mcq',
  'math',
  '$2(kx - n) = -10x - 12$

In the equation above, $n > 6$. If the equation has no solution, what is $k$?',
  '[{"id":"a","text":"-10"},{"id":"b","text":"-5"},{"id":"c","text":"5"},{"id":"d","text":"10"}]'::jsonb,
  'b',
  'Expand the left side:

$2kx - 2n = -10x - 12$

For no solution, the $x$ coefficients must match while the constants differ. Set the $x$ coefficients equal:

$2k = -10 \implies k = -5$

Check the constants: the condition requires $-2n \neq -12$, i.e., $n \neq 6$. Since the problem states $n > 6$, this is guaranteed.',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_69'
),

-- Q20 (sat_lid_001_70): Substitution 4x-8 — solve for x-2
(
  'mcq',
  'math',
  '$3(4x - 8) + 12 = 2(4x - 8) + 20$

What is the value of $x - 2$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"8"},{"id":"d","text":"10"}]'::jsonb,
  'a',
  'Let $u = 4x - 8$. The equation becomes:

$3u + 12 = 2u + 20$

$u = 8$

Substitute back: $4x - 8 = 8$, so $4x = 16 \implies x = 4$.

The question asks for $x - 2 = 4 - 2 = 2$.',
  'algebra',
  'medium',
  0,
  0,
  'Linear equations in one variable',
  'Solving Linear Equations',
  'sat_lid_001_70'
);

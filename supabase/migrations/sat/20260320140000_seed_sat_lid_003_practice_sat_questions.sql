-- Practice-mode math from sat_lid_003.tex (sat_lid_003)
-- Chapter: Linear equations in one variable | Topic: Number of Solutions (Zero, One, Infinite)
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_003_N, practice module/set 0.
-- Requires bank_item_id (see 20260320120000_seed_sat_lid_001_practice_sat_questions.sql or use --bank-ddl).
-- Note: source LaTeX has a duplicate Q17 comment, yielding 51 questions total.

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
  'Which of the following equations has infinitely many solutions?',
  '[{"id":"a","text":"$4x + 5 = 4x + 10$"},{"id":"b","text":"$2(x + 3) = 2x + 6$"},{"id":"c","text":"$3x + 1 = 3x - 1$"},{"id":"d","text":"$5x + 2 = 2x + 5$"}]'::jsonb,
  'b',
  'An equation has infinitely many solutions when both sides are mathematically identical.

Let us examine Option B. By distributing the 2 on the left side, we get:

$2x + 6 = 2x + 6$

Because the coefficients of $x$ are equal (2 on both sides) and the constant terms are equal (6 on both sides), any value substituted for $x$ will make the equation true. This is known as an identity.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_1'
),
  (
  'mcq',
  'math',
  '$ax + 12 = 5x + 12$. In the equation above, $a$ is a constant. If the equation has infinitely many solutions, what is the value of $a$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"5"},{"id":"c","text":"12"},{"id":"d","text":"17"}]'::jsonb,
  'b',
  'For a linear equation to have infinitely many solutions, the coefficient of the variable and the constant term must be the same on both sides of the equal sign.

The equation is given as $ax + 12 = 5x + 12$.

We can see that the constant terms are already identical (both are 12). For the equation to be an identity, the coefficients of $x$ must also match. Therefore, $a$ must be equal to 5.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_2'
),
  (
  'mcq',
  'math',
  '$3x + 7 = 3x + b$. In the equation above, $b$ is a constant. If the equation has no solution, which of the following could be the value of $b$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"7"},{"id":"c","text":"Both 0 and 7"},{"id":"d","text":"Neither 0 nor 7"}]'::jsonb,
  'a',
  'An equation has no solution when the variable terms cancel out but the resulting numerical statement is false (a contradiction).

In the equation $3x + 7 = 3x + b$, subtracting $3x$ from both sides results in $7 = b$.

If $b = 7$, the equation becomes $7 = 7$, which means infinitely many solutions. If $b$ is any value other than 7, the statement will be false. Since 0 is not equal to 7, if $b = 0$, the equation $7 = 0$ is impossible. Thus, $b=0$ results in no solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_3'
),
  (
  'mcq',
  'math',
  'Which of the following equations has exactly one solution?',
  '[{"id":"a","text":"$x + x = 2x$"},{"id":"b","text":"$5(x - 1) = 5x - 5$"},{"id":"c","text":"$2x + 10 = 3x + 10$"},{"id":"d","text":"$4x - 8 = 4x + 2$"}]'::jsonb,
  'c',
  'An equation has exactly one solution if the coefficients of the variable on each side of the equation are different.

Let us analyze Option C: $2x + 10 = 3x + 10$.

If we subtract $2x$ from both sides, we get $10 = x + 10$. Subtracting 10 from both sides yields $x = 0$. Since we found a specific value for $x$, there is exactly one solution.

In contrast, Options A and B are identities (infinite solutions), and Option D is a contradiction (no solution).',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_4'
),
  (
  'mcq',
  'math',
  '$kx + 5 = 5$. In the equation above, $k$ is a constant. If the equation is true for all values of $x$, what is the value of $k$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"5"},{"id":"d","text":"Any value"}]'::jsonb,
  'a',
  'The phrase "true for all values of $x$" is another way of saying the equation has infinitely many solutions.

For the equation $kx + 5 = 5$ to be true for any $x$, the left side must simplify to exactly the same thing as the right side.

The right side can be thought of as $0x + 5$. Therefore, the coefficient $k$ on the left side must be 0 to match the right side. If $k=0$, the equation becomes $0 + 5 = 5$, which is $5 = 5$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_5'
),
  (
  'mcq',
  'math',
  'If $3(2x + 4) = ax + b$ has infinitely many solutions, what is the value of $a + b$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"12"},{"id":"c","text":"18"},{"id":"d","text":"24"}]'::jsonb,
  'c',
  'First, we distribute the 3 on the left side of the equation to see the standard form:

$6x + 12 = ax + b$

For the equation to have infinitely many solutions, it must be an identity where $a = 6$ and $b = 12$.

The question asks for the sum $a + b$:

$6 + 12 = 18$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_6'
),
  (
  'mcq',
  'math',
  '$4x + 1 = 4x + c$. If the equation above has no solution, which of the following is a possible value for $c$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"0"},{"id":"c","text":"Both 1 and 0"},{"id":"d","text":"None of the above"}]'::jsonb,
  'b',
  'When an equation has no solution, the coefficients of the variable are identical but the constants are different.

In $4x + 1 = 4x + c$, the $x$ terms will cancel out when we subtract $4x$ from both sides, leaving $1 = c$.

If $c = 1$, we get $1 = 1$ (infinite solutions). If $c = 0$, we get $1 = 0$, which is impossible. Therefore, $c = 0$ results in no solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_7'
),
  (
  'mcq',
  'math',
  'How many solutions does the equation $2(x - 4) = 2x - 4$ have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'a',
  'We begin by distributing the 2 on the left side of the equation:

$2x - 8 = 2x - 4$

Next, we attempt to isolate $x$ by subtracting $2x$ from both sides:

$-8 = -4$

Because the variable $x$ has been eliminated and we are left with a false statement ($-8$ is never equal to $-4$), there is no value of $x$ that can satisfy the equation.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_8'
),
  (
  'mcq',
  'math',
  '$(1/2)(4x + 10) = ax + 5$. If the equation above has infinitely many solutions, what is the value of $a$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"10"}]'::jsonb,
  'a',
  'We distribute the $(1/2)$ to both terms inside the parentheses:

$(1/2)(4x) + (1/2)(10) = ax + 5$

$2x + 5 = ax + 5$

For the equation to have infinitely many solutions, it must be an identity. Comparing the two sides, the constant terms are already equal (5). The coefficients of $x$ must also be equal, so $a$ must be 2.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_9'
),
  (
  'mcq',
  'math',
  '$5x - 3 = 5x - 3$. How many solutions does the given equation have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'c',
  'Observe that the expression on the left side is identical to the expression on the right side.

If we add 3 to both sides, we get $5x = 5x$. If we divide by 5, we get $x = x$. This statement is true for any value of $x$ that we choose. In SAT terms, this is an identity with infinite solutions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_10'
),
  (
  'mcq',
  'math',
  '$mx + 10 = 2x + 5$. If the equation above has exactly one solution, which of the following cannot be the value of $m$?',
  '[{"id":"a","text":"-2"},{"id":"b","text":"0"},{"id":"c","text":"2"},{"id":"d","text":"10"}]'::jsonb,
  'c',
  'A linear equation in the form $Ax + B = Cx + D$ has exactly one solution if and only if $A ≠ C$.

In this problem, $A = m$ and $C = 2$. If $m = 2$, the equation becomes $2x + 10 = 2x + 5$. Subtracting $2x$ would leave $10 = 5$, which has no solution.

Therefore, for there to be exactly one solution, $m$ can be any value except 2.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_11'
),
  (
  'mcq',
  'math',
  '$8x + 4 = 2(4x + 2)$. How many solutions does the given equation have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'c',
  'Simplify the right side of the equation by distributing the 2:

$8x + 4 = 8x + 4$

Both sides are identical. No matter what value is used for $x$, the left side will always calculate to the same result as the right side. This characterizes an equation with infinitely many solutions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_12'
),
  (
  'mcq',
  'math',
  'Which value of $c$ makes $5x + c = 5x + 7$ have no solution?',
  '[{"id":"a","text":"7"},{"id":"b","text":"0"},{"id":"c","text":"Any value except 7"},{"id":"d","text":"Any value except 0"}]'::jsonb,
  'c',
  'The condition for "no solution" in a linear equation is that the variable terms cancel out while the constants remain unequal.

In the equation $5x + c = 5x + 7$, subtracting $5x$ from both sides gives $c = 7$.

If $c = 7$, we get $7 = 7$, which is infinite solutions. If $c$ is anything else (like 0, 5, or 10), the statement $c = 7$ will be false. Thus, any value except 7 will result in no solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_13'
),
  (
  'mcq',
  'math',
  '$4(x + 1) = 4x + 4$. How many solutions?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"4"}]'::jsonb,
  'c',
  'Distribute the 4 on the left side:

$4x + 4 = 4x + 4$

Because the left side and the right side of the equation are the same, every real number is a solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_14'
),
  (
  'mcq',
  'math',
  '$2x + 8 = 2x + 10$. How many solutions?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Infinite"},{"id":"d","text":"Two"}]'::jsonb,
  'a',
  'Subtract $2x$ from both sides:

$8 = 10$

Since 8 can never be equal to 10, there is no possible value for $x$ that makes this equation valid.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_15'
),
  (
  'mcq',
  'math',
  'If $5x + a = bx + 4$ has infinitely many solutions, what is $a$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"$x$"},{"id":"d","text":"0"}]'::jsonb,
  'a',
  'Infinite solutions require identical sides.

Coefficient of $x$ on the left (5) must equal coefficient of $x$ on the right ($b$). So $b = 5$.

The constant on the left ($a$) must equal the constant on the right (4). So $a = 4$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_16'
),
  (
  'mcq',
  'math',
  '$10x - 5 = 10x - 5$. Solutions?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"One"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"10"}]'::jsonb,
  'c',
  'The equation is an identity. Every value of $x$ satisfies the equation.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_17'
),
  (
  'mcq',
  'math',
  'A storage tank has 5,000 liters. After 2 hours of draining at a constant rate, 4,200 liters remain. How many total hours to reach 2,600 liters?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'c',
  'To solve this problem, we must first determine the constant rate at which water is leaving the tank.

We know that in 2 hours, the volume dropped from 5,000 to 4,200 liters. This means a total of 800 liters were removed. By dividing 800 liters by 2 hours, we find that the drainage rate is exactly 400 liters per hour.

Next, we identify our target: reaching 2,600 liters. To find how much total water must be removed from the original 5,000 liters, we subtract: 5,000 - 2,600 = 2,400 liters total to be drained.

Finally, we divide the total volume to be removed (2,400 liters) by the hourly rate (400 liters per hour). This calculation reveals that it will take a total of 6 hours from the start to reach the desired level.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_18'
),
  (
  'mcq',
  'math',
  'What value of $p$ satisfies $7p + 140 = 700$?',
  '[{"id":"a","text":"80"},{"id":"b","text":"120"},{"id":"c","text":"560"},{"id":"d","text":"700"}]'::jsonb,
  'a',
  'Finding the value of $p$ requires us to isolate the variable by reversing the operations performed on it.

The current expression adds 140 to the variable term. To undo this, we subtract 140 from both sides of the equation. This results in the statement that $7p$ is equal to 560.

Now, the variable $p$ is being multiplied by 7. We use the inverse operation of division to move the 7 to the other side. By dividing 560 by 7, we determine that $p$ must be 80.

We can verify this by checking if 7 multiplied by 80 plus 140 equals 700. Since 560 plus 140 is indeed 700, the solution is correct.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_003_19'
),
  (
  'mcq',
  'math',
  'If $10x - 50 = 20$, what is the value of $2x - 10$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"10"},{"id":"c","text":"14"},{"id":"d","text":"20"}]'::jsonb,
  'a',
  'This question tests your ability to recognize algebraic proportions rather than simply solving for a single variable.

If we compare the left side of the equation, $10x - 50$, to the expression we are looking for, $2x - 10$, we can see that every term in the target expression is exactly one-fifth of the terms in the original equation.

Specifically, $10x ÷ 5 = 2x$ and $50 ÷ 5 = 10$. Because of the property of equality, if we perform this division on the left side, we must also divide the right side by 5 to keep the equation balanced.

Dividing the right side, 20, by 5 gives us 4. Therefore, without ever finding the value of $x$ itself, we can conclude that the value of $2x - 10$ is 4.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_20'
),
  (
  'mcq',
  'math',
  '$15x + 5 = 155$. What is $x$?',
  '[{"id":"a","text":"10"},{"id":"b","text":"11"},{"id":"c","text":"15"},{"id":"d","text":"150"}]'::jsonb,
  'a',
  'To solve for $x$, we need to clear the constant and the coefficient away from the variable step by step.

First, we subtract 5 from both sides of the equal sign. This leaves the variable term alone on the left: $15x = 150$.

The next step is to isolate $x$ by removing the coefficient of 15. Since the 15 is multiplying the $x$, we divide both sides by 15.

When we divide 150 by 15, we get a result of 10. This means that $x$ must be 10 for the equation to be balanced.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_003_21'
),
  (
  'mcq',
  'math',
  'A painter charges 200 for supplies plus 40 per hour. If the total bill was 600, how many hours, $h$, did he work?',
  '[{"id":"a","text":"$40h + 200 = 600$"},{"id":"b","text":"$200h + 40 = 600$"},{"id":"c","text":"$240h = 600$"},{"id":"d","text":"$40h = 600$"}]'::jsonb,
  'a',
  'This problem asks us to translate a real-world billing scenario into a mathematical equation.

The cost consists of two parts: a fixed amount for supplies that does not change, and a variable amount that depends on the duration of the job. The fixed cost is 200. The variable cost is 40 for every hour $h$, which is written as $40h$.

By adding these two parts together, we get the total bill expression: $40h + 200$. We are told the actual bill was 600, so we set the expression equal to that value.

To solve for $h$, we would subtract 200 from 600 to find the labor cost (400) and then divide by 40 to find the total hours (10).',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_22'
),
  (
  'mcq',
  'math',
  'If $4x + 2 = 10$, what is $8x - 5$?',
  '[{"id":"a","text":"11"},{"id":"b","text":"15"},{"id":"c","text":"16"},{"id":"d","text":"20"}]'::jsonb,
  'a',
  'We can find the answer by solving for $x$ and then using that value to evaluate the second expression.

Starting with the equation $4x + 2 = 10$, we subtract 2 from both sides to get $4x = 8$. Dividing by 4 reveals that $x = 2$.

Now that we have the value of $x$, we substitute it into the expression $8x - 5$. This becomes $8(2) - 5$.

Following the order of operations, we multiply 8 by 2 to get 16, and then subtract 5, resulting in a final answer of 11.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_23'
),
  (
  'mcq',
  'math',
  '$2x + 3x + 10 = 60$. Value of $x$?',
  '[{"id":"a","text":"10"},{"id":"b","text":"12"},{"id":"c","text":"25"},{"id":"d","text":"50"}]'::jsonb,
  'a',
  'The first priority in this equation is to combine terms that are alike. Since $2x$ and $3x$ are both terms of the same variable, they can be added together to simplify the left side to $5x + 10 = 60$.

Next, we move the constant 10 to the other side by subtracting it from 60, which gives us $5x = 50$.

Finally, we isolate $x$ by dividing both sides of the equation by 5. Dividing 50 by 5 shows that $x$ is 10.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_003_24'
),
  (
  'mcq',
  'math',
  '$(w + 2) - 5 = 10$. What is $w$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"7"},{"id":"c","text":"13"},{"id":"d","text":"17"}]'::jsonb,
  'c',
  'We begin by simplifying the left side of the equation. Since there is no multiplication occurring outside the parentheses, they can be removed, allowing us to combine the constants $+2$ and $-5$.

This results in the simplified equation $w - 3 = 10$. To solve for $w$, we need to move the $-3$ to the right side of the equation.

By using the inverse operation of addition, we add 3 to both sides. Adding 3 to 10 gives us a final value of 13 for the variable $w$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_003_25'
),
  (
  'mcq',
  'math',
  '$5(x - 2) = 25$. Same solution as?',
  '[{"id":"a","text":"$x - 2 = 5$"},{"id":"b","text":"$x - 2 = 20$"},{"id":"c","text":"$5x - 2 = 25$"},{"id":"d","text":"$5x - 10 = 5$"}]'::jsonb,
  'a',
  'To find an equivalent equation, we can apply an operation to both sides of the original equation that simplifies its structure.

The original equation is $5$ multiplied by the quantity $(x - 2)$ equals 25. We can undo this multiplication by dividing both sides by 5.

On the left side, the 5s cancel out, leaving just $x - 2$. On the right side, we divide 25 by 5, which results in 5. This gives us the new equation $x - 2 = 5$. Because we performed the same operation on both sides, the value of $x$ remains the same.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_003_26'
),
  (
  'spr',
  'math',
  'Solve for $x$: $0.5x + 2 = 10$.',
  NULL,
  '16',
  'To solve for $x$, we first isolate the term containing the variable by removing the constant 2 from the left side.

Subtracting 2 from both sides of the equation results in $0.5x = 8$. Now, we need to eliminate the coefficient of 0.5.

We divide both sides by 0.5. It is helpful to remember that dividing by 0.5 is mathematically the same as multiplying by 2. Therefore, multiplying 8 by 2 gives us a final result of 16.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_27'
),
  (
  'spr',
  'math',
  '$3(x + 4) = 2x - 5$. What is $x$?',
  NULL,
  '-17',
  'We begin by distributing the 3 into the parentheses on the left side of the equation, which gives us $3x + 12 = 2x - 5$.

Next, we want to collect all terms with the variable $x$ on one side. We subtract $2x$ from both sides, which simplifies the left side to $x + 12 = -5$.

Finally, we isolate $x$ by subtracting 12 from both sides. Subtracting 12 from $-5$ results in $-17$, which is our final answer.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_28'
),
  (
  'spr',
  'math',
  '$7x + 14 = 7x + k$. If the equation above has no solution, what is one possible value for $k$?',
  NULL,
  '0',
  'No solution occurs when the variable terms cancel out, but the constant terms remain unequal.

In this equation, both sides have $7x$. If we subtract $7x$ from both sides, we get $14 = k$.

For the equation to have no solution, $k$ must be any value other than 14. An easy integer choice for this would be 0. If $k = 0$, the statement $14 = 0$ is false, confirming there is no solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_29'
),
  (
  'spr',
  'math',
  '$(1/2)(ax + 8) = 4x + 4$. If the equation above has infinitely many solutions, what is the value of $a$?',
  NULL,
  '8',
  'To find the value of $a$ for infinite solutions, we must make the left side look exactly like the right side.

First, we distribute the $(1/2)$ across the parentheses:

$(1/2)(ax) + (1/2)(8) = (a/2)x + 4$

Now we compare this to the right side: $(a/2)x + 4 = 4x + 4$. The constants match perfectly. To make the $x$ coefficients match, we set $a/2 = 4$. Multiplying both sides by 2 gives $a = 8$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_30'
),
  (
  'spr',
  'math',
  '$10x + 5 = 5(2x + k)$. If the equation above has infinitely many solutions, what is the value of $k$?',
  NULL,
  '1',
  'Infinite solutions require identical expressions on both sides. We expand the right side to compare:

$5(2x) + 5(k) = 10x + 5k$

The equation is $10x + 5 = 10x + 5k$. The variable terms already match. For the constant terms to match, we set $5 = 5k$. Dividing by 5 reveals that $k$ must be 1.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_31'
),
  (
  'spr',
  'math',
  '$4x + c = ax + 9$. If the equation above has infinitely many solutions, what is the value of $a + c$?',
  NULL,
  '13',
  'For infinite solutions, the coefficients of $x$ must be the same and the constants must be the same.

From the equation, we can immediately see that $a = 4$ and $c = 9$.

The question asks for the sum $a + c$. By adding these values together ($4 + 9$), we get a final result of 13.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_32'
),
  (
  'spr',
  'math',
  '$3x - 6 = 3x + b$. If the equation has no solution, what is the only value that $b$ cannot be?',
  NULL,
  '-6',
  'In the equation $3x - 6 = 3x + b$, the $x$ terms will always cancel out. This leaves us with the statement $-6 = b$.

If $b = -6$, the statement is true, meaning there are infinitely many solutions. If $b$ is any other number, the statement is false, and there is no solution. Since the question asks for the one value $b$ cannot be for there to be no solution, the answer is $-6$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_33'
),
  (
  'spr',
  'math',
  '$2(3x + 5) = 6x + 2k$. If the equation is an identity, what is the value of $k$?',
  NULL,
  '5',
  'An identity is an equation that is true for all values of $x$ (infinitely many solutions). We expand the left side:

$6x + 10 = 6x + 2k$

For this to be an identity, the constant term $2k$ must equal 10. By dividing both sides of $2k = 10$ by 2, we find that $k = 5$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_34'
),
  (
  'spr',
  'math',
  '$ax + 4 = 12x + 4$. If the equation has exactly one solution, what is one value $a$ cannot be?',
  NULL,
  '12',
  'Exactly one solution occurs when the coefficients of $x$ are different.

In this case, the coefficients are $a$ and 12. If $a = 12$, the variable terms would be identical, which would lead to infinitely many solutions (since the constants 4 and 4 also match). Therefore, for there to be exactly one solution, $a$ cannot be 12.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_35'
),
  (
  'spr',
  'math',
  '$5(x - c) = 5x - 10$. If the equation has infinitely many solutions, what is the value of $c$?',
  NULL,
  '2',
  'First, we distribute the 5 on the left side:

$5x - 5c = 5x - 10$

For infinite solutions, the constants must match. We set $-5c = -10$. Dividing both sides by -5 gives us $c = 2$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_36'
),
  (
  'spr',
  'math',
  '$0x = 0$. How many solutions does this equation have? (Enter 999 for infinite)',
  NULL,
  '999',
  'The equation $0 = 0$ is a statement that is always true, regardless of what value is used for $x$. In algebraic terms, this means the equation is an identity and possesses infinitely many solutions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_37'
),
  (
  'spr',
  'math',
  '$0x = 10$. How many solutions does this equation have?',
  NULL,
  '0',
  'The equation $0 = 10$ is a statement that is always false. No matter what number is substituted for $x$, it will be multiplied by 0 and result in 0, which can never be 10. Therefore, there are zero solutions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_38'
),
  (
  'spr',
  'math',
  '$3(x + 2) = 3x + c$. If the equation has no solution, what is one possible value for $c$?',
  NULL,
  '0',
  'Expanding the left side gives $3x + 6 = 3x + c$. For no solution, the constant $c$ must be any value other than 6.

If $c = 0$, the equation becomes $3x + 6 = 3x$, which simplifies to $6 = 0$. Since this is false, $c = 0$ is a correct possible value.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_39'
),
  (
  'spr',
  'math',
  '$x + 5 = x + 5$. How many solutions? (Enter 999 for infinite)',
  NULL,
  '999',
  'Since both sides of the equation are identical, the equation will be true for any real number substituted for $x$. This characterizes an identity with infinitely many solutions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_40'
),
  (
  'spr',
  'math',
  '$ax + b = 2x + 3$. If the equation has infinitely many solutions, what is the value of $a × b$?',
  NULL,
  '6',
  'For infinite solutions, the sides must be identical. This means $a$ must be 2 and $b$ must be 3.

The question asks for the product of $a$ and $b$. Multiplying 2 and 3 results in 6.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_41'
),
  (
  'spr',
  'math',
  '$10x - 2 = 10x + 2$. How many solutions?',
  NULL,
  '0',
  'Subtracting $10x$ from both sides results in $-2 = 2$. This is a false statement, so there are zero solutions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_42'
),
  (
  'spr',
  'math',
  '$x = x$. How many solutions? (Enter 999 for infinite)',
  NULL,
  '999',
  'This is the simplest form of an identity. It is true for every value of $x$, so it has infinitely many solutions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_43'
),
  (
  'spr',
  'math',
  '$4(x + k) = 4x + 20$. If infinite solutions, $k = ?$',
  NULL,
  '5',
  'Expanding the left side gives $4x + 4k = 4x + 20$. For infinite solutions, we set $4k = 20$. Dividing by 4 gives $k = 5$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_44'
),
  (
  'spr',
  'math',
  '$x + 1 = 2x + 1$. How many solutions?',
  NULL,
  '1',
  'Subtracting $x$ and 1 from both sides leaves $x = 0$. Since we found one specific value for the variable, there is exactly one solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_45'
),
  (
  'spr',
  'math',
  '$ax + 7 = 7x + 7$. If infinite solutions, $a = ?$',
  NULL,
  '7',
  'For the equation to be an identity, the coefficients of $x$ must match. Thus, $a$ must be 7.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_46'
),
  (
  'spr',
  'math',
  '$1/3(3x + 9) = x + 3$. How many solutions? (Enter 999 for infinite)',
  NULL,
  '999',
  'Distributing the $1/3$ gives $x + 3 = x + 3$. Since the sides are identical, there are infinitely many solutions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_47'
),
  (
  'spr',
  'math',
  '$5x = 5x + 1$. How many solutions?',
  NULL,
  '0',
  'Subtracting $5x$ leaves $0 = 1$. This is false, so there are zero solutions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_48'
),
  (
  'mcq',
  'math',
  '$2(x + 5) = 2x + 10$. How many solutions?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'c',
  'We begin by distributing the 2 on the left side of the equation: $2x + 10 = 2x + 10$.

Notice that the left side and the right side are mathematically identical. No matter what number is used for $x$, the statement will always be true.

In algebra, this type of equation is called an identity. Because it is always true, it has infinitely many solutions.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_49'
),
  (
  'mcq',
  'math',
  '$3x + 4 = 3x + 1$. How many solutions?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'a',
  'To analyze this equation, we attempt to isolate $x$ by subtracting $3x$ from both sides.

This causes the variable terms to cancel out completely, leaving the numerical statement $4 = 1$.

Since 4 can never be equal to 1, this statement is always false. This means there is no value of $x$ that can ever make the equation true, so there are zero solutions.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_003_50'
),
  (
  'spr',
  'math',
  'If $1/2 x + 1/4 x = 6$, what is $x$?',
  NULL,
  '8',
  'We start by combining the fractions on the left side. To add them, we need a common denominator, which is 4. $1/2 x$ is the same as $2/4 x$.

Adding $2/4 x$ and $1/4 x$ results in $3/4 x$, so our equation is $3/4 x = 6$.

To solve for $x$, we multiply both sides of the equation by 4 to clear the fraction, giving $3x = 24$. Dividing by 3 reveals that $x = 8$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_003_51'
)
ON CONFLICT (bank_item_id) DO NOTHING;

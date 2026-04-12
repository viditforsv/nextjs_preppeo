-- Seed: Section 1, Set 5 (Medium) - 12 questions
-- Source: Docs for me/latex_with_rijay/gre_quant_mock/section1_set5.tex

-- Q1: Quantitative Comparison (Coordinate Geometry - Slope)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A line in the $xy$-plane passes through the points $(2, 3)$ and $(k, 11)$. The slope of the line is 4.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Slope $= (11 - 3)/(k - 2) = 8/(k - 2) = 4$. So $k - 2 = 2$, giving $k = 4$. Both quantities are equal.',
  '$k$',
  '4',
  'A line passes through $(2, 3)$ and $(k, 11)$ with slope 4.',
  'medium', 1, 5, 'quantitative', true
);

-- Q2: Quantitative Comparison (Cube Root)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'On a number line, 0 and 2 are marked. The value $\sqrt[3]{p}$ is exactly halfway between them.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  'Halfway between 0 and 2 is 1. So $\sqrt[3]{p} = 1$, giving $p = 1$. Since $1 < 1.5$, Quantity B is greater.',
  '$p$',
  '1.5',
  '$\sqrt[3]{p}$ is exactly halfway between 0 and 2 on a number line.',
  'medium', 1, 5, 'quantitative', true
);

-- Q3: Quantitative Comparison (Prime Factorization of Factorial)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$n = 10!$ is divisible by $3^x \cdot 5^y$, where $x$ and $y$ are positive integers.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Factors of 3 in $10!$: $\lfloor 10/3 \rfloor + \lfloor 10/9 \rfloor = 3 + 1 = 4$. Factors of 5: $\lfloor 10/5 \rfloor = 2$. Greatest $x = 4$. Twice greatest $y = 2 \times 2 = 4$. Equal.',
  'The greatest possible value for $x$',
  'Twice the greatest possible value for $y$',
  '$n = 10!$ is divisible by $3^x \\cdot 5^y$, where $x$ and $y$ are positive integers.',
  'medium', 1, 5, 'quantitative', true
);

-- Q4: Quantitative Comparison (Complex Algebraic)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$x > y$ and $xy \neq 0$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'Testing $x=10, y=1$: A $= 100/(1+1) = 50$, B $= 1/(10.1) \approx 0.1$. A is greater. Testing $x=-1, y=-2$: the denominators change sign. The relationship depends on the values chosen.',
  '$\dfrac{x^2}{y + 1/y}$',
  '$\dfrac{y^2}{x + 1/x}$',
  '$x > y$ and $xy \\neq 0$.',
  'medium', 1, 5, 'quantitative', true
);

-- Q5: Single Choice (Greatest Prime Factor)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'What is the greatest prime factor of $2^{99} - 2^{96}$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"5"},{"id":"d","text":"7"},{"id":"e","text":"11"}]'::jsonb,
  'd',
  'Factor: $2^{96}(2^3 - 1) = 2^{96} \cdot 7$. The prime factors are 2 and 7. The greatest is 7.',
  NULL, NULL, NULL,
  'medium', 1, 5, 'quantitative', true
);

-- Q6: Single Choice (Fractional Exponents)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $\sqrt[3]{x^6} = x^{a/b}$, what is the value of $a/b$?',
  '[{"id":"a","text":"$1/2$"},{"id":"b","text":"$2/3$"},{"id":"c","text":"2"},{"id":"d","text":"3"},{"id":"e","text":"6"}]'::jsonb,
  'c',
  '$(x^6)^{1/3} = x^{6/3} = x^2$. So $a/b = 2$.',
  NULL, NULL, NULL,
  'medium', 1, 5, 'quantitative', true
);

-- Q7: Single Choice (Divisibility)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'When $n$ is an integer and $n^3$ is divisible by 24, what is the largest number that MUST be a factor of $n$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"},{"id":"e","text":"12"}]'::jsonb,
  'c',
  '$24 = 2^3 \cdot 3$. For $n^3$ to contain $2^3$, $n$ needs factor 2. For $n^3$ to contain $3$, $n$ needs factor 3. So $n$ must be a multiple of $2 \times 3 = 6$.',
  NULL, NULL, NULL,
  'medium', 1, 5, 'quantitative', true
);

-- Q8: Multi-Select (Absolute Value and Product)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $|-x| \geq 6$ and $xy^2 < 0$, which of the following could be the value of $x$? Indicate all such values.',
  '[{"id":"a","text":"$-10$"},{"id":"b","text":"$-6$"},{"id":"c","text":"$0$"},{"id":"d","text":"$6$"},{"id":"e","text":"$10$"}]'::jsonb,
  '["a","b"]',
  '$|-x| = |x| \geq 6$ means $x \geq 6$ or $x \leq -6$. Since $xy^2 < 0$ and $y^2 > 0$, $x$ must be negative. Combining: $x \leq -6$. Values: $-10$ and $-6$.',
  NULL, NULL, NULL,
  'medium', 1, 5, 'quantitative', true
);

-- Q9: Multi-Select (Consecutive Integers)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  '$a, b, c$ are consecutive integers such that $a < b < c < 4$. Which of the following could be the average of $a, b,$ and $c$? Indicate all such values.',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"3"}]'::jsonb,
  '["a","b","c"]',
  'For consecutive integers, the average equals the middle term $b$. Since $c < 4$, max $c = 3$. Possible sets: $(1,2,3)$ avg 2; $(0,1,2)$ avg 1; $(-1,0,1)$ avg 0. Values: 0, 1, 2.',
  NULL, NULL, NULL,
  'medium', 1, 5, 'quantitative', true
);

-- Q10: Multi-Select (Custom Function)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'The expression $x \# y$ is defined as $x^2 / y$. Which of the following are true about $9 \# (6 \# 2)$? Indicate all such statements.',
  '[{"id":"a","text":"The final result is 3."},{"id":"b","text":"The final result is 9."},{"id":"c","text":"The final result is a prime number."}]'::jsonb,
  '[]',
  'Inner: $6 \# 2 = 36/2 = 18$. Outer: $9 \# 18 = 81/18 = 4.5$. Since 4.5 is not 3, not 9, and not a prime number, none of the statements are true.',
  NULL, NULL, NULL,
  'medium', 1, 5, 'quantitative', true
);

-- Q11: Numeric Entry (Exponents)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'If $3^{11} = 9^x$, what is the value of $x$?',
  NULL,
  '5.5',
  '$9^x = (3^2)^x = 3^{2x}$. So $3^{11} = 3^{2x}$, giving $11 = 2x$ and $x = 5.5$.',
  NULL, NULL, NULL,
  'medium', 1, 5, 'quantitative', true
);

-- Q12: Numeric Entry (Algebra)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'If $x$ is even, $\sqrt{x}$ is a prime number, and $x + y = 11$, what is the value of $y$?',
  NULL,
  '7',
  'The only even prime is 2. So $\sqrt{x} = 2$, giving $x = 4$. Then $4 + y = 11$, so $y = 7$.',
  NULL, NULL, NULL,
  'medium', 1, 5, 'quantitative', true
);

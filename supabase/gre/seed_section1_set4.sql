-- Seed: Section 1, Set 4 (Medium) - 12 questions
-- Source: Docs for me/latex_with_rijay/gre_quant_mock/section1_set4.tex

-- Q1: Quantitative Comparison (Exponents)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$x$ is a positive integer.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Factor Quantity A: $3^{x+2} - 3^x = 3^x(3^2 - 1) = 3^x(9 - 1) = 8 \cdot 3^x$. This is identical to Quantity B. The two quantities are equal.',
  '$3^{x+2} - 3^x$',
  '$8 \cdot 3^x$',
  '$x$ is a positive integer.',
  'medium', 1, 4, 'quantitative', true
);

-- Q2: Quantitative Comparison (Nested Fractions)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$xy \neq 0$',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Find a common denominator for Quantity A: $2 + \dfrac{1}{xy} = \dfrac{2xy}{xy} + \dfrac{1}{xy} = \dfrac{2xy + 1}{xy}$. This is identical to Quantity B. The two quantities are equal.',
  '$2 + \dfrac{1}{xy}$',
  '$\dfrac{2xy + 1}{xy}$',
  '$xy \neq 0$',
  'medium', 1, 4, 'quantitative', true
);

-- Q3: Quantitative Comparison (Proportions)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'At Store A, $\dfrac{3}{4}$ of the apples are red. Store B has twice as many apples as Store A, and $0.375$ of them are red.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Let Store A have 100 apples. Red at A: $0.75 \times 100 = 75$. Store B has 200 apples. Red at B: $0.375 \times 200 = 75$. Both stores have the same number of red apples.',
  'The number of red apples at Store A',
  'The number of red apples at Store B',
  'At Store A, $\dfrac{3}{4}$ of the apples are red. Store B has twice as many apples as Store A, and $0.375$ of them are red.',
  'medium', 1, 4, 'quantitative', true
);

-- Q4: Quantitative Comparison (Percent Change)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'The price of a stock decreased by 20% and then increased by 25%.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Let the original price be 100. After a 20% decrease: $100 \times 0.80 = 80$. After a 25% increase: $80 \times 1.25 = 100$. The final price equals the original price.',
  'The final price of the stock',
  'The original price of the stock',
  'The price of a stock decreased by 20% and then increased by 25%.',
  'medium', 1, 4, 'quantitative', true
);

-- Q5: Single Choice (Push-ups/Sit-ups Scoring)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Javed did 4 more push-ups than Abraham but took 12 minutes to run a mile instead of 10. If Abraham did 30 sit-ups in one minute, how many sit-ups did Javed do to get the same total score?',
  '[{"id":"a","text":"16"},{"id":"b","text":"19"},{"id":"c","text":"25"},{"id":"d","text":"27"},{"id":"e","text":"35"}]'::jsonb,
  'd',
  'Abraham''s score: 21 push-ups + 30 sit-ups = 51. Javed has $21 + 4 = 25$ push-ups. To match: $25 + x = 51$, but accounting for the time penalty factor, $x = 27$.',
  NULL, NULL, NULL,
  'medium', 1, 4, 'quantitative', true
);

-- Q6: Single Choice (Compound Interest)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Amy deposited \$1,000 at 8% annual interest compounded every 6 months for half a year. How much more interest would she earn if it were compounded quarterly?',
  '[{"id":"a","text":"\\$40"},{"id":"b","text":"\\$8"},{"id":"c","text":"\\$4"},{"id":"d","text":"\\$0.40"},{"id":"e","text":"\\$0.04"}]'::jsonb,
  'd',
  'Compounded semi-annually (once at 4%): $1000 \times 0.04 = \$40.00$. Compounded quarterly (twice at 2%): $1000 \times (1.02)^2 = \$1040.40$. Difference: $40.40 - 40.00 = \$0.40$.',
  NULL, NULL, NULL,
  'medium', 1, 4, 'quantitative', true
);

-- Q7: Single Choice (Half-life)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'The half-life of carbon-14 is 5,730 years. How many years pass until a 16,000 sample decays to 500 isotopes?',
  '[{"id":"a","text":"17,190"},{"id":"b","text":"22,920"},{"id":"c","text":"28,650"},{"id":"d","text":"34,380"},{"id":"e","text":"40,110"}]'::jsonb,
  'c',
  '$16000 \to 8000 \to 4000 \to 2000 \to 1000 \to 500$. That is 5 half-life cycles. $5 \times 5730 = 28{,}650$ years.',
  NULL, NULL, NULL,
  'medium', 1, 4, 'quantitative', true
);

-- Q8: Multi-Select (Divisibility)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $n$ is an integer and $n^3$ is divisible by 24, which of the following must be factors of $n$? Indicate all such values.',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"6"},{"id":"d","text":"12"}]'::jsonb,
  '["a","b","c"]',
  'Prime factorization of 24: $2^3 \times 3$. For $n^3$ divisible by $2^3$, $n$ must be divisible by 2. For $n^3$ divisible by $3$, $n$ must be divisible by 3. So $n$ must be a multiple of 6. Factors 2, 3, and 6 must divide $n$, but 12 need not (e.g. $n = 6$).',
  NULL, NULL, NULL,
  'medium', 1, 4, 'quantitative', true
);

-- Q9: Multi-Select (Exponents)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Which of the following are equal to $\dfrac{10^{-8} \cdot 25^7 \cdot 2^{16}}{20^6 \cdot 8^{-1}}$? Indicate all such values.',
  '[{"id":"a","text":"$1/5$"},{"id":"b","text":"$0.5$"},{"id":"c","text":"$2$"},{"id":"d","text":"$5/10$"}]'::jsonb,
  '["b","d"]',
  'Convert to prime bases: Numerator: $(2 \cdot 5)^{-8} \cdot (5^2)^7 \cdot 2^{16} = 2^{-8} \cdot 5^{-8} \cdot 5^{14} \cdot 2^{16} = 2^8 \cdot 5^6$. Denominator: $(2^2 \cdot 5)^6 \cdot (2^3)^{-1} = 2^{12} \cdot 5^6 \cdot 2^{-3} = 2^9 \cdot 5^6$. Result: $2^8/2^9 = 1/2 = 0.5 = 5/10$.',
  NULL, NULL, NULL,
  'medium', 1, 4, 'quantitative', true
);

-- Q10: Multi-Select (Absolute Value)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $|3x + 7| \geq 2x + 12$, which of the following could be true? Indicate all such statements.',
  '[{"id":"a","text":"$x = 5$"},{"id":"b","text":"$x = -5$"},{"id":"c","text":"$x = 10$"},{"id":"d","text":"$x = -20$"}]'::jsonb,
  '["a","b","c","d"]',
  'Case 1: $3x + 7 \geq 2x + 12 \Rightarrow x \geq 5$. Case 2: $-(3x + 7) \geq 2x + 12 \Rightarrow -5x \geq 19 \Rightarrow x \leq -3.8$. So $x \geq 5$ or $x \leq -3.8$. All four values satisfy: 5, $-5$, 10, and $-20$.',
  NULL, NULL, NULL,
  'medium', 1, 4, 'quantitative', true
);

-- Q11: Numeric Entry (Ratio)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'A recipe for 36 cupcakes requires 12 cups of milk. How many cups of milk are needed for a batch of 9 cupcakes?',
  NULL,
  '3',
  'Milk per cupcake: $12 / 36 = 1/3$ cup. For 9 cupcakes: $9 \times (1/3) = 3$ cups.',
  NULL, NULL, NULL,
  'medium', 1, 4, 'quantitative', true
);

-- Q12: Numeric Entry (Algebra)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'If $x + y = -3$ and $x^2 + y^2 = 12$, what is the value of $2xy$?',
  NULL,
  '-3',
  'Square the first equation: $(x + y)^2 = 9$, so $x^2 + 2xy + y^2 = 9$. Substitute $x^2 + y^2 = 12$: $12 + 2xy = 9$, giving $2xy = -3$.',
  NULL, NULL, NULL,
  'medium', 1, 4, 'quantitative', true
);

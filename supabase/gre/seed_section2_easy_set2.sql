-- Seed: Section 2, Set 2 (Easy) - 15 questions
-- Source: Docs for me/gre_mock/section2_easy_set2.tex

-- Q1: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Quantity A: $\dfrac{1}{4} + \dfrac{1}{5} + \dfrac{1}{6} = \dfrac{15+12+10}{60} = \dfrac{37}{60} \approx 0.616$. Quantity B: 0.6. Since 0.616 > 0.6, Quantity A is greater.',
  '$\dfrac{1}{4} + \dfrac{1}{5} + \dfrac{1}{6}$',
  '0.6',
  NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In the triangle above, $x + y = 130$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  '$x + y + z = 180 \implies 130 + z = 180 \implies z = 50$. Quantity A and Quantity B are both 50. They are equal.',
  '$z$',
  '50',
  'In the triangle above, $x + y = 130$.',
  'easy', 2, 2, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$x$ is an integer such that $x^2 - 5x + 6 = 0$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  '$(x-2)(x-3) = 0$ so $x = 2$ or $x = 3$. If $x = 2$, Quantity B is greater. If $x = 3$, Quantity A is greater. The relationship cannot be determined.',
  '$x$',
  '2.5',
  '$x$ is an integer such that $x^2 - 5x + 6 = 0$.',
  'easy', 2, 2, 'quantitative', true
);

-- Q4: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  '$120 = 2^3 \times 3 \times 5$ (distinct primes: 2, 3, 5). $150 = 2 \times 3 \times 5^2$ (distinct primes: 2, 3, 5). Both have 3 distinct prime factors. The two quantities are equal.',
  'The number of distinct prime factors of 120',
  'The number of distinct prime factors of 150',
  NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q5: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Child A ate 3/5 of a 1 kg cake. Child B ate 450 grams of the same cake.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Quantity A: $\dfrac{3}{5} \times 1000 = 600$ grams. Quantity B: 450 grams. Quantity A is greater.',
  'Weight eaten by Child A',
  'Weight eaten by Child B',
  'Child A ate 3/5 of a 1 kg cake. Child B ate 450 grams of the same cake.',
  'easy', 2, 2, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $f(x) = x^2 - 10$, what is the value of $f(5) - f(3)$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"16"},{"id":"d","text":"25"},{"id":"e","text":"34"}]'::jsonb,
  'c',
  '$f(5) = 25 - 10 = 15$, $f(3) = 9 - 10 = -1$. $f(5) - f(3) = 15 - (-1) = 16$.',
  NULL, NULL, NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'After a 20\% discount, the price of a coat is \$80. What was the original price?',
  '[{"id":"a","text":"\\$90"},{"id":"b","text":"\\$96"},{"id":"c","text":"\\$100"},{"id":"d","text":"\\$110"},{"id":"e","text":"\\$120"}]'::jsonb,
  'c',
  '$0.80P = 80 \implies P = 80/0.8 = 100$.',
  NULL, NULL, NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q8: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $x + 2y = 10$ and $2x + y = 14$, what is the value of $x - y$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"},{"id":"e","text":"10"}]'::jsonb,
  'b',
  'Subtract first from second: $(2x+y)-(x+2y) = 14-10 \implies x - y = 4$.',
  NULL, NULL, NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q9: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A student spends 1/3 of her allowance on rent and 1/4 of the remaining amount on food. If she has \$450 left, what is her total allowance?',
  '[{"id":"a","text":"\\$600"},{"id":"b","text":"\\$750"},{"id":"c","text":"\\$800"},{"id":"d","text":"\\$900"},{"id":"e","text":"\\$1,200"}]'::jsonb,
  'd',
  'After rent: $\dfrac{2}{3}A$. After food: $\dfrac{2}{3}A - \dfrac{1}{4}(\dfrac{2}{3}A) = \dfrac{1}{2}A$. So $\dfrac{1}{2}A = 450 \implies A = 900$.',
  NULL, NULL, NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q10: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'In the rectangle above, the sides are 8 and 6. What is the length of the diagonal?',
  '[{"id":"a","text":"9"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"14"},{"id":"e","text":"15"}]'::jsonb,
  'b',
  'By Pythagorean theorem: $d^2 = 8^2 + 6^2 = 64 + 36 = 100$, so $d = 10$.',
  NULL, NULL, NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q11: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $x$ is a positive integer, which of the following could be the remainder when $23^x$ is divided by 5? Indicate all such remainders.',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  '["a","b","c","d"]',
  'Units digit of $23^x$ cycles: 3, 9, 7, 1. Remainders mod 5: 3, 4, 2, 1. All four remainders are possible.',
  NULL, NULL, NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'What is the area of a regular hexagon with side length 2? (Enter the coefficient of $\sqrt{3}$, e.g. 6 for $6\sqrt{3}$.)',
  NULL,
  '6',
  'Area $= \dfrac{3\sqrt{3}}{2} s^2 = \dfrac{3\sqrt{3}}{2} \times 4 = 6\sqrt{3}$.',
  NULL, NULL, NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  E'\\begin{tabular}\nDay & Mon & Tue & Wed & Thu & Fri \\\\\nWidgets & 60 & 80 & 45 & 90 & 75\n\\end{tabular}\n\nWhat was the average number of widgets produced per day over the 5-day period?',
  '[{"id":"a","text":"65"},{"id":"b","text":"70"},{"id":"c","text":"75"},{"id":"d","text":"80"},{"id":"e","text":"85"}]'::jsonb,
  'b',
  'Sum $= 60 + 80 + 45 + 90 + 75 = 350$. Average $= 350/5 = 70$.',
  NULL, NULL, NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  E'\\begin{tabular}\nDay & Mon & Tue & Wed & Thu & Fri \\\\\nWidgets & 60 & 80 & 45 & 90 & 75\n\\end{tabular}\n\nOn which day was the production exactly 50% greater than Monday''s production?',
  '[{"id":"a","text":"Tuesday"},{"id":"b","text":"Wednesday"},{"id":"c","text":"Thursday"},{"id":"d","text":"Friday"},{"id":"e","text":"None"}]'::jsonb,
  'c',
  '50\% greater than 60 $= 60 + 30 = 90$. Thursday''s production was 90.',
  NULL, NULL, NULL,
  'easy', 2, 2, 'quantitative', true
);

-- Q15: Multi-Select (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  E'\\begin{tabular}\nDay & Mon & Tue & Wed & Thu & Fri \\\\\nWidgets & 60 & 80 & 45 & 90 & 75\n\\end{tabular}\n\nWhich of the following statements about the production data must be true? Indicate all such statements.',
  '[{"id":"a","text":"The median production for the week was 75."},{"id":"b","text":"The range of production was 45."},{"id":"c","text":"Total production was less than 400."}]'::jsonb,
  '["a","b","c"]',
  'Ordered: 45, 60, 75, 80, 90. Median = 75 (A). Range = 90 - 45 = 45 (B). Total = 350 < 400 (C). All true.',
  NULL, NULL, NULL,
  'easy', 2, 2, 'quantitative', true
);

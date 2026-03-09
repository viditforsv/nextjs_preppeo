-- Seed: Section 2, Set 3 (Easy) - 15 questions
-- Source: Docs for me/gre_mock/section2_easy_set3.tex

-- Q1: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A car travels at a constant speed of 40 miles per hour.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Time $= 10/40 = 0.25$ hours $= 15$ minutes. Quantity A and Quantity B are both 15 minutes. They are equal.',
  'The time it takes to travel 10 miles',
  '15 minutes',
  'A car travels at a constant speed of 40 miles per hour.',
  'easy', 2, 3, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Average $= (10 + 20 + 30 + 40)/4 = 100/4 = 25$. Quantity A and Quantity B are both 25. They are equal.',
  'The average (arithmetic mean) of 10, 20, 30, and 40',
  '25',
  NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A circle has area $25\pi$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  '$25\pi = \pi r^2 \implies r = 5$. Circumference $= 2\pi r = 10\pi$. Both quantities equal $10\pi$.',
  'The circumference of the circle',
  '$10\pi$',
  'A circle has area $25\pi$.',
  'easy', 2, 3, 'quantitative', true
);

-- Q4: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$x$ and $y$ are positive integers such that $x + y = 10$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'If $x=5$, $y=5$, then $xy = 25$ (equal). If $x=4$, $y=6$, then $xy = 24$ (B greater). If $x=1$, $y=9$, then $xy = 9$ (B greater). The relationship cannot be determined.',
  '$xy$',
  '25',
  '$x$ and $y$ are positive integers such that $x + y = 10$.',
  'easy', 2, 3, 'quantitative', true
);

-- Q5: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  '$3^4 = 81$, $4^3 = 64$. Since 81 > 64, Quantity A is greater.',
  '$3^4$',
  '$4^3$',
  NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'What is the units digit of $2^{50}$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"},{"id":"e","text":"0"}]'::jsonb,
  'b',
  'Units digit of powers of 2 cycles: 2, 4, 8, 6. $50 \equiv 2 \pmod{4}$, so the units digit is 4.',
  NULL, NULL, NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $5x + 10 = 35$, what is the value of $x$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"6"},{"id":"e","text":"7"}]'::jsonb,
  'c',
  '$5x = 25 \implies x = 5$.',
  NULL, NULL, NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q8: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'After a 10 percent increase, a salary becomes \$55,000. What was the original salary?',
  '[{"id":"a","text":"\\$45,000"},{"id":"b","text":"\\$49,500"},{"id":"c","text":"\\$50,000"},{"id":"d","text":"\\$51,000"},{"id":"e","text":"\\$52,500"}]'::jsonb,
  'c',
  '$1.10S = 55{,}000 \implies S = 55{,}000/1.1 = 50{,}000$.',
  NULL, NULL, NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q9: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A cylindrical tank has a radius of 3 and a height of 10. What is its total volume?',
  '[{"id":"a","text":"$30\\pi$"},{"id":"b","text":"$60\\pi$"},{"id":"c","text":"$90\\pi$"},{"id":"d","text":"$120\\pi$"},{"id":"e","text":"$150\\pi$"}]'::jsonb,
  'c',
  '$V = \pi r^2 h = \pi \times 9 \times 10 = 90\pi$.',
  NULL, NULL, NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q10: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $x = 4$, what is the value of $2x^2 - 3x + 5$?',
  '[{"id":"a","text":"15"},{"id":"b","text":"20"},{"id":"c","text":"25"},{"id":"d","text":"30"},{"id":"e","text":"35"}]'::jsonb,
  'c',
  '$2(16) - 12 + 5 = 32 - 12 + 5 = 25$.',
  NULL, NULL, NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q11: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Which of the following integers are prime? Indicate all such integers.',
  '[{"id":"a","text":"2"},{"id":"b","text":"9"},{"id":"c","text":"13"},{"id":"d","text":"21"}]'::jsonb,
  '["a","c"]',
  '2 and 13 have only two divisors (1 and themselves). 9 = 3×3, 21 = 3×7 are not prime.',
  NULL, NULL, NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'If the average of $x$, $y$, and 20 is 30, what is the value of $x + y$?',
  NULL,
  '70',
  '$(x + y + 20)/3 = 30 \implies x + y + 20 = 90 \implies x + y = 70$.',
  NULL, NULL, NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Monthly sales revenue (USD) — Jan 400, Feb 350, Mar 500, Apr 450, May 550. What were the average monthly sales for the 5-month period shown?',
  '[{"id":"a","text":"\\$430"},{"id":"b","text":"\\$450"},{"id":"c","text":"\\$470"},{"id":"d","text":"\\$500"},{"id":"e","text":"\\$520"}]'::jsonb,
  'b',
  'Total $= 400 + 350 + 500 + 450 + 550 = 2{,}250$. Average $= 2{,}250/5 = 450$.',
  NULL, NULL, NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Monthly sales revenue (USD) — Jan 400, Feb 350, Mar 500, Apr 450, May 550. Between which two consecutive months was the greatest dollar increase in revenue?',
  '[{"id":"a","text":"Jan to Feb"},{"id":"b","text":"Feb to Mar"},{"id":"c","text":"Mar to Apr"},{"id":"d","text":"Apr to May"},{"id":"e","text":"All are equal"}]'::jsonb,
  'b',
  'Feb to Mar: $500 - 350 = 150$ (greatest). Apr to May: $550 - 450 = 100$.',
  NULL, NULL, NULL,
  'easy', 2, 3, 'quantitative', true
);

-- Q15: Multi-Select (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Data: Monthly sales revenue (USD) — Jan 400, Feb 350, Mar 500, Apr 450, May 550. Which of the following statements about the sales data are true? Indicate all such statements.',
  '[{"id":"a","text":"Revenue in May was more than 30% greater than revenue in Jan."},{"id":"b","text":"The range of monthly revenue was $200."},{"id":"c","text":"Revenue decreased in exactly two month-to-month intervals."}]'::jsonb,
  '["a","b","c"]',
  'A: $(550-400)/400 = 37.5\% > 30\%$ (true). B: $550 - 350 = 200$ (true). C: Jan–Feb and Mar–Apr decreased (true).',
  NULL, NULL, NULL,
  'easy', 2, 3, 'quantitative', true
);

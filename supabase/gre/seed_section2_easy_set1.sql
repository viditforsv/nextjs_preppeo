-- Seed: Section 2, Set 1 (Easy) - 15 questions
-- Source: Docs for me/gre_mock/section2_easy_set1.tex

-- Q1: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  'Quantity A: $2^3 \times 3^2 = 8 \times 9 = 72$. Quantity B: $3^3 \times 2^2 = 27 \times 4 = 108$. Since 108 > 72, Quantity B is greater.',
  '$2^3 \times 3^2$',
  '$3^3 \times 2^2$',
  NULL,
  'easy', 2, 1, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$q$ is an odd integer.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  'Since $q$ is odd, $(-1)^q = -1$. Quantity A $= -1$, Quantity B $= -1 + 1 = 0$. Since 0 > -1, Quantity B is greater.',
  '$(-1)^q$',
  '$(-1)^q + 1$',
  '$q$ is an odd integer.',
  'easy', 2, 1, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'The circumference of a circle is $16\pi$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  '$16\pi = 2\pi r \implies r = 8$. Area $= \pi r^2 = 64\pi$. Quantity A is $64\pi$, Quantity B is $60\pi$. Quantity A is greater.',
  'The area of the circle',
  '$60\pi$',
  'The circumference of a circle is $16\pi$.',
  'easy', 2, 1, 'quantitative', true
);

-- Q4: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$xz = 12$ and $yz = 24$, where $z$ is a non-zero integer.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'If $z = 1$, then $x = 12$ and $y = 24$ (B greater). If $z = -1$, then $x = -12$ and $y = -24$ (A greater). The relationship cannot be determined.',
  '$x$',
  '$y$',
  '$xz = 12$ and $yz = 24$, where $z$ is a non-zero integer.',
  'easy', 2, 1, 'quantitative', true
);

-- Q5: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In the triangle above, the value of $x + y$ is 115.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  '$x + y + z = 180$, so $115 + z = 180 \implies z = 65$. Quantity A and Quantity B are both 65. They are equal.',
  '$z$',
  '65',
  'In the triangle above, the value of $x + y$ is 115.',
  'easy', 2, 1, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A store owner marked down an item by 20\% and the new price is \$160. What was the original price?',
  '[{"id":"a","text":"\\$180"},{"id":"b","text":"\\$192"},{"id":"c","text":"\\$200"},{"id":"d","text":"\\$220"},{"id":"e","text":"\\$240"}]'::jsonb,
  'c',
  '$0.80P = 160 \implies P = 160/0.8 = 200$.',
  NULL, NULL, NULL,
  'easy', 2, 1, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $y = 3x - 4$ and $x = 2$, what is the value of $y$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"},{"id":"e","text":"5"}]'::jsonb,
  'b',
  '$y = 3(2) - 4 = 6 - 4 = 2$.',
  NULL, NULL, NULL,
  'easy', 2, 1, 'quantitative', true
);

-- Q8: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A machine produces 20 cans per hour. Each box fits 10 cans. If the machine ran for 2 hours, how many boxes are needed to pack all the cans?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"10"},{"id":"d","text":"20"},{"id":"e","text":"40"}]'::jsonb,
  'b',
  'Total cans $= 20 \times 2 = 40$. Boxes $= 40/10 = 4$.',
  NULL, NULL, NULL,
  'easy', 2, 1, 'quantitative', true
);

-- Q9: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'What is the area of a regular hexagon with side length 4?',
  '[{"id":"a","text":"$12\\sqrt{3}$"},{"id":"b","text":"$16\\sqrt{3}$"},{"id":"c","text":"$24\\sqrt{3}$"},{"id":"d","text":"$32\\sqrt{3}$"},{"id":"e","text":"$48\\sqrt{3}$"}]'::jsonb,
  'c',
  'Area $= \dfrac{3\sqrt{3}}{2} s^2 = \dfrac{3\sqrt{3}}{2} \times 16 = 24\sqrt{3}$.',
  NULL, NULL, NULL,
  'easy', 2, 1, 'quantitative', true
);

-- Q10: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'In a class of 40 students, 25 are girls. What is the ratio of boys to girls?',
  '[{"id":"a","text":"$3 : 5$"},{"id":"b","text":"$5 : 3$"},{"id":"c","text":"$3 : 8$"},{"id":"d","text":"$5 : 8$"},{"id":"e","text":"$8 : 5$"}]'::jsonb,
  'a',
  'Boys $= 40 - 25 = 15$. Ratio boys : girls $= 15 : 25 = 3 : 5$.',
  NULL, NULL, NULL,
  'easy', 2, 1, 'quantitative', true
);

-- Q11: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $a$ is a prime number and $b$ is an even number, which of the following must be even? Indicate all such expressions.',
  '[{"id":"a","text":"$ab$"},{"id":"b","text":"$a + b$"},{"id":"c","text":"$a^b$"}]'::jsonb,
  '["a"]',
  'Any number times an even number is even, so $ab$ must be even. $a + b$ can be odd (e.g. $3+2=5$). $a^b$ can be odd (e.g. $3^2=9$). Only $ab$ must be even.',
  NULL, NULL, NULL,
  'easy', 2, 1, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'What is the area of a circle that has a circumference of $12\pi$? (Enter the coefficient of $\pi$, e.g. 36 for $36\pi$.)',
  NULL,
  '36',
  '$12\pi = 2\pi r \implies r = 6$. Area $= \pi r^2 = 36\pi$.',
  NULL, NULL, NULL,
  'easy', 2, 1, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Department | Employees | Avg Salary (\$): Sales 40, 50,000; Marketing 25, 60,000; Engineering 35, 80,000. What is the weighted average salary for all 100 employees?',
  '[{"id":"a","text":"\\$60,000"},{"id":"b","text":"\\$63,000"},{"id":"c","text":"\\$65,000"},{"id":"d","text":"\\$70,000"},{"id":"e","text":"\\$75,000"}]'::jsonb,
  'b',
  'Total payroll $= 40(50{,}000) + 25(60{,}000) + 35(80{,}000) = 6{,}300{,}000$. Weighted average $= 6{,}300{,}000/100 = 63{,}000$.',
  NULL, NULL, NULL,
  'easy', 2, 1, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Department | Employees | Avg Salary (\$): Sales 40, 50,000; Marketing 25, 60,000; Engineering 35, 80,000. Which department has the highest total expenditure on salaries?',
  '[{"id":"a","text":"Sales"},{"id":"b","text":"Marketing"},{"id":"c","text":"Engineering"},{"id":"d","text":"Both Sales and Marketing"},{"id":"e","text":"All are equal"}]'::jsonb,
  'c',
  'Sales: \$2,000,000; Marketing: \$1,500,000; Engineering: \$2,800,000. Engineering has the highest.',
  NULL, NULL, NULL,
  'easy', 2, 1, 'quantitative', true
);

-- Q15: Numeric Entry (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Data: Department | Employees | Avg Salary (\$): Sales 40, 50,000; Marketing 25, 60,000; Engineering 35, 80,000. If 5 new employees are hired into Marketing at an average salary of \$60,000 each, what would be the new average salary for the Marketing department? (Enter the number only, e.g. 60000)',
  NULL,
  '60000',
  'Current total Marketing $= 25 \times 60{,}000 = 1{,}500{,}000$. New total $= 1{,}500{,}000 + 5(60{,}000) = 1{,}800{,}000$. New average $= 1{,}800{,}000/30 = 60{,}000$.',
  NULL, NULL, NULL,
  'easy', 2, 1, 'quantitative', true
);

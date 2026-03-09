-- Seed: Section 2, Set 3 (Medium) - 15 questions
-- Source: Docs for me/gre_mock/section2_medium_set3.tex

-- Q1: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$15!$ is divisible by $3^x 5^y$ where $x$ and $y$ are positive integers.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Legendre: max power of 3 in $15!$ is $\lfloor 15/3 \rfloor + \lfloor 15/9 \rfloor = 6$. Max power of 5 is $\lfloor 15/5 \rfloor = 3$. Quantity A = 6, Quantity B = $2 \times 3 = 6$. They are equal.',
  'The greatest possible value for $x$',
  'Twice the greatest possible value for $y$',
  '$15!$ is divisible by $3^x 5^y$ where $x$ and $y$ are positive integers.',
  'medium', 2, 3, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In triangle $ABC$, $DE \parallel AC$. The area of triangle $BDE$ is 16 and the ratio $BD/BA = 2/3$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Similar triangles: area ratio $= (BD/BA)^2 = (2/3)^2 = 4/9$. So $16/\text{Area}(ABC) = 4/9$, hence Area$(ABC) = 36$. Both quantities equal 36.',
  'The area of triangle $ABC$',
  '36',
  'In triangle $ABC$, $DE \parallel AC$. The area of triangle $BDE$ is 16 and the ratio $BD/BA = 2/3$.',
  'medium', 2, 3, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'The median of a set of 7 distinct integers is 20.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'The mean can be above or below 20 depending on the other six values (e.g. large upper values raise the mean; large negative lower values lower it). The relationship cannot be determined.',
  'The average (arithmetic mean) of the integers',
  '20',
  'The median of a set of 7 distinct integers is 20.',
  'medium', 2, 3, 'quantitative', true
);

-- Q4: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$k$ is a positive integer.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Units digit of $7^n$: cycle 7,9,3,1. For $4k+2$, remainder 2 so digit 9. Units digit of $3^n$: cycle 3,9,7,1; remainder 2 so digit 9. Both equal 9.',
  'The units digit of $7^{4k+2}$',
  'The units digit of $3^{4k+2}$',
  '$k$ is a positive integer.',
  'medium', 2, 3, 'quantitative', true
);

-- Q5: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'The price of a stock rose by 25 percent and then decreased by $y$ percent. After the decrease, the stock was back to its original price.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  'Original 100, after 25% increase: 125. To return to 100, decrease by 25, so $y = (25/125) \times 100 = 20$. Quantity A is 20, Quantity B is 25. Quantity B is greater.',
  '$y$',
  '25',
  'The price of a stock rose by 25 percent and then decreased by $y$ percent. After the decrease, the stock was back to its original price.',
  'medium', 2, 3, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A chemist currently has 30 ounces of a solution, 10 of which are acetone. How many ounces of pure acetone must she add to attain a 50/50 mixture of acetone and water?',
  '[{"id":"a","text":"5"},{"id":"b","text":"10"},{"id":"c","text":"15"},{"id":"d","text":"20"},{"id":"e","text":"25"}]'::jsonb,
  'b',
  'Water = 30 - 10 = 20 oz. For 50/50, acetone must equal 20 oz. She has 10 oz acetone, so add 10 oz pure acetone.',
  NULL, NULL, NULL,
  'medium', 2, 3, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'In a parking lot, 1/3 of the vehicles are black and 1/5 of the remainder are white. What is the minimum number of vehicles in the lot?',
  '[{"id":"a","text":"8"},{"id":"b","text":"12"},{"id":"c","text":"15"},{"id":"d","text":"30"},{"id":"e","text":"45"}]'::jsonb,
  'c',
  'Total must be divisible by 3 (for 1/3 black) and by 5 for the remainder split. LCM(3,5) = 15. Minimum is 15.',
  NULL, NULL, NULL,
  'medium', 2, 3, 'quantitative', true
);

-- Q8: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'In a right triangle, the slope of the line from $B$ to the vertex opposite the base is $2/3$. If the length of $BC$ (the base) is 12, what is the length of $AB$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"6"},{"id":"c","text":"8"},{"id":"d","text":"12"},{"id":"e","text":"18"}]'::jsonb,
  'c',
  'Slope = rise/run = $AB/BC$. So $2/3 = AB/12$, hence $AB = 8$.',
  NULL, NULL, NULL,
  'medium', 2, 3, 'quantitative', true
);

-- Q9: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $f(x) = x^2 - 4x$, what is the value of $f(x+2) - f(x-2)$?',
  '[{"id":"a","text":"$8x$"},{"id":"b","text":"$8x - 16$"},{"id":"c","text":"$4x - 8$"},{"id":"d","text":"$16x$"},{"id":"e","text":"$0$"}]'::jsonb,
  'b',
  '$f(x+2) = (x+2)^2 - 4(x+2) = x^2 - 4$. $f(x-2) = (x-2)^2 - 4(x-2) = x^2 - 8x + 12$. Difference $= (x^2-4) - (x^2-8x+12) = 8x - 16$.',
  NULL, NULL, NULL,
  'medium', 2, 3, 'quantitative', true
);

-- Q10: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A square is inscribed in a circle with an area of $64\pi$. What is the area of the square?',
  '[{"id":"a","text":"64"},{"id":"b","text":"96"},{"id":"c","text":"128"},{"id":"d","text":"160"},{"id":"e","text":"256"}]'::jsonb,
  'c',
  '$\pi r^2 = 64\pi \implies r = 8$. Diameter = diagonal of square = 16. Area of square $= d^2/2 = 256/2 = 128$.',
  NULL, NULL, NULL,
  'medium', 2, 3, 'quantitative', true
);

-- Q11: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $xz = 12$ and $yz = 24$, and $z \neq 0$, which of the following could be the value of $x - y$? Indicate all such values.',
  '[{"id":"a","text":"-12"},{"id":"b","text":"12"},{"id":"c","text":"-6"},{"id":"d","text":"6"}]'::jsonb,
  '["a","b","c","d"]',
  '$x - y = 12/z - 24/z = -12/z$. For $z = 1,-1,2,-2$ we get $-12, 12, -6, 6$. All four are possible.',
  NULL, NULL, NULL,
  'medium', 2, 3, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'What is the units digit of $7^{100}$?',
  NULL,
  '1',
  'Powers of 7 cycle: 7, 9, 3, 1. $100 \equiv 0 \pmod{4}$, so the units digit is 1.',
  NULL, NULL, NULL,
  'medium', 2, 3, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Departmental performance (units per member) — A: 12, B: 15, C: 18, D: 10. If Department C has 5 members, what is the total number of units produced by Department C?',
  '[{"id":"a","text":"18"},{"id":"b","text":"36"},{"id":"c","text":"72"},{"id":"d","text":"90"},{"id":"e","text":"108"}]'::jsonb,
  'd',
  'Dept C: 18 units per member × 5 members = 90 units.',
  NULL, NULL, NULL,
  'medium', 2, 3, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Departmental performance (units per member) — A: 12, B: 15, C: 18, D: 10. The performance of Department B is what percent greater than that of Department D?',
  '[{"id":"a","text":"5%"},{"id":"b","text":"15%"},{"id":"c","text":"25%"},{"id":"d","text":"50%"},{"id":"e","text":"75%"}]'::jsonb,
  'd',
  'B = 15, D = 10. Percent greater $= (15-10)/10 \times 100 = 50\%$.',
  NULL, NULL, NULL,
  'medium', 2, 3, 'quantitative', true
);

-- Q15: Multi-Select (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Data: Departmental performance (units per member) — A: 12, B: 15, C: 18, D: 10. Which of the following statements about the departments are true? Indicate all such statements.',
  '[{"id":"a","text":"The average performance of the four departments is 13.75."},{"id":"b","text":"Department C is the most productive per member."},{"id":"c","text":"Department A produced more total units than Department D."}]'::jsonb,
  '["a","b"]',
  'A: Average $= (12+15+18+10)/4 = 13.75$ (true). B: C has highest at 18 (true). C: Total units depend on member count, which is not given (false).',
  NULL, NULL, NULL,
  'medium', 2, 3, 'quantitative', true
);

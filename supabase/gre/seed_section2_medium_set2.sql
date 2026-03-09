-- Seed: Section 2, Set 2 (Medium) - 15 questions
-- Source: Docs for me/gre_mock/section2_medium_set2.tex

-- Q1: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$|x|y > x|y|$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  'The inequality implies $y > 0$ and $|x| > x$, so $x < 0$. Then $(x+y)^2 = x^2 + 2xy + y^2$ and $(x-y)^2 = x^2 - 2xy + y^2$. Since $xy < 0$, $-2xy > 2xy$, so Quantity B is greater.',
  '$(x + y)^2$',
  '$(x - y)^2$',
  '$|x|y > x|y|$.',
  'medium', 2, 2, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A dataset of tree heights is normally distributed. One standard deviation below the mean is 15 feet, and one standard deviation above the mean is 21 feet.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'In a normal distribution, mean = median. The mean is halfway between $\mu - \sigma = 15$ and $\mu + \sigma = 21$, so mean $= (15+21)/2 = 18$. Quantity A equals Quantity B.',
  'The median height of the trees',
  '18 feet',
  'A dataset of tree heights is normally distributed. One SD below the mean is 15 ft, one SD above is 21 ft.',
  'medium', 2, 2, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In the circle above, the length of the minor arc corresponding to a $60^\circ$ central angle is $4\pi$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Arc/circumference $= 60/360 = 1/6$, so $4\pi/C = 1/6$, hence $C = 24\pi$. Quantity A and Quantity B are both $24\pi$.',
  'The circumference of the circle',
  '$24\pi$',
  'In the circle above, the length of the minor arc corresponding to a $60^\circ$ central angle is $4\pi$.',
  'medium', 2, 2, 'quantitative', true
);

-- Q4: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$n$ is a positive integer.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Quantity A: $(-1)^{4n} \times (-1)^{202}$; both exponents are even, so the product is $1 \times 1 = 1$. Quantity B: $3^3 \times (-5)^5$ is positive times negative, so negative. Quantity A is greater.',
  '$(-1)^{4n} \times (-1)^{202}$',
  '$3^3 \times (-5)^5$',
  '$n$ is a positive integer.',
  'medium', 2, 2, 'quantitative', true
);

-- Q5: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$xz = 24$ and $yz = 36$, where $z \neq 0$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Dividing: $\dfrac{xz}{yz} = \dfrac{24}{36}$, so $\dfrac{x}{y} = \dfrac{2}{3}$. The two quantities are equal.',
  '$x/y$',
  '$2/3$',
  '$xz = 24$ and $yz = 36$, where $z \neq 0$.',
  'medium', 2, 2, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A contractor has two teams. Team A can pave a road in 12 days, and Team B can pave it in 18 days. If Team A works alone for 2 days and then Team B joins to finish, how many total days does the project take?',
  '[{"id":"a","text":"6"},{"id":"b","text":"8"},{"id":"c","text":"10"},{"id":"d","text":"12"},{"id":"e","text":"14"}]'::jsonb,
  'b',
  'A does $2/12 = 1/6$ in 2 days. Remaining $5/6$. Combined rate $= 1/12 + 1/18 = 5/36$. Time $= (5/6)/(5/36) = 6$ days. Total $= 2 + 6 = 8$ days.',
  NULL, NULL, NULL,
  'medium', 2, 2, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $x$ is 250 percent greater than 40, $x$ is what percent greater than 70?',
  '[{"id":"a","text":"50%"},{"id":"b","text":"100%"},{"id":"c","text":"150%"},{"id":"d","text":"200%"},{"id":"e","text":"250%"}]'::jsonb,
  'b',
  '$x = 40 + 2.5(40) = 140$. Percent greater than 70: $(140-70)/70 \times 100 = 100\%$.',
  NULL, NULL, NULL,
  'medium', 2, 2, 'quantitative', true
);

-- Q8: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $f(x) = x^2 + 5$, what is the value of $f(a+b) - f(a-b)$?',
  '[{"id":"a","text":"$2b^2 + 10$"},{"id":"b","text":"$4ab$"},{"id":"c","text":"$4ab + 10$"},{"id":"d","text":"$2a^2 + 2b^2$"},{"id":"e","text":"$0$"}]'::jsonb,
  'b',
  '$f(a+b) - f(a-b) = (a+b)^2 + 5 - [(a-b)^2 + 5] = (a^2+2ab+b^2) - (a^2-2ab+b^2) = 4ab$.',
  NULL, NULL, NULL,
  'medium', 2, 2, 'quantitative', true
);

-- Q9: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A snack mix contains 3 oz pretzels, 1 oz chocolate, 2 oz nuts, and $x$ oz fruit. What percent of the mix is fruit, by weight?',
  '[{"id":"a","text":"$100x/(6+x)$"},{"id":"b","text":"$x/600$"},{"id":"c","text":"$100/6x$"},{"id":"d","text":"$6x/100$"},{"id":"e","text":"$x/(6+x)$"}]'::jsonb,
  'a',
  'Total weight $= 6 + x$. Percent fruit $= \dfrac{x}{6+x} \times 100 = \dfrac{100x}{6+x}$.',
  NULL, NULL, NULL,
  'medium', 2, 2, 'quantitative', true
);

-- Q10: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'What is the remainder when $4^{20}$ is divided by 10?',
  '[{"id":"a","text":"0"},{"id":"b","text":"2"},{"id":"c","text":"4"},{"id":"d","text":"6"},{"id":"e","text":"8"}]'::jsonb,
  'd',
  'Remainder mod 10 is the units digit. Powers of 4 cycle: 4, 6 (even exponent gives 6). $4^{20}$ has units digit 6.',
  NULL, NULL, NULL,
  'medium', 2, 2, 'quantitative', true
);

-- Q11: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $g$ is an integer and $x$ is a prime number, which of the following must be an integer? Indicate all such expressions.',
  '[{"id":"a","text":"$\\dfrac{g^2x + 5gx}{x}$"},{"id":"b","text":"$g^2 - \\dfrac{x^2}{3}$"},{"id":"c","text":"$6(\\frac{g}{2}) - 100(\\frac{g}{2})^2$"}]'::jsonb,
  '["a","c"]',
  'A: $\dfrac{x(g^2+5g)}{x} = g^2+5g$ (integer). B: $x^2/3$ need not be integer. C: $3g - 25g^2$ (integer when $g$ is integer).',
  NULL, NULL, NULL,
  'medium', 2, 2, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Evaluate: $\dfrac{(18)(21)(25)}{(14)(15)(9)}$.',
  NULL,
  '5',
  'Factor and cancel: $\dfrac{18 \cdot 21 \cdot 25}{14 \cdot 15 \cdot 9} = \dfrac{2\cdot 9 \cdot 3\cdot 7 \cdot 25}{2\cdot 7 \cdot 3\cdot 5 \cdot 9} = 5$.',
  NULL, NULL, NULL,
  'medium', 2, 2, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Fuel efficiency vs weight (lbs, MPG): (2200,38), (2500,34), (2800,30), (3200,28), (3500,24), (4000,20), (4200,18), (4800,14). Based on the trend, what is the approximate decrease in MPG for every 1,000 lbs increase in weight?',
  '[{"id":"a","text":"5"},{"id":"b","text":"9"},{"id":"c","text":"12"},{"id":"d","text":"15"},{"id":"e","text":"20"}]'::jsonb,
  'b',
  'From 3000 to 4000 lbs, MPG drops from about 30 to about 21, a decrease of about 9.',
  NULL, NULL, NULL,
  'medium', 2, 2, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Fuel efficiency vs weight (lbs, MPG): (2200,38), (2500,34), (2800,30), (3200,28), (3500,24), (4000,20), (4200,18), (4800,14). How many vehicles weigh more than 3,000 lbs but get more than 20 MPG?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"},{"id":"e","text":"5"}]'::jsonb,
  'b',
  'Points with weight > 3000 and MPG > 20: (3200, 28) and (3500, 24). Count = 2.',
  NULL, NULL, NULL,
  'medium', 2, 2, 'quantitative', true
);

-- Q15: Multi-Select (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Data: Fuel efficiency vs weight (lbs, MPG): (2200,38), (2500,34), (2800,30), (3200,28), (3500,24), (4000,20), (4200,18), (4800,14). Which of the following statements about the data are true? Indicate all such statements.',
  '[{"id":"a","text":"There is a negative correlation between weight and fuel efficiency."},{"id":"b","text":"The range of vehicle weight in the sample is 2,600 lbs."},{"id":"c","text":"The lightest vehicle has the highest MPG."}]'::jsonb,
  '["a","b","c"]',
  'A: Heavier vehicles have lower MPG (true). B: Range = 4800 - 2200 = 2600 (true). C: (2200, 38) is lightest and has highest MPG (true).',
  NULL, NULL, NULL,
  'medium', 2, 2, 'quantitative', true
);

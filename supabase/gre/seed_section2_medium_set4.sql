-- Seed: Section 2, Medium, Set 4 - 15 questions
-- Source: Docs for me/latex_with_rijay/gre_quant_mock/section2_medium_set4.tex

-- Q1: Quantitative Comparison (Geometry - Quarter Circle)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Sector $OAB$ is a quarter-circle. The central angle of $90^\circ$ is divided into three parts: $2x^\circ$, $3x^\circ$, and $x^\circ$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'A quarter-circle has a central angle of 90°. Sum of parts: $2x + 3x + x = 6x = 90$, so $x = 15$. Both quantities are equal.',
  '$x$',
  '15',
  'Sector $OAB$ is a quarter-circle. The central angle is divided into three parts: $2x^\\circ$, $3x^\\circ$, and $x^\\circ$.',
  'medium', 2, 4, 'quantitative', true
);

-- Q2: Quantitative Comparison (Work Rate)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A team of 8 chefs produce 3,200 tarts in 5 days at a constant rate.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Rate per chef per day: $3200 / (8 \times 5) = 80$. Qty A: $3600 / (C \times 3) = 80 \Rightarrow C = 15$. Qty B: $4800 / (4 \times D) = 80 \Rightarrow D = 15$. Both equal 15.',
  'The number of chefs needed to produce 3,600 tarts in 3 days',
  'The number of days that 4 chefs need to produce 4,800 tarts',
  'A team of 8 chefs produce 3,200 tarts in 5 days at a constant rate.',
  'medium', 2, 4, 'quantitative', true
);

-- Q3: Quantitative Comparison (Set Theory)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In a school of 150 students, 75 study Latin, 110 study Spanish, and 11 study neither.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  'Students studying at least one: $150 - 11 = 139$. Both: $75 + 110 - 139 = 46$. Only Latin: $75 - 46 = 29$. Since $29 < 46$, Quantity B is greater.',
  'The number of students who study ONLY Latin',
  '46',
  'In a school of 150 students, 75 study Latin, 110 study Spanish, and 11 study neither.',
  'medium', 2, 4, 'quantitative', true
);

-- Q4: Quantitative Comparison (Normal Distribution)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Rock sample weights are normally distributed. One standard deviation below the mean is 250g and one standard deviation above is 420g.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'In a normal distribution, the mean equals the median. Mean $= (250 + 420)/2 = 335$. The median is 335 grams.',
  'The median weight in grams',
  '335 grams',
  'Rock sample weights are normally distributed. One standard deviation below the mean is 250g and one standard deviation above is 420g.',
  'medium', 2, 4, 'quantitative', true
);

-- Q5: Quantitative Comparison (Percentages)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$a$, $b$, and $c$ are positive constants.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  '$(a+b)\%$ of $c = \dfrac{(a+b)c}{100}$. $c\%$ of $(a+b) = \dfrac{c(a+b)}{100}$. These are identical expressions.',
  '$(a + b)\\%$ of $c$',
  '$c\\%$ of $(a + b)$',
  '$a$, $b$, and $c$ are positive constants.',
  'medium', 2, 4, 'quantitative', true
);

-- Q6: Single Choice (Circle Geometry)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A circle with center $O$ has a circumference of $12\pi\sqrt{3}$. $AC$ is a diameter and angle $ACB = 30^\circ$. Find the length of $AB$.',
  '[{"id":"a","text":"$3\\sqrt{2}$"},{"id":"b","text":"6"},{"id":"c","text":"$6\\sqrt{3}$"},{"id":"d","text":"18"}]'::jsonb,
  'd',
  'Circumference $= 12\pi\sqrt{3} = \pi d$, so diameter $AC = 12\sqrt{3}$. Angle at $B$ is 90° (subtends a diameter). Triangle $ABC$ is a 30-60-90 triangle. $AB = AC \cdot \sin(60°) = 12\sqrt{3} \cdot \dfrac{\sqrt{3}}{2} = 18$.',
  NULL, NULL, NULL,
  'medium', 2, 4, 'quantitative', true
);

-- Q7: Single Choice (Probability - Dice)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A 6-sided die is rolled twice. What is the probability that the sum is exactly 8?',
  '[{"id":"a","text":"$1/9$"},{"id":"b","text":"$1/8$"},{"id":"c","text":"$5/36$"},{"id":"d","text":"$1/6$"}]'::jsonb,
  'c',
  'Total outcomes: $6 \times 6 = 36$. Pairs summing to 8: $(2,6), (3,5), (4,4), (5,3), (6,2)$. That is 5 outcomes. Probability $= 5/36$.',
  NULL, NULL, NULL,
  'medium', 2, 4, 'quantitative', true
);

-- Q8: Single Choice (Age/Algebra)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Mason is now twice as old as Gunther was 10 years ago. If $G$ is Gunther''s current age, which represents the sum of their ages 4 years from now?',
  '[{"id":"a","text":"$3G - 12$"},{"id":"b","text":"$3G + 28$"},{"id":"c","text":"$3G - 20$"},{"id":"d","text":"$8 - G$"}]'::jsonb,
  'a',
  'Mason''s current age: $M = 2(G - 10) = 2G - 20$. In 4 years: $(2G - 20 + 4) + (G + 4) = 2G - 16 + G + 4 = 3G - 12$.',
  NULL, NULL, NULL,
  'medium', 2, 4, 'quantitative', true
);

-- Q9: Single Choice (Combinatorics)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'How many 10-digit numbers can be formed using only the digits 2 and 5?',
  '[{"id":"a","text":"$2^{10}$"},{"id":"b","text":"$10!$"},{"id":"c","text":"$(5!)(5!)$"},{"id":"d","text":"$10!/2$"}]'::jsonb,
  'a',
  'Each of the 10 digit positions has 2 choices (either 2 or 5). Total: $2^{10}$.',
  NULL, NULL, NULL,
  'medium', 2, 4, 'quantitative', true
);

-- Q10: Single Choice (Mixture Problem)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  '16 ounces of birdseed contains 10% sesame. How much sesame must be added to produce a 20% sesame mix?',
  '[{"id":"a","text":"1 ounce"},{"id":"b","text":"1.6 ounces"},{"id":"c","text":"2 ounces"},{"id":"d","text":"2.4 ounces"}]'::jsonb,
  'c',
  'Current sesame: $16 \times 0.10 = 1.6$ oz. Let $x$ = added sesame. $(1.6 + x)/(16 + x) = 0.20$. Solving: $1.6 + x = 3.2 + 0.2x \Rightarrow 0.8x = 1.6 \Rightarrow x = 2$.',
  NULL, NULL, NULL,
  'medium', 2, 4, 'quantitative', true
);

-- Q11: Numeric Entry (Rate)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Jarod uses $2/3$ of an ounce of vinegar for every 2 cups of sushi rice. How many ounces of vinegar does he need for 7 cups of rice?',
  NULL,
  '2.33',
  'Rate: $(2/3)/2 = 1/3$ ounce per cup. For 7 cups: $7 \times (1/3) = 7/3 \approx 2.33$.',
  NULL, NULL, NULL,
  'medium', 2, 4, 'quantitative', true
);

-- Q12: Numeric Entry (Optimization)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Chocolate chip cookies are made in batches of 7 and peanut butter in batches of 6. If 95 total cookies were made, what is the minimum number of chocolate chip cookies?',
  NULL,
  '35',
  'Solve $7x + 6y = 95$ with positive integers. If $x = 5$: $35 + 6y = 95 \Rightarrow y = 10$. Minimum chocolate chip $= 7 \times 5 = 35$.',
  NULL, NULL, NULL,
  'medium', 2, 4, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation - Varsity Sports)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Varsity Sports Rosters (bar chart). Male/Female athletes by sport: Volleyball (M: 0, F: 16), Track & Field (M: 37, F: 61), Tennis (M: 9, F: 9), Cross Country (M: 17, F: 23), Basketball (M: 24, F: 15). What is the ratio of male athletes to female athletes on the Track and Field roster?',
  '[{"id":"a","text":"$37/61$"},{"id":"b","text":"$14/9$"},{"id":"c","text":"$61/37$"},{"id":"d","text":"$17/23$"}]'::jsonb,
  'a',
  'Track and Field: Male = 37, Female = 61. Ratio = $37/61$.',
  NULL, NULL, NULL,
  'medium', 2, 4, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation - Largest Roster)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Varsity Sports Rosters (bar chart). Male/Female athletes by sport: Volleyball (M: 0, F: 16), Track & Field (M: 37, F: 61), Tennis (M: 9, F: 9), Cross Country (M: 17, F: 23), Basketball (M: 24, F: 15). Which sport has the largest total roster (Male + Female combined)?',
  '[{"id":"a","text":"Basketball"},{"id":"b","text":"Track and Field"},{"id":"c","text":"Volleyball"},{"id":"d","text":"Cross Country"}]'::jsonb,
  'b',
  'Basketball: $24 + 15 = 39$. Track and Field: $37 + 61 = 98$. Cross Country: $17 + 23 = 40$. Track and Field is the largest.',
  NULL, NULL, NULL,
  'medium', 2, 4, 'quantitative', true
);

-- Q15: Numeric Entry (Data Interpretation - Overlap)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Data: Varsity Sports Rosters (bar chart). Male athletes by sport: Volleyball 0, Track & Field 37, Tennis 9, Cross Country 17, Basketball 24. If there are 76 unique male athletes, how many are on both the Track and Field and Cross Country teams?',
  NULL,
  '11',
  'Sum of all male athlete counts: $0 + 37 + 9 + 17 + 24 = 87$. Since there are 76 unique males, the overlap $= 87 - 76 = 11$.',
  NULL, NULL, NULL,
  'medium', 2, 4, 'quantitative', true
);

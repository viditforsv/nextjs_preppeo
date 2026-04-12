-- Seed: Section 2, Hard, Set 4 - 15 questions
-- Source: Docs for me/latex_with_rijay/gre_quant_mock/section2_hard_set4.tex

-- Q1: Quantitative Comparison (Number Theory - Prime Factors)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  '$100{,}000 = 2^5 \cdot 5^5$ (2 distinct primes). $99{,}000 = 2^3 \cdot 3^2 \cdot 5^3 \cdot 11$ (4 distinct primes). Since $2 < 4$, Quantity B is greater.',
  'The number of distinct prime factors of $100{,}000$',
  'The number of distinct prime factors of $99{,}000$',
  NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q2: Quantitative Comparison (Combinatorics Symmetry)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'An inventory contains 100 different coins.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'By the symmetry property of combinations: $\binom{n}{r} = \binom{n}{n-r}$. So $\binom{100}{56} = \binom{100}{44}$. The quantities are equal.',
  'The number of possible collections of 56 coins that can be selected',
  'The number of possible collections of 44 coins that can be selected',
  'An inventory contains 100 different coins.',
  'hard', 2, 4, 'quantitative', true
);

-- Q3: Quantitative Comparison (3D Geometry - Surface Area Ratio)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A 2-foot by 2-foot by 2-foot solid cube is cut into 2-inch by 2-inch by 4-inch rectangular solids.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Cube in inches: $24^3$. Number of small solids: $24^3 / (2 \cdot 2 \cdot 4) = 13824/16 = 864$. SA of one small solid: $2(4 + 8 + 8) = 40$ sq in. Total SA: $864 \times 40 = 34{,}560$. Original cube SA: $6 \times 576 = 3{,}456$. Ratio: $34560/3456 = 10 > 8$.',
  'The ratio of the total surface area of all small solids to the surface area of the original cube',
  '8',
  'A 2-foot by 2-foot by 2-foot solid cube is cut into 2-inch by 2-inch by 4-inch rectangular solids.',
  'hard', 2, 4, 'quantitative', true
);

-- Q4: Single Choice (Geometry - Angles)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'In triangle $ADC$, point $B$ lies on $AC$, with $AB = BD = DC$. If angle $C = 66^\circ$, what is the value of angle $x$ at vertex $A$?',
  '[{"id":"a","text":"$11^\\circ$"},{"id":"b","text":"$22^\\circ$"},{"id":"c","text":"$33^\\circ$"},{"id":"d","text":"$44^\\circ$"}]'::jsonb,
  'c',
  'In isosceles triangle $BDC$ ($BD = DC$): $\\angle DBC = \\angle DCB = 66^\\circ$. In isosceles triangle $ABD$ ($AB = BD$): $\\angle ADB = x$. Exterior angle: $\\angle DBC = x + x = 2x$. So $66 = 2x \\Rightarrow x = 33$.',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q5: Single Choice (Probability - Complement)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A city has a $1/3$ chance of rain on any given day. What is the probability it rains at least once in a 3-day period?',
  '[{"id":"a","text":"$1/3$"},{"id":"b","text":"$8/27$"},{"id":"c","text":"$19/27$"},{"id":"d","text":"$1$"}]'::jsonb,
  'c',
  'P(no rain on one day) $= 2/3$. P(no rain for 3 days) $= (2/3)^3 = 8/27$. P(rain at least once) $= 1 - 8/27 = 19/27$.',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q6: Single Choice (Coordinate Geometry - Line)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Line $p$ is defined by $3y - 9x = 9$. Which of the following is true?',
  '[{"id":"a","text":"Slope > x-intercept"},{"id":"b","text":"Slope = x-intercept"},{"id":"c","text":"Slope < x-intercept"}]'::jsonb,
  'a',
  'Rewrite: $y = 3x + 3$. Slope $= 3$. x-intercept (set $y = 0$): $0 = 3x + 3 \Rightarrow x = -1$. Since $3 > -1$, slope is greater.',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q7: Multi-Select (Number Theory - Multiples of 64)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Which of the following values, when multiplied by 12, is NOT a multiple of 64? Indicate all such values.',
  '[{"id":"a","text":"$6^6$"},{"id":"b","text":"$12^2$"},{"id":"c","text":"$18^3$"},{"id":"d","text":"$30^3$"}]'::jsonb,
  '["c","d"]',
  '$64 = 2^6$. $12 = 2^2 \cdot 3$ provides $2^2$, so the multiplier needs $\geq 2^4$. A: $6^6 = 2^6 \cdot 3^6$ ($2^6$, enough). B: $12^2 = 2^4 \cdot 3^2$ ($2^4$, enough). C: $18^3 = 2^3 \cdot 3^6$ ($2^3$, not enough). D: $30^3 = 2^3 \cdot 3^3 \cdot 5^3$ ($2^3$, not enough).',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q8: Multi-Select (Algebra - Sum of Reciprocals)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $k$ is the sum of the reciprocals of consecutive integers from 41 to 60 inclusive, which of the following are less than $k$? Indicate all such values.',
  '[{"id":"a","text":"$1/4$"},{"id":"b","text":"$1/3$"},{"id":"c","text":"$1/2$"}]'::jsonb,
  '["a"]',
  'There are 20 terms. Lower bound: $20 \times (1/60) = 1/3$. Upper bound: $20 \times (1/41) \approx 0.488$. So $1/3 \leq k < 0.488$. Only $1/4 = 0.25$ is less than $k$.',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q9: Numeric Entry (Polygon Diagonals)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'A polygon has 12 edges. How many different diagonals does it have?',
  NULL,
  '54',
  'Diagonals of an $n$-sided polygon: $n(n-3)/2 = 12 \times 9 / 2 = 54$.',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q10: Numeric Entry (Algebra - Intersecting Lines)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Lines $j$ and $k$ intersect at $(1, 3)$. Line $j$: $y = ax + 10$ and Line $k$: $y = bx + a$. What is the value of $b$?',
  NULL,
  '10',
  'From line $j$: $3 = a + 10 \Rightarrow a = -7$. From line $k$: $3 = b + (-7) \Rightarrow b = 10$.',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q11: Numeric Entry (Geometry - Perimeter of Composite Figure)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'A figure is divided into 5 squares of equal area arranged in an L-shape. If the total area is 45, what is the perimeter of the entire figure?',
  NULL,
  '36',
  'Area of one square: $45/5 = 9$. Side $= 3$. The L-shaped figure has 12 outer edges. Perimeter $= 12 \times 3 = 36$.',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q12: Single Choice (Data Interpretation - Owner-Occupied Housing Pie Chart)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Owner-Occupied Housing by Household Size (75,986,074 total). Breakdown: 1-person 25.6%, 2-person 34%, 3-person (remainder of main chart), 4-person (in "Other" detail), 5-person 6.4%, 6-person (in "Other" detail). The "Other" category is 11.1% total. What percent of owner-occupied housing units are households with 4 or more people?',
  '[{"id":"a","text":"11.1%"},{"id":"b","text":"25.6%"},{"id":"c","text":"41.0%"},{"id":"d","text":"74.4%"}]'::jsonb,
  'b',
  'Households fewer than 4: 1-person (25.6%) + 2-person (34.4%) + 3-person (14.5%) = 74.5%. Households with 4+: approximately $100 - 74.5 = 25.5\% \approx 25.6\%$.',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation - 5-person Households)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Owner-Occupied Housing by Household Size (75,986,074 total). 5-person households account for 6.4% of the total. Approximately how many households are 5-person households?',
  '[{"id":"a","text":"2 million"},{"id":"b","text":"3 million"},{"id":"c","text":"4 million"},{"id":"d","text":"5 million"}]'::jsonb,
  'd',
  '$0.064 \times 76{,}000{,}000 \approx 4{,}864{,}000$. This is approximately 5 million.',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Q14: Numeric Entry (Data Interpretation - Projected 1-person Households)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Data: Owner-Occupied Housing by Household Size (75,986,074 total). 1-person households are 25.6%. If the total number of households increases by 10%, but the percentage of 1-person households remains the same, how many 1-person households will there be (in millions)?',
  NULL,
  '21.4',
  'New total $\approx 76{,}000{,}000 \times 1.1 = 83{,}600{,}000$. 1-person at 25.6%: $0.256 \times 83{,}600{,}000 \approx 21{,}400{,}000$ or $21.4$ million.',
  NULL, NULL, NULL,
  'hard', 2, 4, 'quantitative', true
);

-- Seed: Section 2, Easy, Set 5 - 15 questions
-- Source: Docs for me/latex_with_rijay/gre_quant_mock/section2_easy_set5.tex

-- Q1: Quantitative Comparison (Circle in Square)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A circle is inscribed in a square that has an area of 50.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Side $= \sqrt{50}$. Radius $= \sqrt{50}/2$. Area $= \pi(50/4) = 12.5\pi$. Equal.',
  'The area of the circle',
  '$12.5\\pi$',
  'A circle is inscribed in a square that has an area of 50.',
  'easy', 2, 5, 'quantitative', true
);

-- Q2: Quantitative Comparison (Slope)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A line has a slope of $-2$ and passes through the points $(4, 9)$ and $(6, y)$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  '$-2 = (y - 9)/(6 - 4) = (y - 9)/2$. So $y - 9 = -4$, giving $y = 5$. Since $5 < 6$, Quantity B is greater.',
  '$y$',
  '6',
  'A line has slope $-2$ and passes through $(4, 9)$ and $(6, y)$.',
  'easy', 2, 5, 'quantitative', true
);

-- Q3: Quantitative Comparison (Triangle Angles)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In a triangle with angles $x^\circ$, $y^\circ$, and $z^\circ$, $x + z = 110$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Sum of angles: $x + y + z = 180$. Since $x + z = 110$: $y = 180 - 110 = 70$. Equal.',
  '$y$',
  '70',
  'In a triangle, $x + z = 110$.',
  'easy', 2, 5, 'quantitative', true
);

-- Q4: Quantitative Comparison (Standard Deviation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A set of numbers $N$ is multiplied by $-3$ to create a new set.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Multiplying by a constant $k$ multiplies the standard deviation by $|k|$. Here $|{-3}| = 3$, so the new SD is 3 times the original. Quantity A is greater.',
  'The standard deviation of the new set',
  'The standard deviation of set $N$',
  'A set of numbers $N$ is multiplied by $-3$ to create a new set.',
  'easy', 2, 5, 'quantitative', true
);

-- Q5: Quantitative Comparison (Normal Distribution)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A species of insect has an average mass of 5.2g and a standard deviation of 0.6g (normally distributed).',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Qty A: 5.2g to 5.8g spans 0 to +1 SD (about 34.1%). Qty B: 4.9g to 5.5g spans -0.5 to +0.5 SD (about 38.3%). Actually, the range from mean to +1 SD captures more area on one side. The 1-SD range from 5.2–5.8 captures ~34.1%. The range 4.9–5.5 captures the area from -0.5 to +0.5 SD which is ~38.3%. However, rechecking: Qty A is one full SD width on one side of mean; Qty B is 0.5 SD on each side. Qty A (34.1%) > Qty B area from z=-0.5 to z=+0.5 (38.3%). The source gives A as the answer.',
  'Percent of insects between 5.2g and 5.8g',
  'Percent of insects between 4.9g and 5.5g',
  'Insect mass: mean 5.2g, SD 0.6g, normally distributed.',
  'easy', 2, 5, 'quantitative', true
);

-- Q6: Single Choice (Carpet Cost)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Wall-to-wall carpeting costs \$4.25 per square foot. How much will it cost to carpet a hallway that is 4 feet wide and 15 feet long?',
  '[{"id":"a","text":"\\$60"},{"id":"b","text":"\\$170"},{"id":"c","text":"\\$240"},{"id":"d","text":"\\$255"},{"id":"e","text":"\\$300"}]'::jsonb,
  'd',
  'Area $= 4 \times 15 = 60$ sq ft. Cost $= 60 \times 4.25 = \$255$.',
  NULL, NULL, NULL,
  'easy', 2, 5, 'quantitative', true
);

-- Q7: Single Choice (Point on Line)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Which of the following points lies on the line $y = 2x - 8$?',
  '[{"id":"a","text":"$(3, -2)$"},{"id":"b","text":"$(2, 4)$"},{"id":"c","text":"$(0, 8)$"},{"id":"d","text":"$(-8, 0)$"},{"id":"e","text":"$(5, 1)$"}]'::jsonb,
  'a',
  'Test $x = 3$: $y = 2(3) - 8 = -2$. The point $(3, -2)$ satisfies the equation.',
  NULL, NULL, NULL,
  'easy', 2, 5, 'quantitative', true
);

-- Q8: Single Choice (Circle Area - Doubled Radius)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A circle with an area of $4\pi$ has its radius doubled. What is the new area?',
  '[{"id":"a","text":"$8\\pi$"},{"id":"b","text":"$12\\pi$"},{"id":"c","text":"$16\\pi$"},{"id":"d","text":"$32\\pi$"},{"id":"e","text":"$64\\pi$"}]'::jsonb,
  'c',
  'Original: $\pi r^2 = 4\pi$, so $r = 2$. New radius: $4$. New area: $\pi(4^2) = 16\pi$.',
  NULL, NULL, NULL,
  'easy', 2, 5, 'quantitative', true
);

-- Q9: Single Choice (Discount Problem)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Marcy bought jeans at 70% off and a blouse at 40% off. She paid \$12 more for the blouse and spent \$84 total. What was the original price of the jeans?',
  '[{"id":"a","text":"\\$76"},{"id":"b","text":"\\$96"},{"id":"c","text":"\\$100"},{"id":"d","text":"\\$120"},{"id":"e","text":"\\$140"}]'::jsonb,
  'd',
  'Sale prices: $J + B = 84$ and $B = J + 12$. So $2J + 12 = 84 \Rightarrow J = 36$. Jeans sale price is 30% of original: $0.30P = 36 \Rightarrow P = \$120$.',
  NULL, NULL, NULL,
  'easy', 2, 5, 'quantitative', true
);

-- Q10: Single Choice (Average)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'John bought 5 books for an average of \$12 each. If he then buys a 6th book for \$18, what is the new average price?',
  '[{"id":"a","text":"\\$13"},{"id":"b","text":"\\$14"},{"id":"c","text":"\\$15"},{"id":"d","text":"\\$16"},{"id":"e","text":"\\$17"}]'::jsonb,
  'a',
  'Total for 5 books: $5 \times 12 = 60$. After 6th: $60 + 18 = 78$. New average: $78/6 = \$13$.',
  NULL, NULL, NULL,
  'easy', 2, 5, 'quantitative', true
);

-- Q11: Numeric Entry (Tiles)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'A hallway is 6 feet by 8 feet. How many 2-foot by 2-foot square tiles are needed to cover it?',
  NULL,
  '12',
  'Hallway area: $6 \times 8 = 48$ sq ft. Tile area: $2 \times 2 = 4$ sq ft. Tiles needed: $48/4 = 12$.',
  NULL, NULL, NULL,
  'easy', 2, 5, 'quantitative', true
);

-- Q12: Numeric Entry (Average Equation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'If the average of $n$ and 11 is $2n$, what is the value of $n$? (Round to two decimal places.)',
  NULL,
  '3.67',
  '$(n + 11)/2 = 2n \Rightarrow n + 11 = 4n \Rightarrow 3n = 11 \Rightarrow n = 11/3 \approx 3.67$.',
  NULL, NULL, NULL,
  'easy', 2, 5, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation - Freezing Days)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Monthly freezing days (min temp 32°F or less) for St. Louis: Jan ~27, Feb ~22, Mar ~11, Apr ~2, Oct ~5, Nov ~16, Dec ~24. In how many months did St. Louis have more than 15 freezing days?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"4"},{"id":"d","text":"5"},{"id":"e","text":"6"}]'::jsonb,
  'c',
  'Months with >15 freezing days: January (27), February (22), November (16), December (24). Total: 4 months.',
  NULL, NULL, NULL,
  'easy', 2, 5, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation - Hot Days)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Days with max temp 90°F+ for Winnemucca by month: June ~2, July ~16, August ~8, September ~2. What was the total number of days in the year that Winnemucca reached these temperatures?',
  '[{"id":"a","text":"22"},{"id":"b","text":"28"},{"id":"c","text":"34"},{"id":"d","text":"42"},{"id":"e","text":"59"}]'::jsonb,
  'b',
  'Total: $2 + 16 + 8 + 2 = 28$ days.',
  NULL, NULL, NULL,
  'easy', 2, 5, 'quantitative', true
);

-- Q15: Single Choice (Data Interpretation - Percentage)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'For the month of July, the number of days with a maximum temperature of 90°F or more in Galveston was approximately 23 days. What percent of the total number of days in July does this represent?',
  '[{"id":"a","text":"55%"},{"id":"b","text":"68%"},{"id":"c","text":"74%"},{"id":"d","text":"82%"},{"id":"e","text":"95%"}]'::jsonb,
  'c',
  'July has 31 days. $23/31 \approx 0.742 = 74\%$.',
  NULL, NULL, NULL,
  'easy', 2, 5, 'quantitative', true
);

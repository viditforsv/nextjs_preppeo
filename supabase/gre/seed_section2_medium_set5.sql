-- Seed: Section 2, Medium, Set 5 - 15 questions
-- Source: Docs for me/latex_with_rijay/gre_quant_mock/section2_medium_set5.tex

-- Q1: Quantitative Comparison (Triangle Geometry)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In a figure, $XZ = 6$, $ZW = 3$, $YZ = 5$. Angle $XWY$ is $90^\circ$. Point $Z$ lies on $XW$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'By Pythagorean theorem on triangle $YZW$: $YW^2 + 3^2 = 5^2 \Rightarrow YW = 4$. Area of $XYZ = \dfrac{1}{2} \cdot 6 \cdot 4 = 12$. Equal.',
  'The area of triangle $XYZ$',
  '12',
  '$XZ = 6$, $ZW = 3$, $YZ = 5$, angle $XWY = 90^\\circ$.',
  'medium', 2, 5, 'quantitative', true
);

-- Q2: Quantitative Comparison (Y-intercept)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A line has a slope of $-2$ and passes through the point $(4, 9)$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  '$y - 9 = -2(x - 4) \Rightarrow y = -2x + 17$. The $y$-intercept is 17. Equal.',
  'The $y$-intercept of the line',
  '17',
  'A line has slope $-2$ and passes through $(4, 9)$.',
  'medium', 2, 5, 'quantitative', true
);

-- Q3: Quantitative Comparison (Intersecting Lines)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Two lines intersect forming angles $a, b, f, g, e, h$. $a > 90$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'Without a specific diagram showing the arrangement of all angles, the relationship between $g$ and $h$ cannot be determined, so the comparison of $a + f + g$ vs $b + e + h$ is indeterminate.',
  '$a + f + g$',
  '$b + e + h$',
  'Two lines intersect. $a > 90$.',
  'medium', 2, 5, 'quantitative', true
);

-- Q4: Quantitative Comparison (Barter System)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In a barter system, 1 sack of rice = 2.5 lbs of beans OR $1/3$ bushel of tomatoes.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  '1 lb beans $= 1/2.5 = 0.4$ sacks. 1 bushel tomatoes $= 1/(1/3) = 3$ sacks. $0.4 < 3$, Quantity B is greater.',
  'Sacks of rice for 1 lb of beans',
  'Sacks of rice for 1 bushel of tomatoes',
  '1 sack of rice = 2.5 lbs of beans OR $1/3$ bushel of tomatoes.',
  'medium', 2, 5, 'quantitative', true
);

-- Q5: Quantitative Comparison (MP3 Capacity)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Francisco''s MP3 player (64GB) was $3/4$ full. He deleted 25% of the data, then saved 20GB of new data.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Initial: $64 \times 0.75 = 48$ GB. After delete: $48 \times 0.75 = 36$ GB. After save: $36 + 20 = 56$ GB. Percent: $56/64 = 87.5\%$. Equal.',
  'Final data as a percent of capacity',
  '87.5%',
  '64GB player, $3/4$ full, deleted 25%, then saved 20GB.',
  'medium', 2, 5, 'quantitative', true
);

-- Q6: Single Choice (Circle in Square)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A circle is inscribed in a square that has an area of 50. What is the area of the circle?',
  '[{"id":"a","text":"$12.5\\pi$"},{"id":"b","text":"$25\\pi$"},{"id":"c","text":"$50\\pi$"},{"id":"d","text":"$625\\pi/16$"}]'::jsonb,
  'a',
  'Side $= \sqrt{50}$. Radius $= \sqrt{50}/2$. Area $= \pi \cdot 50/4 = 12.5\pi$.',
  NULL, NULL, NULL,
  'medium', 2, 5, 'quantitative', true
);

-- Q7: Single Choice (Subscribers)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Last year, a magazine charged \$50 per subscription. This year, the price increases by \$10. If the magazine loses 4 subscribers but collects the same revenue, how many subscribers were there last year?',
  '[{"id":"a","text":"20"},{"id":"b","text":"21"},{"id":"c","text":"24"},{"id":"d","text":"25"}]'::jsonb,
  'c',
  '$50n = 60(n - 4) \Rightarrow 50n = 60n - 240 \Rightarrow 10n = 240 \Rightarrow n = 24$.',
  NULL, NULL, NULL,
  'medium', 2, 5, 'quantitative', true
);

-- Q8: Single Choice (Mixture Percentage)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A bag of snack mix contains 3oz pretzels, 1oz chocolate, and 2oz nuts. $x$ ounces of dried fruit are added. What percent of the mix is dried fruit?',
  '[{"id":"a","text":"$\\dfrac{x}{6 + x} \\cdot 100$"},{"id":"b","text":"$\\dfrac{100x}{6}$"},{"id":"c","text":"$\\dfrac{x}{600}$"},{"id":"d","text":"$\\dfrac{100}{6x}$"}]'::jsonb,
  'a',
  'Original mix: $3 + 1 + 2 = 6$ oz. After adding: $6 + x$ oz. Percentage: $\dfrac{x}{6 + x} \times 100$.',
  NULL, NULL, NULL,
  'medium', 2, 5, 'quantitative', true
);

-- Q9: Single Choice (Rate/Time)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Kurt is behind 200 people in line. 4 people board every 15 seconds. How many minutes until Kurt boards the coaster?',
  '[{"id":"a","text":"8"},{"id":"b","text":"10"},{"id":"c","text":"12.5"},{"id":"d","text":"15"}]'::jsonb,
  'c',
  'Rate: $4 \times 4 = 16$ people per minute. Time: $200/16 = 12.5$ minutes.',
  NULL, NULL, NULL,
  'medium', 2, 5, 'quantitative', true
);

-- Q10: Single Choice (Cost Ratios)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'The total cost of 3 bananas, 2 apples, and 1 mango is \$3.50. The cost of 3 bananas, 2 apples, and 1 papaya is \$4.20. The ratio of mango cost to papaya cost is 3:5. What is the cost of a mango?',
  '[{"id":"a","text":"\\$0.60"},{"id":"b","text":"\\$0.90"},{"id":"c","text":"\\$1.05"},{"id":"d","text":"\\$1.50"}]'::jsonb,
  'c',
  'Let $X$ = cost of 3B + 2A. $X + M = 3.50$, $X + P = 4.20$. So $P - M = 0.70$. With $M:P = 3:5$: $5k - 3k = 0.70 \Rightarrow k = 0.35$. Mango $= 3(0.35) = \$1.05$.',
  NULL, NULL, NULL,
  'medium', 2, 5, 'quantitative', true
);

-- Q11: Numeric Entry (Percent Increase)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'A shirt costs $k$ dollars. It increases by 30%, then by an additional 50%. What is the coefficient of $k$ in the new price? (i.e., if the new price is $ck$, what is $c$?)',
  NULL,
  '1.95',
  'After 30% increase: $1.30k$. After 50% increase: $1.30k \times 1.50 = 1.95k$. The coefficient is 1.95.',
  NULL, NULL, NULL,
  'medium', 2, 5, 'quantitative', true
);

-- Q12: Numeric Entry (Intersecting Lines - Angles)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Two lines intersect such that $35^\circ$ is one of the angles. What is the sum of the other three angles?',
  NULL,
  '325',
  'All angles around the intersection sum to $360^\circ$. Other three angles: $360 - 35 = 325$.',
  NULL, NULL, NULL,
  'medium', 2, 5, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation - Cross Country Overlap)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Varsity Sports Rosters. Male athletes: Track & Field 37, Cross Country 17. If 11 males total are on both Track and Cross Country, what percent of the male Cross Country athletes are also on the Track team?',
  '[{"id":"a","text":"45%"},{"id":"b","text":"55%"},{"id":"c","text":"65%"},{"id":"d","text":"75%"}]'::jsonb,
  'c',
  'Males on Cross Country: 17. On both teams: 11. Percentage: $11/17 \approx 64.7\% \approx 65\%$.',
  NULL, NULL, NULL,
  'medium', 2, 5, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation - Ratio)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Varsity Sports Rosters. Female athletes: Basketball 15, Track & Field 61. What is the ratio of female Basketball players to female Track and Field players?',
  '[{"id":"a","text":"15:61"},{"id":"b","text":"24:37"},{"id":"c","text":"1:4"},{"id":"d","text":"1:3"}]'::jsonb,
  'a',
  'Female Basketball: 15. Female Track & Field: 61. Ratio: 15:61.',
  NULL, NULL, NULL,
  'medium', 2, 5, 'quantitative', true
);

-- Q15: Numeric Entry (Data Interpretation - Female Comparison)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Data: Varsity Sports Rosters. Female athletes: Volleyball 16, Track & Field 61, Tennis 9, Cross Country 23, Basketball 15. How many more female athletes are there in Track and Field than in all other sports combined?',
  NULL,
  '-2',
  'Others combined: $16 + 9 + 23 + 15 = 63$. Track & Field: 61. Difference: $61 - 63 = -2$. There are actually 2 fewer in Track & Field.',
  NULL, NULL, NULL,
  'medium', 2, 5, 'quantitative', true
);

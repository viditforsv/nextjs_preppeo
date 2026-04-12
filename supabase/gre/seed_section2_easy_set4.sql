-- Seed: Section 2, Easy, Set 4 - 15 questions
-- Source: Docs for me/latex_with_rijay/gre_quant_mock/section2_easy_set4.tex

-- Q1: Quantitative Comparison (Percentiles)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'On a standardized test, the 75th percentile corresponds to a score of 700, and the 25th percentile corresponds to a score of 450.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'Percentiles indicate relative standing, not a linear progression. Without knowing the standard deviation or the shape of the distribution, the 95th percentile cannot be calculated. The relationship cannot be determined.',
  'A 95th percentile score',
  '800',
  'On a standardized test, the 75th percentile corresponds to a score of 700, and the 25th percentile corresponds to a score of 450.',
  'easy', 2, 4, 'quantitative', true
);

-- Q2: Quantitative Comparison (Coordinate Geometry)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A line passes through $(3, -2)$ and $(-8, 0)$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  'Slope $= \dfrac{0 - (-2)}{-8 - 3} = \dfrac{2}{-11}$. A negative value is less than zero. Quantity B is greater.',
  'The slope of the line',
  '0',
  'A line passes through $(3, -2)$ and $(-8, 0)$.',
  'easy', 2, 4, 'quantitative', true
);

-- Q3: Quantitative Comparison (Isosceles Triangle)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Two sides of an isosceles triangle are 2 and 11.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'The third side must be 2 or 11. If sides are 2, 2, 11: $2 + 2 < 11$ (violates triangle inequality). The only valid triangle has sides 11, 11, 2. Perimeter $= 11 + 11 + 2 = 24$.',
  'The perimeter of the triangle',
  '24',
  'Two sides of an isosceles triangle are 2 and 11.',
  'easy', 2, 4, 'quantitative', true
);

-- Q4: Quantitative Comparison (Weighted Averages)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A store sold three times as many jeans as chinos. The profit for a pair of chinos is twice the profit for a pair of jeans.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Let chinos sold $= n$, jeans profit $= p$. Jeans: $3n \cdot p = 3np$. Chinos: $n \cdot 2p = 2np$. Total: $5np$. Chinos share: $2np / 5np = 40\%$.',
  'Percent of total profit from chinos',
  '40%',
  'A store sold three times as many jeans as chinos. The profit for a pair of chinos is twice the profit for a pair of jeans.',
  'easy', 2, 4, 'quantitative', true
);

-- Q5: Quantitative Comparison (Geometry - Triangle)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In a figure, $ZW = 3$, $XZ = 6$, and $YZ = 5$. Triangle $XYW$ is a right triangle with the right angle at $W$. Point $Z$ lies on $XW$ between $X$ and $W$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Using Pythagorean theorem on triangle $YZW$: $YW^2 + ZW^2 = YZ^2 \Rightarrow YW^2 + 9 = 25 \Rightarrow YW = 4$. Area of $XYZ = \dfrac{1}{2} \cdot XZ \cdot YW = \dfrac{1}{2} \cdot 6 \cdot 4 = 12$.',
  'The area of triangle $XYZ$',
  '12',
  '$ZW = 3$, $XZ = 6$, $YZ = 5$. Triangle $XYW$ is a right triangle with the right angle at $W$.',
  'easy', 2, 4, 'quantitative', true
);

-- Q6: Single Choice (Rectangle Perimeter)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'The length of a rectangle is 2 more than twice its width. The area is 40. What is the perimeter of the rectangle?',
  '[{"id":"a","text":"20"},{"id":"b","text":"26"},{"id":"c","text":"28"},{"id":"d","text":"32"},{"id":"e","text":"36"}]'::jsonb,
  'c',
  'Let width $= w$, length $= 2w + 2$. Area: $w(2w + 2) = 40 \Rightarrow 2w^2 + 2w - 40 = 0 \Rightarrow w^2 + w - 20 = 0 \Rightarrow (w+5)(w-4) = 0$. So $w = 4$, $l = 10$. Perimeter $= 2(10 + 4) = 28$.',
  NULL, NULL, NULL,
  'easy', 2, 4, 'quantitative', true
);

-- Q7: Single Choice (Age Problem)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Rey is 12 years younger than Sebastian. Five years ago, Rey was half Sebastian''s age. How old will Sebastian be next year?',
  '[{"id":"a","text":"25"},{"id":"b","text":"29"},{"id":"c","text":"30"},{"id":"d","text":"32"},{"id":"e","text":"35"}]'::jsonb,
  'c',
  'Let Sebastian $= S$, Rey $= S - 12$. Five years ago: $(S - 17) = \dfrac{1}{2}(S - 5)$. So $S - 17 = 0.5S - 2.5 \Rightarrow 0.5S = 14.5 \Rightarrow S = 29$. Next year: $29 + 1 = 30$.',
  NULL, NULL, NULL,
  'easy', 2, 4, 'quantitative', true
);

-- Q8: Single Choice (Circle Area Scaling)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If the radius of a circle is doubled, the new area is how many times the original?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"4"},{"id":"d","text":"5"},{"id":"e","text":"8"}]'::jsonb,
  'c',
  'Area is proportional to $r^2$. New area $= \pi(2r)^2 = 4\pi r^2$. This is 4 times the original.',
  NULL, NULL, NULL,
  'easy', 2, 4, 'quantitative', true
);

-- Q9: Single Choice (Arithmetic)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Attendees at a charity dinner gave at least \$85 each. If \$6,450 was collected, what is the maximum number of people who could have attended?',
  '[{"id":"a","text":"73"},{"id":"b","text":"74"},{"id":"c","text":"75"},{"id":"d","text":"76"},{"id":"e","text":"77"}]'::jsonb,
  'c',
  'To maximize attendees, assume each gave the minimum: $6450 / 85 = 75.88$. Since 76 people would need at least $76 \times 85 = \$6460 > \$6450$, the maximum is 75.',
  NULL, NULL, NULL,
  'easy', 2, 4, 'quantitative', true
);

-- Q10: Single Choice (Circle Inscribed in Square)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A circle is inscribed in a square that has an area of 50. What is the area of the circle?',
  '[{"id":"a","text":"$12.5\\pi$"},{"id":"b","text":"$25\\pi$"},{"id":"c","text":"$50\\pi$"},{"id":"d","text":"$100\\pi$"}]'::jsonb,
  'a',
  'Side of square $= \sqrt{50}$. Radius of inscribed circle $= \sqrt{50}/2$. Area $= \pi(\sqrt{50}/2)^2 = 50\pi/4 = 12.5\pi$.',
  NULL, NULL, NULL,
  'easy', 2, 4, 'quantitative', true
);

-- Q11: Multi-Select (Points on a Line)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Which of the following points lie on the line $y = 2x - 8$? Indicate all such points.',
  '[{"id":"a","text":"$(3, -2)$"},{"id":"b","text":"$(0, -8)$"},{"id":"c","text":"$(4, 0)$"},{"id":"d","text":"$(-8, 0)$"}]'::jsonb,
  '["a","b","c"]',
  'A: $-2 = 2(3) - 8 = -2$ (True). B: $-8 = 2(0) - 8 = -8$ (True). C: $0 = 2(4) - 8 = 0$ (True). D: $0 = 2(-8) - 8 = -24$ (False).',
  NULL, NULL, NULL,
  'easy', 2, 4, 'quantitative', true
);

-- Q12: Multi-Select (Polygon Angles)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Let $x$ be the interior angle of a regular hexagon and $y$ be the interior angle of a regular octagon. Which of the following is true? Indicate all such statements.',
  '[{"id":"a","text":"$y > x$"},{"id":"b","text":"$x + y = 255^\\circ$"},{"id":"c","text":"$y - x = 15^\\circ$"}]'::jsonb,
  '["a","b","c"]',
  'Interior angle formula: $(n-2) \\cdot 180/n$. Hexagon: $x = 720/6 = 120^\\circ$. Octagon: $y = 1080/8 = 135^\\circ$. A: $135 > 120$ (True). B: $120 + 135 = 255$ (True). C: $135 - 120 = 15$ (True).',
  NULL, NULL, NULL,
  'easy', 2, 4, 'quantitative', true
);

-- Q13: Multi-Select (Data Interpretation - Temperature)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Data: A bar chart shows monthly freezing days and days above 90°F for St. Louis. January has over 25 freezing days, July has the most days above 90°F, and June and July have zero freezing days. Which statements about St. Louis temperatures are true? Indicate all such statements.',
  '[{"id":"a","text":"St. Louis had more than 25 freezing days in January."},{"id":"b","text":"July was the month with the most days above 90°F."},{"id":"c","text":"There were no freezing days in June or July."}]'::jsonb,
  '["a","b","c"]',
  'A: The chart shows St. Louis bar for January is above 25 (True). B: July has the highest bar for days above 90°F (True). C: Freezing days in June and July are at zero (True).',
  NULL, NULL, NULL,
  'easy', 2, 4, 'quantitative', true
);

-- Q14: Numeric Entry (Statistics - Average)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'If the average of $n$ and 11 is $2n$, what is the average of $n$ and $13/3$?',
  NULL,
  '4',
  'Solve for $n$: $(n + 11)/2 = 2n \Rightarrow n + 11 = 4n \Rightarrow n = 11/3$. Average of $11/3$ and $13/3$: $(11/3 + 13/3)/2 = (24/3)/2 = 8/2 = 4$.',
  NULL, NULL, NULL,
  'easy', 2, 4, 'quantitative', true
);

-- Q15: Numeric Entry (Age Algebra)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Beth is 12 years younger than Alan. In 20 years, Beth will be 80% of Alan''s age. How old is Beth now?',
  NULL,
  '28',
  'Let Alan $= A$, Beth $= A - 12$. In 20 years: $(A - 12 + 20) = 0.8(A + 20)$. So $A + 8 = 0.8A + 16 \Rightarrow 0.2A = 8 \Rightarrow A = 40$. Beth $= 40 - 12 = 28$.',
  NULL, NULL, NULL,
  'easy', 2, 4, 'quantitative', true
);

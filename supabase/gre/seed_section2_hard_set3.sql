-- Seed: Section 2, Set 3 (Hard) - 15 questions
-- Source: Docs for me/gre_mock/section2_hard_set3.tex

-- Q1: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Eight women and two men are available. Three people are picked at random to form a committee.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  '$P(\text{at least one man}) = 1 - P(\text{all women}) = 1 - \dfrac{\binom{8}{3}}{\binom{10}{3}} = 1 - \dfrac{56}{120} = \dfrac{8}{15} \approx 0.533 > 0.5$. Quantity A is greater.',
  'The probability that the committee includes at least one man',
  '0.5',
  'Eight women and two men are available. Three people are picked at random to form a committee.',
  'hard', 2, 3, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A parabola has vertex $(1, 2)$ and passes through $(0, 3)$. It is defined by $y = a(x-h)^2 + k$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Vertex $(h,k) = (1,2)$. From $3 = a(0-1)^2 + 2$ we get $a = 1$. So $a + h + k = 1 + 1 + 2 = 4$. The two quantities are equal.',
  '$a + h + k$',
  '4',
  'A parabola has vertex $(1, 2)$ and passes through $(0, 3)$, with $y = a(x-h)^2 + k$.',
  'hard', 2, 3, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$x$ is a non-zero integer and $0 < y < 1$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  '$x^2 \geq 1$ and $y \in (0,1)$, so $x^2/y > x^2 \geq 1$. Quantity A is always greater than 1.',
  '$x^2 / y$',
  '1',
  '$x$ is a non-zero integer and $0 < y < 1$.',
  'hard', 2, 3, 'quantitative', true
);

-- Q4: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'An inventory contains 100 different coins.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  '$\binom{100}{56} = \binom{100}{44}$ by the identity $\binom{n}{k} = \binom{n}{n-k}$. The two quantities are equal.',
  'The number of possible collections of 56 coins that can be selected',
  'The number of possible collections of 44 coins that can be selected',
  'An inventory contains 100 different coins.',
  'hard', 2, 3, 'quantitative', true
);

-- Q5: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$x + y = 10$ and $|x + y| = 10$. $x \geq 0$ and $z < y - x$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  'When $x=0$, $y=10$, so $y-x=10$ and $z < 10$. For $x>0$, $y-x < 10$, so $z < 10$ always. Quantity B is greater.',
  '$z$',
  '10',
  '$x + y = 10$, $x \geq 0$, and $z < y - x$.',
  'hard', 2, 3, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A solid right circular cylinder with height 9 and radius 2 is cut into three cylinders of equal height. How much new surface area is created?',
  '[{"id":"a","text":"$4\\pi$"},{"id":"b","text":"$8\\pi$"},{"id":"c","text":"$12\\pi$"},{"id":"d","text":"$16\\pi$"},{"id":"e","text":"$24\\pi$"}]'::jsonb,
  'd',
  'Two cuts create 4 new circular faces. Each face area $= \pi (2)^2 = 4\pi$. New surface area $= 4 \times 4\pi = 16\pi$.',
  NULL, NULL, NULL,
  'hard', 2, 3, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'One robot''s polishing rate is 3/5 that of another. Working together they polish 88 pounds in 6 minutes. How many minutes would it take the slower robot alone to polish 165 pounds?',
  '[{"id":"a","text":"15.75"},{"id":"b","text":"18"},{"id":"c","text":"25"},{"id":"d","text":"30"},{"id":"e","text":"40"}]'::jsonb,
  'd',
  'Combined rate $= 88/6 = 44/3$ lbs/min. If faster $= R$, then $R + (3/5)R = (8/5)R = 44/3$, so $R = 55/6$, slower $= 11/2$. Time $= 165/(11/2) = 30$ min.',
  NULL, NULL, NULL,
  'hard', 2, 3, 'quantitative', true
);

-- Q8: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'In a certain group, the ratio of women to men is 5 to 6, and the ratio of left-handed to right-handed people is 7 to 9. If everyone is either left- or right-handed, what is the minimum number of people in the group?',
  '[{"id":"a","text":"11"},{"id":"b","text":"16"},{"id":"c","text":"66"},{"id":"d","text":"176"},{"id":"e","text":"196"}]'::jsonb,
  'd',
  'Total must be a multiple of $5+6=11$ and of $7+9=16$. LCM(11, 16) $= 176$.',
  NULL, NULL, NULL,
  'hard', 2, 3, 'quantitative', true
);

-- Q9: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A 10-inch square is cut in half along the diagonal, then one half is cut again from a corner to the midpoint of the opposite side. What is the perimeter of one of the smallest triangles?',
  '[{"id":"a","text":"10"},{"id":"b","text":"$10\\sqrt{2}$"},{"id":"c","text":"20"},{"id":"d","text":"$10 + 10\\sqrt{2}$"},{"id":"e","text":"$10 + 5\\sqrt{2}$"}]'::jsonb,
  'd',
  'First cut: two isosceles right triangles with legs 10, hypotenuse $10\sqrt{2}$. Second cut splits hypotenuse into $5\sqrt{2}$ each. Smallest triangle has sides $10$, $5\sqrt{2}$, $5\sqrt{2}$; perimeter $= 10 + 10\sqrt{2}$.',
  NULL, NULL, NULL,
  'hard', 2, 3, 'quantitative', true
);

-- Q10: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A polygon has 12 edges. How many different diagonals can be drawn from its vertices?',
  '[{"id":"a","text":"54"},{"id":"b","text":"66"},{"id":"c","text":"108"},{"id":"d","text":"132"},{"id":"e","text":"144"}]'::jsonb,
  'a',
  'Number of diagonals $= \dfrac{n(n-3)}{2} = \dfrac{12 \times 9}{2} = 54$.',
  NULL, NULL, NULL,
  'hard', 2, 3, 'quantitative', true
);

-- Q11: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'The average age of buildings on a block is greater than 40 years. Four buildings are 2 years old and none are older than 80. Which of the following could be the number of buildings on the block? Indicate all such values.',
  '[{"id":"a","text":"6"},{"id":"b","text":"8"},{"id":"c","text":"11"},{"id":"d","text":"40"}]'::jsonb,
  '["b","c","d"]',
  'Sum $S > 40n$. Minimum sum with four 2-year-olds and rest $\leq 80$: $8 + (n-4)80$ must exceed $40n$, so $40n < 8 + 80n - 320 \implies n > 7.8$. So $n \geq 8$. Possible: 8, 11, 40.',
  NULL, NULL, NULL,
  'hard', 2, 3, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'A parabola has equation $y = (x - h)^2 + k$ and vertex $(2, 16)$. The point $(-3, n)$ lies on the parabola. What is $n$?',
  NULL,
  '41',
  '$n = (-3-2)^2 + 16 = 25 + 16 = 41$.',
  NULL, NULL, NULL,
  'hard', 2, 3, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Defects per 1,000 vs experience (hours): (1000,15), (2000,28), (4000,42), (6000,50), (8000,52), (10000,48), (12000,30), (14000,12). Approximately how many defects per 1,000 for an operator with 12,000 hours?',
  '[{"id":"a","text":"12"},{"id":"b","text":"20"},{"id":"c","text":"30"},{"id":"d","text":"40"},{"id":"e","text":"50"}]'::jsonb,
  'c',
  'At 12,000 hours the data point shows 30 defects per 1,000.',
  NULL, NULL, NULL,
  'hard', 2, 3, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Defects per 1,000 vs experience — peak defects at 8000 hrs. On average, operators with how many hours of experience produce the most defective parts?',
  '[{"id":"a","text":"4,000"},{"id":"b","text":"6,000"},{"id":"c","text":"8,000"},{"id":"d","text":"10,000"},{"id":"e","text":"12,000"}]'::jsonb,
  'c',
  'The curve peaks at approximately 8,000 hours.',
  NULL, NULL, NULL,
  'hard', 2, 3, 'quantitative', true
);

-- Q15: Multi-Select (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Data: Manufacturing defects vs experience (curve rises then falls). Which of the following statements about the data is true? Indicate all such statements.',
  '[{"id":"a","text":"Defects initially increase with experience but later decrease."},{"id":"b","text":"An operator with 14,000 hours is more efficient than one with 4,000 hours."},{"id":"c","text":"The relationship between experience and defects is linear."}]'::jsonb,
  '["a","b"]',
  'A: Graph rises then falls (true). B: At 14k defects ≈ 12, at 4k ≈ 42; 14k is more efficient (true). C: Relationship is curved, not linear (false).',
  NULL, NULL, NULL,
  'hard', 2, 3, 'quantitative', true
);

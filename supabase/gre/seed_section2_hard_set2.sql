-- Seed: Section 2, Set 2 (Hard) - 15 questions
-- Source: Docs for me/gre_mock/section2_hard_set2.tex

-- Q1: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Let $S$ be a set of $n$ distinct integers with range $r$. A new set $T$ is created by multiplying every element in $S$ by $-3$ and then adding 5.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'After $y = -3x + 5$, the new max is at old min and new min at old max. Range of $T$ $= (-3 S_{min}+5) - (-3 S_{max}+5) = 3(S_{max}-S_{min}) = 3r$. The two quantities are equal.',
  'The range of set $T$',
  '$3r$',
  'Let $S$ be a set of $n$ distinct integers with range $r$. $T$ is created by multiplying every element in $S$ by $-3$ and then adding 5.',
  'hard', 2, 2, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$k$ is a positive integer.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Remainder mod 10 is the units digit. $7^{4k+2}$: cycle 7,9,3,1, position 2 gives 9. $3^{4k+2}$: cycle 3,9,7,1, position 2 gives 9. Both equal 9.',
  'The remainder when $7^{4k+2}$ is divided by 10',
  'The remainder when $3^{4k+2}$ is divided by 10',
  '$k$ is a positive integer.',
  'hard', 2, 2, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A container holds 12 red marbles and 18 blue marbles. Two marbles are drawn at random without replacement.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  '$P(\text{both blue}) = \dfrac{18}{30} \times \dfrac{17}{29} = \dfrac{51}{145} \approx 0.352$. Quantity B $= 1/3 \approx 0.333$. Quantity A is greater.',
  'The probability that both marbles are blue',
  '$1/3$',
  'A container holds 12 red and 18 blue marbles. Two marbles are drawn at random without replacement.',
  'hard', 2, 2, 'quantitative', true
);

-- Q4: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$a$ and $b$ are integers such that $a^2 - b^2 = 21$ and $a > b > 0$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  '$(a-b)(a+b) = 21$. Pairs: (1,21) gives $a=11$, $b=10$, $ab=110$; (3,7) gives $a=5$, $b=2$, $ab=10$. So $ab$ can be greater or less than 12. Cannot be determined.',
  '$a \times b$',
  '12',
  '$a$ and $b$ are integers such that $a^2 - b^2 = 21$ and $a > b > 0$.',
  'hard', 2, 2, 'quantitative', true
);

-- Q5: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In a square of side $s$, $T_1$ is the triangle formed by one diagonal. $T_2$ is the right triangle formed by connecting the midpoints of two adjacent sides.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Area $T_1 = \dfrac{1}{2}s^2$. $T_2$ has legs $s/2$, so area $T_2 = \dfrac{s^2}{8}$. Thus $4 \times T_2 = s^2/2 = T_1$. The two quantities are equal.',
  'Area of $T_1$',
  '$4 \times \text{Area of } T_2$',
  'In a square of side $s$, $T_1$ is formed by a diagonal; $T_2$ is formed by connecting the midpoints of adjacent sides.',
  'hard', 2, 2, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $3^{x+1} - 3^x = 486$, what is the value of $x$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"7"},{"id":"e","text":"8"}]'::jsonb,
  'b',
  '$3^x(3-1) = 486 \implies 3^x = 243 = 3^5$, so $x = 5$.',
  NULL, NULL, NULL,
  'hard', 2, 2, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A contractor surrounds a circular pool of radius $r$ with a 2-meter stone walkway. If the walkway area is $44\pi$, what is $r$?',
  '[{"id":"a","text":"8"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"14"},{"id":"e","text":"16"}]'::jsonb,
  'b',
  '$\pi(r+2)^2 - \pi r^2 = 44\pi \implies 4r + 4 = 44 \implies r = 10$.',
  NULL, NULL, NULL,
  'hard', 2, 2, 'quantitative', true
);

-- Q8: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Which of the following is equivalent to $\dfrac{-2}{\sqrt{n-1} - \sqrt{n+1}}$?',
  '[{"id":"a","text":"$-1$"},{"id":"b","text":"$1$"},{"id":"c","text":"$2(\\sqrt{n-1} + \\sqrt{n+1})$"},{"id":"d","text":"$\\sqrt{n-1} + \\sqrt{n+1}$"},{"id":"e","text":"$1/n$"}]'::jsonb,
  'd',
  'Multiply numerator and denominator by $\sqrt{n-1} + \sqrt{n+1}$. Denominator $= (n-1)-(n+1) = -2$. So expression $= \sqrt{n-1} + \sqrt{n+1}$.',
  NULL, NULL, NULL,
  'hard', 2, 2, 'quantitative', true
);

-- Q9: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'How many ways are there to arrange 6 people in a row if 2 of them refuse to sit together?',
  '[{"id":"a","text":"120"},{"id":"b","text":"240"},{"id":"c","text":"480"},{"id":"d","text":"720"},{"id":"e","text":"840"}]'::jsonb,
  'c',
  'Total $= 6! = 720$. With the 2 together: $5! \times 2 = 240$. So apart $= 720 - 240 = 480$.',
  NULL, NULL, NULL,
  'hard', 2, 2, 'quantitative', true
);

-- Q10: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'In a collegiate department, 60% play a winter sport and 40% of those also play a spring sport. If 120 play both, what is the total number of athletes?',
  '[{"id":"a","text":"300"},{"id":"b","text":"400"},{"id":"c","text":"500"},{"id":"d","text":"600"},{"id":"e","text":"800"}]'::jsonb,
  'c',
  'Both $= 0.40 \times (0.60T) = 0.24T = 120$, so $T = 120/0.24 = 500$.',
  NULL, NULL, NULL,
  'hard', 2, 2, 'quantitative', true
);

-- Q11: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $k$ is a positive integer, which could be the remainder when $7^k$ is divided by 100? Indicate all such values.',
  '[{"id":"a","text":"07"},{"id":"b","text":"49"},{"id":"c","text":"43"},{"id":"d","text":"01"}]'::jsonb,
  '["a","b","c","d"]',
  'Last two digits of $7^k$ cycle: 07, 49, 43, 01. All four are possible.',
  NULL, NULL, NULL,
  'hard', 2, 2, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Evaluate $\dfrac{8! - 7!}{6!}$.',
  NULL,
  '49',
  '$\dfrac{7!(8-1)}{6!} = 7 \times 7 = 49$.',
  NULL, NULL, NULL,
  'hard', 2, 2, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: GPA distribution (number of students) for 1950 and 2000 — 2.3: 300/100, 2.7: 600/250, 3.0: 900/500, 3.3: 650/800, 3.7: 400/950, 4.0: 150/400. What was the mode for GPA of the 3,000 students in 2000?',
  '[{"id":"a","text":"2.7"},{"id":"b","text":"3.0"},{"id":"c","text":"3.3"},{"id":"d","text":"3.7"},{"id":"e","text":"4.0"}]'::jsonb,
  'd',
  'In 2000 the highest count is 950 at the 3.7 GPA range. Mode = 3.7.',
  NULL, NULL, NULL,
  'hard', 2, 2, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: 3.7 GPA range — 1950: 400 students, 2000: 950 students. The number in 2000 was what percent greater than in 1950?',
  '[{"id":"a","text":"55%"},{"id":"b","text":"137.5%"},{"id":"c","text":"150%"},{"id":"d","text":"237.5%"},{"id":"e","text":"300%"}]'::jsonb,
  'b',
  'Increase $= 950 - 400 = 550$. Percent greater $= (550/400) \times 100 = 137.5\%$.',
  NULL, NULL, NULL,
  'hard', 2, 2, 'quantitative', true
);

-- Q15: Multi-Select (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Data: GPA distributions for 1950 and 2000 (3,000 students each). Which of the following statements must be true? Indicate all such statements.',
  '[{"id":"a","text":"The median GPA in 2000 was higher than the median GPA in 1950."},{"id":"b","text":"In 1950, more than half of the students had a GPA of 3.0 or lower."},{"id":"c","text":"The total number of students with GPA above 3.3 in 2000 was greater than in 1950."}]'::jsonb,
  '["a","b","c"]',
  'A: 2000 distribution is shifted right (true). B: 1950 at 2.3+2.7+3.0 = 1800 > 1500 (true). C: 2000 above 3.3 = 950+400 = 1350; 1950 = 400+150 = 550 (true).',
  NULL, NULL, NULL,
  'hard', 2, 2, 'quantitative', true
);

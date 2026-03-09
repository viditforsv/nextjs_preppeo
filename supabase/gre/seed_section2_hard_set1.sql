-- Seed: Section 2, Set 1 (Hard) - 15 questions
-- Source: Docs for me/gre_mock/section2_hard_set1.tex

-- Q1: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'The outcome of a standardized test is an integer between 151 and 200, inclusive. The percentiles of 400 test scores are calculated, and the scores are divided into corresponding percentile groups.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'There are 50 possible integer scores and 100 percentile groups. The distribution of the 400 students is unknown, so we cannot fix how many groups correspond to any specific score or how many integers contain more than one group.',
  'The minimum number of integers between 151 and 200, inclusive, that include more than one percentile group',
  'The minimum number of percentile groups that correspond to a score of 200',
  'The outcome of a standardized test is an integer between 151 and 200, inclusive. The percentiles of 400 test scores are calculated, and the scores are divided into corresponding percentile groups.',
  'hard', 2, 1, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A square is inscribed in a circle with area $64\pi$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Circle: $\pi r^2 = 64\pi \implies r = 8$, diameter $= 16$. Square diagonal $= 16$, so area of square $= 16^2/2 = 128$. Shaded $= 64\pi - 128 = 64(\pi - 2)$. The two quantities are equal.',
  'The area of the shaded region (inside circle, outside square)',
  '$64(\pi - 2)$',
  'A square is inscribed in a circle with area $64\pi$.',
  'hard', 2, 1, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$n$ is a positive integer such that $4^n$ is a factor of $20!$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  'Legendre: highest power of 2 in $20!$ is 18. So $4^n = 2^{2n} \leq 2^{18} \implies n \leq 9$. Greatest $n$ is 9. Quantity B (10) is greater.',
  'The greatest possible value of $n$',
  '10',
  '$n$ is a positive integer such that $4^n$ is a factor of $20!$.',
  'hard', 2, 1, 'quantitative', true
);

-- Q4: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$a$, $b$, $c$, $d$, $e$ are consecutive odd integers such that $a < b < c < d < e$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'SD depends only on spacing. For five equally spaced values (step 2), variance $= 8$, so $\sigma = \sqrt{8}$. The two quantities are equal.',
  'The standard deviation of $\{a, b, c, d, e\}$',
  '$\sqrt{8}$',
  '$a$, $b$, $c$, $d$, $e$ are consecutive odd integers such that $a < b < c < d < e$.',
  'hard', 2, 1, 'quantitative', true
);

-- Q5: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Five people are to be arranged in a row; 2 of them refuse to sit next to each other.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Total $= 5! = 120$. With the 2 together: $4! \times 2 = 48$. So not together $= 120 - 48 = 72$. The two quantities are equal.',
  'The number of ways to arrange the 5 people so the 2 do not sit next to each other',
  '72',
  'Five people are to be arranged in a row; 2 of them refuse to sit next to each other.',
  'hard', 2, 1, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $xz = 15$, $yz = 25$, and $xy = 15/z$, what is the value of $xyz$ if all variables are positive?',
  '[{"id":"a","text":"25"},{"id":"b","text":"45"},{"id":"c","text":"75"},{"id":"d","text":"125"},{"id":"e","text":"225"}]'::jsonb,
  'c',
  '$(xz)(yz) = 15 \times 25 = 375$, so $xyz \cdot z = 375$. From $xy = 15/z$ we get $xyz = 15z^2/z = 15z$. Solving gives $xyz = 75$.',
  NULL, NULL, NULL,
  'hard', 2, 1, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'What is the units digit of $2^{100} - 3^{11}$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"3"},{"id":"c","text":"7"},{"id":"d","text":"9"},{"id":"e","text":"5"}]'::jsonb,
  'd',
  'Units digit of $2^{100}$: cycle 2,4,8,6; $100 \equiv 0 \pmod{4}$ so 6. Units digit of $3^{11}$: cycle 3,9,7,1; remainder 3 so 7. $6 - 7$ requires borrowing: 16 - 7 = 9.',
  NULL, NULL, NULL,
  'hard', 2, 1, 'quantitative', true
);

-- Q8: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A right triangle has legs of length $x$ and $x-2$. If the area is 24, what is the hypotenuse?',
  '[{"id":"a","text":"8"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"14"},{"id":"e","text":"16"}]'::jsonb,
  'b',
  '$\dfrac{1}{2} x(x-2) = 24 \implies x^2 - 2x - 48 = 0 \implies (x-8)(x+6)=0$, so $x=8$. Legs 8 and 6; hypotenuse $= \sqrt{64+36} = 10$.',
  NULL, NULL, NULL,
  'hard', 2, 1, 'quantitative', true
);

-- Q9: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $f(x) = \dfrac{1}{x^2 + 1}$, what is $f(f(1))$?',
  '[{"id":"a","text":"1/2"},{"id":"b","text":"2/5"},{"id":"c","text":"4/5"},{"id":"d","text":"1"},{"id":"e","text":"5/4"}]'::jsonb,
  'c',
  '$f(1) = 1/(1+1) = 1/2$. $f(1/2) = 1/((1/4)+1) = 1/(5/4) = 4/5$.',
  NULL, NULL, NULL,
  'hard', 2, 1, 'quantitative', true
);

-- Q10: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'How many integers between 100 and 500 are divisible by both 6 and 8?',
  '[{"id":"a","text":"15"},{"id":"b","text":"16"},{"id":"c","text":"17"},{"id":"d","text":"20"},{"id":"e","text":"24"}]'::jsonb,
  'b',
  'LCM(6,8) = 24. First multiple in range: $24 \times 5 = 120$. Last: $24 \times 20 = 480$. Count $= 20 - 5 + 1 = 16$.',
  NULL, NULL, NULL,
  'hard', 2, 1, 'quantitative', true
);

-- Q11: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $k$ is a positive integer, which could be the remainder when $7^k$ is divided by 100? Indicate all such remainders.',
  '[{"id":"a","text":"01"},{"id":"b","text":"07"},{"id":"c","text":"43"},{"id":"d","text":"49"}]'::jsonb,
  '["a","b","c","d"]',
  'Last two digits of $7^k$ cycle: $7^1=07$, $7^2=49$, $7^3=343 \to 43$, $7^4=2401 \to 01$. All four occur.',
  NULL, NULL, NULL,
  'hard', 2, 1, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Evaluate $\dfrac{8! - 7!}{6!}$.',
  NULL,
  '49',
  '$\dfrac{7!(8-1)}{6!} = \dfrac{7 \cdot 6! \cdot 7}{6!} = 49$.',
  NULL, NULL, NULL,
  'hard', 2, 1, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Two normal distributions A and B are shown; A is narrower and taller, B is wider and flatter. Which distribution has a greater standard deviation?',
  '[{"id":"a","text":"A"},{"id":"b","text":"B"},{"id":"c","text":"They are equal"},{"id":"d","text":"Cannot be determined"}]'::jsonb,
  'b',
  'Standard deviation corresponds to the spread of the curve. B is wider and flatter, so B has the greater standard deviation.',
  NULL, NULL, NULL,
  'hard', 2, 1, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Two normal distributions A and B are shown; peak of A is left of peak of B. Which distribution has a greater mean?',
  '[{"id":"a","text":"A"},{"id":"b","text":"B"},{"id":"c","text":"They are equal"},{"id":"d","text":"Cannot be determined"}]'::jsonb,
  'b',
  'The mean is at the peak. Peak B is to the right of peak A, so B has the greater mean.',
  NULL, NULL, NULL,
  'hard', 2, 1, 'quantitative', true
);

-- Q15: Multi-Select (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Data: Two normal distributions A and B. Which statement must be true regarding the area under the curves? Indicate all such statements.',
  '[{"id":"a","text":"The area under curve A is equal to the area under curve B."},{"id":"b","text":"Both areas represent a total probability of 1."},{"id":"c","text":"Curve A represents a higher frequency of scores near its mean than Curve B does near its mean."}]'::jsonb,
  '["a","b","c"]',
  'Any normal PDF has total area 1, so A and B are equal (A, B true). A is taller at its peak, so higher concentration near its mean (C true).',
  NULL, NULL, NULL,
  'hard', 2, 1, 'quantitative', true
);

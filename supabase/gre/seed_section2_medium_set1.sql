-- Seed: Section 2, Set 1 (Medium) - 15 questions
-- Source: Docs for me/gre_mock/section2_medium_set1.tex

-- Q1: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$m$, $n$, $p$, and $q$ are integers such that $m > n$ and $p > q$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Adding the two inequalities: $m + p > n + q$. Quantity A is always greater.',
  '$m + p$',
  '$n + q$',
  '$m$, $n$, $p$, and $q$ are integers such that $m > n$ and $p > q$.',
  'medium', 2, 1, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A dataset of test scores is normally distributed with a mean of 550 and a standard deviation of 40.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  '$Z = (590 - 550)/40 = 1$. In a normal distribution, 1 SD above the mean is the 84th percentile. Quantity A and Quantity B are both 84.',
  'The percentile of a score of 590',
  '84',
  'A dataset of test scores is normally distributed with a mean of 550 and a standard deviation of 40.',
  'medium', 2, 1, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In the triangle above, the dashed line segment $k$ is parallel to the base $B$ and bisects the other two sides.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'By the Triangle Midsegment Theorem, $k = \dfrac{1}{2}B$, so $k/B = 0.5$. The two quantities are equal.',
  'The ratio of $k$ to $B$',
  '0.5',
  'In the triangle above, the dashed line segment $k$ is parallel to the base $B$ and bisects the other two sides.',
  'medium', 2, 1, 'quantitative', true
);

-- Q4: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$x$ is a positive integer such that $4^x$ is a factor of $20!$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Legendre: highest power of 2 in $20!$ is $\lfloor 20/2 \rfloor + \lfloor 20/4 \rfloor + \lfloor 20/8 \rfloor + \lfloor 20/16 \rfloor = 18$. So $4^x = 2^{2x}$ divides $20!$ when $2x \leq 18$, max $x = 9$. Both quantities equal 9.',
  'The greatest possible value for $x$',
  '9',
  '$x$ is a positive integer such that $4^x$ is a factor of $20!$.',
  'medium', 2, 1, 'quantitative', true
);

-- Q5: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$rs = \sqrt{3}$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Quantity A: $\dfrac{\sqrt{3}}{3} \approx 0.577$. Quantity B: $\dfrac{2}{3\sqrt{2}} \approx 0.471$. Quantity A is greater.',
  '$\dfrac{rs}{3}$',
  '$\dfrac{2}{3\sqrt{2}}$',
  '$rs = \sqrt{3}$.',
  'medium', 2, 1, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A jewelry store sells silver rings for $80 and gold rings for $240. If the average price of 50 rings sold was $144, how many gold rings were sold?',
  '[{"id":"a","text":"15"},{"id":"b","text":"20"},{"id":"c","text":"25"},{"id":"d","text":"30"},{"id":"e","text":"35"}]'::jsonb,
  'b',
  'Let $g$ = gold rings. $240g + 80(50-g) = 50 \times 144 = 7200$. So $160g + 4000 = 7200$, $g = 20$.',
  NULL, NULL, NULL,
  'medium', 2, 1, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'What is the greatest prime factor of $3^{20} - 3^{18}$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"5"},{"id":"d","text":"7"},{"id":"e","text":"11"}]'::jsonb,
  'b',
  '$3^{20} - 3^{18} = 3^{18}(9 - 1) = 3^{18} \times 8 = 3^{18} \times 2^3$. Prime factors are 2 and 3; greatest is 3.',
  NULL, NULL, NULL,
  'medium', 2, 1, 'quantitative', true
);

-- Q8: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A parabola opens downward and has its vertex at $(0, 1)$. Which of the following is the equation of this parabola?',
  '[{"id":"a","text":"$y = x^2 + 1$"},{"id":"b","text":"$y = -x^2 + 1$"},{"id":"c","text":"$y = -x^2 - 1$"},{"id":"d","text":"$y = -(x-1)^2$"},{"id":"e","text":"$y = x^2 - 1$"}]'::jsonb,
  'b',
  'Downward opening implies negative $x^2$ coefficient. Vertex at $(0,1)$ gives $y = -x^2 + 1$.',
  NULL, NULL, NULL,
  'medium', 2, 1, 'quantitative', true
);

-- Q9: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'If $g$ is an integer and $x$ is a prime number, which of the following must be an integer?',
  '[{"id":"a","text":"$\\dfrac{g^2x + 7gx}{x}$"},{"id":"b","text":"$g^2 - \\dfrac{x}{3}$"},{"id":"c","text":"$\\dfrac{x}{g}$"},{"id":"d","text":"$\\dfrac{g}{x}$"},{"id":"e","text":"$\\sqrt{gx}$"}]'::jsonb,
  'a',
  'Option A: $\dfrac{x(g^2 + 7g)}{x} = g^2 + 7g$, which is an integer when $g$ is an integer.',
  NULL, NULL, NULL,
  'medium', 2, 1, 'quantitative', true
);

-- Q10: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A cylindrical tank has a diameter of 6 meters and a height of 10 meters. If it is 60% full, what is the volume of water in cubic meters?',
  '[{"id":"a","text":"$36\\pi$"},{"id":"b","text":"$54\\pi$"},{"id":"c","text":"$60\\pi$"},{"id":"d","text":"$90\\pi$"},{"id":"e","text":"$120\\pi$"}]'::jsonb,
  'b',
  'Radius $r = 3$. Full volume $= \pi r^2 h = 90\pi$. 60% of that $= 0.6 \times 90\pi = 54\pi$.',
  NULL, NULL, NULL,
  'medium', 2, 1, 'quantitative', true
);

-- Q11: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $a$, $b$, and $c$ are consecutive integers such that $a < b < c$, which of the following must be even? Indicate all such expressions.',
  '[{"id":"a","text":"$abc$"},{"id":"b","text":"$a + b + c$"},{"id":"c","text":"$(a+b)(b+c)$"}]'::jsonb,
  '["a"]',
  'Among any three consecutive integers, at least one is even, so $abc$ is even. Sum can be odd (e.g. 1+2+3=6, 2+3+4=9). $(a+b)(b+c)$ can be odd (e.g. 1,2,3 gives 3×5=15). Only A must be even.',
  NULL, NULL, NULL,
  'medium', 2, 1, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'What is the units digit of $2^{43} + 3^{43}$?',
  NULL,
  '5',
  'Units digit of $2^{43}$: cycle 2,4,8,6; $43 \equiv 3 \pmod{4}$ so 8. Units digit of $3^{43}$: cycle 3,9,7,1; remainder 3 so 7. $8 + 7 = 15$, units digit 5.',
  NULL, NULL, NULL,
  'medium', 2, 1, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Annual profit ($ millions) — 2021: 20, 2022: 35, 2023: 50, 2024: 45. What was the average annual profit over the four-year period?',
  '[{"id":"a","text":"$35.0M"},{"id":"b","text":"$37.5M"},{"id":"c","text":"$40.0M"},{"id":"d","text":"$42.5M"},{"id":"e","text":"$45.0M"}]'::jsonb,
  'b',
  'Sum $= 20 + 35 + 50 + 45 = 150$. Average $= 150/4 = 37.5$.',
  NULL, NULL, NULL,
  'medium', 2, 1, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Annual profit ($ millions) — 2021: 20, 2022: 35, 2023: 50, 2024: 45. What was the percentage increase in profit from 2021 to 2023?',
  '[{"id":"a","text":"50 percent"},{"id":"b","text":"75 percent"},{"id":"c","text":"100 percent"},{"id":"d","text":"150 percent"},{"id":"e","text":"250 percent"}]'::jsonb,
  'd',
  'Increase $= 50 - 20 = 30$. Percent increase $= (30/20) \times 100 = 150\%$.',
  NULL, NULL, NULL,
  'medium', 2, 1, 'quantitative', true
);

-- Q15: Multi-Select (Data Interpretation)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Data: Annual profit ($ millions) — 2021: 20, 2022: 35, 2023: 50, 2024: 45. Based on the data, which of the following statements are true? Indicate all such statements.',
  '[{"id":"a","text":"The median profit was 40.0M."},{"id":"b","text":"Profit increased in every year shown."},{"id":"c","text":"The total profit for the first two years was less than the profit in 2023."}]'::jsonb,
  '["a"]',
  'Ordered: 20, 35, 45, 50. Median $= (35+45)/2 = 40$ (A true). Profit decreased from 2023 to 2024 (B false). First two years sum $= 55$, which is not less than 50 (C false).',
  NULL, NULL, NULL,
  'medium', 2, 1, 'quantitative', true
);

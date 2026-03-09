-- Seed: Section 1, Set 1 (Medium) - 12 questions
-- Source: Docs for me/gre_mock/section1_set1.tex

-- Q1: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$rs = \sqrt{3}$',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  'Simplify Quantity A: $\dfrac{2r\sqrt{12}}{r^2 s \sqrt{72}} = \dfrac{4r\sqrt{3}}{6r^2s\sqrt{2}} = \dfrac{2\sqrt{3}}{3rs\sqrt{2}}$. Substituting $rs = \sqrt{3}$: $\dfrac{2}{3\sqrt{2}} = \dfrac{\sqrt{2}}{3} \approx 0.471$. Simplify Quantity B: $\dfrac{14rs^2}{42s} = \dfrac{rs}{3} = \dfrac{\sqrt{3}}{3} \approx 0.577$. Since $0.577 > 0.471$, Quantity B is greater.',
  '$\dfrac{2r\sqrt{12}}{r^2 s \sqrt{72}}$',
  '$\dfrac{14rs^2}{42s}$',
  '$rs = \sqrt{3}$',
  'medium', 1, 1, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'The sequence $a_1, a_2, \dots, a_n$ is defined by $a_n = 2^n - \dfrac{1}{2^{n-33}}$ for each integer $n \geq 1$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  '$S_{32} = S_{31} + a_{32}$. We find $a_{32} = 2^{32} - \dfrac{1}{2^{-1}} = 2^{32} - 2$. Since $2^{32}$ is very large, $a_{32} > 0$, so $S_{32} > S_{31}$. Quantity A is greater.',
  'The sum of the first 32 terms',
  'The sum of the first 31 terms',
  'The sequence $a_1, a_2, \dots, a_n$ is defined by $a_n = 2^n - \dfrac{1}{2^{n-33}}$ for each integer $n \geq 1$.',
  'medium', 1, 1, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$rs = \sqrt{2}$ and $st = \sqrt{3}$',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Dividing the two equations: $\dfrac{rs}{st} = \dfrac{\sqrt{2}}{\sqrt{3}}$, so $\dfrac{r}{t} = \dfrac{\sqrt{2}}{\sqrt{3}}$. Rationalizing: $\dfrac{\sqrt{2}}{\sqrt{3}} \times \dfrac{\sqrt{3}}{\sqrt{3}} = \dfrac{\sqrt{6}}{3}$. The two quantities are equal.',
  '$\dfrac{r}{t}$',
  '$\dfrac{\sqrt{6}}{3}$',
  '$rs = \sqrt{2}$ and $st = \sqrt{3}$',
  'medium', 1, 1, 'quantitative', true
);

-- Q4: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$k$ is a positive integer.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'Using Legendre''s Formula, the highest power of 3 in $10!$ is $\lfloor 10/3 \rfloor + \lfloor 10/9 \rfloor = 4$. The highest power of 5 in $10!$ is $\lfloor 10/5 \rfloor = 2$. If $k=1$, both remainders are 0 (equal). If $k=3$, remainder for $3^3$ is 0 but remainder for $5^3$ is $> 0$. The relationship cannot be determined.',
  'The remainder when $10!$ is divided by $3^k$',
  'The remainder when $10!$ is divided by $5^k$',
  '$k$ is a positive integer.',
  'medium', 1, 1, 'quantitative', true
);

-- Q5: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'The price of a phone call consists of a standard connection fee plus a per-minute charge. A 10-minute call costs \$2.90 and a 16-minute call costs \$4.40. How much does a 13-minute call cost?',
  '[{"id":"a","text":"\\$3.45"},{"id":"b","text":"\\$3.65"},{"id":"c","text":"\\$3.75"},{"id":"d","text":"\\$3.80"},{"id":"e","text":"\\$3.90"}]'::jsonb,
  'b',
  'Let $C$ be the connection fee and $R$ the rate per minute. $C + 10R = 2.90$ and $C + 16R = 4.40$. Subtracting: $6R = 1.50$, so $R = 0.25$. Then $C = 0.40$. For 13 minutes: $0.40 + 13(0.25) = 3.65$.',
  NULL, NULL, NULL,
  'medium', 1, 1, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A baker made 60 pies in the first 5 hours of his workday. By how many pies per hour did he increase his rate in the last 3 hours of the workday in order to complete 150 pies in the entire 8-hour period?',
  '[{"id":"a","text":"10"},{"id":"b","text":"12"},{"id":"c","text":"18"},{"id":"d","text":"20"},{"id":"e","text":"30"}]'::jsonb,
  'c',
  'Initial rate $= 60/5 = 12$ pies/hr. Remaining pies $= 150 - 60 = 90$. New rate $= 90/3 = 30$ pies/hr. Increase $= 30 - 12 = 18$.',
  NULL, NULL, NULL,
  'medium', 1, 1, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'In a class of 25 students, 9 study Spanish, 7 study Latin, and 5 study exactly two languages. If no students study all three languages, how many students study only French?',
  '[{"id":"a","text":"9"},{"id":"b","text":"10"},{"id":"c","text":"11"},{"id":"d","text":"12"},{"id":"e","text":"14"}]'::jsonb,
  'e',
  'Total students $= x_1 + x_2$ where $x_1$ is students in exactly one language and $x_2 = 5$. So $x_1 = 20$. Sum of sets: $S + L + F = x_1 + 2x_2 = 30$. So $9 + 7 + F = 30$, giving $F = 14$.',
  NULL, NULL, NULL,
  'medium', 1, 1, 'quantitative', true
);

-- Q8: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $g(x) = \dfrac{x^2 (4x+9)}{(3x-3)(x+2)}$, for which of the following values is $g(x)$ undefined? Indicate all such values.',
  '[{"id":"a","text":"$-9/4$"},{"id":"b","text":"$-2$"},{"id":"c","text":"$0$"},{"id":"d","text":"$1$"},{"id":"e","text":"$2$"}]'::jsonb,
  '["b","d"]',
  'The function is undefined when the denominator equals zero. $(3x - 3)(x + 2) = 0$ gives $x = 1$ and $x = -2$.',
  NULL, NULL, NULL,
  'medium', 1, 1, 'quantitative', true
);

-- Q9: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Which of the following points in the coordinate plane does not lie on the curve $y = x^2 - 3$? Indicate all such points.',
  '[{"id":"a","text":"$(3, 6)$"},{"id":"b","text":"$(-3, 6)$"},{"id":"c","text":"$(0, -3)$"},{"id":"d","text":"$(-3, 0)$"},{"id":"e","text":"$(0.5, -2.75)$"}]'::jsonb,
  '["d"]',
  'Test each point: A: $3^2 - 3 = 6$ (on curve). B: $(-3)^2 - 3 = 6$ (on curve). C: $0^2 - 3 = -3$ (on curve). D: $(-3)^2 - 3 = 6 \neq 0$ (NOT on curve). E: $0.5^2 - 3 = -2.75$ (on curve). Only D fails.',
  NULL, NULL, NULL,
  'medium', 1, 1, 'quantitative', true
);

-- Q10: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $a = (x+y)^2$, $b = x^2 + y^2$, and $xy > 0$, which of the following must be true? Indicate all such statements.',
  '[{"id":"a","text":"$a > b$"},{"id":"b","text":"$a - b = 2xy$"},{"id":"c","text":"$\\dfrac{a}{b} > 1$"}]'::jsonb,
  '["a","b","c"]',
  'Expand: $a = x^2 + 2xy + y^2$. So $a - b = 2xy$ (B is true). Since $xy > 0$, $2xy > 0$, so $a > b$ (A is true). Since $a > b > 0$, $a/b > 1$ (C is true). All three are true.',
  NULL, NULL, NULL,
  'medium', 1, 1, 'quantitative', true
);

-- Q11: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'What is the area of a triangle with vertices $(-2, 4)$, $(2, 4)$, and $(-6, 6)$ in the coordinate plane?',
  NULL,
  '4',
  'The vertices $(-2, 4)$ and $(2, 4)$ share $y=4$, so the base $= 2 - (-2) = 4$. The height is the vertical distance from $(-6, 6)$ to the line $y=4$: height $= 6 - 4 = 2$. Area $= \dfrac{1}{2} \times 4 \times 2 = 4$.',
  NULL, NULL, NULL,
  'medium', 1, 1, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'What is the value of $\sqrt{2 + \sqrt{2 + \sqrt{2 + \sqrt{4}}}}$?',
  NULL,
  '2',
  'Solve from the innermost root outward: $\sqrt{4} = 2$, then $\sqrt{2 + 2} = \sqrt{4} = 2$, then $\sqrt{2 + 2} = 2$, then $\sqrt{2 + 2} = 2$.',
  NULL, NULL, NULL,
  'medium', 1, 1, 'quantitative', true
);

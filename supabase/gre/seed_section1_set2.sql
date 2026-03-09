-- Seed: Section 1, Set 2 (Medium) - 12 questions
-- Source: Docs for me/gre_mock/section1_set2.tex

-- Q1: Quantitative Comparison (geometry - two right triangles)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Two right triangles share a vertex. The left triangle has legs 12 and $b_1$, and hypotenuse 13. The total base of both triangles is 12.2. $k$ is the hypotenuse of the second right triangle.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Left triangle: $b_1 = \sqrt{13^2 - 12^2} = 5$. Second triangle base $= 12.2 - 5 = 7.2$. Height of second triangle $= 3$ (from similar triangle ratio). Hypotenuse $k = \sqrt{7.2^2 + 3^2} = \sqrt{60.84} = 7.8$. Since $7.8 > 7.5$, Quantity A is greater.',
  '$k$',
  '$7.5$',
  'Two right triangles share a vertex. The left triangle has legs 12 and $b_1$, and hypotenuse 13. The total base is 12.2.',
  'medium', 1, 2, 'quantitative', true
);

-- Q2: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'For a certain quantity of a gas, $PV = kT$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'For Quantity A: $P = \dfrac{k(32)}{20} = 1.6k$. For Quantity B: $T = \dfrac{(78)(10)}{k} = \dfrac{780}{k}$. Without knowing $k$, we cannot determine which is larger.',
  'The value of $P$ if $V = 20$ and $T = 32$',
  'The value of $T$ if $V = 10$ and $P = 78$',
  'For a certain quantity of a gas, $PV = kT$.',
  'medium', 1, 2, 'quantitative', true
);

-- Q3: Quantitative Comparison
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$k$ is a positive integer.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'Highest power of 3 in $10!$: $\lfloor 10/3 \rfloor + \lfloor 10/9 \rfloor = 4$. Highest power of 5 in $10!$: $\lfloor 10/5 \rfloor = 2$. If $k = 1$, both remainders are 0. If $k = 3$, Quantity A is 0 and Quantity B is $> 0$. Cannot be determined.',
  'The remainder when $10!$ is divided by $3^k$',
  'The remainder when $10!$ is divided by $5^k$',
  '$k$ is a positive integer.',
  'medium', 1, 2, 'quantitative', true
);

-- Q4: Quantitative Comparison (triangle angles)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In a triangle, $x + z = 110$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'The sum of interior angles of a triangle is $180$. $x + y + z = 180$, so $110 + y = 180$, giving $y = 70$. Both quantities equal 70.',
  '$y$',
  '$70$',
  'In a triangle with angles $x$, $y$, and $z$ degrees, $x + z = 110$.',
  'medium', 1, 2, 'quantitative', true
);

-- Q5: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'On a certain train, tickets cost $6 each for children and $9 each for adults. The total cost for a certain group of six passengers was between $44 and $50. How many children were in the group?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"},{"id":"e","text":"5"}]'::jsonb,
  'b',
  'Let $c$ = children, $a = 6 - c$ adults. Total $= 6c + 9(6-c) = 54 - 3c$. Inequality: $44 < 54 - 3c < 50$ gives $1.33 < c < 3.33$. Testing $c=2$: $T = 48$. Answer is 2.',
  NULL, NULL, NULL,
  'medium', 1, 2, 'quantitative', true
);

-- Q6: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'After a 15% discount, the price of a computer was \$612. What was the price before the discount?',
  '[{"id":"a","text":"\\$108.00"},{"id":"b","text":"\\$520.20"},{"id":"c","text":"\\$703.80"},{"id":"d","text":"\\$720.00"},{"id":"e","text":"\\$744.00"}]'::jsonb,
  'd',
  'Let $P$ be the original price. $0.85P = 612$, so $P = 612 / 0.85 = 720$.',
  NULL, NULL, NULL,
  'medium', 1, 2, 'quantitative', true
);

-- Q7: Single Choice
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Two trees have a combined height of 60 feet, and the taller tree is $x$ times the height of the shorter tree. How tall is the shorter tree?',
  '[{"id":"a","text":"$\\dfrac{60}{1 + x}$"},{"id":"b","text":"$\\dfrac{60}{x}$"},{"id":"c","text":"$60 - x$"},{"id":"d","text":"$\\dfrac{60x}{1 + x}$"},{"id":"e","text":"$60 - \\dfrac{x}{2}$"}]'::jsonb,
  'a',
  'Let $s$ be the shorter tree height. Taller tree $= xs$. So $s + xs = 60$, giving $s(1+x) = 60$, thus $s = \dfrac{60}{1+x}$.',
  NULL, NULL, NULL,
  'medium', 1, 2, 'quantitative', true
);

-- Q8: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $a, b,$ and $c$ are positive even integers such that $8 > a > b > c$, which of the following must be true? Indicate all such statements.',
  '[{"id":"a","text":"The range of {a, b, c} is 4."},{"id":"b","text":"The average of {a, b, c} is 4."},{"id":"c","text":"$a + b + c = 12$."}]'::jsonb,
  '["a","b","c"]',
  'Positive even integers less than 8 are {2, 4, 6}. Since $a > b > c$: $a=6, b=4, c=2$. Range $= 6-2 = 4$ (A true). Average $= 12/3 = 4$ (B true). Sum $= 12$ (C true).',
  NULL, NULL, NULL,
  'medium', 1, 2, 'quantitative', true
);

-- Q9: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'A dataset contains at least two different integers. Which could be true regarding the range and IQR? Indicate all such statements.',
  '[{"id":"a","text":"Range > IQR"},{"id":"b","text":"Range = IQR"},{"id":"c","text":"Range < IQR"}]'::jsonb,
  '["a","b"]',
  'Range is min to max. IQR is $Q_1$ to $Q_3$. Since $\min \leq Q_1$ and $\max \geq Q_3$, Range $\geq$ IQR. A and B are possible. C is impossible.',
  NULL, NULL, NULL,
  'medium', 1, 2, 'quantitative', true
);

-- Q10: Multi-Select
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $xy > 0$, which must be true? Indicate all such statements.',
  '[{"id":"a","text":"$(x + y)^2 > x^2 + y^2$"},{"id":"b","text":"$(x + y)^2 - (x^2 + y^2) = 2xy$"},{"id":"c","text":"$\\dfrac{(x + y)^2}{x^2 + y^2} > 1$"}]'::jsonb,
  '["a","b","c"]',
  'Expand $(x+y)^2 = x^2 + 2xy + y^2$. B: difference is $2xy$ (true). A: since $xy > 0$, $2xy > 0$, so $(x+y)^2 > x^2+y^2$ (true). C: since numerator > denominator > 0, ratio > 1 (true).',
  NULL, NULL, NULL,
  'medium', 1, 2, 'quantitative', true
);

-- Q11: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'What is the area of a triangle with vertices $(-2, 4)$, $(2, 4)$, and $(-6, 6)$?',
  NULL,
  '4',
  'Base connects $(-2,4)$ and $(2,4)$, length $= 4$. Height is vertical distance from $y=6$ to $y=4$, height $= 2$. Area $= 0.5 \times 4 \times 2 = 4$.',
  NULL, NULL, NULL,
  'medium', 1, 2, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'If $f(x) = x^2 - 10$, find $f(5) - f(3)$.',
  NULL,
  '16',
  '$f(5) = 25 - 10 = 15$. $f(3) = 9 - 10 = -1$. $f(5) - f(3) = 15 - (-1) = 16$.',
  NULL, NULL, NULL,
  'medium', 1, 2, 'quantitative', true
);

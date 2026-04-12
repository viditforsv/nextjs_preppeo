-- Seed: Section 2, Hard, Set 5 - 15 questions
-- Source: Docs for me/latex_with_rijay/gre_quant_mock/section2_hard_set5.tex

-- Q1: Quantitative Comparison (Parallel Lines & Triangles)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Line segments $AC$ and $BD$ are parallel. Points $W$ and $Z$ lie on line $AC$. Points $X$ and $Y$ lie on line $BD$. Point $X$ lies between $W$ and $Z$ vertically.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'd',
  'Without knowing the exact positions of the points, the base lengths of the two triangles cannot be determined. Since $WY$ and $WZ$ may differ, the relationship cannot be determined.',
  'The area of triangle $WYX$',
  'The area of triangle $WZX$',
  'Parallel line segments $AC$ and $BD$, with points $W$, $Z$ on $AC$ and $X$, $Y$ on $BD$.',
  'hard', 2, 5, 'quantitative', true
);

-- Q2: Quantitative Comparison (Right Triangle in Circle)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'A right triangle is inscribed in a circle with an area of $16\pi$ cm$^2$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'An inscribed right triangle has its hypotenuse as the diameter. $\pi r^2 = 16\pi \Rightarrow r = 4$. Diameter $= 8$. Equal.',
  'The length of the hypotenuse of the triangle',
  '8',
  'A right triangle is inscribed in a circle with area $16\\pi$ cm$^2$.',
  'hard', 2, 5, 'quantitative', true
);

-- Q3: Quantitative Comparison (Independent Probability)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'Events $A$ and $B$ are independent. $P(A) = 0.6$, $P(B) = 0.8$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  '$P(\text{not } A) = 0.4$, $P(\text{not } B) = 0.2$. P(neither) $= 0.4 \times 0.2 = 0.08$. Equal.',
  'The probability that neither event occurs',
  '0.08',
  'Events $A$ and $B$ are independent. $P(A) = 0.6$, $P(B) = 0.8$.',
  'hard', 2, 5, 'quantitative', true
);

-- Q4: Quantitative Comparison (Parabola)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'The equation of a parabola is $y = (x - h)^2 + k$. The point $(-3, n)$ lies on it, and the vertex is at $(2, 0)$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'Equation: $y = (x - 2)^2$. At $x = -3$: $n = (-3 - 2)^2 = (-5)^2 = 25$. Equal.',
  '$n$',
  '25',
  'Parabola $y = (x - h)^2 + k$, vertex at $(2, 0)$, point $(-3, n)$ lies on it.',
  'hard', 2, 5, 'quantitative', true
);

-- Q5: Quantitative Comparison (Exponents - Factorization)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$x$ and $y$ are positive integers such that $x^2 \cdot 5^y = 10{,}125$.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'b',
  '$10125 = 5^3 \times 3^4 = 5^3 \times 81 = 5^3 \times 9^2$. So $x^2 = 81$ ($x = 9$) and $5^y = 125$ ($y = 3$). Since $81 < 125$, Quantity B is greater.',
  '$x^2$',
  '$5^y$',
  '$x$ and $y$ are positive integers, $x^2 \\cdot 5^y = 10{,}125$.',
  'hard', 2, 5, 'quantitative', true
);

-- Q6: Single Choice (Combinatorics - Restrictions)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Five students (Adnan, Beth, Chao, Dan, Edmund) are arranged in a line. How many arrangements are possible if Beth is not allowed to stand next to Dan?',
  '[{"id":"a","text":"24"},{"id":"b","text":"48"},{"id":"c","text":"72"},{"id":"d","text":"96"},{"id":"e","text":"120"}]'::jsonb,
  'c',
  'Total: $5! = 120$. Beth and Dan together: treat as block, $4! \times 2 = 48$. Not together: $120 - 48 = 72$.',
  NULL, NULL, NULL,
  'hard', 2, 5, 'quantitative', true
);

-- Q7: Single Choice (3D Geometry - Cylinder SA Ratio)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A solid cylinder has height 9 and radius 2. It is cut into three new cylinders of equal height. What is the ratio of the total surface area of the three new cylinders to the original?',
  '[{"id":"a","text":"1:1"},{"id":"b","text":"3:2"},{"id":"c","text":"13:11"},{"id":"d","text":"15:11"}]'::jsonb,
  'd',
  'Original SA: $2\pi(4) + 2\pi(2)(9) = 8\pi + 36\pi = 44\pi$. Each new: $2\pi(4) + 2\pi(2)(3) = 8\pi + 12\pi = 20\pi$. Total: $60\pi$. Ratio: $60/44 = 15/11$.',
  NULL, NULL, NULL,
  'hard', 2, 5, 'quantitative', true
);

-- Q8: Single Choice (Profit Inequality)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A batch of widgets costs $p + 15$ dollars to produce and sells for $p(9 - p)$ dollars. For which value of $p$ does the company make a profit?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"6"}]'::jsonb,
  'b',
  'Profit: $p(9-p) > p + 15 \Rightarrow -p^2 + 9p > p + 15 \Rightarrow p^2 - 8p + 15 < 0 \Rightarrow (p-3)(p-5) < 0$. This holds for $3 < p < 5$. Only $p = 4$ works.',
  NULL, NULL, NULL,
  'hard', 2, 5, 'quantitative', true
);

-- Q9: Multi-Select (Parabola Y-intercept Properties)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $x$ is the $y$-intercept of the parabola $y = -(x - 1)^2 + 4$, which of the following is true? Indicate all such statements.',
  '[{"id":"a","text":"$x$ is prime"},{"id":"b","text":"$x$ is odd"},{"id":"c","text":"$x > 0$"}]'::jsonb,
  '["a","b","c"]',
  'Set $x = 0$: $y = -(0-1)^2 + 4 = -1 + 4 = 3$. The $y$-intercept is 3. 3 is prime, odd, and positive. All true.',
  NULL, NULL, NULL,
  'hard', 2, 5, 'quantitative', true
);

-- Q10: Multi-Select (Number Theory - Terminating Decimal)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $3^x(5^2)$ is divided by $3^5(5^3)$, the quotient terminates with one decimal digit. If $x > 0$, which of the following must be true? Indicate all such statements.',
  '[{"id":"a","text":"$x = 5$"},{"id":"b","text":"$x \\geq 5$"},{"id":"c","text":"$x$ is even"}]'::jsonb,
  '["a","b"]',
  'Quotient: $3^{x-5}/5$. For termination with one decimal digit, $3^{x-5}$ must be 1, so $x = 5$. Since $x = 5$ also satisfies $x \geq 5$, both A and B are true.',
  NULL, NULL, NULL,
  'hard', 2, 5, 'quantitative', true
);

-- Q11: Numeric Entry (Rate/Distance)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Car A travels at 8 mph faster than Car B. They meet at a combined distance of 62 miles after Car B has driven for 15 minutes. Car A started 30 minutes before Car B. How many miles had Car B driven?',
  NULL,
  '14',
  'Let Car B speed $= r$, Car A $= r + 8$. B drove 0.25 hrs, A drove 0.75 hrs. $0.75(r+8) + 0.25r = 62 \Rightarrow r + 6 = 62 \Rightarrow r = 56$. B distance $= 56 \times 0.25 = 14$.',
  NULL, NULL, NULL,
  'hard', 2, 5, 'quantitative', true
);

-- Q12: Numeric Entry (Rectangle Dimensions)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'If the width of a rectangle $w$ is twice the length, and the area is 72, what is $w$?',
  NULL,
  '12',
  'Let length $= L$, width $= w = 2L$. Area: $w \cdot L = 2L^2 = 72 \Rightarrow L^2 = 36 \Rightarrow L = 6$. So $w = 12$.',
  NULL, NULL, NULL,
  'hard', 2, 5, 'quantitative', true
);

-- Q13: Single Choice (Data Interpretation - GPA Mode)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: Comparison of 3,000 students (1950 vs 2000). Student counts by GPA in 2000: 4.0 (550), 3.7 (620), 3.3 (450), 3.0 (350), 2.7 (300), 2.3 (150), 2.0 (80). What was the mode for GPA of the 3,000 students in 2000?',
  '[{"id":"a","text":"4.0"},{"id":"b","text":"3.7"},{"id":"c","text":"3.3"},{"id":"d","text":"3.0"}]'::jsonb,
  'b',
  'The mode is the GPA with the highest frequency. In 2000, 3.7 has the highest count (620).',
  NULL, NULL, NULL,
  'hard', 2, 5, 'quantitative', true
);

-- Q14: Single Choice (Data Interpretation - Percentage)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'Data: 3,000 students in 2000 by GPA: 4.0 (550), 3.7 (620), 3.3 (450), 3.0 (350), 2.7 (300), 2.3 (150), 2.0 (80). Approximately what percent of students in 2000 earned at least a 3.0 GPA?',
  '[{"id":"a","text":"50%"},{"id":"b","text":"67%"},{"id":"c","text":"80%"},{"id":"d","text":"95%"}]'::jsonb,
  'b',
  'Students with GPA $\geq 3.0$: $550 + 620 + 450 + 350 = 1970$. Percent: $1970/3000 \approx 65.7\% \approx 67\%$.',
  NULL, NULL, NULL,
  'hard', 2, 5, 'quantitative', true
);

-- Q15: Numeric Entry (Data Interpretation - 1950 Low GPA)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'Data: 3,000 students in 1950 by GPA: 4.0 (410), 3.7 (300), 3.3 (320), 3.0 (480), 2.7 (420), 2.3 (450), 2.0 (500). In 1950, what was the total number of students who earned a GPA of 2.7 or lower?',
  NULL,
  '1370',
  'Students with GPA $\leq 2.7$ in 1950: $420 + 450 + 500 = 1370$.',
  NULL, NULL, NULL,
  'hard', 2, 5, 'quantitative', true
);

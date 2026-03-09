-- Seed: Section 1, Set 3 (Medium) - 12 questions
-- Source: Docs for me/gre_mock/section1_set3.tex

-- Q1: Quantitative Comparison (circle geometry)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  'In a circle with center $O$, $AC$ is a diameter. The circumference of the circle is $18\pi\sqrt{3}$. Angle $ACB = 30$ degrees.',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'c',
  'From $C = 2\pi r$: $18\pi\sqrt{3} = 2\pi r$, so $r = 9\sqrt{3}$. Diameter $AC = 18\sqrt{3}$. By Thales'' Theorem, angle $ABC = 90$ degrees. In a 30-60-90 triangle, side opposite 30 degrees is half the hypotenuse: $AB = \dfrac{1}{2} \times 18\sqrt{3} = 9\sqrt{3}$. The two quantities are equal.',
  'The length of segment $AB$',
  '$9\sqrt{3}$',
  'In a circle with center $O$, $AC$ is a diameter. The circumference is $18\pi\sqrt{3}$. Angle $ACB = 30$ degrees.',
  'medium', 1, 3, 'quantitative', true
);

-- Q2: Quantitative Comparison (trailing zeros)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$m = 2^{16} \cdot 3^{17} \cdot 4^{18} \cdot 5^{19}$ and $n = 2^{19} \cdot 3^{18} \cdot 4^{17} \cdot 5^{16}$',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Trailing zeros $= \min(\text{power of 2}, \text{power of 5})$. For $m$: $2^{16} \cdot 2^{36} \cdot 5^{19} = 2^{52} \cdot 5^{19}$, so 19 zeros. For $n$: $2^{19} \cdot 2^{34} \cdot 5^{16} = 2^{53} \cdot 5^{16}$, so 16 zeros. 19 > 16.',
  'The number of trailing zeros of $m$',
  'The number of trailing zeros of $n$',
  '$m = 2^{16} \cdot 3^{17} \cdot 4^{18} \cdot 5^{19}$ and $n = 2^{19} \cdot 3^{18} \cdot 4^{17} \cdot 5^{16}$',
  'medium', 1, 3, 'quantitative', true
);

-- Q3: Quantitative Comparison (exponents)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$x < 0$',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  'Quantity A: $((25^x)^{-2})^3 = 25^{-6x} = 5^{-12x}$. Quantity B: $((5^{-3})^2)^{-x} = 5^{6x}$. Since $x < 0$, $-12x > 0$ and $6x < 0$. So $5^{-12x} > 1 > 5^{6x}$. Quantity A is greater.',
  '$((25^x)^{-2})^3$',
  '$((5^{-3})^2)^{-x}$',
  '$x < 0$',
  'medium', 1, 3, 'quantitative', true
);

-- Q4: Quantitative Comparison (algebra)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'quantitative-comparison',
  '$xy > 0$',
  '[{"id":"a","text":"Quantity A is greater"},{"id":"b","text":"Quantity B is greater"},{"id":"c","text":"The two quantities are equal"},{"id":"d","text":"The relationship cannot be determined"}]'::jsonb,
  'a',
  '$(x+y)^2 = x^2 + 2xy + y^2$. Comparing to $x^2 + y^2$: difference is $2xy$. Since $xy > 0$, $2xy > 0$, so $(x+y)^2 > x^2 + y^2$. Quantity A is greater.',
  '$(x + y)^2$',
  '$x^2 + y^2$',
  '$xy > 0$',
  'medium', 1, 3, 'quantitative', true
);

-- Q5: Single Choice (similar triangles)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'In triangle $ABC$, $DE$ is parallel to $AC$. If $AC = 12$, $DE = 8$, and $AD = 2$, what is the length of $AB$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"4"},{"id":"d","text":"5"},{"id":"e","text":"6"}]'::jsonb,
  'e',
  'Since $DE \parallel AC$, triangles $BDE$ and $BAC$ are similar. $\dfrac{DE}{AC} = \dfrac{BD}{BA}$, so $\dfrac{8}{12} = \dfrac{BA - 2}{BA}$. Cross-multiplying: $2BA = 3(BA-2)$, giving $BA = 6$.',
  NULL, NULL, NULL,
  'medium', 1, 3, 'quantitative', true
);

-- Q6: Single Choice (phone call cost)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A standard connection fee is constant, plus a per-minute charge. A 10-minute call costs \$2.90 and a 16-minute call costs \$4.40. How much does a 13-minute call cost?',
  '[{"id":"a","text":"\\$3.45"},{"id":"b","text":"\\$3.65"},{"id":"c","text":"\\$3.75"},{"id":"d","text":"\\$3.80"},{"id":"e","text":"\\$3.90"}]'::jsonb,
  'b',
  'Let $f$ = fee, $r$ = rate. $f + 10r = 2.90$ and $f + 16r = 4.40$. Subtracting: $6r = 1.50$, $r = 0.25$, $f = 0.40$. For 13 min: $0.40 + 13(0.25) = 3.65$.',
  NULL, NULL, NULL,
  'medium', 1, 3, 'quantitative', true
);

-- Q7: Single Choice (paper cutting)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'single-choice',
  'A 200cm by 200cm sheet of paper is cut into 2cm by 10cm rectangles. What is the maximum number of rectangles that can be cut from the sheet?',
  '[{"id":"a","text":"100"},{"id":"b","text":"200"},{"id":"c","text":"1,000"},{"id":"d","text":"2,000"},{"id":"e","text":"4,000"}]'::jsonb,
  'd',
  'Sheet area $= 200 \times 200 = 40,000$ sq cm. Rectangle area $= 2 \times 10 = 20$ sq cm. Number $= 40,000 / 20 = 2,000$.',
  NULL, NULL, NULL,
  'medium', 1, 3, 'quantitative', true
);

-- Q8: Multi-Select (function undefined)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $g(x) = \dfrac{x^2(4x + 9)}{(3x - 3)(x + 2)}$, for which values of $x$ is $g(x)$ undefined? Indicate all such values.',
  '[{"id":"a","text":"$-9/4$"},{"id":"b","text":"$-2$"},{"id":"c","text":"$0$"},{"id":"d","text":"$1$"},{"id":"e","text":"$2$"}]'::jsonb,
  '["b","d"]',
  'Denominator $(3x-3)(x+2) = 0$ when $x = 1$ or $x = -2$.',
  NULL, NULL, NULL,
  'medium', 1, 3, 'quantitative', true
);

-- Q9: Multi-Select (salary distributions) — matches section1_set3.tex Q9
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'Physicists'' salaries cluster around a mean of \$100,000, and biologists'' cluster around a mean of \$70,000. Which statements could be true based on overlapping normal distributions? Indicate all such statements.',
  '[{"id":"a","text":"Some biologists earn more than some physicists."},{"id":"b","text":"Both groups'' salaries are normally distributed."},{"id":"c","text":"The standard deviation of biologists is greater than that of physicists."}]'::jsonb,
  '["a","b","c"]',
  'Statement A: Bell curves for normal distributions have infinite tails; therefore, their distributions overlap, meaning some high-earning biologists can earn more than low-earning physicists. (True) Statement B: The problem explicitly mentions the groups are normally distributed. (True) Statement C: Standard deviation measures spread; one distribution could be wider than the other without changing the mean. (True)',
  NULL, NULL, NULL,
  'medium', 1, 3, 'quantitative', true
);

-- Q10: Multi-Select (remainders cycle)
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'multi-select',
  'If $x$ is a positive integer, which could be the remainder when $73^x$ is divided by 10? Indicate all such remainders.',
  '[{"id":"a","text":"1"},{"id":"b","text":"3"},{"id":"c","text":"7"},{"id":"d","text":"9"}]'::jsonb,
  '["a","b","c","d"]',
  'Units digit of $73^x$ = units digit of $3^x$. Cycle: $3^1=3, 3^2=9, 3^3=27(7), 3^4=81(1)$. All four values {3, 9, 7, 1} are possible.',
  NULL, NULL, NULL,
  'medium', 1, 3, 'quantitative', true
);

-- Q11: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'John bought 5 books for $12 average. He buys a 6th book for $18. What is the new average?',
  NULL,
  '13',
  'Total for 5 books $= 5 \times 12 = 60$. Add 6th book: $60 + 18 = 78$. New average $= 78 / 6 = 13$.',
  NULL, NULL, NULL,
  'medium', 1, 3, 'quantitative', true
);

-- Q12: Numeric Entry
INSERT INTO gre_questions (type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, section_number, set_number, section_type, is_active)
VALUES (
  'numeric-entry',
  'What is the area of a triangle with vertices $(-2, 4)$, $(2, 4)$, and $(-6, 6)$?',
  NULL,
  '4',
  'Base on $y=4$: $|2 - (-2)| = 4$. Height from $y=6$ to $y=4$: $|6-4| = 2$. Area $= \dfrac{1}{2} \times 4 \times 2 = 4$.',
  NULL, NULL, NULL,
  'medium', 1, 3, 'quantitative', true
);

-- LID 027: Questions go into question_bank first; then quiz is created and lic.quiz built from it.
-- Topic: Advanced Math / Evaluating Functions
-- Depends on: 20250306100000_sat_quant_learn_lid027_content.sql
-- Idempotent: ON CONFLICT (human_readable_id) DO NOTHING for question_bank; ON CONFLICT DO NOTHING for quiz_questions.

-- ============================================================
-- STEP 1: Insert questions into question_bank (50 questions from sat_lid_027.tex)
-- ============================================================

INSERT INTO public.question_bank (
  human_readable_id, question_text, options, correct_answer, explanation,
  difficulty, question_type, subject, source, topic, subtopic,
  is_pyq, is_active, grade
) VALUES

('sat_lid_027_1', 'The function $f$ is defined by $f(x) = 3x - 7$. What is the value of $f(5)$?', '[{"value": "8"}, {"value": "15"}, {"value": "22"}, {"value": "25"}]'::jsonb, '8', E'Function notation $f(a)$ means substitute $a$ for $x$. So $f(5) = 3(5) - 7 = 15 - 7 = 8$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_2', 'The function $g$ is defined by $g(x) = ax^2 + 24$. If $g(4) = 8$, what is the value of $g(-4)$?', '[]'::jsonb, '8', E'In $g(x) = ax^2 + 24$, the only $x$-dependence is $x^2$, so $g(4) = g(-4)$. Since $g(4) = 8$, then $g(-4) = 8$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_3', 'For the function $h$ defined by $h(x) = \\frac{x+k}{2}$, $k$ is a constant. If $h(3) = 10$, what is the value of $k$?', '[{"value": "7"}, {"value": "13"}, {"value": "17"}, {"value": "20"}]'::jsonb, '17', E'Substitute: $10 = \\frac{3+k}{2}$. Multiply by 2: $20 = 3 + k$, so $k = 17$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_4', '$f(x) = x^2 - 5x$ and $g(x) = 3x + 2$. What is the value of $f(g(1))$?', '[]'::jsonb, '0', E'Evaluate inner function first: $g(1) = 3(1) + 2 = 5$. Then $f(5) = 5^2 - 5(5) = 25 - 25 = 0$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_5', 'If $f(x) = x^2 + 1$, which of the following represents $f(x+2)$?', '[{"value": "$x^2 + 3$"}, {"value": "$x^2 + 5$"}, {"value": "$x^2 + 4x + 4$"}, {"value": "$x^2 + 4x + 5$"}]'::jsonb, '$x^2 + 4x + 5$', E'Substitute $(x+2)$ for $x$: $f(x+2) = (x+2)^2 + 1 = x^2 + 4x + 4 + 1 = x^2 + 4x + 5$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_6', 'For the function $q(x) = 5x + c$, where $c$ is a constant, if $q(q(1)) = 37$, what is the value of $c$?', '[]'::jsonb, '2', E'$q(1) = 5 + c$. Then $q(5+c) = 5(5+c) + c = 25 + 6c = 37$, so $6c = 12$ and $c = 2$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_7', '$f(x) = \\frac{1}{2}x + 8$. For what value of $x$ does $f(x) = 12$?', '[{"value": "2"}, {"value": "4"}, {"value": "8"}, {"value": "14"}]'::jsonb, '8', E'Set $12 = \\frac{1}{2}x + 8$. Subtract 8: $4 = \\frac{1}{2}x$. Multiply by 2: $x = 8$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_8', '$g(x) = 2x - 1$. If $g(k) = 15$, what is the value of $g(2k)$?', '[]'::jsonb, '31', E'From $15 = 2k - 1$ we get $k = 8$. Then $g(2k) = g(16) = 2(16) - 1 = 31$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_9', 'If $f(x) = x^3 - x$, what is the value of $f(-2)$?', '[{"value": "-10"}, {"value": "-6"}, {"value": "6"}, {"value": "10"}]'::jsonb, '-6', E'$f(-2) = (-2)^3 - (-2) = -8 + 2 = -6$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_10', 'The function $p$ is defined by $p(x) = x^2 - kx + 10$. If $p(3) = 1$, what is the value of $k$?', '[]'::jsonb, '6', E'$1 = 9 - 3k + 10$, so $1 = 19 - 3k$, $-18 = -3k$, $k = 6$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_11', 'If $f(x) = 5x^2$, what is the value of $f(2k)$ in terms of $k$?', '[{"value": "$10k^2$"}, {"value": "$20k^2$"}, {"value": "$25k^2$"}, {"value": "$100k^2$"}]'::jsonb, '$20k^2$', E'$f(2k) = 5(2k)^2 = 5(4k^2) = 20k^2$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_12', '$f(x) = 3x - 5$. If $f(a) + f(b) = 14$, what is the value of $3(a+b)$?', '[]'::jsonb, '24', E'$f(a)+f(b) = (3a-5)+(3b-5) = 3a+3b-10 = 14$, so $3a+3b = 24$, hence $3(a+b)=24$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_13', 'If $g(x) = \\sqrt{x+9}$, for what value of $x$ is $g(x) = 5$?', '[{"value": "4"}, {"value": "16"}, {"value": "25"}, {"value": "34"}]'::jsonb, '16', E'$5 = \\sqrt{x+9}$ implies $25 = x+9$, so $x = 16$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_14', '$f(x) = 2^x + 5$. What is the value of $f(3) - f(1)$?', '[]'::jsonb, '6', E'$f(3) = 8+5 = 13$, $f(1) = 2+5 = 7$. So $f(3)-f(1) = 6$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_15', 'If $f(x) = \\frac{x}{x-1}$, which of the following represents $f(\\frac{1}{x})$ for $x \\neq 0, 1$?', '[{"value": "$\\frac{1}{1-x}$"}, {"value": "$\\frac{x}{1-x}$"}, {"value": "$\\frac{1}{x-1}$"}, {"value": "$x-1$"}]'::jsonb, '$\\frac{1}{1-x}$', E'$f(1/x) = \\frac{1/x}{1/x - 1}$. Multiply numerator and denominator by $x$: $\\frac{1}{1-x}$.', 7, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_16', '$f(x) = ax + b$ where $a$ and $b$ are constants. If $f(1) = 10$ and $f(2) = 13$, what is the value of $f(0)$?', '[]'::jsonb, '7', E'Slope $a = \\frac{13-10}{2-1} = 3$. From $f(1) = 3+b = 10$, $b = 7$. So $f(0) = b = 7$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_17', 'For $g(x) = |x-4| - 2$, what is the value of $g(1)$?', '[{"value": "-5"}, {"value": "-1"}, {"value": "1"}, {"value": "5"}]'::jsonb, '1', E'$g(1) = |1-4| - 2 = |-3| - 2 = 3 - 2 = 1$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_18', 'If $f(x) = \\sqrt{x} + 10$ and $f(k) = 16$, what is the value of $f(k+13)$?', '[]'::jsonb, '17', E'$16 = \\sqrt{k} + 10$ gives $\\sqrt{k} = 6$, so $k = 36$. Then $f(k+13) = f(49) = \\sqrt{49} + 10 = 7 + 10 = 17$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_19', 'A function $f$ satisfies $f(2) = 5$ and $f(3) = 10$. If $f$ is linear, which defines $f(x)$?', '[{"value": "$f(x) = 5x$"}, {"value": "$f(x) = 5x - 5$"}, {"value": "$f(x) = x + 3$"}, {"value": "$f(x) = 2x + 1$"}]'::jsonb, '$f(x) = 5x - 5$', E'Slope $m = \\frac{10-5}{3-2} = 5$. From $5 = 5(2)+b$, $b = -5$. So $f(x) = 5x - 5$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_20', 'The function $h$ is defined by $h(x) = 2x^2 - x$. What is the value of $h(4) - h(3)$?', '[]'::jsonb, '13', E'$h(4) = 32-4 = 28$, $h(3) = 18-3 = 15$. So $h(4)-h(3) = 13$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_21', 'If $f(x-3) = 2x + 1$, what is the value of $f(5)$?', '[{"value": "5"}, {"value": "11"}, {"value": "17"}, {"value": "21"}]'::jsonb, '17', E'We need $x-3 = 5$, so $x = 8$. Then $f(5) = 2(8) + 1 = 17$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_22', 'For $w(x) = x^2 - 1$, what is the value of $w(w(2))$?', '[]'::jsonb, '8', E'$w(2) = 4-1 = 3$. Then $w(3) = 9-1 = 8$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_23', 'If $f(x) = kx + 4$ and $f(2) = f(5) - 6$, what is the value of $k$?', '[{"value": "2"}, {"value": "3"}, {"value": "4"}, {"value": "6"}]'::jsonb, '2', E'$2k+4 = (5k+4)-6$, so $2k+4 = 5k-2$, $6 = 3k$, $k = 2$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_24', '$g(x) = \\frac{12}{x-c}$. If $g(5)$ is undefined, what is the value of $g(c+2)$?', '[]'::jsonb, '6', E'$g(5)$ undefined means $5-c=0$, so $c=5$. Then $g(c+2)=g(7)=\\frac{12}{7-5}=6$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_25', 'If $f(x) = x^2$ and $g(x) = x-3$, which of the following is $f(g(x))$?', '[{"value": "$x^2 - 3$"}, {"value": "$x^2 - 9$"}, {"value": "$x^2 - 6x + 9$"}, {"value": "$x^2 + 9$"}]'::jsonb, '$x^2 - 6x + 9$', E'$f(g(x)) = f(x-3) = (x-3)^2 = x^2 - 6x + 9$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_26', 'The function $f$ is defined by $f(x) = 2x^2 - 3x + c$. If $f(2) = 10$, what is the value of $f(-1)$?', '[]'::jsonb, '13', E'From $10 = 2(4)-6+c$ we get $c=8$. Then $f(-1) = 2(1)+3+8 = 13$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_27', 'If $g(x) = \\frac{3}{x-5} + 2$, what is the value of $g(8)$?', '[{"value": "1"}, {"value": "3"}, {"value": "5"}, {"value": "11"}]'::jsonb, '3', E'$g(8) = \\frac{3}{8-5} + 2 = \\frac{3}{3} + 2 = 1 + 2 = 3$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_28', '$f(x) = 4x - 11$ and $g(x) = x^2 + 5$. If $f(k) = g(3)$, what is the value of $k$?', '[]'::jsonb, '6.25', E'$g(3) = 9+5 = 14$. So $4k - 11 = 14$, $4k = 25$, $k = 6.25$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_29', 'Which describes the value of $f(0)$ for any linear function $f(x) = mx + b$?', '[{"value": "The slope of the function."}, {"value": "The $x$-intercept."}, {"value": "The $y$-intercept of the function."}, {"value": "The maximum value of the function."}]'::jsonb, 'The $y$-intercept of the function.', E'$f(0) = m(0) + b = b$, which is the $y$-intercept.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_30', 'If $f(x) = 3(x-k)^2 + 7$ and $f(5) = 7$, what is the value of $k$?', '[]'::jsonb, '5', E'$7 = 3(5-k)^2 + 7$ gives $0 = 3(5-k)^2$, so $(5-k)^2=0$, hence $k=5$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_31', 'For the function $h$ in the table ($x$: 1,2,3 → $h(x)$: 3,1,2), what is $h(h(2))$?', '[{"value": "1"}, {"value": "2"}, {"value": "3"}, {"value": "4"}]'::jsonb, '3', E'$h(2) = 1$ from the table. Then $h(1) = 3$. So $h(h(2)) = 3$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_32', '$f(x) = x^2 - k$. If $f(f(2)) = 0$ and $k > 0$, what is the value of $k$?', '[]'::jsonb, '2', E'Using the given condition and $k>0$, the value of $k$ that works is $k=2$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_33', 'If $f(x) = 2x^2 - 5$, which represents $f(3a)$?', '[{"value": "$6a^2 - 5$"}, {"value": "$18a^2 - 5$"}, {"value": "$18a - 5$"}, {"value": "$36a^2 - 5$"}]'::jsonb, '$18a^2 - 5$', E'$f(3a) = 2(3a)^2 - 5 = 2(9a^2) - 5 = 18a^2 - 5$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_34', 'The function $g$ is defined by $g(x) = 4$. What is the value of $g(100)$?', '[{"value": "4"}, {"value": "100"}, {"value": "400"}, {"value": "Undefined"}]'::jsonb, '4', E'Constant function: output is always 4 for any input.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_35', 'If $f(x) = \\frac{x+2}{x-2}$, what is the value of $f(f(3))$?', '[]'::jsonb, '7/3', E'$f(3) = \\frac{5}{1} = 5$. Then $f(5) = \\frac{7}{3}$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_36', '$f(x) = 2x + 1$ and $g(x) = x - 3$. Which is an expression for $f(x) + g(x)$?', '[{"value": "$2x - 2$"}, {"value": "$3x - 2$"}, {"value": "$3x + 4$"}, {"value": "$x + 4$"}]'::jsonb, '$3x - 2$', E'$(2x+1)+(x-3) = 3x - 2$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_37', 'If $f(x) = x^2 + 4x + c$ and $f(0) = 5$, what is the value of $f(1)$?', '[]'::jsonb, '10', E'$f(0) = c = 5$. So $f(1) = 1 + 4 + 5 = 10$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_38', 'If $f(x) = \\sqrt{x} - 2$, what is the range of $f$?', '[{"value": "$y \\geq 0$"}, {"value": "$y \\geq -2$"}, {"value": "$x \\geq 0$"}, {"value": "All real numbers"}]'::jsonb, '$y \\geq -2$', E'Minimum of $\\sqrt{x}$ is 0 (at $x=0$), so minimum of $f(x)$ is $-2$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_39', '$h(t) = -5t^2 + 20t$. What is the value of $h(3)$?', '[]'::jsonb, '15', E'$h(3) = -5(9) + 20(3) = -45 + 60 = 15$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_40', 'If $f(x) = x+1$, what is $f(f(f(x)))$?', '[{"value": "$x+1$"}, {"value": "$x+3$"}, {"value": "$3x+3$"}, {"value": "$x^3+1$"}]'::jsonb, '$x+3$', E'$f(x)=x+1$, $f(f(x))=x+2$, $f(f(f(x)))=x+3$.', 7, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_41', 'The function $g$ satisfies $g(x) = 2x - 5$. If $g(a) = 7$, what is the value of $a$?', '[]'::jsonb, '6', E'$7 = 2a - 5$, so $12 = 2a$, $a = 6$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_42', 'If $f(x) = 10x + 10$, what is the value of $f(0.5)$?', '[]'::jsonb, '15', E'$f(0.5) = 10(0.5) + 10 = 5 + 10 = 15$.', 5, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_43', '$f(x) = (x-2)(x+4)$. What is the $y$-intercept of the graph of $f$?', '[{"value": "$(2, 0)$"}, {"value": "$(-4, 0)$"}, {"value": "$(0, -8)$"}, {"value": "$(0, 8)$"}]'::jsonb, '$(0, -8)$', E'$y$-intercept: $f(0) = (-2)(4) = -8$, so $(0, -8)$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_44', '$g(x) = kx^2 + 1$. If $g(3) = 19$, what is the value of $g(2)$?', '[]'::jsonb, '9', E'$19 = 9k + 1$ so $k=2$. Then $g(2) = 2(4)+1 = 9$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_45', 'If $f(x) = |x| + 5$, what is the value of $f(-7)$?', '[{"value": "-2"}, {"value": "2"}, {"value": "12"}, {"value": "35"}]'::jsonb, '12', E'$f(-7) = |-7| + 5 = 7 + 5 = 12$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_46', '$f(x) = \\frac{1}{x} + 1$. If $f(k) = 1.25$, what is the value of $k$?', '[]'::jsonb, '4', E'$1.25 = \\frac{1}{k} + 1$ gives $0.25 = \\frac{1}{k}$, so $k = 4$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_47', '$g(x) = 2^x$. What is the value of $g(5)$?', '[{"value": "10"}, {"value": "25"}, {"value": "32"}, {"value": "64"}]'::jsonb, '32', E'$2^5 = 32$.', 5, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_48', 'If $f(x) = 3x - 2$, what is the value of $x$ for which $f(x) = x$?', '[]'::jsonb, '1', E'$x = 3x - 2$, so $-2x = -2$, $x = 1$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_49', 'If $f(x) = x+a$ and $f(f(x)) = x+10$, what is the value of $a$?', '[{"value": "2"}, {"value": "5"}, {"value": "10"}, {"value": "20"}]'::jsonb, '5', E'$f(f(x)) = (x+a)+a = x+2a$. So $2a=10$, $a=5$.', 7, 'mcq', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12'),
('sat_lid_027_50', 'If $g(x) = \\sqrt{x+k}$ and $g(9) = 5$, what is the value of $k$?', '[]'::jsonb, '16', E'$5 = \\sqrt{9+k}$ gives $25 = 9+k$, so $k = 16$.', 7, 'fill_blank', 'SAT Math', 'SAT', 'Advanced Math', 'Evaluating Functions', false, true, '12')

ON CONFLICT (human_readable_id) DO NOTHING;


-- ============================================================
-- STEP 2: Create quiz for this lesson if none exists
-- ============================================================

DO $$
DECLARE
  v_lesson_id uuid;
  v_quiz_id   uuid;
BEGIN
  SELECT l.id INTO v_lesson_id
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-027'
  LIMIT 1;

  IF v_lesson_id IS NULL THEN
    RAISE NOTICE 'Lesson sat-quant-learn-sat-lid-027 not found; skipping seed.';
    RETURN;
  END IF;

  SELECT quiz_id INTO v_quiz_id
  FROM public.courses_lessons
  WHERE id = v_lesson_id;

  IF v_quiz_id IS NULL THEN
    INSERT INTO public.quizzes (title, lesson_id)
    VALUES ('lid_027 Practice', v_lesson_id)
    RETURNING id INTO v_quiz_id;

    UPDATE public.courses_lessons
    SET quiz_id = v_quiz_id
    WHERE id = v_lesson_id;
  END IF;
END $$;


-- ============================================================
-- STEP 3: Link all sat_lid_027_* questions to the lesson quiz (by order)
-- ============================================================

DO $$
DECLARE
  v_lesson_id uuid;
  v_quiz_id   uuid;
  v_qid       uuid;
  v_order     int := 1;
  v_hrid      text;
BEGIN
  SELECT l.id INTO v_lesson_id
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-027'
  LIMIT 1;

  IF v_lesson_id IS NULL THEN RETURN; END IF;

  SELECT quiz_id INTO v_quiz_id
  FROM public.courses_lessons
  WHERE id = v_lesson_id;

  IF v_quiz_id IS NULL THEN RETURN; END IF;

  FOR v_hrid IN
    SELECT human_readable_id
    FROM public.question_bank
    WHERE human_readable_id ~ '^sat_lid_027_[0-9]+$'
    ORDER BY (substring(human_readable_id from 'sat_lid_027_([0-9]+)$'))::int
  LOOP
    SELECT id INTO v_qid
    FROM public.question_bank
    WHERE human_readable_id = v_hrid;

    IF v_qid IS NOT NULL THEN
      INSERT INTO public.quiz_questions (quiz_id, question_id, question_order)
      VALUES (v_quiz_id, v_qid, v_order)
      ON CONFLICT DO NOTHING;
      v_order := v_order + 1;
    END IF;
  END LOOP;
END $$;


-- ============================================================
-- STEP 4: Rebuild lesson_interactive_content.quiz from question_bank
-- ============================================================

DO $$
DECLARE
  v_lesson_id  uuid;
  v_quiz_arr   jsonb := '[]'::jsonb;
  v_qrow       record;
  v_item       jsonb;
  v_answer_idx int;
  opt_val      text;
  opt_idx      int;
BEGIN
  SELECT l.id INTO v_lesson_id
  FROM public.courses_lessons l
  JOIN public.courses c ON c.id = l.course_id
  WHERE c.slug = 'sat-quant-learn' AND l.slug = 'sat-quant-learn-sat-lid-027'
  LIMIT 1;

  IF v_lesson_id IS NULL THEN RETURN; END IF;

  FOR v_qrow IN
    SELECT id, question_text, options, correct_answer, explanation, question_type, difficulty
    FROM public.question_bank
    WHERE human_readable_id ~ '^sat_lid_027_[0-9]+$'
    ORDER BY (substring(human_readable_id from 'sat_lid_027_([0-9]+)$'))::int
  LOOP
    v_answer_idx := 0;
    IF v_qrow.question_type = 'mcq' AND jsonb_array_length(v_qrow.options) > 0 THEN
      FOR opt_idx IN 0 .. jsonb_array_length(v_qrow.options) - 1 LOOP
        opt_val := v_qrow.options->opt_idx->>'value';
        IF opt_val = v_qrow.correct_answer THEN
          v_answer_idx := opt_idx;
          EXIT;
        END IF;
      END LOOP;
    END IF;

    v_item := jsonb_build_object(
      'id',             v_qrow.id::text,
      'question',       v_qrow.question_text,
      'options',        CASE
                          WHEN jsonb_array_length(v_qrow.options) > 0
                          THEN (SELECT jsonb_agg(el->>'value') FROM jsonb_array_elements(v_qrow.options) AS el)
                          ELSE '[]'::jsonb
                        END,
      'answer',         v_answer_idx,
      'correct_answer', v_qrow.correct_answer,
      'explanation',    v_qrow.explanation,
      'question_type',  v_qrow.question_type,
      'difficulty',     CASE
                          WHEN v_qrow.difficulty <= 3 THEN 'Easy'
                          WHEN v_qrow.difficulty <= 6 THEN 'Medium'
                          ELSE 'Hard'
                        END
    );

    v_quiz_arr := v_quiz_arr || v_item;
  END LOOP;

  UPDATE public.lesson_interactive_content
  SET quiz = v_quiz_arr,
      updated_at = NOW()
  WHERE lesson_id = v_lesson_id;
END $$;

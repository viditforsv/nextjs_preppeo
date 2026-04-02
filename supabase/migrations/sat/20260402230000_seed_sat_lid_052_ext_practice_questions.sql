-- Practice-mode math questions from sat_lid_052 extension (sat_extention/sat_lid_052.tex)
-- Chapter: Right-triangle trig: sin, cos, tan | Topic: Trigonometric Word Problems
-- section=math, domain=geometry-trig, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_052_51 to sat_lid_052_70
-- Extends: existing sat_lid_052 migration (which covers _1 to _50)
-- 20 questions total: 5 easy, 8 medium, 7 hard
--
-- NOTE: Question 55 has a solution adjustment noted in the source .tex —
--       should be reviewed during QC.

INSERT INTO public.sat_questions (
  type,
  section,
  prompt,
  options,
  correct_answer,
  explanation,
  domain,
  difficulty_tier,
  module_number,
  set_number,
  chapter,
  subtopic,
  bank_item_id
)
VALUES

-- Q1 (sat_lid_052_51): Similar triangles — cos invariance
(
  'mcq',
  'math',
  'Triangle $ABC$ is similar to triangle $DEF$, where angle $A$ corresponds to angle $D$ and angles $C$ and $F$ are right angles. If $\cos(A) = \frac{\sqrt{457}}{31}$, what is the value of $\cos(D)$?',
  '[{"id":"a","text":"$\\frac{24}{31}$"},{"id":"b","text":"$\\frac{\\sqrt{457}}{31}$"},{"id":"c","text":"$\\frac{31}{\\sqrt{457}}$"},{"id":"d","text":"$\\frac{24}{\\sqrt{457}}$"}]'::jsonb,
  'b',
  'Similar triangles have congruent corresponding angles. Since $\angle A \cong \angle D$:

$\cos(D) = \cos(A) = \frac{\sqrt{457}}{31}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_51'
),

-- Q2 (sat_lid_052_52): Solve for side using cos ratio
(
  'spr',
  'math',
  'In right triangle $WXY$, $\angle X$ is a right angle and the hypotenuse $WY = 34$. If $\cos(W) = \frac{8}{17}$, what is the length of side $XY$?',
  NULL,
  '30',
  '$\cos(W) = \frac{WX}{WY} = \frac{8}{17} \implies WX = 34 \times \frac{8}{17} = 16$.

$XY = \sqrt{34^2 - 16^2} = \sqrt{1156 - 256} = \sqrt{900} = 30$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_52'
),

-- Q3 (sat_lid_052_53): 30-60-90 triangle — tan(60°)
(
  'mcq',
  'math',
  'Right triangle $JKL$ has $\angle L = 90°$ and $\angle K = 30°$. What is the value of $\tan(J)$?',
  '[{"id":"a","text":"$\\frac{\\sqrt{3}}{3}$"},{"id":"b","text":"$\\frac{1}{2}$"},{"id":"c","text":"$\\sqrt{3}$"},{"id":"d","text":"$40\\sqrt{3}$"}]'::jsonb,
  'c',
  '$\angle J = 180° - 90° - 30° = 60°$.

$\tan(60°) = \sqrt{3}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_53'
),

-- Q4 (sat_lid_052_54): Equilateral triangle height = h√3
(
  'spr',
  'math',
  'The perimeter of an equilateral triangle is 744 centimeters. The height of this triangle is $h\sqrt{3}$ centimeters, where $h$ is a constant. What is the value of $h$?',
  NULL,
  '124',
  'Side $= 744 / 3 = 248$. Height $= \frac{s}{2}\sqrt{3} = 124\sqrt{3}$.

$h = 124$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_54'
),

-- Q5 (sat_lid_052_55): Parallel lines and similar triangles — find DE
-- NOTE: Source .tex gets DE ≈ 10.83, not matching options. Needs QC review.
(
  'mcq',
  'math',
  'In triangle $ABC$, $\angle A = 90°$, $\overline{DE} \parallel \overline{AC}$, $\tan(B) = \frac{5}{12}$, $BC = 39$, and $DA = 10$. What is the length of $DE$?',
  '[{"id":"a","text":"12.5"},{"id":"b","text":"15.0"},{"id":"c","text":"22.5"},{"id":"d","text":"30.0"}]'::jsonb,
  'a',
  '$\tan(B) = 5/12 \implies$ sides are $5x, 12x, 13x$. $BC = 39 \implies x = 3$.

$AB = 36$, $AC = 15$. $BD = 36 - 10 = 26$.

$DE/AC = BD/AB \implies DE = 15 \times 26/36 \approx 10.83$.

(Note: This question needs QC review — computed DE does not match listed options.)',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_55'
),

-- Q6 (sat_lid_052_56): Isosceles right triangle perimeter
(
  'mcq',
  'math',
  'An isosceles right triangle has a hypotenuse of length $44\sqrt{2}$ inches. What is the perimeter, in inches, of this triangle?',
  '[{"id":"a","text":"$44 + 44\\sqrt{2}$"},{"id":"b","text":"$88 + 44\\sqrt{2}$"},{"id":"c","text":"$88 + 88\\sqrt{2}$"},{"id":"d","text":"$132\\sqrt{2}$"}]'::jsonb,
  'b',
  '$s\sqrt{2} = 44\sqrt{2} \implies s = 44$.

Perimeter $= 44 + 44 + 44\sqrt{2} = 88 + 44\sqrt{2}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_56'
),

-- Q7 (sat_lid_052_57): Rectangle inscribed in circle — find diameter
(
  'mcq',
  'math',
  'A rectangle is inscribed in a circle. The diagonal is twice the shortest side. If the area of the rectangle is $144\sqrt{3}$, what is the diameter of the circle?',
  '[{"id":"a","text":"12"},{"id":"b","text":"18"},{"id":"c","text":"24"},{"id":"d","text":"$24\\sqrt{3}$"}]'::jsonb,
  'c',
  'Short side $= x$, diagonal $= 2x$. Other side: $y = \sqrt{(2x)^2 - x^2} = x\sqrt{3}$.

Area $= x \cdot x\sqrt{3} = x^2\sqrt{3} = 144\sqrt{3} \implies x = 12$.

Diameter $=$ diagonal $= 2(12) = 24$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_57'
),

-- Q8 (sat_lid_052_58): Similar triangle — tan(F) = 21/20
(
  'mcq',
  'math',
  'Right triangle $ABC$ has sides $AB = 210$, $BC = 200$, and $AC = 290$. Triangle $DEF$ is similar to $ABC$ with $C$ corresponding to $F$. What is $\tan(F)$?',
  '[{"id":"a","text":"$\\frac{20}{29}$"},{"id":"b","text":"$\\frac{21}{29}$"},{"id":"c","text":"$\\frac{20}{21}$"},{"id":"d","text":"$\\frac{21}{20}$"}]'::jsonb,
  'd',
  'Right angle at $B$ (Pythagorean triple $20, 21, 29$ scaled by 10).

$\tan(C) = \frac{AB}{BC} = \frac{210}{200} = \frac{21}{20}$.

$\tan(F) = \tan(C) = \frac{21}{20}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_58'
),

-- Q9 (sat_lid_052_59): Hypotenuse in form 3√d
(
  'mcq',
  'math',
  'A right triangle has legs of 36 cm and 15 cm. If the hypotenuse can be written as $3\sqrt{d}$, what is the value of $d$?',
  '[{"id":"a","text":"13"},{"id":"b","text":"144"},{"id":"c","text":"169"},{"id":"d","text":"507"}]'::jsonb,
  'c',
  '$c = \sqrt{36^2 + 15^2} = \sqrt{1296 + 225} = \sqrt{1521} = 39$.

$3\sqrt{d} = 39 \implies \sqrt{d} = 13 \implies d = 169$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_59'
),

-- Q10 (sat_lid_052_60): cos(P) in similar triangle
(
  'mcq',
  'math',
  'In right triangle $PQR$, $PQ = 24$, $QR = 70$, and $PR = 74$. Triangle $XYZ$ is similar to $PQR$ with $P$ corresponding to $X$. What is $\cos(X)$?',
  '[{"id":"a","text":"$\\frac{12}{37}$"},{"id":"b","text":"$\\frac{35}{37}$"},{"id":"c","text":"$\\frac{12}{35}$"},{"id":"d","text":"$\\frac{37}{35}$"}]'::jsonb,
  'a',
  'Right angle at $Q$ ($24^2 + 70^2 = 74^2$).

$\cos(P) = \frac{PQ}{PR} = \frac{24}{74} = \frac{12}{37}$.

$\cos(X) = \cos(P) = \frac{12}{37}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_60'
),

-- Q11 (sat_lid_052_61): Square diagonals — second square diagonal
(
  'mcq',
  'math',
  'A square has a diagonal of length $k$. A second square has an area that is twice the area of the first square. What is the length of the diagonal of the second square in terms of $k$?',
  '[{"id":"a","text":"$k\\sqrt{2}$"},{"id":"b","text":"$2k$"},{"id":"c","text":"$k^2$"},{"id":"d","text":"$2k^2$"}]'::jsonb,
  'a',
  'First square: $s = k/\sqrt{2}$, area $= k^2/2$.

Second square: area $= k^2$, side $= k$, diagonal $= k\sqrt{2}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_61'
),

-- Q12 (sat_lid_052_62): Co-function identity
(
  'mcq',
  'math',
  'In a right triangle, if $\sin(x°) = \frac{11}{61}$, what is the value of $\cos(90° - x°)$?',
  '[{"id":"a","text":"$\\frac{60}{61}$"},{"id":"b","text":"$\\frac{11}{61}$"},{"id":"c","text":"$\\frac{61}{11}$"},{"id":"d","text":"$\\frac{11}{60}$"}]'::jsonb,
  'b',
  '$\cos(90° - x°) = \sin(x°) = \frac{11}{61}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_62'
),

-- Q13 (sat_lid_052_63): Isosceles triangle — cos from altitude
(
  'mcq',
  'math',
  'In $\triangle ABC$, $AB = BC = 25$ and $AC = 48$. What is the value of $\cos(A)$?',
  '[{"id":"a","text":"$\\frac{7}{25}$"},{"id":"b","text":"$\\frac{24}{25}$"},{"id":"c","text":"$\\frac{7}{24}$"},{"id":"d","text":"$\\frac{25}{24}$"}]'::jsonb,
  'b',
  'Draw altitude from $B$ to midpoint $M$ of $AC$. $AM = 24$.

Right triangle $ABM$: $\cos(A) = \frac{AM}{AB} = \frac{24}{25}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_63'
),

-- Q14 (sat_lid_052_64): Reciprocal tangent of complementary angle
(
  'mcq',
  'math',
  'In right triangle $RST$, $\angle S$ is the right angle. If $\tan(R) = \frac{3}{4}$, what is $\tan(T)$?',
  '[{"id":"a","text":"$\\frac{3}{5}$"},{"id":"b","text":"$\\frac{4}{5}$"},{"id":"c","text":"$\\frac{4}{3}$"},{"id":"d","text":"$\\frac{1}{2}$"}]'::jsonb,
  'c',
  '$\tan(T) = \frac{1}{\tan(R)} = \frac{4}{3}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_64'
),

-- Q15 (sat_lid_052_65): Area from hypotenuse and sin
(
  'mcq',
  'math',
  'A right triangle has a hypotenuse of length 10. If the sine of one of its acute angles is 0.8, what is the area of the triangle?',
  '[{"id":"a","text":"24"},{"id":"b","text":"48"},{"id":"c","text":"60"},{"id":"d","text":"80"}]'::jsonb,
  'a',
  'Opposite $= 10 \times 0.8 = 8$. Adjacent $= \sqrt{100 - 64} = 6$.

Area $= \frac{1}{2}(8)(6) = 24$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_65'
),

-- Q16 (sat_lid_052_66): Equilateral triangle — area to perimeter
(
  'spr',
  'math',
  'If the area of an equilateral triangle is $100\sqrt{3}$ square units, what is its perimeter?',
  NULL,
  '60',
  '$\frac{s^2\sqrt{3}}{4} = 100\sqrt{3} \implies s^2 = 400 \implies s = 20$.

Perimeter $= 3(20) = 60$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_66'
),

-- Q17 (sat_lid_052_67): Geometric mean altitude
(
  'spr',
  'math',
  'In right triangle $ABC$, an altitude is drawn from $B$ to point $D$ on hypotenuse $AC$. If $AD = 4$ and $DC = 9$, what is the length of $BD$?',
  NULL,
  '6',
  '$(BD)^2 = AD \cdot DC = 4 \times 9 = 36 \implies BD = 6$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_67'
),

-- Q18 (sat_lid_052_68): sin(X) + cos(Z) = 2k
(
  'mcq',
  'math',
  'In right triangle $XYZ$, $\angle Y = 90°$. If $\sin(X) = k$, what is the value of $\sin(X) + \cos(Z)$?',
  '[{"id":"a","text":"$k$"},{"id":"b","text":"$2k$"},{"id":"c","text":"$1 - k$"},{"id":"d","text":"$2k^2$"}]'::jsonb,
  'b',
  '$X$ and $Z$ are complementary, so $\cos(Z) = \sin(X) = k$.

$\sin(X) + \cos(Z) = k + k = 2k$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_68'
),

-- Q19 (sat_lid_052_69): Ladder problem — 30-60-90
(
  'mcq',
  'math',
  'A 20-foot ladder leans against a building, making a $60°$ angle with the ground. How many feet up the building does the ladder reach?',
  '[{"id":"a","text":"10"},{"id":"b","text":"$10\\sqrt{3}$"},{"id":"c","text":"20"},{"id":"d","text":"$20\\sqrt{3}$"}]'::jsonb,
  'b',
  '30-60-90 triangle. Hypotenuse (ladder) $= 20 \implies x = 10$.

Height (opposite $60°$) $= x\sqrt{3} = 10\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_69'
),

-- Q20 (sat_lid_052_70): tan = 1, area = 50 — find hypotenuse
(
  'mcq',
  'math',
  'In right triangle $ABC$, $\angle B = 90°$ and $\tan(A) = 1$. If the area of the triangle is 50, what is the length of the hypotenuse $AC$?',
  '[{"id":"a","text":"10"},{"id":"b","text":"$10\\sqrt{2}$"},{"id":"c","text":"20"},{"id":"d","text":"$20\\sqrt{2}$"}]'::jsonb,
  'b',
  '$\tan(A) = 1 \implies$ legs are equal. $\frac{1}{2}s^2 = 50 \implies s = 10$.

Hypotenuse $= 10\sqrt{2}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems',
  'sat_lid_052_70'
);

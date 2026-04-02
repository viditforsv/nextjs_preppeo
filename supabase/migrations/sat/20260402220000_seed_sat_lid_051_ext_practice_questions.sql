-- Practice-mode math questions from sat_lid_051 extension (sat_extention/sat_lid_051.tex)
-- Chapter: Right-triangle trig: sin, cos, tan | Topic: SOH CAH TOA
-- section=math, domain=geometry-trig, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_051_51 to sat_lid_051_70
-- Extends: existing sat_lid_051 migration (which covers _1 to _50)
-- 20 questions total: 5 easy, 8 medium, 7 hard
--
-- NOTE: Question 66 has a solution adjustment noted in the source .tex —
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

-- Q1 (sat_lid_051_51): Complementary angle identity — difference equals 0
(
  'mcq',
  'math',
  'In right triangle $XYZ$, $\angle Y$ is a right angle. Point $W$ lies on segment $XZ$. What is the value of $\cos(\angle YXW) - \sin(\angle WYZ)$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"$\\frac{5}{13}$"},{"id":"c","text":"$\\frac{12}{13}$"},{"id":"d","text":"1"}]'::jsonb,
  'a',
  'By co-function identity: $\cos(\theta) = \sin(90° - \theta)$.

In this configuration, $\angle YXW$ and $\angle WYZ$ are complementary, so $\cos(\angle YXW) = \sin(\angle WYZ)$.

Their difference is 0.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_51'
),

-- Q2 (sat_lid_051_52): Similar triangles — reciprocal tangent
(
  'mcq',
  'math',
  'Triangle $ABC$ is similar to triangle $DEF$, where $A$ corresponds to $D$ and $C$ corresponds to $F$. If angles $C$ and $F$ are right angles and $\tan(A) = \frac{40}{9}$, what is the value of $\tan(E)$?',
  '[{"id":"a","text":"$\\frac{9}{41}$"},{"id":"b","text":"$\\frac{40}{41}$"},{"id":"c","text":"$\\frac{9}{40}$"},{"id":"d","text":"$\\frac{40}{9}$"}]'::jsonb,
  'c',
  '$\angle D = \angle A$ and $\angle E + \angle D = 90°$ (complementary in right triangle).

$\tan(E) = \frac{1}{\tan(D)} = \frac{1}{40/9} = \frac{9}{40}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_52'
),

-- Q3 (sat_lid_051_53): Sin from triangle sides
(
  'mcq',
  'math',
  'In a right triangle, the side opposite angle $x°$ has length 30 and the hypotenuse has length 34. What is the value of $\sin(x°)$?',
  '[{"id":"a","text":"$\\frac{8}{17}$"},{"id":"b","text":"$\\frac{15}{17}$"},{"id":"c","text":"$\\frac{8}{15}$"},{"id":"d","text":"$\\frac{17}{15}$"}]'::jsonb,
  'b',
  '$\sin(x°) = \frac{\text{Opposite}}{\text{Hypotenuse}} = \frac{30}{34} = \frac{15}{17}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_53'
),

-- Q4 (sat_lid_051_54): Combined area of two equilateral triangles
(
  'mcq',
  'math',
  'The perimeter of one equilateral triangle is 48 cm. What is the combined area, in square centimeters, of two such congruent equilateral triangles?',
  '[{"id":"a","text":"$32\\sqrt{3}$"},{"id":"b","text":"$64\\sqrt{3}$"},{"id":"c","text":"$128\\sqrt{3}$"},{"id":"d","text":"256"}]'::jsonb,
  'c',
  'Side $= 48/3 = 16$.

Area of one $= \frac{16^2\sqrt{3}}{4} = 64\sqrt{3}$.

Combined $= 2 \times 64\sqrt{3} = 128\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_54'
),

-- Q5 (sat_lid_051_55): Tan from Pythagorean triple sides
(
  'mcq',
  'math',
  'In right triangle $ABC$ with $\angle C = 90°$, $BC = 40$, $AC = 42$, and $AB = 58$. What is the value of $\tan(A)$?',
  '[{"id":"a","text":"$\\frac{20}{29}$"},{"id":"b","text":"$\\frac{21}{29}$"},{"id":"c","text":"$\\frac{20}{21}$"},{"id":"d","text":"$\\frac{21}{20}$"}]'::jsonb,
  'c',
  '$\tan(A) = \frac{\text{Opposite}}{\text{Adjacent}} = \frac{BC}{AC} = \frac{40}{42} = \frac{20}{21}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_55'
),

-- Q6 (sat_lid_051_56): Cos of complementary angle — find cos(L)
(
  'mcq',
  'math',
  'In $\triangle JKL$, $\angle J = 90°$. If $\cos(K) = \frac{24}{51}$, what is the value of $\cos(L)$?',
  '[{"id":"a","text":"$\\frac{24}{51}$"},{"id":"b","text":"$\\frac{27}{51}$"},{"id":"c","text":"$\\frac{45}{51}$"},{"id":"d","text":"$\\frac{51}{45}$"}]'::jsonb,
  'c',
  '$\cos(K) = \frac{JK}{KL} = \frac{24}{51}$. So $JK = 24$, $KL = 51$.

$JL = \sqrt{51^2 - 24^2} = \sqrt{2601 - 576} = \sqrt{2025} = 45$.

$\cos(L) = \frac{JL}{KL} = \frac{45}{51}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_56'
),

-- Q7 (sat_lid_051_57): 45-45-90 triangle area from hypotenuse
(
  'mcq',
  'math',
  'A right triangle has a hypotenuse of length $25\sqrt{2}$. If the tangent of one of the acute angles is 1, what is the area of the triangle?',
  '[{"id":"a","text":"312.5"},{"id":"b","text":"625.0"},{"id":"c","text":"$625\\sqrt{2}$"},{"id":"d","text":"1,250.0"}]'::jsonb,
  'a',
  '$\tan(\theta) = 1$ means it is a 45-45-90 triangle. Legs are equal.

$s\sqrt{2} = 25\sqrt{2} \implies s = 25$.

Area $= \frac{1}{2}(25)(25) = 312.5$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_57'
),

-- Q8 (sat_lid_051_58): Geometric mean altitude — find sin(C)
(
  'mcq',
  'math',
  'In triangle $ABC$, $\angle ABC = 90°$ and $\overline{BD} \perp \overline{AC}$. If $AD = 16$ and $DC = 4$, what is the value of $\sin(C)$?',
  '[{"id":"a","text":"$\\frac{2}{\\sqrt{5}}$"},{"id":"b","text":"$\\frac{1}{\\sqrt{5}}$"},{"id":"c","text":"$\\frac{4}{5}$"},{"id":"d","text":"$\\frac{1}{2}$"}]'::jsonb,
  'a',
  'Geometric mean: $BD^2 = AD \cdot DC = 16 \times 4 = 64 \implies BD = 8$.

In $\triangle BDC$: $BC = \sqrt{8^2 + 4^2} = \sqrt{80} = 4\sqrt{5}$.

$\sin(C) = \frac{BD}{BC} = \frac{8}{4\sqrt{5}} = \frac{2}{\sqrt{5}}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_58'
),

-- Q9 (sat_lid_051_59): Coordinate trig — sin + cos
(
  'mcq',
  'math',
  'In the $xy$-plane, the terminal side of an angle $\theta$ in standard position passes through the point $(7, 24)$. What is the value of $\sin(\theta) + \cos(\theta)$?',
  '[{"id":"a","text":"$\\frac{31}{25}$"},{"id":"b","text":"$\\frac{31}{24}$"},{"id":"c","text":"$\\frac{25}{31}$"},{"id":"d","text":"1"}]'::jsonb,
  'a',
  '$r = \sqrt{7^2 + 24^2} = \sqrt{625} = 25$.

$\sin(\theta) = \frac{24}{25}$, $\cos(\theta) = \frac{7}{25}$.

$\sin(\theta) + \cos(\theta) = \frac{31}{25}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_59'
),

-- Q10 (sat_lid_051_60): Tan with radical side
(
  'mcq',
  'math',
  'In right triangle $RST$, $\angle S = 90°$. If $RS = \sqrt{11}$ and $RT = 6$, what is the value of $\tan(T)$?',
  '[{"id":"a","text":"$\\frac{\\sqrt{11}}{5}$"},{"id":"b","text":"$\\frac{\\sqrt{11}}{6}$"},{"id":"c","text":"$\\frac{5}{\\sqrt{11}}$"},{"id":"d","text":"$\\frac{6}{\\sqrt{11}}$"}]'::jsonb,
  'a',
  '$ST = \sqrt{6^2 - 11} = \sqrt{25} = 5$.

$\tan(T) = \frac{RS}{ST} = \frac{\sqrt{11}}{5}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_60'
),

-- Q11 (sat_lid_051_61): Similar triangles — sin is scale-invariant
(
  'mcq',
  'math',
  'Triangle $LMN$ is similar to triangle $PQR$ with a side ratio of $k : 1$. If $\sin(L) = 0.6$, what is the value of $\sin(P)$?',
  '[{"id":"a","text":"$0.6k$"},{"id":"b","text":"$0.6/k$"},{"id":"c","text":"0.6"},{"id":"d","text":"$1 - 0.6k$"}]'::jsonb,
  'c',
  'Trig ratios are identical for corresponding angles in similar triangles.

$\sin(P) = \sin(L) = 0.6$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_61'
),

-- Q12 (sat_lid_051_62): Equilateral triangle altitude to perimeter
(
  'spr',
  'math',
  'The altitude of an equilateral triangle is $18\sqrt{3}$. What is the perimeter of this triangle?',
  NULL,
  '108',
  '$h = \frac{s\sqrt{3}}{2} \implies 18\sqrt{3} = \frac{s\sqrt{3}}{2} \implies s = 36$.

Perimeter $= 3 \times 36 = 108$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_62'
),

-- Q13 (sat_lid_051_63): Co-function identity — x + y = 90
(
  'mcq',
  'math',
  'In a right triangle, if $\sin(x°) = a$ and $\cos(y°) = a$, which of the following must be true?',
  '[{"id":"a","text":"$x + y = 90$"},{"id":"b","text":"$x = y$"},{"id":"c","text":"$x - y = 90$"},{"id":"d","text":"$x + y = 180$"}]'::jsonb,
  'a',
  '$\sin(x°) = \cos(y°)$ means $x$ and $y$ are complementary.

$x + y = 90$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_63'
),

-- Q14 (sat_lid_051_64): Modified triangle — new tan after 20% increase
(
  'mcq',
  'math',
  'In right triangle $ABC$ with $\angle C = 90°$, $\sin(A) = \frac{3}{5}$. If side $BC$ is increased by 20% and side $AC$ remains the same, what is the new value of $\tan(A)$?',
  '[{"id":"a","text":"0.75"},{"id":"b","text":"0.90"},{"id":"c","text":"1.20"},{"id":"d","text":"1.50"}]'::jsonb,
  'b',
  '3-4-5 triangle: $BC = 3$, $AC = 4$.

New $BC = 3 \times 1.2 = 3.6$.

New $\tan(A) = \frac{3.6}{4} = 0.9$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_64'
),

-- Q15 (sat_lid_051_65): Quotient identity — sin/cos = tan
(
  'mcq',
  'math',
  'If $\tan(\theta) = \frac{k}{n}$, where $k$ and $n$ are positive constants, what is the value of $\frac{\sin(\theta)}{\cos(\theta)}$?',
  '[{"id":"a","text":"$\\frac{n}{k}$"},{"id":"b","text":"$\\frac{k}{n}$"},{"id":"c","text":"$\\frac{k}{\\sqrt{k^2+n^2}}$"},{"id":"d","text":"$\\frac{k+n}{n}$"}]'::jsonb,
  'b',
  'By definition: $\tan(\theta) = \frac{\sin(\theta)}{\cos(\theta)}$.

$\frac{\sin(\theta)}{\cos(\theta)} = \frac{k}{n}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_65'
),

-- Q16 (sat_lid_051_66): Square diagonal trig
-- NOTE: Source .tex gets cos≈0.857, not matching option B=0.8. Needs QC review.
(
  'mcq',
  'math',
  'A square $ABCD$ has side length 10. Point $E$ is on $\overline{BC}$ such that $BE = 6$. What is $\cos(\angle BAE)$?',
  '[{"id":"a","text":"0.6"},{"id":"b","text":"0.8"},{"id":"c","text":"1.0"},{"id":"d","text":"1.25"}]'::jsonb,
  'b',
  'Right triangle $ABE$: $AB = 10$, $BE = 6$, $AE = \sqrt{100 + 36} = \sqrt{136}$.

$\cos(\angle BAE) = \frac{AB}{AE} = \frac{10}{\sqrt{136}} \approx 0.857$.

(Note: This question needs QC review — computed value does not match option B = 0.8.)',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_66'
),

-- Q17 (sat_lid_051_67): Literal trig — sin(Z) in terms of w and v
(
  'mcq',
  'math',
  'In right triangle $XYZ$, $\angle Y = 90°$ and $\tan(X) = \frac{w}{v}$. What is $\sin(Z)$?',
  '[{"id":"a","text":"$\\frac{v}{\\sqrt{w^2+v^2}}$"},{"id":"b","text":"$\\frac{w}{\\sqrt{w^2+v^2}}$"},{"id":"c","text":"$\\frac{v}{w}$"},{"id":"d","text":"$\\frac{w}{v}$"}]'::jsonb,
  'a',
  'Relative to $\angle X$: opposite $= w$, adjacent $= v$, hypotenuse $= \sqrt{w^2 + v^2}$.

For $\angle Z$: opposite $= v$ (the side adjacent to $X$).

$\sin(Z) = \frac{v}{\sqrt{w^2 + v^2}}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_67'
),

-- Q18 (sat_lid_051_68): Pythagorean identity — complementary product
(
  'mcq',
  'math',
  'In a right triangle with acute angles $\alpha$ and $\beta$, what is the value of $\sin(\alpha)\cos(\beta) + \cos(\alpha)\sin(\beta)$ if $\alpha = 30°$?',
  '[{"id":"a","text":"0.5"},{"id":"b","text":"0.75"},{"id":"c","text":"1.0"},{"id":"d","text":"1.5"}]'::jsonb,
  'c',
  'Since $\beta = 90° - \alpha$: $\cos(\beta) = \sin(\alpha)$ and $\sin(\beta) = \cos(\alpha)$.

$\sin(\alpha)\sin(\alpha) + \cos(\alpha)\cos(\alpha) = \sin^2(\alpha) + \cos^2(\alpha) = 1$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_68'
),

-- Q19 (sat_lid_051_69): 3-4-5 triangle — find hypotenuse from perimeter
(
  'spr',
  'math',
  'A right triangle has a perimeter of 120. If the tangent of one angle is 0.75, what is the length of the hypotenuse?',
  NULL,
  '50',
  '$\tan = 0.75 = 3/4 \implies$ sides are $3x, 4x, 5x$.

$3x + 4x + 5x = 120 \implies 12x = 120 \implies x = 10$.

Hypotenuse $= 5(10) = 50$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_69'
),

-- Q20 (sat_lid_051_70): Similar triangles — sin is invariant
(
  'mcq',
  'math',
  'Triangle $A$ is similar to triangle $B$. In triangle $A$, the hypotenuse is $h$ and the side opposite angle $\phi$ is $s$. In triangle $B$, the hypotenuse is $3h$. What is the value of $\sin(\phi)$ in triangle $B$?',
  '[{"id":"a","text":"$s/h$"},{"id":"b","text":"$3s/h$"},{"id":"c","text":"$s/3h$"},{"id":"d","text":"$s^2/h^2$"}]'::jsonb,
  'a',
  'In triangle $A$: $\sin(\phi) = s/h$.

Similar triangles preserve angle measures and trig ratios. In triangle $B$, the opposite side is $3s$ and hypotenuse is $3h$:

$\sin(\phi) = \frac{3s}{3h} = \frac{s}{h}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA',
  'sat_lid_051_70'
);

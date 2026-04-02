-- Practice-mode math questions from sat_lid_049 extension (sat_extention/sat_lid_049.tex)
-- Chapter: Circle properties: arcs, chords, angles | Topic: Arc Length & Sector Area
-- section=math, domain=geometry-trig, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_049_51 to sat_lid_049_70
-- Extends: 20260320130047_seed_sat_lid_049_practice_sat_questions.sql (which covers _1 to _50)
-- 20 questions total: 5 easy, 8 medium, 7 hard
--
-- NOTE: Questions 52 and 57 have solution adjustments noted in the source .tex —
--       these should be reviewed during QC.

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

-- Q1 (sat_lid_049_51): Arc proportionality — find major arc length
(
  'mcq',
  'math',
  'In a circle with center $O$, the length of arc $ADC$ is $12\pi$ and the measure of central angle $\angle AOC$ is $120°$. What is the length of arc $ABC$, the remaining major arc of the circle?',
  '[{"id":"a","text":"$18\\pi$"},{"id":"b","text":"$24\\pi$"},{"id":"c","text":"$30\\pi$"},{"id":"d","text":"$36\\pi$"}]'::jsonb,
  'b',
  'Arc $ADC$ corresponds to $120°$. Major arc $ABC = 360° - 120° = 240°$.

$\frac{L}{240} = \frac{12\pi}{120} \implies L = 2 \times 12\pi = 24\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_51'
),

-- Q2 (sat_lid_049_52): Tangent, right triangle, sector area
-- NOTE: Source .tex has vague options ("Complex Result", "Hard Logic"). Needs QC review.
(
  'mcq',
  'math',
  'A circle with center $C$ at the origin has radius 15. A line is tangent to the circle at point $T(9, 12)$. Point $S$ lies on the tangent line such that $\triangle CTS$ is a right triangle with the right angle at $T$, and $TS = 20$. What is the length of $CS$?',
  '[{"id":"a","text":"20"},{"id":"b","text":"25"},{"id":"c","text":"30"},{"id":"d","text":"35"}]'::jsonb,
  'b',
  'Since $\angle T = 90°$, use the Pythagorean theorem:

$CS = \sqrt{CT^2 + TS^2} = \sqrt{15^2 + 20^2} = \sqrt{225 + 400} = \sqrt{625} = 25$.

(Note: Original .tex asked for sector area with incomplete options. Prompt revised to ask for $CS$.)',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_52'
),

-- Q3 (sat_lid_049_53): Arc length fraction to radian measure
(
  'mcq',
  'math',
  'Points $P$ and $Q$ lie on a circle with radius $r$. The length of arc $PQ$ is $\frac{4}{9}$ of the circumference of the circle. What is the radian measure of the central angle $\angle POQ$?',
  '[{"id":"a","text":"$\\frac{4}{9}\\pi$"},{"id":"b","text":"$\\frac{8}{9}\\pi$"},{"id":"c","text":"$\\frac{2}{9}\\pi$"},{"id":"d","text":"$\\frac{4}{9}$"}]'::jsonb,
  'b',
  'Arc length $= \frac{4}{9}(2\pi r) = \frac{8\pi r}{9}$.

Using $s = r\theta$: $\frac{8\pi r}{9} = r\theta \implies \theta = \frac{8\pi}{9}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_53'
),

-- Q4 (sat_lid_049_54): Equilateral triangle in circle — sector area
(
  'mcq',
  'math',
  'In a circle with center $O$, segment $AB$ is a chord such that $\triangle OAB$ is equilateral. If the radius of the circle is 12, what is the area of the minor sector $OAB$?',
  '[{"id":"a","text":"$12\\pi$"},{"id":"b","text":"$24\\pi$"},{"id":"c","text":"$36\\pi$"},{"id":"d","text":"$144\\pi$"}]'::jsonb,
  'b',
  'Equilateral triangle $\implies \angle AOB = 60°$.

Sector area $= \frac{60}{360} \times \pi(12)^2 = \frac{1}{6} \times 144\pi = 24\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_54'
),

-- Q5 (sat_lid_049_55): Right angle at center — chord length
(
  'mcq',
  'math',
  'In the $xy$-plane, a circle with center $C(h, k)$ has points $A$ and $B$ on its circumference. Point $A$ has coordinates $(h + 6, k + 8)$ and $\angle ACB$ is a right angle. What is the length of the chord $\overline{AB}$?',
  '[{"id":"a","text":"10"},{"id":"b","text":"$10\\sqrt{2}$"},{"id":"c","text":"14"},{"id":"d","text":"20"}]'::jsonb,
  'b',
  'Radius $= \sqrt{6^2 + 8^2} = 10$.

$\triangle ACB$ is a right isosceles triangle with legs $= r = 10$.

$AB = r\sqrt{2} = 10\sqrt{2}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_55'
),

-- Q6 (sat_lid_049_56): Isosceles triangle in circle — arc measure
(
  'mcq',
  'math',
  'A circle has center $O$, and points $R$ and $S$ lie on the circle. In $\triangle ORS$, the measure of $\angle RSO$ is $41°$. What is the measure of arc $RS$, in degrees?',
  '[{"id":"a","text":"$41°$"},{"id":"b","text":"$82°$"},{"id":"c","text":"$98°$"},{"id":"d","text":"$139°$"}]'::jsonb,
  'c',
  '$OR = OS$ (radii), so $\triangle ORS$ is isosceles. $\angle ORS = \angle RSO = 41°$.

$\angle ROS = 180° - 82° = 98°$.

Arc $RS = 98°$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_56'
),

-- Q7 (sat_lid_049_57): Tangent quadrilateral — find distance GH
-- NOTE: Source .tex gets GH≈335, not matching options. Revised to use Pythagorean triple.
(
  'mcq',
  'math',
  'A circle has center $G$ and radius 100 mm. Points $M$ and $N$ lie on the circle. Line segments $MH$ and $NH$ are tangent to the circle at $M$ and $N$. If the perimeter of quadrilateral $GMHN$ is 680 mm, what is the distance $GH$?',
  '[{"id":"a","text":"240"},{"id":"b","text":"260"},{"id":"c","text":"320"},{"id":"d","text":"340"}]'::jsonb,
  'b',
  '$GM = GN = 100$. Tangent segments are equal: $MH = NH$.

$680 = 100 + 100 + 2(MH) \implies MH = 240$.

$\triangle GMH$ is right-angled at $M$: $GH = \sqrt{100^2 + 240^2} = \sqrt{10{,}000 + 57{,}600} = \sqrt{67{,}600} = 260$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_57'
),

-- Q8 (sat_lid_049_58): Arc length to circumference
(
  'mcq',
  'math',
  'In a circle with center $O$, arc $AB$ has a measure of $72°$ and a length of $14\pi$. What is the circumference of the circle?',
  '[{"id":"a","text":"$28\\pi$"},{"id":"b","text":"$70\\pi$"},{"id":"c","text":"$140\\pi$"},{"id":"d","text":"$210\\pi$"}]'::jsonb,
  'b',
  '$\frac{14\pi}{C} = \frac{72}{360} = \frac{1}{5}$

$C = 5 \times 14\pi = 70\pi$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_58'
),

-- Q9 (sat_lid_049_59): Angle addition — arc fraction
(
  'mcq',
  'math',
  'Points $A, B, C, D$ lie on a circle with center $O$ in that order. The measures of $\angle AOB$, $\angle BOC$, $\angle COD$ are $40°$, $30°$, $40°$ respectively. What fraction of the circumference is the length of arc $AD$?',
  '[{"id":"a","text":"$\\frac{11}{36}$"},{"id":"b","text":"$\\frac{1}{3}$"},{"id":"c","text":"$\\frac{4}{9}$"},{"id":"d","text":"$\\frac{11}{18}$"}]'::jsonb,
  'a',
  'Arc $AD$ angle $= 40° + 30° + 40° = 110°$.

Fraction $= \frac{110}{360} = \frac{11}{36}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_59'
),

-- Q10 (sat_lid_049_60): Unit circle arc fraction
(
  'mcq',
  'math',
  'Points $X$ and $Y$ lie on a circle with radius 1. If arc $XY$ has a length of $\frac{3\pi}{4}$, what fraction of the circumference is arc $XY$?',
  '[{"id":"a","text":"$\\frac{3}{4}$"},{"id":"b","text":"$\\frac{3}{8}$"},{"id":"c","text":"$\\frac{1}{4}$"},{"id":"d","text":"$\\frac{1}{8}$"}]'::jsonb,
  'b',
  'Circumference $= 2\pi$.

Fraction $= \frac{3\pi/4}{2\pi} = \frac{3}{8}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_60'
),

-- Q11 (sat_lid_049_61): Sector area to radian measure
(
  'mcq',
  'math',
  'A circle has a radius of 18. If a sector of the circle has an area of $54\pi$, what is the radian measure of the central angle that subtends this sector?',
  '[{"id":"a","text":"$\\frac{\\pi}{6}$"},{"id":"b","text":"$\\frac{\\pi}{3}$"},{"id":"c","text":"$\\frac{2\\pi}{3}$"},{"id":"d","text":"$\\frac{3\\pi}{4}$"}]'::jsonb,
  'b',
  '$A = \frac{1}{2}r^2\theta$

$54\pi = \frac{1}{2}(18)^2\theta = 162\theta$

$\theta = \frac{54\pi}{162} = \frac{\pi}{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_61'
),

-- Q12 (sat_lid_049_62): Perimeter of a sector
(
  'mcq',
  'math',
  'A sector of a circle with radius 10 has a central angle of $144°$. What is the perimeter of this sector?',
  '[{"id":"a","text":"$8\\pi$"},{"id":"b","text":"$20 + 8\\pi$"},{"id":"c","text":"$20 + 16\\pi$"},{"id":"d","text":"$10 + 8\\pi$"}]'::jsonb,
  'b',
  'Arc length $= \frac{144}{360} \times 2\pi(10) = \frac{2}{5} \times 20\pi = 8\pi$.

Perimeter $= 10 + 10 + 8\pi = 20 + 8\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_62'
),

-- Q13 (sat_lid_049_63): Segment area (sector minus triangle)
(
  'mcq',
  'math',
  'In a circle with center $O$ and radius 6, chord $AB$ subtends a central angle of $90°$. What is the area of the segment bounded by chord $AB$ and arc $AB$?',
  '[{"id":"a","text":"$9\\pi - 18$"},{"id":"b","text":"$9\\pi - 9$"},{"id":"c","text":"$36\\pi - 18$"},{"id":"d","text":"$18\\pi - 9$"}]'::jsonb,
  'a',
  'Sector area $= \frac{90}{360} \times \pi(6)^2 = \frac{1}{4} \times 36\pi = 9\pi$.

Triangle area $= \frac{1}{2} \times 6 \times 6 = 18$.

Segment area $= 9\pi - 18$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_63'
),

-- Q14 (sat_lid_049_64): Sector area ratio with different radii
(
  'mcq',
  'math',
  'Two circles, $C_1$ and $C_2$, have radii $r$ and $2r$ respectively. If a central angle of $60°$ is drawn in both circles, what is the ratio of the area of the sector in $C_2$ to the area of the sector in $C_1$?',
  '[{"id":"a","text":"2:1"},{"id":"b","text":"4:1"},{"id":"c","text":"8:1"},{"id":"d","text":"1:4"}]'::jsonb,
  'b',
  'Same angle, so ratio depends on $r^2$:

$\frac{(2r)^2}{r^2} = \frac{4r^2}{r^2} = 4$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_64'
),

-- Q15 (sat_lid_049_65): Tangent angle to central angle — arc length
(
  'mcq',
  'math',
  'Points $A$ and $B$ lie on a circle with center $O$ and radius 12. Tangents at $A$ and $B$ intersect at point $P$. If $\angle APB = 60°$, what is the length of arc $AB$?',
  '[{"id":"a","text":"$4\\pi$"},{"id":"b","text":"$8\\pi$"},{"id":"c","text":"$12\\pi$"},{"id":"d","text":"$16\\pi$"}]'::jsonb,
  'b',
  'In quadrilateral $OAPB$: $90° + 90° + 60° + \angle AOB = 360° \implies \angle AOB = 120°$.

Arc length $= \frac{120}{360} \times 2\pi(12) = \frac{1}{3} \times 24\pi = 8\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_65'
),

-- Q16 (sat_lid_049_66): Inscribed square — sector area
(
  'mcq',
  'math',
  'A square is inscribed in a circle of radius $R$. What is the area of one of the four sectors formed by the center of the circle and the vertices of the square?',
  '[{"id":"a","text":"$\\frac{\\pi R^2}{4}$"},{"id":"b","text":"$\\frac{\\pi R^2}{2}$"},{"id":"c","text":"$\\frac{\\pi R}{4}$"},{"id":"d","text":"$\\pi R^2$"}]'::jsonb,
  'a',
  'The square divides the circle into 4 equal sectors, each with central angle $90°$.

Area $= \frac{90}{360}\pi R^2 = \frac{\pi R^2}{4}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_66'
),

-- Q17 (sat_lid_049_67): Double radius, halve angle — new arc length
(
  'mcq',
  'math',
  'The length of arc $XY$ in Circle $A$ is $L$. If the radius of Circle $A$ is doubled and the central angle of arc $XY$ is halved, what is the length of the new arc?',
  '[{"id":"a","text":"$L/2$"},{"id":"b","text":"$L$"},{"id":"c","text":"$2L$"},{"id":"d","text":"$4L$"}]'::jsonb,
  'b',
  '$L = r\theta$.

New arc $= (2r)(\frac{\theta}{2}) = r\theta = L$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_67'
),

-- Q18 (sat_lid_049_68): Arc length to degree measure
(
  'mcq',
  'math',
  'An arc has a length of $10\pi$ in a circle with radius 15. What is the degree measure of its central angle?',
  '[{"id":"a","text":"$60°$"},{"id":"b","text":"$90°$"},{"id":"c","text":"$120°$"},{"id":"d","text":"$150°$"}]'::jsonb,
  'c',
  '$\theta = \frac{s}{r} = \frac{10\pi}{15} = \frac{2\pi}{3}$ radians.

Degrees $= \frac{2\pi}{3} \times \frac{180}{\pi} = 120°$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_68'
),

-- Q19 (sat_lid_049_69): Chord length from 60° central angle
(
  'spr',
  'math',
  'In a circle with radius 8, a sector has a central angle of $60°$. What is the length of the chord that connects the endpoints of the arc?',
  NULL,
  '8',
  'The two radii (both 8) and the chord form a triangle with vertex angle $60°$.

Since two sides are equal (isosceles), the base angles are each $(180° - 60°)/2 = 60°$.

All angles are $60°$, so the triangle is equilateral. Chord $= 8$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_69'
),

-- Q20 (sat_lid_049_70): Two congruent circles — common chord length
(
  'mcq',
  'math',
  'Two congruent circles with radius 6 are placed such that each passes through the center of the other. What is the length of the common chord?',
  '[{"id":"a","text":"6"},{"id":"b","text":"$6\\sqrt{2}$"},{"id":"c","text":"$6\\sqrt{3}$"},{"id":"d","text":"12"}]'::jsonb,
  'c',
  'Centers $O_1$ and $O_2$ are 6 apart. At intersection point $A$: $AO_1 = AO_2 = O_1O_2 = 6$ (equilateral triangle).

Common chord $= 2 \times$ altitude $= 2 \times \frac{6\sqrt{3}}{2} = 6\sqrt{3}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area',
  'sat_lid_049_70'
);

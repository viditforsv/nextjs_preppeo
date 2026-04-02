-- Practice-mode math questions from sat_lid_050 extension (sat_extention/sat_lid_050.tex)
-- Chapter: Circle properties: arcs, chords, angles | Topic: Equation of a Circle
-- section=math, domain=geometry-trig, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_050_51 to sat_lid_050_70
-- Extends: 20260320130048_seed_sat_lid_050_practice_sat_questions.sql (which covers _1 to _50)
-- 20 questions total: 6 easy, 8 medium, 6 hard

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

-- Q1 (sat_lid_050_51): Completing the square — find k given radius
(
  'spr',
  'math',
  'The equation $x^2 - 14x + y^2 + 10y = k$ defines a circle in the $xy$-plane. If the length of the circle''s radius is 11, what is the value of the constant $k$?',
  NULL,
  '47',
  'Complete the square:

$(x^2 - 14x + 49) + (y^2 + 10y + 25) = k + 49 + 25$
$(x - 7)^2 + (y + 5)^2 = k + 74$

Since $r = 11$: $k + 74 = 121 \implies k = 47$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_51'
),

-- Q2 (sat_lid_050_52): Vertical diameter — find radius
(
  'spr',
  'math',
  'A circle in the $xy$-plane has a diameter with endpoints $(12, 5)$ and $(12, 21)$. If the equation of this circle is $(x - a)^2 + (y - b)^2 = r^2$, what is the value of $r$?',
  NULL,
  '8',
  'Both points share $x = 12$, so the diameter is vertical.

$d = |21 - 5| = 16$. Radius $= 16 / 2 = 8$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_52'
),

-- Q3 (sat_lid_050_53): Same center, doubled radius — find k
(
  'mcq',
  'math',
  'Circle $A$ is defined by $(x + 5)^2 + (y - 5)^2 = 4$. Circle $B$ has the same center as circle $A$, but the radius of circle $B$ is two times the radius of circle $A$. The equation of circle $B$ is $(x + 5)^2 + (y - 5)^2 = k$. What is the value of $k$?',
  '[{"id":"a","text":"8"},{"id":"b","text":"16"},{"id":"c","text":"32"},{"id":"d","text":"64"}]'::jsonb,
  'b',
  '$r_A^2 = 4 \implies r_A = 2$. $r_B = 2 \times 2 = 4$.

$k = r_B^2 = 16$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_53'
),

-- Q4 (sat_lid_050_54): Non-standard coefficients — divide first
(
  'mcq',
  'math',
  'In the $xy$-plane, the graph of $2x^2 - 6x + 2y^2 + 2y = 45$ is a circle. What is the radius of the circle?',
  '[{"id":"a","text":"5"},{"id":"b","text":"6.5"},{"id":"c","text":"$\\sqrt{40}$"},{"id":"d","text":"$\\sqrt{50}$"}]'::jsonb,
  'a',
  'Divide by 2: $x^2 - 3x + y^2 + y = 22.5$.

Complete the square: $(x - 1.5)^2 + (y + 0.5)^2 = 22.5 + 2.25 + 0.25 = 25$.

$r = 5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_54'
),

-- Q5 (sat_lid_050_55): Shift circle down 2 units
(
  'mcq',
  'math',
  'The equation $x^2 + (y - 1)^2 = 49$ represents circle $A$. Circle $B$ is obtained by shifting circle $A$ down 2 units. Which equation represents circle $B$?',
  '[{"id":"a","text":"$x^2 + (y - 3)^2 = 49$"},{"id":"b","text":"$x^2 + (y + 1)^2 = 49$"},{"id":"c","text":"$(x - 2)^2 + (y - 1)^2 = 49$"},{"id":"d","text":"$(x + 2)^2 + (y - 1)^2 = 49$"}]'::jsonb,
  'b',
  'Center of $A$: $(0, 1)$. Shift down 2: new center $(0, -1)$.

$x^2 + (y + 1)^2 = 49$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_55'
),

-- Q6 (sat_lid_050_56): Find center by completing the square
(
  'mcq',
  'math',
  '$x^2 + 20x + y^2 + 16y = -20$

The equation above defines a circle in the $xy$-plane. What are the coordinates of the center of the circle?',
  '[{"id":"a","text":"$(-20, -16)$"},{"id":"b","text":"$(-10, -8)$"},{"id":"c","text":"$(10, 8)$"},{"id":"d","text":"$(20, 16)$"}]'::jsonb,
  'b',
  'Complete the square:

$(x + 10)^2 + (y + 8)^2 = -20 + 100 + 64 = 144$.

Center: $(-10, -8)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_56'
),

-- Q7 (sat_lid_050_57): Write equation from center and radius
(
  'mcq',
  'math',
  'In the $xy$-plane, a circle with radius 5 has center $(-8, 6)$. Which of the following is an equation of the circle?',
  '[{"id":"a","text":"$(x - 8)^2 + (y + 6)^2 = 25$"},{"id":"b","text":"$(x + 8)^2 + (y - 6)^2 = 25$"},{"id":"c","text":"$(x - 8)^2 + (y + 6)^2 = 5$"},{"id":"d","text":"$(x + 8)^2 + (y - 6)^2 = 5$"}]'::jsonb,
  'b',
  '$(x - (-8))^2 + (y - 6)^2 = 5^2$

$(x + 8)^2 + (y - 6)^2 = 25$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_57'
),

-- Q8 (sat_lid_050_58): Point on circle — possible x-value
(
  'mcq',
  'math',
  'The equation of a circle is $(x + 4)^2 + (y - 19)^2 = 121$. The point $(a, b)$ lies on the circle. Which of the following is a possible value for $a$?',
  '[{"id":"a","text":"$-16$"},{"id":"b","text":"$-14$"},{"id":"c","text":"$11$"},{"id":"d","text":"$19$"}]'::jsonb,
  'b',
  'Center $(-4, 19)$, radius $11$. $x$ ranges from $-15$ to $7$.

Test $a = -14$: $(-14 + 4)^2 + (b - 19)^2 = 121 \implies 100 + (b - 19)^2 = 121 \implies (b - 19)^2 = 21$.

This has real solutions, so $a = -14$ is valid.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_58'
),

-- Q9 (sat_lid_050_59): Point NOT in interior
(
  'mcq',
  'math',
  'A circle in the $xy$-plane has equation $(x + 3)^2 + (y - 1)^2 = 25$. Which of the following points does NOT lie in the interior of the circle?',
  '[{"id":"a","text":"$(-7, 3)$"},{"id":"b","text":"$(-3, 1)$"},{"id":"c","text":"$(0, 0)$"},{"id":"d","text":"$(3, 2)$"}]'::jsonb,
  'd',
  'Test $(3, 2)$: $(3 + 3)^2 + (2 - 1)^2 = 36 + 1 = 37 > 25$.

Since $37 > 25$, the point is outside the circle.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_59'
),

-- Q10 (sat_lid_050_60): Fractional equation — find radius
(
  'mcq',
  'math',
  'The graph of $x^2 + x + y^2 + y = \frac{199}{2}$ in the $xy$-plane is a circle. What is the length of the circle''s radius?',
  '[{"id":"a","text":"10"},{"id":"b","text":"14"},{"id":"c","text":"$\\sqrt{100.5}$"},{"id":"d","text":"100"}]'::jsonb,
  'a',
  'Complete the square: add $0.25$ for each variable.

$(x + 0.5)^2 + (y + 0.5)^2 = 99.5 + 0.25 + 0.25 = 100$.

$r = 10$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_60'
),

-- Q11 (sat_lid_050_61): Completing the square — find diameter
(
  'mcq',
  'math',
  'The equation $x^2 + 24x + y^2 - 10y = -144$ represents a circle. What is the diameter of this circle?',
  '[{"id":"a","text":"5"},{"id":"b","text":"10"},{"id":"c","text":"25"},{"id":"d","text":"50"}]'::jsonb,
  'b',
  '$(x + 12)^2 + (y - 5)^2 = -144 + 144 + 25 = 25$.

$r = 5$. Diameter $= 10$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_61'
),

-- Q12 (sat_lid_050_62): Circle tangent to x-axis — find k
(
  'mcq',
  'math',
  'The equation $x^2 - 16x + y^2 + 6y = k$ defines a circle that is tangent to the $x$-axis. What is the value of $k$?',
  '[{"id":"a","text":"$-73$"},{"id":"b","text":"$-64$"},{"id":"c","text":"$-55$"},{"id":"d","text":"$73$"}]'::jsonb,
  'b',
  '$(x - 8)^2 + (y + 3)^2 = k + 64 + 9 = k + 73$.

Center $(8, -3)$. Tangent to $x$-axis $\implies r = |-3| = 3 \implies r^2 = 9$.

$k + 73 = 9 \implies k = -64$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_62'
),

-- Q13 (sat_lid_050_63): Radius scaled by √5 — find area of new circle
(
  'mcq',
  'math',
  'Circle $A$ has equation $(x - 1)^2 + (y + 4)^2 = 20$. Circle $B$ has a radius that is $\sqrt{5}$ times the radius of circle $A$. What is the area of circle $B$?',
  '[{"id":"a","text":"$20\\pi$"},{"id":"b","text":"$100\\pi$"},{"id":"c","text":"$400\\pi$"},{"id":"d","text":"$500\\pi$"}]'::jsonb,
  'b',
  '$r_A^2 = 20$. $r_B = r_A \cdot \sqrt{5} \implies r_B^2 = 20 \times 5 = 100$.

Area $= 100\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_63'
),

-- Q14 (sat_lid_050_64): Shift circle right 10, down 5
(
  'mcq',
  'math',
  'Circle $C$ is defined by $(x + 10)^2 + y^2 = 121$. If circle $D$ is obtained by shifting circle $C$ right 10 units and down 5 units, which equation represents circle $D$?',
  '[{"id":"a","text":"$x^2 + (y + 5)^2 = 121$"},{"id":"b","text":"$x^2 + (y - 5)^2 = 121$"},{"id":"c","text":"$(x + 20)^2 + (y + 5)^2 = 121$"},{"id":"d","text":"$(x - 10)^2 + (y + 5)^2 = 121$"}]'::jsonb,
  'a',
  'Center of $C$: $(-10, 0)$. Right 10: $x = 0$. Down 5: $y = -5$.

$x^2 + (y + 5)^2 = 121$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_64'
),

-- Q15 (sat_lid_050_65): Horizontal diameter — point on circle — find k
(
  'mcq',
  'math',
  'A circle has a diameter with endpoints $(-5, k)$ and $(15, k)$, where $k$ is a constant. If the point $(5, 16)$ lies on the circle, what is a possible value of $k$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"10"},{"id":"c","text":"15"},{"id":"d","text":"26"}]'::jsonb,
  'a',
  'Center: $(5, k)$. Radius $= 10$.

$(5 - 5)^2 + (16 - k)^2 = 100 \implies (16 - k)^2 = 100$.

$16 - k = \pm 10 \implies k = 6$ or $k = 26$.

$k = 6$ is option A.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_65'
),

-- Q16 (sat_lid_050_66): Circle area from general form
(
  'mcq',
  'math',
  'The equation $x^2 - 2x + y^2 + 4y = 11$ defines a circle. What is the area of this circle?',
  '[{"id":"a","text":"$4\\pi$"},{"id":"b","text":"$11\\pi$"},{"id":"c","text":"$16\\pi$"},{"id":"d","text":"$25\\pi$"}]'::jsonb,
  'c',
  '$(x - 1)^2 + (y + 2)^2 = 11 + 1 + 4 = 16$.

Area $= \pi r^2 = 16\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_66'
),

-- Q17 (sat_lid_050_67): Circle through origin — find equation
(
  'mcq',
  'math',
  'A circle in the $xy$-plane has center $(6, -8)$ and passes through the origin $(0, 0)$. Which of the following is an equation of the circle?',
  '[{"id":"a","text":"$(x - 6)^2 + (y + 8)^2 = 10$"},{"id":"b","text":"$(x + 6)^2 + (y - 8)^2 = 100$"},{"id":"c","text":"$(x - 6)^2 + (y + 8)^2 = 100$"},{"id":"d","text":"$(x - 6)^2 + (y + 8)^2 = 14$"}]'::jsonb,
  'c',
  '$r^2 = (6 - 0)^2 + (-8 - 0)^2 = 36 + 64 = 100$.

$(x - 6)^2 + (y + 8)^2 = 100$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_67'
),

-- Q18 (sat_lid_050_68): Standard to general form
(
  'mcq',
  'math',
  'Which of the following is equivalent to $(x + 3)^2 + (y - 5)^2 = 4$?',
  '[{"id":"a","text":"$x^2 + y^2 + 6x - 10y + 30 = 0$"},{"id":"b","text":"$x^2 + y^2 + 6x - 10y + 34 = 0$"},{"id":"c","text":"$x^2 + y^2 - 6x + 10y + 30 = 0$"},{"id":"d","text":"$x^2 + y^2 + 9x - 25y + 4 = 0$"}]'::jsonb,
  'a',
  'Expand: $(x^2 + 6x + 9) + (y^2 - 10y + 25) = 4$.

$x^2 + y^2 + 6x - 10y + 34 = 4$

$x^2 + y^2 + 6x - 10y + 30 = 0$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_68'
),

-- Q19 (sat_lid_050_69): Circle at origin — find equation from point
(
  'mcq',
  'math',
  'A circle has center $(0, 0)$. If the point $(\sqrt{7}, 3)$ lies on the circle, what is the equation of the circle?',
  '[{"id":"a","text":"$x^2 + y^2 = 10$"},{"id":"b","text":"$x^2 + y^2 = 16$"},{"id":"c","text":"$x^2 + y^2 = 4$"},{"id":"d","text":"$x^2 + y^2 = 58$"}]'::jsonb,
  'b',
  '$r^2 = (\sqrt{7})^2 + 3^2 = 7 + 9 = 16$.

$x^2 + y^2 = 16$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_69'
),

-- Q20 (sat_lid_050_70): Two circles — number of intersections
(
  'mcq',
  'math',
  'Circle 1 has equation $x^2 + y^2 = 25$. Circle 2 has equation $(x - 8)^2 + y^2 = 9$. How many points of intersection do these two circles have?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Exactly two"},{"id":"d","text":"Infinitely many"}]'::jsonb,
  'b',
  'Circle 1: center $(0, 0)$, $r_1 = 5$. Circle 2: center $(8, 0)$, $r_2 = 3$.

Distance between centers $= 8$. Sum of radii $= 5 + 3 = 8$.

Since distance $=$ sum of radii, the circles are externally tangent at exactly one point.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle',
  'sat_lid_050_70'
);

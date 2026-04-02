-- Practice-mode math questions from sat_lid_047 extension (sat_extention/sat_lid_047.tex)
-- Chapter: Area and volume of 2D/3D shapes | Topic: Area of Polygons
-- section=math, domain=geometry-trig, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_047_51 to sat_lid_047_70
-- Extends: 20260320130045_seed_sat_lid_047_practice_sat_questions.sql (which covers _1 to _50)
-- 20 questions total: 5 easy, 8 medium, 7 hard

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

-- Q1 (sat_lid_047_51): Area of square from coordinate side length
(
  'mcq',
  'math',
  'A line segment in the $xy$-plane has endpoints at $(-4, 3)$ and $(2, 7)$ and represents one side of a square. If the area of this square is $k$ square units, what is the value of $k$?',
  '[{"id":"a","text":"13"},{"id":"b","text":"52"},{"id":"c","text":"100"},{"id":"d","text":"169"}]'::jsonb,
  'b',
  'Side length using the distance formula:

$s = \sqrt{(2 - (-4))^2 + (7 - 3)^2} = \sqrt{36 + 16} = \sqrt{52}$

Area $= s^2 = 52$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_51'
),

-- Q2 (sat_lid_047_52): Area scaling with percentages
(
  'mcq',
  'math',
  'A rectangular plot has an area of 500 square meters. A second plot is created where the length is increased by 25% and the width is increased by 40%. What is the area, in square meters, of the second plot?',
  '[{"id":"a","text":"825"},{"id":"b","text":"875"},{"id":"c","text":"925"},{"id":"d","text":"1,050"}]'::jsonb,
  'b',
  'Scale factors: length $= 1.25$, width $= 1.40$.

Combined factor: $1.25 \times 1.40 = 1.75$.

New area $= 500 \times 1.75 = 875$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_52'
),

-- Q3 (sat_lid_047_53): Right triangle area with radicals
(
  'mcq',
  'math',
  'A right triangle has legs of length $4\sqrt{3}$ and $\sqrt{48}$ units. What is the area of the triangle, in square units?',
  '[{"id":"a","text":"12"},{"id":"b","text":"24"},{"id":"c","text":"$12\\sqrt{3}$"},{"id":"d","text":"$24\\sqrt{3}$"}]'::jsonb,
  'b',
  'Simplify: $\sqrt{48} = \sqrt{16 \times 3} = 4\sqrt{3}$.

Both legs are $4\sqrt{3}$.

$A = \frac{1}{2} \times 4\sqrt{3} \times 4\sqrt{3} = \frac{1}{2} \times 16 \times 3 = 24$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_53'
),

-- Q4 (sat_lid_047_54): Open-top cube surface area
(
  'mcq',
  'math',
  'A square box does not have a lid. Each interior edge of the box has a length of 12 inches. What is the total interior surface area, in square inches, of the box?',
  '[{"id":"a","text":"576"},{"id":"b","text":"720"},{"id":"c","text":"864"},{"id":"d","text":"1,728"}]'::jsonb,
  'b',
  'A box without a lid has 5 square faces (1 base + 4 walls).

Each face: $12 \times 12 = 144$ sq in.

Total: $5 \times 144 = 720$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_54'
),

-- Q5 (sat_lid_047_55): Similar polygon area ratio
(
  'mcq',
  'math',
  'The area of Polygon $A$ is 40 square units. Polygon $B$ is similar to Polygon $A$, and each side of Polygon $B$ is 4 times the length of the corresponding side of Polygon $A$. What is the area, in square units, of Polygon $B$?',
  '[{"id":"a","text":"160"},{"id":"b","text":"320"},{"id":"c","text":"640"},{"id":"d","text":"1,280"}]'::jsonb,
  'c',
  'Scale factor $r = 4$. Area ratio $= r^2 = 16$.

Area of $B = 40 \times 16 = 640$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_55'
),

-- Q6 (sat_lid_047_56): Rectangle with triangle removed
(
  'mcq',
  'math',
  'A custom sign is in the shape of a rectangle with a right triangle removed from one corner. The rectangle originally measured 20 inches by 30 inches. The removed triangle has legs of 10 inches and 12 inches. What is the area of the sign?',
  '[{"id":"a","text":"480"},{"id":"b","text":"540"},{"id":"c","text":"570"},{"id":"d","text":"600"}]'::jsonb,
  'b',
  'Rectangle area: $20 \times 30 = 600$.

Triangle area: $\frac{1}{2} \times 10 \times 12 = 60$.

Sign area: $600 - 60 = 540$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_56'
),

-- Q7 (sat_lid_047_57): Parallelogram from coordinates
(
  'mcq',
  'math',
  'A parallelogram has vertices at $(0, 0)$, $(8, 0)$, $(3, 5)$, and $(11, 5)$. What is the area of this parallelogram?',
  '[{"id":"a","text":"15"},{"id":"b","text":"24"},{"id":"c","text":"40"},{"id":"d","text":"55"}]'::jsonb,
  'c',
  'Base: horizontal segment from $(0, 0)$ to $(8, 0)$, length $= 8$.

Height: vertical distance between $y = 0$ and $y = 5$, so $h = 5$.

Area $= 8 \times 5 = 40$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_57'
),

-- Q8 (sat_lid_047_58): Equilateral triangle area from perimeter
(
  'mcq',
  'math',
  'The perimeter of an equilateral triangle is 18 units. What is the area of this triangle?',
  '[{"id":"a","text":"$9\\sqrt{3}$"},{"id":"b","text":"$18\\sqrt{3}$"},{"id":"c","text":"$27\\sqrt{3}$"},{"id":"d","text":"36"}]'::jsonb,
  'a',
  'Side length: $s = 18 / 3 = 6$.

Area $= \frac{s^2\sqrt{3}}{4} = \frac{36\sqrt{3}}{4} = 9\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_58'
),

-- Q9 (sat_lid_047_59): Trapezoid — find longer base from area
(
  'mcq',
  'math',
  'A trapezoid has a height of 8. The shorter base is 10. If the area of the trapezoid is 120, what is the length of the longer base?',
  '[{"id":"a","text":"15"},{"id":"b","text":"20"},{"id":"c","text":"25"},{"id":"d","text":"30"}]'::jsonb,
  'b',
  '$A = \frac{b_1 + b_2}{2} \times h$

$120 = \frac{10 + b_2}{2} \times 8 \implies 15 = \frac{10 + b_2}{2} \implies 30 = 10 + b_2 \implies b_2 = 20$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_59'
),

-- Q10 (sat_lid_047_60): Rhombus area from diagonal coordinates
(
  'mcq',
  'math',
  'A rhombus has diagonals that lie along the $x$- and $y$-axes. The vertices are $(5, 0)$, $(-5, 0)$, $(0, 12)$, and $(0, -12)$. What is the area of the rhombus?',
  '[{"id":"a","text":"30"},{"id":"b","text":"60"},{"id":"c","text":"120"},{"id":"d","text":"240"}]'::jsonb,
  'c',
  '$d_1 = |5 - (-5)| = 10$. $d_2 = |12 - (-12)| = 24$.

Area $= \frac{d_1 \times d_2}{2} = \frac{10 \times 24}{2} = 120$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_60'
),

-- Q11 (sat_lid_047_61): Regular hexagon area
(
  'mcq',
  'math',
  'What is the area of a regular hexagon with a side length of 4 units?',
  '[{"id":"a","text":"$12\\sqrt{3}$"},{"id":"b","text":"$24\\sqrt{3}$"},{"id":"c","text":"$36\\sqrt{3}$"},{"id":"d","text":"48"}]'::jsonb,
  'b',
  'A regular hexagon = 6 equilateral triangles.

Area of one triangle: $\frac{4^2\sqrt{3}}{4} = 4\sqrt{3}$.

Total: $6 \times 4\sqrt{3} = 24\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_61'
),

-- Q12 (sat_lid_047_62): Perimeter ratio to area ratio (squares)
(
  'mcq',
  'math',
  'The perimeter of Square $X$ is $P$. The perimeter of Square $Y$ is $3P$. What is the ratio of the area of Square $Y$ to the area of Square $X$?',
  '[{"id":"a","text":"3:1"},{"id":"b","text":"6:1"},{"id":"c","text":"9:1"},{"id":"d","text":"27:1"}]'::jsonb,
  'c',
  'Perimeter ratio $= 3:1 \implies$ side ratio $= 3:1$.

Area ratio $= 3^2 = 9:1$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_62'
),

-- Q13 (sat_lid_047_63): L-shaped polygon area
(
  'mcq',
  'math',
  'An L-shaped polygon is formed by two rectangles. Rectangle 1 is 4 by 10. Rectangle 2 is 4 by 6. If they are joined such that no area overlaps, what is the total area?',
  '[{"id":"a","text":"44"},{"id":"b","text":"56"},{"id":"c","text":"64"},{"id":"d","text":"80"}]'::jsonb,
  'c',
  'Total area $= (4 \times 10) + (4 \times 6) = 40 + 24 = 64$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_63'
),

-- Q14 (sat_lid_047_64): Right triangle area constraint — find b
(
  'spr',
  'math',
  'A right triangle has a base on the $x$-axis from $x = 0$ to $x = b$. The third vertex is at $(b, 10)$. If the area is 50, what is the value of $b$?',
  NULL,
  '10',
  'Base $= b$, height $= 10$.

$50 = \frac{1}{2} \times b \times 10 = 5b \implies b = 10$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_64'
),

-- Q15 (sat_lid_047_65): Square inscribed in circle — area
(
  'mcq',
  'math',
  'A circle has a diameter of 10. A square is inscribed in the circle such that its diagonal is equal to the diameter. What is the area of the square?',
  '[{"id":"a","text":"25"},{"id":"b","text":"50"},{"id":"c","text":"75"},{"id":"d","text":"100"}]'::jsonb,
  'b',
  'Diagonal $= 10 = s\sqrt{2} \implies s = \frac{10}{\sqrt{2}} = 5\sqrt{2}$.

Area $= s^2 = (5\sqrt{2})^2 = 50$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_65'
),

-- Q16 (sat_lid_047_66): Trapezoid area with percentage changes
(
  'mcq',
  'math',
  'A trapezoid has bases of 12 and 18, and a height of 10. If the height is increased by 10% and both bases are decreased by 10%, how does the area change?',
  '[{"id":"a","text":"It remains the same."},{"id":"b","text":"It decreases by 1%."},{"id":"c","text":"It increases by 1%."},{"id":"d","text":"It decreases by 11%."}]'::jsonb,
  'b',
  'Original area: $\frac{12 + 18}{2} \times 10 = 150$.

New dimensions: bases $= 10.8$ and $16.2$, height $= 11$.

New area: $\frac{10.8 + 16.2}{2} \times 11 = 13.5 \times 11 = 148.5$.

Change: $\frac{148.5 - 150}{150} = -1\%$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_66'
),

-- Q17 (sat_lid_047_67): Inscribed regular octagon area
(
  'mcq',
  'math',
  'A regular octagon is inscribed in a square with side length $s$. The octagon is formed by removing four congruent right-angled isosceles triangles from the corners of the square. Which expression represents the area of the octagon in terms of $s$?',
  '[{"id":"a","text":"$s^2(2\\sqrt{2} - 2)$"},{"id":"b","text":"$s^2(\\sqrt{2} - 1)$"},{"id":"c","text":"$s^2(3 - 2\\sqrt{2})$"},{"id":"d","text":"$s^2(2 - \\sqrt{2})$"}]'::jsonb,
  'a',
  'Let $x$ = leg of each removed triangle. Along one side of the square: $x + x\sqrt{2} + x = s \implies x(2 + \sqrt{2}) = s$.

$x = \frac{s}{2 + \sqrt{2}} = \frac{s(2 - \sqrt{2})}{2}$.

Total removed area: $4 \times \frac{1}{2}x^2 = 2x^2 = 2 \cdot \frac{s^2(2 - \sqrt{2})^2}{4} = \frac{s^2(6 - 4\sqrt{2})}{2} = s^2(3 - 2\sqrt{2})$.

Octagon area $= s^2 - s^2(3 - 2\sqrt{2}) = s^2(2\sqrt{2} - 2)$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_67'
),

-- Q18 (sat_lid_047_68): Wire cut into square and triangle — area ratio
(
  'mcq',
  'math',
  'A piece of wire of length $L$ is cut into two equal parts. One part is bent to form a square, and the other is bent to form an equilateral triangle. What is the ratio of the area of the square to the area of the triangle?',
  '[{"id":"a","text":"$9\\sqrt{3} : 16$"},{"id":"b","text":"$3\\sqrt{3} : 4$"},{"id":"c","text":"$16 : 9\\sqrt{3}$"},{"id":"d","text":"$4 : 3\\sqrt{3}$"}]'::jsonb,
  'b',
  'Each piece has length $L/2$.

Square: side $= L/8$, area $= L^2/64$.

Triangle: side $= L/6$, area $= \frac{(L/6)^2\sqrt{3}}{4} = \frac{L^2\sqrt{3}}{144}$.

Ratio: $\frac{L^2/64}{L^2\sqrt{3}/144} = \frac{144}{64\sqrt{3}} = \frac{9}{4\sqrt{3}} = \frac{9\sqrt{3}}{12} = \frac{3\sqrt{3}}{4}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_68'
),

-- Q19 (sat_lid_047_69): Triangle area equals base length — find k
(
  'mcq',
  'math',
  'In the $xy$-plane, a triangle has vertices at $A(-2, 4)$, $B(6, 4)$, and $C(2, k)$. If the area of triangle $ABC$ is numerically equal to the distance between points $A$ and $B$, which of the following is a possible value for $k$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'c',
  'Base $AB$ is horizontal: $|6 - (-2)| = 8$. Area must equal 8.

$8 = \frac{1}{2} \times 8 \times h \implies h = 2$.

Height $= |k - 4| = 2 \implies k = 6$ or $k = 2$.

$k = 6$ is in the options.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_69'
),

-- Q20 (sat_lid_047_70): Kite area — find vertex coordinate
(
  'mcq',
  'math',
  'A kite in the $xy$-plane has diagonals that intersect at $(3, 5)$. One diagonal lies on the line $x = 3$ and has a length of 14. The second diagonal lies on the line $y = 5$. If the area of the kite is 105 square units and one vertex of the second diagonal is at $(h, 5)$ where $h > 3$, what is the value of $h$?',
  '[{"id":"a","text":"7.5"},{"id":"b","text":"10.5"},{"id":"c","text":"13.5"},{"id":"d","text":"15.0"}]'::jsonb,
  'b',
  'Area of kite $= \frac{d_1 \times d_2}{2}$.

$105 = \frac{14 \times d_2}{2} \implies d_2 = 15$.

The horizontal diagonal is centered at $x = 3$, so each half $= 7.5$.

$h = 3 + 7.5 = 10.5$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Area of Polygons',
  'sat_lid_047_70'
);

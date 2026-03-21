-- Practice-mode math from lid_045.tex (sat_lid_045)
-- Chapter: Triangles, Pythagorean theorem, similar triangles | Topic: Special Right Triangles
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_045_N, practice module/set 0.

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
  bank_item_id,
  chapter,
  subtopic
)
VALUES
  (
  'mcq',
  'math',
  'In a $45^\\circ-45^\\circ-90^\\circ$ triangle, one of the legs has a length of $7$. What is the length of the hypotenuse?',
  '[{"id":"a","text":"7"},{"id":"b","text":"$7\\\\sqrt{2}$"},{"id":"c","text":"$7\\\\sqrt{3}$"},{"id":"d","text":"14"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In an isosceles right triangle ($45^\\circ-45^\\circ-90^\\circ$), the ratio of the sides is $x : x : x\\sqrt{2}$. The legs are equal, and the hypotenuse is the leg length multiplied by $\\sqrt{2}$.

\\textbf{Calculation and Logic:}

Given the leg length is 7, we apply the ratio directly.

Hypotenuse $= \\text{leg} × \\sqrt{2} = 7\\sqrt{2}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_045_1',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, triangle $ABC$ is a $30^\\circ-60^\\circ-90^\\circ$ triangle. If the hypotenuse $AC$ has a length of $12$, what is the length of the side $BC$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (5.196,0) node[anchor=north west]{$C$} -- (5.196,3) node[anchor=south west]{$B$} -- cycle; \\draw (4.896,0) -- (4.896,0.3) -- (5.196,0.3); \\node at (0.8,0.2) {$30^\\circ$}; \\node at (2.5,2) {12}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"6"},{"id":"b","text":"$6\\\\sqrt{2}$"},{"id":"c","text":"$6\\\\sqrt{3}$"},{"id":"d","text":"24"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In a $30^\\circ-60^\\circ-90^\\circ$ triangle, the ratios of the sides are $x : x\\sqrt{3} : 2x$. The side opposite the $30^\\circ$ angle is the shortest side ($x$), and the hypotenuse is exactly twice that length ($2x$).

\\textbf{Calculation and Logic:}

The hypotenuse is $2x = 12$.

The side $BC$ is opposite the $30^\\circ$ angle, which is the shortest side ($x$).

$x = 12 / 2 = 6$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_2',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'spr',
  'math',
  'A square has a diagonal of length $10\\sqrt{2}$. What is the area of the square?',
  NULL,
  '100',
  '\\textbf{Conceptual Explanation:}

The diagonal of a square divides it into two $45^\\circ-45^\\circ-90^\\circ$ triangles. The side of the square represents the leg of these triangles, and the diagonal represents the hypotenuse.

\\textbf{Calculation and Logic:}

The relationship for a square is $\\text{diagonal} = \\text{side} × \\sqrt{2}$.

$10\\sqrt{2} = \\text{side} × \\sqrt{2}$.

Dividing both sides by $\\sqrt{2}$, we find $\\text{side} = 10$.

The area of the square is $\\text{side}^2 = 10^2 = 100$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_3',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In a $30^\\circ-60^\\circ-90^\\circ$ triangle, the side opposite the $60^\\circ$ angle has a length of $9\\sqrt{3}$. What is the perimeter of the triangle?',
  '[{"id":"a","text":"27"},{"id":"b","text":"$18 + 9\\\\sqrt{3}$"},{"id":"c","text":"$27 + 9\\\\sqrt{3}$"},{"id":"d","text":"$18\\\\sqrt{3} + 9$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

We use the ratio $x : x\\sqrt{3} : 2x$. We are given the middle side ($x\\sqrt{3}$), which allows us to find the shortest side ($x$) and the hypotenuse ($2x$).

\\textbf{Calculation and Logic:}

1. Find $x$: $x\\sqrt{3} = 9\\sqrt{3} → x = 9$.

2. Find hypotenuse: $2x = 2(9) = 18$.

3. Sum the sides for perimeter: $9 + 18 + 9\\sqrt{3} = 27 + 9\\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_4',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle XYZ$ is an equilateral triangle with side length 10. What is the length of the altitude $h$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) -- (4,0) -- (2,3.46) -- cycle; \\draw[dashed] (2,3.46) -- (2,0) node[midway, right]{$h$}; \\draw (2,0) -- (2.3,0) -- (2.3,0.3) -- (2,0.3); \\node at (1,-0.4) {5}; \\node at (3,-0.4) {5}; \\node at (0.8, 1.8) {10}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"5"},{"id":"b","text":"$5\\\\sqrt{2}$"},{"id":"c","text":"$5\\\\sqrt{3}$"},{"id":"d","text":"$10\\\\sqrt{3}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

An altitude in an equilateral triangle bisects the base and the vertex angle, creating two $30^\\circ-60^\\circ-90^\\circ$ triangles. The altitude is the side opposite the $60^\\circ$ angle.

\\textbf{Calculation and Logic:}

The base of the smaller right triangle is $10/2 = 5$.

In a $30^\\circ-60^\\circ-90^\\circ$ triangle, the side opposite $60^\\circ$ is $x\\sqrt{3}$, where $x$ is the shortest side.

Since $x = 5$, the altitude $h = 5\\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_5',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'spr',
  'math',
  'In a $45^\\circ-45^\\circ-90^\\circ$ triangle, the hypotenuse has a length of $8$. What is the length of one of the legs?',
  NULL,
  '$4\\sqrt{2',
  '\\textbf{Conceptual Explanation:}

In this triangle, the hypotenuse is $\\sqrt{2}$ times the length of a leg. To find the leg, we must divide the hypotenuse by $\\sqrt{2}$ and rationalize the denominator.

\\textbf{Calculation and Logic:}

$\\text{Leg} = (8)/(\\sqrt{2)}$.

To rationalize: $(8)/(\\sqrt{2)} × \\frac{\\sqrt{2}}{\\sqrt{2}} = \\frac{8\\sqrt{2}}{2} = 4\\sqrt{2}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_6',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, what is the value of $x$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) -- (4,0) node[midway, below]{$x$} -- (4,4) node[midway, right]{$x$} -- cycle; \\draw (3.7,0) -- (3.7,0.3) -- (4,0.3); \\node at (1.8, 2.5) {$12\\sqrt{2}$}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"6"},{"id":"b","text":"12"},{"id":"c","text":"$12\\\\sqrt{2}$"},{"id":"d","text":"24"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Since the legs are both labeled $x$, this is an isosceles right triangle ($45^\\circ-45^\\circ-90^\\circ$). The hypotenuse is $x\\sqrt{2}$.

\\textbf{Calculation and Logic:}

$x\\sqrt{2} = 12\\sqrt{2}$.

Dividing both sides by $\\sqrt{2}$ gives $x = 12$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_7',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'A $30^\\circ-60^\\circ-90^\\circ$ triangle and a $45^\\circ-45^\\circ-90^\\circ$ triangle share a side of length 6. If this side is the side opposite the $60^\\circ$ angle in the first triangle and the hypotenuse in the second triangle, what is the length of the leg of the $45^\\circ-45^\\circ-90^\\circ$ triangle?',
  '[{"id":"a","text":"$2\\\\sqrt{3}$"},{"id":"b","text":"3"},{"id":"c","text":"$3\\\\sqrt{2}$"},{"id":"d","text":"$6\\\\sqrt{2}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The question provides a shared side but specifically asks for a component of the second triangle. We only need to focus on the $45^\\circ-45^\\circ-90^\\circ$ triangle where the hypotenuse is 6.

\\textbf{Calculation and Logic:}

For a $45^\\circ-45^\\circ-90^\\circ$ triangle: $\\text{hypotenuse} = \\text{leg} × \\sqrt{2}$.

$6 = \\text{leg} × \\sqrt{2}$.

$\\text{Leg} = (6)/(\\sqrt{2)} = \\frac{6\\sqrt{2}}{2} = 3\\sqrt{2}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_8',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, what is the length of segment $BD$? \\begin{center} \\begin{tikzpicture}[scale=0.9] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (4,0) node[anchor=north west]{$C$} -- (4,2.31) node[anchor=south west]{$B$} -- cycle; \\draw[thick] (4,2.31) -- (6.31,0) node[anchor=north west]{$D$} -- (4,0); \\draw (3.7,0) -- (3.7,0.3) -- (4,0.3); \\node at (0.8,0.2) {$30^\\circ$}; \\node at (5.8,0.2) {$45^\\circ$}; \\node at (2, -0.4) {$6\\sqrt{3}$}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"6"},{"id":"b","text":"$6\\\\sqrt{2}$"},{"id":"c","text":"$6\\\\sqrt{3}$"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This figure consists of two right triangles sharing a common side, $BC$. We first use the $30^\\circ-60^\\circ-90^\\circ$ triangle to find the height $BC$, and then use that height in the $45^\\circ-45^\\circ-90^\\circ$ triangle to find the hypotenuse $BD$.

\\textbf{Calculation and Logic:}

In $\\triangle ABC$, $AC$ is the side opposite the $60^\\circ$ angle ($x\\sqrt{3}$).

$x\\sqrt{3} = 6\\sqrt{3} → x = 6$. So, $BC = 6$.

In $\\triangle BCD$, $BC$ is a leg of an isosceles right triangle.

The hypotenuse $BD = \\text{leg} × \\sqrt{2} = 6\\sqrt{2}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_9',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'The area of a $45^\\circ-45^\\circ-90^\\circ$ triangle is 18. What is the length of the hypotenuse?',
  '[{"id":"a","text":"6"},{"id":"b","text":"$6\\\\sqrt{2}$"},{"id":"c","text":"12"},{"id":"d","text":"$12\\\\sqrt{2}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The area of a right triangle is $(1)/(2) × \\text{base} × \\text{height}$. In this special triangle, the base and height (the legs) are equal ($x$).

\\textbf{Calculation and Logic:}

Area $= (1)/(2) x^2 = 18 → x^2 = 36 → x = 6$.

The legs are 6.

The hypotenuse is $x\\sqrt{2} = 6\\sqrt{2}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_10',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'spr',
  'math',
  'In a $30^\\circ-60^\\circ-90^\\circ$ triangle, the shortest side has a length of $\\sqrt{3}$. What is the area of the triangle?',
  NULL,
  '$1.5\\sqrt{3',
  '\\textbf{Conceptual Explanation:}

We identify the shortest side as $x$. Using our ratios, we find the other leg ($x\\sqrt{3}$) and then calculate the area.

\\textbf{Calculation and Logic:}

Shortest side ($x$) $= \\sqrt{3}$.

Longer leg ($x\\sqrt{3}$) $= \\sqrt{3} × \\sqrt{3} = 3$.

Area $= (1)/(2) × \\text{base} × \\text{height} = (1)/(2) × \\sqrt{3} × 3 = \\frac{3\\sqrt{3}}{2}$ (or $1.5\\sqrt{3}$).',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_11',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'What is the perimeter of a square with a diagonal of length 8?',
  '[{"id":"a","text":"16"},{"id":"b","text":"$16\\\\sqrt{2}$"},{"id":"c","text":"32"},{"id":"d","text":"$32\\\\sqrt{2}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A square''s diagonal creates two $45^\\circ-45^\\circ-90^\\circ$ triangles. We find the side length by dividing the diagonal by $\\sqrt{2}$.

\\textbf{Calculation and Logic:}

Side $= 8 / \\sqrt{2} = 4\\sqrt{2}$.

Perimeter $= 4 × \\text{side} = 4 × 4\\sqrt{2} = 16\\sqrt{2}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_12',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'If the hypotenuse of a $30^\\circ-60^\\circ-90^\\circ$ triangle is $x$, what is the length of the side opposite the $60^\\circ$ angle?',
  '[{"id":"a","text":"$x/2$"},{"id":"b","text":"$x\\\\sqrt{2}/2$"},{"id":"c","text":"$x\\\\sqrt{3}/2$"},{"id":"d","text":"$x\\\\sqrt{3}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This tests the ability to manipulate the ratios using a variable. If the hypotenuse ($2n$) is $x$, then the shortest side ($n$) is $x/2$.

\\textbf{Calculation and Logic:}

Hypotenuse $= 2n = x → n = x/2$.

The side opposite $60^\\circ$ is $n\\sqrt{3} = (x/2)\\sqrt{3} = \\frac{x\\sqrt{3}}{2}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_045_13',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, a line segment starts at the origin $(0,0)$ and ends at a point $P$ in the first quadrant. If the segment makes a $30^\\circ$ angle with the $x$-axis and has a length of 10, what are the coordinates of point $P$?',
  '[{"id":"a","text":"$(5, 5\\\\sqrt{3})$"},{"id":"b","text":"$(5\\\\sqrt{3}, 5)$"},{"id":"c","text":"$(5, 5)$"},{"id":"d","text":"$(10\\\\sqrt{3}, 10)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The line segment acts as the hypotenuse of a $30^\\circ-60^\\circ-90^\\circ$ triangle. The $x$-coordinate is the side adjacent to the $30^\\circ$ angle (longer leg), and the $y$-coordinate is the side opposite the $30^\\circ$ angle (shortest leg).

\\textbf{Calculation and Logic:}

Hypotenuse $= 10$, so the shortest leg ($y$) is $10/2 = 5$.

The longer leg ($x$) is the shortest leg times $\\sqrt{3}$, which is $5\\sqrt{3}$.

Point $P$ is $(5\\sqrt{3}, 5)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_14',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'spr',
  'math',
  'A regular hexagon is inscribed in a circle with a radius of 6. What is the area of the hexagon?',
  NULL,
  '$54\\sqrt{3',
  '\\textbf{Conceptual Explanation:}

A regular hexagon can be divided into six equilateral triangles. Each triangle has a side length equal to the radius of the circle. We can find the area of one equilateral triangle by splitting it into two $30^\\circ-60^\\circ-90^\\circ$ triangles and then multiplying by 6.

\\textbf{Calculation and Logic:}

Side of equilateral triangle $= 6$.

Half-base $= 3$; Altitude $= 3\\sqrt{3}$.

Area of one triangle $= (1)/(2) × 6 × 3\\sqrt{3} = 9\\sqrt{3}$.

Total area of hexagon $= 6 × 9\\sqrt{3} = 54\\sqrt{3}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_15',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC$ is a $45^\\circ-45^\\circ-90^\\circ$ triangle and $\\triangle BCD$ is a $30^\\circ-60^\\circ-90^\\circ$ triangle. If $AB = 4$, what is the length of $CD$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (3,0) node[anchor=north]{$C$} -- (3,3) node[anchor=south east]{$B$} -- cycle; \\draw[thick] (3,3) -- (8.2,0) node[anchor=north west]{$D$} -- (3,0); \\draw (2.7,0) -- (2.7,0.3) -- (3,0.3); \\node at (1.5,-0.4) {4}; \\node at (7, 0.3) {$30^\\circ$}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"4"},{"id":"b","text":"$4\\\\sqrt{2}$"},{"id":"c","text":"$4\\\\sqrt{3}$"},{"id":"d","text":"8"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

First, identify side $BC$ from the $45^\\circ-45^\\circ-90^\\circ$ triangle. Since $AB$ and $BC$ are legs, $BC = 4$. Then, use $BC$ as the shortest leg of the $30^\\circ-60^\\circ-90^\\circ$ triangle to find the longer leg $CD$.

\\textbf{Calculation and Logic:}

In $\\triangle ABC$, $BC = AB = 4$.

In $\\triangle BCD$, $\\angle D = 30^\\circ$, so $BC$ is the shortest side ($x = 4$).

Side $CD$ is opposite the $60^\\circ$ angle, which is $x\\sqrt{3}$.

$CD = 4\\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_16',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'What is the length of the altitude of an equilateral triangle with a perimeter of 18?',
  '[{"id":"a","text":"3"},{"id":"b","text":"$3\\\\sqrt{2}$"},{"id":"c","text":"$3\\\\sqrt{3}$"},{"id":"d","text":"9"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

First find the side length from the perimeter. Then, use the $30^\\circ-60^\\circ-90^\\circ$ relationship where the altitude is the longer leg of the triangle formed by bisecting the equilateral triangle.

\\textbf{Calculation and Logic:}

Side length $= 18 / 3 = 6$.

The shortest side of the $30^\\circ-60^\\circ-90^\\circ$ triangle is $6 / 2 = 3$.

The altitude is $3\\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_17',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'A right triangle has a hypotenuse of 20 and one angle of $60^\\circ$. What is the area of the triangle?',
  '[{"id":"a","text":"50"},{"id":"b","text":"$50\\\\sqrt{2}$"},{"id":"c","text":"$50\\\\sqrt{3}$"},{"id":"d","text":"$100\\\\sqrt{3}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This is a $30^\\circ-60^\\circ-90^\\circ$ triangle. We use the hypotenuse to find both legs, which then serve as the base and height for the area formula.

\\textbf{Calculation and Logic:}

Shortest leg ($x$) $= 20 / 2 = 10$.

Longer leg ($x\\sqrt{3}$) $= 10\\sqrt{3}$.

Area $= (1)/(2) × 10 × 10\\sqrt{3} = 50\\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_18',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'If a $45^\\circ-45^\\circ-90^\\circ$ triangle has an area of $a$, what is the length of its hypotenuse in terms of $a$?',
  '[{"id":"a","text":"$\\\\sqrt{2a}$"},{"id":"b","text":"$2\\\\sqrt{a}$"},{"id":"c","text":"$\\\\sqrt{a}$"},{"id":"d","text":"$2a$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We relate the area to the leg length $x$, then express the hypotenuse ($x\\sqrt{2}$) in terms of that area.

\\textbf{Calculation and Logic:}

Area $a = (1)/(2)x^2 → x^2 = 2a → x = \\sqrt{2a}$.

Hypotenuse $= x\\sqrt{2} = \\sqrt{2a} × \\sqrt{2} = \\sqrt{4a} = 2\\sqrt{a}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_19',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In a $30^\\circ-60^\\circ-90^\\circ$ triangle, the ratio of the longer leg to the hypotenuse is:',
  '[{"id":"a","text":"$1 : 2$"},{"id":"b","text":"$\\\\sqrt{3} : 2$"},{"id":"c","text":"$1 : \\\\sqrt{3}$"},{"id":"d","text":"$\\\\sqrt{2} : 2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This checks pure knowledge of the ratios $x : x\\sqrt{3} : 2x$.

\\textbf{Calculation and Logic:}

Longer leg $= x\\sqrt{3}$.

Hypotenuse $= 2x$.

Ratio $= x\\sqrt{3} / 2x = \\sqrt{3} / 2$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_20',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'spr',
  'math',
  'A square is inscribed in a circle. If the area of the square is 50, what is the radius of the circle?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

The diagonal of the inscribed square is the diameter of the circle. The diagonal forms a $45^\\circ-45^\\circ-90^\\circ$ triangle with the sides of the square.

\\textbf{Calculation and Logic:}

Area of square $= s^2 = 50 → s = \\sqrt{50} = 5\\sqrt{2}$.

Diagonal $= s\\sqrt{2} = 5\\sqrt{2} × \\sqrt{2} = 10$.

Radius $= \\text{Diagonal} / 2 = 5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_21',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'The longer leg of a $30^\\circ-60^\\circ-90^\\circ$ triangle has a length of 12. What is the length of the shortest side?',
  '[{"id":"a","text":"6"},{"id":"b","text":"$6\\\\sqrt{3}$"},{"id":"c","text":"$4\\\\sqrt{3}$"},{"id":"d","text":"$12\\\\sqrt{3}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To find the shortest side $x$ from the longer leg ($x\\sqrt{3}$), we must divide by $\\sqrt{3}$ and rationalize.

\\textbf{Calculation and Logic:}

$x\\sqrt{3} = 12 → x = 12 / \\sqrt{3}$.

Rationalizing: $(12)/(\\sqrt{3)} × \\frac{\\sqrt{3}}{\\sqrt{3}} = \\frac{12\\sqrt{3}}{3} = 4\\sqrt{3}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_22',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'A $45^\\circ-45^\\circ-90^\\circ$ triangle has a hypotenuse of $10\\sqrt{6}$. What is the length of a leg?',
  '[{"id":"a","text":"$10\\\\sqrt{3}$"},{"id":"b","text":"10"},{"id":"c","text":"$5\\\\sqrt{6}$"},{"id":"d","text":"20"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The hypotenuse is leg $× \\sqrt{2}$. Divide by $\\sqrt{2}$ to find the leg.

\\textbf{Calculation and Logic:}

Leg $= 10\\sqrt{6} / \\sqrt{2} = 10\\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_23',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'An isosceles right triangle is removed from the corner of a square with side length 10. If the legs of the triangle removed are 4, what is the perimeter of the remaining shape?',
  '[{"id":"a","text":"32"},{"id":"b","text":"$32 + 4\\\\sqrt{2}$"},{"id":"c","text":"$40 + 4\\\\sqrt{2}$"},{"id":"d","text":"$36 + 4\\\\sqrt{2}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The original perimeter was 40. Removing the corner replaces two legs of length 4 with one hypotenuse of length $4\\sqrt{2}$.

\\textbf{Calculation and Logic:}

New perimeter $= (10 + 10 + 6 + 6) + \\text{hypotenuse}$.

New perimeter $= 32 + 4\\sqrt{2}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_24',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'Which of the following side lengths could represent a $30^\\circ-60^\\circ-90^\\circ$ triangle?',
  '[{"id":"a","text":"$2, 2, 2\\\\sqrt{2}$"},{"id":"b","text":"$3, 3\\\\sqrt{3}, 6$"},{"id":"c","text":"$5, 5, 5$"},{"id":"d","text":"$1, \\\\sqrt{2}, \\\\sqrt{3}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Check for the $x : x\\sqrt{3} : 2x$ ratio.

\\textbf{Calculation and Logic:}

Choice B follows this: $3 : 3\\sqrt{3} : 2(3)$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_045_25',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, triangle $ABC$ is an isosceles right triangle with hypotenuse $AC$. If the area of the triangle is 50, what is the length of $AC$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north east]{$B$} -- (4,0) node[anchor=north west]{$C$} -- (0,4) node[anchor=south east]{$A$} -- cycle; \\draw (0,0) -- (0.3,0) -- (0.3,0.3) -- (0,0.3); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"10"},{"id":"b","text":"$10\\\\sqrt{2}$"},{"id":"c","text":"20"},{"id":"d","text":"$20\\\\sqrt{2}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In an isosceles right triangle, the legs are equal. We use the area formula to find the leg length and then apply the $45^\\circ-45^\\circ-90^\\circ$ ratio to find the hypotenuse.

\\textbf{Calculation and Logic:}

Area $= (1)/(2)x^2 = 50 → x^2 = 100 → x = 10$.

The legs are 10.

The hypotenuse $AC$ is $x\\sqrt{2} = 10\\sqrt{2}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_26',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'spr',
  'math',
  'A $30^\\circ-60^\\circ-90^\\circ$ triangle is inscribed in a circle with a diameter of 16. What is the length of the side opposite the $60^\\circ$ angle?',
  NULL,
  '$8\\sqrt{3',
  '\\textbf{Conceptual Explanation:}

Any triangle inscribed in a circle where one side is the diameter must be a right triangle. Therefore, the diameter of the circle is the hypotenuse of the $30^\\circ-60^\\circ-90^\\circ$ triangle.

\\textbf{Calculation and Logic:}

Hypotenuse $= 16$.

Shortest side ($x$) $= 16 / 2 = 8$.

Side opposite $60^\\circ$ ($x\\sqrt{3}$) $= 8\\sqrt{3}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_27',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'What is the area of a square whose diagonal is $s$?',
  '[{"id":"a","text":"$s^2$"},{"id":"b","text":"$s^2/2$"},{"id":"c","text":"$s^2/4$"},{"id":"d","text":"$s\\\\sqrt{2}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The diagonal $s$ forms a $45^\\circ-45^\\circ-90^\\circ$ triangle with the sides. We find the side length in terms of $s$ and then square it.

\\textbf{Calculation and Logic:}

$\\text{Side} = s / \\sqrt{2}$.

$\\text{Area} = (\\text{side})^2 = (s / \\sqrt{2})^2 = s^2 / 2$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_28',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In a $30^\\circ-60^\\circ-90^\\circ$ triangle, if the longer leg is 3, what is the hypotenuse?',
  '[{"id":"a","text":"$2\\\\sqrt{3}$"},{"id":"b","text":"$3\\\\sqrt{3}$"},{"id":"c","text":"6"},{"id":"d","text":"$6\\\\sqrt{3}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We start with the longer leg ($x\\sqrt{3}$) and solve for $x$ (the shortest side), then double it for the hypotenuse.

\\textbf{Calculation and Logic:}

$x\\sqrt{3} = 3 → x = 3 / \\sqrt{3} = \\sqrt{3}$.

Hypotenuse $= 2x = 2\\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_29',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'The figure below shows a cube with side length 4. What is the length of the space diagonal $AG$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) -- (3,0) -- (3,3) -- (0,3) -- cycle; \\draw[thick] (3,0) -- (4,1) -- (4,4) -- (3,3); \\draw[thick] (0,3) -- (1,4) -- (4,4); \\draw[dashed] (0,0) -- (1,1) -- (1,4); \\draw[dashed] (1,1) -- (4,1); \\draw[ultra thick, red] (0,3) -- (4,1); \\node at (-0.2,3.2) {$A$}; \\node at (4.2,0.8) {$G$}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$4\\\\sqrt{2}$"},{"id":"b","text":"$4\\\\sqrt{3}$"},{"id":"c","text":"8"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To find the space diagonal, we first find the diagonal of the base (a $45^\\circ-45^\\circ-90^\\circ$ triangle) and then use that as a leg in a second right triangle where the other leg is the cube''s height.

\\textbf{Calculation and Logic:}

Base diagonal $= 4\\sqrt{2}$.

Space diagonal $= \\sqrt{(4\\sqrt{2})^2 + 4^2} = \\sqrt{32 + 16} = \\sqrt{48}$.

$\\sqrt{48} = 4\\sqrt{3}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_30',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'An altitude of an equilateral triangle has length $6\\sqrt{3}$. What is the perimeter of the triangle?',
  '[{"id":"a","text":"18"},{"id":"b","text":"36"},{"id":"c","text":"$18\\\\sqrt{3}$"},{"id":"d","text":"54"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The altitude is the $x\\sqrt{3}$ side of a $30^\\circ-60^\\circ-90^\\circ$ triangle.

\\textbf{Calculation and Logic:}

$x\\sqrt{3} = 6\\sqrt{3} → x = 6$.

The side of the equilateral triangle is $2x = 12$.

Perimeter $= 3 × 12 = 36$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_31',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In a $45^\\circ-45^\\circ-90^\\circ$ triangle, the legs are $x$. What is the ratio of the area to the square of the hypotenuse?',
  '[{"id":"a","text":"$1 : 2$"},{"id":"b","text":"$1 : 4$"},{"id":"c","text":"$1 : \\\\sqrt{2}$"},{"id":"d","text":"$2 : 1$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Calculate the area and the square of the hypotenuse in terms of $x$, then compare.

\\textbf{Calculation and Logic:}

Area $= (1)/(2)x^2$.

Hypotenuse $= x\\sqrt{2} → (\\text{hypotenuse})^2 = 2x^2$.

Ratio $= ((1)/(2)x^2) / (2x^2) = 1/4$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_045_32',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'spr',
  'math',
  'Two $30^\\circ-60^\\circ-90^\\circ$ triangles are joined along their longer legs to form an isosceles triangle. If the shared leg has length 12, what is the perimeter of the resulting isosceles triangle?',
  NULL,
  '$24\\sqrt{3',
  '\\textbf{Conceptual Explanation:}

Joining them along the longer leg means the height of the new triangle is 12. The base of the new triangle consists of the two shorter legs, and the two hypotenuses become the equal sides of the isosceles triangle.

\\textbf{Calculation and Logic:}

Longer leg $= x\\sqrt{3} = 12 → x = 12/\\sqrt{3} = 4\\sqrt{3}$.

Hypotenuse $= 2x = 8\\sqrt{3}$.

Perimeter $= \\text{Base} + 2(\\text{hypotenuse}) = (4\\sqrt{3} + 4\\sqrt{3}) + (8\\sqrt{3} + 8\\sqrt{3}) = 24\\sqrt{3}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_33',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'A right triangle has sides in the ratio $1 : \\sqrt{3} : 2$. If the area is $8\\sqrt{3}$, what is the length of the hypotenuse?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"$4\\\\sqrt{3}$"},{"id":"d","text":"16"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The ratio identifies this as a $30^\\circ-60^\\circ-90^\\circ$ triangle. Use the area to solve for $x$.

\\textbf{Calculation and Logic:}

Area $= (1)/(2)(x)(x\\sqrt{3}) = 8\\sqrt{3}$.

$(1)/(2)x^2 = 8 → x^2 = 16 → x = 4$.

Hypotenuse $= 2x = 8$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_34',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $ABCD$ is a rectangle. If $AB = 5$ and diagonal $AC$ makes a $30^\\circ$ angle with $AD$, what is the area of the rectangle? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (5,0) node[anchor=north west]{$D$} -- (5,3) node[anchor=south west]{$C$} -- (0,3) node[anchor=south east]{$B$} -- cycle; \\draw[thick] (0,0) -- (5,3); \\node at (0.8, 0.2) {$30^\\circ$}; \\node at (-0.4, 1.5) {5}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"25"},{"id":"b","text":"$25\\\\sqrt{2}$"},{"id":"c","text":"$25\\\\sqrt{3}$"},{"id":"d","text":"50"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The diagonal creates a $30^\\circ-60^\\circ-90^\\circ$ triangle. Since $AB=5$, the side $CD$ is also 5, which is the shortest leg (opposite the $30^\\circ$ angle).

\\textbf{Calculation and Logic:}

Shortest side $CD = 5$.

Longer side $AD = 5\\sqrt{3}$.

Area $= 5 × 5\\sqrt{3} = 25\\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_35',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'A $45^\\circ-45^\\circ-90^\\circ$ triangle is cut from a square paper of side length 12 by connecting the midpoints of two adjacent sides. What is the length of the cut?',
  '[{"id":"a","text":"6"},{"id":"b","text":"$6\\\\sqrt{2}$"},{"id":"c","text":"$6\\\\sqrt{3}$"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The cut forms the hypotenuse of a right triangle where the legs are half the side of the square.

\\textbf{Calculation and Logic:}

Legs $= 12/2 = 6$.

Cut (hypotenuse) $= 6\\sqrt{2}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_36',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In a $30^\\circ-60^\\circ-90^\\circ$ triangle, what is the sine of the $60^\\circ$ angle?',
  '[{"id":"a","text":"$1/2$"},{"id":"b","text":"$\\\\sqrt{2}/2$"},{"id":"c","text":"$\\\\sqrt{3}/2$"},{"id":"d","text":"1"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Use the ratio of the side opposite the angle to the hypotenuse.

\\textbf{Calculation and Logic:}

$\\text{Opposite} = x\\sqrt{3}$, $\\text{Hypotenuse} = 2x$.

$\\sin 60^\\circ = x\\sqrt{3} / 2x = \\sqrt{3}/2$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_37',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'The height of an equilateral triangle is 10. What is the length of one side?',
  '[{"id":"a","text":"$5\\\\sqrt{3}$"},{"id":"b","text":"$10\\\\sqrt{3}$"},{"id":"c","text":"$\\\\frac{20\\\\sqrt{3}}{3}$"},{"id":"d","text":"20"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The height is the longer leg of the $30^\\circ-60^\\circ-90^\\circ$ triangle.

\\textbf{Calculation and Logic:}

$x\\sqrt{3} = 10 → x = 10/\\sqrt{3} = \\frac{10\\sqrt{3}}{3}$.

Side $= 2x = \\frac{20\\sqrt{3}}{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_38',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'spr',
  'math',
  'A right triangle has a $45^\\circ$ angle and a leg of length $\\sqrt{8}$. What is the length of the hypotenuse?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

Multiply the leg by $\\sqrt{2}$.

\\textbf{Calculation and Logic:}

Hypotenuse $= \\sqrt{8} × \\sqrt{2} = \\sqrt{16} = 4$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_39',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'A circle is circumscribed around a square with side length $s$. What is the area of the circle?',
  '[{"id":"a","text":"$\\\\pi s^2$"},{"id":"b","text":"$\\\\pi s^2 / 2$"},{"id":"c","text":"$\\\\pi s^2 / 4$"},{"id":"d","text":"$2\\\\pi s^2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The diagonal of the square is the diameter of the circle.

\\textbf{Calculation and Logic:}

$\\text{Diagonal} = s\\sqrt{2}$.

$\\text{Radius} = (s\\sqrt{2})/2$.

Area $= \\pi r^2 = \\pi ((s^2 \\cdot 2)/(4)) = \\pi s^2 / 2$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_40',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'Which of the following triples could be the sides of a $45^\\circ-45^\\circ-90^\\circ$ triangle?',
  '[{"id":"a","text":"$1, 1, 2$"},{"id":"b","text":"$\\\\sqrt{2}, \\\\sqrt{2}, 2$"},{"id":"c","text":"$2, 2, 4$"},{"id":"d","text":"$1, \\\\sqrt{3}, 2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The ratio must be $x : x : x\\sqrt{2}$.

\\textbf{Calculation and Logic:}

Check Choice B: $\\sqrt{2} × \\sqrt{2} = 2$. This fits the ratio.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_41',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'What is the area of a $30^\\circ-60^\\circ-90^\\circ$ triangle with a hypotenuse of 4?',
  '[{"id":"a","text":"$2\\\\sqrt{3}$"},{"id":"b","text":"$4\\\\sqrt{3}$"},{"id":"c","text":"8"},{"id":"d","text":"$8\\\\sqrt{3}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Find both legs and use the area formula.

\\textbf{Calculation and Logic:}

Legs are 2 and $2\\sqrt{3}$.

Area $= (1)/(2)(2)(2\\sqrt{3}) = 2\\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_42',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'An equilateral triangle and a square have the same perimeter. What is the ratio of the height of the triangle to the side of the square?',
  '[{"id":"a","text":"$2\\\\sqrt{3} : 3$"},{"id":"b","text":"$\\\\sqrt{3} : 2$"},{"id":"c","text":"$3\\\\sqrt{3} : 4$"},{"id":"d","text":"$1 : 1$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Let perimeter $= 12x$.

\\textbf{Calculation and Logic:}

Triangle side $= 4x$, Triangle height $= (4x/2)\\sqrt{3} = 2x\\sqrt{3}$.

Square side $= 3x$.

Ratio $= 2x\\sqrt{3} / 3x = 2\\sqrt{3} : 3$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_43',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'In a $45^\\circ-45^\\circ-90^\\circ$ triangle, what is the tangent of one of the acute angles?',
  '[{"id":"a","text":"$1/2$"},{"id":"b","text":"$\\\\sqrt{2}/2$"},{"id":"c","text":"1"},{"id":"d","text":"$\\\\sqrt{2}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

$\\tan \\theta = \\text{opposite} / \\text{adjacent}$.

\\textbf{Calculation and Logic:}

Since legs are equal ($x$), $\\tan 45^\\circ = x/x = 1$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_045_44',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'A right triangle has angles of $30^\\circ$ and $60^\\circ$. If the perimeter is $3 + \\sqrt{3}$, what is the shortest side?',
  '[{"id":"a","text":"1"},{"id":"b","text":"$\\\\sqrt{3}$"},{"id":"c","text":"2"},{"id":"d","text":"$1.5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Set the perimeter in terms of $x$.

\\textbf{Calculation and Logic:}

Perimeter $= x + x\\sqrt{3} + 2x = 3x + x\\sqrt{3} = x(3 + \\sqrt{3})$.

Given $x(3 + \\sqrt{3}) = 3 + \\sqrt{3}$, it follows $x = 1$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_45',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'What is the area of a square whose perimeter is $8\\sqrt{2}$?',
  '[{"id":"a","text":"8"},{"id":"b","text":"$8\\\\sqrt{2}$"},{"id":"c","text":"16"},{"id":"d","text":"32"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Find the side length first.

\\textbf{Calculation and Logic:}

Side $= 8\\sqrt{2} / 4 = 2\\sqrt{2}$.

Area $= (2\\sqrt{2})^2 = 4 × 2 = 8$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_46',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'A $30^\\circ-60^\\circ-90^\\circ$ triangle''s shortest side is $s$. A square is built on the hypotenuse. What is the area of the square?',
  '[{"id":"a","text":"$s^2$"},{"id":"b","text":"$2s^2$"},{"id":"c","text":"$3s^2$"},{"id":"d","text":"$4s^2$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Find the hypotenuse in terms of $s$.

\\textbf{Calculation and Logic:}

Hypotenuse $= 2s$.

Area of square $= (2s)^2 = 4s^2$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_47',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'spr',
  'math',
  'In an isosceles right triangle, the sum of the legs is 12. What is the length of the hypotenuse?',
  NULL,
  '$6\\sqrt{2',
  '\\textbf{Conceptual Explanation:}

The legs are equal.

\\textbf{Calculation and Logic:}

$x + x = 12 → x = 6$.

Hypotenuse $= 6\\sqrt{2}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_48',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'mcq',
  'math',
  'The diagonal of a rectangle is 20. If it makes a $60^\\circ$ angle with the shorter side, what is the length of the shorter side?',
  '[{"id":"a","text":"10"},{"id":"b","text":"$10\\\\sqrt{3}$"},{"id":"c","text":"$20\\\\sqrt{3}$"},{"id":"d","text":"40"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The diagonal and shorter side form a $30^\\circ-60^\\circ-90^\\circ$ triangle. The shorter side is adjacent to the $60^\\circ$ angle.

\\textbf{Calculation and Logic:}

Angle with the shorter side is $60^\\circ$, so the shorter side is opposite the $30^\\circ$ angle.

Shortest side $= 20 / 2 = 10$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_045_49',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
),
  (
  'spr',
  'math',
  'A $30^\\circ-60^\\circ-90^\\circ$ triangle has an area of $18\\sqrt{3}$. What is the length of the shortest side?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

Use the area to solve for $x$.

\\textbf{Calculation and Logic:}

Area $= (1)/(2)(x)(x\\sqrt{3}) = 18\\sqrt{3}$.

$(1)/(2)x^2 = 18 → x^2 = 36 → x = 6$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_045_50',
  'Triangles, Pythagorean theorem, similar triangles',
  'Special Right Triangles'
)
ON CONFLICT (bank_item_id) DO NOTHING;

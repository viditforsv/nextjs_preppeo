-- Practice-mode math from lid_047.tex (sat_lid_047)
-- Chapter: Area and volume of 2D/3D shapes | Topic: Area of Polygons
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_047_N, practice module/set 0.

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
  'The side length of a square is 55 centimeters (cm). What is the area, in $\\text{cm}^2$, of the square?',
  '[{"id":"a","text":"110"},{"id":"b","text":"220"},{"id":"c","text":"3,025"},{"id":"d","text":"12,100"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The area of a square is calculated by squaring the length of its side. The formula is $\\text{Area} = s^2$, where $s$ represents the side length.

\\textbf{Calculation and Logic:}

Identify the given side length, which is $s = 55 \\text{ cm}$. Apply the area formula: $\\text{Area} = 55^2$. Performing the multiplication $55 × 55$ results in 3,025. Therefore, the area of the square is 3,025 square centimeters.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_047_1',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'Square A has side lengths that are 166 times the side lengths of square B. The area of square A is $k$ times the area of square B. What is the value of $k$?',
  NULL,
  '27556',
  '\\textbf{Conceptual Explanation:}

In geometry, when the linear dimensions (like side lengths) of a shape are scaled by a factor of $x$, the area of that shape is scaled by a factor of $x^2$. This is known as the Area-Scale Factor relationship.

\\textbf{Calculation and Logic:}

Identify the linear scale factor given in the problem, which is 166. Let the side length of square B be $s_B$. Then the side length of square A is $166s_B$. Calculate the area of square B: $\\text{Area}_B = (s_B)^2$. Calculate the area of square A: $\\text{Area}_A = (166s_B)^2 = 166^2 × (s_B)^2$. The value of $k$ represents the ratio $\\text{Area}_A / \\text{Area}_B$, which is simply $166^2$. Squaring 166: $166 × 166 = 27,556$. Thus, $k = 27,556$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_2',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'The area of a square is 64 square inches. What is the side length, in inches, of this square?',
  '[{"id":"a","text":"8"},{"id":"b","text":"16"},{"id":"c","text":"64"},{"id":"d","text":"128"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Finding the side length of a square when given its area is the inverse operation of finding the area. You must take the square root of the area.

\\textbf{Calculation and Logic:}

Use the formula $\\text{Area} = s^2$. Substitute the known area: $64 = s^2$. To isolate $s$, take the square root of both sides: $s = \\sqrt{64}$. Since $8 × 8 = 64$, the side length $s$ is 8 inches.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_3',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'What is the length of one side of a square that has the same area as a circle with radius 2?',
  '[{"id":"a","text":"2"},{"id":"b","text":"$\\\\sqrt{2\\\\pi}$"},{"id":"c","text":"$2\\\\sqrt{\\\\pi}$"},{"id":"d","text":"$2\\\\pi$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This problem requires setting the area formulas for two different shapes equal to each other. The area of a circle is $\\pi r^2$ and the area of a square is $s^2$.

\\textbf{Calculation and Logic:}

First, calculate the area of the circle with radius $r = 2$: $\\text{Area}_{\\text{circle}} = \\pi(2)^2 = 4\\pi$. Next, set the area of the square equal to the area of the circle: $s^2 = 4\\pi$. To find the side length $s$, take the square root of both sides: $s = \\sqrt{4\\pi}$. Using properties of radicals, $\\sqrt{4\\pi} = \\sqrt{4} × \\sqrt{\\pi}$, which simplifies to $2\\sqrt{\\pi}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_4',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) -- (5,0) -- (3,3) -- cycle; \\draw (3,3) -- (3,0); \\draw (3,0) rectangle (2.8,0.2); \\node at (2.5,-0.3) {5 in}; \\node at (3.3,1.5) {3 in}; \\end{tikzpicture} \\end{center} The figure shows the lengths, in inches, of two sides of a right triangle. What is the area of the triangle, in square inches?',
  NULL,
  '7.5',
  '\\textbf{Conceptual Explanation:}

The area of a right triangle is calculated as half the product of its legs. In a right triangle, the two sides that form the right angle act as the base and the height.

\\textbf{Calculation and Logic:}

Identify the base and height from the diagram. One leg (base) is 5 inches and the other leg (height) is 3 inches. Apply the area formula: $\\text{Area} = (1)/(2) × \\text{base} × \\text{height}$. $\\text{Area} = 0.5 × 5 × 3$. $\\text{Area} = 0.5 × 15$. Performing the calculation results in 7.5. The area of the triangle is 7.5 square inches.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_5',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[thick] (0,0) node[left]{$A$} -- (3,0) node[below]{$C$} -- (3,5) node[above]{$B$} -- cycle; \\draw[thick] (3,0) -- (6,0) node[right]{$E$} -- (6,10) node[above]{$D$} -- cycle; \\draw (3,0) rectangle (2.7,0.3); \\draw (6,0) rectangle (5.7,0.3); \\node at (1.5,-0.5) {3}; \\node at (4.5,-0.5) {21}; \\node at (0.8,2.8) {$\\sqrt{34}$}; \\end{tikzpicture} \\end{center} In the figure shown, $AB = \\sqrt{34}$ units, $AC = 3$ units, and $CE = 21$ units. What is the area, in square units, of triangle $ADE$?',
  '[{"id":"a","text":"60"},{"id":"b","text":"120"},{"id":"c","text":"240"},{"id":"d","text":"480"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

To find the area of the larger triangle $ADE$, we need its total base ($AE$) and its height ($DE$). We can use the Pythagorean theorem on the small triangle to find a side length and then use similar triangle proportions to find the dimensions of the larger triangle.

\\textbf{Calculation and Logic:}

Step 1: Find the height of the small triangle $BC$. In $\\triangle ABC$, $3^2 + (BC)^2 = (\\sqrt{34})^2$. $9 + (BC)^2 = 34 → (BC)^2 = 25 → BC = 5$. Step 2: Use similarity to find $DE$. $\\triangle ABC \\sim \\triangle ADE$. The base of $\\triangle ADE$ is $AE = AC + CE = 3 + 21 = 24$. The ratio of bases is $AE/AC = 24/3 = 8$. Therefore, the height $DE = 8 × BC = 8 × 5 = 40$. Step 3: Calculate the area of $\\triangle ADE$: $\\text{Area} = (1)/(2) × \\text{base} × \\text{height} = (1)/(2) × 24 × 40 = 12 × 40 = 480$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_6',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'Square X has a side length of 12 centimeters. The perimeter of square Y is 2 times the perimeter of square X. What is the length, in centimeters, of one side of square Y?',
  '[{"id":"a","text":"6"},{"id":"b","text":"10"},{"id":"c","text":"14"},{"id":"d","text":"24"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The perimeter of a square is $4s$. If the perimeter is scaled by a factor, the side length is scaled by that same factor because side length and perimeter are both linear measurements.

\\textbf{Calculation and Logic:}

Find the perimeter of square X: $P_X = 4 × 12 = 48 \\text{ cm}$. The perimeter of square Y is $2 × 48 = 96 \\text{ cm}$. To find the side length of square Y, divide its perimeter by 4: $s_Y = 96 / 4 = 24$. Alternatively, since the perimeter is 2 times larger, the side length must also be 2 times larger: $12 × 2 = 24$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_7',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'The length of each edge of a box is 29 inches. Each side of the box is in the shape of a square. The box does not have a lid. What is the exterior surface area, in square inches, of this box without a lid?',
  NULL,
  '4205',
  '\\textbf{Conceptual Explanation:}

A box (cube) without a lid consists of 5 square faces (one bottom and four vertical sides). The total surface area is the sum of the areas of these 5 faces.

\\textbf{Calculation and Logic:}

First, calculate the area of one square face: $\\text{Area}_{\\text{face}} = 29^2$. $29 × 29 = 841 \\text{ sq inches}$. Since there is no lid, there are exactly 5 faces. Multiply the area of one face by 5: $841 × 5 = 4,205$. The exterior surface area is 4,205 square inches.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_8',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A cube has a volume of 474,552 cubic units. What is the surface area, in square units, of the cube?',
  NULL,
  '36504',
  '\\textbf{Conceptual Explanation:}

To find the surface area, you must first find the side length (edge) of the cube by taking the cube root of the volume. Then, use the surface area formula for a cube, $6s^2$.

\\textbf{Calculation and Logic:}

Step 1: Find the edge length $s$. $s = \\sqrt[3]{474,552}$. Testing values: $70^3 = 343,000$ and $80^3 = 512,000$. Since the last digit is 2, the edge length must end in 8. Testing 78: $78 × 78 × 78 = 474,552$. So $s = 78$. Step 2: Calculate the area of one face: $78^2 = 6,084$. Step 3: Calculate total surface area for all 6 faces: $6,084 × 6 = 36,504$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_9',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'A sphere has a radius of 17/5 feet. What is the volume, in cubic feet, of the sphere?',
  '[{"id":"a","text":"$5\\\\pi/17$"},{"id":"b","text":"$68\\\\pi/15$"},{"id":"c","text":"$32\\\\pi/5$"},{"id":"d","text":"$19,652\\\\pi/375$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The volume of a sphere is given by the formula $V = (4)/(3)\\pi r^3$.

\\textbf{Calculation and Logic:}

Substitute $r = 17/5$ into the formula: $V = (4)/(3)\\pi (17/5)^3$. Calculate $(17/5)^3$: $17^3 = 4,913$ and $5^3 = 125$. This gives $\\pi(4913/125)$. Apply the $4/3$ factor: $V = (4 × 4913)/(3 × 125)\\pi = (19652)/(375)\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_10',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A cube has an edge length of 41 inches. What is the volume, in cubic inches, of the cube?',
  NULL,
  '68921',
  '\\textbf{Conceptual Explanation:}

The volume of a cube is the cube of its edge length: $V = s^3$.

\\textbf{Calculation and Logic:}

$V = 41^3$. $41 × 41 = 1681$. $1681 × 41 = 68,921$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_11',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A rectangle has a length of 15 units and a width of 10 units. What is its area?',
  NULL,
  '150',
  '\\textbf{Calculation and Logic:}

$\\text{Area} = \\text{length} × \\text{width} = 15 × 10 = 150$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_047_12',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'A parallelogram has a base of 14 cm and a height of 9 cm. A second parallelogram is similar to the first and has a base of 28 cm. What is the area of the second parallelogram?',
  '[{"id":"a","text":"126 $\\\\text{cm}^2$"},{"id":"b","text":"252 $\\\\text{cm}^2$"},{"id":"c","text":"504 $\\\\text{cm}^2$"},{"id":"d","text":"1,008 $\\\\text{cm}^2$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$\\text{Area}_1 = 14 × 9 = 126 \\text{ cm}^2$. The linear scale factor is $28/14 = 2$. The area scale factor is $2^2 = 4$. $\\text{Area}_2 = 126 × 4 = 504 \\text{ cm}^2$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_13',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'What is the area of a trapezoid with bases of 10 and 20 units and a height of 8 units?',
  NULL,
  '120',
  '\\textbf{Calculation and Logic:}

$\\text{Area} = (b_1 + b_2)/(2) × h = (10 + 20)/(2) × 8 = 15 × 8 = 120$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_14',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'If the area of a square is 144, what is its perimeter?',
  NULL,
  '48',
  '\\textbf{Calculation and Logic:}

$s = \\sqrt{144} = 12$. $\\text{Perimeter} = 4 × 12 = 48$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_15',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A triangle has a base of 12 and an area of 48. What is the height of the triangle?',
  NULL,
  '8',
  '\\textbf{Calculation and Logic:}

$48 = 0.5 × 12 × h → 48 = 6h → h = 8$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_16',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'A square is inscribed in a circle with radius 5. What is the area of the square?',
  '[{"id":"a","text":"25"},{"id":"b","text":"50"},{"id":"c","text":"75"},{"id":"d","text":"100"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The diagonal of the square is equal to the diameter of the circle.

\\textbf{Calculation and Logic:}

$\\text{Diameter} = 2 × 5 = 10$. For a square, $\\text{Diagonal} = s\\sqrt{2} = 10$. So $s = 10/\\sqrt{2}$. $\\text{Area} = s^2 = (10/\\sqrt{2})^2 = 100/2 = 50$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_17',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A cube has a surface area of 150. What is the length of one side?',
  NULL,
  '5',
  '\\textbf{Calculation and Logic:}

$6s^2 = 150 → s^2 = 25 → s = 5$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_047_18',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'The sides of a rectangle are 4 and 9. A square has the same area as this rectangle. What is the side length of the square?',
  NULL,
  '6',
  '\\textbf{Calculation and Logic:}

$\\text{Area}_{\\text{rect}} = 4 × 9 = 36$. $s^2 = 36 → s = 6$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_19',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'If the side length of a square is tripled, the area is multiplied by:',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"27"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

The area is proportional to the square of the side length. $3^2 = 9$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_20',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A right triangle has legs of 8 and 15. What is the area?',
  NULL,
  '60',
  '\\textbf{Calculation:}

$0.5 × 8 × 15 = 4 × 15 = 60$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_21',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A rhombus has diagonals of 10 and 24. What is its area?',
  NULL,
  '120',
  '\\textbf{Conceptual Explanation:}

$\\text{Area}_{\\text{rhombus}} = (d_1 × d_2)/(2)$.

\\textbf{Calculation:}

$(10 × 24) / 2 = 120$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_22',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A regular hexagon has a side length of 4. What is its area? (Round to the nearest whole number).',
  NULL,
  '42',
  '\\textbf{Calculation:}

$\\text{Area} = \\frac{3\\sqrt{3}}{2}s^2 = \\frac{3\\sqrt{3}}{2}(16) = 24\\sqrt{3} \\approx 24 × 1.732 \\approx 41.56$. Rounded to 42.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_23',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'Area of a circle with diameter 10? (Use $\\pi = 3.14$).',
  NULL,
  '78.5',
  '\\textbf{Calculation:}

$r = 5$. $\\text{Area} = 3.14 × 25 = 78.5$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_047_24',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A trapezoid area is 50. Bases are 6 and 14. Height?',
  NULL,
  '5',
  '\\textbf{Calculation:}

$50 = 0.5(6+14)h → 50 = 10h → h = 5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_25',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'Volume of a rectangular prism with sides 2, 5, 10?',
  NULL,
  '100',
  '\\textbf{Calculation:}

$2 × 5 × 10 = 100$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_26',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'Surface area of a sphere with radius 3? (Give answer in terms of $\\pi$).',
  NULL,
  '$36\\pi$',
  '\\textbf{Calculation:}

$\\text{SA} = 4\\pi r^2 = 4\\pi(9) = 36\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_27',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'Area of a square with perimeter 20?',
  NULL,
  '25',
  '\\textbf{Calculation:}

$s = 5$. $\\text{Area} = 25$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_047_28',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A cylinder height is 10 and radius is 4. Volume? (In terms of $\\pi$).',
  NULL,
  '$160\\pi$',
  '\\textbf{Calculation:}

$V = \\pi r^2 h = \\pi(16)(10) = 160\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_29',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'Area of a triangle with sides 3, 4, 5?',
  NULL,
  '6',
  '\\textbf{Calculation:}

It is a right triangle. $\\text{Area} = 0.5 × 3 × 4 = 6$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_30',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'A rectangle has a length that is twice its width. If the perimeter of the rectangle is 120 centimeters, what is the area of the rectangle in square centimeters?',
  '[{"id":"a","text":"200"},{"id":"b","text":"400"},{"id":"c","text":"800"},{"id":"d","text":"1,600"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To find the area of a rectangle, you must first determine its specific length and width dimensions. We use the perimeter formula, $P = 2(L + W)$, and the given relationship between the dimensions to set up an algebraic equation.

\\textbf{Calculation and Logic:}

Let the width be $w$. According to the problem, the length is $2w$. Substitute these into the perimeter formula: $120 = 2(2w + w)$. Simplify the expression inside the parentheses to get $120 = 2(3w)$, which results in $120 = 6w$. Dividing both sides by 6 gives a width of $w = 20 \\text{ cm}$. Consequently, the length is $2 × 20 = 40 \\text{ cm}$. Now, calculate the area by multiplying the length and the width. The calculation $40 × 20$ results in 800. Therefore, the area of the rectangle is 800 square centimeters.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_31',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A regular octagon is composed of 8 congruent isosceles triangles. If each triangle has a base of 10 units and a height (apothem) of 12 units, what is the total area of the octagon?',
  NULL,
  '480',
  '\\textbf{Conceptual Explanation:}

The area of a regular polygon can be viewed as the sum of the areas of the congruent triangles that radiate from its center to its sides.

\\textbf{Calculation and Logic:}

First, calculate the area of a single triangular component. Using the formula for the area of a triangle, multiply the base of 10 by the height of 12 and then divide by 2. The calculation $0.5 × 10 × 12$ results in 60 square units. Since the octagon is made of exactly 8 of these congruent triangles, multiply the area of one triangle by 8. The calculation $60 × 8$ results in 480. Thus, the total area of the regular octagon is 480 square units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_32',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'A square and a rectangle have the same area. The square has a side length of 12. If the rectangle has a length of 18, what is the perimeter of the rectangle?',
  '[{"id":"a","text":"8"},{"id":"b","text":"26"},{"id":"c","text":"52"},{"id":"d","text":"144"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This problem requires equating the area of two different shapes to find a missing dimension, then using that dimension to calculate a linear property (perimeter).

\\textbf{Calculation and Logic:}

First, determine the area of the square by squaring its side length. $12 × 12 = 144$. Because the rectangle shares this area, set the rectangle''s area formula, $\\text{Length} × \\text{Width}$, equal to 144. Substitute the known length: $18 × \\text{Width} = 144$. Solve for the width by dividing 144 by 18, which results in a width of 8. Finally, calculate the perimeter of the rectangle using the formula $2(L + W)$. The calculation $2(18 + 8)$ becomes $2 × 26$, which results in 52.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_33',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,0) -- (4,0) -- (6,2) -- (2,2) -- cycle; \\draw[dashed] (2,2) -- (2,0); \\draw (2,0) rectangle (2.2,0.2); \\node at (2,-0.3) {4}; \\node at (5,1.3) {5}; \\node at (2.3,1) {3}; \\end{tikzpicture} \\end{center} What is the area of the parallelogram shown above?',
  NULL,
  '12',
  '\\textbf{Conceptual Explanation:}

The area of a parallelogram is calculated as the product of its base and its perpendicular height. It is important not to use the slant height (side length) in this calculation.

\\textbf{Calculation and Logic:}

Identify the base and the perpendicular height from the diagram. The horizontal base is given as 4 units, and the dashed line representing the vertical height is given as 3 units. Note that the side length of 5 is a distractor for this specific calculation. Apply the formula $\\text{Area} = \\text{base} × \\text{height}$. Multiplying 4 by 3 results in 12. Therefore, the area of the parallelogram is 12 square units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_34',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A right isosceles triangle has a hypotenuse of length $10\\sqrt{2}$. What is the area of this triangle?',
  NULL,
  '50',
  '\\textbf{Conceptual Explanation:}

In a right isosceles triangle (45-45-90), the legs are equal in length, and the hypotenuse is $\\text{leg} × \\sqrt{2}$. Finding the leg length allows for the calculation of the area.

\\textbf{Calculation and Logic:}

First, identify the leg length by dividing the hypotenuse by $\\sqrt{2}$. The calculation $10\\sqrt{2} / \\sqrt{2}$ results in a leg length of 10. Since it is a right triangle, the two legs serve as the base and the height. Apply the triangle area formula: $\\text{Area} = 0.5 × \\text{base} × \\text{height}$. Substituting the values gives $0.5 × 10 × 10$. Multiplying 10 by 10 gives 100, and taking half of that results in 50. The area of the triangle is 50 square units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_35',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'If the area of a regular hexagon is $24\\sqrt{3}$ square units, what is its side length?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The area of a regular hexagon is given by the formula $\\text{Area} = \\frac{3\\sqrt{3}}{2}s^2$, where $s$ is the side length. We set the given area equal to this formula to solve for $s$.

\\textbf{Calculation and Logic:}

Set up the equation: $24\\sqrt{3} = \\frac{3\\sqrt{3}}{2}s^2$. First, divide both sides by $\\sqrt{3}$ to simplify: $24 = (3)/(2)s^2$. Next, multiply both sides by 2 to clear the fraction: $48 = 3s^2$. Divide both sides by 3 to isolate the squared term: $s^2 = 16$. Finally, take the square root of both sides to find the side length. The square root of 16 is 4. Thus, the side length of the hexagon is 4 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_36',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A trapezoid has an area of 100 square units. Its height is 10 units and one of its bases is 8 units. What is the length of the other base?',
  NULL,
  '12',
  '\\textbf{Conceptual Explanation:}

The area of a trapezoid is the average of its two bases multiplied by its height. The formula is $\\text{Area} = 0.5 × (b_1 + b_2) × h$.

\\textbf{Calculation and Logic:}

Substitute the known values into the area formula: $100 = 0.5 × (8 + b_2) × 10$. Simplify the product of 0.5 and 10 to get 5, resulting in the equation $100 = 5 × (8 + b_2)$. Divide both sides by 5 to isolate the term in parentheses: $20 = 8 + b_2$. To find $b_2$, subtract 8 from 20. The calculation $20 - 8$ results in 12. Therefore, the length of the other base is 12 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_37',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'A circle with circumference $12\\pi$ is inscribed in a square. What is the area of the square?',
  '[{"id":"a","text":"36"},{"id":"b","text":"72"},{"id":"c","text":"144"},{"id":"d","text":"452"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

An inscribed circle''s diameter is exactly equal to the side length of the square it resides in. We must find the diameter from the circumference first.

\\textbf{Calculation and Logic:}

Use the circumference formula $C = \\pi d$. Given $12\\pi = \\pi d$, dividing by $\\pi$ shows the diameter $d = 12$. Since the diameter is 12, the side length of the square is also 12. To find the area of the square, square the side length: $12^2 = 144$. The area of the square is 144 square units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_38',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'The area of a rhombus is 60. If one diagonal is 10, what is the length of the other diagonal?',
  '[{"id":"a","text":"6"},{"id":"b","text":"12"},{"id":"c","text":"24"},{"id":"d","text":"30"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The area of a rhombus can be calculated using the lengths of its diagonals. The formula is $\\text{Area} = (d_1 × d_2)/(2)$.

\\textbf{Calculation and Logic:}

Substitute the known values into the formula: $60 = (10 × d_2) / 2$. Simplify the right side by dividing 10 by 2, which results in $60 = 5 × d_2$. To find the length of the second diagonal, divide 60 by 5. The calculation $60 / 5$ results in 12. Thus, the length of the other diagonal is 12 units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_39',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'What is the area of a square with a perimeter of 32 centimeters?',
  NULL,
  '64',
  '\\textbf{Conceptual Explanation:}

Perimeter is a linear measure of the total boundary, while area is a measure of the internal surface. You must find the side length from the perimeter before you can calculate the area.

\\textbf{Calculation and Logic:}

First, find the side length $s$ by dividing the total perimeter by 4. The calculation $32 / 4$ results in a side length of 8 cm. Next, use the side length to calculate the area using the formula $\\text{Area} = s^2$. Squaring 8 ($8 × 8$) results in 64. Therefore, the area of the square is 64 square centimeters.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_047_40',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'A rectangular room is 12 feet by 15 feet. A square rug with a side length of 9 feet is placed in the center of the room. How many square feet of the floor are NOT covered by the rug?',
  '[{"id":"a","text":"81"},{"id":"b","text":"99"},{"id":"c","text":"180"},{"id":"d","text":"261"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To find the area of the floor left uncovered, calculate the total area of the room and subtract the area of the rug.

\\textbf{Calculation and Logic:}

First, calculate the total area of the rectangular room by multiplying its dimensions: $12 × 15 = 180 \\text{ sq feet}$. Second, calculate the area of the square rug by squaring its side length: $9^2 = 81 \\text{ sq feet}$. Finally, subtract the rug''s area from the room''s total area to find the remaining floor space. The calculation $180 - 81$ results in 99. Thus, 99 square feet of the floor are not covered.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_41',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A triangle has a height of 14 units and a base of 20 units. What is its area?',
  NULL,
  '140',
  '\\textbf{Calculation and Logic:}

Identify the base as 20 and the height as 14. Apply the standard triangle area formula, which is half the base multiplied by the height. Multiply 20 by 14 to get 280. Then, take half of that total. The calculation $0.5 × 280$ results in 140. Therefore, the total area of the triangle is 140 square units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_42',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'If the area of a square is increased by 300%, by what percentage does the side length increase?',
  '[{"id":"a","text":"100%"},{"id":"b","text":"150%"},{"id":"c","text":"200%"},{"id":"d","text":"300%"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

An increase of 300% means the new area is $1 + 3 = 4$ times the original area. We use the area-scale relationship to determine how the side length changes.

\\textbf{Calculation and Logic:}

Let the original area be $A$. An increase of 300% results in a new area of $4A$. Since area is proportional to the square of the side length ($s^2$), if the area is multiplied by 4, the side length must be multiplied by the square root of 4, which is 2. Doubling a side length is equivalent to a 100% increase ($100% \\text{ original} + 100% \\text{ increase} = 200% \\text{ or factor of 2}$). Therefore, the side length increased by 100%.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_43',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A rectangle has an area of 48 square units. If the width is 4 units, what is the perimeter?',
  NULL,
  '32',
  '\\textbf{Calculation and Logic:}

First, find the length by dividing the area by the width. The calculation $48 / 4$ results in a length of 12 units. Next, use the length and width to calculate the perimeter using the formula $2(L + W)$. Add 12 and 4 to get 16. Multiply this sum by 2. The calculation $2 × 16$ results in 32. Thus, the perimeter is 32 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_44',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A kite has diagonals that measure 12 cm and 18 cm. What is the area of the kite in square centimeters?',
  NULL,
  '108',
  '\\textbf{Conceptual Explanation:}

Like a rhombus, the area of a kite is calculated using the product of its perpendicular diagonals.

\\textbf{Calculation and Logic:}

Apply the diagonal area formula: $\\text{Area} = (d_1 × d_2) / 2$. Substitute the diagonal lengths into the equation: $(12 × 18) / 2$. Multiply 12 by 18 to get 216. Then, divide this product by 2. The calculation $216 / 2$ results in 108. Therefore, the area of the kite is 108 square centimeters.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_45',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'What is the area of a square with side length $\\sqrt{7}$?',
  '[{"id":"a","text":"$\\\\sqrt{7}$"},{"id":"b","text":"7"},{"id":"c","text":"14"},{"id":"d","text":"49"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

The area of a square is the side length squared. Squaring a square root cancels out the radical. The calculation $(\\sqrt{7})^2$ is equal to 7. Thus, the area of the square is 7 square units.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_047_46',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'A parallelogram has a base of 15 and an area of 75. What is the height?',
  NULL,
  '5',
  '\\textbf{Calculation and Logic:}

Use the formula $\\text{Area} = \\text{base} × \\text{height}$. Substitute the known values: $75 = 15 × \\text{height}$. To isolate the height, divide 75 by 15. The calculation $75 / 15$ results in 5. Therefore, the height of the parallelogram is 5 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_47',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'What is the area of a right triangle with legs of 9 and 12 units?',
  NULL,
  '54',
  '\\textbf{Calculation and Logic:}

In a right triangle, the legs are the base and height. Apply the area formula: $0.5 × 9 × 12$. Multiply 9 by 12 to get 108. Then, calculate half of 108. The result is 54. The area of the triangle is 54 square units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_48',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'mcq',
  'math',
  'A rectangular field is 40 meters wide and 60 meters long. If the length is increased by 10% and the width is decreased by 10%, what is the new area?',
  '[{"id":"a","text":"2,376"},{"id":"b","text":"2,400"},{"id":"c","text":"2,424"},{"id":"d","text":"2,640"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

To find the new area, first calculate the modified dimensions and then multiply them. Note that equal percentage changes in opposite directions do not cancel each other out in area calculations.

\\textbf{Calculation and Logic:}

First, find the new length: $60 + (0.10 × 60) = 60 + 6 = 66 \\text{ meters}$. Next, find the new width: $40 - (0.10 × 40) = 40 - 4 = 36 \\text{ meters}$. Calculate the new area by multiplying these dimensions. The calculation $66 × 36$ results in 2,376. Therefore, the new area is 2,376 square meters.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_047_49',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
),
  (
  'spr',
  'math',
  'The area of a square is 225. What is the perimeter?',
  NULL,
  '60',
  '\\textbf{Calculation and Logic:}

First, find the side length by taking the square root of the area. The square root of 225 is 15. Next, use the side length to find the perimeter by multiplying by 4. The calculation $15 × 4$ results in 60. Thus, the perimeter is 60 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_047_50',
  'Area and volume of 2D/3D shapes',
  'Area of Polygons'
)
ON CONFLICT (bank_item_id) DO NOTHING;

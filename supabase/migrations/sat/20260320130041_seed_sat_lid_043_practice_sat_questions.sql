-- Practice-mode math from lid_043.tex (sat_lid_043)
-- Chapter: Lines, angles, parallel/perpendicular lines | Topic: Angles in Polygons
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_043_N, practice module/set 0.

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
  'In convex pentagon $ABCDE$, segment $AB$ is parallel to segment $DE$. The measure of angle $B$ is 139 degrees, and the measure of angle $D$ is 174 degrees. What is the measure, in degrees, of angle $C$?',
  '[{"id":"a","text":"47"},{"id":"b","text":"65"},{"id":"c","text":"133"},{"id":"d","text":"141"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The sum of the interior angles of any convex polygon with $n$ sides is given by the formula $(n - 2) × 180^\\circ$. For a pentagon ($n = 5$), the sum is $(5 - 2) × 180^\\circ = 540^\\circ$. Additionally, when two segments in a polygon are parallel, we can use properties of transversal lines, such as consecutive interior angles, to relate specific angles.

\\textbf{Calculation and Logic:}

First, identify the total sum of interior angles for the pentagon, which is $540^\\circ$. We are given that $AB \\parallel DE$. If we extend the segments to act as parallel lines intersected by transversals $BC$ and $CD$, we can observe the relationship between the angles. However, a more direct approach is to use the property of consecutive interior angles. If we were to draw an auxiliary line parallel to $AB$ and $DE$ through vertex $C$, it would split $\\angle C$ into two parts. But since we are only given $\\angle B = 139^\\circ$ and $\\angle D = 174^\\circ$, we utilize the fact that for parallel segments $AB$ and $DE$, the sum of the angles on one side of the polygon "between" the parallel lines ($B + C + D$) must satisfy a specific transversal relationship. In this specific configuration, $\\angle B + \\angle C + \\angle D = 360^\\circ$ because they represent the interior angles on the same side of a "double transversal" setup. Calculating the value: $139 + \\angle C + 174 = 360$. Summing the known values: $313 + \\angle C = 360$. Subtracting 313 from both sides results in $\\angle C = 47^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_1',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,0) -- (3,0) -- (4,2) -- (2,3.5) -- (-1,2) -- cycle; \\node at (-0.2,0.3) {$x^\\circ$}; \\node at (3.2,0.3) {$110^\\circ$}; \\node at (3.8,1.8) {$120^\\circ$}; \\node at (2,3.1) {$100^\\circ$}; \\node at (-0.8,1.8) {$115^\\circ$}; \\end{tikzpicture} \\end{center} What is the value of $x$ in the pentagon shown above?',
  '[{"id":"a","text":"95"},{"id":"b","text":"105"},{"id":"c","text":"115"},{"id":"d","text":"125"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Every convex pentagon has an interior angle sum of $540^\\circ$. To find a missing angle, you must sum all known interior angles and subtract that total from the theoretical sum for that specific polygon.

\\textbf{Calculation and Logic:}

Step 1: Calculate the sum of the four given interior angles. $110 + 120 + 100 + 115 = 445^\\circ$. Step 2: Set up an algebraic equation where the sum of all five angles equals $540^\\circ$. The equation is $x + 445 = 540$. Step 3: Solve for $x$ by isolating the variable. $x = 540 - 445$. Performing the subtraction gives $x = 95$. Therefore, the measure of the final interior angle is 95 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_2',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'Quadrilateral $P''Q''R''S''$ is similar to quadrilateral $PQRS$, where $P, Q, R$, and $S$ correspond to $P'', Q'', R''$, and $S''$, respectively. The measure of angle $P$ is $30^\\circ$, the measure of angle $Q$ is $50^\\circ$, and the measure of angle $R$ is $70^\\circ$. The length of each side of $P''Q''R''S''$ is 3 times the length of each corresponding side of $PQRS$. What is the measure of angle $P''$?',
  '[{"id":"a","text":"$10^\\\\circ$"},{"id":"b","text":"$30^\\\\circ$"},{"id":"c","text":"$40^\\\\circ$"},{"id":"d","text":"$90^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Similarity in geometry has two primary components: corresponding sides are proportional, and corresponding angles are congruent. While the side lengths can be scaled by a factor (in this case, 3), the measures of the angles remain completely unchanged regardless of the size of the polygon.

\\textbf{Calculation and Logic:}

The problem states that $P''Q''R''S''$ is similar to $PQRS$. By the definition of similarity, $\\angle P \\cong \\angle P''$, $\\angle Q \\cong \\angle Q''$, $\\angle R \\cong \\angle R''$, and $\\angle S \\cong \\angle S''$. We are given that the measure of $\\angle P = 30^\\circ$. Although the side lengths of the second quadrilateral are three times larger, this scaling does not affect the rotation between the segments. Therefore, the measure of the corresponding angle $P''$ must be identical to the measure of $\\angle P$. Thus, the measure of $\\angle P''$ is $30^\\circ$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_3',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'A regular hexagon is inscribed in a circle. What is the measure, in degrees, of each interior angle of the hexagon?',
  NULL,
  '120',
  '\\textbf{Conceptual Explanation:}

A regular polygon has sides of equal length and interior angles of equal measure. The formula for the measure of one interior angle of a regular $n$-gon is $((n - 2) × 180)/(n)$.

\\textbf{Calculation and Logic:}

First, identify the number of sides for a hexagon, which is $n = 6$. Second, calculate the total sum of the interior angles using $(6 - 2) × 180$. This becomes $4 × 180 = 720^\\circ$. Third, since the hexagon is regular, all 6 interior angles are equal. Divide the total sum by the number of angles: $720 / 6$. Performing the division results in 120. Therefore, each interior angle of a regular hexagon measures 120 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_4',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,0) -- (4,0) -- (3,2.5) -- (1,2.5) -- cycle; \\node at (0.3,0.3) {$x^\\circ$}; \\node at (3.7,0.3) {$x^\\circ$}; \\node at (1.2,2.2) {$y^\\circ$}; \\node at (2.8,2.2) {$y^\\circ$}; \\end{tikzpicture} \\end{center} In the isosceles trapezoid shown above, $y = 2x + 30$. What is the value of $x$?',
  '[{"id":"a","text":"50"},{"id":"b","text":"60"},{"id":"c","text":"70"},{"id":"d","text":"130"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

An isosceles trapezoid is a quadrilateral with one pair of parallel sides. The angles adjacent to the non-parallel sides (consecutive interior angles) are supplementary, meaning they add up to $180^\\circ$.

\\textbf{Calculation and Logic:}

Because the top and bottom bases are parallel, the angles $x$ and $y$ are consecutive interior angles. This gives us the equation $x + y = 180$. We are also given a relationship between the variables: $y = 2x + 30$. Substitute the expression for $y$ into the first equation: $x + (2x + 30) = 180$. Combine the like terms to get $3x + 30 = 180$. Subtract 30 from both sides of the equation: $3x = 150$. Finally, divide by 3 to isolate $x$, resulting in $x = 50$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_5',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'What is the sum of the exterior angles of a convex octagon, taking one at each vertex?',
  '[{"id":"a","text":"$180^\\\\circ$"},{"id":"b","text":"$360^\\\\circ$"},{"id":"c","text":"$720^\\\\circ$"},{"id":"d","text":"$1080^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The Polygon Exterior Angle Sum Theorem states that for any convex polygon, regardless of the number of sides, the sum of the exterior angles (one at each vertex) is always constant.

\\textbf{Calculation and Logic:}

Identify that the polygon is an octagon, which has 8 sides. According to the theorem, the exterior angle sum does not depend on $n$. Whether the polygon has 3 sides or 100 sides, the rotation required to travel around the perimeter and return to the starting direction is exactly one full circle. Therefore, the sum is $360^\\circ$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_043_6',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'A regular polygon has an interior angle sum of $1,440^\\circ$. How many sides does the polygon have?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

We use the interior angle sum formula, $S = (n - 2) × 180$, and solve for the variable $n$, which represents the number of sides.

\\textbf{Calculation and Logic:}

Set up the equation using the given sum: $1440 = (n - 2) × 180$. First, divide both sides of the equation by 180 to simplify: $1440 / 180 = n - 2$. Calculating the division gives $8 = n - 2$. Next, isolate $n$ by adding 2 to both sides of the equation: $n = 8 + 2 = 10$. This means the polygon is a decagon with 10 sides.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_7',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'If the measure of one exterior angle of a regular polygon is $40^\\circ$, how many sides does the polygon have?',
  '[{"id":"a","text":"4"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"12"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

For a regular polygon, all exterior angles are equal. Since the total sum of exterior angles is always $360^\\circ$, the measure of one exterior angle is $(360)/(n)$.

\\textbf{Calculation and Logic:}

Set up the relationship: $40 = (360)/(n)$. To solve for $n$, multiply both sides by $n$ to get $40n = 360$. Then, divide both sides by 40: $n = 360 / 40$. Performing the division gives $n = 9$. The polygon is a regular nonagon with 9 sides.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_8',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,0) -- (2,0) -- (3,1.73) -- (2,3.46) -- (0,3.46) -- (-1,1.73) -- cycle; \\draw[thick] (0,0) -- (3,1.73); \\node at (0.4,0.2) {$a^\\circ$}; \\end{tikzpicture} \\end{center} In the regular hexagon shown above, a diagonal is drawn from one vertex to another. What is the value of $a$?',
  '[{"id":"a","text":"30"},{"id":"b","text":"60"},{"id":"c","text":"90"},{"id":"d","text":"120"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In a regular polygon, all interior angles are equal. A hexagon has interior angles of $120^\\circ$. When diagonals are drawn from a single vertex, they divide the interior angle into $n-2$ triangles. In a regular polygon, these divisions are often symmetrical.

\\textbf{Calculation and Logic:}

The interior angle of a regular hexagon is $120^\\circ$. The triangle formed by the diagonal and two sides of the hexagon is an isosceles triangle because all sides of a regular hexagon are equal. In this triangle, the vertex angle is the hexagon''s interior angle ($120^\\circ$). The remaining $180 - 120 = 60^\\circ$ must be split equally between the two base angles. Therefore, each base angle (including angle $a$) is $60 / 2 = 30^\\circ$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_9',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'A quadrilateral has three interior angles measuring $85^\\circ, 95^\\circ$, and $105^\\circ$. What is the measure of the fourth interior angle?',
  '[{"id":"a","text":"$75^\\\\circ$"},{"id":"b","text":"$85^\\\\circ$"},{"id":"c","text":"$95^\\\\circ$"},{"id":"d","text":"$105^\\\\circ$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The sum of the interior angles of any quadrilateral is $(4 - 2) × 180 = 360^\\circ$. The missing angle is found by subtracting the sum of the known angles from 360.

\\textbf{Calculation and Logic:}

Calculate the sum of the three known angles: $85 + 95 + 105 = 285^\\circ$. Subtract this total from the quadrilateral sum: $360 - 285 = 75^\\circ$. Thus, the fourth angle must measure 75 degrees to complete the interior sum.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_10',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'A convex polygon has $n$ sides. If the sum of the interior angles of the polygon is $1,080^\\circ$, what is the value of $n$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"7"},{"id":"c","text":"8"},{"id":"d","text":"10"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The relationship between the number of sides $n$ and the sum of the interior angles $S$ is defined by the formula $S = (n - 2) × 180$. To find the number of sides, we set the given sum equal to this formula and solve for $n$.

\\textbf{Calculation and Logic:}

First, set up the equation: $1080 = (n - 2) × 180$. To isolate the term $(n - 2)$, divide both sides of the equation by 180. The calculation $1080 / 180$ results in 6. This gives the simplified equation $6 = n - 2$. Finally, add 2 to both sides to solve for $n$. The calculation $6 + 2$ results in 8. Thus, the polygon has 8 sides, making it an octagon.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_11',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'In a regular nonagon (a 9-sided polygon), what is the measure, in degrees, of one exterior angle?',
  NULL,
  '40',
  '\\textbf{Conceptual Explanation:}

For any convex polygon, the sum of the exterior angles, taking one at each vertex, is always $360^\\circ$. In a regular polygon, all exterior angles are congruent. Therefore, the measure of one exterior angle is found by dividing 360 by the number of sides.

\\textbf{Calculation and Logic:}

Identify the number of sides for a nonagon, which is $n = 9$. Use the exterior angle formula: $\\text{Exterior Angle} = 360 / n$. Substitute the value of $n$: $360 / 9$. Performing the division results in 40. Each exterior angle of a regular nonagon measures 40 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_12',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'The measure of an interior angle of a regular polygon is 5 times the measure of its exterior angle. How many sides does the polygon have?',
  '[{"id":"a","text":"10"},{"id":"b","text":"12"},{"id":"c","text":"15"},{"id":"d","text":"18"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

At any vertex of a polygon, the interior angle and the exterior angle are supplementary, meaning their sum is $180^\\circ$. We can represent these measures algebraically to find the number of sides.

\\textbf{Calculation and Logic:}

Let the measure of the exterior angle be $e$. Then the interior angle is $5e$. Set up the supplementary equation: $e + 5e = 180$. Combine like terms: $6e = 180$. Divide by 6 to find the exterior angle: $e = 30^\\circ$. Now, use the exterior angle sum property to find the number of sides $n$: $n = 360 / e$. Substitute 30 for $e$: $n = 360 / 30$. Performing the division gives $n = 12$. The polygon has 12 sides.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_13',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,0) -- (2,0) -- (2.5,1.5) -- (1,2.5) -- (-0.5,1.5) -- cycle; \\node at (1,0.3) {$(3x)^\\circ$}; \\node at (1.8,1) {$(4x)^\\circ$}; \\node at (1,2) {$(2x)^\\circ$}; \\node at (0.2,1) {$(4x)^\\circ$}; \\node at (1,-0.3) {Pentagon $P$}; \\end{tikzpicture} \\end{center} If the five interior angles of pentagon $P$ are $3x, 4x, 2x, 4x,$ and $5x$, what is the value of $x$?',
  '[{"id":"a","text":"18"},{"id":"b","text":"30"},{"id":"c","text":"36"},{"id":"d","text":"54"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The sum of the interior angles of a pentagon is always $(5-2) × 180 = 540^\\circ$. To find the value of a variable within these angles, sum the algebraic expressions and set them equal to 540.

\\textbf{Calculation and Logic:}

First, sum the given angle expressions: $3x + 4x + 2x + 4x + 5x = 18x$. Set this total equal to the pentagon interior sum: $18x = 540$. To solve for $x$, divide both sides of the equation by 18. The calculation $540 / 18$ results in $x = 30$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_14',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'A regular polygon has interior angles that each measure $162^\\circ$. How many sides does this polygon have?',
  NULL,
  '20',
  '\\textbf{Conceptual Explanation:}

While you can use the interior angle formula, it is often faster to find the measure of the exterior angle first. Since interior and exterior angles are supplementary, $\\text{Exterior Angle} = 180 - \\text{Interior Angle}$.

\\textbf{Calculation and Logic:}

Step 1: Calculate the measure of one exterior angle. $180 - 162 = 18^\\circ$. Step 2: Use the relationship that the number of sides $n$ equals the total exterior sum divided by one exterior angle. $n = 360 / 18$. Step 3: Perform the division. $360 / 18 = 20$. The polygon has 20 sides.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_15',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'The sum of the interior angles of a convex polygon is $1,800^\\circ$. If the polygon is regular, what is the measure of each interior angle?',
  '[{"id":"a","text":"$120^\\\\circ$"},{"id":"b","text":"$144^\\\\circ$"},{"id":"c","text":"$150^\\\\circ$"},{"id":"d","text":"$160^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In a regular polygon, every interior angle is identical. To find the measure of one angle, we must first determine the number of sides using the sum formula and then divide the total sum by that number of sides.

\\textbf{Calculation and Logic:}

Step 1: Find the number of sides $n$. $(n - 2) × 180 = 1800$. Dividing by 180 gives $n - 2 = 10$, so $n = 12$. Step 2: Divide the total sum by the number of angles. $\\text{One Angle} = 1800 / 12$. Performing the division results in 150. Each interior angle of the regular 12-gon measures 150 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_16',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'Two angles of a quadrilateral are $70^\\circ$ and $110^\\circ$. The other two angles are in a ratio of 4:5. What is the measure of the largest angle in the quadrilateral?',
  '[{"id":"a","text":"$80^\\\\circ$"},{"id":"b","text":"$100^\\\\circ$"},{"id":"c","text":"$110^\\\\circ$"},{"id":"d","text":"$120^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The sum of the angles in any quadrilateral is $360^\\circ$. We subtract the known angles from this total and then use the remaining sum to solve for the unknown angles using their given ratio.

\\textbf{Calculation and Logic:}

Step 1: Find the sum of the remaining two angles. $360 - (70 + 110) = 360 - 180 = 180^\\circ$. Step 2: Represent the two angles using the ratio 4:5 as $4x$ and $5x$. Step 3: Set up the sum equation: $4x + 5x = 180$. Combine terms: $9x = 180$, which means $x = 20$. Step 4: Calculate the two angles: $4(20) = 80^\\circ$ and $5(20) = 100^\\circ$. Step 5: Compare all angles: $70, 110, 80, 100$. The largest angle is 110 degrees.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_17',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'As the number of sides of a regular polygon increases, what happens to the measure of each exterior angle?',
  '[{"id":"a","text":"It increases."},{"id":"b","text":"It decreases."},{"id":"c","text":"It stays the same ($360^\\\\circ$)."},{"id":"d","text":"It becomes greater than the interior angle."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The measure of one exterior angle of a regular polygon is given by $360 / n$. This is an inverse relationship between the number of sides and the size of the angle.

\\textbf{Calculation and Logic:}

Since the total sum of exterior angles is fixed at $360^\\circ$, adding more vertices means that the "turn" required at each vertex must become smaller to complete the same $360^\\circ$ rotation. Mathematically, as $n$ (the denominator) increases, the value of the fraction $360/n$ must decrease.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_043_18',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'A regular polygon has a total of 20 diagonals. How many sides does this polygon have?',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

The number of diagonals $D$ in a polygon with $n$ sides is given by the formula $D = (n(n - 3))/(2)$. We solve for $n$ by setting $D = 20$.

\\textbf{Calculation and Logic:}

Set up the equation: $20 = (n(n - 3))/(2)$. Multiply both sides by 2: $40 = n^2 - 3n$. Rearrange into a quadratic equation: $n^2 - 3n - 40 = 0$. Factoring the quadratic: $(n - 8)(n + 5) = 0$. Since the number of sides must be positive, $n = 8$. The polygon is an octagon.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_19',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,0) -- (3,0) -- (3,2) -- (0,2) -- cycle; \\draw[thick] (0,2) -- (1.5,3) -- (3,2); \\node at (1.5,1) {House Shape}; \\end{tikzpicture} \\end{center} A "house" shape is formed by placing an equilateral triangle on top of a square. What is the measure of the interior angle formed where the triangle meets the square?',
  '[{"id":"a","text":"$90^\\\\circ$"},{"id":"b","text":"$120^\\\\circ$"},{"id":"c","text":"$150^\\\\circ$"},{"id":"d","text":"$180^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To find the total interior angle of a composite figure, you sum the individual interior angles of the polygons that meet at that vertex.

\\textbf{Calculation and Logic:}

The vertex in question is shared by a square and an equilateral triangle. The interior angle of a square is $90^\\circ$. The interior angle of an equilateral triangle is $60^\\circ$. To find the total measure of the combined interior angle of the resulting pentagon at that vertex, add the two measures: $90 + 60 = 150^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_20',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'What is the sum of the interior angles of a quadrilateral?',
  '[{"id":"a","text":"$180^\\\\circ$"},{"id":"b","text":"$360^\\\\circ$"},{"id":"c","text":"$540^\\\\circ$"},{"id":"d","text":"$720^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Use the formula $(n - 2) × 180$. For a quadrilateral, $n = 4$. $(4 - 2) × 180 = 2 × 180 = 360^\\circ$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_043_21',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'A regular polygon has 15 sides. What is the measure of each interior angle?',
  NULL,
  '156',
  '\\textbf{Calculation and Logic:}

Total sum: $(15 - 2) × 180 = 13 × 180 = 2,340^\\circ$. Measure of one angle: $2,340 / 15$. Performing the division results in 156. Each interior angle is 156 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_22',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'If the sum of the interior angles of a polygon is $2,700^\\circ$, how many sides does it have?',
  '[{"id":"a","text":"13"},{"id":"b","text":"15"},{"id":"c","text":"17"},{"id":"d","text":"19"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$(n - 2) × 180 = 2700$. Divide by 180: $n - 2 = 15$. Add 2: $n = 17$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_23',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'In a convex hexagon, five of the angles measure $100^\\circ, 110^\\circ, 120^\\circ, 130^\\circ,$ and $140^\\circ$. What is the measure of the sixth angle?',
  '[{"id":"a","text":"$100^\\\\circ$"},{"id":"b","text":"$110^\\\\circ$"},{"id":"c","text":"$120^\\\\circ$"},{"id":"d","text":"$130^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Hexagon interior sum: $(6 - 2) × 180 = 720^\\circ$. Sum of five known angles: $100 + 110 + 120 + 130 + 140 = 600^\\circ$. Sixth angle: $720 - 600 = 120^\\circ$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_24',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'Which polygon has an interior angle sum equal to its exterior angle sum?',
  '[{"id":"a","text":"Triangle"},{"id":"b","text":"Quadrilateral"},{"id":"c","text":"Pentagon"},{"id":"d","text":"Hexagon"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Exterior sum is always $360^\\circ$. Interior sum of a quadrilateral is $(4 - 2) × 180 = 360^\\circ$. Therefore, the quadrilateral is the only polygon where these two sums are equal.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_043_25',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'What is the measure of one exterior angle of a regular decagon?',
  NULL,
  '36',
  '\\textbf{Calculation and Logic:}

Total exterior sum = $360^\\circ$. A decagon has $n = 10$ sides. One exterior angle: $360 / 10 = 36^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_26',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'The measure of each interior angle of a regular polygon is $140^\\circ$. How many sides does it have?',
  '[{"id":"a","text":"7"},{"id":"b","text":"8"},{"id":"c","text":"9"},{"id":"d","text":"10"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Exterior angle: $180 - 140 = 40^\\circ$. Number of sides $n = 360 / 40 = 9$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_27',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'A polygon has $n$ sides. If each interior angle is $150^\\circ$, what is the sum of the interior angles?',
  '[{"id":"a","text":"$1,080^\\\\circ$"},{"id":"b","text":"$1,440^\\\\circ$"},{"id":"c","text":"$1,800^\\\\circ$"},{"id":"d","text":"$2,160^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Exterior angle: $180 - 150 = 30^\\circ$. Number of sides $n = 360 / 30 = 12$. Total interior sum: $(12 - 2) × 180 = 10 × 180 = 1,800^\\circ$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_28',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'Is it possible for a regular polygon to have an interior angle of $70^\\circ$?',
  '[{"id":"a","text":"Yes, it would be a triangle."},{"id":"b","text":"Yes, it would be a heptagon."},{"id":"c","text":"No, because the exterior angle would not divide 360 evenly."},{"id":"d","text":"No, because $n$ would be less than 3."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

If interior is 70, exterior is $180 - 70 = 110$. Number of sides $n = 360 / 110 \\approx 3.27$. Since a polygon must have an integer number of sides, this is impossible. Additionally, the smallest interior angle for a regular polygon is $60^\\circ$ (equilateral triangle).',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_043_29',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'In a quadrilateral, the angles are $x, 2x, 3x,$ and $4x$. What is the measure of the smallest angle?',
  NULL,
  '36',
  '\\textbf{Calculation and Logic:}

Sum of angles: $x + 2x + 3x + 4x = 10x$. Set equal to 360: $10x = 360 → x = 36$. The smallest angle is $x = 36^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_30',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'Which of the following is the sum of interior angles for a 20-gon?',
  '[{"id":"a","text":"$3,240^\\\\circ$"},{"id":"b","text":"$3,600^\\\\circ$"},{"id":"c","text":"$3,960^\\\\circ$"},{"id":"d","text":"$4,320^\\\\circ$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

$(20 - 2) × 180 = 18 × 180 = 3,240^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_31',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'A regular polygon has an exterior angle of $x^\\circ$ and an interior angle of $(2x + 60)^\\circ$. How many sides does it have?',
  '[{"id":"a","text":"6"},{"id":"b","text":"8"},{"id":"c","text":"9"},{"id":"d","text":"12"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

$x + (2x + 60) = 180 → 3x = 120 → x = 40$. Exterior angle is 40. $n = 360 / 40 = 9$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_32',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'A triangle has two angles measuring $45^\\circ$ and $55^\\circ$. What is the measure of the third angle?',
  NULL,
  '80',
  '\\textbf{Calculation and Logic:}

$180 - (45 + 55) = 180 - 100 = 80^\\circ$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_043_33',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'What is the sum of the interior angles of a heptagon?',
  '[{"id":"a","text":"$720^\\\\circ$"},{"id":"b","text":"$900^\\\\circ$"},{"id":"c","text":"$1,080^\\\\circ$"},{"id":"d","text":"$1,260^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

A heptagon has $n = 7$ sides. $(7 - 2) × 180 = 5 × 180 = 900^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_34',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'If a regular polygon has 20 sides, what is the measure of each exterior angle?',
  '[{"id":"a","text":"$18^\\\\circ$"},{"id":"b","text":"$20^\\\\circ$"},{"id":"c","text":"$36^\\\\circ$"},{"id":"d","text":"$72^\\\\circ$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

$360 / 20 = 18^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_35',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'The ratio of an interior angle to an exterior angle of a regular polygon is 7:2. How many sides does the polygon have?',
  NULL,
  '9',
  '\\textbf{Calculation and Logic:}

$7x + 2x = 180 → 9x = 180 → x = 20$. Exterior angle = $2(20) = 40^\\circ$. Number of sides $n = 360 / 40 = 9$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_36',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'Which of the following is NOT possible for an exterior angle of a regular polygon?',
  '[{"id":"a","text":"$60^\\\\circ$"},{"id":"b","text":"$90^\\\\circ$"},{"id":"c","text":"$100^\\\\circ$"},{"id":"d","text":"$120^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

For a regular polygon, $360/e$ must be an integer $\\ge 3$. $360/60=6$, $360/90=4$, $360/120=3$. $360/100 = 3.6$, which is not an integer.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_043_37',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'In a pentagon, four angles measure $110^\\circ, 100^\\circ, 90^\\circ,$ and $120^\\circ$. Find the fifth angle.',
  '[{"id":"a","text":"$110^\\\\circ$"},{"id":"b","text":"$120^\\\\circ$"},{"id":"c","text":"$130^\\\\circ$"},{"id":"d","text":"$140^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Pentagon sum = $540^\\circ$. Sum of four: $110 + 100 + 90 + 120 = 420^\\circ$. Fifth angle: $540 - 420 = 120^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_38',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'A regular polygon has each exterior angle measuring $15^\\circ$. How many sides does it have?',
  NULL,
  '24',
  '\\textbf{Calculation and Logic:}

$n = 360 / 15 = 24$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_39',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'If the number of sides of a regular polygon is doubled, what happens to the sum of the exterior angles?',
  '[{"id":"a","text":"It is doubled."},{"id":"b","text":"It is halved."},{"id":"c","text":"It stays the same."},{"id":"d","text":"It increases by $360^\\\\circ$."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

The sum of exterior angles for any convex polygon is always $360^\\circ$, independent of $n$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_40',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'Sum of exterior angles of a triangle?',
  '[{"id":"a","text":"$180^\\\\circ$"},{"id":"b","text":"$360^\\\\circ$"},{"id":"c","text":"$540^\\\\circ$"},{"id":"d","text":"$720^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Always $360^\\circ$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_043_41',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'A regular octagon has how many diagonals?',
  NULL,
  '20',
  '\\textbf{Calculation and Logic:}

$D = (n(n - 3))/(2)$. For $n = 8$: $D = (8(5))/(2) = 40 / 2 = 20$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_42',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'If each interior angle of a regular polygon is $144^\\circ$, what is its name?',
  '[{"id":"a","text":"Hexagon"},{"id":"b","text":"Octagon"},{"id":"c","text":"Decagon"},{"id":"d","text":"Dodecagon"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To identify the polygon by name, we first need to determine the number of sides ($n$) based on the given interior angle measure.

\\textbf{Calculation and Logic:}

First, find the measure of one exterior angle by subtracting the interior angle from 180 degrees: $180 - 144 = 36^\\circ$. Next, use the exterior angle sum property to solve for $n$: $n = 360 / 36$. Performing the division results in 10. A polygon with 10 sides is called a decagon.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_43',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'In similar quadrilaterals $ABCD$ and $PQRS$, the ratio of their corresponding sides is 2:3. If the sum of the angles in $ABCD$ is $K$, what is the sum of the angles in $PQRS$?',
  '[{"id":"a","text":"$K$"},{"id":"b","text":"$1.5K$"},{"id":"c","text":"$2.25K$"},{"id":"d","text":"$360^\\\\circ$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The sum of the interior angles of a polygon is determined solely by the number of sides it has, not by the length of its sides or its overall area.

\\textbf{Calculation and Logic:}

Both figures are quadrilaterals, meaning they both have exactly 4 sides. According to the formula $(n-2) × 180$, the interior angle sum for any quadrilateral is $(4-2) × 180 = 360^\\circ$. Therefore, $K = 360^\\circ$. Since $PQRS$ is also a quadrilateral, its angle sum must also be $360^\\circ$, which is equal to $K$. Similarity affects side lengths and area, but it does not change the polygon''s fundamental angle sum.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_44',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'A convex polygon has $14$ sides. What is the total sum of its interior angles in degrees?',
  NULL,
  '2160',
  '\\textbf{Conceptual Explanation:}

The sum of interior angles increases as more sides are added to a polygon. We apply the standard polygon sum formula to calculate this total.

\\textbf{Calculation and Logic:}

Identify the number of sides, which is $n = 14$. Apply the formula: $S = (n - 2) × 180$. Substitute 14 for $n$: $S = (14 - 2) × 180$. Simplify the subtraction: $S = 12 × 180$. Perform the multiplication: $12 × 100 = 1200$ and $12 × 80 = 960$. Adding these together, $1200 + 960 = 2,160$. The total sum is 2,160 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_45',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'Which of the following values could NOT be the sum of the interior angles of a convex polygon?',
  '[{"id":"a","text":"$180^\\\\circ$"},{"id":"b","text":"$360^\\\\circ$"},{"id":"c","text":"$450^\\\\circ$"},{"id":"d","text":"$540^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The sum of interior angles must be a multiple of 180 degrees because the formula is $(n-2) × 180$, where $n-2$ must be a positive integer.

\\textbf{Calculation and Logic:}

Test each choice by dividing by 180:

$180 / 180 = 1$ (possible, $n=3$).

$360 / 180 = 2$ (possible, $n=4$).

$540 / 180 = 3$ (possible, $n=5$).

$450 / 180 = 2.5$.

Because 450 is not an even multiple of 180, it is mathematically impossible for a convex polygon to have an interior sum of 450 degrees.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_043_46',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'A regular polygon is such that the ratio of its number of diagonals to its number of sides is 2:1. How many sides does the polygon have?',
  '[{"id":"a","text":"5"},{"id":"b","text":"7"},{"id":"c","text":"9"},{"id":"d","text":"10"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We use the diagonal formula $D = (n(n-3))/(2)$ and the given ratio to set up an algebraic equation to solve for $n$.

\\textbf{Calculation and Logic:}

The ratio of diagonals to sides is $D/n = 2/1$. Substitute the formula for $D$: $(n(n-3))/(2) ÷ n = 2$. Simplify the left side by canceling out $n$: $(n-3)/(2) = 2$. Multiply both sides by 2: $n - 3 = 4$. Add 3 to both sides: $n = 7$. The polygon has 7 sides.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_47',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'In a regular polygon, each exterior angle is $12^\\circ$. What is the sum of the interior angles of this polygon?',
  NULL,
  '5040',
  '\\textbf{Conceptual Explanation:}

This is a two-step problem. First, find the number of sides using the exterior angle measure. Second, use the number of sides to find the total interior sum.

\\textbf{Calculation and Logic:}

Step 1: Find the number of sides $n$. $n = 360 / 12 = 30$. Step 2: Find the interior sum using $n = 30$. $S = (30 - 2) × 180$. $S = 28 × 180$. Perform the multiplication: $28 × 18 = 504$. Therefore, $28 × 180 = 5,040$. The total interior sum is 5,040 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_043_48',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'mcq',
  'math',
  'If a convex polygon has $n$ sides, how many triangles can it be divided into by drawing all possible diagonals from a single vertex?',
  '[{"id":"a","text":"$n$"},{"id":"b","text":"$n - 1$"},{"id":"c","text":"$n - 2$"},{"id":"d","text":"$n - 3$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This concept forms the basis of the interior angle sum formula. Every time you draw a diagonal from one vertex to another, you create a new triangle within the polygon.

\\textbf{Calculation and Logic:}

Consider a square ($n=4$). One diagonal from a vertex creates 2 triangles ($4-2$). Consider a pentagon ($n=5$). Two diagonals from a single vertex create 3 triangles ($5-2$). This pattern holds for all convex polygons: the number of triangles is always 2 less than the number of sides. Thus, the correct expression is $n - 2$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_043_49',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
),
  (
  'spr',
  'math',
  'A regular polygon has interior angles that are $150^\\circ$ each. If the side length of this polygon is 5 units, what is the perimeter of the polygon?',
  NULL,
  '60',
  '\\textbf{Conceptual Explanation:}

Perimeter is the total length of the boundary, calculated by multiplying the number of sides by the length of one side. We must first find the number of sides from the angle measure.

\\textbf{Calculation and Logic:}

Step 1: Find the exterior angle. $180 - 150 = 30^\\circ$. Step 2: Find the number of sides $n$. $n = 360 / 30 = 12$. Step 3: Calculate the perimeter. $\\text{Perimeter} = n × \\text{side length}$. $\\text{Perimeter} = 12 × 5 = 60$. The perimeter of the regular 12-gon is 60 units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_043_50',
  'Lines, angles, parallel/perpendicular lines',
  'Angles in Polygons'
)
ON CONFLICT (bank_item_id) DO NOTHING;

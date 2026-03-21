-- Practice-mode math from lid_046.tex (sat_lid_046)
-- Chapter: Triangles, Pythagorean theorem, similar triangles | Topic: Similar Triangles
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_046_N, practice module/set 0.

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
  'In the figure below, $\\triangle ABC$ is similar to $\\triangle DEF$. If the ratio of the length of side $AB$ to the length of side $DE$ is $2:5$, and the length of side $BC$ is 8, what is the length of side $EF$? \\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[thick] (0,0) node[anchor=north]{$A$} -- (3,0) node[anchor=north]{$C$} -- (1,2) node[anchor=south]{$B$} -- cycle; \\begin{scope}[shift={(5,0)}] \\draw[thick] (0,0) node[anchor=north]{$D$} -- (7.5,0) node[anchor=north]{$F$} -- (2.5,5) node[anchor=south]{$E$} -- cycle; \\end{scope} \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"3.2"},{"id":"b","text":"10"},{"id":"c","text":"16"},{"id":"d","text":"20"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

When two triangles are similar, the ratios of their corresponding sides are equal. We can set up a proportion using the given scale factor of $2:5$.

\\textbf{Calculation and Logic:}

The ratio is $(AB)/(DE) = (BC)/(EF)$.

Substituting the known values: $(2)/(5) = (8)/(EF)$.

Cross-multiplying gives $2(EF) = 40$.

Dividing by 2, we find $EF = 20$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_046_1',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\overline{BD}$ is parallel to $\\overline{AE}$. If $CD = 6$, $DE = 3$, and $BC = 8$, what is the length of segment $AB$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north]{$C$} -- (6,0) node[anchor=north]{$E$}; \\draw[thick] (0,0) -- (6,3) node[anchor=south]{$A$}; \\draw[thick] (4,0) node[anchor=north]{$D$} -- (4,2) node[anchor=south west]{$B$}; \\draw[thick] (6,0) -- (6,3); \\node at (2,-0.4) {6}; \\node at (5,-0.4) {3}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"4"},{"id":"b","text":"12"},{"id":"c","text":"15"},{"id":"d","text":"24"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Because $\\overline{BD} \\parallel \\overline{AE}$, $\\triangle CBD$ is similar to $\\triangle CAE$ by Angle-Angle similarity. Note that the side $CE$ is the sum of $CD$ and $DE$.

\\textbf{Calculation and Logic:}

First, find $CE$: $6 + 3 = 9$.

The ratio of the sides is $(CD)/(CE) = (BC)/(AC)$.

$(6)/(9) = (8)/(AC) → (2)/(3) = (8)/(AC)$.

$2(AC) = 24 → AC = 12$.

The question asks for $AB$, which is $AC - BC$.

$AB = 12 - 8 = 4$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_2',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'spr',
  'math',
  'In right triangle $ABC$, an altitude is drawn from the right angle $C$ to the hypotenuse $AB$, intersecting at point $D$. If $AD = 4$ and $DB = 9$, what is the length of the altitude $CD$?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

When an altitude is drawn to the hypotenuse of a right triangle, it creates two smaller triangles that are both similar to the original triangle and to each other. This allows us to use the Geometric Mean theorem: $CD^2 = AD × DB$.

\\textbf{Calculation and Logic:}

Using the similarity ratio $(AD)/(CD) = (CD)/(DB)$:

$CD^2 = 4 × 9$.

$CD^2 = 36$.

$CD = 6$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_3',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'A 6-foot tall man stands so that his shadow exactly overlaps the end of the shadow cast by a 24-foot tall flagpole. If the man is 30 feet away from the flagpole, how long is the man''s shadow, in feet? \\begin{center} \\begin{tikzpicture}[scale=0.15] \\draw[thick] (0,0) -- (40,0); \\draw[ultra thick] (0,24) -- (0,0) node[midway, left]{24}; \\draw[thick] (30,6) -- (30,0) node[midway, right]{6}; \\draw[dashed] (0,24) -- (40,0); \\node at (20, -3) {30}; \\node at (35, -3) {$s$}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"6"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"15"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The flagpole and the man create two nested similar right triangles because they both stand perpendicular to the ground and share the angle of the sun''s rays. Let $s$ be the length of the man''s shadow. The total base of the large triangle is $30 + s$.

\\textbf{Calculation and Logic:}

Set up the proportion: $\\frac{\\text{Height of Man}}{\\text{Height of Flagpole}} = \\frac{\\text{Shadow of Man}}{\\text{Total Base}}$

$(6)/(24) = (s)/(30 + s)$

$(1)/(4) = (s)/(30 + s)$

$30 + s = 4s → 30 = 3s → s = 10$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_4',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\overline{XY} \\parallel \\overline{RS}$. If $PX = 4$, $XR = 6$, and $XY = 5$, what is the length of segment $RS$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=south]{$P$} -- (-2,-4) node[anchor=north]{$R$} -- (2,-4) node[anchor=north]{$S$} -- cycle; \\draw[thick] (-0.8,-1.6) node[anchor=east]{$X$} -- (0.8,-1.6) node[anchor=west]{$Y$}; \\node at (-0.3, -0.8) {4}; \\node at (-1.5, -2.8) {6}; \\node at (0, -1.8) {5}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"7.5"},{"id":"b","text":"10"},{"id":"c","text":"12.5"},{"id":"d","text":"15"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Because $\\overline{XY}$ is parallel to $\\overline{RS}$, $\\triangle PXY$ is similar to $\\triangle PRS$. The side $PR$ corresponds to $PX$, and $RS$ corresponds to $XY$. Note that $PR = PX + XR$.

\\textbf{Calculation and Logic:}

$PR = 4 + 6 = 10$.

The proportion is $(PX)/(PR) = (XY)/(RS)$.

$(4)/(10) = (5)/(RS) → 4(RS) = 50$.

$RS = 50 / 4 = 12.5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_5',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'spr',
  'math',
  'The ratio of the lengths of corresponding sides of two similar triangles is $3:7$. If the area of the smaller triangle is 18, what is the area of the larger triangle?',
  NULL,
  '98',
  '\\textbf{Conceptual Explanation:}

For similar figures, if the side ratio is $a:b$, the area ratio is $a^2:b^2$. This is a consistent rule for all similar shapes on the SAT.

\\textbf{Calculation and Logic:}

Side ratio $= 3:7$.

Area ratio $= 3^2:7^2 = 9:49$.

Set up the proportion: $(9)/(49) = (18)/(\\text{Area)_{large}}$.

Since $9 × 2 = 18$, we find $\\text{Area}_{large} = 49 × 2 = 98$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_6',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\angle ABC = \\angle ADE = 90^\\circ$. If $AD = 15$, $AE = 17$, and $AC = 10$, what is the length of segment $BC$? \\begin{center} \\begin{tikzpicture}[scale=0.4] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (15,0) node[anchor=north]{$D$} -- (15,8) node[anchor=south west]{$E$} -- cycle; \\draw[thick] (10,0) node[anchor=north]{$C$} -- (10,5.33) node[anchor=south east]{$B$}; \\draw (14,0) -- (14,1) -- (15,1); \\draw (9,0) -- (9,1) -- (10,1); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"5.33"},{"id":"b","text":"6"},{"id":"c","text":"8"},{"id":"d","text":"10.67"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The triangles $\\triangle ABC$ and $\\triangle ADE$ share angle $A$ and both have a right angle, so they are similar by AA. We first find the missing side $DE$ of the large triangle using the Pythagorean theorem, then use similarity.

\\textbf{Calculation and Logic:}

In $\\triangle ADE$, $DE = \\sqrt{17^2 - 15^2} = \\sqrt{289 - 225} = \\sqrt{64} = 8$.

The proportion is $(AC)/(AD) = (BC)/(DE)$.

$(10)/(15) = (BC)/(8) → (2)/(3) = (BC)/(8)$.

$3(BC) = 16 → BC = 16/3 = 5.33...$',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_7',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\overline{AB} \\parallel \\overline{CD}$. If $AE = 12$, $ED = 4$, and $AB = 15$, what is the length of segment $CD$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=east]{$A$} -- (4,2) node[anchor=south]{$E$} -- (8,0) node[anchor=west]{$B$} -- cycle; \\draw[thick] (4,2) -- (2.6,2.7) node[anchor=south]{$D$} -- (5.4,2.7) node[anchor=south]{$C$} -- cycle; \\draw[thick] (0,0) -- (8,0); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"5"},{"id":"b","text":"7.5"},{"id":"c","text":"10"},{"id":"d","text":"45"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When lines are parallel in this "hourglass" shape, the triangles $\\triangle ABE$ and $\\triangle DCE$ are similar because of alternate interior angles. Side $AE$ corresponds to $DE$, and $AB$ corresponds to $CD$.

\\textbf{Calculation and Logic:}

The proportion is $(AE)/(DE) = (AB)/(CD)$.

$(12)/(4) = (15)/(CD) → 3 = (15)/(CD)$.

$CD = 15 / 3 = 5$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_8',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'If two triangles are similar, which of the following MUST be true?',
  '[{"id":"a","text":"Their areas are equal."},{"id":"b","text":"Their perimeters are equal."},{"id":"c","text":"Their corresponding angles are equal."},{"id":"d","text":"Their corresponding sides are equal."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Similarity by definition means the shapes are the same but not necessarily the same size. Therefore, angles are preserved, but side lengths are scaled.

\\textbf{Calculation and Logic:}

Choice C is the definition of similarity. Choice D describes "congruent" triangles, not necessarily similar ones.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_046_9',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'A triangle has sides 6, 8, and 10. A second triangle, similar to the first, has a longest side of 15. What is the perimeter of the second triangle?',
  '[{"id":"a","text":"24"},{"id":"b","text":"30"},{"id":"c","text":"36"},{"id":"d","text":"48"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

We find the scale factor by comparing the longest side of each triangle. Then we can either find the individual sides of the new triangle or scale the entire perimeter of the first triangle.

\\textbf{Calculation and Logic:}

Perimeter of 1st triangle $= 6 + 8 + 10 = 24$.

Scale factor $= \\frac{\\text{New Longest}}{\\text{Old Longest}} = (15)/(10) = 1.5$.

New Perimeter $= 24 × 1.5 = 36$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_10',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'spr',
  'math',
  'In the figure below, $\\overline{DE} \\parallel \\overline{AC}$. If $BD = 3$, $DA = 2$, and the area of $\\triangle BDE$ is 18, what is the area of $\\triangle BAC$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north]{$A$} -- (2,4) node[anchor=south]{$B$} -- (5,0) node[anchor=north]{$C$} -- cycle; \\draw[thick] (0.8,1.6) node[anchor=east]{$D$} -- (3.2,1.6) node[anchor=west]{$E$}; \\end{tikzpicture} \\end{center}',
  NULL,
  '50',
  '\\textbf{Conceptual Explanation:}

$\\triangle BDE \\sim \\triangle BAC$ because $\\overline{DE} \\parallel \\overline{AC}$. The side $BA = BD + DA$. We use the square of the side ratio to find the area ratio.

\\textbf{Calculation and Logic:}

$BA = 3 + 2 = 5$.

Side ratio (Small:Large) $= 3:5$.

Area ratio $= 3^2:5^2 = 9:25$.

$(9)/(25) = (18)/(\\text{Area)_{BAC}}$.

Since $9 × 2 = 18$, Area$_{BAC} = 25 × 2 = 50$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_11',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\overline{AD}$ and $\\overline{BE}$ intersect at $C$. If $\\angle A = \\angle D$, $AC = 10$, $CD = 5$, and $BC = 8$, what is the length of segment $CE$? \\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[thick] (0,3) node[anchor=south]{$A$} -- (4,0) node[anchor=north]{$C$} -- (8,3) node[anchor=south]{$E$}; \\draw[thick] (2,-2) node[anchor=north]{$B$} -- (4,0) -- (6,-2) node[anchor=north]{$D$}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"4"},{"id":"b","text":"10"},{"id":"c","text":"16"},{"id":"d","text":"20"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The triangles $\\triangle ABC$ and $\\triangle DEC$ are similar by AA (given $\\angle A = \\angle D$ and vertical angles at $C$ are equal). Side $AC$ corresponds to $DC$ and $BC$ corresponds to $EC$.

\\textbf{Calculation and Logic:}

Proportion: $(AC)/(DC) = (BC)/(EC)$.

$(10)/(5) = (8)/(EC) → 2 = (8)/(EC)$.

$EC = 4$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_12',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'A right triangle has legs of length 5 and 12. A second right triangle is similar to the first and has an area of 270. What is the length of the hypotenuse of the second triangle?',
  '[{"id":"a","text":"13"},{"id":"b","text":"26"},{"id":"c","text":"39"},{"id":"d","text":"65"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Find the area and hypotenuse of the first triangle. Use the area ratio to find the scale factor, then apply the scale factor to the hypotenuse.

\\textbf{Calculation and Logic:}

Area$_1 = (1)/(2)(5)(12) = 30$.

Hypotenuse$_1 = \\sqrt{5^2 + 12^2} = 13$.

Area ratio $= (270)/(30) = 9$.

Scale factor $= \\sqrt{9} = 3$.

Hypotenuse$_2 = 13 × 3 = 39$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_13',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC \\sim \\triangle DEF$. If the perimeter of $\\triangle ABC$ is 30 and the perimeter of $\\triangle DEF$ is 45, what is the ratio of the length of $AC$ to the length of $DF$?',
  '[{"id":"a","text":"$2:3$"},{"id":"b","text":"$4:9$"},{"id":"c","text":"$3:2$"},{"id":"d","text":"$1:2$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The ratio of the perimeters of similar triangles is equal to the ratio of their corresponding side lengths.

\\textbf{Calculation and Logic:}

Ratio $= (30)/(45)$.

Simplify by dividing both by 15: $(2)/(3)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_14',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In right triangle $ABC$, $\\angle C = 90^\\circ$. If $\\triangle ABC \\sim \\triangle DEF$ and $\\cos A = 0.6$, what is the value of $\\sin E$?',
  '[{"id":"a","text":"0.4"},{"id":"b","text":"0.6"},{"id":"c","text":"0.8"},{"id":"d","text":"1.0"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Similar triangles have equal corresponding angles. $\\angle A = \\angle D$ and $\\angle B = \\angle E$. In a right triangle, $\\sin E$ is the same as $\\sin B$. Since $A$ and $B$ are complementary, $\\sin B = \\cos A$.

\\textbf{Calculation and Logic:}

Because $\\triangle ABC \\sim \\triangle DEF$, $\\angle E$ corresponds to $\\angle B$.

In $\\triangle ABC$, $A + B = 90^\\circ$.

Therefore, $\\sin B = \\cos A = 0.6$.

So, $\\sin E = 0.6$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_15',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC \\sim \\triangle DEF$. If the ratio of the area of $\\triangle ABC$ to the area of $\\triangle DEF$ is $1:16$ and $BC = 3$, what is the length of $EF$?',
  '[{"id":"a","text":"9"},{"id":"b","text":"12"},{"id":"c","text":"24"},{"id":"d","text":"48"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The ratio of the areas of similar triangles is the square of the ratio of their corresponding side lengths. To find the side ratio, we take the square root of the area ratio.

\\textbf{Calculation and Logic:}

Area ratio $= 1:16$.

Side ratio $= \\sqrt{1} : \\sqrt{16} = 1:4$.

Since $BC$ corresponds to $EF$: $(1)/(4) = (3)/(EF) → EF = 12$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_16',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, $\\triangle OPQ$ has vertices $O(0,0)$, $P(0,6)$, and $Q(8,0)$. A second triangle, $\\triangle ORS$, is similar to $\\triangle OPQ$ and has a vertex $R(0,3)$. If point $S$ lies on the $x$-axis, what is the area of $\\triangle ORS$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"12"},{"id":"c","text":"24"},{"id":"d","text":"48"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We first determine the area of the original triangle and the scale factor between the two triangles using the corresponding vertical legs ($OP$ and $OR$).

\\textbf{Calculation and Logic:}

Area of $\\triangle OPQ = (1)/(2) × 8 × 6 = 24$.

Side ratio (New:Old) $= (OR)/(OP) = (3)/(6) = (1)/(2)$.

Area ratio $= ((1)/(2))^2 = (1)/(4)$.

Area of $\\triangle ORS = 24 × (1)/(4) = 6$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_17',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'Two similar isosceles triangles have perimeters in the ratio $3:5$. If the base of the larger triangle is 20, what is the base of the smaller triangle?',
  '[{"id":"a","text":"10"},{"id":"b","text":"12"},{"id":"c","text":"15"},{"id":"d","text":"33.3"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Perimeter ratios are identical to side length ratios in similar triangles.

\\textbf{Calculation and Logic:}

$(3)/(5) = \\frac{\\text{Base}_{small}}{20}$.

$5(\\text{Base}_{small}) = 60 → \\text{Base}_{small} = 12$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_18',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'spr',
  'math',
  'In right triangle $ABC$, an altitude $CD$ is drawn to hypotenuse $AB$. If $CD = 4$ and $AD = 2$, what is the length of segment $DB$?',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

Using the Right Triangle Altitude Theorem (Geometric Mean), the altitude squared equals the product of the segments of the hypotenuse: $CD^2 = AD \\cdot DB$.

\\textbf{Calculation and Logic:}

$4^2 = 2 \\cdot DB$.

$16 = 2 \\cdot DB → DB = 8$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_19',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'A map is drawn to a scale where 1 inch represents 50 miles. A triangular plot of land on the map has sides 3 in, 4 in, and 5 in. What is the actual length of the shortest side of the land in miles?',
  '[{"id":"a","text":"1.5"},{"id":"b","text":"150"},{"id":"c","text":"200"},{"id":"d","text":"250"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The map triangle is similar to the actual land triangle. The scale factor is 50 miles/inch.

\\textbf{Calculation and Logic:}

Shortest side on map $= 3$ inches.

Actual length $= 3 \\text{ in} × 50 \\text{ miles/in} = 150$ miles.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_20',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'The areas of two similar triangles are $25 \\text{ cm}^2$ and $49 \\text{ cm}^2$. If the perimeter of the smaller triangle is 30 cm, what is the perimeter of the larger triangle?',
  '[{"id":"a","text":"42"},{"id":"b","text":"58.8"},{"id":"c","text":"60"},{"id":"d","text":"84"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Area ratio is the square of the perimeter ratio.

\\textbf{Calculation and Logic:}

Area ratio $= 25:49$.

Perimeter ratio $= \\sqrt{25} : \\sqrt{49} = 5:7$.

$(5)/(7) = (30)/(P_{large)} → 5P_{large} = 210 → P_{large} = 42$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_21',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In $\\triangle ABC$ and $\\triangle DEF$, $\\frac{AB}{DE} = \\frac{BC}{EF}$. Which additional piece of information is sufficient to prove the triangles are similar?',
  '[{"id":"a","text":"$\\\\angle A = \\\\angle D$"},{"id":"b","text":"$\\\\angle B = \\\\angle E$"},{"id":"c","text":"$\\\\angle C = \\\\angle F$"},{"id":"d","text":"$AC = DF$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

SAS (Side-Angle-Side) Similarity requires two proportional sides and the congruency of the included angle (the angle formed by those sides).

\\textbf{Calculation and Logic:}

The angle between sides $AB$ and $BC$ is $\\angle B$. The angle between $DE$ and $EF$ is $\\angle E$. Thus, $\\angle B = \\angle E$ is required.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_22',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC$ is a right triangle with $\\angle C = 90^\\circ$. If $\\triangle ABC \\sim \\triangle DEF$ and the scale factor is 3, what is the value of $\\tan E$?',
  '[{"id":"a","text":"$\\\\tan B$"},{"id":"b","text":"$3 \\\\tan B$"},{"id":"c","text":"$\\\\frac{1}{3} \\\\tan B$"},{"id":"d","text":"$\\\\tan A$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Similarity preserves angle measures. Corresponding angles are equal regardless of the scale factor.

\\textbf{Calculation and Logic:}

$\\angle E$ corresponds to $\\angle B$. Therefore, $\\angle E = \\angle B$, and $\\tan E = \\tan B$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_23',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'spr',
  'math',
  'Triangle $A$ has sides of 10, 24, and 26. Triangle $B$ is similar to Triangle $A$ and has a perimeter of 30. What is the length of the shortest side of Triangle $B$?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

Find the perimeter of Triangle $A$, determine the scale factor, and apply it to the shortest side.

\\textbf{Calculation and Logic:}

Perimeter $A = 10 + 24 + 26 = 60$.

Scale factor $= \\frac{\\text{Perimeter } B}{\\text{Perimeter } A} = (30)/(60) = 0.5$.

Shortest side $B = 10 × 0.5 = 5$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_24',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In a photo, a tree that is actually 20 feet tall appears to be 2 inches tall. A person in the same photo appears to be 0.6 inches tall. How tall is the person in feet?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"12"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This is a similarity problem where the photo and reality are the similar "objects."

\\textbf{Calculation and Logic:}

$\\frac{2 \\text{ in}}{20 \\text{ ft}} = \\frac{0.6 \\text{ in}}{x \\text{ ft}}$.

$2x = 12 → x = 6$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_25',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'Two similar triangles have areas in the ratio $n:1$. What is the ratio of their perimeters?',
  '[{"id":"a","text":"$n:1$"},{"id":"b","text":"$n^2:1$"},{"id":"c","text":"$\\\\sqrt{n}:1$"},{"id":"d","text":"$1:n$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Perimeter ratio is the linear ratio (side ratio), which is the square root of the area ratio.

\\textbf{Calculation and Logic:}

Ratio $= \\sqrt{n} : \\sqrt{1} = \\sqrt{n} : 1$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_26',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC \\sim \\triangle ADE$. If $BC = 5$, $DE = 15$, and $AC = 4$, what is the length of $CE$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=south]{$A$} -- (-1.5,-3) node[anchor=north]{$B$} -- (1.5,-3) node[anchor=north]{$C$} -- cycle; \\draw[thick] (-1.5,-3) -- (-3,-6) node[anchor=north]{$D$} -- (3,-6) node[anchor=north]{$E$} -- (1.5,-3); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"8"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"16"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Note that $AE = AC + CE$. The ratio of the triangles is $BC:DE$.

\\textbf{Calculation and Logic:}

Scale factor $= 15/5 = 3$.

$AE = 3 × AC = 3 × 4 = 12$.

$CE = AE - AC = 12 - 4 = 8$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_27',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'spr',
  'math',
  'If the area of a triangle is tripled while maintaining similarity, by what factor is the perimeter multiplied? (Round to two decimal places)',
  NULL,
  '1.73',
  '\\textbf{Conceptual Explanation:}

The scale factor of linear dimensions (perimeter) is the square root of the area scale factor.

\\textbf{Calculation and Logic:}

Area factor $= 3$.

Perimeter factor $= \\sqrt{3} \\approx 1.73$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_28',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\angle X = \\angle Z = 90^\\circ$. If $XY = 6$, $YZ = 8$, and $YW = 10$, are triangles $\\triangle XYW$ and $\\triangle ZYW$ similar?',
  '[{"id":"a","text":"Yes, by SSS"},{"id":"b","text":"Yes, by SAS"},{"id":"c","text":"Yes, by AA"},{"id":"d","text":"No"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Check for side proportionality and angle congruency. Both are right triangles and share side $YW$.

\\textbf{Calculation and Logic:}

Without information about the third sides or another angle, similarity cannot be established just by sharing a hypotenuse and a right angle.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_29',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'Two similar triangles have side ratios of $k:1$. If the smaller triangle has an area of $A$, what is the area of the larger triangle?',
  '[{"id":"a","text":"$kA$"},{"id":"b","text":"$k^2A$"},{"id":"c","text":"$A/k$"},{"id":"d","text":"$A/k^2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Area scales with the square of the linear scale factor.

\\textbf{Calculation and Logic:}

Ratio $= k^2 : 1$. Area $= k^2A$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_30',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'A right triangle has a hypotenuse of 10. A similar triangle has a hypotenuse of 5. What is the ratio of the area of the smaller triangle to the larger?',
  '[{"id":"a","text":"$1:2$"},{"id":"b","text":"$1:4$"},{"id":"c","text":"$2:1$"},{"id":"d","text":"$4:1$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The linear ratio is $5:10$, which simplifies to $1:2$.

\\textbf{Calculation and Logic:}

Area ratio $= (1/2)^2 = 1/4$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_31',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In $\\triangle ABC$, $DE$ is parallel to $BC$, where $D$ is on $AB$ and $E$ is on $AC$. If $AD = x$, $DB = x+2$, $AE = 4$, and $EC = 6$, what is $x$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"6"},{"id":"c","text":"8"},{"id":"d","text":"12"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The Side-Splitter Theorem (derived from similarity) states that $(AD)/(DB) = (AE)/(EC)$.

\\textbf{Calculation and Logic:}

$(x)/(x+2) = (4)/(6) = (2)/(3)$.

$3x = 2(x+2) → 3x = 2x + 4 → x = 4$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_32',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'If the ratio of the corresponding altitudes of two similar triangles is $4:9$, what is the ratio of their areas?',
  '[{"id":"a","text":"$2:3$"},{"id":"b","text":"$4:9$"},{"id":"c","text":"$16:81$"},{"id":"d","text":"$64:729$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Altitudes are linear measures. The ratio of areas is the square of any linear ratio.

\\textbf{Calculation and Logic:}

$(4/9)^2 = 16/81$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_33',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'spr',
  'math',
  'Two similar triangles have perimeters of 24 and 36. If the area of the larger triangle is 54, what is the area of the smaller triangle?',
  NULL,
  '24',
  '\\textbf{Conceptual Explanation:}

Linear ratio $= 24/36 = 2/3$. Area ratio $= 4/9$.

\\textbf{Calculation and Logic:}

$(4)/(9) = \\frac{A_{small}}{54}$.

Since $9 × 6 = 54$, $A_{small} = 4 × 6 = 24$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_34',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In right triangle $ABC$, altitude $BD$ is drawn to the hypotenuse. If $AD = 9$ and $AC = 25$, what is the length of side $AB$?',
  '[{"id":"a","text":"12"},{"id":"b","text":"15"},{"id":"c","text":"16"},{"id":"d","text":"20"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The Leg Rule of Geometric Mean states: $AB^2 = AD \\cdot AC$.

\\textbf{Calculation and Logic:}

$AB^2 = 9 \\cdot 25 = 225$.

$AB = \\sqrt{225} = 15$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_35',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'A shadow problem: A 5-foot post casts a 3-foot shadow. At the same time, a building casts a 21-foot shadow. How tall is the building?',
  '[{"id":"a","text":"12.6"},{"id":"b","text":"35"},{"id":"c","text":"63"},{"id":"d","text":"105"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

$\\frac{\\text{Height}_{post}}{\\text{Shadow}_{post}} = \\frac{\\text{Height}_{build}}{\\text{Shadow}_{build}}$.

\\textbf{Calculation and Logic:}

$(5)/(3) = (h)/(21) → 3h = 105 → h = 35$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_36',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC \\sim \\triangle ADE$. If $AB = 6$, $BD = 4$, and the area of $\\triangle ADE$ is 50, what is the area of quadrilateral $BCED$?',
  '[{"id":"a","text":"18"},{"id":"b","text":"32"},{"id":"c","text":"50"},{"id":"d","text":"100"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

$AD = AB + BD = 10$. The area of the quadrilateral is the difference between the large and small triangle areas.

\\textbf{Calculation and Logic:}

Linear ratio $(ABC:ADE) = 6:10 = 3:5$.

Area ratio $= 9:25$.

$(9)/(25) = \\frac{Area_{ABC}}{50} → Area_{ABC} = 18$.

Area$_{BCED} = 50 - 18 = 32$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_37',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'Two triangles are similar. The sides of the first are 4, 5, and 6. The perimeter of the second is 45. What is its longest side?',
  '[{"id":"a","text":"12"},{"id":"b","text":"15"},{"id":"c","text":"18"},{"id":"d","text":"24"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Perimeter of first triangle $= 15$. Scale factor $= 45/15 = 3$.

\\textbf{Calculation and Logic:}

Longest side $= 6 × 3 = 18$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_38',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'Are all equilateral triangles similar?',
  '[{"id":"a","text":"Yes, because all angles are $60^\\\\circ$"},{"id":"b","text":"Yes, because all sides are equal"},{"id":"c","text":"No, only if they have the same area"},{"id":"d","text":"No, only if they are congruent"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Similarity requires equal angles (AA). All equilateral triangles have three $60^\\circ$ angles.

\\textbf{Calculation and Logic:}

By AA similarity, all equilateral triangles are similar.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_39',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'spr',
  'math',
  'The area of a triangle is increased by 44%. By what percentage did the side lengths increase?',
  NULL,
  '20',
  '\\textbf{Conceptual Explanation:}

If Area is multiplied by $1.44$, the sides are multiplied by $\\sqrt{1.44}$.

\\textbf{Calculation and Logic:}

$\\sqrt{1.44} = 1.2$.

An increase of $1.2$ corresponds to a 20% increase.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_40',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC \\sim \\triangle XYZ$. If $\\sin A = 3/5$ and $XY = 15$, what is the length of the side opposite $\\angle X$ in $\\triangle XYZ$ if it is a right triangle?',
  '[{"id":"a","text":"9"},{"id":"b","text":"12"},{"id":"c","text":"15"},{"id":"d","text":"25"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

$\\sin A = \\sin X = 3/5$. In a right triangle, $\\sin X = \\frac{\\text{opp}}{\\text{hyp}}$.

\\textbf{Calculation and Logic:}

$3/5 = (YZ)/(15) → 5(YZ) = 45 → YZ = 9$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_41',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'A triangle has sides 7, 24, 25. A similar triangle has a shortest side of 14. What is its hypotenuse?',
  '[{"id":"a","text":"48"},{"id":"b","text":"50"},{"id":"c","text":"75"},{"id":"d","text":"100"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The shortest side 7 becomes 14. The scale factor is 2.

\\textbf{Calculation and Logic:}

Hypotenuse $= 25 × 2 = 50$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_42',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'Two similar triangles have perimeters $P_1$ and $P_2$. What is the ratio of their areas?',
  '[{"id":"a","text":"$P_1 : P_2$"},{"id":"b","text":"$\\\\sqrt{P_1} : \\\\sqrt{P_2}$"},{"id":"c","text":"$P_1^2 : P_2^2$"},{"id":"d","text":"$1 : 1$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Area ratio is the square of the linear ratio.

\\textbf{Calculation and Logic:}

$(P_1/P_2)^2 = P_1^2/P_2^2$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_43',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'spr',
  'math',
  'A triangle is dilated by a factor of 2.5. What is the ratio of the new area to the old area?',
  NULL,
  '6.25',
  '\\textbf{Conceptual Explanation:}

Area scale factor is the square of the dilation factor.

\\textbf{Calculation and Logic:}

$2.5^2 = 6.25$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_44',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC \\sim \\triangle DEC$. If $AB = 10$, $DE = 4$, and $AC = 15$, what is $DC$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"37.5"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Proportion: $(AB)/(DE) = (AC)/(DC)$.

\\textbf{Calculation and Logic:}

$(10)/(4) = (15)/(DC) → 10(DC) = 60 → DC = 6$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_45',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'Are all right triangles similar?',
  '[{"id":"a","text":"Yes, they all have a $90^\\\\circ$ angle"},{"id":"b","text":"No, they need another angle to be equal"},{"id":"c","text":"No, they must have equal hypotenuses"},{"id":"d","text":"Yes, by HL similarity"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Similarity (AA) requires two angles. A right angle is only one.

\\textbf{Calculation and Logic:}

A $30-60-90$ and a $45-45-90$ are both right triangles but not similar.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_46',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC \\sim \\triangle DEF$. If the perimeter of $\\triangle ABC$ is $12\\sqrt{2}$ and the perimeter of $\\triangle DEF$ is $6\\sqrt{2}$, what is the ratio of their areas?',
  '[{"id":"a","text":"$2:1$"},{"id":"b","text":"$4:1$"},{"id":"c","text":"$\\\\sqrt{2}:1$"},{"id":"d","text":"$1:2$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Linear ratio $= (12\\sqrt{2})/(6\\sqrt{2}) = 2:1$.

\\textbf{Calculation and Logic:}

Area ratio $= 2^2 : 1^2 = 4:1$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_47',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'If $\\triangle ABC \\sim \\triangle DEF$, then $\\frac{Area_{ABC}}{Area_{DEF}} = $?',
  '[{"id":"a","text":"$AB/DE$"},{"id":"b","text":"$(AB/DE)^2$"},{"id":"c","text":"$\\\\sqrt{AB/DE}$"},{"id":"d","text":"$2(AB/DE)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This is the fundamental Area-Side relationship theorem for similarity.

\\textbf{Calculation and Logic:}

Area ratio is the square of the side ratio.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_046_48',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC \\sim \\triangle ADE$. If $BC = x$, $DE = x+3$, $AB = 4$, and $AD = 10$, what is $x$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"3"},{"id":"c","text":"4.5"},{"id":"d","text":"5"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Proportion: $(AB)/(AD) = (BC)/(DE)$.

\\textbf{Calculation and Logic:}

$(4)/(10) = (x)/(x+3) → 4(x+3) = 10x$.

$4x + 12 = 10x → 6x = 12 → x = 2$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_49',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
),
  (
  'spr',
  'math',
  'A triangle with area 10 is dilated by a factor of $k$ to an area of 160. What is $k$?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

Area ratio $= 160/10 = 16$. Dilation factor $k$ is the square root of the area ratio.

\\textbf{Calculation and Logic:}

$k = \\sqrt{16} = 4$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_046_50',
  'Triangles, Pythagorean theorem, similar triangles',
  'Similar Triangles'
)
ON CONFLICT (bank_item_id) DO NOTHING;

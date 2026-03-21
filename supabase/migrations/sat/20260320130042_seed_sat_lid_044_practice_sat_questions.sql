-- Practice-mode math from lid_044.tex (sat_lid_044)
-- Chapter: Triangles, Pythagorean theorem, similar triangles | Topic: Pythagorean Theorem
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_044_N, practice module/set 0.

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
  'spr',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[left]{$A$} -- (3,0) node[below]{$C$} -- (3,5) node[above]{$B$} -- cycle; \\draw (3,0) rectangle (2.7,0.3); \\node at (1.5,-0.4) {3 units}; \\node at (3.8,2.5) {?}; \\node at (0.8,2.8) {$\\sqrt{34}$ units}; \\end{tikzpicture} \\end{center} In the figure shown, $AB = \\sqrt{34}$ units and $AC = 3$ units. If triangle $ABC$ is a right triangle with the right angle at $C$, what is the length of segment $BC$?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

The Pythagorean Theorem states that for any right triangle with legs $a$ and $b$ and hypotenuse $c$, the relationship $a^2 + b^2 = c^2$ must hold. In this problem, we are given the hypotenuse ($AB$) and one leg ($AC$), and we need to solve for the missing leg ($BC$).

\\textbf{Calculation and Logic:}

Identify the known values: $c = \\sqrt{34}$ and $a = 3$. Set up the equation: $3^2 + (BC)^2 = (\\sqrt{34})^2$. Calculate the squares: $9 + (BC)^2 = 34$. Isolate the missing term by subtracting 9 from both sides: $(BC)^2 = 34 - 9$. This gives $(BC)^2 = 25$. To find $BC$, take the square root of both sides: $BC = \\sqrt{25} = 5$. The length of segment $BC$ is 5 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_1',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[thick] (0,0) node[left]{$A$} -- (5,0) node[right]{$C$} -- (5,12) node[above]{$B$} -- cycle; \\draw (5,0) rectangle (4.6,0.4); \\node at (2.5,-0.5) {5}; \\node at (5.5,6) {12}; \\end{tikzpicture} \\end{center} What is the length of the hypotenuse of a right triangle with legs of length 5 and 12?',
  '[{"id":"a","text":"13"},{"id":"b","text":"15"},{"id":"c","text":"17"},{"id":"d","text":"25"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When given both legs of a right triangle, we apply the Pythagorean Theorem ($a^2 + b^2 = c^2$) to find the hypotenuse, which is the longest side opposite the right angle.

\\textbf{Calculation and Logic:}

Assign the leg lengths: $a = 5$ and $b = 12$. Substitute these into the formula: $5^2 + 12^2 = c^2$. Calculate the squares: $25 + 144 = c^2$. Sum the results: $169 = c^2$. Solve for $c$ by taking the square root: $c = \\sqrt{169} = 13$. The hypotenuse is 13 units long.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_2',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.5] \\draw[thick] (0,0) node[left]{$A$} -- (12,0) node[below]{$C$} -- (12,5) node[right]{$B$} -- cycle; \\draw[thick] (5,0) node[below]{$E$} -- (5,2.08) node[above]{$D$}; \\draw (12,0) rectangle (11.5,0.5); \\draw (5,0) rectangle (4.5,0.5); \\node at (2.5,0.5) {5}; \\node at (8.5,0.5) {7}; \\node at (12.5,2.5) {$y$}; \\node at (4.5,1) {$x$}; \\end{tikzpicture} \\end{center} In the figure above, triangle $ABC$ is similar to triangle $ADE$. If $AC = 12$, $AE = 5$, and the area of triangle $ABC$ is 30, what is the value of $x$?',
  NULL,
  '25/12',
  '\\textbf{Conceptual Explanation:}

This problem combines the area of a triangle, the Pythagorean Theorem (to find side lengths if needed), and the properties of similar triangles. Corresponding sides of similar triangles are proportional.

\\textbf{Calculation and Logic:}

First, use the area of triangle $ABC$ to find $y$: $\\text{Area} = (1)/(2) × \\text{base} × \\text{height} → 30 = (1)/(2) × 12 × y → 30 = 6y → y = 5$. Since triangle $ADE \\sim ABC$, the ratio of corresponding legs is constant: $(DE)/(BC) = (AE)/(AC)$. Substitute the known values: $(x)/(5) = (5)/(12)$. Solve for $x$ by multiplying both sides by 5: $x = (25)/(12)$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_3',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'A right triangle has a hypotenuse of length 10 and one leg of length 8. What is the length of the other leg?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"9"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Let the missing leg be $b$. Using $a^2 + b^2 = c^2$: $8^2 + b^2 = 10^2$. This simplifies to $64 + b^2 = 100$. Subtract 64 from both sides: $b^2 = 36$. Taking the square root gives $b = \\sqrt{36} = 6$. The missing leg is 6.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_4',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'Two nearby trees are perpendicular to the ground, which is flat. One of these trees is 10 feet tall and has a shadow that is 5 feet long. At the same time, the shadow of the other tree is 2 feet long. How tall, in feet, is the other tree?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"8"},{"id":"d","text":"27"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The tree and its shadow form the legs of a right triangle. Since the sun''s rays hit the ground at the same angle, the two triangles formed are similar. We can use proportions to solve for the height.

\\textbf{Calculation and Logic:}

Set up a proportion between height and shadow: $\\frac{\\text{Height}_1}{\\text{Shadow}_1} = \\frac{\\text{Height}_2}{\\text{Shadow}_2}$. Substitute the values: $(10)/(5) = (H)/(2)$. Simplify the left ratio: $2 = (H)/(2)$. Multiply by 2: $H = 4$. The other tree is 4 feet tall.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_5',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'A coordinate plane has points at $(0,0)$ and $(8,15)$. What is the distance between these two points?',
  NULL,
  '17',
  '\\textbf{Conceptual Explanation:}

The distance formula $d = \\sqrt{(x_2-x_1)^2 + (y_2-y_1)^2}$ is derived directly from the Pythagorean Theorem, where the difference in $x$-coordinates is one leg and the difference in $y$-coordinates is the other.

\\textbf{Calculation and Logic:}

Leg 1 (horizontal distance): $8 - 0 = 8$. Leg 2 (vertical distance): $15 - 0 = 15$. Apply the theorem: $8^2 + 15^2 = c^2 → 64 + 225 = c^2 → 289 = c^2$. The distance $c = \\sqrt{289} = 17$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_6',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[left]{$M$} -- (4.5,0) node[right]{$P$} -- (1.5,2) node[above]{$N$} -- cycle; \\draw[thick] (1.5,2) -- (1.5,0) node[below]{$Q$}; \\draw (1.5,0) rectangle (1.3,0.2); \\node at (0.7,1.2) {3}; \\node at (3.5,1.2) {4}; \\end{tikzpicture} \\end{center} In the figure above, $MN = 3$ and $NP = 4$. If $\\angle MNP$ is a right angle and $NQ$ is an altitude to $MP$, what is the length of $NQ$?',
  '[{"id":"a","text":"2.2"},{"id":"b","text":"2.3"},{"id":"c","text":"2.4"},{"id":"d","text":"2.5"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In a right triangle, the altitude to the hypotenuse creates three similar triangles. The area can be calculated in two ways: $(1)/(2)(\\text{leg}_1 × \\text{leg}_2)$ or $(1)/(2)(\\text{hypotenuse} × \\text{altitude})$.

\\textbf{Calculation and Logic:}

First, find the hypotenuse $MP$ using legs 3 and 4: $MP = \\sqrt{3^2 + 4^2} = \\sqrt{25} = 5$. Next, set the two area formulas equal: $(1)/(2)(3 × 4) = (1)/(2)(5 × NQ)$. Simplify: $6 = 2.5 × NQ$. Solve for $NQ$: $NQ = (6)/(2.5) = 2.4$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_7',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'A square has a diagonal of length $10\\sqrt{2}$. What is the area of the square?',
  NULL,
  '100',
  '\\textbf{Conceptual Explanation:}

In a square, the diagonal ($d$) and two sides ($s$) form a right isosceles triangle. By the Pythagorean Theorem, $s^2 + s^2 = d^2$.

\\textbf{Calculation and Logic:}

$2s^2 = (10\\sqrt{2})^2 → 2s^2 = 100 × 2 → 2s^2 = 200 → s^2 = 100$. Since the area of a square is $s^2$, the area is 100 square units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_8',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'Which set of side lengths represents a right triangle?',
  '[{"id":"a","text":"3, 4, 6"},{"id":"b","text":"5, 10, 12"},{"id":"c","text":"7, 24, 25"},{"id":"d","text":"8, 15, 16"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

Check each set using $a^2 + b^2 = c^2$. For choice C: $7^2 + 24^2 = 49 + 576 = 625$. Since $25^2 = 625$, the theorem holds. Choice C is a "Pythagorean Triple."',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_044_9',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'A 26-foot ladder is leaning against a vertical wall. If the base of the ladder is 10 feet away from the wall, how high up the wall does the ladder reach?',
  '[{"id":"a","text":"16 feet"},{"id":"b","text":"20 feet"},{"id":"c","text":"24 feet"},{"id":"d","text":"25 feet"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

The ladder is the hypotenuse ($c=26$) and the ground distance is one leg ($a=10$). Using $10^2 + h^2 = 26^2 → 100 + h^2 = 676 → h^2 = 576$. Thus, $h = \\sqrt{576} = 24$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_10',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) -- (4,0) node[midway, below]{32$^\\circ$} -- (4,2.5) -- cycle; \\draw[thick] (6,2.5) -- (6,0) node[midway, below]{58$^\\circ$} -- (8,0) -- cycle; \\node at (0.2,1.5) {$A$}; \\node at (7.8,1.5) {$E$}; \\node at (4.3,2.5) {$B$}; \\node at (5.7,2.5) {$T$}; \\end{tikzpicture} \\end{center} Triangles $ABC$ and $DEF$ are right triangles. Which of the following is equal to the ratio $\\frac{BC}{AB}$?',
  '[{"id":"a","text":"$\\\\frac{DE}{DF}$"},{"id":"b","text":"$\\\\frac{DF}{DE}$"},{"id":"c","text":"$\\\\frac{DF}{EF}$"},{"id":"d","text":"$\\\\frac{EF}{DE}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In right triangles, the ratio of sides is determined by the acute angles. If two right triangles have an identical acute angle, they are similar, and their side ratios (trigonometric functions) are equal. Note that $32^\\circ + 58^\\circ = 90^\\circ$, meaning these triangles are complementary.

\\textbf{Calculation and Logic:}

In $\\triangle ABC$, $(BC)/(AB)$ is $\\sin(32^\\circ)$ or $\\cos(58^\\circ)$. In $\\triangle DEF$, $\\cos(58^\\circ)$ is the ratio of adjacent leg to hypotenuse, which is $(DF)/(DE)$. Therefore, $(BC)/(AB) = (DF)/(DE)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_11',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[thick] (0,0) node[left]{$D$} -- (8,0) node[below]{$E$} -- (8,6) node[right]{$B$} -- (0,6) node[above]{$C$} -- cycle; \\draw[thick] (0,6) -- (6,0) node[below]{$A$}; \\draw (8,0) rectangle (7.5,0.5); \\node at (4,-0.5) {8}; \\node at (8.5,3) {$y$}; \\node at (3,3.5) {$x$}; \\end{tikzpicture} \\end{center} The area of triangle $ABC$ is at least 48 but no more than 60. If $y$ is an integer, what is one possible value of $x$?',
  NULL,
  '14.4',
  '\\textbf{Calculation and Logic:}

The base of $\\triangle ABC$ is $y$. The height is $CD = 8 - 2$ (if $DA=6$). Wait, in the diagram, $DE=8$ and $DA=6$. Thus $AE=2$. Height of $\\triangle ABC$ is horizontal distance 8. Area $= (1)/(2) \\cdot 8 \\cdot y = 4y$. Given $48 \\le 4y \\le 60 → 12 \\le y \\le 15$. If $y=12$, then $x = \\sqrt{8^2 + 12^2} = \\sqrt{64+144} = \\sqrt{208} \\approx 14.4$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_12',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'A right triangle has legs of length $\\sqrt{7}$ and $\\sqrt{2}$. What is the length of the hypotenuse?',
  NULL,
  '3',
  '\\textbf{Calculation and Logic:}

$c^2 = (\\sqrt{7})^2 + (\\sqrt{2})^2 = 7 + 2 = 9$. $c = \\sqrt{9} = 3$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_044_13',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'The area of a right triangle is 24 square inches. If one leg is 6 inches, what is the length of the hypotenuse?',
  '[{"id":"a","text":"8 inches"},{"id":"b","text":"10 inches"},{"id":"c","text":"12 inches"},{"id":"d","text":"14 inches"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Area $= (1)/(2)ab → 24 = (1)/(2)(6)b → 24 = 3b → b = 8$. Use legs 6 and 8: $c = \\sqrt{6^2 + 8^2} = \\sqrt{100} = 10$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_14',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'What is the perimeter of a right triangle with legs of length 9 and 40?',
  NULL,
  '90',
  '\\textbf{Calculation and Logic:}

Hypotenuse $c = \\sqrt{9^2 + 40^2} = \\sqrt{81 + 1600} = \\sqrt{1681} = 41$. Perimeter $= 9 + 40 + 41 = 90$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_15',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'A right triangle has side lengths $x$, $x+7$, and $x+8$. What is the value of $x$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"5"},{"id":"c","text":"8"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Substitute the algebraic expressions into the Pythagorean Theorem. The longest side, $x+8$, must be the hypotenuse.

\\textbf{Calculation and Logic:}

$x^2 + (x+7)^2 = (x+8)^2 → x^2 + x^2 + 14x + 49 = x^2 + 16x + 64$. Simplify to a quadratic: $x^2 - 2x - 15 = 0$. Factor the equation: $(x-5)(x+3) = 0$. Since length must be positive, $x = 5$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_16',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'The legs of a right triangle are in a ratio of 3:4. If the hypotenuse is 25, what is the length of the shorter leg?',
  NULL,
  '15',
  '\\textbf{Calculation and Logic:}

Let legs be $3x$ and $4x$. $(3x)^2 + (4x)^2 = 25^2 → 9x^2 + 16x^2 = 625 → 25x^2 = 625 → x^2 = 25 → x = 5$. Shorter leg $= 3(5) = 15$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_17',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'A rectangle has a perimeter of 34 and a diagonal of 13. What is the area of the rectangle?',
  '[{"id":"a","text":"30"},{"id":"b","text":"60"},{"id":"c","text":"120"},{"id":"d","text":"169"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Let dimensions be $L$ and $W$. $2(L+W) = 34 → L+W = 17$. From the diagonal: $L^2 + W^2 = 13^2 = 169$. Use the identity $(L+W)^2 = L^2 + W^2 + 2LW → 17^2 = 169 + 2LW → 289 = 169 + 2LW → 120 = 2LW → LW = 60$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_18',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'In a right triangle, the hypotenuse is 17 and one leg is 15. What is the area of the triangle?',
  NULL,
  '60',
  '\\textbf{Calculation and Logic:}

Missing leg $a = \\sqrt{17^2 - 15^2} = \\sqrt{289 - 225} = \\sqrt{64} = 8$. Area $= (1)/(2)(8 × 15) = 60$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_19',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=1] \\draw[thick] (0,0) -- (4,0) -- (4,3) -- cycle; \\draw[thick] (4,3) -- (6,3) -- (4,0); \\node at (2,-0.4) {4}; \\node at (4.3,1.5) {3}; \\node at (5,3.3) {2}; \\end{tikzpicture} \\end{center} In the composite figure above, what is the distance from the bottom-left vertex to the top-right vertex?',
  '[{"id":"a","text":"$\\\\sqrt{13}$"},{"id":"b","text":"$\\\\sqrt{29}$"},{"id":"c","text":"$\\\\sqrt{45}$"},{"id":"d","text":"$\\\\sqrt{61}$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Create a large right triangle. The horizontal leg is $4 + 2 = 6$. The vertical leg is 3. The distance $d = \\sqrt{6^2 + 3^2} = \\sqrt{36 + 9} = \\sqrt{45}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_20',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'A right triangle has legs of length 8 and 15. Find the hypotenuse.',
  NULL,
  '17',
  '\\textbf{Calculation and Logic:}

$c^2 = 8^2 + 15^2 = 64 + 225 = 289 → c = 17$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_044_21',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'An equilateral triangle has a side length of 6. What is its height?',
  '[{"id":"a","text":"3"},{"id":"b","text":"$3\\\\sqrt{2}$"},{"id":"c","text":"$3\\\\sqrt{3}$"},{"id":"d","text":"6"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

The height bisects the base into two segments of 3. This forms a right triangle with leg 3 and hypotenuse 6. $h^2 + 3^2 = 6^2 → h^2 + 9 = 36 → h^2 = 27 → h = \\sqrt{27} = 3\\sqrt{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_22',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'A rectangle has sides of 20 and 21. How long is its diagonal?',
  NULL,
  '29',
  '\\textbf{Calculation and Logic:}

$d^2 = 20^2 + 21^2 = 400 + 441 = 841 → d = \\sqrt{841} = 29$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_23',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'A right triangle has a perimeter of 40 and a hypotenuse of 17. What is the length of the shortest side?',
  '[{"id":"a","text":"8"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"15"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Sum of legs $a+b = 40 - 17 = 23$. Pythagorean property: $a^2 + b^2 = 17^2 = 289$. Testing integer pairs that sum to 23: 8 and 15. Check: $8^2 + 15^2 = 64 + 225 = 289$. The shortest side is 8.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_24',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'Find the area of a right triangle where the hypotenuse is 25 and one leg is 7.',
  NULL,
  '84',
  '\\textbf{Calculation and Logic:}

Leg $b = \\sqrt{25^2 - 7^2} = \\sqrt{625 - 49} = \\sqrt{576} = 24$. Area $= (1)/(2)(7 × 24) = 84$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_25',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'A circle is inscribed in a square with a diagonal of $8\\sqrt{2}$. What is the circumference of the circle?',
  '[{"id":"a","text":"$4\\\\pi$"},{"id":"b","text":"$8\\\\pi$"},{"id":"c","text":"$16\\\\pi$"},{"id":"d","text":"$64\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Diagonal $d = s\\sqrt{2} → 8\\sqrt{2} = s\\sqrt{2} → s = 8$. The diameter of the inscribed circle is equal to the side of the square (8). Circumference $= \\pi d = 8\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_26',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'Find the leg of a right triangle if the hypotenuse is 5 and the other leg is 4.',
  NULL,
  '3',
  '\\textbf{Calculation and Logic:}

$x = \\sqrt{5^2 - 4^2} = \\sqrt{9} = 3$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_044_27',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'A right triangle has legs of length $x$ and $2x$. If the hypotenuse is $\\sqrt{20}$, what is $x$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"10"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

$x^2 + (2x)^2 = (\\sqrt{20})^2 → x^2 + 4x^2 = 20 → 5x^2 = 20 → x^2 = 4 → x = 2$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_28',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'What is the area of a right isosceles triangle with a hypotenuse of $4\\sqrt{2}$?',
  NULL,
  '8',
  '\\textbf{Calculation and Logic:}

Leg $s = 4$. Area $= (1)/(2)(4 × 4) = 8$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_29',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'An isosceles triangle has a base of 16 and a perimeter of 36. What is its height?',
  '[{"id":"a","text":"6"},{"id":"b","text":"8"},{"id":"c","text":"10"},{"id":"d","text":"12"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Legs $= (36 - 16) / 2 = 10$. Height forms a right triangle with half the base (8) and a leg (10). $h = \\sqrt{10^2 - 8^2} = \\sqrt{36} = 6$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_30',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'Find the hypotenuse for legs 1.5 and 2.',
  NULL,
  '2.5',
  '\\textbf{Calculation and Logic:}

$c = \\sqrt{1.5^2 + 2^2} = \\sqrt{2.25 + 4} = \\sqrt{6.25} = 2.5$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_044_31',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'The area of a square is 50. What is the length of its diagonal?',
  '[{"id":"a","text":"5"},{"id":"b","text":"10"},{"id":"c","text":"$5\\\\sqrt{2}$"},{"id":"d","text":"$10\\\\sqrt{2}$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$s^2 = 50 → s = \\sqrt{50} = 5\\sqrt{2}$. Diagonal $d = s\\sqrt{2} = 5\\sqrt{2} \\cdot \\sqrt{2} = 5 \\cdot 2 = 10$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_32',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'A right triangle has legs $\\sqrt{11}$ and $\\sqrt{14}$. Find the hypotenuse.',
  NULL,
  '5',
  '\\textbf{Calculation and Logic:}

$c = \\sqrt{11 + 14} = \\sqrt{25} = 5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_33',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'A rhombus has diagonals of 10 and 24. What is its perimeter?',
  '[{"id":"a","text":"34"},{"id":"b","text":"52"},{"id":"c","text":"68"},{"id":"d","text":"120"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Diagonals of a rhombus bisect at right angles. Half-diagonals are 5 and 12. Side $s = \\sqrt{5^2 + 12^2} = 13$. Perimeter $= 4 × 13 = 52$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_34',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'A triangle has sides 11, 60, and 61. What is its area?',
  NULL,
  '330',
  '\\textbf{Calculation and Logic:}

Check if it''s a right triangle: $11^2 + 60^2 = 121 + 3600 = 3721$. $61^2 = 3721$. Yes. Area $= (1)/(2)(11 × 60) = 330$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_35',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'Points $P(2,3)$ and $Q(5,7)$ are in a coordinate plane. What is the distance $PQ$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"7"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$\\Delta x = 3, \\Delta y = 4$. $d = \\sqrt{3^2 + 4^2} = 5$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_36',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'Legs 20 and 21. Hypotenuse?',
  NULL,
  '29',
  '\\textbf{Calculation and Logic:}

$c = \\sqrt{400 + 441} = 29$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_044_37',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'One leg of a right triangle is twice the other. If the area is 16, find the hypotenuse.',
  '[{"id":"a","text":"4"},{"id":"b","text":"$4\\\\sqrt{5}$"},{"id":"c","text":"8"},{"id":"d","text":"$8\\\\sqrt{5}$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$(1)/(2)(x)(2x) = 16 → x^2 = 16 → x = 4$. Legs are 4 and 8. $c = \\sqrt{16 + 64} = \\sqrt{80} = 4\\sqrt{5}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_38',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'Diagonal of a square is 6. Find its area.',
  NULL,
  '18',
  '\\textbf{Calculation and Logic:}

Area $= d^2 / 2 = 36 / 2 = 18$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_39',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'Two sides of a right triangle are 3 and 4. What is the sum of all possible lengths of the third side?',
  '[{"id":"a","text":"5"},{"id":"b","text":"$5 + \\\\sqrt{7}$"},{"id":"c","text":"7"},{"id":"d","text":"12"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Case 1: 3 and 4 are legs $→ c = 5$. Case 2: 4 is hypotenuse $→ a = \\sqrt{4^2 - 3^2} = \\sqrt{7}$. Sum $= 5 + \\sqrt{7}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_40',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'Hypotenuse 13, leg 12. Find the other leg.',
  NULL,
  '5',
  '\\textbf{Calculation:}

$\\sqrt{169 - 144} = 5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_41',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'Find the length of the longest stick that can fit inside a 3x4x12 box.',
  '[{"id":"a","text":"12"},{"id":"b","text":"13"},{"id":"c","text":"15"},{"id":"d","text":"19"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

3D Pythagorean theorem: $d = \\sqrt{L^2 + W^2 + H^2} = \\sqrt{3^2 + 4^2 + 12^2} = \\sqrt{9 + 16 + 144} = \\sqrt{169} = 13$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_42',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'A right triangle has legs of 1 and 1. Find the hypotenuse squared.',
  NULL,
  '2',
  '\\textbf{Calculation:}

$c^2 = 1^2 + 1^2 = 2$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_43',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'The area of a right isosceles triangle is 18. Find the hypotenuse.',
  '[{"id":"a","text":"6"},{"id":"b","text":"$6\\\\sqrt{2}$"},{"id":"c","text":"12"},{"id":"d","text":"$12\\\\sqrt{2}$"}]'::jsonb,
  'b',
  '\\textbf{Calculation:}

$(1)/(2)s^2 = 18 → s^2 = 36 → s = 6$. $c = 6\\sqrt{2}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_44',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'Sides 24, 70, 74. Area?',
  NULL,
  '840',
  '\\textbf{Calculation:}

$24^2 + 70^2 = 576 + 4900 = 5476 = 74^2$. Right triangle. Area $= 0.5 × 24 × 70 = 840$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_45',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'A rectangle diagonal is 25. Width is 7. Find Perimeter.',
  '[{"id":"a","text":"31"},{"id":"b","text":"32"},{"id":"c","text":"62"},{"id":"d","text":"84"}]'::jsonb,
  'c',
  '\\textbf{Calculation:}

Length $= \\sqrt{25^2 - 7^2} = 24$. Perimeter $= 2(24 + 7) = 62$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_46',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'Legs 12, 16. Hypotenuse?',
  NULL,
  '20',
  '\\textbf{Calculation:}

$\\sqrt{144 + 256} = \\sqrt{400} = 20$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_044_47',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'mcq',
  'math',
  'A square side is doubled. What happens to its diagonal?',
  '[{"id":"a","text":"It doubles"},{"id":"b","text":"It triples"},{"id":"c","text":"It increases by $\\\\sqrt{2}$"},{"id":"d","text":"It stays the same"}]'::jsonb,
  'a',
  '\\textbf{Calculation:}

$d_1 = s\\sqrt{2}$. $d_2 = (2s)\\sqrt{2} = 2d_1$. It doubles.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_48',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'Area of square is 36. Find diagonal squared.',
  NULL,
  '72',
  '\\textbf{Calculation:}

$s^2 = 36 → s=6$. $d^2 = 6^2 + 6^2 = 72$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_044_49',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
),
  (
  'spr',
  'math',
  'A right triangle has hypotenuse 10. Legs are $x$ and $x+2$. Find $x$.',
  NULL,
  '6',
  '\\textbf{Calculation:}

$x^2 + (x+2)^2 = 100 → x^2 + x^2 + 4x + 4 = 100 → 2x^2 + 4x - 96 = 0 → x^2 + 2x - 48 = 0 → (x+8)(x-6) = 0 → x = 6$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_044_50',
  'Triangles, Pythagorean theorem, similar triangles',
  'Pythagorean Theorem'
)
ON CONFLICT (bank_item_id) DO NOTHING;

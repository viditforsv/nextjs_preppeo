-- Practice-mode math from lid_051.tex (sat_lid_051)
-- Chapter: Right-triangle trig: sin, cos, tan | Topic: SOH CAH TOA
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_051_N, practice module/set 0.

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
  'In a right triangle, the side opposite to acute angle $\\theta$ has a length of 7 and the hypotenuse has a length of 25. What is the value of $\\cos \\theta$?',
  '[{"id":"a","text":"$\\\\frac{7}{25}$"},{"id":"b","text":"$\\\\frac{7}{24}$"},{"id":"c","text":"$\\\\frac{24}{25}$"},{"id":"d","text":"$\\\\frac{25}{24}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To find $\\cos \\theta$, we need the ratio of the adjacent side to the hypotenuse ($\\frac{\\text{adj}}{\\text{hyp}}$). We are given the opposite side and the hypotenuse.

\\textbf{Calculation and Logic:}

1. Use the Pythagorean theorem to find the adjacent side ($a$):

$a^2 + 7^2 = 25^2$

$a^2 + 49 = 625$

$a^2 = 576 → a = 24$

2. Apply the definition of Cosine (CAH):

$\\cos \\theta = \\frac{\\text{adjacent}}{\\text{hypotenuse}} = (24)/(25)$',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_051_1',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'In $\\triangle ABC$, the measure of $\\angle C$ is $90^\\circ$. If $\\sin A = \\frac{5}{13}$, what is the value of $\\cos B$?',
  NULL,
  '5/13',
  '\\textbf{Conceptual Explanation:}

This question tests the Complementary Angle Identity. In any right triangle, the two acute angles (A and B) must sum to $90^\\circ$. For any such angles, $\\sin A = \\cos(90^\\circ - A)$.

\\textbf{Calculation and Logic:}

1. Since $\\angle C = 90^\\circ$, we know $A + B = 90^\\circ$.

2. The identity states that $\\sin A = \\cos B$.

3. Given $\\sin A = (5)/(13)$, it follows directly that $\\cos B = (5)/(13)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_2',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'For a certain acute angle $x$, $\\tan x = \\frac{3}{4}$. What is the value of $\\sin x + \\cos x$?',
  '[{"id":"a","text":"$\\\\frac{7}{5}$"},{"id":"b","text":"$\\\\frac{5}{7}$"},{"id":"c","text":"$\\\\frac{12}{25}$"},{"id":"d","text":"$1$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The tangent ratio represents $\\frac{\\text{opposite}}{\\text{adjacent}}$. We can model this using a standard 3-4-5 right triangle.

\\textbf{Calculation and Logic:}

1. Let the side opposite to $x$ be 3 and the side adjacent to $x$ be 4.

2. The hypotenuse is $\\sqrt{3^2 + 4^2} = 5$.

3. Determine the individual ratios:

$\\sin x = \\frac{\\text{opp}}{\\text{hyp}} = (3)/(5)$

$\\cos x = \\frac{\\text{adj}}{\\text{hyp}} = (4)/(5)$

4. Sum the values: $(3)/(5) + (4)/(5) = (7)/(5)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_3',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In a right triangle, $\\cos \\theta = \\frac{\\sqrt{3}}{2}$. What is the value of $\\sin (90^\\circ - \\theta)$?',
  '[{"id":"a","text":"$\\\\frac{1}{2}$"},{"id":"b","text":"$\\\\frac{\\\\sqrt{3}}{2}$"},{"id":"c","text":"$1$"},{"id":"d","text":"$\\\\frac{\\\\sqrt{3}}{3}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This question utilizes the cofunction identity which states that the cosine of an angle is equal to the sine of its complement.

\\textbf{Calculation and Logic:}

The identity $\\cos \\theta = \\sin(90^\\circ - \\theta)$ applies here directly.

Given that $\\cos \\theta = \\frac{\\sqrt{3}}{2}$, then the value of $\\sin(90^\\circ - \\theta)$ must be the exact same value.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_4',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'In the $xy$-plane, the terminal ray of an angle $\\alpha$ in standard position passes through the point $(8, 15)$. What is the value of $\\sin \\alpha$?',
  NULL,
  '15/17',
  '\\textbf{Conceptual Explanation:}

We can treat the coordinates $(x, y)$ as the adjacent and opposite sides of a right triangle where the hypotenuse is the distance from the origin to the point.

\\textbf{Calculation and Logic:}

The $x$-coordinate is 8 (adjacent) and the $y$-coordinate is 15 (opposite).

Find the hypotenuse ($r$) using the Pythagorean theorem: $r = \\sqrt{8^2 + 15^2} = \\sqrt{64 + 225} = \\sqrt{289} = 17$.

The sine ratio is $\\frac{\\text{opposite}}{\\text{hypotenuse}}$, which gives $15/17$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_5',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $\\frac{\\sin \\theta}{\\cos \\theta}$ for all acute angles $\\theta$?',
  '[{"id":"a","text":"$\\\\cos(90^\\\\circ - \\\\theta)$"},{"id":"b","text":"$\\\\tan \\\\theta$"},{"id":"c","text":"$1$"},{"id":"d","text":"$\\\\sin^2 \\\\theta$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This is a fundamental trigonometric identity derived from the SOH CAH TOA definitions.

\\textbf{Calculation and Logic:}

Substitute the side ratios: $\\sin \\theta = \\frac{\\text{opp}}{\\text{hyp}}$ and $\\cos \\theta = \\frac{\\text{adj}}{\\text{hyp}}$.

Dividing these gives $(\\frac{\\text{opp}}{\\text{hyp}}) ÷ (\\frac{\\text{adj}}{\\text{hyp}}) = \\frac{\\text{opp}}{\\text{adj}}$.

By definition, $\\frac{\\text{opp}}{\\text{adj}}$ is $\\tan \\theta$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_051_6',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In the figure below, triangle $ABC$ is a right triangle. If $BC = 12$ and $\\tan A = \\frac{3}{4}$, what is the length of segment $AB$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (4,0) node[anchor=north west]{$C$} -- (4,3) node[anchor=south west]{$B$} -- cycle; \\draw (3.7,0) -- (3.7,0.3) -- (4,0.3); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"9"},{"id":"b","text":"15"},{"id":"c","text":"16"},{"id":"d","text":"20"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The tangent of angle $A$ is defined as the ratio of the side opposite to $A$ (which is $BC$) to the side adjacent to $A$ (which is $AC$). We use this ratio to find the missing sides and then use the Pythagorean theorem for $AB$.

\\textbf{Calculation and Logic:}

From the definition, $\\tan A = (BC)/(AC) = (3)/(4)$.

Substituting the known value, $(12)/(AC) = (3)/(4)$.

Cross-multiplying gives $3(AC) = 48$, so $AC = 16$.

To find the hypotenuse $AB$, we use $AB = \\sqrt{AC^2 + BC^2} = \\sqrt{16^2 + 12^2} = \\sqrt{256 + 144} = \\sqrt{400}$.

The length of $AB$ is 20.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_7',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In right triangle $XYZ$ shown below, the length of $XY$ is 10 and $\\cos X = 0.8$. What is the length of $YZ$? \\begin{center} \\begin{tikzpicture}[scale=1] \\draw[thick] (0,0) node[anchor=north east]{$X$} -- (4,0) node[anchor=north west]{$Z$} -- (4,3) node[anchor=south west]{$Y$} -- cycle; \\draw (3.7,0) -- (3.7,0.3) -- (4,0.3); \\node at (1.8,1.8) {10}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"6"},{"id":"b","text":"8"},{"id":"c","text":"12.5"},{"id":"d","text":"15"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We are given the hypotenuse and the cosine of an angle. We can find the adjacent side first, or use the sine relationship since $YZ$ is opposite to angle $X$.

\\textbf{Calculation and Logic:}

The cosine ratio is $\\frac{\\text{adj}}{\\text{hyp}}$, so $0.8 = (XZ)/(10)$, which means $XZ = 8$.

Using the Pythagorean theorem, $YZ = \\sqrt{10^2 - 8^2} = \\sqrt{100 - 64} = \\sqrt{36}$.

The length of $YZ$ is 6.

Alternatively, if $\\cos X = 0.8$, then $\\sin X = \\sqrt{1 - 0.8^2} = 0.6$. Then $YZ = 10 × 0.6 = 6$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_8',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'In a right triangle, $\\sin \\theta = \\frac{a}{b}$ and $\\cos \\theta = \\frac{c}{b}$. If $a=5$ and $c=12$, what is the value of $b$?',
  NULL,
  '13',
  '\\textbf{Conceptual Explanation:}

The denominators of the sine and cosine ratios in a right triangle both represent the hypotenuse. The numerators represent the legs of the triangle.

\\textbf{Calculation and Logic:}

According to the Pythagorean identity, $\\sin^2 \\theta + \\cos^2 \\theta = 1$.

Substituting the given ratios: $((a)/(b))^2 + ((c)/(b))^2 = 1$.

This simplifies to $a^2 + c^2 = b^2$.

Plugging in the values: $5^2 + 12^2 = b^2 → 25 + 144 = b^2$.

$b^2 = 169$, so $b = 13$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_9',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In the figure below, a ladder leans against a wall, making a $60^\\circ$ angle with the ground. If the base of the ladder is 8 feet from the wall, what is the length of the ladder, in feet? \\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[thick] (0,0) -- (4,0) node[midway, below]{8 ft} -- (4,7); \\draw[ultra thick, blue] (0,0) -- (4,7) node[midway, above left, black]{L}; \\draw (0.8,0) arc (0:60:0.8) node[midway, right=2pt]{$60^\\circ$}; \\draw (3.7,0) -- (3.7,0.3) -- (4,0.3); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"4"},{"id":"b","text":"$8\\\\sqrt{3}$"},{"id":"c","text":"16"},{"id":"d","text":"$16\\\\sqrt{3}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The ladder forms the hypotenuse of a right triangle. The distance from the wall is the side adjacent to the $60^\\circ$ angle. We use the cosine ratio (CAH) to relate these.

\\textbf{Calculation and Logic:}

By definition, $\\cos(60^\\circ) = \\frac{\\text{adjacent}}{\\text{hypotenuse}}$.

Substituting the values gives $\\cos(60^\\circ) = (8)/(L)$.

Since $\\cos(60^\\circ) = 0.5$, we have $0.5 = (8)/(L)$.

Solving for $L$ yields $L = (8)/(0.5) = 16$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_10',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'In a right triangle, $\\sin \\theta = \\cos(2\\theta - 30^\\circ)$, where all angles are in degrees. What is the value of $\\theta$?',
  NULL,
  '40',
  '\\textbf{Conceptual Explanation:}

The sine and cosine functions are equal when their arguments are complementary angles. This means the sum of the two angles must be $90^\\circ$.

\\textbf{Calculation and Logic:}

Set the sum of the angles to 90: $\\theta + (2\\theta - 30) = 90$.

Combine like terms: $3\\theta - 30 = 90$.

Add 30 to both sides: $3\\theta = 120$.

Divide by 3: $\\theta = 40$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_11',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In $\\triangle DEF$ (not shown), $\\angle E$ is a right angle. Which of the following is equivalent to $\\cos D$?',
  '[{"id":"a","text":"$\\\\sin F$"},{"id":"b","text":"$\\\\sin D$"},{"id":"c","text":"$\\\\tan F$"},{"id":"d","text":"$\\\\cos F$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In any right triangle, the two acute angles are complements of each other. The cofunction identity states that the cosine of one acute angle equals the sine of the other.

\\textbf{Calculation and Logic:}

Since $\\angle E = 90^\\circ$, then $D + F = 90^\\circ$.

According to the complementary angle identity, $\\cos D = \\sin(90^\\circ - D)$.

Substituting $F$ for $(90^\\circ - D)$, we find $\\cos D = \\sin F$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_051_12',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In right triangle $PQR$, $\\angle Q = 90^\\circ$ and $\\tan P = \\frac{x}{y}$. What is the value of $\\sin R$?',
  '[{"id":"a","text":"$\\\\frac{x}{\\\\sqrt{x^2+y^2}}$"},{"id":"b","text":"$\\\\frac{y}{\\\\sqrt{x^2+y^2}}$"},{"id":"c","text":"$\\\\frac{x}{y}$"},{"id":"d","text":"$\\\\frac{y}{x}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The tangent of angle $P$ gives the ratio of the opposite side ($QR$) to the adjacent side ($PQ$). We need to find the hypotenuse ($PR$) to determine the sine of angle $R$.

\\textbf{Calculation and Logic:}

Let $QR = x$ and $PQ = y$.

The hypotenuse $PR = \\sqrt{x^2 + y^2}$.

Angle $R$ is opposite to side $PQ$.

Therefore, $\\sin R = \\frac{\\text{opposite to R}}{\\text{hypotenuse}} = (PQ)/(PR) = (y)/(\\sqrt{x^2 + y^2)}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_13',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'If $\\cos(x^\\circ) = \\sin(24^\\circ)$, where $0 < x < 90$, what is the value of $x$?',
  NULL,
  '66',
  '\\textbf{Conceptual Explanation:}

The sine and cosine of complementary angles are equal. This identity is a staple of the SAT and requires the two angles to sum to 90.

\\textbf{Calculation and Logic:}

Set up the equation based on the identity: $x + 24 = 90$.

Subtract 24 from 90 to isolate $x$.

$x = 66$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_14',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\sin A = 0.6$. If $AB = 15$, what is the area of triangle $ABC$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (4.8,0) node[anchor=north west]{$C$} -- (4.8,3.6) node[anchor=south west]{$B$} -- cycle; \\draw (4.5,0) -- (4.5,0.3) -- (4.8,0.3); \\node at (2.4,2.2) {15}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"27"},{"id":"b","text":"54"},{"id":"c","text":"108"},{"id":"d","text":"135"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To find the area ($(1)/(2) × \\text{base} × \\text{height}$), we need the lengths of sides $AC$ and $BC$. We can use the sine ratio and the Pythagorean theorem to find them.

\\textbf{Calculation and Logic:}

$\\sin A = (BC)/(AB) → 0.6 = (BC)/(15) → BC = 9$.

Using the Pythagorean theorem, $AC = \\sqrt{15^2 - 9^2} = \\sqrt{225 - 81} = \\sqrt{144} = 12$.

Area $= (1)/(2) × AC × BC = (1)/(2) × 12 × 9$.

Area $= 6 × 9 = 54$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_15',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In $\\triangle ABC$ below, $\\angle C = 90^\\circ$ and $BC = 5$. If $\\sin A = \\frac{5}{13}$, what is the value of $\\tan B$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (4.5,0) node[anchor=north west]{$C$} -- (4.5,2) node[anchor=south west]{$B$} -- cycle; \\draw (4.2,0) -- (4.2,0.3) -- (4.5,0.3); \\node at (4.8, 1) {5}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$\\\\frac{5}{12}$"},{"id":"b","text":"$\\\\frac{12}{13}$"},{"id":"c","text":"$\\\\frac{12}{5}$"},{"id":"d","text":"$\\\\frac{13}{5}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

We use the given sine ratio to identify the side lengths of the triangle. Since $\\sin A$ involves the hypotenuse, we first find the adjacent side $AC$ to calculate the tangent of angle $B$.

\\textbf{Calculation and Logic:}

By definition, $\\sin A = \\frac{\\text{opp}}{\\text{hyp}} = (BC)/(AB)$.

Given $\\sin A = (5)/(13)$ and $BC = 5$, it follows that the hypotenuse $AB = 13$.

Using the Pythagorean theorem, $AC = \\sqrt{13^2 - 5^2} = \\sqrt{169 - 25} = 12$.

For angle $B$, the opposite side is $AC$ and the adjacent side is $BC$.

$\\tan B = \\frac{\\text{opp}}{\\text{adj}} = (AC)/(BC) = (12)/(5)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_16',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'In a right triangle, the measure of one acute angle is $x^\\circ$, where $\\sin(x^\\circ) = \\frac{1}{3}$. What is the value of $\\cos(90^\\circ - x^\\circ)$?',
  NULL,
  '1/3',
  '\\textbf{Conceptual Explanation:}

The SAT frequently tests the relationship between the sine of an angle and the cosine of its complement. This identity is based on the fact that the side opposite one acute angle is the side adjacent to the other.

\\textbf{Calculation and Logic:}

The fundamental identity is $\\sin(\\theta) = \\cos(90^\\circ - \\theta)$.

In this problem, $\\theta = x$.

Therefore, $\\cos(90^\\circ - x^\\circ)$ must be equal to $\\sin(x^\\circ)$.

Given $\\sin(x^\\circ) = 1/3$, the required value is $1/3$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_17',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'Which of the following expressions is equal to $1$ for all values of $\\theta$ such that $0 < \\theta < 90^\\circ$?',
  '[{"id":"a","text":"$\\\\sin \\\\theta + \\\\cos \\\\theta$"},{"id":"b","text":"$\\\\frac{\\\\sin \\\\theta}{\\\\cos(90^\\\\circ - \\\\theta)}$"},{"id":"c","text":"$\\\\tan \\\\theta \\\\cdot \\\\cos \\\\theta$"},{"id":"d","text":"$\\\\frac{\\\\cos \\\\theta}{\\\\sin \\\\theta}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We evaluate the trigonometric identities. For a fraction or product to equal 1, the numerator must equal the denominator or the terms must be reciprocals.

\\textbf{Calculation and Logic:}

Check Choice B: Using the identity $\\cos(90^\\circ - \\theta) = \\sin \\theta$.

The expression becomes $(\\sin \\theta)/(\\sin \\theta)$, which is 1 for all valid $\\theta$.

Choice A is only 1 at $0^\\circ$ or $90^\\circ$ (not acute).

Choice C simplifies to $(\\frac{\\text{opp}}{\\text{adj}}) \\cdot (\\frac{\\text{adj}}{\\text{hyp}}) = \\sin \\theta$.

Choice D is $\\cot \\theta$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_18',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In the right triangle shown below, what is the value of $\\sin \\beta$? \\begin{center} \\begin{tikzpicture}[scale=1] \\draw[thick] (0,0) -- (3,0) node[midway, below]{4} -- (3,1.5) node[midway, right]{3} -- cycle; \\node at (0.4, 0.2) {$\\beta$}; \\draw (2.8,0) -- (2.8,0.2) -- (3,0.2); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"0.6"},{"id":"b","text":"0.75"},{"id":"c","text":"0.8"},{"id":"d","text":"1.33"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We identify the components of SOH CAH TOA. The sine of an angle is the ratio of the side opposite to it over the hypotenuse.

\\textbf{Calculation and Logic:}

The side opposite $\\beta$ is 3. The side adjacent to $\\beta$ is 4.

The hypotenuse is $\\sqrt{3^2 + 4^2} = 5$.

$\\sin \\beta = (3)/(5) = 0.6$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_051_19',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'The circle shown below is centered at the origin. If the point $P(\\frac{1}{2}, \\frac{\\sqrt{3}}{2})$ lies on the circle, what is the value of $\\cos \\theta$? \\begin{center} \\begin{tikzpicture}[scale=1.5] \\draw[->] (-0.2,0) -- (1.5,0); \\draw[->] (0,-0.2) -- (0,1.5); \\draw (1,0) arc (0:90:1); \\draw[thick, blue] (0,0) -- (0.5, 0.866) node[anchor=south west, black]{$P$}; \\draw (0.3,0) arc (0:60:0.3) node[midway, right]{$\\theta$}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$\\\\frac{1}{2}$"},{"id":"b","text":"$\\\\frac{\\\\sqrt{3}}{2}$"},{"id":"c","text":"$\\\\sqrt{3}$"},{"id":"d","text":"$1$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

On the unit circle (or any circle centered at the origin), the cosine of an angle in standard position is given by the $x$-coordinate divided by the radius.

\\textbf{Calculation and Logic:}

The $x$-coordinate of point $P$ is $1/2$ and the $y$-coordinate is $\\sqrt{3}/2$.

The radius $r$ is $\\sqrt{((1)/(2))^2 + (\\frac{\\sqrt{3}}{2})^2} = \\sqrt{(1)/(4) + (3)/(4)} = 1$.

Since $\\cos \\theta = (x)/(r)$, then $\\cos \\theta = (1/2)/(1) = 1/2$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_20',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In a right triangle, the legs have lengths of 9 and 40. What is the value of the sine of the angle opposite the side with length 9?',
  '[{"id":"a","text":"$\\\\frac{9}{40}$"},{"id":"b","text":"$\\\\frac{9}{41}$"},{"id":"c","text":"$\\\\frac{40}{41}$"},{"id":"d","text":"$\\\\frac{41}{9}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To find the sine ratio, we need the opposite side and the hypotenuse. We calculate the hypotenuse using the Pythagorean theorem with the two given legs.

\\textbf{Calculation and Logic:}

Hypotenuse $= \\sqrt{9^2 + 40^2} = \\sqrt{81 + 1600} = \\sqrt{1681} = 41$.

The side opposite the required angle is 9.

$\\sin \\theta = \\frac{\\text{opp}}{\\text{hyp}} = (9)/(41)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_21',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'In the figure below, $\\overline{BD}$ is perpendicular to $\\overline{AC}$. If $BD = 4$ and $\\tan A = 0.5$, what is the length of segment $AD$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north]{$A$} -- (6,0) node[anchor=north]{$C$} -- (2,4) node[anchor=south]{$B$} -- cycle; \\draw[dashed] (2,4) -- (2,0) node[anchor=north]{$D$}; \\draw (2.2,0) -- (2.2,0.2) -- (2,0.2); \\end{tikzpicture} \\end{center}',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

The dashed line creates two right triangles. We use triangle $ABD$ and the given tangent value to find the horizontal segment $AD$.

\\textbf{Calculation and Logic:}

In right triangle $ABD$, $\\tan A = (BD)/(AD)$.

Given $\\tan A = 0.5$ and $BD = 4$, we have $0.5 = (4)/(AD)$.

Solving for $AD$ gives $AD = (4)/(0.5) = 8$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_22',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'Given that $\\sin x = \\cos y$ and $x$ and $y$ are acute angles. If $x = 3k - 10$ and $y = 2k + 5$, what is the value of $k$?',
  '[{"id":"a","text":"15"},{"id":"b","text":"19"},{"id":"c","text":"25"},{"id":"d","text":"30"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The equality $\\sin x = \\cos y$ for acute angles implies that $x$ and $y$ are complementary. Their sum must be exactly 90 degrees.

\\textbf{Calculation and Logic:}

$(3k - 10) + (2k + 5) = 90$.

$5k - 5 = 90$.

$5k = 95$.

$k = 19$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_23',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In right triangle $ABC$, the hypotenuse $AB$ has a length of 10. If $\\cos A = \\frac{3}{5}$, what is the length of side $BC$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"8"},{"id":"c","text":"$2\\\\sqrt{5}$"},{"id":"d","text":"10"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We use the cosine ratio to find the side adjacent to angle $A$ ($AC$), and then use the Pythagorean theorem or sine relationship to find the side opposite angle $A$ ($BC$).

\\textbf{Calculation and Logic:}

$\\cos A = (AC)/(10) = (3)/(5) → AC = 6$.

Using the Pythagorean theorem: $BC = \\sqrt{10^2 - 6^2} = \\sqrt{64} = 8$.

Alternatively, since $\\cos A = 3/5$, $\\sin A = 4/5$, and $BC = 10 × (4/5) = 8$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_24',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In a right triangle, $\\tan \\theta = 1$. What is the value of $\\sin \\theta$?',
  '[{"id":"a","text":"$0.5$"},{"id":"b","text":"$\\\\frac{\\\\sqrt{2}}{2}$"},{"id":"c","text":"$\\\\frac{\\\\sqrt{3}}{2}$"},{"id":"d","text":"$1$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When $\\tan \\theta = 1$, the opposite and adjacent sides are equal. This occurs in a $45^\\circ-45^\\circ-90^\\circ$ triangle.

\\textbf{Calculation and Logic:}

Let the legs be 1. The hypotenuse is $\\sqrt{1^2 + 1^2} = \\sqrt{2}$.

$\\sin \\theta = (1)/(\\sqrt{2)}$.

Rationalizing the denominator: $(1)/(\\sqrt{2)} × \\frac{\\sqrt{2}}{\\sqrt{2}} = \\frac{\\sqrt{2}}{2}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_051_25',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In a right triangle, $\\sin \\theta = 0.8$. What is the value of $(\\cos \\theta)^2$?',
  '[{"id":"a","text":"0.2"},{"id":"b","text":"0.36"},{"id":"c","text":"0.6"},{"id":"d","text":"0.64"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We use the Pythagorean identity which states that the square of the sine of an angle plus the square of the cosine of the same angle always equals 1.

\\textbf{Calculation and Logic:}

Substitute the given value into the identity $\\sin^2 \\theta + \\cos^2 \\theta = 1$.

$(0.8)^2 + \\cos^2 \\theta = 1$.

$0.64 + \\cos^2 \\theta = 1$.

Subtracting 0.64 from both sides gives $\\cos^2 \\theta = 0.36$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_26',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In the figure below, $\\triangle ABC$ is similar to $\\triangle DEF$. If $\\cos A = \\frac{12}{13}$, what is the value of $\\cos D$? \\begin{center} \\begin{tikzpicture}[scale=0.7] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (2.4,0) node[anchor=north west]{$C$} -- (2.4,1) node[anchor=south west]{$B$} -- cycle; \\draw (2.1,0) -- (2.1,0.3) -- (2.4,0.3); \\begin{scope}[shift={(4,0)}] \\draw[thick] (0,0) node[anchor=north east]{$D$} -- (4.8,0) node[anchor=north west]{$F$} -- (4.8,2) node[anchor=south west]{$E$} -- cycle; \\draw (4.5,0) -- (4.5,0.3) -- (4.8,0.3); \\end{scope} \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$\\\\frac{5}{13}$"},{"id":"b","text":"$\\\\frac{12}{13}$"},{"id":"c","text":"$\\\\frac{13}{12}$"},{"id":"d","text":"$\\\\frac{24}{26}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Trigonometric ratios depend only on the measure of the angle, not the size of the triangle. Since the triangles are similar, their corresponding angles are equal.

\\textbf{Calculation and Logic:}

Angle $A$ corresponds to angle $D$ in the similar triangles.

Therefore, the measure of angle $A$ is equal to the measure of angle $D$.

Since the angles are equal, their cosines must be equal.

Given $\\cos A = 12/13$, it follows that $\\cos D = 12/13$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_27',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'In right triangle $RST$ (not shown), $\\angle S = 90^\\circ$. If $\\tan R = \\frac{24}{7}$, what is the value of $\\sin T$?',
  NULL,
  '7/25',
  '\\textbf{Conceptual Explanation:}

The tangent of angle $R$ gives us the ratio of the side opposite $R$ ($ST$) to the side adjacent to $R$ ($RS$). We need to find the hypotenuse to determine the sine of angle $T$.

\\textbf{Calculation and Logic:}

Let $ST = 24$ and $RS = 7$.

The hypotenuse $RT = \\sqrt{24^2 + 7^2} = \\sqrt{576 + 49} = \\sqrt{625} = 25$.

Angle $T$ is opposite side $RS$.

By definition, $\\sin T = \\frac{\\text{opposite to T}}{\\text{hypotenuse}} = (RS)/(RT) = (7)/(25)$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_28',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'A surveyor stands 50 meters from the base of a building. The angle of elevation to the top of the building is $37^\\circ$. If $\\tan 37^\\circ \\approx 0.75$, what is the height of the building in meters?',
  '[{"id":"a","text":"37.5"},{"id":"b","text":"40"},{"id":"c","text":"66.7"},{"id":"d","text":"75"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The distance from the building represents the adjacent side of a right triangle, and the height of the building represents the opposite side. We use the tangent ratio to relate these.

\\textbf{Calculation and Logic:}

$\\tan(37^\\circ) = \\frac{\\text{height}}{50}$.

Substituting the given value, $0.75 = \\frac{\\text{height}}{50}$.

Multiplying both sides by 50, we get height $= 50 × 0.75 = 37.5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_29',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In a right triangle, $\\angle A$ and $\\angle B$ are acute. If $\\tan A = \\frac{a}{b}$, what is $\\tan B$?',
  '[{"id":"a","text":"$\\\\frac{a}{b}$"},{"id":"b","text":"$\\\\frac{b}{a}$"},{"id":"c","text":"$\\\\frac{a}{\\\\sqrt{a^2+b^2}}$"},{"id":"d","text":"$\\\\frac{b}{\\\\sqrt{a^2+b^2}}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In a right triangle, the side opposite angle $A$ is the side adjacent to angle $B$, and vice versa. This makes their tangent ratios reciprocals of each other.

\\textbf{Calculation and Logic:}

$\\tan A = \\frac{\\text{opp A}}{\\text{adj A}} = (a)/(b)$.

Since the opposite of $A$ is the adjacent of $B$, and the adjacent of $A$ is the opposite of $B$:

$\\tan B = \\frac{\\text{opp B}}{\\text{adj B}} = (b)/(a)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_30',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'In right triangle $ABC$, $\\angle C = 90^\\circ$, $AC = 3$, and $BC = 4$. What is the value of $\\cos A$?',
  NULL,
  '0.6',
  '\\textbf{Conceptual Explanation:}

We are given the two legs of the triangle. We must first find the hypotenuse using the Pythagorean theorem and then apply the definition of cosine for angle $A$.

\\textbf{Calculation and Logic:}

Hypotenuse $AB = \\sqrt{3^2 + 4^2} = 5$.

The side adjacent to angle $A$ is $AC$, which has a length of 3.

By definition, $\\cos A = \\frac{\\text{adjacent}}{\\text{hypotenuse}} = (3)/(5)$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_051_31',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, an angle $\\alpha$ has its vertex at the origin and its initial side on the positive $x$-axis. If the point $(-3, 4)$ lies on the terminal side of $\\alpha$, what is $\\sin \\alpha$?',
  '[{"id":"a","text":"$-0.6$"},{"id":"b","text":"$-0.75$"},{"id":"c","text":"$0.6$"},{"id":"d","text":"$0.8$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

In the coordinate plane, for any point $(x, y)$ on the terminal side of an angle, $\\sin \\alpha = y/r$, where $r$ is the distance from the origin.

\\textbf{Calculation and Logic:}

The $y$-coordinate is 4 and the $x$-coordinate is $-3$.

Calculate $r = \\sqrt{(-3)^2 + 4^2} = \\sqrt{9 + 16} = 5$.

Substitute into the sine formula: $\\sin \\alpha = 4/5 = 0.8$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_32',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In $\\triangle ABC$ (not shown), $\\angle C = 90^\\circ$. If $\\sin A = \\frac{\\sqrt{2}}{2}$, what is the measure of angle $B$ in degrees?',
  '[{"id":"a","text":"$30^\\\\circ$"},{"id":"b","text":"$45^\\\\circ$"},{"id":"c","text":"$60^\\\\circ$"},{"id":"d","text":"$90^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We identify the angle $A$ whose sine is $\\sqrt{2}/2$. Since the triangle is a right triangle, angles $A$ and $B$ must sum to $90^\\circ$.

\\textbf{Calculation and Logic:}

The sine value $\\frac{\\sqrt{2}}{2}$ corresponds to an angle of $45^\\circ$.

Therefore, $A = 45^\\circ$.

Since $A + B = 90^\\circ$, we have $45^\\circ + B = 90^\\circ$.

Solving for $B$ gives $B = 45^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_33',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In a right triangle, $\\cos \\theta = \\frac{x}{12}$. If $\\sin(90^\\circ - \\theta) = \\frac{2}{3}$, what is the value of $x$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"6"},{"id":"c","text":"8"},{"id":"d","text":"9"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This problem uses the cofunction identity where $\\sin(90^\\circ - \\theta) = \\cos \\theta$. We set the two expressions for cosine equal to each other.

\\textbf{Calculation and Logic:}

From the identity, $\\cos \\theta = \\sin(90^\\circ - \\theta) = (2)/(3)$.

We are also given $\\cos \\theta = (x)/(12)$.

Set them equal: $(x)/(12) = (2)/(3)$.

Cross-multiply: $3x = 24$.

Divide by 3: $x = 8$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_34',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In the figure below, $AD = 10$, $CD = 6$, and $\\angle C = 90^\\circ$. What is $\\cos (\\angle DAC)$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (4,0) node[anchor=north west]{$C$} -- (4,3) node[anchor=south west]{$D$} -- cycle; \\draw (3.7,0) -- (3.7,0.3) -- (4,0.3); \\node at (2, 1.8) {10}; \\node at (4.3, 1.5) {6}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"0.6"},{"id":"b","text":"0.75"},{"id":"c","text":"0.8"},{"id":"d","text":"1.25"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To find the cosine of $\\angle DAC$, we need the ratio of the side adjacent to it ($AC$) to the hypotenuse ($AD$). We use the Pythagorean theorem to find $AC$.

\\textbf{Calculation and Logic:}

$AC = \\sqrt{AD^2 - CD^2} = \\sqrt{10^2 - 6^2} = \\sqrt{100 - 36} = \\sqrt{64} = 8$.

By definition, $\\cos(\\angle DAC) = (AC)/(AD) = (8)/(10) = 0.8$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_35',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'If $\\sin \\theta = \\frac{1}{k}$ and $0 < \\theta < 90^\\circ$, what is $\\tan \\theta$ in terms of $k$?',
  '[{"id":"a","text":"$\\\\sqrt{k^2-1}$"},{"id":"b","text":"$\\\\frac{1}{\\\\sqrt{k^2-1}}$"},{"id":"c","text":"$\\\\frac{k}{\\\\sqrt{k^2-1}}$"},{"id":"d","text":"$\\\\frac{\\\\sqrt{k^2-1}}{k}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We can model this using a right triangle where the opposite side is 1 and the hypotenuse is $k$. We find the adjacent side and then determine the tangent ratio.

\\textbf{Calculation and Logic:}

Opposite side $= 1$, Hypotenuse $= k$.

Adjacent side $= \\sqrt{k^2 - 1^2} = \\sqrt{k^2 - 1}$.

$\\tan \\theta = \\frac{\\text{opposite}}{\\text{adjacent}} = (1)/(\\sqrt{k^2 - 1)}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_36',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In $\\triangle ABC$, the measure of $\\angle B$ is $90^\\circ$. If $\\sin A = \\frac{x}{y}$, what is $\\cos C$?',
  '[{"id":"a","text":"$\\\\frac{x}{y}$"},{"id":"b","text":"$\\\\frac{y}{x}$"},{"id":"c","text":"$\\\\frac{\\\\sqrt{y^2-x^2}}{y}$"},{"id":"d","text":"$\\\\frac{\\\\sqrt{y^2-x^2}}{x}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In a right triangle where $\\angle B$ is $90^\\circ$, angles $A$ and $C$ are complementary. The sine of one acute angle equals the cosine of the other.

\\textbf{Calculation and Logic:}

The cofunction identity states that $\\sin A = \\cos(90^\\circ - A)$.

Since $A + C = 90^\\circ$, then $90^\\circ - A = C$.

Therefore, $\\sin A = \\cos C$.

Given $\\sin A = x/y$, then $\\cos C$ must also be $x/y$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_37',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'In a right triangle, $\\tan \\theta = \\frac{15}{8}$. What is the value of $\\cos \\theta$?',
  NULL,
  '8/17',
  '\\textbf{Conceptual Explanation:}

The tangent ratio provides the opposite and adjacent sides. We calculate the hypotenuse and then find the cosine ratio.

\\textbf{Calculation and Logic:}

Opposite $= 15$, Adjacent $= 8$.

Hypotenuse $= \\sqrt{15^2 + 8^2} = \\sqrt{225 + 64} = \\sqrt{289} = 17$.

$\\cos \\theta = \\frac{\\text{adjacent}}{\\text{hypotenuse}} = (8)/(17)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_38',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In the figure below, line $l$ passes through the origin and the point $(k, 3)$. If the angle $\\theta$ formed by line $l$ and the positive $x$-axis satisfies $\\cos \\theta = \\frac{4}{5}$, what is the value of $k$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[->] (-0.5,0) -- (5,0) node[anchor=north]{$x$}; \\draw[->] (0,-0.5) -- (0,4) node[anchor=east]{$y$}; \\draw[thick, blue] (0,0) -- (4,3) node[anchor=south west, black]{$(k, 3)$}; \\draw (0.8,0) arc (0:36.87:0.8) node[midway, right]{$\\theta$}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"6"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The point $(k, 3)$ forms a right triangle with the $x$-axis where $k$ is the adjacent side and 3 is the opposite side. We use the given cosine to find the relationship between the sides.

\\textbf{Calculation and Logic:}

If $\\cos \\theta = 4/5$, then the ratio of adjacent to hypotenuse is $4:5$.

In a $3-4-5$ triangle, if the adjacent side is 4 and the hypotenuse is 5, the opposite side is 3.

Here, the opposite side ($y$-coordinate) is given as 3.

Therefore, the adjacent side $k$ must be 4.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_39',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In a right triangle, $\\sin \\theta = p$. Which of the following is equivalent to $\\tan \\theta$?',
  '[{"id":"a","text":"$\\\\frac{p}{\\\\sqrt{1-p^2}}$"},{"id":"b","text":"$\\\\frac{\\\\sqrt{1-p^2}}{p}$"},{"id":"c","text":"$\\\\frac{p}{1-p}$"},{"id":"d","text":"$\\\\sqrt{1-p^2}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We express tangent in terms of sine and cosine, then use the Pythagorean identity to replace cosine with an expression involving sine.

\\textbf{Calculation and Logic:}

$\\tan \\theta = (\\sin \\theta)/(\\cos \\theta)$.

From $\\sin^2 \\theta + \\cos^2 \\theta = 1$, we get $\\cos \\theta = \\sqrt{1 - \\sin^2 \\theta} = \\sqrt{1 - p^2}$.

Substituting these into the tangent formula gives $(p)/(\\sqrt{1 - p^2)}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_40',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In $\\triangle ABC$, $\\angle C = 90^\\circ$. If $\\cos B = \\frac{21}{29}$, what is $\\sin B$?',
  '[{"id":"a","text":"$\\\\frac{20}{29}$"},{"id":"b","text":"$\\\\frac{21}{20}$"},{"id":"c","text":"$\\\\frac{29}{21}$"},{"id":"d","text":"$\\\\frac{8}{29}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Given one trigonometric ratio, we use the Pythagorean theorem to find the missing side and determine the other ratio for the same angle.

\\textbf{Calculation and Logic:}

Adjacent side $= 21$, Hypotenuse $= 29$.

Opposite side $= \\sqrt{29^2 - 21^2} = \\sqrt{841 - 441} = \\sqrt{400} = 20$.

$\\sin B = \\frac{\\text{opposite}}{\\text{hypotenuse}} = (20)/(29)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_41',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'For which of the following angles is $\\sin \\theta = \\cos \\theta$?',
  '[{"id":"a","text":"$0^\\\\circ$"},{"id":"b","text":"$30^\\\\circ$"},{"id":"c","text":"$45^\\\\circ$"},{"id":"d","text":"$60^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The sine and cosine of an angle are equal when the opposite side and adjacent side of the right triangle are equal in length.

\\textbf{Calculation and Logic:}

This occurs in an isosceles right triangle ($45^\\circ-45^\\circ-90^\\circ$).

At $45^\\circ$, both $\\sin \\theta$ and $\\cos \\theta$ equal $\\frac{\\sqrt{2}}{2}$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_051_42',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In right triangle $JKL$, $\\angle K = 90^\\circ$ and $\\sin J = \\frac{1}{2}$. What is the length of $KL$ if $JL = 10$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"$5\\\\sqrt{3}$"},{"id":"c","text":"10"},{"id":"d","text":"20"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We are given the hypotenuse ($JL$) and the sine of angle $J$. The side $KL$ is opposite to angle $J$, so we can use the sine ratio directly.

\\textbf{Calculation and Logic:}

$\\sin J = (KL)/(JL)$.

$(1)/(2) = (KL)/(10)$.

Multiplying both sides by 10 gives $KL = 5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_43',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'If $\\sin(x + 20)^\\circ = \\cos(x + 10)^\\circ$ and both angles are acute, what is the value of $x$?',
  NULL,
  '30',
  '\\textbf{Conceptual Explanation:}

The sine of one angle equals the cosine of another when the two angles are complementary (sum to 90 degrees).

\\textbf{Calculation and Logic:}

$(x + 20) + (x + 10) = 90$.

$2x + 30 = 90$.

$2x = 60$.

$x = 30$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_44',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In a right triangle, $\\tan \\theta = \\frac{1}{\\sqrt{3}}$. What is $\\cos \\theta$?',
  '[{"id":"a","text":"$\\\\frac{1}{2}$"},{"id":"b","text":"$\\\\frac{\\\\sqrt{2}}{2}$"},{"id":"c","text":"$\\\\frac{\\\\sqrt{3}}{2}$"},{"id":"d","text":"$\\\\frac{\\\\sqrt{3}}{1}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A tangent of $1/\\sqrt{3}$ identifies this as a $30^\\circ-60^\\circ-90^\\circ$ triangle. We can either identify the angle or use the side ratios.

\\textbf{Calculation and Logic:}

Opposite $= 1$, Adjacent $= \\sqrt{3}$.

Hypotenuse $= \\sqrt{1^2 + (\\sqrt{3})^2} = \\sqrt{1 + 3} = 2$.

$\\cos \\theta = \\frac{\\text{adjacent}}{\\text{hypotenuse}} = \\frac{\\sqrt{3}}{2}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_45',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'The triangle below is a right triangle. What is the value of $\\sin A + \\cos A$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (4,0) node[anchor=north west]{$C$} -- (4,3) node[anchor=south west]{$B$} -- cycle; \\draw (3.7,0) -- (3.7,0.3) -- (4,0.3); \\node at (2, -0.4) {12}; \\node at (4.3, 1.5) {5}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$\\\\frac{17}{13}$"},{"id":"b","text":"$\\\\frac{17}{12}$"},{"id":"c","text":"$1$"},{"id":"d","text":"$\\\\frac{7}{13}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We first calculate the hypotenuse of the triangle and then sum the sine and cosine ratios for angle $A$.

\\textbf{Calculation and Logic:}

Hypotenuse $AB = \\sqrt{12^2 + 5^2} = \\sqrt{144 + 25} = 13$.

$\\sin A = \\frac{\\text{opp}}{\\text{hyp}} = (5)/(13)$.

$\\cos A = \\frac{\\text{adj}}{\\text{hyp}} = (12)/(13)$.

Sum $= (5)/(13) + (12)/(13) = (17)/(13)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_46',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In right triangle $XYZ$, $\\angle Y = 90^\\circ$ and $\\tan X = t$. What is $\\sin Z$ in terms of $t$?',
  '[{"id":"a","text":"$\\\\frac{t}{\\\\sqrt{1+t^2}}$"},{"id":"b","text":"$\\\\frac{1}{\\\\sqrt{1+t^2}}$"},{"id":"c","text":"$t$"},{"id":"d","text":"$\\\\frac{1}{t}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Since $X$ and $Z$ are complementary, $\\sin Z = \\cos X$. We find $\\cos X$ based on the given tangent.

\\textbf{Calculation and Logic:}

$\\tan X = \\frac{\\text{opp X}}{\\text{adj X}} = (t)/(1)$.

Hypotenuse $= \\sqrt{t^2 + 1^2} = \\sqrt{t^2 + 1}$.

$\\cos X = \\frac{\\text{adj X}}{\\text{hyp}} = (1)/(\\sqrt{t^2 + 1)}$.

Since $\\sin Z = \\cos X$, then $\\sin Z = (1)/(\\sqrt{t^2 + 1)}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_47',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In the figure below, triangle $ABC$ is a right triangle. What is $\\tan A$? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=north east]{$A$} -- (5,0) node[anchor=north west]{$C$} -- (5,2) node[anchor=south west]{$B$} -- cycle; \\draw (4.7,0) -- (4.7,0.3) -- (5,0.3); \\node at (2.5, 1.3) {$\\sqrt{29}$}; \\node at (5.3, 1) {2}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$\\\\frac{2}{5}$"},{"id":"b","text":"$\\\\frac{5}{2}$"},{"id":"c","text":"$\\\\frac{2}{\\\\sqrt{29}}$"},{"id":"d","text":"$\\\\frac{5}{\\\\sqrt{29}}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Tangent is the ratio of opposite to adjacent sides. We are given the opposite side and the hypotenuse, so we must find the adjacent side first.

\\textbf{Calculation and Logic:}

$AC = \\sqrt{(\\sqrt{29})^2 - 2^2} = \\sqrt{29 - 4} = \\sqrt{25} = 5$.

$\\tan A = \\frac{\\text{opposite}}{\\text{adjacent}} = (2)/(5)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_051_48',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, the line $y = \\frac{3}{4}x$ passes through the origin and forms an acute angle $\\theta$ with the positive $x$-axis. What is the value of $\\cos \\theta$?',
  '[{"id":"a","text":"$\\\\frac{3}{5}$"},{"id":"b","text":"$\\\\frac{4}{5}$"},{"id":"c","text":"$\\\\frac{3}{4}$"},{"id":"d","text":"$\\\\frac{4}{3}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The slope of a line passing through the origin is equivalent to the tangent of the angle it makes with the positive $x$-axis. We can use this slope to define the opposite and adjacent sides of a right triangle.

\\textbf{Calculation and Logic:}

The slope $m = 3/4$, which means $\\tan \\theta = 3/4$.

We can treat the opposite side as 3 and the adjacent side as 4.

The hypotenuse is $\\sqrt{3^2 + 4^2} = 5$.

By definition, $\\cos \\theta = \\frac{\\text{adjacent}}{\\text{hypotenuse}} = (4)/(5)$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_49',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
),
  (
  'spr',
  'math',
  'In $\\triangle ABC$, $\\angle C = 90^\\circ$ and $\\tan A = \\frac{w}{z}$. If $z > w$, what is the value of $\\cos(90^\\circ - B)$?',
  NULL,
  '$z/\\sqrt{w^2+z^2',
  '\\textbf{Conceptual Explanation:}

This problem requires understanding two concepts: the definition of tangent and the cofunction relationship. Note that in a right triangle, the complement of angle $B$ is angle $A$.

\\textbf{Calculation and Logic:}

Since $A + B = 90^\\circ$, then $90^\\circ - B = A$.

Therefore, $\\cos(90^\\circ - B) = \\cos A$.

From $\\tan A = w/z$, we have opposite $= w$ and adjacent $= z$.

The hypotenuse is $\\sqrt{w^2 + z^2}$.

Wait, let''s re-examine: $\\cos(90^\\circ - B)$ is identically equal to $\\sin B$.

The side opposite angle $B$ is the side adjacent to angle $A$, which is $z$.

The hypotenuse remains $\\sqrt{w^2 + z^2}$.

Therefore, $\\sin B = (z)/(\\sqrt{w^2 + z^2)}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_051_50',
  'Right-triangle trig: sin, cos, tan',
  'SOH CAH TOA'
)
ON CONFLICT (bank_item_id) DO NOTHING;

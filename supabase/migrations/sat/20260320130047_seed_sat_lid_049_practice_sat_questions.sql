-- Practice-mode math from lid_049.tex (sat_lid_049)
-- Chapter: Circle properties: arcs, chords, angles | Topic: Arc Length & Sector Area
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_049_N, practice module/set 0.

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
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) circle (2); \\filldraw (0,0) circle (1.5pt) node[left] {$O$}; \\draw[thick] (0,0) -- (30:2) node[right] {$C$}; \\draw[thick] (0,0) -- (-40:2) node[right] {$A$}; \\node at (0.4, -0.1) {$x^\\circ$}; \\node at (-2.2, 0) {$B$}; \\node at (1.8, 1) {$D$}; \\end{tikzpicture} \\end{center} The circle above has center $O$, the length of arc $\\text{ADC}$ is $5\\pi$, and $x = 100$. What is the length of arc $\\text{ABC}$?',
  '[{"id":"a","text":"$9\\\\pi$"},{"id":"b","text":"$13\\\\pi$"},{"id":"c","text":"$18\\\\pi$"},{"id":"d","text":"$\\\\frac{13}{2}\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The length of an arc in a circle is proportional to the measure of its central angle. The ratio of the arc length to the total circumference is equal to the ratio of the central angle to $360^\\circ$. By setting up a proportion, we can determine the relationship between different arcs in the same circle.

\\textbf{Calculation and Logic:}

First, identify the central angle for arc $\\text{ADC}$, which is $x = 100^\\circ$. We are given that its length is $5\\pi$. Set up a ratio of arc length to angle: $\\text{Ratio} = 5\\pi / 100^\\circ = \\pi / 20^\\circ$. This means every degree of central angle corresponds to $\\pi/20$ units of arc length. Next, determine the central angle for the remaining part of the circle, arc $\\text{ABC}$. Since a full circle is $360^\\circ$, the angle for arc $\\text{ABC}$ is $360 - 100 = 260^\\circ$. Now, apply the established ratio to find the length of arc $\\text{ABC}$: $\\text{Length} = 260 × (\\pi / 20)$. Performing the division, $260 / 20$ equals 13. Therefore, the length of arc $\\text{ABC}$ is $13\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_1',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) circle (2); \\filldraw (0,0) circle (1.5pt) node[below] {$O$}; \\draw[thick] (0,0) -- (150:2) coordinate (A) node[above left] {$A$}; \\draw[thick] (0,0) -- (30:2) coordinate (B) node[above right] {$B$}; \\draw[thick] (A) -- (B); \\draw[thick] (0,0) -- (0,-2) node[below] {$C$}; \\node at (0, 0.4) {$30^\\circ$}; \\end{tikzpicture} \\end{center} Point $O$ is the center of the circle above, and the measure of $\\angle OAB$ is $30^\\circ$. If the length of $\\overline{OC}$ is 18, what is the length of arc $\\text{AB}$?',
  '[{"id":"a","text":"$9\\\\pi$"},{"id":"b","text":"$12\\\\pi$"},{"id":"c","text":"$15\\\\pi$"},{"id":"d","text":"$18\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To find arc length, we need the radius of the circle and the measure of the central angle. In this figure, $\\triangle OAB$ is an isosceles triangle because $OA$ and $OB$ are radii. We can use the triangle sum theorem to find the central angle $\\angle AOB$.

\\textbf{Calculation and Logic:}

First, identify the radius. Since $C$ lies on the circle and $O$ is the center, the segment $\\overline{OC}$ is a radius. Thus, $r = 18$. Second, find the central angle $\\angle AOB$. In $\\triangle OAB$, $OA = OB$, so $\\angle OBA = \\angle OAB = 30^\\circ$. The sum of angles in a triangle is $180^\\circ$, so $\\angle AOB = 180 - (30 + 30) = 180 - 60 = 120^\\circ$. Third, use the arc length formula $L = ( \\text{angle} / 360 ) × 2\\pi r$. Substitute the values: $L = ( 120 / 360 ) × 2\\pi(18)$. Simplify the fraction: $120/360 = 1/3$. Calculate the circumference part: $2 × 18 = 36$. Finally, multiply: $(1/3) × 36\\pi = 12\\pi$. The length of arc $\\text{AB}$ is $12\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_2',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) circle (2); \\filldraw (0,0) circle (1.5pt) node[below] {$O$}; \\draw[thick] (-1.2, 1.6) node[above left] {$S$} -- (1.2, -1.6) node[below right] {$Q$}; \\draw[thick] (1.2, 1.6) node[above right] {$R$} -- (-1.2, -1.6) node[below left] {$P$}; \\end{tikzpicture} \\end{center} The circle shown has center $O$, circumference $144\\pi$, and diameters $\\overline{PR}$ and $\\overline{QS}$. The length of arc $\\text{PS}$ is twice the length of arc $\\text{PQ}$. What is the length of arc $\\text{QR}$?',
  '[{"id":"a","text":"$24\\\\pi$"},{"id":"b","text":"$48\\\\pi$"},{"id":"c","text":"$72\\\\pi$"},{"id":"d","text":"$96\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The total circumference of a circle is $360^\\circ$. A diameter splits the circle into two $180^\\circ$ arcs. Since vertical angles are equal, the arcs opposite each other ($\\text{PS}$ and $\\text{QR}$) are identical in length.

\\textbf{Calculation and Logic:}

Identify that $\\overline{PR}$ is a diameter, so arc $\\text{PQR} = 180^\\circ$, which is half the circumference: $144\\pi / 2 = 72\\pi$. Similarly, arc $\\text{PSQ} = 180^\\circ$. Let the length of arc $\\text{PQ}$ be $x$. We are told arc $\\text{PS} = 2x$. Since $\\text{PS} + \\text{PQ} = 180^\\circ$ (the semicircle), we have $2x + x = 180^\\circ$, or $3x$ corresponds to $72\\pi$. Solving for $x$: $x = 72\\pi / 3 = 24\\pi$. Therefore, arc $\\text{PQ} = 24\\pi$ and arc $\\text{PS} = 48\\pi$. Because $\\angle PSQ$ and $\\angle QOR$ are related by vertical angles ($\\angle POQ$ vertical to $\\angle SOR$, and $\\angle POS$ vertical to $\\angle QOR$), arc $\\text{QR}$ must be equal to its vertical counterpart, arc $\\text{PS}$. Thus, arc $\\text{QR} = 48\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_3',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'A circle has center $O$, and points $A$ and $B$ lie on the circle. The measure of arc $\\text{AB}$ is $45^\\circ$ and the length of arc $\\text{AB}$ is 3 inches. What is the circumference, in inches, of the circle?',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"9"},{"id":"d","text":"24"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Arc length is a fractional part of the total circumference. The fraction is determined by the central angle divided by $360^\\circ$.

\\textbf{Calculation and Logic:}

First, find the fraction of the circle represented by the arc. The angle is $45^\\circ$. The fraction is $45 / 360$. To simplify, divide both by 45: $45 / 360 = 1 / 8$. This means the arc length is exactly $1/8$ of the total circumference. Set up the equation: $(1/8) × \\text{Circumference} = 3 \\text{ inches}$. To solve for the circumference, multiply both sides by 8. The calculation $3 × 8$ results in 24. Therefore, the circumference of the circle is 24 inches.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_4',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'The graph of $x^2 + x + y^2 + y = \\frac{199}{2}$ in the $xy$-plane is a circle. What is the length of the circle’s radius?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

To find the radius of a circle from its general equation, we must rewrite it in standard form: $(x-h)^2 + (y-k)^2 = r^2$. This is achieved through the process of completing the square for both $x$ and $y$ terms.

\\textbf{Calculation and Logic:}

Start with the equation: $x^2 + x + y^2 + y = 99.5$. To complete the square for $x$, take half of the coefficient of $x$ (which is 1), resulting in $0.5$, and square it: $(0.5)^2 = 0.25$. Do the same for $y$: $(0.5)^2 = 0.25$. Add these values to both sides of the equation to maintain equality: $(x^2 + x + 0.25) + (y^2 + y + 0.25) = 99.5 + 0.25 + 0.25$. This simplifies to $(x + 0.5)^2 + (y + 0.5)^2 = 100$. In the standard form, $r^2 = 100$. To find the radius $r$, take the square root of 100. The calculation $\\sqrt{100}$ results in 10. The length of the circle''s radius is 10.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_5',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'A circle has center $O$, and points $R$ and $S$ lie on the circle. In triangle $ORS$, the measure of $\\angle ROS$ is $88^\\circ$. What is the measure of $\\angle RSO$, in degrees?',
  NULL,
  '46',
  '\\textbf{Conceptual Explanation:}

Any triangle formed by the center of a circle and two points on its circumference is an isosceles triangle because two of its sides are radii of the same circle ($OR = OS$).

\\textbf{Calculation and Logic:}

In $\\triangle ORS$, identify that side $OR$ and side $OS$ are equal in length (both are radii). According to the Base Angles Theorem, the angles opposite these sides must be equal: $\\angle RSO = \\angle SRO$. Let the measure of these angles be $a$. The sum of angles in a triangle is $180^\\circ$. Set up the equation: $88 + a + a = 180$. Simplify to $88 + 2a = 180$. Subtract 88 from both sides: $2a = 92$. Divide by 2: $a = 46$. Therefore, the measure of $\\angle RSO$ is 46 degrees.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_6',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'The number of radians in a 720-degree angle can be written as $a\\pi$, where $a$ is a constant. What is the value of $a$?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

To convert degrees to radians, multiply the degree measure by the conversion factor $\\pi / 180$. This relationship exists because a full circle is $360^\\circ$, which is equivalent to $2\\pi$ radians.

\\textbf{Calculation and Logic:}

Identify the given degree measure: $720^\\circ$. Apply the conversion: $720 × (\\pi / 180)$. Simplify the numerical fraction by dividing 720 by 180. Since $180 × 2 = 360$ and $360 × 2 = 720$, then $720 / 180 = 4$. This results in $4\\pi$. In the form $a\\pi$, the value of the constant $a$ is 4.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_049_7',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) circle (2); \\filldraw (0,0) circle (1.5pt) node[below] {$O$}; \\draw[thick] (-1.41, 1.41) node[above left] {$A$} -- (1.41, -1.41); \\draw[thick] (1.41, 1.41) node[above right] {$C$} -- (-1.41, -1.41); \\draw (0.2, 0) -- (0.2, 0.2) -- (0, 0.2); \\end{tikzpicture} \\end{center} The circle above with center $O$ has a circumference of 36. What is the length of minor arc $\\text{AC}$?',
  '[{"id":"a","text":"9"},{"id":"b","text":"12"},{"id":"c","text":"18"},{"id":"d","text":"36"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In a circle, perpendicular diameters divide the circle into four equal $90^\\circ$ arcs. The length of one of these arcs is exactly one-fourth of the total circumference.

\\textbf{Calculation and Logic:}

Observe the diagram: the central angle $\\angle AOC$ is marked with a right angle symbol, indicating it measures $90^\\circ$. To find the length of arc $\\text{AC}$, calculate the ratio of the central angle to the total circle: $90 / 360 = 1 / 4$. Since the arc represents one-fourth of the circle, multiply the total circumference by this fraction: $36 × (1/4)$. Performing the division, $36 / 4$ equals 9. Therefore, the length of minor arc $\\text{AC}$ is 9.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_8',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'Points $A$ and $B$ lie on a circle with radius 1, and arc $\\text{AB}$ has length $\\pi / 3$. What fraction of the circumference of the circle is the length of arc $\\text{AB}$?',
  NULL,
  '1/6',
  '\\textbf{Conceptual Explanation:}

To find the fraction of the circumference, first calculate the total circumference using the radius, then set up a ratio of the specific arc length to that total.

\\textbf{Calculation and Logic:}

First, calculate the circumference of the circle with $r = 1$: $C = 2\\pi r = 2\\pi(1) = 2\\pi$. Second, express the length of arc $\\text{AB}$ as a ratio to this circumference: $\\text{Ratio} = (\\pi / 3) / (2\\pi)$. To simplify, divide by $\\pi$, which leaves $(1/3) / 2$. Multiplying by the reciprocal of the denominator: $(1/3) × (1/2) = 1/6$. Therefore, the arc length is $1/6$ of the circumference.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_9',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'A circle has a radius of 10. The area of a sector of this circle is $20\\pi$. What is the measure of the central angle of this sector, in degrees?',
  NULL,
  '72',
  '\\textbf{Conceptual Explanation:}

The area of a sector is proportional to its central angle. The ratio of the sector area to the total circle area is equal to the ratio of the central angle to $360^\\circ$.

\\textbf{Calculation and Logic:}

First, calculate the total area of the circle with radius $r = 10$: $\\text{Area} = \\pi r^2 = \\pi(10)^2 = 100\\pi$. Second, determine the fraction of the circle occupied by the sector: $\\text{Fraction} = 20\\pi / 100\\pi$. Simplifying this results in $20/100$, or $1/5$. Third, since the sector is $1/5$ of the circle, its central angle must be $1/5$ of the total $360^\\circ$: $\\text{Angle} = (1/5) × 360$. Performing the division, $360 / 5 = 72$. The measure of the central angle is 72 degrees.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_10',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'In a circle with radius 6, what is the length of an arc intercepted by a central angle of $60^\\circ$?',
  '[{"id":"a","text":"$\\\\pi$"},{"id":"b","text":"$2\\\\pi$"},{"id":"c","text":"$3\\\\pi$"},{"id":"d","text":"$6\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Find the circumference: $C = 2\\pi(6) = 12\\pi$. Calculate the arc''s fraction of the circle: $60 / 360 = 1 / 6$. Multiply the circumference by the fraction: $(1/6) × 12\\pi$. Performing the calculation, $12 / 6 = 2$. Therefore, the arc length is $2\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_11',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'If the area of a circle is $144\\pi$, what is the length of an arc with a central angle of $150^\\circ$? (Give answer in terms of $\\pi$).',
  NULL,
  '$10\\pi$',
  '\\textbf{Calculation and Logic:}

First, find the radius from the area: $\\pi r^2 = 144\\pi$, so $r = 12$. Second, calculate the circumference: $C = 2\\pi(12) = 24\\pi$. Third, find the arc length using the proportion: $L = (150 / 360) × 24\\pi$. Simplify the fraction $150/360$: divide both by 30 to get $5/12$. Calculate the final length: $(5/12) × 24\\pi$. Since $24/12 = 2$, we have $5 × 2\\pi = 10\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_12',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'A sector has an area of $6\\pi$ and a central angle of $60^\\circ$. What is the radius of the circle?',
  '[{"id":"a","text":"3"},{"id":"b","text":"6"},{"id":"c","text":"12"},{"id":"d","text":"36"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Find the ratio of the sector to the whole circle: $60 / 360 = 1 / 6$. Since the sector is $1/6$ of the total area, the total area is $6 × 6\\pi = 36\\pi$. Use the area formula to find $r$: $\\pi r^2 = 36\\pi$. Dividing by $\\pi$ gives $r^2 = 36$. Taking the square root, $r = 6$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_13',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'How many degrees are in an angle of $3\\pi / 2$ radians?',
  '[{"id":"a","text":"90"},{"id":"b","text":"180"},{"id":"c","text":"270"},{"id":"d","text":"360"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

To convert radians to degrees, multiply by $180 / \\pi$. Apply this to the given angle: $(3\\pi / 2) × (180 / \\pi)$. The $\\pi$ terms cancel out, leaving $(3/2) × 180$. Divide 180 by 2 to get 90. Then multiply by 3: $3 × 90 = 270$. The angle is 270 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_14',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'In a circle, arc $A$ has length $L$ and central angle $\\theta$. If arc $B$ has the same central angle $\\theta$ but the circle''s radius is doubled, what is the length of arc $B$?',
  '[{"id":"a","text":"$L/2$"},{"id":"b","text":"$L$"},{"id":"c","text":"$2L$"},{"id":"d","text":"$4L$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Arc length is given by $L = r\\theta$ (when $\\theta$ is in radians). If the angle $\\theta$ stays constant and the radius $r$ is replaced with $2r$, the new length is $(2r)\\theta$. This can be rewritten as $2(r\\theta)$, which is $2L$. Therefore, doubling the radius doubles the arc length for a fixed angle.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_15',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'What is the area of a sector with radius 8 and central angle $\\pi / 4$ radians? (In terms of $\\pi$).',
  NULL,
  '$8\\pi$',
  '\\textbf{Conceptual Explanation:}

The area of a sector using radian measure is given by the formula $A = (1)/(2)r^2\\theta$.

\\textbf{Calculation and Logic:}

Identify $r = 8$ and $\\theta = \\pi / 4$. Substitute into the formula: $A = 0.5 × (8)^2 × (\\pi / 4)$. Calculate $8^2 = 64$. Multiply: $0.5 × 64 = 32$. Finally, multiply by the angle: $32 × (\\pi / 4)$. Performing the division, $32 / 4 = 8$. The area of the sector is $8\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_16',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'A circle has a circumference of $40\\pi$. A sector of this circle has an area of $100\\pi$. What is the arc length of this sector?',
  '[{"id":"a","text":"$5\\\\pi$"},{"id":"b","text":"$10\\\\pi$"},{"id":"c","text":"$20\\\\pi$"},{"id":"d","text":"$40\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Step 1: Find the radius. $2\\pi r = 40\\pi → r = 20$. Step 2: Find total area. $A = \\pi(20)^2 = 400\\pi$. Step 3: Find the sector''s fraction of the circle. $100\\pi / 400\\pi = 1 / 4$. Step 4: Calculate the arc length as $1/4$ of the circumference. $40\\pi × (1/4) = 10\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_17',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'A circle is defined by $(x-3)^2 + (y+4)^2 = 64$. What is the length of an arc of this circle that subtends a central angle of $45^\\circ$? (Use $\\pi = 3.14$).',
  NULL,
  '6.28',
  '\\textbf{Calculation and Logic:}

First, identify the radius squared from the equation: $r^2 = 64$, so $r = 8$. Second, calculate the circumference: $C = 2 × 3.14 × 8 = 50.24$. Third, find the length of the $45^\\circ$ arc. Since $45 / 360 = 1 / 8$, the arc is one-eighth of the circle. Calculate $50.24 / 8 = 6.28$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_18',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'If an arc of length $8\\pi$ subtends a central angle of $144^\\circ$, what is the radius of the circle?',
  NULL,
  '10',
  '\\textbf{Calculation and Logic:}

Identify the proportion: $(\\text{Arc Length}) / (\\text{Circumference}) = (\\text{Angle}) / 360$. $8\\pi / (2\\pi r) = 144 / 360$. Simplify the left side to $4 / r$. Simplify the right side: divide both by 72 to get $2 / 5$. Set up the equality: $4 / r = 2 / 5$. Cross-multiply: $2r = 20$. Divide by 2: $r = 10$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_19',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'The area of a circle is $81\\pi$. What is the area of a sector with a central angle of $120^\\circ$?',
  '[{"id":"a","text":"$9\\\\pi$"},{"id":"b","text":"$18\\\\pi$"},{"id":"c","text":"$27\\\\pi$"},{"id":"d","text":"$54\\\\pi$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Identify the fraction of the circle: $120 / 360 = 1 / 3$. Multiply the total area by this fraction: $(1/3) × 81\\pi$. Performing the division, $81 / 3 = 27$. The area of the sector is $27\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_20',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'A central angle of $2.5$ radians intercepts an arc of length $15$ cm. What is the area of the resulting sector?',
  '[{"id":"a","text":"18.75"},{"id":"b","text":"37.5"},{"id":"c","text":"45"},{"id":"d","text":"75"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

First, find the radius using $s = r\\theta → 15 = r(2.5) → r = 6$. Next, apply the sector area formula $A = 0.5 × r^2 × \\theta$. $A = 0.5 × 36 × 2.5$. $A = 18 × 2.5$. Calculating $18 × 2 = 36$ and $18 × 0.5 = 9$, the sum is $36 + 9 = 45$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_21',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'How many radians are in a $180^\\circ$ angle? (Give answer in terms of $\\pi$).',
  NULL,
  '$\\pi$',
  '\\textbf{Calculation:}

$180 × (\\pi / 180) = \\pi$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_049_22',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'A sector has radius 5 and arc length 10. What is the area of the sector?',
  NULL,
  '25',
  '\\textbf{Conceptual Explanation:}

An alternative formula for sector area is $A = (1)/(2) × \\text{arc length} × \\text{radius}$.

\\textbf{Calculation and Logic:}

Identify $s = 10$ and $r = 5$. Apply the formula: $A = 0.5 × 10 × 5$. $A = 5 × 5 = 25$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_23',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'In a circle with radius $r$, if the length of an arc is equal to the radius, what is the measure of the central angle in radians?',
  '[{"id":"a","text":"$1/\\\\pi$"},{"id":"b","text":"1"},{"id":"c","text":"$\\\\pi/2$"},{"id":"d","text":"$\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

By definition, a radian is the measure of a central angle that intercepts an arc equal in length to the radius. Mathematically, if $s = r$ and $s = r\\theta$, then $r = r\\theta$, which means $\\theta = 1$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_24',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'The area of a circle is $16\\pi$. A sector of the circle has a central angle of $x$ radians and an area of $2\\pi$. What is the value of $x$?',
  NULL,
  '$\\pi/4$',
  '\\textbf{Calculation and Logic:}

First, find the fraction of the circle occupied by the sector: $2\\pi / 16\\pi = 1 / 8$. Since a full circle is $2\\pi$ radians, the central angle $x$ must be $1/8$ of $2\\pi$. $x = (1/8) × 2\\pi = \\pi / 4$. As a decimal, this is approximately 0.785.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_25',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'Radius of circle is 12. Central angle is $30^\\circ$. Arc length? (In terms of $\\pi$).',
  NULL,
  '$2\\pi$',
  '\\textbf{Calculation:}

$C = 24\\pi$. Fraction $= 30/360 = 1/12$. $L = 24\\pi / 12 = 2\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_26',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'If the central angle of a sector is doubled while the radius is halved, what happens to the area of the sector?',
  '[{"id":"a","text":"It stays the same."},{"id":"b","text":"It is doubled."},{"id":"c","text":"It is halved."},{"id":"d","text":"It is quartered."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Sector Area $A = 0.5 r^2 \\theta$. New area $A'' = 0.5 × (0.5r)^2 × (2\\theta)$. $A'' = 0.5 × 0.25r^2 × 2\\theta$. Combine constants: $0.25 × 2 = 0.5$. So $A'' = 0.5 × (0.5 r^2 \\theta) = 0.5A$. The area is halved.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_27',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'Radius 4, circumference? (In terms of $\\pi$).',
  NULL,
  '$8\\pi$',
  '\\textbf{Calculation:}

$2 × 4 × \\pi = 8\\pi$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_049_28',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'Arc length 5, radius 5. Central angle in radians?',
  NULL,
  '1',
  '\\textbf{Calculation:}

$\\theta = s/r = 5/5 = 1$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_29',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'A sector has radius 10 and area $25\\pi$. What is the arc length?',
  '[{"id":"a","text":"$5\\\\pi$"},{"id":"b","text":"$10\\\\pi$"},{"id":"c","text":"$25\\\\pi$"},{"id":"d","text":"$50\\\\pi$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Total circle area $= 100\\pi$. Sector fraction $= 25\\pi / 100\\pi = 1/4$. Total circumference $= 20\\pi$. Arc length $= (1/4) × 20\\pi = 5\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_30',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'In a circle with a radius of 6 units, what is the length of an arc intercepted by a central angle measuring 150 degrees?',
  '[{"id":"a","text":"$2.5\\\\pi$"},{"id":"b","text":"$5\\\\pi$"},{"id":"c","text":"$10\\\\pi$"},{"id":"d","text":"$15\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The length of an arc is a fractional part of the total circumference of the circle. To find this length, we first calculate the full distance around the circle (circumference) and then multiply it by the fraction of the circle represented by the central angle.

\\textbf{Calculation and Logic:}

Step 1: Calculate the total circumference of the circle using the formula $C = 2\\pi r$. With a radius of 6, the circumference is $2 × \\pi × 6 = 12\\pi$. Step 2: Determine the fraction of the circle occupied by the arc. Since a full rotation is 360 degrees, the fraction is $150 / 360$. Dividing both the numerator and denominator by 30 simplifies this fraction to $5 / 12$. Step 3: Multiply the total circumference by this fraction to find the specific arc length. The calculation $(5 / 12) × 12\\pi$ allows the 12 in the numerator and denominator to cancel out, leaving exactly $5\\pi$. Therefore, the arc length is $5\\pi$ units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_31',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'A sector of a circle has an area of $10\\pi$ square units and an arc length of $2\\pi$ units. What is the radius of this circle?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

There is a direct relationship between the area of a sector, its arc length, and the radius of the circle, defined by the formula $\\text{Area} = (1)/(2) × \\text{arc length} × \\text{radius}$. This formula is analogous to the area of a triangle ($(1)/(2)bh$), where the arc length acts as the base and the radius acts as the height.

\\textbf{Calculation and Logic:}

Identify the given values: $\\text{Sector Area} = 10\\pi$ and $\\text{Arc Length} = 2\\pi$. Substitute these values into the sector area formula: $10\\pi = 0.5 × 2\\pi × r$. Simplify the right side of the equation by multiplying 0.5 and $2\\pi$, which results in $\\pi × r$. This gives the simplified equation $10\\pi = \\pi × r$. To isolate the radius ($r$), divide both sides of the equation by $\\pi$. The calculation $10\\pi / \\pi$ results in 10. Thus, the radius of the circle is 10 units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_32',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'A circle has a radius of 20 units. What is the length of an arc in this circle that is subtended by a central angle of 18 degrees? (Give your answer in terms of $\\pi$).',
  NULL,
  '$2\\pi$',
  '\\textbf{Conceptual Explanation:}

Arc length calculation relies on the proportionality between the angle of the arc and the 360 degrees of a full circle. We scale the total circumference by the ratio of the given angle to the total possible degrees.

\\textbf{Calculation and Logic:}

First, calculate the total circumference of the circle. Using $C = 2\\pi r$ with $r = 20$, we find $C = 2 × \\pi × 20 = 40\\pi$. Second, establish the angular proportion: the arc covers $18$ out of $360$ degrees. This fraction $18 / 360$ can be simplified by dividing both numbers by 18, resulting in $1 / 20$. This means the arc is exactly one-twentieth of the entire circle. Third, apply this fraction to the circumference: $\\text{Arc Length} = (1 / 20) × 40\\pi$. Performing the division, $40 / 20$ equals 2. The resulting arc length is $2\\pi$ units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_33',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'What is the radian measure of a central angle that represents a full rotation of 360 degrees? (Give your answer in terms of $\\pi$).',
  NULL,
  '$2\\pi$',
  '\\textbf{Conceptual Explanation:}

Radians and degrees are two different units for measuring rotation. The conversion factor is based on the fact that the circumference of a unit circle is $2\\pi$, meaning a full $360^\\circ$ rotation is equivalent to $2\\pi$ radians.

\\textbf{Calculation and Logic:}

To convert any degree measure to radians, multiply the number of degrees by the constant ratio $\\pi / 180$. For a full rotation, take $360$ and multiply it by $\\pi / 180$. This sets up the calculation $360\\pi / 180$. By dividing 360 by 180, we find the result is exactly 2. When combined with the constant $\\pi$, the final measure is $2\\pi$. Thus, 360 degrees is equal to $2\\pi$ radians.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_049_34',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'A sector of a circle has a radius $R$, a central angle of $X$ degrees, and an area $A$. If the radius of the circle is tripled and the central angle is halved, what will be the area of the new sector?',
  '[{"id":"a","text":"$1.5A$"},{"id":"b","text":"$3A$"},{"id":"c","text":"$4.5A$"},{"id":"d","text":"$9A$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The area of a sector depends on the square of the radius and the linear value of the central angle. When the dimensions of a circle change, we can find the new area by applying the respective scale factors to the original area formula.

\\textbf{Calculation and Logic:}

The area of a sector is proportional to $r^2 × \\theta$. Identify the scale factors for the new sector: the radius is multiplied by 3 and the angle is multiplied by $0.5$ (halved). Apply these factors to the area relationship: $\\text{New Area} = (3)^2 × 0.5 × A$. Squaring the radius factor results in 9. Multiplying 9 by the angle factor of 0.5 results in 4.5. This calculation shows that the area of the new sector is $4.5$ times the original area $A$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_35',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'The circumference of a circle is $20\\pi$. An arc in this circle has a length of $5\\pi$. What is the measure of the central angle of this arc, in degrees?',
  NULL,
  '90',
  '\\textbf{Conceptual Explanation:}

Because arc length and central angles are directly proportional, the ratio of a specific arc length to the total circumference is identical to the ratio of that arc''s central angle to the total 360 degrees of the circle.

\\textbf{Calculation and Logic:}

First, find the ratio of the given arc length to the total circumference. Divide $5\\pi$ by $20\\pi$, which simplifies to $5 / 20$. This fraction further simplifies to $1 / 4$, meaning the arc represents exactly one-fourth of the circle. Second, since the circle contains a total of 360 degrees, calculate one-fourth of that total to find the central angle. The calculation $360 × (1 / 4)$ or $360 / 4$ results in 90. Therefore, the central angle measures 90 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_36',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'The total area of a circle is $100\\pi$. A sector of this circle has a central angle of 2 radians. What is the area of this sector?',
  NULL,
  '100',
  '\\textbf{Conceptual Explanation:}

When the central angle is provided in radians, the formula for the area of a sector is $A = (1)/(2)r^2\\theta$. We must first use the total area of the circle to determine the radius before we can calculate the specific area of the sector.

\\textbf{Calculation and Logic:}

Step 1: Determine the radius of the circle. Set the total area $100\\pi$ equal to the area formula $\\pi r^2$. Dividing both sides by $\\pi$ gives $100 = r^2$. Taking the square root of 100, we find the radius $r = 10$. Step 2: Use the sector area formula with $r = 10$ and $\\theta = 2$ radians. Substitute the values: $\\text{Area} = 0.5 × (10)^2 × 2$. Square the radius to get 100. Multiply 0.5 by 100 to get 50. Finally, multiply 50 by the angle of 2. The calculation $50 × 2$ results in 100. The area of the sector is 100 square units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_37',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'What is the radian measure of a central angle that measures 45 degrees?',
  '[{"id":"a","text":"$\\\\pi/8$"},{"id":"b","text":"$\\\\pi/4$"},{"id":"c","text":"$\\\\pi/2$"},{"id":"d","text":"$3\\\\pi/4$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Radian measure is a way of expressing angles based on the radius of a circle. To convert degrees to radians, we multiply by the conversion factor $\\pi / 180$, which represents the ratio of radians to degrees in a semicircle.

\\textbf{Calculation and Logic:}

Take the given angle of 45 degrees and multiply it by $\\pi / 180$. This results in the fraction $45\\pi / 180$. To simplify this expression, determine how many times 45 goes into 180. Since $45 × 2 = 90$ and $90 × 2 = 180$, it follows that $45 × 4 = 180$. Therefore, $45 / 180$ simplifies to $1 / 4$. Appending the constant $\\pi$, the resulting radian measure is $\\pi / 4$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_38',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'A circle has a radius of 14 units. What is the length of an arc that subtends a central angle of 270 degrees? (Use 22/7 as an approximation for $\\pi$).',
  NULL,
  '66',
  '\\textbf{Conceptual Explanation:}

This problem requires finding arc length using a specific numerical approximation for $\\pi$. We first find the circumference of the circle and then calculate the portion of that circumference corresponding to a $270^\\circ$ angle.

\\textbf{Calculation and Logic:}

First, calculate the circumference $C = 2\\pi r$. Substituting the approximation $22/7$ and the radius $14$: $C = 2 × (22/7) × 14$. Simplify by dividing 14 by 7, which gives 2. Then multiply: $2 × 22 × 2 = 88$. The total circumference is 88 units. Second, find the fraction of the circle: $270 / 360$. Dividing both by 90 simplifies this to $3 / 4$. Third, multiply the circumference by this fraction: $88 × (3 / 4)$. Dividing 88 by 4 gives 22. Finally, multiply 22 by 3. The calculation $22 × 3$ results in 66. The arc length is 66 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_39',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'In a circle with a radius of 2 units, an arc has a length of $\\pi$. What is the area of the sector formed by this arc and the radii of the circle?',
  NULL,
  '$\\pi$',
  '\\textbf{Conceptual Explanation:}

The area of a sector can be found directly if the arc length and radius are known by using the formula $A = (1)/(2) × \\text{arc length} × \\text{radius}$. This avoids the need to find the central angle separately.

\\textbf{Calculation and Logic:}

Identify the known values: the radius $r = 2$ and the arc length $s = \\pi$. Apply these to the formula: $\\text{Area} = 0.5 × \\pi × 2$. Multiply the numerical constants first: $0.5 × 2$ equals 1. This leaves the result as $1 × \\pi$, or simply $\\pi$. The area of the sector is $\\pi$ square units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_40',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'A circle has a radius of 9. What is the length of an arc intercepted by a central angle of 40 degrees?',
  '[{"id":"a","text":"$2\\\\pi$"},{"id":"b","text":"$4\\\\pi$"},{"id":"c","text":"$8\\\\pi$"},{"id":"d","text":"$9\\\\pi$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Step 1: Calculate the full circumference using $C = 2\\pi r$. With $r = 9$, the circumference is $2 × \\pi × 9 = 18\\pi$. Step 2: Determine the angular fraction of the circle. The arc covers $40$ out of $360$ degrees. Simplifying $40 / 360$ by dividing both by 40 results in $1 / 9$. Step 3: Multiply the total circumference by this fraction. The calculation $18\\pi × (1 / 9)$ is equivalent to $18\\pi / 9$, which results in $2\\pi$. The arc length is $2\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_41',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'The total area of a circle is $49\\pi$. What is the area of a sector of this circle that has a central angle of $\\pi$ radians?',
  NULL,
  '$24.5\\pi$',
  '\\textbf{Conceptual Explanation:}

Since a full circle is $2\\pi$ radians, a central angle of $\\pi$ radians represents exactly half of the circle. The area of the sector will therefore be exactly half of the total area of the circle.

\\textbf{Calculation and Logic:}

Start with the total circle area, which is $49\\pi$. Identify the fraction of the circle represented by the angle: $\\pi / 2\\pi = 1 / 2$. Calculate the area of the sector by multiplying the total area by this fraction: $49\\pi × (1 / 2)$. Performing the division $49 / 2$ results in 24.5. Therefore, the area of the sector is $24.5\\pi$ square units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_42',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'In a circle with a radius of 15 units, an arc has a length of $5\\pi$. What is the degree measure of the central angle subtended by this arc?',
  NULL,
  '60',
  '\\textbf{Conceptual Explanation:}

To find the central angle, we calculate what fraction of the total circumference the specific arc length represents, and then apply that same fraction to the 360 degrees of the full circle.

\\textbf{Calculation and Logic:}

First, find the total circumference: $C = 2\\pi(15) = 30\\pi$. Second, find the ratio of the arc length to the circumference: $5\\pi / 30\\pi$. Dividing both by $5\\pi$ simplifies this to $1 / 6$. This indicates the arc is one-sixth of the circle. Third, calculate the angle by taking one-sixth of 360 degrees. The calculation $360 / 6$ results in 60. The central angle measures 60 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_43',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'An angle measures 120 degrees. If this angle is written in radians as $x\\pi$, what is the value of $x$?',
  NULL,
  '2/3',
  '\\textbf{Conceptual Explanation:}

Converting degrees to radians involves scaling the degree measure by the ratio of $\\pi$ radians to 180 degrees. This provides the fraction of "pi" that the angle represents.

\\textbf{Calculation and Logic:}

Take the measure of 120 degrees and multiply it by the conversion factor $\\pi / 180$. This gives the fraction $120\\pi / 180$. To simplify, divide both 120 and 180 by their greatest common divisor, which is 60. The calculation $120 / 60$ results in 2, and $180 / 60$ results in 3. This simplifies the expression to $(2/3)\\pi$. In the form $x\\pi$, the value of $x$ is $2/3$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_049_44',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'A sector of a circle has an area of $15\\pi$ and a radius of 10. What is the length of the arc of this sector?',
  '[{"id":"a","text":"$0.3\\\\pi$"},{"id":"b","text":"$3\\\\pi$"},{"id":"c","text":"$6\\\\pi$"},{"id":"d","text":"$30\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We can use the direct relationship between area, arc length, and radius: $\\text{Area} = 0.5 × \\text{arc length} × \\text{radius}$. By substituting the known area and radius, we can isolate the unknown arc length.

\\textbf{Calculation and Logic:}

Identify the knowns: $\\text{Area} = 15\\pi$ and $\\text{Radius} = 10$. Plug these into the formula: $15\\pi = 0.5 × L × 10$. Simplify the right side by multiplying 0.5 and 10, which results in 5. The equation is now $15\\pi = 5L$. To solve for the arc length ($L$), divide both sides by 5. The calculation $15\\pi / 5$ results in $3\\pi$. Therefore, the length of the arc is $3\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_45',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'What is the radian measure of a central angle that intercepts an arc of length 6 in a circle with a radius of 3?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

The definition of radian measure is the ratio of the arc length to the radius of the circle. It represents how many "radii" fit into the length of the arc. The formula is $\\theta = s / r$.

\\textbf{Calculation and Logic:}

Identify the arc length $s = 6$ and the radius $r = 3$. Apply the formula for radian measure: $\\theta = 6 / 3$. Performing the division results in 2. This means the central angle measures 2 radians.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_46',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'A circle has a total area of $64\\pi$. What is the area of a sector of this circle if the arc length of the sector is $4\\pi$?',
  NULL,
  '$16\\pi$',
  '\\textbf{Conceptual Explanation:}

To find the sector area, we first need to determine the radius of the circle from its total area. Once the radius is found, we use the arc length and radius in the simplified sector area formula.

\\textbf{Calculation and Logic:}

Step 1: Find the radius. Set total area $64\\pi$ equal to $\\pi r^2$. Dividing by $\\pi$ gives $64 = r^2$, so the radius $r = 8$. Step 2: Calculate the sector area using the formula $\\text{Area} = 0.5 × \\text{arc length} × \\text{radius}$. Substitute the values: $\\text{Area} = 0.5 × 4\\pi × 8$. Multiply 0.5 by 8 to get 4. Finally, multiply 4 by $4\\pi$. The calculation $4 × 4\\pi$ results in $16\\pi$. The area of the sector is $16\\pi$ square units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_47',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'mcq',
  'math',
  'If a central angle of a circle measures $\\pi$ radians, what fraction of the circle does it represent?',
  '[{"id":"a","text":"1/4"},{"id":"b","text":"1/2"},{"id":"c","text":"1/3"},{"id":"d","text":"2/3"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A full rotation around a circle is defined as $2\\pi$ radians. To find the fraction of the circle represented by any angle, we divide that angle by the total $2\\pi$ radians of a full circle.

\\textbf{Calculation and Logic:}

Take the given central angle of $\\pi$ radians and set it over the total circle measure: $\\pi / 2\\pi$. The constant $\\pi$ appears in both the numerator and the denominator, so it cancels out. This leaves the fraction $1 / 2$. Therefore, a central angle of $\\pi$ radians represents exactly one-half of the circle.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_049_48',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'A circle has a radius of 10 units. What is the area of a sector of this circle that is subtended by a central angle of 100 degrees? (Give your answer in terms of $\\pi$).',
  NULL,
  '$250\\pi/9$',
  '\\textbf{Conceptual Explanation:}

The area of a sector is found by calculating the total area of the circle and then multiplying it by the fraction of the circle occupied by the central angle ($ \\text{angle} / 360 $).

\\textbf{Calculation and Logic:}

First, calculate the total area of the circle using $A = \\pi r^2$. With $r = 10$, the total area is $\\pi × 10^2 = 100\\pi$. Second, determine the fraction of the circle: $100 / 360$. Dividing both by 20 simplifies this fraction to $5 / 18$. Third, multiply the total area by this fraction: $100\\pi × (5 / 18)$. This results in $500\\pi / 18$. To simplify further, divide both numbers by 2, which gives $250\\pi / 9$. As a decimal, this is approximately $27.78\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_049_49',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
),
  (
  'spr',
  'math',
  'The total circumference of a circle is $18\\pi$. An arc in this circle has a length of $3\\pi$. What is the degree measure of the central angle that intercepts this arc?',
  NULL,
  '60',
  '\\textbf{Conceptual Explanation:}

The portion of the circumference represented by an arc length is exactly equal to the portion of the 360-degree rotation represented by the central angle.

\\textbf{Calculation and Logic:}

First, find the ratio of the arc length to the circumference. Divide $3\\pi$ by $18\\pi$, which simplifies to $3 / 18$. Further dividing both by 3 results in a fraction of $1 / 6$. This means the arc is one-sixth of the entire circle. Second, calculate one-sixth of the total degrees in a circle to find the angle. The calculation $360 × (1 / 6)$ or $360 / 6$ results in 60. Therefore, the central angle measures 60 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_049_50',
  'Circle properties: arcs, chords, angles',
  'Arc Length & Sector Area'
)
ON CONFLICT (bank_item_id) DO NOTHING;

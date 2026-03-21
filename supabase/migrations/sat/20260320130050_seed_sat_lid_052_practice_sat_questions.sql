-- Practice-mode math from lid_052.tex (sat_lid_052)
-- Chapter: Right-triangle trig: sin, cos, tan | Topic: Trigonometric Word Problems
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_052_N, practice module/set 0.

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
  'A 12-foot ladder leans against a building. If the ladder makes an angle of $65^\\circ$ with the ground, what is the distance from the base of the ladder to the building, to the nearest tenth of a foot? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) -- (4,0) -- (4,5); \\draw[ultra thick, brown] (0,0) -- (4,5) node[midway, above left, black]{12 ft}; \\draw (0.8,0) arc (0:51.3:0.8) node[midway, right=2pt]{$65^\\circ$}; \\draw (3.7,0) -- (3.7,0.3) -- (4,0.3); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"5.1"},{"id":"b","text":"5.6"},{"id":"c","text":"10.9"},{"id":"d","text":"25.7"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The ladder forms the hypotenuse of a right triangle. The distance from the base to the building is the side adjacent to the given angle. We use the cosine ratio (CAH) to solve.

\\textbf{Calculation and Logic:}

Let $x$ be the distance from the base to the building.

$\\cos(65^\\circ) = \\frac{\\text{adjacent}}{\\text{hypotenuse}} = (x)/(12)$.

$x = 12 × \\cos(65^\\circ)$.

Using a calculator: $x = 12 × 0.4226 \\approx 5.071$.

Rounding to the nearest tenth, we get 5.1.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_1',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A person standing on top of a 100-foot cliff looks down at a boat in the water. The angle of depression from the person to the boat is $22^\\circ$. What is the horizontal distance from the base of the cliff to the boat, to the nearest foot? \\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[thick] (0,5) -- (8,5); % Sight line \\draw[dashed] (0,5) -- (8,0); % Line of sight to boat \\draw (1.5,5) arc (0:-32:1.5) node[midway, right]{$22^\\circ$}; \\draw[ultra thick] (0,5) -- (0,0) node[midway, left]{100 ft} -- (8,0); \\node at (8, -0.4) {Boat}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"40"},{"id":"b","text":"93"},{"id":"c","text":"248"},{"id":"d","text":"267"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The angle of depression is equal to the angle of elevation from the boat to the top of the cliff. The height of the cliff is the opposite side, and the horizontal distance is the adjacent side.

\\textbf{Calculation and Logic:}

$\\tan(22^\\circ) = \\frac{\\text{opposite}}{\\text{adjacent}} = (100)/(x)$.

$x = (100)/(\\tan(22^\\circ))$.

Using a calculator: $x = (100)/(0.404) \\approx 247.5$.

Rounding to the nearest foot, we get 248.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_2',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'A ramp is to be built to reach a door that is 3 feet above the ground. If the maximum allowable angle of elevation for the ramp is $5^\\circ$, what is the minimum required length of the ramp, in feet, rounded to the nearest tenth?',
  NULL,
  '34.4',
  '\\textbf{Conceptual Explanation:}

The ramp itself represents the hypotenuse of the right triangle. The height of the door is the opposite side relative to the angle of elevation. We use the sine ratio (SOH) for this calculation.

\\textbf{Calculation and Logic:}

$\\sin(5^\\circ) = \\frac{\\text{opposite}}{\\text{hypotenuse}} = (3)/(L)$.

$L = (3)/(\\sin(5^\\circ))$.

Using a calculator: $L = (3)/(0.0872) \\approx 34.403$.

Rounding to the nearest tenth, we get 34.4.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_3',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A flagpole casts a shadow that is 15 meters long. If the angle of elevation from the tip of the shadow to the top of the flagpole is $32^\\circ$, what is the height of the flagpole to the nearest meter? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) -- (5,0) node[midway, below]{15 m} -- (5,3) node[midway, right]{$h$}; \\draw[dashed] (0,0) -- (5,3); \\draw (0.8,0) arc (0:31:0.8) node[midway, right=2pt]{$32^\\circ$}; \\draw (4.7,0) -- (4.7,0.3) -- (5,0.3); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"8"},{"id":"b","text":"9"},{"id":"c","text":"13"},{"id":"d","text":"24"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The flagpole and its shadow form the legs of a right triangle. Since we have the side adjacent to the angle (the shadow) and need the side opposite (the height), we use the tangent ratio.

\\textbf{Calculation and Logic:}

$\\tan(32^\\circ) = (h)/(15)$.

$h = 15 × \\tan(32^\\circ)$.

Using a calculator, $\\tan(32^\\circ) \\approx 0.6249$.

$h = 15 × 0.6249 = 9.3735$.

Rounding to the nearest meter, we get 9.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_4',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'A kite is flying at the end of a 100-foot string. The string is held 3 feet off the ground and makes an angle of $50^\\circ$ with the horizontal. To the nearest foot, how high is the kite above the ground?',
  NULL,
  '80',
  '\\textbf{Conceptual Explanation:}

We first calculate the vertical height of the kite relative to the point where the string is held (the right triangle height). Then, we must add the height of the person''s hand (3 feet) to find the total height above the ground.

\\textbf{Calculation and Logic:}

Let $y$ be the vertical distance from the hand to the kite.

$\\sin(50^\\circ) = (y)/(100)$.

$y = 100 × \\sin(50^\\circ) \\approx 100 × 0.766 = 76.6$ feet.

Total height above ground $= y + 3 = 76.6 + 3 = 79.6$.

Rounding to the nearest foot, we get 80.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_5',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'An airplane is flying at an altitude of 30,000 feet. The pilot spots an airport at an angle of depression of $15^\\circ$. What is the direct line-of-sight distance (slant range) from the plane to the airport, rounded to the nearest thousand feet?',
  '[{"id":"a","text":"31,000"},{"id":"b","text":"112,000"},{"id":"c","text":"116,000"},{"id":"d","text":"224,000"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The altitude is the side opposite the angle of elevation from the airport to the plane. The line-of-sight distance is the hypotenuse of this right triangle.

\\textbf{Calculation and Logic:}

Using the angle of elevation (which equals the angle of depression):

$\\sin(15^\\circ) = (30,000)/(\\text{hypotenuse)}$.

Hypotenuse $= (30,000)/(\\sin(15^\\circ))$.

$\\sin(15^\\circ) \\approx 0.2588$.

Hypotenuse $= (30,000)/(0.2588) \\approx 115,920$.

Rounding to the nearest thousand, we get 116,000.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_6',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'In $\\triangle ABC$ below, a surveyor needs to find the width of a river, represented by $BC$. If $AC = 80$ meters and $\\angle A = 38^\\circ$, what is the width of the river to the nearest meter? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) node[anchor=east]{$A$} -- (5,0) node[anchor=west]{$C$} -- (5,4) node[anchor=south]{$B$} -- cycle; \\draw (4.7,0) -- (4.7,0.3) -- (5,0.3); \\node at (2.5, -0.4) {80 m}; \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"50"},{"id":"b","text":"62"},{"id":"c","text":"63"},{"id":"d","text":"102"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The side $AC$ is adjacent to angle $A$. The width of the river, $BC$, is opposite to angle $A$. We use the tangent ratio.

\\textbf{Calculation and Logic:}

$\\tan(38^\\circ) = (BC)/(80)$.

$BC = 80 × \\tan(38^\\circ)$.

$\\tan(38^\\circ) \\approx 0.7813$.

$BC = 80 × 0.7813 = 62.504$.

Rounding to the nearest meter, we get 63.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_7',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A hot air balloon is tethered to the ground by two ropes on opposite sides of the balloon. Rope 1 is 100 feet long and makes a $45^\\circ$ angle with the ground. Rope 2 makes a $30^\\circ$ angle with the ground. What is the length of Rope 2?',
  '[{"id":"a","text":"$50\\\\sqrt{2}$"},{"id":"b","text":"$100\\\\sqrt{2}$"},{"id":"c","text":"141"},{"id":"d","text":"200"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Both ropes share the same vertical height (the altitude of the balloon). We find the height using the first rope and then use that height to find the length of the second rope.

\\textbf{Calculation and Logic:}

Height $h = 100 × \\sin(45^\\circ) = 100 × \\frac{\\sqrt{2}}{2} = 50\\sqrt{2}$.

For Rope 2, $\\sin(30^\\circ) = (h)/(\\text{Rope 2)}$.

Rope 2 $= \\frac{50\\sqrt{2}}{\\sin(30^\\circ)} = \\frac{50\\sqrt{2}}{0.5} = 100\\sqrt{2}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_8',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A support wire is attached to the top of a 20-foot pole and anchored to the ground. If the wire is 25 feet long, what is the measure of the angle, to the nearest degree, that the wire makes with the ground? \\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,0) -- (4.5,0) -- (4.5,3) node[midway, right]{20 ft}; \\draw[ultra thick, blue] (0,0) -- (4.5,3) node[midway, above left, black]{25 ft}; \\node at (0.8, 0.3) {$\\theta$}; \\draw (4.2,0) -- (4.2,0.3) -- (4.5,0.3); \\end{tikzpicture} \\end{center}',
  '[{"id":"a","text":"$37^\\\\circ$"},{"id":"b","text":"$39^\\\\circ$"},{"id":"c","text":"$51^\\\\circ$"},{"id":"d","text":"$53^\\\\circ$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

In this right triangle, the height of the pole is the side opposite the angle $\\theta$, and the wire is the hypotenuse. We use the inverse sine function to find the angle.

\\textbf{Calculation and Logic:}

$\\sin \\theta = \\frac{\\text{opposite}}{\\text{hypotenuse}} = (20)/(25) = 0.8$.

$\\theta = \\arcsin(0.8)$.

Using a calculator, $\\theta \\approx 53.13^\\circ$.

Rounding to the nearest degree, we get $53^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_9',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'From a point on the ground 100 feet from the base of a building, the angle of elevation to the bottom of a smokestack on the roof is $35^\\circ$, and the angle of elevation to the top of the smokestack is $45^\\circ$. What is the height of the smokestack to the nearest foot?',
  NULL,
  '30',
  '\\textbf{Conceptual Explanation:}

The smokestack''s height is the difference between the height of the building (from the ground to the bottom of the stack) and the total height (from the ground to the top of the stack). We solve for both using the tangent ratio.

\\textbf{Calculation and Logic:}

Height to bottom: $h_1 = 100 × \\tan(35^\\circ) \\approx 100 × 0.700 = 70.0$ ft.

Height to top: $h_2 = 100 × \\tan(45^\\circ) = 100 × 1 = 100$ ft.

Smokestack height $= h_2 - h_1 = 100 - 70.0 = 30$ ft.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_10',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A ship travels 50 miles east and then 120 miles north. What is the sine of the angle $\\theta$ formed between the starting point and the final destination, relative to the eastward path?',
  '[{"id":"a","text":"$\\\\frac{5}{13}$"},{"id":"b","text":"$\\\\frac{12}{13}$"},{"id":"c","text":"$\\\\frac{5}{12}$"},{"id":"d","text":"$\\\\frac{12}{5}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The path forms a right triangle with legs of 50 and 120. We first find the hypotenuse (the direct distance) and then calculate the sine of the angle at the starting point.

\\textbf{Calculation and Logic:}

Hypotenuse $= \\sqrt{50^2 + 120^2} = \\sqrt{2500 + 14400} = \\sqrt{16900} = 130$.

The side opposite $\\theta$ is the northward distance (120).

$\\sin \\theta = \\frac{\\text{opposite}}{\\text{hypotenuse}} = (120)/(130) = (12)/(13)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_11',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'An observer at point $P$ looks at the top of a tower. If the tower is 50 meters tall and the observer is 50 meters from the base, what is the angle of elevation?',
  '[{"id":"a","text":"$30^\\\\circ$"},{"id":"b","text":"$45^\\\\circ$"},{"id":"c","text":"$60^\\\\circ$"},{"id":"d","text":"$90^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When the distance from the base (adjacent side) is equal to the height (opposite side), the tangent of the angle is 1. This identifies the triangle as an isosceles right triangle.

\\textbf{Calculation and Logic:}

$\\tan \\theta = (50)/(50) = 1$.

The angle whose tangent is 1 is $45^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_12',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A road rises 10 feet for every 100 feet of horizontal distance. Which expression represents the angle of inclination $\\alpha$ of the road?',
  '[{"id":"a","text":"$\\\\sin^{-1}(0.1)$"},{"id":"b","text":"$\\\\cos^{-1}(0.1)$"},{"id":"c","text":"$\\\\tan^{-1}(0.1)$"},{"id":"d","text":"$\\\\tan(0.1)$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The "rise over run" of the road represents the tangent of the angle of inclination. To find the angle itself, we use the inverse tangent function.

\\textbf{Calculation and Logic:}

$\\tan \\alpha = \\frac{\\text{rise}}{\\text{run}} = (10)/(100) = 0.1$.

Therefore, $\\alpha = \\tan^{-1}(0.1)$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_13',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A tree casts a 24-foot shadow when the angle of elevation of the sun is $53^\\circ$. If $\\sin 53^\\circ \\approx 0.8$ and $\\cos 53^\\circ \\approx 0.6$, what is the height of the tree?',
  '[{"id":"a","text":"18 ft"},{"id":"b","text":"24 ft"},{"id":"c","text":"32 ft"},{"id":"d","text":"40 ft"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

We have the shadow (adjacent side) and need the height (opposite side). We use the tangent ratio, which is $(\\sin \\theta)/(\\cos \\theta)$.

\\textbf{Calculation and Logic:}

$\\tan(53^\\circ) = (\\sin 53^\\circ)/(\\cos 53^\\circ) = (0.8)/(0.6) = (4)/(3)$.

Height $h = 24 × \\tan(53^\\circ) = 24 × (4)/(3) = 8 × 4 = 32$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_14',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'A drone flies from a height of 20 meters to a height of 100 meters while traveling a horizontal distance of 60 meters. What is the direct distance, in meters, traveled by the drone?',
  NULL,
  '100',
  '\\textbf{Conceptual Explanation:}

The drone''s path is the hypotenuse of a right triangle. The horizontal leg is 60 meters. The vertical leg is the change in height.

\\textbf{Calculation and Logic:}

Vertical leg $= 100 - 20 = 80$ meters.

Direct distance $= \\sqrt{60^2 + 80^2} = \\sqrt{3600 + 6400} = \\sqrt{10000} = 100$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_15',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A 15-foot wire is attached to a pole at a height of 12 feet. What is the cosine of the angle $\\theta$ formed between the wire and the pole?',
  '[{"id":"a","text":"0.6"},{"id":"b","text":"0.75"},{"id":"c","text":"0.8"},{"id":"d","text":"1.25"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The wire is the hypotenuse and the height on the pole is the side adjacent to the angle $\\theta$ located at the top of the pole. We use the cosine ratio directly.

\\textbf{Calculation and Logic:}

$\\cos \\theta = \\frac{\\text{adj}}{\\text{hyp}} = (12)/(15)$.

Simplifying the fraction gives $4/5$, which is 0.8.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_16',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A surveyor stands 40 meters from the base of a tree. The angle of elevation to the top of the tree is $30^\\circ$. How much taller would the tree need to be for the angle of elevation to be $45^\\circ$ from the same spot?',
  '[{"id":"a","text":"$40 - 20\\\\sqrt{3}$"},{"id":"b","text":"$40\\\\sqrt{3} - 40$"},{"id":"c","text":"$40 - \\\\frac{40\\\\sqrt{3}}{3}$"},{"id":"d","text":"20"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

We calculate the initial height and the target height using the tangent of the respective angles and then find the difference.

\\textbf{Calculation and Logic:}

Initial height: $h_1 = 40 \\tan(30^\\circ) = 40(\\frac{\\sqrt{3}}{3}) = \\frac{40\\sqrt{3}}{3}$.

Target height: $h_2 = 40 \\tan(45^\\circ) = 40(1) = 40$.

Difference: $40 - \\frac{40\\sqrt{3}}{3}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_17',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A ship sails 10 miles at a bearing of $90^\\circ$ (due East) and then 10 miles at a bearing of $180^\\circ$ (due South). What is the sine of the angle formed at the starting point between the initial path and the direct line back to the start?',
  '[{"id":"a","text":"$\\\\frac{1}{2}$"},{"id":"b","text":"$\\\\frac{\\\\sqrt{2}}{2}$"},{"id":"c","text":"$\\\\frac{\\\\sqrt{3}}{2}$"},{"id":"d","text":"$1$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The path forms an isosceles right triangle because the eastward and southward distances are equal. The hypotenuse is the direct line.

\\textbf{Calculation and Logic:}

The legs are 10 and 10. The hypotenuse is $10\\sqrt{2}$.

The angle at the start between the path and hypotenuse is $45^\\circ$.

$\\sin(45^\\circ) = (10)/(10\\sqrt{2)} = (1)/(\\sqrt{2)} = \\frac{\\sqrt{2}}{2}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_18',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'An observer in a lighthouse 80 feet above sea level spots two boats directly in line. The angles of depression to the boats are $30^\\circ$ and $60^\\circ$. What is the distance between the two boats, rounded to the nearest foot? \\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[thick] (0,4) -- (0,0) node[midway, left]{80 ft}; \\draw[dashed] (0,4) -- (10,0); \\draw[dashed] (0,4) -- (4,0); \\draw (0,0) -- (11,0); \\node at (4, -0.3) {B1}; \\node at (10, -0.3) {B2}; \\end{tikzpicture} \\end{center}',
  NULL,
  '92',
  '\\textbf{Conceptual Explanation:}

We find the horizontal distance from the lighthouse to each boat using the tangent of the angles of elevation (which match the depression angles) and subtract the smaller from the larger.

\\textbf{Calculation and Logic:}

Distance to Boat 1 ($60^\\circ$): $x_1 = (80)/(\\tan(60^\\circ)) = (80)/(\\sqrt{3)} \\approx 46.2$.

Distance to Boat 2 ($30^\\circ$): $x_2 = (80)/(\\tan(30^\\circ)) = (80)/(1/\\sqrt{3)} = 80\\sqrt{3} \\approx 138.6$.

Distance between: $138.6 - 46.2 = 92.4$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_19',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A right triangle has an angle $\\alpha$. If $\\tan \\alpha = 1.5$ and the side adjacent to $\\alpha$ is 10, what is the length of the hypotenuse?',
  '[{"id":"a","text":"5"},{"id":"b","text":"15"},{"id":"c","text":"$5\\\\sqrt{13}$"},{"id":"d","text":"25"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Use the tangent to find the opposite side, then apply the Pythagorean theorem to find the hypotenuse.

\\textbf{Calculation and Logic:}

$\\text{Opposite} = 10 × 1.5 = 15$.

$\\text{Hypotenuse} = \\sqrt{10^2 + 15^2} = \\sqrt{100 + 225} = \\sqrt{325}$.

$\\sqrt{325} = \\sqrt{25 × 13} = 5\\sqrt{13}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_20',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A ramp has a length of 20 feet and rises to a height of 4 feet. What is the sine of the angle the ramp makes with the ground?',
  '[{"id":"a","text":"0.2"},{"id":"b","text":"0.25"},{"id":"c","text":"4.0"},{"id":"d","text":"5.0"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The ramp is the hypotenuse and the height is the opposite side.

\\textbf{Calculation and Logic:}

$\\sin \\theta = \\frac{\\text{opp}}{\\text{hyp}} = (4)/(20) = (1)/(5) = 0.2$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_21',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'The shadow of a building is 60 feet long when the angle of elevation of the sun is $35^\\circ$. If the building is $h$ feet tall, which equation can be used to find $h$?',
  '[{"id":"a","text":"$h = 60 \\\\sin 35^\\\\circ$"},{"id":"b","text":"$h = 60 \\\\cos 35^\\\\circ$"},{"id":"c","text":"$h = 60 \\\\tan 35^\\\\circ$"},{"id":"d","text":"$h = \\\\frac{60}{\\\\tan 35^\\\\circ}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Height is opposite and shadow is adjacent. Tangent relates these two.

\\textbf{Calculation and Logic:}

$\\tan(35^\\circ) = (h)/(60) → h = 60 \\tan 35^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_22',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'A ladder leans against a wall making a $70^\\circ$ angle with the ground. If the base of the ladder is 5 feet from the wall, what is the length of the ladder to the nearest foot?',
  NULL,
  '15',
  '\\textbf{Conceptual Explanation:}

The distance from the wall is adjacent; the ladder is the hypotenuse.

\\textbf{Calculation and Logic:}

$\\cos(70^\\circ) = (5)/(L) → L = (5)/(\\cos(70^\\circ))$.

$L = (5)/(0.342) \\approx 14.6$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_23',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A person is flying a kite with 50 meters of string out. The angle of elevation is $60^\\circ$. If the wind drops and the angle of elevation becomes $30^\\circ$ with the same amount of string out, what is the change in the kite''s height?',
  '[{"id":"a","text":"25"},{"id":"b","text":"$25(\\\\sqrt{3}-1)$"},{"id":"c","text":"$50(\\\\sqrt{3}-1)$"},{"id":"d","text":"$25\\\\sqrt{3}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Calculate height at $60^\\circ$ and $30^\\circ$ using sine, then find the difference.

\\textbf{Calculation and Logic:}

$h_1 = 50 \\sin(60^\\circ) = 50(\\frac{\\sqrt{3}}{2}) = 25\\sqrt{3}$.

$h_2 = 50 \\sin(30^\\circ) = 50(0.5) = 25$.

Change $= 25\\sqrt{3} - 25 = 25(\\sqrt{3}-1)$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_24',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'If the angle of elevation to the sun is $90^\\circ$, what is the length of the shadow of a 10-foot pole?',
  '[{"id":"a","text":"0"},{"id":"b","text":"10"},{"id":"c","text":"Undefined"},{"id":"d","text":"Infinite"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When the sun is directly overhead, rays are parallel to the pole.

\\textbf{Calculation and Logic:}

$\\tan(90^\\circ)$ is undefined, but physically, the light hits the top and base at the same horizontal point.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_052_25',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A wire 30 feet long is stretched from the top of a pole to the ground. If the wire makes an angle of $40^\\circ$ with the pole, how tall is the pole to the nearest foot?',
  '[{"id":"a","text":"19"},{"id":"b","text":"23"},{"id":"c","text":"25"},{"id":"d","text":"39"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The angle is at the top. The pole is the adjacent side to this angle.

\\textbf{Calculation and Logic:}

$\\cos(40^\\circ) = (h)/(30) → h = 30 \\cos(40^\\circ)$.

$h = 30(0.766) \\approx 22.98$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_26',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A slide at a park is 10 feet long and its base is 8 feet from the ladder. What is the measure of the angle the slide makes with the ladder?',
  '[{"id":"a","text":"$37^\\\\circ$"},{"id":"b","text":"$45^\\\\circ$"},{"id":"c","text":"$53^\\\\circ$"},{"id":"d","text":"$60^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The ladder and ground are perpendicular. The angle with the ladder is at the top. The ground distance (8) is opposite this angle.

\\textbf{Calculation and Logic:}

$\\sin \\theta = (8)/(10) = 0.8$.

$\\theta = \\arcsin(0.8) \\approx 53^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_27',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'A plane takes off at an angle of $10^\\circ$. How many feet of ground distance has it covered when it reaches an altitude of 2,000 feet? (Round to nearest 10 feet)',
  NULL,
  '11340',
  '\\textbf{Conceptual Explanation:}

Altitude is opposite, ground distance is adjacent.

\\textbf{Calculation and Logic:}

$\\tan(10^\\circ) = (2000)/(x) → x = (2000)/(\\tan(10^\\circ))$.

$x = (2000)/(0.1763) \\approx 11344.3$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_28',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A boy is looking at a bird in a tree. His eyes are 5 feet above the ground. The bird is 25 feet above the ground. If the angle of elevation is $40^\\circ$, how far is the boy from the tree?',
  '[{"id":"a","text":"$20 \\\\tan 40^\\\\circ$"},{"id":"b","text":"$20 / \\\\tan 40^\\\\circ$"},{"id":"c","text":"$25 / \\\\tan 40^\\\\circ$"},{"id":"d","text":"$30 / \\\\tan 40^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Use the relative height (Bird height - Eye height).

\\textbf{Calculation and Logic:}

$\\text{Relative height} = 25 - 5 = 20$.

$\\tan(40^\\circ) = (20)/(x) → x = 20 / \\tan 40^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_29',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'Two poles are 20 feet apart. One is 10 feet tall and the other is 25 feet tall. What is the length of a wire connecting the tops?',
  '[{"id":"a","text":"15"},{"id":"b","text":"20"},{"id":"c","text":"25"},{"id":"d","text":"35"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The wire is the hypotenuse of a triangle with horizontal leg 20 and vertical leg as the difference in heights.

\\textbf{Calculation and Logic:}

$\\text{Vertical} = 25 - 10 = 15$.

$\\text{Length} = \\sqrt{20^2 + 15^2} = \\sqrt{400 + 225} = 25$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_30',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A 20-foot ramp makes an angle of $15^\\circ$ with the ground. How high is the ramp?',
  '[{"id":"a","text":"$20 \\\\sin 15^\\\\circ$"},{"id":"b","text":"$20 \\\\cos 15^\\\\circ$"},{"id":"c","text":"$20 \\\\tan 15^\\\\circ$"},{"id":"d","text":"$20 / \\\\sin 15^\\\\circ$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Height is opposite, ramp is hypotenuse.

\\textbf{Calculation and Logic:}

$\\sin(15^\\circ) = (h)/(20) → h = 20 \\sin 15^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_31',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A surveyor measures the angle of elevation to a mountain top as $20^\\circ$. After walking 1000 meters closer, the angle is $25^\\circ$. Which equation solves for height $h$?',
  '[{"id":"a","text":"$h = \\\\frac{1000}{\\\\cot 20^\\\\circ - \\\\cot 25^\\\\circ}$"},{"id":"b","text":"$h = 1000(\\\\tan 25^\\\\circ - \\\\tan 20^\\\\circ)$"},{"id":"c","text":"$h = \\\\frac{1000 \\\\sin 20^\\\\circ \\\\sin 25^\\\\circ}{\\\\sin 5^\\\\circ}$"},{"id":"d","text":"Both A and C"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

This is a standard "two-point" elevation problem. Both the cotangent difference and the sine rule derivation are valid.

\\textbf{Calculation and Logic:}

$x = h \\cot 25^\\circ$ and $x + 1000 = h \\cot 20^\\circ$.

$1000 = h(\\cot 20^\\circ - \\cot 25^\\circ)$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_32',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'A staircase has steps with a 7-inch rise and 11-inch run. What is the angle of the staircase with the floor to the nearest degree?',
  NULL,
  '32',
  '\\textbf{Conceptual Explanation:}

The angle is determined by the tangent of rise over run.

\\textbf{Calculation and Logic:}

$\\tan \\theta = 7/11 \\approx 0.636$.

$\\theta = \\arctan(0.636) \\approx 32.47^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_33',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A boat is 100 meters from a lighthouse. The angle of elevation to the light is $25^\\circ$. If the light is 10 meters above the cliff edge, how high is the cliff?',
  '[{"id":"a","text":"$100 \\\\tan 25^\\\\circ$"},{"id":"b","text":"$100 \\\\tan 25^\\\\circ - 10$"},{"id":"c","text":"$100 \\\\tan 25^\\\\circ + 10$"},{"id":"d","text":"$100 / \\\\tan 25^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The total height is $100 \\tan 25^\\circ$. Subtract the light''s height to get the cliff.

\\textbf{Calculation and Logic:}

$\\text{Total height} = 100 \\tan 25^\\circ$.

$\\text{Cliff} = \\text{Total} - 10$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_34',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'If a shadow is shorter than the object casting it, what can be said about the angle of elevation $\\theta$ of the sun?',
  '[{"id":"a","text":"$\\\\theta < 45^\\\\circ$"},{"id":"b","text":"$\\\\theta = 45^\\\\circ$"},{"id":"c","text":"$\\\\theta > 45^\\\\circ$"},{"id":"d","text":"$\\\\theta = 90^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

$\\tan \\theta = \\text{Height} / \\text{Shadow}$. If Shadow < Height, then $\\tan \\theta > 1$.

\\textbf{Calculation and Logic:}

$\\tan(45^\\circ) = 1$. Since the ratio is $> 1$, $\\theta > 45^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_35',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A plane is at altitude $H$ and sees two landmarks. The angles of depression are $\\alpha$ and $\\beta$. What is the distance between them if they are on the same side?',
  '[{"id":"a","text":"$H(\\\\tan \\\\alpha - \\\\tan \\\\beta)$"},{"id":"b","text":"$H(\\\\cot \\\\alpha - \\\\cot \\\\beta)$"},{"id":"c","text":"$H(\\\\sin \\\\alpha - \\\\sin \\\\beta)$"},{"id":"d","text":"$H / (\\\\tan \\\\alpha - \\\\tan \\\\beta)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Distance is the difference of the horizontal components.

\\textbf{Calculation and Logic:}

$x_1 = H \\cot \\alpha$ and $x_2 = H \\cot \\beta$.

Distance $= |H \\cot \\alpha - H \\cot \\beta|$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_36',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'A 50-foot string is tied to a fence. The other end is pulled tight to a point 30 feet from the fence. What is the sine of the angle formed with the fence?',
  NULL,
  '0.6',
  '\\textbf{Conceptual Explanation:}

The distance from the fence is the side opposite the angle at the fence.

\\textbf{Calculation and Logic:}

$\\sin \\theta = (30)/(50) = 0.6$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_37',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A pendulum 1 meter long swings through an angle of $30^\\circ$ from the vertical. How much higher is the bob than at its lowest point?',
  '[{"id":"a","text":"$1 - \\\\cos 30^\\\\circ$"},{"id":"b","text":"$1 - \\\\sin 30^\\\\circ$"},{"id":"c","text":"$\\\\cos 30^\\\\circ$"},{"id":"d","text":"$\\\\sin 30^\\\\circ$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The vertical height from the pivot is $1 \\cos 30^\\circ$. The bob''s rise is the total length minus this height.

\\textbf{Calculation and Logic:}

$\\text{Rise} = 1 - 1 \\cos 30^\\circ$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_38',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A road has a 6% grade. This means it rises 6 units for every 100 horizontal units. What is the angle of inclination?',
  '[{"id":"a","text":"$\\\\sin^{-1}(0.06)$"},{"id":"b","text":"$\\\\tan^{-1}(0.06)$"},{"id":"c","text":"$\\\\cos^{-1}(0.06)$"},{"id":"d","text":"$0.06^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Grade is slope, which is tangent.

\\textbf{Calculation and Logic:}

$\\tan \\theta = 6/100 = 0.06$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_39',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A camera on a tripod 5 feet tall is 20 feet from a statue. The angle of elevation to the head is $20^\\circ$. How tall is the statue?',
  '[{"id":"a","text":"$20 \\\\tan 20^\\\\circ$"},{"id":"b","text":"$20 \\\\tan 20^\\\\circ + 5$"},{"id":"c","text":"$20 \\\\tan 20^\\\\circ - 5$"},{"id":"d","text":"$5 / \\\\tan 20^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Statue height is the triangle height plus the tripod height.

\\textbf{Calculation and Logic:}

$\\text{Triangle height} = 20 \\tan 20^\\circ$.

$\\text{Total} = 20 \\tan 20^\\circ + 5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_40',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'In a right triangle, the hypotenuse is 10 and the area is 24. What is the sine of the smallest angle?',
  NULL,
  '0.6',
  '\\textbf{Conceptual Explanation:}

Let legs be $a, b$. $a^2 + b^2 = 100$ and $ab/2 = 24 → ab = 48$. This is a 6-8-10 triangle.

\\textbf{Calculation and Logic:}

Smallest angle is opposite the shortest side (6).

$\\sin \\theta = 6/10 = 0.6$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_41',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A bird is perched on a 15-meter pole. A cat is on the ground 20 meters from the pole. What is the distance between them?',
  '[{"id":"a","text":"25"},{"id":"b","text":"35"},{"id":"c","text":"$\\\\sqrt{175}$"},{"id":"d","text":"$\\\\sqrt{625}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Use the Pythagorean theorem for the hypotenuse.

\\textbf{Calculation and Logic:}

$D = \\sqrt{15^2 + 20^2} = \\sqrt{225 + 400} = 25$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_42',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'If $\\sin \\theta = \\cos \\theta$, what is $\\tan \\theta$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"$\\\\sqrt{2}/2$"},{"id":"d","text":"Undefined"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

$\\tan \\theta = \\sin \\theta / \\cos \\theta$.

\\textbf{Calculation and Logic:}

Since they are equal, the ratio is 1.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_43',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'An equilateral triangle has side length $s$. What is the sine of the angle formed by an altitude and a side?',
  '[{"id":"a","text":"1/2"},{"id":"b","text":"$\\\\sqrt{3}/2$"},{"id":"c","text":"1"},{"id":"d","text":"$s/2$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The altitude bisects the $60^\\circ$ angle, creating a $30^\\circ$ angle.

\\textbf{Calculation and Logic:}

$\\sin(30^\\circ) = 1/2$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_44',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A person walks 3 miles North and 4 miles West. What is the cosine of the angle with the Northward path?',
  '[{"id":"a","text":"3/5"},{"id":"b","text":"4/5"},{"id":"c","text":"3/4"},{"id":"d","text":"1"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

North is the adjacent leg (3). The Westward path is the opposite leg (4). Hypotenuse is 5.

\\textbf{Calculation and Logic:}

$\\cos \\theta = 3/5 = 0.6$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_45',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'In a right triangle, $\\sin \\theta = 0.28$. What is $\\cos(90 - \\theta)$?',
  NULL,
  '0.28',
  '\\textbf{Conceptual Explanation:}

Apply the complementary angle identity.

\\textbf{Calculation and Logic:}

$\\cos(90 - \\theta) = \\sin \\theta = 0.28$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_46',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A 10-foot pole is broken such that the top touches the ground 3 feet from the base. How high is the break?',
  '[{"id":"a","text":"4.55"},{"id":"b","text":"5"},{"id":"c","text":"5.45"},{"id":"d","text":"7"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Let $x$ be the break height. The remaining part $(10-x)$ is the hypotenuse.

\\textbf{Calculation and Logic:}

$x^2 + 3^2 = (10-x)^2 → x^2 + 9 = 100 - 20x + x^2$.

$20x = 91 → x = 4.55$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_47',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'Which trig function is always less than 1 for acute angles in a right triangle?',
  '[{"id":"a","text":"$\\\\sin \\\\theta$"},{"id":"b","text":"$\\\\tan \\\\theta$"},{"id":"c","text":"Both"},{"id":"d","text":"Neither"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Hypotenuse is always the longest side.

\\textbf{Calculation and Logic:}

Sine is leg/hypotenuse, so it''s always $< 1$. Tangent can be $> 1$ if opposite $>$ adjacent.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_052_48',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'mcq',
  'math',
  'A guy wire is 50 feet long. It makes a $60^\\circ$ angle with the ground. How far from the pole is it anchored?',
  '[{"id":"a","text":"25"},{"id":"b","text":"$25\\\\sqrt{3}$"},{"id":"c","text":"50"},{"id":"d","text":"$50\\\\sqrt{3}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Anchor distance is adjacent. Wire is hypotenuse.

\\textbf{Calculation and Logic:}

$x = 50 \\cos(60^\\circ) = 50(0.5) = 25$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_052_49',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
),
  (
  'spr',
  'math',
  'If the angle of elevation to a 100-foot tower is $30^\\circ$, how much closer must you move for the angle to be $60^\\circ$? (Round to nearest foot)',
  NULL,
  '116',
  '\\textbf{Conceptual Explanation:}

Find distances at both angles and subtract.

\\textbf{Calculation and Logic:}

$d_1 = 100 \\cot 30^\\circ = 100\\sqrt{3} \\approx 173.2$.

$d_2 = 100 \\cot 60^\\circ = 100/\\sqrt{3} \\approx 57.7$.

Change $= 173.2 - 57.7 = 115.5$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_052_50',
  'Right-triangle trig: sin, cos, tan',
  'Trigonometric Word Problems'
)
ON CONFLICT (bank_item_id) DO NOTHING;

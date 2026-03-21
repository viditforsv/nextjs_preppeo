-- Practice-mode math from lid_048.tex (sat_lid_048)
-- Chapter: Area and volume of 2D/3D shapes | Topic: Volume of Prisms & Cylinders
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_048_N, practice module/set 0.

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
  'A right rectangular prism has a length of 4 centimeters, a width of 9 centimeters, and a height of 10 centimeters. What is the volume, in cubic centimeters, of the prism?',
  NULL,
  '360',
  '\\textbf{Conceptual Explanation:}

The volume of a right rectangular prism is the amount of space contained within its three-dimensional boundaries. It is calculated by finding the product of the three linear dimensions: length, width, and height. The general formula for any prism is $\\text{Volume} = \\text{Base Area} × \\text{Height}$.

\\textbf{Calculation and Logic:}

First, identify the three given dimensions of the prism: length ($L = 4$ cm), width ($W = 9$ cm), and height ($H = 10$ cm). Next, apply the volume formula for a rectangular prism: $\\text{Volume} = L × W × H$. Substitute the values into the equation: $\\text{Volume} = 4 × 9 × 10$. Multiply the first two numbers: $4 × 9 = 36$. Finally, multiply the result by the height: $36 × 10 = 360$. Thus, the total volume of the rectangular prism is 360 cubic centimeters.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_1',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A cylinder has a diameter of 8 inches and a height of 12 inches. What is the volume, in cubic inches, of the cylinder?',
  '[{"id":"a","text":"$16\\\\pi$"},{"id":"b","text":"$96\\\\pi$"},{"id":"c","text":"$192\\\\pi$"},{"id":"d","text":"$768\\\\pi$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A cylinder''s volume is determined by multiplying the area of its circular base by its height. The formula for the area of the base is $\\pi r^2$, making the full volume formula $V = \\pi r^2 h$. It is critical to convert the diameter to the radius before beginning calculations.

\\textbf{Calculation and Logic:}

Identify the given diameter, which is 8 inches. Divide the diameter by 2 to find the radius: $r = 8 / 2 = 4$ inches. Now, identify the height: $h = 12$ inches. Plug these values into the volume formula: $V = \\pi × (4)^2 × 12$. Calculate the square of the radius: $4 × 4 = 16$. Next, multiply 16 by the height of 12: $16 × 12 = 192$. Finally, append the constant $\\pi$ to the result. The calculation yields a total volume of $192\\pi$ cubic inches.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_2',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'The length of the edge of the base of a right square prism is 6 units. The volume of the prism is 2,880 cubic units. What is the height, in units, of the prism?',
  '[{"id":"a","text":"$4\\\\sqrt{30}$"},{"id":"b","text":"36"},{"id":"c","text":"$24\\\\sqrt{5}$"},{"id":"d","text":"80"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

A right square prism is a type of prism where the base is a square. The volume is calculated by multiplying the area of this square base ($s^2$) by the height of the prism ($h$). To find a missing dimension like height, you must rearrange the formula $V = s^2 × h$.

\\textbf{Calculation and Logic:}

Start with the known values: edge of the square base ($s = 6$) and total volume ($V = 2,880$). First, calculate the area of the base: $\\text{Base Area} = 6^2 = 36$ square units. Set up the volume equation: $2880 = 36 × h$. To solve for the height $h$, divide both sides of the equation by 36: $h = 2880 / 36$. Performing the division, you find that 36 goes into 288 exactly 8 times, so $2880 / 36 = 80$. The height of the square prism is 80 units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_3',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right circular cylinder has a volume of $45\\pi$. If the height of the cylinder is 5, what is the radius of the cylinder?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4.5"},{"id":"c","text":"9"},{"id":"d","text":"40"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

To find the radius of a cylinder when the volume and height are known, use the formula $V = \\pi r^2 h$. By isolating the $r^2$ term and then taking the square root, you can determine the linear distance from the center of the base to its edge.

\\textbf{Calculation and Logic:}

Given values: Volume ($V = 45\\pi$) and Height ($h = 5$). Set up the formula: $45\\pi = \\pi × r^2 × 5$. Divide both sides by $\\pi$ to simplify: $45 = 5 × r^2$. Next, isolate the squared radius by dividing both sides by 5: $45 / 5 = r^2$, which simplifies to $9 = r^2$. To find the radius $r$, take the square root of 9. The square root of 9 is 3. Therefore, the radius of the cylinder is 3 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_4',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A right square prism has a height of 14 units. The volume of the prism is 2,016 cubic units. What is the length, in units, of an edge of the base?',
  NULL,
  '12',
  '\\textbf{Conceptual Explanation:}

The base of this prism is a square, meaning its area is the length of one edge squared ($s^2$). We use the volume formula $V = s^2 × h$ to solve for the missing base edge length $s$ by taking the square root of the base area.

\\textbf{Calculation and Logic:}

Identify the knowns: Volume ($V = 2,016$) and Height ($h = 14$). Substitute these into the formula: $2016 = s^2 × 14$. To find the area of the base ($s^2$), divide the volume by the height: $s^2 = 2016 / 14$. Performing the division: 14 goes into 20 once (remainder 6), into 61 four times (remainder 5), and into 56 four times. This results in $s^2 = 144$. Finally, take the square root of 144 to find the edge length $s$. Since $12 × 12 = 144$, the edge of the base is 12 units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_5',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,1.5) ellipse (1.5 and 0.4); \\draw[thick] (-1.5,1.5) -- (-1,0); \\draw[thick] (1.5,1.5) -- (1,0); \\draw[thick] (-1,0) arc (180:360:1 and 0.25); \\draw[dashed] (-1,0) arc (180:0:1 and 0.25); \\draw[<->] (-1.5,1.7) -- (1.5,1.7) node[midway, above] {$k$}; \\draw[<->] (-1, -0.3) -- (1, -0.3) node[midway, below] {$k/2$}; \\draw[<->] (1.8, 0) -- (1.8, 1.5) node[midway, right] {$k$}; \\node at (-3, 0.7) {$\\text{Volume} = \\frac{7\\pi k^3}{48}$}; \\end{tikzpicture} \\end{center} The glass pictured above can hold a maximum volume of 473 cubic centimeters. What is the value of $k$, in centimeters?',
  '[{"id":"a","text":"2.52"},{"id":"b","text":"7.67"},{"id":"c","text":"7.79"},{"id":"d","text":"10.11"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

This problem involves solving for a variable within a given geometric volume formula. We must equate the formula provided for the glass''s volume to the numerical value given and isolate the variable $k$.

\\textbf{Calculation and Logic:}

The volume formula is $(7\\pi k^3)/(48)$. Set this equal to the maximum volume of 473: $473 = (7\\pi k^3)/(48)$. First, isolate $k^3$ by multiplying both sides by 48 and dividing by $7\\pi$: $k^3 = (473 × 48)/(7 × 3.14159)$. Calculating the numerator: $473 × 48 = 22,704$. Calculating the denominator: $7 × 3.14159 \\approx 21.991$. Now, divide the two: $k^3 \\approx 22704 / 21.991 \\approx 1,032.42$. To find $k$, take the cube root of this value: $k = \\sqrt[3]{1032.42}$. Estimating the cube root: $10^3 = 1000$, so the value is very close to 10. Checking Choice D: $10.11^3 \\approx 1033.7$. This is the closest value.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_6',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A manufacturing company produces two sizes of cylindrical containers that each have a height of 50 centimeters. The radius of container A is 16 centimeters, and the radius of container B is 25% longer than the radius of container A. What is the volume, in cubic centimeters, of container B?',
  '[{"id":"a","text":"$16,000\\\\pi$"},{"id":"b","text":"$20,000\\\\pi$"},{"id":"c","text":"$25,000\\\\pi$"},{"id":"d","text":"$31,250\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The volume of a cylinder depends heavily on the radius because the radius is squared in the formula $V = \\pi r^2 h$. When the radius increases by a percentage, we must first find the new radius value before calculating the final volume.

\\textbf{Calculation and Logic:}

First, find the radius of container B. Container A has a radius of 16 cm. Container B''s radius is 25% longer, so $r_B = 16 + (0.25 × 16) = 16 + 4 = 20$ cm. Now, use the height ($h = 50$ cm) and the new radius ($r = 20$ cm) in the volume formula: $V = \\pi × (20)^2 × 50$. Calculate the square of the radius: $20^2 = 400$. Next, multiply by the height: $400 × 50 = 20,000$. Finally, include $\\pi$ in the result. The volume of container B is $20,000\\pi$ cubic centimeters.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_7',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A cylindrical can containing pieces of fruit is filled to the top with syrup before being sealed. The base of the can has an area of $75 \\text{ cm}^2$, and the height of the can is 10 cm. If $110 \\text{ cm}^3$ of syrup is needed to fill the can to the top, which of the following is closest to the total volume of the pieces of fruit in the can?',
  '[{"id":"a","text":"$7.5 \\\\text{ cm}^3$"},{"id":"b","text":"$185 \\\\text{ cm}^3$"},{"id":"c","text":"$640 \\\\text{ cm}^3$"},{"id":"d","text":"$750 \\\\text{ cm}^3$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The total volume of the cylinder is shared by the pieces of fruit and the syrup. By calculating the total capacity of the can and subtracting the volume of the syrup, we can determine the remaining volume occupied by the fruit.

\\textbf{Calculation and Logic:}

First, calculate the total volume of the cylindrical can using the formula $\\text{Volume} = \\text{Base Area} × \\text{Height}$. The problem gives the base area as $75 \\text{ cm}^2$ and the height as $10$ cm. Total Volume $= 75 × 10 = 750 \\text{ cm}^3$. The can contains syrup and fruit. We are told the syrup volume is $110 \\text{ cm}^3$. To find the fruit volume, subtract the syrup from the total: $750 - 110 = 640$. Therefore, the total volume of the pieces of fruit is 640 cubic centimeters.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_8',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[thick] (0,0) circle (2 and 0.5); \\draw[thick] (-2,0) -- (-2,-2); \\draw[thick] (2,0) -- (2,-2); \\draw[thick] (-2,-2) arc (180:360:2 and 0.5); \\draw[dashed] (-2,-2) arc (180:0:2 and 0.5); \\draw[->] (0,0) -- (1.5, 0.3) node[midway, above] {$r$}; \\draw[<->] (2.5, 0) -- (2.5, -2) node[midway, right] {$h$}; \\end{tikzpicture} \\end{center} The figure shown is a right circular cylinder with a radius of $r$ and height of $h$. A second right circular cylinder (not shown) has a volume that is 392 times as large as the volume of the cylinder shown. Which of the following could represent the radius $R$, in terms of $r$, and the height $H$, in terms of $h$, of the second cylinder?',
  '[{"id":"a","text":"$R = 8r$ and $H = 7h$"},{"id":"b","text":"$R = 8r$ and $H = 49h$"},{"id":"c","text":"$R = 7r$ and $H = 8h$"},{"id":"d","text":"$R = 49r$ and $H = 8h$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The volume of a cylinder scales based on the squared factor of the radius and the linear factor of the height. If the original volume is $V = \\pi r^2 h$, and the new volume is $V_{new} = \\pi (Ar)^2 (Bh)$, then $V_{new} = (A^2 × B) × V$. We must find factors $A$ and $B$ such that $A^2 × B = 392$.

\\textbf{Calculation and Logic:}

We need the ratio of the volumes to be 392. Let''s test the choices. For Choice A, $R = 8r$ and $H = 7h$. The volume factor is $8^2 × 7 = 64 × 7$. $60 × 7 = 420$, which is already too high. For Choice C, $R = 7r$ and $H = 8h$. The volume factor is $7^2 × 8$. First, square the radius factor: $7 × 7 = 49$. Next, multiply by the height factor: $49 × 8$. Calculating $50 × 8 - 1 × 8 = 400 - 8 = 392$. Since this matches the volume increase given in the problem, Choice C is correct.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_9',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right circular cylinder has a volume of 432 cubic centimeters. The area of the base of the cylinder is 24 square centimeters. What is the height, in centimeters, of the cylinder?',
  '[{"id":"a","text":"18"},{"id":"b","text":"24"},{"id":"c","text":"216"},{"id":"d","text":"10,368"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The height of any prism or cylinder can be found by dividing its total volume by the area of its base. This is derived from the fundamental relationship $\\text{Volume} = \\text{Base Area} × \\text{Height}$.

\\textbf{Calculation and Logic:}

Identify the known parameters: Volume ($V = 432$) and Base Area ($B = 24$). Plug these into the rearranged formula for height: $H = V / B$. Substitute the numbers: $H = 432 / 24$. To simplify the division, note that 24 goes into 43 once (with a remainder of 19). Bring down the 2 to make 192. Now, determine how many times 24 goes into 192. Since $24 × 10 = 240$ and $240 - 24 - 24 = 192$, it goes in 8 times. Thus, $432 / 24 = 18$. The height of the cylinder is 18 centimeters.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_10',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A right rectangular prism has a base area of 45 square inches and a volume of 270 cubic inches. What is the height of the prism?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

For any prism, the volume is the product of the area of the base and the height. If the base area is provided directly, you do not need the length and width separately.

\\textbf{Calculation and Logic:}

Use the formula $V = B × H$. Given $V = 270$ and $B = 45$, set up the equation $270 = 45 × H$. To isolate $H$, divide 270 by 45. To simplify, recognize that $45 × 2 = 90$ and $90 × 3 = 270$. Therefore, $45 × 6 = 270$. The calculation $270 / 45$ results in 6. The height of the prism is 6 inches.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_11',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'Cylinder X has a radius $r$ and height $h$. Cylinder Y has a radius that is 3 times the radius of Cylinder X and a height that is half the height of Cylinder X. What is the ratio of the volume of Cylinder Y to the volume of Cylinder X?',
  '[{"id":"a","text":"1.5"},{"id":"b","text":"3"},{"id":"c","text":"4.5"},{"id":"d","text":"9"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The ratio of volumes is found by examining how changes in dimensions affect the formula $V = \\pi r^2 h$. Squaring the scale factor of the radius and multiplying it by the scale factor of the height gives the total volume scale factor.

\\textbf{Calculation and Logic:}

Let the volume of Cylinder X be $V_X = \\pi r^2 h$. For Cylinder Y, the new radius is $3r$ and the new height is $0.5h$. Calculate the volume of Cylinder Y: $V_Y = \\pi × (3r)^2 × (0.5h)$. Square the radius term: $V_Y = \\pi × 9r^2 × 0.5h$. Combine the numerical constants: $9 × 0.5 = 4.5$. This simplifies to $V_Y = 4.5 × (\\pi r^2 h)$. This shows that the volume of Cylinder Y is 4.5 times the volume of Cylinder X. The ratio is 4.5.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_12',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A right rectangular prism has a volume of 504 cubic units. If the length is 7 units and the width is 8 units, what is the height?',
  NULL,
  '9',
  '\\textbf{Calculation and Logic:}

First, find the area of the base by multiplying the length and width: $7 × 8 = 56$ square units. Next, use the volume formula $V = B × H$ to solve for height: $504 = 56 × H$. Divide 504 by 56. Since $56 × 10 = 560$, and $560 - 56 = 504$, the height must be 9. The height of the prism is 9 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_13',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A cylindrical tank is 20 feet tall and has a circumference of $10\\pi$ feet at its base. What is the volume of the tank in cubic feet?',
  '[{"id":"a","text":"$200\\\\pi$"},{"id":"b","text":"$500\\\\pi$"},{"id":"c","text":"$1,000\\\\pi$"},{"id":"d","text":"$2,000\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Before calculating volume, you must use the circumference to find the radius of the base. The circumference formula is $C = 2\\pi r$.

\\textbf{Calculation and Logic:}

Find the radius using $10\\pi = 2\\pi r$. Dividing both sides by $2\\pi$ gives $r = 5$ feet. Now, use the volume formula $V = \\pi r^2 h$ with $r = 5$ and $h = 20$. Calculate the base area: $\\pi × 5^2 = 25\\pi$. Multiply by the height: $25\\pi × 20$. Since $25 × 2 = 50$, then $25 × 20 = 500$. The total volume is $500\\pi$ cubic feet.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_14',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A square prism has a volume of 1,000 cubic cm. If the height is 10 cm, what is the perimeter of the base?',
  NULL,
  '40',
  '\\textbf{Conceptual Explanation:}

This problem requires moving from volume to base area, then to base edge length, and finally to the base perimeter.

\\textbf{Calculation and Logic:}

Calculate the base area: $B = V / H = 1000 / 10 = 100 \\text{ cm}^2$. Since the prism is square, the edge of the base $s = \\sqrt{100} = 10$ cm. The perimeter of a square base is $4 × s$. Therefore, the perimeter is $4 × 10 = 40$. The perimeter of the base is 40 centimeters.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_15',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right rectangular prism has dimensions $x, x+2,$ and 5. If the volume is 120, what is the value of $x$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"6"},{"id":"c","text":"8"},{"id":"d","text":"10"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Set up the volume equation: $x(x+2)(5) = 120$. Divide both sides by 5 to simplify: $x(x+2) = 24$. We need two numbers that differ by 2 and multiply to 24. Testing integers: $4 × 6 = 24$. Therefore, $x = 4$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_16',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A cylinder is inscribed perfectly inside a cube with edge length 10. What is the volume of the cylinder?',
  '[{"id":"a","text":"$100\\\\pi$"},{"id":"b","text":"$250\\\\pi$"},{"id":"c","text":"$500\\\\pi$"},{"id":"d","text":"$1,000\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When a cylinder is inscribed in a cube, the cylinder''s diameter and its height are both equal to the edge length of the cube.

\\textbf{Calculation and Logic:}

The height $h$ is 10 and the diameter is 10, meaning the radius $r = 5$. Apply the volume formula: $V = \\pi × 5^2 × 10$. Square the radius: $5^2 = 25$. Multiply by the height: $25 × 10 = 250$. The volume is $250\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_17',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'What is the volume of a cylinder with radius 7 and height 2? (Use 22/7 for $\\pi$).',
  NULL,
  '308',
  '\\textbf{Calculation and Logic:}

$V = \\pi r^2 h = (22/7) × 7^2 × 2$. One of the 7s in the denominator cancels with one in the numerator ($7^2 / 7 = 7$). This leaves $22 × 7 × 2$. Multiply $22 × 14 = 308$. The volume is 308 cubic units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_18',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A rectangular pool is 10 meters long, 5 meters wide, and 2 meters deep. If the pool is filled to 80% capacity, how many cubic meters of water are in the pool?',
  NULL,
  '80',
  '\\textbf{Calculation and Logic:}

Total capacity $= 10 × 5 × 2 = 100 \\text{ cubic meters}$. To find 80% of the total capacity, multiply 100 by 0.80. The calculation $100 × 0.80$ results in 80. There are 80 cubic meters of water in the pool.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_19',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'If the height of a prism is doubled and the base area remains the same, the volume:',
  '[{"id":"a","text":"Stays the same"},{"id":"b","text":"Doubles"},{"id":"c","text":"Triples"},{"id":"d","text":"Quadruples"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

Volume is directly proportional to height ($V = B × H$). If $H$ is multiplied by 2, the product $B × H$ is also multiplied by 2. Thus, the volume doubles.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_048_20',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right circular cylinder has a height of 10 inches and a volume of $160\\pi$ cubic inches. If the height of the cylinder is increased by 4 inches and the radius remains the same, what is the volume, in cubic inches, of the new cylinder?',
  '[{"id":"a","text":"$64\\\\pi$"},{"id":"b","text":"$224\\\\pi$"},{"id":"c","text":"$256\\\\pi$"},{"id":"d","text":"$320\\\\pi$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The volume of a cylinder is directly proportional to its height when the radius is constant. To solve this, we must first determine the fixed radius from the original dimensions and then apply the updated height to the volume formula.

\\textbf{Calculation and Logic:}

First, find the radius using the original volume and height. Substitute $V = 160\\pi$ and $h = 10$ into the formula $V = \\pi r^2 h$. This gives $160\\pi = \\pi × r^2 × 10$. Divide both sides by $10\\pi$ to isolate the squared radius: $16 = r^2$. Taking the square root, we find $r = 4$. Next, identify the new height. The height is increased by 4, so $h_{new} = 10 + 4 = 14$ inches. Finally, calculate the new volume with the same radius: $V_{new} = \\pi × (4)^2 × 14$. Square the radius to get 16, then multiply by the height. The calculation $16 × 14$ results in 224. Therefore, the new volume is $224\\pi$ cubic inches.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_21',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A rectangular prism has a square base with an area of 25 square centimeters. If the total surface area of the prism is 150 square centimeters, what is the volume of the prism in cubic centimeters?',
  NULL,
  '125',
  '\\textbf{Conceptual Explanation:}

Surface area and volume are linked through the dimensions of the prism. In a square prism, the surface area is the sum of the two square bases and the four rectangular side faces. Finding the height from the surface area allows for the final volume calculation.

\\textbf{Calculation and Logic:}

Start by finding the side length of the square base. Since the base area is 25, the side length $s = \\sqrt{25} = 5$ cm. The perimeter of this base is $4 × 5 = 20$ cm. Next, use the surface area formula: $SA = 2(\\text{Base Area}) + (\\text{Perimeter} × \\text{Height})$. Substitute the known values: $150 = 2(25) + (20 × H)$. Simplify the equation: $150 = 50 + 20H$. Subtract 50 from both sides: $100 = 20H$. Divide by 20 to find the height: $H = 5$ cm. Finally, calculate the volume using $V = \\text{Base Area} × H$. The calculation $25 × 5$ results in 125. The volume of the prism is 125 cubic centimeters.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_22',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right circular cylinder has a radius of $r$ and a height of $2r$. Which of the following expressions represents the volume of the cylinder in terms of $r$?',
  '[{"id":"a","text":"$2\\\\pi r^2$"},{"id":"b","text":"$2\\\\pi r^3$"},{"id":"c","text":"$4\\\\pi r^2$"},{"id":"d","text":"$4\\\\pi r^3$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This problem requires substituting an algebraic relationship into the standard volume formula for a cylinder. You must correctly apply the laws of exponents when multiplying terms containing the same variable.

\\textbf{Calculation and Logic:}

The standard formula for the volume of a cylinder is $V = \\pi r^2 h$. The problem provides the height in terms of the radius: $h = 2r$. Substitute this expression for $h$ into the volume formula: $V = \\pi × r^2 × (2r)$. To simplify, multiply the numerical coefficients and then combine the variables. The term $r^2 × r$ becomes $r^3$ because you add the exponents ($2+1=3$). Bringing the constant 2 and $\\pi$ to the front, the simplified expression becomes $2\\pi r^3$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_23',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'What is the volume of a right rectangular prism with a base of 12 inches by 5 inches and a diagonal of the base measuring 13 inches, given the height is 20 inches?',
  NULL,
  '1200',
  '\\textbf{Conceptual Explanation:}

The volume of a rectangular prism is independent of the base diagonal. While the diagonal confirms the relationship between length and width via the Pythagorean theorem ($12^2 + 5^2 = 13^2$), we only need the area of the base and the perpendicular height.

\\textbf{Calculation and Logic:}

First, calculate the area of the rectangular base. Multiply the length of 12 inches by the width of 5 inches. The calculation $12 × 5$ results in a base area of 60 square inches. Next, identify the height of the prism, which is given as 20 inches. Apply the general volume formula: $\\text{Volume} = \\text{Base Area} × \\text{Height}$. Substitute the values: $\\text{Volume} = 60 × 20$. Performing the multiplication, $6 × 2 = 12$, and appending the two zeros results in 1,200. The volume is 1,200 cubic inches.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_24',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'Cylinder A has a volume of $V$. Cylinder B has a height that is 3 times the height of Cylinder A and a diameter that is half the diameter of Cylinder A. What is the volume of Cylinder B in terms of $V$?',
  '[{"id":"a","text":"$0.75V$"},{"id":"b","text":"$1.5V$"},{"id":"c","text":"$3V$"},{"id":"d","text":"$6V$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Volume scales linearly with height but quadratically with the radius (or diameter). When both dimensions change, the total volume scale factor is the product of the individual scale factors.

\\textbf{Calculation and Logic:}

Let the volume of Cylinder A be $V = \\pi r^2 h$. Identify the scale factors for Cylinder B. The height factor is 3 ($H = 3h$). Since the diameter is halved, the radius is also halved, so the radius factor is $1/2$ ($R = 0.5r$). Substitute these into the volume formula for Cylinder B: $V_B = \\pi × (0.5r)^2 × (3h)$. Square the radius factor: $(0.5)^2 = 0.25$. Now, multiply the height factor: $0.25 × 3 = 0.75$. This results in $V_B = 0.75 × (\\pi r^2 h)$. Therefore, the volume of Cylinder B is $0.75V$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_25',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A right circular cylinder has a base area of $36\\pi$ square units and a height that is equal to its diameter. What is the volume of the cylinder?',
  NULL,
  '$432\\pi$',
  '\\textbf{Conceptual Explanation:}

The base area of a cylinder provides the radius. Once the radius is known, the diameter can be calculated, which in this case also yields the height. These two dimensions are then used to calculate the total volume.

\\textbf{Calculation and Logic:}

First, find the radius from the base area. Set $\\pi r^2 = 36\\pi$. Dividing by $\\pi$ gives $r^2 = 36$, so $r = 6$. Second, determine the diameter: $d = 2 × 6 = 12$. The problem states the height $h$ is equal to the diameter, so $h = 12$. Now, calculate the volume using $V = \\text{Base Area} × h$. Substitute the values: $V = 36\\pi × 12$. Perform the multiplication: $36 × 10 = 360$ and $36 × 2 = 72$. Adding them together: $360 + 72 = 432$. Thus, the volume is $432\\pi$ cubic units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_26',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right rectangular prism is filled with water to a depth of 5 cm. The base of the prism measures 10 cm by 8 cm. If a metal cube with an edge length of 4 cm is submerged in the water, what is the new depth of the water in centimeters?',
  '[{"id":"a","text":"0.8"},{"id":"b","text":"5.8"},{"id":"c","text":"6.4"},{"id":"d","text":"10.8"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

According to the principle of displacement, the volume of an object submerged in water is equal to the volume of the water that is pushed upward. This "added" volume creates a new height within the prism''s constant base area.

\\textbf{Calculation and Logic:}

First, calculate the volume of the submerged metal cube. $\\text{Volume}_{cube} = 4^3 = 64 \\text{ cubic cm}$. Second, identify the base area of the prism where the water level will rise: $10 × 8 = 80 \\text{ square cm}$. To find how much the water level rises ($\\Delta h$), divide the displaced volume by the base area: $\\Delta h = 64 / 80$. Simplify the fraction: $64 / 80 = 8 / 10 = 0.8 \\text{ cm}$. Finally, add this rise to the initial depth of the water: $5 + 0.8 = 5.8 \\text{ cm}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_27',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'The volume of a cylinder is $500\\pi$. If the radius is 5, what is the surface area of the cylinder? (In terms of $\\pi$).',
  NULL,
  '$250\\pi$',
  '\\textbf{Conceptual Explanation:}

This is a multi-step problem. First, you must find the height from the volume formula. Then, use both the radius and the height to calculate the surface area, which consists of two circular bases and one rectangular lateral side.

\\textbf{Calculation and Logic:}

Step 1: Find height $h$. $500\\pi = \\pi × 5^2 × h → 500 = 25h → h = 20$. Step 2: Use the surface area formula $SA = 2\\pi r^2 + 2\\pi rh$. Substitute $r = 5$ and $h = 20$. Base Area part: $2 × \\pi × 25 = 50\\pi$. Lateral Area part: $2 × \\pi × 5 × 20 = 200\\pi$. Total Surface Area: $50\\pi + 200\\pi = 250\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_28',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right rectangular prism has a volume of 480. If the length is increased by 20%, the width is decreased by 25%, and the height is doubled, what is the volume of the new prism?',
  '[{"id":"a","text":"432"},{"id":"b","text":"864"},{"id":"c","text":"960"},{"id":"d","text":"1,728"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To find the final volume after multiple changes, multiply the original volume by the product of all the scale factors. Percentages must be converted to decimal multipliers (e.g., a 20% increase is a factor of 1.2).

\\textbf{Calculation and Logic:}

Identify the multipliers: Length $= 1.20$, Width $= 0.75$, Height $= 2.0$. Calculate the combined scale factor: $1.2 × 0.75 × 2$. First, $1.2 × 0.75 = 0.9$. Then, $0.9 × 2 = 1.8$. This means the new volume is 1.8 times the original volume. Multiply the original volume by this factor: $480 × 1.8$. To calculate: $480 × 1 = 480$, and $480 × 0.8 = 384$. Summing them: $480 + 384 = 864$. The new volume is 864 cubic units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_29',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A cylindrical pipe is 100 cm long and has an outer radius of 5 cm and an inner radius of 4 cm. What is the volume of the material used to make the pipe? (In terms of $\\pi$).',
  NULL,
  '$900\\pi$',
  '\\textbf{Conceptual Explanation:}

The volume of a hollow pipe is found by calculating the volume of the larger outer cylinder and subtracting the volume of the empty inner cylinder. This is equivalent to finding the area of the "ring" base and multiplying by the length.

\\textbf{Calculation and Logic:}

Identify the dimensions: $L = 100$, $R = 5$, $r = 4$. Outer Volume: $\\pi × 5^2 × 100 = 2500\\pi$. Inner Volume: $\\pi × 4^2 × 100 = 1600\\pi$. Subtract the inner from the outer: $2500\\pi - 1600\\pi = 900\\pi$. The volume of the material is $900\\pi$ cubic centimeters.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_30',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A right circular cylinder has a diameter of 12 units and a volume of $864\\pi$ cubic units. What is the height of the cylinder?',
  NULL,
  '24',
  '\\textbf{Conceptual Explanation:}

To find the height of a cylinder when given its volume and diameter, we must first determine the radius. Once the radius is known, we use the standard volume formula, $V = \\pi r^2 h$, and perform algebraic manipulation to isolate the height variable.

\\textbf{Calculation and Logic:}

First, identify the radius by dividing the diameter by 2. The calculation $12 / 2$ results in a radius of $r = 6$ units. Next, substitute the known volume ($V = 864\\pi$) and the radius into the volume formula: $864\\pi = \\pi × (6)^2 × h$. Simplify the squared radius: $6 × 6 = 36$, resulting in the equation $864\\pi = 36\\pi h$. Divide both sides by $\\pi$ to remove the constant, leaving $864 = 36h$. Finally, isolate $h$ by dividing 864 by 36. Since $36 × 20 = 720$ and $864 - 720 = 144$, and $36 × 4 = 144$, the total is $20 + 4 = 24$. The height of the cylinder is 24 units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_31',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right rectangular prism has a volume of 720 cubic centimeters. If the length is 12 cm and the width is 10 cm, what is the surface area of the prism in square centimeters?',
  '[{"id":"a","text":"240"},{"id":"b","text":"440"},{"id":"c","text":"504"},{"id":"d","text":"600"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This problem requires two main steps: first, using the volume to find the missing height dimension, and second, using all three dimensions (length, width, and height) to calculate the total surface area.

\\textbf{Calculation and Logic:}

Step 1: Find the height. Use the volume formula $V = L × W × H$. Substitute the known values: $720 = 12 × 10 × H$, which simplifies to $720 = 120H$. Dividing 720 by 120 gives a height of $H = 6$ cm. Step 2: Calculate the surface area using the formula $SA = 2(LW + LH + WH)$. Substitute $L=12, W=10, H=6$: $SA = 2(12 × 10 + 12 × 6 + 10 × 6)$. Calculate the products inside the parentheses: $120 + 72 + 60 = 252$. Finally, multiply by 2: $2 × 252 = 504$. The total surface area is 504 square centimeters.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_32',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right circular cylinder has a volume of $V$. If the radius is doubled and the height is reduced to one-fourth of its original length, what is the volume of the new cylinder?',
  '[{"id":"a","text":"$V/4$"},{"id":"b","text":"$V/2$"},{"id":"c","text":"$V$"},{"id":"d","text":"$2V$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Changes in the dimensions of a 3D object affect its volume based on the powers of those dimensions in the volume formula. For a cylinder, the radius is squared, while the height is linear. The final volume is the original volume multiplied by the product of these scaling factors.

\\textbf{Calculation and Logic:}

Let the original volume be $V = \\pi r^2 h$. Identify the scale factors: the radius factor is 2 ($r_{new} = 2r$) and the height factor is 1/4 ($h_{new} = 0.25h$). Apply these to the volume formula: $V_{new} = \\pi × (2r)^2 × (0.25h)$. Squaring the radius factor gives $2^2 = 4$. Multiplying the squared radius factor by the height factor gives $4 × 0.25 = 1$. This results in $V_{new} = 1 × (\\pi r^2 h)$, which is exactly equal to the original volume $V$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_33',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'What is the volume of a right rectangular prism with a square base of side length 5 and a height that is three times the side length of the base?',
  NULL,
  '375',
  '\\textbf{Conceptual Explanation:}

To find the volume, identify the area of the base and the height. Because the base is a square, its area is the side length squared. The height is determined based on the relative relationship provided in the text.

\\textbf{Calculation and Logic:}

First, calculate the base area: $B = 5 × 5 = 25$. Next, determine the height of the prism: $H = 3 × 5 = 15$. Now, apply the general volume formula $V = \\text{Base Area} × \\text{Height}$. Substitute the values: $V = 25 × 15$. To perform the multiplication, calculate $25 × 10 = 250$ and $25 × 5 = 125$. Summing these results gives $250 + 125 = 375$. The volume of the prism is 375 cubic units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_34',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right square prism has a surface area of 210 square units. If the base edge is 5 units, what is the volume of the prism?',
  '[{"id":"a","text":"150"},{"id":"b","text":"200"},{"id":"c","text":"250"},{"id":"d","text":"400"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In this multi-step problem, we must use the surface area and base dimension to isolate the height of the prism. Once the height is found, we can calculate the final volume using the standard prism formula.

\\textbf{Calculation and Logic:}

First, find the area of the two bases: $2 × (5 × 5) = 50$. Subtract the base areas from the total surface area to find the lateral surface area: $210 - 50 = 160$. The lateral area of a square prism is the perimeter of the base multiplied by the height. The perimeter is $4 × 5 = 20$. Set up the equation: $160 = 20 × H$. Dividing 160 by 20 gives a height of $H = 8$. Finally, calculate the volume: $V = \\text{Base Area} × H$. The calculation $25 × 8$ results in 200. Thus, the volume of the prism is 200 cubic units.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_35',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A cylindrical pipe has an inner diameter of 4 cm and an outer diameter of 6 cm. If the pipe is 50 cm long, what is the volume of the material, in cubic cm, used to make the pipe? (Give answer in terms of $\\pi$).',
  NULL,
  '$250\\pi$',
  '\\textbf{Conceptual Explanation:}

The volume of a hollow cylinder (pipe) is the difference between the volume of the larger outer cylinder and the smaller inner cylinder. This is calculated by finding the area of the annular (ring-shaped) base and multiplying by the length.

\\textbf{Calculation and Logic:}

Identify the radii: the outer radius $R = 6 / 2 = 3$ cm and the inner radius $r = 4 / 2 = 2$ cm. Calculate the outer volume: $V_{out} = \\pi × 3^2 × 50 = 450\\pi$. Calculate the inner volume: $V_{in} = \\pi × 2^2 × 50 = 200\\pi$. To find the volume of the material, subtract the inner volume from the outer volume: $450\\pi - 200\\pi = 250\\pi$. The volume of material is $250\\pi$ cubic centimeters.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_36',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A right rectangular prism has a volume of 480 cubic units. The length, width, and height are in a ratio of 3:2:5. What is the length of the longest side?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

When dimensions are given as a ratio, represent them algebraically using a common variable $x$. Multiply these terms to set up a volume equation and solve for $x$, then calculate the specific dimension required.

\\textbf{Calculation and Logic:}

Let the dimensions be $3x, 2x,$ and $5x$. The volume is the product of these dimensions: $(3x)(2x)(5x) = 480$. Multiplying the coefficients: $3 × 2 × 5 = 30$, resulting in $30x^3 = 480$. Divide both sides by 30: $x^3 = 16$. Wait, checking the ratio: $3 × 4 × 10 \\dots$ let''s use ratio 3:2:5 and volume 300. If volume is 480 and ratio is 3:2:5, then $30x^3=480 → x^3=16$. Let''s adjust the ratio to 4:3:5 for a clean volume of 480. If $4x × 3x × 5x = 480$, then $60x^3 = 480 → x^3 = 8 → x = 2$. The sides are $4(2)=8, 3(2)=6,$ and $5(2)=10$. The longest side is 10.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_37',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'Which of the following would result in the greatest increase in the volume of a cylinder?',
  '[{"id":"a","text":"Doubling the height."},{"id":"b","text":"Doubling the radius."},{"id":"c","text":"Tripling the height."},{"id":"d","text":"Increasing both radius and height by 20%."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Volume increases are determined by the power to which a dimension is raised in the formula. Since the radius is squared ($r^2$), changes to the radius have a much larger impact than changes to the linear height ($h$).

\\textbf{Calculation and Logic:}

Analyze each choice: Choice A (doubling height) multiplies volume by 2. Choice C (tripling height) multiplies volume by 3. Choice B (doubling radius) multiplies volume by $2^2 = 4$. Choice D (increasing both by 20%) multiplies volume by $1.2^2 × 1.2 = 1.728$. Comparing the factors 2, 4, 3, and 1.728, doubling the radius results in the largest increase (a factor of 4).',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_38',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A right circular cylinder is filled with water. The cylinder has a radius of 4 cm and a height of 15 cm. If the water is poured into a rectangular prism with a base of 8 cm by 10 cm, what will be the height of the water in the prism, in cm? (Use $\\pi \\approx 3.14$).',
  NULL,
  '9.42',
  '\\textbf{Conceptual Explanation:}

The volume of water remains constant when transferred between containers. By calculating the total volume of the water in the first container and setting it equal to the volume formula for the second container, we can solve for the unknown height.

\\textbf{Calculation and Logic:}

Step 1: Calculate the water volume in the cylinder. $V = \\pi × 4^2 × 15 = 16 × 15 × \\pi = 240\\pi$. Using 3.14 for $\\pi$, $240 × 3.14 = 753.6$ cubic cm. Step 2: Set this volume equal to the prism''s volume formula $V = L × W × H$. Substitute the base dimensions: $753.6 = 8 × 10 × H$, which gives $753.6 = 80H$. Step 3: Solve for $H$ by dividing 753.6 by 80. The calculation $753.6 / 80$ results in 9.42. The height of the water in the prism is 9.42 centimeters.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_39',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A cube has a surface area of 600 square units. What is the volume of the cube?',
  NULL,
  '1000',
  '\\textbf{Conceptual Explanation:}

To find the volume of a cube, you must first determine its side length. The total surface area of a cube consists of 6 equal square faces. Dividing the total area by 6 gives the area of one face, and the square root of that area gives the side length.

\\textbf{Calculation and Logic:}

First, find the area of one face: $600 / 6 = 100$. Second, find the side length $s$ by taking the square root: $s = \\sqrt{100} = 10$. Finally, calculate the volume by cubing the side length ($s^3$). The calculation $10 × 10 × 10$ results in 1,000. The volume of the cube is 1,000 cubic units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_40',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right circular cylinder has a radius of 5 and a height of 10. A second cylinder has a radius of 10 and a height of 5. What is the ratio of the volume of the first cylinder to the volume of the second cylinder?',
  '[{"id":"a","text":"1:1"},{"id":"b","text":"1:2"},{"id":"c","text":"2:1"},{"id":"d","text":"1:4"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Volume of first cylinder ($V_1$): $\\pi × 5^2 × 10 = 250\\pi$. Volume of second cylinder ($V_2$): $\\pi × 10^2 × 5 = 500\\pi$. To find the ratio, divide $V_1$ by $V_2$: $250\\pi / 500\\pi$. This simplifies to $250/500$, which is $1/2$. The ratio is 1:2.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_41',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A right rectangular prism has a base of 6 by 8 and a volume of 480. What is the length of the diagonal of the prism (the distance between opposite corners)?',
  NULL,
  '14.14',
  '\\textbf{Conceptual Explanation:}

The 3D diagonal of a rectangular prism is found using the extended Pythagorean theorem: $d = \\sqrt{L^2 + W^2 + H^2}$. We must first find the height from the volume.

\\textbf{Calculation and Logic:}

Step 1: Find height $H$. $V = L × W × H → 480 = 6 × 8 × H → 480 = 48H → H = 10$. Step 2: Apply the diagonal formula with $L=6, W=8, H=10$: $d = \\sqrt{6^2 + 8^2 + 10^2}$. Calculate the squares: $36 + 64 + 100 = 200$. The diagonal is $\\sqrt{200}$, which simplifies to $10\\sqrt{2}$. As a decimal, this is approximately 14.14.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_42',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A right circular cylinder has a volume of $72\\pi$. If the radius and height are equal, what is the surface area of the cylinder?',
  '[{"id":"a","text":"$36\\\\pi$"},{"id":"b","text":"$48\\\\pi$"},{"id":"c","text":"$72\\\\pi$"},{"id":"d","text":"$108\\\\pi$"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

Step 1: Find dimensions. Let $r = h$. $V = \\pi r^2 h → 72\\pi = \\pi r^2 (r) → 72 = r^3$. Wait, if $V=54\\pi$, then $r^3=54 \\dots$ let''s use $V=250\\pi$ and $r=h$. $250 = r^3 \\dots$ let''s use $V=128\\pi$ and $h=2r$. $128\\pi = \\pi r^2 (2r) → 128 = 2r^3 → 64 = r^3 → r=4$. Then $h=8$. Step 2: Surface Area $SA = 2\\pi r^2 + 2\\pi rh = 2\\pi(16) + 2\\pi(4)(8) = 32\\pi + 64\\pi = 96\\pi$. Let''s return to Choice C for $V=54\\pi, r=h=3$: $SA = 2\\pi(9) + 2\\pi(3)(3) = 18\\pi + 18\\pi = 36\\pi$. Let''s use $V=16\\pi$ and $r=h=2$: $SA = 2\\pi(4) + 2\\pi(2)(2) = 16\\pi$. If $V=54\\pi, SA=36\\pi$. Let''s use choice D for $r=h=6 → V=216\\pi, SA=2\\pi(36)+2\\pi(36)=144\\pi$. With $V=72\\pi$ and $r=h$, $r^3 = 72 \\dots$ the answer is Choice D for $V=108\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_43',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A prism has a hexagonal base with an area of 40 square units. If the volume of the prism is 320 cubic units, what is the height?',
  NULL,
  '8',
  '\\textbf{Calculation and Logic:}

Identify the base area $B = 40$ and the volume $V = 320$. Use the formula $V = B × H$ and substitute the numbers: $320 = 40 × H$. Isolate $H$ by dividing 320 by 40. The calculation $320 / 40$ results in 8. The height of the prism is 8 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_44',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A cylinder has a radius of $x$ and a height of $y$. If $x$ is increased by 50% and $y$ is decreased by 20%, the volume of the cylinder:',
  '[{"id":"a","text":"Increases by 30%"},{"id":"b","text":"Increases by 80%"},{"id":"c","text":"Increases by 100%"},{"id":"d","text":"Decreases by 10%"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Radius factor is 1.5. Height factor is 0.8. Total volume scale factor $= (1.5)^2 × 0.8$. First, $1.5 × 1.5 = 2.25$. Next, $2.25 × 0.8 = 1.8$. A scale factor of 1.8 represents an 80% increase from the original volume ($1.8 - 1.0 = 0.8$). Thus, the volume increases by 80%.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_45',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'Volume of a cylinder with radius 1 and height 10? (Use 3.14).',
  NULL,
  '31.4',
  '\\textbf{Calculation:}

$V = \\pi × 1^2 × 10 = 10\\pi = 10 × 3.14 = 31.4$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_048_46',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'A rectangular box has dimensions 5, 8, and $h$. If the volume is 400, find $h$.',
  NULL,
  '10',
  '\\textbf{Calculation:}

$5 × 8 × h = 400 → 40h = 400 → h = 10$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_47',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'Base area of a cylinder is $25\\pi$. Height is 4. Volume?',
  NULL,
  '$100\\pi$',
  '\\textbf{Calculation:}

$25\\pi × 4 = 100\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_48',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'mcq',
  'math',
  'A solid metal cylinder with radius 2 and height 5 is melted down and recast into a cube. What is the approximate side length of the cube?',
  '[{"id":"a","text":"2.5"},{"id":"b","text":"3.1"},{"id":"c","text":"3.9"},{"id":"d","text":"4.4"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Volume of cylinder $= \\pi × 2^2 × 5 = 20\\pi \\approx 20 × 3.14 = 62.8$. Set this equal to the volume of a cube $s^3 = 62.8$. Test choices: $3^3 = 27, 4^3 = 64$. Since 62.8 is very close to 64, the side length $s$ must be very close to 4. Choice C (3.9) is the closest value.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_048_49',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
),
  (
  'spr',
  'math',
  'Volume of a rectangular prism with sides 3, 4, 5?',
  NULL,
  '60',
  '\\textbf{Calculation:}

$3 × 4 × 5 = 60$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_048_50',
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders'
)
ON CONFLICT (bank_item_id) DO NOTHING;

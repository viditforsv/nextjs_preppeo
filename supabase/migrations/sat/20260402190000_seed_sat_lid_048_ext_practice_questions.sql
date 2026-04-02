-- Practice-mode math questions from sat_lid_048 extension (sat_extention/sat_lid_048.tex)
-- Chapter: Area and volume of 2D/3D shapes | Topic: Volume of Prisms & Cylinders
-- section=math, domain=geometry-trig, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_048_51 to sat_lid_048_70
-- Extends: 20260320130046_seed_sat_lid_048_practice_sat_questions.sql (which covers _1 to _50)
-- 20 questions total: 4 easy, 8 medium, 8 hard
--
-- NOTE: Questions 54, 63, 68 have solution adjustments noted in the source .tex —
--       these should be reviewed during QC.

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

-- Q1 (sat_lid_048_51): Volume scaling — find R and H for 432x volume
(
  'mcq',
  'math',
  'A right circular cylinder has a radius of $r$ and a height of $h$. A second cylinder has a volume that is 432 times as large as the volume of the first cylinder. Which of the following could represent the radius $R$ and height $H$ of the second cylinder?',
  '[{"id":"a","text":"$R = 6r$ and $H = 12h$"},{"id":"b","text":"$R = 12r$ and $H = 3h$"},{"id":"c","text":"$R = 6r$ and $H = 72h$"},{"id":"d","text":"$R = 36r$ and $H = 12h$"}]'::jsonb,
  'a',
  'Volume $= \pi r^2 h$. For the second cylinder: $\pi R^2 H = 432 \pi r^2 h$.

Test Option A: $R = 6r$, $H = 12h$.

$\pi (6r)^2 (12h) = \pi (36r^2)(12h) = 432\pi r^2 h$. Correct.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_51'
),

-- Q2 (sat_lid_048_52): Solve for k from volume formula
(
  'mcq',
  'math',
  'A custom container has volume $V = \frac{5\pi k^3}{72}$, where $k$ is the diameter of the top base in centimeters. If the container holds a maximum of 510 cubic centimeters, which of the following is closest to the value of $k$?',
  '[{"id":"a","text":"7.42"},{"id":"b","text":"13.26"},{"id":"c","text":"15.15"},{"id":"d","text":"24.31"}]'::jsonb,
  'b',
  '$510 = \frac{5\pi k^3}{72}$

$k^3 = \frac{510 \times 72}{5\pi} = \frac{36{,}720}{5\pi} \approx 2{,}338$

$k = \sqrt[3]{2{,}338} \approx 13.26$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_52'
),

-- Q3 (sat_lid_048_53): Tank volume minus water = sphere volume
(
  'mcq',
  'math',
  'A rectangular tank with a base area of $120 \text{ cm}^2$ and a height of $15 \text{ cm}$ contains several solid lead spheres. To fill the tank to the top, $440 \text{ cm}^3$ of water is needed. What is the total volume, in cubic centimeters, of the lead spheres in the tank?',
  '[{"id":"a","text":"1,360"},{"id":"b","text":"1,440"},{"id":"c","text":"1,800"},{"id":"d","text":"2,240"}]'::jsonb,
  'a',
  'Tank volume: $120 \times 15 = 1{,}800$ cm$^3$.

Sphere volume $= 1{,}800 - 440 = 1{,}360$ cm$^3$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_53'
),

-- Q4 (sat_lid_048_54): Composite prism surface area — find h:s ratio
-- NOTE: Source .tex gets h/s = 3.5, not matching option B. Needs QC review.
(
  'mcq',
  'math',
  'Two identical rectangular prisms each have a height of $h$ and a square base with side length $s$. The surface area of each prism is $K$. If the prisms are glued together along one square base, the surface area of the resulting prism is $\frac{15}{8}K$. What is the ratio of $h$ to $s$?',
  '[{"id":"a","text":"2:1"},{"id":"b","text":"3:1"},{"id":"c","text":"4:1"},{"id":"d","text":"6:1"}]'::jsonb,
  'b',
  '$K = 2s^2 + 4sh$. Glued surface area: $2K - 2s^2 = \frac{15}{8}K$.

$\frac{1}{8}K = 2s^2 \implies K = 16s^2$.

$16s^2 = 2s^2 + 4sh \implies 14s = 4h \implies h/s = 3.5$.

(Note: This question needs QC review — computed ratio 3.5:1 does not exactly match option B = 3:1.)',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_54'
),

-- Q5 (sat_lid_048_55): Cylinder volume in terms of r
(
  'mcq',
  'math',
  'A cylindrical storage tank has a height that is 6 feet less than 4 times its radius $r$. Which expression represents the volume $V$, in cubic feet, of the tank in terms of $r$?',
  '[{"id":"a","text":"$V = 4\\pi r^3 - 6\\pi r^2$"},{"id":"b","text":"$V = 4\\pi r^3 + 6\\pi r^2$"},{"id":"c","text":"$V = 16\\pi r^3 - 36\\pi r$"},{"id":"d","text":"$V = \\pi(4r - 6)^2$"}]'::jsonb,
  'a',
  '$h = 4r - 6$.

$V = \pi r^2 h = \pi r^2(4r - 6) = 4\pi r^3 - 6\pi r^2$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_55'
),

-- Q6 (sat_lid_048_56): Square prism height from perimeter and volume
(
  'spr',
  'math',
  'The base of a right square prism has a perimeter of 40 units. If the volume of the prism is 1,200 cubic units, what is the height of the prism?',
  NULL,
  '12',
  'Side length: $4s = 40 \implies s = 10$.

Base area: $10^2 = 100$.

$1{,}200 = 100h \implies h = 12$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_56'
),

-- Q7 (sat_lid_048_57): Cylinder diameter from volume
(
  'mcq',
  'math',
  'A right circular cylinder has a height of 14 cm and a volume of $504\pi \text{ cm}^3$. What is the base diameter, in centimeters, of the cylinder?',
  '[{"id":"a","text":"6"},{"id":"b","text":"12"},{"id":"c","text":"18"},{"id":"d","text":"36"}]'::jsonb,
  'b',
  '$504\pi = \pi r^2(14) \implies r^2 = 36 \implies r = 6$.

Diameter $= 2r = 12$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_57'
),

-- Q8 (sat_lid_048_58): Rectangular prism surface area from volume
(
  'mcq',
  'math',
  'The volume of a right rectangular prism is 480 cubic inches. If the dimensions of the base are 8 inches by 10 inches, what is the surface area, in square inches, of the prism?',
  '[{"id":"a","text":"160"},{"id":"b","text":"240"},{"id":"c","text":"376"},{"id":"d","text":"480"}]'::jsonb,
  'c',
  'Height: $480 = 8 \times 10 \times h \implies h = 6$.

$SA = 2(8 \times 10 + 8 \times 6 + 10 \times 6) = 2(80 + 48 + 60) = 2(188) = 376$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_58'
),

-- Q9 (sat_lid_048_59): Triangular prism — height = 2 × base area
(
  'mcq',
  'math',
  'A triangular prism has a volume of $450 \text{ cm}^3$. If the height of the prism is twice the area of its base, what is the height of the prism in centimeters?',
  '[{"id":"a","text":"15"},{"id":"b","text":"25"},{"id":"c","text":"30"},{"id":"d","text":"45"}]'::jsonb,
  'c',
  'Let $B$ = base area, $h$ = height. Given $h = 2B$.

$V = Bh \implies 450 = B(2B) = 2B^2 \implies B^2 = 225 \implies B = 15$.

$h = 2(15) = 30$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_59'
),

-- Q10 (sat_lid_048_60): Cylinder with scaled radius and height
(
  'mcq',
  'math',
  'Cylinder A has a volume of $V$. Cylinder B has 3 times the radius and $\frac{1}{3}$ the height of Cylinder A. What is the volume of Cylinder B in terms of $V$?',
  '[{"id":"a","text":"$V$"},{"id":"b","text":"$3V$"},{"id":"c","text":"$9V$"},{"id":"d","text":"$27V$"}]'::jsonb,
  'b',
  '$V_B = \pi(3r)^2 \cdot \frac{h}{3} = \pi(9r^2) \cdot \frac{h}{3} = 3\pi r^2 h = 3V$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_60'
),

-- Q11 (sat_lid_048_61): Volume with percentage dimension changes
(
  'mcq',
  'math',
  'A right square prism has a height of 25 units and a volume of 4,000 cubic units. If the side length of the base is increased by 20% and the height is decreased by 40%, what is the volume of the new prism?',
  '[{"id":"a","text":"2,880"},{"id":"b","text":"3,456"},{"id":"c","text":"4,608"},{"id":"d","text":"5,760"}]'::jsonb,
  'b',
  'Volume scale factor: side increases by 1.2 (squared for area) and height by 0.6.

$V_{new} = V \times (1.2)^2 \times 0.6 = 4{,}000 \times 1.44 \times 0.6 = 4{,}000 \times 0.864 = 3{,}456$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_61'
),

-- Q12 (sat_lid_048_62): Cylinder mass from density
(
  'mcq',
  'math',
  'A solid steel cylinder has a radius of 4 cm and a height of 10 cm. The density of the steel is 7.8 grams per cubic centimeter. What is the total mass of the cylinder in grams? (Use $\pi \approx 3.14$)',
  '[{"id":"a","text":"1,256.0"},{"id":"b","text":"3,921.6"},{"id":"c","text":"4,562.4"},{"id":"d","text":"7,836.2"}]'::jsonb,
  'b',
  '$V = \pi r^2 h = 3.14 \times 16 \times 10 = 502.4$ cm$^3$.

Mass $= 7.8 \times 502.4 = 3{,}918.7$.

Closest option: 3,921.6.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_62'
),

-- Q13 (sat_lid_048_63): Surface area to volume — find r then V
-- NOTE: Source .tex gets V = 360π, not matching options. Adjusts SA. Needs QC review.
(
  'mcq',
  'math',
  'A right circular cylinder has a surface area of $144\pi$. If the height of the cylinder is 10 units, what is the volume of the cylinder?',
  '[{"id":"a","text":"$90\\pi$"},{"id":"b","text":"$144\\pi$"},{"id":"c","text":"$160\\pi$"},{"id":"d","text":"$250\\pi$"}]'::jsonb,
  'c',
  '$SA = 2\pi r^2 + 2\pi rh$. With $h = 10$:

$144\pi = 2\pi r^2 + 20\pi r \implies r^2 + 10r - 72 = 0 \implies (r + 18)(r - 4) = 0 \implies r = 4$.

Wait: $(r+18)(r-4)$ gives $r^2 + 14r - 72$, not matching. Let''s factor correctly: $r^2 + 10r - 72 = 0$. Using the quadratic formula: $r = \frac{-10 + \sqrt{100 + 288}}{2} = \frac{-10 + \sqrt{388}}{2} \approx 4.85$.

(Note: This question needs QC review — the surface area and options may need adjustment for a clean integer radius.)',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_63'
),

-- Q14 (sat_lid_048_64): All dimensions scaled by 1.5 — new volume
(
  'mcq',
  'math',
  'A rectangular prism has a volume of $V$. If each dimension (length, width, and height) is increased by 50%, what is the volume of the new prism in terms of $V$?',
  '[{"id":"a","text":"$1.5V$"},{"id":"b","text":"$2.25V$"},{"id":"c","text":"$3.375V$"},{"id":"d","text":"$4.5V$"}]'::jsonb,
  'c',
  '$V_{new} = (1.5L)(1.5W)(1.5H) = 1.5^3 \times LWH = 3.375V$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_64'
),

-- Q15 (sat_lid_048_65): Cylinder from circumference — height = 2r
(
  'mcq',
  'math',
  'The base of a right circular cylinder has a circumference of $12\pi$. If the height is twice the radius, what is the volume of the cylinder?',
  '[{"id":"a","text":"$144\\pi$"},{"id":"b","text":"$216\\pi$"},{"id":"c","text":"$432\\pi$"},{"id":"d","text":"$864\\pi$"}]'::jsonb,
  'c',
  '$2\pi r = 12\pi \implies r = 6$. Height $= 2r = 12$.

$V = \pi(6)^2(12) = 432\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_65'
),

-- Q16 (sat_lid_048_66): Inscribed cylinder in square prism — leftover volume
(
  'mcq',
  'math',
  'A right square prism with a base edge of 10 and a height of 8 contains the largest possible inscribed right circular cylinder. What is the volume of the space inside the prism that is NOT occupied by the cylinder?',
  '[{"id":"a","text":"$800 - 200\\pi$"},{"id":"b","text":"$800 - 100\\pi$"},{"id":"c","text":"$400 - 50\\pi$"},{"id":"d","text":"$200 - 25\\pi$"}]'::jsonb,
  'a',
  'Prism volume: $10^2 \times 8 = 800$.

Largest inscribed cylinder: $r = 5$, $h = 8$.

Cylinder volume: $\pi(5)^2(8) = 200\pi$.

Leftover: $800 - 200\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_66'
),

-- Q17 (sat_lid_048_67): Volume ratio — radius 2r, height 4h
(
  'mcq',
  'math',
  'Cylinder X has radius $r$ and height $h$. Cylinder Y has radius $2r$ and height $4h$. What is the ratio of the volume of Cylinder Y to the volume of Cylinder X?',
  '[{"id":"a","text":"4:1"},{"id":"b","text":"8:1"},{"id":"c","text":"16:1"},{"id":"d","text":"32:1"}]'::jsonb,
  'c',
  '$V_Y = \pi(2r)^2(4h) = 16\pi r^2 h$.

$\frac{V_Y}{V_X} = \frac{16\pi r^2 h}{\pi r^2 h} = 16$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_67'
),

-- Q18 (sat_lid_048_68): Equilateral triangle base prism — find side length
-- NOTE: Source .tex solution doesn't simplify cleanly. Needs QC review.
(
  'mcq',
  'math',
  'A triangular prism has a height of 15 and a volume of 360. If the base is an equilateral triangle, what is the side length of that triangle?',
  '[{"id":"a","text":"$4\\sqrt{6}$"},{"id":"b","text":"$8\\sqrt{3}$"},{"id":"c","text":"$4\\sqrt[4]{3}$"},{"id":"d","text":"24"}]'::jsonb,
  'a',
  'Base area: $B = \frac{360}{15} = 24$.

$\frac{s^2\sqrt{3}}{4} = 24 \implies s^2 = \frac{96}{\sqrt{3}} = 32\sqrt{3}$.

$s = \sqrt{32\sqrt{3}}$.

(Note: This question needs QC review — the answer does not simplify to a clean form matching the options exactly.)',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_68'
),

-- Q19 (sat_lid_048_69): Water level rise from dropped cube
(
  'mcq',
  'math',
  'A cylindrical cup with a radius of 3 cm is half-full of water. A solid metal cube with side length 4 cm is dropped into the cup. By how many centimeters does the water level rise? (Use $\pi \approx 3$)',
  '[{"id":"a","text":"1.62"},{"id":"b","text":"2.37"},{"id":"c","text":"3.12"},{"id":"d","text":"7.11"}]'::jsonb,
  'b',
  'Cube volume: $4^3 = 64$ cm$^3$.

Displaced water forms a cylinder: $64 = \pi r^2 \Delta h \approx 3 \times 9 \times \Delta h = 27\Delta h$.

$\Delta h = \frac{64}{27} \approx 2.37$ cm.',
  'geometry-trig',
  'hard',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_69'
),

-- Q20 (sat_lid_048_70): Volume = surface area — find height
(
  'spr',
  'math',
  'A right circular cylinder has a numerical volume equal to its numerical surface area. If the radius is 4, what is the height of the cylinder?',
  NULL,
  '4',
  '$\pi r^2 h = 2\pi r^2 + 2\pi rh$. Cancel $\pi r$:

$rh = 2r + 2h$. Substitute $r = 4$:

$4h = 8 + 2h \implies 2h = 8 \implies h = 4$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'Area and volume of 2D/3D shapes',
  'Volume of Prisms & Cylinders',
  'sat_lid_048_70'
);

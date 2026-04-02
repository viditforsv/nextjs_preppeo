-- Practice-mode math questions from sat_lid_008 extension (sat_extention/sat_lid_008.tex)
-- Chapter: Systems of two linear equations in two variables | Topic: Systems Word Problems
-- section=math, domain=algebra, module_number=0, set_number=0 (practice pool)
-- bank_item_id range: sat_lid_008_50 to sat_lid_008_69
-- Extends: 20260320190000_seed_sat_lid_008_practice_sat_questions.sql (which covers _1 to _49)
-- 20 questions total: 5 easy, 10 medium, 5 hard
--
-- NOTE: Questions 50, 57, 58 have solution adjustments noted in the source .tex —
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

-- Q1 (sat_lid_008_50): Vendor pricing — two-vendor system
-- NOTE: Source .tex solution doesn't produce integer; answer B=9 is stated. Needs QC review.
(
  'mcq',
  'math',
  'Vendor A sells organic coffee for \$14.50 per bag and tea for \$6.00 per box. Vendor B sells the same coffee for \$16.50 per bag and tea for \$5.00 per box. A cafe owner made a purchase of $c$ bags of coffee and $t$ boxes of tea that would cost \$176.00 at Vendor A or \$189.00 at Vendor B. How many boxes of tea, $t$, were in this purchase?',
  '[{"id":"a","text":"7"},{"id":"b","text":"9"},{"id":"c","text":"11"},{"id":"d","text":"13"}]'::jsonb,
  'b',
  'Set up the system:

Vendor A: $14.5c + 6t = 176$
Vendor B: $16.5c + 5t = 189$

Subtract Vendor A from Vendor B: $2c - t = 13 \implies t = 2c - 13$.

Substitute into Vendor A: $14.5c + 6(2c - 13) = 176 \implies 14.5c + 12c - 78 = 176 \implies 26.5c = 254$.

$c \approx 9.58$. (Note: This question needs QC review — constants may need adjustment for integer answers.)',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_50'
),

-- Q2 (sat_lid_008_51): Wire/cable cutting — find x
(
  'mcq',
  'math',
  'A piece of fiber-optic cable with a length of 120 meters is cut into two parts. One part has a length of $x$ meters, and the other part has a length of $y$ meters. The length of $x$ is 15 meters less than twice the length of $y$. What is the value of $x$?',
  '[{"id":"a","text":"45"},{"id":"b","text":"65"},{"id":"c","text":"75"},{"id":"d","text":"85"}]'::jsonb,
  'c',
  'Set up the system:

$x + y = 120$
$x = 2y - 15$

Substitute: $(2y - 15) + y = 120 \implies 3y - 15 = 120 \implies 3y = 135 \implies y = 45$.

$x = 120 - 45 = 75$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_51'
),

-- Q3 (sat_lid_008_52): Park survey — find number in favor
(
  'mcq',
  'math',
  'A survey regarding a new park reported that 4 times as many residents were in favor of the park as residents who opposed it. A local news report stated that 12,600 more residents were in favor than those opposed. Based on these data, how many residents were in favor of the park?',
  '[{"id":"a","text":"3,150"},{"id":"b","text":"4,200"},{"id":"c","text":"15,750"},{"id":"d","text":"16,800"}]'::jsonb,
  'd',
  'Let $F$ = residents in favor, $O$ = residents opposed.

$F = 4O$
$F = O + 12{,}600$

Substitute: $4O = O + 12{,}600 \implies 3O = 12{,}600 \implies O = 4{,}200$.

$F = 4(4{,}200) = 16{,}800$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_52'
),

-- Q4 (sat_lid_008_53): Museum tickets — revenue difference
(
  'mcq',
  'math',
  'A museum sold two types of tickets: general admission for \$18 and student tickets for \$10. The museum sold a total of 150 tickets for \$2,140. How much more money, in dollars, was spent on general admission tickets than on student tickets?',
  '[{"id":"a","text":"\\$700"},{"id":"b","text":"\\$740"},{"id":"c","text":"\\$1,440"},{"id":"d","text":"\\$1,580"}]'::jsonb,
  'b',
  'Let $g$ = general tickets, $s$ = student tickets.

$g + s = 150 \implies s = 150 - g$
$18g + 10s = 2{,}140$

Substitute: $18g + 10(150 - g) = 2{,}140 \implies 8g = 640 \implies g = 80$.

$s = 70$. General revenue $= 80 \times 18 = 1{,}440$. Student revenue $= 70 \times 10 = 700$.

Difference $= 1{,}440 - 700 = 740$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_53'
),

-- Q5 (sat_lid_008_54): Test scoring — find correct answers
(
  'mcq',
  'math',
  'In a standardized test, the score is calculated by adding 4 points for every correct answer and subtracting 1 point for every incorrect answer. If a student answered 60 questions total and received a score of 165, how many questions did the student answer correctly?',
  '[{"id":"a","text":"42"},{"id":"b","text":"45"},{"id":"c","text":"48"},{"id":"d","text":"52"}]'::jsonb,
  'b',
  'Let $C$ = correct, $W$ = wrong.

$C + W = 60 \implies W = 60 - C$
$4C - W = 165$

Substitute: $4C - (60 - C) = 165 \implies 5C - 60 = 165 \implies 5C = 225 \implies C = 45$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_54'
),

-- Q6 (sat_lid_008_55): Acid mixture — find volume of Solution Y
(
  'mcq',
  'math',
  'A chemist combines two acid solutions to create 40 liters of a 25% acid solution. Solution X is 10% acid and Solution Y is 35% acid. What was the volume, in liters, of Solution Y used in the mixture?',
  '[{"id":"a","text":"12"},{"id":"b","text":"16"},{"id":"c","text":"20"},{"id":"d","text":"24"}]'::jsonb,
  'd',
  'Let $x$ and $y$ be volumes of Solution X and Y.

$x + y = 40 \implies x = 40 - y$
$0.10x + 0.35y = 0.25(40) = 10$

Substitute: $0.10(40 - y) + 0.35y = 10 \implies 4 - 0.10y + 0.35y = 10 \implies 0.25y = 6 \implies y = 24$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_55'
),

-- Q7 (sat_lid_008_56): Desk/chair discount — identify correct system
(
  'mcq',
  'math',
  'The total original price of a desk and a chair is \$450. A store applies a 20% discount to the desk and a 15% discount to the chair, resulting in a combined sale price of \$372. Which system of equations represents the original price of the desk, $d$, and the chair, $c$?',
  '[{"id":"a","text":"$d + c = 450$ and $0.20d + 0.15c = 372$"},{"id":"b","text":"$d + c = 450$ and $0.80d + 0.85c = 372$"},{"id":"c","text":"$d + c = 372$ and $0.80d + 0.85c = 450$"},{"id":"d","text":"$0.20d + 0.15c = 450$ and $d + c = 372$"}]'::jsonb,
  'b',
  'The first equation is the sum of original prices: $d + c = 450$.

A 20% discount means the customer pays 80% of $d$: $0.80d$.
A 15% discount means the customer pays 85% of $c$: $0.85c$.

The sale total: $0.80d + 0.85c = 372$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_56'
),

-- Q8 (sat_lid_008_57): Swim and run distance — find swim distance
-- NOTE: Source .tex adjusts constants for integer; answer A=400 stated. Needs QC review.
(
  'mcq',
  'math',
  'During a training week, Leo swam $s$ meters at a rate of 40 meters per minute and ran $r$ meters at a rate of 180 meters per minute. He swam and ran a total of 5,000 meters. If he spent exactly 3 times as many minutes running as he did swimming, how many meters did he swim?',
  '[{"id":"a","text":"400"},{"id":"b","text":"800"},{"id":"c","text":"1,200"},{"id":"d","text":"3,600"}]'::jsonb,
  'a',
  'Let $t_s$ = time swimming, $t_r$ = time running.

$40t_s + 180t_r = 5{,}000$
$t_r = 3t_s$

Substitute: $40t_s + 180(3t_s) = 5{,}000 \implies 40t_s + 540t_s = 5{,}000 \implies 580t_s = 5{,}000$.

$t_s \approx 8.62$ minutes. Swim distance $= 40 \times 8.62 \approx 345$.

(Note: This question needs QC review — constants may need adjustment for an exact integer answer.)',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_57'
),

-- Q9 (sat_lid_008_58): Deli sandwiches and sodas — find sandwich cost
-- NOTE: Source .tex gets x=4.80 but states answer C=$4.75. Needs QC review.
(
  'mcq',
  'math',
  'Two patrons bought identical items at a deli. The first patron paid \$16.50 for 2 sandwiches and 3 sodas. The second patron paid \$21.50 for 4 sandwiches and 1 soda. What is the cost, in dollars, of 1 sandwich?',
  '[{"id":"a","text":"\\$3.25"},{"id":"b","text":"\\$4.50"},{"id":"c","text":"\\$4.75"},{"id":"d","text":"\\$5.00"}]'::jsonb,
  'c',
  'Set up the system (let $x$ = sandwich cost, $y$ = soda cost):

$2x + 3y = 16.50$
$4x + y = 21.50 \implies y = 21.50 - 4x$

Substitute: $2x + 3(21.50 - 4x) = 16.50 \implies 2x + 64.50 - 12x = 16.50 \implies -10x = -48 \implies x = 4.80$.

(Note: This question needs QC review — computed answer $x = 4.80$ does not exactly match option C = \$4.75.)',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_58'
),

-- Q10 (sat_lid_008_59): Hotel rooms — find number of suites
(
  'mcq',
  'math',
  'A tour group of 145 tourists booked 45 hotel rooms. Standard rooms hold 3 tourists each, and Suites hold 5 tourists each. Assuming every room is filled to capacity, how many of the rooms were Suites?',
  '[{"id":"a","text":"5"},{"id":"b","text":"10"},{"id":"c","text":"15"},{"id":"d","text":"20"}]'::jsonb,
  'a',
  'Let $s$ = standard rooms, $u$ = suites.

$s + u = 45 \implies s = 45 - u$
$3s + 5u = 145$

Substitute: $3(45 - u) + 5u = 145 \implies 135 - 3u + 5u = 145 \implies 2u = 10 \implies u = 5$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_59'
),

-- Q11 (sat_lid_008_60): Fencing two gardens — find side length x
(
  'mcq',
  'math',
  'A landscaper has 180 feet of fencing to enclose two separate rectangular garden beds. Garden A is a square with side length $x$. Garden B is a rectangle where the length is 3 times the width $y$. If the total perimeter of both gardens is 180 feet and the landscaper uses 20 more feet for Garden A than Garden B, what is the value of $x$?',
  '[{"id":"a","text":"15"},{"id":"b","text":"20"},{"id":"c","text":"25"},{"id":"d","text":"30"}]'::jsonb,
  'c',
  'Perimeter of Garden A: $P_A = 4x$. Perimeter of Garden B: $P_B = 2(3y + y) = 8y$.

$4x + 8y = 180$
$4x = 8y + 20$

Substitute: $(8y + 20) + 8y = 180 \implies 16y = 160 \implies y = 10$.

$4x = 8(10) + 20 = 100 \implies x = 25$.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_60'
),

-- Q12 (sat_lid_008_61): Auditorium seats — find a - b
(
  'mcq',
  'math',
  'An auditorium charges $a$ dollars for premium seats and $b$ dollars for economy seats. On Friday, they sold 200 premium and 400 economy tickets for a total of \$12,000. On Saturday, they sold 300 premium and 300 economy tickets for \$13,500. What is the value of $a - b$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"15"},{"id":"c","text":"25"},{"id":"d","text":"35"}]'::jsonb,
  'b',
  'Simplify the system:

$200a + 400b = 12{,}000 \implies a + 2b = 60$
$300a + 300b = 13{,}500 \implies a + b = 45$

Subtract equation 2 from equation 1: $b = 15$.

$a = 45 - 15 = 30$. So $a - b = 30 - 15 = 15$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_61'
),

-- Q13 (sat_lid_008_62): Pump work rate — find x
(
  'mcq',
  'math',
  'Pump A can fill a tank in $x$ hours, and Pump B can fill the same tank in $y$ hours. Working together, they fill the tank in 12 hours. If Pump A is twice as fast as Pump B, what is the value of $x$?',
  '[{"id":"a","text":"18"},{"id":"b","text":"24"},{"id":"c","text":"30"},{"id":"d","text":"36"}]'::jsonb,
  'a',
  'Work rate equation: $\frac{1}{x} + \frac{1}{y} = \frac{1}{12}$.

If A is twice as fast, it takes half the time: $y = 2x$.

Substitute: $\frac{1}{x} + \frac{1}{2x} = \frac{1}{12}$.

Find common denominator: $\frac{3}{2x} = \frac{1}{12} \implies 2x = 36 \implies x = 18$.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_62'
),

-- Q14 (sat_lid_008_63): Two lines intersect at (3, k) — find k
(
  'mcq',
  'math',
  'Two distinct lines intersect at $(3, k)$. The first line has equation $ax + by = 15$ and the second has equation $bx + ay = 13$. If $a + b = 7$, what is the value of $k$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  'Substitute $(3, k)$ into both equations:

$3a + kb = 15$
$3b + ka = 13$

Add: $3(a + b) + k(a + b) = 28 \implies (3 + k)(a + b) = 28$.

Since $a + b = 7$: $(3 + k)(7) = 28 \implies 3 + k = 4 \implies k = 1$.',
  'algebra',
  'hard',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_63'
),

-- Q15 (sat_lid_008_64): Nested ratios — find gravel amount
(
  'mcq',
  'math',
  'A recipe for concrete requires sand, gravel, and cement. The ratio of sand to gravel is 3:5, and the ratio of gravel to cement is 2:1. If a construction crew uses a total of 1,260 kg of these materials, how many kg of gravel were used?',
  '[{"id":"a","text":"400"},{"id":"b","text":"600"},{"id":"c","text":"720"},{"id":"d","text":"800"}]'::jsonb,
  'b',
  'Link the ratios using gravel as the common term.

Sand : Gravel = 3 : 5 = 6 : 10
Gravel : Cement = 2 : 1 = 10 : 5

Combined ratio: Sand : Gravel : Cement = 6 : 10 : 5.

$6x + 10x + 5x = 1{,}260 \implies 21x = 1{,}260 \implies x = 60$.

Gravel $= 10 \times 60 = 600$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_64'
),

-- Q16 (sat_lid_008_65): Printer output — find color printing time
(
  'mcq',
  'math',
  'A printer produces 20 black-and-white pages per minute or 12 color pages per minute. In 4 hours of continuous printing, the printer produced a total of 3,840 pages. How many minutes were spent printing in color?',
  '[{"id":"a","text":"60"},{"id":"b","text":"120"},{"id":"c","text":"180"},{"id":"d","text":"240"}]'::jsonb,
  'b',
  'Let $b$ = minutes on B&W, $c$ = minutes on color. Total time = 240 minutes.

$b + c = 240 \implies b = 240 - c$
$20b + 12c = 3{,}840$

Substitute: $20(240 - c) + 12c = 3{,}840 \implies 4{,}800 - 20c + 12c = 3{,}840 \implies -8c = -960 \implies c = 120$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_65'
),

-- Q17 (sat_lid_008_66): BOGO vs flat discount — find original price
(
  'mcq',
  'math',
  'Store X offers a "Buy One, Get One 50% Off" deal on items of equal value. Store Y offers a flat 30% discount on all items. A customer wants to buy 2 identical items. If the total price is \$14.00 cheaper at Store Y, what is the original price of one item?',
  '[{"id":"a","text":"\\$100"},{"id":"b","text":"\\$120"},{"id":"c","text":"\\$140"},{"id":"d","text":"\\$200"}]'::jsonb,
  'c',
  'Let $P$ = original price of one item.

Store X price: $P + 0.5P = 1.5P$
Store Y price: $2P \times 0.70 = 1.4P$

Difference: $1.5P - 1.4P = 14 \implies 0.1P = 14 \implies P = 140$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_66'
),

-- Q18 (sat_lid_008_67): Rectangle sides — area in terms of d
(
  'mcq',
  'math',
  'The sum of the lengths of two sides of a rectangle is $s$ and the difference between those same two sides is $d$. If $s = 5d$, which of the following represents the area of the rectangle in terms of $d$?',
  '[{"id":"a","text":"$2d^2$"},{"id":"b","text":"$4d^2$"},{"id":"c","text":"$6d^2$"},{"id":"d","text":"$10d^2$"}]'::jsonb,
  'c',
  'Let sides be $L$ and $W$.

$L + W = s$ and $L - W = d$.

Add: $2L = s + d$. Since $s = 5d$: $2L = 6d \implies L = 3d$.

Subtract: $2W = s - d = 4d \implies W = 2d$.

Area $= L \times W = 3d \times 2d = 6d^2$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_67'
),

-- Q19 (sat_lid_008_68): Alcohol mixture — find liters of Solution A in terms of k
(
  'mcq',
  'math',
  'Solution A is 20% alcohol and Solution B is 50% alcohol. To make $k$ liters of a 30% alcohol solution, how many liters of Solution A must be used in terms of $k$?',
  '[{"id":"a","text":"$\\frac{1}{3}k$"},{"id":"b","text":"$\\frac{2}{3}k$"},{"id":"c","text":"$\\frac{1}{2}k$"},{"id":"d","text":"$\\frac{3}{4}k$"}]'::jsonb,
  'b',
  'Let $a$ = liters of A, $b$ = liters of B.

$a + b = k \implies b = k - a$
$0.2a + 0.5b = 0.3k$

Substitute: $0.2a + 0.5(k - a) = 0.3k \implies 0.2a + 0.5k - 0.5a = 0.3k \implies -0.3a = -0.2k \implies a = \frac{2}{3}k$.',
  'algebra',
  'medium',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_68'
),

-- Q20 (sat_lid_008_69): Orange boxes — find L - S
(
  'mcq',
  'math',
  'A vendor sells a large box of oranges for $L$ dollars and a small box for $S$ dollars. 10 large and 5 small boxes cost \$250. 5 large and 10 small boxes cost \$200. What is the value of $L - S$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"10"},{"id":"c","text":"15"},{"id":"d","text":"20"}]'::jsonb,
  'b',
  'Set up the system:

$10L + 5S = 250$
$5L + 10S = 200$

Subtract equation 2 from equation 1:

$5L - 5S = 50 \implies L - S = 10$.',
  'algebra',
  'easy',
  0,
  0,
  'Systems of two linear equations in two variables',
  'Systems Word Problems',
  'sat_lid_008_69'
);

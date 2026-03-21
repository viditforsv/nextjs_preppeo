-- Practice-mode math from lid_008.tex (sat_lid_008)
-- Chapter: Systems of two linear equations in two variables | Topic: Systems Word Problems
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_008_N, practice module/set 0.
-- Requires bank_item_id (see 20260320120000_seed_sat_lid_001_practice_sat_questions.sql or use --bank-ddl).

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
  bank_item_id
)
VALUES
  (
  'mcq',
  'math',
  'A craft store manager is ordering two types of yarn. Wool yarn costs 8 per skein and acrylic yarn costs 5 per skein. The manager ordered a total of 24 skeins for a total cost of 150. If $w$ represents the skeins of wool yarn and $a$ represents the skeins of acrylic yarn, which system of equations models this purchase?',
  '[{"id":"a","text":"$w + a = 24$; $8w + 5a = 150$"},{"id":"b","text":"$w + a = 150$; $8w + 5a = 24$"},{"id":"c","text":"$8w + 5a = 24$; $w + a = 150$"},{"id":"d","text":"$5w + 8a = 150$; $w + a = 24$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In this modeling problem, we must identify two independent constraints. The first constraint is the physical count of the items (skeins of yarn). The second constraint is the financial limit (total budget). By multiplying the count of each type by its unit price, we determine its contribution to the total cost.

\\textbf{Calculation and Logic:}

First, we establish the quantity equation based on the total of 24 skeins:

\\[w + a = 24\\]

Next, we establish the value equation based on the prices (8 for wool and 5 for acrylic) and the total cost of 150:

\\[8w + 5a = 150\\]

Combining these two gives the system in option A.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_1'
),
  (
  'spr',
  'math',
  'A local sanctuary houses two species of birds: Parrots and Cockatoos. There are 18 birds in total. Parrots require 2 cups of specialized seed per day, while Cockatoos require 5 cups. If the sanctuary uses exactly 60 cups of seed per day, how many Cockatoos are at the sanctuary?',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

This problem requires solving for one of the variables in a quantity-value system. We set up equations for the bird count and the food consumption, then use substitution to find the number of Cockatoos.

\\textbf{Calculation and Logic:}

Let $p$ be Parrots and $c$ be Cockatoos.

\\[p + c = 18 → p = 18 - c\\]

\\[2p + 5c = 60\\]

Substituting the first expression into the second:

\\[2(18 - c) + 5c = 60\\]

\\[36 - 2c + 5c = 60\\]

\\[3c = 24 → c = 8\\]

There are 8 Cockatoos.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_2'
),
  (
  'mcq',
  'math',
  'A tech company manufactures two versions of a processor. Version X takes 30 minutes to test and Version Y takes 50 minutes to test. In one shift, a total of 40 processors were tested, requiring a total testing time of 1,500 minutes. If $x$ is the number of Version X processors and $y$ is the number of Version Y processors, which system correctly represents this?',
  '[{"id":"a","text":"$x + y = 40$; $30x + 50y = 1,500$"},{"id":"b","text":"$x + y = 1,500$; $30x + 50y = 40$"},{"id":"c","text":"$30x + 50y = 40$; $x + y = 1,500$"},{"id":"d","text":"$x + y = 40$; $50x + 30y = 1,500$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The SAT frequently uses time as the second constraint. One equation relates to the number of units produced or tested, while the other relates to the total time consumed, calculated by multiplying the units by the time-per-unit rate.

\\textbf{Calculation and Logic:}

The total count of processors is 40:

\\[x + y = 40\\]

The total time is 1,500 minutes, with X taking 30 and Y taking 50:

\\[30x + 50y = 1,500\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_3'
),
  (
  'spr',
  'math',
  'A scientist is blending a 20% saline solution with a 60% saline solution. She wants to create 40 liters of a 50% saline solution. How many liters of the 60% solution should she use?',
  NULL,
  '30',
  '\\textbf{Conceptual Explanation:}

Mixture systems track the volume of the mixture and the "strength" or amount of the solute (saline). We create one equation for the total liters and another for the liters of pure saline.

\\textbf{Calculation and Logic:}

Let $L$ be the 20% solution and $H$ be the 60% solution.

\\[L + H = 40 → L = 40 - H\\]

The target saline amount is $50%$ of 40, which is 20 liters.

\\[0.20L + 0.60H = 20\\]

Substitute:

\\[0.20(40 - H) + 0.60H = 20\\]

\\[8 - 0.20H + 0.60H = 20\\]

\\[0.40H = 12 → H = 30\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_4'
),
  (
  'mcq',
  'math',
  'A gardener is creating 100 pounds of mulch by mixing pine bark, costing 2 per pound, and cedar chips, costing 5 per pound. If the total cost for the mulch is 320, which system represents the pounds of pine bark ($p$) and cedar chips ($c$)?',
  '[{"id":"a","text":"$p + c = 100$; $2p + 5c = 320$"},{"id":"b","text":"$p + c = 320$; $2p + 5c = 100$"},{"id":"c","text":"$2p + 5c = 100$; $p + c = 320$"},{"id":"d","text":"$p + c = 100$; $5p + 2c = 320$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The system is built on weight and budget. One equation sums the weights of the two components to equal the final weight, and the second sums the costs to equal the total budget.

\\textbf{Calculation and Logic:}

Total weight equation: $p + c = 100$

Total budget equation: $2p + 5c = 320$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_5'
),
  (
  'spr',
  'math',
  'A bookstore ordered 50 books. Paperbacks cost 10 each and hardcovers cost 18 each. If the total order was 700, how many hardcovers were ordered?',
  NULL,
  '25',
  '\\textbf{Conceptual Explanation:}

We use the elimination method to isolate the number of hardcovers by multiplying the quantity equation to match the paperback coefficient.

\\textbf{Calculation and Logic:}

$p + h = 50$

$10p + 18h = 700$

Multiply the quantity equation by 10:

\\[10p + 10h = 500\\]

Subtract this from the value equation:

\\[(10p + 18h) - (10p + 10h) = 700 - 500\\]

\\[8h = 200 → h = 25\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_6'
),
  (
  'mcq',
  'math',
  'A movie theater sold 120 tickets. Child tickets are 8 and adult tickets are 14. The total revenue was 1,320. If $c$ is child tickets and $a$ is adult tickets, which system is correct?',
  '[{"id":"a","text":"$c + a = 120$; $8c + 14a = 1,320$"},{"id":"b","text":"$c + a = 1,320$; $8c + 14a = 120$"},{"id":"c","text":"$8c + 14a = 1,320$; $c + a = 1,320$"},{"id":"d","text":"$14c + 8a = 1,320$; $c + a = 120$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

This system models ticket counts and revenue. The first equation sums the ticket types, and the second multiplies each by its respective price to reach the total sales.

\\textbf{Calculation and Logic:}

Count: $c + a = 120$

Revenue: $8c + 14a = 1,320$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_7'
),
  (
  'spr',
  'math',
  'A hobbyist bought 15 total model planes and cars. Planes cost 20 and cars cost 12. If he spent 220, how many planes did he buy?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

Setting up a system for count and cost allowed us to find the specific quantity of planes by substituting the car variable.

\\textbf{Calculation and Logic:}

$p + c = 15 → c = 15 - p$

$20p + 12c = 220$

\\[20p + 12(15 - p) = 220\\]

\\[20p + 180 - 12p = 220\\]

\\[8p = 40 → p = 5\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_8'
),
  (
  'mcq',
  'math',
  'A shipment of 80 crates contains small crates and large crates. Small crates weigh 10 kg and large crates weigh 25 kg. Total weight is 1,250 kg. If $s$ is small and $l$ is large, which system works?',
  '[{"id":"a","text":"$s + l = 80$; $10s + 25l = 1,250$"},{"id":"b","text":"$s + l = 1,250$; $10s + 25l = 80$"},{"id":"c","text":"$10s + 25l = 80$; $s + l = 80$"},{"id":"d","text":"$25s + 10l = 1,250$; $s + l = 80$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

We model the shipment using crate count and the sum of weights. The weight of each crate type is its coefficient in the second equation.

\\textbf{Calculation and Logic:}

Crate count: $s + l = 80$

Weight sum: $10s + 25l = 1,250$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_9'
),
  (
  'spr',
  'math',
  'A vending machine contains 40 coins, all quarters (0.25) and dimes (0.10). The total value is 7.00. How many quarters are in the machine?',
  NULL,
  '20',
  '\\textbf{Conceptual Explanation:}

Using the total count of coins and their monetary values, we create a system and solve for quarters using substitution.

\\textbf{Calculation and Logic:}

$q + d = 40 → d = 40 - q$

$0.25q + 0.10d = 7.00$

\\[0.25q + 0.10(40 - q) = 7.00\\]

\\[0.25q + 4 - 0.10q = 7.00\\]

\\[0.15q = 3 → q = 20\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_10'
),
  (
  'mcq',
  'math',
  'A parking lot has 60 vehicles, some cars and some motorcycles. Cars have 4 wheels and motorcycles have 2. Total wheels in the lot is 200. If $c$ is cars and $m$ is motorcycles, which system is correct?',
  '[{"id":"a","text":"$c + m = 60$; $4c + 2m = 200$"},{"id":"b","text":"$c + m = 200$; $4c + 2m = 60$"},{"id":"c","text":"$4c + 2m = 60$; $c + m = 60$"},{"id":"d","text":"$c + m = 60$; $2c + 4m = 200$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

This system uses vehicle count and wheel count. We multiply the wheels per vehicle by the number of each vehicle to find the total.

\\textbf{Calculation and Logic:}

Vehicle count: $c + m = 60$

Wheel count: $4c + 2m = 200$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_11'
),
  (
  'spr',
  'math',
  'A test has 50 questions. Students get 5 points for each correct answer and lose 2 points for each incorrect answer. A student scored 180 by answering all questions. How many did they get correct?',
  NULL,
  '40',
  '\\textbf{Conceptual Explanation:}

Score systems on the SAT often involve negative coefficients for incorrect answers. We track total questions and total points.

\\textbf{Calculation and Logic:}

$c + i = 50 → i = 50 - c$

$5c - 2i = 180$

\\[5c - 2(50 - c) = 180\\]

\\[5c - 100 + 2c = 180\\]

\\[7c = 280 → c = 40\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_12'
),
  (
  'mcq',
  'math',
  'A florist sells lilies for 4 each and roses for 6 each. A customer bought 20 flowers for 104. If $L$ is lilies and $r$ is roses, which system models this?',
  '[{"id":"a","text":"$L + r = 20$; $4L + 6r = 104$"},{"id":"b","text":"$L + r = 104$; $4L + 6r = 20$"},{"id":"c","text":"$4L + 6r = 104$; $L + r = 104$"},{"id":"d","text":"$L + r = 20$; $6L + 4r = 104$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The system counts flowers and calculates the total cost based on individual unit prices.

\\textbf{Calculation and Logic:}

Flower count: $L + r = 20$

Cost sum: $4L + 6r = 104$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_13'
),
  (
  'spr',
  'math',
  'A gym has 15 total weights: 5-lb plates and 10-lb plates. The total weight is 110 lbs. How many 10-lb plates are there?',
  NULL,
  '7',
  '\\textbf{Conceptual Explanation:}

We track the count of plates and the sum of their weights, solving for the 10-lb plates by eliminating the 5-lb variable.

\\textbf{Calculation and Logic:}

$x + y = 15 → x = 15 - y$

$5x + 10y = 110$

\\[5(15 - y) + 10y = 110\\]

\\[75 - 5y + 10y = 110\\]

\\[5y = 35 → y = 7\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_14'
),
  (
  'mcq',
  'math',
  'A cafe sold 45 drinks: small coffees for 3 and large coffees for 5. Total sales were 175. If $s$ is small and $L$ is large, which system is correct?',
  '[{"id":"a","text":"$s + L = 45$; $3s + 5L = 175$"},{"id":"b","text":"$s + L = 175$; $3s + 5L = 45$"},{"id":"c","text":"$3s + 5L = 175$; $s + L = 175$"},{"id":"d","text":"$s + L = 45$; $5s + 3L = 175$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Drink count and revenue are the constraints. Small drinks generate $3s$ dollars and large drinks generate $5L$ dollars.

\\textbf{Calculation and Logic:}

Count: $s + L = 45$

Revenue: $3s + 5L = 175$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_15'
),
  (
  'spr',
  'math',
  'A drawer has 24 socks, black and blue. There are twice as many black socks as blue socks. How many blue socks are there?',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

This system uses a simple relationship between variables instead of a budget. We define one variable in terms of the other.

\\textbf{Calculation and Logic:}

$B + L = 24$

$B = 2L$

\\[(2L) + L = 24\\]

\\[3L = 24 → L = 8\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_16'
),
  (
  'mcq',
  'math',
  'A theater has 200 seats divided into floor and balcony. Floor seats cost 50 and balcony seats cost 30. Revenue for a full show is 7,600. If $f$ is floor and $b$ is balcony, which system works?',
  '[{"id":"a","text":"$f + b = 200$; $50f + 30b = 7,600$"},{"id":"b","text":"$f + b = 7,600$; $50f + 30b = 200$"},{"id":"c","text":"$50f + 30b = 7,600$; $f + b = 7,600$"},{"id":"d","text":"$f + b = 200$; $30f + 50b = 7,600$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The constraints are seat capacity and total potential revenue. The price of each seat type acts as its weight in the value equation.

\\textbf{Calculation and Logic:}

Seats: $f + b = 200$

Revenue: $50f + 30b = 7,600$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_17'
),
  (
  'spr',
  'math',
  'A rectangular field has a perimeter of 60 meters. The length is 6 meters more than the width. What is the width of the field?',
  NULL,
  '12',
  '\\textbf{Conceptual Explanation:}

Perimeter systems define relationships between dimensions. We use the perimeter formula and the specific relationship provided.

\\textbf{Calculation and Logic:}

$2L + 2W = 60 → L + W = 30$

$L = W + 6$

\\[(W + 6) + W = 30\\]

\\[2W = 24 → W = 12\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_18'
),
  (
  'mcq',
  'math',
  'A person bought 12 fruits: apples for 1.50 and oranges for 2.00. Total cost was 21.00. If $a$ is apples and $r$ is oranges, which system is correct?',
  '[{"id":"a","text":"$a + r = 12$; $1.5a + 2r = 21$"},{"id":"b","text":"$a + r = 21$; $1.5a + 2r = 12$"},{"id":"c","text":"$1.5a + 2r = 21$; $a + r = 21$"},{"id":"d","text":"$a + r = 12$; $2a + 1.5r = 21$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Modeling fruit count and budget follows the standard value-quantity pattern.

\\textbf{Calculation and Logic:}

Count: $a + r = 12$

Budget: $1.5a + 2r = 21$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_19'
),
  (
  'spr',
  'math',
  'Two numbers sum to 40 and their difference is 10. What is the smaller number?',
  NULL,
  '15',
  '\\textbf{Conceptual Explanation:}

Simple numerical systems are a foundational SAT skill. Adding and subtracting equations directly allows for rapid solving.

\\textbf{Calculation and Logic:}

$x + y = 40$

$x - y = 10$

Subtracting:

\\[(x + y) - (x - y) = 40 - 10\\]

\\[2y = 30 → y = 15\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_20'
),
  (
  'mcq',
  'math',
  'A store sells small lamps for 15 and large lamps for 25. A customer bought 10 lamps for 190. If $s$ is small and $L$ is large, which system models this?',
  '[{"id":"a","text":"$s + L = 10$; $15s + 25L = 190$"},{"id":"b","text":"$s + L = 190$; $15s + 25L = 10$"},{"id":"c","text":"$15s + 25L = 190$; $s + L = 190$"},{"id":"d","text":"$s + L = 10$; $25s + 15L = 190$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The model links lamp count to the total expenditure based on the price of each size.

\\textbf{Calculation and Logic:}

Count: $s + L = 10$

Budget: $15s + 25L = 190$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_21'
),
  (
  'spr',
  'math',
  'A collection of 30 stamps contains 20-cent stamps and 50-cent stamps. Total value is 12.00. How many 50-cent stamps are there?',
  NULL,
  '20',
  '\\textbf{Conceptual Explanation:}

This system models stamp count and value in dollars. We multiply the count of each by its value in dollars to reach the total.

\\textbf{Calculation and Logic:}

$x + y = 30 → x = 30 - y$

$0.20x + 0.50y = 12$

\\[0.20(30 - y) + 0.50y = 12\\]

\\[6 - 0.20y + 0.50y = 12\\]

\\[0.30y = 6 → y = 20\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_22'
),
  (
  'mcq',
  'math',
  'A truck carried 50 packages. Type A packages weigh 4 lbs and Type B weigh 7 lbs. Total weight is 260 lbs. If $a$ is Type A and $b$ is Type B, which system is correct?',
  '[{"id":"a","text":"$a + b = 50$; $4a + 7b = 260$"},{"id":"b","text":"$a + b = 260$; $4a + 7b = 50$"},{"id":"c","text":"$4a + 7b = 260$; $a + b = 260$"},{"id":"d","text":"$a + b = 50$; $7a + 4b = 260$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The system models the package shipment using unit weight and count constraints.

\\textbf{Calculation and Logic:}

Package count: $a + b = 50$

Weight sum: $4a + 7b = 260$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_23'
),
  (
  'spr',
  'math',
  'In a shop, 20 tools were sold: screwdrivers and hammers. Screwdrivers cost 5 and hammers cost 12. Total sales were 156. How many screwdrivers were sold?',
  NULL,
  '12',
  '\\textbf{Conceptual Explanation:}

By modeling tool count and revenue, we can solve for screwdrivers by substituting the hammer variable.

\\textbf{Calculation and Logic:}

$s + h = 20 → h = 20 - s$

$5s + 12h = 156$

\\[5s + 12(20 - s) = 156\\]

\\[5s + 240 - 12s = 156\\]

\\[-7s = -84 → s = 12\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_24'
),
  (
  'mcq',
  'math',
  'A company has 100 employees: managers and workers. Managers earn 200 per day and workers earn 120 per day. Total payroll is 13,600. If $m$ is managers and $w$ is workers, which system is correct?',
  '[{"id":"a","text":"$m + w = 100$; $200m + 120w = 13,600$"},{"id":"b","text":"$m + w = 13,600$; $200m + 120w = 100$"},{"id":"c","text":"$200m + 120w = 13,600$; $m + w = 13,600$"},{"id":"d","text":"$m + w = 100$; $120m + 200w = 13,600$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Modeling employee count and daily payroll costs follows the standard value-quantity pattern.

\\textbf{Calculation and Logic:}

Count: $m + w = 100$

Payroll: $200m + 120w = 13,600$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_25'
),
  (
  'mcq',
  'math',
  'A cyclist travels 40 miles with a tailwind in 2 hours and returns against the same wind in 2.5 hours. What is the speed of the wind in miles per hour?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"18"},{"id":"d","text":"20"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Wind problems use modifying speeds. With the wind, speeds add ($c + w$). Against the wind, they subtract ($c - w$).

\\textbf{Calculation and Logic:}

With wind: $40 / 2 = 20$ mph $→ c + w = 20$

Against wind: $40 / 2.5 = 16$ mph $→ c - w = 16$

Subtract equations to eliminate cyclist speed $c$:

\\[(c + w) - (c - w) = 20 - 16\\]

\\[2w = 4 → w = 2\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_27'
),
  (
  'spr',
  'math',
  'A technician has two data plans. Plan A costs 20 plus 10 per GB. Plan B costs 50 plus 5 per GB. For what number of GB will the plans cost the same?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

"Equal cost" problems are solved by setting the linear expressions for each plan equal to each other.

\\textbf{Calculation and Logic:}

Plan A: $20 + 10x$

Plan B: $50 + 5x$

\\[20 + 10x = 50 + 5x\\]

\\[5x = 30 → x = 6\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_28'
),
  (
  'mcq',
  'math',
  'A collection of 60 notes contains 5 notes and 10 notes. Total value is 420. If $f$ is 5 and $t$ is 10, which system is correct?',
  '[{"id":"a","text":"$f + t = 60$; $5f + 10t = 420$"},{"id":"b","text":"$f + t = 420$; $5f + 10t = 60$"},{"id":"c","text":"$5f + 10t = 420$; $f + t = 420$"},{"id":"d","text":"$f + t = 60$; $10f + 5t = 420$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The system models banknote count and the sum of their cash values.

\\textbf{Calculation and Logic:}

Count: $f + t = 60$

Value: $5f + 10t = 420$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_008_29'
),
  (
  'spr',
  'math',
  'A rectangle has a perimeter of 40 cm. The length is three times the width. What is the length of the rectangle?',
  NULL,
  '15',
  '\\textbf{Conceptual Explanation:}

We use the perimeter formula and the specific multiplier relationship to solve for length.

\\textbf{Calculation and Logic:}

$2L + 2W = 40 → L + W = 20$

$L = 3W$

\\[(3W) + W = 20\\]

\\[4W = 20 → W = 5\\]

If $W = 5$, then $L = 3(5) = 15$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_30'
),
  (
  'mcq',
  'math',
  'A store owner mixed nuts costing 3 per lb with nuts costing 8 per lb to get 10 lbs of a mix costing 5 per lb. Which system models this?',
  '[{"id":"a","text":"$x + y = 10$; $3x + 8y = 50$"},{"id":"b","text":"$x + y = 10$; $3x + 8y = 5$"},{"id":"c","text":"$3x + 8y = 10$; $x + y = 50$"},{"id":"d","text":"$x + y = 50$; $3x + 8y = 10$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The total mix is 10 lbs, and the total cost is 10 lbs $×$ 5/lb = 50.

\\textbf{Calculation and Logic:}

Weight: $x + y = 10$

Total cost: $3x + 8y = 50$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_31'
),
  (
  'spr',
  'math',
  'In a factory, 40 machines produce 200 parts per hour. Type A machines produce 4 parts and Type B produce 6 parts. How many Type B machines are there?',
  NULL,
  '20',
  '\\textbf{Conceptual Explanation:}

Modeling production follows the quantity-value pattern, using hourly rates as coefficients.

\\textbf{Calculation and Logic:}

$A + B = 40 → A = 40 - B$

$4A + 6B = 200$

\\[4(40 - B) + 6B = 200\\]

\\[160 - 4B + 6B = 200\\]

\\[2B = 40 → B = 20\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_32'
),
  (
  'mcq',
  'math',
  'A plane flying with the wind travels 1,200 miles in 3 hours. Against the wind, it takes 4 hours for the same distance. What is the speed of the wind?',
  '[{"id":"a","text":"50"},{"id":"b","text":"350"},{"id":"c","text":"400"},{"id":"d","text":"300"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Modifying speed systems allow for finding both the vehicle and the medium''s speed.

\\textbf{Calculation and Logic:}

With wind: $1,200 / 3 = 400 → p + w = 400$

Against wind: $1,200 / 4 = 300 → p - w = 300$

Subtract equations:

\\[(p + w) - (p - w) = 400 - 300\\]

\\[2w = 100 → w = 50\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_33'
),
  (
  'spr',
  'math',
  'A student scored 85 on a test with 40 questions. Correct answers earned 3 points and incorrect answers lost 2 points. How many did they answer correctly?',
  NULL,
  '33',
  '\\textbf{Conceptual Explanation:}

Tracking total questions and point deductions allows us to find the number of correct answers.

\\textbf{Calculation and Logic:}

$c + i = 40 → i = 40 - c$

$3c - 2i = 85$

\\[3c - 2(40 - c) = 85\\]

\\[3c - 80 + 2c = 85\\]

\\[5c = 165 → c = 33\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_34'
),
  (
  'mcq',
  'math',
  'A jar contains 50 coins, all nickels and dimes. Total value is 3.50. If $n$ is nickels and $d$ is dimes, which system models this?',
  '[{"id":"a","text":"$n + d = 50$; $0.05n + 0.10d = 3.50$"},{"id":"b","text":"$n + d = 3.50$; $0.05n + 0.10d = 50$"},{"id":"c","text":"$0.05n + 0.10d = 3.50$; $n + d = 3.50$"},{"id":"d","text":"$n + d = 50$; $0.10n + 0.05d = 3.50$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The system models coin count and the sum of their monetary values in dollars.

\\textbf{Calculation and Logic:}

Count: $n + d = 50$

Value: $0.05n + 0.10d = 3.50$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_35'
),
  (
  'spr',
  'math',
  'Two angles are supplementary (sum to 180 degrees). One angle is 20 degrees more than three times the other. What is the smaller angle?',
  NULL,
  '40',
  '\\textbf{Conceptual Explanation:}

Geometric systems use defined sums (like 180 or 90) alongside specific additive or multiplicative relationships.

\\textbf{Calculation and Logic:}

$x + y = 180 → x = 180 - y$

$x = 3y + 20$

\\[(3y + 20) + y = 180\\]

\\[4y = 160 → y = 40\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_36'
),
  (
  'mcq',
  'math',
  'A mix of 20 lbs of nuts costing 4 per lb and 9 per lb costs 6 per lb total. Which system models this?',
  '[{"id":"a","text":"$x + y = 20$; $4x + 9y = 120$"},{"id":"b","text":"$x + y = 20$; $4x + 9y = 6$"},{"id":"c","text":"$4x + 9y = 120$; $x + y = 120$"},{"id":"d","text":"$x + y = 6$; $4x + 9y = 20$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Total cost is the total weight multiplied by the unit price of the final mix.

\\textbf{Calculation and Logic:}

Weight: $x + y = 20$

Cost: $20 × 6 = 120 → 4x + 9y = 120$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_37'
),
  (
  'spr',
  'math',
  'A runner covers 10 miles in 2 segments. The first part is at 6 mph and the second is at 8 mph. If the total time was 1.5 hours, how many miles was the first part?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

Segmented distance problems use distance-time relationships. We create equations for total distance and total time (distance / speed).

\\textbf{Calculation and Logic:}

$d_1 + d_2 = 10 → d_2 = 10 - d_1$

$d_1 / 6 + d_2 / 8 = 1.5$

Multiply by 24: $4d_1 + 3d_2 = 36$

\\[4d_1 + 3(10 - d_1) = 36\\]

\\[d_1 + 30 = 36 → d_1 = 6\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_38'
),
  (
  'mcq',
  'math',
  'A technician has 40 resistors: 100-ohm and 250-ohm. Total resistance in series is 6,400 ohms. If $x$ is 100-ohm and $y$ is 250-ohm, which system is correct?',
  '[{"id":"a","text":"$x + y = 40$; $100x + 250y = 6,400$"},{"id":"b","text":"$x + y = 6,400$; $100x + 250y = 40$"},{"id":"c","text":"$100x + 250y = 6,400$; $x + y = 6,400$"},{"id":"d","text":"$x + y = 40$; $250x + 100y = 6,400$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

This system models resistor count and total cumulative resistance.

\\textbf{Calculation and Logic:}

Count: $x + y = 40$

Total Resistance: $100x + 250y = 6,400$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_39'
),
  (
  'mcq',
  'math',
  'A bank has 80 notes: 10 and 20. Total value is 1,100. If $x$ is 10 and $y$ is 20, which system is correct?',
  '[{"id":"a","text":"$x + y = 80$; $10x + 20y = 1,100$"},{"id":"b","text":"$x + y = 1,100$; $10x + 20y = 80$"},{"id":"c","text":"$10x + 20y = 1,100$; $x + y = 1,100$"},{"id":"d","text":"$x + y = 80$; $20x + 10y = 1,100$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Modeling currency count and total cash value follows the standard quantity-value pattern.

\\textbf{Calculation and Logic:}

Count: $x + y = 80$

Value: $10x + 20y = 1,100$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_41'
),
  (
  'spr',
  'math',
  'A rectangle has a perimeter of 50. The width is 5 less than the length. What is the width?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

We use the perimeter formula and the specific additive relationship to solve for width.

\\textbf{Calculation and Logic:}

$2L + 2W = 50 → L + W = 25$

$W = L - 5 → L = W + 5$

\\[(W + 5) + W = 25\\]

\\[2W = 20 → W = 10\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_42'
),
  (
  'mcq',
  'math',
  'A store mixed coffee worth 6 per lb and 11 per lb to get 20 lbs of a mix worth 8 per lb. Which system models this?',
  '[{"id":"a","text":"$x + y = 20$; $6x + 11y = 160$"},{"id":"b","text":"$x + y = 20$; $6x + 11y = 8$"},{"id":"c","text":"$6x + 11y = 20$; $x + y = 160$"},{"id":"d","text":"$x + y = 160$; $6x + 11y = 20$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Total mix is 20 lbs, and total value is 20 lbs $×$ 8/lb = 160.

\\textbf{Calculation and Logic:}

Weight: $x + y = 20$

Value: $6x + 11y = 160$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_43'
),
  (
  'spr',
  'math',
  'Two numbers sum to 60. One number is 10 more than four times the other. What is the larger number?',
  NULL,
  '50',
  '\\textbf{Conceptual Explanation:}

Numerical systems use additive and multiplicative relationships. We substitute one variable to find the values.

\\textbf{Calculation and Logic:}

$x + y = 60 → x = 60 - y$

$x = 4y + 10$

\\[(4y + 10) + y = 60\\]

\\[5y = 50 → y = 10\\]

If $y = 10$, then $x = 4(10) + 10 = 50$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_44'
),
  (
  'mcq',
  'math',
  'A jar has 40 balls, red and blue. Red balls cost 2 and blue balls cost 5. Total cost is 110. If $r$ is red and $b$ is blue, which system is correct?',
  '[{"id":"a","text":"$r + b = 40$; $2r + 5b = 110$"},{"id":"b","text":"$r + b = 110$; $2r + 5b = 40$"},{"id":"c","text":"$2r + 5b = 110$; $r + b = 110$"},{"id":"d","text":"$r + b = 40$; $5r + 2b = 110$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Modeling ball count and total budget follows the standard value-quantity pattern.

\\textbf{Calculation and Logic:}

Count: $r + b = 40$

Budget: $2r + 5b = 110$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_45'
),
  (
  'spr',
  'math',
  'In a library, 30 books were checked out: novels and non-fiction. Total fine for late return was 21. Novels fine is 0.50 and non-fiction is 1.00. How many novels were checked out?',
  NULL,
  '18',
  '\\textbf{Conceptual Explanation:}

Modeling book count and cumulative fines follows the standard quantity-value pattern.

\\textbf{Calculation and Logic:}

$n + f = 30 → f = 30 - n$

$0.50n + 1.00f = 21$

\\[0.50n + 1.00(30 - n) = 21\\]

\\[-0.50n = -9 → n = 18\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_46'
),
  (
  'mcq',
  'math',
  'A collection of 100 tools contains screwdrivers and wrenches. Screwdrivers cost 3 and wrenches cost 6. Total value is 420. If $s$ is screwdrivers and $w$ is wrenches, which system works?',
  '[{"id":"a","text":"$s + w = 100$; $3s + 6w = 420$"},{"id":"b","text":"$s + w = 420$; $3s + 6w = 100$"},{"id":"c","text":"$3s + 6w = 420$; $s + w = 420$"},{"id":"d","text":"$s + w = 100$; $6s + 3w = 420$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Modeling tool count and cumulative costs follows the standard quantity-value pattern.

\\textbf{Calculation and Logic:}

Count: $s + w = 100$

Cost: $3s + 6w = 420$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_47'
),
  (
  'spr',
  'math',
  'Two numbers sum to 80. Their difference is 20. What is the larger number?',
  NULL,
  '50',
  '\\textbf{Conceptual Explanation:}

Numerical systems are solved efficiently by summing the equations to find the larger variable.

\\textbf{Calculation and Logic:}

$x + y = 80$

$x - y = 20$

Summing:

\\[2x = 100 → x = 50\\]',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_48'
),
  (
  'mcq',
  'math',
  'A box of 60 items has Type X and Type Y. Type X costs 4 and Type Y costs 9. Total value is 340. If $x$ is Type X and $y$ is Type Y, which system is correct?',
  '[{"id":"a","text":"$x + y = 60$; $4x + 9y = 340$"},{"id":"b","text":"$x + y = 340$; $4x + 9y = 60$"},{"id":"c","text":"$4x + 9y = 340$; $x + y = 340$"},{"id":"d","text":"$x + y = 60$; $9x + 4y = 340$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Modeling item count and cumulative costs follows the standard quantity-value pattern.

\\textbf{Calculation and Logic:}

Count: $x + y = 60$

Cost: $4x + 9y = 340$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_008_49'
)
ON CONFLICT (bank_item_id) DO NOTHING;

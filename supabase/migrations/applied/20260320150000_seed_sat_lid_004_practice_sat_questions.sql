-- Practice-mode math from lid_004.tex (sat_lid_004)
-- Chapter: Linear equations in two variables | Topic: Slope-Intercept & Standard Form
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_004_N, practice module/set 0.
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
  'A jet ski rental shop charges a fixed 35 insurance fee and an hourly rate of 12.50. A tourist wants to spend no more than 100 on a rental. If $h$ represents the number of hours the jet ski is rented, which inequality represents this situation?',
  '[{"id":"a","text":"$12.50h ≤ 100$"},{"id":"b","text":"$35 + 12.50h ≤ 100$"},{"id":"c","text":"$35h + 12.50 ≤ 100$"},{"id":"d","text":"$12.50 + 35h ≥ 100$"}]'::jsonb,
  'b',
  'To represent the total cost of the rental, we analyze the two distinct types of charges. The fixed insurance fee is a one-time cost of 35 that does not change based on how long the jet ski is used. This acts as the constant in our linear expression.

The variable part of the cost is the hourly rate of 12.50. Since $h$ represents the total number of hours, we multiply the rate by the hours to get $12.50h$. Adding these two components together gives us the total expression for the expenditure: $35 + 12.50h$.

The phrase "no more than" indicates that the total cost must be less than or equal to the tourist''s budget of 100. In mathematical notation, this is expressed using the $≤$ symbol. Therefore, the complete inequality representing the constraint on the rental time is $35 + 12.50h ≤ 100$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_1'
),
  (
  'mcq',
  'math',
  'The width of a standard warehouse loading dock is at least 12 feet and no more than 15 feet. A logistics manager has a total wall length of 180 feet available for docks. Which of the following describes all possible values for $n$, the number of loading docks that can be built?',
  '[{"id":"a","text":"$12 ≤ n ≤ 15$"},{"id":"b","text":"$12 ≤ n ≤ 180$"},{"id":"c","text":"$15 ≤ n ≤ 180$"},{"id":"d","text":"$12 ≤ n ≤ 15$"}]'::jsonb,
  'a',
  'To find the possible number of docks that can fit in the allotted space, we must consider the two extreme scenarios for the dock widths. The number of docks is found by dividing the total available wall length of 180 feet by the width of an individual dock.

If the manager chooses to build the widest possible docks at 15 feet each, the number of docks will be at its minimum. Dividing 180 feet by 15 feet per dock results in exactly 12 docks.

Conversely, if the manager builds the narrowest allowed docks at 12 feet each, the number of docks will be at its maximum. Dividing 180 feet by 12 feet per dock results in 15 docks.

Because the width can be any value between 12 and 15, the resulting number of docks $n$ must fall within the range of 12 to 15, inclusive. This relationship is expressed by the inequality $12 ≤ n ≤ 15$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_2'
),
  (
  'mcq',
  'math',
  'A catering company is buying crates of soda and water. A delivery truck can carry at most 500 pounds. A crate of soda weighs 18 pounds, and a crate of water weighs 22 pounds. The company wants to buy at least three times as many crates of water as crates of soda. Let $s$ be soda and $w$ be water. Which system represents this?',
  '[{"id":"a","text":"$18s + 22w ≤ 500$; $w ≥ 3s$"},{"id":"b","text":"$18s + 22w ≤ 500$; $s ≥ 3w$"},{"id":"c","text":"$40(s+w) ≤ 500$; $w ≥ 3s$"},{"id":"d","text":"$18s + 22w ≥ 500$; $w ≤ 3s$"}]'::jsonb,
  'a',
  'This problem requires two separate inequalities to model the truck''s capacity and the company''s purchasing preference. First, we determine the weight constraint. The total weight is the sum of the weight of the soda crates ($18s$) and the weight of the water crates ($22w$). Since the truck has a maximum capacity of 500 pounds, the total weight must be less than or equal to 500, giving us $18s + 22w ≤ 500$.

Second, we model the relationship between the quantities of the two items. The company requires "at least three times as many water crates as soda crates." This means the number of water crates, $w$, must be greater than or equal to three times the number of soda crates, $s$. This is written mathematically as $w ≥ 3s$.

Combining these two requirements into a system gives us the constraints necessary for the catering company''s order.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_3'
),
  (
  'mcq',
  'math',
  'A florist creates bouquets that contain at least 12 flowers but no more than 18 flowers. Which of the following could be the total number of flowers in 6 bouquets?',
  '[{"id":"a","text":"65"},{"id":"b","text":"80"},{"id":"c","text":"110"},{"id":"d","text":"125"}]'::jsonb,
  'b',
  'To determine which of the provided options is a possible total, we need to establish the minimum and maximum boundaries for the total number of flowers in a set of 6 bouquets. We do this by applying the individual bouquet limits to the entire group.

If every bouquet contains the minimum number of flowers allowed, we multiply 6 bouquets by 12 flowers each, which equals a total of 72 flowers. This represents our lower boundary. If every bouquet contains the maximum number allowed, we multiply 6 bouquets by 18 flowers each, resulting in 108 flowers. This represents our upper boundary.

Any valid total must be a number between 72 and 108, inclusive. Comparing the options to this range, we see that 65 is too low and both 110 and 125 exceed the maximum. The value 80 is the only option that falls within the acceptable range of 72 to 108.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_4'
),
  (
  'mcq',
  'math',
  'Alice and Bob shared a 300-mile drive. Alice drove at an average speed of 55 mph and Bob at 60 mph. If they drove for a total time that was under 6 hours, which inequality represents the situation where $a$ is Alice''s hours and $b$ is Bob''s hours?',
  '[{"id":"a","text":"$55a + 60b < 300$"},{"id":"b","text":"$55a + 60b > 300$"},{"id":"c","text":"$a + b < 6$"},{"id":"d","text":"$a + b > 6$"}]'::jsonb,
  'c',
  'The problem provides information about speeds and distance, but it specifically asks for the inequality that represents the "total time" constraint. We are told that $a$ represents the number of hours Alice drove and $b$ represents the number of hours Bob drove.

The total time spent driving is simply the sum of the hours driven by each person, which is $a + b$. The problem states that this total time was "under 6 hours." In mathematical terms, "under" means strictly less than, so we use the $<$ symbol rather than the $≤$ symbol.

Therefore, the relationship for the time limit is expressed as $a + b < 6$. While the equation for the distance would be $55a + 60b = 300$, that equation describes the mileage rather than the specific time constraint requested by the question.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_5'
),
  (
  'mcq',
  'math',
  'Which point $(x, y)$ is a solution to the system of inequalities $y ≤ 2x + 4$ and $y ≥ -x + 1$?',
  '[{"id":"a","text":"$(0, 0)$"},{"id":"b","text":"$(0, 5)$"},{"id":"c","text":"$(2, 1)$"},{"id":"d","text":"$(-2, 5)$"}]'::jsonb,
  'c',
  'For a point to be a solution to a system of inequalities, the $(x, y)$ coordinates must make both inequality statements true at the same time. We can verify the correct option by substituting the values into each expression.

Let''s test the coordinates $(2, 1)$. For the first inequality, $y ≤ 2x + 4$, we substitute 2 for $x$ and 1 for $y$. This gives $1 ≤ 2(2) + 4$, which simplifies to $1 ≤ 8$. This is a true statement. Next, we test the same point in the second inequality, $y ≥ -x + 1$. Substituting the values gives $1 ≥ -(2) + 1$, which simplifies to $1 ≥ -1$. This is also a true statement.

Since both inequalities are satisfied by the point $(2, 1)$, it is a valid solution. In contrast, testing a point like $(0, 0)$ would fail the second inequality because 0 is not greater than or equal to 1. Similarly, $(0, 5)$ fails the first inequality because 5 is not less than or equal to 4.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_6'
),
  (
  'mcq',
  'math',
  'A mixture contains two types of nuts. Brand A is 20% peanuts and Brand B is 60% peanuts. A bowl contains at least 50 grams of peanuts. If $x$ is grams of Brand A and $y$ is grams of Brand B, which inequality represents this?',
  '[{"id":"a","text":"$0.2x + 0.6y ≥ 50$"},{"id":"b","text":"$20x + 60y ≥ 50$"},{"id":"c","text":"$0.2x + 0.6y ≤ 50$"},{"id":"d","text":"$x + y ≥ 50$"}]'::jsonb,
  'a',
  'To find the total mass of peanuts in the mixture, we need to calculate the peanut contribution from each brand separately. We do this by multiplying the total mass of each brand by its corresponding percentage of peanuts, expressed as a decimal.

Brand A consists of 20% peanuts, so for $x$ grams of Brand A, the amount of peanuts is $0.20x$. Brand B consists of 60% peanuts, so for $y$ grams of Brand B, the amount of peanuts is $0.60y$. Adding these together gives the total grams of peanuts in the bowl: $0.2x + 0.6y$.

The problem specifies that the bowl must contain "at least 50 grams" of peanuts. The phrase "at least" means the amount must be 50 grams or more, which we represent with the $≥$ symbol. Combining these parts results in the inequality $0.2x + 0.6y ≥ 50$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_7'
),
  (
  'mcq',
  'math',
  'A gym offers a monthly membership for 60. Non-members pay 7 per visit. What is the minimum number of visits per month for which the membership is cheaper than paying per visit?',
  '[{"id":"a","text":"7"},{"id":"b","text":"8"},{"id":"c","text":"9"},{"id":"d","text":"10"}]'::jsonb,
  'c',
  'To determine when the membership becomes a better financial choice, we need to find the point where the total cost of individual visits exceeds the flat monthly fee of 60. We can set up an inequality where $v$ represents the number of visits.

The cost for a non-member is 7 multiplied by the number of visits, or $7v$. We want to find when the membership cost is less than this variable cost: $60 < 7v$. To solve for $v$, we divide both sides of the inequality by 7, which gives us approximately $8.57 < v$.

Because you cannot visit the gym a fraction of a time, we must look for the smallest whole number that is greater than 8.57. That number is 9. At 8 visits, the cost would be 56, which is still cheaper than the membership. However, at 9 visits, the cost would be 63, making the 60 membership the cheaper option.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_8'
),
  (
  'mcq',
  'math',
  'A plumber charges a 50 call-out fee plus 80 per hour of work. A customer has a budget of 400. Which inequality shows the number of hours $h$ the plumber can work?',
  '[{"id":"a","text":"$50h + 80 ≤ 400$"},{"id":"b","text":"$50 + 80h ≤ 400$"},{"id":"c","text":"$130h ≤ 400$"},{"id":"d","text":"$50 + 80h ≥ 400$"}]'::jsonb,
  'b',
  'The total cost of hiring the plumber is made up of a fixed initial cost and a variable cost that depends on the duration of the job. The 50 call-out fee is a one-time charge applied at the start, regardless of how many hours are worked.

The variable cost is 80 for every hour $h$, which is expressed as $80h$. Summing these two parts gives the total cost formula: $50 + 80h$. The customer has a budget of 400, meaning the total cost cannot go over this amount. We use the "less than or equal to" symbol to represent this limit.

The final inequality that shows the constraint on the number of hours the plumber can work within the given budget is $50 + 80h ≤ 400$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_9'
),
  (
  'mcq',
  'math',
  'A fence is being built using panels that are between 6 and 8 feet long. If the total length of the fence is 96 feet, what is the maximum number of panels that could be used?',
  '[{"id":"a","text":"12"},{"id":"b","text":"14"},{"id":"c","text":"16"},{"id":"d","text":"18"}]'::jsonb,
  'c',
  'To find the maximum number of panels required to cover a fixed distance of 96 feet, we need to use the shortest possible panel length. Using shorter panels means more of them will be needed to span the same total distance.

The problem states that the panels can be as short as 6 feet. To calculate the number of these panels needed, we divide the total fence length of 96 feet by the length of one panel, which is 6 feet. Performing the division $96 / 6$ gives us a result of 16.

If we had used the longest panels (8 feet), we would have only needed 12 panels ($96 / 8 = 12$). Since the question asks for the maximum number of panels, we conclude that 16 is the correct answer.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_10'
),
  (
  'mcq',
  'math',
  'A local library buys books in bulk. Each box contains at least 15 books but no more than 22 books. If the library orders 7 boxes, which of the following could be the total number of books received?',
  '[{"id":"a","text":"100"},{"id":"b","text":"125"},{"id":"c","text":"160"},{"id":"d","text":"185"}]'::jsonb,
  'b',
  'To determine which total is possible, we first need to calculate the minimum and maximum boundaries for the total number of books in a shipment of 7 boxes. We do this by assuming every box contains either the fewest or the most books allowed.

If every box contains the minimum of 15 books, the total number of books would be $7 × 15$, which equals 105. This represents the lower limit of the possible range. If every box contains the maximum of 22 books, the total would be $7 × 22$, which equals 154. This represents the upper limit.

Therefore, any valid answer must be a value between 105 and 154, inclusive. Looking at the options provided, 100 is too small and 160 and 185 are too large. The value 125 is the only choice that falls within the established range of [105, 154].',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_11'
),
  (
  'mcq',
  'math',
  'A manufacturing plant uses two machines to produce components. Machine A produces 12 components per hour, and Machine B produces 15 components per hour. The plant manager wants to produce more than 150 components in a single shift. Which inequality represents the situation where $x$ is the hours Machine A runs and $y$ is the hours Machine B runs?',
  '[{"id":"a","text":"$12x + 15y > 150$"},{"id":"b","text":"$12x + 15y < 150$"},{"id":"c","text":"$27(x + y) > 150$"},{"id":"d","text":"$15x + 12y ≥ 150$"}]'::jsonb,
  'a',
  'The total production of the plant is the sum of the components produced by each individual machine. To find the production for each machine, we multiply its hourly rate by the number of hours it is operational.

For Machine A, the production is 12 components per hour multiplied by $x$ hours, which is $12x$. For Machine B, the production is 15 components per hour multiplied by $y$ hours, which is $15y$. The total production for the shift is the sum of these two values, represented by the expression $12x + 15y$.

The manager''s goal is to produce "more than 150 components." In mathematics, the phrase "more than" translates to a strict inequality using the "greater than" symbol ($>$). This means 150 itself is not a sufficient total; it must be exceeded. Combining these elements, we get the final inequality $12x + 15y > 150$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_12'
),
  (
  'mcq',
  'math',
  'A gardener is mixing two types of fertilizer. Fertilizer X is 5% nitrogen by weight, and Fertilizer Y is 12% nitrogen by weight. The gardener needs the final mixture to contain at least 10 pounds of nitrogen. If $x$ is the weight of Fertilizer X and $y$ is the weight of Fertilizer Y, which inequality represents this requirement?',
  '[{"id":"a","text":"$5x + 12y ≥ 10$"},{"id":"b","text":"$0.05x + 0.12y ≤ 10$"},{"id":"c","text":"$0.05x + 0.12y ≥ 10$"},{"id":"d","text":"$0.5x + 1.2y ≥ 10$"}]'::jsonb,
  'c',
  'To represent the amount of nitrogen in the mixture, we must calculate the contribution from each type of fertilizer based on its concentration. Concentration percentages must be converted to decimals before they can be used in an algebraic expression.

Fertilizer X is 5% nitrogen, which is $0.05$ as a decimal. Multiplying this by the total weight $x$ gives $0.05x$ pounds of nitrogen. Fertilizer Y is 12% nitrogen, which is $0.12$ as a decimal. Multiplying this by the total weight $y$ gives $0.12y$ pounds of nitrogen. The total weight of nitrogen in the mixture is $0.05x + 0.12y$.

The requirement is to have "at least 10 pounds" of nitrogen. "At least" means that the amount can be exactly 10 or anything greater than 10. We use the "greater than or equal to" symbol ($≥$) to denote this. Thus, the inequality is $0.05x + 0.12y ≥ 10$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_004_13'
),
  (
  'mcq',
  'math',
  'A parking garage charges 5 for the first hour and 3 for each additional hour. A driver has 20 to spend on parking. Which inequality represents the total number of hours $h$ the driver can park?',
  '[{"id":"a","text":"$5 + 3h ≤ 20$"},{"id":"b","text":"$5 + 3(h - 1) ≤ 20$"},{"id":"c","text":"$8h ≤ 20$"},{"id":"d","text":"$5h + 3 ≤ 20$"}]'::jsonb,
  'b',
  'Calculating the cost for this parking garage requires careful attention to how the hours are billed. The first hour has a unique flat rate of 5. Every hour after that first one costs 3.

If $h$ represents the total number of hours parked, then the number of "additional" hours is $(h - 1)$. We multiply these additional hours by the rate of 3, giving us $3(h - 1)$. We then add the cost of the very first hour to this amount to get the total cost expression: $5 + 3(h - 1)$.

Since the driver''s budget is limited to 20, the total cost must be less than or equal to 20. This leads to the inequality $5 + 3(h - 1) ≤ 20$. This structure ensures that the 5 is only charged once and the 3 rate only applies to time spent after the first hour.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_14'
),
  (
  'mcq',
  'math',
  'Which point $(x, y)$ is a solution to the system $y < -2x + 5$ and $y > x - 1$?',
  '[{"id":"a","text":"(0, 0)"},{"id":"b","text":"(3, 0)"},{"id":"c","text":"(0, 6)"},{"id":"d","text":"(2, 2)"}]'::jsonb,
  'a',
  'To find the solution to a system of inequalities, we must identify a point that satisfies both conditions simultaneously. We can test the options by plugging the $x$ and $y$ values into both inequalities to see if they produce true statements.

Let''s test the point (0, 0). For the first inequality, $y < -2x + 5$, we substitute 0 for $x$ and 0 for $y$: $0 < -2(0) + 5$, which simplifies to $0 < 5$. This is true. For the second inequality, $y > x - 1$, we substitute the values again: $0 > 0 - 1$, which simplifies to $0 > -1$. This is also true.

Since (0, 0) makes both inequalities true, it is a solution to the system. If we tested (3, 0), the first inequality would be $0 < -2(3) + 5$, which is $0 < -1$, a false statement. Therefore, (3, 0) is not a solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_15'
),
  (
  'mcq',
  'math',
  'A contractor is ordering planks of wood that are between 8 and 10 feet long. If the contractor needs to cover a total span of 120 feet by laying planks end-to-end, what is the minimum number of planks needed?',
  '[{"id":"a","text":"10"},{"id":"b","text":"12"},{"id":"c","text":"15"},{"id":"d","text":"20"}]'::jsonb,
  'b',
  'To find the minimum number of planks required to cover a fixed distance of 120 feet, we should use the longest individual planks available. Using longer planks means that each single unit covers more ground, thereby reducing the total count required.

The longest plank available is 10 feet. To calculate how many of these we need, we divide the total span of 120 feet by the length of one plank: $120 / 10$. This results in exactly 12 planks.

If we had used the shortest planks (8 feet), we would have needed more of them: $120 / 8 = 15$ planks. Since the question specifically asks for the minimum number, 12 is the correct answer.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_16'
),
  (
  'mcq',
  'math',
  'A store owner is buying two types of light bulbs. Type A bulbs cost 4 each and Type B bulbs cost 6 each. The owner must buy at least 50 bulbs total but cannot spend more than 400. Which system of inequalities represents this, where $a$ is the number of Type A bulbs and $b$ is the number of Type B bulbs?',
  '[{"id":"a","text":"$a + b ≥ 50$; $4a + 6b ≤ 400$"},{"id":"b","text":"$a + b ≤ 50$; $4a + 6b ≤ 400$"},{"id":"c","text":"$a + b ≥ 50$; $4a + 6b ≥ 400$"},{"id":"d","text":"$4a + 6b ≤ 50$; $a + b ≥ 400$"}]'::jsonb,
  'a',
  'We are dealing with two separate constraints: one for the quantity of items and one for the total cost. Let''s build each inequality one at a time.

The quantity constraint states that the owner must buy "at least 50 bulbs total." The total number of bulbs is the sum of Type A ($a$) and Type B ($b$). "At least" means 50 or more, so we write $a + b ≥ 50$.

The cost constraint involves the price of each bulb. Type A bulbs contribute $4a$ to the total cost, and Type B bulbs contribute $6b$. The sum $4a + 6b$ represents the total expenditure. Since the owner "cannot spend more than 400," the total must be less than or equal to 400. This is written as $4a + 6b ≤ 400$. Combining these two gives the correct system.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_17'
),
  (
  'mcq',
  'math',
  'A car rental agency offers a deal: 150 for the week with the first 200 miles free, and 0.25 for every mile driven over 200. If a customer wants to spend at most 250, which inequality represents the number of miles $m$ they can drive, assuming $m > 200$?',
  '[{"id":"a","text":"$150 + 0.25m ≤ 250$"},{"id":"b","text":"$150 + 0.25(m - 200) ≤ 250$"},{"id":"c","text":"$150 + 200(m - 0.25) ≤ 250$"},{"id":"d","text":"$0.25(m + 200) ≤ 250$"}]'::jsonb,
  'b',
  'To find the correct inequality, we must model the cost structure accurately. There is a base fee of 150 that the customer pays regardless of mileage. This fee includes the first 200 miles at no extra charge.

The extra charge only applies to the miles driven beyond the initial 200. If the total miles driven is $m$, the number of miles that incur a fee is $(m - 200)$. Each of these additional miles costs 0.25, so the total mileage surcharge is $0.25(m - 200)$. We add this to the base fee to get the total cost: $150 + 0.25(m - 200)$.

The customer wants to spend "at most" 250. This means the total cost must be less than or equal to 250. This gives us the final inequality $150 + 0.25(m - 200) ≤ 250$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_18'
),
  (
  'mcq',
  'math',
  'A solution is made by mixing two liquids. Liquid A is 30% alcohol and Liquid B is 70% alcohol. The final mixture must be at least 40 liters and must contain no more than 20 liters of alcohol. Which system represents this, where $a$ is liters of Liquid A and $b$ is liters of Liquid B?',
  '[{"id":"a","text":"$a + b ≥ 40$; $0.3a + 0.7b ≤ 20$"},{"id":"b","text":"$a + b ≤ 40$; $0.3a + 0.7b ≥ 20$"},{"id":"c","text":"$a + b ≥ 40$; $30a + 70b ≤ 20$"},{"id":"d","text":"$0.3a + 0.7b ≥ 40$; $a + b ≤ 20$"}]'::jsonb,
  'a',
  'We have two constraints here: the total volume of the mixture and the specific amount of alcohol within that volume.

The volume constraint is straightforward. The total liters $a + b$ must be "at least 40," which means 40 or more. This gives us $a + b ≥ 40$.

The alcohol constraint requires us to look at the concentrations. Liquid A contributes $0.30a$ liters of alcohol, and Liquid B contributes $0.70b$ liters of alcohol. The sum of these, $0.3a + 0.7b$, represents the total alcohol in the mixture. The problem states this total must be "no more than 20 liters," which translates to less than or equal to 20. Thus, $0.3a + 0.7b ≤ 20$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_004_19'
),
  (
  'mcq',
  'math',
  'An athlete wants to burn at least 600 calories during a workout. Running burns 12 calories per minute, and cycling burns 8 calories per minute. If $r$ is the minutes spent running and $c$ is the minutes spent cycling, which inequality represents the goal?',
  '[{"id":"a","text":"$12r + 8c ≤ 600$"},{"id":"b","text":"$12r + 8c ≥ 600$"},{"id":"c","text":"$20(r + c) ≥ 600$"},{"id":"d","text":"$8r + 12c ≥ 600$"}]'::jsonb,
  'b',
  'To reach the calorie goal, the sum of the calories burned from both activities must meet or exceed 600. We calculate the calories for each activity by multiplying the rate of calorie burn by the time spent on that activity.

For running, the burn is 12 calories per minute. Over $r$ minutes, this is $12r$ calories. For cycling, the burn is 8 calories per minute. Over $c$ minutes, this is $8c$ calories. The total calories burned is $12r + 8c$.

The athlete wants to burn "at least 600" calories. "At least" indicates that 600 is the minimum acceptable amount, so the total should be greater than or equal to 600. This is written as $12r + 8c ≥ 600$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_20'
),
  (
  'mcq',
  'math',
  'A person is buying a combination of 5 notebooks and 2 pens. They want to spend more than 20 but no more than 50. Which system represents the possible number of notebooks $n$ and pens $p$?',
  '[{"id":"a","text":"$5n + 2p > 20$; $5n + 2p ≤ 50$"},{"id":"b","text":"$5n + 2p < 20$; $5n + 2p ≥ 50$"},{"id":"c","text":"$n + p > 20$; $n + p ≤ 50$"},{"id":"d","text":"$5n + 2p ≥ 20$; $5n + 2p < 50$"}]'::jsonb,
  'a',
  'The total cost of the purchase is determined by the price of each item multiplied by the quantity bought. Notebooks cost 5 each, so $n$ notebooks cost $5n$. Pens cost 2 each, so $p$ pens cost $2p$. The total cost expression is $5n + 2p$.

We are given a range for the total spending. First, the cost must be "more than 20." This is a strict inequality, so we use $5n + 2p > 20$. Second, the cost must be "no more than 50." This means it can be exactly 50 or anything less, so we use $5n + 2p ≤ 50$.

Together, these two inequalities define the allowed spending region for the customer.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_21'
),
  (
  'mcq',
  'math',
  'A taxi service charges 4.00 to start the ride and 2.50 per mile. If a passenger has a maximum of 24 to spend, what is the maximum number of miles $m$ they can travel?',
  '[{"id":"a","text":"6 miles"},{"id":"b","text":"8 miles"},{"id":"c","text":"10 miles"},{"id":"d","text":"12 miles"}]'::jsonb,
  'b',
  'We start by setting up an inequality to represent the passenger''s budget. The total cost of the taxi ride is the flat starting fee plus the mileage rate. The expression for the cost is $4 + 2.5m$.

Since the passenger can spend a maximum of 24, we set the cost to be less than or equal to 24: $4 + 2.5m ≤ 24$. To solve for $m$, we first subtract the flat fee of 4 from both sides, leaving $2.5m ≤ 20$.

Next, we divide both sides by 2.5. $20 / 2.5$ is the same as $200 / 25$, which equals 8. This tells us the passenger can travel a maximum of 8 miles without exceeding their 24 budget.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_22'
),
  (
  'mcq',
  'math',
  'Which point lies in the solution set of $y ≤ -x + 10$, $y ≥ 2$, and $x ≥ 5$?',
  '[{"id":"a","text":"(4, 4)"},{"id":"b","text":"(6, 1)"},{"id":"c","text":"(6, 3)"},{"id":"d","text":"(11, 2)"}]'::jsonb,
  'c',
  'To be in the solution set, a point must satisfy three separate conditions simultaneously. Let''s evaluate the options against these rules.

First, check (6, 3):

1. Is $x ≥ 5$? Since 6 is greater than 5, this is true.

2. Is $y ≥ 2$? Since 3 is greater than 2, this is true.

3. Is $y ≤ -x + 10$? Substituting the values gives $3 ≤ -6 + 10$, which simplifies to $3 ≤ 4$. This is also true.

Because (6, 3) satisfies all three inequalities, it is the correct answer. In contrast, (4, 4) fails the $x ≥ 5$ check, (6, 1) fails the $y ≥ 2$ check, and (11, 2) fails the $y ≤ -x + 10$ check because 2 is not less than or equal to $-1$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_004_23'
),
  (
  'mcq',
  'math',
  'A cell phone plan costs 30 per month plus 0.10 per text message sent. Another plan costs 50 per month for unlimited texting. For what number of text messages $t$ is the second plan cheaper?',
  '[{"id":"a","text":"$t > 200$"},{"id":"b","text":"$t < 200$"},{"id":"c","text":"$t > 500$"},{"id":"d","text":"$t < 500$"}]'::jsonb,
  'a',
  'We want to find when the cost of the first plan exceeds the flat cost of the second plan. The cost of the first plan is 30 plus 0.10 for every text $t$, which is written as $30 + 0.10t$. The cost of the second plan is simply 50.

We set up the inequality where the first plan is more expensive: $30 + 0.10t > 50$. To solve for $t$, we first subtract 30 from both sides, which gives $0.10t > 20$.

Now, divide both sides by 0.10. Dividing by 0.10 is the same as multiplying by 10. $20 × 10 = 200$. Therefore, if you send more than 200 text messages, the second plan becomes the cheaper option.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_24'
),
  (
  'mcq',
  'math',
  'A theater has two types of seats: floor seats for 40 and balcony seats for 25. The theater wants to make at least 2,000 from a show. Which inequality represents the number of floor seats $f$ and balcony seats $b$ they need to sell?',
  '[{"id":"a","text":"$40f + 25b ≥ 2,000$"},{"id":"b","text":"$40f + 25b ≤ 2,000$"},{"id":"c","text":"$65(f + b) ≥ 2,000$"},{"id":"d","text":"$25f + 40b ≥ 2,000$"}]'::jsonb,
  'a',
  'The total revenue from the show is the sum of the money made from each seating section. For floor seats, the revenue is the price (40) times the number sold ($f$), which is $40f$. For balcony seats, it is the price (25) times the number sold ($b$), which is $25b$.

The theater''s goal is to make "at least 2,000." "At least" indicates that the revenue should be 2,000 or any amount higher than that. This is represented by the "greater than or equal to" symbol ($≥$).

Combining these expressions gives us the inequality $40f + 25b ≥ 2,000$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_25'
),
  (
  'mcq',
  'math',
  'What is the slope of the line given by the equation $2x - 3y = 9$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"-3"},{"id":"c","text":"2/3"},{"id":"d","text":"-2/3"}]'::jsonb,
  'c',
  'To find the slope of a line written in standard form ($Ax + By = C$), it is usually easiest to rearrange the equation into slope-intercept form ($y = mx + b$). In this form, the coefficient $m$ represents the slope.

Starting with $2x - 3y = 9$, we first isolate the $y$-term by subtracting $2x$ from both sides of the equation. This gives us $-3y = -2x + 9$.

Next, we solve for $y$ by dividing every term by -3. This results in $y = (-2/-3)x + (9/-3)$, which simplifies to $y = (2/3)x - 3$. Looking at the coefficient of $x$, we can see that the slope of the line is 2/3.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_26'
),
  (
  'mcq',
  'math',
  'A line passes through the point (4, -1) and has a slope of -2. What is the y-intercept of the line?',
  '[{"id":"a","text":"7"},{"id":"b","text":"-9"},{"id":"c","text":"9"},{"id":"d","text":"-7"}]'::jsonb,
  'a',
  'We can find the y-intercept ($b$) by using the slope-intercept equation $y = mx + b$ and substituting the known values for the slope and the coordinates of the given point.

The problem tells us that the slope $m$ is -2. The point (4, -1) gives us an $x$ value of 4 and a $y$ value of -1. Substituting these into the equation, we get: $-1 = -2(4) + b$.

Simplifying the multiplication, we have $-1 = -8 + b$. To solve for $b$, we add 8 to both sides of the equation, which results in $7 = b$. Therefore, the y-intercept of the line is 7.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_27'
),
  (
  'mcq',
  'math',
  'Which of the following lines is parallel to the line $y = 4x - 5$?',
  '[{"id":"a","text":"$y = -4x + 5$"},{"id":"b","text":"$y = (1/4)x - 5$"},{"id":"c","text":"$4x - y = 10$"},{"id":"d","text":"$x + 4y = 8$"}]'::jsonb,
  'c',
  'Parallel lines are defined by having identical slopes but different y-intercepts. The given line is $y = 4x - 5$, which has a slope of 4. We need to find which of the options also has a slope of 4.

Let''s check the third option: $4x - y = 10$. To find its slope, we can rearrange it into $y = mx + b$ form. Subtracting $4x$ from both sides gives $-y = -4x + 10$. Multiplying the entire equation by -1 to solve for $y$ gives $y = 4x - 10$.

This line has a slope of 4, which matches our original line. Therefore, it is parallel. The other options have slopes of -4, 1/4, and -1/4, respectively, so they are not parallel.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_28'
),
  (
  'mcq',
  'math',
  'What is the x-intercept of the line $3x + 2y = 12$?',
  '[{"id":"a","text":"(0, 6)"},{"id":"b","text":"(4, 0)"},{"id":"c","text":"(6, 0)"},{"id":"d","text":"(0, 4)"}]'::jsonb,
  'b',
  'The x-intercept of a line is the point where it crosses the x-axis. At this specific point, the y-coordinate must be zero. We can find the x-coordinate by substituting $y = 0$ into the equation and solving for $x$.

Starting with $3x + 2y = 12$, we substitute 0 for $y$: $3x + 2(0) = 12$. This simplifies to $3x = 12$. Dividing both sides by 3 gives $x = 4$.

Since the x-coordinate is 4 and the y-coordinate is 0, the x-intercept is written as the ordered pair (4, 0).',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_29'
),
  (
  'mcq',
  'math',
  'A line passes through the points (2, 5) and (6, 13). What is the slope of the line?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"1/2"},{"id":"d","text":"8"}]'::jsonb,
  'a',
  'The slope ($m$) of a line passing through two points $(x_1, y_1)$ and $(x_2, y_2)$ is calculated using the rise-over-run formula: $m = (y_2 - y_1) / (x_2 - x_1)$.

Using our given points, we identify $x_1 = 2, y_1 = 5$ and $x_2 = 6, y_2 = 13$. Plugging these into the formula, we get: $m = (13 - 5) / (6 - 2)$.

Subtracting the values in the numerator and denominator gives $m = 8 / 4$. Simplifying this fraction, we find that the slope is 2.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_30'
),
  (
  'mcq',
  'math',
  'Which of the following is the equation of a line that is perpendicular to $y = -3x + 2$?',
  '[{"id":"a","text":"$y = -3x - 2$"},{"id":"b","text":"$y = 3x + 2$"},{"id":"c","text":"$y = (1/3)x + 5$"},{"id":"d","text":"$y = -(1/3)x + 5$"}]'::jsonb,
  'c',
  'Perpendicular lines have slopes that are negative reciprocals of each other. This means if you multiply their slopes together, the result is -1. The slope of our original line is -3.

To find the negative reciprocal of -3, we first take the reciprocal, which is -1/3, and then change the sign. This gives us a perpendicular slope of +1/3.

Looking at the options, the third choice $y = (1/3)x + 5$ is the only one with a slope of 1/3. Therefore, this is the line perpendicular to the original.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_31'
),
  (
  'mcq',
  'math',
  'What is the equation of a horizontal line that passes through the point (5, -7)?',
  '[{"id":"a","text":"$x = 5$"},{"id":"b","text":"$y = 5$"},{"id":"c","text":"$x = -7$"},{"id":"d","text":"$y = -7$"}]'::jsonb,
  'd',
  'Horizontal lines have a slope of zero and stay at a constant height regardless of the x-value. Because the height (the y-value) never changes, the equation of any horizontal line is simply $y = k$, where $k$ is the y-coordinate of every point on that line.

Since the line must pass through (5, -7), we look at the y-coordinate of that point, which is -7. This means every point on the line must have a y-value of -7. Thus, the equation of the line is $y = -7$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_32'
),
  (
  'mcq',
  'math',
  'A line in the xy-plane passes through the origin and has a slope of 3/4. Which of the following points also lies on this line?',
  '[{"id":"a","text":"(3, 4)"},{"id":"b","text":"(4, 3)"},{"id":"c","text":"(0, 3)"},{"id":"d","text":"(4, 0)"}]'::jsonb,
  'b',
  'A line that passes through the origin (0, 0) has a y-intercept of zero. Therefore, its equation can be written in the form $y = mx$. Given the slope of 3/4, the equation for this specific line is $y = (3/4)x$.

To find which point lies on the line, we can substitute the x-value of each option into our equation and see if it produces the corresponding y-value. Let''s test the point (4, 3).

If we plug in $x = 4$, we get $y = (3/4) × 4$, which simplifies to $y = 3$. Since this matches the y-coordinate of the point (4, 3), that point must lie on the line.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_33'
),
  (
  'mcq',
  'math',
  'What is the slope of a line that is perpendicular to the x-axis?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"-1"},{"id":"d","text":"Undefined"}]'::jsonb,
  'd',
  'A line that is perpendicular to the x-axis is a vertical line. Vertical lines go straight up and down, meaning that for any two points on the line, the x-coordinate stays exactly the same while the y-coordinate changes.

When we try to calculate the slope using the formula $m = (y_2 - y_1) / (x_2 - x_1)$, the denominator $(x_2 - x_1)$ will be zero because the x-values are identical. In mathematics, division by zero is not allowed and is described as being undefined. Therefore, the slope of a vertical line is undefined.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_34'
),
  (
  'mcq',
  'math',
  'The line $L$ contains the points (1, 2) and (3, 10). Which of the following is an equation for line $L$?',
  '[{"id":"a","text":"$y = 4x - 2$"},{"id":"b","text":"$y = 4x + 2$"},{"id":"c","text":"$y = 2x + 4$"},{"id":"d","text":"$y = 8x - 6$"}]'::jsonb,
  'a',
  'First, we calculate the slope of the line using the two points provided. The change in $y$ is $10 - 2 = 8$, and the change in $x$ is $3 - 1 = 2$. The slope $m$ is $8 / 2$, which equals 4.

Next, we use the slope-intercept form $y = mx + b$ to find the y-intercept. We can plug in the slope (4) and the coordinates of one of our points, such as (1, 2). This gives us $2 = 4(1) + b$.

Simplifying the equation, we have $2 = 4 + b$. Subtracting 4 from both sides results in $b = -2$. Combining the slope and the y-intercept, the equation for the line is $y = 4x - 2$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_004_35'
),
  (
  'mcq',
  'math',
  'Which of the following lines has a slope of 0?',
  '[{"id":"a","text":"$x = 2$"},{"id":"b","text":"$y = 2$"},{"id":"c","text":"$y = x$"},{"id":"d","text":"$x + y = 0$"}]'::jsonb,
  'b',
  'A slope of 0 indicates that a line is perfectly horizontal. In a horizontal line, the y-value stays constant no matter what the x-value is. Such lines always have equations in the form $y = k$, where $k$ is a constant number.

Looking at the options, $y = 2$ is the only equation where $y$ is set to a constant value and does not depend on $x$. In contrast, $x = 2$ is a vertical line (undefined slope), $y = x$ has a slope of 1, and $x + y = 0$ (which is $y = -x$) has a slope of -1.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_36'
),
  (
  'mcq',
  'math',
  'What is the y-intercept of the line $y - 4 = 3(x + 2)$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"10"},{"id":"c","text":"-2"},{"id":"d","text":"6"}]'::jsonb,
  'b',
  'To find the y-intercept of a line given in point-slope form, we can either rearrange the equation into $y = mx + b$ form or simply substitute $x = 0$ and solve for $y$. Let''s use the substitution method.

Plugging in $x = 0$ gives us $y - 4 = 3(0 + 2)$. Simplifying inside the parentheses results in $y - 4 = 3(2)$, which is $y - 4 = 6$.

To isolate $y$, we add 4 to both sides of the equation. This gives us $y = 10$. Therefore, the line crosses the y-axis at the point where $y = 10$, making 10 the y-intercept.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_37'
),
  (
  'mcq',
  'math',
  'A line passes through (1, 5) and is parallel to the x-axis. What is its equation?',
  '[{"id":"a","text":"$x = 1$"},{"id":"b","text":"$y = 1$"},{"id":"c","text":"$x = 5$"},{"id":"d","text":"$y = 5$"}]'::jsonb,
  'd',
  'A line that is parallel to the x-axis must be a horizontal line. Horizontal lines have a constant y-value. This means that no matter where you move along the line, the height (the y-coordinate) remains exactly the same.

Since the line passes through the point (1, 5), its y-coordinate is 5. For the line to stay horizontal, every single point on it must have a y-coordinate of 5. Therefore, the equation that describes this line is $y = 5$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_38'
),
  (
  'mcq',
  'math',
  'If a line $y = mx + b$ passes through (2, 4) and (5, 4), what is the value of $m$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"3"},{"id":"c","text":"1"},{"id":"d","text":"Undefined"}]'::jsonb,
  'a',
  'We can find the slope $m$ by looking at the coordinates of the two points. Notice that the y-coordinate is 4 for both points. This means there is no "rise" or vertical change as we move from the first point to the second.

Using the slope formula: $m = (4 - 4) / (5 - 2)$, which simplifies to $m = 0 / 3$. Any fraction with zero in the numerator and a non-zero number in the denominator is equal to zero. This tells us the line is horizontal and has a slope of 0.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_004_39'
),
  (
  'mcq',
  'math',
  'What is the slope of the line $x = -4$?',
  '[{"id":"a","text":"-4"},{"id":"b","text":"0"},{"id":"c","text":"1"},{"id":"d","text":"Undefined"}]'::jsonb,
  'd',
  'The equation $x = -4$ represents a vertical line where every point has an x-coordinate of -4. Vertical lines do not have a "run" because the x-value never changes.

In the slope formula $m = \\text{rise} / \\text{run}$, the "run" (the change in $x$) would be zero. Since we cannot divide by zero, the slope of any vertical line is not a real number and is described as being undefined.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_40'
),
  (
  'mcq',
  'math',
  'A line has a y-intercept of 3 and an x-intercept of -3. What is its slope?',
  '[{"id":"a","text":"1"},{"id":"b","text":"-1"},{"id":"c","text":"3"},{"id":"d","text":"0"}]'::jsonb,
  'a',
  'The y-intercept of 3 corresponds to the point (0, 3), and the x-intercept of -3 corresponds to the point (-3, 0). We can use these two points to calculate the slope of the line.

Using the formula $m = (y_2 - y_1) / (x_2 - x_1)$, we get: $m = (0 - 3) / (-3 - 0)$. This simplifies to $m = -3 / -3$. Since any non-zero number divided by itself is 1, the slope of the line is 1.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_41'
),
  (
  'mcq',
  'math',
  'Which of the following is an equation of a line with a slope of -1/2 that passes through the origin?',
  '[{"id":"a","text":"$y = -2x$"},{"id":"b","text":"$x + 2y = 0$"},{"id":"c","text":"$2x + y = 0$"},{"id":"d","text":"$y = 2x$"}]'::jsonb,
  'b',
  'A line that passes through the origin has a y-intercept of 0, so its equation in $y = mx + b$ form is simply $y = mx$. Given a slope of -1/2, the equation is $y = -1/2x$.

To find which option matches this, we can try to rearrange them. Let''s look at the second option: $x + 2y = 0$. If we subtract $x$ from both sides, we get $2y = -x$. Dividing both sides by 2 gives us $y = -1/2x$, which matches our target equation.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_42'
),
  (
  'mcq',
  'math',
  'A line passes through (2, 3) and (2, 7). What is the equation of this line?',
  '[{"id":"a","text":"$y = 3$"},{"id":"b","text":"$x = 2$"},{"id":"c","text":"$y = 2x - 1$"},{"id":"d","text":"$y = 5$"}]'::jsonb,
  'b',
  'Notice that for both points given, the x-coordinate is exactly the same value: 2. This tells us that the line is vertical, as it does not move left or right at all between these two points.

Vertical lines are always written in the form $x = k$, where $k$ is the constant x-coordinate. Since $x$ is always 2 for every point on this line, the equation must be $x = 2$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_43'
),
  (
  'mcq',
  'math',
  'What is the slope of a line parallel to $2x + y = 4$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"-2"},{"id":"c","text":"1/2"},{"id":"d","text":"-1/2"}]'::jsonb,
  'b',
  'Parallel lines must have the same slope. To find the slope of the line $2x + y = 4$, we can solve the equation for $y$ to put it in slope-intercept form.

Subtracting $2x$ from both sides gives us $y = -2x + 4$. In this form, we can see that the slope is -2. Any line parallel to this one must also have a slope of -2.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_44'
),
  (
  'mcq',
  'math',
  'A line has the equation $y = 5$. What is its slope?',
  '[{"id":"a","text":"5"},{"id":"b","text":"1"},{"id":"c","text":"0"},{"id":"d","text":"Undefined"}]'::jsonb,
  'c',
  'The equation $y = 5$ represents a horizontal line where every point has a y-coordinate of 5. Because the y-value never changes, there is no vertical "rise."

In the slope formula, the numerator (change in $y$) will be zero. Zero divided by any non-zero change in $x$ results in zero. Therefore, all horizontal lines have a slope of 0.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_45'
),
  (
  'mcq',
  'math',
  'A line passes through (-1, 4) and (2, -2). What is the y-intercept of this line?',
  '[{"id":"a","text":"2"},{"id":"b","text":"-2"},{"id":"c","text":"4"},{"id":"d","text":"0"}]'::jsonb,
  'a',
  'First, we find the slope $m = (-2 - 4) / (2 - (-1)) = -6 / 3 = -2$.

Next, we use the equation $y = mx + b$ with the point (-1, 4) to solve for $b$. Substituting the values gives $4 = -2(-1) + b$, which simplifies to $4 = 2 + b$.

Subtracting 2 from both sides gives $b = 2$. Therefore, the y-intercept of the line is 2.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_004_46'
),
  (
  'mcq',
  'math',
  'Which of the following is an equation of a line with an undefined slope?',
  '[{"id":"a","text":"$y = 0$"},{"id":"b","text":"$x = 0$"},{"id":"c","text":"$y = x$"},{"id":"d","text":"$x + y = 1$"}]'::jsonb,
  'b',
  'An undefined slope only occurs for vertical lines. Vertical lines are written in the form $x = k$.

Looking at the choices, $x = 0$ is a vertical line (it is actually the y-axis). Its slope is undefined because there is no change in $x$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_47'
),
  (
  'mcq',
  'math',
  'What is the slope of the line $y = x$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"-1"},{"id":"d","text":"Undefined"}]'::jsonb,
  'b',
  'In the equation $y = x$, the coefficient of $x$ is an invisible 1. This means the equation can be written as $y = 1x + 0$.

The slope is the coefficient of $x$, which is 1. This means for every 1 unit you move to the right, you move 1 unit up.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_004_48'
),
  (
  'mcq',
  'math',
  'A line passes through (3, 2) and (6, 2). What is the equation of this line?',
  '[{"id":"a","text":"$x = 3$"},{"id":"b","text":"$y = 2$"},{"id":"c","text":"$y = x - 1$"},{"id":"d","text":"$x = 2$"}]'::jsonb,
  'b',
  'Since the y-coordinate is 2 for both points, the line is horizontal. Horizontal lines are written in the form $y = k$.

The constant y-value for this line is 2, so the equation is $y = 2$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_004_49'
),
  (
  'mcq',
  'math',
  'The line $y = 2x + b$ passes through (1, 5). What is the x-intercept of the line?',
  '[{"id":"a","text":"-1.5"},{"id":"b","text":"3"},{"id":"c","text":"-3"},{"id":"d","text":"1.5"}]'::jsonb,
  'a',
  'First, find $b$ by plugging in the point (1, 5): $5 = 2(1) + b → b = 3$. The equation is $y = 2x + 3$.

To find the x-intercept, set $y = 0$: $0 = 2x + 3 → -3 = 2x → x = -1.5$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_004_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

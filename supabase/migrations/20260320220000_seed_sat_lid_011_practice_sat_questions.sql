-- Practice-mode math from lid_011.tex (sat_lid_011)
-- Chapter: Linear inequalities in one or two variables | Topic: Systems of Inequalities
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_011_N, practice module/set 0.
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
  'A local shipping service charges 18.50 for any package weighing 5 pounds or less. For packages weighing more than 5 pounds, the service charges 18.50 plus an additional 2.25 per pound for each pound over 5. Which inequality represents the weight $w$, in pounds, of a package for which the total shipping charge is at least 32.00?',
  '[{"id":"a","text":"$18.50 + 2.25(w - 5) \\\\ge 32.00$"},{"id":"b","text":"$18.50 + 2.25w \\\\ge 32.00$"},{"id":"c","text":"$18.50 + 2.25(w + 5) \\\\ge 32.00$"},{"id":"d","text":"$2.25(w - 5) \\\\ge 32.00$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The base price applies to the first 5 pounds. The additional rate only applies to the "excess" weight, which is the total weight $w$ minus the initial 5 pounds. "At least" indicates $\\ge$.

\\textbf{Calculation and Logic:}

Base cost = 18.50

Additional cost = $2.25 × (w - 5)$

Total must be $\\ge 32.00$.

Inequality: $18.50 + 2.25(w - 5) \\ge 32.00$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_1'
),
  (
  'mcq',
  'math',
  'A baker needs at least 45 cups of flour for a large order. If each bag of flour contains 8 cups, what is the minimum number of bags, $b$, the baker must purchase?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"7"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In SAT "minimum purchase" problems, you must round up to the nearest whole number because you cannot buy a fraction of a bag.

\\textbf{Calculation and Logic:}

$8b \\ge 45$

$b \\ge 5.625$

Since $b$ must be an integer, the smallest value is 6.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_011_2'
),
  (
  'mcq',
  'math',
  'The table below shows the cost of data roaming for a mobile plan. \\begin{center} \\begin{tabular}{|c|c|} \\hline \\textbf{Data Used ($d$)} & \\textbf{Cost} \\hline $0 < d \\le 500$ MB & 10.00 \\hline $500 < d \\le 1000$ MB & 18.00 \\hline $1000 < d \\le 2000$ MB & 30.00 \\hline \\end{tabular} \\end{center} A user paid 18.00 for roaming. If they had used 1 MB more, they would have paid 30.00. Which of the following could be the amount of data the user used?',
  '[{"id":"a","text":"499 MB"},{"id":"b","text":"500 MB"},{"id":"c","text":"999 MB"},{"id":"d","text":"1000 MB"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The user is at a "boundary" where adding the smallest possible increment (1 MB) jumps them into the next price tier.

\\textbf{Calculation and Logic:}

The transition from 18 to 30 occurs right after 1000 MB.

If the user had exactly 1000 MB, they stay in the 18 tier.

If they add 1 MB (1001 MB), they enter the 30 tier.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_3'
),
  (
  'mcq',
  'math',
  'A certain species of bamboo grows more than 15 but less than 24 inches per day. If a bamboo stalk is currently 40 inches tall, which of the following inequalities represents all possible heights $h$, in inches, the stalk could be 5 days from now?',
  '[{"id":"a","text":"$75 < h < 120$"},{"id":"b","text":"$115 < h < 160$"},{"id":"c","text":"$115 \\\\le h \\\\le 160$"},{"id":"d","text":"$40 < h < 160$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This is a range problem. We calculate the minimum possible growth and the maximum possible growth over the 5-day period and add them to the initial height.

\\textbf{Calculation and Logic:}

Initial height = 40

Min growth = $5 × 15 = 75$

Max growth = $5 × 24 = 120$

Min total = $40 + 75 = 115$

Max total = $40 + 120 = 160$

Since the growth is "more than" and "less than," we use strict inequalities ($<$).',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_4'
),
  (
  'mcq',
  'math',
  'A number $n$ is at least 8 more than 3 times the value of $k$. If $k = -2$, what is the minimum possible value of $n$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"-2"},{"id":"c","text":"14"},{"id":"d","text":"-14"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Translate the word problem into an inequality first. "At least" means $\\ge$. "8 more than" means adding 8.

\\textbf{Calculation and Logic:}

$n \\ge 3k + 8$

Substitute $k = -2$:

$n \\ge 3(-2) + 8$

$n \\ge -6 + 8$

$n \\ge 2$

The minimum value is 2.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_5'
),
  (
  'mcq',
  'math',
  'A gym charges a monthly fee based on the number of personal training sessions attended. \\begin{center} \\begin{tabular}{|c|c|} \\hline \\textbf{Sessions ($s$)} & \\textbf{Total Monthly Fee} \\hline 1--4 sessions & 120 \\hline 5--8 sessions & 200 \\hline 9--12 sessions & 270 \\hline \\end{tabular} \\end{center} An athlete paid 200 for the month. If the athlete had attended one fewer session, the fee would have been 120. How many sessions did the athlete attend?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"8"},{"id":"d","text":"9"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The fee change occurs at the boundaries of the session brackets. Moving from 200 down to 120 requires crossing the threshold between the 5--8 bracket and the 1--4 bracket.

\\textbf{Calculation and Logic:}

The current fee is 200, which corresponds to 5 to 8 sessions.

The previous bracket (1--4 sessions) costs 120.

If attending one fewer session drops the price to 120, the athlete must currently be at the very bottom of the 200 bracket.

Boundary: 5 sessions. One fewer is 4 sessions.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_6'
),
  (
  'mcq',
  'math',
  'A moving truck can carry a maximum of 3,500 pounds. If the truck is already loaded with 1,200 pounds of furniture, which inequality represents the possible weight $w$, in pounds, of the remaining boxes that can be added?',
  '[{"id":"a","text":"$w \\\\le 2,300$"},{"id":"b","text":"$w \\\\ge 2,300$"},{"id":"c","text":"$w + 3,500 \\\\le 1,200$"},{"id":"d","text":"$w - 1,200 \\\\le 3,500$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

"Maximum" indicates an upper limit, represented by the $\\le$ symbol. The sum of the existing weight and the new weight must not exceed the capacity.

\\textbf{Calculation and Logic:}

$1,200 + w \\le 3,500$

$w \\le 3,500 - 1,200$

$w \\le 2,300$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_011_7'
),
  (
  'mcq',
  'math',
  'A professional printer requires at least 1,000 sheets of paper to start a high-volume job. Paper is sold in reams of 250 sheets. What is the minimum number of reams, $r$, that must be purchased if the printer currently has 120 sheets?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"6"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

First, determine the deficit (how much more paper is needed). Then, divide by the amount per ream and round up to the next whole ream, as you cannot buy partial reams.

\\textbf{Calculation and Logic:}

Sheets needed = $1,000 - 120 = 880$

$250r \\ge 880$

$r \\ge 3.52$

The minimum whole number of reams is 4.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_8'
),
  (
  'mcq',
  'math',
  'The Karvonen formula $R = (M - r) \\times I + r$ represents the target heart rate $R$, where $M$ is maximum heart rate, $r$ is resting heart rate, and $I$ is intensity. For a person with $M = 190$ and $r = 60$, the recommended intensity $I$ is between $0.6$ and $0.8$. Which inequality represents the range of the target heart rate $R$?',
  '[{"id":"a","text":"$78 \\\\le R \\\\le 104$"},{"id":"b","text":"$138 \\\\le R \\\\le 164$"},{"id":"c","text":"$114 \\\\le R \\\\le 152$"},{"id":"d","text":"$150 \\\\le R \\\\le 190$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Substitute the constants $M$ and $r$ into the formula, then calculate the values of $R$ for the minimum and maximum intensities provided.

\\textbf{Calculation and Logic:}

$R = (190 - 60) × I + 60 = 130I + 60$

Min: $R = 130(0.6) + 60 = 78 + 60 = 138$

Max: $R = 130(0.8) + 60 = 104 + 60 = 164$

Inequality: $138 \\le R \\le 164$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_9'
),
  (
  'mcq',
  'math',
  'A gardener budgets 150 to purchase rose bushes. Each bush costs 18.50. The gardener must buy at least 3 bushes to get a free bag of mulch. What is the maximum number of bushes the gardener can buy while staying within the budget?',
  '[{"id":"a","text":"3"},{"id":"b","text":"7"},{"id":"c","text":"8"},{"id":"d","text":"9"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Calculate how many times the unit price fits into the total budget. Since you cannot buy a fraction of a bush, round down to the nearest whole number.

\\textbf{Calculation and Logic:}

$18.50b \\le 150$

$b \\le 8.108...$

The maximum whole number is 8.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_011_10'
),
  (
  'mcq',
  'math',
  'The value of $y$ is at most 12 more than twice the value of $x$. If $x = -5$, what is the greatest possible value of $y$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"7"},{"id":"c","text":"22"},{"id":"d","text":"-2"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Translate "at most" to $\\le$ and "12 more than twice $x$" to $2x + 12$.

\\textbf{Calculation and Logic:}

$y \\le 2x + 12$

Substitute $x = -5$:

$y \\le 2(-5) + 12$

$y \\le -10 + 12$

$y \\le 2$

The greatest value is 2.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_11'
),
  (
  'mcq',
  'math',
  'A migration study found that a bird species travels a minimum of 80 miles and a maximum of 140 miles per day. Which inequality represents the possible total distance $d$, in miles, the bird travels in a 7-day week?',
  '[{"id":"a","text":"$d \\\\le 140$"},{"id":"b","text":"$80 \\\\le d \\\\le 140$"},{"id":"c","text":"$560 \\\\le d \\\\le 980$"},{"id":"d","text":"$d \\\\ge 560$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Multiply both the minimum and maximum daily bounds by the number of days (7) to find the total range for the week.

\\textbf{Calculation and Logic:}

Min: $80 × 7 = 560$

Max: $140 × 7 = 980$

Range: $560 \\le d \\le 980$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_12'
),
  (
  'mcq',
  'math',
  'For which of the following tables are all values of $x$ and $y$ solutions to $y < 3x - 2$?',
  '[{"id":"a","text":"\\\\begin{tabular}{|c|c|} \\\\hline $x$ & $y$ \\\\hline 2 & 5 \\\\hline 4 & 11 \\\\hline \\\\end{tabular}"},{"id":"b","text":"\\\\begin{tabular}{|c|c|} \\\\hline $x$ & $y$ \\\\hline 2 & 3 \\\\hline 4 & 9 \\\\hline \\\\end{tabular}"},{"id":"c","text":"\\\\begin{tabular}{|c|c|} \\\\hline $x$ & $y$ \\\\hline 3 & 7 \\\\hline 5 & 12 \\\\hline \\\\end{tabular}"},{"id":"d","text":"\\\\begin{tabular}{|c|c|} \\\\hline $x$ & $y$ \\\\hline 1 & 1 \\\\hline 2 & 4 \\\\hline \\\\end{tabular}"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Substitute each $(x, y)$ pair into the inequality. For the table to be correct, the inequality must be true for every row.

\\textbf{Calculation and Logic:}

Test Choice C:

For $x=3, y=7$: $7 < 3(3) - 2 → 7 < 7$ (False)

Test Choice B:

For $x=2, y=3$: $3 < 3(2) - 2 → 3 < 4$ (True)

For $x=4, y=9$: $9 < 3(4) - 2 → 9 < 10$ (True)',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_13'
),
  (
  'mcq',
  'math',
  'A store sells small notebooks for 3 and large notebooks for 7. A student wants to buy at least 10 notebooks but cannot spend more than 50. If $s$ is the number of small notebooks and $l$ is the number of large notebooks, which system of inequalities represents this situation?',
  '[{"id":"a","text":"$s + l \\\\ge 10$; $3s + 7l \\\\le 50$"},{"id":"b","text":"$s + l \\\\le 10$; $3s + 7l \\\\le 50$"},{"id":"c","text":"$s + l \\\\ge 10$; $7s + 3l \\\\le 50$"},{"id":"d","text":"$s + l > 10$; $3s + 7l < 50$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The first inequality handles the quantity ("at least 10"). The second inequality handles the budget constraints ("cannot spend more than 50").

\\textbf{Calculation and Logic:}

Quantity: $s + l \\ge 10$

Cost: $3s + 7l \\le 50$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_14'
),
  (
  'mcq',
  'math',
  'A baby elephant weighs 250 pounds at birth and gains more than 1.5 but less than 2.5 pounds per day. Which inequality represents all possible weights $W$, in pounds, for the elephant 100 days after birth?',
  '[{"id":"a","text":"$150 < W < 250$"},{"id":"b","text":"$400 < W < 500$"},{"id":"c","text":"$350 < W < 450$"},{"id":"d","text":"$250 < W < 500$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Calculate the minimum and maximum possible gain over 100 days and add both to the birth weight.

\\textbf{Calculation and Logic:}

Birth weight = 250

Min gain: $100 × 1.5 = 150$

Max gain: $100 × 2.5 = 250$

Min total: $250 + 150 = 400$

Max total: $250 + 250 = 500$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_15'
),
  (
  'mcq',
  'math',
  'A theater has 300 seats. Ticket prices are 15 for adults and 10 for children. The theater must make at least 3,500 per show to cover costs. If $a$ is the number of adult tickets and $c$ is the number of children''s tickets, which inequality represents the revenue requirement?',
  '[{"id":"a","text":"$15a + 10c \\\\ge 3,500$"},{"id":"b","text":"$15a + 10c \\\\le 300$"},{"id":"c","text":"$a + c \\\\ge 3,500$"},{"id":"d","text":"$15a + 10c \\\\le 3,500$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Revenue is (Price $×$ Quantity). Since they must make "at least" a certain amount, the sum must be greater than or equal to that target.

\\textbf{Calculation and Logic:}

Adult revenue = $15a$

Children revenue = $10c$

Total revenue $\\ge 3,500$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_16'
),
  (
  'mcq',
  'math',
  'A data plan costs 40 per month plus 5 for every gigabyte ($g$) over the 10 GB limit. If a customer wants to keep their monthly bill at most 65, what is the maximum number of total gigabytes they can use?',
  '[{"id":"a","text":"5"},{"id":"b","text":"10"},{"id":"c","text":"15"},{"id":"d","text":"25"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Set up the equation for the bill: base price + (cost per extra GB $×$ extra GB). Solve for the total usage.

\\textbf{Calculation and Logic:}

$40 + 5(g - 10) \\le 65$

$5(g - 10) \\le 25$

$g - 10 \\le 5$

$g \\le 15$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_17'
),
  (
  'mcq',
  'math',
  'Which of the following values of $x$ is a solution to the inequality $4x - 7 > 13$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"6"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Solve the inequality for $x$, then look for the value that is strictly greater than the resulting bound.

\\textbf{Calculation and Logic:}

$4x > 20$

$x > 5$

Since it is $x > 5$ (not $\\ge$), 5 is not a solution. 6 is the only option that works.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_011_18'
),
  (
  'mcq',
  'math',
  'A wholesale club charges a 60 annual membership fee. Members pay 1.50 per pound for coffee, while non-members pay 2.50 per pound. Which inequality represents the number of pounds of coffee $p$ for which the annual cost for a member is less than the cost for a non-member?',
  '[{"id":"a","text":"$60 + 1.5p < 2.5p$"},{"id":"b","text":"$1.5p < 60 + 2.5p$"},{"id":"c","text":"$60 + 1.5p > 2.5p$"},{"id":"d","text":"$60 < 1.5p + 2.5p$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Member cost = fee + (price $×$ pounds). Non-member cost = (price $×$ pounds). The question asks when the member cost is "less than" the non-member cost.

\\textbf{Calculation and Logic:}

Member: $60 + 1.50p$

Non-member: $2.50p$

Inequality: $60 + 1.5p < 2.5p$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_19'
),
  (
  'mcq',
  'math',
  'A scientist is monitoring a liquid that must be kept between $45^\\circ$F and $75^\\circ$F. The current temperature is $50^\\circ$F and is rising at a rate of $2^\\circ$F per hour. Which inequality represents the number of hours $h$ the liquid can continue to rise before it exceeds the maximum temperature?',
  '[{"id":"a","text":"$50 + 2h \\\\le 75$"},{"id":"b","text":"$50 + 2h \\\\ge 45$"},{"id":"c","text":"$2h \\\\le 75$"},{"id":"d","text":"$50 + 2h < 45$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Start with the current temperature, add the rate of increase multiplied by time, and set it to be less than or equal to the maximum allowed temperature.

\\textbf{Calculation and Logic:}

Current Temp = 50

Increase = $2 × h$

Total $\\le 75$

$50 + 2h \\le 75$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_20'
),
  (
  'mcq',
  'math',
  'A baker has 20 cups of sugar. Each batch of cookies requires 1.5 cups of sugar, and each cake requires 3 cups of sugar. If the baker makes $c$ batches of cookies and $k$ cakes, which inequality represents the sugar constraint?',
  '[{"id":"a","text":"$1.5c + 3k \\\\le 20$"},{"id":"b","text":"$1.5c + 3k \\\\ge 20$"},{"id":"c","text":"$3c + 1.5k \\\\le 20$"},{"id":"d","text":"$c + k \\\\le 20$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The total sugar used (sum of sugar for cookies and sugar for cakes) must be less than or equal to the total sugar available.

\\textbf{Calculation and Logic:}

Sugar for cookies = $1.5c$

Sugar for cakes = $3k$

Total usage $\\le 20$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_21'
),
  (
  'mcq',
  'math',
  'The table below shows the points awarded in a trivia game. \\begin{center} \\begin{tabular}{|c|c|} \\hline \\textbf{Question Level} & \\textbf{Points} \\hline Easy & 5 \\hline Medium & 10 \\hline Hard & 20 \\hline \\end{tabular} \\end{center} A player answered 12 questions and scored at least 150 points. If the player answered 4 Easy questions and $m$ Medium questions, and the rest were Hard questions, what is the minimum number of Hard questions the player could have answered?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"7"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

First, use the total number of questions to express $m$ in terms of the number of Hard questions ($h$). Then, set up the score inequality.

\\textbf{Calculation and Logic:}

Total questions: $4 + m + h = 12 → m + h = 8 → m = 8 - h$

Score: $5(4) + 10(m) + 20(h) \\ge 150$

$20 + 10(8 - h) + 20h \\ge 150$

$20 + 80 - 10h + 20h \\ge 150$

$100 + 10h \\ge 150 → 10h \\ge 50 → h \\ge 5$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_22'
),
  (
  'mcq',
  'math',
  'A student needs a GPA of at least 3.5 to keep a scholarship. If their current GPA points sum to 13.2 over 4 courses, what is the minimum grade point $g$ they need in their 5th course to meet the requirement?',
  '[{"id":"a","text":"3.5"},{"id":"b","text":"3.8"},{"id":"c","text":"4.0"},{"id":"d","text":"4.3"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The GPA is the total points divided by the total number of courses. Set up the inequality and solve for the missing course points.

\\textbf{Calculation and Logic:}

$(13.2 + g)/(5) \\ge 3.5$

$13.2 + g \\ge 17.5$

$g \\ge 4.3$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_011_23'
),
  (
  'mcq',
  'math',
  'A small plane can carry a maximum load of 1,200 pounds. The pilot weighs 180 pounds and the fuel weighs 300 pounds. If each passenger weighs an average of 165 pounds and carries 30 pounds of luggage, what is the maximum number of passengers $p$ the plane can carry?',
  '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"6"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Subtract the fixed weights (pilot and fuel) from the total capacity. Divide the remaining capacity by the total weight per passenger (person + luggage).

\\textbf{Calculation and Logic:}

Available weight = $1,200 - (180 + 300) = 720$

Weight per passenger = $165 + 30 = 195$

$195p \\le 720$

$p \\le 3.69$

The maximum number of passengers is 3.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_24'
),
  (
  'mcq',
  'math',
  'An online store offers free shipping on orders over 75. A customer has 54 worth of items in their cart. If they add $n$ pairs of socks that cost 4.25 each, which inequality represents the values of $n$ for which the customer will receive free shipping?',
  '[{"id":"a","text":"$54 + 4.25n > 75$"},{"id":"b","text":"$54 + 4.25n \\\\ge 75$"},{"id":"c","text":"$4.25n > 75$"},{"id":"d","text":"$54 + n > 75$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The phrase "over 75" indicates a strict inequality ($>$). The total cost is the current cart value plus the cost of $n$ additional items.

\\textbf{Calculation and Logic:}

Current = 54

Additional = $4.25n$

Total $> 75$

$54 + 4.25n > 75$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_25'
),
  (
  'mcq',
  'math',
  'Which of the following points $(x, y)$ is a solution to the system of inequalities $y > -2x + 4$ and $y < x + 1$?',
  '[{"id":"a","text":"(1, 1)"},{"id":"b","text":"(2, 2)"},{"id":"c","text":"(3, 0)"},{"id":"d","text":"(1, 3)"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

For a point to be a solution to a system, it must satisfy every inequality in that system.

\\textbf{Calculation and Logic:}

Test (2, 2):

$2 > -2(2) + 4 → 2 > 0$ (True)

$2 < 2 + 1 → 2 < 3$ (True)

Both conditions are met.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_26'
),
  (
  'mcq',
  'math',
  'A solution to the inequality $ax + 3 \\le 11$ is $x \\ge -4$, where $a$ is a constant. What is the value of $a$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"-2"},{"id":"c","text":"4"},{"id":"d","text":"-4"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When solving an inequality, if the inequality sign flips (from $\\le$ to $\\ge$), it means we divided by a negative number.

\\textbf{Calculation and Logic:}

$ax \\le 11 - 3$

$ax \\le 8$

Since the result is $x \\ge -4$, we know $a$ must be negative and $8/a = -4$.

$a = 8 / -4 = -2$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_27'
),
  (
  'mcq',
  'math',
  'The shaded region of a graph represents the solution to $y \\le \\frac{1}{2}x + 3$. Which of the following describes the boundary line and the shading?',
  '[{"id":"a","text":"A solid line with shading above the line."},{"id":"b","text":"A dashed line with shading above the line."},{"id":"c","text":"A solid line with shading below the line."},{"id":"d","text":"A dashed line with shading below the line."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The symbol $\\le$ (less than or equal to) indicates a solid boundary line. The "less than" part ($<$) indicates that the region below the line is shaded.

\\textbf{Calculation and Logic:}

Symbol is $\\le$.

Equal sign component ($\\dots = \\dots$) = Solid line.

Less than component ($y < \\dots$) = Shading below.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_28'
),
  (
  'mcq',
  'math',
  'A company produces two types of widgets. Type A requires 2 hours of assembly and Type B requires 3 hours. The assembly line is available for a maximum of 40 hours per week. If the company must produce at least 5 of Type A, which system represents the constraints on $a$ and $b$?',
  '[{"id":"a","text":"$2a + 3b \\\\le 40$; $a \\\\ge 5$"},{"id":"b","text":"$2a + 3b \\\\ge 40$; $a \\\\le 5$"},{"id":"c","text":"$3a + 2b \\\\le 40$; $a \\\\ge 5$"},{"id":"d","text":"$a + b \\\\le 40$; $2a + 3b \\\\ge 5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The first inequality is the time constraint (Total time $\\le$ Max time). The second is the production quota (Type A $\\ge$ Min amount).

\\textbf{Calculation and Logic:}

Assembly time: $2a + 3b \\le 40$

Quantity of A: $a \\ge 5$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_29'
),
  (
  'mcq',
  'math',
  'In the $xy$-plane, if a point $(h, k)$ lies in the solution set of the system $y < 3x + 2$ and $y > -x + 5$, which of the following must be true?',
  '[{"id":"a","text":"$h > 0.75$"},{"id":"b","text":"$h < 0.75$"},{"id":"c","text":"$k > 3$"},{"id":"d","text":"$k < 5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The solution set is the region where these two inequalities overlap. Finding the intersection point of the boundary lines helps determine the bounds for $x$ (which is $h$) and $y$ (which is $k$).

\\textbf{Calculation and Logic:}

Set the boundary lines equal: $3x + 2 = -x + 5$

$4x = 3 → x = 0.75$

For $x > 0.75$, the area where $y$ is both $< 3x+2$ and $> -x+5$ exists.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_30'
),
  (
  'mcq',
  'math',
  'If $7 < x < 10$ and $2 < y < 5$, what is the greatest possible integer value for $x - y$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"7"},{"id":"d","text":"8"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To maximize the difference $x - y$, you must pick the largest possible value for $x$ and the smallest possible value for $y$.

\\textbf{Calculation and Logic:}

Max $x$ is just below 10.

Min $y$ is just above 2.

$10 - 2 = 8$.

Since $x$ cannot be 10 and $y$ cannot be 2, the difference must be less than 8. The greatest integer is 7.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_011_31'
),
  (
  'mcq',
  'math',
  'Which inequality is represented by the statement "the sum of a number $n$ and 5 is no more than the product of 3 and $n$"?',
  '[{"id":"a","text":"$n + 5 < 3n$"},{"id":"b","text":"$n + 5 \\\\le 3n$"},{"id":"c","text":"$n + 5 > 3n$"},{"id":"d","text":"$3(n + 5) \\\\le n$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

"No more than" means the value can be equal to or less than the limit, but not greater. This translates to $\\le$.

\\textbf{Calculation and Logic:}

Sum of $n$ and 5: $n + 5$

Product of 3 and $n$: $3n$

Inequality: $n + 5 \\le 3n$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_32'
),
  (
  'mcq',
  'math',
  'A set of numbers consists of all integers $x$ such that $2x - 4 > 10$ and $x + 5 < 20$. How many integers are in this set?',
  '[{"id":"a","text":"6"},{"id":"b","text":"7"},{"id":"c","text":"8"},{"id":"d","text":"9"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Solve both inequalities separately to find the range for $x$, then list the integers within that range.

\\textbf{Calculation and Logic:}

1) $2x > 14 → x > 7$

2) $x < 15$

Range: $7 < x < 15$.

Integers: 8, 9, 10, 11, 12, 13, 14.

Total count: 7.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_33'
),
  (
  'mcq',
  'math',
  'An inequality is given as $y > \\frac{2}{3}x - 4$. Which quadrant contains no solutions for this inequality?',
  '[{"id":"a","text":"Quadrant I"},{"id":"b","text":"Quadrant II"},{"id":"c","text":"Quadrant III"},{"id":"d","text":"All quadrants contain solutions."}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The inequality $y > \\dots$ shades above the line. If the line has a positive slope and a negative y-intercept, it passes through Quadrants I, III, and IV. Shading above will cover some of Quadrant II as well.

\\textbf{Calculation and Logic:}

The line passes through (0, -4) and (6, 0).

The region above this line includes all of Quadrant II and parts of I, III, and IV.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_34'
),
  (
  'mcq',
  'math',
  'What is the smallest integer value of $x$ that satisfies $3x + 10 > 25$?',
  '[{"id":"a","text":"5"},{"id":"b","text":"6"},{"id":"c","text":"4"},{"id":"d","text":"7"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Solve the inequality for $x$ and identify the smallest integer that is strictly greater than your solution.

\\textbf{Calculation and Logic:}

$3x > 15$

$x > 5$

The smallest integer greater than 5 is 6.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_011_35'
),
  (
  'mcq',
  'math',
  'A car rental agency charges 35 per day plus 0.20 per mile. If a person rents a car for 2 days and wants to spend no more than 100, what is the maximum number of miles they can drive?',
  '[{"id":"a","text":"150"},{"id":"b","text":"325"},{"id":"c","text":"125"},{"id":"d","text":"100"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Calculate the fixed cost for the 2 days, subtract it from the total budget, and then divide by the per-mile cost.

\\textbf{Calculation and Logic:}

Fixed cost: $2 × 35 = 70$

Remaining budget: $100 - 70 = 30$

$0.20m \\le 30$

$m \\le 150$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_36'
),
  (
  'mcq',
  'math',
  'The solution to a system of linear inequalities is a triangular region. The vertices of this region are (0, 0), (0, 4), and (4, 0). Which of the following systems defines this region?',
  '[{"id":"a","text":"$x \\\\ge 0, y \\\\ge 0, x + y \\\\le 4$"},{"id":"b","text":"$x \\\\le 0, y \\\\le 0, x + y \\\\ge 4$"},{"id":"c","text":"$x \\\\ge 0, y \\\\ge 0, y \\\\le x + 4$"},{"id":"d","text":"$x \\\\le 4, y \\\\le 4, x + y \\\\le 4$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The vertices (0,0), (0,4), and (4,0) imply the region is in the first quadrant (bounded by the axes) and limited by a line connecting (0,4) and (4,0).

\\textbf{Calculation and Logic:}

Boundary 1: $x = 0$ (y-axis)

Boundary 2: $y = 0$ (x-axis)

Boundary 3: Line through (0,4) and (4,0) is $y = -x + 4$ or $x + y = 4$.

Since (0,0) is inside, the inequality is $x + y \\le 4$.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_37'
),
  (
  'mcq',
  'math',
  'A student''s score on a test was at least 75 and at most 92. If $s$ represents the score, which absolute value inequality represents this range?',
  '[{"id":"a","text":"$|s - 83.5| \\\\le 8.5$"},{"id":"b","text":"$|s - 8.5| \\\\le 83.5$"},{"id":"c","text":"$|s - 92| \\\\le 75$"},{"id":"d","text":"$|s + 83.5| \\\\le 8.5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

To write a range as an absolute value inequality, use the form $|x - \\text{midpoint}| \\le \\text{distance to ends}$.

\\textbf{Calculation and Logic:}

Midpoint = $(75 + 92) / 2 = 83.5$

Distance = $92 - 83.5 = 8.5$

Inequality: $|s - 83.5| \\le 8.5$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_38'
),
  (
  'mcq',
  'math',
  'If $x + y > 10$ and $x - y < 4$, which of the following is a possible value for $x$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"4"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Adding the two inequalities can help eliminate $y$ and find a bound for $x$.

\\textbf{Calculation and Logic:}

$(x + y) + (x - y) > 10 + (\\text{no, this doesn''t work directly because of the direction of signs})$.

Let''s rewrite: $y > 10 - x$ and $y > x - 4$.

For a solution to exist, pick $x = 8$:

$y > 2$ and $y > 4$. A value like $y = 5$ works.

If $x = 2$: $y > 8$ and $y > -2$. $x + y > 10 → 2 + y > 10 → y > 8$. $x - y < 4 → 2 - y < 4 → y > -2$.

Wait, if $x=8$ and $y=5$: $8+5=13 > 10$ (True). $8-5=3 < 4$ (True).',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_39'
),
  (
  'mcq',
  'math',
  'A company''s profit $P$ must be at least 500 per day. Profit is calculated as $P = 20n - 1200$, where $n$ is the number of units sold. What is the minimum number of units the company must sell to reach its goal?',
  '[{"id":"a","text":"60"},{"id":"b","text":"85"},{"id":"c","text":"25"},{"id":"d","text":"100"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Set up the inequality where the profit expression is $\\ge 500$ and solve for $n$.

\\textbf{Calculation and Logic:}

$20n - 1200 \\ge 500$

$20n \\ge 1700$

$n \\ge 85$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_40'
),
  (
  'mcq',
  'math',
  'Which of the following inequalities has the same solution set as $3 - 2x < 11$?',
  '[{"id":"a","text":"$x > -4$"},{"id":"b","text":"$x < -4$"},{"id":"c","text":"$x > 4$"},{"id":"d","text":"$x < 4$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Solve the inequality, making sure to flip the inequality sign when dividing by a negative number.

\\textbf{Calculation and Logic:}

$-2x < 11 - 3$

$-2x < 8$

$x > -4$ (flip sign)',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_41'
),
  (
  'mcq',
  'math',
  'A student is buying pens and pencils. Pens cost 1.50 each and pencils cost 0.50 each. The student must buy at least 20 items in total and has 15.00 to spend. If $x$ is pens and $y$ is pencils, which of the following is a possible number of pens?',
  '[{"id":"a","text":"1"},{"id":"b","text":"5"},{"id":"c","text":"10"},{"id":"d","text":"15"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Set up the system: $x + y \\ge 20$ and $1.5x + 0.5y \\le 15$. Test the options by seeing if a valid $y$ exists.

\\textbf{Calculation and Logic:}

If $x = 5$: $5 + y \\ge 20 → y \\ge 15$.

Cost: $1.5(5) + 0.5(15) = 7.5 + 7.5 = 15$.

This satisfies both conditions (Cost is exactly 15 and quantity is exactly 20).',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_42'
),
  (
  'mcq',
  'math',
  'Which inequality is shown by the graph of a horizontal line through (0, 5) with shading above?',
  '[{"id":"a","text":"$x > 5$"},{"id":"b","text":"$y > 5$"},{"id":"c","text":"$x < 5$"},{"id":"d","text":"$y < 5$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Horizontal lines are of the form $y = c$. Shading "above" means $y > c$.

\\textbf{Calculation and Logic:}

Line passes through (0, 5) horizontally $→ y = 5$.

Shading above $→ y > 5$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_011_43'
),
  (
  'mcq',
  'math',
  'A rectangle has a length of 10 inches. If the perimeter must be at least 30 inches and at most 50 inches, which inequality represents the possible widths $w$?',
  '[{"id":"a","text":"$5 \\\\le w \\\\le 15$"},{"id":"b","text":"$10 \\\\le w \\\\le 20$"},{"id":"c","text":"$20 \\\\le w \\\\le 40$"},{"id":"d","text":"$5 \\\\le w \\\\le 25$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Perimeter $P = 2l + 2w$. Substitute $l = 10$ and solve the compound inequality for $w$.

\\textbf{Calculation and Logic:}

$P = 2(10) + 2w = 20 + 2w$

$30 \\le 20 + 2w \\le 50$

$10 \\le 2w \\le 30$

$5 \\le w \\le 15$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_44'
),
  (
  'mcq',
  'math',
  'In a system of inequalities, $y \\ge 2x - 1$ and $x + y \\le 5$. What is the maximum possible value of $y$?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"5"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The maximum value of $y$ usually occurs at the intersection of the two boundary lines.

\\textbf{Calculation and Logic:}

$y = 2x - 1$

$y = 5 - x$

$2x - 1 = 5 - x → 3x = 6 → x = 2$

$y = 5 - (2) = 3$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_45'
),
  (
  'mcq',
  'math',
  'A music store sells CDs for 12 and vinyl records for 20. A customer wants to spend more than 100 but less than 150. If the customer buys 4 CDs, what is the range of the number of vinyl records $v$ they can buy?',
  '[{"id":"a","text":"$2 < v < 6$"},{"id":"b","text":"$3 \\\\le v \\\\le 5$"},{"id":"c","text":"$2.6 < v < 5.1$"},{"id":"d","text":"$3 < v < 5$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Subtract the cost of the 4 CDs from both ends of the budget range, then divide by the price of a vinyl record.

\\textbf{Calculation and Logic:}

CD cost: $4 × 12 = 48$

$100 - 48 < 20v < 150 - 48$

$52 < 20v < 102$

$2.6 < v < 5.1$

Since $v$ must be an integer: 3, 4, or 5.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_46'
),
  (
  'mcq',
  'math',
  'Which of the following is equivalent to $x + 2 > 5$ OR $x + 2 < 1$?',
  '[{"id":"a","text":"$x > 3$ or $x < -1$"},{"id":"b","text":"$x > 7$ or $x < 3$"},{"id":"c","text":"$-1 < x < 3$"},{"id":"d","text":"$x > 3$ or $x < 1$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Solve each inequality in the "OR" statement separately. The solution set includes any value that makes either statement true.

\\textbf{Calculation and Logic:}

1) $x > 5 - 2 → x > 3$

2) $x < 1 - 2 → x < -1$

Result: $x > 3$ or $x < -1$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_011_47'
),
  (
  'mcq',
  'math',
  'If $f(x) = 2x - 5$, for what values of $x$ is $f(x) \\le 11$?',
  '[{"id":"a","text":"$x \\\\le 3$"},{"id":"b","text":"$x \\\\le 8$"},{"id":"c","text":"$x \\\\le 16$"},{"id":"d","text":"$x \\\\ge 8$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This is a standard inequality solution. Substitute the function expression into the inequality.

\\textbf{Calculation and Logic:}

$2x - 5 \\le 11$

$2x \\le 16$

$x \\le 8$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_011_48'
),
  (
  'mcq',
  'math',
  'A pool currently holds 5,000 gallons of water and is being drained at a rate of 250 gallons per hour. After how many hours $h$ will the pool have less than 1,000 gallons of water?',
  '[{"id":"a","text":"$h > 16$"},{"id":"b","text":"$h < 16$"},{"id":"c","text":"$h > 20$"},{"id":"d","text":"$h < 24$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Start with the initial amount, subtract the rate of drainage multiplied by time, and set it to be less than the target amount.

\\textbf{Calculation and Logic:}

$5000 - 250h < 1000$

$-250h < -4000$

$h > 16$ (flip sign when dividing by -250)',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_49'
),
  (
  'mcq',
  'math',
  'The sum of two positive integers, $x$ and $y$, is less than 10. If $x = 3$, what is the maximum possible value of $y$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"7"},{"id":"c","text":"5"},{"id":"d","text":"10"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Substitute the value of $x$ into the inequality and solve for the range of $y$. Remember that "less than 10" does not include 10 itself.

\\textbf{Calculation and Logic:}

$3 + y < 10$

$y < 7$

The largest integer less than 7 is 6.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_011_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

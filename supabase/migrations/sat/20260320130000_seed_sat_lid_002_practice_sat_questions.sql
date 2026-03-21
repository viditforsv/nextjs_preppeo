-- Practice-mode math from lid_002.tex (sat_lid_002)
-- Chapter: Linear equations in one variable | Topic: Linear Equation Word Problems
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_002_N, practice module/set 0.
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
  'A plumbing company charges a fixed service call fee of 75 plus an hourly labor rate of 60. If a customer was charged a total of 315 for a repair, which equation represents the number of hours, $h$, the plumber worked?',
  '[{"id":"a","text":"$75h + 60 = 315$"},{"id":"b","text":"$60h + 75 = 315$"},{"id":"c","text":"$135h = 315$"},{"id":"d","text":"$60h - 75 = 315$"}]'::jsonb,
  'b',
  'To represent this situation with a linear equation, we must distinguish between the fixed cost and the variable cost.

The service call fee is a constant amount of 75 that is charged once, regardless of how long the job takes. The hourly rate is 60, which must be multiplied by the number of hours worked, $h$, to find the total labor cost, resulting in the term $60h$.

The total bill is the sum of these two distinct parts. By adding the variable labor cost to the fixed service fee and setting the total equal to 315, we arrive at the model:

$60h + 75 = 315$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_1'
),
  (
  'mcq',
  'math',
  'If $4x + 5 = 17$, what is the value of $12x + 15$?',
  '[{"id":"a","text":"34"},{"id":"b","text":"46"},{"id":"c","text":"51"},{"id":"d","text":"66"}]'::jsonb,
  'c',
  'This problem tests your ability to recognize algebraic relationships between two expressions to find a shortcut.

Observe the given equation, $4x + 5 = 17$, and the expression we are asked to evaluate, $12x + 15$. Notice that each term in the required expression is exactly three times the corresponding term in the initial equation:

$3 × (4x) = 12x$

$3 × (5) = 15$

Because the entire expression is being tripled, we can apply the multiplication property of equality. If the left side is tripled, the right side must also be tripled to maintain balance:

$3(4x + 5) = 3(17)$

$12x + 15 = 51$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_2'
),
  (
  'mcq',
  'math',
  'What value of $p$ satisfies the equation $5p + 140 = 390$?',
  '[{"id":"a","text":"50"},{"id":"b","text":"70"},{"id":"c","text":"110"},{"id":"d","text":"250"}]'::jsonb,
  'a',
  'To solve for the variable $p$, we apply inverse operations step-by-step to isolate the term.

First, we subtract the constant 140 from both sides of the equation. This moves the numerical values to one side:

$5p = 390 - 140$

$5p = 250$

Next, we isolate $p$ by undoing the multiplication by 5. Dividing both sides by the coefficient 5 gives:

$p = (250)/(5)$

$p = 50$

Substituting 50 back into the original equation ($5 × 50 + 140 = 250 + 140 = 390$) verifies the answer.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_3'
),
  (
  'mcq',
  'math',
  '$15x - 8x + 120 = 260$. What value of $x$ is the solution to the given equation?',
  '[{"id":"a","text":"20"},{"id":"b","text":"40"},{"id":"c","text":"80"},{"id":"d","text":"140"}]'::jsonb,
  'a',
  'The first requirement is to simplify the left side of the equation by combining like terms. Variable terms containing the same letter can be combined:

$15x - 8x = 7x$

Now the equation is $7x + 120 = 260$. To isolate the variable term, subtract 120 from both sides:

$7x = 260 - 120$

$7x = 140$

Finally, solve for $x$ by dividing by the coefficient 7:

$x = (140)/(7) = 20$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_4'
),
  (
  'mcq',
  'math',
  '$(m + 8) + 17 = 40$. What value of $m$ is the solution to the given equation?',
  '[{"id":"a","text":"15"},{"id":"b","text":"23"},{"id":"c","text":"32"},{"id":"d","text":"48"}]'::jsonb,
  'a',
  'Because the operations on the left side are addition, the parentheses around $(m + 8)$ do not change the priority of calculations and can be removed.

The equation becomes $m + 8 + 17 = 40$. We simplify by adding the constant terms:

$m + 25 = 40$

To isolate $m$, we perform the inverse operation of subtraction. Subtracting 25 from both sides gives:

$m = 40 - 25 = 15$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_002_5'
),
  (
  'mcq',
  'math',
  'If $3x - 18 = 12$, what is the value of $x - 6$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"10"},{"id":"c","text":"14"},{"id":"d","text":"30"}]'::jsonb,
  'a',
  'This question allows for a direct solution by factoring the left side. Both terms in $3x - 18$ are divisible by 3.

Factoring out the 3 gives:

$3(x - 6) = 12$

To find the value of the expression $(x - 6)$ specifically, we can simply divide both sides of the equation by 3:

$(3(x - 6))/(3) = (12)/(3)$

$x - 6 = 4$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_6'
),
  (
  'mcq',
  'math',
  '$5(3x - 2) = 35$. Which equation has the same solution?',
  '[{"id":"a","text":"$3x - 2 = 7$"},{"id":"b","text":"$3x - 2 = 30$"},{"id":"c","text":"$15x - 2 = 35$"},{"id":"d","text":"$15x - 10 = 7$"}]'::jsonb,
  'a',
  'We can find an equivalent equation by performing a balanced operation on the whole equation.

The original statement is $5$ multiplied by $(3x - 2)$ equals 35. To simplify this, we divide both sides by 5:

$(5(3x - 2))/(5) = (35)/(5)$

$3x - 2 = 7$

This version of the equation will yield the same result for $x$ as the original equation.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_7'
),
  (
  'mcq',
  'math',
  'A tank contained 8,000 gallons of water. A pump removes water at a constant rate. After 4 hours, 6,800 gallons remain. At this rate, how many total hours will the pump have run when 3,500 gallons remain?',
  '[{"id":"a","text":"9"},{"id":"b","text":"12"},{"id":"c","text":"15"},{"id":"d","text":"18"}]'::jsonb,
  'c',
  'First, we must calculate the rate of change. In 4 hours, the volume decreased from 8,000 to 6,800 gallons:

$8,000 - 6,800 = 1,200$ gallons removed.

The rate per hour is $1,200 ÷ 4 = 300$ gallons per hour.

Next, determine the total loss needed to reach 3,500 gallons from the initial 8,000:

$8,000 - 3,500 = 4,500$ total gallons to be removed.

Finally, divide the total loss by the hourly rate:

$4,500 ÷ 300 = 15$ hours.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_002_8'
),
  (
  'mcq',
  'math',
  'If $2x + 7 = 19$, what is the value of $6x + 5$?',
  '[{"id":"a","text":"36"},{"id":"b","text":"41"},{"id":"c","text":"48"},{"id":"d","text":"52"}]'::jsonb,
  'b',
  'First, we solve for $2x$ in the given equation by subtracting 7 from both sides:

$2x = 12$

We need the value of $6x + 5$. Since $6x$ is three times $2x$, we multiply 12 by 3:

$6x = 36$

Finally, add 5 to the result:

$36 + 5 = 41$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_9'
),
  (
  'mcq',
  'math',
  '$7x + 14 = 154$. What is the solution to the given equation?',
  '[{"id":"a","text":"20"},{"id":"b","text":"22"},{"id":"c","text":"24"},{"id":"d","text":"140"}]'::jsonb,
  'a',
  'Isolate the $x$ term by subtracting 14 from both sides:

$7x = 154 - 14$

$7x = 140$

Now, divide by the coefficient 7 to find the value of $x$:

$x = (140)/(7) = 20$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_10'
),
  (
  'mcq',
  'math',
  'Laila paid 180 for a gym membership which included a 60 registration fee and $m$ monthly payments of 15. Which equation represents this situation?',
  '[{"id":"a","text":"$60m + 15 = 180$"},{"id":"b","text":"$15m + 60 = 180$"},{"id":"c","text":"$75m = 180$"},{"id":"d","text":"$15m - 60 = 180$"}]'::jsonb,
  'b',
  'The cost structure consists of a fixed portion and a recurring portion. The registration fee is a one-time payment of 60. The monthly payments are 15 per month for $m$ months, which totals $15m$.

The sum of these two components equals the total price paid. The resulting equation is $15m + 60 = 180$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_11'
),
  (
  'mcq',
  'math',
  'If $9x - 81 = 18$, what is the value of $x - 9$?',
  '[{"id":"a","text":"2"},{"id":"b","text":"9"},{"id":"c","text":"11"},{"id":"d","text":"20"}]'::jsonb,
  'a',
  'Factor the left side to look for the requested expression. Both 9 and 81 are multiples of 9:

$9(x - 9) = 18$

Divide both sides by 9 to isolate the expression $(x - 9)$:

$x - 9 = (18)/(9) = 2$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_12'
),
  (
  'mcq',
  'math',
  '$14x - 10x + 50 = 110$. What is the value of $x$?',
  '[{"id":"a","text":"15"},{"id":"b","text":"30"},{"id":"c","text":"45"},{"id":"d","text":"60"}]'::jsonb,
  'a',
  'Combine the $x$ terms: $14x - 10x = 4x$.

The equation becomes $4x + 50 = 110$. Subtract 50 from both sides:

$4x = 60$

Divide by 4 to get $x = 15$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_13'
),
  (
  'mcq',
  'math',
  '$(y - 5) + 12 = 30$. What is $y$?',
  '[{"id":"a","text":"13"},{"id":"b","text":"18"},{"id":"c","text":"23"},{"id":"d","text":"47"}]'::jsonb,
  'c',
  'Simplify the constant terms on the left: $-5 + 12 = 7$.

The equation is $y + 7 = 30$. Subtract 7 from both sides:

$y = 23$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_002_14'
),
  (
  'mcq',
  'math',
  'If $4x + 2 = 18$, what is the value of $20x + 10$?',
  '[{"id":"a","text":"80"},{"id":"b","text":"90"},{"id":"c","text":"100"},{"id":"d","text":"110"}]'::jsonb,
  'b',
  'Observe the relationship between the terms. $20x$ is $5 × 4x$ and $10$ is $5 × 2$.

This means the second expression is 5 times the first equation''s left side. Multiply the entire equation by 5:

$5(4x + 2) = 5(18)$

$20x + 10 = 90$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_15'
),
  (
  'mcq',
  'math',
  '$6(2x + 3) = 54$. Which equation has the same solution?',
  '[{"id":"a","text":"$2x + 3 = 9$"},{"id":"b","text":"$2x + 3 = 48$"},{"id":"c","text":"$12x + 3 = 54$"},{"id":"d","text":"$12x + 18 = 9$"}]'::jsonb,
  'a',
  'Divide both sides of the original equation by 6 to remove the multiplier:

$(6(2x + 3))/(6) = (54)/(6)$

$2x + 3 = 9$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_16'
),
  (
  'mcq',
  'math',
  'A storage unit had 500 liters of fuel. It is used at a constant rate of 40 liters per hour. After $h$ hours, 140 liters remain. How many total hours have passed?',
  '[{"id":"a","text":"7"},{"id":"b","text":"9"},{"id":"c","text":"11"},{"id":"d","text":"13"}]'::jsonb,
  'b',
  'Total fuel used is $500 - 140 = 360$ liters.

Since the rate is 40 liters per hour, we divide the total fuel used by the rate:

$h = 360 ÷ 40 = 9$ hours.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_002_17'
),
  (
  'mcq',
  'math',
  'What value of $n$ satisfies $8n + 160 = 800$?',
  '[{"id":"a","text":"80"},{"id":"b","text":"100"},{"id":"c","text":"120"},{"id":"d","text":"640"}]'::jsonb,
  'a',
  'Subtract 160 from 800: $8n = 640$.

Divide by 8 to solve for $n$: $n = 80$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_002_18'
),
  (
  'mcq',
  'math',
  'If $10x - 40 = 30$, what is the value of $2x - 8$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"10"},{"id":"c","text":"14"},{"id":"d","text":"18"}]'::jsonb,
  'a',
  'Notice that the terms $2x$ and 8 are exactly one-fifth of $10x$ and 40.

Divide the entire equation by 5:

$(10x - 40)/(5) = (30)/(5)$

$2x - 8 = 6$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_19'
),
  (
  'mcq',
  'math',
  '$11x + 9 = 130$. What is $x$?',
  '[{"id":"a","text":"11"},{"id":"b","text":"12"},{"id":"c","text":"13"},{"id":"d","text":"121"}]'::jsonb,
  'a',
  'Subtract 9 from 130: $11x = 121$.

Divide by 11: $x = 11$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_002_20'
),
  (
  'mcq',
  'math',
  'A mechanic charges 80 for diagnosis plus 55 per hour for labor. If the bill was 300, which equation models the number of hours worked, $h$?',
  '[{"id":"a","text":"$55h + 80 = 300$"},{"id":"b","text":"$80h + 55 = 300$"},{"id":"c","text":"$135h = 300$"},{"id":"d","text":"$55h = 300$"}]'::jsonb,
  'a',
  'The fixed fee is 80 and the variable labor cost is $55h$.

Summing these gives the total: $55h + 80 = 300$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_21'
),
  (
  'mcq',
  'math',
  'If $5x + 3 = 18$, what is $10x - 4$?',
  '[{"id":"a","text":"26"},{"id":"b","text":"30"},{"id":"c","text":"32"},{"id":"d","text":"36"}]'::jsonb,
  'a',
  'Find $5x$: $5x = 15$.

Multiply by 2 to get $10x = 30$.

Subtract 4: $30 - 4 = 26$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_22'
),
  (
  'mcq',
  'math',
  '$3x + 2x + 12 = 72$. Value of $x$?',
  '[{"id":"a","text":"12"},{"id":"b","text":"14"},{"id":"c","text":"16"},{"id":"d","text":"60"}]'::jsonb,
  'a',
  'Combine terms: $5x + 12 = 72$.

Subtract 12: $5x = 60 → x = 12$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_002_23'
),
  (
  'mcq',
  'math',
  '$(w + 4) - 9 = 11$. What is $w$?',
  '[{"id":"a","text":"14"},{"id":"b","text":"16"},{"id":"c","text":"18"},{"id":"d","text":"24"}]'::jsonb,
  'b',
  'Simplify left: $w - 5 = 11$.

Add 5: $w = 16$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_002_24'
),
  (
  'mcq',
  'math',
  '$6(x - 4) = 36$. Same solution as?',
  '[{"id":"a","text":"$x - 4 = 6$"},{"id":"b","text":"$x - 4 = 30$"},{"id":"c","text":"$6x - 4 = 36$"},{"id":"d","text":"$6x - 24 = 6$"}]'::jsonb,
  'a',
  'Divide both sides by 6: $x - 4 = 6$.',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_002_25'
),
  (
  'spr',
  'math',
  'A caterer charges a delivery fee of 45 and 18 per guest. If the total bill was 495, how many guests attended the event?',
  NULL,
  '25',
  'We set up the linear equation where $g$ represents the number of guests. The total cost is the sum of the delivery fee and the per-guest charge:

$18g + 45 = 495$

Subtract the constant fee from both sides:

$18g = 450$

Divide by the per-guest rate:

$g = (450)/(18) = 25$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_26'
),
  (
  'spr',
  'math',
  'A rental car costs 35 per day plus 0.20 per mile. If the total bill for one day was 75, how many miles were driven?',
  NULL,
  '200',
  'Let $m$ be the number of miles. The equation is:

$0.20m + 35 = 75$

Subtract the daily fee:

$0.20m = 40$

Divide by the mileage rate (dividing by 0.20 is the same as multiplying by 5):

$m = 200$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_27'
),
  (
  'spr',
  'math',
  'A savings account started with 150. Every month, 45 is deposited. After how many months will the account balance be 780?',
  NULL,
  '14',
  'Let $x$ be the number of months. The model is:

$45x + 150 = 780$

Subtract the starting balance:

$45x = 630$

Divide by the monthly deposit:

$x = (630)/(45) = 14$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_28'
),
  (
  'spr',
  'math',
  'A candle is 25 cm tall and burns at a rate of 1.5 cm per hour. After how many hours will the candle be exactly 13 cm tall?',
  NULL,
  '8',
  'The height $h$ after $t$ hours is $h = 25 - 1.5t$. We set $h = 13$:

$25 - 1.5t = 13$

Subtract 25 from both sides:

$-1.5t = -12$

Divide by -1.5:

$t = 8$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_29'
),
  (
  'spr',
  'math',
  'An elevator starts on the 40th floor and descends at a rate of 2 floors per second. After how many seconds is the elevator on the 12th floor?',
  NULL,
  '14',
  'Equation: $40 - 2s = 12$.

$-2s = -28$.

$s = 14$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_30'
),
  (
  'spr',
  'math',
  'A cell phone plan costs 30 per month plus 0.05 per text message. If the bill was 42.50, how many texts were sent?',
  NULL,
  '250',
  '$0.05x + 30 = 42.50$.

$0.05x = 12.50$.

$x = 250$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_31'
),
  (
  'spr',
  'math',
  'A membership fee is 100, and each yoga class costs 12. If a person spent a total of 244, how many classes did they attend?',
  NULL,
  '12',
  '$12c + 100 = 244$.

$12c = 144$.

$c = 12$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_32'
),
  (
  'spr',
  'math',
  'A printer can print 25 pages per minute. How many minutes will it take to print a document that is 350 pages long?',
  NULL,
  '14',
  '$25m = 350$.

$m = 14$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_33'
),
  (
  'spr',
  'math',
  'A car travels at 65 miles per hour. How many hours will it take to travel 520 miles?',
  NULL,
  '8',
  '$65t = 520$.

$t = 8$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_34'
),
  (
  'spr',
  'math',
  'A balloon is at an altitude of 1,200 feet and descends at a rate of 40 feet per minute. What is the altitude after 12 minutes?',
  NULL,
  '720',
  '$A = 1,200 - 40(12)$.

$A = 1,200 - 480$.

$A = 720$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_35'
),
  (
  'spr',
  'math',
  'A baker uses 3 cups of flour for each loaf of bread. If they have 45 cups of flour, how many loaves can they make?',
  NULL,
  '15',
  '$3x = 45$.

$x = 15$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_36'
),
  (
  'spr',
  'math',
  'A tree is 4 feet tall and grows 1.5 feet per year. How many years will it take to reach a height of 19 feet?',
  NULL,
  '10',
  '$1.5y + 4 = 19$.

$1.5y = 15$.

$y = 10$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_37'
),
  (
  'spr',
  'math',
  'A swimming pool contains 2,500 gallons of water and is being filled at a rate of 150 gallons per hour. How many gallons will be in the pool after 6 hours?',
  NULL,
  '3,400',
  '$G = 2,500 + 150(6)$.

$G = 2,500 + 900 = 3,400$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_38'
),
  (
  'spr',
  'math',
  'A student has 250 in their bank account and withdraws 20 each week. After how many weeks will the balance be 90?',
  NULL,
  '8',
  '$250 - 20w = 90$.

$-20w = -160$.

$w = 8$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_39'
),
  (
  'spr',
  'math',
  '$x/3 - 4 = 1$. What is $x$?',
  NULL,
  '15',
  'Add 4 to both sides:

$x/3 = 5$

Multiply by 3:

$x = 15$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_40'
),
  (
  'spr',
  'math',
  'If $10x = 80$, what is $x/2$?',
  NULL,
  '4',
  'Solve for $x$:

$x = 8$

Divide by 2:

$8 ÷ 2 = 4$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_002_41'
),
  (
  'spr',
  'math',
  '$20 - (x + 5) = 10$. What is $x$?',
  NULL,
  '5',
  'Distribute the negative sign:

$20 - x - 5 = 10$

Combine the constants:

$15 - x = 10$

Isolate $x$ (subtract 15 and multiply by -1):

$-x = -5 → x = 5$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_42'
),
  (
  'spr',
  'math',
  '$9x + 4 = 6x + 19$. Value of $x$?',
  NULL,
  '5',
  'Subtract $6x$ from both sides:

$3x + 4 = 19$

Subtract 4 from both sides:

$3x = 15$

Divide by 3:

$x = 5$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_43'
),
  (
  'spr',
  'math',
  '$5(2x - 8) = 0$. What is $x$?',
  NULL,
  '4',
  'The quantity inside the parentheses must equal 0:

$2x - 8 = 0$

$2x = 8$

$x = 4$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_44'
),
  (
  'spr',
  'math',
  'If $x + x + x + x + x = 25$, what is $2x$?',
  NULL,
  '10',
  'Combine $x$ terms:

$5x = 25 → x = 5$

Multiply by 2:

$2 × 5 = 10$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_002_45'
),
  (
  'spr',
  'math',
  'Solve: $1.5x + 0.5x = 14$.',
  NULL,
  '7',
  'Combine the variable terms:

$2.0x = 14$

Divide by 2:

$x = 7$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_46'
),
  (
  'spr',
  'math',
  'If $4x = 16$, what is $4x + 9$?',
  NULL,
  '25',
  'Substitute 16 for the term $4x$:

$16 + 9 = 25$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_002_47'
),
  (
  'mcq',
  'math',
  '$5(x + 3) = 5x + 15$. How many solutions?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'c',
  'Distribute the 5 on the left side:

$5x + 15 = 5x + 15$

Because both sides of the equation are mathematically identical, the statement is true for any value of $x$. This represents an identity with infinite solutions.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_002_48'
),
  (
  'mcq',
  'math',
  '$4x + 1 = 4x + 9$. How many solutions?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'a',
  'Subtract $4x$ from both sides:

$1 = 9$

This is a false statement. Since the variable cancels out leaving a contradiction, no value of $x$ will make the equation true.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_002_49'
),
  (
  'spr',
  'math',
  'If $1/5 x + 2/5 x = 9$, what is $x$?',
  NULL,
  '15',
  'Combine the fractions:

$3/5 x = 9$

Isolate $x$ by multiplying by the reciprocal $(5)/(3)$:

$x = 9 × (5)/(3) = 3 × 5 = 15$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_002_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

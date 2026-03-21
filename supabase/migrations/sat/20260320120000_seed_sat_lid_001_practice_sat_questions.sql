-- Practice-mode math questions from lid_001.tex (sat_lid_001)
-- Maps to sat_questions for GET /api/sat/practice-questions?section=math&domains=algebra&...
-- Tagging: domain = algebra (SAT Math "unit"); difficulty_tier from source; lesson sat_lid_001 in bank_item_id.
-- module_number = 0, set_number = 0 — practice-only (see 20260312399000_allow_practice_module_number.sql)
--
-- Schema note: supabase db dump was not run here (Docker unavailable). Columns match:
-- migrations 20260310100000_create_sat_questions.sql + section/passage + module 0 + bank_item_id below.

ALTER TABLE public.sat_questions ADD COLUMN IF NOT EXISTS bank_item_id TEXT;
-- One stable id per bank row; multiple NULLs still allowed for legacy rows.
CREATE UNIQUE INDEX IF NOT EXISTS sat_questions_bank_item_id_unique
  ON public.sat_questions (bank_item_id);

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
  'A car rental agency charges a flat daily fee of 45 plus 0.25 per mile driven. If a customer was charged a total of 95 for a one-day rental, which equation represents the number of miles, $m$, the customer drove?',
  '[{"id":"a","text":"$45m + 0.25 = 95$"},{"id":"b","text":"$0.25m + 45 = 95$"},{"id":"c","text":"$45.25m = 95$"},{"id":"d","text":"$0.25m - 45 = 95$"}]'::jsonb,
  'b',
  'To model this real-world scenario, we must identify the constant and variable components of the total cost.

The flat daily fee of 45 is a fixed value that does not change regardless of the distance traveled. The cost per mile is 0.25, which must be multiplied by the total number of miles driven, $m$. This creates the variable term $0.25m$.

The total charge is the sum of these two distinct parts: the variable mileage cost and the fixed daily fee. Setting this sum equal to the final bill of 95 gives us the linear equation:

$0.25m + 45 = 95$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_1'
),
  (
  'mcq',
  'math',
  'If $5x + 2 = 12$, what is the value of $15x + 6$?',
  '[{"id":"a","text":"24"},{"id":"b","text":"30"},{"id":"c","text":"36"},{"id":"d","text":"42"}]'::jsonb,
  'c',
  'Instead of solving for the variable $x$ and then substituting, we can utilize algebraic manipulation to find the value of the requested expression directly.

Observe the relationship between the given equation, $5x + 2 = 12$, and the expression we need to find, $15x + 6$. Notice that each term in the required expression is exactly three times the corresponding term in the given equation:

$3 × (5x) = 15x$

$3 × (2) = 6$

According to the properties of equality, if we multiply the entire left side of the equation by 3, we must also multiply the right side by 3 to maintain balance:

$3(5x + 2) = 3(12)$

$15x + 6 = 36$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_2'
),
  (
  'mcq',
  'math',
  'What value of $n$ satisfies the equation $6n + 180 = 540$?',
  '[{"id":"a","text":"60"},{"id":"b","text":"90"},{"id":"c","text":"120"},{"id":"d","text":"360"}]'::jsonb,
  'a',
  'To find the value of $n$, we isolate the variable by performing inverse operations in the reverse order of operations.

First, we address the addition of 180 by subtracting 180 from both sides of the equation:

$6n = 540 - 180$

$6n = 360$

Next, we isolate $n$ by undoing the multiplication by 6. We divide both sides of the equation by the coefficient 6:

$n = (360)/(6)$

$n = 60$

Substituting 60 back into the original equation ($6 × 60 + 180 = 360 + 180 = 540$) confirms the solution.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_3'
),
  (
  'mcq',
  'math',
  '$12x - 5x + 140 = 280$. What value of $x$ is the solution to the given equation?',
  '[{"id":"a","text":"20"},{"id":"b","text":"40"},{"id":"c","text":"70"},{"id":"d","text":"140"}]'::jsonb,
  'a',
  'The first step in solving this linear equation is to simplify the left side by combining like terms. Like terms are terms that contain the same variable raised to the same power.

Subtracting $5x$ from $12x$ results in $7x$:

$7x + 140 = 280$

Now, we isolate the variable term by subtracting 140 from both sides:

$7x = 280 - 140$

$7x = 140$

Finally, we divide both sides by 7 to solve for $x$:

$x = (140)/(7) = 20$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_4'
),
  (
  'mcq',
  'math',
  '$(k + 9) + 21 = 50$. What value of $k$ is the solution to the given equation?',
  '[{"id":"a","text":"20"},{"id":"b","text":"29"},{"id":"c","text":"38"},{"id":"d","text":"41"}]'::jsonb,
  'a',
  'Because the operations on the left side of the equation consist only of addition, the parentheses around the expression $(k + 9)$ can be removed without affecting the value.

The equation simplifies to:

$k + 9 + 21 = 50$

Next, we combine the constant terms on the left side:

$k + 30 = 50$

To isolate $k$, we subtract 30 from both sides of the equation:

$k = 50 - 30$

$k = 20$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_5'
),
  (
  'mcq',
  'math',
  'If $4x - 24 = 16$, what is the value of $x - 6$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"40"}]'::jsonb,
  'a',
  'SAT questions often reward students for noticing patterns that bypass solving for the variable $x$.

Observe the left side of the equation, $4x - 24$. Both terms are divisible by 4. If we factor out 4, we can rewrite the equation as:

$4(x - 6) = 16$

Since the question specifically asks for the value of the expression $x - 6$, we can isolate that expression by dividing both sides of the equation by 4:

$(4(x - 6))/(4) = (16)/(4)$

$x - 6 = 4$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_6'
),
  (
  'mcq',
  'math',
  '$6(2x - 5) = 42$. Which equation has the same solution?',
  '[{"id":"a","text":"$2x - 5 = 7$"},{"id":"b","text":"$2x - 5 = 36$"},{"id":"c","text":"$12x - 5 = 42$"},{"id":"d","text":"$12x - 30 = 7$"}]'::jsonb,
  'a',
  'To find an equivalent equation with the same solution, we can perform operations that preserve the equality.

The original equation states that 6 is multiplied by the quantity $(2x - 5)$. We can undo this multiplication by dividing both sides of the equation by 6:

$(6(2x - 5))/(6) = (42)/(6)$

$2x - 5 = 7$

This simplified version will yield the same value for $x$ as the original equation.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_7'
),
  (
  'mcq',
  'math',
  'A fuel tank contained 12,000 gallons of oil. A pump removes oil at a constant rate. After 3 hours, 10,500 gallons remain. At this rate, how many total hours will the pump have run when 7,000 gallons remain?',
  '[{"id":"a","text":"8"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"15"}]'::jsonb,
  'b',
  'First, we must determine the constant rate at which the oil is being removed. In the first 3 hours, the amount of oil decreased from 12,000 to 10,500 gallons:

$12,000 - 10,500 = 1,500$ gallons removed.

Dividing this loss by the time elapsed gives the removal rate:

$1,500 ÷ 3 = 500$ gallons per hour.

Next, we calculate the total amount of oil that needs to be removed from the initial quantity to reach the target of 7,000 gallons:

$12,000 - 7,000 = 5,000$ gallons.

Finally, we divide the total required loss by the hourly rate to find the total time:

$5,000 ÷ 500 = 10$ hours.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_001_8'
),
  (
  'mcq',
  'math',
  'If $3x + 4 = 13$, what is the value of $6x + 5$?',
  '[{"id":"a","text":"18"},{"id":"b","text":"23"},{"id":"c","text":"26"},{"id":"d","text":"31"}]'::jsonb,
  'b',
  'We can find the value of $x$ first. Subtracting 4 from 13 gives:

$3x = 9 → x = 3$

Now, we substitute $x = 3$ into the second expression:

$6(3) + 5 = 18 + 5 = 23$

Alternatively, we can notice that $6x$ is twice $3x$. If $3x = 9$, then $6x = 18$. Adding 5 to this value results in 23.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_9'
),
  (
  'mcq',
  'math',
  '$8x + 16 = 176$. What is the solution to the given equation?',
  '[{"id":"a","text":"20"},{"id":"b","text":"22"},{"id":"c","text":"24"},{"id":"d","text":"160"}]'::jsonb,
  'a',
  'To solve for $x$, we first isolate the variable term by subtracting 16 from both sides of the equation:

$8x = 176 - 16$

$8x = 160$

Next, we divide both sides by the coefficient 8:

$x = (160)/(8) = 20$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_10'
),
  (
  'mcq',
  'math',
  'A freelancer charged 400 for a project. This included a 100 research fee and $h$ hours of editing at 60 per hour. Which equation represents this?',
  '[{"id":"a","text":"$100h + 60 = 400$"},{"id":"b","text":"$60h + 100 = 400$"},{"id":"c","text":"$160h = 400$"},{"id":"d","text":"$60h - 100 = 400$"}]'::jsonb,
  'b',
  'The total cost of the project is made up of a one-time fixed fee and a variable cost based on time.

The fixed research fee is 100. The variable editing cost is the product of the hourly rate (60) and the number of hours ($h$), which is $60h$.

Combining these two parts to equal the total project cost gives:

$60h + 100 = 400$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_11'
),
  (
  'mcq',
  'math',
  'If $7x - 49 = 28$, what is the value of $x - 7$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"7"},{"id":"c","text":"11"},{"id":"d","text":"28"}]'::jsonb,
  'a',
  'We can find the answer efficiently by factoring the left side of the equation. Since 7 is a common factor of $7x$ and 49, we can rewrite the equation as:

$7(x - 7) = 28$

To isolate the expression $x - 7$, divide both sides by 7:

$x - 7 = (28)/(7) = 4$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_12'
),
  (
  'mcq',
  'math',
  '$15x - 11x + 30 = 110$. What is the value of $x$?',
  '[{"id":"a","text":"20"},{"id":"b","text":"40"},{"id":"c","text":"80"},{"id":"d","text":"140"}]'::jsonb,
  'a',
  'First, simplify the left side of the equation by combining the like $x$ terms:

$4x + 30 = 110$

Subtract 30 from both sides to isolate the $4x$ term:

$4x = 80$

Finally, divide by 4:

$x = 20$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_13'
),
  (
  'mcq',
  'math',
  '$(y - 8) + 12 = 34$. What is $y$?',
  '[{"id":"a","text":"30"},{"id":"b","text":"38"},{"id":"c","text":"42"},{"id":"d","text":"54"}]'::jsonb,
  'a',
  'Remove the parentheses and simplify the left side by combining the numbers $-8$ and $+12$:

$y + 4 = 34$

Subtract 4 from both sides:

$y = 30$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_14'
),
  (
  'mcq',
  'math',
  'If $2x + 1 = 6$, what is the value of $10x + 5$?',
  '[{"id":"a","text":"25"},{"id":"b","text":"30"},{"id":"c","text":"35"},{"id":"d","text":"40"}]'::jsonb,
  'b',
  'Observe the relationship between $2x + 1$ and $10x + 5$. Each term in the second expression is five times larger than the corresponding term in the first.

$5 × (2x + 1) = 10x + 5$

Multiply the entire original equation by 5:

$5(2x + 1) = 5(6)$

$10x + 5 = 30$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_15'
),
  (
  'mcq',
  'math',
  '$3(4x + 5) = 39$. Which has the same solution?',
  '[{"id":"a","text":"$4x + 5 = 13$"},{"id":"b","text":"$4x + 5 = 36$"},{"id":"c","text":"$12x + 5 = 39$"},{"id":"d","text":"$12x + 15 = 13$"}]'::jsonb,
  'a',
  'Divide both sides of the original equation by the factor of 3 to simplify the left side:

$(3(4x + 5))/(3) = (39)/(3)$

$4x + 5 = 13$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_16'
),
  (
  'mcq',
  'math',
  'A storage unit drains water at 60 liters per hour. Initially, it had 2,000 liters. After $h$ hours, 1,400 liters remain. How many total hours have passed?',
  '[{"id":"a","text":"8"},{"id":"b","text":"10"},{"id":"c","text":"12"},{"id":"d","text":"15"}]'::jsonb,
  'b',
  'Total water removed = $2,000 - 1,400 = 600$ liters.

Given the drain rate is 60 liters per hour, we can set up the equation:

$60h = 600$

Divide by 60:

$h = 10$',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_001_17'
),
  (
  'mcq',
  'math',
  'What value of $p$ satisfies $9p + 270 = 900$?',
  '[{"id":"a","text":"70"},{"id":"b","text":"100"},{"id":"c","text":"130"},{"id":"d","text":"630"}]'::jsonb,
  'a',
  'Subtract 270 from both sides:

$9p = 630$

Divide by 9:

$p = 70$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_18'
),
  (
  'mcq',
  'math',
  'If $12x - 48 = 24$, what is the value of $3x - 12$?',
  '[{"id":"a","text":"6"},{"id":"b","text":"12"},{"id":"c","text":"18"},{"id":"d","text":"24"}]'::jsonb,
  'a',
  'Each term in the expression $3x - 12$ is one-fourth of the terms in $12x - 48$.

Divide the entire equation by 4:

$(12x - 48)/(4) = (24)/(4)$

$3x - 12 = 6$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_19'
),
  (
  'mcq',
  'math',
  '$18x + 10 = 190$. What is $x$?',
  '[{"id":"a","text":"10"},{"id":"b","text":"12"},{"id":"c","text":"15"},{"id":"d","text":"180"}]'::jsonb,
  'a',
  'Subtract 10:

$18x = 180$

Divide by 18:

$x = 10$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_20'
),
  (
  'mcq',
  'math',
  'A caterer charges 150 for delivery plus 30 per guest. If the total bill was 750, how many guests, $g$, were there?',
  '[{"id":"a","text":"$30g + 150 = 750$"},{"id":"b","text":"$150g + 30 = 750$"},{"id":"c","text":"$180g = 750$"},{"id":"d","text":"$30g = 750$"}]'::jsonb,
  'a',
  'Total Cost = (Rate $×$ guests) + Delivery Fee

Total = $30g + 150$.

Given total is 750:

$30g + 150 = 750$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_21'
),
  (
  'mcq',
  'math',
  'If $4x + 1 = 13$, what is $12x - 5$?',
  '[{"id":"a","text":"31"},{"id":"b","text":"34"},{"id":"c","text":"39"},{"id":"d","text":"44"}]'::jsonb,
  'a',
  'Solve for $4x$:

$4x = 12$

Find $12x$ by multiplying $4x$ by 3:

$12x = 3 × 12 = 36$

Subtract 5:

$36 - 5 = 31$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_22'
),
  (
  'mcq',
  'math',
  '$6x + 2x + 15 = 95$. Value of $x$?',
  '[{"id":"a","text":"10"},{"id":"b","text":"12"},{"id":"c","text":"15"},{"id":"d","text":"80"}]'::jsonb,
  'a',
  'Combine terms:

$8x + 15 = 95$

Subtract 15:

$8x = 80$

Divide by 8:

$x = 10$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_23'
),
  (
  'mcq',
  'math',
  '$(w + 12) - 15 = 5$. What is $w$?',
  '[{"id":"a","text":"8"},{"id":"b","text":"12"},{"id":"c","text":"15"},{"id":"d","text":"20"}]'::jsonb,
  'a',
  'Simplify left side:

$w - 3 = 5$

Add 3:

$w = 8$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_24'
),
  (
  'mcq',
  'math',
  '$3(x - 5) = 15$. Same solution as?',
  '[{"id":"a","text":"$x - 5 = 5$"},{"id":"b","text":"$x - 5 = 12$"},{"id":"c","text":"$3x - 5 = 15$"},{"id":"d","text":"$3x - 15 = 5$"}]'::jsonb,
  'a',
  'Divide by 3:

$x - 5 = 5$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_25'
),
  (
  'spr',
  'math',
  'Solve for $x$: $0.2x + 4 = 12$.',
  NULL,
  '40',
  'Isolate the decimal term by subtracting 4:

$0.2x = 8$

Divide by 0.2 (which is the same as multiplying by 5):

$x = 40$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_26'
),
  (
  'spr',
  'math',
  '$4(x + 2) = 2x + 14$. What is $x$?',
  NULL,
  '3',
  'Distribute the 4:

$4x + 8 = 2x + 14$

Group $x$ terms on left:

$2x + 8 = 14$

Subtract 8:

$2x = 6 → x = 3$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_27'
),
  (
  'spr',
  'math',
  'If $x/5 + 10 = 13$, what is $x$?',
  NULL,
  '15',
  'Subtract 10:

$x/5 = 3$

Multiply by 5:

$x = 15$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_28'
),
  (
  'spr',
  'math',
  '$8x - 10 = 5x + 11$. Value of $x$?',
  NULL,
  '7',
  'Subtract $5x$ and add 10:

$3x = 21$

Divide by 3:

$x = 7$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_29'
),
  (
  'spr',
  'math',
  '$2(x - 5) + 6 = 12$. What is $x$?',
  NULL,
  '8',
  'Distribute:

$2x - 10 + 6 = 12$

Simplify:

$2x - 4 = 12$

Add 4:

$2x = 16 → x = 8$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_30'
),
  (
  'spr',
  'math',
  'If $x/4 = 8$, what is $3x$?',
  NULL,
  '96',
  'Solve for $x$:

$x = 32$

Multiply by 3:

$3 × 32 = 96$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_31'
),
  (
  'spr',
  'math',
  '$6x + 15 = 3$. What is $x$?',
  NULL,
  '-2',
  'Subtract 15:

$6x = -12$

Divide by 6:

$x = -2$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_32'
),
  (
  'spr',
  'math',
  'Solve for $m$: $5m/2 = 15$.',
  NULL,
  '6',
  'Multiply by 2:

$5m = 30$

Divide by 5:

$m = 6$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_33'
),
  (
  'spr',
  'math',
  '$25 - x = 2x + 4$. What is $x$?',
  NULL,
  '7',
  'Add $x$:

$25 = 3x + 4$

Subtract 4:

$21 = 3x → x = 7$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_34'
),
  (
  'spr',
  'math',
  'If $5(x + 1) = 25$, what is $x + 1$?',
  NULL,
  '5',
  'Divide by 5:

$x + 1 = 5$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_35'
),
  (
  'spr',
  'math',
  '$0.4x = 10$. What is $x$?',
  NULL,
  '25',
  'Divide by 0.4:

$x = 25$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_36'
),
  (
  'spr',
  'math',
  '$5x + 3x - 10 = 30$. What is $x$?',
  NULL,
  '5',
  'Combine:

$8x - 10 = 30$

Add 10:

$8x = 40 → x = 5$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_37'
),
  (
  'spr',
  'math',
  'If $12 - 4x = 28$, what is $x$?',
  NULL,
  '-4',
  'Subtract 12:

$-4x = 16$

Divide by -4:

$x = -4$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_38'
),
  (
  'spr',
  'math',
  '$4(x - 2) = x + 7$. What is $x$?',
  NULL,
  '5',
  'Distribute:

$4x - 8 = x + 7$

Subtract $x$ and add 8:

$3x = 15 → x = 5$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_39'
),
  (
  'spr',
  'math',
  '$x/3 - 4 = 1$. What is $x$?',
  NULL,
  '15',
  'Add 4:

$x/3 = 5$

Multiply by 3:

$x = 15$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_40'
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

$8/2 = 4$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_41'
),
  (
  'spr',
  'math',
  '$20 - (x + 5) = 10$. What is $x$?',
  NULL,
  '5',
  'Distribute negative:

$20 - x - 5 = 10$

Simplify:

$15 - x = 10 → x = 5$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_42'
),
  (
  'spr',
  'math',
  '$9x + 4 = 6x + 19$. Value of $x$?',
  NULL,
  '5',
  'Subtract $6x$:

$3x + 4 = 19$

Subtract 4:

$3x = 15 → x = 5$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_43'
),
  (
  'spr',
  'math',
  '$5(2x - 8) = 0$. What is $x$?',
  NULL,
  '4',
  'The quantity in parentheses must be 0:

$2x - 8 = 0$

$2x = 8 → x = 4$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_44'
),
  (
  'spr',
  'math',
  'If $x + x + x + x + x = 25$, what is $2x$?',
  NULL,
  '10',
  'Combine:

$5x = 25 → x = 5$

Multiply:

$2(5) = 10$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_45'
),
  (
  'spr',
  'math',
  'Solve: $1.2x + 0.3x = 3$.',
  NULL,
  '2',
  'Combine:

$1.5x = 3$

Divide by 1.5:

$x = 2$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_46'
),
  (
  'spr',
  'math',
  'If $4x = 16$, what is $4x + 9$?',
  NULL,
  '25',
  'Substitute:

$16 + 9 = 25$',
  'algebra',
  'easy',
  0,
  0,
  'sat_lid_001_47'
),
  (
  'mcq',
  'math',
  '$5(x + 3) = 5x + 15$. How many solutions?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'c',
  'Distribute:

$5x + 15 = 5x + 15$

Identical sides mean infinite solutions.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_001_48'
),
  (
  'mcq',
  'math',
  '$4x + 1 = 4x + 9$. How many solutions?',
  '[{"id":"a","text":"Zero"},{"id":"b","text":"Exactly one"},{"id":"c","text":"Infinitely many"},{"id":"d","text":"Exactly two"}]'::jsonb,
  'a',
  'Subtract $4x$:

$1 = 9$

Impossible statement means zero solutions.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_001_49'
),
  (
  'spr',
  'math',
  'If $1/5 x + 2/5 x = 9$, what is $x$?',
  NULL,
  '15',
  'Combine:

$3/5 x = 9$

Multiply by 5/3:

$x = 15$',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_001_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

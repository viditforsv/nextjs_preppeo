-- Practice-mode math from lid_006.tex (sat_lid_006)
-- Chapter: Linear equations in two variables | Topic: Interpreting Linear Models
-- sat_questions: section=math, domain=algebra, bank_item_id=sat_lid_006_N, practice module/set 0.
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
  'The total cost $C$, in dollars, to rent a surfboard for $h$ hours is given by the function $C(h) = 15h + 25$. What is the best interpretation of the value 25 in this context?',
  '[{"id":"a","text":"The cost to rent the surfboard for each additional hour."},{"id":"b","text":"The total number of hours the surfboard was rented."},{"id":"c","text":"The minimum cost to rent the surfboard regardless of the duration."},{"id":"d","text":"The maximum cost a customer would pay for a rental."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In a linear model of the form $y = mx + b$, the constant term $b$ represents the value of the dependent variable when the independent variable is zero. In real-world rental scenarios, this is typically referred to as a "flat fee," "deposit," or "service charge" that must be paid regardless of how much time passes.

\\textbf{Calculation and Logic:}

If we set $h = 0$ in the equation:

\\[C(0) = 15(0) + 25 = 25\\]

This confirms that before any hours are even used, the cost is already 25. Therefore, 25 represents the initial, fixed cost of the rental.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_1'
),
  (
  'spr',
  'math',
  'The height of a certain tree, $H$, in inches, can be modeled by the equation $H = 4.5y + 36$, where $y$ is the number of years since it was planted. According to the model, how many inches does the tree grow each year?',
  NULL,
  '4.5',
  '\\textbf{Conceptual Explanation:}

The growth of the tree over time is represented by the rate of change in the linear equation. In the form $y = mx + b$, the slope $m$ describes how much the dependent variable changes for every one-unit increase in the independent variable.

\\textbf{Calculation and Logic:}

Looking at the equation $H = 4.5y + 36$, the variable $y$ (years) is multiplied by 4.5.

\\[\\text{Rate of change} = (\\Delta H)/(\\Delta y) = 4.5\\]

This means for every year that passes ($y$ increases by 1), the height $H$ increases by 4.5 inches.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_2'
),
  (
  'mcq',
  'math',
  '$n = 1,200 - 40d$ The equation above models the number of laptops, $n$, remaining in a warehouse after $d$ days of sales. Which of the following is the best interpretation of the value 40 in this equation?',
  '[{"id":"a","text":"The initial number of laptops in the warehouse."},{"id":"b","text":"The number of days it takes to sell all the laptops."},{"id":"c","text":"The number of laptops sold each day."},{"id":"d","text":"The total number of laptops sold after $d$ days."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In this model, the number of laptops is decreasing over time. The negative coefficient in front of the variable $d$ indicates the rate at which the inventory is being depleted.

\\textbf{Calculation and Logic:}

The slope of the equation is -40.

\\[\\text{Slope} = \\frac{\\text{Change in laptops}}{\\text{Change in days}} = -40\\]

This means that for every 1 day that passes, the inventory $n$ decreases by 40. Therefore, 40 represents the daily sales rate of the laptops.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_3'
),
  (
  'spr',
  'math',
  'A plumber charges a one-time fee of 60 plus an hourly rate of x. If a 3-hour job costs 225, what is the value of $x$?',
  NULL,
  '55',
  '\\textbf{Conceptual Explanation:}

We can model the plumber''s total charges using a linear equation where the total cost is the sum of the fixed call-out fee and the variable hourly charges.

\\textbf{Calculation and Logic:}

Let the total cost be $T$. The model is:

\\[T = xh + 60\\]

We are given that when $h = 3$, $T = 225$. We substitute these values into the equation:

\\[225 = 3x + 60\\]

Subtract 60 from both sides:

\\[165 = 3x\\]

Divide by 3:

\\[x = 55\\]

The hourly rate $x$ is 55.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_4'
),
  (
  'mcq',
  'math',
  '$V(t) = 25,000 - 2,500t$ The function above models the value of a car, $V$, in dollars, $t$ years after it was purchased. What is the interpretation of the $t$-intercept of the graph of this function in the $ty$-plane?',
  '[{"id":"a","text":"The purchase price of the car."},{"id":"b","text":"The annual decrease in the car''s value."},{"id":"c","text":"The number of years until the car has no monetary value."},{"id":"d","text":"The value of the car after 10 years."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The $t$-intercept occurs when the dependent variable ($V$) is zero. In the context of value over time, this point represents the specific time at which the asset is worth nothing.

\\textbf{Calculation and Logic:}

Set $V(t) = 0$ and solve for $t$:

\\[0 = 25,000 - 2,500t\\]

\\[2,500t = 25,000\\]

\\[t = (25,000)/(2,500) = 10\\]

At $t = 10$, the value is 0. Thus, the $t$-intercept represents the time it takes for the car''s value to drop to zero.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_5'
),
  (
  'spr',
  'math',
  'A moving company charges a flat fee of 150 to rent a truck plus 0.75 per mile driven. If a customer was charged a total of 210, how many miles did they drive?',
  NULL,
  '80',
  '\\textbf{Conceptual Explanation:}

The relationship between total cost and distance driven is linear. The flat fee is our constant, and the cost per mile is our slope.

\\textbf{Calculation and Logic:}

Let $m$ be the number of miles. The equation is:

\\[\\text{Total Cost} = 0.75m + 150\\]

We set the total cost to 210:

\\[210 = 0.75m + 150\\]

Subtract 150 from both sides:

\\[60 = 0.75m\\]

Divide by 0.75 (which is the same as multiplying by 4/3):

\\[m = 80\\]

The customer drove 80 miles.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_6'
),
  (
  'mcq',
  'math',
  '$P = 14.7 + 0.44d$ The total pressure $P$, in pounds per square inch, at a depth of $d$ feet below the surface of the ocean is given by the equation above. Which statement is the best interpretation of the value 14.7 in this context?',
  '[{"id":"a","text":"The pressure at the surface of the ocean."},{"id":"b","text":"The increase in pressure for every 1 foot of depth."},{"id":"c","text":"The depth at which the pressure is zero."},{"id":"d","text":"The maximum pressure the ocean can exert."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In this linear model, $d$ represents depth. The value 14.7 is the constant term (y-intercept). This value represents the pressure when the depth is zero (at the surface).

\\textbf{Calculation and Logic:}

If we let $d = 0$:

\\[P = 14.7 + 0.44(0) = 14.7\\]

Since a depth of 0 feet describes the surface level, 14.7 is the atmospheric pressure at the ocean''s surface.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_7'
),
  (
  'spr',
  'math',
  'A candle is 12 inches tall when it is lit. Every hour it burns, the height decreases by 0.75 inches. After how many hours will the candle be 6 inches tall?',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

The height of the candle is a linear function of time. The initial height is our starting value, and the burn rate is our negative slope.

\\textbf{Calculation and Logic:}

Let $h$ be the height and $t$ be the hours:

\\[h = 12 - 0.75t\\]

We want to find $t$ when $h = 6$:

\\[6 = 12 - 0.75t\\]

Subtract 12 from both sides:

\\[-6 = -0.75t\\]

Divide by -0.75:

\\[t = (6)/(0.75) = 8\\]

It will take 8 hours for the candle to reach 6 inches.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_8'
),
  (
  'mcq',
  'math',
  '$S = 15 + 0.2(T - 60)$ The speed of sound $S$, in meters per second, depends on the air temperature $T$, in degrees Celsius. The equation above is valid for temperatures above 60 degrees. Which of the following is the best interpretation of the value 0.2 in this context?',
  '[{"id":"a","text":"The speed of sound when the temperature is 60 degrees."},{"id":"b","text":"The temperature at which the speed of sound is 15 meters per second."},{"id":"c","text":"The increase in the speed of sound for each 1 degree increase in temperature."},{"id":"d","text":"The temperature at which sound cannot travel."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In the linear form $y = m(x - x_1) + y_1$, the value $m$ is the slope. The slope represents the rate of change of the dependent variable (Speed) with respect to the independent variable (Temperature).

\\textbf{Calculation and Logic:}

If we distribute the 0.2, the equation becomes $S = 0.2T + \\text{constant}$.

The coefficient 0.2 is the slope.

\\[\\text{Slope} = (\\Delta S)/(\\Delta T) = 0.2\\]

This means for every 1 degree increase in temperature, the speed of sound increases by 0.2 meters per second.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_9'
),
  (
  'spr',
  'math',
  'A bank account starts with 500. Every month, 75 is deposited into the account. If no other transactions occur, how many months will it take for the balance to reach 1,400?',
  NULL,
  '12',
  '\\textbf{Conceptual Explanation:}

The account balance grows linearly. The starting amount is the y-intercept, and the monthly deposit is the slope.

\\textbf{Calculation and Logic:}

Let $B$ be the balance and $m$ be the months:

\\[B = 75m + 500\\]

Set $B = 1,400$:

\\[1,400 = 75m + 500\\]

Subtract 500:

\\[900 = 75m\\]

Divide by 75:

\\[m = 12\\]

It will take 12 months to reach 1,400.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_10'
),
  (
  'mcq',
  'math',
  '$A = 1,500 + 20t$ A construction manager uses the equation above to estimate the total cost $A$, in dollars, for a project that takes $t$ hours of labor. What does the value 1,500 represent?',
  '[{"id":"a","text":"The hourly rate for labor."},{"id":"b","text":"the total cost if no labor is required."},{"id":"c","text":"The number of workers on the project."},{"id":"d","text":"The maximum budget for the project."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The 1,500 is the constant term in the linear model. It is the cost associated with the project before any labor hours are added.

\\textbf{Calculation and Logic:}

Setting $t = 0$:

\\[A = 1,500 + 20(0) = 1,500\\]

This 1,500 could represent equipment fees or materials—costs that are fixed and do not depend on the hours of work.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_11'
),
  (
  'spr',
  'math',
  '$y = 0.15x + 2.50$ The cost $y$, in dollars, for a long-distance phone call lasts $x$ minutes. If a call costs 6.10, how many minutes did the call last?',
  NULL,
  '24',
  '\\textbf{Conceptual Explanation:}

This is a standard linear model where 2.50 is the connection fee and 0.15 is the price per minute.

\\textbf{Calculation and Logic:}

\\[6.10 = 0.15x + 2.50\\]

Subtract 2.50:

\\[3.60 = 0.15x\\]

Divide by 0.15:

\\[x = 24\\]

The call lasted 24 minutes.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_12'
),
  (
  'mcq',
  'math',
  '$w = 150 - 2.5t$ The weight $w$, in pounds, of a block of ice $t$ hours after it began melting is given by the equation above. What is the interpretation of the value 2.5?',
  '[{"id":"a","text":"The initial weight of the ice block."},{"id":"b","text":"The weight of the block after 1 hour."},{"id":"c","text":"The amount of weight the ice block loses each hour."},{"id":"d","text":"The time it takes for the ice block to melt completely."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The value 2.5 is the coefficient of the time variable $t$. Because it is being subtracted, it represents a rate of loss or decrease.

\\textbf{Calculation and Logic:}

The slope $m = -2.5$. This indicates that for every 1-hour increase in $t$, the weight $w$ decreases by 2.5 pounds.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_13'
),
  (
  'spr',
  'math',
  'A car''s gas tank contains 15 gallons of fuel. The car consumes 0.04 gallons of fuel for every mile driven. How many miles can the car travel before it has only 5 gallons remaining?',
  NULL,
  '250',
  '\\textbf{Conceptual Explanation:}

The amount of fuel is a decreasing linear function of distance. We start at 15 and subtract the fuel used per mile.

\\textbf{Calculation and Logic:}

Let $g$ be gallons and $m$ be miles:

\\[g = 15 - 0.04m\\]

Set $g = 5$:

\\[5 = 15 - 0.04m\\]

\\[-10 = -0.04m\\]

Divide by -0.04 (which is the same as dividing by -1/25, or multiplying by -25):

\\[m = 250\\]

The car can travel 250 miles.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_14'
),
  (
  'mcq',
  'math',
  '$T = 72 + 1.5h$ The temperature $T$, in degrees Fahrenheit, in a room $h$ hours after a heater is turned on is given by the equation above. Which of the following is the best interpretation of the value 72?',
  '[{"id":"a","text":"The temperature of the room when the heater was turned on."},{"id":"b","text":"The rate at which the temperature is increasing."},{"id":"c","text":"The temperature of the room after 1 hour."},{"id":"d","text":"The maximum temperature the room can reach."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The value 72 is the constant term. In time-based models, the constant term represents the starting state (where $h=0$).

\\textbf{Calculation and Logic:}

At $h = 0$, $T = 72 + 1.5(0) = 72$. This is the initial temperature.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_15'
),
  (
  'spr',
  'math',
  'A subscription service costs 12 per month. A new member joins and pays a 30 sign-up fee. If the member has paid a total of 150 so far, for how many months have they been a member?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

Total cost equals the sign-up fee plus the product of the monthly rate and the number of months.

\\textbf{Calculation and Logic:}

Let $m$ be the months:

\\[12m + 30 = 150\\]

Subtract 30:

\\[12m = 120\\]

Divide by 12:

\\[m = 10\\]

The membership has lasted 10 months.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_16'
),
  (
  'mcq',
  'math',
  '$y = 100 + 4x$ A salesperson earns a base salary plus a commission for every unit sold. The equation above models the salesperson''s daily earnings $y$, in dollars, for selling $x$ units. What does the slope of the graph of this equation represent?',
  '[{"id":"a","text":"The salesperson''s base daily salary."},{"id":"b","text":"The number of units the salesperson sells each day."},{"id":"c","text":"The commission earned for each unit sold."},{"id":"d","text":"The total earnings after selling $x$ units."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The slope is the coefficient of $x$. It represents the rate at which the total earnings increase per unit sold.

\\textbf{Calculation and Logic:}

Slope = 4.

This means for every 1 unit increase in $x$, earnings $y$ increase by 4. This "per unit" increase is the definition of a commission.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_17'
),
  (
  'spr',
  'math',
  'A balloon is released from a height of 5 feet and rises at a constant rate of 2 feet per second. After how many seconds will the balloon be 25 feet above the ground?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

Height is a linear function of time. We start at 5 and add the product of speed and time.

\\textbf{Calculation and Logic:}

\\[H = 2t + 5\\]

Set $H = 25$:

\\[25 = 2t + 5\\]

\\[20 = 2t\\]

\\[t = 10\\]

The balloon reaches 25 feet after 10 seconds.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_18'
),
  (
  'mcq',
  'math',
  '$G = 12 - 0.05d$ The amount of gas $G$, in gallons, remaining in a car''s tank after driving $d$ miles is modeled by the equation above. What does the $d$-intercept of the graph represent?',
  '[{"id":"a","text":"The car''s fuel efficiency in miles per gallon."},{"id":"b","text":"The maximum distance the car can drive on a full tank."},{"id":"c","text":"The initial amount of gas in the tank."},{"id":"d","text":"The distance driven when the tank is half full."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The $d$-intercept occurs when the amount of gas $G$ is zero. This point indicates how many miles can be driven until the fuel is completely gone.

\\textbf{Calculation and Logic:}

Set $G = 0$:

\\[0 = 12 - 0.05d\\]

\\[0.05d = 12\\]

\\[d = (12)/(0.05) = 240\\]

The car can drive 240 miles on a full tank.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_19'
),
  (
  'spr',
  'math',
  'A water tank starts with 100 gallons. A pump begins removing water at a rate of 4 gallons per minute. How many minutes will it take for the tank to have exactly 20 gallons left?',
  NULL,
  '20',
  '\\textbf{Conceptual Explanation:}

The volume of water is decreasing linearly over time.

\\textbf{Calculation and Logic:}

Let $V$ be volume and $t$ be time:

\\[V = 100 - 4t\\]

Set $V = 20$:

\\[20 = 100 - 4t\\]

\\[-80 = -4t\\]

\\[t = 20\\]

It will take 20 minutes.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_20'
),
  (
  'mcq',
  'math',
  '$L = 0.5w + 10$ The length $L$, in inches, of a spring is a linear function of the weight $w$, in pounds, attached to it. What does the value 0.5 represent?',
  '[{"id":"a","text":"The length of the spring with no weight attached."},{"id":"b","text":"The total weight required to stretch the spring to 10 inches."},{"id":"c","text":"The increase in length for each 1 pound of weight attached."},{"id":"d","text":"The maximum weight the spring can hold."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The slope 0.5 indicates the rate of change of the spring''s length with respect to the weight applied.

\\textbf{Calculation and Logic:}

Slope = 0.5.

This means for every 1 pound of weight ($w$), the length ($L$) increases by 0.5 inches.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_21'
),
  (
  'spr',
  'math',
  'A rental car costs 40 per day plus 0.20 per mile. If a person rents the car for 2 days and the total bill is 110, how many miles did they drive?',
  NULL,
  '150',
  '\\textbf{Conceptual Explanation:}

The total cost is the daily fee times the number of days, plus the mileage fee.

\\textbf{Calculation and Logic:}

Daily fees: $40 × 2 = 80$.

Total Cost: $0.20m + 80$.

\\[110 = 0.20m + 80\\]

\\[30 = 0.20m\\]

\\[m = (30)/(0.20) = 150\\]

The person drove 150 miles.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_22'
),
  (
  'mcq',
  'math',
  '$C = 50 + 0.15n$ The total cost $C$, in dollars, to print $n$ copies of a flyer is given by the equation above. What is the interpretation of the value 0.15?',
  '[{"id":"a","text":"The setup fee for the printing job."},{"id":"b","text":"The total cost to print 50 copies."},{"id":"c","text":"The price to print each additional copy."},{"id":"d","text":"The maximum number of copies that can be printed."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The slope 0.15 is the coefficient of the number of copies. It represents the unit price.

\\textbf{Calculation and Logic:}

Slope = 0.15.

This means the cost increases by 0.15 for every 1 flyer ($n$) printed.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_23'
),
  (
  'spr',
  'math',
  '$y = 1.25x + 10$ A taxi service charges 10 as a base fare and 1.25 per mile. If a passenger''s fare was 35, how many miles was the trip?',
  NULL,
  '20',
  '\\textbf{Conceptual Explanation:}

We subtract the base fare from the total to find the mileage cost, then divide by the rate per mile.

\\textbf{Calculation and Logic:}

\\[35 = 1.25x + 10\\]

\\[25 = 1.25x\\]

\\[x = (25)/(1.25) = 20\\]

The trip was 20 miles.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_24'
),
  (
  'mcq',
  'math',
  '$H = 60 - 5t$ A container is being drained. The height $H$ of the liquid, in centimeters, $t$ minutes after the drain was opened is given by the equation above. What does the value 60 represent?',
  '[{"id":"a","text":"The rate at which the liquid is draining."},{"id":"b","text":"The time it takes for the container to empty."},{"id":"c","text":"The initial height of the liquid in the container."},{"id":"d","text":"The height of the liquid after 1 minute."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The constant term 60 represents the state of the system at time $t=0$.

\\textbf{Calculation and Logic:}

At $t = 0$:

\\[H = 60 - 5(0) = 60\\]

This is the starting height of the liquid.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_25'
),
  (
  'spr',
  'math',
  'A phone battery is at 100% and loses charge at a rate of 8% per hour while in use. After how many hours of use will the battery be at 20%?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

The battery percentage is a decreasing linear function of time.

\\textbf{Calculation and Logic:}

Let $P$ be percentage and $t$ be hours:

\\[P = 100 - 8t\\]

Set $P = 20$:

\\[20 = 100 - 8t\\]

\\[-80 = -8t\\]

\\[t = 10\\]

The battery will reach 20% after 10 hours.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_26'
),
  (
  'mcq',
  'math',
  '$y = mx + b$ In the linear equation above, $y$ is the total cost of a service and $x$ is the number of hours. If the service provider doubles their hourly rate but keeps the same flat fee, which of the following describes the change in the graph?',
  '[{"id":"a","text":"The y-intercept doubles."},{"id":"b","text":"The x-intercept doubles."},{"id":"c","text":"The slope doubles."},{"id":"d","text":"The graph shifts up by $m$ units."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The hourly rate is represented by the slope $m$. If the rate doubles, the slope must be multiplied by 2.

\\textbf{Calculation and Logic:}

Original: $y = mx + b$.

New: $y = (2m)x + b$.

The coefficient of $x$ (the slope) has doubled.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_27'
),
  (
  'spr',
  'math',
  'A hiker is at an elevation of 2,000 feet and begins descending at a constant rate of 400 feet per hour. What will the hiker''s elevation be after 3.5 hours?',
  NULL,
  '600',
  '\\textbf{Conceptual Explanation:}

Elevation is the starting height minus the total descent (rate $×$ time).

\\textbf{Calculation and Logic:}

\\[E = 2,000 - 400(3.5)\\]

\\[400 × 3.5 = 1,400\\]

\\[E = 2,000 - 1,400 = 600\\]

The elevation will be 600 feet.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_28'
),
  (
  'mcq',
  'math',
  '$A = 500(1 + 0.05t)$ The amount of money $A$ in a simple interest savings account after $t$ years is given by the equation above. What is the interpretation of the value 0.05 in this context?',
  '[{"id":"a","text":"The initial deposit in the account."},{"id":"b","text":"The annual interest rate as a decimal."},{"id":"c","text":"The total interest earned after $t$ years."},{"id":"d","text":"The amount of money added to the account each year."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

If we distribute the 500, the equation becomes $A = 500 + 25t$. Here, 25 is the annual interest. However, in the factored form, the value 0.05 is the percentage of the principal added per year.

\\textbf{Calculation and Logic:}

In the formula for simple interest $A = P(1 + rt)$, $r$ represents the interest rate. Therefore, 0.05 is the interest rate (5%).',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_29'
),
  (
  'spr',
  'math',
  'A car rental company charges 35 per day. If a customer was charged 245, for how many days did they rent the car?',
  NULL,
  '7',
  '\\textbf{Conceptual Explanation:}

Since there is no mention of a flat fee, the total cost is simply the daily rate multiplied by the number of days.

\\textbf{Calculation and Logic:}

\\[245 = 35d\\]

\\[d = (245)/(35) = 7\\]

The car was rented for 7 days.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_30'
),
  (
  'mcq',
  'math',
  '$y = -0.8x + 12$ The amount of a medication $y$, in milligrams, remaining in a patient''s bloodstream $x$ hours after it was administered is modeled by the equation above. What does the value 12 represent?',
  '[{"id":"a","text":"The time it takes for the medication to be fully cleared."},{"id":"b","text":"The dosage of the medication administered."},{"id":"c","text":"The rate at which the medication is cleared from the blood."},{"id":"d","text":"The amount of medication after 1 hour."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The constant term 12 represents the amount of medication at time $x=0$, which is the moment it was administered.

\\textbf{Calculation and Logic:}

At $x = 0$, $y = 12$. This is the initial dosage.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_31'
),
  (
  'spr',
  'math',
  'A spring stretches 2 centimeters for every 5 kilograms of weight added. If the spring is initially 10 centimeters long, how long will it be with 15 kilograms of weight?',
  NULL,
  '16',
  '\\textbf{Conceptual Explanation:}

We first determine the rate of stretch per kilogram (the slope), then use the linear model.

\\textbf{Calculation and Logic:}

Rate = $2 / 5 = 0.4$ cm per kg.

Model: $L = 0.4w + 10$.

For $w = 15$:

\\[L = 0.4(15) + 10 = 6 + 10 = 16\\]

The spring will be 16 cm long.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_32'
),
  (
  'mcq',
  'math',
  '$y = 50x + 200$ A company''s daily production cost $y$ is modeled by the equation above, where $x$ is the number of units produced. If the company wants to decrease the cost per unit, which part of the equation should they target to change?',
  '[{"id":"a","text":"The value 50."},{"id":"b","text":"The value 200."},{"id":"c","text":"The variable $x$."},{"id":"d","text":"The variable $y$."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The "cost per unit" is the rate of change or the slope of the linear model.

\\textbf{Calculation and Logic:}

In $y = 50x + 200$, the 50 represents the cost added for each additional unit produced. To lower the cost per unit, this rate must be reduced.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_33'
),
  (
  'spr',
  'math',
  'A pool contains 5,000 gallons of water and is being filled at a rate of 15 gallons per minute. How many hours will it take to add 1,800 gallons of water?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

We need to find the time in minutes to add the specified volume, then convert that time into hours.

\\textbf{Calculation and Logic:}

Time in minutes: $1,800 / 15 = 120$ minutes.

Convert to hours: $120 / 60 = 2$ hours.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_34'
),
  (
  'mcq',
  'math',
  '$V = 1,000(0.8)^t$ While this is an exponential model, the SAT often asks to compare it to linear models. If the value decreased by a constant 200 each year instead of by 20%, which linear equation would model the value $V$ over time $t$?',
  '[{"id":"a","text":"$V = 1,000 - 0.2t$"},{"id":"b","text":"$V = 1,000 - 200t$"},{"id":"c","text":"$V = 200t + 1,000$"},{"id":"d","text":"$V = 1,000(200)t$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A "constant decrease" indicates a linear relationship where the decrease per year is the slope.

\\textbf{Calculation and Logic:}

Initial Value = 1,000.

Rate of change = -200.

Equation: $V = 1,000 - 200t$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_35'
),
  (
  'spr',
  'math',
  'A student has 400 pages left to read in a book. If the student reads 25 pages per day, after how many days will there be 150 pages left?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

Pages remaining is the total minus the pages read (rate $×$ days).

\\textbf{Calculation and Logic:}

\\[150 = 400 - 25d\\]

\\[-250 = -25d\\]

\\[d = 10\\]

It will take 10 days.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_36'
),
  (
  'mcq',
  'math',
  '$y = 0.5x + 10$ The equation above models the total weight $y$, in pounds, of a box containing $x$ books. What does the value 10 represent?',
  '[{"id":"a","text":"The weight of each book."},{"id":"b","text":"The total weight of the books."},{"id":"c","text":"The weight of the empty box."},{"id":"d","text":"The maximum capacity of the box."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The 10 is the weight when $x=0$, which means no books are in the box.

\\textbf{Calculation and Logic:}

At $x = 0$, $y = 10$. This is the "base" weight of the container itself.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_37'
),
  (
  'spr',
  'math',
  'An athlete runs 6 miles at a pace of 8 minutes per mile. What is the total time, in minutes, the athlete spends running?',
  NULL,
  '48',
  '\\textbf{Conceptual Explanation:}

Total time is the product of the rate (time per unit distance) and the total distance.

\\textbf{Calculation and Logic:}

\\[\\text{Time} = 8 \\text{ min/mile} × 6 \\text{ miles} = 48 \\text{ minutes}\\]',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_38'
),
  (
  'mcq',
  'math',
  '$T = 20 + 0.5(d - 100)$ The temperature $T$ of a substance increases once the pressure $d$ exceeds 100 units. What is the temperature of the substance when the pressure is exactly 100 units?',
  '[{"id":"a","text":"0"},{"id":"b","text":"20"},{"id":"c","text":"50"},{"id":"d","text":"100"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

We evaluate the function at the specific point $d = 100$.

\\textbf{Calculation and Logic:}

\\[T = 20 + 0.5(100 - 100)\\]

\\[T = 20 + 0.5(0) = 20\\]

The temperature is 20 units.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_39'
),
  (
  'spr',
  'math',
  'A car rental costs 120 for 3 days. What is the daily rate for the car rental?',
  NULL,
  '40',
  '\\textbf{Conceptual Explanation:}

The daily rate is the total cost divided by the number of days.

\\textbf{Calculation and Logic:}

\\[\\text{Rate} = 120 / 3 = 40\\]

The rate is 40 per day.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_40'
),
  (
  'mcq',
  'math',
  '$y = 1.5x + 3.0$ The price $y$ of a customized coffee depends on the number of extra toppings $x$. What is the base price of the coffee with no extra toppings?',
  '[{"id":"a","text":"1.50"},{"id":"b","text":"3.00"},{"id":"c","text":"4.50"},{"id":"d","text":"0.00"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Base price corresponds to the constant term in the linear equation.

\\textbf{Calculation and Logic:}

At $x = 0$, $y = 3.0$. The base price is 3.00.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_41'
),
  (
  'spr',
  'math',
  'A plane is at 30,000 feet and descends at a rate of 1,500 feet per minute. How many minutes will it take for the plane to reach 15,000 feet?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

We find the total descent needed and divide by the rate of descent.

\\textbf{Calculation and Logic:}

Total descent: $30,000 - 15,000 = 15,000$.

Time: $15,000 / 1,500 = 10$ minutes.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_42'
),
  (
  'mcq',
  'math',
  '$n = 450 - 15t$ The number of people $n$ in a theater $t$ minutes after a movie ends is given by the equation above. What does the value 15 represent?',
  '[{"id":"a","text":"The number of people in the theater when the movie ends."},{"id":"b","text":"The number of people who leave the theater each minute."},{"id":"c","text":"The time it takes for all people to leave."},{"id":"d","text":"The total number of minutes the movie lasted."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The value 15 is the rate of change. Because it is subtracted, it represents the rate of decrease.

\\textbf{Calculation and Logic:}

Slope = -15.

This means for every 1 minute that passes, 15 people leave the theater.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_43'
),
  (
  'spr',
  'math',
  'A gardener charges 25 to come to a house plus 15 per hour. If a job cost 85, how many hours did the gardener work?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

Subtract the travel fee from the total, then divide by the hourly rate.

\\textbf{Calculation and Logic:}

\\[85 = 15h + 25\\]

\\[60 = 15h\\]

\\[h = 4\\]

The gardener worked 4 hours.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_44'
),
  (
  'mcq',
  'math',
  '$y = 0.8x + b$ A salesperson''s earnings $y$ are a linear function of sales $x$. If the base salary increases, which part of the equation would change?',
  '[{"id":"a","text":"The value 0.8."},{"id":"b","text":"The variable $x$."},{"id":"c","text":"The value $b$."},{"id":"d","text":"The variable $y$."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Base salary is the constant income that does not depend on sales. This is represented by the y-intercept.

\\textbf{Calculation and Logic:}

In the model, $b$ is the earnings when $x = 0$. Therefore, $b$ is the base salary.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_45'
),
  (
  'spr',
  'math',
  'A car travels 300 miles on 12 gallons of gas. What is the car''s fuel efficiency in miles per gallon?',
  NULL,
  '25',
  '\\textbf{Conceptual Explanation:}

Fuel efficiency is the total distance divided by the total fuel consumed.

\\textbf{Calculation and Logic:}

Efficiency = $300 / 12 = 25$ mpg.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_46'
),
  (
  'mcq',
  'math',
  '$P = 100 - 0.5t$ The percentage $P$ of a project remaining to be completed $t$ hours after work began is given by the equation above. What does the $t$-intercept represent?',
  '[{"id":"a","text":"The total time required to finish the project."},{"id":"b","text":"The percentage of the project completed in 1 hour."},{"id":"c","text":"The initial amount of work required."},{"id":"d","text":"The time when half the project is done."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The $t$-intercept is when $P = 0$, meaning 0% of the project is remaining (it is finished).

\\textbf{Calculation and Logic:}

\\[0 = 100 - 0.5t\\]

\\[0.5t = 100\\]

\\[t = 200\\]

It takes 200 hours to finish the project.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_47'
),
  (
  'spr',
  'math',
  'A machine produces 120 parts per hour. How many parts does it produce in 15 minutes?',
  NULL,
  '30',
  '\\textbf{Conceptual Explanation:}

We convert the time from minutes to hours, then multiply by the production rate.

\\textbf{Calculation and Logic:}

15 minutes = $15 / 60 = 0.25$ hours.

Parts = $120 × 0.25 = 30$.',
  'algebra',
  'medium',
  0,
  0,
  'sat_lid_006_48'
),
  (
  'mcq',
  'math',
  '$S = 24,000 + 1,200n$ The salary $S$ of an employee depends on the number of years of experience $n$. Which of the following is the best interpretation of 1,200?',
  '[{"id":"a","text":"The starting salary of the employee."},{"id":"b","text":"The total salary after $n$ years."},{"id":"c","text":"The annual raise the employee receives each year."},{"id":"d","text":"The total number of employees in the company."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

1,200 is the slope, which represents the change in salary per one-unit change in years of experience.

\\textbf{Calculation and Logic:}

Slope = 1,200. This means for every 1 year of experience ($n$), the salary ($S$) increases by 1,200. This is the annual raise.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_49'
),
  (
  'spr',
  'math',
  'A candle is 15 inches tall and burns down to 9 inches in 4 hours. What is the burning rate of the candle in inches per hour?',
  NULL,
  '1.5',
  '\\textbf{Conceptual Explanation:}

The rate of change is the total height lost divided by the time elapsed.

\\textbf{Calculation and Logic:}

Height lost: $15 - 9 = 6$ inches.

Rate: $6 / 4 = 1.5$ inches per hour.',
  'algebra',
  'hard',
  0,
  0,
  'sat_lid_006_50'
)
ON CONFLICT (bank_item_id) DO NOTHING;

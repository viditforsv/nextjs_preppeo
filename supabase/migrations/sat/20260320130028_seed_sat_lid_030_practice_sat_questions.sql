-- Practice-mode math from lid_030.tex (sat_lid_030)
-- Chapter: Ratios, rates, proportional relationships, units | Topic: Unit Conversions & Rates
-- sat_questions: section=math, domain=problem-solving, bank_item_id=sat_lid_030_N, practice module/set 0.

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
  'A printer produces posters at a constant rate of 42 posters per minute. At what rate, in posters per hour, does the printer produce the posters?',
  NULL,
  '2520',
  '\\textbf{Conceptual Explanation:}

To convert a rate from "per minute" to "per hour," we use the fundamental conversion factor: 60 minutes = 1 hour. Since there are 60 individual minutes in one hour, the output over an hour will be 60 times the output of a single minute.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the given rate:} 42 posters / 1 minute.

2. \\textbf{Identify the conversion factor:} 60 minutes / 1 hour.

3. \\textbf{Set up the multiplication:}

\\[ \\frac{42 \\text{ posters}}{1 \\text{ minute}} × \\frac{60 \\text{ minutes}}{1 \\text{ hour}} \\]

Multiply the numerical values:

$42 × 60 = 2,520$

The printer produces 2,520 posters per hour.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_1',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'mcq',
  'math',
  'The International Space Station orbits Earth at an average speed of 4.76 miles per second. What is the space station''s average speed in miles per hour?',
  '[{"id":"a","text":"285.6"},{"id":"b","text":"571.2"},{"id":"c","text":"856.8"},{"id":"d","text":"17,136.0"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

This problem requires converting a high-frequency rate (per second) to a lower-frequency rate (per hour). There are 3,600 seconds in one hour ($60 \\text{ seconds/min} × 60 \\text{ minutes/hr}$).

\\textbf{Calculation and Logic:}

Step 1: Convert miles per second to miles per minute.

$4.76 \\text{ miles/sec} × 60 \\text{ sec/min} = 285.6 \\text{ miles per minute}$.

Step 2: Convert miles per minute to miles per hour.

$285.6 \\text{ miles/min} × 60 \\text{ min/hr} = 17,136 \\text{ miles per hour}$.

\\textbf{Final Result:}

$4.76 × 3,600 = 17,136$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_2',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'mcq',
  'math',
  'For a person $m$ miles from a flash of lightning, the length of the time interval from the moment the person sees the lightning to the moment the person hears the thunder is $k$ seconds. The ratio of $m$ to $k$ can be estimated to be 1 to 5. According to this estimate, the person is how many miles from a flash of lightning if the time interval is 25 seconds?',
  '[{"id":"a","text":"10"},{"id":"b","text":"9"},{"id":"c","text":"6"},{"id":"d","text":"5"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The relationship between distance and time is given as a constant ratio. We can set up a proportion where the ratio of the unknown distance to the given time equals the estimated ratio of 1:5.

\\textbf{Calculation and Logic:}

1. \\textbf{Set up the proportion:}

\\[ \\frac{m \\text{ (distance)}}{k \\text{ (time)}} = (1)/(5) \\]

2. \\textbf{Substitute the given time ($k = 25$):}

\\[ (m)/(25) = (1)/(5) \\]

3. \\textbf{Solve for } $m$:

$5m = 25$

$m = 5$',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_3',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'The ratio 140 to $m$ is equivalent to the ratio 4 to 28. What is the value of $m$?',
  NULL,
  '980',
  '\\textbf{Conceptual Explanation:}

Equivalent ratios can be written as a proportion. Solving for the unknown variable involves cross-multiplication or identifying a scale factor between the numerators.

\\textbf{Calculation and Logic:}

1. \\textbf{Equate the two ratios:}

\\[ (140)/(m) = (4)/(28) \\]

2. \\textbf{Simplify the reference ratio:}

\\[ (4)/(28) = (1)/(7) \\]

3. \\textbf{Solve the simplified proportion:}

\\[ (140)/(m) = (1)/(7) \\]

$m = 140 × 7 = 980$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_4',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A customer spent 27 to purchase oranges at 3 per pound. How many pounds of oranges did the customer purchase?',
  NULL,
  '9',
  '\\textbf{Conceptual Explanation:}

In unit rate problems, the total cost is the product of the quantity and the unit price. Therefore, to find the quantity, divide the total expenditure by the cost per unit.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the formula:} $\\text{Quantity} = \\frac{\\text{Total Cost}}{\\text{Unit Price}}$

2. \\textbf{Substitute the values:}

\\[ \\text{Quantity} = (27)/(3/\\text{lb)} \\]

3. \\textbf{Perform the division:}

$27 ÷ 3 = 9$

The customer purchased 9 pounds of oranges.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_5',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A mechanical device in a workshop produces items at a constant rate of 60 items per hour. At this rate, how many items will the mechanical device produce in 3 hours?',
  NULL,
  '180',
  '\\textbf{Conceptual Explanation:}

When a rate is constant, the total quantity produced is directly proportional to the amount of time elapsed. This relationship is modeled by the formula: $\\text{Total} = \\text{Rate} × \\text{Time}$.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the rate:} 60 items / 1 hour.

2. \\textbf{Identify the time duration:} 3 hours.

3. \\textbf{Perform the multiplication:}

\\[ 60 \\text{ items/hour} × 3 \\text{ hours} = 180 \\text{ items} \\]',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_6',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'How many fluid ounces are equivalent to 76 quarts? (8 fluid ounces = 1 cup and 4 cups = 1 quart)',
  NULL,
  '2,432',
  '\\textbf{Conceptual Explanation:}

This problem requires multi-step dimensional analysis. We must convert from quarts to cups first, then from cups to fluid ounces using the provided conversion factors.

\\textbf{Calculation and Logic:}

Step 1: Convert quarts to cups.

$76 \\text{ quarts} × 4 \\text{ cups/quart} = 304 \\text{ cups}$.

Step 2: Convert cups to fluid ounces.

$304 \\text{ cups} × 8 \\text{ fluid ounces/cup} = 2,432 \\text{ fluid ounces}$.

Alternative setup using a single string of conversions:

\\[ 76 \\text{ qt} × \\frac{4 \\text{ cups}}{1 \\text{ qt}} × \\frac{8 \\text{ fl oz}}{1 \\text{ cup}} = 2,432 \\text{ fl oz} \\]',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_7',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'Pure beeswax has a density of 0.555 ounce per cubic inch. An online company sells pure beeswax at a price of 8.00 per ounce. What is the selling price, in dollars per cubic inch, for pure beeswax purchased from this company?',
  NULL,
  '4.44',
  '\\textbf{Conceptual Explanation:}

This is a rate conversion problem involving density and cost. We need to find the cost for one unit of volume (cubic inch). Since we know the mass of one cubic inch (the density) and the cost of that mass, we multiply them.

\\textbf{Calculation and Logic:}

1. \\textbf{Mass per volume (Density):} 0.555 ounce / 1 cubic inch.

2. \\textbf{Cost per mass:} 8.00 / 1 ounce.

3. \\textbf{Calculate cost per volume:}

\\[ \\frac{0.555 \\text{ ounce}}{1 \\text{ in}^3} × (8.00)/(1 \\text{ ounce)} \\]

$0.555 × 8 = 4.44$

The price is 4.44 per cubic inch.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_8',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'mcq',
  'math',
  'The population density of Worthington is 290 people per square mile. Worthington has a population of 92,800 people. What is the area, in square miles, of Worthington?',
  '[{"id":"a","text":"102,400"},{"id":"b","text":"93,090"},{"id":"c","text":"320"},{"id":"d","text":"32"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Population density is defined as the ratio of the total population to the total land area. The formula is: $\\text{Density} = \\frac{\\text{Population}}{\\text{Area}}$.

\\textbf{Calculation and Logic:}

1. \\textbf{Rearrange the formula to solve for Area:} $\\text{Area} = \\frac{\\text{Population}}{\\text{Density}}$.

2. \\textbf{Substitute the given values:}

\\[ \\text{Area} = (92,800)/(290) \\]

3. \\textbf{Simplify:}

$9,280 ÷ 29 = 320$.

Worthington has an area of 320 square miles.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_9',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A special camera is used for underwater ocean research. When the camera is at a depth of 58 fathoms, what is the camera''s depth in feet? (1 fathom = 6 feet)',
  NULL,
  '348',
  '\\textbf{Conceptual Explanation:}

To convert a measurement from one unit (fathoms) to another (feet), multiply the measurement by the specific conversion factor provided.

\\textbf{Calculation and Logic:}

1. \\textbf{Given depth:} 58 fathoms.

2. \\textbf{Conversion factor:} 6 feet per fathom.

3. \\textbf{Calculate:}

\\[ 58 \\text{ fathoms} × \\frac{6 \\text{ feet}}{1 \\text{ fathom}} = 348 \\text{ feet} \\]',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_10',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A factory produces 150 components every 12 minutes. At this constant rate, how many components are produced in 1 hour?',
  NULL,
  '750',
  '\\textbf{Conceptual Explanation:}

To find the total production for a specific duration, we first determine the production rate per unit of time (in this case, per minute) and then multiply by the total number of minutes in that duration.

\\textbf{Calculation and Logic:}

1. \\textbf{Calculate the rate per minute:}

\\[ \\text{Rate} = \\frac{150 \\text{ components}}{12 \\text{ minutes}} = 12.5 \\text{ components/min} \\]

2. \\textbf{Identify minutes in 1 hour:}

1 hour = 60 minutes.

3. \\textbf{Calculate total production:}

$12.5 \\text{ components/min} × 60 \\text{ minutes} = 750$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_11',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A specific metal alloy has a density of 4.5 grams per cubic centimeter. If the price of the metal is 0.50 per gram, what is the cost of 10 cubic centimeters of this alloy?',
  NULL,
  '22.5',
  '\\textbf{Conceptual Explanation:}

This is a multi-step conversion problem. First, use the density and volume to determine the total mass. Then, use the unit price to determine the total cost of that mass.

\\textbf{Calculation and Logic:}

1. \\textbf{Find the mass:}

\\[ \\text{Mass} = \\text{Density} × \\text{Volume} \\]

$\\text{Mass} = 4.5 \\text{ g/cm}^3 × 10 \\text{ cm}^3 = 45 \\text{ grams}$.

2. \\textbf{Calculate the cost:}

$\\text{Cost} = 45 \\text{ grams} × 0.50/\\text{gram} = 22.50$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_12',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A county has an area of 450 square miles and a population density of 120 people per square mile. What is the total population of the county?',
  NULL,
  '54000',
  '\\textbf{Conceptual Explanation:}

Population density relates the number of residents to a specific unit of land area. To find the total population, multiply the density by the total area.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the formula:} $\\text{Population} = \\text{Density} × \\text{Area}$.

2. \\textbf{Perform the multiplication:}

\\[ 120 \\text{ people/sq mi} × 450 \\text{ sq mi} = 54,000 \\text{ people} \\]',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_13',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'An athlete runs at a speed of 12 feet per second. What is this speed in yards per minute? (3 feet = 1 yard)',
  NULL,
  '240',
  '\\textbf{Conceptual Explanation:}

This problem requires two separate conversions: length (feet to yards) and time (seconds to minutes).

\\textbf{Calculation and Logic:}

1. \\textbf{Convert feet per second to yards per second:}

$12 \\text{ ft/sec} ÷ 3 = 4 \\text{ yards per second}$.

2. \\textbf{Convert yards per second to yards per minute:}

$4 \\text{ yards/sec} × 60 \\text{ sec/min} = 240 \\text{ yards per minute}$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_14',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A container holds 5 gallons of water. How many cups of water are in the container? (1 gallon = 4 quarts, 1 quart = 4 cups)',
  NULL,
  '80',
  '\\textbf{Conceptual Explanation:}

Use chained dimensional analysis to move from the largest unit (gallons) to the target unit (cups) using the provided intermediate steps (quarts).

\\textbf{Calculation and Logic:}

1. \\textbf{Convert gallons to quarts:}

$5 \\text{ gallons} × 4 \\text{ quarts/gallon} = 20 \\text{ quarts}$.

2. \\textbf{Convert quarts to cups:}

$20 \\text{ quarts} × 4 \\text{ cups/quart} = 80 \\text{ cups}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_15',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'In a scale drawing, 2 inches represents 15 miles. If two cities are 7 inches apart on the map, what is the actual distance in miles?',
  NULL,
  '52.5',
  '\\textbf{Calculation and Logic:}

Set up a proportion:

\\[ \\frac{2 \\text{ inches}}{15 \\text{ miles}} = \\frac{7 \\text{ inches}}{x \\text{ miles}} \\]

$2x = 105$

$x = 52.5$',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_16',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A gardener buys mulch for 24 per cubic yard. If the gardener needs 150 cubic feet of mulch, how much will it cost? (1 cubic yard = 27 cubic feet)',
  NULL,
  '133.33',
  '\\textbf{Conceptual Explanation:}

First, convert the required volume from cubic feet to cubic yards so it matches the unit of the given price. Then, multiply the volume in cubic yards by the price.

\\textbf{Calculation and Logic:}

1. \\textbf{Convert cubic feet to cubic yards:}

$150 ÷ 27 \\approx 5.556 \\text{ cubic yards}$.

2. \\textbf{Calculate the total cost:}

$(150/27) × 24 = (50/9) × 24 = 1200/9 = 133.333...$',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_17',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A nautical mile is approximately 6,076 feet. If a boat travels 15 nautical miles, approximately how many feet did it travel?',
  NULL,
  '91140',
  '\\textbf{Calculation and Logic:}

$15 \\text{ nautical miles} × 6,076 \\text{ feet/nautical mile} = 91,140 \\text{ feet}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_18',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'The ratio of boys to girls in a school is 4 to 5. If there are 320 boys, how many students are there in total?',
  NULL,
  '720',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Find the number of girls (x):}

$(4)/(5) = (320)/(x) → 4x = 1,600 → x = 400 \\text{ girls}$.

2. \\textbf{Calculate total students:}

Total = $320 \\text{ (boys)} + 400 \\text{ (girls)} = 720$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_19',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A car travels at a constant speed of 55 miles per hour. How many miles will it travel in 15 minutes?',
  NULL,
  '13.75',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Convert minutes to hours:}

15 minutes = 0.25 hours (or $15/60$).

2. \\textbf{Calculate distance:}

$\\text{Distance} = 55 \\text{ miles/hr} × 0.25 \\text{ hr} = 13.75 \\text{ miles}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_20',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A heart beats 72 times per minute. At this rate, how many times does it beat in 24 hours?',
  NULL,
  '103680',
  '\\textbf{Calculation and Logic:}

$72 \\text{ beats/min} × 60 \\text{ min/hr} × 24 \\text{ hr} = 103,680 \\text{ beats}$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_21',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'Light travels at $3 \\times 10^8$ meters per second. How many kilometers does light travel in 1 minute? (1,000 meters = 1 kilometer)',
  NULL,
  '18000000',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Distance in meters per minute:}

$(3 × 10^8) × 60 = 1.8 × 10^{10} \\text{ meters}$.

2. \\textbf{Convert to kilometers:}

$(1.8 × 10^{10}) ÷ 1000 = 1.8 × 10^7 \\text{ kilometers}$.

Standard notation: 18,000,000.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_22',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A city has a population of 1.2 million and covers 400 square kilometers. What is the population density in people per square kilometer?',
  NULL,
  '3000',
  '\\textbf{Calculation and Logic:}

Population = 1,200,000.

$\\text{Density} = \\frac{1,200,000 \\text{ people}}{400 \\text{ sq km}} = 3,000 \\text{ people/sq km}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_23',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'If a liquid has a density of 0.8 grams per milliliter, what is the volume of 200 grams of this liquid?',
  NULL,
  '250',
  '\\textbf{Calculation and Logic:}

$\\text{Volume} = \\text{Mass} ÷ \\text{Density}$

$\\text{Volume} = 200 \\text{ g} ÷ 0.8 \\text{ g/mL} = 250 \\text{ mL}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_24',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'Convert 504 square inches to square feet. (12 inches = 1 foot)',
  NULL,
  '3.5',
  '\\textbf{Conceptual Explanation:}

When converting square units, you must square the conversion factor. Since $1 \\text{ ft} = 12 \\text{ inches}$, then $1 \\text{ sq ft} = 12 × 12 = 144 \\text{ sq inches}$.

\\textbf{Calculation and Logic:}

$504 \\text{ sq inches} ÷ 144 \\text{ sq inches/sq ft} = 3.5 \\text{ sq ft}$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_25',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A recipe requires 2.5 cups of flour to make 12 muffins. How many cups of flour are needed to make 30 muffins?',
  NULL,
  '6.25',
  '\\textbf{Conceptual Explanation:}

The amount of flour is directly proportional to the number of muffins produced. This relationship can be modeled using a ratio and proportion.

\\textbf{Calculation and Logic:}

1. \\textbf{Set up the proportion:}

\\[ \\frac{2.5 \\text{ cups}}{12 \\text{ muffins}} = \\frac{x \\text{ cups}}{30 \\text{ muffins}} \\]

2. \\textbf{Cross-multiply:}

$12x = 2.5 × 30$

$12x = 75$

3. \\textbf{Solve for } $x$:

$x = 75 ÷ 12 = 6.25$',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_26',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A car''s fuel efficiency is 28 miles per gallon. If gas costs 3.50 per gallon, what is the cost of fuel per mile?',
  NULL,
  '0.125',
  '\\textbf{Conceptual Explanation:}

To find the cost per mile, you must divide the cost of one unit of fuel by the distance that unit of fuel allows the vehicle to travel.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the formula:} $\\text{Cost per mile} = \\frac{\\text{Price per gallon}}{\\text{Miles per gallon}}$

2. \\textbf{Substitute the values:}

\\[ \\text{Cost} = (3.50)/(28 \\text{ miles)} \\]

3. \\textbf{Perform the division:}

$3.50 ÷ 28 = 0.125$',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_27',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'Water flows into a tank at a rate of 5 gallons every 3 minutes. If the tank already contains 20 gallons, how many gallons will be in the tank after 15 minutes?',
  NULL,
  '45',
  '\\textbf{Conceptual Explanation:}

This problem involves an initial value and a constant rate of change. The total amount is the sum of the initial amount and the quantity added over time.

\\textbf{Calculation and Logic:}

1. \\textbf{Calculate the amount added:}

$\\text{Rate} = 5/3 \\text{ gallons per minute}$.

$\\text{Water added} = (5/3) × 15 \\text{ minutes} = 5 × 5 = 25 \\text{ gallons}$.

2. \\textbf{Add the initial amount:}

$\\text{Total} = 20 \\text{ (initial)} + 25 \\text{ (added)} = 45 \\text{ gallons}$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_28',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A runner''s pace is 8 minutes per mile. What is the runner''s speed in miles per hour?',
  NULL,
  '7.5',
  '\\textbf{Conceptual Explanation:}

Pace (time per distance) is the reciprocal of speed (distance per time). To convert a pace in minutes per mile to speed in miles per hour, divide 60 minutes by the pace.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify minutes in an hour:} 60 minutes.

2. \\textbf{Calculate speed:}

\\[ \\text{Speed} = \\frac{60 \\text{ minutes}}{8 \\text{ minutes/mile}} = 7.5 \\text{ miles per hour} \\]',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_29',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A map has a scale of 1:50,000. If two points are 4 cm apart on the map, what is the actual distance in kilometers?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

A map scale ratio indicates that one unit on the map equals 50,000 of those same units in reality. We must calculate the total units and then convert them to the target unit (kilometers).

\\textbf{Calculation and Logic:}

1. \\textbf{Calculate actual distance in centimeters:}

$4 \\text{ cm} × 50,000 = 200,000 \\text{ cm}$.

2. \\textbf{Convert centimeters to meters:}

$200,000 \\text{ cm} ÷ 100 = 2,000 \\text{ meters}$.

3. \\textbf{Convert meters to kilometers:}

$2,000 \\text{ meters} ÷ 1,000 = 2 \\text{ kilometers}$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_30',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'If 3 pounds of apples cost 4.50, how much do 10 pounds cost?',
  NULL,
  '15',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Find the price per pound:}

$4.50 ÷ 3 = 1.50 \\text{ per pound}$.

2. \\textbf{Calculate the cost for 10 pounds:}

$10 \\text{ lbs} × 1.50/\\text{lb} = 15.00$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_31',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A machine can label 2,400 bottles in 8 hours. How many bottles can it label in 15 minutes?',
  NULL,
  '75',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Find the hourly rate:}

$2,400 ÷ 8 = 300 \\text{ bottles per hour}$.

2. \\textbf{Convert time to hours:}

15 minutes = 0.25 hours.

3. \\textbf{Calculate labels produced:}

$300 \\text{ bottles/hr} × 0.25 \\text{ hr} = 75 \\text{ bottles}$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_32',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'Convert 2.5 meters per second to kilometers per hour.',
  NULL,
  '9',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Convert seconds to hours:}

$2.5 \\text{ m/s} × 3,600 \\text{ s/hr} = 9,000 \\text{ meters per hour}$.

2. \\textbf{Convert meters to kilometers:}

$9,000 \\text{ m/hr} ÷ 1,000 \\text{ m/km} = 9 \\text{ km/hr}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_33',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A rectangular field is 100 yards by 50 yards. What is the area in square feet? (3 feet = 1 yard)',
  NULL,
  '45000',
  '\\textbf{Conceptual Explanation:}

Convert dimensions to feet before calculating area, or calculate area in square yards and convert using the squared conversion factor ($1 \\text{ sq yd} = 9 \\text{ sq ft}$).

\\textbf{Calculation and Logic:}

1. \\textbf{Convert dimensions:}

$\\text{Length} = 100 × 3 = 300 \\text{ ft}$.

$\\text{Width} = 50 × 3 = 150 \\text{ ft}$.

2. \\textbf{Calculate Area:}

$300 × 150 = 45,000 \\text{ square feet}$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_34',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'If a printer prints 15 pages per minute, how long will it take to print a 240-page document?',
  NULL,
  '16',
  '\\textbf{Calculation and Logic:}

$\\text{Time} = \\text{Total Pages} ÷ \\text{Rate}$

$\\text{Time} = 240 ÷ 15 = 16 \\text{ minutes}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_35',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A solution is 20% salt by mass. How many grams of salt are in 250 grams of the solution?',
  NULL,
  '50',
  '\\textbf{Calculation and Logic:}

$\\text{Salt mass} = 250 × 0.20 = 50 \\text{ grams}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_36',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'If 5 liters of gas cost 18.50, what is the unit price in dollars per liter?',
  NULL,
  '3.7',
  '\\textbf{Calculation and Logic:}

$18.50 ÷ 5 = 3.70 \\text{ per liter}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_37',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A piece of land is 2.5 hectares. How many square meters is this? (1 hectare = 10,000 square meters)',
  NULL,
  '25000',
  '\\textbf{Calculation and Logic:}

$2.5 × 10,000 = 25,000 \\text{ square meters}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_38',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A car uses 12 liters of fuel for every 100 km. How much fuel is needed for a 450 km trip?',
  NULL,
  '54',
  '\\textbf{Calculation and Logic:}

$\\text{Fuel needed} = (12/100) × 450$

$\\text{Fuel} = 0.12 × 450 = 54 \\text{ liters}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_39',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A pool is being filled at a rate of 250 liters per hour. If the pool capacity is 15,000 liters, how many days will it take to fill the pool if the water runs continuously?',
  NULL,
  '2.5',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Calculate total hours:}

$15,000 ÷ 250 = 60 \\text{ hours}$.

2. \\textbf{Convert hours to days:}

$60 ÷ 24 = 2.5 \\text{ days}$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_40',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'If 8 ounces of cheese cost 4.00, what is the price per pound? (16 ounces = 1 pound)',
  NULL,
  '8',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Find price per ounce:} $4.00 ÷ 8 = 0.50$.

2. \\textbf{Calculate price per pound:} $0.50 × 16 = 8.00$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_41',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A person walks 5 km in 45 minutes. What is the person''s speed in meters per minute?',
  NULL,
  '111.11',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Convert distance to meters:} $5 \\text{ km} = 5,000 \\text{ meters}$.

2. \\textbf{Calculate speed:} $5,000 ÷ 45 \\approx 111.11 \\text{ meters/min}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_42',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A box has dimensions 2 ft by 3 ft by 4 ft. What is the volume in cubic inches? (1 ft = 12 inches)',
  NULL,
  '41472',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Calculate volume in cubic feet:} $2 × 3 × 4 = 24 \\text{ ft}^3$.

2. \\textbf{Convert to cubic inches:}

$1 \\text{ ft}^3 = 12 × 12 × 12 = 1,728 \\text{ in}^3$.

$24 × 1,728 = 41,472 \\text{ in}^3$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_43',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A font size of 72 points is equal to 1 inch in height. What is the height in points of a letter that is 2.5 inches tall?',
  NULL,
  '180',
  '\\textbf{Calculation and Logic:}

$2.5 \\text{ inches} × 72 \\text{ points/inch} = 180 \\text{ points}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_44',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'If 2 liters of paint cover 25 square meters, how many liters are needed for 150 square meters?',
  NULL,
  '12',
  '\\textbf{Calculation and Logic:}

$(2)/(25) = (x)/(150) → x = (2 × 150) / 25 = 12 \\text{ liters}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_45',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A car uses 1 gallon of gas every 32 miles. If gas is 4.00 per gallon and the car travels 400 miles, what is the total cost of gas?',
  NULL,
  '50',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Calculate gallons needed:} $400 ÷ 32 = 12.5 \\text{ gallons}$.

2. \\textbf{Calculate cost:} $12.5 × 4 = 50.00$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_46',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'Convert 90 km/h to m/s.',
  NULL,
  '25',
  '\\textbf{Calculation and Logic:}

$90 \\text{ km/hr} × (1,000 \\text{ m} / 1 \\text{ km}) × (1 \\text{ hr} / 3,600 \\text{ sec}) = 25 \\text{ m/s}$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_030_47',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A cylindrical tank has a volume of 500 liters. How many gallons is this? (1 gallon $\\approx$ 3.785 liters)',
  NULL,
  '132.1',
  '\\textbf{Calculation and Logic:}

$500 ÷ 3.785 \\approx 132.10$',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_48',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'A runner finishes a 10 km race in 50 minutes. What is the runner''s average speed in km/h?',
  NULL,
  '12',
  '\\textbf{Calculation and Logic:}

50 minutes = 5/6 hours.

$\\text{Speed} = 10 ÷ (5/6) = 12 \\text{ km/h}$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_49',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
),
  (
  'spr',
  'math',
  'If 1.5 kg of meat cost 18.00, how much does 250 grams cost?',
  NULL,
  '3',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Identify units:} 1.5 kg = 1,500 grams.

2. \\textbf{Calculate price per gram:} $18 ÷ 1,500 = 0.012$.

3. \\textbf{Calculate cost for 250g:} $0.012 × 250 = 3.00$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_030_50',
  'Ratios, rates, proportional relationships, units',
  'Unit Conversions & Rates'
)
ON CONFLICT (bank_item_id) DO NOTHING;

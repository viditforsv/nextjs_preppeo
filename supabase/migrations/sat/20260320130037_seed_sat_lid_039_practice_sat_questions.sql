-- Practice-mode math from lid_039.tex (sat_lid_039)
-- Chapter: Probability and conditional probability | Topic: Conditional Probability Tables
-- sat_questions: section=math, domain=problem-solving, bank_item_id=sat_lid_039_N, practice module/set 0.

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
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline \\textbf{Type of penguin} & \\textbf{Male} & \\textbf{Female} & \\textbf{Total} \\hline Chinstrap & 41 & 59 & 100 \\hline Emperor & 8 & 27 & 35 \\hline Gentoo & 49 & 54 & 103 \\hline Macaroni & 42 & 40 & 82 \\hline \\textbf{Total} & 140 & 180 & 320 \\hline \\end{tabular} \\end{center} The number of penguins in a zoo exhibit, sorted by gender and type of penguin, is shown in the table above. Which type of penguin has a female population that is the closest to being $\\frac{1}{3}$ of the total female penguin population in the exhibit?',
  '[{"id":"a","text":"Chinstrap"},{"id":"b","text":"Emperor"},{"id":"c","text":"Gentoo"},{"id":"d","text":"Macaroni"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The question asks us to identify which sub-category (female population of a specific species) is closest to a specific fraction ($(1)/(3)$) of a larger group (total female population). This requires comparing specific row values to a specific column total.

\\textbf{Calculation and Logic:}

* Identify the target value: The total female penguin population is 180. One-third of this is:

\\[ (1)/(3) × 180 = 60 \\]

* Compare specific female populations from the table to 60:

* \\textbf{Chinstrap:} 59 (Difference = 1)

* \\textbf{Emperor:} 27 (Difference = 33)

* \\textbf{Gentoo:} 54 (Difference = 6)

* \\textbf{Macaroni:} 40 (Difference = 20)

* Determine the closest value: 59 is the closest number to 60.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_1',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|} \\hline \\textbf{2013 State-Level Taxes} & \\textbf{State sales tax} & \\textbf{No state sales tax} \\hline State income tax & 39 & 4 \\hline No state income tax & 6 & 1 \\hline \\end{tabular} \\end{center} To the nearest tenth of a percent, what percent of states with a state-level sales tax do not have a state-level income tax?',
  '[{"id":"a","text":"6.0%"},{"id":"b","text":"12.0%"},{"id":"c","text":"13.3%"},{"id":"d","text":"14.0%"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This is a conditional percentage problem. The "base" of our calculation is restricted by the condition "states with a state-level sales tax." We only use the data from that specific column.

\\textbf{Calculation and Logic:}

* Find the total for the condition "State-level sales tax":

\\[ 39 (\\text{Income tax}) + 6 (\\text{No income tax}) = 45 \\text{ total states} \\]

* Identify the target group within that total: States with "No state income tax." This value is 6.

* Set up the percentage calculation:

\\[ (6)/(45) × 100 \\]

* Perform the division: $6 ÷ 45 = 0.1333...$

* Round to the nearest tenth of a percent: 13.3%.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_2',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|} \\hline \\textbf{Ages} & \\textbf{Number} \\hline 40--44 & 2 \\hline 45--49 & 7 \\hline 50--54 & 13 \\hline 55--59 & 11 \\hline 60--64 & 7 \\hline 65--69 & 3 \\hline \\end{tabular} \\end{center} The table above gives the number of United States presidents from 1789 to 2015 whose age at the time they first took office is within the interval listed. Of those presidents who were at least 50 years old when they first took office, what fraction were at least 60 years old?',
  '[{"id":"a","text":"$\\\\frac{10}{43}$"},{"id":"b","text":"$\\\\frac{10}{34}$"},{"id":"c","text":"$\\\\frac{10}{24}$"},{"id":"d","text":"$\\\\frac{25}{34}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Conditional probability from a frequency table involves creating a new "total" based on a restriction. Here, the restriction is "at least 50 years old," meaning we exclude the 40--44 and 45--49 categories entirely.

\\textbf{Calculation and Logic:}

* Calculate the restricted total (Presidents $\\ge$ 50):

\\[ 13 (50\\text{--}54) + 11 (55\\text{--}59) + 7 (60\\text{--}64) + 3 (65\\text{--}69) = 34 \\]

* Identify the favorable count (Presidents $\\ge$ 60):

\\[ 7 (60\\text{--}64) + 3 (65\\text{--}69) = 10 \\]

* Set up the fraction: $(10)/(34)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_3',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|} \\hline \\textbf{Classification} & \\textbf{Frequency} \\hline color X & 119 \\hline color Y & 3 \\hline color Z & 35 \\hline \\end{tabular} \\end{center} Each of 157 gemstones can be classified as one of three classifications, as shown in the frequency table. If one of the gemstones is selected at random, what is the probability of selecting a gemstone of color Y?',
  '[{"id":"a","text":"$\\\\frac{3}{157}$"},{"id":"b","text":"$\\\\frac{35}{157}$"},{"id":"c","text":"$\\\\frac{119}{157}$"},{"id":"d","text":"$\\\\frac{154}{157}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The basic probability of an event is the frequency of that specific outcome divided by the total number of outcomes.

\\textbf{Calculation and Logic:}

* Identify total gemstones: 157 (given in text and sum of table).

* Identify gemstones of color Y: 3.

* Probability = $\\frac{\\text{favorable}}{\\text{total}} = (3)/(157)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_4',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|c|} \\hline & \\textbf{0--9 years} & \\textbf{10--19 years} & \\textbf{20+ years} & \\textbf{Total} \\hline \\textbf{Group A} & 7 & 14 & 9 & 30 \\hline \\textbf{Group B} & 6 & 4 & 20 & 30 \\hline \\textbf{Group C} & 17 & 12 & 1 & 30 \\hline \\textbf{Total} & 30 & 30 & 30 & 90 \\hline \\end{tabular} \\end{center} One of these participants will be selected at random. What is the probability of selecting a participant from group A, given that the participant is at least 10 years of age?',
  '[{"id":"a","text":"$\\\\frac{14}{60}$"},{"id":"b","text":"$\\\\frac{23}{60}$"},{"id":"c","text":"$\\\\frac{23}{90}$"},{"id":"d","text":"$\\\\frac{30}{90}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The condition "given that the participant is at least 10 years of age" combines multiple age categories. We must sum the totals for the 10--19 and 20+ columns to find our denominator.

\\textbf{Calculation and Logic:}

* Find the total for the condition ($\\ge$ 10 years):

\\[ 30 (10\\text{--}19) + 30 (20+) = 60 \\]

* Find the target participants within that subset (Group A and $\\ge$ 10 years):

\\[ 14 (\\text{Group A, 10--19}) + 9 (\\text{Group A, 20+}) = 23 \\]

* Probability = $(23)/(60)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_5',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline & \\textbf{Rain} & \\textbf{No rain} & \\textbf{Total} \\hline Number of weekdays & 12 & 48 & 60 \\hline Number of weekend days & 8 & 16 & 24 \\hline \\textbf{Total} & 20 & 64 & 84 \\hline \\end{tabular} \\end{center} If one of the days on which there was no rain is selected at random, what is the probability the day was a weekend day?',
  '[{"id":"a","text":"$\\\\frac{4}{21}$"},{"id":"b","text":"$\\\\frac{1}{4}$"},{"id":"c","text":"$\\\\frac{2}{3}$"},{"id":"d","text":"$\\\\frac{3}{4}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In this conditional probability problem, we ignore the "Rain" column entirely and only focus on the "No rain" group.

\\textbf{Calculation and Logic:}

* Identify the restricted total: 64 days with "No rain."

* Identify the favorable outcome: "Weekend days" within the "No rain" group. This value is 16.

* Set up the probability: $(16)/(64)$.

* Simplify the fraction: $(16)/(64) = (1)/(4)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_6',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|} \\hline & \\textbf{Phone} & \\textbf{Email} \\hline Dinner dance & 55% & 80% \\hline Football game & 20% & 10% \\hline Picnic & 20% & 5% \\hline Pool party & 5% & 5% \\hline \\textbf{Total} & 100% & 100% \\hline \\end{tabular} \\end{center} An alumni association survey asked graduates to select one activity. For the survey, the number of email responses was twice the number of phone responses. If a person who preferred a picnic is selected at random, what is the probability that the person responded by email?',
  '[{"id":"a","text":"$\\\\frac{1}{3}$"},{"id":"b","text":"$\\\\frac{2}{5}$"},{"id":"c","text":"$\\\\frac{1}{2}$"},{"id":"d","text":"$\\\\frac{2}{3}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When given relative population sizes (twice as many) and percentages, it is helpful to assign a dummy value (like $n=100$) to the phone group to calculate actual numbers.

\\textbf{Calculation and Logic:}

* Let Phone responses = 100. Then Email responses = 200.

* Calculate number of "Picnic" responses for each:

* \\textbf{Phone Picnic:} $20% \\text{ of } 100 = 20$

* \\textbf{Email Picnic:} $5% \\text{ of } 200 = 10$

* Total Picnic responses = $20 + 10 = 30$.

* Probability email response given picnic:

\\[ \\frac{\\text{Email Picnic}}{\\text{Total Picnic}} = (10)/(30) = (1)/(3) \\]',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_7',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline \\textbf{Texting behavior} & \\textbf{Talks daily} & \\textbf{Does not talk daily} & \\textbf{Total} \\hline Light & 110 & 146 & 256 \\hline Medium & 139 & 164 & 303 \\hline Heavy & 166 & 74 & 240 \\hline \\textbf{Total} & 415 & 384 & 799 \\hline \\end{tabular} \\end{center} If one of the 799 teens surveyed is selected at random, what is the probability that the teen talks on a cell phone daily?',
  '[{"id":"a","text":"$\\\\frac{1}{799}$"},{"id":"b","text":"$\\\\frac{415}{799}$"},{"id":"c","text":"$\\\\frac{384}{415}$"},{"id":"d","text":"$\\\\frac{384}{799}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This is a simple probability calculation based on the entire sample population. We use the grand total as the denominator.

\\textbf{Calculation and Logic:}

* Identify total participants: 799.

* Identify the target category: "Talks on a cell phone daily." This is the total for the first column.

* Locate the value in the table: 415.

* Probability = $(415)/(799)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_8',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|} \\hline \\textbf{Classification} & \\textbf{Frequency} \\hline igneous & 10 \\hline metamorphic & 33 \\hline sedimentary & 27 \\hline \\end{tabular} \\end{center} If one of these 70 rocks is selected at random, what is the probability of selecting a rock that is igneous?',
  '[{"id":"a","text":"$\\\\frac{10}{27}$"},{"id":"b","text":"$\\\\frac{10}{33}$"},{"id":"c","text":"$\\\\frac{10}{60}$"},{"id":"d","text":"$\\\\frac{10}{70}$"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

* Identify the rock collection size: 70.

* Identify the frequency of igneous rocks: 10.

* Probability = $(10)/(70)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_9',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|c|} \\hline \\textbf{Mascot} & \\textbf{Sixth} & \\textbf{Seventh} & \\textbf{Eighth} & \\textbf{Total} \\hline Badger & 4 & 9 & 9 & 22 \\hline Lion & 9 & 2 & 9 & 20 \\hline Longhorn & 4 & 6 & 4 & 14 \\hline Tiger & 6 & 9 & 9 & 24 \\hline \\textbf{Total} & 23 & 26 & 31 & 80 \\hline \\end{tabular} \\end{center} If one of these students is selected at random, what is the probability of selecting a student whose vote for new mascot was for a lion?',
  '[{"id":"a","text":"$\\\\frac{1}{9}$"},{"id":"b","text":"$\\\\frac{1}{5}$"},{"id":"c","text":"$\\\\frac{1}{4}$"},{"id":"d","text":"$\\\\frac{1}{3}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The total probability is found by taking the specific row total for "Lion" and dividing it by the grand total of all votes.

\\textbf{Calculation and Logic:}

* Total students: 80.

* Votes for Lion: 20.

* Probability = $(20)/(80)$.

* Simplify the fraction: $(20)/(80) = (1)/(4)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_10',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'Which of the following describes the probability $P(A|B)$?',
  '[{"id":"a","text":"The probability that both A and B occur."},{"id":"b","text":"The probability that event A occurs given that event B has occurred."},{"id":"c","text":"The probability that either event A or event B occurs."},{"id":"d","text":"The probability that event B occurs given that event A has occurred."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The notation $P(A|B)$ is standard statistical notation for conditional probability. The vertical bar $|$ is read as "given."

\\textbf{Logic:}

* In the expression $P(A|B)$, the second letter ($B$) represents the condition or the restricted sample space.

* The first letter ($A$) represents the outcome we are measuring within that restricted space.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_11',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline & \\textbf{Red} & \\textbf{Blue} & \\textbf{Total} \\hline \\textbf{Small} & 5 & 10 & 15 \\hline \\textbf{Large} & 15 & 20 & 35 \\hline \\textbf{Total} & 20 & 30 & 50 \\hline \\end{tabular} \\end{center} A box contains 50 blocks of different sizes and colors. If a large block is selected at random, what is the probability that it is red?',
  '[{"id":"a","text":"$\\\\frac{15}{50}$"},{"id":"b","text":"$\\\\frac{15}{35}$"},{"id":"c","text":"$\\\\frac{15}{20}$"},{"id":"d","text":"$\\\\frac{35}{50}$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

* Restriction: "If a \\textbf{large} block is selected."

* Total large blocks: 35.

* Favorable outcome (Large and Red): 15.

* Probability = $(15)/(35)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_12',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'spr',
  'math',
  'In a class of 25 students, 15 are female and 10 are male. If a student is selected at random, what is the probability that the student is male? (Express as a decimal).',
  NULL,
  '0.4',
  '\\textbf{Calculation and Logic:}

* Total students: 25.

* Favorable outcomes (male): 10.

* Probability = $(10)/(25) = 0.4$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_13',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'If the probability of selecting a student who plays an instrument is 0.6, what is the probability of selecting a student who does NOT play an instrument?',
  '[{"id":"a","text":"0.3"},{"id":"b","text":"0.4"},{"id":"c","text":"0.5"},{"id":"d","text":"0.6"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

* The sum of probabilities for all possible outcomes must be 1.

* $P(\\text{Not instrument}) = 1 - P(\\text{Instrument}) = 1 - 0.6 = 0.4$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_14',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline & \\textbf{Math} & \\textbf{Science} & \\textbf{Total} \\hline \\textbf{Freshmen} & 40 & 20 & 60 \\hline \\textbf{Sophomores} & 30 & 50 & 80 \\hline \\textbf{Total} & 70 & 70 & 140 \\hline \\end{tabular} \\end{center} If a sophomore is selected at random, what is the probability that they prefer Science?',
  '[{"id":"a","text":"$\\\\frac{50}{70}$"},{"id":"b","text":"$\\\\frac{50}{80}$"},{"id":"c","text":"$\\\\frac{50}{140}$"},{"id":"d","text":"$\\\\frac{80}{140}$"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

* Restriction: Sophomore (Total 80).

* Target: Science (50).

* Fraction: $(50)/(80)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_15',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A jar contains 5 red marbles, 8 blue marbles, and 7 green marbles. If one is picked, what is the probability it is NOT blue?',
  '[{"id":"a","text":"$\\\\frac{12}{20}$"},{"id":"b","text":"$\\\\frac{8}{20}$"},{"id":"c","text":"$\\\\frac{7}{20}$"},{"id":"d","text":"$\\\\frac{5}{20}$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

* Total marbles: $5 + 8 + 7 = 20$.

* Not blue: Red (5) + Green (7) = 12.

* Probability: $(12)/(20)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_16',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline & \\textbf{Pass} & \\textbf{Fail} & \\textbf{Total} \\hline \\textbf{Study} & 45 & 5 & 50 \\hline \\textbf{No Study} & 10 & 20 & 30 \\hline \\textbf{Total} & 55 & 25 & 80 \\hline \\end{tabular} \\end{center} What percent of students who passed the test did NOT study?',
  '[{"id":"a","text":"12.5%"},{"id":"b","text":"18.2%"},{"id":"c","text":"20.0%"},{"id":"d","text":"33.3%"}]'::jsonb,
  'b',
  '\\textbf{Calculation:}

* Restriction: Passed (Total 55).

* Target: No Study (10).

* Percentage: $(10)/(55) × 100 \\approx 18.2%$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_17',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A fair 6-sided die is rolled. Probability of rolling a 4 or 5?',
  '[{"id":"a","text":"$\\\\frac{1}{6}$"},{"id":"b","text":"$\\\\frac{2}{6}$"},{"id":"c","text":"$\\\\frac{3}{6}$"},{"id":"d","text":"$\\\\frac{4}{6}$"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

* Favorable: {4, 5} (2 outcomes).

* Total: 6.

* Fraction: $(2)/(6)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_18',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'spr',
  'math',
  'In a survey of 100 people, 60 like coffee, 40 like tea, and 20 like both. If a person who likes coffee is selected, what is the probability they also like tea?',
  NULL,
  '1/3',
  '\\textbf{Calculation:}

* Restriction: Likes Coffee (60).

* Target: Also likes tea (the "Both" group) (20).

* Probability: $(20)/(60) = (1)/(3)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_19',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'If two events A and B are independent, which of the following is true?',
  '[{"id":"a","text":"$P(A|B) = P(A)$"},{"id":"b","text":"$P(A|B) = P(B)$"},{"id":"c","text":"$P(A|B) = 0$"},{"id":"d","text":"$P(A|B) = 1$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

* Independence means that the occurrence of event B does not change the probability of event A occurring.

* Therefore, the "given" condition B has no effect on the outcome.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_20',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A bag has 4 red and 6 blue pens. Probability of picking a red pen?',
  '[{"id":"a","text":"0.4"},{"id":"b","text":"0.5"},{"id":"c","text":"0.6"},{"id":"d","text":"0.8"}]'::jsonb,
  'a',
  '\\textbf{Calculation:}

* Red: 4. Total: 10.

* $(4)/(10) = 0.4$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_21',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline & \\textbf{SUV} & \\textbf{Sedan} & \\textbf{Total} \\hline \\textbf{New} & 20 & 30 & 50 \\hline \\textbf{Used} & 40 & 10 & 50 \\hline \\textbf{Total} & 60 & 40 & 100 \\hline \\end{tabular} \\end{center} Probability that a randomly selected Used car is a Sedan?',
  '[{"id":"a","text":"10%"},{"id":"b","text":"20%"},{"id":"c","text":"25%"},{"id":"d","text":"40%"}]'::jsonb,
  'b',
  '\\textbf{Calculation:}

* Restriction: Used (Total 50).

* Target: Sedan (10).

* $(10)/(50) = 0.20$ or 20%.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_22',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'Probability of drawing a Heart from a standard 52-card deck?',
  '[{"id":"a","text":"$\\\\frac{1}{52}$"},{"id":"b","text":"$\\\\frac{1}{13}$"},{"id":"c","text":"$\\\\frac{1}{4}$"},{"id":"d","text":"$\\\\frac{1}{2}$"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

* There are 4 suits in a deck. Each suit makes up $(1)/(4)$ of the deck.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_23',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline & \\textbf{Win} & \\textbf{Loss} & \\textbf{Total} \\hline \\textbf{Home} & 12 & 3 & 15 \\hline \\textbf{Away} & 5 & 10 & 15 \\hline \\textbf{Total} & 17 & 13 & 30 \\hline \\end{tabular} \\end{center} If a game was a Win, what is the probability it was played at Home?',
  '[{"id":"a","text":"$\\\\frac{12}{15}$"},{"id":"b","text":"$\\\\frac{12}{17}$"},{"id":"c","text":"$\\\\frac{12}{30}$"},{"id":"d","text":"$\\\\frac{17}{30}$"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

* Restriction: Win (Total 17).

* Target: Home (12).

* Fraction: $(12)/(17)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_24',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'spr',
  'math',
  'Bag with 2 green and 3 yellow blocks. Probability of green? (Decimal)',
  NULL,
  '0.4',
  '\\textbf{Calculation:}

* Green: 2. Total: 5.

* $(2)/(5) = 0.4$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_25',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline & \\textbf{A} & \\textbf{B} & \\textbf{Total} \\hline \\textbf{Type 1} & 15 & 5 & 20 \\hline \\textbf{Type 2} & 10 & 20 & 30 \\hline \\textbf{Total} & 25 & 25 & 50 \\hline \\end{tabular} \\end{center} What fraction of Type 1 items are category B?',
  '[{"id":"a","text":"$\\\\frac{5}{20}$"},{"id":"b","text":"$\\\\frac{5}{25}$"},{"id":"c","text":"$\\\\frac{5}{50}$"},{"id":"d","text":"$\\\\frac{20}{50}$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

* Restriction: Type 1 (20).

* Target: B (5).

* Fraction: $(5)/(20)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_26',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'If $P(A \\text{ and } B) = 0.2$ and $P(B) = 0.5$, what is $P(A|B)$?',
  '[{"id":"a","text":"0.1"},{"id":"b","text":"0.3"},{"id":"c","text":"0.4"},{"id":"d","text":"0.7"}]'::jsonb,
  'c',
  '\\textbf{Calculation:}

* Formula: $P(A|B) = \\frac{P(A \\text{ and } B)}{P(B)}$

* $P(A|B) = (0.2)/(0.5) = 0.4$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_27',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline & \\textbf{Action} & \\textbf{Comedy} & \\textbf{Total} \\hline \\textbf{Men} & 30 & 20 & 50 \\hline \\textbf{Women} & 15 & 35 & 50 \\hline \\textbf{Total} & 45 & 55 & 100 \\hline \\end{tabular} \\end{center} Of those who prefer Comedy, what fraction are women?',
  '[{"id":"a","text":"$\\\\frac{35}{50}$"},{"id":"b","text":"$\\\\frac{35}{55}$"},{"id":"c","text":"$\\\\frac{35}{100}$"},{"id":"d","text":"$\\\\frac{55}{100}$"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

* Restriction: Comedy (Total 55).

* Target: Women (35).

* Fraction: $(35)/(55)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_28',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A coin is flipped. Probability of Tails?',
  '[{"id":"a","text":"0"},{"id":"b","text":"0.25"},{"id":"c","text":"0.5"},{"id":"d","text":"1.0"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

* 1 favorable outcome out of 2 total outcomes.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_29',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'Which table property ensures $P(A|B)$ can be calculated?',
  '[{"id":"a","text":"The total frequency must be 100."},{"id":"b","text":"The frequency of event B must be greater than zero."},{"id":"c","text":"All categories must have equal frequencies."},{"id":"d","text":"The table must be a 2x2 table."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

* Since conditional probability involves dividing by the frequency of the condition ($B$), it is mathematically impossible if that frequency is zero.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_30',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline & \\textbf{Pet: Dog} & \\textbf{Pet: Cat} & \\textbf{Total} \\hline \\textbf{Living in House} & 42 & 18 & 60 \\hline \\textbf{Living in Apartment} & 15 & 25 & 40 \\hline \\textbf{Total} & 57 & 43 & 100 \\hline \\end{tabular} \\end{center} The table summarizes a survey of 100 pet owners. If a pet owner who lives in an apartment is selected at random, what is the probability that the owner has a dog?',
  '[{"id":"a","text":"$\\\\frac{15}{40}$"},{"id":"b","text":"$\\\\frac{15}{57}$"},{"id":"c","text":"$\\\\frac{15}{100}$"},{"id":"d","text":"$\\\\frac{40}{100}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Conditional probability requires restricting the sample space to a specific group defined by the "if" or "given" clause. In this case, we only care about the subset of people living in apartments.

\\textbf{Calculation and Logic:}

* Identify the restricted group: "Living in Apartment."

* Find the total for this row in the table: 40.

* Identify the favorable outcomes within this specific group: Apartment dwellers who have a "Dog."

* Locate the intersection in the table: 15.

* Set up the probability fraction: $\\frac{\\text{favorable}}{\\text{restricted total}} = (15)/(40)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_31',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'spr',
  'math',
  'A bag contains 60 marbles that are either solid or striped. If the probability of choosing a striped marble at random is 0.35, how many solid marbles are in the bag?',
  NULL,
  '39',
  '\\textbf{Conceptual Explanation:}

The sum of all probabilities in a sample space must equal 1. To find the count of a specific category, we can find its individual probability and multiply it by the total population.

\\textbf{Calculation and Logic:}

* Calculate the probability of choosing a solid marble: $1 - 0.35 = 0.65$.

* Multiply the total number of marbles by this probability: $60 × 0.65$.

* Break down the multiplication: $60 × 0.6 = 36$ and $60 × 0.05 = 3$.

* Sum the parts: $36 + 3 = 39$.

* There are 39 solid marbles in the bag.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_32',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A fair 10-sided die labeled 1 through 10 is rolled once. What is the probability of rolling a number that is a factor of 10?',
  '[{"id":"a","text":"$\\\\frac{2}{10}$"},{"id":"b","text":"$\\\\frac{3}{10}$"},{"id":"c","text":"$\\\\frac{4}{10}$"},{"id":"d","text":"$\\\\frac{5}{10}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To solve this, we must first define the sample space (all possible outcomes) and then identify which of those outcomes satisfy the specific mathematical condition provided.

\\textbf{Calculation and Logic:}

* Identify the sample space: $\\{1, 2, 3, 4, 5, 6, 7, 8, 9, 10\\}$.

* List the factors of 10: A factor is a number that divides 10 with no remainder. These are $\\{1, 2, 5, 10\\}$.

* Count the favorable outcomes: There are 4 such numbers.

* Set up the ratio: $(4)/(10)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_33',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A letter is chosen at random from the word "PROBABILITY." What is the probability that the letter chosen is a "B"?',
  '[{"id":"a","text":"$\\\\frac{1}{11}$"},{"id":"b","text":"$\\\\frac{2}{11}$"},{"id":"c","text":"$\\\\frac{2}{9}$"},{"id":"d","text":"$\\\\frac{1}{5}$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

* Count the total number of letters in the word "PROBABILITY": 11 letters.

* Count the number of times the letter "B" appears in the word: 2 times.

* Set up the probability: $(2)/(11)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_34',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'spr',
  'math',
  'In a group of 80 students, 45 take Spanish, 20 take French, and 10 take both languages. If a student is selected at random, what is the probability that the student takes neither Spanish nor French? (Express your answer as a fraction).',
  NULL,
  '5/16',
  '\\textbf{Conceptual Explanation:}

When categories overlap, we use the Principle of Inclusion-Exclusion to find the total number of unique individuals in those categories before determining who is left over (the "neither" group).

\\textbf{Calculation and Logic:}

* Calculate students taking at least one language: $(\\text{Spanish}) + (\\text{French}) - (\\text{Both})$.

* $45 + 20 - 10 = 55$ unique students take a language.

* Calculate the "neither" group: Total students $-$ Students taking a language.

* $80 - 55 = 25$ students.

* Probability = $(25)/(80)$.

* Simplify: $(25 ÷ 5)/(80 ÷ 5) = (5)/(16)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_35',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'If event A and event B are independent, and $P(A) = 0.4$ and $P(B) = 0.5$, what is $P(A \\text{ and } B)$?',
  '[{"id":"a","text":"0.1"},{"id":"b","text":"0.2"},{"id":"c","text":"0.9"},{"id":"d","text":"1.0"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Independence means the occurrence of one event does not affect the probability of the other. For independent events, the probability of both occurring simultaneously is found by multiplying their individual probabilities.

\\textbf{Calculation and Logic:}

* Identify the formula for independent events: $P(A \\text{ and } B) = P(A) × P(B)$.

* Substitute the given values: $0.4 × 0.5$.

* Multiply: $0.20$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_36',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A jar contains 12 caramels, 8 mints, and 10 chocolates. If one piece of candy is selected at random, what is the probability it is a chocolate?',
  '[{"id":"a","text":"$\\\\frac{1}{3}$"},{"id":"b","text":"$\\\\frac{1}{2}$"},{"id":"c","text":"$\\\\frac{1}{10}$"},{"id":"d","text":"$\\\\frac{10}{20}$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

* Find the total number of candies: $12 + 8 + 10 = 30$.

* Identify the number of chocolates: 10.

* Probability = $(10)/(30)$.

* Simplify: $(1)/(3)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_37',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A doctor tests 200 patients for a condition. 40 patients actually have it. The test correctly identifies 38 of those with the condition but also gives a positive result for 16 patients who do not have it. If a patient with a positive test result is chosen at random, what is the probability they actually have the condition?',
  '[{"id":"a","text":"$\\\\frac{38}{200}$"},{"id":"b","text":"$\\\\frac{38}{54}$"},{"id":"c","text":"$\\\\frac{38}{40}$"},{"id":"d","text":"$\\\\frac{54}{200}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This problem uses conditional probability to determine "Positive Predictive Value." We must restrict our denominator to only those who received a positive test result, regardless of whether that result was correct or incorrect.

\\textbf{Calculation and Logic:}

* Find the total number of positive test results: (True Positives) + (False Positives).

* $\\text{Total Positive} = 38 + 16 = 54$.

* Identify the favorable outcome: A person who has the condition AND tested positive (38).

* Set up the probability: $(38)/(54)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_38',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'spr',
  'math',
  'A set of cards is numbered 1 through 20. If one card is drawn, what is the probability that the number is a multiple of 4? (Express your answer as a decimal.)',
  NULL,
  '0.25',
  '\\textbf{Calculation and Logic:}

* Total number of possible outcomes: 20.

* List multiples of 4 within the range: $\\{4, 8, 12, 16, 20\\}$.

* Count the favorable outcomes: 5.

* Probability = $(5)/(20)$.

* Convert to decimal: $5 ÷ 20 = 0.25$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_39',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'Which of the following is an impossible probability for any event?',
  '[{"id":"a","text":"0"},{"id":"b","text":"0.75"},{"id":"c","text":"1"},{"id":"d","text":"1.2"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Probability represents a ratio of parts to a whole. Consequently, the value of any probability must fall within the range of 0 (impossible) to 1 (certain).

\\textbf{Logic:}

* A probability of 1.2 is equivalent to 120%.

* It is impossible to have more favorable outcomes than total possible outcomes.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_40',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A company produces 500 light bulbs. 2% are defective. If 2 bulbs are chosen at random with replacement, what is the probability that both are defective?',
  '[{"id":"a","text":"0.0004"},{"id":"b","text":"0.02"},{"id":"c","text":"0.04"},{"id":"d","text":"0.4"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The term "with replacement" indicates that the selection of the second bulb is independent of the first selection. The probability remains constant for both events.

\\textbf{Calculation and Logic:}

* Convert the percentage to a decimal: $2% = 0.02$.

* Identify the probability of the first event (defective): 0.02.

* Identify the probability of the second event (defective): 0.02.

* Multiply the probabilities for independent events: $0.02 × 0.02 = 0.0004$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_41',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A weather forecast predicts a 30% chance of rain on Saturday and a 30% chance on Sunday. Assuming these are independent events, what is the probability that it rains on at least one of these days?',
  '[{"id":"a","text":"30%"},{"id":"b","text":"51%"},{"id":"c","text":"60%"},{"id":"d","text":"90%"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The "at least one" rule is best calculated by finding the probability of the complement (neither day raining) and subtracting that from 1.

\\textbf{Calculation and Logic:}

* Find the probability of no rain on a single day: $1 - 0.30 = 0.70$.

* Calculate the probability of no rain on both days: $0.70 × 0.70 = 0.49$.

* Subtract from 1 to find the probability of at least one rainy day: $1 - 0.49 = 0.51$.

* Convert to percentage: 51%.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_42',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'spr',
  'math',
  'A class has 15 boys and 10 girls. Three students are chosen for a committee. If the first two chosen are boys, what is the probability that the third student chosen is a girl? (Express as a fraction).',
  NULL,
  '10/23',
  '\\textbf{Conceptual Explanation:}

This problem deals with dependent events because the selections are made without replacement. The composition of the remaining group changes after each selection.

\\textbf{Calculation and Logic:}

* Initial total students: $15 + 10 = 25$.

* After the first two boys are chosen: $15 - 2 = 13$ boys remain.

* The number of girls remains 10.

* The new total number of students is $25 - 2 = 23$.

* The probability of choosing a girl from the remaining students is $(10)/(23)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_43',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A bag has 5 red and 5 blue balls. After a red ball is drawn and NOT replaced, what is the probability of drawing another red ball?',
  '[{"id":"a","text":"$\\\\frac{4}{9}$"},{"id":"b","text":"$\\\\frac{4}{10}$"},{"id":"c","text":"$\\\\frac{5}{9}$"},{"id":"d","text":"$\\\\frac{5}{10}$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

* Original composition: 5 red, 5 blue (Total 10).

* Composition after 1 red is removed: 4 red, 5 blue (Total 9).

* Probability of drawing red: $(4)/(9)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_44',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A point is chosen at random inside a circle of radius 2 that is centered within a square of side length 5. What is the probability the point is inside the circle?',
  '[{"id":"a","text":"$\\\\frac{2}{5}$"},{"id":"b","text":"$\\\\frac{4}{25}$"},{"id":"c","text":"$\\\\frac{2\\\\pi}{25}$"},{"id":"d","text":"$\\\\frac{4\\\\pi}{25}$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Geometric probability is calculated by comparing the area of the favorable region to the total area available.

\\[ P = \\frac{\\text{Area of Circle}}{\\text{Area of Square}} \\]

\\textbf{Calculation and Logic:}

* Calculate the area of the square: $\\text{side}^2 = 5^2 = 25$.

* Calculate the area of the circle: $\\pi r^2 = \\pi (2^2) = 4\\pi$.

* Set up the ratio: $(4\\pi)/(25)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_45',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A student guesses on a 5-question multiple-choice quiz. Each question has 4 options. What is the probability that the student gets all 5 questions correct?',
  '[{"id":"a","text":"$(\\\\frac{1}{4})^5$"},{"id":"b","text":"$5 \\\\times \\\\frac{1}{4}$"},{"id":"c","text":"$1 - (\\\\frac{1}{4})^5$"},{"id":"d","text":"$\\\\frac{1}{5}$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

* Probability of guessing one correct: $(1)/(4)$.

* Since each guess is independent, the probability of getting all 5 correct is the product of individual probabilities: $(1)/(4) × (1)/(4) × (1)/(4) × (1)/(4) × (1)/(4)$.

* This is expressed as $((1)/(4))^5$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_46',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'spr',
  'math',
  'There are 12 eggs in a carton, and 3 are cracked. If you pick two eggs at random without replacement, what is the probability that both are cracked? (Express as a fraction).',
  NULL,
  '1/22',
  '\\textbf{Calculation and Logic:}

* Probability the first egg is cracked: $(3)/(12)$.

* Probability the second egg is cracked (given the first was cracked): $(2)/(11)$.

* Multiply for sequential events: $(3)/(12) × (2)/(11) = (6)/(132)$.

* Simplify the fraction: $(6 ÷ 6)/(132 ÷ 6) = (1)/(22)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_47',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'Which of the following describes mutually exclusive events?',
  '[{"id":"a","text":"Events that cannot occur at the same time."},{"id":"b","text":"Events where the outcome of one affects the other."},{"id":"c","text":"Events where the outcome of one does not affect the other."},{"id":"d","text":"Events that must occur at the same time."}]'::jsonb,
  'a',
  '\\textbf{Logic:}

* Mutually exclusive (disjoint) means the events have no overlap in their sample space. If one happens, the other is guaranteed not to happen at that same moment.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_039_48',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A bag has 10 red marbles and 90 black marbles. What is the probability of picking a red marble?',
  '[{"id":"a","text":"0.01"},{"id":"b","text":"0.10"},{"id":"c","text":"0.90"},{"id":"d","text":"1.00"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

* Total marbles: $10 + 90 = 100$.

* Red marbles: 10.

* Probability: $(10)/(100) = 0.10$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_039_49',
  'Probability and conditional probability',
  'Conditional Probability Tables'
),
  (
  'mcq',
  'math',
  'A test for a disease is 90% accurate for those who have it and 90% accurate for those who do not. If 10% of a population has the disease, what is the probability that a randomly chosen person tests positive?',
  '[{"id":"a","text":"0.09"},{"id":"b","text":"0.10"},{"id":"c","text":"0.18"},{"id":"d","text":"0.20"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A "positive test" can result from two different scenarios: a true positive (sick person correctly identified) or a false positive (healthy person incorrectly identified). We must sum the probabilities of both scenarios.

\\textbf{Calculation and Logic:}

* Scenario 1 (True Positive): Has disease (0.10) and tests positive (0.90).

* $0.10 × 0.90 = 0.09$.

* Scenario 2 (False Positive): Does not have disease (0.90) and tests positive (0.10).

* $0.90 × 0.10 = 0.09$.

* Total probability of positive result: $0.09 + 0.09 = 0.18$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_039_50',
  'Probability and conditional probability',
  'Conditional Probability Tables'
)
ON CONFLICT (bank_item_id) DO NOTHING;

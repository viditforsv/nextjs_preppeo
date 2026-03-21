-- Practice-mode math from lid_038.tex (sat_lid_038)
-- Chapter: Probability and conditional probability | Topic: Basic Probability
-- sat_questions: section=math, domain=problem-solving, bank_item_id=sat_lid_038_N, practice module/set 0.

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
  'Each face of a fair 14-sided die is labeled with a number from 1 through 14, with a different number appearing on each face. If the die is rolled one time, what is the probability of rolling a 2?',
  '[{"id":"a","text":"$\\\\frac{1}{14}$"},{"id":"b","text":"$\\\\frac{2}{14}$"},{"id":"c","text":"$\\\\frac{12}{14}$"},{"id":"d","text":"$\\\\frac{13}{14}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Probability is the ratio of the number of favorable outcomes to the total number of possible outcomes in the sample space.

\\[ P(\\text{Event}) = \\frac{\\text{Number of favorable outcomes}}{\\text{Total number of outcomes}} \\]

\\textbf{Calculation and Logic:}

* Identify the total number of outcomes: Since the die has 14 sides labeled 1 through 14, there are 14 possible outcomes.

* Identify the favorable outcomes: The event is "rolling a 2." There is only one face with the number 2.

* Set up the ratio: $(1)/(14)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_1',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'In a bag, there are 7 red, 4 white, 33 blue, and 33 yellow cubes. If one of these cubes is selected at random, what is the probability of selecting a cube that is neither blue nor yellow?',
  '[{"id":"a","text":"$\\\\frac{6}{7}$"},{"id":"b","text":"$\\\\frac{7}{11}$"},{"id":"c","text":"$\\\\frac{1}{3}$"},{"id":"d","text":"$\\\\frac{1}{7}$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

To find the probability of a "neither/nor" event, we first determine which outcomes satisfy the condition (the red and white cubes) and then divide by the total number of items in the set.

\\textbf{Calculation and Logic:}

* Calculate the total number of cubes: $7 + 4 + 33 + 33 = 77$.

* Identify the "neither blue nor yellow" cubes: These are the red and white cubes.

* Calculate the number of favorable outcomes: $7 + 4 = 11$.

* Set up the probability fraction: $(11)/(77)$.

* Simplify the fraction: $(11 ÷ 11)/(77 ÷ 11) = (1)/(7)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_2',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A grove has 6 rows of birch trees and 5 rows of maple trees. Each row of birch trees has 8 trees 20 feet or taller and 6 trees shorter than 20 feet. Each row of maple trees has 9 trees 20 feet or taller and 7 trees shorter than 20 feet. A tree from one of these rows will be selected at random. What is the probability of selecting a maple tree, given that the tree is 20 feet or taller?',
  '[{"id":"a","text":"$\\\\frac{9}{164}$"},{"id":"b","text":"$\\\\frac{3}{10}$"},{"id":"c","text":"$\\\\frac{15}{31}$"},{"id":"d","text":"$\\\\frac{9}{17}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This is a conditional probability problem. We are restricted to a specific subset of the data: only trees that are 20 feet or taller. The "total" for our probability will be the sum of all trees meeting that height requirement.

\\textbf{Calculation and Logic:}

* Calculate total birch trees $\\ge$ 20 ft: $6 \\text{ rows} × 8 \\text{ trees/row} = 48$.

* Calculate total maple trees $\\ge$ 20 ft: $5 \\text{ rows} × 9 \\text{ trees/row} = 45$.

* Calculate the "given" total (all trees $\\ge$ 20 ft): $48 + 45 = 93$.

* Identify the favorable outcomes (maple trees $\\ge$ 20 ft): 45.

* Set up the probability: $(45)/(93)$.

* Simplify by dividing by 3: $(45 ÷ 3)/(93 ÷ 3) = (15)/(31)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_3',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|} \\hline \\textbf{Classification} & \\textbf{Frequency} \\hline Igneous & 10 \\hline Metamorphic & 33 \\hline Sedimentary & 27 \\hline \\end{tabular} \\end{center} Each rock in a collection of 70 rocks was classified as either igneous, metamorphic, or sedimentary, as shown in the frequency table. If one of these rocks is selected at random, what is the probability of selecting a rock that is igneous?',
  '[{"id":"a","text":"$\\\\frac{10}{27}$"},{"id":"b","text":"$\\\\frac{10}{33}$"},{"id":"c","text":"$\\\\frac{10}{60}$"},{"id":"d","text":"$\\\\frac{10}{70}$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

In a frequency table, the probability is the frequency of the specific category divided by the total frequency of all categories combined.

\\textbf{Calculation and Logic:}

* Identify the total number of rocks (given in the problem and table): 70.

* Identify the frequency of igneous rocks: 10.

* Set up the probability ratio: $(10)/(70)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_4',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'Of the 8 planets in our solar system, 4 are considered rocky. If a student randomly selects 1 of those 8 planets as a topic for a report, what is the probability that the selected planet will be rocky?',
  '[{"id":"a","text":"$\\\\frac{1}{8}$"},{"id":"b","text":"$\\\\frac{1}{4}$"},{"id":"c","text":"$\\\\frac{1}{2}$"},{"id":"d","text":"2"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

* Total possible outcomes (total planets): 8.

* Favorable outcomes (rocky planets): 4.

* Probability = $(4)/(8)$.

* Simplify: $(1)/(2)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_5',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'At a movie theater, there are a total of 350 customers. Each customer is located in either theater A, theater B, or theater C. If one of these customers is selected at random, the probability of selecting a customer who is located in theater A is 0.48, and the probability of selecting a customer who is located in theater B is 0.24. How many customers are located in theater C?',
  '[{"id":"a","text":"28"},{"id":"b","text":"40"},{"id":"c","text":"84"},{"id":"d","text":"98"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The sum of probabilities for all possible mutually exclusive outcomes must equal 1. Once the probability of the final category is found, multiply it by the total population to find the specific count.

\\textbf{Calculation and Logic:}

* Calculate the combined probability of A and B: $0.48 + 0.24 = 0.72$.

* Find the probability of theater C: $1 - 0.72 = 0.28$.

* Multiply the probability of C by the total number of customers: $0.28 × 350$.

* $28% \\text{ of } 350 = 0.28 × 350 = 98$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_6',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'Each vertex of a 14-sided polygon is labeled with one of the 14 letters A through N, with a different letter at each vertex. If one vertex is selected at random, what is the probability that the letter D will be at the selected vertex? (Express your answer as a fraction.)',
  NULL,
  '1/14',
  '\\textbf{Calculation and Logic:}

* Total vertices: 14.

* Each vertex has a unique letter, so there is exactly one vertex labeled "D".

* Probability = $(1)/(14)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_7',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A band with 45 members has 11 members who play saxophone. If one band member is selected at random, what is the probability of selecting a band member who plays saxophone?',
  '[{"id":"a","text":"$\\\\frac{1}{45}$"},{"id":"b","text":"$\\\\frac{11}{45}$"},{"id":"c","text":"$\\\\frac{34}{45}$"},{"id":"d","text":"$\\\\frac{45}{45}$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

* Total outcomes (band members): 45.

* Favorable outcomes (saxophone players): 11.

* Probability = $(11)/(45)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_8',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'On May 10, 2015, there were 83 million Internet subscribers in Nigeria. By September 30, 2015, the number of Internet subscribers in Nigeria had increased to 97 million. If an Internet subscriber in Nigeria on September 30, 2015, is selected at random, the probability that the person selected was an MTN subscriber is 0.43. There were $p$ million MTN subscribers in Nigeria on September 30, 2015. To the nearest integer, what is the value of $p$?',
  NULL,
  '42',
  '\\textbf{Conceptual Explanation:}

To find a subset''s size when given its probability relative to a total, multiply the total population by the probability.

\\[ \\text{Subset Size} = \\text{Total Size} × \\text{Probability} \\]

\\textbf{Calculation and Logic:}

* Use the total population for the specific date mentioned (Sept 30): 97 million.

* Use the given probability for MTN subscribers: 0.43.

* Multiply: $97 × 0.43 = 41.71$.

* Round to the nearest integer: 42.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_9',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A store received a shipment of 1,000 MP3 players, 4 of which were defective. If an MP3 player is randomly selected from this shipment, what is the probability that it is defective?',
  '[{"id":"a","text":"0.004"},{"id":"b","text":"0.04"},{"id":"c","text":"0.4"},{"id":"d","text":"4"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

* Total outcomes: 1,000.

* Favorable outcomes (defective): 4.

* Probability = $(4)/(1,000)$.

* Convert to decimal: 0.004.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_10',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'If the probability of an event happening is $x$, what is the probability of the event NOT happening?',
  '[{"id":"a","text":"$x$"},{"id":"b","text":"$1 - x$"},{"id":"c","text":"$\\\\frac{1}{x}$"},{"id":"d","text":"$x - 1$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The sum of the probability of an event and the probability of its complement (it not happening) is always exactly 1.

\\textbf{Calculation and Logic:}

* $P(\\text{Event}) + P(\\text{Not Event}) = 1$.

* $x + P(\\text{Not Event}) = 1$.

* $P(\\text{Not Event}) = 1 - x$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_11',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A spinner is divided into 8 equal sections labeled 1 through 8. What is the probability that the spinner lands on a number that is a prime number?',
  '[{"id":"a","text":"$\\\\frac{1}{8}$"},{"id":"b","text":"$\\\\frac{3}{8}$"},{"id":"c","text":"$\\\\frac{4}{8}$"},{"id":"d","text":"$\\\\frac{5}{8}$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

* Total outcomes: 8.

* List prime numbers between 1 and 8: 2, 3, 5, 7.

* Count favorable outcomes: 4.

* Probability = $(4)/(8)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_12',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|c|c|c|c|} \\hline & \\textbf{Science} & \\textbf{History} & \\textbf{Total} \\hline \\textbf{Grade 10} & 15 & 25 & 40 \\hline \\textbf{Grade 11} & 20 & 10 & 30 \\hline \\textbf{Total} & 35 & 35 & 70 \\hline \\end{tabular} \\end{center} Based on the table, if a Grade 11 student is chosen at random, what is the probability that they prefer History?',
  '[{"id":"a","text":"$\\\\frac{10}{30}$"},{"id":"b","text":"$\\\\frac{10}{35}$"},{"id":"c","text":"$\\\\frac{10}{70}$"},{"id":"d","text":"$\\\\frac{30}{70}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

For conditional probability from a two-way table, use the specific row or column total mentioned in the "if" clause as the denominator.

\\textbf{Calculation and Logic:}

* Condition: "if a Grade 11 student is chosen."

* Total Grade 11 students: 30.

* Favorable outcomes (Grade 11 and History): 10.

* Probability = $(10)/(30)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_13',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'A jar contains 5 red marbles, 8 blue marbles, and 7 green marbles. If one marble is selected at random, what is the probability that the marble is NOT red? (Express your answer as a decimal.)',
  NULL,
  '0.75',
  '\\textbf{Conceptual Explanation:}

The probability of an event NOT occurring is the complement of the event occurring. We can find this by identifying all outcomes that do not meet the "red" criteria and dividing by the total.

\\textbf{Calculation and Logic:}

* Calculate the total number of marbles: $5 + 8 + 7 = 20$.

* Identify favorable outcomes (not red): These are blue and green marbles.

* Count favorable outcomes: $8 + 7 = 15$.

* Set up the probability fraction: $(15)/(20)$.

* Convert to decimal: $15 ÷ 20 = 0.75$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_14',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|c|c|c|c|} \\hline & \\textbf{Pass} & \\textbf{Fail} & \\textbf{Total} \\hline \\textbf{Trained} & 45 & 5 & 50 \\hline \\textbf{Untrained} & 20 & 30 & 50 \\hline \\textbf{Total} & 65 & 35 & 100 \\hline \\end{tabular} \\end{center} The table shows the results of a safety exam for 100 employees. If an employee who failed the exam is selected at random, what is the probability that the employee was untrained?',
  '[{"id":"a","text":"$\\\\frac{30}{100}$"},{"id":"b","text":"$\\\\frac{30}{50}$"},{"id":"c","text":"$\\\\frac{30}{35}$"},{"id":"d","text":"$\\\\frac{35}{100}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

This is a conditional probability problem where the sample space is restricted to only those who "failed." The denominator must be the total number of failures.

\\textbf{Calculation and Logic:}

* Identify the restricted group: Employees who "Fail."

* Find the total for that group from the table: 35.

* Identify the favorable outcome within that group: Untrained and Fail.

* Find that value: 30.

* Set up the ratio: $(30)/(35)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_15',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A fair coin is flipped 3 times. What is the probability that the coin lands on heads exactly 2 times?',
  '[{"id":"a","text":"$\\\\frac{1}{8}$"},{"id":"b","text":"$\\\\frac{1}{4}$"},{"id":"c","text":"$\\\\frac{3}{8}$"},{"id":"d","text":"$\\\\frac{1}{2}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

For small sample spaces, we can list all possible outcomes (Heads/Tails) and count how many meet the specific condition.

\\textbf{Calculation and Logic:}

* List total outcomes ($2^3 = 8$): HHH, HHT, HTH, THH, HTT, THT, TTH, TTT.

* Identify outcomes with exactly two heads: HHT, HTH, THH.

* Count favorable outcomes: 3.

* Set up the ratio: $(3)/(8)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_16',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A set of cards consists of 10 cards numbered 1 through 10. If one card is drawn at random, what is the probability that the number on the card is a multiple of 3?',
  '[{"id":"a","text":"$\\\\frac{1}{10}$"},{"id":"b","text":"$\\\\frac{3}{10}$"},{"id":"c","text":"$\\\\frac{4}{10}$"},{"id":"d","text":"$\\\\frac{1}{3}$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

* Total possible outcomes: 10.

* List multiples of 3 in the set: 3, 6, 9.

* Count favorable outcomes: 3.

* Probability = $(3)/(10)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_17',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'A survey asked 200 people if they prefer tea or coffee. 120 people said tea, and the rest said coffee. Of those who said tea, 40 were male. Of those who said coffee, 50 were male. If a person who is male is selected at random, what is the probability that he prefers coffee?',
  NULL,
  '5/9',
  '\\textbf{Conceptual Explanation:}

We must first organize the raw data into categories to identify the "given" group (males) and the favorable subgroup (males who like coffee).

\\textbf{Calculation and Logic:}

* Total people = 200.

* Tea drinkers = 120. Coffee drinkers = $200 - 120 = 80$.

* Tea + Male = 40.

* Coffee + Male = 50.

* Total Males = $40 + 50 = 90$.

* Probability (Coffee given Male) = $(50)/(90)$.

* Simplify: $5/9$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_18',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A box contains 4 red pens, 6 blue pens, and 10 black pens. If one pen is chosen at random, what is the probability that it is NOT a black pen?',
  '[{"id":"a","text":"0.1"},{"id":"b","text":"0.4"},{"id":"c","text":"0.5"},{"id":"d","text":"0.6"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

* Total pens: $4 + 6 + 10 = 20$.

* Pens that are "not black" are red or blue: $4 + 6 = 10$.

* Probability: $(10)/(20) = 0.5$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_19',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A company has two branches. Branch A has 60 employees, 12 of whom are managers. Branch B has 40 employees, 8 of whom are managers. If an employee is selected at random from the entire company, what is the probability that the employee is a manager?',
  '[{"id":"a","text":"0.10"},{"id":"b","text":"0.20"},{"id":"c","text":"0.25"},{"id":"d","text":"0.40"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

* Total employees: $60 + 40 = 100$.

* Total managers: $12 + 8 = 20$.

* Probability: $(20)/(100) = 0.20$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_20',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'A fair 6-sided die is rolled. What is the probability of rolling a number greater than 4?',
  NULL,
  '1/3',
  '\\textbf{Logic:}

* Total outcomes: 6.

* Numbers greater than 4: 5, 6.

* Favorable outcomes: 2.

* Probability: $(2)/(6) = (1)/(3)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_21',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A bag contains 50 tokens numbered 1 to 50. If one token is selected at random, what is the probability that the number is a perfect square or a multiple of 20?',
  '[{"id":"a","text":"$\\\\frac{7}{50}$"},{"id":"b","text":"$\\\\frac{9}{50}$"},{"id":"c","text":"$\\\\frac{10}{50}$"},{"id":"d","text":"$\\\\frac{12}{50}$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

* List perfect squares $\\le 50$: 1, 4, 9, 16, 25, 36, 49 (7 tokens).

* List multiples of 20 $\\le 50$: 20, 40 (2 tokens).

* Check for overlap: None of the perfect squares are multiples of 20.

* Total favorable outcomes: $7 + 2 = 9$.

* Probability: $(9)/(50)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_22',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'If $P(A) = 0.35$ and $P(B) = 0.45$, and events A and B are mutually exclusive, what is $P(A \\text{ or } B)$?',
  '[{"id":"a","text":"0.10"},{"id":"b","text":"0.80"},{"id":"c","text":"0.1575"},{"id":"d","text":"1.00"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

For mutually exclusive events, the probability of either occurring is the sum of their individual probabilities.

\\textbf{Logic:}

* $P(A \\text{ or } B) = P(A) + P(B)$.

* $0.35 + 0.45 = 0.80$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_23',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'A group of 30 students includes 18 girls and 12 boys. 10 girls and 5 boys are in the school band. If a student is selected at random, what is the probability that the student is a boy or in the band?',
  NULL,
  '11/15',
  '\\textbf{Conceptual Explanation:}

To find the probability of "A or B," we add the probabilities but subtract the overlap ($A \\text{ and } B$) to avoid double-counting.

\\textbf{Calculation and Logic:}

* Total students = 30.

* Boys = 12.

* Band members = $10 \\text{ (girls)} + 5 \\text{ (boys)} = 15$.

* Overlap (Boys in band) = 5.

* Favorable = (Boys) + (Band) - (Overlap) = $12 + 15 - 5 = 22$.

* Probability = $(22)/(30) = (11)/(15)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_24',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A card is drawn from a standard 52-card deck. What is the probability of drawing a King?',
  '[{"id":"a","text":"$\\\\frac{1}{52}$"},{"id":"b","text":"$\\\\frac{1}{26}$"},{"id":"c","text":"$\\\\frac{1}{13}$"},{"id":"d","text":"$\\\\frac{1}{4}$"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

* Total cards: 52.

* Number of Kings: 4 (one for each suit).

* Probability: $(4)/(52) = (1)/(13)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_25',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A target has three regions: A, B, and C. The probability of hitting A is 0.2 and hitting B is 0.5. If hit points are mutually exclusive, what is the probability of hitting C or missing the target entirely?',
  '[{"id":"a","text":"0.3"},{"id":"b","text":"0.7"},{"id":"c","text":"0.8"},{"id":"d","text":"Cannot be determined."}]'::jsonb,
  'a',
  '\\textbf{Logic:}

* Total probability = 1.0.

* Probability of hitting A or B = $0.2 + 0.5 = 0.7$.

* The remaining probability represents everything else (hitting C or missing) = $1.0 - 0.7 = 0.3$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_26',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'A bag has 10 coins: 3 quarters, 2 dimes, and 5 nickels. If a coin is selected at random, what is the probability it is a dime?',
  NULL,
  '0.2',
  '\\textbf{Logic:}

* Total coins: 10.

* Favorable (dimes): 2.

* Probability: $(2)/(10) = 0.2$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_27',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'Which of the following probabilities represents a "certain" event?',
  '[{"id":"a","text":"0"},{"id":"b","text":"0.5"},{"id":"c","text":"1"},{"id":"d","text":"100"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

* On a probability scale, 0 is impossible and 1 is certain.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_28',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A box contains 5 red balls and 5 white balls. If you draw one ball, what is the probability it is red?',
  '[{"id":"a","text":"0.1"},{"id":"b","text":"0.5"},{"id":"c","text":"5"},{"id":"d","text":"10"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

* Total: 10. Red: 5. $(5)/(10) = 0.5$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_29',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'In a class of 25 students, 15 play sports. What is the probability that a randomly chosen student does NOT play sports?',
  NULL,
  '0.4',
  '\\textbf{Logic:}

* Total: 25.

* Do not play sports: $25 - 15 = 10$.

* Probability: $(10)/(25) = (2)/(5) = 0.4$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_30',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|l|c|c|c|} \\hline & \\textbf{Pet: Dog} & \\textbf{Pet: Cat} & \\textbf{Total} \\hline \\textbf{Living in House} & 42 & 18 & 60 \\hline \\textbf{Living in Apartment} & 15 & 25 & 40 \\hline \\textbf{Total} & 57 & 43 & 100 \\hline \\end{tabular} \\end{center} The table summarizes a survey of 100 pet owners. If a pet owner who lives in an apartment is selected at random, what is the probability that the owner has a dog?',
  '[{"id":"a","text":"$\\\\frac{15}{40}$"},{"id":"b","text":"$\\\\frac{15}{57}$"},{"id":"c","text":"$\\\\frac{15}{100}$"},{"id":"d","text":"$\\\\frac{40}{100}$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

This is a conditional probability problem. The phrase "If a pet owner who lives in an apartment is selected" restricts our focus to only those 40 individuals. The denominator of our probability fraction must be the total for that specific row.

\\textbf{Calculation and Logic:}

* Identify the restricted group: "Living in Apartment."

* Find the total for this group from the table: 40.

* Identify the favorable outcomes within this group: Owners who have a "Dog."

* Locate the intersection of "Apartment" and "Dog" in the table: 15.

* Set up the probability ratio: $(15)/(40)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_31',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'A bag contains 60 marbles that are either solid or striped. If the probability of choosing a striped marble at random is 0.35, how many solid marbles are in the bag?',
  NULL,
  '39',
  '\\textbf{Conceptual Explanation:}

The probabilities of all mutually exclusive events in a set must add up to 1. If we know the probability of one type (striped), we can find the probability of the other (solid) and then calculate the physical count.

\\textbf{Calculation and Logic:}

* Find the probability of choosing a solid marble: $1 - 0.35 = 0.65$.

* Multiply the total number of marbles by the probability of choosing a solid one: $60 × 0.65$.

* Calculation: $60 × 0.6 = 36$ and $60 × 0.05 = 3$.

* $36 + 3 = 39$.

* There are 39 solid marbles in the bag.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_32',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A fair 10-sided die labeled 1 through 10 is rolled once. What is the probability of rolling a number that is a factor of 10?',
  '[{"id":"a","text":"$\\\\frac{2}{10}$"},{"id":"b","text":"$\\\\frac{3}{10}$"},{"id":"c","text":"$\\\\frac{4}{10}$"},{"id":"d","text":"$\\\\frac{5}{10}$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To find the probability, we first list all possible outcomes and then identify which specific numbers meet the criteria of being a "factor of 10."

\\textbf{Calculation and Logic:}

* Identify the sample space: $\\{1, 2, 3, 4, 5, 6, 7, 8, 9, 10\\}$.

* List the factors of 10: Any number that divides 10 evenly. These are 1, 2, 5, and 10.

* Count the favorable outcomes: 4.

* Probability = $\\frac{\\text{favorable}}{\\text{total}} = (4)/(10)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_33',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A letter is chosen at random from the word "PROBABILITY." What is the probability that the letter chosen is a "B"?',
  '[{"id":"a","text":"$\\\\frac{1}{11}$"},{"id":"b","text":"$\\\\frac{2}{11}$"},{"id":"c","text":"$\\\\frac{2}{9}$"},{"id":"d","text":"$\\\\frac{1}{5}$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

* Count the total number of letters in "PROBABILITY": 11 letters.

* Count how many times the letter "B" appears: 2 times.

* The probability of choosing a "B" is $(2)/(11)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_34',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'In a group of 80 students, 45 take Spanish, 20 take French, and 10 take both languages. If a student is selected at random, what is the probability that the student takes neither Spanish nor French?',
  NULL,
  '5/16',
  '\\textbf{Conceptual Explanation:}

To find the number of students taking "neither," we must first find the total number of unique students taking at least one language. We use the Principle of Inclusion-Exclusion to avoid double-counting the students who take both.

\\textbf{Calculation and Logic:}

* Total taking Spanish or French: $45 \\text{ (Spanish)} + 20 \\text{ (French)} - 10 \\text{ (Both)} = 55$.

* Total students taking neither: $80 \\text{ (Total students)} - 55 \\text{ (At least one)} = 25$.

* Probability of neither: $(25)/(80)$.

* Simplify the fraction: $(25 ÷ 5)/(80 ÷ 5) = (5)/(16)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_35',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'If event A and event B are independent, and $P(A) = 0.4$ and $P(B) = 0.5$, what is $P(A \\text{ and } B)$?',
  '[{"id":"a","text":"0.1"},{"id":"b","text":"0.2"},{"id":"c","text":"0.9"},{"id":"d","text":"1.0"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

For two independent events, the probability of both happening at the same time is the product of their individual probabilities.

\\[ P(A \\text{ and } B) = P(A) × P(B) \\]

\\textbf{Calculation and Logic:}

* $P(A) = 0.4$.

* $P(B) = 0.5$.

* $P(A \\text{ and } B) = 0.4 × 0.5 = 0.20$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_36',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A jar contains 12 caramels, 8 mints, and 10 chocolates. If one piece of candy is selected at random, what is the probability it is a chocolate?',
  '[{"id":"a","text":"$\\\\frac{1}{3}$"},{"id":"b","text":"$\\\\frac{1}{2}$"},{"id":"c","text":"$\\\\frac{1}{10}$"},{"id":"d","text":"$\\\\frac{10}{20}$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

* Total pieces of candy: $12 + 8 + 10 = 30$.

* Favorable outcomes (chocolates): 10.

* Probability = $(10)/(30) = (1)/(3)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_37',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A doctor tests 200 patients for a certain condition. 40 patients actually have the condition. The test correctly identifies 38 of those with the condition but also gives a positive result for 16 patients who do not have it. If a patient with a positive test result is chosen at random, what is the probability they actually have the condition?',
  '[{"id":"a","text":"$\\\\frac{38}{200}$"},{"id":"b","text":"$\\\\frac{38}{54}$"},{"id":"c","text":"$\\\\frac{38}{40}$"},{"id":"d","text":"$\\\\frac{54}{200}$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Conditional probability focuses only on the specific subset that meets the "given" criteria. Here, we only care about patients who received a "positive test result."

\\textbf{Calculation and Logic:}

* Total positive results = (True Positives) + (False Positives).

* Total positive results = $38 + 16 = 54$.

* Favorable outcomes (actually have condition and tested positive): 38.

* Probability = $(38)/(54)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_38',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'A set of cards is numbered 1 through 20. If one card is drawn, what is the probability that the number is a multiple of 4? (Express your answer as a decimal.)',
  NULL,
  '0.25',
  '\\textbf{Calculation and Logic:}

* Total cards: 20.

* Multiples of 4 in the set: 4, 8, 12, 16, 20.

* Count: 5.

* Probability = $(5)/(20) = (1)/(4) = 0.25$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_39',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'Which of the following is an impossible probability for any event?',
  '[{"id":"a","text":"0"},{"id":"b","text":"0.75"},{"id":"c","text":"1"},{"id":"d","text":"1.2"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Probabilities are ratios of parts to a whole. Therefore, the value of any probability $P$ must be $0 \\le P \\le 1$.

\\textbf{Logic:}

* 1.2 is greater than 1, which would imply there are more favorable outcomes than total possible outcomes. This is impossible.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_40',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A company produces 500 light bulbs. 2% are defective. If 2 bulbs are chosen at random with replacement, what is the probability that both are defective?',
  '[{"id":"a","text":"0.0004"},{"id":"b","text":"0.02"},{"id":"c","text":"0.04"},{"id":"d","text":"0.4"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

* Probability of one defective bulb: 2% = 0.02.

* Because they are chosen "with replacement," the events are independent.

* $P(\\text{Both Defective}) = 0.02 × 0.02 = 0.0004$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_41',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A weather forecast predicts a 30% chance of rain on Saturday and a 30% chance of rain on Sunday. Assuming these are independent events, what is the probability that it rains on at least one of these days?',
  '[{"id":"a","text":"30%"},{"id":"b","text":"51%"},{"id":"c","text":"60%"},{"id":"d","text":"90%"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The easiest way to find the probability of "at least one" is to find the complement: the probability that it rains on neither day, and subtract that from 1.

\\textbf{Calculation and Logic:}

* $P(\\text{No rain Saturday}) = 1 - 0.3 = 0.7$.

* $P(\\text{No rain Sunday}) = 1 - 0.3 = 0.7$.

* $P(\\text{No rain either day}) = 0.7 × 0.7 = 0.49$.

* $P(\\text{At least one day}) = 1 - 0.49 = 0.51$, or 51%.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_42',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'A class has 15 boys and 10 girls. Three students are chosen to be on a committee. If the first two chosen are boys, what is the probability that the third student chosen is a girl?',
  NULL,
  '10/23',
  '\\textbf{Conceptual Explanation:}

When choosing without replacement, the total number of students and the number of students in each category decrease after each selection.

\\textbf{Calculation and Logic:}

* Initial count: 15 boys, 10 girls (Total 25).

* After choosing 2 boys: 13 boys remain, 10 girls remain (Total 23).

* The probability that the next student is a girl is $(10)/(23)$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_43',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A bag has 5 red and 5 blue balls. After a red ball is drawn and NOT replaced, what is the probability of drawing another red ball?',
  '[{"id":"a","text":"$\\\\frac{4}{9}$"},{"id":"b","text":"$\\\\frac{4}{10}$"},{"id":"c","text":"$\\\\frac{5}{9}$"},{"id":"d","text":"$\\\\frac{5}{10}$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

* Initially: 5 red, 5 blue (Total 10).

* After one red is removed: 4 red, 5 blue (Total 9).

* Probability of another red: $(4)/(9)$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_44',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'If a point is chosen at random inside a circle of radius 2 that is centered within a square of side length 5, what is the probability the point is inside the circle?',
  '[{"id":"a","text":"$\\\\frac{2}{5}$"},{"id":"b","text":"$\\\\frac{4}{25}$"},{"id":"c","text":"$\\\\frac{2\\\\pi}{25}$"},{"id":"d","text":"$\\\\frac{4\\\\pi}{25}$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

In geometric probability, the probability is the area of the favorable region divided by the total area of the entire shape.

[Image of a circle inscribed in a square]

\\textbf{Calculation and Logic:}

* Area of the square (Total): $5 × 5 = 25$.

* Area of the circle (Favorable): $\\pi r^2 = \\pi (2^2) = 4\\pi$.

* Probability = $(4\\pi)/(25)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_45',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A student answers a 5-question multiple-choice quiz by guessing. Each question has 4 options. What is the probability that the student gets all 5 questions correct?',
  '[{"id":"a","text":"$(\\\\frac{1}{4})^5$"},{"id":"b","text":"$5 \\\\times \\\\frac{1}{4}$"},{"id":"c","text":"$1 - (\\\\frac{1}{4})^5$"},{"id":"d","text":"$\\\\frac{1}{5}$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

* The probability of guessing one question correctly is $(1)/(4)$.

* Since each guess is independent, the probability of getting all 5 correct is the product: $(1)/(4) × (1)/(4) × (1)/(4) × (1)/(4) × (1)/(4)$.

* This is $((1)/(4))^5$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_46',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'spr',
  'math',
  'There are 12 eggs in a carton, and 3 are cracked. If you pick two eggs at random without replacement, what is the probability that both are cracked?',
  NULL,
  '1/22',
  '\\textbf{Calculation and Logic:}

* Probability first is cracked: $(3)/(12)$.

* Probability second is cracked (given the first was cracked): $(2)/(11)$.

* $P(\\text{Both}) = (3)/(12) × (2)/(11) = (6)/(132)$.

* Simplify: $(1)/(22)$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_47',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'Which of the following describes mutually exclusive events?',
  '[{"id":"a","text":"Events that cannot happen at the same time."},{"id":"b","text":"Events where the outcome of one affects the other."},{"id":"c","text":"Events where the outcome of one does not affect the other."},{"id":"d","text":"Events that must happen at the same time."}]'::jsonb,
  'a',
  '\\textbf{Logic:}

* Mutually exclusive means "disjoint." If one happens, the other cannot. For example, rolling a 1 and rolling a 2 on a single die roll are mutually exclusive.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_038_48',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A bag has 10 red marbles and 90 black marbles. What is the probability of picking a red marble?',
  '[{"id":"a","text":"0.01"},{"id":"b","text":"0.10"},{"id":"c","text":"0.90"},{"id":"d","text":"1.00"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

* Total: $10 + 90 = 100$.

* Red: 10.

* Probability: $(10)/(100) = 0.10$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_038_49',
  'Probability and conditional probability',
  'Basic Probability'
),
  (
  'mcq',
  'math',
  'A test for a disease is 90% accurate for those who have it and 90% accurate for those who do not. If 10% of a population has the disease, what is the probability that a randomly chosen person tests positive?',
  '[{"id":"a","text":"0.09"},{"id":"b","text":"0.10"},{"id":"c","text":"0.18"},{"id":"d","text":"0.20"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A positive test can come from two groups: people who actually have the disease (True Positives) and people who do not have it (False Positives).

\\textbf{Calculation and Logic:}

* Group 1 (Has disease): 10% of population. $P(\\text{Has and Tests Positive}) = 0.10 × 0.90 = 0.09$.

* Group 2 (No disease): 90% of population. $P(\\text{No and Tests Positive}) = 0.90 × 0.10 = 0.09$.

* Total probability of testing positive: $0.09 + 0.09 = 0.18$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_038_50',
  'Probability and conditional probability',
  'Basic Probability'
)
ON CONFLICT (bank_item_id) DO NOTHING;

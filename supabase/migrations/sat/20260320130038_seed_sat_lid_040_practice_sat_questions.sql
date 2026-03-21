-- Practice-mode math from lid_040.tex (sat_lid_040)
-- Chapter: Inference from samples, margin of error | Topic: Sample Validity & Bias
-- sat_questions: section=math, domain=problem-solving, bank_item_id=sat_lid_040_N, practice module/set 0.

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
  'In a study of cell phone use, 799 randomly selected US teens were asked how often they talked on a cell phone and about their texting behavior. Based on the data, an estimate of the percent of US teens who are heavy texters is 30% and the associated margin of error is 3%. Which of the following is a correct statement based on the given margin of error?',
  '[{"id":"a","text":"Approximately 3% of the teens in the study who are classified as heavy texters are not really heavy texters."},{"id":"b","text":"It is not possible that the percent of all US teens who are heavy texters is less than 27%."},{"id":"c","text":"The percent of all US teens who are heavy texters is 33%."},{"id":"d","text":"It is doubtful that the percent of all US teens who are heavy texters is 35%."}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

A margin of error creates a range of plausible values for a population based on a sample. This interval is calculated by adding and subtracting the error from the estimated percentage.

\\textbf{Calculation and Logic:}

First, determine the lower and upper bounds of the interval by calculating 30% minus 3% and 30% plus 3%, which gives a range of 27% to 33%. This range represents the values that are likely to contain the true population percentage. Looking at the choices, 35% falls entirely outside of this range, making it unlikely or doubtful that the true percentage is 35%. Choice B is incorrect because a margin of error does not rule out other values as impossible, while Choice C incorrectly treats a range boundary as a definite fact.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_1',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'There are 55 students in Spanish club. A sample of the Spanish club students was selected at random and asked whether they intend to enroll in a new study program. Of those surveyed, 20% responded that they intend to enroll in the study program. Based on this survey, which of the following is the best estimate of the total number of Spanish club students who intend to enroll in the study program?',
  '[{"id":"a","text":"11"},{"id":"b","text":"20"},{"id":"c","text":"44"},{"id":"d","text":"55"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

When a random sample is representative of a population, we can apply the sample''s percentage to the entire population size to estimate a total count.

\\textbf{Calculation and Logic:}

Identify the total number of students in the club, which is 55. Convert the sample percentage of 20% into a decimal, which is 0.20. Multiply the population size by this decimal to find the estimated count. Calculating 55 times 0.20 results in 11. This means the best estimate for the number of students intending to enroll is 11.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_040_2',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'A researcher interviewed 411 randomly selected US residents. If the population of the United States was 300 million when the survey was given, what is the best estimate, in millions, of the difference between the number of US residents who favor (somewhat or strongly) and those who oppose (somewhat or strongly) the use of nuclear energy? (Round to the nearest whole number). \\begin{center} \\textbf{Views on Nuclear Energy Use} \\begin{tabular}{|l|c|} \\hline \\textbf{Response} & \\textbf{Frequency} \\hline Strongly favor & 56 \\hline Somewhat favor & 214 \\hline Somewhat oppose & 104 \\hline Strongly oppose & 37 \\hline \\end{tabular} \\end{center}',
  NULL,
  '94',
  '\\textbf{Conceptual Explanation:}

To estimate a difference for a large population, first find the difference in the sample counts and then scale that difference up proportionally to the size of the whole population.

\\textbf{Calculation and Logic:}

Start by finding the total number of people in the sample who favor nuclear energy by adding 56 and 214, which equals 270. Next, find the total number of people in the sample who oppose it by adding 104 and 37, which equals 141. The difference in the sample counts is 270 minus 141, resulting in 129 people. To find the proportion this represents, divide 129 by the total sample size of 411. Apply this proportion to the 300 million US residents by multiplying 129 divided by 411 by 300. This calculation results in approximately 94.16 million. Rounding to the nearest whole number gives an estimate of 94 million.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_3',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A study was done on the weights of different types of fish in a pond. A random sample of fish were caught and marked. The sample contained 150 largemouth bass, of which 30% weighed more than 2 pounds. Which of the following conclusions is best supported by the sample data?',
  '[{"id":"a","text":"The majority of all fish in the pond weigh less than 2 pounds."},{"id":"b","text":"The average weight of all fish in the pond is approximately 2 pounds."},{"id":"c","text":"Approximately 30% of all fish in the pond weigh more than 2 pounds."},{"id":"d","text":"Approximately 30% of all largemouth bass in the pond weigh more than 2 pounds."}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Results from a study can only be generalized to the specific population that was sampled. Using a sample from one specific group to make claims about a much broader group is a common statistical error.

\\textbf{Calculation and Logic:}

The study specifically sampled 150 largemouth bass. While the findings provide an accurate estimate for the largemouth bass population in that pond, they do not provide information about other species of fish that might live there. Choices A, B, and C all attempt to make conclusions about "all fish" in the pond, which is incorrect because the sample was not representative of all fish species. Therefore, the only valid conclusion is the one limited to the largemouth bass.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_4',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A park ranger asked a random sample of visitors how far they hiked during their visit. Based on the responses, the estimated mean was found to be 4.5 miles, with an associated margin of error of 0.5 miles. Which of the following is the best conclusion from these data?',
  '[{"id":"a","text":"It is likely that all visitors hiked between 4 and 5 miles."},{"id":"b","text":"It is likely that most visitors hiked exactly 4.5 miles."},{"id":"c","text":"It is not possible that any visitor hiked less than 3 miles."},{"id":"d","text":"It is plausible that the mean distance hiked for all visitors is between 4 and 5 miles."}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The margin of error describes the uncertainty around a population parameter like the mean. It does not describe the range of individual values within that population.

\\textbf{Calculation and Logic:}

Calculate the interval for the mean by subtracting and adding the 0.5-mile margin of error to the estimated mean of 4.5 miles. This results in a range of 4.0 to 5.0 miles. This range suggests where the true average of all visitors likely falls. It does not mean that every single visitor (or even most visitors) hiked a distance in that specific range, as individual distances can vary widely. Choice D is the only statement that correctly refers to the mean of the entire population rather than the specific behavior of individuals.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_5',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A bag containing 10,000 beads of assorted colors is purchased. To estimate the percent of red beads in the bag, a sample of beads is selected at random. The percent of red beads in the bag was estimated to be 15%, with an associated margin of error of 2%. If $r$ is the actual number of red beads in the bag, which of the following is most plausible?',
  '[{"id":"a","text":"$r > 1,700$"},{"id":"b","text":"$1,300 < r < 1,700$"},{"id":"c","text":"$200 < r < 1,500$"},{"id":"d","text":"$r < 1,300$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To estimate a population count, apply the interval created by the margin of error to the total population size.

\\textbf{Calculation and Logic:}

First, find the plausible range for the percentage of red beads by calculating 15% minus 2% and 15% plus 2%, which gives an interval of 13% to 17%. Next, apply these percentages to the total number of beads, which is 10,000. Calculating 13% of 10,000 gives 1,300, and 17% of 10,000 gives 1,700. This establishes that the actual number of red beads, $r$, is likely to be between 1,300 and 1,700.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_6',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|c|c|c|} \\hline Sample & Percent in favor & Margin of error \\hline A & 52% & 4.2% \\hline B & 48% & 1.6% \\hline \\end{tabular} \\end{center} The results of two random samples of votes for a proposition are shown above. The samples were selected from the same population, and the margins of error were calculated using the same method. Which of the following is the most appropriate reason that the margin of error for sample A is greater than the margin of error for sample B?',
  '[{"id":"a","text":"Sample A had a smaller number of votes that could not be recorded."},{"id":"b","text":"Sample A had a higher percent of favorable responses."},{"id":"c","text":"Sample A had a larger sample size."},{"id":"d","text":"Sample A had a smaller sample size."}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The precision of an estimate is directly related to the size of the sample. Larger samples provide more data and a more accurate representation of the population, which leads to a smaller margin of error.

\\textbf{Calculation and Logic:}

Observe that Sample A has a margin of error of 4.2%, which is significantly larger than Sample B''s margin of error of 1.6%. A larger margin of error indicates a less precise estimate. Since the samples were taken from the same population and processed using the same methods, the difference in error is most likely caused by the number of people surveyed. A smaller sample size naturally results in a larger margin of error, which matches the data provided for Sample A.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_7',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'From a population of 50,000 people, 1,000 were chosen at random and surveyed about a proposed piece of legislation. Based on the survey, it is estimated that 35% of people in the population support the legislation, with an associated margin of error of 3%. Based on these results, which of the following is a plausible value for the total number of people in the population who support the proposed legislation?',
  '[{"id":"a","text":"350"},{"id":"b","text":"650"},{"id":"c","text":"16,750"},{"id":"d","text":"31,750"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Determine the range of plausible percentages by calculating 35% minus 3% and 35% plus 3%, resulting in an interval from 32% to 38%. To convert this to a population count, multiply both percentages by the total population of 50,000. 32% of 50,000 is 16,000, and 38% of 50,000 is 19,000. A plausible total number of supporters must fall between these two values. Among the choices, 16,750 is the only value that fits within this range.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_8',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'In State X, Mr. Camp’s eighth-grade class consisting of 26 students was surveyed and 34.6 percent of the students reported that they had at least two siblings. The average eighth-grade class size in the state is 26. If the students in Mr. Camp’s class are representative of students in the state’s 1,800 eighth-grade classes, which of the following best estimates the number of eighth-grade students in the state who have fewer than two siblings?',
  '[{"id":"a","text":"16,200"},{"id":"b","text":"23,400"},{"id":"c","text":"30,600"},{"id":"d","text":"46,800"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Pay close attention to the definition of the target group. In this case, the sample data is provided for one category (at least two siblings), but the question asks for the estimate of the opposite category (fewer than two siblings).

\\textbf{Calculation and Logic:}

First, calculate the total number of eighth-grade students in the state by multiplying the 1,800 classes by the average size of 26 students per class, which equals 46,800 students. Next, find the percentage of students who have fewer than two siblings. Since 34.6% have at least two, subtract 34.6 from 100 to get 65.4%. Finally, multiply the total population of 46,800 by 65.4%, which is 0.654. This results in approximately 30,607 students. Choice C provides the closest estimate to this value.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_9',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A researcher wants to estimate the average time spent on homework by high school students in a large city. Which of the following sampling methods would most likely result in a representative sample?',
  '[{"id":"a","text":"Surveying 100 students at a local library."},{"id":"b","text":"Surveying 100 students from the city''s highest-performing high school."},{"id":"c","text":"Surveying 100 students selected at random from the city''s school enrollment records."},{"id":"d","text":"Surveying 100 students who volunteer to participate after an announcement at a sports event."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A representative sample must be unbiased and give every member of the population an equal chance of being selected. Random selection is the most effective way to avoid bias.

\\textbf{Calculation and Logic:}

Surveying students at a library (Choice A) or a sports event (Choice D) introduces bias because students in those locations may spend significantly more or less time on homework than the general population. Surveying only one specific high school (Choice B) is also biased because it does not account for the diversity of schools across the city. Choice C uses random selection from a complete list of all city students, which ensures that different types of students from different schools and backgrounds are likely to be included, making it the most representative method.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_10',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A survey of 1,200 randomly selected residents of a city found that 15% of the respondents walk to work. The margin of error for this estimate is 2%. Which of the following is the best interpretation of this margin of error?',
  '[{"id":"a","text":"It is plausible that between 13% and 17% of all city residents walk to work."},{"id":"b","text":"Exactly 15% of all city residents walk to work, but there is a 2% chance the survey is wrong."},{"id":"c","text":"The researchers are 2% sure that the actual percentage is 15%."},{"id":"d","text":"Between 13% and 17% of the 1,200 residents surveyed walk to work."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The margin of error indicates the range of values that are plausible for the entire population based on the sample data. It represents the potential difference between the sample result and the true population value.

\\textbf{Calculation and Logic:}

To find the plausible range, subtract the margin of error from the sample estimate and add it to the sample estimate. Calculating 15% minus 2% gives 13%, and adding 2% to 15% gives 17%. This interval of 13% to 17% represents the range where the true proportion of the entire city population is likely to fall. Choice D is incorrect because the margin of error describes the whole population, whereas we already know the exact percentage for the 1,200 people in the survey. Choice A correctly identifies this interval as the plausible range for the population.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_11',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A study was conducted to determine the average number of hours of sleep for high school students in a district. A random sample of 200 students from one high school in the district was surveyed. Which of the following limits the ability to generalize the results to all high school students in the district?',
  '[{"id":"a","text":"The sample size was too small."},{"id":"b","text":"The sample was not random."},{"id":"c","text":"The sample was only taken from one school in the district."},{"id":"d","text":"Sleep habits cannot be measured accurately with a survey."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Generalizing results requires that the sample be representative of the entire population being studied. If the population is "all students in a district," the sample should include students from various schools across that district.

\\textbf{Calculation and Logic:}

Even though the sample of 200 students was selected randomly, the selection was limited to only one high school. Students at different schools might have different start times, workloads, or extracurricular expectations that affect sleep. Because the sample did not account for the diversity of schools within the entire district, the results cannot be reliably applied to students at other schools. This geographic limitation creates a selection bias that prevents district-wide generalization.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_12',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A poll of 600 likely voters showed that 54% intended to vote for Candidate A, with a margin of error of 4%. What is the maximum percentage of likely voters that can be expected to vote for Candidate A based on this poll?',
  '[{"id":"a","text":"50%"},{"id":"b","text":"54%"},{"id":"c","text":"58%"},{"id":"d","text":"62%"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

The margin of error provides the upper and lower limits of the plausible range for the population. To find the maximum expected percentage, take the sample estimate of 54% and add the margin of error of 4%. The calculation of 54 plus 4 results in 58%. This value represents the highest plausible percentage of the total voter population that would support Candidate A according to the poll data.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_13',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'A random sample of 400 trees in a forest of 5,000 trees was examined. It was found that 12% of the trees in the sample were infected with a specific fungus. Based on this sample, how many trees in the entire forest are expected to be infected?',
  NULL,
  '600',
  '\\textbf{Conceptual Explanation:}

Inference allows us to project a proportion found in a random sample onto the total population size to estimate a total count.

\\textbf{Calculation and Logic:}

Identify the total population of trees in the forest, which is 5,000. Convert the sample percentage of 12% to a decimal, which is 0.12. To find the total infected count, multiply the population size of 5,000 by 0.12. Performing the multiplication of 5,000 and 0.12 results in 600. Therefore, the best estimate for the number of infected trees in the whole forest is 600.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_14',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A researcher interviewed 100 people who were leaving a fitness center and asked them how many days per week they exercise. The mean number of days was 4.5. Which of the following is true about this study?',
  '[{"id":"a","text":"The mean of 4.5 is a reliable estimate for the exercise habits of all people in the city."},{"id":"b","text":"The mean of 4.5 is a reliable estimate for the exercise habits of all members of that fitness center."},{"id":"c","text":"The sample is biased because it only includes people who were at a fitness center."},{"id":"d","text":"The sample size is too small to make any conclusions."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The validity of an inference depends on the sampling method. Sampling people at a specific location, like a gym, for a question about exercise habits leads to "convenience sampling" bias.

\\textbf{Calculation and Logic:}

The target population is likely the general public, but the researcher only interviewed people at a fitness center. People at a gym are much more likely to exercise frequently than the average person in the city. Because the sample was not chosen randomly from the whole city, it is not representative. Choice C correctly identifies that the location of the survey introduces a bias that makes the data unsuitable for generalizing to the broader population.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_15',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A larger sample size generally leads to which of the following?',
  '[{"id":"a","text":"A larger margin of error"},{"id":"b","text":"A smaller margin of error"},{"id":"c","text":"A more biased result"},{"id":"d","text":"No change in the margin of error"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

In statistics, the margin of error is inversely proportional to the sample size. As you collect more data from a larger group of people, the sample becomes a more precise reflection of the population, which reduces the uncertainty of the estimate. Therefore, increasing the sample size results in a smaller margin of error.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_040_16',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A quality control manager at a factory randomly selected 500 light bulbs from a day''s production of 20,000 bulbs. In the sample, 3 bulbs were defective. Which of the following is the best estimate of the number of defective light bulbs in the day''s production?',
  '[{"id":"a","text":"60"},{"id":"b","text":"120"},{"id":"c","text":"150"},{"id":"d","text":"300"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

First, find the proportion of defective bulbs in the sample by dividing 3 by 500, which is 0.006. Next, apply this proportion to the entire day''s production of 20,000 bulbs by multiplying 20,000 by 0.006. This calculation results in 120. Thus, based on the sample, we can estimate that there are 120 defective bulbs in the total production.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_17',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A biologist is studying the average weight of squirrels in a park. Which of the following squirrel samples is most likely to be representative?',
  '[{"id":"a","text":"The first 10 squirrels found near a bird feeder in the morning."},{"id":"b","text":"20 squirrels caught in various locations throughout the park at different times of the day."},{"id":"c","text":"5 squirrels that appear to be the largest in the park."},{"id":"d","text":"50 squirrels caught in a single trap located near the park entrance."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Representativeness requires that the sample be selected in a way that minimizes bias, usually through randomization across different locations and times.

\\textbf{Calculation and Logic:}

Choice A is biased by location (bird feeder) and time. Choice C is biased because it deliberately selects for size. Choice D is biased because it only looks at squirrels at the entrance. Choice B is the most representative because it collects data from multiple locations and times, ensuring that squirrels with different behaviors and habitats within the park are included in the study.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_18',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'An estimate for the percentage of students who favor a new school policy is 65%, with a margin of error of 5%. Which of the following percentages is NOT a plausible value for the true population proportion?',
  '[{"id":"a","text":"61%"},{"id":"b","text":"64%"},{"id":"c","text":"68%"},{"id":"d","text":"72%"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

The plausible range is found by calculating the lower and upper bounds of the confidence interval. Subtracting 5% from 65% gives 60%, and adding 5% to 65% gives 70%. Any value between 60% and 70% is considered plausible. Comparing the choices, 61%, 64%, and 68% all fall within this range. However, 72% is outside of the interval, making it an implausible value for the true population proportion.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_19',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'In a random sample of 250 students, 40 reported that they play a musical instrument. If there are 2,000 students in the school, how many are estimated to play a musical instrument?',
  NULL,
  '320',
  '\\textbf{Calculation and Logic:}

First, find the fraction of students in the sample who play an instrument, which is 40 out of 250. This fraction can be simplified to 4 out of 25, or a decimal of 0.16. Multiply the total school population of 2,000 by this proportion of 0.16. Multiplying 2,000 by 0.16 results in 320. This indicates that approximately 320 students in the school play an instrument.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_20',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A city council wants to know if residents support a new park. They mail a survey to every household and receive responses from 5% of them. Which of the following is the most likely bias in this study?',
  '[{"id":"a","text":"The sample size is too large."},{"id":"b","text":"The survey was not mailed to everyone."},{"id":"c","text":"Nonresponse bias, because those who feel strongly are more likely to respond."},{"id":"d","text":"The survey was sent at the wrong time of year."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Nonresponse bias occurs when the people who choose to respond to a survey have different opinions than the people who do not, often because they have a stronger emotional connection to the topic.

\\textbf{Calculation and Logic:}

Even though the survey was sent to every household, the very low response rate of 5% means the final sample is no longer random. People who strongly support or strongly oppose the park are the most motivated to fill out and mail back the survey. This means the 5% who responded do not accurately reflect the views of the 95% who stayed silent. This is a classic example of nonresponse bias.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_21',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'If the margin of error for a study is decreased, the confidence interval for the population parameter will:',
  '[{"id":"a","text":"Become wider"},{"id":"b","text":"Become narrower"},{"id":"c","text":"Stay the same"},{"id":"d","text":"Shift to the right"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

The confidence interval is defined as the estimate plus or minus the margin of error. If the margin of error gets smaller (for example, by increasing the sample size), the distance between the lower bound and the upper bound decreases. This results in a "narrower" interval, which represents a more precise estimate of the population.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_040_22',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A sample of 50 commuters was asked about their commute time, and the mean was 30 minutes with a margin of error of 5 minutes. Which conclusion is most appropriate?',
  '[{"id":"a","text":"Every commuter in the city has a commute between 25 and 35 minutes."},{"id":"b","text":"Most commuters in the city have a commute of exactly 30 minutes."},{"id":"c","text":"The true mean commute time for all commuters is likely between 25 and 35 minutes."},{"id":"d","text":"The study is invalid because the sample size is only 50."}]'::jsonb,
  'c',
  '\\textbf{Logic:}

Apply the margin of error to the sample mean to find the plausible interval: 30 minus 5 is 25, and 30 plus 5 is 35. This range of 25 to 35 minutes estimates the true average of the whole population. Choices A and B are incorrect because they focus on individual commuters rather than the population mean. Choice C correctly uses the margin of error to describe the population parameter.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_23',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'A biologist estimated that 24% of a certain bird population has a wingspan of over 10 inches, with a margin of error of 4%. If there are 5,000 birds in the population, what is the \\textbf{minimum} plausible number of birds with a wingspan over 10 inches?',
  NULL,
  '1000',
  '\\textbf{Calculation and Logic:}

To find the minimum plausible number, first find the lower bound of the percentage range by subtracting the 4% margin of error from the 24% estimate, which equals 20%. Next, calculate 20% of the total bird population of 5,000 by multiplying 5,000 by 0.20. This calculation results in 1,000 birds.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_24',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'Which of the following is necessary for a sample to be representative of a population?',
  '[{"id":"a","text":"The sample must include at least half of the population."},{"id":"b","text":"The sample must be selected randomly from the population."},{"id":"c","text":"The sample must be taken from people who are interested in the study."},{"id":"d","text":"The sample must be as large as possible regardless of selection method."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

Randomization is the core requirement for representativeness because it ensures that every individual in the population has an equal chance of being included. This prevents selection bias and allows researchers to use the sample to make valid inferences about the larger group. Size alone (Choice D) or interest in the study (Choice C) do not guarantee that the sample will look like the population.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_25',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A study found that the mean price of a gallon of milk in a city is 3.50, with a margin of error of 0.15. Which of the following is a plausible mean price for a gallon of milk in the city?',
  '[{"id":"a","text":"3.30"},{"id":"b","text":"3.40"},{"id":"c","text":"3.70"},{"id":"d","text":"4.00"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Calculate the confidence interval for the mean price. The lower bound is 3.50 minus 0.15, which is 3.35. The upper bound is 3.50 plus 0.15, which is 3.65. Any value between 3.35 and 3.65 is considered a plausible mean. Comparing the choices, 3.40 is the only value that falls within this range.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_26',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'To determine the popularity of a new movie, a researcher surveys the first 50 people who enter the theater for the 7:00 PM showing. What type of sampling bias is most likely present?',
  '[{"id":"a","text":"Nonresponse bias"},{"id":"b","text":"Undercoverage bias, because it only surveys people already at the movie."},{"id":"c","text":"Measurement bias, because people may lie about liking the movie."},{"id":"d","text":"No bias is present because it is a random sample of moviegoers."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

The target population is likely all potential moviegoers or the general public. However, by only surveying people who are already entering the theater to see that specific movie, the researcher is excluding everyone who chose not to see it or who doesn''t go to theaters. This is undercoverage bias, as a large portion of the population is systematically excluded from the study.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_27',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A scientist surveyed 200 adults in a town and found that 45% exercise at least 3 times a week, with a margin of error of 6%. If the town has 10,000 adults, which of the following is a plausible number of adults who exercise at least 3 times a week?',
  '[{"id":"a","text":"3,500"},{"id":"b","text":"4,200"},{"id":"c","text":"5,300"},{"id":"d","text":"6,000"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Establish the percentage range: 45% minus 6% is 39%, and 45% plus 6% is 51%. Next, calculate these bounds for the total population of 10,000 adults. 39% of 10,000 is 3,900, and 51% of 10,000 is 5,100. Any plausible number must be between 3,900 and 5,100. Choice B (4,200) is the only value that falls within this interval.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_28',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'In a random sample of 100 batteries, 2 were found to be defective. If a factory produces 50,000 batteries in a day, how many defective batteries are expected?',
  NULL,
  '1000',
  '\\textbf{Calculation and Logic:}

Find the sample proportion by dividing 2 by 100, which is 0.02. Multiply the total production of 50,000 batteries by this decimal of 0.02. The calculation of 50,000 times 0.02 results in 1,000. Therefore, 1,000 batteries are expected to be defective.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_040_29',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A random sample of 1,000 people was used to estimate that 22% of a population has a certain trait, with a margin of error of 1.5%. If the sample size were increased to 4,000 people, what would most likely happen to the margin of error?',
  '[{"id":"a","text":"It would double to 3.0%."},{"id":"b","text":"It would stay at 1.5%."},{"id":"c","text":"It would decrease to approximately 0.75%."},{"id":"d","text":"It would decrease to 0%."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The margin of error is proportional to $1/\\sqrt{n}$. When the sample size $n$ is multiplied by a factor of 4, the margin of error is divided by the square root of 4.

\\textbf{Calculation and Logic:}

Increasing the sample size from 1,000 to 4,000 is a fourfold increase ($n × 4$). Since the error is related to the square root of the sample size, and the square root of 4 is 2, the new margin of error will be approximately half of the original. Dividing 1.5% by 2 results in 0.75%. This reflects the general rule that larger samples provide more precision and smaller errors.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_30',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A researcher conducted a survey of 400 randomly selected residents in a town of 10,000 people. The survey found that 22% of the residents support a new tax, with a margin of error of 4%. Which of the following is a plausible range for the number of residents in the town who support the new tax?',
  '[{"id":"a","text":"1,800 to 2,600"},{"id":"b","text":"2,200 to 2,600"},{"id":"c","text":"1,800 to 2,200"},{"id":"d","text":"400 to 10,000"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

To find the plausible range for a population count, first determine the lower and upper percentage bounds using the margin of error, then apply those percentages to the total population.

\\textbf{Calculation and Logic:}

Lower bound percentage: $22% - 4% = 18%$. Upper bound percentage: $22% + 4% = 26%$. Apply these to the population of 10,000: $0.18 × 10,000 = 1,800$ and $0.26 × 10,000 = 2,600$. The plausible number of supporters is between 1,800 and 2,600.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_31',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'In a random sample of 500 light bulbs from a batch of 12,000, 15 bulbs were found to be defective. Based on this sample, what is the estimated total number of defective light bulbs in the batch?',
  NULL,
  '360',
  '\\textbf{Calculation and Logic:}

Sample proportion: $15 / 500 = 0.03$. Apply to the total batch: $0.03 × 12,000$. $3 × 120 = 360$. The estimated number of defective bulbs is 360.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_32',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A study of 1,000 randomly selected adults in a city found that the mean amount spent on groceries per week is 150, with a margin of error of 12. Which of the following is the most plausible value for the true mean weekly grocery expenditure for all adults in the city?',
  '[{"id":"a","text":"135"},{"id":"b","text":"145"},{"id":"c","text":"165"},{"id":"d","text":"175"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Calculate the interval: $150 - 12 = 138$ and $150 + 12 = 162$. Any plausible mean must fall between 138 and 162. Comparing the choices: 135 is too low, 165 and 175 are too high. 145 is the only value within the range of 138 to 162.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_33',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A biologist tagged 40 fish in a lake. Later, a random sample of 100 fish was caught, and 5 of them were found to be tagged. Based on this, what is the estimated total number of fish in the lake?',
  '[{"id":"a","text":"200"},{"id":"b","text":"400"},{"id":"c","text":"800"},{"id":"d","text":"2,000"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Set up a proportion: $\\frac{\\text{Tagged Sample}}{\\text{Total Sample}} = \\frac{\\text{Total Tagged}}{\\text{Total Population}}$. $(5)/(100) = (40)/(x)$. Cross multiply: $5x = 4,000$. Divide by 5: $x = 800$. The total population is estimated to be 800.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_34',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'Which change to a survey would most likely decrease the margin of error?',
  '[{"id":"a","text":"Increasing the population size."},{"id":"b","text":"Increasing the sample size."},{"id":"c","text":"Decreasing the sample size."},{"id":"d","text":"Changing the survey questions to be more general."}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

The margin of error formula involves $1/\\sqrt{n}$, where $n$ is the sample size. As $n$ increases, the value of the error term decreases. Therefore, increasing the sample size directly reduces the margin of error.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_040_35',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'A city with 50,000 households has an estimated 14% of households using a specific internet provider, with a margin of error of 1.5%. What is the \\textbf{maximum} plausible number of households using this provider?',
  NULL,
  '7750',
  '\\textbf{Calculation and Logic:}

Max percentage: $14% + 1.5% = 15.5%$. Convert to decimal: $0.155$. Multiply by total households: $50,000 × 0.155$. $50 × 155 = 7,750$. The maximum plausible number is 7,750.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_36',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A random sample of 80 students found that 25% take the bus to school. If there are 1,200 students in the school, which is the best estimate for the number of students who do \\textbf{not} take the bus?',
  '[{"id":"a","text":"300"},{"id":"b","text":"600"},{"id":"c","text":"900"},{"id":"d","text":"1,200"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Percentage who do not take the bus: $100% - 25% = 75%$. Apply to total population: $1,200 × 0.75 = 900$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_37',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A survey of 600 people has a margin of error of 4%. If the sample size is increased to 2,400 people, what will be the new margin of error?',
  '[{"id":"a","text":"1%"},{"id":"b","text":"2%"},{"id":"c","text":"8%"},{"id":"d","text":"16%"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Ratio of sample sizes: $2400 / 600 = 4$. Margin of error is proportional to $1/\\sqrt{n}$. The error will be divided by $\\sqrt{4} = 2$. New error: $4% / 2 = 2%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_38',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'A factory produces 40,000 widgets a day. A random sample of 800 widgets showed that 2 were oversized. How many widgets in the day''s production are expected to be oversized?',
  NULL,
  '100',
  '\\textbf{Calculation and Logic:}

Sample proportion: $2 / 800 = 1 / 400 = 0.0025$. Multiply by population: $40,000 × 0.0025 = 100$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_39',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A poll estimated that 40% of residents support a new law with a margin of error of 3%. Which of the following is the best description of the 3%?',
  '[{"id":"a","text":"3% of the people in the sample lied."},{"id":"b","text":"3% of the total population was not reached."},{"id":"c","text":"The actual population percentage is likely between 37% and 43%."},{"id":"d","text":"The poll is exactly 3% away from being perfectly accurate."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Calculate interval: $40% - 3% = 37%$ and $40% + 3% = 43%$. This range represents the likely values for the true population percentage. Choice C correctly identifies this range.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_40',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'If 15% of a random sample of 200 people like a product, how many people in the sample like the product?',
  NULL,
  '30',
  '\\textbf{Calculation and Logic:}

$200 × 0.15 = 30$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_040_41',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A study found that the mean height of a sample of plants is 12 cm, with a margin of error of 2 cm. What is the width of the confidence interval?',
  '[{"id":"a","text":"2 cm"},{"id":"b","text":"4 cm"},{"id":"c","text":"10 cm"},{"id":"d","text":"14 cm"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Interval is $12 - 2 = 10$ to $12 + 2 = 14$. Width = Upper Bound $-$ Lower Bound. $14 - 10 = 4$. (Alternatively, width is always $2 ×$ margin of error). $2 × 2 = 4$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_42',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'A school has 1,500 students. A random sample of 50 students found that 10 were on the honor roll. How many students in the school are expected to be on the honor roll?',
  NULL,
  '300',
  '\\textbf{Calculation and Logic:}

Proportion: $10 / 50 = 1 / 5 = 0.2$. Population estimate: $1,500 × 0.2 = 300$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_43',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A researcher wants to survey the residents of a building with 40 floors. They survey all the residents on floors 1, 10, 20, 30, and 40. This is an example of what type of sampling?',
  '[{"id":"a","text":"Random sampling"},{"id":"b","text":"Cluster sampling"},{"id":"c","text":"Stratified sampling"},{"id":"d","text":"Convenience sampling"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

The researcher divided the population into groups (floors) and selected specific entire groups to survey. This is the definition of cluster sampling.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_44',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A sample size of $n=100$ has a margin of error of $E$. What happens to the error if $n$ is increased to $n=10,000$?',
  '[{"id":"a","text":"It is divided by 10."},{"id":"b","text":"It is divided by 100."},{"id":"c","text":"It is multiplied by 10."},{"id":"d","text":"It stays the same."}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Factor of increase: $10,000 / 100 = 100$. Error is divided by the square root of the factor: $\\sqrt{100} = 10$. The error is divided by 10.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_040_45',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A random sample of 250 adults showed that 60% own a car. If there are 10,000 adults in the town, what is the best estimate for the number of adults who own a car?',
  '[{"id":"a","text":"2,500"},{"id":"b","text":"6,000"},{"id":"c","text":"8,500"},{"id":"d","text":"10,000"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$10,000 × 0.60 = 6,000$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_46',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'A survey of 1,000 people has an estimate of 30% with a margin of error of 2.5%. What is the \\textbf{minimum} plausible number of people in a population of 20,000 that share this trait?',
  NULL,
  '5500',
  '\\textbf{Calculation and Logic:}

Min percentage: $30% - 2.5% = 27.5%$. Convert to decimal: $0.275$. Multiply by population: $20,000 × 0.275 = 5,500$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_47',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'Which of the following is the primary goal of random sampling?',
  '[{"id":"a","text":"To make the survey easier to conduct."},{"id":"b","text":"To ensure the sample is as small as possible."},{"id":"c","text":"To ensure every individual in the population has an equal chance of being selected."},{"id":"d","text":"To guarantee the sample results are 100% accurate."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Random sampling is designed to eliminate selection bias by giving every member of the population an equal probability of being chosen, which makes the sample representative.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_040_48',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'spr',
  'math',
  'A random sample of 40 students found that 8 take an art class. What percentage of the sample takes an art class?',
  NULL,
  '20',
  '\\textbf{Calculation and Logic:}

$8 / 40 = 1 / 5 = 0.20 = 20%$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_040_49',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
),
  (
  'mcq',
  'math',
  'A city with 1,000,000 people is surveyed. A random sample of 1,000 people gives an estimate with a margin of error of 3%. If the city''s population grew to 2,000,000 but the sample size stayed at 1,000, what would happen to the margin of error?',
  '[{"id":"a","text":"It would double to 6%."},{"id":"b","text":"It would decrease to 1.5%."},{"id":"c","text":"It would stay approximately 3%."},{"id":"d","text":"It would decrease to 0%."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

The margin of error formula depends on the sample size ($n$), not the total population size ($N$), as long as the population is significantly larger than the sample. Since $n$ remains 1,000, the margin of error remains 3%.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_040_50',
  'Inference from samples, margin of error',
  'Sample Validity & Bias'
)
ON CONFLICT (bank_item_id) DO NOTHING;

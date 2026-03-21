-- Practice-mode math from lid_041.tex (sat_lid_041)
-- Chapter: Inference from samples, margin of error | Topic: Margin of Error & Confidence
-- sat_questions: section=math, domain=problem-solving, bank_item_id=sat_lid_041_N, practice module/set 0.

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
  'Based on a random sample from a population, a researcher estimated that the mean value of a certain variable for the population is 20.5, with an associated margin of error of 1. Which of the following is the most appropriate conclusion?',
  '[{"id":"a","text":"It is plausible that the actual mean value of the variable for the population is between 19.5 and 21.5."},{"id":"b","text":"It is not possible that the mean value of the variable for the population is less than 19.5 or greater than 21.5."},{"id":"c","text":"Every value of the variable in the population is between 19.5 and 21.5."},{"id":"d","text":"The mean value of the variable for the population is 20.5."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The margin of error defines a confidence interval—a range of values within which the true population parameter (like a mean or proportion) is likely to fall. It does not provide absolute certainty or describe individual data points.

\\textbf{Calculation and Logic:}

Lower bound: $20.5 - 1 = 19.5$. Upper bound: $20.5 + 1 = 21.5$. The interval [19.5, 21.5] represents the range of plausible values for the true population mean. Choice B is too strong because "not possible" ignores the nature of statistical probability. Choice C is incorrect because the interval describes the mean of the population, not every individual value in it. Choice D is incorrect because the sample mean is just an estimate, not necessarily the exact population mean.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_1',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'To estimate the proportion of a population that has a certain characteristic, a random sample was selected from the population. Based on the sample, it is estimated that the proportion of the population that has the characteristic is 0.49, with an associated margin of error of 0.04. Based on this estimate and margin of error, which of the following is the most appropriate conclusion about the proportion of the population that has the characteristic?',
  '[{"id":"a","text":"It is plausible that the proportion is between 0.45 and 0.53."},{"id":"b","text":"It is plausible that the proportion is less than 0.45."},{"id":"c","text":"The proportion is exactly 0.49."},{"id":"d","text":"It is plausible that the proportion is greater than 0.53."}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Lower bound calculation: $0.49 - 0.04 = 0.45$. Upper bound calculation: $0.49 + 0.04 = 0.53$. The resulting interval is 0.45 to 0.53. This range contains the values that are statistically plausible for the actual population proportion.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_2',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'In a study, the data from a random sample of a population had a mean of 37, with an associated margin of error of 3. Which of the following is the most appropriate conclusion that can be made about the population mean?',
  '[{"id":"a","text":"It is less than 37."},{"id":"b","text":"It is greater than 37."},{"id":"c","text":"It is between 34 and 40."},{"id":"d","text":"It is less than 34 or greater than 40."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Confidence Interval = Estimate $\\pm$ Margin of Error. $37 - 3 = 34$ and $37 + 3 = 40$. The plausible values for the true population mean fall between 34 and 40.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_041_3',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A company that produces socks wants to estimate the percent of the socks produced in a typical week that are defective. A random sample of 310 socks produced in a certain week were inspected. Based on the sample, it is estimated that 12% of all socks produced by the company in this week are defective, with an associated margin of error of 3.62%. Which of the following is the most appropriate conclusion about all socks produced by the company during this week?',
  '[{"id":"a","text":"3.62% of the socks are defective."},{"id":"b","text":"It is plausible that between 8.38% and 15.62% of the socks are defective."},{"id":"c","text":"12% of the socks are defective."},{"id":"d","text":"It is plausible that more than 15.62% of the socks are defective."}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Percentage range: $12% - 3.62% = 8.38%$ and $12% + 3.62% = 15.62%$. This range [8.38%, 15.62%] represents the set of plausible values for the actual percentage of defective socks in the entire weekly production.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_4',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A bag containing 10,000 beads of assorted colors is purchased from a craft store. To estimate the percent of red beads in the bag, a sample of beads is selected at random. The percent of red beads in the bag was estimated to be 15%, with an associated margin of error of 2%. If $r$ is the actual number of red beads in the bag, which of the following is most plausible?',
  '[{"id":"a","text":"$r > 1,700$"},{"id":"b","text":"$1,300 < r < 1,700$"},{"id":"c","text":"$200 < r < 1,500$"},{"id":"d","text":"$r < 1,300$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

To move from a percentage interval to a population count, apply the lower and upper bounds of the percentage range to the total population size.

\\textbf{Calculation and Logic:}

Percentage bounds: $15% \\pm 2% = [13%, 17%]$. Calculate the count for 10,000 beads: $0.13 × 10,000 = 1,300$ and $0.17 × 10,000 = 1,700$. Therefore, it is plausible that the actual number of red beads, $r$, falls between 1,300 and 1,700.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_5',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|c|c|c|} \\hline Sample & Percent in favor & Margin of error \\hline A & 52% & 4.2% \\hline B & 48% & 1.6% \\hline \\end{tabular} \\end{center} The results of two random samples of votes for a proposition are shown above. Which of the following is the most appropriate reason that the margin of error for sample A is greater than the margin of error for sample B?',
  '[{"id":"a","text":"Sample A had a smaller number of votes that could not be recorded."},{"id":"b","text":"Sample A had a higher percent of favorable responses."},{"id":"c","text":"Sample A had a larger sample size."},{"id":"d","text":"Sample A had a smaller sample size."}]'::jsonb,
  'd',
  '\\textbf{Logic:}

The margin of error is inversely related to the sample size. As the number of participants ($n$) in a random sample increases, the estimate becomes more precise, causing the margin of error to decrease. Since Sample A has a much larger margin of error (4.2%) compared to Sample B (1.6%), it implies that Sample A had fewer respondents (a smaller sample size).',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_6',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'From a population of 50,000 people, 1,000 were chosen at random and surveyed. Based on the survey, it is estimated that 35% support a piece of legislation, with a margin of error of 3%. Which of the following is a plausible value for the total number of people in the population who support the legislation?',
  '[{"id":"a","text":"350"},{"id":"b","text":"650"},{"id":"c","text":"16,750"},{"id":"d","text":"31,750"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Percentage range: $35% \\pm 3% = [32%, 38%]$. Apply these percentages to the population of 50,000: $0.32 × 50,000 = 16,000$ and $0.38 × 50,000 = 19,000$. A plausible value must fall within the range of 16,000 to 19,000. Among the choices, 16,750 is the only value in that range.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_7',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A quality control manager inspected a random sample of 200 light bulbs and found that 4 were defective. If the factory produces 10,000 bulbs per day, what is the best estimate for the total number of defective bulbs?',
  '[{"id":"a","text":"20"},{"id":"b","text":"100"},{"id":"c","text":"200"},{"id":"d","text":"400"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Sample proportion: $4 / 200 = 0.02$. Population estimate: $0.02 × 10,000 = 200$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_041_8',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'A random sample of 500 residents of a town was surveyed, and 40% reported that they exercise daily. If the associated margin of error is 5%, what is the \\textbf{maximum} plausible number of residents who exercise daily in a town of 8,000 people?',
  NULL,
  '3600',
  '\\textbf{Calculation and Logic:}

Max plausible percentage: $40% + 5% = 45%$. Max plausible count: $0.45 × 8,000 = 3,600$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_9',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'If the sample size of a random survey is increased from 400 to 1,600, what will happen to the margin of error?',
  '[{"id":"a","text":"It will be multiplied by 4."},{"id":"b","text":"It will be multiplied by 2."},{"id":"c","text":"It will be divided by 2."},{"id":"d","text":"It will be divided by 4."}]'::jsonb,
  'c',
  '\\textbf{Logic:}

The margin of error is proportional to $1/\\sqrt{n}$. The sample size increased by a factor of 4 ($1,600 / 400 = 4$). Therefore, the margin of error is divided by $\\sqrt{4}$, which is 2.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_10',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A survey of a random sample of 1,200 residents of a city found that 15% of the respondents walk to work. The margin of error for this estimate is 2%. Which of the following is the best interpretation of this margin of error?',
  '[{"id":"a","text":"It is plausible that between 13% and 17% of all city residents walk to work."},{"id":"b","text":"Exactly 15% of all city residents walk to work, but there is a 2% chance the survey is wrong."},{"id":"c","text":"The researchers are 2% sure that the actual percentage is 15%."},{"id":"d","text":"Between 13% and 17% of the 1,200 residents surveyed walk to work."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The margin of error defines the range around the sample estimate where the actual population parameter is likely to be found. It accounts for the variability inherent in using a sample instead of the entire population.

\\textbf{Calculation and Logic:}

Calculate the interval bounds: $15% - 2% = 13%$ and $15% + 2% = 17%$. This interval of 13% to 17% represents the set of plausible values for the percentage of the entire city population that walks to work. Choice D is incorrect because we already know the exact data for the 1,200 people surveyed; the error only applies when making an inference about the larger population.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_11',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A study was conducted to determine the average number of hours of sleep for high school students in a district. A random sample of 200 students from one high school in the district was surveyed. Which of the following limits the ability to generalize the results to all high school students in the district?',
  '[{"id":"a","text":"The sample size was too small."},{"id":"b","text":"The sample was not random."},{"id":"c","text":"The sample was only taken from one school in the district."},{"id":"d","text":"Sleep habits cannot be measured accurately with a survey."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

To generalize results to a larger population (all students in the district), the sample must be representative of that entire population. Since the students were only selected from one specific school, students from other schools with different schedules or workloads were excluded. This geographic bias prevents the results from being applied to the whole district.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_12',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A poll of 600 likely voters showed that 54% intended to vote for Candidate A, with a margin of error of 4%. What is the maximum percentage of likely voters that can be expected to vote for Candidate A based on this poll?',
  '[{"id":"a","text":"50%"},{"id":"b","text":"54%"},{"id":"c","text":"58%"},{"id":"d","text":"62%"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Upper bound calculation: $\\text{Estimate} + \\text{Margin of Error}$. $54% + 4% = 58%$. The maximum plausible support for the candidate in the general population is 58%.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_13',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'A random sample of 400 trees in a forest of 5,000 trees was examined. It was found that 12% of the trees in the sample were infected with a specific fungus. Based on this sample, how many trees in the entire forest are estimated to be infected?',
  NULL,
  '600',
  '\\textbf{Calculation and Logic:}

Sample proportion in decimal form: $0.12$. Estimated total infected: $0.12 × 5,000 = 600$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_14',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A researcher interviewed 100 people who were leaving a fitness center and asked them how many days per week they exercise. The mean number of days was 4.5. Which of the following is true about this study?',
  '[{"id":"a","text":"The mean of 4.5 is a reliable estimate for the exercise habits of all people in the city."},{"id":"b","text":"The mean of 4.5 is a reliable estimate for the exercise habits of all members of that fitness center."},{"id":"c","text":"The sample is biased because it only includes people who were at a fitness center."},{"id":"d","text":"The sample size is too small to make any conclusions."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

The target population is likely the general public, but by surveying only people at a gym, the researcher uses "convenience sampling." People leaving a gym are significantly more likely to exercise than the general population. Because the sample is not representative of all residents, the result is biased and cannot be generalized to the city.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_15',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A larger sample size generally leads to which of the following?',
  '[{"id":"a","text":"A larger margin of error"},{"id":"b","text":"A smaller margin of error"},{"id":"c","text":"A more biased result"},{"id":"d","text":"No change in the margin of error"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

The margin of error is calculated using the formula $z × \\sqrt{(p(1-p))/(n)}$. Because the sample size $n$ is in the denominator, as $n$ increases, the overall value of the error decreases. Larger samples provide more precision.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_041_16',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A quality control manager at a factory randomly selected 500 light bulbs from a day''s production of 20,000 bulbs. In the sample, 3 bulbs were defective. Which of the following is the best estimate of the number of defective light bulbs in the day''s production?',
  '[{"id":"a","text":"60"},{"id":"b","text":"120"},{"id":"c","text":"150"},{"id":"d","text":"300"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Sample proportion defective: $3 / 500 = 0.006$. Total production estimate: $0.006 × 20,000 = 120$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_17',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A biologist is studying the average weight of squirrels in a park. Which of the following squirrel samples is most likely to be representative?',
  '[{"id":"a","text":"The first 10 squirrels found near a bird feeder in the morning."},{"id":"b","text":"20 squirrels caught in various locations throughout the park at different times of the day."},{"id":"c","text":"5 squirrels that appear to be the largest in the park."},{"id":"d","text":"50 squirrels caught in a single trap located near the park entrance."}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Choice B is the most representative because it employs a randomized approach across both space (various locations) and time. Choice A is biased by location/food source; Choice C is biased by size; Choice D is biased by a single fixed location.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_18',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'An estimate for the percentage of students who favor a new school policy is 65%, with a margin of error of 5%. Which of the following percentages is NOT a plausible value for the true population proportion?',
  '[{"id":"a","text":"61%"},{"id":"b","text":"64%"},{"id":"c","text":"68%"},{"id":"d","text":"72%"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

Plausible range: $65% - 5% = 60%$ to $65% + 5% = 70%$. Any percentage within [60%, 70%] is plausible. $72%$ is outside this range.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_19',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'In a random sample of 250 students, 40 reported that they play a musical instrument. If there are 2,000 students in the school, how many are estimated to play a musical instrument?',
  NULL,
  '320',
  '\\textbf{Calculation and Logic:}

Sample proportion: $40 / 250 = 0.16$. Estimate for school: $0.16 × 2,000 = 320$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_20',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A city council wants to estimate the proportion of residents who support a new park. A random sample of 800 residents was surveyed, and 62% expressed support, with an associated margin of error of 3.5%. Which of the following is the most plausible range for the number of supporters in the city''s population of 120,000?',
  '[{"id":"a","text":"70,200 to 78,600"},{"id":"b","text":"74,400 to 78,600"},{"id":"c","text":"70,200 to 74,400"},{"id":"d","text":"62,000 to 120,000"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

To determine the plausible range for a total count, calculate the lower and upper bounds of the confidence interval percentage and multiply them by the total population size.

\\textbf{Calculation and Logic:}

Lower bound percentage: $62% - 3.5% = 58.5%$. Upper bound percentage: $62% + 3.5% = 65.5%$. Apply to population: $120,000 × 0.585 = 70,200$ and $120,000 × 0.655 = 78,600$. The plausible number of supporters is between 70,200 and 78,600.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_21',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'A random sample of 40 students from a school of 600 students was asked if they own a tablet. If 10 students in the sample responded "yes," what is the best estimate for the total number of students in the school who own a tablet?',
  NULL,
  '150',
  '\\textbf{Calculation and Logic:}

Sample proportion: $10 / 40 = 0.25$. Population estimate: $600 × 0.25 = 150$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_22',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A scientist surveyed 1,000 people and estimated that 28% of a population has a specific allergy, with a margin of error of 2.4%. If the scientist wants to reduce the margin of error to 1.2%, what should the new sample size be?',
  '[{"id":"a","text":"2,000"},{"id":"b","text":"4,000"},{"id":"c","text":"8,000"},{"id":"d","text":"10,000"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

The scientist wants to cut the margin of error in half ($1/2$). The margin of error is proportional to $1/\\sqrt{n}$. To divide the error by 2, the sample size must be multiplied by $2^2 = 4$. New sample size: $1,000 × 4 = 4,000$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_23',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'A survey of 500 car owners found that the mean annual maintenance cost is 450, with a margin of error of 25. What is the \\textbf{minimum} plausible mean annual maintenance cost for the population of all car owners?',
  NULL,
  '425',
  '\\textbf{Calculation and Logic:}

Lower bound: $450 - 25 = 425$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_24',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'Which of the following is true about a margin of error?',
  '[{"id":"a","text":"It represents the percentage of the sample that was calculated incorrectly."},{"id":"b","text":"It is a range within which the actual population mean is likely to fall."},{"id":"c","text":"It identifies the exact value of the population mean."},{"id":"d","text":"It describes the difference between the largest and smallest values in the sample."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

The margin of error expresses the degree of uncertainty in a sample-based estimate. It defines an interval around the sample mean (or proportion) where the true population parameter is expected to be found.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_25',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A factory produces 50,000 units per month. A random sample of 1,000 units found that 1.5% were defective, with a margin of error of 0.4%. What is the \\textbf{maximum} plausible number of defective units produced in a month?',
  '[{"id":"a","text":"550"},{"id":"b","text":"750"},{"id":"c","text":"950"},{"id":"d","text":"1,250"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Maximum plausible percentage: $1.5% + 0.4% = 1.9%$. Decimal form: $0.019$. Max count: $50,000 × 0.019 = 950$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_26',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'An environmental study of 250 lakes found that 12% had high acidity levels. If the margin of error is 3%, which of the following is a plausible acidity percentage for all lakes in the region?',
  '[{"id":"a","text":"8%"},{"id":"b","text":"11%"},{"id":"c","text":"16%"},{"id":"d","text":"20%"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Confidence interval: $12% \\pm 3% = [9%, 15%]$. A plausible value must be in this range. 11% is the only choice that fits.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_27',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'A random sample of 150 employees at a company of 1,200 found that 80% prefer a four-day work week. How many employees in the entire company are estimated to prefer a four-day work week?',
  NULL,
  '960',
  '\\textbf{Calculation and Logic:}

$1,200 × 0.80 = 960$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_28',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'If the sample size is multiplied by 9, the margin of error will most likely:',
  '[{"id":"a","text":"Be multiplied by 9."},{"id":"b","text":"Be multiplied by 3."},{"id":"c","text":"Be divided by 3."},{"id":"d","text":"Be divided by 9."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Error is proportional to $1/\\sqrt{n}$. If $n$ becomes $9n$, the error becomes $1/\\sqrt{9} = 1/3$ of its original value.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_29',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A national poll found that 45% of respondents favor a new policy, with a margin of error of 2.1%. If the poll is representative of 250 million people, what is the best estimate for the difference between the maximum and minimum plausible number of people who favor the policy?',
  '[{"id":"a","text":"5.25 million"},{"id":"b","text":"10.5 million"},{"id":"c","text":"112.5 million"},{"id":"d","text":"239.5 million"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

The difference between the max and min bound is equal to $2 × \\text{Margin of Error}$. Total range width in percentage: $2 × 2.1% = 4.2%$. Total range width in population: $250,000,000 × 0.042 = 10,500,000$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_30',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'In a random sample of 200 light bulbs, 6 were found to be broken. What percentage of the sample was broken?',
  NULL,
  '3',
  '\\textbf{Calculation and Logic:}

$6 / 200 = 3 / 100 = 3%$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_041_31',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A scientist estimated that the population of a certain bird species is 4,500 with a margin of error of 400. If a second study with a larger sample size has a margin of error of 200, which is most likely the width of the new confidence interval?',
  '[{"id":"a","text":"200"},{"id":"b","text":"400"},{"id":"c","text":"800"},{"id":"d","text":"4,500"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Width of interval = $2 × \\text{Margin of Error}$. For the new study: $2 × 200 = 400$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_32',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'If 18% of a population of 5,000 has a certain trait, how many individuals have that trait?',
  NULL,
  '900',
  '\\textbf{Calculation and Logic:}

$5,000 × 0.18 = 900$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_33',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A study found that 52% of a sample of 400 high school students play video games daily, with a margin of error of 5%. Which statement is most accurate?',
  '[{"id":"a","text":"5% of the students do not play video games."},{"id":"b","text":"Exactly 208 students in the school play video games."},{"id":"c","text":"It is plausible that between 47% and 57% of all high school students play video games daily."},{"id":"d","text":"The margin of error would increase if the sample size were increased to 1,000."}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Range calculation: $52% \\pm 5% = [47%, 57%]$. This interval describes the plausible values for the entire population. Choice C is a standard interpretation of a confidence interval.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_34',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A survey of 100 people is less likely to be representative than a survey of 1,000 people because:',
  '[{"id":"a","text":"100 is an even number."},{"id":"b","text":"Smaller samples usually have larger margins of error."},{"id":"c","text":"Larger samples are more expensive."},{"id":"d","text":"Smaller samples are always biased."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

Sample size directly affects precision. A larger sample reduces the variability of the estimate, leading to a smaller margin of error and a result that is likely closer to the true population value.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_041_35',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'A random sample of 50 people showed that 12% are left-handed. If there are 2,500 people in the town, how many are estimated to be left-handed?',
  NULL,
  '300',
  '\\textbf{Calculation and Logic:}

$2,500 × 0.12 = 300$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_36',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A pollster wants to estimate a proportion with a margin of error of no more than 2%. If a previous survey with 400 people had an error of 5%, what is the minimum number of people they should survey now?',
  '[{"id":"a","text":"1,000"},{"id":"b","text":"1,600"},{"id":"c","text":"2,500"},{"id":"d","text":"4,000"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Ratio of required error change: $2/5 = 0.4$. Since Error $\\propto 1/\\sqrt{n}$, then $n \\propto 1/\\text{Error}^2$. Factor for $n$: $1 / 0.4^2 = 1 / 0.16 = 6.25$. New sample size: $400 × 6.25 = 2,500$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_37',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'A random sample of 500 voters showed that 55% support a candidate. If the margin of error is 4%, what is the \\textbf{maximum} plausible percentage of support?',
  NULL,
  '59',
  '\\textbf{Calculation and Logic:}

$55% + 4% = 59%$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_38',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'An estimate of 30% has a margin of error of 5%. If the total population is 10,000, which of the following represents the width of the plausible population count interval?',
  '[{"id":"a","text":"500"},{"id":"b","text":"1,000"},{"id":"c","text":"3,000"},{"id":"d","text":"5,000"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Percentage width = $2 × 5% = 10%$. Population width: $10,000 × 0.10 = 1,000$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_39',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A confidence interval of [20, 30] for a population mean implies that:',
  '[{"id":"a","text":"The sample mean was 25."},{"id":"b","text":"The margin of error was 10."},{"id":"c","text":"Every value in the population is between 20 and 30."},{"id":"d","text":"There are exactly 50 people in the sample."}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

The estimate (sample mean) is the midpoint of the interval: $(20 + 30) / 2 = 25$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_041_40',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'A random sample of 60 items found that 5 were defective. If the total batch is 1,200 items, how many are estimated to be defective?',
  NULL,
  '100',
  '\\textbf{Calculation and Logic:}

Sample proportion: $5 / 60 = 1 / 12$. Batch estimate: $1,200 × (1 / 12) = 100$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_41',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A surveyor found that 35% of a random sample of 1,000 residents walk to work, with a margin of error of 3%. Which of the following would \\textbf{decrease} the width of the confidence interval?',
  '[{"id":"a","text":"Increasing the population size."},{"id":"b","text":"Increasing the sample size."},{"id":"c","text":"Increasing the margin of error."},{"id":"d","text":"Selecting a non-random sample."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

The width of the interval is $2 × \\text{Margin of Error}$. To decrease the width, you must decrease the margin of error. Increasing the sample size $n$ is the standard way to reduce error and increase precision.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_42',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'A random sample of 250 birds was caught, and 40 were found to be females. What percentage of the sample was female?',
  NULL,
  '16',
  '\\textbf{Calculation and Logic:}

$40 / 250 = 4 / 25 = 16 / 100 = 16%$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_43',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A population has 10,000 individuals. A sample estimate is 15% with a margin of error of 2%. What is the \\textbf{minimum} plausible count of individuals in the population sharing the trait?',
  '[{"id":"a","text":"130"},{"id":"b","text":"1,300"},{"id":"c","text":"1,500"},{"id":"d","text":"1,700"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Lower bound percentage: $15% - 2% = 13%$. Lower bound count: $10,000 × 0.13 = 1,300$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_44',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A margin of error of 0% is only possible if:',
  '[{"id":"a","text":"The sample size is 1,000."},{"id":"b","text":"The population size is 1,000."},{"id":"c","text":"The entire population is surveyed (a census)."},{"id":"d","text":"The sample is perfectly random."}]'::jsonb,
  'c',
  '\\textbf{Logic:}

As long as you are using a sample (a subset), there is inherent variability and uncertainty. A margin of error only disappears when the entire population is measured, as there is no longer an "estimate"—the value is exact.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_041_45',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'A random sample of 800 people showed that 12% speak more than two languages. If the margin of error is 2.5%, what is the \\textbf{maximum} plausible percentage for the population?',
  NULL,
  '14.5',
  '\\textbf{Calculation and Logic:}

$12% + 2.5% = 14.5%$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_46',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A survey of 1,000 people has a margin of error of 3%. What will the margin of error be if the sample size is reduced to 250?',
  '[{"id":"a","text":"1.5%"},{"id":"b","text":"3%"},{"id":"c","text":"6%"},{"id":"d","text":"12%"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Sample size reduction factor: $1,000 / 250 = 4$. Since Error $\\propto 1/\\sqrt{n}$, reducing $n$ by 4 increases the error by $\\sqrt{4} = 2$. New error: $3% × 2 = 6%$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_47',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'A scientist wants to generalize findings from a sample of 200 college students to all adults in the country. What is the main problem with this?',
  '[{"id":"a","text":"The sample size is too small."},{"id":"b","text":"College students are not representative of all adults in the country."},{"id":"c","text":"The survey was likely not random."},{"id":"d","text":"College students do not have traits."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

To generalize to a population, the sample must be representative. College students differ from the general adult population in age, education level, and often income. This creates a selection bias.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_041_48',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'spr',
  'math',
  'An estimate for the population mean is 85, with a margin of error of 7. What is the upper bound of the confidence interval?',
  NULL,
  '92',
  '\\textbf{Calculation and Logic:}

$85 + 7 = 92$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_041_49',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
),
  (
  'mcq',
  'math',
  'Which of the following describes a confidence interval?',
  '[{"id":"a","text":"A single number that is always correct."},{"id":"b","text":"A range of values used to estimate a population parameter."},{"id":"c","text":"The percentage of the sample that was wrong."},{"id":"d","text":"The time it takes to finish a survey."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

A confidence interval uses sample data to provide a range where the true population value is likely to be. It is the core tool of statistical inference.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_041_50',
  'Inference from samples, margin of error',
  'Margin of Error & Confidence'
)
ON CONFLICT (bank_item_id) DO NOTHING;

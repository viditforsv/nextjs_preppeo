-- Practice-mode math from lid_035.tex (sat_lid_035)
-- Chapter: Distributions, measures of center/spread | Topic: Standard Deviation & Box Plots
-- sat_questions: section=math, domain=problem-solving, bank_item_id=sat_lid_035_N, practice module/set 0.

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
  'The table shown summarizes the number of employees at each of the 17 restaurants in a town. \\begin{center} \\begin{tabular}{|c|c|} \\hline Number of employees & Number of restaurants \\hline 2 to 7 & 2 \\hline 8 to 13 & 4 \\hline 14 to 19 & 2 \\hline 20 to 25 & 7 \\hline 26 to 31 & 2 \\hline \\end{tabular} \\end{center} Which of the following could be the median number of employees for the restaurants in this town?',
  '[{"id":"a","text":"2"},{"id":"b","text":"9"},{"id":"c","text":"15"},{"id":"d","text":"21"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

The median of a data set with $n$ values is the middle value. For $n=17$ restaurants, the median is the $9^{th}$ value ($ (17+1)/(2) = 9 $). We find which interval contains the $9^{th}$ value by calculating cumulative frequencies.

\\textbf{Calculation and Logic:}

1. \\textbf{Interval 1 (2--7):} Cumulative frequency = 2.

2. \\textbf{Interval 2 (8--13):} Cumulative frequency = $2 + 4 = 6$.

3. \\textbf{Interval 3 (14--19):} Cumulative frequency = $6 + 2 = 8$.

4. \\textbf{Interval 4 (20--25):} Cumulative frequency = $8 + 7 = 15$.

Since the $9^{th}$ value falls within the range where the cumulative frequency jumps from 8 to 15, the median must be in the \\textbf{20 to 25} range. Only choice D (21) falls in this range.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_1',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\begin{axis}[ybar interval, ymin=0, ymax=12, xmin=10, xmax=65, ylabel={Frequency}, xlabel={Integer}, xtick={10,20,30,40,50,60}, width=0.45\\textwidth, title={Data Set A}] \\addplot coordinates {(10,0) (20,3) (30,4) (40,7) (50,9) (60,0)}; \\end{axis} \\end{tikzpicture} \\begin{tikzpicture} \\begin{axis}[ybar interval, ymin=0, ymax=12, xmin=10, xmax=65, ylabel={Frequency}, xlabel={Integer}, xtick={10,20,30,40,50,60}, width=0.45\\textwidth, title={Data Set B}] \\addplot coordinates {(10,3) (20,4) (30,7) (40,9) (50,0) (60,0)}; \\end{axis} \\end{tikzpicture} \\end{center} Two data sets of 23 integers each are summarized in the histograms shown. What is the smallest possible difference between the mean of data set A and the mean of data set B?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"10"},{"id":"d","text":"23"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

To find the smallest possible difference between means, we try to make the means as close as possible. Notice that Data Set B is simply Data Set A shifted left by exactly one interval (10 units).

\\textbf{Calculation and Logic:}

1. \\textbf{Observe Symmetry:} Data Set A frequencies are (3, 4, 7, 9) for intervals starting at 20, 30, 40, 50.

2. \\textbf{Observe Shift:} Data Set B frequencies are (3, 4, 7, 9) for intervals starting at 10, 20, 30, 40.

3. \\textbf{Constant Difference:} Every individual data point in A could be exactly 10 units greater than a corresponding point in B. If $A_i = B_i + 10$, then the mean of A will be exactly 10 units greater than the mean of B.

Because the frequency distributions are identical but shifted by one full interval width (10), the difference in means is fixed at 10.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_2',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|c|c|} \\hline Value & Frequency \\hline 1 & $a$ \\hline 2 & $2a$ \\hline 3 & $3a$ \\hline 4 & $2a$ \\hline 5 & $a$ \\hline \\end{tabular} \\end{center} The frequency distribution above summarizes a set of data, where $a$ is a positive integer. How much greater is the mean of the set of data than the median?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"2"},{"id":"d","text":"3"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

A frequency distribution that is perfectly symmetric around a central value will have its mean and median equal to that central value.

\\textbf{Calculation and Logic:}

1. \\textbf{Symmetry:} The frequencies $(a, 2a, 3a, 2a, a)$ are symmetric around the value \\textbf{3}.

2. \\textbf{Median:} The total number of values is $a+2a+3a+2a+a = 9a$. The median is the $((9a+1)/(2))^{th}$ value, which falls in the "3" category.

3. \\textbf{Mean:} Calculate the weighted average:

\\[ \\text{Mean} = (1(a) + 2(2a) + 3(3a) + 4(2a) + 5(a))/(9a) = (a + 4a + 9a + 8a + 5a)/(9a) = (27a)/(9a) = 3 \\]

4. \\textbf{Difference:} $3 - 3 = 0$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_3',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'Two different teams consisting of 10 members each ran in a race. Team A Mean: 3.41 minutes Team B Mean: 3.79 minutes Which of the following MUST be true?',
  '[{"id":"a","text":"Every member of team A completed the race in less time than any member of team B."},{"id":"b","text":"The median time of team B is greater than the median time of team A."},{"id":"c","text":"There is at least one member of team B who took more time than some member of team A."}]'::jsonb,
  'a',
  '\\textbf{Logic:}

1. \\textbf{Statement I:} False. Team A could have one very slow runner and Team B could have many runners just slightly slower than Team A''s average. Means don''t prove individual comparisons.

2. \\textbf{Statement II:} False. Outliers can affect the mean without reflecting the median.

3. \\textbf{Statement III:} True. If every member of B was faster than every member of A, the mean of B would have to be lower than the mean of A. Since Team B''s mean is higher, there must be at least one person in B who is slower than at least one person in A.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_4',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'The mean score of 8 players in a basketball game was 14.5 points. If the highest individual score is removed, the mean score of the remaining 7 players becomes 12 points. What was the highest score?',
  '[{"id":"a","text":"20"},{"id":"b","text":"24"},{"id":"c","text":"32"},{"id":"d","text":"36"}]'::jsonb,
  'c',
  '\\textbf{Calculation:}

1. \\textbf{Total Sum (8 players):} $8 × 14.5 = 116$.

2. \\textbf{Total Sum (7 players):} $7 × 12 = 84$.

3. \\textbf{Difference (Highest Score):} $116 - 84 = 32$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_5',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'spr',
  'math',
  'The list gives the mass, in grams, of 5 alpine marmots: 4,010; 4,010; 3,030; 4,050; 3,050 What is the mean mass, in grams, of these 5 alpine marmots?',
  NULL,
  '3630',
  '\\textbf{Calculation:}

Sum = $4,010 + 4,010 + 3,030 + 4,050 + 3,050 = 18,150$.

Mean = $18,150 / 5 = 3,630$.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_035_6',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[help lines] (1,0) -- (5,0); \\foreach \\x in {1,2,3,4,5} \\draw (\\x,0.1) -- (\\x,-0.1) node[below] {\\x}; \\foreach \\x/\\y in {1/4, 2/5, 3/2, 4/1, 5/1} { \\foreach \\i in {1,...,\\y} \\fill (\\x, \\i*0.2) circle (2pt); } \\node at (3,-0.8) {Number of bursts}; \\end{tikzpicture} \\end{center} The dot plot above represents a data set of 13 eruptions. If an additional eruption with 11 bursts is added to this data set, which of the following measures will be greater for the new data set? I. The median number of bursts II. The mean number of bursts',
  '[{"id":"a","text":"I and II"},{"id":"b","text":"I only"},{"id":"c","text":"II only"},{"id":"d","text":"Neither I nor II"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

1. \\textbf{Mean:} The current mean is low (centered around 1-2). Adding 11 (a massive outlier) will significantly increase the total sum, thus the mean will increase.

2. \\textbf{Median:} Original median ($7^{th}$ value) is 2. With 14 values, the median is the average of the $7^{th}$ and $8^{th}$ values. Looking at the dots: both the $7^{th}$ and $8^{th}$ dots are at 2. The median remains 2.

Only the mean increases.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_7',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tabular}{|c|c|c|c|c|} \\hline Station 1 & Station 2 & Station 3 & Station 4 & Station 5 \\hline 3.699 & 3.609 & 3.729 & 3.679 & 3.729 \\hline \\end{tabular} \\end{center} Melissa recorded gas prices from five stations. What is the median of the gas prices?',
  '[{"id":"a","text":"3.679"},{"id":"b","text":"3.689"},{"id":"c","text":"3.699"},{"id":"d","text":"3.729"}]'::jsonb,
  'c',
  '\\textbf{Calculation:}

1. Order the prices: 3.609, 3.679, \\textbf{3.699}, 3.729, 3.729.

2. The middle value is 3.699.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_035_8',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\node at (-1,0.5) {Class A}; \\draw[help lines] (1,0) -- (7,0); \\foreach \\x in {1,...,7} \\draw (\\x,0.1) -- (\\x,-0.1) node[below] {\\x}; \\foreach \\x in {1,2} \\fill (\\x, 0.2) circle (2pt); \\foreach \\x in {3} \\foreach \\i in {1,2,3} \\fill (\\x, \\i*0.2) circle (2pt); \\foreach \\x in {4} \\foreach \\i in {1,2,3,4} \\fill (\\x, \\i*0.2) circle (2pt); \\foreach \\x in {5} \\foreach \\i in {1,2,3,4,5} \\fill (\\x, \\i*0.2) circle (2pt); \\foreach \\x in {6} \\foreach \\i in {1,2,3,4,5,6} \\fill (\\x, \\i*0.2) circle (2pt); \\foreach \\x in {7} \\foreach \\i in {1,2,3,4,5,6,7} \\fill (\\x, \\i*0.2) circle (2pt); \\begin{scope}[shift={(0,-2)}] \\node at (-1,0.5) {Class B}; \\draw[help lines] (14,0) -- (20,0); \\foreach \\x in {14,...,20} \\draw (\\x,0.1) -- (\\x,-0.1) node[below] {\\x}; \\foreach \\x in {14,15} \\fill (\\x, 0.2) circle (2pt); \\foreach \\x in {16} \\foreach \\i in {1,2,3} \\fill (\\x, \\i*0.2) circle (2pt); \\foreach \\x in {17} \\foreach \\i in {1,2,3,4} \\fill (\\x, \\i*0.2) circle (2pt); \\foreach \\x in {18} \\foreach \\i in {1,2,3,4,5} \\fill (\\x, \\i*0.2) circle (2pt); \\foreach \\x in {19} \\foreach \\i in {1,2,3,4,5,6} \\fill (\\x, \\i*0.2) circle (2pt); \\foreach \\x in {20} \\foreach \\i in {1,2,3,4,5,6,7} \\fill (\\x, \\i*0.2) circle (2pt); \\end{scope} \\end{tikzpicture} \\end{center} Which statement best compares the standard deviations of the number of glue sticks brought in for these two classes?',
  '[{"id":"a","text":"SD of Class A is less than Class B."},{"id":"b","text":"SD of Class A is equal to Class B."},{"id":"c","text":"SD of Class A is greater than Class B."},{"id":"d","text":"Not enough information."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

Standard deviation measures the spread of data relative to the mean. Class B is an exact copy of Class A, shifted 13 units to the right ($x+13$). Shifting a data set does not change its spread or standard deviation.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_9',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'Data set A: 10, 11, 11, 11, 11, 12, 12, 13, 13, 13, 14, 14, 15, 15, 15, 15, 16 Data set B: 10, 10, 11, 11, 11, 11, 12, 12, 13, 14, 14, 15, 15, 15, 15, 16, 16 Which statement must be true?',
  '[{"id":"a","text":"The median of A is equal to the median of B."},{"id":"b","text":"The standard deviation of A is equal to the standard deviation of B."}]'::jsonb,
  'a',
  '\\textbf{Logic:}

1. \\textbf{Median:} Both sets have $n=17$. The median is the $9^{th}$ value. For both A and B, counting from the left, the $9^{th}$ dot/value is 13. (I is true).

2. \\textbf{SD:} Set B has more dots at the extremes (two 10s and two 16s) compared to A (one 10 and one 16). Since B has more data points far from the center, its standard deviation is larger. (II is false).',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_10',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw (0,0) -- (10,0); \\foreach \\x in {0,2,4,6,8,10} \\draw (\\x,0.1) -- (\\x,-0.1) node[below] {\\x}; \\node[above] at (5,1.5) {Group X}; \\draw (1,0.5) -- (2,0.5); \\draw (7,0.5) -- (9,0.5); % Whiskers \\draw (2,0.2) rectangle (7,0.8); \\draw (4,0.2) -- (4,0.8); % Box \\begin{scope}[shift={(0,-1.5)}] \\node[above] at (5,1.5) {Group Y}; \\draw (2,0.5) -- (3,0.5); \\draw (6,0.5) -- (8,0.5); % Whiskers \\draw (3,0.2) rectangle (6,0.8); \\draw (4,0.2) -- (4,0.8); % Box \\end{scope} \\end{tikzpicture} \\end{center} The box plots above summarize the scores of two groups. Which of the following must be true?',
  '[{"id":"a","text":"Group X has a larger range and a larger IQR than Group Y."},{"id":"b","text":"Group X has a smaller range and a larger IQR than Group Y."},{"id":"c","text":"Group X has a larger range and a smaller IQR than Group Y."},{"id":"d","text":"The means of Group X and Group Y are equal."}]'::jsonb,
  'a',
  '\\textbf{Logic:}

1. \\textbf{Range:} Group X (1 to 9, Range=8) is wider than Group Y (2 to 8, Range=6).

2. \\textbf{IQR:} The box for X (2 to 7, IQR=5) is wider than the box for Y (3 to 6, IQR=3).

3. \\textbf{Mean:} Box plots show medians (both are 4), not means.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_11',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'A data set consists of 50 integers. The mean of the data set is 40 and the standard deviation is 5. If a new data set is created by multiplying each integer in the original set by 3, what are the mean and standard deviation of the new data set?',
  '[{"id":"a","text":"Mean: 40, SD: 5"},{"id":"b","text":"Mean: 120, SD: 5"},{"id":"c","text":"Mean: 120, SD: 15"},{"id":"d","text":"Mean: 40, SD: 15"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

When every value in a data set is multiplied by a constant $k$, the mean is multiplied by $k$ and the standard deviation is also multiplied by $|k|$.

\\textbf{Calculation and Logic:}

1. \\textbf{New Mean:} $40 × 3 = 120$.

2. \\textbf{New SD:} $5 × 3 = 15$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_12',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'spr',
  'math',
  'The scores of 10 students on a quiz are: 75, 75, 80, 80, 80, 85, 85, 90, 95, 100. What is the range of these scores?',
  NULL,
  '25',
  '\\textbf{Calculation:}

Range = Max $-$ Min

Range = $100 - 75 = 25$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_13',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\begin{axis}[ybar interval, ymin=0, ymax=10, xmin=0, xmax=50, ylabel={Frequency}, xlabel={Value}, xtick={0,10,20,30,40,50}, width=0.6\\textwidth] \\addplot coordinates {(0,2) (10,8) (20,5) (30,3) (40,2) (50,0)}; \\end{axis} \\end{tikzpicture} \\end{center} For the data summarized in the histogram above, which of the following is true?',
  '[{"id":"a","text":"The mean is likely greater than the median."},{"id":"b","text":"The mean is likely less than the median."},{"id":"c","text":"The mean and median are exactly equal."},{"id":"d","text":"The standard deviation is 0."}]'::jsonb,
  'a',
  '\\textbf{Logic:}

The histogram shows a distribution that is "skewed to the right" (positive skew), as the tail extends further toward the higher values (40-50) while the bulk of the data is on the left (10-20). In a right-skewed distribution, the mean is typically pulled toward the tail and is therefore greater than the median.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_14',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'Which of the following data sets has the smallest standard deviation?',
  '[{"id":"a","text":"\\\\{10, 10, 10, 10, 10\\\\}"},{"id":"b","text":"\\\\{10, 11, 12, 13, 14\\\\}"},{"id":"c","text":"\\\\{1, 5, 10, 15, 20\\\\}"},{"id":"d","text":"\\\\{0, 10, 20, 30, 40\\\\}"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

Standard deviation measures the "spread" or "variation" from the mean. If all values in a data set are identical, there is zero variation, and the standard deviation is 0. This is the smallest possible value for standard deviation.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_15',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'spr',
  'math',
  'A set of 11 numbers has a median of 50. If the largest number in the set is increased by 20 and the smallest number is decreased by 20, what is the median of the new set?',
  NULL,
  '50',
  '\\textbf{Logic:}

The median is the middle value of an ordered set. Changing the extreme values (the largest and the smallest) does not change which value is in the middle position, nor does it change that value itself, as long as the order is preserved.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_16',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'The weights, in pounds, of 6 dogs are: 12, 15, 12, 20, 15, 12. What is the mode of these weights?',
  '[{"id":"a","text":"12"},{"id":"b","text":"14"},{"id":"c","text":"15"},{"id":"d","text":"20"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

The mode is the value that appears most frequently.

12 appears 3 times.

15 appears 2 times.

20 appears 1 time.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_035_17',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw (0,0) -- (8,0); \\foreach \\x in {0,2,4,6,8} \\draw (\\x,0.1) -- (\\x,-0.1) node[below] {\\x}; \\draw (1,0.5) -- (2,0.5); \\draw (6,0.5) -- (7,0.5); \\draw (2,0.2) rectangle (6,0.8); \\draw (5,0.2) -- (5,0.8); \\end{tikzpicture} \\end{center} Based on the box plot above, what is the interquartile range (IQR)?',
  '[{"id":"a","text":"4"},{"id":"b","text":"5"},{"id":"c","text":"6"},{"id":"d","text":"8"}]'::jsonb,
  'a',
  '\\textbf{Calculation:}

The IQR is the width of the box ($Q3 - Q1$).

$Q1 = 2$.

$Q3 = 6$.

$IQR = 6 - 2 = 4$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_18',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'If the standard deviation of a data set is 0, which of the following must be true?',
  '[{"id":"a","text":"The mean is 0."},{"id":"b","text":"The range is 0."},{"id":"c","text":"The median is 0."},{"id":"d","text":"All of the above."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

A standard deviation of 0 means there is no spread; every value in the set is identical. If every value is the same, the Max and Min are equal, so Range = Max $-$ Min = 0.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_19',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'A frequency table for 40 data points has a median in the interval 10--19. If 5 points are added to the 0--9 interval, which of the following could be the new median?',
  '[{"id":"a","text":"8"},{"id":"b","text":"15"},{"id":"c","text":"25"},{"id":"d","text":"30"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

Adding points to the lower end of a data set shifts the median toward the lower end (left). Since the original median was in the 10--19 range, the new median will either stay in that range or move slightly lower. It will not jump to 25 or 30. Given the choices, 15 is the most plausible.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_20',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'spr',
  'math',
  'A set of 4 numbers has a mean of 25. If three of the numbers are 10, 20, and 30, what is the fourth number?',
  NULL,
  '40',
  '\\textbf{Calculation:}

Sum = Mean $× n = 25 × 4 = 100$.

$10 + 20 + 30 + x = 100$.

$60 + x = 100 → x = 40$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_21',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw (0,0) -- (10,0); \\foreach \\x in {0,2,4,6,8,10} \\draw (\\x,0.1) -- (\\x,-0.1) node[below] {\\x}; \\node[left] at (0,1) {Set A}; \\draw (1,1) -- (2,1); \\draw (8,1) -- (9,1); \\draw (2,0.7) rectangle (8,1.3); \\draw (5,0.7) -- (5,1.3); \\begin{scope}[shift={(0,-1.5)}] \\node[left] at (0,1) {Set B}; \\draw (4,1) -- (4.5,1); \\draw (5.5,1) -- (6,1); \\draw (4.5,0.7) rectangle (5.5,1.3); \\draw (5,0.7) -- (5,1.3); \\end{scope} \\end{tikzpicture} \\end{center} Which set has a higher standard deviation?',
  '[{"id":"a","text":"Set A"},{"id":"b","text":"Set B"},{"id":"c","text":"They are equal."},{"id":"d","text":"Cannot be determined."}]'::jsonb,
  'a',
  '\\textbf{Logic:}

Standard deviation is a measure of spread. Set A is visually much more spread out than Set B, covering a larger range and having a larger IQR. Therefore, Set A has a higher standard deviation.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_22',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'If the mean of a symmetric distribution is 100, what is the median?',
  '[{"id":"a","text":"50"},{"id":"b","text":"100"},{"id":"c","text":"200"},{"id":"d","text":"Cannot be determined."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

In any perfectly symmetric distribution, the mean, median, and mode are all equal and located at the center of symmetry.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_23',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'spr',
  'math',
  'A list of 5 numbers has a mean of 10. If the number 16 is added to the list, what is the mean of the new list?',
  NULL,
  '11',
  '\\textbf{Calculation:}

Original Sum = $5 × 10 = 50$.

New Sum = $50 + 16 = 66$.

New Mean = $66 / 6 = 11$.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_24',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'What is the median of the set {5, 2, 9, 1, 7}?',
  '[{"id":"a","text":"2"},{"id":"b","text":"5"},{"id":"c","text":"7"},{"id":"d","text":"9"}]'::jsonb,
  'b',
  '\\textbf{Calculation:}

Order the set: 1, 2, \\textbf{5}, 7, 9.

The middle value is 5.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_035_25',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'Which of the following is most affected by an outlier?',
  '[{"id":"a","text":"Mean"},{"id":"b","text":"Median"},{"id":"c","text":"Mode"},{"id":"d","text":"IQR"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

The mean is calculated using every value in the set, making it very sensitive to extreme values (outliers). The median and IQR are more "resistant."',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_26',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'If we add 10 to every value in a data set, how does the standard deviation change?',
  '[{"id":"a","text":"It increases by 10."},{"id":"b","text":"It decreases by 10."},{"id":"c","text":"It stays the same."},{"id":"d","text":"It is multiplied by 10."}]'::jsonb,
  'c',
  '\\textbf{Logic:}

Adding a constant to every value shifts the entire distribution but does not change the distance between the values. Since the "spread" remains the same, the standard deviation is unchanged.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_27',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'spr',
  'math',
  'The interquartile range of a set is 20. If $Q3$ is 55, what is $Q1$?',
  NULL,
  '35',
  '\\textbf{Calculation:}

$IQR = Q3 - Q1$.

$20 = 55 - Q1 → Q1 = 35$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_28',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'What is the mean of {10, 20, 30, 40}?',
  '[{"id":"a","text":"20"},{"id":"b","text":"25"},{"id":"c","text":"30"},{"id":"d","text":"35"}]'::jsonb,
  'b',
  '\\textbf{Calculation:}

Sum = $10 + 20 + 30 + 40 = 100$.

Mean = $100 / 4 = 25$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_29',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'For the dot plot below, which of the following is true?',
  '[{"id":"a","text":"Mean = Median"},{"id":"b","text":"Mean > Median"},{"id":"c","text":"Mean < Median"},{"id":"d","text":"Standard Deviation = 0"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

The dot plot is perfectly symmetric around the value 3. In any perfectly symmetric distribution, the mean and the median are equal.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_30',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'A data set consists of 25 values with a mean of 60 and a standard deviation of 12. If the value 60 is added to the data set, which of the following describes the changes to the mean and standard deviation?',
  '[{"id":"a","text":"The mean stays the same, and the standard deviation stays the same."},{"id":"b","text":"The mean stays the same, and the standard deviation decreases."},{"id":"c","text":"The mean increases, and the standard deviation stays the same."},{"id":"d","text":"The mean stays the same, and the standard deviation increases."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The mean is the "balance point" of the data, while the standard deviation measures the average "spread" or distance of all points from that mean. Adding a value exactly at the balance point doesn''t shift the center, but it does change the density of the data.

\\textbf{Calculation and Logic:}

1. \\textbf{Effect on Mean:} Adding a value equal to the mean ($x = \\mu$) will never change the average. If the average of 25 people is 60, and a 26th person with 60 joins, the new average is still 60.

2. \\textbf{Effect on Standard Deviation:} Standard deviation is the square root of the average squared distance from the mean.

- The new value (60) has a distance of \\textbf{0} from the mean ($60 - 60 = 0$).

- Because we are adding a "0" to the sum of squared distances but increasing the total count ($n$) from 25 to 26, the average distance \\textbf{decreases}.

The mean stays the same, but the standard deviation is "diluted" and thus decreases.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_31',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'A scientist is comparing two sets of data. Set A has a standard deviation of $\\sigma$. Set B is created by taking every value in Set A and subtracting 50, then dividing by 2. What is the standard deviation of Set B?',
  '[{"id":"a","text":"$\\\\sigma - 50$"},{"id":"b","text":"$\\\\sigma / 2$"},{"id":"c","text":"$(\\\\sigma - 50) / 2$"},{"id":"d","text":"$\\\\sigma$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Standard deviation is a measure of the distance between data points. We must distinguish between "shifting" the data and "scaling" the data.

\\textbf{Calculation and Logic:}

1. \\textbf{Subtraction (Shifting):} Subtracting 50 from every value moves the entire data set 50 units to the left on a number line. However, the distance between the points remains exactly the same. Therefore, subtracting 50 has \\textbf{no effect} on the standard deviation.

2. \\textbf{Division (Scaling):} Dividing every value by 2 shrinks the entire distribution. The distances between all points are now half of what they used to be.

3. \\textbf{Final Result:} The standard deviation $\\sigma$ is only affected by the division.

\\[ \\sigma_{new} = (\\sigma)/(2) \\]

The new standard deviation is half of the original.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_33',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\begin{axis}[ybar interval, ymin=0, ymax=10, xmin=0, xmax=40, ylabel={Frequency}, xlabel={Age}, xtick={0,10,20,30,40}] \\addplot coordinates {(0,9) (10,5) (20,2) (30,1) (40,0)}; \\end{axis} \\end{tikzpicture} \\end{center} Which of the following is the most likely relationship between the mean and the median for the data set shown in the histogram?',
  '[{"id":"a","text":"mean $\\\\approx$ median"},{"id":"b","text":"mean $<$ median"},{"id":"c","text":"mean $>$ median"},{"id":"d","text":"standard deviation = 0"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In data distributions, "skewness" describes the direction of the "tail." The mean is highly sensitive to the values in that tail and is "pulled" in that direction, whereas the median is more resistant.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify Skew:} This histogram has a long tail stretching toward the right (higher ages). This is a \\textbf{right-skewed} (positive) distribution.

2. \\textbf{Position of the Median:} The median is the 50th percentile. Since the highest frequencies are in the 0--10 and 10--20 ranges, the median will be a relatively low number.

3. \\textbf{Position of the Mean:} The few individuals in the 30--40 range act like "heavy weights" on a lever, pulling the mean toward the right to balance the distribution.

[Image of the relationship between mean, median, and mode in a right-skewed distribution]

Because the mean is pulled toward the high-value tail, the mean will be greater than the median.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_35',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'spr',
  'math',
  'A data set has a maximum value of 92 and a minimum value of 48. What is the range of this data set?',
  NULL,
  '44',
  '\\textbf{Conceptual Explanation:}

The range is a measure of the total "distance" covered by a data set on a number line. It tells us the spread between the two most extreme points: the smallest (minimum) and the largest (maximum).

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the formula:} The range is calculated by subtracting the minimum value from the maximum value.

\\[ \\text{Range} = \\text{Maximum} - \\text{Minimum} \\]

2. \\textbf{Substitute the values:}

- Maximum = 92

- Minimum = 48

3. \\textbf{Perform the subtraction:}

\\[ 92 - 48 = 44 \\]

The total spread of the data set is 44 units.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_36',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'The interquartile range (IQR) of a data set is 12. If every value in the set is multiplied by 3, what is the new IQR?',
  '[{"id":"a","text":"12"},{"id":"b","text":"15"},{"id":"c","text":"36"},{"id":"d","text":"48"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The Interquartile Range (IQR) is the distance between the 25th percentile ($Q1$) and the 75th percentile ($Q3$). Like the range and standard deviation, the IQR is a "measure of spread." When you scale data (multiply/divide), the spread scales by that same factor.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the transformation:} Multiplication by a constant ($k = 3$) affects all positional values ($Q1, Q2, Q3$) equally.

2. \\textbf{Apply the scale factor:} Since $Q3$ and $Q1$ are both tripled, the distance between them is also tripled.

\\[ \\text{New IQR} = \\text{Original IQR} × 3 \\]

3. \\textbf{Calculate:}

\\[ 12 × 3 = 36 \\]

The new spread between the quartiles is 36.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_37',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'Data set P: \\{2, 4, 6, 8, 10\\} Data set Q: \\{2, 2, 6, 10, 10\\} Which of the following is true?',
  '[{"id":"a","text":"Set P has a larger standard deviation than Set Q."},{"id":"b","text":"Set Q has a larger standard deviation than Set P."},{"id":"c","text":"The means of the two sets are different."},{"id":"d","text":"The medians of the two sets are different."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Standard deviation measures how "spread out" values are from the mean. Data sets with more values near the center have lower standard deviations; data sets with more values at the extreme ends (the "tails") have higher standard deviations.

\\textbf{Calculation and Logic:}

1. \\textbf{Check the Center:} Both sets are symmetric around 6.

- Mean of P = 6; Median of P = 6.

- Mean of Q = 6; Median of Q = 6.

- (Choices C and D are eliminated).

2. \\textbf{Analyze the Spread:}

- In Set P, the values 4 and 8 are relatively close to the mean (6).

- In Set Q, those values are replaced by 2 and 10, which are much further from the mean.

3. \\textbf{Conclusion:} Because Set Q has more weight at the minimum and maximum distances, it is "more spread out."

Set Q has a larger standard deviation than Set P.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_38',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'spr',
  'math',
  'The heights (in inches) of five basketball players are: 72, 75, 78, 72, 83. What is the mode of this data set?',
  NULL,
  '72',
  '\\textbf{Conceptual Explanation:}

The mode is the statistical measure of "popularity" in a data set. It is the value (or values) that appear with the highest frequency.

\\textbf{Calculation and Logic:}

1. \\textbf{List the frequency of each value:}

- 72: Appears 2 times.

- 75: Appears 1 time.

- 78: Appears 1 time.

- 83: Appears 1 time.

2. \\textbf{Identify the highest frequency:} The value 72 appears more than any other value.

The mode is 72.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_035_39',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'A box plot has whiskers extending from 15 to 45. The box itself extends from 20 to 35, with a vertical line at 28. What is the value of the first quartile ($Q1$)?',
  '[{"id":"a","text":"15"},{"id":"b","text":"20"},{"id":"c","text":"28"},{"id":"d","text":"35"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A box plot (box-and-whisker plot) visualizes the five-number summary: Minimum, $Q1$, Median, $Q3$, and Maximum. Each part of the "box" corresponds to one of these specific statistical markers.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify Box Plot components:}

- Left whisker end = Minimum (15)

- Left edge of box = $Q1$ (First Quartile)

- Vertical line inside = Median (28)

- Right edge of box = $Q3$ (Third Quartile)

- Right whisker end = Maximum (45)

2. \\textbf{Locate $Q1$:} The problem states the box begins at 20.

The first quartile ($Q1$) is 20.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_40',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'Which of the following statistics is most "resistant" to outliers (extreme values)?',
  '[{"id":"a","text":"Mean"},{"id":"b","text":"Range"},{"id":"c","text":"Median"},{"id":"d","text":"Standard Deviation"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

A "resistant" statistic is one that is not significantly changed by a few extreme values. If you add a value of 1,000,000 to a list of small numbers, some measures will skyrocket, while others will stay roughly the same.

\\textbf{Calculation and Logic:}

1. \\textbf{Mean:} Uses every value; one huge number pulls the average up. (Not resistant).

2. \\textbf{Range:} Uses the Max; if the Max becomes an outlier, the range expands massively. (Not resistant).

3. \\textbf{Standard Deviation:} Measures distance from mean; extreme distance increases the SD significantly. (Not resistant).

4. \\textbf{Median:} Only cares about the middle position. An outlier at the end of the list only moves the median by one "spot" in the ranking, regardless of how big that outlier is.

The median is the most resistant measure.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_41',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw (0,0) -- (6,0); \\foreach \\x in {1,2,3,4,5} \\draw (\\x,0.1) -- (\\x,-0.1) node[below] {\\x}; \\foreach \\x/\\y in {1/2, 2/2, 3/2, 4/2, 5/2} { \\foreach \\i in {1,...,\\y} \\fill (\\x, \\i*0.2) circle (2pt); } \\end{tikzpicture} \\end{center} In the uniform dot plot shown above, how does the mean compare to the median?',
  '[{"id":"a","text":"Mean $>$ Median"},{"id":"b","text":"Mean $<$ Median"},{"id":"c","text":"Mean = Median"},{"id":"d","text":"Mean = 0"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Symmetry is the key to understanding the relationship between the mean and median. In a perfectly balanced distribution, the "average" and the "middle" are the same point.

\\textbf{Calculation and Logic:}

1. \\textbf{Observe Symmetry:} The dot plot shows an equal number of dots (2) at every value from 1 to 5.

2. \\textbf{Find Median:} There are 10 dots total. The median is the average of the 5th and 6th values. Both are located at 3.

3. \\textbf{Find Mean:}

\\[ (2(1) + 2(2) + 2(3) + 2(4) + 2(5))/(10) = (2 + 4 + 6 + 8 + 10)/(10) = (30)/(10) = 3 \\]

4. \\textbf{Compare:} Both measures are equal to the center of the distribution.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_42',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'spr',
  'math',
  'A set of 5 numbers has a mean of 12. If a sixth number, 30, is added to the set, what is the new mean?',
  NULL,
  '15',
  '\\textbf{Conceptual Explanation:}

The mean is the total sum of all values divided by the number of values ($n$). To find a new mean, we must find the new total sum and the new $n$.

\\textbf{Calculation and Logic:}

1. \\textbf{Find original sum:}

\\[ \\text{Sum} = \\text{Mean} × n = 12 × 5 = 60 \\]

2. \\textbf{Update the sum:} Add the new value (30) to the original total.

\\[ 60 + 30 = 90 \\]

3. \\textbf{Update $n$:} The set now has 6 numbers.

4. \\textbf{Calculate new mean:}

\\[ (90)/(6) = 15 \\]',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_43',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'If the standard deviation of a set of integers is 15, what is the variance?',
  '[{"id":"a","text":"3.87"},{"id":"b","text":"15"},{"id":"c","text":"30"},{"id":"d","text":"225"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Standard deviation and variance are both measures of spread, but they are in different units. Standard deviation is the square root of the variance.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the relationship:}

\\[ \\text{Variance} = (\\text{Standard Deviation})^2 \\]

2. \\textbf{Substitute and Solve:}

\\[ 15^2 = 15 × 15 = 225 \\]

The variance is 225.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_44',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'If a data set is skewed to the left, which of the following is generally true?',
  '[{"id":"a","text":"mean $>$ median"},{"id":"b","text":"mean $<$ median"},{"id":"c","text":"mean = median"},{"id":"d","text":"standard deviation = 0"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Skewness describes the "tail" of the data. A left-skewed distribution has a long tail of very low values stretching to the left. The mean is "pulled" by these low values, while the median remains near the peak.

\\textbf{Calculation and Logic:}

1. \\textbf{Analyze Left Skew:} Imagine a set like \\{1, 2, 9, 10, 10\\}.

2. \\textbf{Calculate Median:} Middle value is 9.

3. \\textbf{Calculate Mean:}

\\[ (1+2+9+10+10)/(5) = (32)/(5) = 6.4 \\]

4. \\textbf{Compare:} $6.4 < 9$. The mean is lower than the median.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_45',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'What is the median of \\{10, 2, 8, 4, 6\\}?',
  '[{"id":"a","text":"4"},{"id":"b","text":"6"},{"id":"c","text":"8"},{"id":"d","text":"10"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The median is the value that splits the data into two equal halves. It is only visible when the data is sorted.

\\textbf{Calculation and Logic:}

1. \\textbf{Sort the data:} 2, 4, 6, 8, 10.

2. \\textbf{Identify the middle:} With 5 values, the 3rd value is the exact center.

3. \\textbf{Locate:} The 3rd value is 6.',
  'problem-solving',
  'easy',
  0,
  0,
  'sat_lid_035_46',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'spr',
  'math',
  'A frequency table for 20 values shows 8 values are "5", 4 values are "10", and 8 values are "15". What is the mean of this data set?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

When data is provided in a frequency table, we calculate the "weighted mean." This involves multiplying each value by how many times it occurs (its weight) to find the total sum.

\\textbf{Calculation and Logic:}

1. \\textbf{Multiply Value $×$ Frequency:}

- $5 × 8 = 40$

- $10 × 4 = 40$

- $15 × 8 = 120$

2. \\textbf{Find total sum:} $40 + 40 + 120 = 200$.

3. \\textbf{Divide by total $n$:}

\\[ (200)/(20) = 10 \\]',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_47',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'Two groups of 100 people were surveyed about their sleep. Group A had a standard deviation of 1.2 hours. Group B had a standard deviation of 2.5 hours. Which group had more "consistent" sleep patterns?',
  '[{"id":"a","text":"Group A"},{"id":"b","text":"Group B"},{"id":"c","text":"Both are equally consistent."},{"id":"d","text":"Cannot be determined."}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

In statistics, "consistency" or "reliability" is measured by how close the data points are to the average. A low standard deviation means most people are very close to the average; a high standard deviation means the data is widely spread out.

\\textbf{Calculation and Logic:}

1. \\textbf{Compare SD values:} $1.2 < 2.5$.

2. \\textbf{Interpret:} Group A has a smaller spread. Their sleep times are clustered tightly around the mean, which represents higher consistency.

Group A is more consistent.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_48',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'A set has a mean of 50. If the value 1,000 is added, which of the following increases the most?',
  '[{"id":"a","text":"Mean"},{"id":"b","text":"Median"},{"id":"c","text":"Range"},{"id":"d","text":"IQR"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

We must compare how a massive outlier (1,000) affects different measures of center and spread.

\\textbf{Calculation and Logic:}

1. \\textbf{Range:} Range = Max - Min. If the Max was around 100 and becomes 1,000, the Range increases by roughly 900.

2. \\textbf{Mean:} The sum increases by 1,000, but this is divided by $n+1$. If $n=10$, the mean only increases by about 100.

3. \\textbf{Median/IQR:} These are resistant. The median only shifts one position; the IQR only changes if the 25th or 75th percentile values themselves change.

4. \\textbf{Conclusion:} The Range is entirely dependent on the Maximum value, so it captures the full scale of the outlier.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_49',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'A set has a mean of 50. If the value 1,000 is added, which of the following increases the most?',
  '[{"id":"a","text":"Mean"},{"id":"b","text":"Median"},{"id":"c","text":"Range"},{"id":"d","text":"IQR"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

We must compare how a massive outlier (1,000) affects different measures of center and spread.

\\textbf{Calculation and Logic:}

1. \\textbf{Range:} Range = Max - Min. If the Max was around 100 and becomes 1,000, the Range increases by roughly 900.

2. \\textbf{Mean:} The sum increases by 1,000, but this is divided by $n+1$. If $n=10$, the mean only increases by about 100.

3. \\textbf{Median/IQR:} These are resistant. The median only shifts one position; the IQR only changes if the 25th or 75th percentile values themselves change.

4. \\textbf{Conclusion:} The Range is entirely dependent on the Maximum value, so it captures the full scale of the outlier.',
  'problem-solving',
  'hard',
  0,
  0,
  'sat_lid_035_49',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'What is the mean of \\{5, 5, 5, 5, 5\\}?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"5"},{"id":"d","text":"25"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The mean is the point of central tendency. If there is no variation in the data (every value is identical), then the center of the data must be that identical value.

\\textbf{Calculation and Logic:}

1. \\textbf{Sum the values:} $5 + 5 + 5 + 5 + 5 = 25$.

2. \\textbf{Divide by $n$:}

\\[ (25)/(5) = 5 \\]

When every value in a set is $x$, the mean is always $x$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_50',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
),
  (
  'mcq',
  'math',
  'What is the mean of \\{5, 5, 5, 5, 5\\}?',
  '[{"id":"a","text":"0"},{"id":"b","text":"1"},{"id":"c","text":"5"},{"id":"d","text":"25"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The mean is the point of central tendency. If there is no variation in the data (every value is identical), then the center of the data must be that identical value.

\\textbf{Calculation and Logic:}

1. \\textbf{Sum the values:} $5 + 5 + 5 + 5 + 5 = 25$.

2. \\textbf{Divide by $n$:}

\\[ (25)/(5) = 5 \\]

When every value in a set is $x$, the mean is always $x$.',
  'problem-solving',
  'medium',
  0,
  0,
  'sat_lid_035_50',
  'Distributions, measures of center/spread',
  'Standard Deviation & Box Plots'
)
ON CONFLICT (bank_item_id) DO NOTHING;

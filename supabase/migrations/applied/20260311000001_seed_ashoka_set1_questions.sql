-- ============================================================================
-- SEED: Ashoka Aptitude Test — Set 1 (40 MCQs)
-- 20 Problem Solving + 20 Critical Thinking
-- ============================================================================

INSERT INTO ashoka_questions (type, section_type, prompt, options, correct_answer, explanation, set_number) VALUES

-- ═══════════════════════════════════════════════════════════════════════════
-- PROBLEM SOLVING (20 questions)
-- ═══════════════════════════════════════════════════════════════════════════

-- PS 1 — Linear Equations
('single-choice', 'problem-solving',
 'If 3x + 7 = 22, what is the value of 5x − 3?',
 '[{"id":"a","text":"22"},{"id":"b","text":"20"},{"id":"c","text":"18"},{"id":"d","text":"25"}]',
 'a',
 '3x + 7 = 22 → 3x = 15 → x = 5. So 5(5) − 3 = 22.',
 1),

-- PS 2 — Linear Equations
('single-choice', 'problem-solving',
 'A number is 8 more than twice another number. If their sum is 35, what is the larger number?',
 '[{"id":"a","text":"26"},{"id":"b","text":"27"},{"id":"c","text":"24"},{"id":"d","text":"22"}]',
 'a',
 'Let smaller = x. Larger = 2x + 8. x + 2x + 8 = 35 → 3x = 27 → x = 9. Larger = 26.',
 1),

-- PS 3 — Linear Equations
('single-choice', 'problem-solving',
 'Two friends have a combined age of 50. If one is 6 years older than the other, how old is the younger friend?',
 '[{"id":"a","text":"20"},{"id":"b","text":"22"},{"id":"c","text":"24"},{"id":"d","text":"28"}]',
 'b',
 'Let younger = x. x + (x + 6) = 50 → 2x = 44 → x = 22.',
 1),

-- PS 4 — Linear Equations
('single-choice', 'problem-solving',
 'A shop sells pens at ₹10 each and notebooks at ₹30 each. Riya buys some pens and notebooks for exactly ₹200. If she buys 5 pens, how many notebooks did she buy?',
 '[{"id":"a","text":"3"},{"id":"b","text":"4"},{"id":"c","text":"5"},{"id":"d","text":"6"}]',
 'c',
 '5 × 10 = 50. Remaining = 200 − 50 = 150. 150 ÷ 30 = 5 notebooks.',
 1),

-- PS 5 — Ratio
('single-choice', 'problem-solving',
 'The ratio of boys to girls in a class is 3:5. If there are 40 students in total, how many girls are there?',
 '[{"id":"a","text":"15"},{"id":"b","text":"20"},{"id":"c","text":"25"},{"id":"d","text":"30"}]',
 'c',
 'Total parts = 3 + 5 = 8. Girls = (5/8) × 40 = 25.',
 1),

-- PS 6 — Ratio
('single-choice', 'problem-solving',
 'A recipe requires flour and sugar in the ratio 7:2. If 630 grams of flour are used, how many grams of sugar are needed?',
 '[{"id":"a","text":"160"},{"id":"b","text":"170"},{"id":"c","text":"180"},{"id":"d","text":"190"}]',
 'c',
 '7 parts = 630g → 1 part = 90g. Sugar = 2 × 90 = 180g.',
 1),

-- PS 7 — Percentage / Profit-Loss
('single-choice', 'problem-solving',
 'A shopkeeper buys an item for ₹800 and sells it for ₹1,000. What is the profit percentage?',
 '[{"id":"a","text":"20%"},{"id":"b","text":"25%"},{"id":"c","text":"15%"},{"id":"d","text":"30%"}]',
 'b',
 'Profit = 1000 − 800 = 200. Profit % = (200/800) × 100 = 25%.',
 1),

-- PS 8 — Percentage / Profit-Loss
('single-choice', 'problem-solving',
 'A salary of ₹50,000 is first increased by 10% and then decreased by 10%. What is the final salary?',
 '[{"id":"a","text":"₹50,000"},{"id":"b","text":"₹49,500"},{"id":"c","text":"₹49,000"},{"id":"d","text":"₹50,500"}]',
 'b',
 'After 10% increase: 50,000 × 1.1 = 55,000. After 10% decrease: 55,000 × 0.9 = 49,500.',
 1),

-- PS 9 — Percentage / Profit-Loss
('single-choice', 'problem-solving',
 'In an election, candidate A received 60% of the votes and won by 4,000 votes. How many total votes were cast?',
 '[{"id":"a","text":"18,000"},{"id":"b","text":"20,000"},{"id":"c","text":"22,000"},{"id":"d","text":"25,000"}]',
 'b',
 'A got 60%, B got 40%. Difference = 20% of total = 4,000. Total = 4,000 / 0.2 = 20,000.',
 1),

-- PS 10 — Time, Speed & Distance
('single-choice', 'problem-solving',
 'A car travels 180 km in 3 hours. If it increases its speed by 20 km/h, how long will it take to travel 240 km?',
 '[{"id":"a","text":"2.5 hours"},{"id":"b","text":"3 hours"},{"id":"c","text":"3.5 hours"},{"id":"d","text":"4 hours"}]',
 'b',
 'Original speed = 180/3 = 60 km/h. New speed = 80 km/h. Time = 240/80 = 3 hours.',
 1),

-- PS 11 — Time & Work
('single-choice', 'problem-solving',
 'A can complete a task in 12 days and B can complete the same task in 18 days. If they work together, in how many days will they complete the task?',
 '[{"id":"a","text":"6.4 days"},{"id":"b","text":"7.2 days"},{"id":"c","text":"8 days"},{"id":"d","text":"9 days"}]',
 'b',
 'A''s rate = 1/12, B''s rate = 1/18. Combined = 1/12 + 1/18 = 5/36. Days = 36/5 = 7.2.',
 1),

-- PS 12 — Numbers
('single-choice', 'problem-solving',
 'What is the sum of all prime numbers between 10 and 25?',
 '[{"id":"a","text":"60"},{"id":"b","text":"72"},{"id":"c","text":"83"},{"id":"d","text":"78"}]',
 'c',
 'Primes between 10 and 25: 11, 13, 17, 19, 23. Sum = 11 + 13 + 17 + 19 + 23 = 83.',
 1),

-- PS 13 — Data Interpretation
('single-choice', 'problem-solving',
 'A survey of 200 students found that 35% prefer cricket, 25% prefer football, and the rest prefer badminton. How many students prefer badminton?',
 '[{"id":"a","text":"70"},{"id":"b","text":"80"},{"id":"c","text":"90"},{"id":"d","text":"60"}]',
 'b',
 'Badminton = 100% − 35% − 25% = 40%. 40% of 200 = 80.',
 1),

-- PS 14 — Data Interpretation
('single-choice', 'problem-solving',
 'A company''s revenue was ₹50 lakh in Q1, ₹60 lakh in Q2, ₹45 lakh in Q3, and ₹65 lakh in Q4. What was the average quarterly revenue?',
 '[{"id":"a","text":"₹52 lakh"},{"id":"b","text":"₹55 lakh"},{"id":"c","text":"₹57.5 lakh"},{"id":"d","text":"₹60 lakh"}]',
 'b',
 'Total = 50 + 60 + 45 + 65 = 220. Average = 220/4 = 55 lakh.',
 1),

-- PS 15 — Logical Reasoning
('single-choice', 'problem-solving',
 'In a row of children, Meera is 8th from the left and 12th from the right. How many children are in the row?',
 '[{"id":"a","text":"18"},{"id":"b","text":"19"},{"id":"c","text":"20"},{"id":"d","text":"21"}]',
 'b',
 'Total = 8 + 12 − 1 = 19 (Meera is counted in both positions).',
 1),

-- PS 16 — Logical Reasoning
('single-choice', 'problem-solving',
 'If all roses are flowers, and some flowers are red, which of the following must be true?',
 '[{"id":"a","text":"All roses are red"},{"id":"b","text":"Some roses may be red"},{"id":"c","text":"No roses are red"},{"id":"d","text":"All red things are roses"}]',
 'b',
 'Since all roses are flowers, and some flowers are red, it is possible (but not certain) that some roses are red.',
 1),

-- PS 17 — Logical Reasoning / Pattern
('single-choice', 'problem-solving',
 'What comes next in the sequence: 2, 6, 12, 20, 30, ?',
 '[{"id":"a","text":"40"},{"id":"b","text":"42"},{"id":"c","text":"44"},{"id":"d","text":"36"}]',
 'b',
 'Differences: 4, 6, 8, 10, ... next difference = 12. So 30 + 12 = 42. Pattern: n(n+1) where n = 1,2,3,...',
 1),

-- PS 18 — Data Interpretation
('single-choice', 'problem-solving',
 'A pie chart shows the budget allocation of a household: Rent 30%, Food 25%, Transport 15%, Savings 20%, and Miscellaneous 10%. If the total monthly income is ₹80,000, how much is spent on Food and Transport combined?',
 '[{"id":"a","text":"₹28,000"},{"id":"b","text":"₹30,000"},{"id":"c","text":"₹32,000"},{"id":"d","text":"₹36,000"}]',
 'c',
 'Food + Transport = 25% + 15% = 40%. 40% of 80,000 = 32,000.',
 1),

-- PS 19 — Logical Reasoning
('single-choice', 'problem-solving',
 'Five people — A, B, C, D, E — are sitting in a circle. A is between B and E. C is not next to A. Who is sitting next to D?',
 '[{"id":"a","text":"B and C"},{"id":"b","text":"C and E"},{"id":"c","text":"A and C"},{"id":"d","text":"B and E"}]',
 'b',
 'A is between B and E → arrangement has B-A-E consecutive. C is not next to A, so C must be between B''s other side and E''s other side, meaning D and C fill the remaining spots. D is next to C and E.',
 1),

-- PS 20 — Data Interpretation
('single-choice', 'problem-solving',
 'The bar graph shows that City X had 120 rainy days in 2023 and 150 rainy days in 2024. What is the percentage increase in rainy days?',
 '[{"id":"a","text":"20%"},{"id":"b","text":"25%"},{"id":"c","text":"30%"},{"id":"d","text":"15%"}]',
 'b',
 'Increase = 150 − 120 = 30. Percentage increase = (30/120) × 100 = 25%.',
 1),

-- ═══════════════════════════════════════════════════════════════════════════
-- CRITICAL THINKING (20 questions)
-- ═══════════════════════════════════════════════════════════════════════════

-- CT 1 — Reading Comprehension
('single-choice', 'critical-thinking',
 'Read the passage: "The introduction of microfinance in rural India has been hailed as a revolution in poverty alleviation. By providing small loans to individuals who lack access to traditional banking, microfinance institutions have enabled millions to start small businesses. However, critics point out that high interest rates and aggressive collection practices have sometimes pushed borrowers deeper into debt." Based on the passage, what is the main tension described?',
 '[{"id":"a","text":"Microfinance is more popular in cities than in villages"},{"id":"b","text":"Microfinance helps reduce poverty but can also worsen debt"},{"id":"c","text":"Traditional banks are better than microfinance institutions"},{"id":"d","text":"Small businesses always fail without large loans"}]',
 'b',
 'The passage describes the benefit (poverty alleviation through small loans) and the criticism (worsening debt), creating a tension between the two.',
 1),

-- CT 2 — Reading Comprehension
('single-choice', 'critical-thinking',
 'Read the passage: "Urban green spaces are not merely aesthetic additions to cities. Research consistently shows that access to parks and gardens significantly reduces stress levels, improves air quality, and fosters community interaction. Cities that invest in green infrastructure tend to report higher citizen satisfaction and lower healthcare costs." According to the passage, which of the following is NOT mentioned as a benefit of urban green spaces?',
 '[{"id":"a","text":"Reduced stress levels"},{"id":"b","text":"Improved air quality"},{"id":"c","text":"Increased property values"},{"id":"d","text":"Greater community interaction"}]',
 'c',
 'The passage mentions reduced stress, improved air quality, and community interaction. Increased property values is not mentioned.',
 1),

-- CT 3 — Main Idea
('single-choice', 'critical-thinking',
 '"Social media has fundamentally changed the way we consume news. While it has democratised information by allowing anyone to share stories, it has also created echo chambers where people are only exposed to viewpoints that align with their own. This selective exposure can deepen political polarisation and reduce critical engagement with diverse perspectives." What is the main idea of this passage?',
 '[{"id":"a","text":"Social media is the best source for news"},{"id":"b","text":"Social media has both democratised and distorted news consumption"},{"id":"c","text":"People should stop using social media"},{"id":"d","text":"Echo chambers are beneficial for political understanding"}]',
 'b',
 'The passage presents both the positive (democratisation) and negative (echo chambers, polarisation) impacts of social media on news.',
 1),

-- CT 4 — Main Idea
('single-choice', 'critical-thinking',
 '"The shift towards remote work, accelerated by the pandemic, has revealed that productivity does not necessarily require physical office presence. Many employees report higher job satisfaction working from home. However, concerns about collaboration, mentorship for junior employees, and blurred work-life boundaries persist." What is the central point of this passage?',
 '[{"id":"a","text":"Remote work is always better than office work"},{"id":"b","text":"The pandemic destroyed traditional work culture"},{"id":"c","text":"Remote work has clear benefits but also unresolved challenges"},{"id":"d","text":"Junior employees cannot learn when working remotely"}]',
 'c',
 'The passage balances the productivity and satisfaction benefits with ongoing concerns about collaboration and mentorship.',
 1),

-- CT 5 — Main Idea
('single-choice', 'critical-thinking',
 '"Traditional education systems were designed for an industrial economy — standardised curricula, fixed schedules, rote memorisation. In a knowledge economy that rewards creativity and adaptability, these methods are increasingly inadequate. Educational reform must prioritise critical thinking, problem-solving, and personalised learning." The author''s main argument is that:',
 '[{"id":"a","text":"Industrial economies no longer exist"},{"id":"b","text":"Education must evolve to match the demands of a modern economy"},{"id":"c","text":"Rote memorisation has no value whatsoever"},{"id":"d","text":"All schools should eliminate fixed schedules"}]',
 'b',
 'The author argues that the education system, designed for an older economic model, must be reformed to suit the knowledge economy.',
 1),

-- CT 6 — Primary Purpose
('single-choice', 'critical-thinking',
 '"India''s space programme has achieved remarkable milestones on a fraction of the budget of Western agencies. The Mars Orbiter Mission cost less than the production budget of many Hollywood films. This cost-effectiveness stems from frugal engineering practices, lower labour costs, and a culture of innovation within ISRO." The primary purpose of this passage is to:',
 '[{"id":"a","text":"Criticise Western space agencies for overspending"},{"id":"b","text":"Explain why India''s space programme is cost-effective"},{"id":"c","text":"Argue that Hollywood films are too expensive"},{"id":"d","text":"Predict the future of space exploration"}]',
 'b',
 'The passage aims to explain the reasons behind the cost-effectiveness of India''s space programme.',
 1),

-- CT 7 — Primary Purpose
('single-choice', 'critical-thinking',
 '"While genetic testing offers unprecedented insight into hereditary disease risks, it also raises profound ethical questions. Should employers have access to employees'' genetic data? Can insurance companies deny coverage based on genetic predispositions? These questions demand careful regulation before the technology outpaces our legal frameworks." The primary purpose is to:',
 '[{"id":"a","text":"Promote genetic testing for all individuals"},{"id":"b","text":"Highlight the ethical and regulatory challenges of genetic testing"},{"id":"c","text":"Argue that insurance companies are discriminatory"},{"id":"d","text":"Explain how genetic testing works"}]',
 'b',
 'The passage focuses on the ethical dilemmas and regulatory gaps created by genetic testing.',
 1),

-- CT 8 — Primary Purpose
('single-choice', 'critical-thinking',
 '"Coral reefs support approximately 25% of all marine species despite covering less than 1% of the ocean floor. Rising sea temperatures, ocean acidification, and pollution are destroying these ecosystems at an alarming rate. Without immediate intervention, scientists predict that 90% of the world''s coral reefs could disappear by 2050." The passage primarily aims to:',
 '[{"id":"a","text":"Describe the beauty of coral reefs"},{"id":"b","text":"Argue for urgent action to protect coral reefs"},{"id":"c","text":"Explain how marine species reproduce"},{"id":"d","text":"Compare coral reefs to other marine ecosystems"}]',
 'b',
 'The passage presents the ecological importance of reefs, the threats they face, and the urgency of intervention.',
 1),

-- CT 9 — Strengthen/Weaken
('single-choice', 'critical-thinking',
 'Argument: "Cities should ban single-use plastic bags because they clog drains, harm marine life, and take hundreds of years to decompose." Which of the following, if true, would most STRENGTHEN this argument?',
 '[{"id":"a","text":"Cloth bags are more expensive to produce than plastic bags"},{"id":"b","text":"A recent study shows that cities with plastic bag bans saw a 40% reduction in waterway pollution"},{"id":"c","text":"Some consumers find plastic bags more convenient"},{"id":"d","text":"Recycling programmes can handle plastic waste effectively"}]',
 'b',
 'Evidence that bans actually reduce pollution directly supports the argument for banning plastic bags.',
 1),

-- CT 10 — Strengthen/Weaken
('single-choice', 'critical-thinking',
 'Argument: "Replacing textbooks with tablets in schools will improve student learning outcomes." Which of the following, if true, would most WEAKEN this argument?',
 '[{"id":"a","text":"Tablets are lighter than textbooks"},{"id":"b","text":"Studies show students retain information better from printed materials than screens"},{"id":"c","text":"Tablets can display videos and interactive content"},{"id":"d","text":"Many schools already use digital content"}]',
 'b',
 'If students actually learn better from print, the core claim that tablets improve outcomes is weakened.',
 1),

-- CT 11 — Strengthen/Weaken
('single-choice', 'critical-thinking',
 'Argument: "Mandatory voting should be introduced because it ensures higher democratic participation." Which of the following, if true, would most WEAKEN this argument?',
 '[{"id":"a","text":"Countries with mandatory voting have higher turnout rates"},{"id":"b","text":"Forced voters often cast uninformed or random ballots, reducing the quality of democratic outcomes"},{"id":"c","text":"Voluntary voting leads to lower participation among youth"},{"id":"d","text":"Mandatory voting exists in Australia and Brazil"}]',
 'b',
 'If mandatory voting leads to uninformed voting, it undermines the quality of participation even if quantity increases.',
 1),

-- CT 12 — Strengthen/Weaken
('single-choice', 'critical-thinking',
 'Argument: "Working from home reduces carbon emissions because fewer people commute by car." Which of the following, if true, would most WEAKEN this argument?',
 '[{"id":"a","text":"Public transport usage has declined during the remote work era"},{"id":"b","text":"Home energy consumption for heating and cooling increases significantly when people work from home"},{"id":"c","text":"Many employees enjoy not commuting"},{"id":"d","text":"Some companies have reduced office space"}]',
 'b',
 'If home energy use rises substantially, the net carbon benefit of reduced commuting may be offset.',
 1),

-- CT 13 — Strengthen/Weaken
('single-choice', 'critical-thinking',
 'Argument: "Universities should require all students to take a course in financial literacy because most young adults are unprepared to manage their finances." Which of the following, if true, would STRENGTHEN this argument?',
 '[{"id":"a","text":"Most university students already take elective finance courses"},{"id":"b","text":"A survey found that 70% of graduates under 30 carry avoidable debt due to poor financial planning"},{"id":"c","text":"Financial literacy courses are expensive to develop"},{"id":"d","text":"Some students find financial topics boring"}]',
 'b',
 'High rates of avoidable debt among graduates directly supports the claim that financial literacy education is needed.',
 1),

-- CT 14 — Strengthen/Weaken
('single-choice', 'critical-thinking',
 'Argument: "Zoos play a vital role in wildlife conservation by breeding endangered species." Which of the following, if true, would most WEAKEN this argument?',
 '[{"id":"a","text":"Many zoos invest heavily in breeding programmes"},{"id":"b","text":"Fewer than 5% of zoo-bred animals are ever successfully reintroduced into the wild"},{"id":"c","text":"Zoos provide educational experiences for children"},{"id":"d","text":"Some endangered species exist only in captivity"}]',
 'b',
 'If almost no zoo-bred animals return to the wild, the conservation claim is significantly weakened.',
 1),

-- CT 15 — Strengthen/Weaken
('single-choice', 'critical-thinking',
 'Argument: "Increasing the minimum wage will reduce poverty." Which of the following, if true, would most WEAKEN this argument?',
 '[{"id":"a","text":"Workers earning minimum wage often struggle to afford basic necessities"},{"id":"b","text":"When the minimum wage increases, many small businesses reduce staff or cut hours, resulting in lower total earnings for workers"},{"id":"c","text":"Inflation has outpaced wage growth for the past decade"},{"id":"d","text":"Higher wages boost consumer spending"}]',
 'b',
 'If businesses respond by cutting jobs or hours, workers may end up earning less despite a higher hourly rate.',
 1),

-- CT 16 — Strengthen/Weaken
('single-choice', 'critical-thinking',
 'Argument: "Social media should be banned for children under 16 to protect their mental health." Which of the following, if true, would most STRENGTHEN this argument?',
 '[{"id":"a","text":"Many adults also experience negative effects from social media"},{"id":"b","text":"A longitudinal study of 10,000 teenagers found that daily social media use correlated with a 50% increase in anxiety and depression symptoms"},{"id":"c","text":"Some children use social media to connect with friends"},{"id":"d","text":"Parents can monitor their children''s online activity"}]',
 'b',
 'Strong empirical evidence linking social media use to mental health problems in teenagers directly supports the ban argument.',
 1),

-- CT 17 — Strengthen/Weaken
('single-choice', 'critical-thinking',
 'Argument: "Organic farming is better for the environment than conventional farming." Which of the following, if true, would most WEAKEN this argument?',
 '[{"id":"a","text":"Organic food is generally more expensive"},{"id":"b","text":"Organic farms produce 20–30% less food per hectare, requiring more land and potentially more deforestation"},{"id":"c","text":"Conventional farming uses synthetic pesticides"},{"id":"d","text":"Consumer demand for organic food is growing"}]',
 'b',
 'If organic farming requires significantly more land, it could lead to deforestation, undermining its environmental benefit.',
 1),

-- CT 18 — Strengthen/Weaken
('single-choice', 'critical-thinking',
 'Argument: "Artificial intelligence will eliminate more jobs than it creates, leading to mass unemployment." Which of the following, if true, would most WEAKEN this argument?',
 '[{"id":"a","text":"AI is already being used in healthcare and finance"},{"id":"b","text":"Historical data shows that every major technological revolution — from the printing press to the internet — initially displaced workers but ultimately created more new jobs than it eliminated"},{"id":"c","text":"AI requires large amounts of data to function"},{"id":"d","text":"Some workers are anxious about automation"}]',
 'b',
 'Historical precedent of technology creating net new jobs challenges the prediction of mass unemployment.',
 1),

-- CT 19 — Parallel Reasoning
('single-choice', 'critical-thinking',
 'Argument: "All doctors study biology. Priya studies biology. Therefore, Priya is a doctor." Which of the following uses the SAME flawed reasoning?',
 '[{"id":"a","text":"All cats are animals. Rover is an animal. Therefore, Rover is a cat."},{"id":"b","text":"All squares are rectangles. This shape is a square. Therefore, it is a rectangle."},{"id":"c","text":"No birds are mammals. A penguin is a bird. Therefore, a penguin is not a mammal."},{"id":"d","text":"Some teachers are musicians. Raj is a teacher. Therefore, Raj is a musician."}]',
 'a',
 'Both arguments commit the fallacy of affirming the consequent: All A are B; X is B; therefore X is A.',
 1),

-- CT 20 — Parallel Reasoning
('single-choice', 'critical-thinking',
 'Argument: "Every time it rains, the streets get wet. The streets are wet. Therefore, it must have rained." Which of the following exhibits the SAME logical flaw?',
 '[{"id":"a","text":"Every time I eat spicy food, I get a headache. I have a headache. Therefore, I must have eaten spicy food."},{"id":"b","text":"If it snows, schools close. It snowed today. Therefore, schools are closed."},{"id":"c","text":"All mammals are warm-blooded. Dogs are mammals. Therefore, dogs are warm-blooded."},{"id":"d","text":"If I study hard, I pass. I didn''t study. Therefore, I will fail."}]',
 'a',
 'Both arguments assume the only possible cause: if A then B; B occurred; therefore A. But B could have other causes (e.g., a burst pipe, or a different headache trigger).',
 1);

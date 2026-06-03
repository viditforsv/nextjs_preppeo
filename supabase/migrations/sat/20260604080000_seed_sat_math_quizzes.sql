-- ════════════════════════════════════════════════════════════════════════
-- Seed concept-check quiz questions for each SAT Math topic's quiz item
-- (slug='quiz'). Basic questions that test the topic's concepts — NOT
-- exam-style. Linear Equations already has its quiz (item slug 'linear-quiz')
-- and is excluded. NOT EXISTS guard makes re-runs safe. Target: dev first.
-- ════════════════════════════════════════════════════════════════════════
INSERT INTO public.sat_learn_quiz_questions (item_id, question, options, correct_answer, explanation, sort_order)
SELECT i.id, v.question, v.options::jsonb, v.correct_answer, v.explanation, v.sort_order
FROM (VALUES
  -- Algebra
  ('linear-functions-graphs','In f(x) = mx + b, what does b represent?','[{"id":"A","text":"the slope"},{"id":"B","text":"the value of f(0)"},{"id":"C","text":"the x-intercept"},{"id":"D","text":"the rate of change"}]','B','b is the output when x = 0 — the y-intercept.',1),
  ('linear-functions-graphs','A line has positive slope. As x increases, y…','[{"id":"A","text":"decreases"},{"id":"B","text":"increases"},{"id":"C","text":"stays constant"},{"id":"D","text":"becomes zero"}]','B','Positive slope means the line rises left to right.',2),
  ('linear-functions-graphs','What is the slope of a horizontal line?','[{"id":"A","text":"0"},{"id":"B","text":"1"},{"id":"C","text":"undefined"},{"id":"D","text":"-1"}]','A','No vertical change means rise/run = 0.',3),
  ('linear-functions-graphs','A quantity increases by the same amount for every step in x. The model is…','[{"id":"A","text":"quadratic"},{"id":"B","text":"exponential"},{"id":"C","text":"linear"},{"id":"D","text":"random"}]','C','A constant rate of change is the signature of a linear function.',4),

  ('systems-of-linear-equations','A system whose two lines are parallel has…','[{"id":"A","text":"one solution"},{"id":"B","text":"no solution"},{"id":"C","text":"infinitely many"},{"id":"D","text":"two solutions"}]','B','Parallel lines never meet, so there is no common solution.',1),
  ('systems-of-linear-equations','Which method cancels a variable by adding or subtracting the equations?','[{"id":"A","text":"substitution"},{"id":"B","text":"elimination"},{"id":"C","text":"factoring"},{"id":"D","text":"graphing"}]','B','Elimination combines equations to remove a variable.',2),
  ('systems-of-linear-equations','If both equations describe the same line, the system has…','[{"id":"A","text":"no solution"},{"id":"B","text":"one solution"},{"id":"C","text":"infinitely many solutions"},{"id":"D","text":"exactly two"}]','C','Every point on the shared line satisfies both equations.',3),
  ('systems-of-linear-equations','Graphically, the solution of a system is…','[{"id":"A","text":"the y-intercepts"},{"id":"B","text":"the slopes"},{"id":"C","text":"the point where the lines cross"},{"id":"D","text":"the x-axis"}]','C','The intersection point satisfies both equations at once.',4),

  ('linear-inequalities','When you divide both sides of an inequality by -2, you must…','[{"id":"A","text":"keep the sign"},{"id":"B","text":"flip the sign"},{"id":"C","text":"drop the sign"},{"id":"D","text":"square both sides"}]','B','Multiplying or dividing by a negative reverses the inequality.',1),
  ('linear-inequalities','The graph of y > 2x + 1 uses a boundary line that is…','[{"id":"A","text":"solid"},{"id":"B","text":"dashed"},{"id":"C","text":"vertical"},{"id":"D","text":"curved"}]','B','Strict inequalities (> or <) exclude the boundary, so it is dashed.',2),
  ('linear-inequalities','To decide which side of the line to shade, you can…','[{"id":"A","text":"guess"},{"id":"B","text":"test a point such as (0,0)"},{"id":"C","text":"flip the line"},{"id":"D","text":"use only the slope"}]','B','Testing a point shows which side makes the inequality true.',3),
  ('linear-inequalities','In a system of inequalities, the solution set is…','[{"id":"A","text":"either shaded region"},{"id":"B","text":"the overlap of the shaded regions"},{"id":"C","text":"the boundary lines"},{"id":"D","text":"the y-axis"}]','B','A solution must satisfy every inequality at once.',4),

  -- Advanced Math
  ('quadratic-functions','The graph of a quadratic function is a…','[{"id":"A","text":"line"},{"id":"B","text":"parabola"},{"id":"C","text":"circle"},{"id":"D","text":"hyperbola"}]','B','Every quadratic graphs as a parabola.',1),
  ('quadratic-functions','In y = a(x - h)² + k, the vertex is at…','[{"id":"A","text":"(a, k)"},{"id":"B","text":"(h, k)"},{"id":"C","text":"(h, a)"},{"id":"D","text":"(0, k)"}]','B','Vertex form reads the vertex directly as (h, k).',2),
  ('quadratic-functions','If the discriminant b² - 4ac equals zero, how many real solutions are there?','[{"id":"A","text":"none"},{"id":"B","text":"one"},{"id":"C","text":"two"},{"id":"D","text":"infinitely many"}]','B','A zero discriminant gives exactly one (repeated) real root.',3),
  ('quadratic-functions','Which form most directly shows the x-intercepts?','[{"id":"A","text":"standard"},{"id":"B","text":"vertex"},{"id":"C","text":"factored"},{"id":"D","text":"slope-intercept"}]','C','Factored form exposes the roots r1 and r2.',4),

  ('exponents-radicals','Simplify x³ · x⁴.','[{"id":"A","text":"x⁷"},{"id":"B","text":"x¹²"},{"id":"C","text":"x⁻¹"},{"id":"D","text":"x"}]','A','Multiplying powers with the same base adds exponents: 3 + 4 = 7.',1),
  ('exponents-radicals','What is a⁰ for a not equal to 0?','[{"id":"A","text":"0"},{"id":"B","text":"1"},{"id":"C","text":"a"},{"id":"D","text":"undefined"}]','B','Any nonzero base to the power 0 equals 1.',2),
  ('exponents-radicals','a⁻² is equal to…','[{"id":"A","text":"-a²"},{"id":"B","text":"1/a²"},{"id":"C","text":"2a"},{"id":"D","text":"a/2"}]','B','A negative exponent means the reciprocal.',3),
  ('exponents-radicals','√x can be written as…','[{"id":"A","text":"x²"},{"id":"B","text":"x^(1/2)"},{"id":"C","text":"2x"},{"id":"D","text":"x⁻¹"}]','B','A square root is the one-half power.',4),

  ('polynomials-factoring','Factor x² - 9.','[{"id":"A","text":"(x-3)(x-3)"},{"id":"B","text":"(x+3)(x-3)"},{"id":"C","text":"(x+9)(x-1)"},{"id":"D","text":"(x-9)(x+1)"}]','B','Difference of squares: a² - b² = (a+b)(a-b).',1),
  ('polynomials-factoring','x² + 5x + 6 factors to…','[{"id":"A","text":"(x+2)(x+3)"},{"id":"B","text":"(x+1)(x+6)"},{"id":"C","text":"(x-2)(x-3)"},{"id":"D","text":"(x+5)(x+1)"}]','A','2 and 3 multiply to 6 and add to 5.',2),
  ('polynomials-factoring','If (x - 4) is a factor of P(x), then…','[{"id":"A","text":"P(0) = 4"},{"id":"B","text":"P(4) = 0"},{"id":"C","text":"P(4) = 4"},{"id":"D","text":"P(-4) = 0"}]','B','By the factor theorem, the matching root makes P equal 0.',3),
  ('polynomials-factoring','A value where a polynomial equals zero is called a…','[{"id":"A","text":"coefficient"},{"id":"B","text":"degree"},{"id":"C","text":"root"},{"id":"D","text":"vertex"}]','C','A root (zero) is where P(x) = 0.',4),

  ('exponential-functions','In y = a · bˣ, the value a is…','[{"id":"A","text":"the rate"},{"id":"B","text":"the starting value at x = 0"},{"id":"C","text":"the exponent"},{"id":"D","text":"the base"}]','B','When x = 0, b⁰ = 1, so y = a.',1),
  ('exponential-functions','If b is between 0 and 1, the function shows…','[{"id":"A","text":"growth"},{"id":"B","text":"decay"},{"id":"C","text":"a straight line"},{"id":"D","text":"no change"}]','B','A factor less than 1 shrinks the value each step.',2),
  ('exponential-functions','"Increases by 8% each year" is modeled by…','[{"id":"A","text":"y = a + 0.08t"},{"id":"B","text":"y = a(1.08)ᵗ"},{"id":"C","text":"y = 8a"},{"id":"D","text":"y = a/1.08"}]','B','Repeated percent growth multiplies by (1 + r) each period.',3),
  ('exponential-functions','Exponential functions change by…','[{"id":"A","text":"adding a constant"},{"id":"B","text":"multiplying by a constant factor"},{"id":"C","text":"a fixed slope"},{"id":"D","text":"subtracting"}]','B','Each step multiplies by the same factor b.',4),

  -- Problem-Solving & Data
  ('ratios-rates-proportions','From a/b = c/d, cross-multiplying gives…','[{"id":"A","text":"ab = cd"},{"id":"B","text":"ad = bc"},{"id":"C","text":"a + d = b + c"},{"id":"D","text":"a/d = b/c"}]','B','Cross-multiplication multiplies each numerator by the other denominator.',1),
  ('ratios-rates-proportions','3 pencils cost 6 rupees. At the same rate, 5 pencils cost…','[{"id":"A","text":"9"},{"id":"B","text":"10"},{"id":"C","text":"12"},{"id":"D","text":"15"}]','B','Each pencil is 2 rupees, so 5 cost 10.',2),
  ('ratios-rates-proportions','A rate compares quantities with…','[{"id":"A","text":"the same unit"},{"id":"B","text":"different units"},{"id":"C","text":"no units"},{"id":"D","text":"only money"}]','B','A rate links different units, like miles per hour.',3),
  ('ratios-rates-proportions','To convert units you multiply by a fraction equal to…','[{"id":"A","text":"0"},{"id":"B","text":"1"},{"id":"C","text":"the rate"},{"id":"D","text":"100"}]','B','A unit factor equals 1, so it changes units without changing value.',4),

  ('percentages','What is 25% of 80?','[{"id":"A","text":"16"},{"id":"B","text":"20"},{"id":"C","text":"25"},{"id":"D","text":"40"}]','B','0.25 × 80 = 20.',1),
  ('percentages','A price rises from 50 to 60. The percent increase is…','[{"id":"A","text":"10%"},{"id":"B","text":"16.7%"},{"id":"C","text":"20%"},{"id":"D","text":"60%"}]','C','Change is 10 over an original of 50, which is 20%.',2),
  ('percentages','Increasing a number by 10% means multiplying by…','[{"id":"A","text":"0.10"},{"id":"B","text":"1.10"},{"id":"C","text":"0.90"},{"id":"D","text":"10"}]','B','Add the 10% to the whole: 1 + 0.10.',3),
  ('percentages','0.3 written as a percent is…','[{"id":"A","text":"0.3%"},{"id":"B","text":"3%"},{"id":"C","text":"30%"},{"id":"D","text":"300%"}]','C','Multiply a decimal by 100 to get a percent.',4),

  ('statistics-data','Which measure of center is most affected by an outlier?','[{"id":"A","text":"mean"},{"id":"B","text":"median"},{"id":"C","text":"mode"},{"id":"D","text":"none of them"}]','A','The mean uses every value, so an extreme value pulls it.',1),
  ('statistics-data','The median is…','[{"id":"A","text":"the average"},{"id":"B","text":"the middle value when ordered"},{"id":"C","text":"the most frequent value"},{"id":"D","text":"max minus min"}]','B','The median is the middle of the ordered list.',2),
  ('statistics-data','The range equals…','[{"id":"A","text":"max + min"},{"id":"B","text":"max - min"},{"id":"C","text":"sum / count"},{"id":"D","text":"the middle value"}]','B','Range measures the spread from smallest to largest.',3),
  ('statistics-data','A larger standard deviation means the data is…','[{"id":"A","text":"more spread out"},{"id":"B","text":"more clustered"},{"id":"C","text":"all equal"},{"id":"D","text":"smaller"}]','A','Standard deviation grows as values spread from the mean.',4),

  ('probability','A fair six-sided die is rolled. P(rolling a 4) is…','[{"id":"A","text":"1/2"},{"id":"B","text":"1/4"},{"id":"C","text":"1/6"},{"id":"D","text":"4/6"}]','C','One favorable outcome out of six equally likely outcomes.',1),
  ('probability','Probability values range from…','[{"id":"A","text":"0 to 100"},{"id":"B","text":"0 to 1"},{"id":"C","text":"-1 to 1"},{"id":"D","text":"1 to 10"}]','B','0 is impossible and 1 is certain.',2),
  ('probability','If P(A) = 0.3, then P(not A) is…','[{"id":"A","text":"0.3"},{"id":"B","text":"0.7"},{"id":"C","text":"1.3"},{"id":"D","text":"0"}]','B','The complement is 1 - P(A) = 0.7.',3),
  ('probability','For independent events A and B, P(A and B) equals…','[{"id":"A","text":"P(A) + P(B)"},{"id":"B","text":"P(A) - P(B)"},{"id":"C","text":"P(A) × P(B)"},{"id":"D","text":"P(A) / P(B)"}]','C','Independent probabilities multiply.',4),

  -- Geometry & Trigonometry
  ('lines-angles-triangles','Two angles that add to 180° are…','[{"id":"A","text":"complementary"},{"id":"B","text":"supplementary"},{"id":"C","text":"vertical"},{"id":"D","text":"right"}]','B','Supplementary angles sum to 180°.',1),
  ('lines-angles-triangles','Vertical angles are always…','[{"id":"A","text":"equal"},{"id":"B","text":"supplementary"},{"id":"C","text":"90°"},{"id":"D","text":"different"}]','A','Opposite angles at a crossing are equal.',2),
  ('lines-angles-triangles','The interior angles of a triangle sum to…','[{"id":"A","text":"90°"},{"id":"B","text":"180°"},{"id":"C","text":"270°"},{"id":"D","text":"360°"}]','B','Every triangle has angle sum 180°.',3),
  ('lines-angles-triangles','Similar triangles have…','[{"id":"A","text":"equal areas"},{"id":"B","text":"equal side lengths"},{"id":"C","text":"equal angles and proportional sides"},{"id":"D","text":"only right angles"}]','C','Similarity preserves angles and scales sides proportionally.',4),

  ('right-triangles-trigonometry','In a right triangle with hypotenuse c, a² + b² equals…','[{"id":"A","text":"ab"},{"id":"B","text":"c²"},{"id":"C","text":"2c"},{"id":"D","text":"c"}]','B','That is the Pythagorean theorem.',1),
  ('right-triangles-trigonometry','sin θ equals…','[{"id":"A","text":"adjacent / hypotenuse"},{"id":"B","text":"opposite / hypotenuse"},{"id":"C","text":"opposite / adjacent"},{"id":"D","text":"hypotenuse / opposite"}]','B','SOH: sine is opposite over hypotenuse.',2),
  ('right-triangles-trigonometry','The sides of a 45-45-90 triangle are in the ratio…','[{"id":"A","text":"1 : 1 : √2"},{"id":"B","text":"1 : 2 : 3"},{"id":"C","text":"1 : √3 : 2"},{"id":"D","text":"3 : 4 : 5"}]','A','The two legs are equal and the hypotenuse is leg × √2.',3),
  ('right-triangles-trigonometry','tan θ equals…','[{"id":"A","text":"opposite / adjacent"},{"id":"B","text":"adjacent / opposite"},{"id":"C","text":"opposite / hypotenuse"},{"id":"D","text":"adjacent / hypotenuse"}]','A','TOA: tangent is opposite over adjacent.',4),

  ('circles','The area of a circle is…','[{"id":"A","text":"2πr"},{"id":"B","text":"πr²"},{"id":"C","text":"πd"},{"id":"D","text":"r²"}]','B','Area uses the radius squared: πr².',1),
  ('circles','The circumference of a circle is…','[{"id":"A","text":"πr²"},{"id":"B","text":"2πr"},{"id":"C","text":"πr"},{"id":"D","text":"4πr"}]','B','Circumference is 2πr.',2),
  ('circles','The circle (x - 2)² + (y + 3)² = 16 has center…','[{"id":"A","text":"(2, 3)"},{"id":"B","text":"(-2, 3)"},{"id":"C","text":"(2, -3)"},{"id":"D","text":"(-2, -3)"}]','C','Center is (h, k) = (2, -3) from the signs inside.',3),
  ('circles','For that same circle, the radius is…','[{"id":"A","text":"16"},{"id":"B","text":"8"},{"id":"C","text":"4"},{"id":"D","text":"2"}]','C','r² = 16, so r = 4.',4),

  ('area-volume','A triangle has base 6 and height 4. Its area is…','[{"id":"A","text":"10"},{"id":"B","text":"12"},{"id":"C","text":"24"},{"id":"D","text":"48"}]','B','Area = ½ × 6 × 4 = 12.',1),
  ('area-volume','The volume of a cylinder is…','[{"id":"A","text":"πr²h"},{"id":"B","text":"2πrh"},{"id":"C","text":"(4/3)πr³"},{"id":"D","text":"πr²"}]','A','Volume is base area πr² times height h.',2),
  ('area-volume','The volume of a sphere is…','[{"id":"A","text":"πr²h"},{"id":"B","text":"(4/3)πr³"},{"id":"C","text":"(1/3)πr²h"},{"id":"D","text":"4πr²"}]','B','The sphere volume formula is (4/3)πr³.',3),
  ('area-volume','A cone has volume equal to what fraction of a cylinder with the same base and height?','[{"id":"A","text":"one-half"},{"id":"B","text":"one-third"},{"id":"C","text":"twice"},{"id":"D","text":"the same"}]','B','A cone is one-third of the matching cylinder.',4)
) AS v(topic_slug, question, options, correct_answer, explanation, sort_order)
JOIN public.sat_learn_topics t ON t.slug = v.topic_slug
JOIN public.sat_learn_courses c ON c.id = t.course_id AND c.slug = 'sat-math'
JOIN public.sat_learn_items i ON i.topic_id = t.id AND i.slug = 'quiz'
WHERE NOT EXISTS (
  SELECT 1 FROM public.sat_learn_quiz_questions q WHERE q.item_id = i.id
);

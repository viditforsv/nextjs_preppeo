-- Backfill domain, chapter, subtopic for all LID practice questions

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Linear equations in one variable', subtopic = 'Linear Equation Word Problems'
  WHERE bank_item_id LIKE 'sat_lid_002_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Linear equations in one variable', subtopic = 'Number of Solutions (Zero, One, Infinite)'
  WHERE bank_item_id LIKE 'sat_lid_003_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Linear equations in two variables', subtopic = 'Slope-Intercept & Standard Form'
  WHERE bank_item_id LIKE 'sat_lid_004_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Linear equations in two variables', subtopic = 'Graphing Linear Equations'
  WHERE bank_item_id LIKE 'sat_lid_005_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Linear equations in two variables', subtopic = 'Interpreting Linear Models'
  WHERE bank_item_id LIKE 'sat_lid_006_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Systems of two linear equations in two variables', subtopic = 'Solving Systems (Substitution & Elimination)'
  WHERE bank_item_id LIKE 'sat_lid_007_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Systems of two linear equations in two variables', subtopic = 'Systems Word Problems'
  WHERE bank_item_id LIKE 'sat_lid_008_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Systems of two linear equations in two variables', subtopic = 'Number of Solutions in Systems'
  WHERE bank_item_id LIKE 'sat_lid_009_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Linear inequalities in one or two variables', subtopic = 'Solving & Graphing Inequalities'
  WHERE bank_item_id LIKE 'sat_lid_010_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Linear inequalities in one or two variables', subtopic = 'Systems of Inequalities'
  WHERE bank_item_id LIKE 'sat_lid_011_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Linear functions: slope, intercepts, graphs', subtopic = 'Slope & Intercepts'
  WHERE bank_item_id LIKE 'sat_lid_012_%';

UPDATE public.sat_questions SET domain = 'algebra', chapter = 'Linear functions: slope, intercepts, graphs', subtopic = NULL
  WHERE bank_item_id LIKE 'sat_lid_013_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Nonlinear equations in one variable', subtopic = 'Solving Quadratics (Factoring & Formula)'
  WHERE bank_item_id LIKE 'sat_lid_014_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Nonlinear equations in one variable', subtopic = 'Discriminant & Number of Solutions'
  WHERE bank_item_id LIKE 'sat_lid_015_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Systems of equations in two variables', subtopic = 'Linear-Quadratic Systems'
  WHERE bank_item_id LIKE 'sat_lid_016_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Systems of equations in two variables', subtopic = 'Nonlinear Systems'
  WHERE bank_item_id LIKE 'sat_lid_017_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Equivalent expressions', subtopic = 'Operations with Polynomials'
  WHERE bank_item_id LIKE 'sat_lid_018_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Equivalent expressions', subtopic = 'Exponents & Radicals'
  WHERE bank_item_id LIKE 'sat_lid_019_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Equivalent expressions', subtopic = 'Rational Expressions'
  WHERE bank_item_id LIKE 'sat_lid_020_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Nonlinear Functions Quadratic functions, graphs, vertex, roots', subtopic = 'Vertex Form & Graph Features'
  WHERE bank_item_id LIKE 'sat_lid_021_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Nonlinear Functions Quadratic functions, graphs, vertex, roots', subtopic = 'Quadratic Word Problems'
  WHERE bank_item_id LIKE 'sat_lid_022_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Exponential functions and equations', subtopic = 'Exponential Growth & Decay'
  WHERE bank_item_id LIKE 'sat_lid_023_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Exponential functions and equations', subtopic = 'Compound Interest & Population Growth'
  WHERE bank_item_id LIKE 'sat_lid_024_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Rational and radical equations/functions', subtopic = 'Solving Radical Equations'
  WHERE bank_item_id LIKE 'sat_lid_025_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Nonlinear Functions Rational and radical equations/functions', subtopic = 'Solving Rational Equations'
  WHERE bank_item_id LIKE 'sat_lid_026_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Function Notation Function notation and interpreting functions', subtopic = 'Evaluating Functions'
  WHERE bank_item_id LIKE 'sat_lid_027_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Function Notation Function notation and interpreting functions', subtopic = 'Function Transformations'
  WHERE bank_item_id LIKE 'sat_lid_028_%';

UPDATE public.sat_questions SET domain = 'advanced-math', chapter = 'Function Notation Function notation and interpreting functions', subtopic = 'Domain & Range'
  WHERE bank_item_id LIKE 'sat_lid_029_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Ratios, rates, proportional relationships, units', subtopic = 'Unit Conversions & Rates'
  WHERE bank_item_id LIKE 'sat_lid_030_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Ratios, rates, proportional relationships, units', subtopic = 'Ratio & Proportion Word Problems'
  WHERE bank_item_id LIKE 'sat_lid_031_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Percentages and percentage change', subtopic = 'Percent Change'
  WHERE bank_item_id LIKE 'sat_lid_032_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Percentages and percentage change', subtopic = 'Simple & Compound Interest'
  WHERE bank_item_id LIKE 'sat_lid_033_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Distributions, measures of center/spread', subtopic = 'Mean, Median, Mode, Range'
  WHERE bank_item_id LIKE 'sat_lid_034_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Distributions, measures of center/spread', subtopic = 'Standard Deviation & Box Plots'
  WHERE bank_item_id LIKE 'sat_lid_035_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Scatterplots, trend lines, models', subtopic = 'Line of Best Fit'
  WHERE bank_item_id LIKE 'sat_lid_036_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Scatterplots, trend lines, models', subtopic = 'Predictions from Models'
  WHERE bank_item_id LIKE 'sat_lid_037_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Probability and conditional probability', subtopic = 'Basic Probability'
  WHERE bank_item_id LIKE 'sat_lid_038_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Probability and conditional probability', subtopic = 'Conditional Probability Tables'
  WHERE bank_item_id LIKE 'sat_lid_039_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Inference from samples, margin of error', subtopic = 'Sample Validity & Bias'
  WHERE bank_item_id LIKE 'sat_lid_040_%';

UPDATE public.sat_questions SET domain = 'problem-solving', chapter = 'Inference from samples, margin of error', subtopic = 'Margin of Error & Confidence'
  WHERE bank_item_id LIKE 'sat_lid_041_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Lines, angles, parallel/perpendicular lines', subtopic = 'Parallel Lines & Transversals'
  WHERE bank_item_id LIKE 'sat_lid_042_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Lines, angles, parallel/perpendicular lines', subtopic = 'Angles in Polygons'
  WHERE bank_item_id LIKE 'sat_lid_043_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Triangles, Pythagorean theorem, similar triangles', subtopic = 'Pythagorean Theorem'
  WHERE bank_item_id LIKE 'sat_lid_044_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Triangles, Pythagorean theorem, similar triangles', subtopic = 'Special Right Triangles'
  WHERE bank_item_id LIKE 'sat_lid_045_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Triangles, Pythagorean theorem, similar triangles', subtopic = 'Similar Triangles'
  WHERE bank_item_id LIKE 'sat_lid_046_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Area and volume of 2D/3D shapes', subtopic = 'Area of Polygons'
  WHERE bank_item_id LIKE 'sat_lid_047_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Area and volume of 2D/3D shapes', subtopic = 'Volume of Prisms & Cylinders'
  WHERE bank_item_id LIKE 'sat_lid_048_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Circle properties: arcs, chords, angles', subtopic = 'Arc Length & Sector Area'
  WHERE bank_item_id LIKE 'sat_lid_049_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Circle properties: arcs, chords, angles', subtopic = 'Equation of a Circle'
  WHERE bank_item_id LIKE 'sat_lid_050_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Right-triangle trig: sin, cos, tan', subtopic = 'SOH CAH TOA'
  WHERE bank_item_id LIKE 'sat_lid_051_%';

UPDATE public.sat_questions SET domain = 'geometry-trig', chapter = 'Right-triangle trig: sin, cos, tan', subtopic = 'Trigonometric Word Problems'
  WHERE bank_item_id LIKE 'sat_lid_052_%';


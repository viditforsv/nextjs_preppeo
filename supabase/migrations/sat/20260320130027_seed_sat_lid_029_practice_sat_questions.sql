-- Practice-mode math from lid_029.tex (sat_lid_029)
-- Chapter: Function Notation Function notation and interpreting functions | Topic: Domain & Range
-- sat_questions: section=math, domain=advanced-math, bank_item_id=sat_lid_029_N, practice module/set 0.

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
  'The function $f$ is defined by $f(x) = \\frac{1}{x - 9}$. Which of the following is the domain of $f$?',
  '[{"id":"a","text":"All real numbers"},{"id":"b","text":"All real numbers such that $x \\\\neq 0$"},{"id":"c","text":"All real numbers such that $x \\\\neq 9$"},{"id":"d","text":"All real numbers such that $x > 9$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The domain of a function consists of all possible input values ($x$) for which the function is defined. For rational functions (fractions with variables in the denominator), the function is undefined wherever the denominator equals zero.

\\textbf{Calculation and Logic:}

Set the denominator equal to zero to find the excluded value:

$x - 9 = 0$

$x = 9$

Since division by zero is undefined, $x$ can be any real number except 9.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_1',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = \\sqrt{2x - 14}$ For the function $f$ defined above, what is the smallest value in the domain?',
  NULL,
  '7',
  '\\textbf{Conceptual Explanation:}

For a square root function to result in a real number, the expression inside the radical (the radicand) must be greater than or equal to zero.

\\textbf{Calculation and Logic:}

Set up the inequality for the domain:

$2x - 14 ≥ 0$

Solve for $x$:

$2x ≥ 14$

$x ≥ 7$

The domain consists of all values 7 or greater. The smallest value is 7.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_2',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.7] \\draw[->] (-1,0) -- (5,0) node[right] {$x$}; \\draw[->] (0,-1) -- (0,5) node[above] {$y$}; \\draw[ultra thick, blue] (1,2) -- (4,4); \\filldraw[blue] (1,2) circle (2pt); \\filldraw[blue] (4,4) circle (2pt); \\end{tikzpicture} \\end{center} The graph of the function $f$ is shown in the $xy$-plane above. What is the range of $f$?',
  '[{"id":"a","text":"$1 ≤ x ≤ 4$"},{"id":"b","text":"$2 ≤ y ≤ 4$"},{"id":"c","text":"$1 ≤ y ≤ 4$"},{"id":"d","text":"$2 ≤ x ≤ 4$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The **Range** of a function is the set of all possible output values ($y$-coordinates) shown on the graph. We look at the vertical span of the graph from the lowest point to the highest point.

\\textbf{Calculation and Logic:}

1. **Identify the lowest point:** The segment starts at $(1, 2)$. The $y$-value is 2.

2. **Identify the highest point:** The segment ends at $(4, 4)$. The $y$-value is 4.

The graph covers all $y$-values from 2 to 4, inclusive.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_3',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = |x - 5| + 12$ What is the minimum value of the range of the function $f$?',
  NULL,
  '12',
  '\\textbf{Conceptual Explanation:}

An absolute value expression $|x - h|$ has a minimum value of 0. To find the minimum of the range, we determine the smallest possible value for the entire function.

\\textbf{Calculation and Logic:}

The smallest value $|x - 5|$ can achieve is 0 (which happens when $x = 5$).

$f(5) = 0 + 12 = 12$.

For any other value of $x$, $|x - 5|$ will be positive, making $f(x)$ greater than 12.

Therefore, the range is $y ≥ 12$, and the minimum value is 12.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_4',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'Which of the following values of $x$ is NOT in the domain of the function $f(x) = \\frac{x+5}{x^2 - 16}$?',
  '[{"id":"a","text":"-5"},{"id":"b","text":"0"},{"id":"c","text":"4"},{"id":"d","text":"5"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

A rational function is undefined when the denominator is zero.

$x^2 - 16 = 0$

$x^2 = 16$

$x = 4$ or $x = -4$.

From the given options, 4 is an excluded value.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_5',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$g(x) = \\frac{1}{(x-3)(x-10)}$ The function $g$ is undefined for $x = a$ and $x = b$. What is the value of $a + b$?',
  NULL,
  '13',
  '\\textbf{Calculation and Logic:}

The function is undefined where the denominator equals zero.

$(x - 3)(x - 10) = 0$

$x = 3$ and $x = 10$.

Let $a = 3$ and $b = 10$.

$a + b = 3 + 10 = 13$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_6',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '$f(x) = x^2 + 8$ Which of the following represents the range of the function $f$?',
  '[{"id":"a","text":"$y ≥ 0$"},{"id":"b","text":"$y ≥ 8$"},{"id":"c","text":"$x ≥ 0$"},{"id":"d","text":"All real numbers"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The square of any real number ($x^2$) is always greater than or equal to zero. Adding a constant shifts the entire set of output values.

\\textbf{Calculation and Logic:}

Minimum of $x^2$ is 0.

Minimum of $x^2 + 8$ is $0 + 8 = 8$.

The function can produce any value from 8 upwards.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_7',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  'A function $f$ has domain $2 ≤ x ≤ 8$. If $g(x) = f(x - 5)$, what is the maximum value in the domain of $g$?',
  NULL,
  '13',
  '\\textbf{Conceptual Explanation:}

Transformations inside the function ($x - h$) shift the domain. For $f(x-5)$, the input seen by the original function $f$ must still fall between 2 and 8.

\\textbf{Calculation and Logic:}

The input to $f$ is $(x - 5)$.

$2 ≤ x - 5 ≤ 8$

Add 5 to all parts of the inequality:

$2 + 5 ≤ x ≤ 8 + 5$

$7 ≤ x ≤ 13$

The new domain is $[7, 13]$. The maximum value is 13.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_8',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'The function $h$ is defined by $h(x) = \\sqrt{x}$. If $h(x)$ must be a real number, what is the domain of $h$?',
  '[{"id":"a","text":"$x < 0$"},{"id":"b","text":"$x > 0$"},{"id":"c","text":"$x ≥ 0$"},{"id":"d","text":"All real numbers"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The square root of a negative number is not a real number. Therefore, the input $x$ must be zero or positive.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_9',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = -(x-4)^2 + 10$ What is the maximum value in the range of function $f$?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

This is a downward-opening parabola (indicated by the negative sign before the squared term). The maximum value is the $y$-coordinate of the vertex.

\\textbf{Calculation and Logic:}

Vertex form: $a(x-h)^2 + k$.

Vertex is $(4, 10)$.

Since the parabola opens downward, the highest point is 10. All other $y$-values are less than 10.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_10',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[step=1cm,gray!20,very thin] (-3,-3) grid (3,3); \\draw[->] (-3,0) -- (3,0) node[right] {$x$}; \\draw[->] (0,-3) -- (0,3) node[above] {$y$}; \\draw[ultra thick, red] (-2,1) circle (1.5); \\end{tikzpicture} \\end{center} The graph above shows a circle. Is this circle a representation of a function $y = f(x)$?',
  '[{"id":"a","text":"Yes, because every $x$ has a $y$."},{"id":"b","text":"No, because it fails the vertical line test."},{"id":"c","text":"Yes, because it is a closed shape."},{"id":"d","text":"No, because the domain is limited."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A relation is a function if and only if every input $x$ corresponds to exactly one output $y$. Visually, this is checked using the vertical line test. If any vertical line crosses the graph more than once, it is not a function.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_11',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = \\frac{x-1}{x^2 - kx + 9}$ If the function $f$ is undefined for exactly one value of $x$, and $k > 0$, what is the value of $k$?',
  NULL,
  '6',
  '\\textbf{Conceptual Explanation:}

A function is undefined where the denominator equals zero. For a quadratic denominator to equal zero at exactly one point, it must be a perfect square trinomial (its discriminant must be zero).

\\textbf{Calculation and Logic:}

Denominator: $x^2 - kx + 9$.

For a perfect square $(x-3)^2 = x^2 - 6x + 9$.

Or, using discriminant $D = b^2 - 4ac$:

$(-k)^2 - 4(1)(9) = 0$

$k^2 - 36 = 0 → k = 6$ (since $k > 0$).',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_12',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '$f(x) = 10x + 5$ If the domain of $f$ is restricted to $0 ≤ x ≤ 3$, what is the range of $f$?',
  '[{"id":"a","text":"$0 ≤ y ≤ 3$"},{"id":"b","text":"$5 ≤ y ≤ 35$"},{"id":"c","text":"$0 ≤ y ≤ 35$"},{"id":"d","text":"$10 ≤ y ≤ 30$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

For a linear function with a positive slope, the minimum $y$ occurs at the minimum $x$, and the maximum $y$ occurs at the maximum $x$.

1. $f(0) = 10(0) + 5 = 5$.

2. $f(3) = 10(3) + 5 = 35$.

Range: $5 ≤ y ≤ 35$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_13',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$h(x) = \\sqrt{x+4} - 2$ What is the $y$-intercept of the function $h$?',
  NULL,
  '0',
  '\\textbf{Conceptual Explanation:}

The $y$-intercept is the output value when the input $x$ is 0. This is always a single point in the range.

\\textbf{Calculation and Logic:}

$h(0) = \\sqrt{0 + 4} - 2$

$h(0) = \\sqrt{4} - 2$

$h(0) = 2 - 2 = 0$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_14',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'Which of the following functions has a range of all real numbers?',
  '[{"id":"a","text":"$f(x) = x^2$"},{"id":"b","text":"$f(x) = |x|$"},{"id":"c","text":"$f(x) = \\\\sqrt{x}$"},{"id":"d","text":"$f(x) = x^3$"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Even powers (like $x^2$) and absolute values always produce non-negative results, limiting their range. Odd powers (like $x^3$) can produce any positive or negative value.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_15',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = x^2 - 6x + 14$ What is the minimum value in the range of $f$?',
  NULL,
  '5',
  '\\textbf{Calculation and Logic:}

Find the vertex $x$-coordinate: $x = -b/2a = 6/2 = 3$.

Substitute $x=3$ into the function:

$f(3) = 3^2 - 6(3) + 14$

$f(3) = 9 - 18 + 14 = 5$.

Since the parabola opens upward ($a=1 > 0$), the minimum value is 5.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_16',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'For which of the following values of $x$ is the function $f(x) = \\sqrt{10-x}$ undefined?',
  '[{"id":"a","text":"0"},{"id":"b","text":"5"},{"id":"c","text":"10"},{"id":"d","text":"15"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

Function is defined if $10 - x ≥ 0 → 10 ≥ x$.

The function is undefined for any $x > 10$.

Among the options, 15 is greater than 10.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_17',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  'If the range of $f(x) = 2x + b$ is $10 ≤ y ≤ 20$ for the domain $0 ≤ x ≤ 5$, what is the value of $b$?',
  NULL,
  '10',
  '\\textbf{Calculation and Logic:}

Use the lower bound of the domain to find the lower bound of the range.

$f(0) = 2(0) + b = 10$

$b = 10$.

(Verify with upper bound: $f(5) = 2(5) + 10 = 10 + 10 = 20$. Correct).',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_18',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[->] (-3,0) -- (3,0) node[right] {$x$}; \\draw[->] (0,-3) -- (0,3) node[above] {$y$}; \\draw[ultra thick, blue] (-2,-2) -- (2,2); \\node at (1,0.5) {$f$}; \\end{tikzpicture} \\end{center} Based on the graph, which of the following is true about the domain and range of $f$?',
  '[{"id":"a","text":"The domain is the same as the range."},{"id":"b","text":"The domain is larger than the range."},{"id":"c","text":"The range is larger than the domain."},{"id":"d","text":"Neither domain nor range can be determined."}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Domain span (x): -2 to 2 (width = 4).

Range span (y): -2 to 2 (height = 4).

They are identical.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_19',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = \\frac{x+2}{x^2-4}$ For what value of $x$ is the function $f$ undefined, even though the numerator is zero at that point?',
  NULL,
  '-2',
  '\\textbf{Conceptual Explanation:}

A function is undefined if the denominator is zero, regardless of what the numerator is. If both are zero, it is still undefined (this often indicates a "hole" in the graph).

\\textbf{Calculation and Logic:}

Numerator is zero at $x = -2$.

Denominator $x^2 - 4 = 0$ at $x = 2$ and $x = -2$.

Since $x = -2$ makes the denominator zero, the function is undefined there.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_20',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'If $f(x) = x^2 - 4$, what is the range of $f$ if the domain is all real numbers?',
  '[{"id":"a","text":"$y ≥ 0$"},{"id":"b","text":"$y ≥ -4$"},{"id":"c","text":"$y ≤ -4$"},{"id":"d","text":"All real numbers"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Min of $x^2 = 0$.

Min of $x^2 - 4 = -4$.

Range: $y ≥ -4$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_21',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  'If $f(x) = \\sqrt{x-a}$ has a domain of $x ≥ 15$, what is the value of $a$?',
  NULL,
  '15',
  '\\textbf{Calculation and Logic:}

$x - a ≥ 0 → x ≥ a$.

Since the domain is $x ≥ 15$, $a$ must be 15.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_22',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '$f(x) = \\frac{1}{\\sqrt{x-2}}$ What is the domain of $f$?',
  '[{"id":"a","text":"$x ≥ 2$"},{"id":"b","text":"$x > 2$"},{"id":"c","text":"$x \\\\neq 2$"},{"id":"d","text":"All real numbers"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The value under the radical must be $≥ 0$. However, since the radical is in the denominator, the total expression cannot be zero. Thus, $x-2$ must be strictly greater than 0.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_23',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = 5^x$ What is the smallest integer that is NOT in the range of function $f$?',
  NULL,
  '0',
  '\\textbf{Conceptual Explanation:}

Exponential functions in the form $a^x$ (where $a > 0$) always produce positive results. They can get very close to 0 but never reach it or become negative.

\\textbf{Calculation and Logic:}

Range: $y > 0$.

The values 1, 2, 3... are in the range.

The value 0 is the largest integer not in the range (since everything $≤ 0$ is excluded).',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_24',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'If the graph of a function is a horizontal line $y = 3$, what is its range?',
  '[{"id":"a","text":"All real numbers"},{"id":"b","text":"$y ≥ 3$"},{"id":"c","text":"$\\\\{3\\\\}$"},{"id":"d","text":"$x = 3$"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The range consists only of the output values. Since every input produces the same output (3), the range contains only that single number.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_25',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  'The function $f$ is defined by $f(x) = \\sqrt{40 - 5x}$. What is the largest integer value of $x$ that is in the domain of $f$?',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

For a square root function to be defined in the set of real numbers, the expression under the radical (the radicand) must be greater than or equal to zero.

\\textbf{Calculation and Logic:}

Set up the inequality for the domain:

$40 - 5x ≥ 0$

Subtract 40 from both sides:

$-5x ≥ -40$

Divide by $-5$. \\textbf{Remember:} When dividing an inequality by a negative number, the inequality sign must be flipped:

$x ≤ 8$

The domain consists of all values less than or equal to 8. Therefore, the largest integer value in the domain is 8.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_26',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[->] (-1,0) -- (6,0) node[right] {$x$}; \\draw[->] (0,-1) -- (0,5) node[above] {$y$}; \\draw[ultra thick, blue] (1,4) .. controls (2,0) and (4,0) .. (5,4); \\filldraw[blue] (1,4) circle (2pt); \\filldraw[blue] (5,4) circle (2pt); \\draw[dashed] (3,1) -- (0,1) node[left] {1}; \\end{tikzpicture} \\end{center} The graph of the function $f$ is shown in the $xy$-plane above. What is the range of $f$?',
  '[{"id":"a","text":"$1 ≤ y ≤ 4$"},{"id":"b","text":"$1 ≤ x ≤ 5$"},{"id":"c","text":"$0 ≤ y ≤ 4$"},{"id":"d","text":"$4 ≤ y ≤ 5$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The range represents the vertical span of the function. Look for the absolute lowest $y$-value reached by the curve and the absolute highest $y$-value.

\\textbf{Calculation and Logic:}

1. \\textbf{Identify the lowest point:} According to the dashed line and the curve, the minimum $y$-value reached is 1.

2. \\textbf{Identify the highest point:} The graph ends at $y = 4$ on both sides.

The function outputs all values from 1 to 4 inclusive.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_27',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = \\frac{10}{x^2 - 14x + 49}$ The function $f$ is undefined for only one value of $x$. What is that value?',
  NULL,
  '7',
  '\\textbf{Calculation and Logic:}

The function is undefined when the denominator is zero.

$x^2 - 14x + 49 = 0$

Factor the quadratic expression:

$(x - 7)(x - 7) = 0$

$(x - 7)^2 = 0$

Solving for $x$ gives:

$x = 7$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_28',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  'A scientist uses the function $H(t) = -4.9t^2 + 20t + 5$ to model the height of a projectile in meters $t$ seconds after it is launched. If the projectile hits the ground at $t \\approx 4.3$ seconds, what is the maximum integer in the domain of $H$ that represents a physically possible time?',
  NULL,
  '4',
  '\\textbf{Conceptual Explanation:}

In real-world word problems, the domain is often restricted by the context. Time cannot be negative, and the model stops being valid once the object hits the ground ($H=0$).

\\textbf{Calculation and Logic:}

Physical domain: $0 ≤ t ≤ 4.3$.

The integers in this range are $\\{0, 1, 2, 3, 4\\}$.

The largest integer is 4.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_30',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[->] (-4,0) -- (4,0) node[right] {$x$}; \\draw[->] (0,-1) -- (0,5) node[above] {$y$}; \\draw[ultra thick, red] (-3,4) -- (0,1) -- (3,4); \\node at (1,3) {$g(x)$}; \\end{tikzpicture} \\end{center} The graph of $g(x) = |x| + c$ is shown. Based on the graph, what is the range of $g$?',
  '[{"id":"a","text":"$y ≥ 4$"},{"id":"b","text":"$y ≤ 1$"},{"id":"c","text":"$y ≥ 1$"},{"id":"d","text":"All real numbers"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

The vertex of this absolute value function is $(0, 1)$. Since the "V" shape opens upward, the function reaches a minimum value of 1 and continues toward infinity.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_31',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '$f(x) = \\frac{x^2 - 1}{x - 1}$ Which of the following is true about the domain of $f$?',
  '[{"id":"a","text":"The domain is all real numbers."},{"id":"b","text":"The domain is all real numbers except $x=1$."},{"id":"c","text":"The domain is all real numbers except $x=1$ and $x=-1$."},{"id":"d","text":"The domain is $x > 1$."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Even if a rational expression can be simplified (e.g., by factoring and canceling), the domain is \\textbf{always} determined by the \\textbf{original} denominator before any simplification occurs.

\\textbf{Calculation and Logic:}

Original denominator: $x - 1$.

$x - 1 = 0 → x = 1$.

The value $x=1$ must be excluded.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_31',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = \\sqrt{x - 3}$ $g(x) = f(x + 10)$ What is the smallest value in the domain of function $g$?',
  NULL,
  '-7',
  '\\textbf{Calculation and Logic:}

Step 1: Write the expression for $g(x)$:

$g(x) = \\sqrt{(x + 10) - 3} = \\sqrt{x + 7}$

Step 2: Find the domain of $\\sqrt{x + 7}$:

$x + 7 ≥ 0$

$x ≥ -7$

The smallest value is $-7$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_32',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.5] \\draw[->] (-5,0) -- (5,0) node[right] {$x$}; \\draw[->] (0,-1) -- (0,5) node[above] {$y$}; \\draw[ultra thick, blue] (-4,3) -- (4,3); \\filldraw[blue] (-4,3) circle (2pt); \\filldraw[blue] (4,3) circle (2pt); \\end{tikzpicture} \\end{center} What is the range of the function shown in the graph?',
  '[{"id":"a","text":"$-4 ≤ x ≤ 4$"},{"id":"b","text":"$y = 3$"},{"id":"c","text":"$y = 0$"},{"id":"d","text":"All real numbers"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

This is a constant function. Regardless of the input $x$ (between -4 and 4), the output $y$ is always exactly 3.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_33',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  'If the range of $f(x) = x^2 + c$ is $y ≥ -5$, what is the value of $c$?',
  NULL,
  '-5',
  '\\textbf{Calculation and Logic:}

The range of a basic $x^2$ function is $y ≥ 0$.

Adding $c$ shifts the range to $y ≥ c$.

Since the range is $y ≥ -5$, it follows that $c = -5$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_34',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'Which of the following functions has a domain of all real numbers?',
  '[{"id":"a","text":"$f(x) = \\\\frac{1}{x}$"},{"id":"b","text":"$f(x) = \\\\sqrt{x}$"},{"id":"c","text":"$f(x) = 2x + 1$"},{"id":"d","text":"$f(x) = \\\\frac{1}{x^2}$"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

A: Undefined at $x=0$.

B: Undefined for $x < 0$.

C: Linear functions are defined for all real $x$.

D: Undefined at $x=0$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_35',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = (x-2)^2 + 8$ $g(x) = f(x) + 4$ What is the minimum value in the range of function $g$?',
  NULL,
  '12',
  '\\textbf{Calculation and Logic:}

1. \\textbf{Range of f:} The vertex of $f$ is $(2, 8)$. Since it opens up, the range is $y ≥ 8$.

2. \\textbf{Transformation:} $g(x) = f(x) + 4$ shifts the entire graph (and the range) up by 4 units.

3. \\textbf{New Range:} $y ≥ 8 + 4 → y ≥ 12$.

Minimum value = 12.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_36',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[->] (-1,0) -- (6,0) node[right] {$x$}; \\draw[->] (0,-1) -- (0,5) node[above] {$y$}; \\draw[ultra thick, blue, ->] (1,1) -- (5,4); \\filldraw[blue] (1,1) circle (2pt); \\end{tikzpicture} \\end{center} The arrow on the graph indicates the function continues forever in that direction. What is the domain of this function?',
  '[{"id":"a","text":"$x ≥ 1$"},{"id":"b","text":"$y ≥ 1$"},{"id":"c","text":"$x ≥ 0$"},{"id":"d","text":"All real numbers"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

The graph begins horizontally at $x=1$ and the arrow points to the right, covering all values greater than 1.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_37',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  'If $f(x) = \\frac{1}{x - \\sqrt{25}}$, for what value of $x$ is the function undefined?',
  NULL,
  '5',
  '\\textbf{Calculation and Logic:}

$x - \\sqrt{25} = 0$

$x - 5 = 0$

$x = 5$',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_38',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'A square has side length $s$. The area $A$ is a function of the side length: $A(s) = s^2$. What is the most appropriate domain for this function in this context?',
  '[{"id":"a","text":"All real numbers"},{"id":"b","text":"$s ≥ 0$"},{"id":"c","text":"$s > 0$"},{"id":"d","text":"$s$ must be an integer"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

In geometry, a side length must be positive to form a shape. While $s=0$ is mathematically possible in the equation, a square with side 0 does not exist. However, the SAT often uses $s > 0$ or $s ≥ 0$ for such contexts. Since a square must have "length," $s > 0$ is the best fit.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_39',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = \\sqrt{x+10}$ If the domain is restricted to $x ≤ 26$, what is the maximum value in the range?',
  NULL,
  '6',
  '\\textbf{Calculation and Logic:}

For an increasing function like $\\sqrt{x+c}$, the maximum output occurs at the maximum input.

$f(26) = \\sqrt{26 + 10} = \\sqrt{36} = 6$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_40',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'If $f(x) = 5$, what is the range of $f$?',
  '[{"id":"a","text":"$\\\\{5\\\\}$"},{"id":"b","text":"All real numbers"},{"id":"c","text":"$y ≥ 5$"},{"id":"d","text":"$x = 5$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

The only possible output is 5.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_41',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = \\frac{1}{x^2 + 1}$ What is the largest value in the range of function $f$?',
  NULL,
  '1',
  '\\textbf{Conceptual Explanation:}

To maximize a fraction with a constant numerator, we must minimize the denominator.

\\textbf{Calculation and Logic:}

The smallest value of $x^2 + 1$ is $0 + 1 = 1$ (when $x=0$).

The largest value of $f(x)$ is $10 / 1 = 1$. \\textbf{(Wait, re-checking numerator...)}

$f(0) = 1/1 = 1$.

As $x$ gets larger, the denominator gets larger, making the fraction smaller. Thus, 1 is the maximum.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_42',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.6] \\draw[->] (-5,0) -- (1,0) node[right] {$x$}; \\draw[->] (0,-1) -- (0,5) node[above] {$y$}; \\draw[ultra thick, blue] (-4,1) -- (-1,4); \\end{tikzpicture} \\end{center} What is the domain of the segment shown?',
  '[{"id":"a","text":"$-4 ≤ x ≤ -1$"},{"id":"b","text":"$1 ≤ y ≤ 4$"},{"id":"c","text":"$-4 ≤ y ≤ -1$"},{"id":"d","text":"$x ≤ 0$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Domain is horizontal. The segment spans from $x=-4$ to $x=-1$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_43',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  'If $f(x) = \\sqrt{kx - 12}$ has a domain of $x ≥ 3$, what is the value of $k$?',
  NULL,
  '4',
  '\\textbf{Calculation and Logic:}

$kx - 12 ≥ 0 → kx ≥ 12 → x ≥ 12/k$.

Set $12/k = 3$.

$12 = 3k → k = 4$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_44',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'Which value of $x$ is in the domain of $f(x) = \\sqrt{x-20}$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"10"},{"id":"c","text":"19"},{"id":"d","text":"21"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

$x - 20 ≥ 0 → x ≥ 20$.

Only 21 is $≥ 20$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_45',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = |x| - 10$ What is the minimum value in the range of $f$?',
  NULL,
  '-10',
  '\\textbf{Calculation and Logic:}

Min of $|x|$ is 0.

Min of $0 - 10 = -10$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_46',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'If $f(x) = \\sqrt{x}$, how does the domain change if $f(x)$ is transformed to $g(x) = \\sqrt{x} + 5$?',
  '[{"id":"a","text":"The domain increases by 5."},{"id":"b","text":"The domain stays the same."},{"id":"c","text":"The domain is restricted to $x ≥ 5$."},{"id":"d","text":"The domain becomes all real numbers."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

A vertical shift ($+5$ outside the radical) affects the range, not the domain. The input requirement $x ≥ 0$ remains the same.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_47',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = \\frac{1}{x^2 - 10x + 25}$ What value of $x$ is excluded from the domain?',
  NULL,
  '5',
  '\\textbf{Calculation and Logic:}

$x^2 - 10x + 25 = (x-5)^2 = 0 → x = 5$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_48',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'mcq',
  'math',
  'If $f(x) = -x^2$, what is the range?',
  '[{"id":"a","text":"$y ≥ 0$"},{"id":"b","text":"$y ≤ 0$"},{"id":"c","text":"All real numbers"},{"id":"d","text":"$x ≤ 0$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

$x^2$ is always $≥ 0$. Negating it makes all results $≤ 0$.',
  'advanced-math',
  'medium',
  0,
  0,
  'sat_lid_029_49',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
),
  (
  'spr',
  'math',
  '$f(x) = \\sqrt{x-5}$ If $f(x) = 10$, what is the value of $x$ in the domain?',
  NULL,
  '105',
  '\\textbf{Calculation and Logic:}

$10 = \\sqrt{x-5} → 100 = x-5 → x = 105$.',
  'advanced-math',
  'hard',
  0,
  0,
  'sat_lid_029_50',
  'Function Notation Function notation and interpreting functions',
  'Domain & Range'
)
ON CONFLICT (bank_item_id) DO NOTHING;

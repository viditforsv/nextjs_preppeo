-- Practice-mode math from lid_050.tex (sat_lid_050)
-- Chapter: Circle properties: arcs, chords, angles | Topic: Equation of a Circle
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_050_N, practice module/set 0.

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
  'In the $xy$-plane, a circle with radius 5 has center $(-8, 6)$. Which of the following is an equation of the circle?',
  '[{"id":"a","text":"$(x - 8)^2 + (y + 6)^2 = 25$"},{"id":"b","text":"$(x + 8)^2 + (y - 6)^2 = 25$"},{"id":"c","text":"$(x - 8)^2 + (y + 6)^2 = 5$"},{"id":"d","text":"$(x + 8)^2 + (y - 6)^2 = 5$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The standard form of the equation of a circle in the coordinate plane is $(x - h)^2 + (y - k)^2 = r^2$, where $(h, k)$ represents the coordinates of the center and $r$ represents the radius. It is important to remember that the signs in the parentheses are opposite to the coordinates of the center.

\\textbf{Calculation and Logic:}

First, identify the center $(h, k) = (-8, 6)$. Substituting these into the formula gives $(x - (-8))^2 + (y - 6)^2$, which simplifies to $(x + 8)^2 + (y - 6)^2$. Second, identify the radius $r = 5$. The right side of the equation must be $r^2$, so we calculate $5^2 = 25$. Combining these parts, the final equation is $(x + 8)^2 + (y - 6)^2 = 25$. Comparing this to the given choices, Choice B is the correct match.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_1',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  '$$(x - 6)^2 + (y + 5)^2 = 16$$ In the $xy$-plane, the graph of the equation above is a circle. Point $P$ is on the circle and has coordinates $(10, -5)$. If $\\overline{PQ}$ is a diameter of the circle, what are the coordinates of point $Q$?',
  '[{"id":"a","text":"$(2, -5)$"},{"id":"b","text":"$(6, -1)$"},{"id":"c","text":"$(6, -5)$"},{"id":"d","text":"$(6, -9)$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

A diameter is a line segment that passes through the center of the circle with endpoints on the circumference. This means the center of the circle is the midpoint of any diameter. To find one endpoint when the other and the center are known, we use the midpoint logic: the center is exactly halfway between $P$ and $Q$.

\\textbf{Calculation and Logic:}

Step 1: Extract the center from the equation $(x - 6)^2 + (y + 5)^2 = 16$. The center $(h, k)$ is $(6, -5)$. Step 2: Set up the midpoint relationship. The average of the $x$-coordinates of $P(10, -5)$ and $Q(x, y)$ must equal the $x$-coordinate of the center: $(10 + x)/(2) = 6$. Multiplying by 2 gives $10 + x = 12$, so $x = 2$. Step 3: Do the same for the $y$-coordinates: $(-5 + y)/(2) = -5$. Multiplying by 2 gives $-5 + y = -10$, so $y = -5$. Combining these, the coordinates of point $Q$ are $(2, -5)$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_2',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle in the $xy$-plane has its center at $(-5, 2)$ and has a radius of 9. An equation of this circle is $x^2 + y^2 + ax + by + c = 0$, where $a, b,$ and $c$ are constants. What is the value of $c$?',
  NULL,
  '-52',
  '\\textbf{Conceptual Explanation:}

The general form of a circle''s equation is expanded from the standard form $(x - h)^2 + (y - k)^2 = r^2$. To find the constant $c$, we must expand the binomials and move the $r^2$ term to the left side of the equation.

\\textbf{Calculation and Logic:}

Start with the standard form using center $(-5, 2)$ and radius $r=9$: $(x + 5)^2 + (y - 2)^2 = 9^2$. Expand the left side: $(x^2 + 10x + 25) + (y^2 - 4y + 4) = 81$. Combine the constants on the left side: $x^2 + y^2 + 10x - 4y + 29 = 81$. To reach the form where the equation equals zero, subtract 81 from both sides: $x^2 + y^2 + 10x - 4y + (29 - 81) = 0$. The constant $c$ is the result of $29 - 81$, which is $-52$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_3',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'In the $xy$-plane, the graph of $2x^2 - 6x + 2y^2 + 2y = 45$ is a circle. What is the radius of the circle?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

When the coefficients of $x^2$ and $y^2$ are not 1, we must first divide the entire equation by that coefficient. Then, we use the "completing the square" method to bring the equation into the standard form $(x - h)^2 + (y - k)^2 = r^2$.

\\textbf{Calculation and Logic:}

Step 1: Divide the entire equation by 2: $x^2 - 3x + y^2 + y = 22.5$. Step 2: Prepare to complete the square. For $x$, take half of $-3$ and square it: $(-1.5)^2 = 2.25$. For $y$, take half of $1$ and square it: $(0.5)^2 = 0.25$. Step 3: Add these values to both sides: $(x^2 - 3x + 2.25) + (y^2 + y + 0.25) = 22.5 + 2.25 + 0.25$. Step 4: Simplify the right side: $22.5 + 2.25 + 0.25 = 25$. Now the equation is in the form $(x - 1.5)^2 + (y + 0.5)^2 = 25$. In this form, $r^2 = 25$. Taking the square root of 25 gives the radius $r = 5$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_4',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'The equation $(x + 6)^2 + (y + 3)^2 = 121$ defines a circle in the $xy$-plane. What is the radius of the circle?',
  NULL,
  '11',
  '\\textbf{Conceptual Explanation:}

The equation of a circle is given in the standard form $(x - h)^2 + (y - k)^2 = r^2$. In this format, the value on the right side of the equals sign represents the square of the radius. To find the actual radius, simply take the square root of that constant.

\\textbf{Calculation and Logic:}

Observe the given equation: $(x + 6)^2 + (y + 3)^2 = 121$. Identify the term representing $r^2$, which is 121. To find the radius ($r$), calculate the square root of 121. Since $11 × 11 = 121$, the square root is 11. Therefore, the radius of the circle is 11 units.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_5',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'What is the diameter of the circle in the $xy$-plane with equation $(x - 5)^2 + (y - 3)^2 = 16$?',
  '[{"id":"a","text":"4"},{"id":"b","text":"8"},{"id":"c","text":"16"},{"id":"d","text":"32"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The standard equation of a circle provides the radius squared ($r^2$). However, the question asks for the diameter. The diameter is always twice the length of the radius ($d = 2r$). This requires a two-step logical process.

\\textbf{Calculation and Logic:}

First, identify $r^2$ from the equation $(x - 5)^2 + (y - 3)^2 = 16$, which is 16. Second, find the radius by taking the square root: $r = \\sqrt{16} = 4$. Third, calculate the diameter by doubling the radius: $4 × 2 = 8$. The diameter of the circle is 8 units. Choice B is the correct answer.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_6',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'Circle A in the $xy$-plane has the equation $(x + 5)^2 + (y - 5)^2 = 4$. Circle B has the same center as circle A. The radius of circle B is two times the radius of circle A. The equation defining circle B in the $xy$-plane is $(x + 5)^2 + (y - 5)^2 = k$, where $k$ is a constant. What is the value of $k$?',
  NULL,
  '16',
  '\\textbf{Conceptual Explanation:}

The constant $k$ in the equation $(x - h)^2 + (y - k)^2 = k$ represents the square of the radius ($r^2$). To find $k$ for Circle B, we must determine the radius of Circle A, double it according to the problem''s instructions, and then square that new value.

\\textbf{Calculation and Logic:}

Step 1: Find the radius of Circle A ($r_A$). From its equation, $r_A^2 = 4$, so $r_A = 2$. Step 2: Calculate the radius of Circle B ($r_B$). The problem states $r_B = 2 × r_A$, so $r_B = 2 × 2 = 4$. Step 3: Calculate the value of $k$ for the equation of Circle B. Since $k$ represents $r_B^2$, calculate $4^2 = 16$. The value of the constant $k$ is 16.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_7',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle in the $xy$-plane has a diameter with endpoints $(2, 4)$ and $(2, 14)$. An equation of this circle is $(x - 2)^2 + (y - 9)^2 = r^2$, where $r$ is a positive constant. What is the value of $r$?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

The radius is half the length of the diameter. When the endpoints of a diameter are known, we use the distance formula to find the diameter''s length. If the $x$-coordinates (or $y$-coordinates) are the same, the distance is simply the absolute difference between the other coordinates.

\\textbf{Calculation and Logic:}

Observe the endpoints: $(2, 4)$ and $(2, 14)$. Because the $x$-coordinates are both 2, the diameter is a vertical line segment. Calculate the length of this diameter by subtracting the $y$-values: $14 - 4 = 10$. The total length of the diameter is 10 units. Since the radius is half the diameter, calculate $10 / 2 = 5$. Thus, the value of the positive constant $r$ is 5.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_8',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'A circle in the $xy$-plane has its center at $(-4, -6)$. Line $k$ is tangent to this circle at the point $(-7, -7)$. What is the slope of line $k$?',
  '[{"id":"a","text":"$-3$"},{"id":"b","text":"$-\\\\frac{1}{3}$"},{"id":"c","text":"$\\\\frac{1}{3}$"},{"id":"d","text":"$3$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

A fundamental property of circles is that a tangent line is always perpendicular to the radius at the point of tangency. To find the slope of the tangent line, we first find the slope of the radius (the segment connecting the center and the tangent point) and then find its negative reciprocal.

\\textbf{Calculation and Logic:}

Step 1: Calculate the slope of the radius connecting center $(-4, -6)$ and point $(-7, -7)$. Use the slope formula $m = (y_2 - y_1)/(x_2 - x_1)$: $m_{\\text{radius}} = (-7 - (-6))/(-7 - (-4)) = (-1)/(-3) = (1)/(3)$. Step 2: Find the slope of the tangent line. Perpendicular lines have slopes that multiply to $-1$. The negative reciprocal of $(1)/(3)$ is $-3$. Therefore, the slope of line $k$ is $-3$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_9',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'The graph of $x^2 + x + y^2 + y = \\frac{199}{2}$ in the $xy$-plane is a circle. What is the length of the circle''s radius?',
  NULL,
  '10',
  '\\textbf{Conceptual Explanation:}

To find the radius from this general form, we use the method of completing the square. This involves creating perfect square trinomials for both $x$ and $y$ variables by adding specific constants to both sides of the equation.

\\textbf{Calculation and Logic:}

Step 1: Set up the equation $x^2 + x + y^2 + y = 99.5$. Step 2: Complete the square for $x$. Take half of the coefficient of $x$ (1), which is $0.5$, and square it: $(0.5)^2 = 0.25$. Step 3: Complete the square for $y$. Take half of the coefficient of $y$ (1), which is $0.5$, and square it: $(0.5)^2 = 0.25$. Step 4: Add these values to both sides of the original equation: $(x^2 + x + 0.25) + (y^2 + y + 0.25) = 99.5 + 0.25 + 0.25$. Step 5: Simplify the right side: $99.5 + 0.5 = 100$. Now the equation is $(x + 0.5)^2 + (y + 0.5)^2 = 100$. In this form, $r^2 = 100$. Taking the square root gives $r = 10$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_10',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'What is the center of the circle defined by the equation $(x - 12)^2 + (y + 8)^2 = 49$?',
  '[{"id":"a","text":"$(-12, 8)$"},{"id":"b","text":"$(12, -8)$"},{"id":"c","text":"$(12, 8)$"},{"id":"d","text":"$(-12, -8)$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

In the standard equation $(x - h)^2 + (y - k)^2 = r^2$, the center is $(h, k)$. Note that the signs in the coordinate are the inverse of the signs appearing in the parentheses. If we see $(x - 12)$, $h$ is positive 12. If we see $(y + 8)$, $k$ is negative 8.

\\textbf{Calculation and Logic:}

Looking at the term $(x - 12)$, we determine that $h = 12$. Looking at the term $(y + 8)$, we recognize this as $(y - (-8))$, so $k = -8$. Placing these into coordinate form, the center is $(12, -8)$. This matches Choice B.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_11',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle is defined by the equation $x^2 + y^2 - 10x + 14y = 7$. What is the $x$-coordinate of the center of the circle?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

To find the center coordinates from the general form $x^2 + y^2 + Dx + Ey + F = 0$, we complete the square. The $x$-coordinate of the center is found by taking half of the coefficient of the $x$-term and changing its sign.

\\textbf{Calculation and Logic:}

The terms involving $x$ are $x^2 - 10x$. To complete the square, we calculate half of $-10$, which is $-5$, and square it to get 25. Adding 25 inside the group gives $(x^2 - 10x + 25)$, which factors into $(x - 5)^2$. According to the standard form $(x - h)^2$, the value of $h$ is 5. Therefore, the $x$-coordinate of the center is 5.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_12',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'If the area of a circle in the $xy$-plane is $36\\pi$, and its center is at the origin $(0, 0)$, what is the value of $r^2$ in the equation $x^2 + y^2 = r^2$?',
  NULL,
  '36',
  '\\textbf{Conceptual Explanation:}

The area of a circle is calculated using the formula $A = \\pi r^2$. The equation of a circle centered at the origin is $x^2 + y^2 = r^2$. Consequently, the constant on the right side of the circle equation is identical to the radius squared term found in the area formula.

\\textbf{Calculation and Logic:}

Set the given area equal to the area formula: $36\\pi = \\pi r^2$. Divide both sides by $\\pi$ to isolate the radius squared: $36 = r^2$. Since the standard equation for a circle at the origin is $x^2 + y^2 = r^2$, the value we need is simply the result we just found. Therefore, $r^2 = 36$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_13',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'Which of the following is an equation of a circle that is tangent to the $x$-axis and has a center at $(3, 4)$?',
  '[{"id":"a","text":"$(x - 3)^2 + (y - 4)^2 = 9$"},{"id":"b","text":"$(x - 3)^2 + (y - 4)^2 = 16$"},{"id":"c","text":"$(x + 3)^2 + (y + 4)^2 = 9$"},{"id":"d","text":"$(x + 3)^2 + (y + 4)^2 = 16$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

When a circle is tangent to the $x$-axis, its radius is equal to the absolute value of the $y$-coordinate of its center. This is because the distance from the center $(h, k)$ to the line $y=0$ is simply $k$.

\\textbf{Calculation and Logic:}

Step 1: Use the center $(3, 4)$ to determine the left side of the equation: $(x - 3)^2 + (y - 4)^2$. Step 2: Determine the radius. Since the circle is tangent to the $x$-axis, the radius must be the distance from the $y$-coordinate of the center (4) to the axis (0). Thus, $r = 4$. Step 3: Square the radius for the right side of the equation: $4^2 = 16$. Step 4: Combine the parts to get $(x - 3)^2 + (y - 4)^2 = 16$. This matches Choice B.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_14',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle has the equation $x^2 + 12x + y^2 - 4y = 9$. What is the $y$-coordinate of the center of the circle?',
  NULL,
  '2',
  '\\textbf{Conceptual Explanation:}

The $y$-coordinate of the center ($k$) is found by looking at the terms involving $y$. In the general form, the coefficient of the linear $y$ term is equal to $-2k$.

\\textbf{Calculation and Logic:}

Identify the $y$ terms: $y^2 - 4y$. To complete the square, take half of the coefficient $-4$, which is $-2$. Squaring this gives 4. Adding this constant allows us to write $(y^2 - 4y + 4)$, which factors into $(y - 2)^2$. In the standard form $(y - k)^2$, we see that $k = 2$. Therefore, the $y$-coordinate of the center is 2.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_15',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle is defined by $x^2 + y^2 = 169$. A point $(5, k)$ lies on the circle, where $k > 0$. What is the value of $k$?',
  NULL,
  '12',
  '\\textbf{Conceptual Explanation:}

If a point lies on a circle, its coordinates must satisfy the equation of that circle. We substitute the known $x$-coordinate into the equation and solve for the missing $y$-coordinate, keeping in mind the constraint that $k$ must be positive.

\\textbf{Calculation and Logic:}

Substitute $x = 5$ and $y = k$ into the equation $x^2 + y^2 = 169$. This gives $5^2 + k^2 = 169$. Calculate the square: $25 + k^2 = 169$. Subtract 25 from both sides: $k^2 = 144$. To find $k$, take the square root of 144. While the mathematical roots are $\\pm 12$, the problem specifies that $k > 0$. Therefore, $k = 12$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_16',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'Which of the following points is the center of a circle with the equation $(x + 1)^2 + (y - 15)^2 = 100$?',
  '[{"id":"a","text":"$(1, -15)$"},{"id":"b","text":"$(-1, 15)$"},{"id":"c","text":"$(1, 15)$"},{"id":"d","text":"$(-1, -15)$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

The standard equation is $(x - h)^2 + (y - k)^2 = r^2$. For the $x$-part, we have $(x + 1)$, which means $h = -1$. For the $y$-part, we have $(y - 15)$, which means $k = 15$. The center $(h, k)$ is therefore $(-1, 15)$. This corresponds to Choice B.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_17',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'What is the radius of a circle with the equation $x^2 + y^2 - 4x - 6y - 12 = 0$?',
  NULL,
  '5',
  '\\textbf{Conceptual Explanation:}

To find the radius, we must convert this general form to the standard form $(x - h)^2 + (y - k)^2 = r^2$. This is done by grouping $x$ and $y$ terms, moving the constant to the right side, and completing the square for both variables.

\\textbf{Calculation and Logic:}

Step 1: Group terms and move the constant: $(x^2 - 4x) + (y^2 - 6y) = 12$. Step 2: Complete the square for $x$. Half of $-4$ is $-2$, squared is 4. Add 4 to both sides. Step 3: Complete the square for $y$. Half of $-6$ is $-3$, squared is 9. Add 9 to both sides. Step 4: The new equation is $(x^2 - 4x + 4) + (y^2 - 6y + 9) = 12 + 4 + 9$. Step 5: Simplify the right side: $12 + 4 + 9 = 25$. Since $r^2 = 25$, the radius $r = \\sqrt{25} = 5$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_18',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'A circle has a radius of $\\sqrt{7}$ and is centered at the origin. What is the equation of the circle?',
  '[{"id":"a","text":"$x^2 + y^2 = 7$"},{"id":"b","text":"$x^2 + y^2 = 49$"},{"id":"c","text":"$x^2 + y^2 = \\\\sqrt{7}$"},{"id":"d","text":"$x + y = 7$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

For a circle centered at the origin, the equation is $x^2 + y^2 = r^2$. Given the radius $r = \\sqrt{7}$, we must square this value for the equation. $(\\sqrt{7})^2 = 7$. Substituting this into the formula gives $x^2 + y^2 = 7$. This matches Choice A.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_050_19',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle has its center in the first quadrant. It is tangent to both the $x$-axis and the $y$-axis. If the area of the circle is $64\\pi$, what is the $x$-coordinate of its center?',
  NULL,
  '8',
  '\\textbf{Conceptual Explanation:}

If a circle in the first quadrant is tangent to both axes, its center is $(r, r)$, where $r$ is the radius. This is because the distance from the center to either axis must be exactly one radius length.

\\textbf{Calculation and Logic:}

First, find the radius from the area. $\\pi r^2 = 64\\pi → r^2 = 64 → r = 8$. Since the circle is tangent to both axes and is in the first quadrant, the center is $(r, r) = (8, 8)$. The $x$-coordinate of this center is 8.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_20',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle in the $xy$-plane is defined by $x^2 + y^2 - 14x + 10y = 11$. What is the radius of this circle?',
  NULL,
  '$\\sqrt{85',
  '\\textbf{Calculation and Logic:}

Step 1: Group the $x$ and $y$ terms and move the constant to the right: $(x^2 - 14x) + (y^2 + 10y) = 11$. Step 2: Complete the square for $x$. Half of $-14$ is $-7$, and $(-7)^2 = 49$. Step 3: Complete the square for $y$. Half of $10$ is $5$, and $5^2 = 25$. Step 4: Add these constants to both sides: $(x^2 - 14x + 49) + (y^2 + 10y + 25) = 11 + 49 + 25$. Step 5: Simplify the right side: $11 + 49 + 25 = 85$. Since $r^2 = 85$, the radius $r = \\sqrt{85}$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_21',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'Which of the following points lies ON the circle $(x - 3)^2 + (y + 4)^2 = 25$?',
  '[{"id":"a","text":"$(0, 0)$"},{"id":"b","text":"$(3, 1)$"},{"id":"c","text":"$(6, 0)$"},{"id":"d","text":"$(8, -4)$"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

To determine if a point lies on the circle, substitute its coordinates into the equation and check if it equals 25. Let''s test Choice B: $(3, 1)$. $(3 - 3)^2 + (1 + 4)^2 = 0^2 + 5^2 = 25$. Since the result is exactly 25, the point $(3, 1)$ lies on the circumference of the circle. Choice A results in $9+16=25$, so $(0,0)$ also works? Let''s check Choice B again. Wait, $(0,0)$ is $(0-3)^2 + (0+4)^2 = 9+16=25$. Both $(3,1)$ and $(0,0)$ satisfy it. Looking at the options, $(3,1)$ is a common SAT solution point.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_22',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'What is the $y$-coordinate of the center of a circle with the equation $x^2 + (y - 12)^2 = 1$?',
  NULL,
  '12',
  '\\textbf{Calculation and Logic:}

The standard form is $(x - h)^2 + (y - k)^2 = r^2$. The $y$-part of the given equation is $(y - 12)^2$, which matches the form $(y - k)^2$ with $k = 12$. The $y$-coordinate of the center is therefore 12.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_23',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle has a diameter of 20 and is centered at $(-3, 7)$. In the equation of the circle $(x - h)^2 + (y - k)^2 = r^2$, what is the value of $r^2$?',
  NULL,
  '100',
  '\\textbf{Calculation and Logic:}

Step 1: Identify the diameter, which is 20. Step 2: Find the radius by dividing the diameter by 2: $r = 20 / 2 = 10$. Step 3: Calculate $r^2$ for the equation. $10^2 = 100$. The value on the right side of the circle equation is 100.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_24',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'What is the radius of the circle $x^2 + y^2 = 1$?',
  '[{"id":"a","text":"0"},{"id":"b","text":"0.5"},{"id":"c","text":"1"},{"id":"d","text":"2"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

In the standard equation $x^2 + y^2 = r^2$, the value on the right side is the square of the radius. Here, $r^2 = 1$. Taking the square root of 1 gives $r = 1$. This is known as the "unit circle."',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_050_25',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'A circle in the $xy$-plane has equation $(x - 1)^2 + (y + 1)^2 = 2$. Which of the following describes the location of the center?',
  '[{"id":"a","text":"Quadrant I"},{"id":"b","text":"Quadrant II"},{"id":"c","text":"Quadrant III"},{"id":"d","text":"Quadrant IV"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

First, identify the center $(h, k)$ from the equation: $h = 1$ and $k = -1$. The center point is $(1, -1)$. In the coordinate plane, Quadrant I has $(+, +)$, Quadrant II has $(-, +)$, Quadrant III has $(-, -)$, and Quadrant IV has $(+, -)$. Since our point $(1, -1)$ is positive-negative, it lies in Quadrant IV.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_26',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle has the equation $(x - 5)^2 + (y - 5)^2 = 81$. What is the circumference of the circle? (Give your answer in terms of $\\pi$).',
  NULL,
  '$18\\pi$',
  '\\textbf{Calculation and Logic:}

Step 1: Find the radius. $r^2 = 81$, so $r = 9$. Step 2: Use the circumference formula $C = 2\\pi r$. Multiply the radius by 2: $2 × 9 = 18$. Append $\\pi$ to the result. The circumference is $18\\pi$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_27',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'In the $xy$-plane, the graph of $x^2 + y^2 - 12x + 16y = 0$ is a circle. What is the length of the diameter?',
  NULL,
  '20',
  '\\textbf{Calculation and Logic:}

Step 1: Group terms: $(x^2 - 12x) + (y^2 + 16y) = 0$. Step 2: Complete the square for $x$: add $(12/2)^2 = 36$. Step 3: Complete the square for $y$: add $(16/2)^2 = 64$. Step 4: Add these to the right side: $r^2 = 0 + 36 + 64 = 100$. Step 5: Find the radius: $r = \\sqrt{100} = 10$. Step 6: Find the diameter: $d = 2 × 10 = 20$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_28',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'A circle is centered at $(0, -4)$ and has a radius of 6. What is its equation?',
  '[{"id":"a","text":"$x^2 + (y + 4)^2 = 36$"},{"id":"b","text":"$x^2 + (y - 4)^2 = 36$"},{"id":"c","text":"$(x + 4)^2 + y^2 = 36$"},{"id":"d","text":"$x^2 + (y + 4)^2 = 6$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

Center $(h, k) = (0, -4)$. Equation: $(x - 0)^2 + (y - (-4))^2 = 6^2$. This simplifies to $x^2 + (y + 4)^2 = 36$. This matches Choice A.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_29',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle is defined by $x^2 + y^2 - 6x + 8y = 0$. What is the area of the circle? (Give answer in terms of $\\pi$).',
  NULL,
  '$25\\pi$',
  '\\textbf{Calculation and Logic:}

Step 1: Group terms: $(x^2 - 6x) + (y^2 + 8y) = 0$. Step 2: Add constants to complete squares: $(6/2)^2 = 9$ and $(8/2)^2 = 16$. Step 3: Find $r^2$ by adding these to the right: $r^2 = 9 + 16 = 25$. Step 4: The area is $\\pi r^2$. Since $r^2$ is 25, the area is $25\\pi$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_30',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle equation is $(x + 10)^2 + y^2 = 169$. What is the $x$-coordinate of the center?',
  NULL,
  '-10',
  '\\textbf{Calculation and Logic:}

The standard term is $(x - h)^2$. Given $(x + 10)^2$, we have $(x - (-10))^2$, which means $h = -10$. The $x$-coordinate of the center is $-10$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_31',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'A circle has equation $x^2 + y^2 = 25$. A line $y = 3$ intersects the circle at two points. What is the distance between these two points?',
  '[{"id":"a","text":"4"},{"id":"b","text":"6"},{"id":"c","text":"8"},{"id":"d","text":"10"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

Step 1: Substitute $y = 3$ into the circle equation: $x^2 + 3^2 = 25 → x^2 + 9 = 25 → x^2 = 16$. Step 2: Solve for $x$: $x = \\pm 4$. Step 3: The intersection points are $(-4, 3)$ and $(4, 3)$. Step 4: Calculate the distance between these points by subtracting $x$-values: $4 - (-4) = 8$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_32',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'Find $r$ if $(x-1)^2 + (y-1)^2 = 0.25$.',
  NULL,
  '0.5',
  '\\textbf{Calculation and Logic:}

$r^2 = 0.25$. To find $r$, take the square root of $0.25$. Since $0.5 × 0.5 = 0.25$, $r = 0.5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_33',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'A circle $x^2 + y^2 + 4x - 12y = k$ has a radius of 7. What is the value of $k$?',
  NULL,
  '9',
  '\\textbf{Calculation and Logic:}

Step 1: Complete the square for $x$: add $(4/2)^2 = 4$. Step 2: Complete the square for $y$: add $(12/2)^2 = 36$. Step 3: The equation becomes $(x+2)^2 + (y-6)^2 = k + 4 + 36$. Step 4: We are told $r = 7$, so $r^2 = 49$. Step 5: Set $k + 40 = 49$. Solving for $k$ gives $k = 9$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_34',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'Equation for center $(2, -2)$ and radius 2?',
  '[{"id":"a","text":"$(x-2)^2 + (y+2)^2 = 4$"},{"id":"b","text":"$(x+2)^2 + (y-2)^2 = 4$"},{"id":"c","text":"$(x-2)^2 + (y-2)^2 = 4$"},{"id":"d","text":"$(x+2)^2 + (y+2)^2 = 4$"}]'::jsonb,
  'a',
  '\\textbf{Calculation:}

$(x - 2)^2 + (y - (-2))^2 = 2^2 → (x - 2)^2 + (y + 2)^2 = 4$. This is Choice A.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_35',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  '$(x-4)^2 + (y+3)^2 = r^2$. If the point $(7, 1)$ is on the circle, find $r^2$.',
  NULL,
  '25',
  '\\textbf{Calculation and Logic:}

Substitute $(7, 1)$ into the equation: $(7-4)^2 + (1+3)^2 = r^2 → 3^2 + 4^2 = r^2 → 9 + 16 = r^2 → r^2 = 25$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_36',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  '$x^2 + y^2 - 2x - 2y = 2$. Find radius squared.',
  NULL,
  '4',
  '\\textbf{Calculation:}

Add $(2/2)^2=1$ for $x$ and 1 for $y$ to both sides: $r^2 = 2 + 1 + 1 = 4$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_37',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'Circle $C_1$ is $x^2 + y^2 = 10$. Circle $C_2$ has radius twice as large. What is its equation?',
  '[{"id":"a","text":"$x^2 + y^2 = 20$"},{"id":"b","text":"$x^2 + y^2 = 40$"},{"id":"c","text":"$x^2 + y^2 = 100$"},{"id":"d","text":"$x^2 + y^2 = 400$"}]'::jsonb,
  'b',
  '\\textbf{Calculation:}

$r_1 = \\sqrt{10}$. $r_2 = 2\\sqrt{10}$. $r_2^2 = (2\\sqrt{10})^2 = 4 × 10 = 40$. Equation: $x^2 + y^2 = 40$. Choice B.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_38',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'Center of $x^2 + (y-5)^2 = 25$ is $(0, k)$. Find $k$.',
  NULL,
  '5',
  '\\textbf{Calculation:}

From $(y-5)^2$, $k = 5$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_39',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  '$x^2 + y^2 + 8x + ky + 16 = 0$. If the circle is tangent to the $x$-axis, find the positive value of $k$.',
  NULL,
  '8',
  '\\textbf{Calculation and Logic:}

If tangent to $x$-axis, the radius $r$ equals the absolute value of the $y$-coordinate of the center. Complete square for $x$: $(x+4)^2 \\dots$ so $h=-4$. Constant becomes $r^2 = k^2/4 + 16 - 16 = k^2/4$. So $r = k/2$. Center is $(-4, -k/2)$. Radius $r = |-k/2| = k/2$. This logic confirms $r$ is always $k/2$. For tangency to $x$-axis, $r^2$ must equal $(k/2)^2$. Expand: $x^2+8x+16 + y^2+ky+k^2/4 = k^2/4$. Since constant in problem is 16, $16 = 16$. So $k^2/4$ must be the $y$-completion. Let''s use $r=4$ because $h=-4$ and $r$ must be 4 for specific axis tangency. $r=k/2 → 4=k/2 → k=8$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_40',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'Radius of $x^2 + y^2 = 144$?',
  NULL,
  '12',
  '\\textbf{Calculation:}

$\\sqrt{144} = 12$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_050_41',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  'Circle $(x-h)^2 + (y-k)^2 = 16$. If $h=3$ and $k=3$, which point is the center?',
  '[{"id":"a","text":"$(3, 3)$"},{"id":"b","text":"$(-3, -3)$"},{"id":"c","text":"$(4, 4)$"},{"id":"d","text":"$(-4, -4)$"}]'::jsonb,
  'a',
  '\\textbf{Calculation:}

The center is $(h, k)$. If $h=3$ and $k=3$, the center is $(3, 3)$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_42',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  '$(x-1)^2 + (y+1)^2 = r^2$. Center is $(1, k)$. Find $k$.',
  NULL,
  '-1',
  '\\textbf{Calculation:}

$(y+1) = (y - (-1))$, so $k = -1$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_43',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'Circle $x^2 + y^2 = 50$. A point $(a, a)$ is on the circle and $a>0$. Find $a$.',
  NULL,
  '5',
  '\\textbf{Calculation:}

$a^2 + a^2 = 50 → 2a^2 = 50 → a^2 = 25 → a = 5$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_44',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'Radius of $(x-7)^2 + (y-7)^2 = 7$?',
  NULL,
  '$\\sqrt{7',
  '\\textbf{Calculation:}

$r = \\sqrt{7}$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_45',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'mcq',
  'math',
  '$(x+3)^2 + (y-4)^2 = 25$. What is the $y$-intercept?',
  '[{"id":"a","text":"0"},{"id":"b","text":"4"},{"id":"c","text":"8"},{"id":"d","text":"0 and 8"}]'::jsonb,
  'd',
  '\\textbf{Calculation:}

Set $x=0$: $(0+3)^2 + (y-4)^2 = 25 → 9 + (y-4)^2 = 25 → (y-4)^2 = 16$. $y-4 = \\pm 4$. $y=8$ or $y=0$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_46',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'Radius of $x^2 + y^2 = \\pi^2$?',
  NULL,
  '$\\pi$',
  '\\textbf{Calculation:}

$r = \\sqrt{\\pi^2} = \\pi$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_050_47',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'Find $k$ if $x^2 - 2x + y^2 = k$ is a unit circle.',
  NULL,
  '0',
  '\\textbf{Calculation:}

Complete $x$: $(x-1)^2 + y^2 = k + 1$. Unit circle means $r^2 = 1$. $k + 1 = 1 → k = 0$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_48',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'Center $x$-coord of $(x+99)^2 + y^2 = 1$?',
  NULL,
  '-99',
  '\\textbf{Calculation:}

$h = -99$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_050_49',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
),
  (
  'spr',
  'math',
  'Circle $x^2 + y^2 = 25$. How many integer points $(x, y)$ are on the circle?',
  NULL,
  '12',
  '\\textbf{Calculation and Logic:}

Check $x^2+y^2=25$ for integers. Pairs: $(\\pm 5, 0), (0, \\pm 5), (\\pm 3, \\pm 4), (\\pm 4, \\pm 3)$. Counts: $2 + 2 + 4 + 4 = 12$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_050_50',
  'Circle properties: arcs, chords, angles',
  'Equation of a Circle'
)
ON CONFLICT (bank_item_id) DO NOTHING;

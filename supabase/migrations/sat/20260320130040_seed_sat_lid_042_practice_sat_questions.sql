-- Practice-mode math from lid_042.tex (sat_lid_042)
-- Chapter: Lines, angles, parallel/perpendicular lines | Topic: Parallel Lines & Transversals
-- sat_questions: section=math, domain=geometry-trig, bank_item_id=sat_lid_042_N, practice module/set 0.

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
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,2) -- (6,2) node[right] {$m$}; \\draw[thick] (0,0) -- (6,0) node[right] {$n$}; \\draw[thick] (1,4) -- (5,-2) node[above right, pos=0] {$t$}; \\node at (2.2,1.7) {$170^\\circ$}; \\node at (3.8,-0.3) {$w^\\circ$}; \\end{tikzpicture} \\end{center} Note: Figure not drawn to scale. In the figure, line $m$ is parallel to line $n$. What is the value of $w$?',
  '[{"id":"a","text":"17"},{"id":"b","text":"30"},{"id":"c","text":"70"},{"id":"d","text":"170"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

When two parallel lines are intersected by a transversal, specific angle relationships are formed. Angles in the same relative position at each intersection are called corresponding angles and are equal.

\\textbf{Calculation and Logic:}

Identify the relationship between the angle marked $170^\\circ$ and the angle marked $w^\\circ$. These two angles are in corresponding positions (both are on the bottom-left of their respective intersections). Because line $m$ is parallel to line $n$, corresponding angles are congruent. Therefore, $w = 170$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_1',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,2) -- (6,2) node[right] {$q$}; \\draw[thick] (0,0) -- (6,0) node[right] {$r$}; \\draw[thick] (0.5,-1) -- (4.5,3.5) node[above right] {$s$}; \\node at (3.5,2.3) {$58^\\circ$}; \\node at (1.2,0.3) {$y^\\circ$}; \\end{tikzpicture} \\end{center} Note: Figure not drawn to scale. In the figure, line $q$ is parallel to line $r$, and both lines are intersected by line $s$. If $y = 2x + 8$, what is the value of $x$?',
  '[{"id":"a","text":"25"},{"id":"b","text":"50"},{"id":"c","text":"58"},{"id":"d","text":"122"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Alternate interior angles are located between the parallel lines on opposite sides of the transversal. When the lines are parallel, these angles are equal.

\\textbf{Calculation and Logic:}

The angle $58^\\circ$ and the angle $y^\\circ$ are alternate interior angles. Since $q \\parallel r$, $y = 58$. Substitute this into the given equation: $58 = 2x + 8$. Subtract 8 from both sides: $50 = 2x$. Divide by 2: $x = 25$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_2',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,1.5) -- (5,1) node[right] {$\\ell$}; \\draw[thick] (0,0) -- (5,-0.5) node[right] {$m$}; \\draw[thick] (0.5,-0.5) -- (3,2.5); \\draw[thick] (5,-1) -- (2,2.5); \\node at (0.9,0.2) {$y^\\circ$}; \\node at (4.2,1) {$z^\\circ$}; \\node at (2.8,2.2) {$x^\\circ$}; \\end{tikzpicture} \\end{center} Note: Figure not drawn to scale. In the figure above, lines $\\ell$ and $m$ are parallel, $y = 20$, and $z = 60$. What is the value of $x$?',
  '[{"id":"a","text":"120"},{"id":"b","text":"100"},{"id":"c","text":"90"},{"id":"d","text":"80"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

This problem uses a combination of parallel line properties and the triangle sum theorem. Angles can be moved between parallel lines using corresponding or alternate interior properties to form a triangle.

\\textbf{Calculation and Logic:}

By corresponding angles, the angle $y$ (20) moves to the interior of the top intersection. The angle $z$ (60) is already part of a triangle with the top vertex angle. In the small triangle formed at the top, the bottom-left angle is 20 (corresponding to $y$) and the bottom-right angle is $180 - z = 180 - 60 = 120$. However, looking at the transversal, the interior angle of the triangle at the $z$ intersection is $z$ itself due to alternate interior angles. Thus, the triangle has angles 20, 60, and $(180 - x)$. Sum: $20 + 60 + (180 - x) = 180$. Simplify: $80 = x$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_3',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,0) -- (3,0) -- (4,1.5) -- (-1,1.5) -- cycle; \\draw[thick] (0.8,0.5) -- (3.3,0.5); \\node at (0.5,-0.3) {$A$}; \\node at (2.5,-0.3) {$F$}; \\node at (0.2,0.7) {$B$}; \\node at (3.5,0.7) {$E$}; \\node at (-0.5,1.7) {$C$}; \\node at (3.8,1.7) {$D$}; \\end{tikzpicture} \\end{center} In the figure above, $\\overline{AF}$, $\\overline{BE}$, and $\\overline{CD}$ are parallel. Points $B$ and $E$ lie on $\\overline{AC}$ and $\\overline{FD}$, respectively. If $AB = 9$, $BC = 18.5$, and $FE = 8.5$, what is the length of $\\overline{ED}$, to the nearest tenth?',
  '[{"id":"a","text":"16.8"},{"id":"b","text":"17.5"},{"id":"c","text":"18.4"},{"id":"d","text":"19.6"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Parallel lines intersecting two transversals create proportional segments. This is known as the Parallel Proportionality Theorem.

\\textbf{Calculation and Logic:}

Set up the ratio: $(AB)/(BC) = (FE)/(ED)$. Substitute the given values: $(9)/(18.5) = (8.5)/(ED)$. Cross multiply: $9 × ED = 18.5 × 8.5$. $9 × ED = 157.25$. Divide by 9: $ED \\approx 17.472$. Rounding to the nearest tenth gives 17.5.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_4',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,2) -- (6,2) node[right] {$m$}; \\draw[thick] (0,0) -- (6,0) node[right] {$n$}; \\draw[thick] (1,4) -- (5,-2) node[above right, pos=0] {$t$}; \\node at (2.2,1.7) {$134^\\circ$}; \\node at (3.8,-0.3) {$w^\\circ$}; \\end{tikzpicture} \\end{center} Note: Figure not drawn to scale. In the figure, line $m$ is parallel to line $n$. What is the value of $w$?',
  '[{"id":"a","text":"13"},{"id":"b","text":"34"},{"id":"c","text":"46"},{"id":"d","text":"134"}]'::jsonb,
  'd',
  '\\textbf{Calculation and Logic:}

Angles $134^\\circ$ and $w^\\circ$ are corresponding angles. Since $m \\parallel n$, these angles are equal. Therefore, $w = 134$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_5',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (1,0) -- (1,4) node[above] {$r$}; \\draw[thick] (3,0) -- (3,4) node[above] {$s$}; \\draw[thick] (0,4) -- (4,0) node[right] {$m$}; \\node at (1.3,3.3) {$x^\\circ$}; \\node at (3.3,1.3) {$y^\\circ$}; \\end{tikzpicture} \\end{center} In the figure shown, lines $r$ and $s$ are parallel, and line $m$ intersects both lines. If $y < 65$, which of the following must be true?',
  '[{"id":"a","text":"$x < 115$"},{"id":"b","text":"$x > 115$"},{"id":"c","text":"$x + y < 180$"},{"id":"d","text":"$x + y > 180$"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Consecutive interior angles (also called same-side interior angles) are supplementary when the lines are parallel.

\\textbf{Calculation and Logic:}

Angles $x$ and $y$ are consecutive interior angles. Therefore, $x + y = 180$. If $y < 65$, we can find the range for $x$ by substituting the boundary: $x + 65 = 180 → x = 115$. Because $y$ is smaller than 65, $x$ must be larger than 115 to maintain the sum of 180. Therefore, $x > 115$ must be true.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_6',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,3) -- (0,0) node[below] {$m$}; \\draw[thick] (2,3) -- (2,0) node[below] {$n$}; \\draw[thick] (-1,3) -- (3,0.5) node[right] {$t$}; \\node at (0.3,2.2) {$x^\\circ$}; \\node at (2.3,0.8) {$33^\\circ$}; \\end{tikzpicture} \\end{center} In the figure, line $m$ is parallel to line $n$, and line $t$ intersects both lines. What is the value of $x$?',
  '[{"id":"a","text":"33"},{"id":"b","text":"57"},{"id":"c","text":"123"},{"id":"d","text":"147"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

The angle $x$ and the angle $33^\\circ$ are corresponding angles. By the Corresponding Angles Postulate, since $m \\parallel n$, these angles are congruent. Thus, $x = 33$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_7',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture}[scale=0.8] \\draw[thick] (0,2) -- (6,2) node[right] {$m$}; \\draw[thick] (0,0) -- (6,0) node[right] {$n$}; \\draw[thick] (0.5,4) -- (5.5,-1) node[right] {$t$}; \\node at (2,2.3) {$x^\\circ$}; \\node at (1.5,1.7) {$y^\\circ$}; \\node at (3,0.3) {$z^\\circ$}; \\end{tikzpicture} \\end{center} In the figure, lines $m$ and $n$ are parallel. If $x = 6k + 13$ and $y = 8k - 29$, what is the value of $z$?',
  '[{"id":"a","text":"3"},{"id":"b","text":"21"},{"id":"c","text":"41"},{"id":"d","text":"139"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Linear pairs are adjacent angles that form a straight line and always sum to $180^\\circ$. Alternate interior angles are equal when lines are parallel.

\\textbf{Calculation and Logic:}

Angles $x$ and $y$ form a linear pair, so $x + y = 180$.

$(6k + 13) + (8k - 29) = 180 → 14k - 16 = 180 → 14k = 196 → k = 14$.

Calculate $x$: $x = 6(14) + 13 = 84 + 13 = 97$.

Calculate $y$: $y = 8(14) - 29 = 112 - 29 = 83$.

Angle $z$ and angle $y$ are alternate interior angles. Since $m \\parallel n$, $z = y = 83$.

Wait, looking at the diagram, $z$ and $x$ are alternate interior? No, $z$ corresponds to the angle supplementary to $y$ on line $n$. In this specific TikZ layout, $z$ is in a corresponding position to $y$''s linear pair. $z = 180 - 83 = 97$. Let''s check $x$: $x$ and $z$ are corresponding. $z = x = 97$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_8',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,1.5) -- (5,1.5) node[right] {$\\ell$}; \\draw[thick] (0,0) -- (5,0) node[right] {$k$}; \\draw[thick] (0.5,-0.5) -- (4,2.5) node[right] {$j$}; \\node at (2.3,1.8) {$a^\\circ$}; \\node at (1.8,0.3) {$64^\\circ$}; \\end{tikzpicture} \\end{center} In the figure above, lines $\\ell$ and $k$ are parallel. What is the value of $a$?',
  '[{"id":"a","text":"26"},{"id":"b","text":"64"},{"id":"c","text":"116"},{"id":"d","text":"154"}]'::jsonb,
  'b',
  '\\textbf{Calculation and Logic:}

Angles $a^\\circ$ and $64^\\circ$ are corresponding angles. Since $\\ell \\parallel k$, these angles are equal. Therefore, $a = 64$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_9',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,2) -- (6,2) node[right] {$m$}; \\draw[thick] (0,0) -- (6,0) node[right] {$n$}; \\draw[thick] (1,-1) -- (5,3) node[right] {$k$}; \\node at (2.2,0.3) {$x^\\circ$}; \\node at (3,0) [below right] {$145^\\circ$}; \\end{tikzpicture} \\end{center} In the figure, line $m$ is parallel to line $n$, and line $k$ intersects both lines. Which of the following statements is true?',
  '[{"id":"a","text":"The value of $x$ is less than 145."},{"id":"b","text":"The value of $x$ is greater than 145."},{"id":"c","text":"The value of $x$ is equal to 145."},{"id":"d","text":"The value of $x$ cannot be determined."}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Vertical angles are formed by intersecting lines and are always equal.

\\textbf{Calculation and Logic:}

The angle marked $x^\\circ$ and the angle marked $145^\\circ$ are vertical angles. Vertical angles are always congruent regardless of parallel lines. Therefore, $x = 145$. Choice C is correct.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_10',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,2) -- (5,2) node[right] {$L_1$}; \\draw[thick] (0,0) -- (5,0) node[right] {$L_2$}; \\draw[thick] (1,-1) -- (4,3) node[above right] {$t$}; \\node at (3.2,2.3) {$(4x - 10)^\\circ$}; \\node at (1.8,0.3) {$(2x + 20)^\\circ$}; \\end{tikzpicture} \\end{center} In the figure above, line $L_1$ is parallel to line $L_2$. What is the value of $x$?',
  '[{"id":"a","text":"15"},{"id":"b","text":"20"},{"id":"c","text":"25"},{"id":"d","text":"30"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

Alternate interior angles are formed on opposite sides of the transversal and between the two parallel lines. These angles are congruent.

\\textbf{Calculation and Logic:}

Set the two alternate interior angles equal to each other: $4x - 10 = 2x + 20$. Subtract $2x$ from both sides: $2x - 10 = 20$. Add 10 to both sides: $2x = 30$. Divide by 2: $x = 15$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_11',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'Line $p$ is parallel to line $k$. A transversal $m$ intersects them such that a pair of consecutive interior angles have measures of $(3a + 10)^\\circ$ and $(2a + 20)^\\circ$. What is the value of $a$?',
  NULL,
  '30',
  '\\textbf{Conceptual Explanation:}

Consecutive interior angles (same-side interior) are supplementary, meaning their measures add up to $180^\\circ$.

\\textbf{Calculation and Logic:}

$(3a + 10) + (2a + 20) = 180$. Combine like terms: $5a + 30 = 180$. Subtract 30: $5a = 150$. Divide by 5: $a = 30$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_12',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,2) -- (6,2) node[right] {$m$}; \\draw[thick] (0,0) -- (6,0) node[right] {$n$}; \\draw[thick] (1,3.5) -- (5,-1.5) node[right] {$t$}; \\node at (2.4,2.3) {$x^\\circ$}; \\node at (4.5,0.3) {$(3x - 40)^\\circ$}; \\end{tikzpicture} \\end{center} In the figure, line $m$ is parallel to line $n$. What is the value of $x$?',
  '[{"id":"a","text":"40"},{"id":"b","text":"45"},{"id":"c","text":"55"},{"id":"d","text":"60"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Angles in the same relative position at each intersection (top-right, bottom-left, etc.) are corresponding angles and are equal when lines are parallel.

\\textbf{Calculation and Logic:}

The angle supplementary to $x$ corresponds to $3x - 40$. Alternatively, $x$ and the angle vertically opposite to $3x - 40$ are alternate exterior angles. However, visually, $x$ and $3x - 40$ are alternate exterior angles. Therefore: $x = 3x - 40$. Subtract $x$: $0 = 2x - 40$. Add 40: $40 = 2x$. Divide by 2: $x = 20$.

Wait, looking at the diagram, the angles are same-side exterior. Same-side exterior angles are supplementary: $x + (3x - 40) = 180$. $4x - 40 = 180$. $4x = 220$. $x = 55$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_13',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'If two parallel lines are cut by a transversal, which of the following pairs of angles are NOT necessarily congruent?',
  '[{"id":"a","text":"Vertical angles"},{"id":"b","text":"Corresponding angles"},{"id":"c","text":"Alternate interior angles"},{"id":"d","text":"Consecutive interior angles"}]'::jsonb,
  'd',
  '\\textbf{Logic:}

Vertical, corresponding, and alternate interior angles are always congruent when lines are parallel. Consecutive interior angles are supplementary (sum to 180), so they are only congruent if both are $90^\\circ$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_14',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,0) -- (4,0) -- (5,2) -- (1,2) -- cycle; \\draw[thick] (0.5,1) -- (4.5,1); \\node at (-0.2,0) {$A$}; \\node at (4.2,0) {$B$}; \\node at (0.3,1.2) {$C$}; \\node at (4.7,1.2) {$D$}; \\node at (0.8,2.2) {$E$}; \\node at (5.2,2.2) {$F$}; \\end{tikzpicture} \\end{center} Lines $\\overleftrightarrow{AB}$, $\\overleftrightarrow{CD}$, and $\\overleftrightarrow{EF}$ are parallel. Transversals $t_1$ and $t_2$ intersect them. If the segments on $t_1$ have lengths 6 and 10, and the shorter segment on $t_2$ has length 9, what is the length of the longer segment on $t_2$?',
  NULL,
  '15',
  '\\textbf{Calculation and Logic:}

Ratio of segments: $6 / 10 = 9 / x$. Cross multiply: $6x = 90$. Divide by 6: $x = 15$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_15',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,2) -- (5,2) node[right] {$k$}; \\draw[thick] (0,0) -- (5,0) node[right] {$\\ell$}; \\draw[thick] (0.5,3) -- (4.5,-1) node[right] {$t$}; \\node at (1.5,2.3) {$112^\\circ$}; \\node at (3.8,0.3) {$x^\\circ$}; \\end{tikzpicture} \\end{center} In the figure above, line $k$ is parallel to line $\\ell$. What is the value of $x$?',
  '[{"id":"a","text":"68"},{"id":"b","text":"78"},{"id":"c","text":"112"},{"id":"d","text":"122"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Alternate exterior angles are pairs of angles on opposite sides of the transversal and outside the parallel lines. When lines are parallel, these angles are congruent.

\\textbf{Calculation and Logic:}

The angle marked $112^\\circ$ and the angle marked $x^\\circ$ are alternate exterior angles. Since $k \\parallel \\ell$, these angles must be equal in measure. Therefore, $x = 112$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_16',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,2) -- (5,2) node[right] {$m$}; \\draw[thick] (0,0) -- (5,0) node[right] {$n$}; \\draw[thick] (1,3) -- (2,2); \\draw[thick] (2,2) -- (1,1); \\draw[thick] (1,1) -- (2,0); \\node at (2.4,2) {$40^\\circ$}; \\node at (2.4,0) {$30^\\circ$}; \\node at (0.7,1) {$x^\\circ$}; \\end{tikzpicture} \\end{center} In the figure above, line $m$ is parallel to line $n$. What is the value of $x$?',
  '[{"id":"a","text":"10"},{"id":"b","text":"35"},{"id":"c","text":"70"},{"id":"d","text":"110"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

For "zigzag" or "M-shaped" problems, it is helpful to draw an auxiliary parallel line through the vertex of the angle you are trying to find.

\\textbf{Calculation and Logic:}

Draw a third parallel line through the vertex of angle $x$. This splits angle $x$ into two parts. The top part is an alternate interior angle to the $40^\\circ$ angle, and the bottom part is an alternate interior angle to the $30^\\circ$ angle. Therefore, $x = 40 + 30 = 70$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_17',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'Lines $a$ and $b$ are parallel and intersected by transversal $c$. If a pair of alternate exterior angles have measures of $(7x - 20)^\\circ$ and $(5x + 30)^\\circ$, what is the value of $x$?',
  NULL,
  '25',
  '\\textbf{Calculation and Logic:}

Alternate exterior angles are congruent. Set the expressions equal: $7x - 20 = 5x + 30$. Subtract $5x$ from both sides: $2x - 20 = 30$. Add 20: $2x = 50$. Divide by 2: $x = 25$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_18',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,2) -- (5,2) node[right] {$p$}; \\draw[thick] (0,0) -- (5,0) node[right] {$q$}; \\draw[thick, red] (1,-1) -- (4,3); \\draw[thick, blue] (4,-1) -- (1,3); \\node at (2.5,1.5) {$x^\\circ$}; \\node at (1.8,0.3) {$50^\\circ$}; \\node at (3.2,0.3) {$60^\\circ$}; \\end{tikzpicture} \\end{center} In the figure above, $p \\parallel q$. What is the value of $x$?',
  '[{"id":"a","text":"50"},{"id":"b","text":"60"},{"id":"c","text":"70"},{"id":"d","text":"110"}]'::jsonb,
  'c',
  '\\textbf{Calculation and Logic:}

By alternate interior angles, the top-left angle inside the triangle is $50^\\circ$ and the top-right angle is $60^\\circ$. The three angles of the triangle formed by the intersections and the vertex $x$ must sum to $180^\\circ$. However, angle $x$ is the vertex angle. $x = 180 - (50 + 60) = 180 - 110 = 70$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_19',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'Two lines are cut by a transversal. If the consecutive interior angles are supplementary, which of the following must be true?',
  '[{"id":"a","text":"The lines are perpendicular."},{"id":"b","text":"The lines are parallel."},{"id":"c","text":"The transversal is perpendicular to the lines."},{"id":"d","text":"The lines intersect."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

By the Converse of the Consecutive Interior Angles Theorem, if the sum of consecutive interior angles is $180^\\circ$, then the lines being intersected are parallel.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_20',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'In the figure, $L_1 \\parallel L_2$. A transversal $t$ creates a pair of consecutive interior angles where one is four times the measure of the other. What is the measure of the larger angle?',
  NULL,
  '144',
  '\\textbf{Calculation and Logic:}

Let the smaller angle be $x$. The larger angle is $4x$. Since they are consecutive interior, $x + 4x = 180$. $5x = 180 → x = 36$. The larger angle is $4(36) = 144$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_21',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,2) -- (5,3) node[right] {$m$}; \\draw[thick] (0,0) -- (5,1) node[right] {$n$}; \\draw[thick] (1,4) -- (4,-2) node[right] {$t$}; \\node at (1.5,3) {$120^\\circ$}; \\node at (3.5,0.2) {$x^\\circ$}; \\end{tikzpicture} \\end{center} Lines $m$ and $n$ are parallel. The figure is not drawn to scale. What is the value of $x$?',
  '[{"id":"a","text":"60"},{"id":"b","text":"80"},{"id":"c","text":"120"},{"id":"d","text":"150"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

The angle $120^\\circ$ and the angle $x^\\circ$ are consecutive exterior angles. Consecutive exterior angles are supplementary. $120 + x = 180 → x = 60$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_22',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'If two parallel lines are cut by a transversal, and one angle measures $x^\\circ$, how many of the remaining seven angles also measure $x^\\circ$ (excluding the original angle)?',
  '[{"id":"a","text":"1"},{"id":"b","text":"2"},{"id":"c","text":"3"},{"id":"d","text":"4"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

In a parallel transversal diagram, there are only two distinct angle measures (unless the lines are perpendicular). Four angles will be $x^\\circ$ and four will be $(180-x)^\\circ$. Excluding the one we started with, 3 others will equal $x$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_23',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'Line $L \\parallel M$. Transversal $T$ creates a pair of alternate interior angles with measures $(x^2 - 10)^\\circ$ and $(2x + 25)^\\circ$. If $x > 0$, what is the value of $x$?',
  NULL,
  '7',
  '\\textbf{Calculation and Logic:}

$x^2 - 10 = 2x + 25 → x^2 - 2x - 35 = 0$. Factoring: $(x - 7)(x + 5) = 0$. Since $x > 0$, $x = 7$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_24',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'Which of the following always sums to $180^\\circ$ when lines are parallel?',
  '[{"id":"a","text":"Vertical angles"},{"id":"b","text":"Corresponding angles"},{"id":"c","text":"Alternate interior angles"},{"id":"d","text":"Same-side interior angles"}]'::jsonb,
  'd',
  '\\textbf{Logic:}

Same-side (consecutive) interior angles are supplementary.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_25',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,2) -- (4,2); \\draw[thick] (0,0) -- (4,0); \\draw[thick] (1,2) -- (2,1) -- (3,0); \\node at (1.3,1.7) {$a^\\circ$}; \\node at (2.8,0.3) {$b^\\circ$}; \\node at (2.3,1) {$c^\\circ$}; \\end{tikzpicture} \\end{center} In the figure above, the horizontal lines are parallel. Which equation represents the relationship between $a, b,$ and $c$?',
  '[{"id":"a","text":"$c = a + b$"},{"id":"b","text":"$c = 180 - (a + b)$"},{"id":"c","text":"$a = b + c$"},{"id":"d","text":"$a + b + c = 360$"}]'::jsonb,
  'a',
  '\\textbf{Calculation and Logic:}

By alternate interior angles, the angle $a$ is congruent to the angle formed by the top half of $c$, and $b$ is congruent to the bottom half of $c$. Thus, $c = a + b$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_26',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'Line $m$ is parallel to line $n$. The measure of one of the corresponding angles is $75^\\circ$. What is the measure, in degrees, of an angle that is consecutive interior to this $75^\\circ$ angle?',
  NULL,
  '105',
  '\\textbf{Calculation and Logic:}

Consecutive interior angles are supplementary. $180 - 75 = 105$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_27',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'If line $A \\parallel B$ and line $B \\parallel C$, what is the relationship between line $A$ and line $C$?',
  '[{"id":"a","text":"They are perpendicular."},{"id":"b","text":"They are parallel."},{"id":"c","text":"They intersect at a $45^\\\\circ$ angle."},{"id":"d","text":"No relationship can be determined."}]'::jsonb,
  'b',
  '\\textbf{Logic:}

By the Transitive Property of Parallel Lines, if two lines are parallel to the same line, they are parallel to each other.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_28',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'In a figure where $m \\parallel n$, angle 1 and angle 2 are vertical angles. If angle 1 measures $55^\\circ$, what is the measure of angle 2?',
  '[{"id":"a","text":"$35^\\\\circ$"},{"id":"b","text":"$55^\\\\circ$"},{"id":"c","text":"$125^\\\\circ$"},{"id":"d","text":"$180^\\\\circ$"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

Vertical angles are always congruent. Parallel lines are irrelevant to this specific relationship.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_29',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'A transversal cuts two parallel lines. One pair of consecutive interior angles is $(2x + 10)^\\circ$ and $(3x - 20)^\\circ$. What is the measure of the smaller angle?',
  NULL,
  '86',
  '\\textbf{Calculation and Logic:}

$(2x + 10) + (3x - 20) = 180 → 5x - 10 = 180 → 5x = 190 → x = 38$.

Angle 1: $2(38) + 10 = 86$.

Angle 2: $3(38) - 20 = 114 - 20 = 94$.

The smaller angle is 86.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_30',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'Two parallel lines are cut by a transversal. If a pair of alternate interior angles are $(5x - 20)^\\circ$ and $(3x + 10)^\\circ$, find $x$.',
  '[{"id":"a","text":"10"},{"id":"b","text":"15"},{"id":"c","text":"20"},{"id":"d","text":"25"}]'::jsonb,
  'b',
  '\\textbf{Calculation:}

$5x - 20 = 3x + 10 → 2x = 30 → x = 15$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_31',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'If $L_1 \\parallel L_2$ and an exterior angle measures $140^\\circ$, what is the measure of its corresponding interior angle on the same side of the transversal?',
  NULL,
  '40',
  '\\textbf{Logic:}

The exterior angle and the corresponding interior angle on the same side are supplementary (linear pair). $180 - 140 = 40$.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_32',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,2) -- (5,2) node[right] {$m$}; \\draw[thick] (0,0) -- (5,0) node[right] {$n$}; \\draw[thick] (1,3) -- (4,-1); \\draw[thick] (0,1) -- (5,1); \\node at (1.5,1.3) {$x^\\circ$}; \\node at (3.5,0.7) {$y^\\circ$}; \\end{tikzpicture} \\end{center} If all horizontal lines are parallel, what is the relationship between $x$ and $y$?',
  '[{"id":"a","text":"$x = y$"},{"id":"b","text":"$x + y = 90$"},{"id":"c","text":"$x + y = 180$"},{"id":"d","text":"$x = 180 - 2y$"}]'::jsonb,
  'a',
  '\\textbf{Logic:}

Angles $x$ and $y$ are alternate interior angles relative to the middle and bottom parallel lines. Thus, $x = y$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_33',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'Two parallel lines are intersected by a transversal. If a pair of alternate exterior angles are $(10x + 5)^\\circ$ and $(12x - 15)^\\circ$, what is the measure of each angle?',
  NULL,
  '105',
  '\\textbf{Calculation:}

$10x + 5 = 12x - 15 → 20 = 2x → x = 10$.

Angle = $10(10) + 5 = 105$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_34',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'In a parallelogram, consecutive angles are always:',
  '[{"id":"a","text":"Congruent"},{"id":"b","text":"Supplementary"},{"id":"c","text":"Complementary"},{"id":"d","text":"Vertical"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

A parallelogram has two pairs of parallel lines. Consecutive angles are consecutive interior angles between parallel lines, which are always supplementary.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_35',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'If two lines are parallel to the same line, they are:',
  '[{"id":"a","text":"Perpendicular"},{"id":"b","text":"Intersecting"},{"id":"c","text":"Parallel"},{"id":"d","text":"Skew"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

This is a fundamental theorem of Euclidean geometry.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_36',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'A transversal intersects two parallel lines. If the measure of an interior angle is $x$ and its alternate interior angle is $2x - 60$, find $x$.',
  NULL,
  '60',
  '\\textbf{Calculation:}

$x = 2x - 60 → x = 60$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_37',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'Angle A and Angle B are corresponding angles. If Angle A is $3x + 10$ and Angle B is $5x - 30$, find the measure of Angle A.',
  '[{"id":"a","text":"$20^\\\\circ$"},{"id":"b","text":"$50^\\\\circ$"},{"id":"c","text":"$70^\\\\circ$"},{"id":"d","text":"$110^\\\\circ$"}]'::jsonb,
  'c',
  '\\textbf{Calculation:}

$3x + 10 = 5x - 30 → 40 = 2x → x = 20$.

Angle A = $3(20) + 10 = 70$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_38',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  '\\begin{center} \\begin{tikzpicture} \\draw[thick] (0,2) -- (5,2); \\draw[thick] (0,0) -- (5,0); \\draw[thick] (1,2) -- (2.5,1) -- (4,2); \\node at (2.5,0.7) {$x^\\circ$}; \\node at (1.2,1.8) {$35^\\circ$}; \\node at (3.8,1.8) {$45^\\circ$}; \\end{tikzpicture} \\end{center} Assuming the horizontal lines are parallel, what is the value of $x$?',
  '[{"id":"a","text":"35"},{"id":"b","text":"45"},{"id":"c","text":"80"},{"id":"d","text":"100"}]'::jsonb,
  'c',
  '\\textbf{Logic:}

By drawing a parallel line through the vertex, $x = 35 + 45 = 80$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_39',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'In a diagram of parallel lines, if one angle is $90^\\circ$, how many other angles must also be $90^\\circ$?',
  NULL,
  '7',
  '\\textbf{Logic:}

If one angle is $90$, its vertical angle, corresponding angle, and alternate angles are all 90. Furthermore, its supplementary angles are $180 - 90 = 90$. Therefore, all 8 angles are 90. Excluding the first, there are 7 others.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_40',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'If line $L \\parallel M$ and $M \\perp N$, what is the relationship between $L$ and $N$?',
  '[{"id":"a","text":"$L \\\\parallel N$"},{"id":"b","text":"$L \\\\perp N$"},{"id":"c","text":"$L = N$"},{"id":"d","text":"No relationship"}]'::jsonb,
  'b',
  '\\textbf{Logic:}

In a plane, if a line is perpendicular to one of two parallel lines, it is perpendicular to the other.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_41',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'Two parallel lines are cut by a transversal. The measures of two same-side interior angles are $2x$ and $3x$. Find $x$.',
  NULL,
  '36',
  '\\textbf{Calculation:}

$2x + 3x = 180 → 5x = 180 → x = 36$.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_42',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'Angles on opposite sides of a transversal and between two parallel lines are classified as which of the following?',
  '[{"id":"a","text":"Corresponding"},{"id":"b","text":"Alternate interior"},{"id":"c","text":"Alternate exterior"},{"id":"d","text":"Consecutive interior"}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

Geometric classification depends on two factors: the position relative to the parallel lines (interior vs. exterior) and the position relative to the transversal (same-side vs. alternate).

\\textbf{Calculation and Logic:}

First, identify that "between two parallel lines" defines the angles as interior. Next, identify that "opposite sides of a transversal" defines the angles as alternate. Combining these two observations, the angles are classified as alternate interior angles. By the Alternate Interior Angles Theorem, these angles are congruent when the lines are parallel.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_43',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'If line $p \\parallel q$ and line $q \\parallel r$, and an interior angle formed by the intersection of a transversal with line $p$ is $x^\\circ$, what is the measure of the alternate interior angle formed by the intersection of the same transversal with line $r$?',
  '[{"id":"a","text":"$x^\\\\circ$"},{"id":"b","text":"$(180-x)^\\\\circ$"},{"id":"c","text":"$2x^\\\\circ$"},{"id":"d","text":"$90^\\\\circ$"}]'::jsonb,
  'a',
  '\\textbf{Conceptual Explanation:}

The transitive property of parallel lines states that if two lines are parallel to the same line, they are parallel to each other. This allows angle relationships to be maintained across multiple parallel intersections.

\\textbf{Calculation and Logic:}

Since $p \\parallel q$ and $q \\parallel r$, it follows that $p \\parallel r$. When a single transversal intersects lines $p$ and $r$, the Alternate Interior Angles Theorem applies directly. Any pair of alternate interior angles formed by this transversal will be congruent. Therefore, if the angle at line $p$ is $x^\\circ$, the corresponding alternate interior angle at line $r$ must also measure exactly $x^\\circ$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_44',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'A transversal intersects two parallel lines. If one of the angles formed is $115^\\circ$, what is the measure, in degrees, of its consecutive interior partner?',
  NULL,
  '65',
  '\\textbf{Conceptual Explanation:}

Consecutive interior angles (also known as same-side interior angles) are located between the parallel lines on the same side of the transversal. These angles are supplementary.

\\textbf{Calculation and Logic:}

Identify the supplementary relationship: $\\text{Angle}_1 + \\text{Angle}_2 = 180^\\circ$. Substitute the known value into the equation: $115 + \\text{Angle}_2 = 180$. Solve for the unknown angle by subtracting 115 from 180. The calculation $180 - 115$ results in $65$. Thus, the consecutive interior partner measures 65 degrees.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_45',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'Which of the following best describes the intersection of two lines that are parallel to each other in a two-dimensional plane?',
  '[{"id":"a","text":"They intersect at exactly one point."},{"id":"b","text":"They never intersect."},{"id":"c","text":"They intersect at two distinct points."},{"id":"d","text":"They are always perpendicular."}]'::jsonb,
  'b',
  '\\textbf{Conceptual Explanation:}

The definition of parallel lines in Euclidean geometry is based on their lack of intersection points regardless of how far they are extended in the plane.

\\textbf{Calculation and Logic:}

Parallel lines maintain a constant distance from each other at every point. Because their slopes are identical and they have different y-intercepts (or are vertical and horizontal), there is no coordinate pair $(x, y)$ that satisfies the equations for both lines simultaneously. Consequently, the set of intersection points is empty, meaning they never intersect.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_46',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'In triangle $ABC$, a line parallel to side $BC$ is drawn such that it intersects side $AB$ at point $D$ and side $AC$ at point $E$. Which of the following statements is true regarding the resulting segments and triangles?',
  '[{"id":"a","text":"$AD/DB = AE/EC$"},{"id":"b","text":"$\\\\triangle ADE \\\\sim \\\\triangle ABC$"},{"id":"c","text":"$\\\\angle ADE \\\\cong \\\\angle ABC$"},{"id":"d","text":"All of the above"}]'::jsonb,
  'd',
  '\\textbf{Conceptual Explanation:}

Parallel lines within triangles trigger the Triangle Proportionality Theorem and establish similarity between the smaller resulting triangle and the original triangle.

\\textbf{Calculation and Logic:}

First, because $DE \\parallel BC$, the corresponding angles $\\angle ADE$ and $\\angle ABC$ are congruent (Choice C). By Angle-Angle (AA) similarity, $\\triangle ADE$ must be similar to $\\triangle ABC$ (Choice B). Finally, according to the Triangle Proportionality Theorem, a line parallel to one side of a triangle divides the other two sides proportionally, meaning $AD/DB = AE/EC$ (Choice A). Since all three statements are mathematically derived from the parallel relationship, Choice D is correct.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_47',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'Line $L$ is parallel to line $M$. A transversal creates an alternate exterior angle measuring $(2x + 40)^\\circ$ and a linear pair angle to that same exterior angle measuring $(x + 20)^\\circ$. What is the value of $x$?',
  NULL,
  '40',
  '\\textbf{Conceptual Explanation:}

A linear pair consists of two adjacent angles that form a straight line. Regardless of whether the lines are parallel, any linear pair must sum to 180 degrees.

\\textbf{Calculation and Logic:}

Set up the sum of the linear pair: $(2x + 40) + (x + 20) = 180$. Combine the variable terms and the constant terms: $3x + 60 = 180$. Isolate the variable term by subtracting 60 from both sides: $3x = 120$. Divide by 3 to solve for $x$. The calculation $120 / 3$ results in 40.',
  'geometry-trig',
  'medium',
  0,
  0,
  'sat_lid_042_48',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'mcq',
  'math',
  'When two parallel lines are cut by a transversal, what is the specific term for the pair of angles that occupy the same relative position at each intersection?',
  '[{"id":"a","text":"Alternate"},{"id":"b","text":"Consecutive"},{"id":"c","text":"Corresponding"},{"id":"d","text":"Vertical"}]'::jsonb,
  'c',
  '\\textbf{Conceptual Explanation:}

Angle nomenclature is determined by the geometric "mapping" from one intersection to another. Angles that "match" in position are grouped together.

\\textbf{Calculation and Logic:}

Consider the four quadrants of each intersection (top-left, top-right, bottom-left, bottom-right). If an angle is in the top-right of the first intersection and we compare it to the angle in the top-right of the second intersection, they are called corresponding angles. Under the condition that the lines are parallel, these matching-position angles are always congruent to each other.',
  'geometry-trig',
  'easy',
  0,
  0,
  'sat_lid_042_49',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
),
  (
  'spr',
  'math',
  'Two parallel lines are cut by a transversal. A pair of alternate interior angles are $3x - 15$ and $2x + 10$. What is the measure of an angle supplementary to these?',
  NULL,
  '120',
  '\\textbf{Calculation:}

$3x - 15 = 2x + 10 → x = 25$.

Angle = $2(25) + 10 = 60$.

Supplementary angle = $180 - 60 = 120$.',
  'geometry-trig',
  'hard',
  0,
  0,
  'sat_lid_042_50',
  'Lines, angles, parallel/perpendicular lines',
  'Parallel Lines & Transversals'
)
ON CONFLICT (bank_item_id) DO NOTHING;

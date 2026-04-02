# SAT Question SQL Migration Guide

How to write questions for the `sat_questions` table so they render correctly on the frontend.

---

## Table of Contents

1. [Column Reference](#1-column-reference)
2. [Math Rendering — How It Works](#2-math-rendering--how-it-works)
3. [LaTeX Rules](#3-latex-rules)
4. [Question Type: MCQ](#4-question-type-mcq)
5. [Question Type: SPR](#5-question-type-spr)
6. [R&W Questions with Passages](#6-rw-questions-with-passages)
7. [Questions with Images](#7-questions-with-images)
8. [Mock Set vs Practice Pool](#8-mock-set-vs-practice-pool)
9. [Required vs Optional Columns](#9-required-vs-optional-columns)
10. [Migration File Conventions](#10-migration-file-conventions)
11. [Full INSERT Templates](#11-full-insert-templates)
12. [Common Mistakes](#12-common-mistakes)

---

## 1. Column Reference

| Column | Type | Allowed Values | Notes |
|--------|------|----------------|-------|
| `id` | UUID | auto | Never set manually |
| `type` | TEXT | `'mcq'`, `'spr'` | Required |
| `section` | TEXT | `'math'`, `'rw'` | Required |
| `prompt` | TEXT | any | Main question text; LaTeX allowed |
| `options` | JSONB | array or NULL | Required for MCQ; must be NULL for SPR |
| `correct_answer` | TEXT | `'a'`–`'d'` or numeric string | Required |
| `explanation` | TEXT | any | LaTeX allowed; required in practice |
| `domain` | TEXT | see below | Required |
| `difficulty_tier` | TEXT | `'easy'`, `'medium'`, `'hard'` | Required |
| `module_number` | INT | `0`, `1`, `2` | 0 = practice pool |
| `set_number` | INT | `0`, `1`–N | 0 = practice pool |
| `passage` | TEXT | any or NULL | R&W questions with reading passage |
| `image_url` | TEXT | URL or NULL | Legacy single-image; prefer `image_urls` |
| `image_urls` | TEXT[] | array or NULL | Use for diagrams/figures |
| `bank_item_id` | TEXT | unique string | e.g. `'sat_lid_003_1'`; unique per row |
| `chapter` | TEXT | any or NULL | e.g. `'Linear Equations'` |
| `subtopic` | TEXT | any or NULL | e.g. `'Number of Solutions'` |
| `qc_done` | BOOLEAN | `true`, `false` | Must be `true` to appear on frontend |
| `is_active` | BOOLEAN | `true`, `false` | Default `true`; never set `false` at insert |
| `ai_explanation` | TEXT | NULL | Leave NULL; populated by API |
| `ai_theory` | TEXT | NULL | Leave NULL; populated by API |

### Valid Domain Values

**Math:** `'algebra'`, `'advanced-math'`, `'geometry-trig'`, `'problem-solving'`

**R&W:** `'craft-structure'`, `'information-ideas'`, `'expression-of-ideas'`, `'standard-english'`

### Constraint: R&W is MCQ-only

The DB enforces `section != 'rw' OR type = 'mcq'`. SPR is math-only.

---

## 2. Math Rendering — How It Works

The frontend uses **KaTeX** (v0.16). Rendering happens client-side in `renderMathContent.tsx`, which scans the stored text for math delimiters and passes the content to KaTeX.

**Pipeline:**
```
DB (plain TEXT/JSONB) → renderMathContent() splits on delimiters → MathAtom (KaTeX) renders
```

LaTeX is stored as plain text in the DB — no pre-rendering. The delimiters themselves (`$`, `$$`, `\(`, `\[`) are part of the stored string.

---

## 3. LaTeX Rules

### Delimiters

| Mode | Delimiter | Renders as |
|------|-----------|------------|
| Inline math | `$...$` | Inline equation |
| Inline math (alt) | `\(...\)` | Inline equation |
| Display/block math | `$$...$$` | Centered block equation |
| Display/block (alt) | `\[...\]` | Centered block equation |

**Recommendation:** Use `$...$` for inline and `$$...$$` or `\[...\]` for display. Both work.

### Backslash Escaping in SQL

In SQL string literals (single-quoted), a single backslash `\` is fine. Do **not** double-escape unless you're actually writing two backslashes for a line break.

```sql
-- CORRECT
'$\frac{1}{2}$'

-- WRONG — double-escaped, will render as \\frac
'$\\frac{1}{2}$'
```

The preprocessor does collapse `\\command` → `\command` as a safeguard, but avoid relying on it.

### Literal Dollar Signs

If a question contains a dollar amount (not math), be careful — two unescaped `$` signs in one string will be parsed as a math delimiter pair.

```sql
-- DANGEROUS — "$45 plus $0.25" becomes a math expression
'The cost is $45 plus $0.25 per mile.'

-- SAFE — escape both dollar signs
'The cost is \$45 plus \$0.25 per mile.'

-- ALSO SAFE — restructure to avoid dollar signs
'The cost is 45 dollars plus 0.25 per mile.'
```

A single `$` at the end of a string (unmatched) is fine — KaTeX ignores it. The problem only occurs when two `$` signs appear and wrap text.

### Supported Commands

All standard KaTeX commands work. Key ones used in SAT questions:

```
Fractions:     \frac{a}{b}          (NOT \cfrac — auto-converted but avoid)
Powers:        x^{2}  or  x^2
Roots:         \sqrt{x}  \sqrt[3]{x}
Absolute val:  |x|  or  \left|x\right|
Operators:     \times  \div  \pm  \leq  \geq  \neq  \approx
Greek:         \pi  \alpha  \beta  \theta  \Delta
Display eq:    \[...\]  or  $$...$$
Aligned sys:   \begin{align*} ... \end{align*}   (inside \[...\])
Bold text:     \textbf{...}    (renders as <strong>)
Italic text:   \textit{...}    (renders as <em>)
Underline:     \underline{...} (renders as <u>)
Line break:    \\  or  \newline  (renders as <br>)
```

### What NOT to Use

- `\cfrac` — use `\frac` instead (preprocessor converts it, but avoid)
- `\begin{enumerate}` / `\item` — preprocessor strips these; use plain text lists
- `\includegraphics` — use the `image_urls` column instead
- `\vspace`, `\hspace`, `\centering` — silently stripped; don't rely on spacing
- `\textcolor` — works (`\textcolor{red}{x}`) but use sparingly

---

## 4. Question Type: MCQ

### `options` Format

Always a JSONB array of exactly 4 objects. Choice IDs must be lowercase: `"a"`, `"b"`, `"c"`, `"d"`.

```json
[
  {"id": "a", "text": "Option A text"},
  {"id": "b", "text": "Option B text"},
  {"id": "c", "text": "Option C text"},
  {"id": "d", "text": "Option D text"}
]
```

Option text can contain LaTeX exactly like `prompt` — wrap math in `$...$`.

```json
[
  {"id": "a", "text": "$4x + 5 = 4x + 10$"},
  {"id": "b", "text": "$2(x + 3) = 2x + 6$"},
  {"id": "c", "text": "$3x + 1 = 3x - 1$"},
  {"id": "d", "text": "$5x + 2 = 2x + 5$"}
]
```

### `correct_answer`

Must match an option `id` exactly: `'a'`, `'b'`, `'c'`, or `'d'`.

### SQL Casting

Always cast the options string to JSONB:

```sql
'[{"id":"a","text":"..."}]'::jsonb
```

---

## 5. Question Type: SPR

Student Produced Response — student types in a numeric or short answer.

- `options` must be `NULL`
- `correct_answer` is the exact expected answer as a string
- SPR is **math section only** (DB constraint)

### SPR Answers

| Answer type | Example `correct_answer` |
|-------------|--------------------------|
| Integer | `'7'` |
| Decimal | `'3.5'` |
| Fraction (if needed) | `'7/2'` |
| Negative | `'-4'` |

Always use a string, even for numbers.

---

## 6. R&W Questions with Passages

Most R&W questions embed the passage directly in `prompt`. The `passage` column exists for future use (shared passages across multiple questions) but is not currently used by the frontend question renderer.

### Standard format — passage in prompt

Put the full passage text followed by the question in `prompt`. Separate them with a blank line.

```sql
'In 1869, Russian chemist Dmitri Mendeleev arranged elements by atomic weight
and noticed recurring patterns in their properties. He left gaps for undiscovered
elements, predicting their properties with remarkable accuracy.

Which choice best describes the main purpose of the text?'
```

### R&W Answer IDs

Use lowercase `"a"`, `"b"`, `"c"`, `"d"` — consistent with math questions. Legacy R&W seeds used uppercase `"A"`–`"D"` but new questions should use lowercase.

---

## 7. Questions with Images

Use the `image_urls` column (TEXT array). It supports multiple ordered images. `image_url` (singular) is legacy — don't use for new questions.

```sql
image_urls = ARRAY['https://ootnqmojcqnzfrtvzzec.supabase.co/storage/v1/object/public/sat-images/set1_math_m1_q14.png']
```

For multiple images:
```sql
image_urls = ARRAY[
  'https://.../figure1.png',
  'https://.../figure2.png'
]
```

Images are displayed above the question text. Reference them in `prompt` with phrasing like "In the figure above..." or "Based on the graph shown...".

---

## 8. Mock Set vs Practice Pool

| Use case | `set_number` | `module_number` |
|----------|-------------|----------------|
| Practice pool (not in any mock) | `0` | `0` |
| Mock set 1, Module 1 | `1` | `1` |
| Mock set 1, Module 2 (either track) | `1` | `2` |
| Mock set 2, Module 1 | `2` | `1` |
| Mock set 2, Module 2 (either track) | `2` | `2` |

For M2 easy vs hard track: both use `module_number=2`. They are distinguished by `difficulty_tier`:
- M2 easy track questions: `difficulty_tier = 'easy'`
- M2 hard track questions: `difficulty_tier = 'hard'`

### `qc_done` Flag

- Practice pool: `qc_done = false` at insert is fine; questions won't show until reviewed.
- Mock set questions: must set `qc_done = true` for them to appear in mock tests.

---

## 9. Required vs Optional Columns

### Always Required

```
type, section, prompt, correct_answer, difficulty_tier, module_number, set_number
```

### Required for MCQ

```
options  (JSONB array, cast with ::jsonb)
```

### Required for SPR

```
options = NULL  (explicit)
```

### Strongly Recommended

```
explanation, domain, bank_item_id
```

### Optional

```
passage, image_urls, chapter, subtopic
```

### Never Set at Insert

```
id, ai_explanation, ai_theory, created_at
```

---

## 10. Migration File Conventions

See `CLAUDE.md` for the full convention. Quick summary:

- **Path:** `supabase/migrations/sat/<timestamp>_<description>.sql`
- **Symlink:** also create at `supabase/migrations/<same filename>.sql`
- **Timestamp:** `YYYYMMDDHHMMSS`
- **Header comment:** describe what the migration does, source, and prerequisites

```sql
-- Math practice questions from sat_lid_007.tex (sat_lid_007)
-- Chapter: Systems of Equations | Topic: Substitution & Elimination
-- section=math, domain=algebra, module_number=0, set_number=0 (practice pool)
-- Requires: bank_item_id column (20260320120000_seed_sat_lid_001...)
```

---

## 11. Full INSERT Templates

### Math MCQ — Practice Pool

```sql
INSERT INTO public.sat_questions (
  type, section, prompt, options, correct_answer, explanation,
  domain, difficulty_tier, module_number, set_number, bank_item_id
)
VALUES
  (
    'mcq',
    'math',
    'Which of the following equations has infinitely many solutions?',
    '[{"id":"a","text":"$4x + 5 = 4x + 10$"},{"id":"b","text":"$2(x + 3) = 2x + 6$"},{"id":"c","text":"$3x + 1 = 3x - 1$"},{"id":"d","text":"$5x + 2 = 2x + 5$"}]'::jsonb,
    'b',
    'An equation has infinitely many solutions when both sides are identical.

Option B: distributing the 2 gives $2x + 6 = 2x + 6$, which is true for all $x$.',
    'algebra',
    'medium',
    0,
    0,
    'sat_lid_003_1'
  );
```

### Math SPR — Practice Pool

```sql
INSERT INTO public.sat_questions (
  type, section, prompt, options, correct_answer, explanation,
  domain, difficulty_tier, module_number, set_number, bank_item_id
)
VALUES
  (
    'spr',
    'math',
    'If $5x - 3 = 2x + 12$, what is the value of $x$?',
    NULL,
    '5',
    'Subtract $2x$ from both sides: $3x - 3 = 12$.

Add 3: $3x = 15$.

Divide by 3: $x = 5$.',
    'algebra',
    'medium',
    0,
    0,
    'sat_lid_001_24'
  );
```

### Math MCQ — Mock Set (with qc_done)

```sql
INSERT INTO public.sat_questions (
  type, section, prompt, options, correct_answer, explanation,
  domain, difficulty_tier, module_number, set_number, bank_item_id, qc_done
)
VALUES
  (
    'mcq',
    'math',
    'In the equation $3x + k = 3x + 9$, what value of $k$ gives infinitely many solutions?',
    '[{"id":"a","text":"0"},{"id":"b","text":"3"},{"id":"c","text":"9"},{"id":"d","text":"27"}]'::jsonb,
    'c',
    'For infinitely many solutions, both sides must be identical. $k = 9$ makes the equation $3x + 9 = 3x + 9$, true for all $x$.',
    'algebra',
    'easy',
    1,
    1,
    'sat_set1_m1_001',
    true
  );
```

### Math MCQ — With Image

```sql
INSERT INTO public.sat_questions (
  type, section, prompt, options, correct_answer, explanation,
  domain, difficulty_tier, module_number, set_number, bank_item_id,
  image_urls, qc_done
)
VALUES
  (
    'mcq',
    'math',
    'The figure above shows a right triangle. What is the length of the hypotenuse?',
    '[{"id":"a","text":"5"},{"id":"b","text":"10"},{"id":"c","text":"13"},{"id":"d","text":"15"}]'::jsonb,
    'c',
    'Using the Pythagorean theorem: $a^2 + b^2 = c^2$.

$5^2 + 12^2 = 25 + 144 = 169 = 13^2$.

The hypotenuse is $13$.',
    'geometry-trig',
    'easy',
    1,
    1,
    'sat_set1_m1_010',
    ARRAY['https://ootnqmojcqnzfrtvzzec.supabase.co/storage/v1/object/public/sat-images/set1_m1_q10.png'],
    true
  );
```

### R&W MCQ — Practice Pool

```sql
INSERT INTO public.sat_questions (
  type, section, prompt, options, correct_answer, explanation,
  domain, difficulty_tier, module_number, set_number, bank_item_id
)
VALUES
  (
    'mcq',
    'rw',
    'Maria Mitchell, the first professional female astronomer in the United States, discovered a comet in 1847 that now bears her name. She later became a professor and used her position to advocate for women in science, believing that ______ Which choice completes the text with the most logical transition?',
    '[{"id":"a","text":"curiosity, not gender, should determine who pursues scientific inquiry."},{"id":"b","text":"women were more suited to observational astronomy than men."},{"id":"c","text":"the comet she discovered proved her superior intellect."},{"id":"d","text":"universities were already welcoming to women in her era."}]'::jsonb,
    'a',
    'The passage establishes Mitchell as an advocate for women in science who believed in merit over gender barriers. Choice A correctly captures that logical completion. Choices B, C, and D introduce ideas not supported by the passage.',
    'information-ideas',
    'medium',
    0,
    0,
    'rw_practice_001_1'
  );
```

### Multiple Questions in One Migration

```sql
INSERT INTO public.sat_questions (
  type, section, prompt, options, correct_answer, explanation,
  domain, difficulty_tier, module_number, set_number, bank_item_id
)
VALUES
  (
    'mcq', 'math', 'Question 1 prompt...',
    '[{"id":"a","text":"A"},{"id":"b","text":"B"},{"id":"c","text":"C"},{"id":"d","text":"D"}]'::jsonb,
    'a', 'Explanation 1.', 'algebra', 'easy', 0, 0, 'sat_lid_XXX_1'
  ),
  (
    'spr', 'math', 'Question 2 — what is $x$?',
    NULL,
    '7', 'Explanation 2.', 'algebra', 'medium', 0, 0, 'sat_lid_XXX_2'
  ),
  (
    'mcq', 'math', 'Question 3 prompt...',
    '[{"id":"a","text":"A"},{"id":"b","text":"B"},{"id":"c","text":"C"},{"id":"d","text":"D"}]'::jsonb,
    'c', 'Explanation 3.', 'advanced-math', 'hard', 0, 0, 'sat_lid_XXX_3'
  );
```

---

## 12. Common Mistakes

### Double-escaping backslashes

```sql
-- WRONG — renders as literal \frac text (broken math)
'$\\frac{1}{2}$'

-- CORRECT
'$\frac{1}{2}$'
```

### Missing `::jsonb` cast

```sql
-- WRONG — options stored as text string, frontend fails to parse
'[{"id":"a","text":"Yes"}]'

-- CORRECT
'[{"id":"a","text":"Yes"}]'::jsonb
```

### SPR with non-NULL options

```sql
-- WRONG
'spr', ..., '[{"id":"a","text":"..."}]'::jsonb, ...

-- CORRECT
'spr', ..., NULL, ...
```

### MCQ correct_answer case mismatch

```sql
-- WRONG — 'A' won't match option id 'a'
correct_answer = 'A'

-- CORRECT
correct_answer = 'a'
```

### Forgetting qc_done for mock sets

```sql
-- WRONG — question exists but won't appear in tests (qc_done defaults to false)
INSERT INTO sat_questions (type, section, ...) VALUES ('mcq', 'math', ...)

-- CORRECT — explicitly set for mock set questions
INSERT INTO sat_questions (type, ..., qc_done) VALUES ('mcq', ..., true)
```

### Two dollar signs wrapping non-math text

```sql
-- DANGEROUS — "$45 plus $0.25" is parsed as inline math
'The cost is $45 plus $0.25 per mile.'

-- SAFE
'The cost is \$45 plus \$0.25 per mile.'
```

### bank_item_id collision

Each `bank_item_id` must be globally unique (unique index enforced). Naming scheme:

```
Practice math:   sat_lid_<chapter>_<q_num>       →  sat_lid_003_7
Mock set math:   sat_set<N>_<section>_m<M>_<q>   →  sat_set2_math_m1_015
Practice R&W:    rw_practice_<num>_<q_num>        →  rw_practice_001_4
Mock set R&W:    sat_set<N>_rw_m<M>_<q>          →  sat_set1_rw_m2e_008
```

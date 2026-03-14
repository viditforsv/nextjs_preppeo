# SAT Course Launch (V1) — LMS Interactive Template

Steps to launch an SAT course using the finalized LMS Interactive template. The template is fixed; this doc covers **data and rollout** only.

---

## 1. Prerequisites (already in place)

- **Template:** `courses_templates` has a row with `slug = 'lms-interactive'` (seeded by `20250301000001_seed_lms_interactive_template.sql` or `20250302000000_parallel_sat_quant_learn_course.sql`).
- **Migrations:** All LMS interactive migrations applied (`lesson_interactive_content`, `student_performance_log` with `skipped`, etc.).
- **Routes:** `/learn/[courseSlug]` and `/learn/[courseSlug]/lesson/[lessonSlug]` render only when the course’s template has `slug = 'lms-interactive'`.

---

## 2. Course record

- **Table:** `courses`
- **Required:** `slug` (e.g. `sat-quant-learn`), `title`, `template_id` = id of the `lms-interactive` template row, `status` (e.g. `published`), `instructor_id`.
- **Optional:** `description`, `price`, `thumbnail_url`, `curriculum` / `subject` for filters.

If you already ran the “parallel SAT” migration (`20250302000000_parallel_sat_quant_learn_course.sql`), the course **SAT Quant (Learn)** with slug `sat-quant-learn` exists and is linked to the template. Otherwise create the course and set `template_id` to the `lms-interactive` template id.

---

## 3. Structure: units → chapters → lessons

The Learn UI expects:

- **courses_units** — e.g. “Algebra”, “Problem Solving” (`course_id`, `unit_name`, `unit_order`).
- **courses_chapters** — e.g. “Linear Equations” under Algebra (`unit_id`, `chapter_name`, `chapter_order`).
- **courses_lessons** — each lesson (`course_id`, `chapter_id`, `title`, `slug`, `lesson_order`, `lesson_type`).

**Lesson types:** `video` | `pdf` | `interactive`. Only `interactive` shows Theory + Practice Questions with steps and quiz.

**Slug:** Must be unique per course. Example pattern: `sat-quant-learn-{topic-id}` (e.g. `sat-quant-learn-sat-lid-001`).

The parallel SAT migration copies structure from the existing SAT Quant course; you can instead create units/chapters/lessons manually or via an admin/script.

---

## 4. Interactive lesson content (Theory + Practice)

For each lesson that should use the interactive template (Theory + steps + practice questions):

1. Set **courses_lessons.lesson_type** = `'interactive'`.
2. Optionally set **concept_title**, **concept_content**, **formula_title**, **formula_content** on the lesson row (theory block and formula box).
3. Insert/update **lesson_interactive_content** for that lesson:
   - **intro** — short paragraph (optional).
   - **steps** — JSON array of `{ "title", "content", "equation?", "highlight?" }`.
   - **quiz** — JSON array of `{ "question", "options": [], "answer": number (0-based), "explanation" }`.

Example (one item in `quiz`):

```json
{
  "question": "Solve for x: 2x + 4 = 12",
  "options": ["x = 4", "x = 6", "x = 8", "x = 3"],
  "answer": 0,
  "explanation": "Subtract 4 from both sides: 2x = 8. Then divide by 2: x = 4."
}
```

Optional: add **"difficulty"** (`"Easy"` | `"Medium"` | `"Hard"`) and **"id"** (UUID) to each quiz item if you later wire to `question_bank` and `student_performance_log` for filters and history. For V1, inline quiz only is enough.

Reference migration: `20250302100000_sat_quant_learn_lesson_content.sql` (first lesson only). Duplicate the pattern for every interactive lesson.

---

## 5. How users reach the course

- **Enrolled users:** Student dashboard and “Enrolled” page already link lms-interactive courses to `/learn/{courseSlug}` (e.g. `/learn/sat-quant-learn`).
- **New users:** They need a way to **discover** and **enroll**:
  - Course landing or catalog that shows the SAT (Learn) course and an “Enroll” (or “Start”) CTA.
  - Enroll = insert into `courses_enrollments` (`student_id`, `course_id`, `is_active` = true). If you use payments, run that after payment success.

No code change is required for the template; ensure the course slug is used in your catalog/landing links and enrollment flow.

---

## 6. Optional: AI chatbot context

The AI Tutor uses **course title** and **lesson title** from the app (passed to `/api/courses/chatbot`). No extra setup is required; keep `courses.title` and `courses_lessons.title` clear so the AI responses are contextual.

---

## 7. Launch checklist (summary)

| Step | Action |
|------|--------|
| 1 | Ensure `lms-interactive` template exists and migrations are applied. |
| 2 | Ensure SAT course exists with correct `slug` and `template_id`. |
| 3 | Create or verify **units** → **chapters** → **lessons** for the full syllabus. |
| 4 | For each interactive lesson: set `lesson_type = 'interactive'`, then fill `lesson_interactive_content` (intro, steps, quiz). |
| 5 | Add course to catalog/landing and implement enrollment (insert `courses_enrollments`). |
| 6 | Test: open `/learn/sat-quant-learn` (and a lesson, e.g. `/learn/sat-quant-learn/lesson/sat-quant-learn-sat-lid-001`) as an enrolled user. |

---

## 8. Scaling content (post–V1)

- **More lessons:** Add rows to `courses_lessons` and, for interactive ones, to `lesson_interactive_content`. Reuse the same JSON shape for steps/quiz.
- **Question bank:** To get difficulty/topic filters and attempt history from a shared bank, add `question_bank` rows and set each quiz item’s `id` in `lesson_interactive_content.quiz` to the corresponding `question_bank.id`; the existing practice-questions API and sidebar already support it.
- **Hint vs explanation:** The app uses the first sentence of `explanation` as the hint when there is no separate `hint` field; you can add a `hint` field to quiz items later if you want distinct hints.

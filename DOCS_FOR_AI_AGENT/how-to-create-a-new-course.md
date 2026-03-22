# How to Create a New Course on Preppeo

This document is a step-by-step guide for an AI agent (or developer) to add a new practice-only course to the Preppeo platform. It uses the CBSE 10 Maths implementation as the canonical reference.

---

## Prerequisites

- A unique **course slug** (e.g. `cbse10-maths`, `ibdp-aahl`). Used in URLs, DB values, and file paths.
- A **display name** (e.g. "CBSE Class 10 Mathematics").
- A **color scheme** — a primary hex color for branding (e.g. `#d4d700`), a darker text variant (e.g. `#8a8c00`), and a light tint (e.g. `#f5f7c4`).
- A list of **domains/chapters** the course covers (e.g. 14 chapters for CBSE 10).
- The TeX question bank format should match the SAT format (see `scripts/generate-sat-lid-practice-sql.mjs` for reference).

---

## Step 1: Database Migrations

Create migrations under `supabase/migrations/<course-slug>/`.

### 1a. Questions table

File: `supabase/migrations/<slug>/YYYYMMDDHHMMSS_create_<slug>_questions.sql`

Reference: `supabase/migrations/cbse10/20260321100000_create_cbse10_maths_questions.sql`

Key points:
- Table name: `<slug_underscored>_questions` (e.g. `cbse10_maths_questions`)
- Columns: `id`, `type` (mcq/spr), `prompt`, `options` (JSONB), `correct_answer`, `explanation`, `domain` (with CHECK constraint listing all valid domains), `difficulty_tier` (easy/medium/hard), `chapter`, `subtopic`, `bank_item_id`, `image_url`, `is_active`, `ai_explanation`, `ai_theory`, `qc_done`, `created_at`
- No `section`, `module_number`, or `set_number` (those are SAT-specific for mock tests)
- Indexes on `domain`, `difficulty_tier`, `chapter`, `subtopic`, `bank_item_id` (unique)
- RLS: public read, admin manage

### 1b. Shared tables (one-time setup, already done)

These shared tables already exist and support all courses:
- `practice_answers` — per-question answer tracking. Has `course TEXT` column.
- `practice_daily_usage` — freemium daily limits. Has `course TEXT` column. The `claim_practice_usage` function accepts `p_course TEXT DEFAULT 'sat'`.
- `user_subscriptions` — subscriptions. Filtered by `exam_type`.

### 1c. Subscription plans

File: `supabase/migrations/<slug>/YYYYMMDDHHMMSS_seed_<slug>_subscription_plans.sql`

Reference: `supabase/migrations/cbse10/20260321100003_seed_cbse10_subscription_plans.sql`

Insert rows into `subscription_plans` with `exam_type = '<course-slug>'`.

### 1d. QC column

File: `supabase/migrations/<slug>/YYYYMMDDHHMMSS_<slug>_add_qc_done.sql`

```sql
ALTER TABLE public.<table_name> ADD COLUMN qc_done BOOLEAN NOT NULL DEFAULT false;
```

---

## Step 2: TypeScript Types

File: `src/types/<course-slug>.ts`

Reference: `src/types/cbse10-maths.ts`

Define:
- `<Course>Domain` — union type of all domain strings
- `DifficultyTier` — `'easy' | 'medium' | 'hard'`
- `QuestionType` — `'mcq' | 'spr'`
- `QuestionOption` — `{ id: string; text: string }`
- `<Course>Question` — question interface (id, type, difficulty, domain, chapter, subtopic, prompt, options, correctAnswer, explanation, imageUrl)
- `<Course>PracticeConfig` — domains, chapters, subtopics, difficulty, questionCount
- `<Course>PracticePhase` — `'landing' | 'practice-config' | 'in-practice' | 'practice-summary' | 'analytics'`
- `PracticeAnswer` — for answer tracking
- `ChapterAnalytics`, `AnalyticsData` — for the analytics dashboard

---

## Step 3: Zustand Store

File: `src/stores/use<Course>Store.ts`

Reference: `src/stores/useCBSE10MathsStore.ts`

Practice-only store with:
- State: `phase`, `practiceQuestions`, `practiceAnswers`, `practiceRevealed`, `practiceExplanations`, `practiceLoading`, `practiceTheory`, `practiceTheoryLoading`, `practiceIndex`, `practiceTimestamps`, `practiceConfig`, `isCalculatorOpen`
- Actions: `goToLanding()`, `goToPracticeConfig()`, `goToAnalytics()`, `startPracticeMode(config)`, `setPracticeAnswer(qId, value)`, `revealAnswer(qId)`, `fetchTheory(qId)`, `navigatePractice(idx)`, `finishPractice()`, `toggleCalculator()`
- `startPracticeMode` fetches from `/api/<course-slug>/practice-questions`
- `revealAnswer` POSTs to `/api/<course-slug>/record-answer` and fetches AI explanation from `/api/sat/explain` with `course: '<course-slug>'`
- `fetchTheory` calls `/api/sat/explain` with `mode: 'theory'` and `course: '<course-slug>'`

Important: Update the explain endpoint's `COURSE_TABLE` map in `src/app/api/sat/explain/route.ts` to include the new course's table.

---

## Step 4: API Routes

Create under `src/app/api/<course-slug>/`.

### 4a. `GET /practice-questions`

Reference: `src/app/api/cbse10-maths/practice-questions/route.ts`

- Queries `<table>` with filters: `domains`, `chapters`, `subtopics`, `difficulty`, `count`
- Premium check via `user_subscriptions`
- Freemium: uses `claim_practice_usage` with `p_course = '<course-slug>'`
- No `section` filter needed

### 4b. `GET /practice-filters`

Reference: `src/app/api/cbse10-maths/practice-filters/route.ts`

- Returns hierarchical domain > chapter > subtopic structure from the questions table

### 4c. `GET /practice-usage`

Reference: `src/app/api/cbse10-maths/practice-usage/route.ts`

- Checks subscription status and daily usage filtered by `course = '<course-slug>'`

### 4d. `POST /record-answer`

Reference: `src/app/api/cbse10-maths/record-answer/route.ts`

- Inserts into `practice_answers` with `course = '<course-slug>'`

### 4e. `GET /analytics`

Reference: `src/app/api/cbse10-maths/analytics/route.ts`

- Aggregates `practice_answers` by domain for the user, returns accuracy and strongest/weakest areas

### 4f. Update shared explain endpoint

In `src/app/api/sat/explain/route.ts`, add the new course to the `COURSE_TABLE` constant:

```typescript
const COURSE_TABLE: Record<string, string> = {
  sat: 'sat_questions',
  'cbse10-maths': 'cbse10_maths_questions',
  '<new-course>': '<new_table>',       // <-- add this
};
```

---

## Step 5: UI Components

Create under `src/components/<course-slug>/`.

### 5a. Landing Page

File: `src/components/<course-slug>/LandingScreen.tsx`

Reference: `src/components/cbse10-maths/LandingScreen.tsx`

Layout matches the SAT landing page (`src/components/sat-test/LandingScreen.tsx`):
- 2-column grid with "Practice Mode" and "My Analytics" cards
- Each card has an icon, title, subtitle, feature list, and CTA
- Course branding colors via inline `style` attributes (not Tailwind classes, since colors are arbitrary hex)
- Footer listing all chapters/domains
- "Back to Home" link

Color application pattern:
- Solid backgrounds (icon tiles, CTAs): `style={{ backgroundColor: '<primary>' }}` with `text-gray-900` (for bright colors) or `text-white` (for dark colors)
- Text on white backgrounds: `style={{ color: '<darker-variant>' }}`
- Light tint fills: `style={{ backgroundColor: '<light-tint>' }}`

### 5b. Practice Config Screen

File: `src/components/<course-slug>/PracticeConfigScreen.tsx`

Reference: `src/components/cbse10-maths/PracticeConfigScreen.tsx`

- Fetches usage from `/api/<course-slug>/practice-usage`
- Fetches filters from `/api/<course-slug>/practice-filters`
- Domain/chapter/subtopic cascading pill selectors
- Difficulty and question count selectors (premium only)
- Free plan info banner with remaining questions
- Start button calls store's `startPracticeMode`

### 5c. Practice View

File: `src/components/<course-slug>/PracticeView.tsx`

Reference: `src/components/cbse10-maths/PracticeView.tsx`

- Header bar with course name and review count
- Question display with domain/subtopic badges
- MCQ options or SPR text input
- "Check Answer" button → reveals correct/incorrect + AI explanation
- "Deep Dive: Theory" button
- Footer with Back/Next navigation, question palette, calculator toggle, Finish button

### 5d. Practice Summary

File: `src/components/<course-slug>/PracticeSummary.tsx`

Reference: `src/components/cbse10-maths/PracticeSummary.tsx`

- Score percentage, correct/incorrect/skipped counts
- Domain breakdown with progress bars
- Expandable question review with explanations

### 5e. Analytics Dashboard

File: `src/components/<course-slug>/AnalyticsDashboard.tsx`

Reference: `src/components/cbse10-maths/AnalyticsDashboard.tsx`

- Fetches from `/api/<course-slug>/analytics`
- Overall accuracy percentage
- Strongest/weakest chapters
- Chapter-wise accuracy bars (color-coded: green >= 70%, amber >= 40%, red < 40%)

### 5f. Page Route

File: `src/app/<course-slug>/page.tsx`

Reference: `src/app/cbse10-maths/page.tsx`

Phase-based switch:

```tsx
switch (phase) {
  case 'landing': return <LandingScreen />;
  case 'practice-config': return <PracticeConfigScreen />;
  case 'in-practice': return <PracticeView />;
  case 'practice-summary': return <PracticeSummary />;
  case 'analytics': return <AnalyticsDashboard />;
}
```

---

## Step 6: QC Page (Admin)

**IMPORTANT: Use `src/app/admin/sat-questions-qc/page.tsx` as the canonical benchmark for all QC pages.** It has the most complete feature set. When creating a new QC page, start from SAT QC and adapt (remove SAT-specific fields like `section`, `passage`, `moduleNumber`, `setNumber`; add course-specific fields).

### 6a. Admin API

Directory: `src/app/api/admin/<course-slug>-questions/`

Reference: `src/app/api/admin/sat-questions/route.ts`

Three files:
- `route.ts` — GET all questions + PATCH editable fields + DELETE (soft-delete via `is_active = false`). Ensure `options` is in `ALLOWED_FIELDS` so JSON options are editable.
- `regenerate-ai/route.ts` — regenerate AI explanation/theory with course-specific prompts
- `upload-image/route.ts` — upload/replace/remove images (can reuse `sat-question-images` bucket with a subfolder prefix like `<slug>/`)

### 6b. QC Page

File: `src/app/admin/<course-slug>-qc/page.tsx`

Reference: `src/app/admin/sat-questions-qc/page.tsx` (primary benchmark)

Required features (all present in SAT QC):
- Filters: Domain (chapters), Topic, Subtopic, Difficulty, QC status
- **UUID search**: input field + Go button to jump to any question by ID (or `bankItemId`). Auto-clears filters if the question is hidden.
- View mode: metadata badges, rendered prompt/options, explanation, AI content, image
- Edit mode: editable metadata, prompt, options JSON (with raw string state — do NOT use `JSON.stringify` as `value` directly), explanation, AI fields
- **Delete button**: soft-deletes the question (sets `is_active = false`). Shown in edit mode save bar.
- QC toggle button in sticky bottom bar
- Image upload/replace/remove
- AI regeneration
- Keyboard navigation (arrows, E to edit, Cmd+Enter to save)

### 6c. Admin Link

Update `src/app/admin/site-administration/page.tsx` to add a link to the new QC page.

---

## Step 7: Main Page Link

Update `src/app/page.tsx` — add the new course to the `exams` array:

```typescript
{
  name: "<Display Name>",
  description: "<Short description>",
  gradient: "from-<color1> to-<color2>",
  testRoute: "/<course-slug>",
  courseQuery: "<COURSE>",
  live: true,
},
```

---

## Step 8: Generator Script

File: `scripts/generate-<slug>-lid-practice-sql.mjs`

Reference: `scripts/generate-cbse10m-lid-practice-sql.mjs`

Fork with:
- `UNIT_TO_DOMAIN` mapping for the new course's chapters
- Target table: `<table_name>`
- `bank_item_id` prefix: `<slug>_lid_{LID}_{Q}`
- No `section`, `module_number`, `set_number` columns
- `--tex-dir=` flag to specify TeX file location
- `--generate-backfill` for metadata backfill

Usage:
```bash
node scripts/generate-<slug>-lid-practice-sql.mjs --lid=1 --tex-dir=path/to/tex
```

---

## Checklist Summary

1. [ ] DB migration: questions table
2. [ ] DB migration: subscription plans
3. [ ] DB migration: qc_done column
4. [ ] TypeScript types file
5. [ ] Zustand store
6. [ ] API: practice-questions
7. [ ] API: practice-filters
8. [ ] API: practice-usage
9. [ ] API: record-answer
10. [ ] API: analytics
11. [ ] Update: shared explain endpoint COURSE_TABLE
12. [ ] UI: LandingScreen
13. [ ] UI: PracticeConfigScreen
14. [ ] UI: PracticeView
15. [ ] UI: PracticeSummary
16. [ ] UI: AnalyticsDashboard
17. [ ] UI: Page route
18. [ ] Admin API: GET+PATCH, regenerate-ai, upload-image
19. [ ] Admin: QC page
20. [ ] Admin: site-administration link
21. [ ] Main page: exams array entry
22. [ ] Generator script
23. [ ] Seed questions (run generator on TeX files)
24. [ ] Run migrations on Supabase

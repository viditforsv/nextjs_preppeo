# Digital SAT Ecosystem — Overview

## Full Digital SAT Structure

The Digital SAT is a multi-stage adaptive test consisting of two sections taken in a fixed order:

| Section              | Module 1         | Module 2 (Adaptive)  | Total        |
|----------------------|------------------|----------------------|--------------|
| Reading & Writing    | 27 questions, 32 min | 27 questions, 32 min | 54 questions, 64 min |
| **10-minute break**  |                  |                      |              |
| Math                 | 22 questions, 35 min | 22 questions, 35 min | 44 questions, 70 min |

**Total:** 98 questions, ~2 hours 14 minutes + 10-min break

### Key Rules
- Order is fixed: Reading & Writing first, then Math. Students cannot choose.
- Each section's Module 2 difficulty adapts based on Module 1 performance.
- R&W is all multiple choice. Math includes MCQ and student-produced response (SPR).
- Calculator (Desmos) is available only during the Math section.

### Scoring
- Reading & Writing: 200–800
- Math: 200–800
- Total: 400–1600

### Domains

**Reading & Writing:**
- Craft & Structure
- Information & Ideas
- Standard English Conventions
- Expression of Ideas

**Math:**
- Algebra
- Advanced Math
- Problem Solving & Data Analysis
- Geometry & Trigonometry

---

## Current Implementation Status

### Implemented
- **Math adaptive test** — Module 1 (mixed) → Module 2 (hard/easy based on M1 score)
- **Reading & Writing adaptive test** — Module 1 (mixed) → Module 2 (hard/easy based on M1 score), 243 questions seeded across 3 sets
- **Combined test flow** — R&W → 10-min break → Math in one session, matching real Digital SAT order
- **Combined scoring** — R&W 200–800, Math 200–800, Total 400–1600
- **Question types** — MCQ and SPR with math rendering; R&W includes passage display
- **Per-question tracking** — Time spent, visit count, flags for both sections
- **Results UI** — Tabbed report: Score Overview (per-section + total), Domain Breakdown (filterable by section), Difficulty Breakdown, Time Analysis, Question Review (filterable by section)
- **Data persistence** — `sat_test_attempts` table with full question response data for both R&W and Math
- **Token-based access** — Purchase tokens via Razorpay, enter access code to start
- **Email delivery** — SMTP (ZeptoMail) sends access codes to buyers
- **Auth gating** — Users must sign in before starting a test
- **Realistic test mode** — No difficulty labels, M1 scores, or domain labels shown during the test, matching the real Bluebook experience

### Not Yet Implemented
- **Practice mode** — Placeholder exists, no implementation
- **Score history / dashboard** — Attempts are saved but no student-facing page to view past results

---

## Roadmap

| Stage | Feature | Status |
|-------|---------|--------|
| 1 | R&W section + combined full-test flow | ✅ Complete |
| 2 | SAT score history on student dashboard | Planned |
| 3 | Practice mode (question bank exists as .tsv/.tex files) | Planned |

---

## Database Tables

- `sat_questions` — Question bank (Math + R&W), with `section`, `passage`, `domain`, `difficulty_tier`, `module_number`, `set_number`
- `sat_test_attempts` — Per-attempt results with module-level and question-level data for both sections
- `test_tokens` — Access codes linked to purchases

---

## Key Files

| File | Purpose |
|------|---------|
| `src/stores/useSATTestStore.ts` | Zustand store: full test flow state and actions |
| `src/app/sat-test/page.tsx` | Page routing by phase |
| `src/types/sat-test.ts` | All SAT-related TypeScript types |
| `src/lib/sat-scoring.ts` | Raw-to-scaled score curves (Math + R&W) |
| `src/app/api/sat/questions/route.ts` | Fetch questions by section/module/set |
| `src/app/api/sat/attempts/route.ts` | Persist test attempt results |
| `src/components/sat-test/` | All UI components (landing, test view, results) |

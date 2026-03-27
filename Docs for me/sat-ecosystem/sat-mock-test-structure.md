# SAT Mock Test Structure — Locked Template

Last updated: 2026-03-27

---

## Overview

The SAT mock test system is separate from the LMS course. Questions live in `sat_questions`; attempts in `sat_test_attempts`. Each mock is identified by `set_number` (1–N).

**Questions stored per set:**

| Section | M1 | M2 Easy track | M2 Hard track | Total |
|---------|----|---------------|---------------|-------|
| Math | 22 | 22 | 22 | 66 |
| R&W | 27 | 27 | 27 | 81 |
| **Per set total** | | | | **147** |

**M2 routing thresholds:**
- Math: ≥15/22 correct on M1 → Hard M2; <15 → Easy M2
- R&W: ≥14/27 correct on M1 → Hard M2; <14 → Easy M2

---

## R&W Module Template (locked 2026-03-27)

Mirrors College Board Digital SAT domain percentages exactly.

**Domain distribution — applies to all 3 modules (M1, M2 Easy, M2 Hard):**

| Domain | Questions | CB % |
|--------|-----------|------|
| Craft & Structure (CS) | 8 | 28% |
| Information & Ideas (II) | 7 | 26% |
| Expression of Ideas (EI) | 5 | 20% |
| Standard English Conventions (SEC) | 7 | 26% |
| **Total** | **27** | 100% |

---

### M1 — Balanced (routes students to M2 tier)

| Domain | Easy | Medium | Hard | Total |
|--------|------|--------|------|-------|
| CS | 3 | 3 | 2 | 8 |
| II | 2 | 3 | 2 | 7 |
| EI | 1 | 2 | 2 | 5 |
| SEC | 2 | 2 | 3 | 7 |
| **Total** | **8** | **10** | **9** | **27** |

---

### M2 Easy — Easy-leaning (lower scorers, score cap ~570)

| Domain | Easy | Medium | Hard | Total |
|--------|------|--------|------|-------|
| CS | 4 | 3 | 1 | 8 |
| II | 3 | 3 | 1 | 7 |
| EI | 2 | 2 | 1 | 5 |
| SEC | 3 | 3 | 1 | 7 |
| **Total** | **12** | **11** | **4** | **27** |

---

### M2 Hard — Hard-leaning (higher scorers, full range to 800)

| Domain | Easy | Medium | Hard | Total |
|--------|------|--------|------|-------|
| CS | 1 | 3 | 4 | 8 |
| II | 1 | 2 | 4 | 7 |
| EI | 1 | 1 | 3 | 5 |
| SEC | 1 | 2 | 4 | 7 |
| **Total** | **4** | **8** | **15** | **27** |

---

## Math Module Template (reference)

### M1 — Balanced (22q)

| Domain | Easy | Medium | Hard | Total |
|--------|------|--------|------|-------|
| Algebra | 2 | 4 | 2 | 8 |
| Advanced Math | 1 | 4 | 2 | 7 |
| Geometry & Trig | 1 | 2 | 1 | 4 |
| Problem Solving | 1 | 2 | 0 | 3 |
| **Total** | **5** | **12** | **5** | **22** |

### M2 Easy (22q)

`difficulty_tier = 'easy'` in DB (indicates track, not individual question difficulty).

| Domain | Count |
|--------|-------|
| Algebra | 7 |
| Advanced Math | 7 |
| Geometry & Trig | 4 |
| Problem Solving | 4 |
| **Total** | **22** |

### M2 Hard (22q)

`difficulty_tier = 'hard'` in DB (indicates track, not individual question difficulty).

| Domain | Count |
|--------|-------|
| Advanced Math | 8 |
| Algebra | 7 |
| Geometry & Trig | 4 |
| Problem Solving | 3 |
| **Total** | **22** |

---

## DB Conventions for Mock Questions

| Column | R&W M1 | R&W M2 | Math M1 | Math M2 |
|--------|--------|--------|---------|---------|
| `module_number` | 1 | 2 | 1 | 2 |
| `difficulty_tier` | actual difficulty (easy/medium/hard) | track label ('easy'/'hard') | actual difficulty | track label ('easy'/'hard') |
| `set_number` | set id (1–N) | set id (1–N) | set id (1–N) | set id (1–N) |
| `section` | 'rw' | 'rw' | 'math' | 'math' |
| `qc_done` | true | true | true | true |

Practice questions (not in any mock): `set_number = 0`, `module_number = 0`.

---

## Mock Set Status (as of 2026-03-27)

| Set | Math M1 | Math M2E | Math M2H | RW M1 | RW M2E | RW M2H |
|-----|---------|----------|----------|-------|--------|--------|
| 1 | ✅ 22q | ✅ 22q | ✅ 22q | ✅ 27q | ❌ single domain | ❌ single domain |
| 2 | ✅ 22q | ✅ 22q | ✅ 22q | ✅ 27q | ❌ single domain | ❌ single domain |
| 3 | ✅ 22q | ✅ 22q | ✅ 22q | ✅ 27q | ❌ single domain | ❌ single domain |
| 4 | ✅ 22q | ✅ 22q | ✅ 22q | ❌ empty | ❌ empty | ❌ empty |
| 5 | ✅ 22q | ✅ 22q | ✅ 22q | ❌ empty | ❌ empty | ❌ empty |

R&W M2 for sets 1–3 was incorrectly seeded with a single domain each (not all 4). These need to be rebuilt to match the locked template above.

---

## Gap Analysis (run 2026-03-27)

### Total R&W questions needed: 405 (5 sets × 3 modules × 27)

| Domain | Difficulty | M1 ×5 | M2E ×5 | M2H ×5 | Total needed | Available | Gap |
|--------|-----------|--------|--------|--------|-------------|-----------|-----|
| CS | easy | 15 | 20 | 5 | 40 | 68 | +28 |
| CS | medium | 15 | 15 | 15 | 45 | 68 | +23 |
| CS | hard | 10 | 5 | 20 | 35 | 64 | +29 |
| II | easy | 10 | 15 | 5 | 30 | 137 | +107 |
| II | medium | 15 | 15 | 10 | 40 | 134 | +94 |
| II | hard | 10 | 5 | 20 | 35 | 127 | +92 |
| EI | easy | 5 | 10 | 5 | 20 | 32 | +12 |
| **EI** | **medium** | 10 | 10 | 5 | **25** | **19** | **−6** |
| EI | hard | 10 | 5 | 15 | 30 | 35 | +5 |
| SEC | easy | 10 | 15 | 5 | 30 | 34 | +4 |
| **SEC** | **medium** | 10 | 15 | 10 | **35** | **29** | **−6** |
| **SEC** | **hard** | 15 | 5 | 20 | **40** | **37** | **−3** |

### Questions to author: 15 total

| Domain | Difficulty | Count | Notes |
|--------|-----------|-------|-------|
| Expression of Ideas | Medium | 6 | |
| Standard English Conventions | Medium | 6 | |
| Standard English Conventions | Hard | 3 | |
| **Total** | | **15** | |

> SEC easy (+4) and EI easy (+12) surplus is thin — avoid accidentally consuming these in practice pool usage.

### M1 adjustments needed for sets 1–3

Existing M1s were seeded before the template was locked. Under the new template:

| Domain | Old count/set | New count/set | Action |
|--------|--------------|--------------|--------|
| CS | 7 | 8 | Pull 1 CS question from pool per set (+3 total) |
| II | 6 | 7 | Pull 1 II question from pool per set (+3 total) |
| EI | 7 | 5 | Return 2 EI questions to pool per set (−6 total) |
| SEC | 7 | 7 | No change |

All adjustable from existing surpluses — no new questions needed.

---

## Seeding Roadmap

1. ~~Lock template~~ ✅
2. ~~Run gap audit~~ ✅
3. **Author 15 new questions** (6 EI medium · 6 SEC medium · 3 SEC hard) → seed into practice pool (`set_number=0, module_number=0`)
4. **Fix M1 for sets 1–3** — adjust CS/II/EI counts to match template
5. **Rebuild M2 for sets 1–3** — replace single-domain M2s with proper 4-domain structure
6. **Build R&W M1 + M2E + M2H for sets 4–5** — assign from pool

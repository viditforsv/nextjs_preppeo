# CLAUDE.md — Preppeo Project Rules

## 1. Supabase Project

| | Value |
|-|-------|
| Project name | `preppeo_lms_prod` |
| Prod project ID | `ootnqmojcqnzfrtvzzec` |
| Dev branch ID | `dxhxpfouzjlzpeazwrqo` |
| Prod URL env var | `NEXT_PUBLIC_SUPABASE_URL_PROD` |
| Prod service key env var | `SUPABASE_SERVICE_ROLE_KEY_PROD` |
| Dev URL env var | `NEXT_PUBLIC_SUPABASE_URL` (default in `.env.local`) |
| Dev service key env var | `SUPABASE_SERVICE_ROLE_KEY` |

## 2. Data Flow: Dev → Prod (CRITICAL)

**All data changes go to dev first. Never write directly to prod.**

```
Seed / migrate → dev branch → QC review → promote to prod
```

- All `execute_sql`, `apply_migration`, and seeding scripts must target the **dev branch** (`dxhxpfouzjlzpeazwrqo`) unless explicitly instructed otherwise.
- QC (question review, data validation) happens on dev.
- Only after QC sign-off does data move to prod — either via Supabase branch merge or by re-running the migration against prod.
- If I am about to write to prod directly, I must **stop and confirm with the user first**.

## 3. Migration File Convention

- Every DB change must be accompanied by a migration file.
- Location: `supabase/migrations/sat/<timestamp>_<description>.sql` for SAT work; `supabase/migrations/<timestamp>_<description>.sql` for everything else.
- **No symlinks.** Migrations are applied manually via the Supabase MCP tool, not via CLI.
- Already-applied migrations live in `supabase/migrations/applied/` for reference.
- Timestamp format: `YYYYMMDDHHMMSS` (e.g. `20260327110000`).
- Include a comment header explaining what the migration does, the template it follows, and any prerequisites.

## 4. SAT Question DB Conventions (`sat_questions` table)

| Column | Meaning |
|--------|---------|
| `set_number` | 0 = practice pool; 1–N = mock set number |
| `module_number` | 0 = practice pool; 1 = M1; 2 = M2 |
| `section` | `'math'` or `'rw'` |
| `difficulty_tier` | On **M1**: actual difficulty (`easy`/`medium`/`hard`). On **M2**: adaptive track label (`'easy'` = easy track, `'hard'` = hard track) — NOT individual question difficulty. |
| `domain` | R&W: `craft-structure`, `information-ideas`, `expression-of-ideas`, `standard-english`. Math: `algebra`, `advanced-math`, `geometry-trig`, `problem-solving`. |
| `qc_done` | Must be `true` for questions to appear on the frontend. Always set `qc_done=true` when assigning questions to a mock set. |
| `is_active` | Must be `true`. Always include `is_active=true` in pool queries. |

## 5. SAT Mock Test Structure (Locked 2026-03-27)

**Per set: 147 questions** (66 math + 81 R&W)

### R&W Template (27q per module)

| Domain | M1 | M2E | M2H |
|--------|----|-----|-----|
| Craft & Structure | 8 (3E+3M+2H) | 8 (4E+3M+1H) | 8 (1E+3M+4H) |
| Information & Ideas | 7 (2E+3M+2H) | 7 (3E+3M+1H) | 7 (1E+2M+4H) |
| Expression of Ideas | 5 (1E+2M+2H) | 5 (2E+2M+1H) | 5 (1E+1M+3H) |
| Standard English | 7 (2E+2M+3H) | 7 (3E+3M+1H) | 7 (1E+2M+4H) |

### Math Template

- M1 (22q): Algebra 8 (2E+4M+2H), Adv Math 7 (1E+4M+2H), Geo 4 (1E+2M+1H), PS 3 (1E+2M)
- M2E (22q): `difficulty_tier='easy'` — Adv Math 7 (med pool), Algebra 7 (easy), Geo 4 (easy), PS 4 (easy)
- M2H (22q): `difficulty_tier='hard'` — Adv Math 8 (hard), Algebra 7 (hard), Geo 4 (hard), PS 3 (hard)

### M2 Routing Thresholds

- Math: ≥15/22 on M1 → Hard M2; <15 → Easy M2
- R&W: ≥14/27 on M1 → Hard M2; <14 → Easy M2

### Current Mock Set Status (as of 2026-03-27) — PROD only

Sets 1–5 fully built in both **prod and dev** (synced 2026-03-27). Both branches are identical.

## 6. Seeding Scripts

- Scripts that seed question data must use dev env vars by default.
- To explicitly target prod (only when instructed after QC sign-off), use `NEXT_PUBLIC_SUPABASE_URL_PROD` + `SUPABASE_SERVICE_ROLE_KEY_PROD`.
- Never hardcode project IDs or keys in scripts — always read from env vars.

## 7. General Rules

- Always read a file before editing it.
- Do not create helper scripts or abstractions for one-off tasks.
- Do not add features beyond what was asked.

## 8. Autonomy — When to Ask vs Just Do

**Proceed without asking for anything local or dev:**
- Reading, writing, editing, or creating any local file (code, migrations, configs, docs)
- Running any SELECT query on dev or prod
- Running any INSERT/UPDATE/DELETE on the **dev branch**
- Creating migration files and symlinks
- Installing packages, running build/lint/type-check/test commands
- Running any shell command that only affects the local environment
- Creating new components, pages, API routes, or utilities
- Refactoring or restructuring code
- Deploying to a preview/staging environment

**Stop and confirm only for:**
- Writing to **prod** (any INSERT/UPDATE/DELETE on project `ootnqmojcqnzfrtvzzec`)
- Permanently deleting or dropping tables/data
- Pushing to remote git or opening/merging PRs
- Anything visible to or affecting live users

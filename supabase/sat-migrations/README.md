# SAT migration scripts

This folder holds all SAT Quant (Learn) course migrations: course/lesson content and question-bank seed scripts.

**Applying these migrations:** Supabase CLI only runs files in `supabase/migrations/`. To apply SAT migrations, copy them into that folder (run from repo root):

```bash
cp supabase/sat-migrations/*.sql supabase/migrations/
supabase db push
```

Or run the sync script:

```bash
./supabase/sat-migrations/sync-to-migrations.sh
```

**Order:** Files are named with timestamps so they run in the correct order when combined with the rest of `supabase/migrations/`.

- Course + subject: `20250302000000`, `20250302100000`, `20250303100000`
- Lesson content (theory + quiz JSON): `20250302100001` … `20250302100025` (lid 002–026)
- Clean + question-bank seeds: `20250305100000` (clean), then `20250305100001` … (lid 002, 003, …)
- LID 001 seeds: `20250303110000`, `20250303120000`

**From LID 027 onward (fresh pattern):**
- **Content migration** (e.g. `20250306100000_sat_quant_learn_lid027_content.sql`): Theory + steps + intro only; **quiz = []** (no inline quiz JSON).
- **Seed migration** (e.g. `20250306100001_seed_sat_lid_027_questions.sql`): INSERT questions into `question_bank` first, then create quiz, link via `quiz_questions`, then rebuild `lesson_interactive_content.quiz` from `question_bank`. Add new questions by adding more INSERT rows; the DO blocks pick up all `sat_lid_027_*` (or the relevant lid) by order.

# SAT migrations (`supabase/migrations/sat`)

SQL for **SAT Digital** practice and test data (`sat_questions`, attempts, R\&W seeds tied to the SAT app, images bucket, practice monetization helpers).

## Why this folder exists

The Supabase CLI only runs `*.sql` files that sit **directly** under `supabase/migrations/` (it ignores subdirectories). To keep SAT changes grouped while staying CLI-compatible, each file here is also linked from the parent:

```text
supabase/migrations/20260310100000_create_sat_questions.sql  →  sat/20260310100000_create_sat_questions.sql
```

Edit the real file under `sat/`. If you add a **new** migration, create the file in `sat/` and add a symlink next to its peers:

```bash
cd supabase/migrations
ln -sf sat/20260320130000_seed_sat_lid_002_practice_sat_questions.sql ./20260320130000_seed_sat_lid_002_practice_sat_questions.sql
```

## Quant bank → `sat_questions`

For lesson packs (`lid_XXX.tex`), generate seeds with:

```bash
node scripts/generate-sat-lid-practice-sql.mjs --lid=2
```

Use `--bank-ddl` only when bootstrapping `bank_item_id` on an empty project (already included in the lid_001 seed).

# TSV Workflow

## 1. Pull (Google Sheet → local TSV files)
```
node scripts/cbse10-science-sheets-sync.mjs --pull
```
all 17 files updated at once in push and pull
## 2. Push (local TSV files → Google Sheet)
```
node scripts/cbse10-science-sheets-sync.mjs --push
```

## 3. Convert TSV → SQL migration
```
node scripts/cbse10-science-tsv-to-sql.mjs "Docs for me/latex_with_rijay/cbse_10_science/12_electricity/questions.tsv" --out=supabase/migrations/cbse10-science/20260325120000_seed_electricity.sql
```

one chapter at a time, sql file names are timestamped. 

> All commands run from project root: `nextjs_preppeo/`

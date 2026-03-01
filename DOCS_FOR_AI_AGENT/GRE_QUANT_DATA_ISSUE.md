# GRE Quant Data Issue - Analysis & Solution

## Problem Summary

The GRE quant data system is not working because the `gre_questions` table was never created in Supabase, but a later migration tries to ALTER it.

## Current State

### ✅ What Exists:
- 1 GRE course: "GRE Quant" (slug: `gre-quant`)
- 1 GRE question in `question_bank` table (subject: "GRE Math")
- Migration file: `20251221153306_add_gre_study_features.sql` (tries to ALTER `gre_questions`)

### ❌ What's Missing:
- `gre_questions` table (does not exist)
- `gre_user_bookmarks` table (depends on `gre_questions`)
- `gre_user_notes` table (depends on `gre_questions`)
- `gre_user_flashcards` table (depends on `gre_questions`)

## Root Cause

The migration `20251221153306_add_gre_study_features.sql` attempts to:
```sql
ALTER TABLE public.gre_questions
ADD COLUMN IF NOT EXISTS explanation text,
...
```

But the `gre_questions` table was never created in the first place. This causes the migration to fail silently or error out.

## Solution

A new migration has been created: `20250116000000_create_gre_questions_table.sql`

This migration:
1. Creates the `gre_questions` table with proper structure
2. Includes all base fields needed for GRE questions
3. Sets up indexes and RLS policies
4. Runs BEFORE the study features migration (date: 20250116 < 20251221)

### Table Structure

The `gre_questions` table includes:
- `id` (uuid, primary key)
- `type` (single-choice, multi-select, numeric-entry, text-select)
- `prompt` (question text, supports HTML + LaTeX)
- `passage_id` (optional, for verbal questions)
- `options` (JSONB array of answer options)
- `correct_answer` (text or JSON for multi-select)
- `section_type` (verbal or quantitative)
- `difficulty` (1-10 scale)
- `is_active` (boolean)
- `created_at`, `updated_at` (timestamps)

The study features migration will then add:
- `explanation` (text)
- `hints` (JSONB array)
- `topics` (text array)

## Next Steps

1. **Run the new migration** to create the `gre_questions` table:
   ```bash
   # If using Supabase CLI
   supabase migration up
   
   # Or apply manually in Supabase dashboard
   ```

2. **Verify the table was created**:
   ```bash
   npx tsx scripts/check-gre-quant-data.ts
   ```

3. **Migrate existing data** (if needed):
   - The 1 GRE question in `question_bank` can be migrated to `gre_questions` if needed
   - Or keep using `question_bank` for GRE questions (different approach)

4. **Populate GRE questions**:
   - Create questions in the `gre_questions` table
   - Or use the existing mock data system (currently in `src/lib/mock-gre-data.ts`)

## API Status

Currently, the GRE API (`/api/gre`) uses mock data from `src/lib/mock-gre-data.ts` instead of database data. Once the table is created and populated, the API can be updated to fetch from the database.

## Related Files

- Migration: `supabase/migrations/20250116000000_create_gre_questions_table.sql`
- Study Features Migration: `supabase/migrations/20251221153306_add_gre_study_features.sql`
- Check Script: `scripts/check-gre-quant-data.ts`
- Mock Data: `src/lib/mock-gre-data.ts`
- API Routes:
  - `src/app/api/gre/route.ts`
  - `src/app/api/gre/flashcards/route.ts`
  - `src/app/api/gre/notes/route.ts`


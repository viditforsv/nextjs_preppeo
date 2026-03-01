# Supabase Branching Setup Guide

Complete guide for migrating from two separate Supabase projects to a single project with branches.

## Overview

**Current Setup:**
- Dev Project: `tqeyguvxcsebzhvhzngx.supabase.co` (can be discarded)
- Prod Project: `ootnqmojcqnzfrtvzzec.supabase.co` (will become main branch)

**Target Setup:**
- Main Project: `ootnqmojcqnzfrtvzzec.supabase.co` (production)
- Dev Branch: Persistent branch created from main (for development)

---

## Step 1: Create Dev Branch in Supabase Dashboard

1. **Log into Supabase Dashboard:**
   - Go to https://supabase.com/dashboard
   - Navigate to your `preppeo_lms_prod` project (`ootnqmojcqnzfrtvzzec`)

2. **Create Persistent Branch:**
   - Go to **Project Settings** → **Branches** (or look for "Branching" in the sidebar)
   - Click **"Create Branch"** or **"New Branch"**
   - Select **"Persistent Branch"** (not Preview Branch)
   - Name it: `dev`
   - Click **"Create"**

3. **Wait for Branch Creation:**
   - The branch will be created with a fresh database (no data copied from main)
   - This is expected - dev data will be separate from prod

4. **Get Branch Credentials:**
   - Once created, the branch will have its own:
     - URL: `https://[branch-ref].supabase.co`
     - Anon Key: (unique to the branch)
     - Service Role Key: (unique to the branch)
   - Copy these credentials - you'll need them for `.env.local`

---

## Step 2: Update Environment Variables

After creating the branch, update your `.env.local`:

```bash
# Environment Configuration
NEXT_PUBLIC_ENVIRONMENT=dev

# Dev Supabase Branch (NEW - from branching)
NEXT_PUBLIC_SUPABASE_URL_DEV=https://[branch-ref].supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV=[branch-anon-key]
SUPABASE_SERVICE_ROLE_KEY_DEV=[branch-service-role-key]

# Production Supabase (Main branch)
NEXT_PUBLIC_SUPABASE_URL_PROD=https://ootnqmojcqnzfrtvzzec.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vdG5xbW9qY3FuemZydHZ6emVjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIwNzgwODMsImV4cCI6MjA3NzY1NDA4M30.rNkz8npSWx9Q22jocPgxk30i15ynvqJKi_XuT60PwB0
SUPABASE_SERVICE_ROLE_KEY_PROD=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vdG5xbW9qY3FuemZydHZ6emVjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MjA3ODA4MywiZXhwIjoyMDc3NjU0MDgzfQ.jwyonrPA3slMtB1AvPCtci_nHNC7X_rxao1iY1Z2HZU

# Fallback (points to prod/main)
NEXT_PUBLIC_SUPABASE_URL=https://ootnqmojcqnzfrtvzzec.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vdG5xbW9qY3FuemZydHZ6emVjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIwNzgwODMsImV4cCI6MjA3NzY1NDA4M30.rNkz8npSWx9Q22jocPgxk30i15ynvqJKi_XuT60PwB0
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vdG5xbW9qY3FuemZydHZ6emVjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MjA3ODA4MywiZXhwIjoyMDc3NjU0MDgzfQ.jwyonrPA3slMtB1AvPCtci_nHNC7X_rxao1iY1Z2HZU

# ... rest of your env vars ...
```

---

## Step 3: Apply Migrations to Dev Branch

After creating the branch, you'll need to apply your database schema:

```bash
# Link to the dev branch (replace [branch-ref] with actual branch reference)
supabase link --project-ref [branch-ref]

# Apply all migrations to the dev branch
supabase db push
```

Or manually apply migrations through the Supabase dashboard SQL editor.

---

## Step 4: Update Vercel Environment Variables

Update your Vercel project settings:

**Production Environment (main branch):**
- Keep existing `NEXT_PUBLIC_SUPABASE_URL_PROD` and keys (unchanged)

**Preview Environment (dev branch):**
- Update `NEXT_PUBLIC_SUPABASE_URL_DEV` to the new branch URL
- Update `NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV` to the new branch anon key
- Update `SUPABASE_SERVICE_ROLE_KEY_DEV` to the new branch service role key

---

## Step 5: Test the Setup

1. **Test Dev Environment:**
   ```bash
   git checkout dev
   npm run dev
   ```
   - Verify it connects to the dev branch
   - Check `/api/debug/env` endpoint

2. **Test Prod Environment:**
   ```bash
   git checkout main
   # Update .env.local to use prod
   npm run dev
   ```
   - Verify it still connects to production

---

## Benefits After Migration

✅ **Single Project Management:** One project instead of two  
✅ **Easier Migrations:** Can merge schema changes between branches  
✅ **Better Git Integration:** Automatic preview branches from PRs (optional)  
✅ **Cost Efficiency:** Potentially lower costs depending on plan  
✅ **Production Data Safety:** Main branch (prod) remains untouched  

---

## Important Notes

⚠️ **Dev Branch is Empty:** The new dev branch starts with a fresh database - no data from main/prod  
⚠️ **Old Dev Project:** The old dev project (`tqeyguvxcsebzhvhzngx`) can be deleted after migration  
⚠️ **Migrations:** You'll need to apply all migrations to the dev branch to recreate your schema  
⚠️ **Data Migration:** If you need specific dev data, export it from the old dev project and import to the new branch  

---

## Troubleshooting

**Can't find Branching in Dashboard:**
- Branching might be a beta feature - check if your project/organization has access
- Contact Supabase support if needed

**Branch Creation Fails:**
- Ensure you have proper permissions on the project
- Check if your plan supports branching

**Migration Issues:**
- Use `supabase db push` to apply migrations
- Or use the SQL editor in the dashboard to run migration files manually

---

## Next Steps

After completing the setup:
1. Update documentation to reflect new branching setup
2. Consider setting up GitHub integration for automatic preview branches
3. Delete the old dev project once everything is working

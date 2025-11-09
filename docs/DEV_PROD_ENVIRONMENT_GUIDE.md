# Development & Production Environment Guide

## 🌍 Two Environments Setup

Your project uses **two separate Supabase projects**:

| Environment | Branch | Supabase Project | Domain |
|------------|--------|------------------|---------|
| **Production** | `main` | Production Supabase | https://courses.preppeo.com |
| **Development** | `dev` | Dev Supabase | http://localhost:3000 |

---

## 🔧 Environment Configuration Files

### Files in Project:
```
├── .env.local                  # Active config (NOT in Git) - you switch this
├── env.example                 # General template (in Git)
├── env.development.example     # Dev config template (in Git) 
└── env.production.example      # Prod config template (in Git)
```

---

## 🚀 Quick Start: Switch Environments

### **Working on DEV Branch:**

```bash
# 1. Switch to dev branch
git checkout dev

# 2. Copy dev environment config
cp env.development.example .env.local

# 3. Edit .env.local and add your DEV Supabase credentials:
# - NEXT_PUBLIC_SUPABASE_URL (from dev project)
# - NEXT_PUBLIC_SUPABASE_ANON_KEY (from dev project)
# - SUPABASE_SERVICE_ROLE_KEY (from dev project)

# 4. Start development
npm run dev
```

### **Working on MAIN Branch:**

```bash
# 1. Switch to main branch
git checkout main

# 2. Copy production environment config
cp env.production.example .env.local

# 3. Edit .env.local and add your PRODUCTION Supabase credentials

# 4. Start development (testing production config locally)
npm run dev
```

---

## 📝 Getting Your Supabase Credentials

### For DEV Supabase Project:
1. Go to https://supabase.com/dashboard
2. Select your **DEV** project
3. Go to **Settings** → **API**
4. Copy:
   - Project URL → `NEXT_PUBLIC_SUPABASE_URL`
   - anon/public key → `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - service_role key → `SUPABASE_SERVICE_ROLE_KEY`

### For PRODUCTION Supabase Project:
1. Same steps as above
2. Select your **PRODUCTION** project instead

---

## 🔄 Workflow Example

### Starting New Feature on Dev:

```bash
# 1. Switch to dev branch
git checkout dev

# 2. Ensure .env.local has DEV Supabase credentials
cat .env.local | grep SUPABASE_URL
# Should show: http://...your-dev-project...

# 3. Start coding
npm run dev

# 4. Test changes on dev database
# Make changes, test features, break things safely!

# 5. Commit when ready
git add .
git commit -m "feat: new feature"

# 6. Push to dev branch
git push origin dev
```

### Deploying to Production:

```bash
# 1. Merge dev to main (after testing)
git checkout main
git merge dev

# 2. Update .env.local to PRODUCTION credentials
cp env.production.example .env.local
# Edit .env.local with prod credentials

# 3. Test locally with prod database (optional but recommended)
npm run dev

# 4. Push to main
git push origin main

# 5. Vercel will auto-deploy with prod env vars
```

---

## ⚠️ Important Safety Rules

### **DO:**
- ✅ Use dev branch for all experimental features
- ✅ Test on dev Supabase before production
- ✅ Keep `.env.local` in `.gitignore`
- ✅ Use test payment keys in development
- ✅ Create test users in dev environment

### **DON'T:**
- ❌ NEVER commit `.env.local` to Git
- ❌ NEVER use production credentials in dev branch
- ❌ NEVER test destructive operations on production
- ❌ NEVER share service_role keys publicly
- ❌ NEVER push directly to main without testing on dev

---

## 🗄️ Database Schema Management

### Syncing Dev Database with Production:

**Option 1: Export from Production, Import to Dev**
```bash
# In Production Supabase Studio:
# SQL Editor → Export your schema

# In Dev Supabase Studio:  
# SQL Editor → Paste and run the schema
```

**Option 2: Use Supabase Migrations**
```bash
# Link to production (one-time)
supabase link --project-ref YOUR_PROD_PROJECT_REF

# Pull production schema
supabase db pull

# This creates a migration file
# Then link to dev and apply:
supabase link --project-ref YOUR_DEV_PROJECT_REF
supabase db push
```

**Option 3: Manual SQL File** (Simplest)
```bash
# You have: docs/present_dnd.sql
# Run this SQL in your Dev Supabase Studio to create all tables
```

---

## 📊 Current Setup on Dev Branch

### What's Ready:
- ✅ **Code:** Quiz system, question bank enhancements
- ✅ **Migrations:** Initial schema in `supabase/migrations/`
- ✅ **Config:** `env.development.example` template
- ✅ **Docs:** This guide!

### What You Need to Do:
1. Create `.env.local` from `env.development.example`
2. Fill in your DEV Supabase credentials
3. Run your schema SQL in dev Supabase (if not already done)
4. Start developing!

---

## 🎯 Immediate Next Steps

### Step 1: Create `.env.local` for Dev

```bash
# Copy the development template
cp env.development.example .env.local

# Edit .env.local with your text editor and replace:
# - YOUR_DEV_PROJECT_REF
# - your_dev_supabase_anon_key_here
# - your_dev_supabase_service_role_key_here
```

### Step 2: Verify Configuration

```bash
# Check it's pointing to dev
cat .env.local | grep SUPABASE_URL
# Should show your dev project URL

# Start the app
npm run dev
```

### Step 3: Verify Database

Visit your dev Supabase Studio and ensure you have:
- ✅ All tables from `docs/present_dnd.sql`
- ✅ Test data to work with
- ✅ Same structure as production

---

## 🔄 Quick Reference Commands

```bash
# Switch to dev environment
git checkout dev
cp env.development.example .env.local
# Edit .env.local with dev credentials
npm run dev

# Switch to production testing
git checkout main
cp env.production.example .env.local
# Edit .env.local with prod credentials
npm run dev

# Check current environment
cat .env.local | grep SUPABASE_URL
```

---

**Ready to go!** Your dev environment is all set up. Just need to add your dev Supabase credentials to `.env.local`! 🚀


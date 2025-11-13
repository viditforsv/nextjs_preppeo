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
└── env.example                 # General template (in Git)
```

---

## 🚀 Quick Start: Switch Environments

### **Working on DEV Branch:**

```bash
# 1. Switch to dev branch
git checkout dev

# 2. Create .env.local file with your DEV Supabase credentials

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

# 2. Create .env.local file with your PRODUCTION Supabase credentials

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

# 2. Update .env.local with PRODUCTION credentials
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

**Option 2: Use Supabase CLI Migrations**
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
# Create your database schema manually in Dev Supabase Studio
# Run your SQL scripts directly in the Supabase SQL Editor
```

### Creating Database Migrations:

```bash
# Create your SQL migration files manually
# Apply migrations directly in Supabase Studio SQL Editor
# Or use Supabase CLI if you have it configured

# Test your changes in Supabase Studio
```

### Useful Supabase CLI Commands:

```bash
# Start local Supabase (if using local setup)
supabase start

# Stop local Supabase
supabase stop

# Reset database (reapply all migrations)
supabase db reset

# Check status
supabase status

# View logs
supabase logs

# Access PostgreSQL directly
supabase db connect

# Create new migration
supabase migration new migration_name

# Generate types from schema
supabase gen types typescript --local > src/types/supabase.ts
```

---

## 📊 Current Setup on Dev Branch

### What's Ready:
- ✅ **Code:** Quiz system, question bank enhancements
- ✅ **Config:** Environment configuration templates
- ✅ **Docs:** This guide!

### What You Need to Do:
1. Create `.env.local` file with your DEV Supabase credentials
2. Fill in your DEV Supabase credentials
3. Run your schema SQL in dev Supabase (if not already done)
4. Start developing!

---

## 🎯 Immediate Next Steps

### Step 1: Create `.env.local` for Dev

```bash
# Create .env.local file with your text editor and add:
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
- ✅ All required database tables
- ✅ Test data to work with
- ✅ Same structure as production

---

## 🔄 Quick Reference Commands

```bash
# Switch to dev environment
git checkout dev
# Create .env.local with dev credentials
npm run dev

# Switch to production testing
git checkout main
# Update .env.local with prod credentials
npm run dev

# Check current environment
cat .env.local | grep SUPABASE_URL
```

---

## 🐛 Troubleshooting

### Supabase won't start (if using local setup):
```bash
# Check Docker is running
docker ps

# Reset Supabase
supabase stop
supabase start
```

### Database changes not applying:
```bash
# Hard reset database
supabase db reset --debug
```

### Port conflicts (if using local Supabase):
If using local Supabase, check your Supabase configuration and change ports if needed. Default ports:
- API: 54321
- DB: 54322
- Studio: 54323

### "Password authentication failed" (Supabase CLI):
- ✅ Make sure you're using the correct password for the linked project
- ✅ Verify which project is linked: `supabase projects list`
- ✅ Re-link if needed: `supabase link --project-ref <project-id>`

### "Wrong project" (Supabase CLI):
- ✅ Check current link: `supabase projects list`
- ✅ Re-link to correct project
- ✅ Verify project ID matches what you expect

---

## 🔒 Security Notes

1. ✅ `.env.local` is in `.gitignore` - never committed
2. ✅ Use different Supabase projects for dev/staging/prod
3. ⚠️ **NEVER** commit production keys
4. ⚠️ **NEVER** share service_role keys publicly

---

**Ready to go!** Your dev environment is all set up. Just need to add your dev Supabase credentials to `.env.local`! 🚀


# Development Environment Setup (Separate Dev Supabase Project)

## 📌 Environment Overview

You have **TWO separate Supabase projects**:

| Environment | Branch | Supabase Project | Purpose |
|------------|--------|------------------|---------|
| **Development** | `dev` | Dev Supabase (Cloud) | Testing, new features, breaking changes |
| **Production** | `main` | Production Supabase (Cloud) | Live user data, stable releases |

**Note:** This setup uses **separate cloud-hosted Supabase projects** (not local Docker).

---

## 🚀 Quick Start Guide

### Step 1: Create `.env.local` for Development

When working on the **dev branch**, create `.env.local` with your dev Supabase credentials:

```bash
# Copy the development template
cp env.development.example .env.local

# Edit .env.local and replace with your DEV Supabase project credentials:
# Get these from: https://supabase.com/dashboard/project/YOUR_DEV_PROJECT/settings/api
```

Your `.env.local` should look like:

```bash
# Dev Supabase Project
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGc...your-dev-key
SUPABASE_SERVICE_ROLE_KEY=eyJhbGc...your-dev-service-role-key

# App Configuration
NEXT_PUBLIC_APP_URL=http://localhost:3000
NEXT_PUBLIC_SITE_URL=http://localhost:3000
NODE_ENV=development
```

---

### Step 2: Start Next.js App

```bash
npm run dev
```

Your app will now use **Dev Supabase** for all database operations!

---

### Step 3: Access Supabase Studio (Cloud UI)

Open your **Dev Supabase Studio**: https://supabase.com/dashboard/project/YOUR_DEV_PROJECT

- Browse tables
- Run SQL queries
- Manage data
- View logs
- Test auth flows

---

## 📊 Development Workflow

### Working on Dev Branch:

```bash
# Make sure you're on dev branch
git checkout dev

# Ensure .env.local has DEV credentials
cat .env.local | grep SUPABASE_URL
# Should show your dev Supabase URL

# Start Next.js
npm run dev

# Develop and test with dev database
# All changes go to dev Supabase, not production!
```

### Creating Database Migrations:

```bash
# Create a new migration
supabase migration new add_new_table

# Edit the generated file in supabase/migrations/
# Add your SQL changes

# Apply migration locally
supabase db reset

# Test your changes
```

### Pulling Remote Schema (Optional):

If you want to sync from your production Supabase:

```bash
# Link to remote project (one-time)
supabase link --project-ref YOUR_PROJECT_REF

# Pull remote schema
supabase db pull

# This creates a new migration with remote changes
```

---

## 🔧 Useful Commands

### Supabase Management:

```bash
# Start local Supabase
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
```

### Database Operations:

```bash
# Create new migration
supabase migration new migration_name

# Apply migrations
supabase db reset

# Generate types from schema
supabase gen types typescript --local > src/types/supabase.ts
```

---

## 🌐 Environment Separation

### Local Development (Dev Branch):
- **Supabase:** http://127.0.0.1:54321 (local Docker)
- **App:** http://localhost:3000
- **Database:** Isolated local PostgreSQL
- **Branch:** `dev`

### Production (Main Branch):
- **Supabase:** https://your-project.supabase.co
- **App:** https://courses.preppeo.com
- **Database:** Production Supabase
- **Branch:** `main`

---

## 📁 Project Structure

```
nextjs_preppeo/
├── supabase/
│   ├── config.toml              # Supabase configuration
│   ├── migrations/               # Database migrations (tracked in Git)
│   │   └── 20241109000000_initial_schema.sql
│   └── seed.sql                  # Seed data (optional)
├── .env.local                    # Local environment variables (NOT in Git)
├── .env.example                  # Example env file (in Git)
└── ...
```

---

## 🔒 Security Notes

1. ✅ `.env.local` is in `.gitignore` - never committed
2. ✅ Local Supabase keys are public defaults - safe for local only
3. ⚠️ **NEVER** commit production keys
4. ✅ Use different Supabase projects for dev/staging/prod

---

## 🐛 Troubleshooting

### Supabase won't start:
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

### Port conflicts:
Check `supabase/config.toml` and change ports if needed:
- API: 54321
- DB: 54322
- Studio: 54323

---

## 🎯 Next Steps

1. ✅ Create `.env.local` file (see Step 1 above)
2. ✅ Run `supabase start`
3. ✅ Run `npm run dev`
4. ✅ Access Studio at http://localhost:54323
5. ✅ Start developing!

**Your local dev environment is ready!** 🚀


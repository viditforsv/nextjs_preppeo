# Local Development Environment Setup

## ✅ Supabase CLI Installed
- **Version:** 2.31.8 (Update available: 2.54.11)
- **Location:** `/opt/homebrew/bin/supabase`

## ✅ Supabase Initialized
- **Branch:** `dev`
- **Config:** `supabase/config.toml`
- **Initial Migration:** `supabase/migrations/20241109000000_initial_schema.sql`

---

## 🚀 Quick Start Guide

### Step 1: Create `.env.local` File

Create a `.env.local` file in the project root with these values for local development:

```bash
# Supabase Local Development Configuration
# When running `supabase start`, these values will be used

# Supabase Local URLs
NEXT_PUBLIC_SUPABASE_URL=http://127.0.0.1:54321
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU

# App Configuration
NEXT_PUBLIC_APP_URL=http://localhost:3000
NEXT_PUBLIC_SITE_URL=http://localhost:3000
NODE_ENV=development

# Razorpay (Use test keys)
RAZORPAY_KEY_ID=your_test_key_here
RAZORPAY_KEY_SECRET=your_test_secret_here
NEXT_PUBLIC_RAZORPAY_KEY_ID=your_test_key_here
```

**Note:** These are default Supabase local keys - safe for local dev, NEVER use in production.

---

### Step 2: Start Supabase Local

```bash
supabase start
```

This will:
- ✅ Start local PostgreSQL database (port 54322)
- ✅ Start Supabase API (port 54321)
- ✅ Start Supabase Studio (port 54323) - Database UI
- ✅ Apply migrations from `supabase/migrations/`
- ✅ Set up auth, storage, and realtime

**First run takes 2-5 minutes** (downloads Docker images)

---

### Step 3: Start Next.js App

```bash
npm run dev
```

Your app will now use **local Supabase** (http://127.0.0.1:54321) instead of production!

---

### Step 4: Access Supabase Studio (Local Database UI)

Open: **http://localhost:54323**

- Browse tables
- Run SQL queries
- Manage data
- View logs

---

## 📊 Development Workflow

### Working on Dev Branch:

```bash
# Make sure you're on dev branch
git checkout dev

# Start Supabase local
supabase start

# Start Next.js
npm run dev

# Develop and test locally
# ...

# Stop Supabase when done
supabase stop
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


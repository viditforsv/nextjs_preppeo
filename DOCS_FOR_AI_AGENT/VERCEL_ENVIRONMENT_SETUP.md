# Vercel Environment Variables Setup Guide

## 🎯 Overview: Three Moving Parts

This project has **three separate environments** that need to be configured:

1. **Local Development** (`.env.local` file)
2. **Vercel Preview** (deployments from `dev` branch)
3. **Vercel Production** (deployments from `main` branch)

Each environment connects to a different Supabase project to ensure complete isolation between dev and prod.

---

## 📊 Environment Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    LOCAL DEVELOPMENT                         │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  .env.local file                                       │  │
│  │  - NEXT_PUBLIC_ENVIRONMENT=dev                        │  │
│  │  - NEXT_PUBLIC_SUPABASE_URL_DEV=...                   │  │
│  │  - NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV=...              │  │
│  │  - SUPABASE_SERVICE_ROLE_KEY_DEV=...                  │  │
│  └──────────────────────────────────────────────────────┘  │
│  Connects to: Dev Supabase Project                        │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ git push origin dev
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    VERCEL PREVIEW                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Vercel Environment Variables (Preview)               │  │
│  │  - NEXT_PUBLIC_ENVIRONMENT=dev                        │  │
│  │  - NEXT_PUBLIC_SUPABASE_URL_DEV=...                   │  │
│  │  - NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV=...              │  │
│  │  - SUPABASE_SERVICE_ROLE_KEY_DEV=...                  │  │
│  └──────────────────────────────────────────────────────┘  │
│  Connects to: Dev Supabase Project                        │
│  Domain: https://your-app-git-dev-username.vercel.app     │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ git push origin main
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    VERCEL PRODUCTION                         │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Vercel Environment Variables (Production)          │  │
│  │  - NEXT_PUBLIC_ENVIRONMENT=prod                       │  │
│  │  - NEXT_PUBLIC_SUPABASE_URL_PROD=...                 │  │
│  │  - NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD=...            │  │
│  │  - SUPABASE_SERVICE_ROLE_KEY_PROD=...                 │  │
│  └──────────────────────────────────────────────────────┘  │
│  Connects to: Production Supabase Project                 │
│  Domain: https://courses.preppeo.com                      │
└─────────────────────────────────────────────────────────────┘
```

---

## 🚀 Step-by-Step: Vercel Environment Variables Setup

### Step 1: Access Vercel Project Settings

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Select your project (`nextjs_preppeo`)
3. Click on **Settings** tab
4. Click on **Environment Variables** in the left sidebar

### Step 2: Configure Production Environment Variables

**For Production (main branch deployments):**

1. In the Environment Variables page, you'll see three environment options:
   - **Production** - for `main` branch
   - **Preview** - for all other branches (including `dev`)
   - **Development** - for `vercel dev` command (optional)

2. **Add Production Variables:**
   - Click **Add New**
   - Add each variable one by one:

   ```
   Name: NEXT_PUBLIC_ENVIRONMENT
   Value: prod
   Environment: Production ✅
   ```

   ```
   Name: NEXT_PUBLIC_SUPABASE_URL_PROD
   Value: https://ootnqmojcqnzfrtvzzec.supabase.co
   Environment: Production ✅
   ```

   ```
   Name: NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD
   Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   Environment: Production ✅
   ```

   ```
   Name: SUPABASE_SERVICE_ROLE_KEY_PROD
   Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   Environment: Production ✅
   ```

   **Important:** Only check **Production** for these variables.

### Step 3: Configure Preview Environment Variables

**For Preview (dev branch and other branches):**

1. **Add Preview Variables:**
   - Click **Add New** for each variable:

   ```
   Name: NEXT_PUBLIC_ENVIRONMENT
   Value: dev
   Environment: Preview ✅
   ```

   ```
   Name: NEXT_PUBLIC_SUPABASE_URL_DEV
   Value: https://tqeyguvxcsebzhvhzngx.supabase.co
   Environment: Preview ✅
   ```

   ```
   Name: NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV
   Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   Environment: Preview ✅
   ```

   ```
   Name: SUPABASE_SERVICE_ROLE_KEY_DEV
   Value: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   Environment: Preview ✅
   ```

   **Important:** Only check **Preview** for these variables.

### Step 4: Add Other Required Variables

Don't forget to add other environment variables that your app needs:

**For Production:**
- `NEXT_PUBLIC_APP_URL` = `https://courses.preppeo.com`
- `GOOGLE_CLIENT_ID`
- `GOOGLE_CLIENT_SECRET`
- `RAZORPAY_KEY_ID`
- `RAZORPAY_KEY_SECRET`
- `NEXT_PUBLIC_RAZORPAY_KEY_ID`
- (Any other production-specific variables)

**For Preview:**
- `NEXT_PUBLIC_APP_URL` = `https://dev.courses.preppeo.com` (or your preview domain)
- `GOOGLE_CLIENT_ID` (can be same or different)
- `GOOGLE_CLIENT_SECRET` (can be same or different)
- `RAZORPAY_KEY_ID_TEST` (use test keys for preview)
- `RAZORPAY_KEY_SECRET_TEST`
- (Any other dev/test-specific variables)

---

## 📋 Complete Environment Variables Checklist

### Production Environment Variables (Vercel)

```bash
# Environment
NEXT_PUBLIC_ENVIRONMENT=prod

# Supabase Production
NEXT_PUBLIC_SUPABASE_URL_PROD=https://ootnqmojcqnzfrtvzzec.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD=your-prod-anon-key
SUPABASE_SERVICE_ROLE_KEY_PROD=your-prod-service-role-key

# App URL
NEXT_PUBLIC_APP_URL=https://courses.preppeo.com

# Google Auth
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret

# Razorpay (Live)
RAZORPAY_KEY_ID=rzp_live_...
RAZORPAY_KEY_SECRET=your-razorpay-secret
NEXT_PUBLIC_RAZORPAY_KEY_ID=rzp_live_...
```

### Preview Environment Variables (Vercel)

```bash
# Environment
NEXT_PUBLIC_ENVIRONMENT=dev

# Supabase Development
NEXT_PUBLIC_SUPABASE_URL_DEV=https://tqeyguvxcsebzhvhzngx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV=your-dev-anon-key
SUPABASE_SERVICE_ROLE_KEY_DEV=your-dev-service-role-key

# App URL
NEXT_PUBLIC_APP_URL=https://dev.courses.preppeo.com

# Google Auth (can use same or test credentials)
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret

# Razorpay (Test)
RAZORPAY_KEY_ID_TEST=rzp_test_...
RAZORPAY_KEY_SECRET_TEST=your-test-secret
NEXT_PUBLIC_RAZORPAY_KEY_ID=rzp_test_...
```

---

## 🔍 How Vercel Environment Selection Works

### Vercel Environment Types

1. **Production Environment**
   - Triggered by: Deployments from `main` branch
   - Uses: Variables marked with **Production** ✅
   - Domain: Your production domain (e.g., `courses.preppeo.com`)

2. **Preview Environment**
   - Triggered by: Deployments from any branch except `main` (including `dev`)
   - Uses: Variables marked with **Preview** ✅
   - Domain: Auto-generated preview URLs (e.g., `your-app-git-dev-username.vercel.app`)

3. **Development Environment** (Optional)
   - Triggered by: Running `vercel dev` locally
   - Uses: Variables marked with **Development** ✅
   - Domain: `localhost:3000`

### Environment Variable Priority

When you add a variable, you can select:
- ✅ **Production** only
- ✅ **Preview** only
- ✅ **Development** only
- ✅ **Production + Preview** (if you want to share a variable)
- ✅ **All** (Production + Preview + Development)

**Best Practice:** Keep Production and Preview variables **separate** to ensure complete isolation.

---

## ✅ Verification Steps

### 1. Verify Vercel Environment Variables

1. Go to Vercel Dashboard → Your Project → Settings → Environment Variables
2. Verify you have:
   - Production variables (marked with Production ✅)
   - Preview variables (marked with Preview ✅)
3. Check that Production and Preview use **different** Supabase projects

### 2. Test Preview Deployment

1. Push to `dev` branch:
   ```bash
   git push origin dev
   ```

2. Vercel will create a preview deployment
3. Check the deployment logs to verify it's using dev database
4. Visit the preview URL and verify it connects to dev Supabase

### 3. Test Production Deployment

1. Merge to `main` branch:
   ```bash
   git checkout main
   git merge dev
   git push origin main
   ```

2. Vercel will create a production deployment
3. Check the deployment logs to verify it's using prod database
4. Visit production URL and verify it connects to prod Supabase

### 4. Verify Environment Detection

Add a temporary debug endpoint to verify which environment is being used:

```typescript
// src/app/api/debug/env/route.ts
import { NextResponse } from "next/server";
import { getCurrentEnvironment, getSupabaseUrl } from "@/lib/supabase/env";

export async function GET() {
  return NextResponse.json({
    environment: getCurrentEnvironment(),
    supabaseUrl: getSupabaseUrl(),
    nodeEnv: process.env.NODE_ENV,
    explicitEnv: process.env.NEXT_PUBLIC_ENVIRONMENT,
  });
}
```

Then visit:
- Preview: `https://your-preview-url.vercel.app/api/debug/env`
- Production: `https://courses.preppeo.com/api/debug/env`

---

## 🔄 Workflow Summary

### Development Workflow

```bash
# 1. Work locally on dev branch
git checkout dev

# 2. Local .env.local has dev credentials
# NEXT_PUBLIC_ENVIRONMENT=dev
# NEXT_PUBLIC_SUPABASE_URL_DEV=...

# 3. Push to dev branch
git push origin dev

# 4. Vercel creates preview deployment
# Uses Preview environment variables (dev Supabase)

# 5. Test on preview URL
# Should connect to dev database
```

### Production Workflow

```bash
# 1. Merge dev to main
git checkout main
git merge dev
git push origin main

# 2. Vercel creates production deployment
# Uses Production environment variables (prod Supabase)

# 3. Production goes live
# Should connect to prod database
```

---

## 🐛 Troubleshooting

### Issue: Preview deployment using production database

**Cause:** Preview environment variables not set correctly

**Solution:**
1. Go to Vercel → Settings → Environment Variables
2. Verify Preview variables are set and marked with **Preview** ✅
3. Ensure `NEXT_PUBLIC_ENVIRONMENT=dev` is set for Preview
4. Redeploy the preview

### Issue: Production deployment using dev database

**Cause:** Production environment variables not set correctly

**Solution:**
1. Go to Vercel → Settings → Environment Variables
2. Verify Production variables are set and marked with **Production** ✅
3. Ensure `NEXT_PUBLIC_ENVIRONMENT=prod` is set for Production
4. Redeploy production

### Issue: Environment variables not updating after change

**Cause:** Vercel caches environment variables

**Solution:**
1. After adding/updating variables, trigger a new deployment
2. Or go to Deployments → Click "..." → Redeploy

### Issue: Wrong Supabase project being used

**Cause:** Environment detection logic issue

**Solution:**
1. Check `NEXT_PUBLIC_ENVIRONMENT` is set correctly in Vercel
2. Verify environment-specific variables (`_DEV` vs `_PROD`) are set
3. Check deployment logs for environment detection
4. Use the debug endpoint to verify which environment is detected

---

## 🔒 Security Best Practices

1. ✅ **Never commit** `.env.local` to Git
2. ✅ **Use different Supabase projects** for dev and prod
3. ✅ **Never share** service role keys publicly
4. ✅ **Rotate keys** if accidentally exposed
5. ✅ **Use Vercel's encrypted storage** for sensitive variables
6. ✅ **Limit access** to Vercel project settings
7. ✅ **Use test payment keys** in Preview environment
8. ✅ **Review environment variables** regularly

---

## 📚 Related Documentation

- [ENVIRONMENT_BASED_DATABASE_SETUP.md](./ENVIRONMENT_BASED_DATABASE_SETUP.md) - How environment detection works
- [DEV_PROD_ENVIRONMENT_GUIDE.md](./DEV_PROD_ENVIRONMENT_GUIDE.md) - Local development setup
- [Vercel Environment Variables Docs](https://vercel.com/docs/concepts/projects/environment-variables)

---

## ✅ Quick Reference

| Environment | Branch | Vercel Setting | Supabase Project | Domain |
|------------|--------|----------------|-----------------|--------|
| Local Dev | `dev` | N/A (`.env.local`) | Dev | `localhost:3000` |
| Preview | `dev` | Preview ✅ | Dev | `*.vercel.app` |
| Production | `main` | Production ✅ | Prod | `courses.preppeo.com` |

---

**Ready to deploy!** Once you've set up the environment variables in Vercel, your deployments will automatically use the correct database. 🚀


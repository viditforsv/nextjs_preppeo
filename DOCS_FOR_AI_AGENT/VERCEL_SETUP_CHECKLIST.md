# Vercel Environment Setup Checklist

## ✅ Step-by-Step Action Items

### Step 1: Access Vercel Dashboard
- [ ] Go to [vercel.com/dashboard](https://vercel.com/dashboard)
- [ ] Select your project: `nextjs_preppeo`
- [ ] Navigate to: **Settings** → **Environment Variables**

### Step 2: Set Up Production Environment Variables

**For Production (main branch deployments):**

- [ ] Add `NEXT_PUBLIC_ENVIRONMENT` = `prod` (✅ Production only)
- [ ] Add `NEXT_PUBLIC_SUPABASE_URL_PROD` = `https://ootnqmojcqnzfrtvzzec.supabase.co` (✅ Production only)
- [ ] Add `NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD` = `[your-prod-anon-key]` (✅ Production only)
- [ ] Add `SUPABASE_SERVICE_ROLE_KEY_PROD` = `[your-prod-service-role-key]` (✅ Production only)
- [ ] Add `NEXT_PUBLIC_APP_URL` = `https://courses.preppeo.com` (✅ Production only)
- [ ] Add `GOOGLE_CLIENT_ID` = `[your-google-client-id]` (✅ Production only)
- [ ] Add `GOOGLE_CLIENT_SECRET` = `[your-google-client-secret]` (✅ Production only)
- [ ] Add `RAZORPAY_KEY_ID` = `rzp_live_...` (✅ Production only)
- [ ] Add `RAZORPAY_KEY_SECRET` = `[your-razorpay-secret]` (✅ Production only)
- [ ] Add `NEXT_PUBLIC_RAZORPAY_KEY_ID` = `rzp_live_...` (✅ Production only)

### Step 3: Set Up Preview Environment Variables

**For Preview (dev branch and other branches):**

- [ ] Add `NEXT_PUBLIC_ENVIRONMENT` = `dev` (✅ Preview only)
- [ ] Add `NEXT_PUBLIC_SUPABASE_URL_DEV` = `https://tqeyguvxcsebzhvhzngx.supabase.co` (✅ Preview only)
- [ ] Add `NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV` = `[your-dev-anon-key]` (✅ Preview only)
- [ ] Add `SUPABASE_SERVICE_ROLE_KEY_DEV` = `[your-dev-service-role-key]` (✅ Preview only)
- [ ] Add `NEXT_PUBLIC_APP_URL` = `https://dev.courses.preppeo.com` (or preview domain) (✅ Preview only)
- [ ] Add `GOOGLE_CLIENT_ID` = `[your-google-client-id]` (✅ Preview only)
- [ ] Add `GOOGLE_CLIENT_SECRET` = `[your-google-client-secret]` (✅ Preview only)
- [ ] Add `RAZORPAY_KEY_ID_TEST` = `rzp_test_...` (✅ Preview only)
- [ ] Add `RAZORPAY_KEY_SECRET_TEST` = `[your-test-secret]` (✅ Preview only)
- [ ] Add `NEXT_PUBLIC_RAZORPAY_KEY_ID` = `rzp_test_...` (✅ Preview only)

### Step 4: Verify Environment Variable Configuration

- [ ] Check that Production variables are marked with **Production** ✅ only
- [ ] Check that Preview variables are marked with **Preview** ✅ only
- [ ] Verify Production uses `_PROD` suffix variables
- [ ] Verify Preview uses `_DEV` suffix variables
- [ ] Ensure no variables are shared between Production and Preview (for Supabase credentials)

### Step 5: Test Preview Deployment

- [ ] Push to `dev` branch:
  ```bash
  git push origin dev
  ```
- [ ] Wait for Vercel to create preview deployment
- [ ] Check deployment logs in Vercel dashboard
- [ ] Verify preview deployment uses dev database (check logs for dev Supabase URL)
- [ ] Visit preview URL and test functionality
- [ ] Confirm it's connecting to dev Supabase project

### Step 6: Test Production Deployment

- [ ] Merge dev to main (if ready):
  ```bash
  git checkout main
  git merge dev
  git push origin main
  ```
- [ ] Wait for Vercel to create production deployment
- [ ] Check deployment logs in Vercel dashboard
- [ ] Verify production deployment uses prod database (check logs for prod Supabase URL)
- [ ] Visit production URL: `https://courses.preppeo.com`
- [ ] Confirm it's connecting to prod Supabase project

### Step 7: Create Debug Endpoint (Optional but Recommended)

- [ ] Create `src/app/api/debug/env/route.ts`:
  ```typescript
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
- [ ] Test on preview: `https://your-preview-url.vercel.app/api/debug/env`
- [ ] Test on production: `https://courses.preppeo.com/api/debug/env`
- [ ] Verify correct environment is detected
- [ ] **Remove or secure this endpoint** after verification (add authentication)

### Step 8: Final Verification

- [ ] Preview deployments connect to dev Supabase ✅
- [ ] Production deployments connect to prod Supabase ✅
- [ ] No environment variable errors in deployment logs ✅
- [ ] Application functions correctly on both environments ✅
- [ ] Database operations work on both environments ✅

---

## 🚨 Critical Reminders

1. **Never share Production credentials** - Keep them secure
2. **Use different Supabase projects** - Dev and Prod must be separate
3. **Test on Preview first** - Always test changes on preview before production
4. **Monitor deployment logs** - Check logs after each deployment
5. **Remove debug endpoints** - Don't leave debug endpoints exposed in production

---

## 📝 Quick Reference

### Where to Find Your Credentials

**Supabase Credentials:**
1. Go to [supabase.com/dashboard](https://supabase.com/dashboard)
2. Select your project (Dev or Prod)
3. Go to **Settings** → **API**
4. Copy:
   - Project URL → `NEXT_PUBLIC_SUPABASE_URL_*`
   - anon/public key → `NEXT_PUBLIC_SUPABASE_ANON_KEY_*`
   - service_role key → `SUPABASE_SERVICE_ROLE_KEY_*`

**Current Values (from your .env.local):**

**Dev:**
- URL: `https://tqeyguvxcsebzhvhzngx.supabase.co`
- Anon Key: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRxZXlndXZ4Y3NlYnpodmh6bmd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUzMzcyODcsImV4cCI6MjA3MDkxMzI4N30.-2TAoTNsCQRcI91fT0XIuXgEFhFIIEUv4pFsmMrEPWg`
- Service Role: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRxZXlndXZ4Y3NlYnpodmh6bmd4Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NTMzNzI4NywiZXhwIjoyMDcwOTEzMjg3fQ.lxYNRIwiYj1VPtZpNFM51d3o70HeEd6haqAyKQ-MDDU`

**Prod:**
- URL: `https://ootnqmojcqnzfrtvzzec.supabase.co`
- Anon Key: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vdG5xbW9qY3FuemZydHZ6emVjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIwNzgwODMsImV4cCI6MjA3NzY1NDA4M30.rNkz8npSWx9Q22jocPgxk30i15ynvqJKi_XuT60PwB0`
- Service Role: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vdG5xbW9qY3FuemZydHZ6emVjIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MjA3ODA4MywiZXhwIjoyMDc3NjU0MDgzfQ.jwyonrPA3slMtB1AvPCtci_nHNC7X_rxao1iY1Z2HZU`

---

## 🎯 Expected Outcome

After completing these steps:

✅ **Preview deployments** (from `dev` branch) will:
- Use dev Supabase database
- Have `NEXT_PUBLIC_ENVIRONMENT=dev`
- Connect to: `https://tqeyguvxcsebzhvhzngx.supabase.co`

✅ **Production deployments** (from `main` branch) will:
- Use prod Supabase database
- Have `NEXT_PUBLIC_ENVIRONMENT=prod`
- Connect to: `https://ootnqmojcqnzfrtvzzec.supabase.co`

---

## 📚 Related Documentation

- [VERCEL_ENVIRONMENT_SETUP.md](./VERCEL_ENVIRONMENT_SETUP.md) - Detailed setup guide
- [ENVIRONMENT_BASED_DATABASE_SETUP.md](./ENVIRONMENT_BASED_DATABASE_SETUP.md) - How environment detection works
- [DEV_PROD_ENVIRONMENT_GUIDE.md](./DEV_PROD_ENVIRONMENT_GUIDE.md) - Local development setup

---

**Start with Step 1 and work through the checklist!** 🚀


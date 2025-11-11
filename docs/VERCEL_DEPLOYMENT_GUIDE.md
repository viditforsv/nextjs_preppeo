# Vercel Deployment Guide - Dev & Production Environments

## 🎯 Overview

Your project uses **two separate deployments** on Vercel:

| Branch | Environment | Domain | Supabase Project |
|--------|-------------|--------|------------------|
| `main` | **Production** | `courses.preppeo.com` | Production Supabase |
| `dev` | **Development** | `dev.courses.preppeo.com` (recommended) or Vercel preview URL | Dev Supabase |

---

## 🚀 Setup Instructions

### **Step 1: Configure Production Deployment (Main Branch)**

1. **Go to Vercel Dashboard:**
   - Visit: https://vercel.com/dashboard
   - Select your project: `nextjs_preppeo` (or your project name)

2. **Set Production Domain:**
   - Go to **Settings** → **Domains**
   - Add `courses.preppeo.com` as your production domain
   - Follow DNS configuration instructions

3. **Configure Production Environment Variables:**
   - Go to **Settings** → **Environment Variables**
   - **Select Environment:** `Production` (and `Preview` if you want)
   - Add the following variables:

   ```bash
   NEXT_PUBLIC_SUPABASE_URL=https://your-prod-project.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_prod_anon_key
   SUPABASE_SERVICE_ROLE_KEY=your_prod_service_role_key
   NEXT_PUBLIC_APP_URL=https://courses.preppeo.com
   NEXT_PUBLIC_SITE_URL=https://courses.preppeo.com
   NODE_ENV=production
   
   # Razorpay (Production)
   RAZORPAY_KEY_ID=your_prod_razorpay_key_id
   RAZORPAY_KEY_SECRET=your_prod_razorpay_key_secret
   NEXT_PUBLIC_RAZORPAY_KEY_ID=your_prod_razorpay_key_id
   ```

4. **Configure Production Branch:**
   - Go to **Settings** → **Git**
   - Ensure **Production Branch** is set to `main`
   - Vercel will auto-deploy when you push to `main`

---

### **Step 2: Configure Development Deployment (Dev Branch)**

1. **Enable Preview Deployments for Dev Branch:**
   - Go to **Settings** → **Git**
   - Under **Preview Deployments**, ensure it's enabled
   - Vercel automatically creates preview URLs for all branches

2. **Create Dev Branch Environment Variables:**
   - Go to **Settings** → **Environment Variables**
   - **Select Environment:** `Preview` (applies to all branches except production)
   - Add the following variables:

   ```bash
   NEXT_PUBLIC_SUPABASE_URL=https://your-dev-project.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_dev_anon_key
   SUPABASE_SERVICE_ROLE_KEY=your_dev_service_role_key
   NEXT_PUBLIC_APP_URL=https://dev.courses.preppeo.com
   NEXT_PUBLIC_SITE_URL=https://dev.courses.preppeo.com
   NODE_ENV=development
   
   # Razorpay (Development/Test)
   RAZORPAY_KEY_ID=your_test_razorpay_key_id
   RAZORPAY_KEY_SECRET=your_test_razorpay_key_secret
   NEXT_PUBLIC_RAZORPAY_KEY_ID=your_test_razorpay_key_id
   ```

3. **Assign Custom Domain to Dev Branch (Recommended):**
   - Go to **Settings** → **Domains**
   - Add `dev.courses.preppeo.com` as a custom domain
   - In **Settings** → **Git** → **Branch Protection**, assign this domain to `dev` branch only
   - **Alternative:** Skip this step and use Vercel's automatic preview URLs (e.g., `nextjs-preppeo-git-dev-username.vercel.app`)

---

### **Step 3: Branch-Specific Environment Variables (Advanced)**

If you want **different env vars for `dev` branch vs other preview branches**:

1. **Use Vercel CLI:**
   ```bash
   # Install Vercel CLI
   npm i -g vercel
   
   # Login
   vercel login
   
   # Link project
   vercel link
   
   # Set environment variables for dev branch only
   vercel env add NEXT_PUBLIC_SUPABASE_URL preview dev
   # Enter your dev Supabase URL when prompted
   
   # Set for production
   vercel env add NEXT_PUBLIC_SUPABASE_URL production
   # Enter your prod Supabase URL when prompted
   ```

2. **Or Use Vercel Dashboard:**
   - Go to **Settings** → **Environment Variables**
   - When adding a variable, you can select:
     - `Production` - Only for `main` branch
     - `Preview` - For all branches (including `dev`)
     - `Development` - Only for local `vercel dev`

---

## 📋 Environment Variable Priority

Vercel uses this priority order:
1. **Environment-specific vars** (Production/Preview/Development)
2. **Branch-specific vars** (if configured)
3. **Default vars** (applied to all environments)

**Recommended Setup:**
- **Production:** All vars set for `Production` environment → Applies to `main` branch
- **Development:** All vars set for `Preview` environment → Applies to `dev` branch and all PRs

---

## 🔄 Deployment Workflow

### **Working on Dev Branch:**

```bash
# 1. Make changes on dev branch
git checkout dev
# ... make changes ...

# 2. Commit and push
git add .
git commit -m "feat: new feature"
git push origin dev

# 3. Vercel automatically deploys to preview URL
# → https://dev.courses.preppeo.com (if custom domain configured)
# → Or https://nextjs-preppeo-git-dev-username.vercel.app (default preview URL)
```

### **Deploying to Production:**

```bash
# 1. Merge dev to main (after testing)
git checkout main
git merge dev
git push origin main

# 2. Vercel automatically deploys to production
# → https://courses.preppeo.com
```

---

## 🌐 Custom Domain Setup

### **Production Domain (courses.preppeo.com):**

1. **In Vercel:**
   - Go to **Settings** → **Domains**
   - Add `courses.preppeo.com`
   - Copy the DNS records shown

2. **In Your DNS Provider:**
   - Add the CNAME or A record as shown in Vercel
   - Wait for DNS propagation (5-60 minutes)

3. **SSL Certificate:**
   - Vercel automatically provisions SSL certificates
   - Wait a few minutes after DNS propagation

### **Dev Domain (dev.courses.preppeo.com):**

1. **In Vercel:**
   - Go to **Settings** → **Domains**
   - Add `dev.courses.preppeo.com`
   - Vercel will show you the DNS configuration needed
   - In **Settings** → **Git**, assign this domain to `dev` branch only (not production)

2. **In Your DNS Provider (e.g., Cloudflare, GoDaddy, Namecheap):**
   - Add a CNAME record:
     - **Name/Host:** `dev.courses` (or `dev` if `courses.preppeo.com` is the root)
     - **Value/Target:** `cname.vercel-dns.com` (or the value Vercel provides)
   - Wait for DNS propagation (5-60 minutes)
   - Vercel will automatically provision SSL certificate

3. **Verify:**
   - After DNS propagates, visit `https://dev.courses.preppeo.com`
   - Should show your dev branch deployment
   - Should use dev Supabase credentials

---

## ✅ Verification Checklist

### **Production (Main Branch):**
- [ ] `main` branch is set as production branch
- [ ] Production environment variables are set
- [ ] `courses.preppeo.com` domain is configured
- [ ] SSL certificate is active
- [ ] Production Supabase credentials are correct
- [ ] Production Razorpay keys are set (if using payments)

### **Development (Dev Branch):**
- [ ] Preview deployments are enabled
- [ ] Preview environment variables are set
- [ ] Dev Supabase credentials are correct
- [ ] Dev branch deploys to preview URL
- [ ] Optional: Custom dev domain is configured
- [ ] Test Razorpay keys are set (if using payments)

---

## 🔍 Testing Deployments

### **Test Production Deployment:**
```bash
# 1. Verify environment variables
# Visit: https://courses.preppeo.com
# Check browser console for any errors

# 2. Test authentication
# Try logging in with Google OAuth
# Verify it connects to production Supabase

# 3. Test database connection
# Verify you can see production data
```

### **Test Dev Deployment:**
```bash
# 1. Push to dev branch
git push origin dev

# 2. Check Vercel dashboard for deployment URL
# Visit the preview URL

# 3. Verify it's using dev Supabase
# Check that test data appears (not production data)

# 4. Test features safely
# Break things, test new features, etc.
```

---

## 🚨 Important Notes

### **Security:**
- ✅ **NEVER** commit `.env.local` to Git
- ✅ **NEVER** share service_role keys publicly
- ✅ Use **test payment keys** in dev environment
- ✅ Use **production payment keys** only in production

### **Database:**
- ✅ **Dev branch** → Dev Supabase (test data, safe to break)
- ✅ **Main branch** → Production Supabase (real user data, be careful!)
- ✅ Keep dev database schema in sync with production

### **Environment Variables:**
- ✅ Vercel environment variables override `.env.local`
- ✅ Local development uses `.env.local`
- ✅ Vercel deployments use Vercel environment variables
- ✅ Different vars for Production vs Preview environments

---

## 🔧 Troubleshooting

### **Dev deployment using production database:**
- **Problem:** Dev branch is connecting to production Supabase
- **Solution:** Check Vercel environment variables → Ensure `Preview` environment has dev Supabase credentials

### **Production deployment using dev database:**
- **Problem:** Main branch is connecting to dev Supabase
- **Solution:** Check Vercel environment variables → Ensure `Production` environment has prod Supabase credentials

### **Environment variables not updating:**
- **Problem:** Changes to env vars not reflecting in deployment
- **Solution:** 
  1. Verify vars are set for correct environment (Production/Preview)
  2. Redeploy after changing env vars: Go to **Deployments** → Click **Redeploy**

### **Domain not working:**
- **Problem:** Custom domain not resolving
- **Solution:**
  1. Check DNS records are correct
  2. Wait for DNS propagation (up to 60 minutes)
  3. Verify SSL certificate is active in Vercel dashboard

---

## 📚 Additional Resources

- [Vercel Environment Variables Docs](https://vercel.com/docs/concepts/projects/environment-variables)
- [Vercel Branch Deployments](https://vercel.com/docs/concepts/deployments/branch-deployments)
- [Vercel Custom Domains](https://vercel.com/docs/concepts/projects/domains)
- [Vercel CLI Docs](https://vercel.com/docs/cli)

---

## 🎯 Quick Reference

```bash
# Check current branch
git branch --show-current

# Deploy to dev (automatic on push)
git push origin dev

# Deploy to production (automatic on push to main)
git push origin main

# View Vercel deployments
vercel ls

# View environment variables
vercel env ls

# Add environment variable via CLI
vercel env add VARIABLE_NAME production
```

---

**Your Vercel setup is complete!** 🚀

Now you can:
- ✅ Work on `dev` branch → Auto-deploys to preview URL with dev Supabase
- ✅ Merge to `main` → Auto-deploys to production with prod Supabase
- ✅ Test safely on dev, deploy confidently to production


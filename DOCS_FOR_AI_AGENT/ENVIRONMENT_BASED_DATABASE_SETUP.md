# Environment-Based Database Configuration

This project automatically selects the correct Supabase database (dev or prod) based on the environment configuration.

## 🎯 How It Works

The system automatically detects which environment you're in and uses the appropriate Supabase credentials:

- **Dev Environment**: Uses `NEXT_PUBLIC_SUPABASE_URL_DEV` and `NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV`
- **Prod Environment**: Uses `NEXT_PUBLIC_SUPABASE_URL_PROD` and `NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD`

## 🔧 Environment Detection

The environment is determined in this priority order:

1. **`NEXT_PUBLIC_ENVIRONMENT`** env var (explicit override)
   - Set to `"dev"` or `"prod"` to force an environment
2. **`NODE_ENV`** env var
   - `"production"` → prod environment
   - Anything else → dev environment

## 📝 Setup Instructions

### For Development (dev branch)

Create or update your `.env.local` file with:

```bash
# Explicitly set environment (optional, but recommended)
NEXT_PUBLIC_ENVIRONMENT=dev

# Dev Supabase credentials
NEXT_PUBLIC_SUPABASE_URL_DEV=https://your-dev-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV=your-dev-anon-key
SUPABASE_SERVICE_ROLE_KEY_DEV=your-dev-service-role-key
```

### For Production (main branch)

In your production deployment (e.g., Vercel), set these environment variables:

```bash
# Explicitly set environment (optional, but recommended)
NEXT_PUBLIC_ENVIRONMENT=prod

# Prod Supabase credentials
NEXT_PUBLIC_SUPABASE_URL_PROD=https://your-prod-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD=your-prod-anon-key
SUPABASE_SERVICE_ROLE_KEY_PROD=your-prod-service-role-key
```

## 🔄 Fallback Behavior

If environment-specific variables are not found, the system falls back to:

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`

This allows backward compatibility with existing setups.

## 🚀 Usage in Code

### Client Components / Browser

```typescript
import { createClient } from "@/lib/supabase/client";

// Automatically uses correct environment
const supabase = createClient();
```

### Server Components / API Routes

```typescript
import { createClient } from "@/lib/supabase/server";

// Automatically uses correct environment
const supabase = await createClient();
```

### API Routes with Service Role

```typescript
import { createSupabaseApiClient } from "@/lib/supabase/api-client";

// Automatically uses correct environment with service role key
const supabase = createSupabaseApiClient();
```

## 📋 Migration Guide

### Updating Existing API Routes

**Before:**
```typescript
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);
```

**After:**
```typescript
import { createSupabaseApiClient } from "@/lib/supabase/api-client";

const supabase = createSupabaseApiClient();
```

## ✅ Verification

To verify which environment is being used:

1. Check the console logs when the app starts
2. The error messages will indicate which environment variables are missing
3. You can add a debug log:

```typescript
import { getCurrentEnvironment, getSupabaseUrl } from "@/lib/supabase/env";

console.log("Current environment:", getCurrentEnvironment());
console.log("Supabase URL:", getSupabaseUrl());
```

## 🔒 Security Notes

1. ✅ Never commit `.env.local` to Git
2. ✅ Use different Supabase projects for dev and prod
3. ✅ Never share service role keys publicly
4. ✅ Set environment variables in your deployment platform (Vercel, etc.)

## 🐛 Troubleshooting

### "Missing Supabase environment variables" error

**Solution:** Ensure you have set the appropriate environment variables:
- For dev: `NEXT_PUBLIC_SUPABASE_URL_DEV` and `NEXT_PUBLIC_SUPABASE_ANON_KEY_DEV`
- For prod: `NEXT_PUBLIC_SUPABASE_URL_PROD` and `NEXT_PUBLIC_SUPABASE_ANON_KEY_PROD`

### Wrong database being used

**Solution:** 
1. Check `NEXT_PUBLIC_ENVIRONMENT` is set correctly
2. Verify `NODE_ENV` is set correctly
3. Ensure environment-specific variables are set (not just fallback variables)

### Service role key not working

**Solution:** Ensure you've set:
- `SUPABASE_SERVICE_ROLE_KEY_DEV` for dev
- `SUPABASE_SERVICE_ROLE_KEY_PROD` for prod

## 📚 Related Files

- `src/lib/supabase/env.ts` - Environment detection and credential selection
- `src/lib/supabase/client.ts` - Browser client
- `src/lib/supabase/server.ts` - Server client
- `src/lib/supabase/api-client.ts` - API route client with service role


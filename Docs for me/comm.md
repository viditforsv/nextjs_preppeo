Here is the ideal folder structure using a **Monorepo (TurboRepo)**.

This setup gives you the separation you want (Admin vs. Student App) while allowing the "Student App" to handle multiple subdomains (`sat`, `jee`, `gmat`) using a single codebase.

### The Structure (Monorepo)

```text
my-edtech-platform/
├── apps/
│   ├── admin/                # Internal Dashboard (Question Bank, CMS)
│   │   └── app/...           # Next.js App Router
│   │
│   ├── marketing/            # Main site (preppeo.com)
│   │   └── app/...
│   │
│   └── lms/                  # The Student Portal (sat.*, jee.*, gmat.*)
│       ├── middleware.ts     # ROUTING MAGIC: Detects 'sat' vs 'jee' subdomain
│       └── app/
│           ├── [domain]/     # Dynamic folder catching the subdomain
│           │   ├── page.tsx  # Dynamic Home (changes based on domain)
│           │   └── quiz/     # Shared Quiz UI
│           └── global-layout.tsx
│
├── packages/                 # Shared Code (The "Secret Sauce")
│   ├── ui/                   # Shared Buttons, Navbars, Cards
│   ├── database/             # Shared Supabase Client & Types
│   ├── logic/                # Shared Math parsers, Grading logic
│   └── tsconfig/             # Shared TypeScript configs
│
├── turbo.json                # Build pipeline config
└── package.json
```

### Why this works best:

1.  **`packages/ui`:** You build the "Quiz Player" component once. You import it into `apps/lms` and `apps/admin` (for previewing).
2.  **`apps/lms`:** This is a single Next.js app. You use **Middleware** to detect if the user is on `sat.preppeo.com`. If they are, you fetch SAT data. If `jee.preppeo.com`, you fetch JEE data.
3.  **`apps/admin`:** Totally separate. Admins don't need the flashy animations the students see; they need data tables.

### Key File: `apps/lms/middleware.ts`

This file allows one app to serve many domains.

```typescript
import { NextRequest, NextResponse } from 'next/server';

export default function middleware(req: NextRequest) {
  const hostname = req.headers.get('host'); // e.g., "sat.preppeo.com"
  const subdomain = hostname?.split('.')[0]; // "sat"

  // Rewrite the URL so Next.js sees: /sat/dashboard
  const url = req.nextUrl;
  url.pathname = `/${subdomain}${url.pathname}`;
  
  return NextResponse.rewrite(url);
}
```

-----

**Would you like me to generate the Supabase `questions` table schema including the `category` column to make this filtering work?**
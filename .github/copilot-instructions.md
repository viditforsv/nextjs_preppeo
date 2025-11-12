## Preppeo LMS — Copilot Instructions

These are concise, actionable notes to help an AI coding agent be productive in this repository.

- Project type: Next.js (App Router) with TypeScript, Tailwind CSS, shadcn/ui; Supabase as the primary backend (Auth + Postgres + RLS). See `package.json` and `README.md`.

- Big picture / architecture

  - Frontend: `src/app` (App Router). Global layout and providers live in `src/app/layout.tsx`.
  - Auth & access control: `src/middleware.ts` uses `@supabase/ssr` to hydrate server-side auth, then delegates route checks to `lib/access-control` (`canAccessRoute`, `getRedirectPath`). Any route access change likely needs middleware + corresponding RLS or API updates.
  - Contexts: `src/contexts/*` contains `AuthContext`, `CartContext`, etc. Use these when modifying auth or session flows.

- /******\******* ✨ Smart Paste 📚 ******\*******/
  /**\*\*\*** b6f21857-8cdb-461e-a3fb-29f5d765c4cf **\*\*\***/Data access: Supabase client is used both server-side and client-side. Look for `createServerClient` (middleware) and `@supabase/supabase-js` usage for service role operations. Migrations and DB SQL live under `supabase/migrations`.

- Critical developer workflows

  - Dev server: `npm run dev` (uses Next dev server). See `docs/LOCAL_DEV_SETUP.md` for Supabase local/cloud setup.
  - Build: `npm run build`. Use `npm run build:no-lint` only when linting blocks a quick build.
  - Type checking & linting: `npm run type-check`, `npm run lint`, `npm run lint:fix`.
  - Supabase: migrations and local dev are documented in `docs/LOCAL_DEV_SETUP.md`. Common commands (documented there): `supabase start`, `supabase db reset`, `supabase gen types typescript --local > src/types/supabase.ts`.

- Project-specific conventions & patterns

  - App Router + server components: many pages are intentionally dynamic. `src/app/layout.tsx` sets `export const dynamic = "force-dynamic"`. Respect server/client boundaries; if you add client-only code, include `'use client'` at the top and keep it in a client component file.
  - Middleware-driven auth: middleware enforces redirects and role checks. To change route protection, update `lib/access-control` and middleware together.
  - RLS-aware code: Database access assumes Row Level Security. Service-role operations require `SUPABASE_SERVICE_ROLE_KEY` and should be limited to server-only code (API routes or server components). Never commit service role keys.
  - Environment files: templates at `env.example`, `env.development.example`. Local dev expects `.env.local` per `docs/LOCAL_DEV_SETUP.md`.
  - UI patterns: shadcn + Tailwind utilities; prefer existing component patterns in `components/` (e.g., `TagInput.tsx`, `QuizPlayer.tsx`) and reuse `class-variance-authority` where present.

- Integration points & external dependencies

  - Supabase: `supabase/` folder + `@supabase/supabase-js` + `@supabase/ssr`. Pay attention to `supabase/migrations` and `supabase/config.toml`.
  - Third-party services: Stripe (`@stripe/*`), Razorpay (`razorpay`), OpenAI (`openai`), PDF (pdfjs-dist). Update CSP in `next.config.ts` when adding external hosts.
  - CDN / images: static assets in `public/images`. `next.config.ts` contains CSP headers; add external domains there if needed.

- Files to inspect first when making changes

  - `src/app/layout.tsx` — global providers, fonts, and dynamic rendering config
  - `src/middleware.ts` — central auth & route protection logic
  - `lib/access-control.*` — contains `canAccessRoute` and `getRedirectPath`
  - `supabase/migrations/` — DB schema changes and seeds
  - `docs/LOCAL_DEV_SETUP.md` — exact developer setup (dev vs prod Supabase projects)
  - `package.json` — useful npm scripts

- Examples (copy-paste friendly)

  - Start dev: `npm run dev` — app served on http://localhost:3000
  - Build without lint (quick): `npm run build:no-lint`
  - Generate supabase types: `supabase gen types typescript --local > src/types/supabase.ts` (see `docs/LOCAL_DEV_SETUP.md`)

- Quick agent rules
  - Never add or commit production service keys. If a change requires service keys, request a dev `.env.local` or use existing `env.development.example` guidance.
  - When touching auth or access control, update both `src/middleware.ts` and `lib/access-control` and add tests or manual verification steps in the README or docs.
  - Prefer small, isolated changes; modify migrations with care: add new migration files under `supabase/migrations/` rather than editing historical migrations.

If anything above is unclear or you'd like more examples (e.g., common edit + test cycle for middleware changes), tell me which area to expand and I'll iterate.

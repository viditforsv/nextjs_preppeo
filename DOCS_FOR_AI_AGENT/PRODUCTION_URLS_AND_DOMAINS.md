# Production URLs & Domains (READ BEFORE TOUCHING ANY PUBLIC URL)

Authoritative reference for which domain Preppeo actually serves from, which env
vars build public links, and the gotchas that have already burned us once.

> **TL;DR — the live production domain is `https://preppeo.com` (apex redirects
> to `https://www.preppeo.com`). It is NOT `courses.preppeo.com`.**
> `courses.preppeo.com` is **not attached to this Vercel project and returns 404.**
> Any code, doc, or env var that points public/marketing/SEO/auth URLs at
> `courses.preppeo.com` is wrong.

## Canonical facts

| Thing | Value |
|-------|-------|
| Vercel project | `nextjs-preppeo-lms` (`prj_CZQ0rZ5tPWri8AuSoB6RhSUgJ8J8`) |
| Vercel team | `team_NPY2rk3ZnJK4fzeraFM70CjZ` |
| Production domains on the project | `preppeo.com`, `www.preppeo.com` (+ `*.vercel.app` aliases) |
| Apex behaviour | `preppeo.com` 301-redirects to `www.preppeo.com` |
| `courses.preppeo.com` | **NOT on this project → 404.** Do not use it. |
| Production branch | `main` (Vercel auto-deploys on push) |
| Preview branch | `dev` (`*.vercel.app`) |

## The env vars that build public links

| Env var | Production value | Used by |
|---------|------------------|---------|
| `NEXT_PUBLIC_APP_URL` | `https://preppeo.com` | `sitemap.ts`, `robots.ts`, `layout.tsx` (OG/canonical metadata), auth callback redirect, token fulfilment |
| `NEXT_PUBLIC_SITE_URL` | `https://preppeo.com` | auth callback redirect (secondary), `AuthContext` |

Both are set to `https://preppeo.com` in Vercel **Production**. Keep them in
sync — if they ever disagree or point at `courses.preppeo.com` again, sitemap,
robots, social-share previews, and post-login redirects all silently break.

`.env.production` (committed, non-secret defaults) must also use
`NEXT_PUBLIC_APP_URL=https://preppeo.com`.

## CRITICAL gotchas

1. **`NEXT_PUBLIC_*` vars are baked at BUILD time, not read at runtime.**
   Changing them in the Vercel dashboard/CLI does nothing until you **redeploy
   production**. After any change, push to `main` (or trigger a redeploy) and
   re-verify the live URLs.

2. **The Vercel CLI marks new env vars "sensitive" by default**, which is wrong
   for `NEXT_PUBLIC_*` (they're public anyway) and makes them unreadable. When
   adding/updating these via CLI, pass `--no-sensitive`:
   ```bash
   vercel env rm NEXT_PUBLIC_APP_URL production -y
   vercel env add NEXT_PUBLIC_APP_URL production --value "https://preppeo.com" --no-sensitive --yes
   ```
   A sensitive var returns an **empty string** on `vercel env pull` — so an empty
   pulled value usually means "sensitive flag", not "unset".

3. **Never reintroduce a `courses.preppeo.com` default.** All known occurrences
   were purged on 2026-05-29 (env-var fallbacks in `courses/[slug]/page.tsx` and
   `tokens/fulfill-purchase.ts`, hardcoded links across `lib/email/templates.ts`,
   and proxy `Referer`/`Origin` fallbacks). Any new code that needs a base URL
   should read `NEXT_PUBLIC_APP_URL` with a `https://preppeo.com` fallback — or,
   for email links, hardcode `https://preppeo.com` (see gotcha #4).

4. **Marketing/transactional emails should hardcode `https://preppeo.com`**, not
   read the env var — links in an inbox can't be fixed by a redeploy. The QOTD
   welcome email (`src/app/api/qotd/capture/route.ts`) does this deliberately.

## How to verify after any URL/domain/env change

```bash
# Pages resolve (200, not 404):
curl -sL -o /dev/null -w "%{http_code} %{url_effective}\n" https://preppeo.com/question-of-the-day

# robots.txt points its Sitemap line at preppeo.com (NOT courses.preppeo.com):
curl -sL https://preppeo.com/robots.txt | grep -i sitemap

# sitemap.xml <loc> entries use preppeo.com and contain zero courses.preppeo.com:
curl -sL https://www.preppeo.com/sitemap.xml | grep -c courses.preppeo.com   # must be 0

# Manually: log in on prod and confirm the post-login redirect lands on preppeo.com.
```

## Dev / Preview environment

- Dev domain: **`https://dev.preppeo.com`** (200), served by the `dev` git branch.
  **`dev.courses.preppeo.com` is dead (404)** — same trap as prod's `courses.preppeo.com`.
- Vercel **Preview (dev)** must set `NEXT_PUBLIC_APP_URL` and `NEXT_PUBLIC_SITE_URL`
  to `https://dev.preppeo.com` (both `--no-sensitive` so they stay readable).
- The **localhost-after-OAuth** redirect is a *Supabase* problem, not a Vercel one:
  Supabase bounces to its **Site URL** (default `http://localhost:3000`) when the
  `redirect_to` isn't in its **Redirect URLs** allowlist. Fix on the **dev branch**
  Supabase project (`dxhxpfouzjlzpeazwrqo`) → Authentication → URL Configuration:
  Site URL = `https://dev.preppeo.com`, Redirect URLs include `https://dev.preppeo.com/**`.

## History

- **2026-05-30** — OAuth on `dev.preppeo.com` bounced to `http://localhost:3000`.
  Two causes: (1) Vercel Preview(dev) `NEXT_PUBLIC_APP_URL` was `https://dev.courses.preppeo.com`
  (404) — fixed to `https://dev.preppeo.com` + added `NEXT_PUBLIC_SITE_URL`; (2) the localhost
  bounce itself is the dev Supabase Auth Site URL / Redirect-URL allowlist (dashboard fix).
- **2026-05-29** — QOTD welcome email CTA pointed at `courses.preppeo.com/sat-test`
  (404). Root cause: Vercel prod `NEXT_PUBLIC_APP_URL` + `NEXT_PUBLIC_SITE_URL`
  were both set to `https://courses.preppeo.com`, a domain not on the project.
  Fixed both env vars to `https://preppeo.com`, hardcoded the email's links,
  redeployed, and verified. This doc created so it can't recur.

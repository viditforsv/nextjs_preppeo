# Sprint — 1 June to 14 June 2026

Consolidated from `tasks 29-31 May 2026.md`, `tasks_2026-04-30.md`, and `plan_25mar2026.md`. Only **open** (unchecked) items are carried forward; completed work is omitted. Ordered by priority and grouped into Week 1 (1–7 Jun) and Week 2 (8–14 Jun).

> **Progress as of 2026-06-01 (all live on prod):**
> - ✅ **P0 forgot-password** — fully fixed end-to-end (token_hash + verifyOtp, branded ZeptoMail email, resend-cooldown UX, expired-link double-consume fix).
> - ✅ **Desmos guides ×10** — all published with demo clips **and** a live interactive Desmos calculator per guide.
> - ✅ **SAT mock sets 6–10** — promoted to prod (`total_sets=10`); 10-mock pack added.
> - ✅ **Analytics** — shipped to prod (earlier deploys). Verification checkboxes below remain yours.
> - ➕ Off-sprint extras shipped: SAT-first dashboard redesign + new Progress Report page.
> - ⏭️ Still open: analytics *verification*, mock backfill (2 easy adv-math), hiring, testing/observability, housekeeping.

---

## 🔴 P0 — User-blocking bugs (do first)

- [x] **Fix forgot-password / password-reset flow** — ✅ DONE, live on prod 2026-06-01. Root cause: PKCE recovery links broke across devices + got burned by email-scanner prefetch. Fix: `/auth/reset-password` now verifies a `token_hash` link via `verifyOtp` (stateless, device-independent), Supabase template emits the token_hash link, emails branded via ZeptoMail SMTP. Also fixed a double-`verifyOtp` race (false "expired") and added a 60s resend cooldown + clearer messaging on `/auth/forgot-password`. Tested end-to-end on dev + prod. #preppeo #bug
  - *Optional follow-up:* raise prod Supabase **Auth → Rate Limits → emails/hour** (30 → ~150) for real-traffic headroom.
  - *Deferred (logged in `project-plans_June-2026.md`):* post-login redirect is slow — separate perf fix, not blocking.

---

## 📊 Analytics & funnel — finish going live

Three-layer stack (Vercel Analytics + PostHog + GA4) is installed and wired into `src/app/layout.tsx`; type-check + prod build pass. PostHog now routes through the first-party `/ingest` reverse proxy. Remaining work is verification + production promotion.

- [ ] **Verify events flow** — on the dev preview URL: open it, click around / log in, then check PostHog → Activity (or Web Analytics). `ingested_event` should flip to true. 📅 2026-05-31 #preppeo #analytics
- [ ] **Verify free-mock funnel admin page** at `http://localhost:3000/admin/analytics/free-mock` (needs admin login). #preppeo #analytics
- [x] **Promote `dev` → `main`** (production deploy) so analytics ship to `preppeo.com`. ✅ DONE — shipped via prod deploys; PostHog + Vercel + GA4 live on prod.
- [ ] **Promote free-mock funnel view migration to prod** (`vw_sat_free_mock_funnel`) when ready — re-run against `ootnqmojcqnzfrtvzzec`. Read-only DDL, safe anytime, follows dev→prod rule. #preppeo #analytics

---

## 🔍 SEO — Desmos guides

- [x] **Produce the backlog Desmos guides** — ✅ DONE, live on prod. All 10 guides published with steps/proTip/practice, recorded + encoded demo clips (uniform 1280×640), breadcrumbs + HowTo/BreadcrumbList schema, and — beyond the original scope — a **live interactive Desmos calculator** embedded in each guide's "Try it yourself" section (pre-loaded with that guide's example). Recording scripts kept in `Docs for me/desmos-recording-scripts/`. #preppeo #seo

---

## 👥 Hiring & community — delegate to a VA

**Why:** you're an engineer + educator, not a community manager. The QOTD engine is live and ready to capture leads — a VA feeds it. Hire a sharp, hungry uni student on Upwork / Internshala (a few hrs/week), **not** an agency.

**Hire & onboard**
- [ ] Post the VA job (Upwork + Internshala): "Virtual Assistant for Student Community Engagement (SAT Prep / Reddit & Discord)" — value-first, non-spam framing 📅 2026-05-31 #hiring
- [ ] Draft 3–5 screening questions (SAT structure knowledge, active Reddit/Discord presence, comms skills) 📅 2026-05-31 #hiring
- [ ] Define VA tasks (see "What the VA runs" below) 📅 2026-05-31 #hiring
- [ ] Set comp: base hourly + bonus per 50 verified email signups (align hustle to growth) 📅 2026-05-31 #hiring
- [ ] Weekly handoff: every Sunday give the VA a folder of 7 queued questions + 1-line explanations 📅 2026-05-31 #hiring

**What the VA runs (stop doing this yourself)**
- [ ] Launch post to r/SAT — framed as a tool built from frustration, not a product launch #preppeo
- [ ] Same post in 2–3 SAT Discords #preppeo
- [ ] Daily: monitor r/SAT + SAT Discords for students stuck on hard math; answer 2–3 purely helpfully (zero pitch); point daily-practice askers to the free QOTD portal #preppeo
- [ ] Maintain a warm Reddit account (real founder account, or a warmed one) #preppeo

---

## 🧪 Testing & observability (carry-overs from plan_25mar2026)

- [ ] **Sentry smoke test** — trigger a thrown error in a component, confirm `ErrorBoundary` catches it and the event reaches Sentry. ~15 min. *(Quickest remaining real-feature work — good first pickup.)*
- [ ] **Middleware auth-redirect test** (`src/middleware.ts`) — cover signed-in vs signed-out redirects on protected routes. ~30 min.
- [ ] **Component tests for QuizPlayer + UnifiedLessonPage** — install `jsdom` + `@testing-library/react`, wire into `vitest.config.ts`, add the two test files. ~2 hrs; start only after the two tests above.
- [ ] **Fix pre-existing test failures** in `src/__tests__/api/mocks/create-order.test.ts` (4 tests — spy not called for `token_purchases.insert`). Pre-existing, not introduced by middleware fix. Low priority but get `npm test` green.

---

## 🗃️ SAT mock sets 6–10

- [x] **Promote sets 6–10 to prod** — ✅ DONE 2026-05-31. 735 question rows promoted to `ootnqmojcqnzfrtvzzec` (reconciled by `bank_item_id` due to dev/prod pool id divergence, not the raw assignment migrations); `exam_types.total_sets` 5→10; 10-mock pack (₹4999/$79) added. Verified: 10 sets × 147q, all `qc_done`/`is_active`. #preppeo
- [ ] **Backfill (low priority)** — sets 9/10 M1 advanced-math have **0 easy** (5M+2H instead of 1E+4M+2H) because the easy adv-math pool was exhausted; this shipped to prod as-is. Author 2 easy advanced-math questions, then a small migration to swap the substituted mediums (dev → QC → prod). #preppeo

---

## 🧹 Housekeeping (low impact)

- [ ] **`.claude/settings.local.json`** — accumulated additive permission grants from SAT seeding sessions. Either commit as-is or trim one-off `sat_lid_NNN` greps. Low impact.
- [ ] **Docs cleanup** — strike through completed items in `plan_25mar2026.md` and roll remaining open ones into the running plan (this sprint file supersedes the scattered task lists).

---

## Suggested sequencing

**Week 1 (1–7 Jun):**
1. P0 password-reset bug (user-blocking).
2. Verify analytics events + funnel admin page on dev.
3. Sentry smoke test (15 min) + middleware auth test (30 min).
4. Post the VA job + draft screening questions (kick off hiring early — it has lead time).

**Week 2 (8–14 Jun):**
5. Promote `dev → main` for analytics + funnel view (after QC, confirm-before-prod).
6. Produce Desmos guides (batch 3–4, ~30–45 min each).
7. Component tests for QuizPlayer + UnifiedLessonPage; clean up failing create-order tests.
8. SAT sets 6–10 prod promotion **if** user gives go-ahead; backfill questions.
9. Housekeeping: settings.local.json + docs cleanup.

### Out of scope this sprint
- PostHog session replay / event-schema doc (E2 later phases) — start once "who signed up?" shifts to "why isn't traffic converting?"
- GA4 (E3) — only when paid Google Ads campaigns start.
- Paid-mock analytics, LMS/course analytics, in-test engagement metrics, A/B testing.
- Vercel CLI upgrade.

# Projects

> Detailed plans (Objective · Mission · Starting point · Roadmap) for each → [`project-plans_June-2026.md`](project-plans_June-2026.md)

- ✅ desmos guides x 10 — done (live, with interactive calculators)
- ✅ Finalise 10 mocks for SAT — live on prod (⏳ low-pri backfill: 2 easy adv-math on sets 9/10)
- Setup email marketing with Zoho marketing
- Self Learn course launch
- ✅ Razorpay accept international payments — verified (foreign cards pay in INR today); USD presentment blocked on IEC
- Hire someone for digital presence
- End to End testing for User onboarding
- Create setup when something breaks on portal or an error occurs, we receive an email or whatsapp
- Analytics on Practice mode — *(student-facing Progress Report shipped; admin/PostHog practice analytics still open)*
- Clean repo with stale or useless files
- explore https://admitwise.in/
- Add what next for me on the reports page
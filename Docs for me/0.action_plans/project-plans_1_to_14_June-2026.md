# Project Plans — June 2026

## 3. Email Marketing with Zoho

- **Objective:** Stand up a **bulk marketing-email** capability via Zoho, separate from transactional, with a clean lead list + branded template.
- **Mission:** Own a direct, founder-controlled channel to the lead list for re-engagement and conversion — not hostage to social-platform reach.
- **Starting point:** **Transactional email already works** — `src/lib/email/send.ts` (nodemailer → Zoho **ZeptoMail** SMTP, `smtp.zeptomail.in`, from `noreply@preppeo.com`) with templates in `src/lib/email/templates.ts` (welcome, enrollment, purchase, subscription). **No marketing/bulk.** Leads captured at signup (`profiles`) + free-mock claim (`test_tokens`). Marketing product = **Zoho Campaigns** (distinct from ZeptoMail).

**Roadmap:**
- ⬜ Confirm tool = **Zoho Campaigns** (marketing) vs ZeptoMail (transactional). Decide & set up account.
- ⬜ Verify `preppeo.com` sending domain in Zoho Campaigns (SPF/DKIM — partly set for ZeptoMail; confirm/extend).
- ⬜ Export lead list from Supabase: emails from `profiles` **+ marketing-consent flag** (only opted-in).
- ⬜ Import as a Zoho Campaigns mailing list (compliance: consent, unsubscribe).
- ⬜ Build a branded campaign template matching the transactional look (header/footer).
- ⬜ Add compliant unsubscribe + physical-address footer.
- ⬜ *(Later)* Auto-sync new opted-in signups → Zoho list.

---

## 4. Send 20 Emails  ⏸️ *needs definition*

- **Objective:** **TBD** — undefined until audience + goal are set.
- **Mission:** TBD.
- **Starting point:** Blocked on definition. Depends on #3 (Zoho marketing live). Candidate framings discussed: re-engage existing signups · cold outreach to new prospects · pilot send to validate Zoho.

**Roadmap:**
- ⬜ **DEFINE FIRST** (own decision): audience, goal/CTA, content angle, success metric, the 20 recipients.
- ⬜ *(then)* Draft copy → segment recipients → send → measure opens/clicks/replies.

---

## 5. Self-Learn Course Launch — *content finalization*

- **Objective:** Finalize + QC the self-paced course **content** so it's launch-ready (checkout wiring is explicitly a separate, later project).
- **Mission:** A polished self-paced course is the higher-margin product; content readiness is the gate before any paid launch or marketing.
- **Starting point:** Delivery is built — `/learn/[courseSlug]/`, lesson pages, `UnifiedLessonPage`. Pricing is **enquiry-only** (WhatsApp). Content **completeness is unknown** — needs an audit. Self-paced tiers defined in `src/config/pricing.ts` (1/3/6/12 mo).

**Roadmap:**
- ⬜ Audit the self-paced course: list every module/lesson, flag placeholders/gaps.
- ⬜ Lock the "complete" curriculum outline (what a buyer receives).
- ⬜ Produce/import missing lessons (content + PDFs/videos).
- ⬜ QC each lesson on dev: math renders, images load, tabs work.
- ⬜ Proofread copy; fix LaTeX/render issues.
- ⬜ Content-readiness sign-off (then hand to a future "enable checkout" project).

---


## 7. Hire for Digital Presence

- **Objective:** Hire a VA/contractor to run community + digital presence (Reddit/Discord/social), feeding the QOTD lead engine.
- **Mission:** Free the founder from community management while sustaining top-of-funnel lead flow. (Same person as the sprint's "Community VA".)
- **Starting point:** Plan drafted in the sprint (job framing, screening, comp, task list). QOTD engine live to capture the leads they drive. No hire made yet.

**Roadmap:**
- ⬜ Post VA job (Upwork + Internshala) — value-first, non-spam framing.
- ⬜ Draft 3–5 screening questions (SAT structure, active Reddit/Discord, comms).
- ⬜ Define the VA task list + a simple SOP doc.
- ⬜ Set comp: base hourly + bonus per 50 verified email signups.
- ⬜ Shortlist → interview → hire.
- ⬜ Onboard: launch posts to r/SAT + 2–3 SAT Discords; daily helpful monitoring; weekly handoff of 7 queued QOTD questions.

---

## 8. End-to-End Testing for User Onboarding

- **Objective:** An automated E2E test covering **signup → claim free mock → start mock**.
- **Mission:** Protect the most revenue-critical funnel from regressions. (The reset-password bug shows what untested auth costs.)
- **Starting point:** **Vitest unit tests only** (15 files, API/store level — incl. `claim-free`, `practice-questions`, payment routes). **No Playwright/Cypress, no UI/E2E.** Flow under test: signup → `profiles` row → `claim-free` → `test_tokens` → `sat_test_attempts.started_at`.

**Roadmap:**
- ⬜ Install + configure **Playwright**.
- ⬜ Disposable test-user setup/teardown on dev (Supabase test account).
- ⬜ E2E: signup → authenticated landing.
- ⬜ E2E: claim free mock → token appears.
- ⬜ E2E: start mock → first question renders.
- ⬜ Wire into CI (run on PRs targeting `dev`).

---

## 9. Error Alerting → Email / WhatsApp

- **Objective:** Get notified by **email + WhatsApp** when a portal error or outage occurs.
- **Mission:** Slash mean-time-to-detect — the reset-password bug went unnoticed for weeks. Founders should hear about breakage before users complain.
- **Starting point:** **Sentry installed** (`sentry.client.config.ts`/`sentry.server.config.ts`, error boundaries, error-only session replay) but **no human alerting** configured. No uptime monitor. No notification infra/health route.

**Roadmap:**
- ⬜ Configure Sentry **alert rules → email** (new fatal errors, issue-frequency spikes).
- ⬜ Add Sentry → **WhatsApp** (Sentry has native Slack; WhatsApp via Twilio/Zapier/webhook bridge).
- ⬜ Add a `/api/health` route (DB ping + basic checks) if none exists.
- ⬜ Add an **uptime monitor** (UptimeRobot / Better Uptime) on `preppeo.com` + `/api/health` → email/WhatsApp on downtime.
- ⬜ Test: throw a deliberate error + simulate downtime → confirm both channels fire. *(Absorbs the sprint's "Sentry smoke test".)*

---

## 10. Analytics on Practice Mode

- **Objective:** Track practice-mode engagement: who practices, how often, by difficulty/domain, free vs premium, and free-limit-hit → upgrade signal.
- **Mission:** Understand the practice habit and find the practice → paid conversion lever (currently invisible).
- **Starting point:** Practice mode live — `api/sat/practice-questions`, `practice-usage`, `record-answer`; free daily limits (2E+2M+1H), premium unlimited via `user_subscriptions`. **No practice analytics** — the only dashboard is the free-mock funnel (`vw_sat_free_mock_funnel`, `/admin/analytics/free-mock`). PostHog live but practice events likely uncaptured.

**Roadmap:**
- ⬜ Define metrics: daily active practicers, questions/day, by difficulty + domain, free-limit-reached rate, free-vs-premium split, accuracy.
- ⬜ Capture PostHog events: `practice_started`, `practice_question_answered` (+correct), `practice_limit_reached`, `upgrade_clicked_from_practice`.
- ⬜ DB view aggregating practice attempts (mirror the `vw_sat_free_mock_funnel` pattern). Migration to dev.
- ⬜ Admin page `/admin/analytics/practice` — metric cards + table + CSV (clone the free-mock page).
- ⬜ Verify on dev; promote view to prod.

---

## 11. Clean Repo (stale / useless files)

- **Objective:** Remove stale, dead, and duplicate files from the repo + submodule so the tree is legible.
- **Mission:** Lower cognitive load; make onboarding (human or AI) faster; shrink the repo.
- **Starting point:** **In progress** — already deleted 4 stale task docs + the redundant `sat-ecosystem` folder (rescued its unique SAT verbal bank into the submodule). More candidates remain.

**Roadmap:**
- 🔄 Sweep `Docs for me/` for obsolete docs (keep active reference guides; cull one-off task lists).
- ⬜ Audit `src/app/dev/**` scratch routes (e.g. `sat-math-quest`) — gate behind admin/env-flag or remove.
- ⬜ Find unreferenced components/utils (dead code) via `ts-prune` (or similar).
- ⬜ Find orphaned `public/` assets.
- ⬜ Remove stray `.DS_Store` repo-wide; confirm it's gitignored.
- ⬜ Commit in small logical batches.

---

## Cross-project notes

- **Dependencies:** #4 (Send 20 emails) depends on #3 (Zoho marketing). #9 absorbs the sprint's Sentry smoke test. #10 reuses the free-mock funnel pattern. #7 = the sprint's Community VA.
- **Confirm-before-prod** gates: #2 (sets 6–10 prod promotion), and any prod deploy. Everything else is dev/preview-first per the standing workflow.
- **Sequencing suggestion:** quick wins + safety first (#11 cleanup ongoing, #9 alerting, #6 verify Razorpay), then revenue depth (#2 mocks, #1 Desmos SEO), then growth machinery (#3 email → #4 send, #7 hire, #10 practice analytics), with #5 content + #8 E2E as steady background work.

---

## Deferred / known issues

- ⬜ **Auth post-login redirect is slow.** After authenticating on `/auth`, the
  redirect to the next screen (dashboard / `next`) lags. Confirmed during
  forgot-password testing on dev (2026-06-01) — the reset flow itself works
  (token_hash + verifyOtp + branded ZeptoMail email, dev branch). Deferred — fix
  later. Likely candidates: the `/api/profiles/me` round-trip + role lookup in
  `/auth/page.tsx` before redirect, or the `exchangeCodeForSession` → profile
  fetch chain. Worth profiling that effect before changing anything.

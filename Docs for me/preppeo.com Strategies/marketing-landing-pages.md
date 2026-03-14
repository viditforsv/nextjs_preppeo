# Preppeo Marketing Strategy: Landing Pages, Pricing, and Partner Program

## Two Sales Channels

### A. Direct to Customer (D2C)
Students discover Preppeo directly via search, social media, or referrals. They land on preppeo.com, try a free mock, and convert to paid mocks or subscriptions.

### B. Channel Partners (B2B2C)
Teachers, tutoring centers, and coaching institutes use Preppeo's mock tests as part of their offering. They get a partner referral code, share it with their students, and earn commission on every purchase made using their code.

---

## Product Offerings (Current)

### Mock Tokens (one-time purchase)
| Pack | Price | Per Mock |
|------|-------|----------|
| 1 SAT Mock | Rs 499 | Rs 499 |
| 3 SAT Mocks | Rs 999 | Rs 333 |
| 5 SAT Mocks | Rs 1,499 | Rs 300 |

### Institute Packs (bulk)
| Pack | Price | Per Mock |
|------|-------|----------|
| 50 Mocks | Rs 29,000 | Rs 580 |
| 100 Mocks | Rs 46,000 | Rs 460 |
| 300 Mocks | Rs 1,00,000 | Rs 333 |
| 500 Mocks | Rs 1,25,000 | Rs 250 |

### Practice Subscriptions
| Plan | Duration | Price | Includes |
|------|----------|-------|----------|
| Practice Mode — 1 Month | 30 days | Rs 9,999 | Unlimited practice questions |
| Practice Mode — 3 Months | 90 days | Rs 14,999 | Unlimited practice questions |
| Complete Prep — 3 Months | 90 days | Rs 19,999 | Unlimited practice + 3 mock tokens |

### Free Tier
- 1 complimentary SAT mock (Set 1) on sign-up
- 5 free practice questions per day (2 easy + 2 medium + 1 hard)

---

## Partner Program

### How it works
1. Partner signs up and gets a unique referral code (e.g. COACHING30).
2. Partner shares the code with their students.
3. Students apply the code at checkout and get a discount (default 10%).
4. Partner earns commission on every purchase (default 30% of paid amount).
5. Commissions are tracked in the dashboard and paid out periodically.

### Current partner configuration
- Default commission rate: 30%
- Default student discount: 10%
- Both rates are configurable per partner via admin panel.

### Partner value proposition
- No upfront cost for the partner.
- Institute packs for bulk purchases at lower per-mock cost.
- Dashboard to track referrals and commissions.
- Students get a discount, so the partner adds value.

---

## Landing Pages Required

### Page 1: Student Landing (`/` — the homepage)

**Goal:** Convert visitors into free mock users, then into paid users.

**Sections:**
1. **Hero** — "Ace your Digital SAT" + primary CTA: "Start Free Mock" + secondary: "Explore All Mocks"
2. **Trust bar** — "Adaptive. Timed. Scored. Just like the real exam." or similar social proof.
3. **Exam showcase** — SAT (live), GRE (live), Ashoka (live), GMAT (coming soon). Each with a "Start Mock" CTA.
4. **What you get** — Mock tests, Practice mode, Score reports, AI-powered analytics.
5. **Pricing** — Token packs and subscription plans with clear CTAs.
6. **How it works** — 3 steps: Sign up free -> Take a mock -> Review your score report.
7. **Referral callout** — "Invite friends, both get a free mock."
8. **Final CTA** — "Start your free SAT mock now."

**Key messaging:**
- Lead with "free" — the complimentary mock removes friction.
- Emphasize the product is exam-realistic (adaptive, timed, scored).
- Practice mode as a daily habit (5 free questions/day, unlimited with subscription).

---

### Page 2: Partner / Institute Landing (`/for-institutes`)

**Goal:** Get teachers and institute owners to sign up as partners.

**Sections:**
1. **Hero** — "Offer world-class SAT mocks to your students. Earn on every purchase." + CTA: "Become a Partner"
2. **Problem statement** — "Your students need realistic practice. Building your own mock platform is expensive and slow."
3. **Solution** — "Use Preppeo's adaptive mocks under your recommendation. We handle the tech, you earn commission."
4. **How it works** — 3 steps:
   - Get your unique partner code
   - Share with your students (they get a discount)
   - Earn 30% commission on every purchase
5. **Institute packs** — Bulk pricing table (50, 100, 300, 500 mocks).
6. **Earnings calculator** — Simple interactive widget: "If you have X students and each buys Y mocks, you earn Rs Z."
7. **Partner dashboard preview** — Screenshot or mockup of the dashboard showing referral code, commission stats, and payout history.
8. **Testimonials / trust** — (placeholder for now; fill as partners come on board).
9. **CTA** — "Apply to become a partner" form or link to contact.

**Key messaging:**
- Zero upfront cost, zero tech overhead.
- Focus on earnings potential (commission + bulk pricing margin).
- "Your students get a discount, you earn commission, everyone wins."

---

## Student Referral Program (separate from partner program)

Already implemented at `/referral`. Works peer-to-peer:
- Student shares their referral link.
- Friend signs up and claims free mock using the link.
- Both student and friend get a bonus mock token.

This is different from the partner program (which is for institutes/teachers and involves monetary commission).

---

## Open Questions / Next Steps

1. **Partner sign-up flow:** Currently partners are created by admin. Should we add a self-serve "Apply to be a Partner" form on the partner landing page?
2. **Pricing display:** Should we show all pricing publicly on the student landing page, or only after sign-up?
3. **SEO pages:** Should we create exam-specific landing pages (e.g. `/sat`, `/gre`) for better search ranking?
4. **Blog / resources:** Do we need a content marketing section for organic traffic?

---

## Feature Suggestions (Backlog)

1. **Partner Dashboard (public-facing):** Build a dedicated partner dashboard at `/partner/dashboard` that shows referral code, real-time commission stats, payout history, and student activity. Currently partners are managed via the admin panel. Once this is built, add a "Dashboard Preview" section to the `/for-institutes` landing page and link partners directly to it after sign-up.

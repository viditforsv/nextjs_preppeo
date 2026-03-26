# Preppeo — Improvement Plan (25 Mar 2026)

Three high-priority improvements identified in the codebase review.

---

## 1. Split Large Components

> Three monolithic components (UnifiedLessonPage 91KB, QuizPlayer 44KB, MathRenderer 27KB) mix UI, business logic, and data fetching. Goal: shrink each to an orchestrator and move logic into custom hooks and sub-components.

### MathRenderer.tsx (do first — no external deps)
- [x] Create `src/utils/latex/preprocessor.ts` — move `preprocessLatex()` and `processIncludegraphics()`
- [x] Create `src/utils/latex/parsers.ts` — move `parseDataTablePrompt()` and `detectEnvironment()`
- [x] Create `src/components/math/renderMathContent.tsx` — `renderMathContent()` (renderers.ts merged here)
- [x] Create `src/components/math/environments.tsx` — all environment renderers (align/enumerate/tabular/tasks/parts/etc.) in one file
- [x] Create `src/components/math/MathAtom.tsx` — core KaTeX component (leaf node to avoid circular deps)
- [x] Slim `MathRenderer.tsx` to core component + re-exports only (~150 lines)
- [x] Verify: `npx tsc --noEmit` passes with zero errors

### QuizPlayer.tsx
- [x] Create `src/hooks/useQuizTimer.ts` — global countdown + per-question timer, auto-submit on 0
- [x] Create `src/hooks/useQuizSession.ts` — started/submitted/sessionId state, quiz fetch, start/submit/retry actions
- [x] Create `src/hooks/useAnswerTracking.ts` — answers map, check logic, attempt recording (wraps existing useQuestionAttempt pattern)
- [x] Create `src/components/quiz/QuizStartCard.tsx` — pre-start info card
- [x] Create `src/components/quiz/QuestionDisplay.tsx` — renders question + all option types (MCQ, TF, fill, essay) + answer feedback
- [x] Create `src/components/quiz/QuestionNavigator.tsx` — question grid with status colours
- [x] Create `src/components/quiz/ResultsView.tsx` — score, encouragement, per-question review
- [ ] Create `src/components/quiz/QuestionReviewCard.tsx` — single question result with explanation (merged into ResultsView)
- [x] Slim `QuizPlayer.tsx` to ~100-line orchestrator
- [x] Verify: `npx tsc --noEmit` passes with zero errors

### UnifiedLessonPage.tsx (do last — most complex)
- [x] Create `src/hooks/useEditableField.ts` — reusable admin inline-edit pattern
- [ ] Create `src/hooks/useLessonTabs.ts` — determines visible tabs from content presence (tabs logic kept inline)
- [x] Create `src/hooks/useFeedbackForm.ts` — feedback modal state + image upload + POST /api/lesson-feedback
- [x] Create `src/hooks/useAITutor.ts` — chat messages, send handler, typing indicator
- [x] Create `src/components/lesson/LessonHeader.tsx` — title, badges, admin edit buttons
- [x] Create `src/components/lesson/LessonNavigation.tsx` — prev/next lesson buttons
- [ ] Create `src/components/lesson/PDFViewer.tsx` — iframe + screenshot prevention wrapper (kept inline)
- [x] Create `src/components/lesson/ChatInterface.tsx` — AI tutor chat UI
- [x] Create `src/components/lesson/FeedbackModal.tsx` — feedback form + image upload
- [ ] Create `src/components/lesson/TabContent.tsx` — tab content dispatcher (kept inline)
- [x] Slim `UnifiedLessonPage.tsx` to ~450-line orchestrator (down from 2172 lines)
- [x] Verify: `npx tsc --noEmit` passes with zero errors

---

## 2. Global Error Handling & Error Tracking

> No React Error Boundary exists. API failures have no retry logic. No error tracking service is integrated.

- [x] Create `src/components/ErrorBoundary.tsx` — class-based React Error Boundary with fallback UI
- [x] Wrap root layout (`src/app/layout.tsx`) with ErrorBoundary
- [x] Add per-route error.tsx for critical routes: lesson (learn + courses), sat-test, gre-test
- [x] Create `src/lib/error-tracking.ts` — console-based now, Sentry-ready (see TODO comments inside)
- [x] Install and configure Sentry: `npm install @sentry/nextjs` + `NEXT_PUBLIC_SENTRY_DSN` added to .env.development and .env.production
- [x] Added `sentry.client.config.ts` and `sentry.server.config.ts`; wrapped `next.config.ts` with `withSentryConfig`; updated CSP to allow `*.ingest.de.sentry.io`
- [x] Add retry logic — `src/lib/fetch-with-retry.ts` with exponential backoff
- [x] Validate Razorpay: added type/range checks in create-razorpay; fixed critical bug in verify-razorpay (payment.status was never checked — users could enroll without a captured payment)
- [x] `SENTRY_AUTH_TOKEN` added to `.env.local` and Vercel env vars — source maps will upload on every production build
- [x] Wire `fetchWithRetry` into: lesson content + questions (UnifiedLessonPage), course + interactive (LearnLessonPageClient), quiz + questions (useQuizSession)
- [ ] Test: trigger an error in a component, confirm boundary catches it and Sentry receives the event

---

## 3. Test Coverage — Test Session Flows

> Only 9 test files exist. Critical flows (SAT/GRE/CBSE test sessions, course enrollment, quiz) have no coverage.

- [x] Add tests for `useSATTestStore` — setAnswer, toggleFlag, navigateQuestion, submitModule (phase transitions), startTestMode (fetch + fallback)
- [x] Add tests for `useGRETestStore` — same shape as SAT store tests
- [ ] Add tests for `QuizPlayer` flow — needs `@testing-library/react` + jsdom setup (deferred)
- [x] Add tests for `/api/sat/record-answer` route
- [x] Add tests for `/api/payments/create-razorpay` and `/api/payments/verify-razorpay`
- [x] Add tests for `/api/user-progress` — GET (auth/no-auth), POST (validation, free/paid courses, enrollment check), PUT (auth, ownership)
- [ ] Add component tests for `QuizPlayer` using React Testing Library (needs jsdom + RTL install)
- [ ] Add component tests for `UnifiedLessonPage` (needs jsdom + RTL install)
- [x] Set up coverage thresholds in `vitest.config.ts` — 60% lines/functions/statements, 50% branches
- [ ] Add test for middleware auth redirects (`src/middleware.ts`)
- [x] Add tests for `src/lib/sat-scoring.ts` — all scoring functions and routing thresholds
- [x] Verify: `npm test` — 108/108 tests pass across 14 test files

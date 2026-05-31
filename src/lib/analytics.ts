/**
 * Typed analytics helpers.
 *
 * One place to define the events we track so funnel/retention names stay
 * consistent across the codebase instead of scattered `posthog.capture("...")`
 * calls with drifting names. Import `track`, `identifyUser`, and `resetUser`
 * from here in client components.
 *
 * Events flow to PostHog (product analytics, funnels, session replay).
 * Pageviews + Web Vitals are handled automatically by PostHog, Vercel
 * Analytics, and GA4 — you do NOT need to track those here.
 */
import posthog from "posthog-js";

/** Canonical event names — the funnel Preppeo cares about. Extend as needed. */
export const AnalyticsEvent = {
  // Acquisition / auth
  SignedUp: "signed_up",
  LoggedIn: "logged_in",
  // Commerce
  CheckoutStarted: "checkout_started",
  PurchaseCompleted: "purchase_completed",
  // Core product
  MockStarted: "mock_started",
  MockCompleted: "mock_completed",
  PracticeStarted: "practice_started",
  EnquirySubmitted: "enquiry_submitted",
} as const;

export type AnalyticsEventName =
  (typeof AnalyticsEvent)[keyof typeof AnalyticsEvent];

/**
 * True once PostHog has been initialized. Calling capture/identify before init
 * (e.g. local dev with no key, or before consent) just logs warnings, so we
 * no-op until it's loaded.
 */
function ready(): boolean {
  return (
    typeof window !== "undefined" &&
    Boolean((posthog as unknown as { __loaded?: boolean }).__loaded)
  );
}

/** Capture a product event. Safe to call anywhere on the client. */
export function track(
  event: AnalyticsEventName | string,
  properties?: Record<string, unknown>,
) {
  if (!ready()) return;
  posthog.capture(event, properties);
}

/** Tie events to a known user after login/signup. Call once on auth. */
export function identifyUser(
  userId: string,
  properties?: Record<string, unknown>,
) {
  if (!ready()) return;
  posthog.identify(userId, properties);
}

/** Clear identity on logout so the next session is a fresh anonymous user. */
export function resetUser() {
  if (!ready()) return;
  posthog.reset();
}

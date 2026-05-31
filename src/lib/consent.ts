/**
 * Cookie-consent state shared between the banner, Google Consent Mode v2,
 * and PostHog. Universal module (no browser-only work at import time) so it can
 * be imported from both client components and the server layout.
 */

export const CONSENT_STORAGE_KEY = "preppeo_cookie_consent";

/** "accepted" = analytics + ads granted; "necessary" = only essential cookies. */
export type ConsentChoice = "accepted" | "necessary";

/** Fired on the window when the user makes/changes a choice. */
export const CONSENT_EVENT = "preppeo:consent-change";

export function getStoredConsent(): ConsentChoice | null {
  if (typeof window === "undefined") return null;
  try {
    const v = localStorage.getItem(CONSENT_STORAGE_KEY);
    return v === "accepted" || v === "necessary" ? v : null;
  } catch {
    return null;
  }
}

/** Persist the choice, push it to Google Consent Mode, and notify listeners. */
export function setConsent(choice: ConsentChoice) {
  if (typeof window === "undefined") return;
  try {
    localStorage.setItem(CONSENT_STORAGE_KEY, choice);
  } catch {
    /* storage blocked — still apply for this session */
  }
  applyToGoogleConsent(choice);
  window.dispatchEvent(new CustomEvent<ConsentChoice>(CONSENT_EVENT, { detail: choice }));
}

/** Update Google Consent Mode v2 signals. PostHog is handled in its provider. */
export function applyToGoogleConsent(choice: ConsentChoice) {
  if (typeof window === "undefined") return;
  const granted = choice === "accepted";
  const state = granted ? "granted" : "denied";
  const w = window as unknown as { gtag?: (...args: unknown[]) => void };
  if (typeof w.gtag === "function") {
    w.gtag("consent", "update", {
      ad_storage: state,
      ad_user_data: state,
      ad_personalization: state,
      analytics_storage: state,
    });
  }
}

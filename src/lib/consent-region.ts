/**
 * Server-side helpers to decide whether a visitor's region legally requires a
 * cookie-consent banner, and to build the Google Consent Mode v2 default script.
 *
 * Region is detected from Vercel's `x-vercel-ip-country` request header.
 */
import { CONSENT_STORAGE_KEY } from "@/lib/consent";

// EEA (EU-27 + Iceland, Liechtenstein, Norway) + UK + Switzerland.
const CONSENT_REQUIRED_COUNTRIES = new Set([
  // EU-27
  "AT", "BE", "BG", "HR", "CY", "CZ", "DK", "EE", "FI", "FR", "DE", "GR",
  "HU", "IE", "IT", "LV", "LT", "LU", "MT", "NL", "PL", "PT", "RO", "SK",
  "SI", "ES", "SE",
  // EEA (non-EU)
  "IS", "LI", "NO",
  // UK GDPR + Swiss FADP
  "GB", "CH",
]);

/**
 * True only for EEA/UK/Swiss visitors. A missing header (local dev, or an
 * unknown origin) returns false — production reliably sets the header, and the
 * India-first audience should not be nagged or have analytics suppressed.
 */
export function regionRequiresConsent(country: string | null | undefined): boolean {
  if (!country) return false;
  return CONSENT_REQUIRED_COUNTRIES.has(country.toUpperCase());
}

/**
 * Inline script (runs `beforeInteractive`, before GA's config command) that sets
 * Google Consent Mode v2 defaults. In consent regions everything defaults to
 * `denied` and we restore a prior "accepted" choice; elsewhere we default to
 * `granted` so analytics work normally.
 */
export function buildConsentDefaultScript(requiresConsent: boolean): string {
  const state = requiresConsent ? "denied" : "granted";
  const restore = requiresConsent
    ? `try{var c=localStorage.getItem('${CONSENT_STORAGE_KEY}');if(c==='accepted'){gtag('consent','update',{ad_storage:'granted',ad_user_data:'granted',ad_personalization:'granted',analytics_storage:'granted'});}}catch(e){}`
    : "";
  return (
    "window.dataLayer=window.dataLayer||[];" +
    "function gtag(){dataLayer.push(arguments);}" +
    "window.gtag=gtag;" +
    `gtag('consent','default',{ad_storage:'${state}',ad_user_data:'${state}',ad_personalization:'${state}',analytics_storage:'${state}'${requiresConsent ? ",wait_for_update:500" : ""}});` +
    restore
  );
}

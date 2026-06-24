/**
 * Region resolution + the geo-differentiated link map for the floating widget.
 *
 * Only THREE things are geofenced: contact channel, money (currency + payment
 * rail), and timezone notes. Content/access is never geofenced.
 *
 * Detection order (profile-first to survive NRIs / VPNs / travel):
 *   1. profile country  — most reliable, but `profiles` has no country column
 *      yet, so this arg is unused today. The hook is here for when it lands.
 *   2. Vercel IP header — `x-vercel-ip-country` (free on Vercel; absent locally)
 *   3. default → India
 */

import { WHATSAPP_NUMBER } from "@/config/pricing";

export type Region = "in" | "intl";

export function getRegion(
  profileCountry?: string | null,
  headers?: Headers
): Region {
  const country =
    profileCountry ?? headers?.get("x-vercel-ip-country") ?? "IN";
  return country === "IN" ? "in" : "intl";
}

export interface RegionLinks {
  /** Opens WhatsApp chat with a prefilled message. */
  whatsapp: string;
  /** Book a 1-on-1 session (region sets timezone + currency + rail downstream). */
  book: string;
  /** Buy a mock / course (region sets currency + payment rail downstream). */
  buy: string;
  /** Admissions consulting enquiry. */
  admissions: string;
  /** Short support-hours note shown in the widget. */
  supportNote: string;
}

// ─────────────────────────────────────────────────────────────────────────
// TODO (you fill these in):
//   • book / admissions — point at the real /book and /admissions routes once
//     built (currently routed to existing /pricing and /services/admissions).
//   • Currency + payment rail (Razorpay/INR vs Stripe/USD) are handled on the
//     destination pages via the ?region= param — not here.
// ─────────────────────────────────────────────────────────────────────────
const WA_NUMBER = WHATSAPP_NUMBER; // single source of truth: 918130711689
const WA_TEXT = encodeURIComponent("Hi, I'm interested in SAT prep");

export const REGION_LINKS: Record<Region, RegionLinks> = {
  in: {
    whatsapp: `https://wa.me/${WA_NUMBER}?text=${WA_TEXT}`,
    book: "/pricing?region=in", // TODO: /book?region=in once built
    buy: "/mocks?region=in",
    admissions: "/services/admissions?region=in", // TODO: /admissions?region=in
    supportNote: "Support: IST 9am–9pm",
  },
  intl: {
    whatsapp: `https://wa.me/${WA_NUMBER}?text=${WA_TEXT}&src=intl`,
    book: "/pricing?region=intl", // TODO: /book?region=intl once built
    buy: "/mocks?region=intl",
    admissions: "/services/admissions?region=intl", // TODO: /admissions?region=intl
    supportNote: "We reply in IST — allow 12–24h",
  },
};

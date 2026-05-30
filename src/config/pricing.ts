// Static pricing config for the ENQUIRY-ONLY products on /pricing.
// Mocks (token_packs) and Practice Mode (subscription_plans) are PAID online
// and come live from the database — they are NOT here.
// Self-Paced course and 1-on-1 are enquiry-only (WhatsApp/contact) for now.
//
// Prices come from "Docs for me/comm.md". INR and USD are independent price
// points (NOT a fixed exchange rate), so both are stored per tier and the page
// shows whichever currency is toggled.

/** A single duration-based tier (Self-Paced course). */
export interface DurationTier {
  label: string;
  months: number;
  priceInr: number;
  priceUsd: number;
  note?: string;
}

/** A single 1-on-1 hours tier. Price is the same for one or both subjects. */
export interface OneOnOneTier {
  label: string;
  hours: number;
  priceInr: number;
  priceUsd: number;
  note?: string;
}

// Self-Paced pre-recorded course — 1 / 3 / 6 / 12 months (enquiry-only)
export const selfPacedTiers: DurationTier[] = [
  { label: "1 month", months: 1, priceInr: 3999, priceUsd: 59 },
  { label: "3 months", months: 3, priceInr: 8999, priceUsd: 139 },
  { label: "6 months", months: 6, priceInr: 14999, priceUsd: 239 },
  { label: "12 months", months: 12, priceInr: 24999, priceUsd: 399 },
];

// 1-on-1 Package — 10 / 20 / 30 hours (enquiry-only)
export const oneOnOneTiers: OneOnOneTier[] = [
  { label: "10 hours", hours: 10, priceInr: 34999, priceUsd: 599 },
  { label: "20 hours", hours: 20, priceInr: 64999, priceUsd: 1099 },
  { label: "30 hours", hours: 30, priceInr: 89999, priceUsd: 1499 },
];

// Shared contact channel for products without online checkout.
export const WHATSAPP_NUMBER = "918130711689";

export function whatsappLink(message: string): string {
  return `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(message)}`;
}

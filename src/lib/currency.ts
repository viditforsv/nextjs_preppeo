export type CurrencyCode = 'INR' | 'USD' | 'AED';

export interface CurrencyConfig {
  symbol: string;
  rate: number;
  label: string;
  locale: string;
}

export const CURRENCIES: Record<CurrencyCode, CurrencyConfig> = {
  INR: { symbol: '₹', rate: 1, label: 'INR', locale: 'en-IN' },
  USD: { symbol: '$', rate: 0.012, label: 'USD', locale: 'en-US' },
  AED: { symbol: 'AED ', rate: 0.044, label: 'AED', locale: 'en-AE' },
};

export function convertPrice(inrPrice: number, currency: CurrencyCode): number {
  const converted = inrPrice * CURRENCIES[currency].rate;
  if (currency === 'INR') return Math.round(converted);
  return Math.round(converted * 100) / 100;
}

export function formatPrice(inrPrice: number, currency: CurrencyCode): string {
  const value = convertPrice(inrPrice, currency);
  const { symbol, locale } = CURRENCIES[currency];
  if (currency === 'INR') return `${symbol}${value.toLocaleString(locale)}`;
  return `${symbol}${value.toLocaleString(locale, { minimumFractionDigits: 0, maximumFractionDigits: 2 })}`;
}

/**
 * The amount to display in `currency`. Uses an explicit USD price when one is
 * provided and USD is selected (prices are set independently, not by exchange
 * rate); otherwise falls back to a rate conversion from INR.
 */
export function amountIn(
  currency: CurrencyCode,
  inrPrice: number,
  usdPrice?: number | null,
): number {
  if (currency === 'USD' && usdPrice != null) return usdPrice;
  return convertPrice(inrPrice, currency);
}

/** Format an amount already expressed in `currency` (no conversion). */
export function formatAmount(amount: number, currency: CurrencyCode): string {
  const { symbol, locale } = CURRENCIES[currency];
  if (currency === 'INR') return `${symbol}${Math.round(amount).toLocaleString(locale)}`;
  return `${symbol}${amount.toLocaleString(locale, { minimumFractionDigits: 0, maximumFractionDigits: 2 })}`;
}

export function detectCurrency(): CurrencyCode {
  if (typeof navigator === 'undefined') return 'INR';
  const lang = navigator.language || '';
  if (lang.startsWith('en-US') || lang.startsWith('en-GB')) return 'USD';
  if (lang.includes('AE') || lang.includes('ar')) return 'AED';
  return 'INR';
}

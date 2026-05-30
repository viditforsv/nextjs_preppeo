"use client";

import { useState, useEffect, useMemo } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import {
  ArrowRight,
  Loader2,
  CheckCircle2,
  Sparkles,
  FileText,
  Dumbbell,
  PlayCircle,
  Users,
  X,
} from "lucide-react";
import type { TokenPackWithExam } from "@/types/test-tokens";
import { selfPacedTiers, oneOnOneTiers } from "@/config/pricing";
import { CURRENCIES, convertPrice } from "@/lib/currency";
import type { CurrencyCode } from "@/lib/currency";

// Currencies offered by the toggle (payment always settles in INR).
const PRICING_CURRENCIES: CurrencyCode[] = ["INR", "USD"];

// Standardised action button (Add / Added / Enquire) — full width on mobile,
// fixed min-width on desktop so all four buttons line up identically.
const ACTION_BTN_BASE =
  "inline-flex w-full items-center justify-center rounded-lg border border-primary px-4 py-2 text-center text-sm font-semibold transition-colors sm:w-auto sm:min-w-[132px]";
const ACTION_BTN_IDLE = "text-foreground hover:bg-primary/5";
const ACTION_BTN_ACTIVE = "bg-primary text-white";

// Shared layout for an offering's options row + action column.
const OFFERING_ROW =
  "flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between";
const ACTION_COL = "flex w-full flex-col gap-2 sm:w-auto sm:items-end";

// Format an amount already expressed in the target currency (no conversion).
function money(amount: number, currency: CurrencyCode): string {
  const { symbol, locale } = CURRENCIES[currency];
  return `${symbol}${Math.round(amount).toLocaleString(locale)}`;
}

// INR and USD are independent prices. Show the explicit USD when available;
// fall back to a rate conversion only if a USD price is missing.
function usdOf(inr: number, usd: number | null | undefined): number {
  return usd ?? convertPrice(inr, "USD");
}

/**
 * Shows the actual price, plus a struck-through "anchor" (the smallest tier's
 * per-unit rate × this tier's units) and a "% off" badge when the longer/bigger
 * tier is cheaper per unit. Encourages buying up.
 */
function DiscountPrice({
  inr,
  usd,
  units,
  baseInr,
  baseUsd,
  currency,
}: {
  inr: number;
  usd: number;
  units: number;
  baseInr: number;
  baseUsd: number;
  currency: CurrencyCode;
}) {
  const actual = currency === "USD" ? usd : inr;
  const anchor = (currency === "USD" ? baseUsd : baseInr) * units;
  const pct = anchor > actual ? Math.round((1 - actual / anchor) * 100) : 0;
  return (
    <div className="flex flex-col items-end gap-1">
      {pct >= 5 && (
        <div className="flex items-center gap-2">
          <span className="text-sm text-muted-foreground line-through">
            {money(anchor, currency)}
          </span>
          <span className="rounded-full bg-emerald-100 px-2 py-0.5 text-xs font-bold text-emerald-700">
            Save {pct}%
          </span>
        </div>
      )}
      <span className="text-2xl font-bold text-foreground">
        {money(actual, currency)}
      </span>
    </div>
  );
}

declare global {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  interface Window { Razorpay: any }
}

interface SubscriptionPlan {
  id: string;
  name: string;
  plan_type: "practice_only" | "bundle";
  duration_days: number;
  mock_tokens_included: number;
  price: number;
  price_usd: number | null;
  exam_type: string;
}

// A paid line item in the cart, keyed by product type (one of each max).
type CartKey = "mock" | "practice";
interface CartLine {
  type: CartKey;
  refId: string;
  label: string; // e.g. "Mocks · 5" or "Practice · 3 months"
  priceInr: number;
  priceUsd: number;
}

function loadRazorpayScript(): Promise<boolean> {
  if (typeof window !== "undefined" && window.Razorpay) return Promise.resolve(true);
  return new Promise((resolve) => {
    const script = document.createElement("script");
    script.src = "https://checkout.razorpay.com/v1/checkout.js";
    script.onload = () => resolve(true);
    script.onerror = () => resolve(false);
    document.body.appendChild(script);
  });
}

function planMonths(p: SubscriptionPlan): number {
  return Math.max(1, Math.round(p.duration_days / 30));
}

/** Keep the first item for each key — guards against duplicate DB rows. */
function dedupeBy<T>(arr: T[], key: (t: T) => string | number): T[] {
  const seen = new Set<string | number>();
  return arr.filter((item) => {
    const k = key(item);
    if (seen.has(k)) return false;
    seen.add(k);
    return true;
  });
}

/** Largest "% off" across a set of tiers vs the smallest tier's per-unit rate. */
function maxSavings(
  currency: CurrencyCode,
  baseInr: number,
  baseUsd: number,
  items: { units: number; inr: number; usd: number }[],
): number {
  let max = 0;
  for (const it of items) {
    const actual = currency === "USD" ? it.usd : it.inr;
    const anchor = (currency === "USD" ? baseUsd : baseInr) * it.units;
    const pct = anchor > actual ? Math.round((1 - actual / anchor) * 100) : 0;
    if (pct > max) max = pct;
  }
  return max;
}

/** Small green "Save up to X%" pill (hidden when there's no meaningful saving). */
function SaveUpTo({ pct }: { pct: number }) {
  if (pct < 5) return null;
  return (
    <span className="rounded-full bg-emerald-100 px-1.5 py-0.5 text-[11px] font-bold text-emerald-700">
      Save up to {pct}%
    </span>
  );
}

/** Pill tier selector. */
function Chips({
  options,
  selected,
  onSelect,
}: {
  options: string[];
  selected: number;
  onSelect: (i: number) => void;
}) {
  return (
    <div className="flex flex-wrap gap-2">
      {options.map((label, i) => {
        const active = i === selected;
        return (
          <button
            key={label}
            type="button"
            onClick={() => onSelect(i)}
            className={`rounded-full border px-3.5 py-1.5 text-sm font-medium transition-colors ${
              active
                ? "border-primary bg-primary text-white"
                : "border-gray-200 bg-white text-foreground hover:border-primary/50"
            }`}
          >
            {label}
          </button>
        );
      })}
    </div>
  );
}

/** Shell for one offering row. */
function Offering({
  icon,
  badge,
  featured,
  title,
  description,
  children,
}: {
  icon: React.ReactNode;
  badge?: string;
  featured?: boolean;
  title: string;
  description: string;
  children: React.ReactNode;
}) {
  return (
    <article
      className={`rounded-xl border bg-white p-5 sm:p-6 ${
        featured ? "border-2 border-primary" : "border-gray-200"
      }`}
    >
      <div className="flex items-start gap-3">
        <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-primary/10 text-primary">
          {icon}
        </div>
        <div className="min-w-0 flex-1">
          {badge ? (
            <div className="text-xs font-semibold uppercase tracking-wide text-primary">
              {badge}
            </div>
          ) : null}
          <h3 className="text-lg font-bold text-foreground">{title}</h3>
          <p className="mt-1 text-sm text-muted-foreground">{description}</p>
          <div className="mt-4">{children}</div>
        </div>
      </div>
    </article>
  );
}

export default function PricingPage() {
  const router = useRouter();

  const [packs, setPacks] = useState<TokenPackWithExam[]>([]);
  const [plans, setPlans] = useState<SubscriptionPlan[]>([]);
  const [loading, setLoading] = useState(true);
  const [currency, setCurrency] = useState<CurrencyCode>("INR");

  // selected tier indices
  const [mockIdx, setMockIdx] = useState(0);
  const [practiceIdx, setPracticeIdx] = useState(0);
  const [selfPacedIdx, setSelfPacedIdx] = useState(0);
  const [oneOnOneIdx, setOneOnOneIdx] = useState(0);
  const [bothSubjects, setBothSubjects] = useState(false);

  // cart (at most one mock + one practice)
  const [cart, setCart] = useState<Partial<Record<CartKey, CartLine>>>({});

  const [checkingOut, setCheckingOut] = useState(false);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState<string | null>(null);

  // Referral code (optional) — validated like the old store; server applies it.
  const [referralInput, setReferralInput] = useState("");
  const [referral, setReferral] = useState<{
    code: string;
    discountRate: number;
    partnerName: string;
  } | null>(null);
  const [referralLoading, setReferralLoading] = useState(false);
  const [referralError, setReferralError] = useState("");

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const [packsRes, plansRes] = await Promise.all([
          fetch("/api/mocks/packs").then((r) => r.json()),
          fetch("/api/subscriptions/plans").then((r) => r.json()),
        ]);
        if (!active) return;
        // Consumer retail tiers only (3 / 5 / 10) — exclude the single-mock and
        // large "Institute" bulk packs, and dedupe by mock count since the DB
        // currently has duplicate pack rows.
        const satPacks = dedupeBy(
          ((packsRes.data as TokenPackWithExam[] | undefined) ?? [])
            .filter(
              (p) =>
                p.is_active &&
                p.exam_type === "sat" &&
                p.token_count >= 3 &&
                p.token_count <= 10,
            )
            .sort((a, b) => a.token_count - b.token_count),
          (p) => p.token_count,
        );
        const satPlans = dedupeBy(
          ((plansRes.plans as SubscriptionPlan[] | undefined) ?? [])
            .filter((p) => p.exam_type === "sat" && p.plan_type === "practice_only")
            .sort((a, b) => a.duration_days - b.duration_days),
          (p) => p.duration_days,
        );
        setPacks(satPacks);
        setPlans(satPlans);
      } catch {
        if (active) {
          setPacks([]);
          setPlans([]);
        }
      } finally {
        if (active) setLoading(false);
      }
    })();
    return () => {
      active = false;
    };
  }, []);

  const selectedPack = packs[mockIdx];
  const selectedPlan = plans[practiceIdx];

  const totals = useMemo(() => {
    const lines = Object.values(cart).filter((l): l is CartLine => !!l);
    return {
      inr: lines.reduce((s, l) => s + l.priceInr, 0),
      usd: lines.reduce((s, l) => s + l.priceUsd, 0),
    };
  }, [cart]);
  const total = currency === "USD" ? totals.usd : totals.inr;
  const discountRate = referral?.discountRate ?? 0;
  const payable = discountRate > 0 ? total * (1 - discountRate / 100) : total;

  const handleApplyReferral = async () => {
    const code = referralInput.trim();
    if (!code) return;
    setReferralLoading(true);
    setReferralError("");
    try {
      const res = await fetch("/api/referral/validate", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ code }),
      });
      const data = await res.json();
      if (data.valid) {
        setReferral({
          code: code.toUpperCase(),
          discountRate: data.discount_rate,
          partnerName: data.partner_name,
        });
      } else {
        setReferralError("Invalid or expired code");
        setReferral(null);
      }
    } catch {
      setReferralError("Couldn't validate code");
    } finally {
      setReferralLoading(false);
    }
  };

  const clearReferral = () => {
    setReferral(null);
    setReferralInput("");
    setReferralError("");
  };

  const mockLine = (pack: TokenPackWithExam): CartLine => ({
    type: "mock",
    refId: pack.id,
    label: `Mocks · ${pack.token_count}`,
    priceInr: pack.price,
    priceUsd: usdOf(pack.price, pack.price_usd),
  });

  const practiceLine = (plan: SubscriptionPlan): CartLine => ({
    type: "practice",
    refId: plan.id,
    label: `Practice · ${planMonths(plan)} mo`,
    priceInr: plan.price,
    priceUsd: usdOf(plan.price, plan.price_usd),
  });

  const toggleMock = () => {
    if (cart.mock?.refId === selectedPack?.id) {
      setCart((c) => ({ ...c, mock: undefined }));
      return;
    }
    if (!selectedPack) return;
    setCart((c) => ({ ...c, mock: mockLine(selectedPack) }));
  };

  const togglePractice = () => {
    if (cart.practice?.refId === selectedPlan?.id) {
      setCart((c) => ({ ...c, practice: undefined }));
      return;
    }
    if (!selectedPlan) return;
    setCart((c) => ({ ...c, practice: practiceLine(selectedPlan) }));
  };

  // If the user changes the tier while it's in the cart, keep the cart synced.
  useEffect(() => {
    if (cart.mock && selectedPack && cart.mock.refId !== selectedPack.id) {
      setCart((c) => ({ ...c, mock: mockLine(selectedPack) }));
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [mockIdx]);

  useEffect(() => {
    if (cart.practice && selectedPlan && cart.practice.refId !== selectedPlan.id) {
      setCart((c) => ({ ...c, practice: practiceLine(selectedPlan) }));
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [practiceIdx]);

  const handleCheckout = async () => {
    const items = Object.values(cart)
      .filter((l): l is CartLine => !!l)
      .map((l) => ({ type: l.type, id: l.refId }));
    if (items.length === 0) return;

    setCheckingOut(true);
    setError("");
    try {
      const orderRes = await fetch("/api/checkout/create-order", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          items,
          ...(referral?.code ? { referralCode: referral.code } : {}),
        }),
      });

      if (orderRes.status === 401) {
        // Not logged in — send them to auth, then back to pricing.
        router.push("/auth?redirect=/pricing");
        return;
      }

      const orderData = await orderRes.json();
      if (!orderData.success) {
        setError(orderData.error || "Failed to start checkout");
        setCheckingOut(false);
        return;
      }

      const loaded = await loadRazorpayScript();
      if (!loaded) {
        setError("Failed to load payment gateway");
        setCheckingOut(false);
        return;
      }

      const rzp = new window.Razorpay({
        key: process.env.NEXT_PUBLIC_RAZORPAY_KEY_ID,
        amount: Math.round(orderData.amount * 100),
        currency: orderData.currency,
        name: "Preppeo",
        description: "Your Preppeo plan",
        order_id: orderData.orderId,
        theme: { color: "#1a365d" },
        handler: async (response: {
          razorpay_order_id: string;
          razorpay_payment_id: string;
          razorpay_signature: string;
        }) => {
          const verifyRes = await fetch("/api/checkout/verify-payment", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              orderId: response.razorpay_order_id,
              paymentId: response.razorpay_payment_id,
              signature: response.razorpay_signature,
              purchaseId: orderData.purchaseId,
            }),
          });
          const verifyData = await verifyRes.json();
          if (verifyData.success) {
            setSuccess(
              "Payment successful! Check your email for access codes, and your dashboard for practice access.",
            );
            setCart({});
          } else {
            setError(verifyData.error || "Payment verification failed");
          }
          setCheckingOut(false);
        },
        modal: { ondismiss: () => setCheckingOut(false) },
      });
      rzp.open();
    } catch {
      setError("Something went wrong");
      setCheckingOut(false);
    }
  };

  const oneOnOneTier = oneOnOneTiers[oneOnOneIdx];

  // Enquiry contact-form modal (Self-Paced & 1-on-1 → emails contact@preppeo.com).
  const [enquiry, setEnquiry] = useState<{ product: string; tier: string } | null>(
    null,
  );
  const [eName, setEName] = useState("");
  const [eEmail, setEEmail] = useState("");
  const [ePhone, setEPhone] = useState("");
  const [eMessage, setEMessage] = useState("");
  const [eSubmitting, setESubmitting] = useState(false);
  const [eDone, setEDone] = useState(false);
  const [eError, setEError] = useState("");

  const openEnquiry = (product: string, tier: string) => {
    setEnquiry({ product, tier });
    setEMessage(
      `Hi, I'm interested in ${product} (${tier}). Please share the details and next steps.`,
    );
    setEError("");
    setEDone(false);
  };

  const submitEnquiry = async () => {
    if (!enquiry) return;
    if (!eName.trim() || !eEmail.trim()) {
      setEError("Please enter your name and email.");
      return;
    }
    setESubmitting(true);
    setEError("");
    try {
      const res = await fetch("/api/contact", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: eName.trim(),
          email: eEmail.trim(),
          subject: `${enquiry.product} enquiry — ${enquiry.tier}`,
          message: `${eMessage.trim()}${
            ePhone.trim() ? `\n\nPhone: ${ePhone.trim()}` : ""
          }\n\nProduct: ${enquiry.product}\nOption: ${enquiry.tier}`,
        }),
      });
      const data = await res.json();
      if (res.ok && data.success) {
        setEDone(true);
      } else {
        setEError(data.error || "Couldn't send your enquiry. Please try again.");
      }
    } catch {
      setEError("Couldn't send your enquiry. Please try again.");
    } finally {
      setESubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="mx-auto max-w-6xl px-4 py-12 sm:px-6 lg:px-8">
        {/* Header */}
        <header className="mb-6 flex flex-wrap items-start justify-between gap-4">
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-foreground md:text-4xl">
              Build your prep plan
            </h1>
            <p className="mt-2 text-muted-foreground">
              Mix &amp; match what you need — your total updates live. The longer
              the plan, the more you save (up to ~50% off).
            </p>
          </div>

          {/* Currency toggle */}
          <div className="flex items-center gap-1 rounded-lg border border-gray-200 bg-white p-1">
            {PRICING_CURRENCIES.map((c) => (
              <button
                key={c}
                type="button"
                onClick={() => setCurrency(c)}
                className={`rounded-md px-3 py-1.5 text-sm font-semibold transition-colors ${
                  currency === c
                    ? "bg-primary text-white"
                    : "text-muted-foreground hover:text-foreground"
                }`}
                aria-pressed={currency === c}
              >
                {CURRENCIES[c].symbol.trim()} {c}
              </button>
            ))}
          </div>
        </header>

        {currency !== "INR" && (
          <p className="-mt-2 mb-6 text-xs text-muted-foreground">
            Showing USD prices. Payment is securely processed in INR via Razorpay.
          </p>
        )}

        {/* Free mock banner */}
        <div className="mb-6 flex items-center gap-3 rounded-xl border border-primary/20 bg-primary/5 px-4 py-3">
          <span className="inline-flex items-center gap-1.5 rounded-md bg-primary px-2.5 py-1 text-xs font-bold tracking-wide text-white">
            <Sparkles className="h-3.5 w-3.5" /> FREE
          </span>
          <p className="text-sm text-foreground">
            <strong>1 free full-length mock</strong> is already in your plan — no
            card required.
          </p>
        </div>

        {/* Success / error */}
        {success && (
          <div className="mb-6 flex items-start gap-3 rounded-xl border border-emerald-200 bg-emerald-50 p-4">
            <CheckCircle2 className="mt-0.5 h-5 w-5 shrink-0 text-emerald-600" />
            <p className="text-sm text-emerald-800">{success}</p>
          </div>
        )}
        {error && (
          <div className="mb-6 rounded-xl border border-red-200 bg-red-50 p-4">
            <p className="text-sm text-red-700">{error}</p>
          </div>
        )}

        <div className="grid items-start gap-6 lg:grid-cols-[1fr_320px]">
          {/* ── Offerings ─────────────────────────────────────────── */}
          <section className="flex flex-col gap-4" aria-label="Offerings">
            {/* Mocks (featured, paid) */}
            <Offering
              icon={<FileText className="h-5 w-5" />}
              badge="★ Most popular — start here"
              featured
              title="Mock Tests"
              description="Full-length, timed, adaptive Digital SAT mocks with instant score reports and domain analytics."
            >
              {loading ? (
                <div className="flex items-center py-2 text-sm text-muted-foreground">
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" /> Loading prices…
                </div>
              ) : packs.length === 0 ? (
                <p className="text-sm text-muted-foreground">
                  Mock packs are being updated.{" "}
                  <Link href="/contact" className="text-primary hover:underline">
                    Contact us
                  </Link>{" "}
                  if this persists.
                </p>
              ) : (
                <div className={OFFERING_ROW}>
                  <div>
                    <span className="mb-2 flex items-center gap-2 text-xs text-muted-foreground">
                      Number of mocks
                      <SaveUpTo
                        pct={maxSavings(
                          currency,
                          packs[0].price / packs[0].token_count,
                          usdOf(packs[0].price, packs[0].price_usd) /
                            packs[0].token_count,
                          packs.map((p) => ({
                            units: p.token_count,
                            inr: p.price,
                            usd: usdOf(p.price, p.price_usd),
                          })),
                        )}
                      />
                    </span>
                    <Chips
                      options={packs.map((p) => `${p.token_count}`)}
                      selected={mockIdx}
                      onSelect={setMockIdx}
                    />
                  </div>
                  <div className={ACTION_COL}>
                    <DiscountPrice
                      inr={selectedPack.price}
                      usd={usdOf(selectedPack.price, selectedPack.price_usd)}
                      units={selectedPack.token_count}
                      baseInr={packs[0].price / packs[0].token_count}
                      baseUsd={
                        usdOf(packs[0].price, packs[0].price_usd) /
                        packs[0].token_count
                      }
                      currency={currency}
                    />
                    <button
                      type="button"
                      onClick={toggleMock}
                      className={`${ACTION_BTN_BASE} ${
                        cart.mock?.refId === selectedPack.id
                          ? ACTION_BTN_ACTIVE
                          : ACTION_BTN_IDLE
                      }`}
                    >
                      {cart.mock?.refId === selectedPack.id ? "✓ Added" : "＋ Add"}
                    </button>
                  </div>
                </div>
              )}
            </Offering>

            {/* Practice Mode (paid) */}
            <Offering
              icon={<Dumbbell className="h-5 w-5" />}
              title="Practice Mode"
              description="Unlimited practice questions by topic & difficulty, with AI explanations on every one."
            >
              {loading ? (
                <div className="flex items-center py-2 text-sm text-muted-foreground">
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" /> Loading prices…
                </div>
              ) : plans.length === 0 ? (
                <p className="text-sm text-muted-foreground">
                  Practice plans are being updated.
                </p>
              ) : (
                <div className={OFFERING_ROW}>
                  <div>
                    <span className="mb-2 flex items-center gap-2 text-xs text-muted-foreground">
                      Access length
                      <SaveUpTo
                        pct={maxSavings(
                          currency,
                          plans[0].price / planMonths(plans[0]),
                          usdOf(plans[0].price, plans[0].price_usd) /
                            planMonths(plans[0]),
                          plans.map((p) => ({
                            units: planMonths(p),
                            inr: p.price,
                            usd: usdOf(p.price, p.price_usd),
                          })),
                        )}
                      />
                    </span>
                    <Chips
                      options={plans.map((p) => `${planMonths(p)} mo`)}
                      selected={practiceIdx}
                      onSelect={setPracticeIdx}
                    />
                  </div>
                  <div className={ACTION_COL}>
                    <DiscountPrice
                      inr={selectedPlan.price}
                      usd={usdOf(selectedPlan.price, selectedPlan.price_usd)}
                      units={planMonths(selectedPlan)}
                      baseInr={plans[0].price / planMonths(plans[0])}
                      baseUsd={
                        usdOf(plans[0].price, plans[0].price_usd) /
                        planMonths(plans[0])
                      }
                      currency={currency}
                    />
                    <button
                      type="button"
                      onClick={togglePractice}
                      className={`${ACTION_BTN_BASE} ${
                        cart.practice?.refId === selectedPlan.id
                          ? ACTION_BTN_ACTIVE
                          : ACTION_BTN_IDLE
                      }`}
                    >
                      {cart.practice?.refId === selectedPlan.id ? "✓ Added" : "＋ Add"}
                    </button>
                  </div>
                </div>
              )}
            </Offering>

            {/* Self-Paced course (enquiry-only) */}
            <Offering
              icon={<PlayCircle className="h-5 w-5" />}
              title="Self-Paced Course"
              description="A complete pre-recorded video course you watch anytime, at your own pace."
            >
              <div className={OFFERING_ROW}>
                <div>
                  <span className="mb-2 flex items-center gap-2 text-xs text-muted-foreground">
                    Access length
                    <SaveUpTo
                      pct={maxSavings(
                        currency,
                        selfPacedTiers[0].priceInr / selfPacedTiers[0].months,
                        selfPacedTiers[0].priceUsd / selfPacedTiers[0].months,
                        selfPacedTiers.map((t) => ({
                          units: t.months,
                          inr: t.priceInr,
                          usd: t.priceUsd,
                        })),
                      )}
                    />
                  </span>
                  <Chips
                    options={selfPacedTiers.map((t) => t.label)}
                    selected={selfPacedIdx}
                    onSelect={setSelfPacedIdx}
                  />
                </div>
                <div className={ACTION_COL}>
                  <DiscountPrice
                    inr={selfPacedTiers[selfPacedIdx].priceInr}
                    usd={selfPacedTiers[selfPacedIdx].priceUsd}
                    units={selfPacedTiers[selfPacedIdx].months}
                    baseInr={selfPacedTiers[0].priceInr / selfPacedTiers[0].months}
                    baseUsd={selfPacedTiers[0].priceUsd / selfPacedTiers[0].months}
                    currency={currency}
                  />
                  <button
                    type="button"
                    onClick={() =>
                      openEnquiry(
                        "Self-Paced Course",
                        selfPacedTiers[selfPacedIdx].label,
                      )
                    }
                    className={`${ACTION_BTN_BASE} ${ACTION_BTN_IDLE}`}
                  >
                    Enquire
                  </button>
                </div>
              </div>
            </Offering>

            {/* 1-on-1 (enquiry-only) */}
            <Offering
              icon={<Users className="h-5 w-5" />}
              title="1-on-1 Tutoring"
              description="Private sessions with an expert tutor. Choose your hours and one subject or both (Math + R&W)."
            >
              <div className={OFFERING_ROW}>
                <div className="space-y-3">
                  <div>
                    <span className="mb-2 flex items-center gap-2 text-xs text-muted-foreground">
                      Hours
                      <SaveUpTo
                        pct={maxSavings(
                          currency,
                          oneOnOneTiers[0].priceInr / oneOnOneTiers[0].hours,
                          oneOnOneTiers[0].priceUsd / oneOnOneTiers[0].hours,
                          oneOnOneTiers.map((t) => ({
                            units: t.hours,
                            inr: t.priceInr,
                            usd: t.priceUsd,
                          })),
                        )}
                      />
                    </span>
                    <Chips
                      options={oneOnOneTiers.map((t) => t.label)}
                      selected={oneOnOneIdx}
                      onSelect={setOneOnOneIdx}
                    />
                  </div>
                  <div className="inline-flex w-fit rounded-full border border-gray-200 p-1">
                    <button
                      type="button"
                      onClick={() => setBothSubjects(false)}
                      className={`rounded-full px-3 py-1 text-sm font-medium transition-colors ${
                        !bothSubjects ? "bg-primary text-white" : "text-foreground"
                      }`}
                    >
                      One subject
                    </button>
                    <button
                      type="button"
                      onClick={() => setBothSubjects(true)}
                      className={`rounded-full px-3 py-1 text-sm font-medium transition-colors ${
                        bothSubjects ? "bg-primary text-white" : "text-foreground"
                      }`}
                    >
                      Both subjects
                    </button>
                  </div>
                </div>
                <div className={ACTION_COL}>
                  <DiscountPrice
                    inr={oneOnOneTier.priceInr}
                    usd={oneOnOneTier.priceUsd}
                    units={oneOnOneTier.hours}
                    baseInr={oneOnOneTiers[0].priceInr / oneOnOneTiers[0].hours}
                    baseUsd={oneOnOneTiers[0].priceUsd / oneOnOneTiers[0].hours}
                    currency={currency}
                  />
                  <button
                    type="button"
                    onClick={() =>
                      openEnquiry(
                        "1-on-1 Tutoring",
                        `${oneOnOneTier.label}, ${bothSubjects ? "both subjects" : "one subject"}`,
                      )
                    }
                    className={`${ACTION_BTN_BASE} ${ACTION_BTN_IDLE}`}
                  >
                    Enquire
                  </button>
                </div>
              </div>
            </Offering>
          </section>

          {/* ── Summary ───────────────────────────────────────────── */}
          <aside className="lg:sticky lg:top-6">
            <div className="rounded-xl border border-gray-200 bg-white p-5">
              <h2 className="text-lg font-bold text-foreground">Your plan</h2>

              <div className="mt-4 space-y-2.5">
                <div className="flex items-center justify-between border-b border-gray-100 pb-2.5 text-sm">
                  <span className="text-muted-foreground">Free mock ×1</span>
                  <span className="text-muted-foreground">{money(0, currency)}</span>
                </div>
                {Object.values(cart)
                  .filter((l): l is CartLine => !!l)
                  .map((line) => (
                    <div
                      key={line.type}
                      className="flex items-center justify-between border-b border-gray-100 pb-2.5 text-sm"
                    >
                      <span className="text-foreground">{line.label}</span>
                      <span className="font-medium text-foreground">
                        {money(currency === "USD" ? line.priceUsd : line.priceInr, currency)}
                      </span>
                    </div>
                  ))}
              </div>

              {/* Referral code */}
              {total > 0 && (
                <div className="mt-4">
                  {referral ? (
                    <div className="flex items-center justify-between rounded-lg bg-emerald-50 px-3 py-2 text-sm">
                      <span className="text-emerald-700">
                        <span className="font-semibold">{referral.code}</span> ·{" "}
                        {referral.discountRate}% off
                      </span>
                      <button
                        type="button"
                        onClick={clearReferral}
                        className="text-emerald-700 hover:text-emerald-900"
                        aria-label="Remove code"
                      >
                        <X className="h-4 w-4" />
                      </button>
                    </div>
                  ) : (
                    <div>
                      <div className="flex gap-2">
                        <input
                          type="text"
                          value={referralInput}
                          onChange={(e) => {
                            setReferralInput(e.target.value.toUpperCase());
                            setReferralError("");
                          }}
                          onKeyDown={(e) =>
                            e.key === "Enter" && handleApplyReferral()
                          }
                          placeholder="Referral code"
                          className="flex-1 rounded-lg border border-gray-200 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/20"
                        />
                        <button
                          type="button"
                          onClick={handleApplyReferral}
                          disabled={referralLoading || !referralInput.trim()}
                          className="rounded-lg border border-primary px-3 py-2 text-sm font-semibold text-primary hover:bg-primary/5 disabled:opacity-50"
                        >
                          {referralLoading ? (
                            <Loader2 className="h-4 w-4 animate-spin" />
                          ) : (
                            "Apply"
                          )}
                        </button>
                      </div>
                      {referralError && (
                        <p className="mt-1 text-xs text-red-600">{referralError}</p>
                      )}
                    </div>
                  )}
                </div>
              )}

              {discountRate > 0 && total > 0 && (
                <div className="mt-3 flex items-center justify-between text-sm text-emerald-700">
                  <span>Discount ({discountRate}%)</span>
                  <span>−{money(total - payable, currency)}</span>
                </div>
              )}

              <div className="mt-4 flex items-baseline justify-between">
                <span className="text-sm text-muted-foreground">Total</span>
                <span className="flex items-baseline gap-2">
                  {discountRate > 0 && total > 0 && (
                    <span className="text-sm text-muted-foreground line-through">
                      {money(total, currency)}
                    </span>
                  )}
                  <span className="text-2xl font-bold text-foreground">
                    {money(payable, currency)}
                  </span>
                </span>
              </div>

              <button
                type="button"
                onClick={handleCheckout}
                disabled={total === 0 || checkingOut}
                className="mt-4 flex w-full items-center justify-center gap-2 rounded-lg bg-primary px-4 py-3 text-base font-semibold text-white transition-colors hover:bg-primary/90 disabled:cursor-not-allowed disabled:opacity-50"
              >
                {checkingOut ? (
                  <Loader2 className="h-5 w-5 animate-spin" />
                ) : total === 0 ? (
                  "Add items to checkout"
                ) : (
                  <>
                    Checkout {money(payable, currency)} <ArrowRight className="h-4 w-4" />
                  </>
                )}
              </button>

              <p className="mt-3 text-center text-xs text-muted-foreground">
                Secure payment in INR via Razorpay.{" "}
                <Link href="/refund-policy" className="text-primary hover:underline">
                  Refund policy
                </Link>
                .
              </p>
              <p className="mt-2 text-center text-xs text-muted-foreground">
                Self-Paced &amp; 1-on-1 are arranged on enquiry — use their Enquire
                buttons.
              </p>
            </div>
          </aside>
        </div>
      </div>

      {/* Enquiry contact-form modal */}
      {enquiry && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4"
          onClick={() => setEnquiry(null)}
        >
          <div
            className="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-start justify-between gap-4">
              <div>
                <h3 className="text-lg font-bold text-foreground">
                  Enquire about {enquiry.product}
                </h3>
                <p className="mt-1 text-sm text-muted-foreground">{enquiry.tier}</p>
              </div>
              <button
                type="button"
                onClick={() => setEnquiry(null)}
                className="rounded-md p-1 text-muted-foreground hover:bg-gray-100 hover:text-foreground"
                aria-label="Close"
              >
                <X className="h-5 w-5" />
              </button>
            </div>

            {eDone ? (
              <div className="mt-6 flex flex-col items-center gap-3 py-6 text-center">
                <CheckCircle2 className="h-10 w-10 text-emerald-600" />
                <p className="font-semibold text-foreground">Thanks — we’ve got it!</p>
                <p className="text-sm text-muted-foreground">
                  Our team will reach out within 24 hours. A copy is on its way to
                  your inbox.
                </p>
                <button
                  type="button"
                  onClick={() => setEnquiry(null)}
                  className={`mt-2 ${ACTION_BTN_BASE} ${ACTION_BTN_ACTIVE} border-primary`}
                >
                  Done
                </button>
              </div>
            ) : (
              <div className="mt-4 space-y-3">
                <input
                  type="text"
                  value={eName}
                  onChange={(e) => setEName(e.target.value)}
                  placeholder="Your name *"
                  className="w-full rounded-lg border border-gray-200 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/20"
                />
                <input
                  type="email"
                  value={eEmail}
                  onChange={(e) => setEEmail(e.target.value)}
                  placeholder="Email *"
                  className="w-full rounded-lg border border-gray-200 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/20"
                />
                <input
                  type="tel"
                  value={ePhone}
                  onChange={(e) => setEPhone(e.target.value)}
                  placeholder="Phone (optional)"
                  className="w-full rounded-lg border border-gray-200 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/20"
                />
                <textarea
                  value={eMessage}
                  onChange={(e) => setEMessage(e.target.value)}
                  rows={3}
                  className="w-full rounded-lg border border-gray-200 px-3 py-2 text-sm focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/20"
                />
                {eError && <p className="text-sm text-red-600">{eError}</p>}
                <button
                  type="button"
                  onClick={submitEnquiry}
                  disabled={eSubmitting}
                  className="flex w-full items-center justify-center gap-2 rounded-lg bg-primary px-4 py-2.5 text-sm font-semibold text-white transition-colors hover:bg-primary/90 disabled:opacity-50"
                >
                  {eSubmitting ? (
                    <Loader2 className="h-4 w-4 animate-spin" />
                  ) : (
                    "Send enquiry"
                  )}
                </button>
                <p className="text-center text-xs text-muted-foreground">
                  Goes straight to our team at contact@preppeo.com.
                </p>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

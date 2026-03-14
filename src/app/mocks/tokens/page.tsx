'use client';

import { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'next/navigation';
import { ArrowLeft, Loader2, Ticket, CheckCircle2, Tag, X, Globe, ChevronDown } from 'lucide-react';
import Link from 'next/link';
import PricingTable from '@/components/tests/PricingTable';
import MyTokens from '@/components/tests/MyTokens';
import type { TokenPackWithExam } from '@/types/test-tokens';
import { CURRENCIES, detectCurrency, formatPrice } from '@/lib/currency';
import type { CurrencyCode } from '@/lib/currency';

declare global {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  interface Window { Razorpay: any }
}

interface SubscriptionPlan {
  id: string;
  name: string;
  plan_type: 'practice_only' | 'bundle';
  duration_days: number;
  mock_tokens_included: number;
  price: number;
  exam_type: string;
}

interface ReferralState {
  code: string;
  valid: boolean;
  discount_rate: number;
  partner_name: string;
}

function loadRazorpayScript(): Promise<boolean> {
  if (typeof window !== 'undefined' && window.Razorpay) return Promise.resolve(true);
  return new Promise((resolve) => {
    const script = document.createElement('script');
    script.src = 'https://checkout.razorpay.com/v1/checkout.js';
    script.onload = () => resolve(true);
    script.onerror = () => resolve(false);
    document.body.appendChild(script);
  });
}

export default function TokenStorePage() {
  const searchParams = useSearchParams();
  const examFilter = searchParams.get('exam');

  const [allPacks, setAllPacks] = useState<TokenPackWithExam[]>([]);
  const [allSubPlans, setAllSubPlans] = useState<SubscriptionPlan[]>([]);
  const [loading, setLoading] = useState(true);
  const [purchasedTokens, setPurchasedTokens] = useState<string[] | null>(null);
  const [subSuccess, setSubSuccess] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState<'store' | 'my-tokens'>('store');
  const [currency, setCurrency] = useState<CurrencyCode>('INR');
  const [buyingId, setBuyingId] = useState<string | null>(null);
  const [selectedExam, setSelectedExam] = useState<string | null>(examFilter);

  const [referralInput, setReferralInput] = useState('');
  const [referralLoading, setReferralLoading] = useState(false);
  const [referral, setReferral] = useState<ReferralState | null>(null);
  const [referralError, setReferralError] = useState('');
  const [purchaseError, setPurchaseError] = useState('');

  useEffect(() => {
    setCurrency(detectCurrency());
  }, []);

  const fetchPacks = useCallback(async () => {
    try {
      const res = await fetch('/api/mocks/packs');
      const data = await res.json();
      if (data.data) {
        const active = (data.data as TokenPackWithExam[]).filter((p) => p.is_active);
        setAllPacks(active);
      }
    } catch {
      // silent
    } finally {
      setLoading(false);
    }
  }, []);

  const fetchSubPlans = useCallback(async () => {
    try {
      const res = await fetch('/api/subscriptions/plans');
      const data = await res.json();
      if (data.plans) setAllSubPlans(data.plans as SubscriptionPlan[]);
    } catch { /* silent */ }
  }, []);

  useEffect(() => {
    fetchPacks();
    fetchSubPlans();
  }, [fetchPacks, fetchSubPlans]);

  const examTypes = Array.from(
    new Map(allPacks.map((p) => [p.exam_type, p.exam_types?.name ?? p.exam_type])).entries()
  );

  useEffect(() => {
    if (!selectedExam && examTypes.length > 0) {
      setSelectedExam(examTypes[0][0]);
    }
  }, [examTypes, selectedExam]);

  const packs = selectedExam ? allPacks.filter((p) => p.exam_type === selectedExam) : allPacks;
  const subPlans = selectedExam ? allSubPlans.filter((p) => p.exam_type === selectedExam) : allSubPlans;

  const handleApplyReferral = async () => {
    const code = referralInput.trim();
    if (!code) return;
    setReferralLoading(true);
    setReferralError('');
    try {
      const res = await fetch('/api/referral/validate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ code }),
      });
      const data = await res.json();
      if (data.valid) {
        setReferral({
          code: code.toUpperCase(),
          valid: true,
          discount_rate: data.discount_rate,
          partner_name: data.partner_name,
        });
      } else {
        setReferralError('Invalid or expired referral code');
        setReferral(null);
      }
    } catch {
      setReferralError('Failed to validate code');
    } finally {
      setReferralLoading(false);
    }
  };

  const clearReferral = () => {
    setReferral(null);
    setReferralInput('');
    setReferralError('');
  };

  const handleBuyPack = async (packId: string) => {
    const pack = packs.find((p) => p.id === packId);
    if (!pack) return;
    setBuyingId(`pack-${packId}`);
    setPurchaseError('');

    try {
      const orderRes = await fetch('/api/mocks/create-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ packId, ...(referral?.code ? { referralCode: referral.code } : {}) }),
      });
      const orderData = await orderRes.json();
      if (!orderData.success) {
        setPurchaseError(orderData.error || 'Failed to create order');
        setBuyingId(null);
        return;
      }

      const loaded = await loadRazorpayScript();
      if (!loaded) {
        setPurchaseError('Failed to load payment gateway');
        setBuyingId(null);
        return;
      }

      const rzp = new window.Razorpay({
        key: process.env.NEXT_PUBLIC_RAZORPAY_KEY_ID,
        amount: orderData.amount * 100,
        currency: orderData.currency,
        name: 'Preppeo',
        description: orderData.packName,
        order_id: orderData.orderId,
        theme: { color: '#1a365d' },
        handler: async (response: { razorpay_payment_id: string; razorpay_signature: string }) => {
          const verifyRes = await fetch('/api/mocks/verify-payment', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              orderId: orderData.orderId,
              paymentId: response.razorpay_payment_id,
              signature: response.razorpay_signature,
              purchaseId: orderData.purchaseId,
            }),
          });
          const verifyData = await verifyRes.json();
          if (verifyData.success) {
            setPurchasedTokens(verifyData.tokens);
            setActiveTab('my-tokens');
          } else {
            setPurchaseError(verifyData.error || 'Payment verification failed');
          }
          setBuyingId(null);
        },
        modal: { ondismiss: () => setBuyingId(null) },
      });
      rzp.open();
    } catch {
      setPurchaseError('Something went wrong');
      setBuyingId(null);
    }
  };

  const handleBuyPlan = async (planId: string) => {
    const plan = subPlans.find((p) => p.id === planId);
    if (!plan) return;
    setBuyingId(`plan-${planId}`);
    setPurchaseError('');

    try {
      const orderRes = await fetch('/api/subscriptions/create-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ planId, ...(referral?.code ? { referralCode: referral.code } : {}) }),
      });
      const orderData = await orderRes.json();
      if (!orderData.success) {
        setPurchaseError(orderData.error || 'Failed to create order');
        setBuyingId(null);
        return;
      }

      const loaded = await loadRazorpayScript();
      if (!loaded) {
        setPurchaseError('Failed to load payment gateway');
        setBuyingId(null);
        return;
      }

      const hasDiscount = !!referral?.code && (referral.discount_rate ?? 0) > 0;
      const displayPrice = hasDiscount
        ? Number((plan.price * (1 - referral!.discount_rate / 100)).toFixed(2))
        : plan.price;

      const rzp = new window.Razorpay({
        key: process.env.NEXT_PUBLIC_RAZORPAY_KEY_ID,
        amount: Math.round(displayPrice * 100),
        currency: 'INR',
        name: 'Preppeo',
        description: plan.name,
        order_id: orderData.orderId,
        theme: { color: '#0d47a1' },
        handler: async (response: { razorpay_order_id: string; razorpay_payment_id: string; razorpay_signature: string }) => {
          const verifyRes = await fetch('/api/subscriptions/verify-payment', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              orderId: response.razorpay_order_id,
              paymentId: response.razorpay_payment_id,
              signature: response.razorpay_signature,
              purchaseId: orderData.purchaseId,
              planId,
            }),
          });
          const verifyData = await verifyRes.json();
          if (verifyData.success) {
            setSubSuccess(plan.name);
            if (verifyData.tokens?.length > 0) setPurchasedTokens(verifyData.tokens);
            setActiveTab('my-tokens');
          } else {
            setPurchaseError(verifyData.error || 'Payment verification failed');
          }
          setBuyingId(null);
        },
        modal: { ondismiss: () => setBuyingId(null) },
      });
      rzp.open();
    } catch {
      setPurchaseError('Something went wrong');
      setBuyingId(null);
    }
  };

  const currencyKeys = Object.keys(CURRENCIES) as CurrencyCode[];

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="max-w-4xl mx-auto px-4 py-12">
        {/* Header */}
        <div className="mb-8">
          <Link
            href="/mocks"
            className="inline-flex items-center gap-1 text-sm text-gray-500 hover:text-[#1a365d] mb-4"
          >
            <ArrowLeft className="w-4 h-4" /> Back to Mock Hub
          </Link>
          <h1 className="text-3xl font-bold text-[#1a365d] mb-2">Plans & Packs</h1>
          <p className="text-gray-600 mb-4">
            Practice questions with AI explanations, full-length adaptive mocks, or both.
          </p>

          <div className="flex items-center justify-between gap-4 flex-wrap">
            {/* Exam type selector */}
            {examTypes.length > 1 ? (
              <div className="relative">
                <select
                  value={selectedExam ?? ''}
                  onChange={(e) => setSelectedExam(e.target.value || null)}
                  className="appearance-none bg-white border border-gray-200 rounded-lg pl-3 pr-8 py-2 text-sm font-medium text-gray-800 focus:outline-none focus:ring-2 focus:ring-[#1a365d]/20 focus:border-[#1a365d] cursor-pointer"
                >
                  {examTypes.map(([id, name]) => (
                    <option key={id} value={id}>{name}</option>
                  ))}
                </select>
                <ChevronDown className="w-4 h-4 text-gray-400 absolute right-2.5 top-1/2 -translate-y-1/2 pointer-events-none" />
              </div>
            ) : examTypes.length === 1 ? (
              <span className="text-sm font-medium text-gray-700 bg-white border border-gray-200 rounded-lg px-3 py-2">{examTypes[0][1]}</span>
            ) : <div />}

            {/* Currency selector */}
            <div className="flex items-center gap-1.5 bg-white border border-gray-200 rounded-lg p-1">
              <Globe className="w-4 h-4 text-gray-400 ml-2" />
              {currencyKeys.map((c) => (
                <button
                  key={c}
                  onClick={() => setCurrency(c)}
                  className={`px-3 py-1.5 text-xs font-semibold rounded-md transition-colors ${
                    currency === c
                      ? 'bg-[#1a365d] text-white'
                      : 'text-gray-500 hover:text-gray-800'
                  }`}
                >
                  {CURRENCIES[c].symbol.trim()} {c}
                </button>
              ))}
            </div>
          </div>
          {currency !== 'INR' && (
            <p className="text-xs text-gray-400 mt-2">
              Prices shown in {CURRENCIES[currency].label} are approximate. Payment is processed in INR ({formatPrice(100, currency)} ≈ ₹100).
            </p>
          )}
        </div>

        {/* Success banners */}
        {purchasedTokens && (
          <div className="mb-6 bg-emerald-50 border border-emerald-200 rounded-xl p-4">
            <div className="flex items-start gap-3">
              <CheckCircle2 className="w-5 h-5 text-emerald-600 mt-0.5 shrink-0" />
              <div>
                <p className="font-semibold text-emerald-800">Purchase successful!</p>
                <p className="text-sm text-emerald-700 mt-1">
                  {purchasedTokens.length} token{purchasedTokens.length > 1 ? 's' : ''} generated.
                  Check the &ldquo;My Tokens&rdquo; tab to see your codes.
                </p>
              </div>
            </div>
          </div>
        )}
        {subSuccess && (
          <div className="mb-6 bg-emerald-50 border border-emerald-200 rounded-xl p-4">
            <div className="flex items-start gap-3">
              <CheckCircle2 className="w-5 h-5 text-emerald-600 mt-0.5 shrink-0" />
              <div>
                <p className="font-semibold text-emerald-800">{subSuccess} activated!</p>
                <p className="text-sm text-emerald-700 mt-1">
                  You now have unlimited practice access. Head to SAT Mock to start practicing.
                </p>
              </div>
            </div>
          </div>
        )}
        {purchaseError && (
          <div className="mb-6 bg-red-50 border border-red-200 rounded-xl p-4">
            <p className="text-sm text-red-700">{purchaseError}</p>
          </div>
        )}

        {/* Referral Code — compact inline */}
        <div className="mb-6 bg-white border border-gray-200 rounded-xl p-4">
          {referral ? (
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Tag className="w-4 h-4 text-emerald-600" />
                <span className="text-sm font-medium text-emerald-700">
                  Code <span className="font-bold">{referral.code}</span> applied &mdash; {referral.discount_rate}% off
                </span>
                <span className="text-xs text-gray-400">via {referral.partner_name}</span>
              </div>
              <button onClick={clearReferral} className="p-1 text-gray-400 hover:text-gray-600 transition-colors">
                <X className="w-4 h-4" />
              </button>
            </div>
          ) : (
            <div>
              <p className="text-sm text-gray-600 mb-2">Have a referral code?</p>
              <div className="flex gap-2">
                <input
                  type="text"
                  value={referralInput}
                  onChange={(e) => { setReferralInput(e.target.value.toUpperCase()); setReferralError(''); }}
                  onKeyDown={(e) => e.key === 'Enter' && handleApplyReferral()}
                  placeholder="Enter code"
                  className="flex-1 px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#1a365d]/20 focus:border-[#1a365d]"
                />
                <button
                  onClick={handleApplyReferral}
                  disabled={referralLoading || !referralInput.trim()}
                  className="px-4 py-2 text-sm font-medium bg-[#1a365d] text-white rounded-lg hover:bg-[#2a4a7f] disabled:opacity-50 transition-colors"
                >
                  {referralLoading ? <Loader2 className="w-4 h-4 animate-spin" /> : 'Apply'}
                </button>
              </div>
              {referralError && <p className="text-xs text-red-600 mt-1">{referralError}</p>}
            </div>
          )}
        </div>

        {/* Tabs */}
        <div className="flex gap-1 bg-white rounded-lg p-1 border border-gray-200 mb-8 w-fit">
          <button
            onClick={() => setActiveTab('store')}
            className={`px-4 py-2 text-sm font-medium rounded-md transition-colors ${
              activeTab === 'store' ? 'bg-[#1a365d] text-white' : 'text-gray-600 hover:text-gray-900'
            }`}
          >
            <Ticket className="w-4 h-4 inline mr-1.5 -mt-0.5" />
            Pricing
          </button>
          <button
            onClick={() => setActiveTab('my-tokens')}
            className={`px-4 py-2 text-sm font-medium rounded-md transition-colors ${
              activeTab === 'my-tokens' ? 'bg-[#1a365d] text-white' : 'text-gray-600 hover:text-gray-900'
            }`}
          >
            My Tokens
          </button>
        </div>

        {/* Content */}
        {activeTab === 'store' ? (
          loading ? (
            <div className="flex items-center justify-center py-16">
              <Loader2 className="w-6 h-6 animate-spin text-gray-400" />
            </div>
          ) : packs.length === 0 && subPlans.length === 0 ? (
            <p className="text-gray-500 text-center py-16">No plans available yet.</p>
          ) : (
            <div className="space-y-4">
              {/* Value banner */}
              <div className="flex flex-wrap items-center gap-x-6 gap-y-2 text-xs text-gray-500 bg-white border border-gray-200 rounded-lg px-4 py-3">
                <span className="font-medium text-gray-700">Every mock includes:</span>
                <span>Adaptive sections</span>
                <span>Detailed scoring</span>
                <span>Domain breakdown</span>
                <span>Difficulty analysis</span>
              </div>

              <PricingTable
                plans={subPlans}
                packs={packs}
                currency={currency}
                referralCode={referral?.code ?? null}
                discountRate={referral?.discount_rate ?? 0}
                buyingId={buyingId}
                onBuyPlan={handleBuyPlan}
                onBuyPack={handleBuyPack}
              />
            </div>
          )
        ) : (
          <div className="bg-white border border-gray-200 rounded-xl p-6">
            <MyTokens />
          </div>
        )}
      </div>
    </div>
  );
}

'use client';

import { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'next/navigation';
import { ArrowLeft, Loader2, Ticket, CheckCircle2, Tag, X, BookOpen } from 'lucide-react';
import Link from 'next/link';
import TokenStoreCard from '@/components/tests/TokenStoreCard';
import SubscriptionPlanCard from '@/components/tests/SubscriptionPlanCard';
import MyTokens from '@/components/tests/MyTokens';
import type { TokenPackWithExam } from '@/types/test-tokens';

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

export default function TokenStorePage() {
  const searchParams = useSearchParams();
  const examFilter = searchParams.get('exam');

  const [packs, setPacks] = useState<TokenPackWithExam[]>([]);
  const [subPlans, setSubPlans] = useState<SubscriptionPlan[]>([]);
  const [loading, setLoading] = useState(true);
  const [purchasedTokens, setPurchasedTokens] = useState<string[] | null>(null);
  const [subSuccess, setSubSuccess] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState<'store' | 'my-tokens'>('store');

  const [referralInput, setReferralInput] = useState('');
  const [referralLoading, setReferralLoading] = useState(false);
  const [referral, setReferral] = useState<ReferralState | null>(null);
  const [referralError, setReferralError] = useState('');

  const fetchPacks = useCallback(async () => {
    try {
      const res = await fetch('/api/tests/packs');
      const data = await res.json();
      if (data.data) {
        let allPacks = data.data as TokenPackWithExam[];
        allPacks = allPacks.filter((p) => p.is_active);
        if (examFilter) {
          allPacks = allPacks.filter((p) => p.exam_type === examFilter);
        }
        setPacks(allPacks);
      }
    } catch {
      // silent
    } finally {
      setLoading(false);
    }
  }, [examFilter]);

  const fetchSubPlans = useCallback(async () => {
    try {
      const res = await fetch('/api/subscriptions/plans');
      const data = await res.json();
      if (data.plans) {
        let plans = data.plans as SubscriptionPlan[];
        if (examFilter) plans = plans.filter((p) => p.exam_type === examFilter);
        setSubPlans(plans);
      }
    } catch { /* silent */ }
  }, [examFilter]);

  useEffect(() => {
    fetchPacks();
    fetchSubPlans();
  }, [fetchPacks, fetchSubPlans]);

  const handlePurchaseComplete = (tokens: string[]) => {
    setPurchasedTokens(tokens);
    setActiveTab('my-tokens');
  };

  const handleSubPurchaseComplete = (planName: string, tokens: string[]) => {
    setSubSuccess(planName);
    if (tokens.length > 0) setPurchasedTokens(tokens);
    setActiveTab('my-tokens');
  };

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

  // Group packs by exam type
  const grouped: Record<string, { examName: string; packs: TokenPackWithExam[] }> = {};
  for (const pack of packs) {
    if (!grouped[pack.exam_type]) {
      grouped[pack.exam_type] = {
        examName: pack.exam_types?.name ?? pack.exam_type,
        packs: [],
      };
    }
    grouped[pack.exam_type].packs.push(pack);
  }

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="max-w-4xl mx-auto px-4 py-12">
        {/* Header */}
        <div className="mb-8">
          <Link
            href="/tests"
            className="inline-flex items-center gap-1 text-sm text-gray-500 hover:text-[#1a365d] mb-4"
          >
            <ArrowLeft className="w-4 h-4" /> Back to Test Hub
          </Link>
          <h1 className="text-3xl font-bold text-[#1a365d] mb-2">Plans & Packs</h1>
          <p className="text-gray-600">
            Unlimited practice with AI explanations, full-length adaptive mocks, or both.
            Choose the plan that fits your prep timeline.
          </p>
        </div>

        {/* Success banner */}
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

        {/* Subscription success banner */}
        {subSuccess && (
          <div className="mb-6 bg-emerald-50 border border-emerald-200 rounded-xl p-4">
            <div className="flex items-start gap-3">
              <CheckCircle2 className="w-5 h-5 text-emerald-600 mt-0.5 shrink-0" />
              <div>
                <p className="font-semibold text-emerald-800">{subSuccess} activated!</p>
                <p className="text-sm text-emerald-700 mt-1">
                  You now have unlimited practice access. Head to SAT Test to start practicing.
                </p>
              </div>
            </div>
          </div>
        )}

        {/* Referral Code Section */}
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
              <button
                onClick={clearReferral}
                className="p-1 text-gray-400 hover:text-gray-600 transition-colors"
              >
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
                  onChange={(e) => {
                    setReferralInput(e.target.value.toUpperCase());
                    setReferralError('');
                  }}
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
              {referralError && (
                <p className="text-xs text-red-600 mt-1">{referralError}</p>
              )}
            </div>
          )}
        </div>

        {/* Tabs */}
        <div className="flex gap-1 bg-white rounded-lg p-1 border border-gray-200 mb-8 w-fit">
          <button
            onClick={() => setActiveTab('store')}
            className={`px-4 py-2 text-sm font-medium rounded-md transition-colors ${
              activeTab === 'store'
                ? 'bg-[#1a365d] text-white'
                : 'text-gray-600 hover:text-gray-900'
            }`}
          >
            <Ticket className="w-4 h-4 inline mr-1.5 -mt-0.5" />
            Plans & Packs
          </button>
          <button
            onClick={() => setActiveTab('my-tokens')}
            className={`px-4 py-2 text-sm font-medium rounded-md transition-colors ${
              activeTab === 'my-tokens'
                ? 'bg-[#1a365d] text-white'
                : 'text-gray-600 hover:text-gray-900'
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
          ) : Object.keys(grouped).length === 0 ? (
            <p className="text-gray-500 text-center py-16">No token packs available yet.</p>
          ) : (
            <div className="space-y-8">
              {/* Practice Plans & Bundles */}
              {subPlans.length > 0 && (
                <div>
                  <div className="flex items-center gap-2 mb-3">
                    <BookOpen className="w-5 h-5 text-emerald-600" />
                    <h3 className="text-lg font-bold text-gray-900">Practice Plans</h3>
                  </div>
                  <p className="text-sm text-gray-500 mb-4">
                    Unlimited practice questions with AI explanations and theory. Choose standalone or bundled with mocks.
                  </p>
                  <div className="grid sm:grid-cols-2 gap-4">
                    {subPlans.map((plan) => (
                      <SubscriptionPlanCard
                        key={plan.id}
                        plan={plan}
                        onPurchaseComplete={handleSubPurchaseComplete}
                      />
                    ))}
                  </div>
                </div>
              )}

              {/* Divider */}
              {subPlans.length > 0 && Object.keys(grouped).length > 0 && (
                <div className="border-t border-gray-200" />
              )}

              {/* Mock Packs */}
              <div className="flex flex-wrap items-center gap-x-6 gap-y-2 text-xs text-gray-500 bg-white border border-gray-200 rounded-lg px-4 py-3">
                <span className="font-medium text-gray-700">Every mock includes:</span>
                <span>Adaptive sections</span>
                <span>400–1600 score</span>
                <span>Domain breakdown</span>
                <span>Difficulty analysis</span>
              </div>
              {Object.entries(grouped).map(([examType, group]) => (
                <div key={examType}>
                  <h3 className="text-lg font-bold text-gray-900 mb-3">{group.examName}</h3>
                  <div className="grid sm:grid-cols-2 gap-4">
                    {group.packs.map((pack) => (
                      <TokenStoreCard
                        key={pack.id}
                        pack={pack}
                        onPurchaseComplete={handlePurchaseComplete}
                        referralCode={referral?.code ?? null}
                        discountRate={referral?.discount_rate ?? 0}
                      />
                    ))}
                  </div>
                </div>
              ))}
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

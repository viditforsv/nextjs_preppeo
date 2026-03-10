'use client';

import { useState, useEffect, useCallback } from 'react';
import { useSearchParams } from 'next/navigation';
import { ArrowLeft, Loader2, Ticket, CheckCircle2 } from 'lucide-react';
import Link from 'next/link';
import TokenStoreCard from '@/components/tests/TokenStoreCard';
import MyTokens from '@/components/tests/MyTokens';
import type { TokenPackWithExam } from '@/types/test-tokens';

export default function TokenStorePage() {
  const searchParams = useSearchParams();
  const examFilter = searchParams.get('exam');

  const [packs, setPacks] = useState<TokenPackWithExam[]>([]);
  const [loading, setLoading] = useState(true);
  const [purchasedTokens, setPurchasedTokens] = useState<string[] | null>(null);
  const [activeTab, setActiveTab] = useState<'store' | 'my-tokens'>('store');

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

  useEffect(() => {
    fetchPacks();
  }, [fetchPacks]);

  const handlePurchaseComplete = (tokens: string[]) => {
    setPurchasedTokens(tokens);
    setActiveTab('my-tokens');
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
          <h1 className="text-3xl font-bold text-[#1a365d] mb-2">Token Store</h1>
          <p className="text-gray-600">
            Purchase test tokens to unlock additional mock test sets.
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
            Buy Tokens
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
              {Object.entries(grouped).map(([examType, group]) => (
                <div key={examType}>
                  <h3 className="text-lg font-bold text-gray-900 mb-3">{group.examName}</h3>
                  <div className="grid sm:grid-cols-2 gap-4">
                    {group.packs.map((pack) => (
                      <TokenStoreCard
                        key={pack.id}
                        pack={pack}
                        onPurchaseComplete={handlePurchaseComplete}
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

'use client';

import { useState, useEffect } from 'react';
import { useSATTestStore } from '@/stores/useSATTestStore';
import Link from 'next/link';
import {
  BarChart3,
  Target,
  Layers,
  Clock,
  FileText,
  RotateCcw,
  History,
  ArrowRight,
  Sparkles,
  Gift,
  Copy,
  Check,
} from 'lucide-react';
import ScoreOverviewTab from './results/ScoreOverviewTab';
import DomainBreakdownTab from './results/DomainBreakdownTab';
import DifficultyBreakdownTab from './results/DifficultyBreakdownTab';
import TimeAnalysisTab from './results/TimeAnalysisTab';
import QuestionReviewTab from './results/QuestionReviewTab';

const TABS = [
  { id: 'score', label: 'Score', icon: BarChart3 },
  { id: 'domain', label: 'Domains', icon: Target },
  { id: 'difficulty', label: 'Difficulty', icon: Layers },
  { id: 'time', label: 'Time', icon: Clock },
  { id: 'review', label: 'Review', icon: FileText },
] as const;

type TabId = (typeof TABS)[number]['id'];

export default function ResultsScreen() {
  const {
    module1, module2,
    module1Result, module2Result,
    rwModule1Result, rwModule2Result,
    rwQuestionResponses,
    rwEstimatedScore,
    allQuestionResponses,
    mathEstimatedScore,
    totalEstimatedScore,
    goToLanding,
  } = useSATTestStore();

  const [activeTab, setActiveTab] = useState<TabId>('score');
  const [referralCode, setReferralCode] = useState('');
  const [refCopied, setRefCopied] = useState(false);

  useEffect(() => {
    fetch('/api/referral/student/code')
      .then((r) => r.json())
      .then((d) => { if (d.code) setReferralCode(d.code); })
      .catch(() => {});
  }, []);

  function copyReferralLink() {
    const link = `${window.location.origin}/sat-free?ref=${referralCode}`;
    navigator.clipboard.writeText(link);
    setRefCopied(true);
    setTimeout(() => setRefCopied(false), 2000);
  }

  if (!module1Result) return null;

  const mathResponses = allQuestionResponses.filter((r) => r.section === 'math');
  const rwResponses = allQuestionResponses.filter((r) => r.section === 'rw');

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="bg-[#0d47a1] text-white px-4 py-4">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <BarChart3 className="w-5 h-5" />
            <h1 className="text-lg font-bold">SAT Score Report</h1>
          </div>
          <div className="flex items-center gap-2">
            <Link
              href="/sat-test/history"
              className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
            >
              <History className="w-3.5 h-3.5" />
              Score History
            </Link>
            <button
              onClick={goToLanding}
              className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
            >
              <RotateCcw className="w-3.5 h-3.5" />
              New Test
            </button>
          </div>
        </div>
      </div>

      <div className="bg-white border-b border-gray-200 sticky top-0 z-10">
        <div className="max-w-4xl mx-auto flex overflow-x-auto">
          {TABS.map((tab) => {
            const Icon = tab.icon;
            const isActive = activeTab === tab.id;
            return (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`flex items-center gap-1.5 px-4 py-3 text-sm font-medium border-b-2 whitespace-nowrap transition-colors ${
                  isActive
                    ? 'border-[#0d47a1] text-[#0d47a1]'
                    : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                }`}
              >
                <Icon className="w-4 h-4" />
                {tab.label}
              </button>
            );
          })}
        </div>
      </div>

      <div className="max-w-4xl mx-auto p-4">
        {activeTab === 'score' && (
          <ScoreOverviewTab
            mathModule1Result={module1Result}
            mathModule2Result={module2Result}
            rwModule1Result={rwModule1Result}
            rwModule2Result={rwModule2Result}
            rwEstimatedScore={rwEstimatedScore}
            mathEstimatedScore={mathEstimatedScore}
            totalEstimatedScore={totalEstimatedScore}
            responses={allQuestionResponses}
          />
        )}
        {activeTab === 'domain' && (
          <DomainBreakdownTab responses={allQuestionResponses} />
        )}
        {activeTab === 'difficulty' && (
          <DifficultyBreakdownTab responses={allQuestionResponses} />
        )}
        {activeTab === 'time' && (
          <TimeAnalysisTab responses={allQuestionResponses} />
        )}
        {activeTab === 'review' && (
          <QuestionReviewTab
            responses={allQuestionResponses}
          />
        )}

        {/* Upsell CTA */}
        <div className="mt-8 bg-linear-to-r from-[#0d47a1] to-[#1565c0] rounded-xl p-6 text-white">
          <div className="flex items-start gap-4">
            <div className="w-10 h-10 rounded-lg bg-white/20 flex items-center justify-center shrink-0">
              <Sparkles className="w-5 h-5" />
            </div>
            <div className="flex-1">
              <h3 className="text-lg font-bold mb-1">Ready to Improve Your Score?</h3>
              <p className="text-white/80 text-sm mb-4">
                {totalEstimatedScore
                  ? `You scored ${totalEstimatedScore}. `
                  : ''}
                Students who take 3+ mocks see the biggest improvements. Each test has unique questions and a fresh adaptive challenge.
              </p>
              <Link
                href="/tests/tokens?exam=sat"
                className="inline-flex items-center gap-2 px-5 py-2.5 bg-white text-[#0d47a1] font-semibold text-sm rounded-lg hover:bg-white/90 transition-colors"
              >
                Unlock Premium Practice
                <ArrowRight className="w-4 h-4" />
              </Link>
            </div>
          </div>
        </div>

        {referralCode && (
          <div className="mt-4 bg-white border border-gray-200 rounded-xl p-6">
            <div className="flex items-start gap-4">
              <div className="w-10 h-10 rounded-lg bg-emerald-100 flex items-center justify-center shrink-0">
                <Gift className="w-5 h-5 text-emerald-600" />
              </div>
              <div className="flex-1">
                <h3 className="text-lg font-bold text-[#1a365d] mb-1">Share with a Friend</h3>
                <p className="text-sm text-gray-600 mb-3">
                  Refer a friend and you both get a bonus mock test — free.
                </p>
                <div className="flex items-center gap-3">
                  <div className="bg-gray-50 border border-gray-200 rounded-lg px-3 py-2 flex items-center gap-2">
                    <code className="text-sm font-mono font-semibold text-[#0d47a1]">{referralCode}</code>
                  </div>
                  <button
                    onClick={copyReferralLink}
                    className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium bg-[#0d47a1] text-white rounded-lg hover:bg-[#1565c0] transition-colors"
                  >
                    {refCopied ? <Check className="w-3.5 h-3.5" /> : <Copy className="w-3.5 h-3.5" />}
                    {refCopied ? 'Copied!' : 'Copy Link'}
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

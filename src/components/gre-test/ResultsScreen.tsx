'use client';

import { useState } from 'react';
import { useGRETestStore } from '@/stores/useGRETestStore';
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
} from 'lucide-react';
import ScoreOverviewTab from './results/ScoreOverviewTab';
import TopicBreakdownTab from './results/TopicBreakdownTab';
import DifficultyBreakdownTab from './results/DifficultyBreakdownTab';
import TimeAnalysisTab from './results/TimeAnalysisTab';
import QuestionReviewTab from './results/QuestionReviewTab';

const TABS = [
  { id: 'score', label: 'Score', icon: BarChart3 },
  { id: 'topics', label: 'Topics', icon: Target },
  { id: 'difficulty', label: 'Difficulty', icon: Layers },
  { id: 'time', label: 'Time', icon: Clock },
  { id: 'review', label: 'Review', icon: FileText },
] as const;

type TabId = (typeof TABS)[number]['id'];

export default function ResultsScreen() {
  const {
    section1Result,
    section2Result,
    allQuestionResponses,
    estimatedScore,
    goToLanding,
  } = useGRETestStore();

  const [activeTab, setActiveTab] = useState<TabId>('score');

  if (!section1Result) return null;

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="bg-[#1a365d] text-white px-4 py-4">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <BarChart3 className="w-5 h-5" />
            <h1 className="text-lg font-bold">GRE Score Report</h1>
          </div>
          <div className="flex items-center gap-2">
            <Link
              href="/gre-test/history"
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
              New Mock
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
                    ? 'border-[#1a365d] text-[#1a365d]'
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
            section1Result={section1Result}
            section2Result={section2Result}
            estimatedScore={estimatedScore}
            responses={allQuestionResponses}
          />
        )}
        {activeTab === 'topics' && (
          <TopicBreakdownTab responses={allQuestionResponses} />
        )}
        {activeTab === 'difficulty' && (
          <DifficultyBreakdownTab responses={allQuestionResponses} />
        )}
        {activeTab === 'time' && (
          <TimeAnalysisTab responses={allQuestionResponses} />
        )}
        {activeTab === 'review' && (
          <QuestionReviewTab responses={allQuestionResponses} />
        )}

        <div className="mt-8 bg-linear-to-r from-[#1a365d] to-[#2a4a7f] rounded-xl p-6 text-white">
          <div className="flex items-start gap-4">
            <div className="w-10 h-10 rounded-lg bg-white/20 flex items-center justify-center shrink-0">
              <Sparkles className="w-5 h-5" />
            </div>
            <div className="flex-1">
              <h3 className="text-lg font-bold mb-1">Ready to Improve Your Score?</h3>
              <p className="text-white/80 text-sm mb-4">
                {estimatedScore
                  ? `You scored ${estimatedScore}/170. `
                  : ''}
                Students who take 3+ mocks see the biggest improvements. Each mock has unique questions and a fresh adaptive challenge.
              </p>
              <Link
                href="/gre-test"
                className="inline-flex items-center gap-2 px-5 py-2.5 bg-white text-[#1a365d] font-semibold text-sm rounded-lg hover:bg-white/90 transition-colors"
              >
                Take Another Mock
                <ArrowRight className="w-4 h-4" />
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

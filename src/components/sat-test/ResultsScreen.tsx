'use client';

import { useState } from 'react';
import { useSATTestStore } from '@/stores/useSATTestStore';
import {
  BarChart3,
  Target,
  Layers,
  Clock,
  FileText,
  RotateCcw,
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
          <button
            onClick={goToLanding}
            className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
          >
            <RotateCcw className="w-3.5 h-3.5" />
            New Test
          </button>
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
      </div>
    </div>
  );
}

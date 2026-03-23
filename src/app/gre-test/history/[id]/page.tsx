'use client';

import { useEffect, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import Link from 'next/link';
import type { GREQuestionResponse, SectionResult, DifficultyTier } from '@/types/gre-test';
import {
  BarChart3,
  Target,
  Layers,
  Clock,
  FileText,
  ArrowLeft,
  Loader2,
} from 'lucide-react';
import ScoreOverviewTab from '@/components/gre-test/results/ScoreOverviewTab';
import TopicBreakdownTab from '@/components/gre-test/results/TopicBreakdownTab';
import DifficultyBreakdownTab from '@/components/gre-test/results/DifficultyBreakdownTab';
import TimeAnalysisTab from '@/components/gre-test/results/TimeAnalysisTab';
import QuestionReviewTab from '@/components/gre-test/results/QuestionReviewTab';

const TABS = [
  { id: 'score', label: 'Score', icon: BarChart3 },
  { id: 'topics', label: 'Topics', icon: Target },
  { id: 'difficulty', label: 'Difficulty', icon: Layers },
  { id: 'time', label: 'Time', icon: Clock },
  { id: 'review', label: 'Review', icon: FileText },
] as const;

type TabId = (typeof TABS)[number]['id'];

interface AttemptRow {
  id: string;
  set_number: number;
  section1_correct: number;
  section1_total: number;
  section1_time_used: number;
  section2_tier: DifficultyTier | null;
  section2_correct: number | null;
  section2_total: number | null;
  section2_time_used: number | null;
  total_correct: number;
  total_questions: number;
  score_pct: number;
  estimated_score: number | null;
  question_responses: GREQuestionResponse[];
  completed_at: string;
}

function buildSectionResult(
  sectionNumber: 1 | 2,
  correct: number,
  total: number,
  timeUsed: number,
  tier: DifficultyTier,
): SectionResult {
  return {
    sectionNumber,
    difficultyTier: tier,
    correct,
    total,
    answers: {},
    timeUsed,
  };
}

export default function GREHistoryDetailPage() {
  const { id } = useParams<{ id: string }>();
  const { user, loading: authLoading } = useAuth();
  const router = useRouter();

  const [attempt, setAttempt] = useState<AttemptRow | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState<TabId>('score');

  useEffect(() => {
    if (authLoading) return;
    if (!user) {
      router.push(`/auth?redirect=/gre-test/history/${id}`);
      return;
    }

    fetch(`/api/gre/attempts/${id}`)
      .then(async (res) => {
        if (!res.ok) throw new Error('Not found');
        return res.json();
      })
      .then(setAttempt)
      .catch(() => setError('Attempt not found'))
      .finally(() => setLoading(false));
  }, [id, user, authLoading, router]);

  if (authLoading || loading) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-[#1a365d]" />
      </div>
    );
  }

  if (error || !attempt) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <div className="text-center">
          <p className="text-gray-500 mb-4">{error ?? 'Attempt not found'}</p>
          <Link href="/gre-test/history" className="text-[#1a365d] font-medium hover:underline">
            Back to history
          </Link>
        </div>
      </div>
    );
  }

  const section1Result = buildSectionResult(
    1,
    attempt.section1_correct,
    attempt.section1_total,
    attempt.section1_time_used,
    'medium',
  );

  const section2Result = attempt.section2_correct !== null
    ? buildSectionResult(
        2,
        attempt.section2_correct,
        attempt.section2_total ?? 0,
        attempt.section2_time_used ?? 0,
        attempt.section2_tier ?? 'medium',
      )
    : null;

  const responses = attempt.question_responses ?? [];

  const date = new Date(attempt.completed_at).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="bg-[#1a365d] text-white px-4 py-4">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <BarChart3 className="w-5 h-5" />
            <div>
              <h1 className="text-lg font-bold">GRE Score Report</h1>
              <p className="text-xs text-white/60">Set {attempt.set_number} &middot; {date}</p>
            </div>
          </div>
          <Link
            href="/gre-test/history"
            className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
          >
            <ArrowLeft className="w-3.5 h-3.5" />
            History
          </Link>
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
            estimatedScore={attempt.estimated_score}
            responses={responses}
          />
        )}
        {activeTab === 'topics' && (
          <TopicBreakdownTab responses={responses} />
        )}
        {activeTab === 'difficulty' && (
          <DifficultyBreakdownTab responses={responses} />
        )}
        {activeTab === 'time' && (
          <TimeAnalysisTab responses={responses} />
        )}
        {activeTab === 'review' && (
          <QuestionReviewTab responses={responses} />
        )}
      </div>
    </div>
  );
}

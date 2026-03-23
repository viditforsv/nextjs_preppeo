'use client';

import { useEffect, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import type { GREQuestionResponse, SectionResult, DifficultyTier } from '@/types/gre-test';
import {
  BarChart3,
  Target,
  Layers,
  Clock,
  FileText,
  ArrowLeft,
  Loader2,
  Lightbulb,
} from 'lucide-react';
import Link from 'next/link';
import ResultsShell from '@/components/shared-results/ResultsShell';
import RecommendationsTab from '@/components/shared-results/RecommendationsTab';
import type { ResultsConfig, NormalizedResponse } from '@/components/shared-results/results-types';
import ScoreOverviewTab from '@/components/gre-test/results/ScoreOverviewTab';
import TopicBreakdownTab from '@/components/gre-test/results/TopicBreakdownTab';
import DifficultyBreakdownTab from '@/components/gre-test/results/DifficultyBreakdownTab';
import TimeAnalysisTab from '@/components/gre-test/results/TimeAnalysisTab';
import QuestionReviewTab from '@/components/gre-test/results/QuestionReviewTab';

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
  return { sectionNumber, difficultyTier: tier, correct, total, answers: {}, timeUsed };
}

export default function GREHistoryDetailPage() {
  const { id } = useParams<{ id: string }>();
  const { user, loading: authLoading } = useAuth();
  const router = useRouter();

  const [attempt, setAttempt] = useState<AttemptRow | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

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

  const section1Result = buildSectionResult(1, attempt.section1_correct, attempt.section1_total, attempt.section1_time_used, 'medium');
  const section2Result = attempt.section2_correct !== null
    ? buildSectionResult(2, attempt.section2_correct, attempt.section2_total ?? 0, attempt.section2_time_used ?? 0, attempt.section2_tier ?? 'medium')
    : null;

  const responses = attempt.question_responses ?? [];

  const normalized: NormalizedResponse[] = responses.map((r) => ({
    isCorrect: r.isCorrect,
    isOmitted: r.isOmitted,
    timeSpentMs: r.timeSpentMs,
    difficulty: r.difficulty,
    topic: r.topics?.[0] ?? '',
  }));

  const date = new Date(attempt.completed_at).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });

  const config: ResultsConfig = {
    title: 'GRE Score Report',
    subtitle: `Set ${attempt.set_number} · ${date}`,
    headerColor: '#1a365d',
    accentColor: '#1a365d',
    headerActions: [
      { label: 'History', icon: ArrowLeft, href: '/gre-test/history' },
    ],
    tabs: [
      {
        id: 'score',
        label: 'Score',
        icon: BarChart3,
        render: () => (
          <ScoreOverviewTab
            section1Result={section1Result}
            section2Result={section2Result}
            estimatedScore={attempt.estimated_score}
            responses={responses}
          />
        ),
      },
      {
        id: 'topics',
        label: 'Topics',
        icon: Target,
        render: () => <TopicBreakdownTab responses={responses} />,
      },
      {
        id: 'difficulty',
        label: 'Difficulty',
        icon: Layers,
        render: () => <DifficultyBreakdownTab responses={responses} />,
      },
      {
        id: 'time',
        label: 'Time',
        icon: Clock,
        render: () => <TimeAnalysisTab responses={responses} />,
      },
      {
        id: 'review',
        label: 'Review',
        icon: FileText,
        render: () => <QuestionReviewTab responses={responses} />,
      },
      {
        id: 'recommendations',
        label: 'Tips',
        icon: Lightbulb,
        render: () => <RecommendationsTab responses={normalized} />,
      },
    ],
  };

  return <ResultsShell config={config} />;
}

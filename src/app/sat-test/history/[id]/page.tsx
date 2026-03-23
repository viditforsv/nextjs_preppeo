'use client';

import { useEffect, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import Link from 'next/link';
import type { SATModuleResult, SATQuestionResponse } from '@/types/sat-test';
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
import ResultsShell from '@/components/shared-results/ResultsShell';
import RecommendationsTab from '@/components/shared-results/RecommendationsTab';
import type { ResultsConfig, NormalizedResponse } from '@/components/shared-results/results-types';
import ScoreOverviewTab from '@/components/sat-test/results/ScoreOverviewTab';
import DomainBreakdownTab from '@/components/sat-test/results/DomainBreakdownTab';
import DifficultyBreakdownTab from '@/components/sat-test/results/DifficultyBreakdownTab';
import TimeAnalysisTab from '@/components/sat-test/results/TimeAnalysisTab';
import QuestionReviewTab from '@/components/sat-test/results/QuestionReviewTab';

const SAT_DOMAIN_LABELS: Record<string, string> = {
  algebra: 'Algebra',
  'advanced-math': 'Advanced Math',
  'problem-solving': 'Problem Solving & Data',
  'geometry-trig': 'Geometry & Trig',
  'craft-structure': 'Craft & Structure',
  'information-ideas': 'Information & Ideas',
  'standard-english': 'Standard English',
  'expression-of-ideas': 'Expression of Ideas',
};

interface AttemptRow {
  id: string;
  section_type: string;
  set_number: number;
  completed_at: string;
  module1_correct: number;
  module1_total: number;
  module1_time_used: number;
  module2_tier: string | null;
  module2_correct: number | null;
  module2_total: number | null;
  module2_time_used: number | null;
  rw_module1_correct: number | null;
  rw_module1_total: number | null;
  rw_module1_time_used: number | null;
  rw_module2_tier: string | null;
  rw_module2_correct: number | null;
  rw_module2_total: number | null;
  rw_module2_time_used: number | null;
  estimated_score: number | null;
  rw_estimated_score: number | null;
  total_estimated_score: number | null;
  question_responses: SATQuestionResponse[];
  rw_question_responses: SATQuestionResponse[];
}

function buildModuleResult(
  moduleNumber: 1 | 2,
  section: 'math' | 'rw',
  tier: string | null,
  correct: number | null,
  total: number | null,
  timeUsed: number | null,
): SATModuleResult | null {
  if (correct == null || total == null || timeUsed == null) return null;
  return {
    moduleNumber,
    section,
    difficultyTier: moduleNumber === 1 ? 'mixed' : (tier as 'hard' | 'easy') ?? 'mixed',
    correct,
    total,
    answers: {},
    timeUsed,
  };
}

export default function AttemptDetailPage() {
  const { id } = useParams<{ id: string }>();
  const { user, loading: authLoading } = useAuth();
  const router = useRouter();
  const [attempt, setAttempt] = useState<AttemptRow | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (authLoading) return;
    if (!user) {
      router.push('/auth?redirect=/sat-test/history');
      return;
    }

    fetch(`/api/sat/attempts/${id}`)
      .then((r) => {
        if (!r.ok) throw new Error(r.status === 404 ? 'Attempt not found' : 'Failed to load');
        return r.json();
      })
      .then(setAttempt)
      .catch((e) => setError(e.message))
      .finally(() => setLoading(false));
  }, [id, user, authLoading, router]);

  if (authLoading || loading) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-[#0d47a1]" />
      </div>
    );
  }

  if (error || !attempt) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
        <div className="bg-white rounded-xl border border-gray-200 p-8 text-center max-w-sm">
          <p className="text-gray-600 mb-4">{error ?? 'Attempt not found'}</p>
          <Link
            href="/sat-test/history"
            className="inline-flex items-center gap-1.5 px-4 py-2 bg-[#0d47a1] text-white rounded-lg text-sm font-semibold hover:bg-[#1565c0] transition-colors"
          >
            <ArrowLeft className="w-4 h-4" />
            Back to History
          </Link>
        </div>
      </div>
    );
  }

  const mathM1 = buildModuleResult(1, 'math', null, attempt.module1_correct, attempt.module1_total, attempt.module1_time_used);
  const mathM2 = buildModuleResult(2, 'math', attempt.module2_tier, attempt.module2_correct, attempt.module2_total, attempt.module2_time_used);
  const rwM1 = buildModuleResult(1, 'rw', null, attempt.rw_module1_correct, attempt.rw_module1_total, attempt.rw_module1_time_used);
  const rwM2 = buildModuleResult(2, 'rw', attempt.rw_module2_tier, attempt.rw_module2_correct, attempt.rw_module2_total, attempt.rw_module2_time_used);

  const allResponses: SATQuestionResponse[] = [
    ...(attempt.rw_question_responses ?? []),
    ...(attempt.question_responses ?? []),
  ];

  const normalized: NormalizedResponse[] = allResponses.map((r) => ({
    isCorrect: r.isCorrect,
    isOmitted: r.isOmitted,
    timeSpentMs: r.timeSpentMs,
    difficulty: r.difficulty,
    topic: r.domain ?? '',
  }));

  const date = new Date(attempt.completed_at).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });

  const typeLabel =
    attempt.section_type === 'full'
      ? 'Full Test'
      : attempt.section_type === 'rw'
      ? 'R&W Only'
      : 'Math Only';

  const config: ResultsConfig = {
    title: 'SAT Score Report',
    subtitle: `${typeLabel} · Set ${attempt.set_number} · ${date}`,
    headerColor: '#0d47a1',
    accentColor: '#0d47a1',
    headerActions: [
      { label: 'History', icon: ArrowLeft, href: '/sat-test/history' },
    ],
    tabs: [
      {
        id: 'score',
        label: 'Score',
        icon: BarChart3,
        render: () => mathM1 ? (
          <ScoreOverviewTab
            mathModule1Result={mathM1}
            mathModule2Result={mathM2}
            rwModule1Result={rwM1}
            rwModule2Result={rwM2}
            rwEstimatedScore={attempt.rw_estimated_score}
            mathEstimatedScore={attempt.estimated_score}
            totalEstimatedScore={attempt.total_estimated_score}
            responses={allResponses}
          />
        ) : null,
      },
      {
        id: 'domain',
        label: 'Domains',
        icon: Target,
        render: () => <DomainBreakdownTab responses={allResponses} />,
      },
      {
        id: 'difficulty',
        label: 'Difficulty',
        icon: Layers,
        render: () => <DifficultyBreakdownTab responses={allResponses} />,
      },
      {
        id: 'time',
        label: 'Time',
        icon: Clock,
        render: () => <TimeAnalysisTab responses={allResponses} />,
      },
      {
        id: 'review',
        label: 'Review',
        icon: FileText,
        render: () => <QuestionReviewTab responses={allResponses} />,
      },
      {
        id: 'recommendations',
        label: 'Tips',
        icon: Lightbulb,
        render: () => <RecommendationsTab responses={normalized} topicLabels={SAT_DOMAIN_LABELS} />,
      },
    ],
  };

  return <ResultsShell config={config} />;
}

'use client';

import { useSATTestStore } from '@/stores/useSATTestStore';
import {
  BarChart3,
  Target,
  Layers,
  Clock,
  FileText,
  RotateCcw,
  History,
  Sparkles,
  BookOpen,
  Lightbulb,
} from 'lucide-react';
import ResultsShell from '@/components/shared-results/ResultsShell';
import RecommendationsTab from '@/components/shared-results/RecommendationsTab';
import type { ResultsConfig, NormalizedResponse } from '@/components/shared-results/results-types';
import ScoreOverviewTab from './results/ScoreOverviewTab';
import DomainBreakdownTab from './results/DomainBreakdownTab';
import DifficultyBreakdownTab from './results/DifficultyBreakdownTab';
import TimeAnalysisTab from './results/TimeAnalysisTab';
import QuestionReviewTab from './results/QuestionReviewTab';

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

export default function ResultsScreen() {
  const {
    module1Result,
    module2Result,
    rwModule1Result,
    rwModule2Result,
    rwQuestionResponses,
    rwEstimatedScore,
    allQuestionResponses,
    mathEstimatedScore,
    totalEstimatedScore,
    goToLanding,
  } = useSATTestStore();

  if (!module1Result) return null;

  const normalized: NormalizedResponse[] = allQuestionResponses.map((r) => ({
    isCorrect: r.isCorrect,
    isOmitted: r.isOmitted,
    timeSpentMs: r.timeSpentMs,
    difficulty: r.difficulty,
    topic: r.domain ?? '',
  }));

  const config: ResultsConfig = {
    title: 'SAT Score Report',
    headerColor: '#0d47a1',
    accentColor: '#0d47a1',
    referralPath: '/sat-free',
    headerActions: [
      { label: 'Score History', icon: History, href: '/sat-test/history' },
      { label: 'New Mock', icon: RotateCcw, onClick: goToLanding },
    ],
    tabs: [
      {
        id: 'score',
        label: 'Score',
        icon: BarChart3,
        render: () => (
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
        ),
      },
      {
        id: 'domain',
        label: 'Domains',
        icon: Target,
        render: () => <DomainBreakdownTab responses={allQuestionResponses} />,
      },
      {
        id: 'difficulty',
        label: 'Difficulty',
        icon: Layers,
        render: () => <DifficultyBreakdownTab responses={allQuestionResponses} />,
      },
      {
        id: 'time',
        label: 'Time',
        icon: Clock,
        render: () => <TimeAnalysisTab responses={allQuestionResponses} />,
      },
      {
        id: 'review',
        label: 'Review',
        icon: FileText,
        render: () => <QuestionReviewTab responses={allQuestionResponses} />,
      },
      {
        id: 'recommendations',
        label: 'Tips',
        icon: Lightbulb,
        render: () => (
          <RecommendationsTab responses={normalized} topicLabels={SAT_DOMAIN_LABELS} />
        ),
      },
    ],
    ctas: [
      {
        icon: Sparkles,
        title: 'Ready to Improve Your Score?',
        description: totalEstimatedScore
          ? `You scored ${totalEstimatedScore}. Students who take 3+ mocks see the biggest improvements.`
          : 'Students who take 3+ mocks see the biggest improvements. Each mock has unique questions.',
        buttonLabel: 'Unlock Premium Practice',
        href: '/mocks/tokens?exam=sat',
        gradient: 'linear-gradient(to right, #0d47a1, #1565c0)',
      },
      {
        icon: BookOpen,
        title: 'Want to Improve Specific Areas?',
        description: 'Use Practice Mode to target your weak domains with AI explanations. 5 free questions daily.',
        buttonLabel: 'Start Practicing',
        href: '/sat-test',
        gradient: 'linear-gradient(to right, #059669, #10b981)',
      },
    ],
  };

  return <ResultsShell config={config} />;
}

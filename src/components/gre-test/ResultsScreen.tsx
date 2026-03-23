'use client';

import { useGRETestStore } from '@/stores/useGRETestStore';
import {
  BarChart3,
  Target,
  Layers,
  Clock,
  FileText,
  RotateCcw,
  History,
  Sparkles,
  Lightbulb,
} from 'lucide-react';
import ResultsShell from '@/components/shared-results/ResultsShell';
import RecommendationsTab from '@/components/shared-results/RecommendationsTab';
import type { ResultsConfig } from '@/components/shared-results/results-types';
import type { NormalizedResponse } from '@/components/shared-results/results-types';
import ScoreOverviewTab from './results/ScoreOverviewTab';
import TopicBreakdownTab from './results/TopicBreakdownTab';
import DifficultyBreakdownTab from './results/DifficultyBreakdownTab';
import TimeAnalysisTab from './results/TimeAnalysisTab';
import QuestionReviewTab from './results/QuestionReviewTab';

export default function ResultsScreen() {
  const {
    section1Result,
    section2Result,
    allQuestionResponses,
    estimatedScore,
    goToLanding,
  } = useGRETestStore();

  if (!section1Result) return null;

  const normalized: NormalizedResponse[] = allQuestionResponses.map((r) => ({
    isCorrect: r.isCorrect,
    isOmitted: r.isOmitted,
    timeSpentMs: r.timeSpentMs,
    difficulty: r.difficulty,
    topic: r.topics[0] ?? '',
  }));

  const config: ResultsConfig = {
    title: 'GRE Score Report',
    headerColor: '#1a365d',
    accentColor: '#1a365d',
    headerActions: [
      { label: 'Score History', icon: History, href: '/gre-test/history' },
      { label: 'New Mock', icon: RotateCcw, onClick: goToLanding },
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
            estimatedScore={estimatedScore}
            responses={allQuestionResponses}
          />
        ),
      },
      {
        id: 'topics',
        label: 'Topics',
        icon: Target,
        render: () => <TopicBreakdownTab responses={allQuestionResponses} />,
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
        render: () => <RecommendationsTab responses={normalized} />,
      },
    ],
    ctas: [
      {
        icon: Sparkles,
        title: 'Ready to Improve Your Score?',
        description: estimatedScore
          ? `You scored ${estimatedScore}/170. Students who take 3+ mocks see the biggest improvements.`
          : 'Students who take 3+ mocks see the biggest improvements. Each mock has unique questions and a fresh adaptive challenge.',
        buttonLabel: 'Take Another Mock',
        href: '/gre-test',
        gradient: 'linear-gradient(to right, #1a365d, #2a4a7f)',
      },
    ],
  };

  return <ResultsShell config={config} />;
}

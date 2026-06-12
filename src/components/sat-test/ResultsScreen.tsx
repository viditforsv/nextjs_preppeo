'use client';

import { useEffect, useRef } from 'react';
import { useSATTestStore } from '@/stores/useSATTestStore';
import { useAuth } from '@/contexts/AuthContext';
import FreeMockSignupCard, { RESULTS_CLAIM_FLAG } from './FreeMockSignupCard';
import {
  BarChart3,
  Target,
  Layers,
  Clock,
  FileText,
  RotateCcw,
  History,
  Home,
  Sparkles,
  BookOpen,
  Lightbulb,
  Loader2,
  CheckCircle2,
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
    rwEstimatedScore,
    allQuestionResponses,
    mathEstimatedScore,
    totalEstimatedScore,
    pendingAttemptBody,
    attemptSaved,
    persistAttempt,
    goToLanding,
  } = useSATTestStore();
  const { user, loading: authLoading } = useAuth();
  const savingRef = useRef(false);

  // Once a user exists with an unsaved attempt AND the signup originated from
  // this results screen (RESULTS_CLAIM_FLAG, set by FreeMockSignupCard for both
  // email and Google), grant the free token and save the attempt. The flag gate
  // ensures a normal logged-in finisher — whose attempt is already saved by
  // submitModule — never triggers a duplicate save or an unwanted claim-free.
  useEffect(() => {
    if (!user || !pendingAttemptBody || attemptSaved || savingRef.current) return;
    if (typeof window === 'undefined' || !sessionStorage.getItem(RESULTS_CLAIM_FLAG)) return;
    savingRef.current = true;
    (async () => {
      try {
        const referralCode =
          (typeof window !== 'undefined' && sessionStorage.getItem('sat-free-ref')) || '';
        let claimedCode: string | undefined;
        try {
          const res = await fetch('/api/mocks/claim-free', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ examType: 'sat', ...(referralCode ? { referralCode } : {}) }),
          });
          const data = await res.json();
          if (data?.code) claimedCode = data.code;
        } catch (err) {
          console.error('Failed to claim free token before saving attempt:', err);
        }
        await persistAttempt(claimedCode);
        if (typeof window !== 'undefined') {
          sessionStorage.removeItem(RESULTS_CLAIM_FLAG);
          sessionStorage.removeItem('sat-free-ref');
        }
      } finally {
        savingRef.current = false;
      }
    })();
  }, [user, pendingAttemptBody, attemptSaved, persistAttempt]);

  if (!module1Result) return null;

  // Wait for auth to resolve so an anonymous visitor never flashes the full
  // report before the gate applies.
  if (authLoading) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-[#0d47a1]" />
      </div>
    );
  }

  // Anonymous finisher — show the headline score for free and gate the detailed
  // report behind account creation.
  if (!user) {
    const hasRW = rwEstimatedScore !== null;
    const headline = totalEstimatedScore ?? mathEstimatedScore ?? null;
    return (
      <div className="min-h-screen bg-[#f5f5f0] py-12 px-4">
        <div className="max-w-md mx-auto space-y-6">
          <div className="bg-white rounded-2xl border border-gray-200 shadow-lg p-8 text-center">
            <div className="inline-flex items-center gap-2 text-emerald-600 text-sm font-semibold mb-3">
              <CheckCircle2 className="w-4 h-4" />
              Mock complete
            </div>
            <p className="text-sm font-medium text-gray-500 mb-1">Your estimated SAT score</p>
            <p className="text-6xl font-bold text-[#0d47a1] leading-none mb-3">
              {headline ?? '—'}
            </p>
            <p className="text-sm text-gray-500">
              {hasRW ? (
                <>Reading &amp; Writing <span className="font-semibold text-gray-700">{rwEstimatedScore}</span> · Math <span className="font-semibold text-gray-700">{mathEstimatedScore}</span></>
              ) : (
                <>Math <span className="font-semibold text-gray-700">{mathEstimatedScore}</span></>
              )}
            </p>
          </div>

          <div className="bg-[#0d47a1]/5 border border-[#0d47a1]/15 rounded-xl p-4 text-sm text-gray-600">
            <p className="font-semibold text-[#1a365d] mb-2">Create a free account to unlock:</p>
            <ul className="space-y-1.5">
              {['Domain-by-domain breakdown', 'Question-by-question review', 'Difficulty & time analysis', 'Personalized recommendations'].map((item) => (
                <li key={item} className="flex items-start gap-2">
                  <CheckCircle2 className="w-4 h-4 text-emerald-500 shrink-0 mt-0.5" />
                  <span>{item}</span>
                </li>
              ))}
            </ul>
          </div>

          <FreeMockSignupCard onSignedUp={() => { /* save runs via effect once user is set */ }} />
        </div>
      </div>
    );
  }

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
      { label: 'Home', icon: Home, href: '/' },
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
        href: '/pricing',
        gradient: 'linear-gradient(to right, #0d47a1, #1565c0)',
      },
      {
        icon: BookOpen,
        title: 'Want to Improve Specific Areas?',
        description: 'Use Practice Mode to target your weak domains with AI explanations. 5 free questions daily.',
        buttonLabel: 'Start Practicing',
        href: '/sat-test?mode=practice',
        gradient: 'linear-gradient(to right, #059669, #10b981)',
      },
    ],
  };

  return <ResultsShell config={config} />;
}

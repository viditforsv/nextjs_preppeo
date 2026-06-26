'use client';

import { useEffect, useRef, useState } from 'react';
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
  Mail,
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

  // Soft email gate for anonymous finishers: entering an email captures the lead
  // and unlocks the full report inline (the data is already client-side). Account
  // creation is then offered as a secondary "save your progress" upsell.
  const [reportUnlocked, setReportUnlocked] = useState(false);
  const [leadEmail, setLeadEmail] = useState('');
  const [leadError, setLeadError] = useState('');
  const [leadLoading, setLeadLoading] = useState(false);
  // Whether the report email actually went out: true = sent, false = throttled
  // (already emailed recently), null = unknown (request failed).
  const [emailSent, setEmailSent] = useState<boolean | null>(null);
  const [sentToEmail, setSentToEmail] = useState('');
  const unlockingRef = useRef(false);

  async function handleEmailUnlock(e: React.FormEvent) {
    e.preventDefault();
    // Synchronous guard: a rapid double-Enter would otherwise fire the request
    // twice before `leadLoading` re-renders the button to disabled.
    if (unlockingRef.current) return;
    const email = leadEmail.trim().toLowerCase();
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      setLeadError('Please enter a valid email address.');
      return;
    }
    unlockingRef.current = true;
    setLeadLoading(true);
    setLeadError('');
    setSentToEmail(email);
    // Best-effort capture — never block the unlock on the lead write.
    try {
      const ref =
        (typeof window !== 'undefined' && sessionStorage.getItem('sat-free-ref')) || undefined;
      const res = await fetch('/api/sat-free/lead', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          email,
          ref,
          totalScore: totalEstimatedScore,
          mathScore: mathEstimatedScore,
          rwScore: rwEstimatedScore,
          report: buildReportSummary(),
        }),
      });
      const data = await res.json().catch(() => null);
      setEmailSent(typeof data?.emailed === 'boolean' ? data.emailed : null);
    } catch {
      // Capture is best-effort; UX comes first. Unknown send status (null).
      setEmailSent(null);
    }
    setReportUnlocked(true);
  }

  // Compact summary emailed to the lead so the email itself IS the report
  // (section + domain + difficulty breakdown), not just a teaser. Sent only as
  // keys + tallies; the API resolves domain labels server-side.
  function buildReportSummary() {
    const responses = allQuestionResponses;
    const tallyOf = (pred: (r: (typeof responses)[number]) => boolean) => {
      const rs = responses.filter(pred);
      return { correct: rs.filter((r) => r.isCorrect).length, total: rs.length };
    };
    const byDomain = new Map<string, { key: string; section: string; correct: number; total: number }>();
    for (const r of responses) {
      const key = r.domain ?? 'unknown';
      const d = byDomain.get(key) ?? { key, section: r.section, correct: 0, total: 0 };
      d.total += 1;
      if (r.isCorrect) d.correct += 1;
      byDomain.set(key, d);
    }
    return {
      correct: responses.filter((r) => r.isCorrect).length,
      answered: responses.length,
      sections: {
        math: tallyOf((r) => r.section === 'math'),
        rw: tallyOf((r) => r.section === 'rw'),
      },
      domains: Array.from(byDomain.values()),
      difficulty: {
        easy: tallyOf((r) => r.difficulty === 'easy'),
        medium: tallyOf((r) => r.difficulty === 'medium'),
        hard: tallyOf((r) => r.difficulty === 'hard'),
      },
    };
  }

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

  // Anonymous finisher — show the headline score for free, then unlock the full
  // report with just an email (lowest-friction lead capture). Account creation is
  // offered afterwards as a "save your progress" upsell (see the final return).
  if (!user && !reportUnlocked) {
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

          <div className="bg-white rounded-2xl border border-gray-200 shadow-lg p-6">
            <p className="font-semibold text-[#1a365d] mb-1">Unlock your full report</p>
            <p className="text-sm text-gray-500 mb-3">Enter your email to see your complete breakdown — free.</p>
            <ul className="space-y-1.5 text-sm text-gray-600 mb-5">
              {['Domain-by-domain breakdown', 'Question-by-question review', 'Difficulty & time analysis', 'Personalized recommendations'].map((item) => (
                <li key={item} className="flex items-start gap-2">
                  <CheckCircle2 className="w-4 h-4 text-emerald-500 shrink-0 mt-0.5" />
                  <span>{item}</span>
                </li>
              ))}
            </ul>

            <form onSubmit={handleEmailUnlock} className="space-y-3">
              <div className="relative">
                <Mail className="absolute left-3 top-3 h-4 w-4 text-gray-400" />
                <input
                  type="email"
                  required
                  value={leadEmail}
                  onChange={(e) => setLeadEmail(e.target.value)}
                  placeholder="you@example.com"
                  className="w-full pl-9 pr-3 py-2.5 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1]"
                />
              </div>

              {leadError && (
                <p className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-lg p-2 text-center">{leadError}</p>
              )}

              <button
                type="submit"
                disabled={leadLoading}
                className="w-full flex items-center justify-center gap-2 py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] transition-colors disabled:opacity-50"
              >
                {leadLoading ? <Loader2 className="w-4 h-4 animate-spin" /> : 'Show My Full Report'}
              </button>
              <p className="text-xs text-gray-400 text-center">
                No spam. We&apos;ll email your report and occasional SAT tips.
              </p>
            </form>
          </div>
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

  // Unlocked anonymous finisher: full report renders below, with a secondary
  // account upsell on top. Signing up here sets RESULTS_CLAIM_FLAG, so the effect
  // above grants the free token and persists this attempt for their history.
  if (!user) {
    return (
      <div className="min-h-screen bg-[#f5f5f0]">
        <div className="max-w-2xl mx-auto px-4 pt-8">
          {emailSent === true && (
            <div className="flex items-start gap-2 bg-emerald-50 border border-emerald-200 text-emerald-800 rounded-xl p-4 mb-3 text-sm">
              <CheckCircle2 className="w-4 h-4 shrink-0 mt-0.5" />
              <span>We&apos;ve emailed your full report to <strong>{sentToEmail}</strong>. Check your inbox (and spam).</span>
            </div>
          )}
          {emailSent === false && (
            <div className="flex items-start gap-2 bg-amber-50 border border-amber-200 text-amber-800 rounded-xl p-4 mb-3 text-sm">
              <Mail className="w-4 h-4 shrink-0 mt-0.5" />
              <span>We already emailed your report to <strong>{sentToEmail}</strong> in the last few minutes — check your inbox. To prevent spam, we send at most one report email every 10 minutes.</span>
            </div>
          )}
          {emailSent === null && (
            <div className="flex items-start gap-2 bg-gray-50 border border-gray-200 text-gray-600 rounded-xl p-4 mb-3 text-sm">
              <Mail className="w-4 h-4 shrink-0 mt-0.5" />
              <span>Your full report is below. We couldn&apos;t confirm the email just now — if it doesn&apos;t arrive, you can re-enter your email after a few minutes.</span>
            </div>
          )}
          <div className="bg-[#0d47a1]/5 border border-[#0d47a1]/15 rounded-2xl p-6 mb-2">
            <h2 className="text-lg font-bold text-[#1a365d] mb-1">Save your report</h2>
            <p className="text-sm text-gray-600 mb-5">
              Create a free account to keep this report, track your score across mocks,
              and target weak domains with adaptive practice.
            </p>
            <FreeMockSignupCard
              heading="Create your free account"
              subheading="Save your progress and unlock practice mode"
              onSignedUp={() => { /* save runs via effect once user is set */ }}
            />
          </div>
        </div>
        <ResultsShell config={config} />
      </div>
    );
  }

  return <ResultsShell config={config} />;
}

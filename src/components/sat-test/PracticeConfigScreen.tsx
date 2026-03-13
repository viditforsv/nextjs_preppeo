'use client';

import { useState, useEffect } from 'react';
import { useSATTestStore } from '@/stores/useSATTestStore';
import Link from 'next/link';
import type {
  SATSection,
  SATDomain,
  SATMathDomain,
  SATRWDomain,
  DifficultyTier,
} from '@/types/sat-test';
import { BookOpen, ArrowLeft, Loader2, Play, Crown, Sparkles, ArrowRight } from 'lucide-react';

const MATH_DOMAINS: { id: SATMathDomain; label: string }[] = [
  { id: 'algebra', label: 'Algebra' },
  { id: 'advanced-math', label: 'Advanced Math' },
  { id: 'problem-solving', label: 'Problem Solving & Data' },
  { id: 'geometry-trig', label: 'Geometry & Trig' },
];

const RW_DOMAINS: { id: SATRWDomain; label: string }[] = [
  { id: 'craft-structure', label: 'Craft & Structure' },
  { id: 'information-ideas', label: 'Information & Ideas' },
  { id: 'standard-english', label: 'Standard English' },
  { id: 'expression-of-ideas', label: 'Expression of Ideas' },
];

const DIFFICULTIES: { id: DifficultyTier | 'mixed'; label: string }[] = [
  { id: 'mixed', label: 'Mixed' },
  { id: 'easy', label: 'Easy' },
  { id: 'medium', label: 'Medium' },
  { id: 'hard', label: 'Hard' },
];

const COUNTS = [5, 10, 15, 20];

type Remaining = { easy: number; medium: number; hard: number };

export default function PracticeConfigScreen() {
  const { startPracticeMode, goToLanding } = useSATTestStore();
  const [section, setSection] = useState<SATSection>('rw');
  const [selectedDomains, setSelectedDomains] = useState<SATDomain[]>([]);
  const [difficulty, setDifficulty] = useState<DifficultyTier | 'mixed'>('mixed');
  const [count, setCount] = useState(10);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [isPremium, setIsPremium] = useState<boolean | null>(null);
  const [remaining, setRemaining] = useState<Remaining | null>(null);
  const [usageLoading, setUsageLoading] = useState(true);
  const [subscriptionExpired, setSubscriptionExpired] = useState(false);

  useEffect(() => {
    fetch('/api/sat/practice-usage')
      .then((r) => r.json())
      .then((d) => {
        setIsPremium(d.isPremium ?? false);
        if (!d.isPremium && d.remaining) setRemaining(d.remaining);
        if (d.recentlyExpired) setSubscriptionExpired(true);
      })
      .catch(() => setIsPremium(false))
      .finally(() => setUsageLoading(false));
  }, []);

  const domains = section === 'math' ? MATH_DOMAINS : RW_DOMAINS;

  const toggleDomain = (id: SATDomain) => {
    setSelectedDomains((prev) =>
      prev.includes(id) ? prev.filter((d) => d !== id) : [...prev, id]
    );
  };

  const totalRemaining = remaining ? remaining.easy + remaining.medium + remaining.hard : 0;
  const limitExhausted = isPremium === false && remaining !== null && totalRemaining === 0;

  const handleStart = async () => {
    setLoading(true);
    setError(null);
    try {
      await startPracticeMode({
        section,
        domains: selectedDomains,
        difficulty: isPremium ? difficulty : 'mixed',
        questionCount: isPremium ? count : totalRemaining,
      });
    } catch (err) {
      const msg = err instanceof Error ? err.message : '';
      if (msg.includes('daily_limit_reached')) {
        setError("You've used all your free questions for today. Come back tomorrow or upgrade for unlimited access.");
      } else {
        setError('No questions found for these filters. Try broader options.');
      }
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="w-full max-w-lg">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-2">
            <div className="w-10 h-10 bg-emerald-600 rounded-lg flex items-center justify-center">
              <BookOpen className="w-5 h-5 text-white" />
            </div>
            <div>
              <h1 className="text-xl font-bold text-gray-900">Practice Mode</h1>
              <p className="text-sm text-gray-500">Untimed with AI explanations</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            {isPremium && (
              <span className="inline-flex items-center gap-1 px-2.5 py-1 bg-amber-100 text-amber-700 text-xs font-bold rounded-full">
                <Crown className="w-3 h-3" />
                Premium
              </span>
            )}
            <button
              onClick={goToLanding}
              className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm text-gray-600 hover:text-gray-900 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
            >
              <ArrowLeft className="w-3.5 h-3.5" />
              Back
            </button>
          </div>
        </div>

        {/* Subscription expired banner */}
        {!usageLoading && subscriptionExpired && (
          <div className="mb-4 bg-amber-50 border border-amber-200 rounded-xl p-4">
            <div className="flex items-start justify-between gap-3">
              <div>
                <p className="text-sm font-semibold text-amber-800">Your subscription has expired</p>
                <p className="text-xs text-amber-600 mt-0.5">
                  Renew to continue with unlimited practice questions.
                </p>
              </div>
              <Link
                href="/tests/tokens"
                className="shrink-0 inline-flex items-center gap-1 px-3 py-1.5 bg-[#0d47a1] text-white text-xs font-semibold rounded-lg hover:bg-[#1565c0] transition-colors"
              >
                <Sparkles className="w-3 h-3" />
                Renew
              </Link>
            </div>
          </div>
        )}

        {/* Freemium banner */}
        {!usageLoading && isPremium === false && !subscriptionExpired && (
          <div className="mb-4 bg-[#0d47a1]/5 border border-[#0d47a1]/20 rounded-xl p-4">
            <div className="flex items-start justify-between gap-3">
              <div>
                <p className="text-sm font-semibold text-[#1a365d]">
                  Free Plan — {totalRemaining} question{totalRemaining !== 1 ? 's' : ''} remaining today
                </p>
                <p className="text-xs text-gray-500 mt-0.5">
                  Daily limit: 2 Easy + 2 Medium + 1 Hard with AI explanations
                </p>
                {remaining && (
                  <div className="flex gap-3 mt-2">
                    {(['easy', 'medium', 'hard'] as const).map((tier) => (
                      <span key={tier} className={`text-xs font-medium px-2 py-0.5 rounded-full ${
                        remaining[tier] > 0 ? 'bg-emerald-100 text-emerald-700' : 'bg-gray-100 text-gray-400'
                      }`}>
                        {tier.charAt(0).toUpperCase() + tier.slice(1)}: {remaining[tier]}
                      </span>
                    ))}
                  </div>
                )}
              </div>
              <Link
                href="/tests/tokens"
                className="shrink-0 inline-flex items-center gap-1 px-3 py-1.5 bg-[#0d47a1] text-white text-xs font-semibold rounded-lg hover:bg-[#1565c0] transition-colors"
              >
                <Sparkles className="w-3 h-3" />
                Upgrade
              </Link>
            </div>
          </div>
        )}

        {/* Limit exhausted */}
        {limitExhausted && (
          <div className="mb-4 bg-amber-50 border border-amber-200 rounded-xl p-5 text-center">
            <p className="font-semibold text-amber-800 mb-1">Today&apos;s free questions are used up</p>
            <p className="text-sm text-amber-600 mb-3">Come back tomorrow or upgrade for unlimited practice.</p>
            <Link
              href="/tests/tokens"
              className="inline-flex items-center gap-2 px-5 py-2.5 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] transition-colors text-sm"
            >
              Unlock Unlimited Practice
              <ArrowRight className="w-4 h-4" />
            </Link>
          </div>
        )}

        <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 space-y-6">
          {/* Section */}
          <div>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">Section</label>
            <div className="grid grid-cols-2 gap-3">
              {(['rw', 'math'] as SATSection[]).map((s) => (
                <button
                  key={s}
                  onClick={() => { setSection(s); setSelectedDomains([]); }}
                  className={`py-3 px-4 rounded-lg border-2 text-sm font-semibold transition-all ${
                    section === s
                      ? 'border-emerald-500 bg-emerald-50 text-emerald-700'
                      : 'border-gray-200 text-gray-600 hover:border-gray-300'
                  }`}
                >
                  {s === 'rw' ? 'Reading & Writing' : 'Math'}
                </button>
              ))}
            </div>
          </div>

          {/* Domains */}
          <div>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">
              Domains <span className="font-normal text-gray-400">(none = all)</span>
            </label>
            <div className="flex flex-wrap gap-2">
              {domains.map((d) => {
                const active = selectedDomains.includes(d.id);
                return (
                  <button
                    key={d.id}
                    onClick={() => toggleDomain(d.id)}
                    className={`px-3 py-1.5 rounded-full text-xs font-medium border transition-colors ${
                      active
                        ? 'border-emerald-400 bg-emerald-50 text-emerald-700'
                        : 'border-gray-200 text-gray-500 hover:border-gray-300'
                    }`}
                  >
                    {d.label}
                  </button>
                );
              })}
            </div>
          </div>

          {/* Difficulty — only for premium */}
          <div className={isPremium === false ? 'opacity-50 pointer-events-none' : ''}>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">
              Difficulty
              {isPremium === false && <span className="ml-2 text-xs font-normal text-amber-600">(Premium only)</span>}
            </label>
            <div className="flex gap-2">
              {DIFFICULTIES.map((d) => (
                <button
                  key={d.id}
                  onClick={() => setDifficulty(d.id)}
                  className={`flex-1 py-2 rounded-lg text-xs font-semibold border-2 transition-all ${
                    difficulty === d.id
                      ? 'border-emerald-500 bg-emerald-50 text-emerald-700'
                      : 'border-gray-200 text-gray-500 hover:border-gray-300'
                  }`}
                >
                  {d.label}
                </button>
              ))}
            </div>
          </div>

          {/* Count — only for premium */}
          <div className={isPremium === false ? 'opacity-50 pointer-events-none' : ''}>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">
              Questions
              {isPremium === false && <span className="ml-2 text-xs font-normal text-amber-600">(Premium only)</span>}
            </label>
            <div className="flex gap-2">
              {COUNTS.map((c) => (
                <button
                  key={c}
                  onClick={() => setCount(c)}
                  className={`flex-1 py-2 rounded-lg text-sm font-semibold border-2 transition-all ${
                    count === c
                      ? 'border-emerald-500 bg-emerald-50 text-emerald-700'
                      : 'border-gray-200 text-gray-500 hover:border-gray-300'
                  }`}
                >
                  {c}
                </button>
              ))}
            </div>
          </div>

          {error && (
            <p className="text-sm text-red-600 bg-red-50 rounded-lg p-3">{error}</p>
          )}

          <button
            onClick={handleStart}
            disabled={loading || limitExhausted || usageLoading}
            className="w-full py-3 bg-emerald-600 text-white font-semibold rounded-lg hover:bg-emerald-700 disabled:opacity-60 transition-colors text-lg inline-flex items-center justify-center gap-2"
          >
            {loading ? (
              <>
                <Loader2 className="w-5 h-5 animate-spin" />
                Loading Questions...
              </>
            ) : (
              <>
                <Play className="w-5 h-5" />
                {isPremium ? 'Start Practice' : `Start Practice (${totalRemaining} left)`}
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}

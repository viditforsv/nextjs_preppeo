'use client';

import { useState, useEffect, useMemo } from 'react';
import { useCBSE10MathsStore } from '@/stores/useCBSE10MathsStore';
import Link from 'next/link';
import type { CBSE10MathsDomain, DifficultyTier } from '@/types/cbse10-maths';
import { BookOpen, ArrowLeft, Loader2, Play, Crown, Sparkles, ArrowRight } from 'lucide-react';

const DOMAINS: { id: CBSE10MathsDomain; label: string }[] = [
  { id: 'real-numbers', label: 'Real Numbers' },
  { id: 'polynomials', label: 'Polynomials' },
  { id: 'linear-equations', label: 'Linear Equations' },
  { id: 'quadratic-equations', label: 'Quadratic Equations' },
  { id: 'arithmetic-progressions', label: 'Arithmetic Progressions' },
  { id: 'triangles', label: 'Triangles' },
  { id: 'coordinate-geometry', label: 'Coordinate Geometry' },
  { id: 'trigonometry', label: 'Trigonometry' },
  { id: 'applications-of-trig', label: 'Applications of Trig' },
  { id: 'circles', label: 'Circles' },
  { id: 'areas-related-to-circles', label: 'Areas Related to Circles' },
  { id: 'surface-areas-volumes', label: 'Surface Areas & Volumes' },
  { id: 'statistics', label: 'Statistics' },
  { id: 'probability', label: 'Probability' },
];

const DIFFICULTIES: { id: DifficultyTier | 'mixed'; label: string }[] = [
  { id: 'mixed', label: 'Mixed' },
  { id: 'easy', label: 'Easy' },
  { id: 'medium', label: 'Medium' },
  { id: 'hard', label: 'Hard' },
];

const COUNTS = [5, 10, 15, 20];

type Remaining = { easy: number; medium: number; hard: number };
interface FilterChapter { name: string; subtopics: string[] }
interface FilterDomain { id: string; chapters: FilterChapter[] }

export default function PracticeConfigScreen() {
  const { startPracticeMode, goToLanding } = useCBSE10MathsStore();
  const [selectedDomains, setSelectedDomains] = useState<CBSE10MathsDomain[]>([]);
  const [selectedChapters, setSelectedChapters] = useState<string[]>([]);
  const [selectedSubtopics, setSelectedSubtopics] = useState<string[]>([]);
  const [difficulty, setDifficulty] = useState<DifficultyTier | 'mixed'>('mixed');
  const [count, setCount] = useState(10);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [isPremium, setIsPremium] = useState<boolean | null>(null);
  const [remaining, setRemaining] = useState<Remaining | null>(null);
  const [usageLoading, setUsageLoading] = useState(true);
  const [subscriptionExpired, setSubscriptionExpired] = useState(false);
  const [filterData, setFilterData] = useState<FilterDomain[]>([]);

  useEffect(() => {
    fetch('/api/cbse10-maths/practice-usage')
      .then((r) => r.json())
      .then((d) => {
        setIsPremium(d.isPremium ?? false);
        if (!d.isPremium && d.remaining) setRemaining(d.remaining);
        if (d.recentlyExpired) setSubscriptionExpired(true);
      })
      .catch(() => setIsPremium(false))
      .finally(() => setUsageLoading(false));
  }, []);

  useEffect(() => {
    fetch('/api/cbse10-maths/practice-filters')
      .then((r) => r.json())
      .then((d) => setFilterData(d.domains ?? []))
      .catch(() => setFilterData([]));
  }, []);

  const availableChapters = useMemo(() => {
    if (selectedDomains.length === 0) return filterData.flatMap((d) => d.chapters);
    return filterData.filter((d) => selectedDomains.includes(d.id as CBSE10MathsDomain)).flatMap((d) => d.chapters);
  }, [filterData, selectedDomains]);

  const availableSubtopics = useMemo(() => {
    const chapters = selectedChapters.length > 0
      ? availableChapters.filter((ch) => selectedChapters.includes(ch.name))
      : availableChapters;
    return [...new Set(chapters.flatMap((ch) => ch.subtopics))].sort();
  }, [availableChapters, selectedChapters]);

  const toggleDomain = (id: CBSE10MathsDomain) => {
    setSelectedDomains((prev) => prev.includes(id) ? prev.filter((d) => d !== id) : [...prev, id]);
    setSelectedChapters([]);
    setSelectedSubtopics([]);
  };

  const toggleChapter = (name: string) => {
    setSelectedChapters((prev) => prev.includes(name) ? prev.filter((c) => c !== name) : [...prev, name]);
    setSelectedSubtopics([]);
  };

  const toggleSubtopic = (name: string) => {
    setSelectedSubtopics((prev) => prev.includes(name) ? prev.filter((s) => s !== name) : [...prev, name]);
  };

  const totalRemaining = remaining ? remaining.easy + remaining.medium + remaining.hard : 0;
  const limitExhausted = isPremium === false && remaining !== null && totalRemaining === 0;

  const handleStart = async () => {
    setLoading(true);
    setError(null);
    try {
      await startPracticeMode({
        domains: selectedDomains,
        chapters: selectedChapters,
        subtopics: selectedSubtopics,
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
            <div className="w-10 h-10 rounded-lg flex items-center justify-center text-gray-900" style={{ backgroundColor: '#d4d700' }}>
              <BookOpen className="w-5 h-5" />
            </div>
            <div>
              <h1 className="text-xl font-bold text-gray-900">CBSE 10 Maths</h1>
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

        {!usageLoading && subscriptionExpired && (
          <div className="mb-4 bg-amber-50 border border-amber-200 rounded-xl p-4">
            <div className="flex items-start justify-between gap-3">
              <div>
                <p className="text-sm font-semibold text-amber-800">Your subscription has expired</p>
                <p className="text-xs text-amber-600 mt-0.5">Renew to continue with unlimited practice questions.</p>
              </div>
              <Link href="/mocks/tokens" className="shrink-0 inline-flex items-center gap-1 px-3 py-1.5 text-gray-900 text-xs font-semibold rounded-lg hover:brightness-95 transition-all" style={{ backgroundColor: '#d4d700' }}>
                <Sparkles className="w-3 h-3" />
                Renew
              </Link>
            </div>
          </div>
        )}

        {!usageLoading && isPremium === false && !subscriptionExpired && (
          <div className="mb-4 rounded-xl p-4 border" style={{ backgroundColor: 'rgba(245, 247, 196, 0.65)', borderColor: '#d4d700' }}>
            <div className="flex items-start justify-between gap-3">
              <div>
                <p className="text-sm font-semibold" style={{ color: '#8a8c00' }}>
                  Free Plan — {totalRemaining} question{totalRemaining !== 1 ? 's' : ''} remaining today
                </p>
                <p className="text-xs text-gray-500 mt-0.5">Daily limit: 2 Easy + 2 Medium + 1 Hard with AI explanations</p>
                {remaining && (
                  <div className="flex gap-3 mt-2">
                    {(['easy', 'medium', 'hard'] as const).map((tier) => (
                      <span key={tier} className={`text-xs font-medium px-2 py-0.5 rounded-full ${
                        remaining[tier] > 0 ? '' : 'bg-gray-100 text-gray-400'
                      }`}
                        style={remaining[tier] > 0 ? { backgroundColor: '#f5f7c4', color: '#8a8c00' } : undefined}
                      >
                        {tier.charAt(0).toUpperCase() + tier.slice(1)}: {remaining[tier]}
                      </span>
                    ))}
                  </div>
                )}
              </div>
              <Link href="/mocks/tokens" className="shrink-0 inline-flex items-center gap-1 px-3 py-1.5 text-gray-900 text-xs font-semibold rounded-lg hover:brightness-95 transition-all" style={{ backgroundColor: '#d4d700' }}>
                <Sparkles className="w-3 h-3" />
                Upgrade
              </Link>
            </div>
          </div>
        )}

        {limitExhausted && (
          <div className="mb-4 bg-amber-50 border border-amber-200 rounded-xl p-5 text-center">
            <p className="font-semibold text-amber-800 mb-1">Today&apos;s free questions are used up</p>
            <p className="text-sm text-amber-600 mb-3">Come back tomorrow or upgrade for unlimited practice.</p>
            <Link href="/mocks/tokens" className="inline-flex items-center gap-2 px-5 py-2.5 text-gray-900 font-semibold rounded-lg hover:brightness-95 transition-all text-sm" style={{ backgroundColor: '#d4d700' }}>
              Unlock Unlimited Practice
              <ArrowRight className="w-4 h-4" />
            </Link>
          </div>
        )}

        <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 space-y-6">
          {/* Chapters (domains) */}
          <div>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">
              Chapter <span className="font-normal text-gray-400">(none = all)</span>
            </label>
            <div className="flex flex-wrap gap-2">
              {DOMAINS.map((d) => {
                const active = selectedDomains.includes(d.id);
                return (
                  <button key={d.id} onClick={() => toggleDomain(d.id)}
                    className={`px-3 py-1.5 rounded-full text-xs font-medium border transition-colors ${
                      active ? 'text-gray-900' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                    }`}
                    style={active ? { borderColor: '#d4d700', backgroundColor: '#f5f7c4' } : undefined}
                  >
                    {d.label}
                  </button>
                );
              })}
            </div>
          </div>

          {/* Subtopics from filters API */}
          {availableChapters.length > 0 && (
            <div>
              <label className="text-sm font-semibold text-gray-700 mb-2 block">
                Topic <span className="font-normal text-gray-400">(none = all)</span>
              </label>
              <div className="flex flex-wrap gap-2">
                {availableChapters.map((ch) => {
                  const active = selectedChapters.includes(ch.name);
                  return (
                    <button key={ch.name} onClick={() => toggleChapter(ch.name)}
                      className={`px-3 py-1.5 rounded-full text-xs font-medium border transition-colors ${
                        active ? 'border-blue-400 bg-blue-50 text-blue-700' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                      }`}
                    >
                      {ch.name}
                    </button>
                  );
                })}
              </div>
            </div>
          )}

          {availableSubtopics.length > 0 && (
            <div>
              <label className="text-sm font-semibold text-gray-700 mb-2 block">
                Subtopic <span className="font-normal text-gray-400">(none = all)</span>
              </label>
              <div className="flex flex-wrap gap-2">
                {availableSubtopics.map((st) => {
                  const active = selectedSubtopics.includes(st);
                  return (
                    <button key={st} onClick={() => toggleSubtopic(st)}
                      className={`px-3 py-1.5 rounded-full text-xs font-medium border transition-colors ${
                        active ? 'border-violet-400 bg-violet-50 text-violet-700' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                      }`}
                    >
                      {st}
                    </button>
                  );
                })}
              </div>
            </div>
          )}

          {/* Difficulty */}
          <div className={isPremium === false ? 'opacity-50 pointer-events-none' : ''}>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">
              Difficulty
              {isPremium === false && <span className="ml-2 text-xs font-normal text-amber-600">(Premium only)</span>}
            </label>
            <div className="flex gap-2">
              {DIFFICULTIES.map((d) => (
                <button key={d.id} onClick={() => setDifficulty(d.id)}
                  className={`flex-1 py-2 rounded-lg text-xs font-semibold border-2 transition-all ${
                    difficulty === d.id ? 'text-gray-900' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                  }`}
                  style={difficulty === d.id ? { borderColor: '#d4d700', backgroundColor: '#f5f7c4' } : undefined}
                >
                  {d.label}
                </button>
              ))}
            </div>
          </div>

          {/* Count */}
          <div className={isPremium === false ? 'opacity-50 pointer-events-none' : ''}>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">
              Questions
              {isPremium === false && <span className="ml-2 text-xs font-normal text-amber-600">(Premium only)</span>}
            </label>
            <div className="flex gap-2">
              {COUNTS.map((c) => (
                <button key={c} onClick={() => setCount(c)}
                  className={`flex-1 py-2 rounded-lg text-sm font-semibold border-2 transition-all ${
                    count === c ? 'text-gray-900' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                  }`}
                  style={count === c ? { borderColor: '#d4d700', backgroundColor: '#f5f7c4' } : undefined}
                >
                  {c}
                </button>
              ))}
            </div>
          </div>

          {error && <p className="text-sm text-red-600 bg-red-50 rounded-lg p-3">{error}</p>}

          <button onClick={handleStart} disabled={loading || limitExhausted || usageLoading}
            className="w-full py-3 text-gray-900 font-semibold rounded-lg hover:brightness-95 disabled:opacity-60 transition-all text-lg inline-flex items-center justify-center gap-2"
            style={{ backgroundColor: '#d4d700' }}
          >
            {loading ? (<><Loader2 className="w-5 h-5 animate-spin" />Loading Questions...</>) : (<><Play className="w-5 h-5" />{isPremium ? 'Start Practice' : `Start Practice (${totalRemaining} left)`}</>)}
          </button>
        </div>
      </div>
    </div>
  );
}

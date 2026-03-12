'use client';

import { useState } from 'react';
import { useSATTestStore } from '@/stores/useSATTestStore';
import type {
  SATSection,
  SATDomain,
  SATMathDomain,
  SATRWDomain,
  DifficultyTier,
} from '@/types/sat-test';
import { BookOpen, ArrowLeft, Loader2, Play } from 'lucide-react';

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

export default function PracticeConfigScreen() {
  const { startPracticeMode, goToLanding } = useSATTestStore();
  const [section, setSection] = useState<SATSection>('rw');
  const [selectedDomains, setSelectedDomains] = useState<SATDomain[]>([]);
  const [difficulty, setDifficulty] = useState<DifficultyTier | 'mixed'>('mixed');
  const [count, setCount] = useState(10);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const domains = section === 'math' ? MATH_DOMAINS : RW_DOMAINS;

  const toggleDomain = (id: SATDomain) => {
    setSelectedDomains((prev) =>
      prev.includes(id) ? prev.filter((d) => d !== id) : [...prev, id]
    );
  };

  const handleStart = async () => {
    setLoading(true);
    setError(null);
    try {
      await startPracticeMode({
        section,
        domains: selectedDomains,
        difficulty,
        questionCount: count,
      });
    } catch {
      setError('No questions found for these filters. Try broader options.');
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
          <button
            onClick={goToLanding}
            className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm text-gray-600 hover:text-gray-900 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
          >
            <ArrowLeft className="w-3.5 h-3.5" />
            Back
          </button>
        </div>

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

          {/* Difficulty */}
          <div>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">Difficulty</label>
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

          {/* Count */}
          <div>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">Questions</label>
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
            disabled={loading}
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
                Start Practice
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}

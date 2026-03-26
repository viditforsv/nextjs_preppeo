'use client';

import { useState, useEffect, useMemo } from 'react';
import { useCBSE10ScienceStore } from '@/stores/useCBSE10ScienceStore';
import type { CBSE10ScienceDomain, DifficultyTier } from '@/types/cbse10-science';
import { ClipboardList, ArrowLeft, Loader2, Play, Timer } from 'lucide-react';

const ACCENT = '#1e40af';
const ACCENT_LIGHT = '#dbeafe';

const DOMAINS: { id: CBSE10ScienceDomain; label: string }[] = [
  { id: 'chemical-reactions', label: 'Chemical Reactions' },
  { id: 'acids-bases-salts', label: 'Acids, Bases & Salts' },
  { id: 'metals-non-metals', label: 'Metals & Non-metals' },
  { id: 'carbon-compounds', label: 'Carbon Compounds' },
  { id: 'life-processes', label: 'Life Processes' },
  { id: 'control-coordination', label: 'Control & Coordination' },
  { id: 'reproduction', label: 'Reproduction' },
  { id: 'heredity-evolution', label: 'Heredity & Evolution' },
  { id: 'light', label: 'Light' },
  { id: 'human-eye', label: 'Human Eye' },
  { id: 'electricity', label: 'Electricity' },
  { id: 'magnetic-effects', label: 'Magnetic Effects' },
  { id: 'our-environment', label: 'Our Environment' },
];

const DIFFICULTIES: { id: DifficultyTier | 'mixed'; label: string }[] = [
  { id: 'mixed', label: 'Mixed' },
  { id: 'easy', label: 'Easy' },
  { id: 'medium', label: 'Medium' },
  { id: 'hard', label: 'Hard' },
];

const COUNTS = [10, 15, 20, 25, 30];
// Minutes per question options
const TIME_PER_Q = [1, 1.5, 2];

interface FilterChapter { name: string; subtopics: string[] }
interface FilterDomain { id: string; chapters: FilterChapter[] }

export default function TestModeConfig() {
  const { goToLanding, startTestMode } = useCBSE10ScienceStore();
  const [selectedDomains, setSelectedDomains] = useState<CBSE10ScienceDomain[]>([]);
  const [selectedChapters, setSelectedChapters] = useState<string[]>([]);
  const [selectedSubtopics, setSelectedSubtopics] = useState<string[]>([]);
  const [difficulty, setDifficulty] = useState<DifficultyTier | 'mixed'>('mixed');
  const [count, setCount] = useState(20);
  const [minutesPerQ, setMinutesPerQ] = useState(1.5);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [filterData, setFilterData] = useState<FilterDomain[]>([]);

  useEffect(() => {
    fetch('/api/cbse10-science/practice-filters')
      .then((r) => r.json())
      .then((d) => setFilterData(d.domains ?? []))
      .catch(() => setFilterData([]));
  }, []);

  const availableChapters = useMemo(() => {
    if (selectedDomains.length === 0) return filterData.flatMap((d) => d.chapters);
    return filterData.filter((d) => selectedDomains.includes(d.id as CBSE10ScienceDomain)).flatMap((d) => d.chapters);
  }, [filterData, selectedDomains]);

  const availableSubtopics = useMemo(() => {
    const chapters = selectedChapters.length > 0
      ? availableChapters.filter((ch) => selectedChapters.includes(ch.name))
      : availableChapters;
    return [...new Set(chapters.flatMap((ch) => ch.subtopics))].sort();
  }, [availableChapters, selectedChapters]);

  const toggleDomain = (id: CBSE10ScienceDomain) => {
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

  const timeLimitMinutes = Math.round(count * minutesPerQ);

  const handleStart = async () => {
    setLoading(true);
    setError(null);
    try {
      await startTestMode({
        domains: selectedDomains,
        chapters: selectedChapters,
        subtopics: selectedSubtopics,
        difficulty,
        questionCount: count,
        timeLimitMinutes,
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
            <div className="w-10 h-10 rounded-lg flex items-center justify-center text-white" style={{ backgroundColor: ACCENT }}>
              <ClipboardList className="w-5 h-5" />
            </div>
            <div>
              <h1 className="text-xl font-bold text-gray-900">CBSE 10 Science</h1>
              <p className="text-sm text-gray-500">Configure your test</p>
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
          {/* Chapter filter */}
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
                      active ? 'text-white border-[#1e40af] bg-[#1e40af]' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                    }`}
                  >
                    {d.label}
                  </button>
                );
              })}
            </div>
          </div>

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
          <div>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">Difficulty</label>
            <div className="flex gap-2">
              {DIFFICULTIES.map((d) => (
                <button key={d.id} onClick={() => setDifficulty(d.id)}
                  className={`flex-1 py-2 rounded-lg text-xs font-semibold border-2 transition-all ${
                    difficulty === d.id ? 'text-white border-[#1e40af] bg-[#1e40af]' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                  }`}
                >
                  {d.label}
                </button>
              ))}
            </div>
          </div>

          {/* Question count */}
          <div>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">Questions</label>
            <div className="flex gap-2">
              {COUNTS.map((c) => (
                <button key={c} onClick={() => setCount(c)}
                  className={`flex-1 py-2 rounded-lg text-sm font-semibold border-2 transition-all ${
                    count === c ? 'text-white border-[#1e40af] bg-[#1e40af]' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                  }`}
                >
                  {c}
                </button>
              ))}
            </div>
          </div>

          {/* Time per question */}
          <div>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">Time per question</label>
            <div className="flex gap-2">
              {TIME_PER_Q.map((t) => (
                <button key={t} onClick={() => setMinutesPerQ(t)}
                  className={`flex-1 py-2 rounded-lg text-sm font-semibold border-2 transition-all ${
                    minutesPerQ === t ? 'text-white border-[#1e40af] bg-[#1e40af]' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                  }`}
                >
                  {t} min
                </button>
              ))}
            </div>
          </div>

          {/* Time summary */}
          <div className="flex items-center gap-2 px-4 py-3 rounded-lg text-sm font-medium" style={{ backgroundColor: ACCENT_LIGHT, color: ACCENT }}>
            <Timer className="w-4 h-4" />
            <span>Total time: <strong>{timeLimitMinutes} minutes</strong> for {count} questions</span>
          </div>

          {error && <p className="text-sm text-red-600 bg-red-50 rounded-lg p-3">{error}</p>}

          <button
            onClick={handleStart}
            disabled={loading}
            className="w-full py-3 text-white font-semibold rounded-lg hover:brightness-95 disabled:opacity-60 transition-all text-lg inline-flex items-center justify-center gap-2"
            style={{ backgroundColor: ACCENT }}
          >
            {loading
              ? (<><Loader2 className="w-5 h-5 animate-spin" />Loading Questions...</>)
              : (<><Play className="w-5 h-5" />Start Test</>)}
          </button>
        </div>
      </div>
    </div>
  );
}

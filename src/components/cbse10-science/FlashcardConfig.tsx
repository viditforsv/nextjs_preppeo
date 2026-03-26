'use client';

import { useState, useEffect, useMemo } from 'react';
import { useCBSE10ScienceStore } from '@/stores/useCBSE10ScienceStore';
import type { CBSE10ScienceDomain } from '@/types/cbse10-science';
import { Layers, ArrowLeft, Loader2, Play } from 'lucide-react';

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

const COUNTS = [10, 15, 20, 30];

interface FilterChapter { name: string; subtopics: string[] }
interface FilterDomain { id: string; chapters: FilterChapter[] }

export default function FlashcardConfig() {
  const { goToStudyModeSelect, startFlashcards } = useCBSE10ScienceStore();
  const [selectedDomains, setSelectedDomains] = useState<CBSE10ScienceDomain[]>([]);
  const [selectedChapters, setSelectedChapters] = useState<string[]>([]);
  const [count, setCount] = useState(15);
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

  const toggleDomain = (id: CBSE10ScienceDomain) => {
    setSelectedDomains((prev) => prev.includes(id) ? prev.filter((d) => d !== id) : [...prev, id]);
    setSelectedChapters([]);
  };

  const toggleChapter = (name: string) =>
    setSelectedChapters((prev) => prev.includes(name) ? prev.filter((c) => c !== name) : [...prev, name]);

  const handleStart = async () => {
    setLoading(true);
    setError(null);
    try {
      await startFlashcards({
        domains: selectedDomains,
        chapters: selectedChapters,
        cardCount: count,
      });
    } catch {
      setError('No cards found for these filters. Try broader options.');
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="w-full max-w-lg">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center gap-2">
            <div className="w-10 h-10 rounded-lg bg-violet-600 flex items-center justify-center text-white">
              <Layers className="w-5 h-5" />
            </div>
            <div>
              <h1 className="text-xl font-bold text-gray-900">Flashcard Study</h1>
              <p className="text-sm text-gray-500">CBSE 10 Science</p>
            </div>
          </div>
          <button
            onClick={goToStudyModeSelect}
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
                      active ? 'border-violet-500 bg-violet-600 text-white' : 'border-gray-200 text-gray-500 hover:border-gray-300'
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
                        active ? 'border-violet-400 bg-violet-50 text-violet-700' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                      }`}
                    >
                      {ch.name}
                    </button>
                  );
                })}
              </div>
            </div>
          )}

          {/* Card count */}
          <div>
            <label className="text-sm font-semibold text-gray-700 mb-2 block">Cards in this session</label>
            <div className="flex gap-2">
              {COUNTS.map((c) => (
                <button key={c} onClick={() => setCount(c)}
                  className={`flex-1 py-2 rounded-lg text-sm font-semibold border-2 transition-all ${
                    count === c ? 'border-violet-500 bg-violet-600 text-white' : 'border-gray-200 text-gray-500 hover:border-gray-300'
                  }`}
                >
                  {c}
                </button>
              ))}
            </div>
          </div>

          <div className="text-xs text-gray-500 bg-violet-50 rounded-lg px-4 py-2.5">
            Tap a card to flip it. Mark each card as <strong>Know It</strong> or <strong>Review Again</strong> to track your progress.
          </div>

          {error && <p className="text-sm text-red-600 bg-red-50 rounded-lg p-3">{error}</p>}

          <button
            onClick={handleStart}
            disabled={loading}
            className="w-full py-3 text-white font-semibold rounded-lg bg-violet-600 hover:bg-violet-700 disabled:opacity-60 transition-all text-lg inline-flex items-center justify-center gap-2"
          >
            {loading
              ? (<><Loader2 className="w-5 h-5 animate-spin" />Loading Cards...</>)
              : (<><Play className="w-5 h-5" />Start Flashcards</>)}
          </button>
        </div>
      </div>
    </div>
  );
}

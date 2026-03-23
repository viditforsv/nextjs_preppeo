'use client';

import { useState, useMemo } from 'react';
import type { GREQuestionResponse } from '@/types/gre-test';
import {
  CheckCircle,
  XCircle,
  MinusCircle,
  Flag,
  ChevronDown,
  ChevronUp,
  Clock,
  Eye,
} from 'lucide-react';

const DIFF_LABELS: Record<string, string> = {
  easy: 'Easy',
  medium: 'Medium',
  hard: 'Hard',
};

const TYPE_LABELS: Record<string, string> = {
  'single-choice': 'Single Choice',
  'multi-select': 'Multi-Select',
  'numeric-entry': 'Numeric Entry',
  'quantitative-comparison': 'Quant Comparison',
};

type FilterType = 'all' | 'correct' | 'incorrect' | 'omitted' | 'flagged';
type SectionFilterType = 'all' | '1' | '2';

interface Props {
  responses: GREQuestionResponse[];
}

export default function QuestionReviewTab({ responses }: Props) {
  const [filter, setFilter] = useState<FilterType>('all');
  const [sectionFilter, setSectionFilter] = useState<SectionFilterType>('all');
  const [expandedId, setExpandedId] = useState<string | null>(null);

  const hasS1 = responses.some((r) => r.sectionNumber === 1);
  const hasS2 = responses.some((r) => r.sectionNumber === 2);

  const sectionFiltered = useMemo(() => {
    if (sectionFilter === 'all') return responses;
    return responses.filter((r) => r.sectionNumber === Number(sectionFilter));
  }, [responses, sectionFilter]);

  const filtered = useMemo(() => {
    switch (filter) {
      case 'correct': return sectionFiltered.filter((r) => r.isCorrect);
      case 'incorrect': return sectionFiltered.filter((r) => !r.isCorrect && !r.isOmitted);
      case 'omitted': return sectionFiltered.filter((r) => r.isOmitted);
      case 'flagged': return sectionFiltered.filter((r) => r.isFlagged);
      default: return sectionFiltered;
    }
  }, [filter, sectionFiltered]);

  const counts = useMemo(() => ({
    all: sectionFiltered.length,
    correct: sectionFiltered.filter((r) => r.isCorrect).length,
    incorrect: sectionFiltered.filter((r) => !r.isCorrect && !r.isOmitted).length,
    omitted: sectionFiltered.filter((r) => r.isOmitted).length,
    flagged: sectionFiltered.filter((r) => r.isFlagged).length,
  }), [sectionFiltered]);

  const FILTERS: { id: FilterType; label: string; count: number }[] = [
    { id: 'all', label: 'All', count: counts.all },
    { id: 'correct', label: 'Correct', count: counts.correct },
    { id: 'incorrect', label: 'Incorrect', count: counts.incorrect },
    { id: 'omitted', label: 'Omitted', count: counts.omitted },
    { id: 'flagged', label: 'Flagged', count: counts.flagged },
  ];

  return (
    <div className="space-y-4">
      {hasS1 && hasS2 && (
        <div className="flex gap-2">
          {(['all', '1', '2'] as const).map((f) => (
            <button
              key={f}
              onClick={() => { setSectionFilter(f); setFilter('all'); }}
              className={`text-xs font-medium px-3 py-1.5 rounded-full border transition-colors ${
                sectionFilter === f
                  ? 'bg-[#1a365d] text-white border-[#1a365d]'
                  : 'bg-white text-gray-600 border-gray-300 hover:border-gray-400'
              }`}
            >
              {f === 'all' ? 'All Sections' : `Section ${f}`}
            </button>
          ))}
        </div>
      )}

      <div className="flex flex-wrap gap-2">
        {FILTERS.map((f) => (
          <button
            key={f.id}
            onClick={() => setFilter(f.id)}
            className={`text-xs font-medium px-3 py-1.5 rounded-full border transition-colors ${
              filter === f.id
                ? 'bg-[#1a365d] text-white border-[#1a365d]'
                : 'bg-white text-gray-600 border-gray-300 hover:border-gray-400'
            }`}
          >
            {f.label} ({f.count})
          </button>
        ))}
      </div>

      {filtered.length === 0 ? (
        <p className="text-gray-500 text-center py-8">No questions match this filter.</p>
      ) : (
        <div className="space-y-2">
          {filtered.map((r, idx) => {
            const isOpen = expandedId === r.questionId;
            const timeSec = Math.round(r.timeSpentMs / 1000);

            return (
              <div key={r.questionId} className="bg-white rounded-xl border border-gray-200 overflow-hidden">
                <button
                  onClick={() => setExpandedId(isOpen ? null : r.questionId)}
                  className="w-full flex items-center gap-3 p-4 text-left hover:bg-gray-50 transition-colors"
                >
                  {r.isOmitted ? (
                    <MinusCircle className="w-5 h-5 shrink-0 text-gray-400" />
                  ) : r.isCorrect ? (
                    <CheckCircle className="w-5 h-5 shrink-0 text-green-500" />
                  ) : (
                    <XCircle className="w-5 h-5 shrink-0 text-red-500" />
                  )}

                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 flex-wrap">
                      <span className="text-sm font-medium text-gray-800">Q{idx + 1}</span>
                      <span className="text-xs px-1.5 py-0.5 rounded bg-gray-100 text-gray-600 font-medium">
                        S{r.sectionNumber}
                      </span>
                      {r.isFlagged && <Flag className="w-3 h-3 text-yellow-500 fill-yellow-500" />}
                    </div>
                  </div>

                  <div className="hidden sm:flex items-center gap-1.5 shrink-0">
                    <span className="text-[10px] px-1.5 py-0.5 rounded bg-blue-50 text-blue-700 font-medium">
                      {TYPE_LABELS[r.questionType] ?? r.questionType}
                    </span>
                    <span className={`text-[10px] px-1.5 py-0.5 rounded font-medium ${
                      r.difficulty === 'easy' ? 'bg-green-50 text-green-700'
                        : r.difficulty === 'medium' ? 'bg-yellow-50 text-yellow-700'
                        : 'bg-red-50 text-red-700'
                    }`}>
                      {DIFF_LABELS[r.difficulty]}
                    </span>
                  </div>

                  <div className="hidden sm:flex items-center gap-3 text-xs text-gray-500 shrink-0">
                    <span className="flex items-center gap-1"><Clock className="w-3 h-3" /> {timeSec}s</span>
                    <span className="flex items-center gap-1"><Eye className="w-3 h-3" /> {r.visitCount}x</span>
                  </div>

                  {isOpen ? (
                    <ChevronUp className="w-4 h-4 text-gray-400 shrink-0" />
                  ) : (
                    <ChevronDown className="w-4 h-4 text-gray-400 shrink-0" />
                  )}
                </button>

                {isOpen && (
                  <div className="border-t border-gray-100 p-4 space-y-3">
                    <div className="flex sm:hidden items-center gap-2 flex-wrap text-xs">
                      <span className="px-1.5 py-0.5 rounded bg-blue-50 text-blue-700 font-medium">
                        {TYPE_LABELS[r.questionType] ?? r.questionType}
                      </span>
                      <span className={`px-1.5 py-0.5 rounded font-medium ${
                        r.difficulty === 'easy' ? 'bg-green-50 text-green-700'
                          : r.difficulty === 'medium' ? 'bg-yellow-50 text-yellow-700'
                          : 'bg-red-50 text-red-700'
                      }`}>
                        {DIFF_LABELS[r.difficulty]}
                      </span>
                      <span className="flex items-center gap-1 text-gray-500">
                        <Clock className="w-3 h-3" /> {timeSec}s
                      </span>
                      <span className="flex items-center gap-1 text-gray-500">
                        <Eye className="w-3 h-3" /> {r.visitCount}x
                      </span>
                    </div>

                    {r.topics.length > 0 && (
                      <div className="flex flex-wrap gap-1">
                        {r.topics.map((t) => (
                          <span key={t} className="text-[10px] px-1.5 py-0.5 rounded bg-gray-100 text-gray-600">
                            {t}
                          </span>
                        ))}
                      </div>
                    )}

                    <div className="text-sm text-gray-600">
                      <span className="font-medium">Your answer: </span>
                      {r.isOmitted ? (
                        <span className="text-gray-400 italic">Omitted</span>
                      ) : (
                        <span className={r.isCorrect ? 'text-green-600 font-medium' : 'text-red-600 font-medium'}>
                          {Array.isArray(r.answer) ? r.answer.join(', ') : r.answer}
                        </span>
                      )}
                    </div>
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}

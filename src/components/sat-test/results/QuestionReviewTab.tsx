'use client';

import { useState, useMemo } from 'react';
import type { SATQuestionResponse } from '@/types/sat-test';
import { renderMixedContent } from '@/components/MathRenderer';
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

const DOMAIN_LABELS: Record<string, string> = {
  algebra: 'Algebra',
  'advanced-math': 'Adv Math',
  'problem-solving': 'PS & Data',
  'geometry-trig': 'Geo & Trig',
  'craft-structure': 'Craft & Struct',
  'information-ideas': 'Info & Ideas',
  'standard-english': 'Std English',
  'expression-of-ideas': 'Expression',
};

const DIFF_LABELS: Record<string, string> = {
  easy: 'Easy',
  medium: 'Medium',
  hard: 'Hard',
};

type FilterType = 'all' | 'correct' | 'incorrect' | 'omitted' | 'flagged';
type SectionFilterType = 'all' | 'rw' | 'math';

interface Props {
  responses: SATQuestionResponse[];
}

function optionLabel(optId: string, options?: { id: string; text: string }[]): string {
  if (!options) return optId;
  const opt = options.find((o) => o.id === optId);
  return opt ? opt.text : optId;
}

export default function QuestionReviewTab({ responses }: Props) {
  const [filter, setFilter] = useState<FilterType>('all');
  const [sectionFilter, setSectionFilter] = useState<SectionFilterType>('all');
  const [expandedId, setExpandedId] = useState<string | null>(null);

  const hasRW = responses.some((r) => r.section === 'rw');
  const hasMath = responses.some((r) => r.section === 'math');

  const sectionFiltered = useMemo(() => {
    if (sectionFilter === 'all') return responses;
    return responses.filter((r) => r.section === sectionFilter);
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
      {hasRW && hasMath && (
        <div className="flex gap-2">
          {(['all', 'rw', 'math'] as const).map((f) => (
            <button
              key={f}
              onClick={() => { setSectionFilter(f); setFilter('all'); }}
              className={`text-xs font-medium px-3 py-1.5 rounded-full border transition-colors ${
                sectionFilter === f
                  ? 'bg-[#0d47a1] text-white border-[#0d47a1]'
                  : 'bg-white text-gray-600 border-gray-300 hover:border-gray-400'
              }`}
            >
              {f === 'all' ? 'All Sections' : f === 'rw' ? 'R&W' : 'Math'}
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
                ? 'bg-[#0d47a1] text-white border-[#0d47a1]'
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
            const sectionTag = r.section === 'rw' ? 'R&W' : 'Math';
            const hasContent = !!r.prompt;

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
                        {sectionTag}
                      </span>
                      {r.isFlagged && <Flag className="w-3 h-3 text-yellow-500 fill-yellow-500" />}
                    </div>
                    {hasContent && (
                      <p className="text-xs text-gray-500 mt-0.5 truncate max-w-md">
                        {r.prompt!.slice(0, 80)}{r.prompt!.length > 80 ? '...' : ''}
                      </p>
                    )}
                  </div>

                  <div className="hidden sm:flex items-center gap-1.5 shrink-0">
                    {r.domain && (
                      <span className="text-[10px] px-1.5 py-0.5 rounded bg-blue-50 text-blue-700 font-medium">
                        {DOMAIN_LABELS[r.domain] ?? r.domain}
                      </span>
                    )}
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
                  <div className="border-t border-gray-100 p-4 space-y-4">
                    <div className="flex sm:hidden items-center gap-2 flex-wrap text-xs">
                      {r.domain && (
                        <span className="px-1.5 py-0.5 rounded bg-blue-50 text-blue-700 font-medium">
                          {DOMAIN_LABELS[r.domain] ?? r.domain}
                        </span>
                      )}
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

                    {/* Passage */}
                    {r.passage && (
                      <div className="bg-amber-50 border border-amber-200 rounded-lg p-3">
                        <p className="text-xs font-semibold text-amber-700 mb-1">Passage</p>
                        <div className="text-sm text-gray-700 leading-relaxed whitespace-pre-line">
                          {renderMixedContent(r.passage)}
                        </div>
                      </div>
                    )}

                    {/* Question prompt */}
                    {r.prompt && (
                      <div className="bg-gray-50 rounded-lg p-3 text-sm text-gray-800 leading-relaxed">
                        {renderMixedContent(r.prompt)}
                      </div>
                    )}

                    {/* Image */}
                    {r.imageUrl && (
                      <div className="flex justify-center">
                        {/* eslint-disable-next-line @next/next/no-img-element */}
                        <img src={r.imageUrl} alt="Question figure" className="max-h-48 rounded-lg border border-gray-200" />
                      </div>
                    )}

                    {/* Options with correct/user highlights */}
                    {r.options && r.options.length > 0 && (
                      <div className="space-y-1.5">
                        {r.options.map((opt) => {
                          const isCorrectOpt = r.correctAnswer === opt.id;
                          const isUserOpt = r.answer === opt.id;

                          let borderClass = 'border-gray-200';
                          let bgClass = 'bg-white';
                          if (isCorrectOpt) {
                            borderClass = 'border-green-400';
                            bgClass = 'bg-green-50';
                          }
                          if (isUserOpt && !isCorrectOpt) {
                            borderClass = 'border-red-400';
                            bgClass = 'bg-red-50';
                          }

                          return (
                            <div key={opt.id} className={`flex items-start gap-2 p-2.5 rounded-lg border text-sm ${borderClass} ${bgClass}`}>
                              <span className="font-medium text-gray-500 shrink-0 w-5 text-center">
                                {opt.id.toUpperCase()}
                              </span>
                              <span className="text-gray-800 flex-1">{renderMixedContent(opt.text)}</span>
                              {isCorrectOpt && <CheckCircle className="w-4 h-4 text-green-500 shrink-0 mt-0.5" />}
                              {isUserOpt && !isCorrectOpt && <XCircle className="w-4 h-4 text-red-500 shrink-0 mt-0.5" />}
                            </div>
                          );
                        })}
                      </div>
                    )}

                    {/* Answer summary for SPR (student-produced response) */}
                    {r.questionType === 'spr' && (
                      <div className="flex gap-4 text-sm">
                        <div>
                          <span className="text-gray-500">Your answer: </span>
                          {r.isOmitted ? (
                            <span className="text-gray-400 italic">Omitted</span>
                          ) : (
                            <span className={r.isCorrect ? 'text-green-600 font-medium' : 'text-red-600 font-medium'}>
                              {r.answer}
                            </span>
                          )}
                        </div>
                        <div>
                          <span className="text-gray-500">Correct answer: </span>
                          <span className="text-green-600 font-medium">
                            {optionLabel(r.correctAnswer ?? '', r.options)}
                          </span>
                        </div>
                      </div>
                    )}

                    {/* Explanation */}
                    {r.explanation && (
                      <div className="bg-emerald-50 border border-emerald-200 rounded-lg p-3">
                        <p className="text-xs font-semibold text-emerald-700 mb-1">Explanation</p>
                        <div className="text-sm text-gray-700 leading-relaxed">
                          {renderMixedContent(r.explanation)}
                        </div>
                      </div>
                    )}
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

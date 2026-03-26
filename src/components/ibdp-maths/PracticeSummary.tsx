'use client';

import { useState } from 'react';
import { renderMixedContent } from '@/components/MathRenderer';
import { BarChart3, CheckCircle, XCircle, ChevronDown, ChevronUp, RotateCcw, ArrowLeft, Sparkles, MinusCircle } from 'lucide-react';
import { IBDP_DOMAIN_LABELS } from '@/lib/ibdp-maths-courses';
import type { IBDPMathsCourseConfig } from '@/types/ibdp-maths';
import type { IBDPMathsState } from '@/stores/useIBDPMathsStore';

interface Props {
  config: IBDPMathsCourseConfig;
  useStore: () => IBDPMathsState;
}

export default function PracticeSummary({ config, useStore }: Props) {
  const { practiceQuestions, practiceAnswers, practiceRevealed, practiceExplanations, goToLanding, goToPracticeConfig } = useStore();
  const [expandedId, setExpandedId] = useState<string | null>(null);

  const total = practiceQuestions.length;
  const results = practiceQuestions.map((q) => {
    const ans = practiceAnswers[q.id] ?? null;
    const revealed = !!practiceRevealed[q.id];
    const isCorrect = revealed && ans !== null && ans.trim().toLowerCase() === q.correctAnswer.trim().toLowerCase();
    const isOmitted = !revealed || ans === null || ans === '';
    return { question: q, answer: ans, isCorrect, isOmitted, revealed };
  });

  const correct = results.filter((r) => r.isCorrect).length;
  const incorrect = results.filter((r) => r.revealed && !r.isCorrect && !r.isOmitted).length;
  const unanswered = results.filter((r) => r.isOmitted).length;
  const pct = total > 0 ? Math.round((correct / total) * 100) : 0;

  const domainMap = new Map<string, { correct: number; total: number }>();
  for (const r of results) {
    const d = r.question.domain ?? 'unknown';
    if (!domainMap.has(d)) domainMap.set(d, { correct: 0, total: 0 });
    const entry = domainMap.get(d)!;
    entry.total++;
    if (r.isCorrect) entry.correct++;
  }

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="text-white px-4 py-4" style={{ backgroundColor: config.accentColor }}>
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <BarChart3 className="w-5 h-5" />
            <h1 className="text-lg font-bold">Practice Summary</h1>
          </div>
          <div className="flex items-center gap-2">
            <button
              onClick={goToPracticeConfig}
              className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
            >
              <RotateCcw className="w-3.5 h-3.5" /> Practice Again
            </button>
            <button onClick={goToLanding}
              className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
            >
              <ArrowLeft className="w-3.5 h-3.5" /> Back
            </button>
          </div>
        </div>
      </div>

      <div className="max-w-4xl mx-auto p-4 space-y-4">
        <div className="bg-white rounded-xl border border-gray-200 p-6">
          <div className="text-center mb-6">
            <p className="text-sm text-gray-500 mb-1">{config.title} Practice</p>
            <p className="text-5xl font-bold" style={{ color: config.accentColor }}>{pct}%</p>
            <p className="text-gray-500 mt-1">{correct} of {total} correct</p>
          </div>
          <div className="grid grid-cols-3 gap-4 text-center">
            <div className="bg-green-50 rounded-lg p-3">
              <div className="flex items-center justify-center gap-1 mb-1"><CheckCircle className="w-4 h-4 text-green-600" /></div>
              <p className="text-lg font-bold text-green-700">{correct}</p>
              <p className="text-xs text-green-600">Correct</p>
            </div>
            <div className="bg-red-50 rounded-lg p-3">
              <div className="flex items-center justify-center gap-1 mb-1"><XCircle className="w-4 h-4 text-red-600" /></div>
              <p className="text-lg font-bold text-red-700">{incorrect}</p>
              <p className="text-xs text-red-600">Incorrect</p>
            </div>
            <div className="bg-gray-50 rounded-lg p-3">
              <div className="flex items-center justify-center gap-1 mb-1"><MinusCircle className="w-4 h-4 text-gray-400" /></div>
              <p className="text-lg font-bold text-gray-600">{unanswered}</p>
              <p className="text-xs text-gray-500">Skipped</p>
            </div>
          </div>
        </div>

        {domainMap.size > 1 && (
          <div className="bg-white rounded-xl border border-gray-200 p-6">
            <h3 className="text-sm font-semibold text-gray-700 mb-3">Topic Breakdown</h3>
            <div className="space-y-3">
              {[...domainMap.entries()].map(([domain, stats]) => {
                const domPct = stats.total > 0 ? Math.round((stats.correct / stats.total) * 100) : 0;
                return (
                  <div key={domain}>
                    <div className="flex items-center justify-between text-sm mb-1">
                      <span className="text-gray-600">{IBDP_DOMAIN_LABELS[domain as keyof typeof IBDP_DOMAIN_LABELS] ?? domain}</span>
                      <span className="font-semibold text-gray-800">{stats.correct}/{stats.total}</span>
                    </div>
                    <div className="w-full bg-gray-100 rounded-full h-2">
                      <div className="h-2 rounded-full transition-all" style={{ width: `${domPct}%`, backgroundColor: config.accentColor }} />
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        )}

        <div className="bg-white rounded-xl border border-gray-200 p-6">
          <h3 className="text-sm font-semibold text-gray-700 mb-4">Question Review</h3>
          <div className="space-y-2">
            {results.map((r, idx) => {
              const isExpanded = expandedId === r.question.id;
              return (
                <div key={r.question.id} className="border border-gray-200 rounded-lg overflow-hidden">
                  <button onClick={() => setExpandedId(isExpanded ? null : r.question.id)}
                    className="w-full flex items-center gap-3 p-3 text-left hover:bg-gray-50 transition-colors"
                  >
                    <span className={`w-6 h-6 rounded-full flex items-center justify-center shrink-0 ${
                      r.isOmitted ? 'bg-gray-100 text-gray-400' : r.isCorrect ? 'bg-green-100 text-green-600' : 'bg-red-100 text-red-600'
                    }`}>
                      {r.isOmitted ? <MinusCircle className="w-3.5 h-3.5" /> : r.isCorrect ? <CheckCircle className="w-3.5 h-3.5" /> : <XCircle className="w-3.5 h-3.5" />}
                    </span>
                    <span className="flex-1 text-sm text-gray-700 truncate">Q{idx + 1}: {r.question.prompt.substring(0, 80)}...</span>
                    {isExpanded ? <ChevronUp className="w-4 h-4 text-gray-400 shrink-0" /> : <ChevronDown className="w-4 h-4 text-gray-400 shrink-0" />}
                  </button>

                  {isExpanded && (
                    <div className="px-4 pb-4 border-t border-gray-100">
                      <div className="mt-3 text-sm text-gray-700 leading-relaxed">{renderMixedContent(r.question.prompt)}</div>
                      {r.question.options && (
                        <div className="mt-3 space-y-1">
                          {r.question.options.map((opt) => (
                            <div key={opt.id} className={`text-sm px-3 py-1.5 rounded ${
                              opt.id === r.question.correctAnswer ? 'bg-green-50 text-green-700 font-medium'
                                : opt.id === r.answer && opt.id !== r.question.correctAnswer ? 'bg-red-50 text-red-700'
                                : 'text-gray-600'
                            }`}>
                              <strong>{opt.id})</strong> {opt.text}
                              {opt.id === r.question.correctAnswer && ' ✓'}
                              {opt.id === r.answer && opt.id !== r.question.correctAnswer && ' (your answer)'}
                            </div>
                          ))}
                        </div>
                      )}
                      {practiceExplanations[r.question.id] && (
                        <div className="mt-3 p-3 bg-amber-50 border border-amber-200 rounded-lg">
                          <div className="flex items-center gap-1.5 mb-2">
                            <Sparkles className="w-3.5 h-3.5 text-amber-500" />
                            <span className="text-xs font-semibold text-amber-700">AI Explanation</span>
                          </div>
                          <div className="text-sm text-amber-900 leading-relaxed whitespace-pre-line">
                            {renderMixedContent(practiceExplanations[r.question.id] ?? '')}
                          </div>
                        </div>
                      )}
                      {!practiceExplanations[r.question.id] && r.question.explanation && (
                        <div className="mt-3 p-3 bg-gray-50 rounded-lg">
                          <p className="text-xs font-semibold text-gray-500 mb-1">Explanation</p>
                          <div className="text-sm text-gray-700 leading-relaxed">{renderMixedContent(r.question.explanation ?? '')}</div>
                        </div>
                      )}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </div>
  );
}

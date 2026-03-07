'use client';

import { useState } from 'react';
import { useGRETestStore } from '@/stores/useGRETestStore';
import QuestionRenderer from './question-types/QuestionRenderer';
import {
  BarChart3,
  CheckCircle,
  XCircle,
  ChevronDown,
  ChevronUp,
  RotateCcw,
} from 'lucide-react';

export default function PracticeSummary() {
  const { practiceQuestions, practiceAnswers, goToLanding } = useGRETestStore();
  const [expandedQ, setExpandedQ] = useState<string | null>(null);

  const questions = practiceQuestions;

  let correctCount = 0;
  questions.forEach((q) => {
    const a = practiceAnswers[q.id];
    if (!a) return;
    const correct = q.correctAnswer;
    if (Array.isArray(correct)) {
      if (!Array.isArray(a)) return;
      const sa = [...a].sort();
      const sc = [...correct].sort();
      if (sa.length === sc.length && sa.every((v, i) => v === sc[i])) correctCount++;
    } else {
      if (String(a) === String(correct)) correctCount++;
    }
  });

  const total = questions.length;
  const pct = total > 0 ? Math.round((correctCount / total) * 100) : 0;

  return (
    <div className="min-h-screen bg-[#f5f5f0] p-4">
      <div className="max-w-3xl mx-auto">
        {/* Header */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6 text-center">
          <div className="flex items-center justify-center gap-2 mb-2">
            <BarChart3 className="w-6 h-6 text-emerald-600" />
            <h1 className="text-2xl font-bold text-gray-900">Practice Summary</h1>
          </div>
          <div
            className={`inline-block text-5xl font-bold mb-2 ${
              pct >= 70 ? 'text-green-600' : pct >= 40 ? 'text-yellow-600' : 'text-red-600'
            }`}
          >
            {pct}%
          </div>
          <p className="text-gray-500">
            {correctCount} of {total} questions correct
          </p>
        </div>

        {/* Question review */}
        <div className="bg-white rounded-xl border border-gray-200 overflow-hidden mb-6">
          <div className="divide-y divide-gray-100">
            {questions.map((q, idx) => {
              const answer = practiceAnswers[q.id] ?? null;
              const correct = q.correctAnswer;
              let isRight = false;
              if (answer) {
                if (Array.isArray(correct)) {
                  if (Array.isArray(answer)) {
                    const sa = [...answer].sort();
                    const sc = [...correct].sort();
                    isRight = sa.length === sc.length && sa.every((v, i) => v === sc[i]);
                  }
                } else {
                  isRight = String(answer) === String(correct);
                }
              }

              const isOpen = expandedQ === q.id;

              return (
                <div key={q.id} className="p-4">
                  <button
                    onClick={() => setExpandedQ(isOpen ? null : q.id)}
                    className="w-full flex items-center gap-3 text-left"
                  >
                    {isRight ? (
                      <CheckCircle className="w-5 h-5 shrink-0 text-green-500" />
                    ) : (
                      <XCircle className="w-5 h-5 shrink-0 text-red-500" />
                    )}
                    <span className="text-sm font-medium text-gray-800 flex-1">
                      Q{idx + 1}: {q.prompt.slice(0, 80)}
                      {q.prompt.length > 80 ? '...' : ''}
                    </span>
                    {isOpen ? (
                      <ChevronUp className="w-4 h-4 text-gray-400" />
                    ) : (
                      <ChevronDown className="w-4 h-4 text-gray-400" />
                    )}
                  </button>
                  {isOpen && (
                    <div className="mt-3 ml-8 space-y-3">
                      <QuestionRenderer
                        question={q}
                        answer={answer}
                        onAnswer={() => {}}
                        disabled
                        showCorrect
                      />
                      <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 text-sm text-blue-800">
                        <p className="font-medium mb-1">Explanation:</p>
                        <p>{q.explanation}</p>
                      </div>
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </div>

        <div className="flex justify-center">
          <button
            onClick={goToLanding}
            className="inline-flex items-center gap-2 px-6 py-3 bg-emerald-600 text-white font-semibold rounded-lg hover:bg-emerald-700 transition-colors"
          >
            <RotateCcw className="w-4 h-4" />
            Practice Again
          </button>
        </div>
      </div>
    </div>
  );
}

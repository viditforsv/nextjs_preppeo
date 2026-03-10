'use client';

import { useState } from 'react';
import { useSATTestStore } from '@/stores/useSATTestStore';
import type { SATQuestion, SATModuleResult } from '@/types/sat-test';
import QuestionRenderer from './question-types/QuestionRenderer';
import { renderMixedContent } from '@/components/MathRenderer';
import {
  BarChart3,
  CheckCircle,
  XCircle,
  ChevronDown,
  ChevronUp,
  RotateCcw,
} from 'lucide-react';

function isCorrect(q: SATQuestion, answer: string | null): boolean {
  if (!answer) return false;
  return String(answer).trim().toLowerCase() === String(q.correctAnswer).trim().toLowerCase();
}

function ModuleReview({
  label,
  result,
  questions,
}: {
  label: string;
  result: SATModuleResult;
  questions: SATQuestion[];
}) {
  const [expanded, setExpanded] = useState(false);
  const [expandedQ, setExpandedQ] = useState<string | null>(null);

  const pct = Math.round((result.correct / result.total) * 100);
  const tierLabel =
    result.difficultyTier === 'mixed'
      ? 'Mixed'
      : result.difficultyTier === 'easy'
      ? 'Lower'
      : 'Higher';
  const timeMin = Math.floor(result.timeUsed / 60);
  const timeSec = result.timeUsed % 60;

  return (
    <div className="border border-gray-200 rounded-xl overflow-hidden">
      <button
        onClick={() => setExpanded(!expanded)}
        className="w-full flex items-center justify-between p-4 bg-gray-50 hover:bg-gray-100 transition-colors"
      >
        <div className="flex items-center gap-3">
          <div
            className={`w-12 h-12 rounded-lg flex items-center justify-center text-white font-bold text-lg ${
              pct >= 70 ? 'bg-green-500' : pct >= 40 ? 'bg-yellow-500' : 'bg-red-500'
            }`}
          >
            {pct}%
          </div>
          <div className="text-left">
            <p className="font-semibold text-gray-900">{label}</p>
            <p className="text-sm text-gray-500">
              {result.correct}/{result.total} correct · {tierLabel} · {timeMin}m {timeSec}s used
            </p>
          </div>
        </div>
        {expanded ? (
          <ChevronUp className="w-5 h-5 text-gray-400" />
        ) : (
          <ChevronDown className="w-5 h-5 text-gray-400" />
        )}
      </button>

      {expanded && (
        <div className="divide-y divide-gray-100">
          {questions.map((q, idx) => {
            const answer = result.answers[q.id] ?? null;
            const correct = isCorrect(q, answer);
            const isOpen = expandedQ === q.id;

            return (
              <div key={q.id} className="p-4">
                <button
                  onClick={() => setExpandedQ(isOpen ? null : q.id)}
                  className="w-full flex items-center gap-3 text-left"
                >
                  {correct ? (
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
                    {q.explanation && (
                      <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 text-sm text-blue-800">
                        <p className="font-medium mb-1">Explanation:</p>
                        <div>{renderMixedContent(q.explanation)}</div>
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

export default function ResultsScreen() {
  const { module1, module2, module1Result, module2Result, goToLanding } =
    useSATTestStore();

  if (!module1Result) return null;

  const total1 = module1Result.correct;
  const total2 = module2Result?.correct ?? 0;
  const totalCorrect = total1 + total2;
  const totalQuestions = module1Result.total + (module2Result?.total ?? 0);
  const overallPct = Math.round((totalCorrect / totalQuestions) * 100);

  return (
    <div className="min-h-screen bg-[#f5f5f0] p-4">
      <div className="max-w-3xl mx-auto">
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6 text-center">
          <div className="flex items-center justify-center gap-2 mb-2">
            <BarChart3 className="w-6 h-6 text-[#0d47a1]" />
            <h1 className="text-2xl font-bold text-gray-900">SAT Math Results</h1>
          </div>
          <div
            className={`inline-block text-5xl font-bold mb-2 ${
              overallPct >= 70
                ? 'text-green-600'
                : overallPct >= 40
                ? 'text-yellow-600'
                : 'text-red-600'
            }`}
          >
            {overallPct}%
          </div>
          <p className="text-gray-500">
            {totalCorrect} of {totalQuestions} questions correct
          </p>
        </div>

        <div className="space-y-4 mb-8">
          {module1 && (
            <ModuleReview
              label="Module 1 — Mixed Difficulty"
              result={module1Result}
              questions={module1.questions}
            />
          )}
          {module2 && module2Result && (
            <ModuleReview
              label={`Module 2 — ${
                module2Result.difficultyTier === 'hard' ? 'Higher' : 'Lower'
              } Difficulty`}
              result={module2Result}
              questions={module2.questions}
            />
          )}
        </div>

        <div className="flex justify-center">
          <button
            onClick={goToLanding}
            className="inline-flex items-center gap-2 px-6 py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] transition-colors"
          >
            <RotateCcw className="w-4 h-4" />
            Take Another Test
          </button>
        </div>
      </div>
    </div>
  );
}

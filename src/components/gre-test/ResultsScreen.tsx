'use client';

import { useState } from 'react';
import { useGRETestStore } from '@/stores/useGRETestStore';
import { GREQuestion, SectionResult } from '@/types/gre-test';
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

function isCorrect(q: GREQuestion, answer: string | string[] | null): boolean {
  if (!answer) return false;
  const correct = q.correctAnswer;
  if (Array.isArray(correct)) {
    if (!Array.isArray(answer)) return false;
    const a = [...answer].sort();
    const c = [...correct].sort();
    return a.length === c.length && a.every((v, i) => v === c[i]);
  }
  return String(answer) === String(correct);
}

function SectionReview({
  label,
  result,
  questions,
}: {
  label: string;
  result: SectionResult;
  questions: GREQuestion[];
}) {
  const [expanded, setExpanded] = useState(false);
  const [expandedQ, setExpandedQ] = useState<string | null>(null);

  const pct = Math.round((result.correct / result.total) * 100);
  const tierLabel =
    result.difficultyTier === 'easy'
      ? 'Easy'
      : result.difficultyTier === 'medium'
      ? 'Medium'
      : 'Hard';
  const timeMin = Math.floor(result.timeUsed / 60);
  const timeSec = result.timeUsed % 60;

  return (
    <div className="border border-gray-200 rounded-xl overflow-hidden">
      {/* Section header */}
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

      {/* Questions detail */}
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
                    <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 text-sm text-blue-800">
                      <p className="font-medium mb-1">Explanation:</p>
                      <div>{renderMixedContent(q.explanation)}</div>
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

export default function ResultsScreen() {
  const { section1, section2, section1Result, section2Result, goToLanding } =
    useGRETestStore();

  if (!section1Result) return null;

  const total1 = section1Result.correct;
  const total2 = section2Result?.correct ?? 0;
  const totalCorrect = total1 + total2;
  const totalQuestions = section1Result.total + (section2Result?.total ?? 0);
  const overallPct = Math.round((totalCorrect / totalQuestions) * 100);

  return (
    <div className="min-h-screen bg-[#f5f5f0] p-4">
      <div className="max-w-3xl mx-auto">
        {/* Header */}
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6 text-center">
          <div className="flex items-center justify-center gap-2 mb-2">
            <BarChart3 className="w-6 h-6 text-[#1a365d]" />
            <h1 className="text-2xl font-bold text-gray-900">Test Results</h1>
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

        {/* Section results */}
        <div className="space-y-4 mb-8">
          {section1 && (
            <SectionReview
              label="Section 1 — Medium"
              result={section1Result}
              questions={section1.questions}
            />
          )}
          {section2 && section2Result && (
            <SectionReview
              label={`Section 2 — ${
                section2Result.difficultyTier.charAt(0).toUpperCase() +
                section2Result.difficultyTier.slice(1)
              }`}
              result={section2Result}
              questions={section2.questions}
            />
          )}
        </div>

        {/* Actions */}
        <div className="flex justify-center">
          <button
            onClick={goToLanding}
            className="inline-flex items-center gap-2 px-6 py-3 bg-[#1a365d] text-white font-semibold rounded-lg hover:bg-[#2a4a7f] transition-colors"
          >
            <RotateCcw className="w-4 h-4" />
            Take Another Test
          </button>
        </div>
      </div>
    </div>
  );
}

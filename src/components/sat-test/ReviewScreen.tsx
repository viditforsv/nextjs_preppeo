'use client';

import type { SATQuestion } from '@/types/sat-test';
import { Flag, CheckCircle, Circle, X } from 'lucide-react';

interface Props {
  questions: SATQuestion[];
  answers: Record<string, string | null>;
  flags: Record<string, boolean>;
  currentIndex: number;
  onNavigate: (idx: number) => void;
  onClose: () => void;
  onSubmit: () => void;
}

function isAnswered(answer: string | null | undefined): boolean {
  return answer !== null && answer !== undefined && answer !== '';
}

export default function ReviewScreen({
  questions,
  answers,
  flags,
  currentIndex,
  onNavigate,
  onClose,
  onSubmit,
}: Props) {
  const answeredCount = questions.filter((q) => isAnswered(answers[q.id])).length;
  const flaggedCount = questions.filter((q) => flags[q.id]).length;
  const unanswered = questions.length - answeredCount;

  return (
    <div className="fixed inset-0 z-40 bg-black/50 flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-2xl w-full max-w-2xl max-h-[85vh] overflow-hidden flex flex-col">
        <div className="flex items-center justify-between px-6 py-4 border-b">
          <h2 className="text-lg font-bold text-gray-900">Review Questions</h2>
          <button onClick={onClose} className="p-1 hover:bg-gray-100 rounded">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="flex items-center gap-6 px-6 py-3 bg-gray-50 text-sm">
          <div className="flex items-center gap-1.5">
            <CheckCircle className="w-4 h-4 text-green-600" />
            <span className="text-gray-700">Answered: {answeredCount}</span>
          </div>
          <div className="flex items-center gap-1.5">
            <Circle className="w-4 h-4 text-gray-400" />
            <span className="text-gray-700">Unanswered: {unanswered}</span>
          </div>
          <div className="flex items-center gap-1.5">
            <Flag className="w-4 h-4 text-yellow-500 fill-yellow-500" />
            <span className="text-gray-700">Flagged: {flaggedCount}</span>
          </div>
        </div>

        <div className="flex-1 overflow-y-auto p-6">
          <div className="grid grid-cols-6 sm:grid-cols-8 gap-2">
            {questions.map((q, idx) => {
              const answered = isAnswered(answers[q.id]);
              const flagged = flags[q.id];
              const isCurrent = idx === currentIndex;

              return (
                <button
                  key={q.id}
                  onClick={() => onNavigate(idx)}
                  className={`relative w-full aspect-square rounded-lg border-2 flex items-center justify-center text-sm font-semibold transition-all hover:scale-105 ${
                    isCurrent
                      ? 'border-blue-500 bg-blue-100 text-blue-700 ring-2 ring-blue-300'
                      : answered
                      ? 'border-green-400 bg-green-50 text-green-700'
                      : 'border-gray-300 bg-white text-gray-600 hover:border-gray-400'
                  }`}
                >
                  {idx + 1}
                  {flagged && (
                    <Flag className="absolute -top-1 -right-1 w-3.5 h-3.5 text-yellow-500 fill-yellow-500" />
                  )}
                </button>
              );
            })}
          </div>
        </div>

        <div className="flex items-center justify-between px-6 py-4 border-t bg-gray-50">
          <button
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50"
          >
            Return to Question
          </button>
          <button
            onClick={onSubmit}
            className="px-6 py-2 text-sm font-semibold text-white bg-[#0d47a1] rounded-lg hover:bg-[#1565c0] transition-colors"
          >
            Submit Module
          </button>
        </div>
      </div>
    </div>
  );
}

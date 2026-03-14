'use client';

import { AshokaQuestion } from '@/types/ashoka-test';
import { X, Flag } from 'lucide-react';

interface ReviewScreenProps {
  questions: AshokaQuestion[];
  answers: Record<string, string | null>;
  flags: Record<string, boolean>;
  currentIndex: number;
  onNavigate: (idx: number) => void;
  onClose: () => void;
  onSubmit: () => void;
}

export default function ReviewScreen({
  questions,
  answers,
  flags,
  currentIndex,
  onNavigate,
  onClose,
  onSubmit,
}: ReviewScreenProps) {
  const answered = questions.filter((q) => answers[q.id]).length;
  const flagged = questions.filter((q) => flags[q.id]).length;

  return (
    <div className="fixed inset-0 z-40 bg-black/50 flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-2xl max-w-lg w-full max-h-[80vh] flex flex-col">
        <div className="flex items-center justify-between px-6 py-4 border-b">
          <h3 className="text-lg font-bold text-gray-900">Review Questions</h3>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-600">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="px-6 py-3 border-b bg-gray-50 text-sm text-gray-600 flex gap-4">
          <span>{answered}/{questions.length} answered</span>
          <span>{flagged} flagged</span>
        </div>

        <div className="flex-1 overflow-y-auto p-6">
          <div className="grid grid-cols-5 gap-2">
            {questions.map((q, idx) => {
              const isAns = !!answers[q.id];
              const isCurr = idx === currentIndex;
              const isFlagged = flags[q.id];

              return (
                <button
                  key={q.id}
                  onClick={() => onNavigate(idx)}
                  className={`relative w-full aspect-square rounded-lg text-sm font-semibold border transition-all flex items-center justify-center ${
                    isCurr
                      ? 'border-blue-500 bg-blue-600 text-white'
                      : isAns
                      ? 'border-green-400 bg-green-100 text-green-700'
                      : isFlagged
                      ? 'border-yellow-400 bg-yellow-50 text-yellow-700'
                      : 'border-gray-300 bg-white text-gray-600 hover:border-gray-400'
                  }`}
                >
                  {idx + 1}
                  {isFlagged && (
                    <Flag className="absolute top-1 right-1 w-3 h-3 text-yellow-500 fill-yellow-500" />
                  )}
                </button>
              );
            })}
          </div>
        </div>

        <div className="px-6 py-4 border-t flex justify-end gap-3">
          <button
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-gray-700 border border-gray-300 rounded-lg hover:bg-gray-50"
          >
            Back to Mock
          </button>
          <button
            onClick={onSubmit}
            className="px-5 py-2 text-sm font-semibold text-white bg-[#1a365d] rounded-lg hover:bg-[#2a4a7f]"
          >
            Submit All
          </button>
        </div>
      </div>
    </div>
  );
}

'use client';

import type { SATQuestion } from '@/types/sat-test';

interface Props {
  question: SATQuestion;
  value: string;
  onAnswer: (value: string) => void;
  disabled?: boolean;
  showCorrect?: boolean;
}

export default function SPRQuestion({
  question,
  value,
  onAnswer,
  disabled,
  showCorrect,
}: Props) {
  const isCorrect =
    showCorrect &&
    String(value).trim().toLowerCase() === String(question.correctAnswer).trim().toLowerCase();
  const isWrong = showCorrect && value !== '' && !isCorrect;

  let borderClass = 'border-gray-300 focus-within:border-blue-500';
  if (isCorrect) borderClass = 'border-green-500 bg-green-50';
  if (isWrong) borderClass = 'border-red-500 bg-red-50';

  return (
    <div className="space-y-3">
      <div
        className={`border-2 rounded-lg p-1 transition-all inline-flex items-center ${borderClass}`}
      >
        <input
          type="text"
          inputMode="decimal"
          value={value}
          onChange={(e) => onAnswer(e.target.value)}
          disabled={disabled}
          placeholder="Enter your answer"
          className="w-56 px-4 py-3 text-lg font-mono outline-none bg-transparent"
        />
      </div>
      <p className="text-sm text-gray-500">
        Enter your answer as a number, decimal, or fraction (e.g. 3/4).
      </p>
      {showCorrect && (
        <p className={`text-sm font-medium ${isCorrect ? 'text-green-600' : 'text-red-600'}`}>
          Correct answer: {String(question.correctAnswer)}
        </p>
      )}
    </div>
  );
}

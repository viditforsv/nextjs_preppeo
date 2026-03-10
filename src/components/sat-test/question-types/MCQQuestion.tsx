'use client';

import type { SATQuestion } from '@/types/sat-test';
import { renderMixedContent } from '@/components/MathRenderer';

interface Props {
  question: SATQuestion;
  selectedAnswer: string | null;
  onAnswer: (value: string) => void;
  disabled?: boolean;
  showCorrect?: boolean;
}

export default function MCQQuestion({
  question,
  selectedAnswer,
  onAnswer,
  disabled,
  showCorrect,
}: Props) {
  const options = question.options ?? [];

  return (
    <div className="space-y-3">
      {options.map((opt, idx) => {
        const letter = String.fromCharCode(65 + idx);
        const isSelected = selectedAnswer === opt.id;
        const isCorrect = showCorrect && opt.id === question.correctAnswer;
        const isWrong = showCorrect && isSelected && opt.id !== question.correctAnswer;

        let borderClass = 'border-gray-300 hover:border-gray-400';
        if (isSelected && !showCorrect) borderClass = 'border-blue-600 bg-blue-50';
        if (isCorrect) borderClass = 'border-green-500 bg-green-50';
        if (isWrong) borderClass = 'border-red-500 bg-red-50';

        return (
          <label
            key={opt.id}
            className={`flex items-center gap-3 p-3.5 border-2 rounded-lg cursor-pointer transition-all ${borderClass} ${
              disabled ? 'cursor-default opacity-80' : ''
            }`}
          >
            <span
              className={`shrink-0 w-8 h-8 rounded-full border-2 flex items-center justify-center text-sm font-semibold transition-all ${
                isSelected && !showCorrect
                  ? 'border-blue-600 bg-blue-600 text-white'
                  : isCorrect
                  ? 'border-green-500 bg-green-500 text-white'
                  : isWrong
                  ? 'border-red-500 bg-red-500 text-white'
                  : 'border-gray-400 text-gray-600'
              }`}
            >
              {letter}
            </span>
            <input
              type="radio"
              name={`q-${question.id}`}
              value={opt.id}
              checked={isSelected}
              onChange={() => onAnswer(opt.id)}
              disabled={disabled}
              className="sr-only"
            />
            <span className="flex-1 text-gray-800">{renderMixedContent(opt.text)}</span>
          </label>
        );
      })}
    </div>
  );
}

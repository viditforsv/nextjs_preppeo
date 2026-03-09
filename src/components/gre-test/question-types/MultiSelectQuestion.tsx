'use client';

import { GREQuestion } from '@/types/gre-test';
import { renderMixedContent } from '@/components/MathRenderer';

interface Props {
  question: GREQuestion;
  selectedAnswers: string[];
  onAnswer: (value: string[]) => void;
  disabled?: boolean;
  showCorrect?: boolean;
}

export default function MultiSelectQuestion({
  question,
  selectedAnswers,
  onAnswer,
  disabled,
  showCorrect,
}: Props) {
  const options = question.options ?? [];
  const correctSet = new Set(
    Array.isArray(question.correctAnswer) ? question.correctAnswer : [question.correctAnswer]
  );

  const toggle = (optId: string) => {
    if (disabled) return;
    const next = selectedAnswers.includes(optId)
      ? selectedAnswers.filter((id) => id !== optId)
      : [...selectedAnswers, optId];
    onAnswer(next);
  };

  return (
    <div className="space-y-3">
      <p className="text-sm font-medium text-gray-500 italic">
        Select ALL that apply.
      </p>
      {options.map((opt, idx) => {
        const letter = String.fromCharCode(65 + idx);
        const isSelected = selectedAnswers.includes(opt.id);
        const isCorrect = showCorrect && correctSet.has(opt.id);
        const isWrong = showCorrect && isSelected && !correctSet.has(opt.id);

        let borderClass = 'border-gray-300 hover:border-gray-400';
        if (isSelected && !showCorrect) borderClass = 'border-blue-600 bg-blue-50';
        if (isCorrect) borderClass = 'border-green-500 bg-green-50';
        if (isWrong) borderClass = 'border-red-500 bg-red-50';

        return (
          <div
            key={opt.id}
            role="checkbox"
            aria-checked={isSelected}
            tabIndex={0}
            className={`flex items-center gap-3 p-3.5 border-2 rounded-lg cursor-pointer transition-all ${borderClass} ${
              disabled ? 'cursor-default opacity-80' : ''
            }`}
            onClick={() => toggle(opt.id)}
            onKeyDown={(e) => { if (e.key === ' ' || e.key === 'Enter') { e.preventDefault(); toggle(opt.id); } }}
          >
            <span
              className={`shrink-0 w-8 h-8 rounded border-2 flex items-center justify-center text-sm font-semibold transition-all ${
                isSelected && !showCorrect
                  ? 'border-blue-600 bg-blue-600 text-white'
                  : isCorrect
                  ? 'border-green-500 bg-green-500 text-white'
                  : isWrong
                  ? 'border-red-500 bg-red-500 text-white'
                  : 'border-gray-400 text-gray-600'
              }`}
            >
              {isSelected || isCorrect ? '✓' : letter}
            </span>
            <span className="flex-1 text-gray-800">{renderMixedContent(opt.text)}</span>
          </div>
        );
      })}
    </div>
  );
}

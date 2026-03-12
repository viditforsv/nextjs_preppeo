'use client';

import { GREQuestion } from '@/types/gre-test';
import { renderMixedContent } from '@/components/MathRenderer';

interface Props {
  question: GREQuestion;
  selectedAnswer: string | null;
  onAnswer: (value: string) => void;
  disabled?: boolean;
  showCorrect?: boolean;
}

const QC_OPTIONS = [
  { id: 'a', text: 'Quantity A is greater.' },
  { id: 'b', text: 'Quantity B is greater.' },
  { id: 'c', text: 'The two quantities are equal.' },
  { id: 'd', text: 'The relationship cannot be determined from the information given.' },
];

export default function QuantCompQuestion({
  question,
  selectedAnswer,
  onAnswer,
  disabled,
  showCorrect,
}: Props) {
  return (
    <div className="space-y-5">
      {question.quantityInfo && question.quantityInfo !== question.prompt && (
        <div className="bg-gray-50 border border-gray-200 rounded-lg p-4 text-gray-700 text-sm">
          {renderMixedContent(question.quantityInfo)}
        </div>
      )}

      <div className="grid grid-cols-2 gap-4">
        <div className="border-2 border-gray-300 rounded-lg p-5 text-center">
          <p className="text-xs font-semibold text-gray-500 uppercase mb-2">
            Quantity A
          </p>
          <div className="text-lg font-medium text-gray-800">
            {question.quantityA ? renderMixedContent(question.quantityA) : null}
          </div>
        </div>
        <div className="border-2 border-gray-300 rounded-lg p-5 text-center">
          <p className="text-xs font-semibold text-gray-500 uppercase mb-2">
            Quantity B
          </p>
          <div className="text-lg font-medium text-gray-800">
            {question.quantityB ? renderMixedContent(question.quantityB) : null}
          </div>
        </div>
      </div>

      <div className="space-y-2.5">
        {QC_OPTIONS.map((opt, idx) => {
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
              className={`flex items-center gap-3 p-3 border-2 rounded-lg cursor-pointer transition-all ${borderClass} ${
                disabled ? 'cursor-default opacity-80' : ''
              }`}
            >
              <span
                className={`shrink-0 w-7 h-7 rounded-full border-2 flex items-center justify-center text-xs font-semibold ${
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
              <span className="flex-1 text-sm text-gray-800">{opt.text}</span>
            </label>
          );
        })}
      </div>
    </div>
  );
}

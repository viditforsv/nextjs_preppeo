'use client';

import { GREQuestion } from '@/types/gre-test';
import SingleChoiceQuestion from './SingleChoiceQuestion';
import MultiSelectQuestion from './MultiSelectQuestion';
import NumericEntryQuestion from './NumericEntryQuestion';
import QuantCompQuestion from './QuantCompQuestion';

interface Props {
  question: GREQuestion;
  answer: string | string[] | null;
  onAnswer: (value: string | string[]) => void;
  disabled?: boolean;
  showCorrect?: boolean;
}

export default function QuestionRenderer({
  question,
  answer,
  onAnswer,
  disabled,
  showCorrect,
}: Props) {
  const questionBody = (() => {
    switch (question.type) {
    case 'single-choice':
      return (
        <SingleChoiceQuestion
          question={question}
          selectedAnswer={typeof answer === 'string' ? answer : null}
          onAnswer={onAnswer}
          disabled={disabled}
          showCorrect={showCorrect}
        />
      );
    case 'multi-select':
      return (
        <MultiSelectQuestion
          question={question}
          selectedAnswers={Array.isArray(answer) ? answer : []}
          onAnswer={onAnswer}
          disabled={disabled}
          showCorrect={showCorrect}
        />
      );
    case 'numeric-entry':
      return (
        <NumericEntryQuestion
          question={question}
          value={typeof answer === 'string' ? answer : ''}
          onAnswer={onAnswer}
          disabled={disabled}
          showCorrect={showCorrect}
        />
      );
    case 'quantitative-comparison':
      return (
        <QuantCompQuestion
          question={question}
          selectedAnswer={typeof answer === 'string' ? answer : null}
          onAnswer={onAnswer}
          disabled={disabled}
          showCorrect={showCorrect}
        />
      );
    default:
      return <p className="text-red-500">Unknown question type</p>;
  }
  })();

  return (
    <div>
      {question.imageUrl && (
        <div className="mb-4">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={question.imageUrl}
            alt="Question diagram"
            className="max-w-full h-auto rounded-lg border border-gray-200"
            style={{ maxHeight: 400 }}
          />
        </div>
      )}
      {questionBody}
    </div>
  );
}

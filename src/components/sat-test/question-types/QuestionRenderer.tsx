'use client';

import type { SATQuestion } from '@/types/sat-test';
import MCQQuestion from './MCQQuestion';
import SPRQuestion from './SPRQuestion';

interface Props {
  question: SATQuestion;
  answer: string | null;
  onAnswer: (value: string) => void;
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
      case 'mcq':
        return (
          <MCQQuestion
            question={question}
            selectedAnswer={answer}
            onAnswer={onAnswer}
            disabled={disabled}
            showCorrect={showCorrect}
          />
        );
      case 'spr':
        return (
          <SPRQuestion
            question={question}
            value={answer ?? ''}
            onAnswer={onAnswer}
            disabled={disabled}
            showCorrect={showCorrect}
          />
        );
      default:
        return <p className="text-red-500">Unknown question type</p>;
    }
  })();

  return <div>{questionBody}</div>;
}

"use client";

import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/design-system/components/ui/card";
import type { QuizQuestion } from "@/hooks/useQuizSession";

interface QuestionNavigatorProps {
  questions: QuizQuestion[];
  answers: Record<string, string>;
  currentQuestionIndex: number;
  onNavigate: (index: number) => void;
}

export function QuestionNavigator({
  questions,
  answers,
  currentQuestionIndex,
  onNavigate,
}: QuestionNavigatorProps) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-sm">Question Navigator</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="grid grid-cols-5 md:grid-cols-10 gap-2">
          {questions.map((q, index) => (
            <button
              key={q.id}
              className={`p-2 rounded-lg border-2 text-sm font-semibold transition-all ${
                index === currentQuestionIndex
                  ? "border-primary bg-primary text-white"
                  : answers[q.question_bank.id]
                  ? "border-green-500 bg-green-50 text-green-700"
                  : "border-gray-200 hover:border-primary/50"
              }`}
              onClick={() => onNavigate(index)}
            >
              {index + 1}
            </button>
          ))}
        </div>
        <p className="text-xs text-muted-foreground mt-3">
          Answered: {Object.keys(answers).filter((k) => answers[k]).length} /{" "}
          {questions.length}
        </p>
      </CardContent>
    </Card>
  );
}

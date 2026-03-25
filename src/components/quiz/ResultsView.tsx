"use client";

import { Button } from "@/design-system/components/ui/button";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  CardDescription,
} from "@/design-system/components/ui/card";
import { Badge } from "@/design-system/components/ui/badge";
import { CheckCircle, XCircle, RotateCcw, Award } from "lucide-react";
import { renderMultiPartQuestion } from "@/components/MathRenderer";
import type { QuizQuestion } from "@/hooks/useQuizSession";

interface ResultsViewProps {
  questions: QuizQuestion[];
  answers: Record<string, string>;
  score: number | null;
  onRetry: () => void;
}

export function ResultsView({
  questions,
  answers,
  score,
  onRetry,
}: ResultsViewProps) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-2xl">Quiz Results</CardTitle>
        <CardDescription>
          Here&apos;s how you performed on this quiz
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-6">
        {score !== null && (
          <div className="text-center py-8">
            <div className="inline-block p-8 bg-primary/10 rounded-full mb-4">
              <Award className="w-16 h-16 text-primary" />
            </div>
            <h3 className="text-4xl font-bold text-primary mb-2">{score}%</h3>
            <p className="text-lg text-muted-foreground">
              {score >= 80
                ? "Excellent work!"
                : score >= 60
                ? "Good job!"
                : score >= 40
                ? "Keep practicing!"
                : "Review the material and try again"}
            </p>
          </div>
        )}

        <div className="space-y-4">
          <h4 className="font-semibold text-lg">Review Your Answers</h4>
          {questions.map((q, index) => {
            const userAnswer = answers[q.question_bank.id];
            const correctAnswer = q.question_bank.correct_answer;
            const isCorrect = userAnswer === correctAnswer;

            return (
              <Card
                key={q.id}
                className="border-l-4"
                style={{
                  borderLeftColor: correctAnswer
                    ? isCorrect
                      ? "rgb(34, 197, 94)"
                      : "rgb(239, 68, 68)"
                    : "rgb(156, 163, 175)",
                }}
              >
                <CardContent className="p-4">
                  <div className="flex items-start gap-2 mb-3">
                    <Badge variant="outline">Q{index + 1}</Badge>
                    {correctAnswer && (
                      <Badge
                        variant={isCorrect ? "default" : "destructive"}
                        className={isCorrect ? "bg-green-600" : ""}
                      >
                        {isCorrect ? (
                          <>
                            <CheckCircle className="w-3 h-3 mr-1" />
                            Correct
                          </>
                        ) : (
                          <>
                            <XCircle className="w-3 h-3 mr-1" />
                            Incorrect
                          </>
                        )}
                      </Badge>
                    )}
                  </div>

                  <div className="prose prose-sm max-w-none mb-3">
                    {renderMultiPartQuestion(q.question_bank.question_text)}
                  </div>

                  {correctAnswer && (
                    <div className="mt-3 space-y-2">
                      <p className="text-sm">
                        <span className="font-semibold">Your answer:</span>{" "}
                        <span
                          className={
                            isCorrect ? "text-green-600" : "text-red-600"
                          }
                        >
                          {userAnswer || "Not answered"}
                        </span>
                      </p>
                      {!isCorrect && (
                        <p className="text-sm">
                          <span className="font-semibold">Correct answer:</span>{" "}
                          <span className="text-green-600">{correctAnswer}</span>
                        </p>
                      )}
                      {q.question_bank.explanation && (
                        <div className="mt-2 p-3 bg-blue-50 rounded-lg">
                          <p className="text-sm font-semibold mb-1">
                            Explanation:
                          </p>
                          <div className="prose prose-sm max-w-none">
                            {renderMultiPartQuestion(q.question_bank.explanation)}
                          </div>
                        </div>
                      )}
                    </div>
                  )}
                </CardContent>
              </Card>
            );
          })}
        </div>

        <div className="flex gap-4">
          <Button variant="outline" className="flex-1" onClick={onRetry}>
            <RotateCcw className="w-4 h-4 mr-2" />
            Retry Quiz
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}

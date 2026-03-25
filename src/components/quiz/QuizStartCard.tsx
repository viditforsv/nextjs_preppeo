"use client";

import { Button } from "@/design-system/components/ui/button";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  CardDescription,
} from "@/design-system/components/ui/card";
import { Clock, CheckCircle, Award, Play } from "lucide-react";
import type { Quiz, QuizQuestion } from "@/hooks/useQuizSession";

interface QuizStartCardProps {
  quiz: Quiz;
  questions: QuizQuestion[];
  onStart: () => void;
}

export function QuizStartCard({ quiz, questions, onStart }: QuizStartCardProps) {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-2xl">{quiz.title}</CardTitle>
        <CardDescription>Test your knowledge with this quiz</CardDescription>
      </CardHeader>
      <CardContent className="space-y-6">
        <div className="grid grid-cols-2 gap-4">
          <div className="flex items-center gap-2">
            <CheckCircle className="w-5 h-5 text-primary" />
            <div>
              <p className="text-sm text-muted-foreground">Questions</p>
              <p className="font-semibold">{questions.length}</p>
            </div>
          </div>

          {quiz.time_limit && (
            <div className="flex items-center gap-2">
              <Clock className="w-5 h-5 text-primary" />
              <div>
                <p className="text-sm text-muted-foreground">Time Limit</p>
                <p className="font-semibold">{quiz.time_limit} minutes</p>
              </div>
            </div>
          )}

          <div className="flex items-center gap-2">
            <Award className="w-5 h-5 text-primary" />
            <div>
              <p className="text-sm text-muted-foreground">Difficulty</p>
              <p className="font-semibold capitalize">{quiz.difficulty}</p>
            </div>
          </div>

          <div className="flex items-center gap-2">
            <CheckCircle className="w-5 h-5 text-primary" />
            <div>
              <p className="text-sm text-muted-foreground">Total Marks</p>
              <p className="font-semibold">
                {questions.reduce(
                  (sum, q) => sum + q.question_bank.total_marks,
                  0
                )}
              </p>
            </div>
          </div>
        </div>

        <Button
          className="w-full bg-primary hover:bg-primary/90"
          size="lg"
          onClick={onStart}
        >
          <Play className="w-5 h-5 mr-2" />
          Start Quiz
        </Button>
      </CardContent>
    </Card>
  );
}

"use client";

import { Button } from "@/design-system/components/ui/button";
import { Input } from "@/design-system/components/ui/input";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  CardDescription,
} from "@/design-system/components/ui/card";
import { Badge } from "@/design-system/components/ui/badge";
import { Progress } from "@/design-system/components/ui/progress";
import {
  Clock,
  CheckCircle,
  XCircle,
  ChevronLeft,
  ChevronRight,
  ChevronDown,
  ChevronUp,
} from "lucide-react";
import { Checkbox } from "@/design-system/components/ui/checkbox";
import { renderMultiPartQuestion } from "@/components/MathRenderer";
import type { QuizQuestion } from "@/hooks/useQuizSession";

interface QuestionDisplayProps {
  currentQuestion: QuizQuestion;
  currentQuestionIndex: number;
  totalQuestions: number;
  answers: Record<string, string>;
  checkedAnswers: Record<string, boolean>;
  showExplanations: Record<string, boolean>;
  currentQuestionTime: number;
  timeRemaining: number | null;
  started: boolean;
  submitted: boolean;
  onAnswer: (questionId: string, answer: string) => void;
  onCheckAnswer: (questionId: string) => void;
  onResetAnswer: (questionId: string) => void;
  onToggleExplanation: (questionId: string) => void;
  onPrevious: () => void;
  onNext: () => void;
  onSubmit: () => void;
  isLastQuestion: boolean;
}

function formatTime(seconds: number) {
  const mins = Math.floor(seconds / 60);
  const secs = seconds % 60;
  return `${mins}:${secs.toString().padStart(2, "0")}`;
}

function OptionButton({
  optionValue,
  letterIndex,
  questionId,
  answers,
  checkedAnswers,
  correctAnswer,
  onAnswer,
  variant,
}: {
  optionValue: string;
  letterIndex?: number;
  questionId: string;
  answers: Record<string, string>;
  checkedAnswers: Record<string, boolean>;
  correctAnswer?: string;
  onAnswer: (id: string, val: string) => void;
  variant: "mcq" | "true_false";
}) {
  const isSelected = answers[questionId] === optionValue;
  const isChecked = checkedAnswers[questionId] || false;
  const isAnswerCorrect = isChecked && answers[questionId] === correctAnswer;
  const isThisCorrect = optionValue === correctAnswer;

  let className =
    variant === "true_false"
      ? "w-full flex items-center space-x-2 p-4 border-2 rounded-lg transition-all cursor-pointer "
      : "w-full flex items-center space-x-2 p-3 border rounded-sm transition-all cursor-pointer ";

  if (isChecked) {
    if (isAnswerCorrect && isThisCorrect) {
      className +=
        variant === "mcq"
          ? "bg-green-50 border-green-500 border-2"
          : "bg-green-50 border-green-500";
    } else if (isSelected && !isAnswerCorrect) {
      className +=
        variant === "mcq"
          ? "bg-red-50 border-red-500 border-2"
          : "bg-red-50 border-red-500";
    } else {
      className += "border-gray-200 hover:bg-gray-50";
    }
  } else if (isSelected) {
    className += "bg-blue-50 border-blue-500";
  } else {
    className +=
      variant === "true_false"
        ? "border-gray-200 hover:border-primary/50"
        : "border-gray-200 hover:bg-gray-50";
  }

  if (isChecked && isAnswerCorrect) {
    className += " cursor-not-allowed";
  }

  return (
    <button
      onClick={() => {
        if (!(isChecked && isAnswerCorrect)) {
          onAnswer(questionId, optionValue);
        }
      }}
      disabled={isChecked && isAnswerCorrect}
      className={className}
    >
      {variant === "true_false" ? (
        <Checkbox checked={isSelected} disabled={isChecked && isAnswerCorrect} />
      ) : (
        <div
          className={`w-6 h-6 flex items-center justify-center border-2 rounded-sm text-sm font-medium ${
            isSelected || (isChecked && isAnswerCorrect && isThisCorrect)
              ? "bg-primary border-primary text-white"
              : "border-primary text-primary"
          }`}
        >
          {String.fromCharCode(65 + (letterIndex ?? 0))}
        </div>
      )}
      <span className="font-medium flex-1 text-left">{optionValue}</span>
      {isChecked && isAnswerCorrect && isThisCorrect && (
        <CheckCircle className="w-5 h-5 text-green-600" />
      )}
      {isChecked && isSelected && !isAnswerCorrect && (
        <XCircle className="w-5 h-5 text-red-600" />
      )}
    </button>
  );
}

function AnswerFeedbackBlock({
  questionId,
  answers,
  correctAnswer,
  showExplanations,
  explanation,
  onToggleExplanation,
}: {
  questionId: string;
  answers: Record<string, string>;
  correctAnswer: string;
  showExplanations: Record<string, boolean>;
  explanation?: string;
  onToggleExplanation: (id: string) => void;
}) {
  const isCorrect = answers[questionId] === correctAnswer;

  return (
    <div className="space-y-2">
      <div
        className={`p-3 border rounded-sm ${
          isCorrect ? "bg-green-50 border-green-200" : "bg-red-50 border-red-200"
        }`}
      >
        <p
          className={`text-sm font-medium mb-1 ${
            isCorrect ? "text-green-800" : "text-red-800"
          }`}
        >
          {isCorrect ? "✓ Correct!" : "✗ Incorrect"}
        </p>
        {isCorrect && (
          <p className="text-sm text-green-700">
            <span className="font-medium">Correct Answer: </span>
            {correctAnswer}
          </p>
        )}
      </div>

      {explanation && (
        <div className="mt-4">
          <Button
            variant="outline"
            className="w-full justify-between"
            onClick={() => onToggleExplanation(questionId)}
          >
            <span className="text-sm font-medium">
              {showExplanations[questionId] ? "Hide Explanation" : "Show Explanation"}
            </span>
            {showExplanations[questionId] ? (
              <ChevronUp className="w-4 h-4" />
            ) : (
              <ChevronDown className="w-4 h-4" />
            )}
          </Button>
          {showExplanations[questionId] && (
            <div className="mt-3 p-4 bg-blue-50 border border-blue-200 rounded-lg">
              <p className="text-sm font-semibold mb-2 text-blue-900">
                Explanation:
              </p>
              <div className="prose prose-sm max-w-none text-blue-800">
                {renderMultiPartQuestion(explanation)}
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

export function QuestionDisplay({
  currentQuestion,
  currentQuestionIndex,
  totalQuestions,
  answers,
  checkedAnswers,
  showExplanations,
  currentQuestionTime,
  timeRemaining,
  started,
  submitted,
  onAnswer,
  onCheckAnswer,
  onResetAnswer,
  onToggleExplanation,
  onPrevious,
  onNext,
  onSubmit,
  isLastQuestion,
}: QuestionDisplayProps) {
  const questionId = currentQuestion.question_bank.id;
  const correctAnswer = currentQuestion.question_bank.correct_answer;
  const isAnswerChecked = checkedAnswers[questionId] || false;
  const isAnswerCorrect = isAnswerChecked && answers[questionId] === correctAnswer;

  let options = currentQuestion.question_bank.options;
  if (options && typeof options === "string") {
    try {
      options = JSON.parse(options);
    } catch {
      options = undefined;
    }
  }
  const isMCQ =
    currentQuestion.question_bank.question_type === "mcq" &&
    Array.isArray(options) &&
    options.length > 0;
  const isTrueFalse = currentQuestion.question_bank.question_type === "true_false";
  const isFillBlank = currentQuestion.question_bank.question_type === "fill_blank";

  return (
    <div className="space-y-6">
      {/* Progress Header */}
      <Card>
        <CardContent className="p-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <Badge variant="secondary">
                Question {currentQuestionIndex + 1} of {totalQuestions}
              </Badge>
              {timeRemaining !== null && (
                <div className="flex items-center gap-2">
                  <Clock className="w-4 h-4 text-primary" />
                  <span
                    className={`font-semibold ${
                      timeRemaining < 60 ? "text-red-600" : "text-foreground"
                    }`}
                  >
                    {formatTime(timeRemaining)}
                  </span>
                </div>
              )}
            </div>
            <Progress
              value={((currentQuestionIndex + 1) / totalQuestions) * 100}
              className="w-32 h-2"
            />
          </div>
        </CardContent>
      </Card>

      {/* Question Card */}
      <Card>
        <CardHeader>
          <div className="flex items-start justify-between">
            <div className="flex-1">
              <CardTitle>Question {currentQuestionIndex + 1}</CardTitle>
              <CardDescription>
                {currentQuestion.question_bank.total_marks} mark(s) • Difficulty:{" "}
                {currentQuestion.question_bank.difficulty}/10
              </CardDescription>
            </div>
            <div className="flex items-center gap-3">
              {started && !submitted && (
                <div className="flex items-center gap-2">
                  <Clock className="w-4 h-4 text-muted-foreground" />
                  <span
                    className={`font-semibold ${
                      currentQuestionTime >= 90
                        ? "text-red-600"
                        : currentQuestionTime >= 70
                        ? "text-yellow-600"
                        : "text-foreground"
                    }`}
                  >
                    {formatTime(currentQuestionTime)}
                  </span>
                </div>
              )}
              <Badge variant="outline">
                {currentQuestion.question_bank.question_type}
              </Badge>
            </div>
          </div>
        </CardHeader>

        <CardContent className="space-y-6">
          <div className="prose prose-base max-w-none text-foreground">
            {renderMultiPartQuestion(currentQuestion.question_bank.question_text)}
          </div>

          <div className="space-y-4">
            {isTrueFalse ? (
              <div className="space-y-4">
                <div className="space-y-2">
                  {["True", "False"].map((option) => (
                    <OptionButton
                      key={option}
                      optionValue={option}
                      questionId={questionId}
                      answers={answers}
                      checkedAnswers={checkedAnswers}
                      correctAnswer={correctAnswer}
                      onAnswer={onAnswer}
                      variant="true_false"
                    />
                  ))}
                </div>
                <div className="flex gap-2">
                  {answers[questionId] && !isAnswerCorrect && (
                    <Button
                      onClick={() => onCheckAnswer(questionId)}
                      className="bg-primary hover:bg-primary/90"
                    >
                      {isAnswerChecked ? "Check Answer Again" : "Check Answer"}
                    </Button>
                  )}
                  <Button variant="outline" onClick={() => onResetAnswer(questionId)}>
                    Reset
                  </Button>
                </div>
                {isAnswerChecked && correctAnswer && (
                  <AnswerFeedbackBlock
                    questionId={questionId}
                    answers={answers}
                    correctAnswer={correctAnswer}
                    showExplanations={showExplanations}
                    explanation={currentQuestion.question_bank.explanation}
                    onToggleExplanation={onToggleExplanation}
                  />
                )}
              </div>
            ) : isMCQ ? (
              <div className="space-y-4">
                <div className="space-y-2">
                  {(Array.isArray(options) ? options : []).map(
                    (option: { value: string; label: string }, index: number) => (
                      <OptionButton
                        key={index}
                        optionValue={option.value}
                        letterIndex={index}
                        questionId={questionId}
                        answers={answers}
                        checkedAnswers={checkedAnswers}
                        correctAnswer={correctAnswer}
                        onAnswer={onAnswer}
                        variant="mcq"
                      />
                    )
                  )}
                </div>
                <div className="flex gap-2">
                  {answers[questionId] && !isAnswerCorrect && (
                    <Button
                      onClick={() => onCheckAnswer(questionId)}
                      className="bg-primary hover:bg-primary/90"
                    >
                      {isAnswerChecked ? "Check Answer Again" : "Check Answer"}
                    </Button>
                  )}
                  <Button variant="outline" onClick={() => onResetAnswer(questionId)}>
                    Reset
                  </Button>
                </div>
                {isAnswerChecked && correctAnswer && (
                  <AnswerFeedbackBlock
                    questionId={questionId}
                    answers={answers}
                    correctAnswer={correctAnswer}
                    showExplanations={showExplanations}
                    explanation={currentQuestion.question_bank.explanation}
                    onToggleExplanation={onToggleExplanation}
                  />
                )}
              </div>
            ) : isFillBlank ? (
              <Input
                className="w-full p-3 text-lg"
                placeholder="Type your answer here..."
                value={answers[questionId] || ""}
                onChange={(e) => onAnswer(questionId, e.target.value)}
              />
            ) : (
              <textarea
                className="w-full min-h-32 p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
                placeholder="Type your answer here..."
                value={answers[questionId] || ""}
                onChange={(e) => onAnswer(questionId, e.target.value)}
              />
            )}
          </div>

          <div className="flex justify-between items-center pt-4 border-t">
            <Button
              variant="outline"
              onClick={onPrevious}
              disabled={currentQuestionIndex === 0}
            >
              <ChevronLeft className="w-4 h-4 mr-2" />
              Previous
            </Button>
            {isLastQuestion ? (
              <Button className="bg-primary hover:bg-primary/90" onClick={onSubmit}>
                Submit Quiz
              </Button>
            ) : (
              <Button onClick={onNext}>
                Next
                <ChevronRight className="w-4 h-4 ml-2" />
              </Button>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}

"use client";

import { useState } from "react";
import { Button } from "@/design-system/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/design-system/components/ui/card";
import { ChevronLeft, CheckCircle, XCircle } from "lucide-react";

export interface InteractiveStep {
  title: string;
  content: string;
  visual?: string;
  equation?: string;
  highlight?: string;
}

export interface InteractiveQuizItem {
  question: string;
  options: string[];
  answer: number;
  explanation: string;
}

interface InteractiveLessonViewProps {
  lessonTitle: string;
  intro?: string | null;
  steps: InteractiveStep[];
  quiz: InteractiveQuizItem[];
  accentColor?: string;
  onComplete?: () => void;
}

export function InteractiveLessonView({
  lessonTitle,
  intro = "",
  steps,
  quiz,
  accentColor = "hsl(var(--primary))",
  onComplete,
}: InteractiveLessonViewProps) {
  const [screen, setScreen] = useState<"intro" | "steps" | "quiz" | "result">(
    steps.length === 0 && quiz.length === 0 ? "intro" : steps.length > 0 ? "intro" : "quiz"
  );
  const [stepIndex, setStepIndex] = useState(0);
  const [quizIndex, setQuizIndex] = useState(0);
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [answered, setAnswered] = useState(false);
  const [score, setScore] = useState(0);

  const startSteps = () => setScreen("steps");
  const startQuiz = () => {
    setQuizIndex(0);
    setScore(0);
    setSelectedOption(null);
    setAnswered(false);
    setScreen("quiz");
  };

  const step = steps[stepIndex];
  const isLastStep = stepIndex === steps.length - 1;
  const goNextStep = () => {
    if (isLastStep) startQuiz();
    else setStepIndex((i) => i + 1);
  };
  const goPrevStep = () => {
    if (stepIndex > 0) setStepIndex((i) => i - 1);
    else setScreen("intro");
  };

  const currentQuizItem = quiz[quizIndex];
  const selectAnswer = (idx: number) => {
    if (answered) return;
    setSelectedOption(idx);
    setAnswered(true);
    if (idx === currentQuizItem.answer) setScore((s) => s + 1);
  };
  const nextQuestion = () => {
    if (quizIndex + 1 >= quiz.length) {
      setScreen("result");
      onComplete?.();
    } else {
      setQuizIndex((i) => i + 1);
      setSelectedOption(null);
      setAnswered(false);
    }
  };

  if (screen === "intro") {
    return (
      <Card className="max-w-2xl">
        <CardHeader>
          <CardTitle className="text-2xl">{lessonTitle}</CardTitle>
          {intro && (
            <p className="text-muted-foreground mt-2">{intro}</p>
          )}
        </CardHeader>
        <CardContent className="flex flex-col gap-4">
          <p className="text-sm text-muted-foreground">
            {steps.length} steps · {quiz.length} quiz questions
          </p>
          <div className="flex gap-2">
            {steps.length > 0 && (
              <Button onClick={startSteps} className="bg-primary text-primary-foreground hover:bg-primary/90">
                Start Lesson
              </Button>
            )}
            {steps.length === 0 && quiz.length > 0 && (
              <Button onClick={startQuiz} className="bg-primary text-primary-foreground hover:bg-primary/90">
                Take Quiz
              </Button>
            )}
          </div>
        </CardContent>
      </Card>
    );
  }

  if (screen === "steps" && step) {
    return (
      <div className="w-full grid grid-cols-1 lg:grid-cols-2 gap-4 min-h-[420px]">
        {/* Left panel: Step content */}
        <Card className="flex flex-col">
          <CardHeader className="pb-2">
            <div className="flex items-center justify-between">
              <Button variant="outline" size="sm" onClick={goPrevStep}>
                <ChevronLeft className="w-4 h-4" />
              </Button>
              <span className="text-sm text-muted-foreground">
                Step {stepIndex + 1} of {steps.length}
              </span>
            </div>
            <CardTitle className="text-xl">{step.title}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4 flex-1">
            <p className="text-muted-foreground">{step.content}</p>
            {step.equation && (
              <div
                className="rounded-lg border bg-muted/50 p-4 font-mono text-center text-lg"
                style={{ borderColor: accentColor }}
              >
                {step.equation}
              </div>
            )}
            {step.highlight && (
              <p className="text-center text-sm text-muted-foreground">↑ {step.highlight}</p>
            )}
            <div className="flex justify-end gap-2 pt-4">
              <Button variant="outline" onClick={goPrevStep}>
                Back
              </Button>
              <Button onClick={goNextStep} className="bg-primary text-primary-foreground hover:bg-primary/90">
                {isLastStep ? "Take Quiz" : "Next"}
              </Button>
            </div>
          </CardContent>
        </Card>

        {/* Right panel: Key takeaway / context */}
        <Card className="flex flex-col">
          <CardHeader className="pb-2">
            <CardTitle className="text-lg">Key takeaway</CardTitle>
          </CardHeader>
          <CardContent className="flex-1 min-h-[200px]">
            {(step.equation || step.highlight) ? (
              <div className="space-y-3">
                {step.equation && (
                  <div className="rounded-lg border bg-muted/50 p-4 font-mono text-center text-lg" style={{ borderColor: accentColor }}>
                    {step.equation}
                  </div>
                )}
                {step.highlight && (
                  <p className="text-sm text-muted-foreground">{step.highlight}</p>
                )}
              </div>
            ) : (
              <p className="text-sm text-muted-foreground">{step.content}</p>
            )}
          </CardContent>
        </Card>
      </div>
    );
  }

  if (screen === "quiz" && currentQuizItem) {
    const isCorrect = selectedOption === currentQuizItem.answer;
    return (
      <div className="w-full grid grid-cols-1 lg:grid-cols-2 gap-4 min-h-[420px]">
        {/* Left panel: Question */}
        <Card className="flex flex-col">
          <CardHeader className="pb-2">
            <CardTitle className="text-lg">Question {quizIndex + 1} of {quiz.length}</CardTitle>
          </CardHeader>
          <CardContent className="flex flex-col flex-1 space-y-4">
            <p className="font-medium">{currentQuizItem.question}</p>
            <p className="text-sm text-muted-foreground">Select one option:</p>
            <ul className="space-y-2" role="listbox" aria-label="Answer options">
              {(currentQuizItem.options && currentQuizItem.options.length > 0
                ? currentQuizItem.options
                : ["No options available"]
              ).map((opt, i) => {
                const optionLabel = String.fromCharCode(65 + i);
                let style = "border border-input bg-background hover:bg-accent text-foreground";
                if (answered) {
                  if (i === currentQuizItem.answer) style = "border-green-600 bg-green-500/20 text-green-800 dark:bg-green-500/30 dark:text-green-100";
                  else if (i === selectedOption) style = "border-red-600 bg-red-500/20 text-red-800 dark:bg-red-500/30 dark:text-red-100";
                }
                return (
                  <li key={i}>
                    <button
                      type="button"
                      role="option"
                      aria-selected={selectedOption === i}
                      onClick={() => selectAnswer(i)}
                      disabled={answered}
                      className={`w-full rounded-lg p-3 text-left transition font-medium ${style}`}
                    >
                      <span className="font-semibold mr-2 opacity-90">{optionLabel}.</span>
                      {opt}
                    </button>
                  </li>
                );
              })}
            </ul>
            {answered && (
              <div className="flex justify-end pt-2">
                <Button onClick={nextQuestion} className="bg-primary text-primary-foreground hover:bg-primary/90">
                  {quizIndex + 1 >= quiz.length ? "See Results" : "Next Question"}
                </Button>
              </div>
            )}
          </CardContent>
        </Card>

        {/* Right panel: Solution (empty until answered) */}
        <Card className="flex flex-col">
          <CardHeader className="pb-2">
            <CardTitle className="text-lg">Solution</CardTitle>
          </CardHeader>
          <CardContent className="flex-1 flex flex-col min-h-[200px]">
            {!answered ? (
              <div className="flex-1 flex items-center justify-center rounded-lg border border-dashed border-muted-foreground/30 bg-muted/30 text-muted-foreground text-sm text-center p-6">
                Answer the question on the left to see the solution and explanation here.
              </div>
            ) : (
              <div className="space-y-4">
                <div className={`flex items-center gap-2 font-medium ${isCorrect ? "text-green-600" : "text-red-600"}`}>
                  {isCorrect ? <CheckCircle className="w-5 h-5" /> : <XCircle className="w-5 h-5" />}
                  {isCorrect ? "Correct" : "Incorrect"}
                </div>
                <div>
                  <p className="text-sm font-medium text-muted-foreground mb-1">Explanation</p>
                  <p className="text-sm">{currentQuizItem.explanation}</p>
                </div>
                <p className="text-xs text-muted-foreground pt-2 border-t">
                  Relevant context from this lesson: use this to reinforce the concept before moving on.
                </p>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    );
  }

  if (screen === "result") {
    const total = quiz.length;
    const pct = total ? Math.round((score / total) * 100) : 0;
    return (
      <Card className="max-w-2xl">
        <CardHeader>
          <CardTitle>Quiz complete</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <p className="text-3xl font-bold text-foreground">
            {score} / {total}
          </p>
          <p className="text-muted-foreground">{pct}% correct</p>
          <div className="flex gap-2">
            <Button variant="outline" onClick={() => { setScreen("quiz"); startQuiz(); }}>
              Review Quiz
            </Button>
            {onComplete && (
              <Button onClick={onComplete} className="bg-primary text-primary-foreground hover:bg-primary/90">
                Mark complete & continue
              </Button>
            )}
          </div>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="max-w-2xl">
      <CardContent className="py-8 text-center text-muted-foreground">
        No content for this lesson yet.
      </CardContent>
    </Card>
  );
}

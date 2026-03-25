"use client";

import { useEffect, useState, useCallback } from "react";
import { useQuizSession } from "@/hooks/useQuizSession";
import { useQuizTimer } from "@/hooks/useQuizTimer";
import { useAnswerTracking } from "@/hooks/useAnswerTracking";
import { QuizStartCard } from "./quiz/QuizStartCard";
import { QuestionDisplay } from "./quiz/QuestionDisplay";
import { QuestionNavigator } from "./quiz/QuestionNavigator";
import { ResultsView } from "./quiz/ResultsView";

interface QuizPlayerProps {
  quizId: string;
}

export function QuizPlayer({ quizId }: QuizPlayerProps) {
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);

  const {
    quiz,
    questions,
    loading,
    started,
    submitted,
    score,
    quizSessionId,
    fetchQuizData,
    startQuiz,
    submitQuiz,
    retryQuiz,
  } = useQuizSession(quizId);

  // submitQuiz needs answers — wrap in a stable callback
  const handleSubmit = useCallback(() => {
    submitQuiz(answers);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [submitQuiz]);

  const { timeRemaining, currentQuestionTime, questionStartTimes, resetTimer } =
    useQuizTimer({
      quiz,
      questions,
      started,
      submitted,
      currentQuestionIndex,
      onExpired: handleSubmit,
    });

  const {
    answers,
    checkedAnswers,
    showExplanations,
    handleAnswer,
    handleCheckAnswer,
    handleResetAnswer,
    handleToggleExplanation,
    resetAll: resetAnswers,
  } = useAnswerTracking({ quiz, questions, quizSessionId, questionStartTimes });

  useEffect(() => {
    fetchQuizData();
  }, [fetchQuizData]);

  const handleStart = () => {
    setCurrentQuestionIndex(0);
    resetAnswers();
    resetTimer(quiz?.time_limit);
    startQuiz();
  };

  const handleRetry = () => {
    setCurrentQuestionIndex(0);
    resetAnswers();
    resetTimer(quiz?.time_limit);
    retryQuiz();
  };

  const handleFinalSubmit = useCallback(() => {
    submitQuiz(answers);
  }, [submitQuiz, answers]);

  if (loading) {
    return (
      <div className="text-center py-8">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
        <p className="text-muted-foreground">Loading quiz...</p>
      </div>
    );
  }

  if (!quiz || questions.length === 0) {
    return (
      <div className="text-center py-8">
        <p className="text-muted-foreground">
          No questions available for this quiz yet.
        </p>
      </div>
    );
  }

  if (!started) {
    return (
      <QuizStartCard quiz={quiz} questions={questions} onStart={handleStart} />
    );
  }

  if (submitted) {
    return (
      <ResultsView
        questions={questions}
        answers={answers}
        score={score}
        onRetry={handleRetry}
      />
    );
  }

  const currentQuestion = questions[currentQuestionIndex];
  if (!currentQuestion) return null;

  return (
    <div className="space-y-6">
      <QuestionDisplay
        currentQuestion={currentQuestion}
        currentQuestionIndex={currentQuestionIndex}
        totalQuestions={questions.length}
        answers={answers}
        checkedAnswers={checkedAnswers}
        showExplanations={showExplanations}
        currentQuestionTime={currentQuestionTime}
        timeRemaining={timeRemaining}
        started={started}
        submitted={submitted}
        onAnswer={handleAnswer}
        onCheckAnswer={handleCheckAnswer}
        onResetAnswer={handleResetAnswer}
        onToggleExplanation={handleToggleExplanation}
        onPrevious={() =>
          setCurrentQuestionIndex(Math.max(0, currentQuestionIndex - 1))
        }
        onNext={() =>
          setCurrentQuestionIndex(
            Math.min(questions.length - 1, currentQuestionIndex + 1)
          )
        }
        onSubmit={handleFinalSubmit}
        isLastQuestion={currentQuestionIndex === questions.length - 1}
      />
      <QuestionNavigator
        questions={questions}
        answers={answers}
        currentQuestionIndex={currentQuestionIndex}
        onNavigate={setCurrentQuestionIndex}
      />
    </div>
  );
}

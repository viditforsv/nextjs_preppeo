"use client";

import { useState, useCallback } from "react";
import type { Quiz, QuizQuestion } from "./useQuizSession";

interface UseAnswerTrackingParams {
  quiz: Quiz | null;
  questions: QuizQuestion[];
  quizSessionId: string;
  questionStartTimes: Record<string, number>;
}

export function useAnswerTracking({
  quiz,
  questions,
  quizSessionId,
  questionStartTimes,
}: UseAnswerTrackingParams) {
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [checkedAnswers, setCheckedAnswers] = useState<
    Record<string, boolean>
  >({});
  const [showExplanations, setShowExplanations] = useState<
    Record<string, boolean>
  >({});
  const [recordedAttempts, setRecordedAttempts] = useState<Set<string>>(
    new Set()
  );

  const recordQuestionAttempt = useCallback(
    async (
      questionId: string,
      selectedAnswer: string,
      correctAnswer: string | undefined
    ) => {
      if (!correctAnswer) return;

      setRecordedAttempts((prev) => {
        if (prev.has(questionId)) return prev;
        return new Set(prev).add(questionId);
      });

      const startTime = questionStartTimes[questionId] || Date.now();
      const timeTaken = Math.max(1, Math.floor((Date.now() - startTime) / 1000));
      const isCorrect = selectedAnswer === correctAnswer;

      try {
        const response = await fetch("/api/student-progress/attempts", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            question_id: questionId,
            lesson_id: quiz?.lesson_id || null,
            course_id: quiz?.courses_lessons?.course_id || null,
            time_taken_seconds: timeTaken,
            is_correct: isCorrect,
            hint_used: false,
            session_id: quizSessionId,
            session_order:
              questions.findIndex((q) => q.question_bank.id === questionId) + 1,
          }),
        });

        if (response.ok) {
          console.log(
            `✅ Recorded attempt: ${isCorrect ? "Correct" : "Incorrect"} (${timeTaken}s)`
          );
        } else {
          const errorData = await response.json();
          console.error("Error recording attempt:", errorData);
          setRecordedAttempts((prev) => {
            const newSet = new Set(prev);
            newSet.delete(questionId);
            return newSet;
          });
        }
      } catch (error) {
        console.error("Error recording attempt:", error);
        setRecordedAttempts((prev) => {
          const newSet = new Set(prev);
          newSet.delete(questionId);
          return newSet;
        });
      }
    },
    [questionStartTimes, quiz, quizSessionId, questions]
  );

  const handleAnswer = useCallback(
    (questionId: string, answer: string) => {
      setAnswers((prev) => ({ ...prev, [questionId]: answer }));

      if (checkedAnswers[questionId]) {
        const currentQuestion = questions.find(
          (q) => q.question_bank.id === questionId
        );
        const wasCorrect =
          currentQuestion?.question_bank.correct_answer &&
          answers[questionId] ===
            currentQuestion.question_bank.correct_answer;

        if (!wasCorrect) {
          setCheckedAnswers((prev) => ({ ...prev, [questionId]: false }));
        }
      }
    },
    [checkedAnswers, answers, questions]
  );

  const handleCheckAnswer = useCallback(
    (questionId: string) => {
      setCheckedAnswers((prev) => ({ ...prev, [questionId]: true }));

      const currentQuestion = questions.find(
        (q) => q.question_bank.id === questionId
      );
      if (
        (currentQuestion?.question_bank.question_type === "mcq" ||
          currentQuestion?.question_bank.question_type === "true_false") &&
        currentQuestion?.question_bank.correct_answer &&
        answers[questionId]
      ) {
        recordQuestionAttempt(
          questionId,
          answers[questionId],
          currentQuestion.question_bank.correct_answer
        );
      }
    },
    [questions, answers, recordQuestionAttempt]
  );

  const handleResetAnswer = useCallback((questionId: string) => {
    setAnswers((prev) => ({ ...prev, [questionId]: "" }));
    setCheckedAnswers((prev) => ({ ...prev, [questionId]: false }));
    setShowExplanations((prev) => ({ ...prev, [questionId]: false }));
  }, []);

  const handleToggleExplanation = useCallback((questionId: string) => {
    setShowExplanations((prev) => ({
      ...prev,
      [questionId]: !prev[questionId],
    }));
  }, []);

  const resetAll = useCallback(() => {
    setAnswers({});
    setCheckedAnswers({});
    setShowExplanations({});
    setRecordedAttempts(new Set());
  }, []);

  return {
    answers,
    checkedAnswers,
    showExplanations,
    recordedAttempts,
    handleAnswer,
    handleCheckAnswer,
    handleResetAnswer,
    handleToggleExplanation,
    resetAll,
  };
}

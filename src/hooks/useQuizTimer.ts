"use client";

import { useState, useEffect, useCallback } from "react";
import type { Quiz, QuizQuestion } from "./useQuizSession";

interface UseQuizTimerParams {
  quiz: Quiz | null;
  questions: QuizQuestion[];
  started: boolean;
  submitted: boolean;
  currentQuestionIndex: number;
  onExpired: () => void;
}

export function useQuizTimer({
  quiz,
  questions,
  started,
  submitted,
  currentQuestionIndex,
  onExpired,
}: UseQuizTimerParams) {
  const [timeRemaining, setTimeRemaining] = useState<number | null>(null);
  const [questionStartTimes, setQuestionStartTimes] = useState<
    Record<string, number>
  >({});
  const [currentQuestionTime, setCurrentQuestionTime] = useState<number>(0);

  // Initialise global timer when quiz data loads
  useEffect(() => {
    if (quiz?.time_limit) {
      setTimeRemaining(quiz.time_limit * 60);
    }
  }, [quiz]);

  // Global countdown timer
  useEffect(() => {
    if (started && !submitted && timeRemaining !== null && timeRemaining > 0) {
      const timer = setInterval(() => {
        setTimeRemaining((prev) => {
          if (prev === null || prev <= 1) {
            clearInterval(timer);
            onExpired();
            return 0;
          }
          return prev - 1;
        });
      }, 1000);
      return () => clearInterval(timer);
    }
  }, [started, submitted, timeRemaining, onExpired]);

  // Track start time for each question
  useEffect(() => {
    if (started && !submitted && questions.length > 0) {
      const currentQuestion = questions[currentQuestionIndex];
      if (currentQuestion) {
        const startTime = Date.now();
        setQuestionStartTimes((prev) => ({
          ...prev,
          [currentQuestion.question_bank.id]: startTime,
        }));
        setCurrentQuestionTime(0);
      }
    }
  }, [currentQuestionIndex, started, submitted, questions]);

  // Update per-question elapsed time every second
  useEffect(() => {
    if (started && !submitted && questions.length > 0) {
      const currentQuestion = questions[currentQuestionIndex];
      if (currentQuestion) {
        const startTime = questionStartTimes[currentQuestion.question_bank.id];
        if (startTime) {
          const interval = setInterval(() => {
            setCurrentQuestionTime(
              Math.floor((Date.now() - startTime) / 1000)
            );
          }, 1000);
          return () => clearInterval(interval);
        }
      }
    }
  }, [started, submitted, currentQuestionIndex, questions, questionStartTimes]);

  const resetTimer = useCallback((timeLimitMinutes: number | null | undefined) => {
    if (timeLimitMinutes) {
      setTimeRemaining(timeLimitMinutes * 60);
    }
    setQuestionStartTimes({});
    setCurrentQuestionTime(0);
  }, []);

  return { timeRemaining, currentQuestionTime, questionStartTimes, resetTimer };
}

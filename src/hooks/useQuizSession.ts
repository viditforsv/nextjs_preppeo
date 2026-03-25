"use client";

import { useState, useCallback } from "react";

interface QuizOption {
  value: string;
  label: string;
}

export interface QuizQuestion {
  id: string;
  question_order: number;
  question_bank: {
    id: string;
    question_text: string;
    difficulty: number;
    question_type: string;
    total_marks: number;
    topic: string;
    subtopic: string;
    correct_answer?: string;
    explanation?: string;
    options?: QuizOption[];
  };
}

export interface Quiz {
  id: string;
  title: string;
  difficulty: string;
  time_limit: number | null;
  lesson_id?: string | null;
  courses_lessons?: {
    id: string;
    title: string;
    lesson_code: string;
    course_id?: string;
  } | null;
}

export function useQuizSession(quizId: string) {
  const [quiz, setQuiz] = useState<Quiz | null>(null);
  const [questions, setQuestions] = useState<QuizQuestion[]>([]);
  const [loading, setLoading] = useState(true);
  const [started, setStarted] = useState(false);
  const [submitted, setSubmitted] = useState(false);
  const [score, setScore] = useState<number | null>(null);
  const [quizSessionId] = useState<string>(`quiz_${quizId}_${Date.now()}`);

  const fetchQuizData = useCallback(async () => {
    try {
      setLoading(true);

      const quizResponse = await fetch(`/api/quizzes?id=${quizId}`);
      if (quizResponse.ok) {
        const quizData = await quizResponse.json();
        if (quizData.quizzes && quizData.quizzes.length > 0) {
          setQuiz(quizData.quizzes[0]);
        }
      }

      const questionsResponse = await fetch(`/api/quizzes/${quizId}/questions`);
      if (questionsResponse.ok) {
        const questionsData = await questionsResponse.json();
        setQuestions(questionsData.questions || []);
      }
    } catch (error) {
      console.error("Error fetching quiz:", error);
    } finally {
      setLoading(false);
    }
  }, [quizId]);

  const startQuiz = useCallback(() => {
    setStarted(true);
    setSubmitted(false);
    setScore(null);
  }, []);

  const submitQuiz = useCallback(
    (answers: Record<string, string>) => {
      setSubmitted(true);

      let correct = 0;
      let total = 0;
      questions.forEach((q) => {
        if (q.question_bank.correct_answer) {
          total++;
          if (answers[q.question_bank.id] === q.question_bank.correct_answer) {
            correct++;
          }
        }
      });

      if (total > 0) {
        setScore(Math.round((correct / total) * 100));
      }
    },
    [questions]
  );

  const retryQuiz = useCallback(() => {
    setStarted(false);
    setSubmitted(false);
    setScore(null);
  }, []);

  return {
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
  };
}

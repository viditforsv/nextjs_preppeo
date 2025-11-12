"use client";

import { useState, useEffect } from "react";
import { Button } from "@/app/components-demo/ui/ui-components/button";
import { Input } from "@/app/components-demo/ui/ui-components/input";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  CardDescription,
} from "@/app/components-demo/ui/ui-components/card";
import { Badge } from "@/app/components-demo/ui/ui-components/badge";
import { Progress } from "@/app/components-demo/ui/ui-components/progress";
import {
  Clock,
  CheckCircle,
  XCircle,
  Play,
  RotateCcw,
  Award,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";
import { renderMultiPartQuestion } from "@/components/MathRenderer";
import { Checkbox } from "@/app/components-demo/ui/ui-components/checkbox";

interface QuizQuestion {
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
    options?: any[];
  };
}

interface Quiz {
  id: string;
  title: string;
  difficulty: string;
  time_limit: number | null;
}

interface QuizPlayerProps {
  quizId: string;
}

export function QuizPlayer({ quizId }: QuizPlayerProps) {
  const [quiz, setQuiz] = useState<Quiz | null>(null);
  const [questions, setQuestions] = useState<QuizQuestion[]>([]);
  const [loading, setLoading] = useState(true);
  const [started, setStarted] = useState(false);
  const [submitted, setSubmitted] = useState(false);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [timeRemaining, setTimeRemaining] = useState<number | null>(null);
  const [score, setScore] = useState<number | null>(null);

  useEffect(() => {
    fetchQuizData();
  }, [quizId]);

  // Timer effect
  useEffect(() => {
    if (started && !submitted && timeRemaining !== null && timeRemaining > 0) {
      const timer = setInterval(() => {
        setTimeRemaining((prev) => {
          if (prev === null || prev <= 1) {
            clearInterval(timer);
            handleSubmit(); // Auto-submit when time runs out
            return 0;
          }
          return prev - 1;
        });
      }, 1000);

      return () => clearInterval(timer);
    }
  }, [started, submitted, timeRemaining]);

  const fetchQuizData = async () => {
    try {
      setLoading(true);

      // Fetch quiz details
      const quizResponse = await fetch(`/api/quizzes?id=${quizId}`);
      if (quizResponse.ok) {
        const quizData = await quizResponse.json();
        if (quizData.quizzes && quizData.quizzes.length > 0) {
          setQuiz(quizData.quizzes[0]);
          if (quizData.quizzes[0].time_limit) {
            setTimeRemaining(quizData.quizzes[0].time_limit * 60); // Convert to seconds
          }
        }
      }

      // Fetch quiz questions
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
  };

  const handleStart = () => {
    setStarted(true);
    setSubmitted(false);
    setAnswers({});
    setScore(null);
    setCurrentQuestionIndex(0);
    if (quiz?.time_limit) {
      setTimeRemaining(quiz.time_limit * 60);
    }
  };

  const handleAnswer = (questionId: string, answer: string) => {
    setAnswers({
      ...answers,
      [questionId]: answer,
    });
  };

  const handleSubmit = () => {
    setSubmitted(true);

    // Calculate score (simplified - checks if answer matches correct_answer)
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
  };

  const handleRetry = () => {
    setStarted(false);
    setSubmitted(false);
    setAnswers({});
    setScore(null);
    setCurrentQuestionIndex(0);
    if (quiz?.time_limit) {
      setTimeRemaining(quiz.time_limit * 60);
    }
  };

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, "0")}`;
  };

  const currentQuestion = questions[currentQuestionIndex];

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

  // Quiz not started
  if (!started) {
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
            onClick={handleStart}
          >
            <Play className="w-5 h-5 mr-2" />
            Start Quiz
          </Button>
        </CardContent>
      </Card>
    );
  }

  // Quiz submitted - Show results
  if (submitted) {
    return (
      <Card>
        <CardHeader>
          <CardTitle className="text-2xl">Quiz Results</CardTitle>
          <CardDescription>
            Here&apos;s how you performed on this quiz
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-6">
          {/* Score Display */}
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

          {/* Question Review */}
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
                            <span className="font-semibold">
                              Correct answer:
                            </span>{" "}
                            <span className="text-green-600">
                              {correctAnswer}
                            </span>
                          </p>
                        )}
                        {q.question_bank.explanation && (
                          <div className="mt-2 p-3 bg-blue-50 rounded-lg">
                            <p className="text-sm font-semibold mb-1">
                              Explanation:
                            </p>
                            <div className="prose prose-sm max-w-none">
                              {renderMultiPartQuestion(
                                q.question_bank.explanation
                              )}
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
            <Button variant="outline" className="flex-1" onClick={handleRetry}>
              <RotateCcw className="w-4 h-4 mr-2" />
              Retry Quiz
            </Button>
          </div>
        </CardContent>
      </Card>
    );
  }

  // Quiz in progress
  return (
    <div className="space-y-6">
      {/* Progress Header */}
      <Card>
        <CardContent className="p-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <Badge variant="secondary">
                Question {currentQuestionIndex + 1} of {questions.length}
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
              value={((currentQuestionIndex + 1) / questions.length) * 100}
              className="w-32 h-2"
            />
          </div>
        </CardContent>
      </Card>

      {/* Current Question */}
      {currentQuestion && (
        <Card>
          <CardHeader>
            <div className="flex items-start justify-between">
              <div>
                <CardTitle>Question {currentQuestionIndex + 1}</CardTitle>
                <CardDescription>
                  {currentQuestion.question_bank.total_marks} mark(s) •
                  Difficulty: {currentQuestion.question_bank.difficulty}/10
                </CardDescription>
              </div>
              <Badge variant="outline">
                {currentQuestion.question_bank.question_type}
              </Badge>
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            {/* Question Text */}
            <div className="prose prose-sm max-w-none">
              {renderMultiPartQuestion(
                currentQuestion.question_bank.question_text
              )}
            </div>

            {/* Answer Input */}
            <div className="space-y-4">
              <label className="text-sm font-semibold">Your Answer:</label>

              {currentQuestion.question_bank.question_type === "true_false" ? (
                // True/False Options
                <div className="space-y-2">
                  {["True", "False"].map((option) => (
                    <div
                      key={option}
                      className={`p-4 border-2 rounded-lg cursor-pointer transition-all ${
                        answers[currentQuestion.question_bank.id] === option
                          ? "border-primary bg-primary/5"
                          : "border-gray-200 hover:border-primary/50"
                      }`}
                      onClick={() =>
                        handleAnswer(currentQuestion.question_bank.id, option)
                      }
                    >
                      <div className="flex items-center gap-3">
                        <Checkbox
                          checked={
                            answers[currentQuestion.question_bank.id] === option
                          }
                          onCheckedChange={() =>
                            handleAnswer(
                              currentQuestion.question_bank.id,
                              option
                            )
                          }
                        />
                        <span className="font-medium">{option}</span>
                      </div>
                    </div>
                  ))}
                </div>
              ) : currentQuestion.question_bank.question_type === "mcq" &&
                currentQuestion.question_bank.options &&
                Array.isArray(currentQuestion.question_bank.options) &&
                currentQuestion.question_bank.options.length > 0 ? (
                // MCQ Options
                <div className="space-y-2">
                  {currentQuestion.question_bank.options.map(
                    (option: any, index: number) => (
                      <div
                        key={index}
                        className={`p-3 border rounded-lg cursor-pointer transition-all ${
                          answers[currentQuestion.question_bank.id] ===
                          option.value
                            ? "border-primary bg-primary/5"
                            : "border-gray-200 hover:border-primary/50"
                        }`}
                        onClick={() =>
                          handleAnswer(
                            currentQuestion.question_bank.id,
                            option.value
                          )
                        }
                      >
                        <div className="flex items-center gap-3">
                          <Checkbox
                            checked={
                              answers[currentQuestion.question_bank.id] ===
                              option.value
                            }
                            onCheckedChange={() =>
                              handleAnswer(
                                currentQuestion.question_bank.id,
                                option.value
                              )
                            }
                          />
                          <span>{option.label || option.value}</span>
                        </div>
                      </div>
                    )
                  )}
                </div>
              ) : currentQuestion.question_bank.question_type ===
                "fill_blank" ? (
                // Fill in the Blank - Single line input
                <Input
                  className="w-full p-3 text-lg"
                  placeholder="Type your answer here..."
                  value={answers[currentQuestion.question_bank.id] || ""}
                  onChange={(e) =>
                    handleAnswer(
                      currentQuestion.question_bank.id,
                      e.target.value
                    )
                  }
                />
              ) : (
                // Subjective questions - Textarea
                <textarea
                  className="w-full min-h-32 p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary"
                  placeholder="Type your answer here..."
                  value={answers[currentQuestion.question_bank.id] || ""}
                  onChange={(e) =>
                    handleAnswer(
                      currentQuestion.question_bank.id,
                      e.target.value
                    )
                  }
                />
              )}
            </div>

            {/* Navigation */}
            <div className="flex justify-between items-center pt-4 border-t">
              <Button
                variant="outline"
                onClick={() =>
                  setCurrentQuestionIndex(Math.max(0, currentQuestionIndex - 1))
                }
                disabled={currentQuestionIndex === 0}
              >
                <ChevronLeft className="w-4 h-4 mr-2" />
                Previous
              </Button>

              {currentQuestionIndex === questions.length - 1 ? (
                <Button
                  className="bg-primary hover:bg-primary/90"
                  onClick={handleSubmit}
                >
                  Submit Quiz
                </Button>
              ) : (
                <Button
                  onClick={() =>
                    setCurrentQuestionIndex(
                      Math.min(questions.length - 1, currentQuestionIndex + 1)
                    )
                  }
                >
                  Next
                  <ChevronRight className="w-4 h-4 ml-2" />
                </Button>
              )}
            </div>
          </CardContent>
        </Card>
      )}

      {/* Question Grid Navigation */}
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
                onClick={() => setCurrentQuestionIndex(index)}
              >
                {index + 1}
              </button>
            ))}
          </div>
          <p className="text-xs text-muted-foreground mt-3">
            Answered: {Object.keys(answers).length} / {questions.length}
          </p>
        </CardContent>
      </Card>
    </div>
  );
}

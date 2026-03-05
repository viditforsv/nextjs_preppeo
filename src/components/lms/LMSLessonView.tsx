"use client";

import { useState, useEffect, useRef, useCallback, useMemo } from "react";
import Link from "next/link";
import { ChevronLeft, ChevronRight, BookOpen, Pencil, MessageCircle } from "lucide-react";
import { CollapsibleSidebar } from "@/design-system/components/layout-components/collapsible-sidebar";
import { CourseChatbot } from "./CourseChatbot";
import type { InteractiveStep, InteractiveQuizItem } from "./InteractiveLessonView";
import { Button } from "@/design-system/components/ui/button";
import { useQuestionAttempt } from "@/hooks/useQuestionAttempt";
import {
  PracticeQuestionsSidebar,
  type PracticeQuestionSidebarItem,
  type PracticeQuestionsFilters,
} from "./PracticeQuestionsSidebar";
import { TheoryPanel } from "./TheoryPanel";
import { PracticeQuestionCard } from "./PracticeQuestionCard";
import { CompletionCard } from "./CompletionCard";
import { PracticeNavFooter } from "./PracticeNavFooter";
import { buildAskAIMessage, buildRecapMessage, resetQuestionState } from "./practiceHelpers";

interface Lesson {
  id: string;
  title: string;
  slug: string;
  lesson_order: number;
  is_preview: boolean;
  video_url?: string | null;
  lesson_type?: string | null;
  content?: string | null;
  solution_url?: string | null;
  concept_title?: string | null;
  concept_content?: string | null;
  formula_title?: string | null;
  formula_content?: string | null;
  chapter?: {
    id: string;
    chapter_name: string;
    chapter_order: number;
    unit?: { id: string; unit_name: string; unit_order: number };
  };
}

interface LMSLessonViewProps {
  courseSlug: string;
  courseId: string;
  courseTitle: string;
  lesson: Lesson;
  allLessons: Lesson[];
  isEnrolled: boolean;
  completedLessonIds: Set<string>;
  interactiveContent: { intro?: string | null; steps: InteractiveStep[]; quiz: InteractiveQuizItem[] } | null;
  onMarkComplete: () => Promise<void>;
  askAIMessage?: string | null;
  onAskAISent?: () => void;
  onAskAI?: (message: string) => void;
}

export function LMSLessonView({
  courseSlug,
  courseId,
  courseTitle,
  lesson,
  allLessons,
  isEnrolled,
  completedLessonIds,
  interactiveContent,
  onMarkComplete,
  askAIMessage,
  onAskAISent,
  onAskAI,
}: LMSLessonViewProps) {
  const [activeTab, setActiveTab] = useState<"theory" | "questions">("theory");
  const [revealedHints, setRevealedHints] = useState<Record<number, boolean>>({});
  const [selectedOptions, setSelectedOptions] = useState<Record<number, number>>({});
  const [submittedQuestions, setSubmittedQuestions] = useState<Record<number, boolean>>({});
  const [skippedQuestions, setSkippedQuestions] = useState<Record<number, boolean>>({});
  const [revealedExplanations, setRevealedExplanations] = useState<Record<number, boolean>>({});
  const [practiceQuestionIndex, setPracticeQuestionIndex] = useState(0);
  const [jumpInput, setJumpInput] = useState<string>("1");
  const [elapsedSeconds, setElapsedSeconds] = useState(0);
  const questionStartRef = useRef<number>(Date.now());
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const { recordAttempt } = useQuestionAttempt();
  const [questionsSidebarCollapsed, setQuestionsSidebarCollapsed] = useState(false);
  const [aiPanelCollapsed, setAiPanelCollapsed] = useState(false);
  const [showConfetti, setShowConfetti] = useState(false);
  const [practiceFilters, setPracticeFilters] = useState<PracticeQuestionsFilters>({
    difficulty: "",
    status: "",
  });
  const [practiceQuestionsData, setPracticeQuestionsData] = useState<{
    questions: PracticeQuestionSidebarItem[];
    chapterName: string | null;
  } | null>(null);

  const isInteractive =
    lesson.lesson_type === "interactive" &&
    interactiveContent &&
    (interactiveContent.steps?.length > 0 || interactiveContent.quiz?.length > 0);

  const currentIndex = allLessons.findIndex((l) => l.slug === lesson.slug);
  const prevLesson = currentIndex > 0 ? allLessons[currentIndex - 1] : null;
  const nextLesson = currentIndex >= 0 && currentIndex < allLessons.length - 1 ? allLessons[currentIndex + 1] : null;
  const unitName = lesson.chapter?.unit?.unit_name ?? "Course";
  const chapterName = lesson.chapter?.chapter_name ?? "Section";

  const steps = interactiveContent?.steps ?? [];
  const quiz = interactiveContent?.quiz ?? [];
  const conceptHtml = lesson.concept_content || (interactiveContent?.intro ?? "");
  const conceptTitle = lesson.concept_title || lesson.title;

  // Memoised filter-aware navigation values
  const hasFilter = !!(practiceFilters.difficulty || practiceFilters.status);

  const filteredIndices = useMemo<number[] | null>(
    () =>
      hasFilter && practiceQuestionsData
        ? practiceQuestionsData.questions.map((item) => item.order - 1)
        : null,
    [hasFilter, practiceQuestionsData],
  );

  const isFilteredMode = hasFilter && filteredIndices && filteredIndices.length > 0;

  const filteredListIndex = useMemo(
    () =>
      isFilteredMode && filteredIndices
        ? Math.max(0, filteredIndices.indexOf(practiceQuestionIndex))
        : 0,
    [isFilteredMode, filteredIndices, practiceQuestionIndex],
  );

  const navTotal = useMemo(
    () => (isFilteredMode ? filteredIndices!.length : quiz.length),
    [isFilteredMode, filteredIndices, quiz.length],
  );

  const navPosition = useMemo(
    () => (isFilteredMode ? filteredListIndex + 1 : practiceQuestionIndex + 1),
    [isFilteredMode, filteredListIndex, practiceQuestionIndex],
  );

  // Jump to first filtered question when current isn't in filtered list
  useEffect(() => {
    if (isFilteredMode && filteredIndices && !filteredIndices.includes(practiceQuestionIndex)) {
      setPracticeQuestionIndex(filteredIndices[0]);
    }
  }, [isFilteredMode, filteredIndices, practiceQuestionIndex]);

  // Per-question timer — stops when question is submitted
  useEffect(() => {
    questionStartRef.current = Date.now();
    setElapsedSeconds(0);
    if (timerRef.current) clearInterval(timerRef.current);

    const isAnswered =
      submittedQuestions[practiceQuestionIndex] !== undefined ||
      !!skippedQuestions[practiceQuestionIndex];
    if (isAnswered) return;

    timerRef.current = setInterval(() => {
      setElapsedSeconds((s) => s + 1);
    }, 1000);
    return () => {
      if (timerRef.current) clearInterval(timerRef.current);
      timerRef.current = null;
    };
  }, [practiceQuestionIndex, submittedQuestions, skippedQuestions]);

  // Sync jump input with navigation position
  useEffect(() => {
    setJumpInput(String(navPosition));
  }, [navPosition]);

  const getElapsedForRecording = () =>
    Math.floor((Date.now() - questionStartRef.current) / 1000);

  // Derived completion state
  const scoreCorrect = Object.values(submittedQuestions).filter(Boolean).length;
  const skippedCount = Object.values(skippedQuestions).filter(Boolean).length;
  const allAnswered =
    quiz.length > 0 &&
    quiz.every((_, idx) => submittedQuestions[idx] !== undefined || !!skippedQuestions[idx]);
  const allCorrect = allAnswered && scoreCorrect === quiz.length;

  // ── Shared helpers ──

  const fetchPracticeQuestions = useCallback(async () => {
    if (!lesson.id || quiz.length === 0) return;
    try {
      const params = new URLSearchParams();
      if (practiceFilters.difficulty) params.set("difficulty", practiceFilters.difficulty);
      if (practiceFilters.status) params.set("status", practiceFilters.status);
      const res = await fetch(`/api/lessons/${lesson.id}/practice-questions?${params.toString()}`);
      if (!res.ok) return;
      const data = await res.json();
      setPracticeQuestionsData({
        questions: data.questions ?? [],
        chapterName: data.chapterName ?? null,
      });
    } catch {
      setPracticeQuestionsData({ questions: [], chapterName: null });
    }
  }, [lesson.id, quiz.length, practiceFilters.difficulty, practiceFilters.status]);

  useEffect(() => {
    if (activeTab === "questions" && lesson.id && quiz.length > 0) {
      fetchPracticeQuestions();
    } else {
      setPracticeQuestionsData(null);
    }
  }, [activeTab, lesson.id, quiz.length, fetchPracticeQuestions]);

  useEffect(() => {
    if (allCorrect) {
      setShowConfetti(true);
      const t = setTimeout(() => setShowConfetti(false), 3000);
      return () => clearTimeout(t);
    }
  }, [allCorrect]);

  const navigatePractice = useCallback(
    (direction: "prev" | "next") => {
      if (isFilteredMode && filteredIndices && filteredIndices.length > 0) {
        const delta = direction === "next" ? 1 : -1;
        const targetIdx = Math.max(0, Math.min(filteredIndices.length - 1, filteredListIndex + delta));
        setPracticeQuestionIndex(filteredIndices[targetIdx]);
      } else {
        setPracticeQuestionIndex((idx) =>
          direction === "next" ? Math.min(quiz.length - 1, idx + 1) : Math.max(0, idx - 1),
        );
      }
    },
    [isFilteredMode, filteredIndices, filteredListIndex, quiz.length],
  );

  const handleSubmitAnswer = useCallback(
    async (questionIdx: number) => {
      const q = quiz[questionIdx];
      const selected = selectedOptions[questionIdx];
      if (selected === undefined || !q) return;

      const correctIndex = Math.min(q.answer ?? 0, (q.options?.length ?? 1) - 1);
      const timeTaken = getElapsedForRecording();

      if (q.id) {
        await recordAttempt({
          questionId: q.id,
          lessonId: lesson.id,
          courseId,
          timeSpentSeconds: timeTaken,
          isCorrect: selected === correctIndex,
          hintUsed: !!revealedHints[questionIdx],
          skipped: false,
        });
        fetchPracticeQuestions();
      }

      // Stop timer
      if (timerRef.current) {
        clearInterval(timerRef.current);
        timerRef.current = null;
      }

      setSubmittedQuestions((s) => ({ ...s, [questionIdx]: selected === correctIndex }));
      if (selected !== correctIndex) {
        setRevealedExplanations((e) => ({ ...e, [questionIdx]: true }));
      }
    },
    [quiz, selectedOptions, revealedHints, lesson.id, courseId, recordAttempt, fetchPracticeQuestions],
  );

  const handleSkipQuestion = useCallback(
    async (questionIdx: number) => {
      const q = quiz[questionIdx];
      if (!q) return;

      const timeTaken = getElapsedForRecording();
      if (q.id) {
        await recordAttempt({
          questionId: q.id,
          lessonId: lesson.id,
          courseId,
          timeSpentSeconds: timeTaken,
          isCorrect: false,
          skipped: true,
        });
        fetchPracticeQuestions();
      }

      if (timerRef.current) {
        clearInterval(timerRef.current);
        timerRef.current = null;
      }

      setSkippedQuestions((s) => ({ ...s, [questionIdx]: true }));
    },
    [quiz, lesson.id, courseId, recordAttempt, fetchPracticeQuestions],
  );

  const handleRetryQuestion = useCallback(
    (questionIdx: number) => {
      resetQuestionState(questionIdx, {
        setSubmittedQuestions,
        setSkippedQuestions,
        setSelectedOptions,
        setRevealedExplanations,
        setRevealedHints,
      });
    },
    [],
  );

  const handleReviewWrong = useCallback(() => {
    const firstWrong = quiz.findIndex(
      (_, idx) => submittedQuestions[idx] === false || !!skippedQuestions[idx],
    );
    if (firstWrong >= 0) setPracticeQuestionIndex(firstWrong);

    const newSubmitted = { ...submittedQuestions };
    const newSkipped = { ...skippedQuestions };
    quiz.forEach((_, idx) => {
      if (submittedQuestions[idx] === false || skippedQuestions[idx]) {
        delete newSubmitted[idx];
        delete newSkipped[idx];
      }
    });
    setSubmittedQuestions(newSubmitted);
    setSkippedQuestions(newSkipped);
    setSelectedOptions({});
    setRevealedExplanations({});
    setRevealedHints({});
  }, [quiz, submittedQuestions, skippedQuestions]);

  // Keyboard shortcuts
  const handleKeyDown = useCallback(
    (e: KeyboardEvent) => {
      if (activeTab !== "questions" || quiz.length === 0) return;
      const target = e.target as HTMLElement;
      if (target.tagName === "INPUT" || target.tagName === "TEXTAREA") return;

      const i = Math.min(practiceQuestionIndex, quiz.length - 1);
      const submitted = submittedQuestions[i] !== undefined || !!skippedQuestions[i];

      if (!submitted) {
        const q = quiz[i];
        const optCount = q?.options?.length ?? 0;
        if (e.key === "a" || e.key === "A") setSelectedOptions((s) => ({ ...s, [i]: 0 }));
        else if (e.key === "b" || e.key === "B") setSelectedOptions((s) => ({ ...s, [i]: 1 }));
        else if ((e.key === "c" || e.key === "C") && optCount > 2) setSelectedOptions((s) => ({ ...s, [i]: 2 }));
        else if ((e.key === "d" || e.key === "D") && optCount > 3) setSelectedOptions((s) => ({ ...s, [i]: 3 }));
        else if (e.key === "h" || e.key === "H") setRevealedHints((h) => ({ ...h, [i]: !h[i] }));
        else if (e.key === "Enter") handleSubmitAnswer(i);
      }

      if (e.key === "ArrowRight") navigatePractice("next");
      else if (e.key === "ArrowLeft") navigatePractice("prev");
    },
    [activeTab, quiz, practiceQuestionIndex, submittedQuestions, skippedQuestions, handleSubmitAnswer, navigatePractice],
  );

  useEffect(() => {
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [handleKeyDown]);

  // ── Sidebar items for PracticeQuestionsSidebar ──

  const sidebarItems = useMemo(() => {
    if ((practiceQuestionsData?.questions?.length ?? 0) > 0) {
      return practiceQuestionsData!.questions.map((item) => {
        const idx = item.order - 1;
        const hasSession = submittedQuestions[idx] !== undefined || skippedQuestions[idx];
        return {
          ...item,
          question: item.question ?? quiz[idx]?.question ?? null,
          ...(hasSession
            ? {
                lastAttempt: {
                  time_taken_seconds: 0,
                  is_correct: !!submittedQuestions[idx],
                  skipped: !!skippedQuestions[idx],
                  hint_used: false,
                },
              }
            : {}),
        };
      });
    }
    return quiz.map((qItem, idx) => {
      const diffNum =
        qItem?.difficulty === "Easy" ? 2 : qItem?.difficulty === "Medium" ? 5 : qItem?.difficulty === "Hard" ? 8 : null;
      return {
        order: idx + 1,
        question_id: null,
        difficulty: diffNum,
        topic: null,
        question: qItem?.question ?? null,
        lastAttempt:
          submittedQuestions[idx] !== undefined || skippedQuestions[idx]
            ? {
                time_taken_seconds: 0,
                is_correct: !!submittedQuestions[idx],
                skipped: !!skippedQuestions[idx],
                hint_used: false,
              }
            : undefined,
      };
    });
  }, [practiceQuestionsData, quiz, submittedQuestions, skippedQuestions]);

  // Current question for rendering
  const qIdx = Math.min(practiceQuestionIndex, quiz.length - 1);
  const currentQ = quiz[qIdx];

  return (
    <div className="flex h-screen overflow-hidden bg-[#f4f3f0]" data-template="lms-interactive">
      <CollapsibleSidebar
        currentLessonSlug={lesson.slug}
        courseSlug={courseSlug}
        lessons={allLessons}
        isEnrolled={isEnrolled}
        completedLessonIds={completedLessonIds}
        courseId={courseId}
        basePath="/learn"
      />

      <div className="flex flex-1 flex-col min-w-0 min-h-0">
        {/* Topbar */}
        <div className="flex h-12 shrink-0 items-center gap-4 border-b border-[#eae8e2] bg-white px-5">
          <nav className="flex items-center gap-1.5 text-sm text-[#8b8880]">
            <Link href={`/learn/${courseSlug}`} className="hover:text-[#1a1a2e]">
              {courseTitle}
            </Link>
            <span aria-hidden>›</span>
            <span className="text-[#8b8880]">{unitName}</span>
            <span aria-hidden>›</span>
            <span className="text-[#8b8880]">{chapterName}</span>
            <span aria-hidden>›</span>
            <span className="font-semibold text-[#1a1a2e]">{lesson.title}</span>
          </nav>
          <div className="ml-auto flex gap-2">
            {prevLesson ? (
              <Button variant="outline" size="sm" asChild className="rounded-lg border-[#eae8e2] bg-[#f4f3f0] text-[#5a5860]">
                <Link href={`/learn/${courseSlug}/lesson/${prevLesson.slug}`}>
                  <ChevronLeft className="h-4 w-4 mr-1" /> Prev
                </Link>
              </Button>
            ) : (
              <Button variant="outline" size="sm" disabled className="rounded-lg">
                <ChevronLeft className="h-4 w-4 mr-1" /> Prev
              </Button>
            )}
            {nextLesson ? (
              <Button size="sm" asChild className="rounded-lg bg-[#f59207] text-white hover:bg-[#e08a00]">
                <Link href={`/learn/${courseSlug}/lesson/${nextLesson.slug}`}>
                  Next <ChevronRight className="h-4 w-4 ml-1" />
                </Link>
              </Button>
            ) : (
              <Button size="sm" className="rounded-lg bg-[#f59207] text-white" onClick={() => onMarkComplete()}>
                Mark complete
              </Button>
            )}
          </div>
        </div>

        {/* Panels: content + AI chat */}
        <div className="flex flex-1 min-h-0">
          <div className="flex flex-1 flex-col min-w-0 min-h-0 border-r border-[#eae8e2] bg-[#f9f8f5]">
            {/* Tabs */}
            <div className="flex shrink-0 border-b border-[#eae8e2] bg-white">
              <button
                type="button"
                onClick={() => setActiveTab("theory")}
                className={`flex-1 py-3 px-4 text-center text-sm font-semibold transition-colors flex items-center justify-center gap-2 ${
                  activeTab === "theory"
                    ? "border-b-2 border-[#f59207] bg-white text-[#f59207]"
                    : "text-[#8b8880] hover:bg-[#faf9f6] hover:text-[#1a1a2e]"
                }`}
              >
                <BookOpen className="h-4 w-4" /> Theory
              </button>
              <button
                type="button"
                onClick={() => setActiveTab("questions")}
                className={`flex-1 py-3 px-4 text-center text-sm font-semibold transition-colors flex items-center justify-center gap-2 ${
                  activeTab === "questions"
                    ? "border-b-2 border-[#f59207] bg-white text-[#f59207]"
                    : "text-[#8b8880] hover:bg-[#faf9f6] hover:text-[#1a1a2e]"
                }`}
              >
                <Pencil className="h-4 w-4" /> Practice Questions
                {quiz.length > 0 && (
                  <span className="ml-1.5 rounded-full bg-[#fff8ee] px-2 py-0.5 text-xs font-bold tabular-nums text-[#b45309]">
                    {scoreCorrect}/{quiz.length} correct
                  </span>
                )}
              </button>
            </div>

            {/* Tab content */}
            <div className={`flex-1 ${activeTab === "theory" ? "overflow-y-auto p-5" : "overflow-hidden"}`}>
              {activeTab === "theory" ? (
                <TheoryPanel
                  lessonId={lesson.id}
                  lessonTitle={lesson.title}
                  conceptTitle={conceptTitle}
                  conceptHtml={conceptHtml}
                  steps={steps}
                  formulaTitle={lesson.formula_title}
                  formulaContent={lesson.formula_content}
                  videoUrl={lesson.video_url}
                  isInteractive={!!isInteractive}
                  hasQuiz={quiz.length > 0}
                  onSwitchToQuestions={() => setActiveTab("questions")}
                />
              ) : (
                <div className="flex min-h-0 flex-1 flex-col">
                  {quiz.length === 0 ? (
                    <p className="text-sm text-[#8b8880] p-5">No practice questions for this lesson yet.</p>
                  ) : (
                    <div className="flex min-h-0 flex-1">
                      <PracticeQuestionsSidebar
                        items={sidebarItems}
                        currentIndex={practiceQuestionIndex}
                        onSelectQuestion={(order) => setPracticeQuestionIndex(order - 1)}
                        filters={practiceFilters}
                        onFilterChange={(f) => setPracticeFilters((prev) => ({ ...prev, ...f }))}
                        chapterName={practiceQuestionsData?.chapterName ?? lesson.chapter?.chapter_name ?? null}
                        onRefresh={fetchPracticeQuestions}
                        collapsed={questionsSidebarCollapsed}
                        onToggleCollapsed={() => setQuestionsSidebarCollapsed((c) => !c)}
                        scoreCorrect={scoreCorrect}
                        scoreTotal={quiz.length}
                      />
                      <div className="flex flex-1 flex-col min-h-0">
                        <div className="flex-1 overflow-y-auto p-5 flex flex-col gap-4">
                          {/* Empty filter state */}
                          {hasFilter && (practiceQuestionsData?.questions?.length ?? 0) === 0 ? (
                            <div className="flex flex-1 flex-col items-center justify-center py-12 text-center">
                              <p className="text-sm text-[#6b6966] mb-4">
                                No questions match your filters. Try changing difficulty or status, or clear filters to see all questions.
                              </p>
                              <Button
                                variant="outline"
                                size="sm"
                                className="rounded-lg"
                                onClick={() => setPracticeFilters({ difficulty: "", status: "" })}
                              >
                                Clear filters
                              </Button>
                            </div>
                          ) : (
                            <>
                              {/* Confetti */}
                              {showConfetti && (
                                <div className="pointer-events-none fixed inset-0 z-50 overflow-hidden">
                                  {Array.from({ length: 24 }).map((_, ci) => (
                                    <div
                                      key={ci}
                                      className="absolute top-0 animate-confetti-fall"
                                      style={{
                                        left: `${Math.random() * 100}%`,
                                        animationDelay: `${Math.random() * 1.5}s`,
                                        animationDuration: `${1.5 + Math.random() * 1.5}s`,
                                        fontSize: `${12 + Math.random() * 10}px`,
                                      }}
                                    >
                                      {["🎉", "⭐", "🌟", "✨", "🎊"][ci % 5]}
                                    </div>
                                  ))}
                                </div>
                              )}

                              {/* Completion or active question */}
                              {allAnswered ? (
                                <CompletionCard
                                  scoreCorrect={scoreCorrect}
                                  quizLength={quiz.length}
                                  skippedCount={skippedCount}
                                  courseSlug={courseSlug}
                                  nextLessonSlug={nextLesson?.slug}
                                  onReviewWrong={handleReviewWrong}
                                  onAskRecap={() =>
                                    onAskAI?.(buildRecapMessage(lesson.title, quiz, submittedQuestions, skippedQuestions, scoreCorrect))
                                  }
                                />
                              ) : currentQ ? (
                                <PracticeQuestionCard
                                  question={currentQ}
                                  questionIndex={qIdx}
                                  navPosition={navPosition}
                                  navTotal={navTotal}
                                  elapsedSeconds={elapsedSeconds}
                                  selectedOption={selectedOptions[qIdx]}
                                  isSubmitted={submittedQuestions[qIdx] !== undefined || !!skippedQuestions[qIdx]}
                                  isCorrect={submittedQuestions[qIdx] === true}
                                  isSkipped={!!skippedQuestions[qIdx]}
                                  hintRevealed={!!revealedHints[qIdx]}
                                  explanationRevealed={!!revealedExplanations[qIdx]}
                                  onSelectOption={(oi) => setSelectedOptions((s) => ({ ...s, [qIdx]: oi }))}
                                  onSubmit={() => handleSubmitAnswer(qIdx)}
                                  onSkip={() => handleSkipQuestion(qIdx)}
                                  onToggleHint={() => setRevealedHints((h) => ({ ...h, [qIdx]: !h[qIdx] }))}
                                  onToggleExplanation={() => setRevealedExplanations((e) => ({ ...e, [qIdx]: !e[qIdx] }))}
                                  onAskAI={onAskAI}
                                  onRetry={() => handleRetryQuestion(qIdx)}
                                />
                              ) : null}

                              {/* Navigation footer */}
                              <PracticeNavFooter
                                navPosition={navPosition}
                                navTotal={navTotal}
                                jumpInput={jumpInput}
                                onJumpInputChange={setJumpInput}
                                onJumpTo={(pos) => {
                                  if (isFilteredMode && filteredIndices && filteredIndices.length > 0) {
                                    setPracticeQuestionIndex(filteredIndices[pos - 1]);
                                  } else {
                                    setPracticeQuestionIndex(pos - 1);
                                  }
                                }}
                                onPrev={() => navigatePractice("prev")}
                                onNext={() => navigatePractice("next")}
                                isPrevDisabled={isFilteredMode ? filteredListIndex === 0 : practiceQuestionIndex === 0}
                                isNextDisabled={isFilteredMode ? filteredListIndex >= navTotal - 1 : practiceQuestionIndex >= quiz.length - 1}
                              />
                            </>
                          )}
                        </div>
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          </div>

          {/* AI Tutor panel */}
          {aiPanelCollapsed ? (
            <div className="flex w-10 shrink-0 flex-col items-center border-l border-[#eae8e2] bg-white py-3 gap-2">
              <button
                type="button"
                onClick={() => setAiPanelCollapsed(false)}
                title="Open AI Tutor"
                className="rounded-lg p-1.5 text-[#8b8880] hover:bg-[#f5f4f1] hover:text-[#1a1a2e] transition-colors"
              >
                <MessageCircle className="h-4 w-4" />
              </button>
              <span
                className="text-[9px] font-bold uppercase tracking-wider text-[#c8c5bf] select-none"
                style={{ writingMode: "vertical-rl", transform: "rotate(180deg)" }}
              >
                AI Tutor
              </span>
            </div>
          ) : (
            <div className="flex h-full min-h-0 w-[280px] min-w-[260px] max-w-full flex-col shrink-0 overflow-hidden bg-white sm:w-[300px] md:w-[320px] lg:w-[360px]">
              <CourseChatbot
                courseTitle={courseTitle}
                lessonTitle={lesson.title}
                isOpen={true}
                onToggle={() => {}}
                embedded={true}
                messageToSend={askAIMessage}
                onMessageSent={onAskAISent}
                activePracticeLabel={quiz.length > 0 ? `Help with Q${practiceQuestionIndex + 1}` : undefined}
                onAskAboutPractice={
                  quiz.length > 0 && onAskAI && currentQ
                    ? () => onAskAI(buildAskAIMessage(currentQ))
                    : undefined
                }
                onCollapsePanel={() => setAiPanelCollapsed(true)}
              />
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

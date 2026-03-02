"use client";

import { useState, useEffect, useRef, useCallback } from "react";
import Link from "next/link";
import { ChevronLeft, ChevronRight, BookOpen, FileText, ExternalLink, Pencil, MessageCircle } from "lucide-react";
import { CollapsibleSidebar } from "@/design-system/components/layout-components/collapsible-sidebar";
import { VideoResource } from "@/design-system/components/youtube-video";
import { CourseChatbot } from "./CourseChatbot";
import type { InteractiveStep, InteractiveQuizItem } from "./InteractiveLessonView";
import { Button } from "@/design-system/components/ui/button";
import { useQuestionAttempt } from "@/hooks/useQuestionAttempt";
import {
  PracticeQuestionsSidebar,
  type PracticeQuestionSidebarItem,
  type PracticeQuestionsFilters,
} from "./PracticeQuestionsSidebar";

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
  /** For "Ask AI" from practice: message to send to chatbot. Parent clears via onAskAISent. */
  askAIMessage?: string | null;
  onAskAISent?: () => void;
  /** Called when user clicks "Ask AI" on a practice question; parent should set askAIMessage. */
  onAskAI?: (message: string) => void;
}

function renderSimpleMd(text: string) {
  return text
    .replace(/\*\*(.+?)\*\*/g, "<strong>$1</strong>")
    .replace(/\n/g, "<br/>");
}

// comm.md-style difficulty colors (Easy / Medium / Hard)
const DIFF = {
  Easy: { text: "#15803d", bg: "#f0fdf4", border: "#86efac" },
  Medium: { text: "#b45309", bg: "#fffbeb", border: "#fcd34d" },
  Hard: { text: "#dc2626", bg: "#fef2f2", border: "#fca5a5" },
} as const;
type DiffKey = keyof typeof DIFF;

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
  const [revealedAnswers, setRevealedAnswers] = useState<Record<number, boolean>>({});
  const [selectedOptions, setSelectedOptions] = useState<Record<number, number>>({});
  const [submittedQuestions, setSubmittedQuestions] = useState<Record<number, boolean>>({});
  const [skippedQuestions, setSkippedQuestions] = useState<Record<number, boolean>>({});
  const [revealedExplanations, setRevealedExplanations] = useState<Record<number, boolean>>({});
  const [practiceQuestionIndex, setPracticeQuestionIndex] = useState(0);
  const [elapsedSeconds, setElapsedSeconds] = useState(0);
  const questionStartRef = useRef<number>(Date.now());
  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const { recordAttempt } = useQuestionAttempt();
  const [questionsSidebarCollapsed, setQuestionsSidebarCollapsed] = useState(false);
  const [aiPanelCollapsed, setAiPanelCollapsed] = useState(false);
  const [stepsDone, setStepsDone] = useState<Record<number, boolean>>({});
  const [showConfetti, setShowConfetti] = useState(false);
  const [practiceFilters, setPracticeFilters] = useState<PracticeQuestionsFilters>({
    difficulty: "",
    timeBucket: "",
    topic: "",
    chapter: "",
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
  const conceptHtml =
    lesson.concept_content ||
    (interactiveContent?.intro ?? "");
  const conceptTitle = lesson.concept_title || lesson.title;

  // Per-question timer: reset when question index changes
  useEffect(() => {
    questionStartRef.current = Date.now();
    setElapsedSeconds(0);
    if (timerRef.current) clearInterval(timerRef.current);
    timerRef.current = setInterval(() => {
      setElapsedSeconds((s) => s + 1);
    }, 1000);
    return () => {
      if (timerRef.current) clearInterval(timerRef.current);
      timerRef.current = null;
    };
  }, [practiceQuestionIndex]);

  const getElapsedForRecording = () =>
    Math.floor((Date.now() - questionStartRef.current) / 1000);

  // Derive completion state
  const scoreCorrect = Object.values(submittedQuestions).filter(Boolean).length;
  const allAnswered =
    quiz.length > 0 &&
    quiz.every((_, idx) => submittedQuestions[idx] !== undefined || !!skippedQuestions[idx]);
  const allCorrect = allAnswered && scoreCorrect === quiz.length;

  // Hint = first sentence of explanation (partial clue, not full answer)
  const getHintText = (explanation: string) => {
    const match = explanation.match(/^[^.!?]+[.!?]/);
    return match ? match[0].trim() : explanation;
  };

  const fetchPracticeQuestions = async () => {
    if (!lesson.id || quiz.length === 0) return;
    try {
      const params = new URLSearchParams();
      if (practiceFilters.difficulty) params.set("difficulty", practiceFilters.difficulty);
      if (practiceFilters.timeBucket) params.set("timeBucket", practiceFilters.timeBucket);
      if (practiceFilters.topic) params.set("topic", practiceFilters.topic);
      if (practiceFilters.chapter) params.set("chapter", practiceFilters.chapter);
      const res = await fetch(
        `/api/lessons/${lesson.id}/practice-questions?${params.toString()}`
      );
      if (!res.ok) return;
      const data = await res.json();
      setPracticeQuestionsData({
        questions: data.questions ?? [],
        chapterName: data.chapterName ?? null,
      });
    } catch {
      setPracticeQuestionsData({ questions: [], chapterName: null });
    }
  };

  useEffect(() => {
    if (activeTab === "questions" && lesson.id && quiz.length > 0) {
      fetchPracticeQuestions();
    } else {
      setPracticeQuestionsData(null);
    }
  }, [activeTab, lesson.id, practiceFilters.difficulty, practiceFilters.timeBucket, practiceFilters.topic, practiceFilters.chapter]);

  // Confetti when all correct
  useEffect(() => {
    if (allCorrect) {
      setShowConfetti(true);
      const t = setTimeout(() => setShowConfetti(false), 3000);
      return () => clearTimeout(t);
    }
  }, [allCorrect]);

  // Keyboard shortcuts for practice questions
  const handleKeyDown = useCallback(
    (e: KeyboardEvent) => {
      if (activeTab !== "questions" || quiz.length === 0) return;
      // Ignore when typing in inputs
      const target = e.target as HTMLElement;
      if (target.tagName === "INPUT" || target.tagName === "TEXTAREA") return;

      const i = Math.min(practiceQuestionIndex, quiz.length - 1);
      const submitted = submittedQuestions[i] !== undefined || !!skippedQuestions[i];

      if (!submitted) {
        const q = quiz[i];
        const opts = q?.options?.length ? q.options : [];
        if (e.key === "a" || e.key === "A") setSelectedOptions((s) => ({ ...s, [i]: 0 }));
        else if (e.key === "b" || e.key === "B") setSelectedOptions((s) => ({ ...s, [i]: 1 }));
        else if (e.key === "c" || e.key === "C") setSelectedOptions((s) => ({ ...s, [i]: opts.length > 2 ? 2 : s[i] }));
        else if (e.key === "d" || e.key === "D") setSelectedOptions((s) => ({ ...s, [i]: opts.length > 3 ? 3 : s[i] }));
        else if (e.key === "h" || e.key === "H") setRevealedHints((h) => ({ ...h, [i]: !h[i] }));
        else if (e.key === "Enter") {
          const sel = selectedOptions[i];
          if (sel !== undefined && q) {
            const correctIndex = Math.min(q.answer ?? 0, opts.length - 1);
            (async () => {
              const timeTaken = getElapsedForRecording();
              if (q.id) {
                await recordAttempt({
                  questionId: q.id,
                  lessonId: lesson.id,
                  courseId,
                  timeSpentSeconds: timeTaken,
                  isCorrect: sel === correctIndex,
                  skipped: false,
                });
                fetchPracticeQuestions();
              }
              setSubmittedQuestions((s) => ({ ...s, [i]: sel === correctIndex }));
              if (sel !== correctIndex) setRevealedExplanations((ex) => ({ ...ex, [i]: true }));
            })();
          }
        }
      }

      if (e.key === "ArrowRight") setPracticeQuestionIndex((idx) => Math.min(quiz.length - 1, idx + 1));
      else if (e.key === "ArrowLeft") setPracticeQuestionIndex((idx) => Math.max(0, idx - 1));
    },
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [activeTab, quiz, practiceQuestionIndex, submittedQuestions, skippedQuestions, selectedOptions]
  );

  useEffect(() => {
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [handleKeyDown]);

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

      <div className="flex flex-1 flex-col min-w-0">
        {/* Topbar: breadcrumb + Prev/Next */}
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

        {/* Panels: left (theory/questions) + right (chat) */}
        <div className="flex flex-1 min-h-0">
          <div className="flex flex-1 flex-col min-w-0 border-r border-[#eae8e2] bg-[#f9f8f5]">
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

            <div className="flex-1 overflow-y-auto p-5">
              {activeTab === "theory" ? (
                <>
                  <h1 className="text-xl font-extrabold text-[#1a1a2e] tracking-tight mb-4">{conceptTitle}</h1>
                  {conceptHtml && (
                    <div
                      className="rounded-xl border border-[#eae8e2] bg-white p-5 mb-4 text-[#3a3840] text-[13.5px] leading-relaxed [&_strong]:text-[#1a1a2e]"
                      dangerouslySetInnerHTML={{ __html: renderSimpleMd(conceptHtml) }}
                    />
                  )}
                  {steps.length > 0 && (
                    <>
                      <div className="text-xs font-bold uppercase tracking-wider text-[#1a1a2e] mb-2">Step-by-step method</div>
                      <div className="flex flex-col gap-2 mb-5">
                        {steps.map((s, i) => (
                          <div
                            key={i}
                            className={`flex items-start gap-3 rounded-lg border p-3 transition-colors ${
                              stepsDone[i]
                                ? "border-[#86efac] bg-[#f0fdf4]"
                                : "border-[#eae8e2] bg-white"
                            }`}
                          >
                            <div
                              className={`flex h-7 w-7 shrink-0 items-center justify-center rounded-full text-xs font-extrabold text-white ${
                                stepsDone[i] ? "bg-[#22c55e]" : "bg-[#f59207]"
                              }`}
                            >
                              {stepsDone[i] ? "✓" : i + 1}
                            </div>
                            <div className="flex-1 min-w-0">
                              <h4 className="text-sm font-bold text-[#1a1a2e]">{s.title}</h4>
                              <p className="text-xs text-[#6b6870]">{s.content}</p>
                            </div>
                            {!stepsDone[i] && (
                              <button
                                type="button"
                                onClick={() => setStepsDone((d) => ({ ...d, [i]: true }))}
                                className="shrink-0 rounded-md border border-[#eae8e2] bg-white px-2 py-1 text-[10px] font-semibold text-[#9a9690] hover:border-[#86efac] hover:bg-[#f0fdf4] hover:text-[#15803d] transition-colors"
                              >
                                Got it ✓
                              </button>
                            )}
                          </div>
                        ))}
                      </div>
                    </>
                  )}
                  {(lesson.formula_title || lesson.formula_content) && (
                    <div className="rounded-xl border border-[#fde9b8] bg-linear-to-br from-[#fff8ee] to-white p-5">
                      <div className="text-[11px] font-bold uppercase tracking-widest text-[#f59207] mb-2">
                        {lesson.formula_title || "Key formula"}
                      </div>
                      <div className="font-mono text-sm text-[#3a3840] whitespace-pre-wrap border-l-2 border-[#f59207] pl-3 py-1 bg-white rounded">
                        {lesson.formula_content}
                      </div>
                    </div>
                  )}
                  {lesson.video_url && !isInteractive && (
                    <div className="mt-4">
                      <VideoResource
                        resource={{
                          id: lesson.id,
                          type: "video",
                          url: lesson.video_url,
                          title: lesson.title,
                          thumbnail: undefined,
                        }}
                        lessonId={lesson.id}
                      />
                    </div>
                  )}
                  {lesson.solution_url && (
                    <a
                      href={lesson.solution_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="inline-flex items-center gap-2 mt-4 text-sm text-[#f59207] font-semibold hover:underline"
                    >
                      <FileText className="h-4 w-4" /> View solution <ExternalLink className="h-3 w-3" />
                    </a>
                  )}
                  {!conceptHtml && steps.length === 0 && !lesson.formula_content && !lesson.video_url && (
                    <p className="text-sm text-[#8b8880]">No theory content for this lesson yet.</p>
                  )}
                  {quiz.length > 0 && (
                    <div className="mt-6 flex justify-end">
                      <button
                        type="button"
                        onClick={() => setActiveTab("questions")}
                        className="inline-flex items-center gap-2 rounded-xl border-2 border-[#f59207] bg-[#f59207] px-5 py-2.5 text-sm font-bold text-white shadow-sm transition-all hover:bg-[#e08a00] hover:shadow-md active:scale-[0.97]"
                      >
                        Ready to practice <ChevronRight className="h-4 w-4" />
                      </button>
                    </div>
                  )}
                </>
              ) : (
                <div className="flex min-h-0 flex-1 flex-col">
                  {quiz.length === 0 ? (
                    <p className="text-sm text-[#8b8880]">No practice questions for this lesson yet.</p>
                  ) : (
                    <div className="flex min-h-0 flex-1">
                      <PracticeQuestionsSidebar
                        items={
                          (practiceQuestionsData?.questions?.length ?? 0) > 0
                            ? practiceQuestionsData!.questions.map((item) => {
                                const idx = item.order - 1;
                                const hasSession =
                                  submittedQuestions[idx] !== undefined || skippedQuestions[idx];
                                return {
                                  ...item,
                                  question: item.question ?? quiz[idx]?.question ?? null,
                                  ...(hasSession
                                    ? {
                                        lastAttempt: {
                                          time_taken_seconds: 0,
                                          is_correct: !!submittedQuestions[idx],
                                          skipped: !!skippedQuestions[idx],
                                        },
                                      }
                                    : {}),
                                };
                              })
                            : quiz.map((_, idx) => {
                                const qItem = quiz[idx];
                                const diffNum =
                                  qItem?.difficulty === "Easy"
                                    ? 2
                                    : qItem?.difficulty === "Medium"
                                      ? 5
                                      : qItem?.difficulty === "Hard"
                                        ? 8
                                        : null;
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
                                      }
                                    : undefined,
                              };
                            })
                        }
                        currentIndex={practiceQuestionIndex}
                        onSelectQuestion={(order) => setPracticeQuestionIndex(order - 1)}
                        filters={practiceFilters}
                        onFilterChange={(f) => setPracticeFilters((prev) => ({ ...prev, ...f }))}
                        chapterName={practiceQuestionsData?.chapterName ?? lesson.chapter?.chapter_name ?? null}
                        onRefresh={fetchPracticeQuestions}
                        collapsed={questionsSidebarCollapsed}
                        onToggleCollapsed={() => setQuestionsSidebarCollapsed((c) => !c)}
                        scoreCorrect={Object.values(submittedQuestions).filter(Boolean).length}
                        scoreTotal={quiz.length}
                      />
                      <div className="flex flex-1 flex-col gap-4 overflow-y-auto p-5">
                      {/* Confetti overlay */}
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
                      {/* Completion card when all questions answered */}
                      {allAnswered ? (
                        <div className="rounded-xl border-2 border-[#86efac] bg-linear-to-br from-[#f0fdf4] to-white p-6 text-center shadow-sm">
                          <div className="mb-3 text-4xl">
                            {allCorrect ? "🎉" : scoreCorrect >= Math.ceil(quiz.length / 2) ? "👍" : "💪"}
                          </div>
                          <h3 className="mb-1 text-lg font-extrabold text-[#15803d]">
                            {allCorrect
                              ? "Perfect score!"
                              : scoreCorrect >= Math.ceil(quiz.length / 2)
                              ? "Good work!"
                              : "Keep going!"}
                          </h3>
                          <p className="mb-5 text-sm text-[#6b6966]">
                            You got <strong className="text-[#1c1b1f]">{scoreCorrect} out of {quiz.length}</strong> correct
                            {quiz.length - scoreCorrect - Object.values(skippedQuestions).filter(Boolean).length > 0
                              ? ` · ${quiz.length - scoreCorrect - Object.values(skippedQuestions).filter(Boolean).length} wrong`
                              : ""}
                            {Object.values(skippedQuestions).filter(Boolean).length > 0
                              ? ` · ${Object.values(skippedQuestions).filter(Boolean).length} skipped`
                              : ""}
                          </p>
                          <div className="flex flex-wrap justify-center gap-2">
                            {scoreCorrect < quiz.length && (
                              <button
                                type="button"
                                onClick={() => {
                                  const firstWrong = quiz.findIndex(
                                    (_, idx) => submittedQuestions[idx] === false || !!skippedQuestions[idx]
                                  );
                                  if (firstWrong >= 0) setPracticeQuestionIndex(firstWrong);
                                  // Clear wrong/skipped so user can retry
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
                                }}
                                className="inline-flex items-center gap-1.5 rounded-lg border-2 border-[#f59207] px-4 py-2 text-xs font-bold text-[#f59207] transition-all hover:bg-[#fff8ee] active:scale-[0.97]"
                              >
                                ↺ Review wrong answers
                              </button>
                            )}
                            <button
                              type="button"
                              onClick={() => {
                                const optsText = quiz
                                  .map((qq, qi) => {
                                    const correct = submittedQuestions[qi] === true;
                                    const skipped = !!skippedQuestions[qi];
                                    return `Q${qi + 1}: ${correct ? "✓" : skipped ? "–" : "✗"} ${qq.question}`;
                                  })
                                  .join("\n");
                                onAskAI?.(`I just finished the practice questions for "${lesson.title}". Score: ${scoreCorrect}/${quiz.length}. Can you give me a quick recap of the key concepts?\n\n${optsText}`);
                              }}
                              className="inline-flex items-center gap-1.5 rounded-lg border-2 border-[#c7d2fe] bg-[#eef2ff] px-4 py-2 text-xs font-bold text-[#4338ca] transition-all hover:bg-[#e0e7ff] active:scale-[0.97]"
                            >
                              🤖 Ask AI to recap
                            </button>
                            {nextLesson && (
                              <Button size="sm" asChild className="rounded-lg bg-[#f59207] text-white hover:bg-[#e08a00]">
                                <Link href={`/learn/${courseSlug}/lesson/${nextLesson.slug}`}>
                                  Next lesson <ChevronRight className="h-4 w-4 ml-1" />
                                </Link>
                              </Button>
                            )}
                          </div>
                        </div>
                      ) : null}
                      {!allAnswered && (() => {
                        const i = Math.min(practiceQuestionIndex, quiz.length - 1);
                        const q = quiz[i];
                        if (!q) return null;
                        const selected = selectedOptions[i];
                        const skipped = skippedQuestions[i];
                        const submitted = submittedQuestions[i] !== undefined || skipped;
                        const isCorrect = submittedQuestions[i] === true;
                        const opts = q.options?.length ? q.options : ["No options"];
                        const correctIndex = Math.min(q.answer ?? 0, opts.length - 1);

                        const optionLabel = (oi: number) => String.fromCharCode(65 + oi);
                        const optionText = (opt: string) =>
                          /^[A-D]\)\s*/.test(opt) ? opt.replace(/^[A-D]\)\s*/, "") : opt;
                        const difficulty: DiffKey = q.difficulty ?? "Medium";
                        const diffStyle = DIFF[difficulty];

                        return (
                          <div
                            key={i}
                            className="rounded-xl border border-[#ebe8e1] bg-white p-5 transition-shadow"
                            style={{
                              borderColor: submitted ? (isCorrect ? "#86efac" : "#fca5a5") : undefined,
                            }}
                          >
                            {/* Meta row: Q counter, timer (warn when >90s), difficulty pill, result badge — comm.md */}
                            <div className="mb-3 flex flex-wrap items-center gap-2">
                              <span className="text-[11.5px] font-bold text-[#9a9690]">
                                Q{i + 1} of {quiz.length}
                              </span>
                              {!submitted && (
                                <span
                                  className={`font-mono text-[11px] rounded-md border px-2 py-1 flex items-center gap-1 ${
                                    elapsedSeconds > 90
                                      ? "text-[#dc2626] border-[#fca5a5] bg-[#fef2f2]"
                                      : "text-[#9a9690] border-[#ebe8e1] bg-white"
                                  }`}
                                >
                                  ⏱ {Math.floor(elapsedSeconds / 60)}:{String(elapsedSeconds % 60).padStart(2, "0")}
                                </span>
                              )}
                              <span
                                className="rounded-[20px] border px-2 py-0.5 text-[10px] font-extrabold"
                                style={{ background: diffStyle.bg, color: diffStyle.text, borderColor: diffStyle.border }}
                              >
                                {difficulty}
                              </span>
                              {submitted && (
                                <span
                                  className="ml-auto flex items-center gap-1 rounded-[20px] border px-2.5 py-1 text-[11.5px] font-bold"
                                  style={{
                                    background: skipped ? "#f5f4f1" : isCorrect ? "#f0fdf4" : "#fef2f2",
                                    color: skipped ? "#6b6966" : isCorrect ? "#15803d" : "#dc2626",
                                    borderColor: skipped ? "#e0ddd6" : isCorrect ? "#86efac" : "#fca5a5",
                                  }}
                                >
                                  {skipped ? "Skipped" : isCorrect ? "✓ Correct!" : "✗ Incorrect"}
                                </span>
                              )}
                            </div>

                            <p className="mb-5 text-[15.5px] font-semibold leading-relaxed text-[#1c1b1f] tracking-tight">
                              {q.question}
                            </p>

                            {/* Options — comm.md: white bg, rounded-square letter 28×28, hover translateX(3px), dim non-selected after submit */}
                            <div className="mb-4 flex flex-col gap-2">
                              {opts.map((opt, oi) => {
                                const isSelected = !submitted && selected === oi;
                                const isCorrectOpt = submitted && oi === correctIndex;
                                const isWrongOpt = submitted && oi === selected && oi !== correctIndex;
                                const dim = submitted && oi !== correctIndex && oi !== selected;
                                let rowBg = "#fff";
                                let rowBorder = "#e0ddd6";
                                let rowShadow = "0 0 0 transparent";
                                let letterBg = "#f5f4f1";
                                let letterColor = "#6b6966";
                                let letterBorder = "#e0ddd6";
                                let textColor = "#2c2a28";
                                let textFw = "500";
                                if (isSelected) {
                                  rowBg = "#fffbf0";
                                  rowBorder = "#f59207";
                                  rowShadow = "0 0 0 3px rgba(245,146,7,0.08)";
                                  letterBg = "#f59207";
                                  letterColor = "#fff";
                                  letterBorder = "#f59207";
                                  textColor = "#92400e";
                                  textFw = "600";
                                }
                                if (isCorrectOpt) {
                                  rowBg = "#f0fdf4";
                                  rowBorder = "#22c55e";
                                  rowShadow = "0 0 0 3px rgba(34,197,94,0.09)";
                                  letterBg = "#22c55e";
                                  letterColor = "#fff";
                                  letterBorder = "#22c55e";
                                  textColor = "#15803d";
                                  textFw = "600";
                                }
                                if (isWrongOpt) {
                                  rowBg = "#fef2f2";
                                  rowBorder = "#ef4444";
                                  rowShadow = "0 0 0 3px rgba(239,68,68,0.09)";
                                  letterBg = "#ef4444";
                                  letterColor = "#fff";
                                  letterBorder = "#ef4444";
                                  textColor = "#dc2626";
                                  textFw = "600";
                                }
                                return (
                                  <button
                                    key={oi}
                                    type="button"
                                    disabled={submitted}
                                    onClick={() =>
                                      !submitted && setSelectedOptions((s) => ({ ...s, [i]: oi }))
                                    }
                                    className="flex w-full items-center gap-3 rounded-[11px] border-[1.5px] px-4 py-3 text-left text-[13.5px] transition-all duration-150 focus:outline-none focus-visible:ring-2 focus-visible:ring-[#f59207] focus-visible:ring-offset-2 disabled:pointer-events-none disabled:cursor-default hover:border-[#c8b87a] hover:bg-[#fdfcfa] hover:shadow-[0_2px_8px_rgba(0,0,0,0.04)] hover:translate-x-[3px]"
                                    style={{
                                      background: rowBg,
                                      borderColor: rowBorder,
                                      boxShadow: rowShadow,
                                      opacity: dim ? 0.45 : 1,
                                      cursor: submitted ? "default" : "pointer",
                                    }}
                                  >
                                    <span
                                      className="flex h-7 w-7 shrink-0 items-center justify-center rounded-lg border-[1.5px] text-xs font-extrabold"
                                      style={{
                                        background: letterBg,
                                        color: letterColor,
                                        borderColor: letterBorder,
                                      }}
                                    >
                                      {submitted && oi === correctIndex
                                        ? "✓"
                                        : submitted && oi === selected && oi !== correctIndex
                                          ? "✗"
                                          : optionLabel(oi)}
                                    </span>
                                    <span className="flex-1 font-medium" style={{ color: textColor, fontWeight: textFw }}>
                                      {optionText(opt)}
                                    </span>
                                  </button>
                                );
                              })}
                            </div>

                            {/* Action row — comm.md .abtn styles */}
                            <div className="flex flex-wrap items-center gap-2">
                              {!submitted && (
                                <>
                                  <button
                                    type="button"
                                    disabled={selected === undefined}
                                    className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] px-3.5 py-2 text-xs font-semibold transition-all active:scale-[0.97] disabled:cursor-not-allowed disabled:shadow-none"
                                    style={{
                                      background: selected === undefined ? "#e0ddd6" : "#f59207",
                                      borderColor: selected === undefined ? "#e0ddd6" : "#f59207",
                                      color: selected === undefined ? "#b8b5ae" : "#fff",
                                      boxShadow: selected === undefined ? "none" : "0 2px 6px rgba(245,146,7,0.16)",
                                    }}
                                    onClick={async () => {
                                      if (selected !== undefined) {
                                        const timeTaken = getElapsedForRecording();
                                        if (q.id) {
                                          await recordAttempt({
                                            questionId: q.id,
                                            lessonId: lesson.id,
                                            courseId,
                                            timeSpentSeconds: timeTaken,
                                            isCorrect: selected === correctIndex,
                                            skipped: false,
                                          });
                                          fetchPracticeQuestions();
                                        }
                                        setSubmittedQuestions((s) => ({
                                          ...s,
                                          [i]: selected === correctIndex,
                                        }));
                                        if (selected !== correctIndex)
                                          setRevealedExplanations((e) => ({ ...e, [i]: true }));
                                      }
                                    }}
                                  >
                                    ✓ Submit Answer
                                  </button>
                                  <button
                                    type="button"
                                    className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#e0ddd6] bg-white px-3.5 py-2 text-xs font-semibold text-[#6b6966] transition-all hover:bg-[#f5f4f1] active:scale-[0.97]"
                                    onClick={async () => {
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
                                      setSkippedQuestions((s) => ({ ...s, [i]: true }));
                                    }}
                                  >
                                    Skip
                                  </button>
                                </>
                              )}
                              <button
                                type="button"
                                className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#fde9b8] bg-[#fffbf0] px-3.5 py-2 text-xs font-semibold text-[#b45309] transition-all hover:bg-[#fef3c7] active:scale-[0.97]"
                                onClick={() => setRevealedHints((h) => ({ ...h, [i]: !h[i] }))}
                              >
                                💡 {revealedHints[i] ? "Hide Hint" : "Hint"}
                              </button>
                              {submitted && (
                                <button
                                  type="button"
                                  className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#86efac] bg-[#f0fdf4] px-3.5 py-2 text-xs font-semibold text-[#15803d] transition-all hover:bg-[#dcfce7] active:scale-[0.97]"
                                  onClick={() =>
                                    setRevealedExplanations((e) => ({ ...e, [i]: !e[i] }))
                                  }
                                >
                                  📖 {revealedExplanations[i] ? "Hide" : "Explanation"}
                                </button>
                              )}
                              <button
                                type="button"
                                className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#c7d2fe] bg-[#eef2ff] px-3.5 py-2 text-xs font-semibold text-[#4338ca] transition-all hover:bg-[#e0e7ff] active:scale-[0.97]"
                                onClick={() => {
                                  const optsText =
                                    opts.length > 0
                                      ? opts.map((o, oi) => `${optionLabel(oi)}) ${optionText(o)}`).join(", ")
                                      : "";
                                  onAskAI?.(
                                    `Walk me through this SAT question:\n"${q.question}"\nOptions: ${optsText}`
                                  );
                                }}
                              >
                                🤖 Ask AI
                              </button>
                              {submitted && (
                                <button
                                  type="button"
                                  className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#e0ddd6] bg-white px-3.5 py-2 text-xs font-semibold text-[#6b6966] transition-all hover:bg-[#f5f4f1] active:scale-[0.97]"
                                  onClick={() => {
                                    setSubmittedQuestions((s) => {
                                      const n = { ...s };
                                      delete n[i];
                                      return n;
                                    });
                                    setSkippedQuestions((s) => {
                                      const n = { ...s };
                                      delete n[i];
                                      return n;
                                    });
                                    setSelectedOptions((s) => {
                                      const n = { ...s };
                                      delete n[i];
                                      return n;
                                    });
                                    setRevealedExplanations((e) => {
                                      const n = { ...e };
                                      delete n[i];
                                      return n;
                                    });
                                    setRevealedHints((h) => {
                                      const n = { ...h };
                                      delete n[i];
                                      return n;
                                    });
                                  }}
                                >
                                  ↺ Retry
                                </button>
                              )}
                            </div>

                            {revealedHints[i] && (
                              <div className="mt-3 rounded-[10px] border border-[#fde9b8] bg-[#fffbf0] p-3 text-[12.5px] leading-relaxed text-[#78350f] [&_strong]:text-[#1c1b1f]">
                                💡 <strong>Hint:</strong> {getHintText(q.explanation ?? "")}
                              </div>
                            )}
                            {revealedExplanations[i] && (
                              <div className="mt-3 rounded-[10px] border border-[#86efac] bg-[#f0fdf4] p-3 text-[12.5px] leading-relaxed text-[#14532d] [&_strong]:text-[#1c1b1f]">
                                📖 <strong>Explanation:</strong> {q.explanation}
                              </div>
                            )}

                            {/* Use empty space: prompt to use AI tutor */}
                            {!revealedHints[i] && !revealedExplanations[i] && (
                              <p className="mt-4 text-center text-xs text-[#8b8880]">
                                Stuck?{" "}
                                <button
                                  type="button"
                                  onClick={() => {
                                    const optsText =
                                      opts.length > 0
                                        ? opts.map((o, oi) => `${optionLabel(oi)}) ${optionText(o)}`).join(", ")
                                        : "";
                                    onAskAI?.(
                                      `Can you walk me through this problem step by step?\n\n"${q.question}"\n\nOptions: ${optsText}`
                                    );
                                  }}
                                  className="font-semibold text-[#f59207] hover:text-[#e08a00] hover:underline"
                                >
                                  Ask the AI tutor →
                                </button>
                              </p>
                            )}
                          </div>
                        );
                      })()}

                      {/* Footer — Previous | dots | Next */}
                      {quiz.length > 1 && (
                        <div className="mt-4 flex shrink-0 items-center justify-between gap-2 border-t border-[#ebe8e1] bg-white px-6 py-3">
                          <button
                            type="button"
                            disabled={practiceQuestionIndex === 0}
                            className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#e0ddd6] bg-white px-4 py-2 text-xs font-semibold text-[#6b6966] transition-all hover:bg-[#f5f4f1] disabled:opacity-40 disabled:cursor-not-allowed"
                            onClick={() =>
                              setPracticeQuestionIndex((idx) => Math.max(0, idx - 1))
                            }
                          >
                            <ChevronLeft className="h-4 w-4" /> Previous
                          </button>
                          <div className="flex items-center gap-2">
                            {quiz.map((_, qi) => {
                              const skipped = skippedQuestions[qi];
                              const sub = submittedQuestions[qi];
                              const isActive = qi === practiceQuestionIndex;
                              const bg = isActive
                                ? "#f59207"
                                : skipped
                                  ? "#fcd34d"
                                  : sub === true
                                    ? "#22c55e"
                                    : sub === false
                                      ? "#ef4444"
                                      : "#e0ddd6";
                              return (
                                <button
                                  key={qi}
                                  type="button"
                                  title={`Q${qi + 1}${sub === true ? " · Correct" : sub === false ? " · Incorrect" : skipped ? " · Skipped" : ""}`}
                                  aria-label={`Question ${qi + 1}`}
                                  onClick={() => setPracticeQuestionIndex(qi)}
                                  className="h-3 w-3 rounded-full transition-all duration-150 hover:opacity-80 hover:scale-125"
                                  style={{
                                    background: bg,
                                    transform: isActive ? "scale(1.4)" : "scale(1)",
                                  }}
                                />
                              );
                            })}
                          </div>
                          <button
                            type="button"
                            disabled={practiceQuestionIndex >= quiz.length - 1}
                            className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#f59207] bg-[#f59207] px-4 py-2 text-xs font-semibold text-white transition-all hover:bg-[#e08a00] disabled:border-[#e0ddd6] disabled:bg-[#e0ddd6] disabled:cursor-not-allowed disabled:text-[#b8b5ae]"
                            onClick={() =>
                              setPracticeQuestionIndex((idx) =>
                                Math.min(quiz.length - 1, idx + 1)
                              )
                            }
                          >
                            Next <ChevronRight className="h-4 w-4" />
                          </button>
                        </div>
                      )}
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          </div>

          {/* Right panel: embedded AI chat — collapsible */}
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
                quiz.length > 0 && onAskAI
                  ? () => {
                      const q = quiz[practiceQuestionIndex];
                      if (!q) return;
                      const opts = q.options?.length ? q.options : [];
                      const optsText = opts
                        .map((o, oi) => {
                          const text = /^[A-D]\)\s*/.test(o) ? o.replace(/^[A-D]\)\s*/, "") : o;
                          return `${String.fromCharCode(65 + oi)}) ${text}`;
                        })
                        .join("  ");
                      onAskAI(
                        `Walk me through this SAT question:\n"${q.question}"\nOptions: ${optsText}`
                      );
                    }
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

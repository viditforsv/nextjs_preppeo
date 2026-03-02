"use client";

import { useState } from "react";
import Link from "next/link";
import { ChevronLeft, ChevronRight, BookOpen, FileText, ExternalLink } from "lucide-react";
import { CollapsibleSidebar } from "@/design-system/components/layout-components/collapsible-sidebar";
import { VideoResource } from "@/design-system/components/youtube-video";
import { CourseChatbot } from "./CourseChatbot";
import type { InteractiveStep, InteractiveQuizItem } from "./InteractiveLessonView";
import { Button } from "@/design-system/components/ui/button";

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
  const [revealedExplanations, setRevealedExplanations] = useState<Record<number, boolean>>({});
  const [practiceQuestionIndex, setPracticeQuestionIndex] = useState(0);

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
                <FileText className="h-4 w-4" /> Practice Questions
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
                            className="flex items-start gap-3 rounded-lg border border-[#eae8e2] bg-white p-3"
                          >
                            <div className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-[#f59207] text-xs font-extrabold text-white">
                              {i + 1}
                            </div>
                            <div>
                              <h4 className="text-sm font-bold text-[#1a1a2e]">{s.title}</h4>
                              <p className="text-xs text-[#6b6870]">{s.content}</p>
                            </div>
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
                </>
              ) : (
                <div className="flex flex-col gap-4">
                  {quiz.length === 0 ? (
                    <p className="text-sm text-[#8b8880]">No practice questions for this lesson yet.</p>
                  ) : (
                    <>
                      {/* Score summary */}
                      {Object.keys(submittedQuestions).length > 0 && (
                        <div className="mb-2 flex items-center gap-3 rounded-xl border border-[#eae8e2] bg-white p-3">
                          <span className="text-xl">📊</span>
                          <div>
                            <div className="text-sm font-bold text-[#1a1a2e]">
                              {Object.values(submittedQuestions).filter(Boolean).length} / {Object.keys(submittedQuestions).length} correct
                            </div>
                            <div className="text-xs text-[#8b8880]">
                              {quiz.length - Object.keys(submittedQuestions).length} questions remaining
                            </div>
                          </div>
                          <div className="ml-auto flex gap-1">
                            {quiz.map((_, qi) => {
                              const sub = submittedQuestions[qi];
                              return (
                                <div
                                  key={qi}
                                  className="h-2 w-2 rounded-full bg-[#d4d0c8]"
                                  style={{
                                    background:
                                      sub === undefined ? "#d4d0c8" : sub ? "#22c55e" : "#ef4444",
                                  }}
                                  title={sub === undefined ? "Not answered" : sub ? "Correct" : "Incorrect"}
                                />
                              );
                            })}
                          </div>
                        </div>
                      )}

                      {/* One question at a time: navigation */}
                      {quiz.length > 1 && (
                        <div className="mb-3 flex items-center justify-between gap-2">
                          <Button
                            variant="outline"
                            size="sm"
                            className="rounded-lg border-[#eae8e2] bg-white text-[#5a5860] hover:bg-[#f4f3f0] disabled:opacity-50"
                            disabled={practiceQuestionIndex === 0}
                            onClick={() =>
                              setPracticeQuestionIndex((idx) => Math.max(0, idx - 1))
                            }
                          >
                            <ChevronLeft className="h-4 w-4 mr-1" /> Previous
                          </Button>
                          <div className="flex items-center gap-1.5">
                            {quiz.map((_, qi) => (
                              <button
                                key={qi}
                                type="button"
                                aria-label={`Question ${qi + 1}`}
                                onClick={() => setPracticeQuestionIndex(qi)}
                                className="h-2.5 w-2.5 rounded-full transition-[transform,background] hover:scale-110"
                                style={{
                                  background:
                                    qi === practiceQuestionIndex
                                      ? "#f59207"
                                      : submittedQuestions[qi] === true
                                        ? "#22c55e"
                                        : submittedQuestions[qi] === false
                                          ? "#ef4444"
                                          : "#d4d0c8",
                                }}
                              />
                            ))}
                          </div>
                          <Button
                            variant="outline"
                            size="sm"
                            className="rounded-lg border-[#eae8e2] bg-white text-[#5a5860] hover:bg-[#f4f3f0] disabled:opacity-50"
                            disabled={practiceQuestionIndex >= quiz.length - 1}
                            onClick={() =>
                              setPracticeQuestionIndex((idx) =>
                                Math.min(quiz.length - 1, idx + 1)
                              )
                            }
                          >
                            Next <ChevronRight className="h-4 w-4 ml-1" />
                          </Button>
                        </div>
                      )}

                      {(() => {
                        const i = Math.min(practiceQuestionIndex, quiz.length - 1);
                        const q = quiz[i];
                        if (!q) return null;
                        const selected = selectedOptions[i];
                        const submitted = submittedQuestions[i] !== undefined;
                        const isCorrect = submittedQuestions[i] === true;
                        const opts = q.options?.length ? q.options : ["No options"];
                        const correctIndex = Math.min(q.answer ?? 0, opts.length - 1);

                        const optionLabel = (oi: number) => String.fromCharCode(65 + oi);
                        const optionText = (opt: string) =>
                          /^[A-D]\)\s*/.test(opt) ? opt.replace(/^[A-D]\)\s*/, "") : opt;

                        return (
                          <div
                            key={i}
                            className="rounded-xl border border-[#eae8e2] bg-white p-5 transition-shadow hover:shadow-lg"
                            style={{
                              borderColor: submitted ? (isCorrect ? "#bbf7d0" : "#fecaca") : undefined,
                            }}
                          >
                            <div className="mb-2 flex items-center gap-2">
                              <span className="text-xs font-bold text-[#8b8880]">
                                Q{i + 1} of {quiz.length}
                              </span>
                              {submitted && (
                                <span
                                  className="ml-auto flex items-center gap-1 text-xs font-bold"
                                  style={{
                                    color: isCorrect ? "#16a34a" : "#dc2626",
                                  }}
                                >
                                  {isCorrect ? "✓ Correct" : "✗ Incorrect"}
                                </span>
                              )}
                            </div>

                            <p className="mb-3 text-sm font-semibold leading-snug text-[#1a1a2e]">
                              {q.question}
                            </p>

                            {/* SAT-style MCQ options */}
                            <div className="mb-3 flex flex-col gap-2">
                              {opts.map((opt, oi) => {
                                let bg = "#f4f3f0";
                                let border = "#eae8e2";
                                let color = "#3a3840";
                                let fw = "500";
                                if (!submitted && selected === oi) {
                                  bg = "#fff8ee";
                                  border = "#f59207";
                                  color = "#92400e";
                                  fw = "600";
                                }
                                if (submitted) {
                                  if (oi === correctIndex) {
                                    bg = "#f0fdf4";
                                    border = "#86efac";
                                    color = "#15803d";
                                    fw = "700";
                                  } else if (oi === selected && oi !== correctIndex) {
                                    bg = "#fef2f2";
                                    border = "#fca5a5";
                                    color = "#dc2626";
                                    fw = "600";
                                  }
                                }
                                return (
                                  <button
                                    key={oi}
                                    type="button"
                                    disabled={submitted}
                                    onClick={() =>
                                      !submitted && setSelectedOptions((s) => ({ ...s, [i]: oi }))
                                    }
                                    className="flex w-full items-center gap-2.5 rounded-lg border px-3.5 py-2.5 text-left text-[13px] transition-[border-color,background-color,color]"
                                    style={{
                                      background: bg,
                                      borderWidth: "1.5px",
                                      borderColor: border,
                                      color,
                                      fontWeight: fw,
                                      cursor: submitted ? "default" : "pointer",
                                    }}
                                  >
                                    <span
                                      className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full border-[1.5px] bg-white text-[11px] font-bold"
                                      style={{ borderColor: border, color }}
                                    >
                                      {submitted && oi === correctIndex
                                        ? "✓"
                                        : submitted && oi === selected && oi !== correctIndex
                                          ? "✗"
                                          : optionLabel(oi)}
                                    </span>
                                    {optionText(opt)}
                                  </button>
                                );
                              })}
                            </div>

                            {/* Action row */}
                            <div className="flex flex-wrap gap-2">
                              {!submitted && (
                                <Button
                                  size="sm"
                                  disabled={selected === undefined}
                                  className="rounded-lg bg-[#f59207] text-white hover:bg-[#e08a00] disabled:opacity-45"
                                  onClick={() => {
                                    if (selected !== undefined) {
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
                                </Button>
                              )}
                              <Button
                                variant="outline"
                                size="sm"
                                className="rounded-lg border-[#d4d0c8] bg-[#f4f3f0] text-[#5a5860] hover:bg-[#eae8e2]"
                                onClick={() => setRevealedHints((h) => ({ ...h, [i]: !h[i] }))}
                              >
                                💡 {revealedHints[i] ? "Hide Hint" : "Hint"}
                              </Button>
                              {submitted && (
                                <Button
                                  variant="outline"
                                  size="sm"
                                  className="rounded-lg border-[#d4d0c8] bg-[#f4f3f0] text-[#5a5860] hover:bg-[#eae8e2]"
                                  onClick={() =>
                                    setRevealedExplanations((e) => ({ ...e, [i]: !e[i] }))
                                  }
                                >
                                  📖 {revealedExplanations[i] ? "Hide" : "Explanation"}
                                </Button>
                              )}
                              <Button
                                variant="outline"
                                size="sm"
                                className="rounded-lg border-[#c7d2fe] bg-[#eef2ff] text-[#4338ca] hover:bg-[#e0e7ff]"
                                onClick={() => {
                                  const optsText =
                                    opts.length > 0
                                      ? opts.map((o, oi) => `${optionLabel(oi)}) ${optionText(o)}`).join(", ")
                                      : "";
                                  onAskAI?.(
                                    `Can you walk me through this SAT problem step by step?\n\n"${q.question}"\n\nOptions: ${optsText}`
                                  );
                                }}
                              >
                                🤖 Ask AI
                              </Button>
                              {submitted && (
                                <Button
                                  variant="outline"
                                  size="sm"
                                  className="rounded-lg border-[#d4d0c8] bg-[#f4f3f0] text-[#5a5860] hover:bg-[#eae8e2]"
                                  onClick={() => {
                                    setSubmittedQuestions((s) => {
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
                                </Button>
                              )}
                            </div>

                            {revealedHints[i] && (
                              <div className="mt-3 rounded-lg border border-[#d4d0c8] bg-[#f4f3f0] p-3 text-sm font-medium text-[#5a5860]">
                                💡 {q.explanation}
                              </div>
                            )}
                            {revealedExplanations[i] && (
                              <div className="mt-3 rounded-lg border border-[#bbf7d0] bg-[#f0fdf4] p-3 text-sm leading-relaxed text-[#15803d] [&_strong]:text-[#1a1a2e]">
                                📖 {q.explanation}
                              </div>
                            )}
                          </div>
                        );
                      })()}
                    </>
                  )}
                </div>
              )}
            </div>
          </div>

          {/* Right panel: embedded AI chat — responsive width, full height, input at bottom */}
          <div className="flex h-full min-h-0 w-[280px] min-w-[260px] max-w-full flex-col shrink-0 overflow-hidden bg-white sm:w-[300px] md:w-[320px] lg:w-[360px]">
            <CourseChatbot
              courseTitle={courseTitle}
              lessonTitle={lesson.title}
              isOpen={true}
              onToggle={() => {}}
              embedded={true}
              messageToSend={askAIMessage}
              onMessageSent={onAskAISent}
            />
          </div>
        </div>
      </div>
    </div>
  );
}

import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import {
  HelpCircle,
  FileDown,
  Lock,
  ChevronLeft,
  ChevronRight,
  ArrowRight,
} from "lucide-react";
import {
  getCourseDetail,
  getItemFull,
  getFlashcards,
  getQuizQuestions,
} from "@/lib/sat-learn";
import { SatLearnFlashcards } from "./SatLearnFlashcards";
import { SatLearnQuiz } from "./SatLearnQuiz";
import { MarkComplete } from "./MarkComplete";
import { CourseSidebar } from "../../CourseSidebar";

const NAVY = "#1a365d";
const AMBER = "#f4b400";
const TEAL = "#0891b2";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ courseSlug: string; topicSlug: string; itemSlug: string }>;
}): Promise<Metadata> {
  const { courseSlug, topicSlug, itemSlug } = await params;
  const item = await getItemFull(courseSlug, topicSlug, itemSlug);
  if (!item) return { title: "Lesson not found | Preppeo" };
  return { title: `${item.title} | Preppeo SAT Self-Paced` };
}

/* ── Minimal markdown → JSX (admin-authored content only) ─────────── */
function renderMarkdown(body: string) {
  const lines = body.split("\n");
  const blocks: React.ReactNode[] = [];
  let list: string[] = [];

  const flushList = (key: number) => {
    if (list.length) {
      blocks.push(
        <ul key={`ul-${key}`} className="list-disc pl-5 space-y-1 my-3">
          {list.map((li, i) => (
            <li key={i}>{renderInline(li)}</li>
          ))}
        </ul>
      );
      list = [];
    }
  };

  lines.forEach((raw, i) => {
    const line = raw.trim();
    if (line.startsWith("- ")) {
      list.push(line.slice(2));
      return;
    }
    flushList(i);
    if (!line) return;
    if (line.startsWith("> ")) {
      // Callout — gold left border, cream background (SAT tip).
      blocks.push(
        <div
          key={i}
          className="my-4 rounded-r-xl border-l-4 px-4 py-3 text-sm leading-relaxed"
          style={{ borderColor: AMBER, background: "#fdf6e6", color: "#5a4a23" }}
        >
          {renderInline(line.slice(2))}
        </div>
      );
    } else if (line.startsWith("### ")) {
      blocks.push(
        <h3 key={i} className="text-base font-bold mt-5 mb-1" style={{ color: NAVY }}>
          {renderInline(line.slice(4))}
        </h3>
      );
    } else if (line.startsWith("## ")) {
      blocks.push(
        <h2 key={i} className="text-lg font-bold mt-6 mb-2" style={{ color: NAVY }}>
          {renderInline(line.slice(3))}
        </h2>
      );
    } else {
      blocks.push(
        <p key={i} className="text-gray-700 leading-relaxed my-2">
          {renderInline(line)}
        </p>
      );
    }
  });
  flushList(lines.length);
  return blocks;
}

// Inline: **bold** and `formula chips` (navy on light-blue); else plain text.
function renderInline(text: string): React.ReactNode {
  const parts = text.split(/(\*\*[^*]+\*\*|`[^`]+`)/g);
  return parts.map((p, i) => {
    if (p.startsWith("**") && p.endsWith("**")) {
      return (
        <strong key={i} style={{ color: NAVY }}>
          {p.slice(2, -2)}
        </strong>
      );
    }
    if (p.startsWith("`") && p.endsWith("`")) {
      return (
        <code
          key={i}
          className="rounded-md px-1.5 py-0.5 text-[0.92em] font-semibold"
          style={{ background: "#eef1f7", color: NAVY }}
        >
          {p.slice(1, -1)}
        </code>
      );
    }
    return <span key={i}>{p}</span>;
  });
}

export default async function SatLearnItemPage({
  params,
}: {
  params: Promise<{ courseSlug: string; topicSlug: string; itemSlug: string }>;
}) {
  const { courseSlug, topicSlug, itemSlug } = await params;
  const [course, item] = await Promise.all([
    getCourseDetail(courseSlug),
    getItemFull(courseSlug, topicSlug, itemSlug),
  ]);
  if (!course || !item) notFound();

  // Flatten the curriculum for prev/next + the sidebar.
  const flat = course.topics.flatMap((t) =>
    t.items.map((it) => ({ ...it, topicSlug: t.slug, topicTitle: t.title }))
  );
  const pos = flat.findIndex((f) => f.id === item.id);
  const prev = pos > 0 ? flat[pos - 1] : null;
  const next = pos < flat.length - 1 ? flat[pos + 1] : null;

  const flashcards =
    item.type === "flashcard" && !item.locked ? await getFlashcards(item.id) : [];
  const quizQuestions =
    item.type === "quiz" && !item.locked ? await getQuizQuestions(item.id) : [];

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-8 flex gap-8">
        {/* ── Sidebar: curriculum (shared) ────────────────────────── */}
        <aside className="hidden lg:block w-72 flex-shrink-0">
          <CourseSidebar course={course} activeItemId={item.id} />
        </aside>

        {/* ── Main: content ───────────────────────────────────────── */}
        <main className="flex-1 min-w-0">
          {/* mobile back link */}
          <Link
            href={`/sat/learn/${course.slug}`}
            className="lg:hidden mb-4 inline-flex items-center gap-1 text-sm font-semibold"
            style={{ color: NAVY }}
          >
            <ChevronLeft className="h-4 w-4" /> {course.title}
          </Link>

          <div className="rounded-2xl border border-gray-200 bg-white p-6 sm:p-8">
            <div className="flex items-start justify-between gap-4 mb-6">
              <div>
                <span
                  className="text-xs font-semibold uppercase tracking-widest"
                  style={{ color: AMBER }}
                >
                  {item.type}
                </span>
                <h1 className="mt-1 text-2xl font-bold" style={{ color: NAVY }}>
                  {item.title}
                </h1>
              </div>
              {!item.locked && (
                <MarkComplete itemId={item.id} completed={item.completed} />
              )}
            </div>

            {/* ── Locked state ──────────────────────────────────── */}
            {item.locked ? (
              <div className="rounded-xl bg-gray-50 border border-gray-200 px-6 py-12 text-center">
                <Lock className="mx-auto h-8 w-8 text-gray-300" />
                <p className="mt-3 font-semibold" style={{ color: NAVY }}>
                  This lesson is part of the full course
                </p>
                <p className="mt-1 text-sm text-gray-500">
                  Enroll in {course.title} to unlock all videos, notes,
                  flashcards, and quizzes.
                </p>
                <Link
                  href="/pricing"
                  className="mt-5 inline-flex items-center gap-2 rounded-xl px-5 py-3 text-sm font-bold"
                  style={{ background: AMBER, color: NAVY }}
                >
                  Enroll now <ArrowRight className="h-4 w-4" />
                </Link>
              </div>
            ) : (
              <>
                {/* ── Video ──────────────────────────────────────── */}
                {item.type === "video" &&
                  (item.videoUrl ? (
                    <div className="relative w-full overflow-hidden rounded-xl bg-black" style={{ paddingTop: "56.25%" }}>
                      <iframe
                        src={item.videoUrl}
                        className="absolute inset-0 h-full w-full"
                        loading="lazy"
                        allow="accelerometer; gyroscope; autoplay; encrypted-media; picture-in-picture"
                        allowFullScreen
                      />
                    </div>
                  ) : (
                    <p className="text-sm text-gray-500">Video coming soon.</p>
                  ))}

                {/* ── Reading ────────────────────────────────────── */}
                {item.type === "reading" &&
                  (item.body ? (
                    <div className="prose-sm max-w-none">
                      {renderMarkdown(item.body)}
                    </div>
                  ) : (
                    <p className="text-sm text-gray-500">Notes coming soon.</p>
                  ))}

                {/* ── PDF resource card ──────────────────────────── */}
                {item.type === "pdf" &&
                  (item.pdfUrl ? (
                    <div className="flex flex-wrap items-center gap-6 rounded-xl border border-gray-200 bg-[#fbfaf6] p-5">
                      {/* faux page thumbnail */}
                      <div className="relative h-[140px] w-[108px] flex-none overflow-hidden rounded-lg border border-gray-200 bg-white p-3.5 shadow-sm">
                        {[80, 60, 90, 50, 75, 40].map((w, i) => (
                          <div
                            key={i}
                            className="mb-[7px] h-[5px] rounded"
                            style={{ width: `${w}%`, background: "#e7eaef" }}
                          />
                        ))}
                        <span
                          className="absolute bottom-0 left-0 rounded-tr-lg px-2 py-0.5 text-[9.5px] font-bold tracking-wide text-white"
                          style={{ background: "#d6483b" }}
                        >
                          PDF
                        </span>
                      </div>
                      <div className="min-w-[200px] flex-1">
                        <h4 className="text-lg font-bold" style={{ color: NAVY }}>
                          {item.title}
                        </h4>
                        <p className="mt-1 mb-4 text-sm text-gray-500">
                          One-page formula sheet · open or download for quick review
                        </p>
                        <a
                          href={item.pdfUrl}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="inline-flex items-center gap-2 rounded-xl px-4 py-2.5 text-sm font-bold text-white"
                          style={{ background: NAVY }}
                        >
                          <FileDown className="h-4 w-4" /> Download PDF
                        </a>
                      </div>
                    </div>
                  ) : (
                    <p className="text-sm text-gray-500">PDF coming soon.</p>
                  ))}

                {/* ── Flashcards ─────────────────────────────────── */}
                {item.type === "flashcard" && (
                  <SatLearnFlashcards cards={flashcards} />
                )}

                {/* ── Quiz (embedded concept check) ──────────────── */}
                {item.type === "quiz" &&
                  (quizQuestions.length > 0 ? (
                    <>
                      <p className="mb-5 text-sm text-gray-500">
                        A quick concept check on this topic — {quizQuestions.length}{" "}
                        question{quizQuestions.length === 1 ? "" : "s"}.
                      </p>
                      <SatLearnQuiz questions={quizQuestions} />
                    </>
                  ) : (
                    <div className="rounded-xl bg-gray-50 border border-gray-200 px-6 py-10 text-center">
                      <HelpCircle className="mx-auto h-8 w-8" style={{ color: TEAL }} />
                      <p className="mt-3 font-semibold" style={{ color: NAVY }}>
                        Quiz coming soon
                      </p>
                      <p className="mt-1 text-sm text-gray-500">
                        Concept-check questions are being added for this topic.
                      </p>
                    </div>
                  ))}
              </>
            )}
          </div>

          {/* ── Prev / Next ─────────────────────────────────────── */}
          <div className="mt-6 flex items-center justify-between gap-3">
            {prev ? (
              <Link
                href={`/sat/learn/${course.slug}/${prev.topicSlug}/${prev.slug}`}
                className="inline-flex items-center gap-1 rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-600 hover:bg-gray-50"
              >
                <ChevronLeft className="h-4 w-4" /> Previous
              </Link>
            ) : (
              <span />
            )}
            {next && (
              <Link
                href={`/sat/learn/${course.slug}/${next.topicSlug}/${next.slug}`}
                className="inline-flex items-center gap-1 rounded-lg px-4 py-2 text-sm font-bold"
                style={{ background: NAVY, color: "white" }}
              >
                Next <ChevronRight className="h-4 w-4" />
              </Link>
            )}
          </div>
        </main>
      </div>
    </div>
  );
}

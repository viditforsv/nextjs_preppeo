import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import {
  ChevronRight,
  Home,
  PlayCircle,
  FileText,
  Layers,
  HelpCircle,
  FileDown,
  Check,
  Lock,
  ArrowRight,
} from "lucide-react";
import { getCourseDetail } from "@/lib/sat-learn";
import type { SatLearnItemMeta, SatLearnItemType } from "@/types/sat-learn";
import { CourseSidebar } from "./CourseSidebar";
import { groupTopicsByDomain } from "./segments";

const NAVY = "#1a365d";
const AMBER = "#f4b400";
const TEAL = "#0891b2";

const ITEM_META: Record<
  SatLearnItemType,
  { icon: typeof PlayCircle; label: string }
> = {
  video: { icon: PlayCircle, label: "Video" },
  reading: { icon: FileText, label: "Reading" },
  flashcard: { icon: Layers, label: "Flashcards" },
  quiz: { icon: HelpCircle, label: "Quiz" },
  pdf: { icon: FileDown, label: "PDF" },
};

function fmtDuration(seconds: number | null): string | null {
  if (!seconds) return null;
  return `${Math.round(seconds / 60)} min`;
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ courseSlug: string }>;
}): Promise<Metadata> {
  const { courseSlug } = await params;
  const course = await getCourseDetail(courseSlug);
  if (!course) return { title: "Course not found | Preppeo" };
  return {
    title: `${course.title} | Preppeo`,
    description: course.description ?? course.tagline ?? undefined,
  };
}

export default async function SatLearnCoursePage({
  params,
}: {
  params: Promise<{ courseSlug: string }>;
}) {
  const { courseSlug } = await params;
  const course = await getCourseDetail(courseSlug);
  if (!course) notFound();

  const hasAccess = (item: SatLearnItemMeta) =>
    course.isAdmin || course.isEnrolled || item.isFreePreview;

  const sectionCount = new Set(
    course.topics.map((t) => t.domain).filter(Boolean)
  ).size;
  const totalItems = course.topics.reduce((n, t) => n + t.items.length, 0);
  const doneItems = course.topics.reduce(
    (n, t) => n + t.items.filter((i) => i.completed).length,
    0
  );

  // First lesson → "Start learning" / "Continue" target.
  const firstTopic = course.topics.find((t) => t.items.length > 0);
  const firstItem = firstTopic?.items[0];
  const nextUp =
    course.topics
      .flatMap((t) => t.items.map((i) => ({ t, i })))
      .find(({ i }) => !i.completed) ?? null;
  const ctaTarget = nextUp ?? (firstTopic && firstItem ? { t: firstTopic, i: firstItem } : null);

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-8 flex gap-8">
        {/* ── Sidebar ─────────────────────────────────────────────── */}
        <aside className="hidden lg:block w-72 flex-shrink-0">
          <CourseSidebar course={course} overviewActive />
        </aside>

        {/* ── Main: overview ──────────────────────────────────────── */}
        <main className="flex-1 min-w-0">
          {/* Breadcrumb */}
          <nav aria-label="Breadcrumb" className="mb-5">
            <ol className="flex flex-wrap items-center gap-1.5 text-xs text-gray-500">
              <li>
                <Link href="/" className="inline-flex items-center hover:text-gray-700">
                  <Home className="w-3.5 h-3.5" />
                </Link>
              </li>
              <ChevronRight className="w-3.5 h-3.5 text-gray-300" />
              <li>
                <Link href="/sat/learn" className="hover:text-gray-700">
                  SAT Self-Paced
                </Link>
              </li>
              <ChevronRight className="w-3.5 h-3.5 text-gray-300" />
              <li aria-current="page" className="font-medium text-gray-700">
                {course.subject === "math" ? "Math" : "English"}
              </li>
            </ol>
          </nav>

          {/* Overview card */}
          <div className="rounded-2xl border border-gray-200 bg-white p-6 sm:p-8">
            <span
              className="text-xs font-semibold uppercase tracking-widest"
              style={{ color: AMBER }}
            >
              {course.subject === "math" ? "SAT Math" : "SAT English"} · Self-Paced
            </span>
            <h1 className="mt-2 text-3xl font-bold leading-tight" style={{ color: NAVY }}>
              {course.title}
            </h1>
            {course.description && (
              <p className="mt-3 text-gray-600 text-lg leading-relaxed">
                {course.description}
              </p>
            )}

            <div className="mt-5 flex flex-wrap items-center gap-4 text-sm text-gray-500">
              {sectionCount > 0 && (
                <>
                  <span>{sectionCount} sections</span>
                  <span>·</span>
                </>
              )}
              <span>
                {course.topics.length} topic{course.topics.length === 1 ? "" : "s"}
              </span>
              <span>·</span>
              <span>{totalItems} lessons</span>
              {(course.isEnrolled || course.isAdmin) && totalItems > 0 && (
                <>
                  <span>·</span>
                  <span className="font-semibold" style={{ color: TEAL }}>
                    {doneItems}/{totalItems} complete
                  </span>
                </>
              )}
            </div>

            {ctaTarget && (
              <Link
                href={`/sat/learn/${course.slug}/${ctaTarget.t.slug}/${ctaTarget.i.slug}`}
                className="mt-6 inline-flex items-center gap-2 rounded-xl px-5 py-3 text-sm font-bold transition-opacity hover:opacity-90"
                style={{ background: AMBER, color: NAVY }}
              >
                {doneItems > 0 ? "Continue learning" : "Start learning"}
                <ArrowRight className="h-4 w-4" />
              </Link>
            )}
            {!course.isEnrolled && !course.isAdmin && (
              <p className="mt-3 text-xs text-gray-400">
                Free previews available · enroll for full access
              </p>
            )}
          </div>

          {/* Mobile curriculum (sidebar is hidden < lg) */}
          <div className="lg:hidden mt-6 space-y-6">
            {groupTopicsByDomain(course.topics).map((seg) => (
              <div key={seg.key} className="space-y-3">
                {seg.label && (
                  <h2
                    className="px-1 text-xs font-bold uppercase tracking-[0.13em]"
                    style={{ color: NAVY }}
                  >
                    {seg.label}
                  </h2>
                )}
                {seg.topics.map((topic) => (
              <section
                key={topic.id}
                className="rounded-xl border border-gray-200 bg-white overflow-hidden"
              >
                <div className="border-b border-gray-100 px-5 py-3">
                  <h2 className="font-bold text-sm" style={{ color: NAVY }}>
                    {topic.title}
                  </h2>
                </div>
                {topic.items.length === 0 && (
                  <p className="px-5 py-3 text-sm italic text-gray-400">Coming soon</p>
                )}
                <ul className="divide-y divide-gray-100">
                  {topic.items.map((item) => {
                    const { icon: Icon, label } = ITEM_META[item.type];
                    const access = hasAccess(item);
                    const duration = fmtDuration(item.durationSeconds);
                    return (
                      <li key={item.id}>
                        <Link
                          href={`/sat/learn/${course.slug}/${topic.slug}/${item.slug}`}
                          className="flex items-center gap-3 px-5 py-3 hover:bg-gray-50"
                        >
                          <span
                            className="flex h-7 w-7 flex-shrink-0 items-center justify-center rounded-full"
                            style={{
                              background: item.completed ? "#dcfce7" : "#eef2f7",
                              color: item.completed ? "#16a34a" : NAVY,
                            }}
                          >
                            {item.completed ? (
                              <Check className="h-3.5 w-3.5" />
                            ) : (
                              <Icon className="h-3.5 w-3.5" />
                            )}
                          </span>
                          <span className="min-w-0 flex-1">
                            <span className="block text-sm font-medium text-foreground">
                              {item.title}
                            </span>
                            <span className="block text-xs text-gray-400">
                              {label}
                              {duration ? ` · ${duration}` : ""}
                            </span>
                          </span>
                          {!access && (
                            <Lock className="h-4 w-4 flex-shrink-0 text-gray-300" />
                          )}
                          <ChevronRight className="h-4 w-4 flex-shrink-0 text-gray-300" />
                        </Link>
                      </li>
                    );
                  })}
                </ul>
              </section>
                ))}
              </div>
            ))}
            {course.topics.length === 0 && (
              <p className="text-center text-gray-500 py-12">Content coming soon.</p>
            )}
          </div>
        </main>
      </div>
    </div>
  );
}

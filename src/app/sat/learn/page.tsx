import type { Metadata } from "next";
import Link from "next/link";
import { ArrowRight, BookOpen, Calculator, Lock } from "lucide-react";
import { listCourses, topicCountsByCourse } from "@/lib/sat-learn";

const NAVY = "#1a365d";
const AMBER = "#f4b400";
const TEAL = "#0891b2";

const baseUrl = process.env.NEXT_PUBLIC_APP_URL || "https://preppeo.com";

export const metadata: Metadata = {
  title: "SAT Self-Paced Courses — Math & English | Preppeo",
  description:
    "Self-paced Digital SAT courses for Math and English — concept videos, written notes, flashcards, and quizzes from our live question bank. Learn at your own pace.",
  alternates: { canonical: `${baseUrl}/sat/learn` },
};

export default async function SatLearnLandingPage() {
  const courses = await listCourses();
  const counts = await topicCountsByCourse(courses.map((c) => c.id));

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="max-w-5xl mx-auto px-6 py-14 sm:py-20">
        {/* ── Hero ───────────────────────────────────────────────── */}
        <div className="text-center max-w-2xl mx-auto">
          <div
            className="inline-flex items-center gap-2 text-xs font-semibold uppercase tracking-wide mb-4"
            style={{ color: TEAL }}
          >
            <BookOpen className="w-4 h-4" />
            Self-Paced · Digital SAT
          </div>
          <h1
            className="text-3xl sm:text-5xl font-bold leading-tight"
            style={{ color: NAVY }}
          >
            Learn the SAT at your own pace
          </h1>
          <p className="text-gray-600 mt-4 text-lg leading-relaxed">
            Two complete courses — Math and English — built from concept videos,
            written notes, flashcards, and quizzes drawn from our live question
            bank.
          </p>
        </div>

        {/* ── Course cards ───────────────────────────────────────── */}
        <div className="grid sm:grid-cols-2 gap-6 mt-12">
          {courses.map((course) => {
            const topicCount = counts[course.id] ?? 0;
            const comingSoon = topicCount === 0;
            const Icon = course.subject === "math" ? Calculator : BookOpen;
            return (
              <div
                key={course.id}
                className="flex flex-col rounded-2xl border border-gray-200 bg-white p-7 shadow-sm"
              >
                <div className="flex items-center gap-3">
                  <span
                    className="flex h-11 w-11 items-center justify-center rounded-xl"
                    style={{ background: NAVY }}
                  >
                    <Icon className="h-5 w-5 text-white" />
                  </span>
                  <span
                    className="text-xs font-semibold uppercase tracking-widest"
                    style={{ color: AMBER }}
                  >
                    {course.subject === "math" ? "Math" : "English"}
                  </span>
                </div>

                <h2 className="mt-5 text-xl font-bold" style={{ color: NAVY }}>
                  {course.title}
                </h2>
                {course.tagline && (
                  <p className="mt-1 text-sm font-medium text-gray-500">
                    {course.tagline}
                  </p>
                )}
                {course.description && (
                  <p className="mt-3 text-sm text-gray-600 leading-relaxed flex-1">
                    {course.description}
                  </p>
                )}

                <div className="mt-6">
                  {comingSoon ? (
                    <span className="inline-flex items-center gap-2 rounded-xl bg-gray-100 px-5 py-3 text-sm font-bold text-gray-400">
                      <Lock className="h-4 w-4" /> Coming soon
                    </span>
                  ) : (
                    <Link
                      href={`/sat/learn/${course.slug}`}
                      className="inline-flex items-center gap-2 rounded-xl px-5 py-3 text-sm font-bold transition-opacity hover:opacity-90"
                      style={{ background: AMBER, color: NAVY }}
                    >
                      Explore course <ArrowRight className="h-4 w-4" />
                    </Link>
                  )}
                  {!comingSoon && (
                    <p className="mt-3 text-xs text-gray-400">
                      {topicCount} topic{topicCount === 1 ? "" : "s"}
                    </p>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

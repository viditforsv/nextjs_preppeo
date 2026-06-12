"use client";

import { useState } from "react";
import Link from "next/link";
import {
  PlayCircle,
  FileText,
  Layers,
  HelpCircle,
  FileDown,
  Check,
  Lock,
  ChevronRight,
  LayoutGrid,
} from "lucide-react";
import type { SatLearnCourseDetail, SatLearnItemType } from "@/types/sat-learn";
import { groupTopicsByDomain } from "./segments";

const NAVY = "#1a365d";

const TYPE_ICON: Record<SatLearnItemType, typeof PlayCircle> = {
  video: PlayCircle,
  reading: FileText,
  flashcard: Layers,
  quiz: HelpCircle,
  pdf: FileDown,
};

/**
 * Shared curriculum sidebar — accordion topics, a course progress bar,
 * per-topic completion pills, and per-lesson check circles. Used by the
 * course overview page and the lesson player.
 */
export function CourseSidebar({
  course,
  activeItemId,
  overviewActive = false,
}: {
  course: SatLearnCourseDetail;
  activeItemId?: string;
  overviewActive?: boolean;
}) {
  // Open the topic containing the active lesson (or the first topic).
  const activeTopicId =
    course.topics.find((t) => t.items.some((i) => i.id === activeItemId))?.id ??
    course.topics[0]?.id;
  const [open, setOpen] = useState<Record<string, boolean>>(
    activeTopicId ? { [activeTopicId]: true } : {}
  );

  const totalItems = course.topics.reduce((n, t) => n + t.items.length, 0);
  const doneItems = course.topics.reduce(
    (n, t) => n + t.items.filter((i) => i.completed).length,
    0
  );
  const pct = totalItems ? Math.round((doneItems / totalItems) * 100) : 0;

  const segments = groupTopicsByDomain(course.topics);

  return (
    <div className="sticky top-20">
      {/* Course header + progress */}
      <Link
        href={`/sat/learn/${course.slug}`}
        className="flex items-center gap-2 rounded-lg px-2 py-2 text-sm font-bold transition-colors hover:bg-gray-100"
        style={overviewActive ? { background: "#eef2f7", color: NAVY } : { color: NAVY }}
      >
        <LayoutGrid className="h-4 w-4 flex-shrink-0" />
        <span className="min-w-0 truncate">{course.title}</span>
      </Link>

      {totalItems > 0 && (
        <div className="mt-3 mb-1 flex items-center gap-2.5 px-2">
          <div className="h-1.5 flex-1 overflow-hidden rounded-full bg-gray-200">
            <div
              className="h-full rounded-full transition-all"
              style={{ width: `${pct}%`, background: NAVY }}
            />
          </div>
          <span className="whitespace-nowrap text-xs font-semibold text-gray-400">
            {pct}%
          </span>
        </div>
      )}

      <p className="mt-4 mb-1 px-2 text-[11px] font-bold uppercase tracking-[0.13em] text-gray-400">
        Curriculum
      </p>

      <div className="max-h-[calc(100vh-12rem)] overflow-y-auto pr-1">
        {segments.map((seg) => (
          <div key={seg.key} className="mb-1">
            {seg.label && (
              <p
                className="mt-4 mb-1 px-2 text-[11px] font-bold uppercase tracking-[0.13em]"
                style={{ color: NAVY }}
              >
                {seg.label}
              </p>
            )}
            {seg.topics.map((topic) => {
          const isOpen = !!open[topic.id];
          const done = topic.items.filter((i) => i.completed).length;
          const total = topic.items.length;
          const allDone = total > 0 && done === total;
          return (
            <div key={topic.id} className="border-t border-gray-100 first:border-t-0">
              <button
                onClick={() => setOpen((o) => ({ ...o, [topic.id]: !o[topic.id] }))}
                aria-expanded={isOpen}
                className="flex w-full items-center gap-2 rounded-lg px-2 py-3 text-left transition-colors hover:bg-gray-100"
              >
                <ChevronRight
                  className="h-4 w-4 flex-shrink-0 transition-transform"
                  style={{
                    transform: isOpen ? "rotate(90deg)" : "none",
                    color: isOpen ? NAVY : "#9aa1ac",
                  }}
                />
                <span
                  className="flex-1 text-sm font-bold leading-tight"
                  style={{ color: NAVY }}
                >
                  {topic.title}
                </span>
                <span
                  className="inline-flex flex-shrink-0 items-center gap-1 rounded-full px-2 py-0.5 text-xs font-semibold"
                  style={
                    allDone
                      ? { background: "#e8f6ef", color: "#15734c" }
                      : { background: "#edece5", color: "#9aa1ac" }
                  }
                >
                  {allDone && <Check className="h-3 w-3" />}
                  {done}/{total}
                </span>
              </button>

              <div
                className="overflow-hidden transition-all"
                style={{
                  maxHeight: isOpen
                    ? `${Math.max(topic.items.length, 1) * 52 + 8}px`
                    : "0px",
                }}
              >
                {topic.items.length === 0 && (
                  <p className="px-2.5 pb-3 pt-0.5 text-xs italic text-gray-400">
                    Coming soon
                  </p>
                )}
                <ul className="space-y-0.5 pb-2">
                  {topic.items.map((it) => {
                    const Icon = TYPE_ICON[it.type];
                    const active = it.id === activeItemId;
                    const accessible =
                      course.isAdmin || course.isEnrolled || it.isFreePreview;
                    return (
                      <li key={it.id}>
                        <Link
                          href={`/sat/learn/${course.slug}/${topic.slug}/${it.slug}`}
                          className="flex items-center gap-2.5 rounded-lg px-2.5 py-2.5 text-sm transition-colors hover:bg-gray-100"
                          style={
                            active
                              ? { background: "#edeff6", boxShadow: "inset 0 0 0 1px #dfe3ef" }
                              : undefined
                          }
                        >
                          <span
                            className="flex-shrink-0"
                            style={{ color: active ? NAVY : "#9aa1ac" }}
                          >
                            {accessible ? (
                              <Icon className="h-4 w-4" />
                            ) : (
                              <Lock className="h-3.5 w-3.5" />
                            )}
                          </span>
                          <span
                            className="min-w-0 flex-1 truncate"
                            style={{
                              color: it.completed ? "#6c7686" : active ? NAVY : "#4b5563",
                              fontWeight: active ? 600 : 500,
                            }}
                          >
                            {it.title}
                          </span>
                          {/* completion circle */}
                          <span
                            className="flex h-[18px] w-[18px] flex-shrink-0 items-center justify-center rounded-full border-[1.5px]"
                            style={
                              it.completed
                                ? { background: "#1f9d6b", borderColor: "#1f9d6b", color: "#fff" }
                                : { borderColor: "#d3d2c9" }
                            }
                          >
                            {it.completed && <Check className="h-2.5 w-2.5" />}
                          </span>
                        </Link>
                      </li>
                    );
                  })}
                </ul>
              </div>
            </div>
          );
            })}
          </div>
        ))}
      </div>
    </div>
  );
}

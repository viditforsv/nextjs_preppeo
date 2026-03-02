"use client";

import { useState } from "react";
import { ChevronLeft, ChevronRight, Filter } from "lucide-react";
import { Button } from "@/design-system/components/ui/button";

export interface PracticeQuestionSidebarItem {
  order: number;
  question_id: string | null;
  difficulty: number | null;
  topic: string | null;
  lastAttempt?: {
    time_taken_seconds: number;
    is_correct: boolean;
    skipped: boolean;
  };
}

export type DifficultyFilter = "easy" | "medium" | "hard" | "";
export type TimeBucketFilter = "<30" | "30-90" | ">90" | "";

export interface PracticeQuestionsFilters {
  difficulty: DifficultyFilter;
  timeBucket: TimeBucketFilter;
  topic: string;
  chapter: string;
}

interface PracticeQuestionsSidebarProps {
  items: PracticeQuestionSidebarItem[];
  currentIndex: number;
  onSelectQuestion: (order: number) => void;
  filters: PracticeQuestionsFilters;
  onFilterChange: (f: Partial<PracticeQuestionsFilters>) => void;
  chapterName?: string | null;
  onRefresh?: () => void;
  collapsed?: boolean;
  onToggleCollapsed?: () => void;
}

function getStatus(
  item: PracticeQuestionSidebarItem
): "wrong" | "slow" | "skipped" | "correct" | "none" {
  const last = item.lastAttempt;
  if (!last) return "none";
  if (last.skipped) return "skipped";
  if (!last.is_correct) return "wrong";
  if (last.time_taken_seconds > 90) return "slow";
  return "correct";
}

function getDifficultyLabel(d: number | null): string {
  if (d == null) return "";
  if (d <= 3) return "Easy";
  if (d <= 6) return "Medium";
  return "Hard";
}

export function PracticeQuestionsSidebar({
  items,
  currentIndex,
  onSelectQuestion,
  filters,
  onFilterChange,
  chapterName,
  collapsed = false,
  onToggleCollapsed,
}: PracticeQuestionsSidebarProps) {
  const [filterOpen, setFilterOpen] = useState(false);

  if (collapsed) {
    return (
      <div className="flex w-10 shrink-0 flex-col items-center border-r border-[#eae8e2] bg-white py-2">
        <Button
          variant="outline"
          size="sm"
          onClick={onToggleCollapsed}
          className="rounded-lg"
          aria-label="Expand questions list"
        >
          <ChevronRight className="h-4 w-4 text-[#5a5860]" />
        </Button>
      </div>
    );
  }

  return (
    <div className="flex w-[240px] shrink-0 flex-col border-r border-[#eae8e2] bg-white">
      <div className="flex items-center justify-between border-b border-[#eae8e2] p-2">
        <span className="text-sm font-semibold text-[#1a1a2e]">
          Questions
        </span>
        {onToggleCollapsed && (
          <Button
            variant="outline"
            size="sm"
            onClick={onToggleCollapsed}
            className="h-8 w-8 rounded-lg p-0"
            aria-label="Collapse questions list"
          >
            <ChevronLeft className="h-4 w-4 text-[#5a5860]" />
          </Button>
        )}
      </div>

      {/* Filters */}
      <div className="border-b border-[#eae8e2] p-2">
        <button
          type="button"
          onClick={() => setFilterOpen((o) => !o)}
          className="flex w-full items-center gap-2 rounded-lg px-2 py-1.5 text-xs font-medium text-[#5a5860] hover:bg-[#f4f3f0]"
        >
          <Filter className="h-3.5 w-3.5" />
          Filters
        </button>
        {filterOpen && (
          <div className="mt-2 space-y-2 rounded-lg bg-[#f9f8f5] p-2">
            <div>
              <label className="mb-1 block text-[10px] font-semibold uppercase text-[#8b8880]">
                Difficulty
              </label>
              <select
                value={filters.difficulty}
                onChange={(e) =>
                  onFilterChange({
                    difficulty: e.target.value as DifficultyFilter,
                  })
                }
                className="w-full rounded border border-[#eae8e2] bg-white px-2 py-1.5 text-xs text-[#1a1a2e]"
              >
                <option value="">All</option>
                <option value="easy">Easy</option>
                <option value="medium">Medium</option>
                <option value="hard">Hard</option>
              </select>
            </div>
            <div>
              <label className="mb-1 block text-[10px] font-semibold uppercase text-[#8b8880]">
                Time
              </label>
              <select
                value={filters.timeBucket}
                onChange={(e) =>
                  onFilterChange({
                    timeBucket: e.target.value as TimeBucketFilter,
                  })
                }
                className="w-full rounded border border-[#eae8e2] bg-white px-2 py-1.5 text-xs text-[#1a1a2e]"
              >
                <option value="">All</option>
                <option value="<30">Under 30s</option>
                <option value="30-90">30–90s</option>
                <option value=">90">Over 90s</option>
              </select>
            </div>
            <div>
              <label className="mb-1 block text-[10px] font-semibold uppercase text-[#8b8880]">
                Topic
              </label>
              <input
                type="text"
                value={filters.topic}
                onChange={(e) => onFilterChange({ topic: e.target.value })}
                placeholder="Filter by topic"
                className="w-full rounded border border-[#eae8e2] bg-white px-2 py-1.5 text-xs text-[#1a1a2e] placeholder:text-[#8b8880]"
              />
            </div>
            {chapterName && (
              <div>
                <label className="mb-1 block text-[10px] font-semibold uppercase text-[#8b8880]">
                  Chapter
                </label>
                <input
                  type="text"
                  value={filters.chapter}
                  onChange={(e) => onFilterChange({ chapter: e.target.value })}
                  placeholder={chapterName}
                  className="w-full rounded border border-[#eae8e2] bg-white px-2 py-1.5 text-xs text-[#1a1a2e] placeholder:text-[#8b8880]"
                />
              </div>
            )}
          </div>
        )}
      </div>

      <div className="flex-1 overflow-y-auto p-2">
        {items.length === 0 ? (
          <p className="text-xs text-[#8b8880]">No questions match filters.</p>
        ) : (
          <ul className="space-y-1">
            {items.map((item) => {
              const status = getStatus(item);
              const isCurrent = currentIndex === item.order - 1;
              const bg =
                status === "wrong"
                  ? "bg-red-50 border-red-200"
                  : status === "slow"
                    ? "bg-amber-50 border-amber-200"
                    : status === "skipped" || status === "none"
                      ? "bg-[#f4f3f0] border-[#eae8e2] opacity-75"
                      : "bg-green-50/80 border-green-200";
              return (
                <li key={item.order}>
                  <button
                    type="button"
                    onClick={() => onSelectQuestion(item.order)}
                    className={`w-full rounded-lg border px-2.5 py-2 text-left transition-colors hover:opacity-90 ${bg} ${
                      isCurrent ? "ring-2 ring-[#f59207] ring-offset-1" : ""
                    }`}
                    aria-label={`Question ${item.order}${
                      status === "wrong"
                        ? ", incorrect"
                        : status === "slow"
                          ? ", took over 90 seconds"
                          : status === "skipped"
                            ? ", skipped"
                            : status === "correct"
                              ? ", correct"
                              : ""
                    }`}
                  >
                    <div className="flex items-center justify-between gap-1">
                      <span className="text-sm font-medium text-[#1a1a2e]">
                        Q{item.order}
                      </span>
                      {item.difficulty != null && (
                        <span className="text-[10px] text-[#8b8880]">
                          {getDifficultyLabel(item.difficulty)}
                        </span>
                      )}
                    </div>
                    {item.lastAttempt != null && !item.lastAttempt.skipped && (
                      <span className="mt-0.5 block text-[10px] text-[#8b8880]">
                        {item.lastAttempt.time_taken_seconds}s
                        {item.lastAttempt.is_correct ? " ✓" : " ✗"}
                      </span>
                    )}
                    {item.topic && (
                      <span className="mt-0.5 block truncate text-[10px] text-[#6b6870]">
                        {item.topic}
                      </span>
                    )}
                  </button>
                </li>
              );
            })}
          </ul>
        )}
      </div>
    </div>
  );
}

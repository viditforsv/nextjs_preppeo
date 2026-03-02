"use client";

import { useState } from "react";
import { ChevronLeft, ChevronRight, Filter } from "lucide-react";
import { Button } from "@/design-system/components/ui/button";

export interface PracticeQuestionSidebarItem {
  order: number;
  question_id: string | null;
  difficulty: number | null;
  topic: string | null;
  question?: string | null;
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
  /** comm.md: score bar (X/Y correct) when showing in-lesson quiz */
  scoreCorrect?: number;
  scoreTotal?: number;
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

// comm.md: difficulty color coding for visual engagement (Easy / Medium / Hard)
const DIFF_COLORS: Record<string, { text: string; bg: string; border: string }> = {
  Easy: { text: "#15803d", bg: "#f0fdf4", border: "#86efac" },
  Medium: { text: "#b45309", bg: "#fffbeb", border: "#fcd34d" },
  Hard: { text: "#dc2626", bg: "#fef2f2", border: "#fca5a5" },
};

export function PracticeQuestionsSidebar({
  items,
  currentIndex,
  onSelectQuestion,
  filters,
  onFilterChange,
  chapterName,
  collapsed = false,
  onToggleCollapsed,
  scoreCorrect = 0,
  scoreTotal = 0,
}: PracticeQuestionsSidebarProps) {
  const [filterOpen, setFilterOpen] = useState(false);

  if (collapsed) {
    return (
      <div className="flex w-10 shrink-0 flex-col items-center border-r border-[#ebe8e1] bg-white py-2">
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
    <div className="flex w-[176px] shrink-0 flex-col border-r border-[#ebe8e1] bg-white overflow-hidden">
      <div className="shrink-0 border-b border-[#f0ede6] px-3 pt-3 pb-2">
        <div className="mb-2 flex items-center justify-between gap-1">
          <span className="text-xs font-bold text-[#1c1b1f]">Questions</span>
          <div className="flex items-center gap-0.5">
            <button
              type="button"
              onClick={() => setFilterOpen((o) => !o)}
              className="flex items-center gap-1 rounded-md border border-[#ebe8e1] px-1.5 py-0.5 text-[10px] font-semibold text-[#9a9690] transition-colors hover:bg-[#f5f4f1]"
            >
              <Filter className="h-2.5 w-2.5" />
              Filters
            </button>
            {onToggleCollapsed && (
              <button
                type="button"
                onClick={onToggleCollapsed}
                className="rounded p-0.5 text-[#9a9690] hover:bg-[#f5f4f1]"
                aria-label="Collapse questions"
              >
                <ChevronLeft className="h-3.5 w-3.5" />
              </button>
            )}
          </div>
        </div>
        {scoreTotal > 0 && (
          <div className="flex items-center gap-1.5">
            <div className="flex-1 h-1 rounded-sm bg-[#ebe8e1] overflow-hidden">
              <div
                className="h-full rounded-sm bg-linear-to-r from-[#22c55e] to-[#4ade80] transition-[width] duration-300"
                style={{ width: `${(scoreCorrect / scoreTotal) * 100}%` }}
              />
            </div>
            <span className="text-[10px] font-bold text-[#22c55e] tabular-nums">
              {scoreCorrect}/{scoreTotal}
            </span>
          </div>
        )}
      </div>

      {filterOpen && (
          <div className="border-b border-[#f0ede6] space-y-2 px-2 pb-2 pt-1">
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

      <div className="min-h-0 flex-1 overflow-y-auto p-1.5">
        {items.length === 0 ? (
          <p className="text-[10px] text-[#9a9690] px-1">No questions match filters.</p>
        ) : (
          <ul className="space-y-0.5">
            {items.map((item) => {
              const status = getStatus(item);
              const isCurrent = currentIndex === item.order - 1;
              const isOk = status === "correct";
              const isBad = status === "wrong" || status === "slow";
              const isSkipped = status === "skipped";
              const diffLabel = getDifficultyLabel(item.difficulty);
              const diffColors = diffLabel ? DIFF_COLORS[diffLabel] : null;
              const base = "flex items-center gap-1.5 w-full rounded-lg border-[1.5px] pl-2 pr-2 py-2 text-left transition-all cursor-pointer border-l-4";
              const active = isCurrent ? "bg-[#fffbf0] border-[#fde9b8]" : "";
              const ok = isOk ? "border-[#86efac] bg-[#f0fdf4]" : "";
              const bad = isBad ? "border-[#fca5a5] bg-[#fef2f2]" : "";
              const skip = isSkipped ? "border-[#fcd34d] bg-[#fffbeb]" : "";
              const idle = !active && !ok && !bad && !skip ? "border-transparent hover:bg-[#fdfcfa] hover:border-[#ebe8e1]" : "";
              const leftBorderStyle = diffColors
                ? { borderLeftColor: diffColors.border }
                : { borderLeftColor: "transparent" };
              const statusIcon = isOk ? "✅" : isBad ? "❌" : isSkipped ? "⏭" : isCurrent ? "▶" : "";
              const qNumColor = isBad ? "text-[#dc2626]" : isOk ? "text-[#15803d]" : isSkipped ? "text-[#b45309]" : isCurrent ? "text-[#f59207]" : "text-[#9a9690]";
              const labelColor = isBad ? "text-[#dc2626] font-semibold" : isOk ? "text-[#15803d] font-semibold" : isSkipped ? "text-[#b45309]" : isCurrent ? "text-[#1c1b1f] font-semibold" : "text-[#6b6966]";
              return (
                <li key={item.order}>
                  <button
                    type="button"
                    onClick={() => onSelectQuestion(item.order)}
                    className={`${base} ${active} ${ok} ${bad} ${skip} ${idle}`}
                    style={leftBorderStyle}
                    aria-label={`Question ${item.order}`}
                  >
                    <span className={`text-[11px] font-bold w-5 shrink-0 ${qNumColor}`}>
                      Q{item.order}
                    </span>
                    {item.topic || item.question ? (
                      <span className={`text-[11px] flex-1 line-clamp-2 min-w-0 ${labelColor}`}>
                        {item.topic ?? item.question}
                      </span>
                    ) : (
                      <span className={`text-[11px] flex-1 min-w-0 ${labelColor}`}>
                        Question {item.order}
                      </span>
                    )}
                    {diffLabel && (
                      <span
                        className="shrink-0 rounded-full px-1.5 py-0.5 text-[9px] font-bold border"
                        style={{
                          color: diffColors!.text,
                          backgroundColor: diffColors!.bg,
                          borderColor: diffColors!.border,
                        }}
                      >
                        {diffLabel}
                      </span>
                    )}
                    <span className="text-[13px] shrink-0">{statusIcon}</span>
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

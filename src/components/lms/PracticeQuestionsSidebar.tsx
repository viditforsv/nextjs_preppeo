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

// comm.md: difficulty color coding — muted tones for sidebar
const DIFF_COLORS: Record<string, { text: string; bg: string; border: string }> = {
  Easy: { text: "#4b9e6a", bg: "#f5fbf7", border: "#bbddc9" },
  Medium: { text: "#a07830", bg: "#fdf9f0", border: "#e8d5a0" },
  Hard: { text: "#b85555", bg: "#fdf5f5", border: "#e8b8b8" },
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
              <div className="flex gap-1 flex-wrap">
                {(["", "easy", "medium", "hard"] as DifficultyFilter[]).map((val) => {
                  const label = val === "" ? "All" : val.charAt(0).toUpperCase() + val.slice(1);
                  const active = filters.difficulty === val;
                  const color =
                    val === "easy"
                      ? active ? "bg-[#15803d] text-white border-[#15803d]" : "border-[#bbddc9] text-[#4b9e6a] hover:bg-[#f5fbf7]"
                      : val === "medium"
                      ? active ? "bg-[#b45309] text-white border-[#b45309]" : "border-[#e8d5a0] text-[#a07830] hover:bg-[#fdf9f0]"
                      : val === "hard"
                      ? active ? "bg-[#dc2626] text-white border-[#dc2626]" : "border-[#e8b8b8] text-[#b85555] hover:bg-[#fdf5f5]"
                      : active ? "bg-[#1a1a2e] text-white border-[#1a1a2e]" : "border-[#e0ddd6] text-[#9a9690] hover:bg-[#f5f4f1]";
                  return (
                    <button
                      key={val}
                      type="button"
                      onClick={() => onFilterChange({ difficulty: val })}
                      className={`rounded-full border px-2 py-0.5 text-[9.5px] font-semibold transition-colors ${color}`}
                    >
                      {label}
                    </button>
                  );
                })}
              </div>
            </div>
            <div>
              <label className="mb-1 block text-[10px] font-semibold uppercase text-[#8b8880]">
                Time
              </label>
              <div className="flex gap-1 flex-wrap">
                {([["", "All"], ["<30", "<30s"], ["30-90", "30–90s"], [">90", ">90s"]] as [TimeBucketFilter, string][]).map(([val, label]) => {
                  const active = filters.timeBucket === val;
                  return (
                    <button
                      key={val}
                      type="button"
                      onClick={() => onFilterChange({ timeBucket: val })}
                      className={`rounded-full border px-2 py-0.5 text-[9.5px] font-semibold transition-colors ${
                        active
                          ? "bg-[#4338ca] text-white border-[#4338ca]"
                          : "border-[#c7d2fe] text-[#4338ca] hover:bg-[#eef2ff]"
                      }`}
                    >
                      {label}
                    </button>
                  );
                })}
              </div>
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
              const base = "flex items-center gap-1.5 w-full rounded-lg border border-l-[3px] pl-2 pr-2 py-2 text-left transition-all cursor-pointer";
              const active = isCurrent ? "bg-[#fdfaf4] border-[#f0e6c8]" : "";
              const ok = isOk ? "border-[#c8e6d4] bg-[#f8fcfa]" : "";
              const bad = isBad ? "border-[#e8c8c8] bg-[#fdf8f8]" : "";
              const skip = isSkipped ? "border-[#e8d8a0] bg-[#fdfaf0]" : "";
              const idle = !active && !ok && !bad && !skip ? "border-transparent hover:bg-[#fdfcfa] hover:border-[#ebe8e1]" : "";
              const leftBorderStyle = diffColors
                ? { borderLeftColor: diffColors.border }
                : { borderLeftColor: "transparent" };
              const statusIcon = isOk ? "✓" : isBad ? "✗" : isSkipped ? "–" : isCurrent ? "▶" : "";
              const qNumColor = isBad ? "text-[#b85555]" : isOk ? "text-[#4b9e6a]" : isSkipped ? "text-[#a07830]" : isCurrent ? "text-[#f59207]" : "text-[#9a9690]";
              const labelColor = isBad ? "text-[#b85555]" : isOk ? "text-[#4b9e6a]" : isSkipped ? "text-[#a07830]" : isCurrent ? "text-[#1c1b1f] font-semibold" : "text-[#6b6966]";
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
                    <span
                      className={`text-[10px] font-semibold shrink-0 ${
                        isOk ? "text-[#4b9e6a]" : isBad ? "text-[#b85555]" : isSkipped ? "text-[#a07830]" : isCurrent ? "text-[#c8a84a]" : "text-transparent"
                      }`}
                    >
                      {statusIcon}
                    </span>
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

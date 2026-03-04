"use client";

import { useEffect, useRef } from "react";
import { ChevronLeft, ChevronRight } from "lucide-react";
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
    hint_used: boolean;
  };
}

export type DifficultyFilter = "easy" | "medium" | "hard" | "";
export type AttemptStatusFilter =
  | "unattempted"
  | "correct"
  | "hint"
  | "wrong"
  | "skipped"
  | "";

export interface PracticeQuestionsFilters {
  difficulty: DifficultyFilter;
  status: AttemptStatusFilter;
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
  scoreCorrect?: number;
  scoreTotal?: number;
}

function getStatus(
  item: PracticeQuestionSidebarItem
): "wrong" | "hint" | "skipped" | "correct" | "none" {
  const last = item.lastAttempt;
  if (!last) return "none";
  if (last.skipped) return "skipped";
  if (!last.is_correct) return "wrong";
  if (last.hint_used) return "hint";
  return "correct";
}

function getDifficultyLabel(d: number | null): string {
  if (d == null) return "";
  if (d <= 3) return "Easy";
  if (d <= 6) return "Medium";
  return "Hard";
}

const DIFF_COLORS: Record<string, { text: string; bg: string; border: string; activeBg: string }> = {
  Easy:   { text: "#4b9e6a", bg: "#f5fbf7", border: "#bbddc9", activeBg: "#15803d" },
  Medium: { text: "#a07830", bg: "#fdf9f0", border: "#e8d5a0", activeBg: "#b45309" },
  Hard:   { text: "#b85555", bg: "#fdf5f5", border: "#e8b8b8", activeBg: "#dc2626" },
};

/** Plain-text preview for sidebar: strip LaTeX and take first maxLen chars. */
function toPlainPreview(text: string, maxLen: number = 70): string {
  if (!text || typeof text !== "string") return "";
  let s = text
    .replace(/\$\$?[^$]*\$\$?/g, " ") // inline/block math
    .replace(/\\frac\{[^}]*\}\{[^}]*\}/g, " ")
    .replace(/\\sqrt\{[^}]*\}/g, " ")
    .replace(/\\[a-zA-Z]+\{[^}]*\}/g, " ") // \something{...}
    .replace(/\\[a-zA-Z]+/g, " ") // \command
    .replace(/\s+/g, " ")
    .trim();
  if (s.length === 0) return "";
  return s.length > maxLen ? s.slice(0, maxLen).trim() + "…" : s;
}

const DIFF_CHIPS: { val: DifficultyFilter; label: string }[] = [
  { val: "", label: "All" },
  { val: "easy", label: "Easy" },
  { val: "medium", label: "Med" },
  { val: "hard", label: "Hard" },
];

const STATUS_CHIPS: {
  val: AttemptStatusFilter;
  label: string;
  activeBg: string;
  activeText: string;
  idleText: string;
  idleBorder: string;
  idleHover: string;
}[] = [
  {
    val: "",
    label: "All",
    activeBg: "#1a1a2e",
    activeText: "#ffffff",
    idleText: "#6b6966",
    idleBorder: "#e0ddd6",
    idleHover: "#f5f4f1",
  },
  {
    val: "unattempted",
    label: "New",
    activeBg: "#4338ca",
    activeText: "#ffffff",
    idleText: "#4338ca",
    idleBorder: "#c7d2fe",
    idleHover: "#eef2ff",
  },
  {
    val: "correct",
    label: "Correct",
    activeBg: "#15803d",
    activeText: "#ffffff",
    idleText: "#4b9e6a",
    idleBorder: "#bbddc9",
    idleHover: "#f5fbf7",
  },
  {
    val: "hint",
    label: "Hinted",
    activeBg: "#b45309",
    activeText: "#ffffff",
    idleText: "#a07830",
    idleBorder: "#e8d5a0",
    idleHover: "#fdf9f0",
  },
  {
    val: "wrong",
    label: "Wrong",
    activeBg: "#dc2626",
    activeText: "#ffffff",
    idleText: "#b85555",
    idleBorder: "#e8b8b8",
    idleHover: "#fdf5f5",
  },
  {
    val: "skipped",
    label: "Skipped",
    activeBg: "#92400e",
    activeText: "#ffffff",
    idleText: "#a07830",
    idleBorder: "#fde68a",
    idleHover: "#fdfbf0",
  },
];

export function PracticeQuestionsSidebar({
  items,
  currentIndex,
  onSelectQuestion,
  filters,
  onFilterChange,
  collapsed = false,
  onToggleCollapsed,
  scoreCorrect = 0,
  scoreTotal = 0,
}: PracticeQuestionsSidebarProps) {
  const activeItemRef = useRef<HTMLLIElement | null>(null);

  useEffect(() => {
    activeItemRef.current?.scrollIntoView({ block: "nearest", behavior: "smooth" });
  }, [currentIndex]);

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
    <div className="flex w-[192px] shrink-0 flex-col border-r border-[#ebe8e1] bg-white overflow-hidden">
      {/* Header */}
      <div className="shrink-0 border-b border-[#f0ede6] px-3 pt-3 pb-2">
        <div className="mb-2 flex items-center justify-between gap-1">
          <span className="text-xs font-bold text-[#1c1b1f]">Questions</span>
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

      {/* Difficulty filter row */}
      <div className="shrink-0 border-b border-[#f0ede6] px-2.5 py-2">
        <p className="mb-1.5 text-[9px] font-bold uppercase tracking-wide text-[#9a9690]">Difficulty</p>
        <div className="flex flex-wrap gap-1">
          {DIFF_CHIPS.map(({ val, label }) => {
            const active = filters.difficulty === val;
            const colorKey = val === "easy" ? "Easy" : val === "medium" ? "Medium" : val === "hard" ? "Hard" : null;
            const colors = colorKey ? DIFF_COLORS[colorKey] : null;

            const style = active
              ? {
                  backgroundColor: colors ? colors.activeBg : "#1a1a2e",
                  color: "#ffffff",
                  borderColor: "transparent",
                }
              : {
                  backgroundColor: colors ? colors.bg : "#ffffff",
                  color: colors ? colors.text : "#6b6966",
                  borderColor: colors ? colors.border : "#e0ddd6",
                };

            return (
              <button
                key={val}
                type="button"
                onClick={() => onFilterChange({ difficulty: val })}
                className="rounded-full border px-2.5 py-1 text-[10.5px] font-semibold transition-all duration-100"
                style={style}
              >
                {label}
              </button>
            );
          })}
        </div>
      </div>

      {/* Status filter rows */}
      <div className="shrink-0 border-b border-[#f0ede6] px-2.5 py-2">
        <p className="mb-1.5 text-[9px] font-bold uppercase tracking-wide text-[#9a9690]">Status</p>
        <div className="flex flex-wrap gap-1">
          {STATUS_CHIPS.map(({ val, label, activeBg, activeText, idleText, idleBorder, idleHover }) => {
            const active = filters.status === val;
            return (
              <button
                key={val ?? "all"}
                type="button"
                onClick={() => onFilterChange({ status: val })}
                className="rounded-full border px-2.5 py-1 text-[10.5px] font-semibold transition-all duration-100"
                style={
                  active
                    ? { backgroundColor: activeBg, color: activeText, borderColor: "transparent" }
                    : { backgroundColor: "white", color: idleText, borderColor: idleBorder }
                }
                onMouseEnter={(e) => {
                  if (!active) (e.currentTarget as HTMLButtonElement).style.backgroundColor = idleHover;
                }}
                onMouseLeave={(e) => {
                  if (!active) (e.currentTarget as HTMLButtonElement).style.backgroundColor = "white";
                }}
              >
                {label}
              </button>
            );
          })}
        </div>
      </div>

      {/* Question list */}
      <div className="min-h-0 flex-1 overflow-y-auto p-1.5">
        {items.length === 0 ? (
          <p className="text-[10px] text-[#9a9690] px-1 pt-1">No questions match filters.</p>
        ) : (
          <ul className="space-y-0.5">
            {items.map((item) => {
              const status = getStatus(item);
              const isCurrent = currentIndex === item.order - 1;
              const isCorrect = status === "correct";
              const isHint = status === "hint";
              const isBad = status === "wrong";
              const isSkipped = status === "skipped";
              const diffLabel = getDifficultyLabel(item.difficulty);
              const diffColors = diffLabel ? DIFF_COLORS[diffLabel] : null;

              const base = "flex items-center gap-1.5 w-full rounded-lg border border-l-[3px] pl-2 pr-2 py-2 text-left transition-all cursor-pointer";
              const stateBg =
                isCurrent ? "bg-[#fdfaf4] border-[#f0e6c8]" :
                isCorrect  ? "border-[#c8e6d4] bg-[#f8fcfa]" :
                isHint     ? "border-[#e8d5a0] bg-[#fdfaf0]" :
                isBad      ? "border-[#e8c8c8] bg-[#fdf8f8]" :
                isSkipped  ? "border-[#e8d8a0] bg-[#fdfaf0]" :
                             "border-transparent hover:bg-[#fdfcfa] hover:border-[#ebe8e1]";

              const leftBorderStyle = diffColors
                ? { borderLeftColor: diffColors.border }
                : { borderLeftColor: "transparent" };

              const statusIcon = isCorrect ? "✓" : isHint ? "~" : isBad ? "✗" : isSkipped ? "–" : isCurrent ? "▶" : "";
              const qNumColor =
                isBad ? "text-[#b85555]" :
                isCorrect ? "text-[#4b9e6a]" :
                isHint ? "text-[#a07830]" :
                isSkipped ? "text-[#a07830]" :
                isCurrent ? "text-[#f59207]" :
                "text-[#9a9690]";
              const labelColor =
                isBad ? "text-[#b85555]" :
                isCorrect ? "text-[#4b9e6a]" :
                isHint ? "text-[#a07830]" :
                isSkipped ? "text-[#a07830]" :
                isCurrent ? "text-[#1c1b1f] font-semibold" :
                "text-[#6b6966]";

              return (
                <li
                  key={item.order}
                  ref={isCurrent ? activeItemRef : undefined}
                >
                  <button
                    type="button"
                    onClick={() => onSelectQuestion(item.order)}
                    className={`${base} ${stateBg}`}
                    style={leftBorderStyle}
                    aria-label={`Question ${item.order}`}
                  >
                    <span className={`text-[11px] font-bold w-5 shrink-0 ${qNumColor}`}>
                      Q{item.order}
                    </span>
                    {item.question ? (
                      <span className={`text-[11px] flex-1 line-clamp-2 min-w-0 ${labelColor}`}>
                        {toPlainPreview(item.question) || `Question ${item.order}`}
                      </span>
                    ) : item.topic ? (
                      <span className={`text-[11px] flex-1 line-clamp-2 min-w-0 ${labelColor}`}>
                        {item.topic}
                      </span>
                    ) : (
                      <span className={`text-[11px] flex-1 min-w-0 ${labelColor}`}>
                        Question {item.order}
                      </span>
                    )}
                    <span
                      className={`text-[10px] font-semibold shrink-0 ${
                        isCorrect ? "text-[#4b9e6a]" :
                        isHint ? "text-[#a07830]" :
                        isBad ? "text-[#b85555]" :
                        isSkipped ? "text-[#a07830]" :
                        isCurrent ? "text-[#c8a84a]" :
                        "text-transparent"
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

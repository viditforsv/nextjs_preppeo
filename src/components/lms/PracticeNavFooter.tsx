"use client";

import { ChevronLeft, ChevronRight } from "lucide-react";

interface PracticeNavFooterProps {
  navPosition: number;
  navTotal: number;
  jumpInput: string;
  onJumpInputChange: (value: string) => void;
  onJumpTo: (position: number) => void;
  onPrev: () => void;
  onNext: () => void;
  isPrevDisabled: boolean;
  isNextDisabled: boolean;
}

export function PracticeNavFooter({
  navPosition,
  navTotal,
  jumpInput,
  onJumpInputChange,
  onJumpTo,
  onPrev,
  onNext,
  isPrevDisabled,
  isNextDisabled,
}: PracticeNavFooterProps) {
  if (navTotal <= 1) return null;

  return (
    <div className="mt-4 flex shrink-0 items-center justify-between gap-2 border-t border-[#ebe8e1] bg-white px-6 py-3">
      <button
        type="button"
        disabled={isPrevDisabled}
        className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#e0ddd6] bg-white px-4 py-2 text-xs font-semibold text-[#6b6966] transition-all hover:bg-[#f5f4f1] disabled:opacity-40 disabled:cursor-not-allowed"
        onClick={onPrev}
      >
        <ChevronLeft className="h-4 w-4" /> Previous
      </button>

      <div className="flex flex-col items-center gap-1.5 min-w-0">
        <div className="flex items-center gap-1.5">
          <input
            type="number"
            min={1}
            max={navTotal}
            value={jumpInput}
            onChange={(e) => onJumpInputChange(e.target.value)}
            onBlur={() => {
              const n = parseInt(jumpInput, 10);
              if (!isNaN(n)) {
                onJumpTo(Math.min(navTotal, Math.max(1, n)));
              } else {
                onJumpInputChange(String(navPosition));
              }
            }}
            onKeyDown={(e) => {
              if (e.key === "Enter") (e.target as HTMLInputElement).blur();
            }}
            className="w-11 rounded-lg border border-[#e0ddd6] bg-white px-1 py-1 text-center text-xs font-bold text-[#1c1b1f] focus:border-[#f59207] focus:outline-none"
          />
          <span className="text-xs font-medium text-[#9a9690]">/ {navTotal}</span>
        </div>
        <div className="w-full max-w-[120px] h-1 rounded-full bg-[#e0ddd6] overflow-hidden">
          <div
            className="h-full rounded-full bg-[#f59207] transition-[width] duration-200"
            style={{ width: `${(navPosition / navTotal) * 100}%` }}
          />
        </div>
      </div>

      <button
        type="button"
        disabled={isNextDisabled}
        className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#f59207] bg-[#f59207] px-4 py-2 text-xs font-semibold text-white transition-all hover:bg-[#e08a00] disabled:border-[#e0ddd6] disabled:bg-[#e0ddd6] disabled:cursor-not-allowed disabled:text-[#b8b5ae]"
        onClick={onNext}
      >
        Next <ChevronRight className="h-4 w-4" />
      </button>
    </div>
  );
}

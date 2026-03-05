"use client";

import { renderMixedContent } from "@/components/MathRenderer";
import type { InteractiveQuizItem } from "./InteractiveLessonView";
import {
  DIFF,
  type DiffKey,
  optionLabel,
  cleanOptionText,
  getHintText,
  getOptionVisualState,
  getOptionClasses,
  buildAskAIMessage,
  buildAskAIStepByStep,
} from "./practiceHelpers";

interface PracticeQuestionCardProps {
  question: InteractiveQuizItem;
  questionIndex: number;
  navPosition: number;
  navTotal: number;
  elapsedSeconds: number;
  selectedOption: number | undefined;
  isSubmitted: boolean;
  isCorrect: boolean;
  isSkipped: boolean;
  hintRevealed: boolean;
  explanationRevealed: boolean;
  onSelectOption: (optionIndex: number) => void;
  onSubmit: () => void;
  onSkip: () => void;
  onToggleHint: () => void;
  onToggleExplanation: () => void;
  onAskAI?: (message: string) => void;
  onRetry: () => void;
}

export function PracticeQuestionCard({
  question: q,
  questionIndex: i,
  navPosition,
  navTotal,
  elapsedSeconds,
  selectedOption: selected,
  isSubmitted: submitted,
  isCorrect,
  isSkipped: skipped,
  hintRevealed,
  explanationRevealed,
  onSelectOption,
  onSubmit,
  onSkip,
  onToggleHint,
  onToggleExplanation,
  onAskAI,
  onRetry,
}: PracticeQuestionCardProps) {
  const opts = q.options?.length ? q.options : ["No options"];
  const correctIndex = Math.min(q.answer ?? 0, opts.length - 1);
  const difficulty: DiffKey = q.difficulty ?? "Medium";
  const diffStyle = DIFF[difficulty];

  const cardBorderClass = submitted
    ? isCorrect
      ? "border-[#86efac]"
      : "border-[#fca5a5]"
    : "border-[#ebe8e1]";

  return (
    <div
      key={i}
      className={`rounded-xl border bg-white p-5 transition-shadow ${cardBorderClass}`}
    >
      {/* Meta row */}
      <div className="mb-3 flex flex-wrap items-center gap-2">
        <span className="text-[11.5px] font-bold text-[#9a9690]">
          Q{navPosition} of {navTotal}
        </span>
        {!submitted && (
          <span
            className={`font-mono text-[11px] rounded-md border px-2 py-1 flex items-center gap-1 ${
              elapsedSeconds > 90
                ? "text-[#dc2626] border-[#fca5a5] bg-[#fef2f2]"
                : "text-[#9a9690] border-[#ebe8e1] bg-white"
            }`}
          >
            ⏱ {Math.floor(elapsedSeconds / 60)}:{String(elapsedSeconds % 60).padStart(2, "0")}
          </span>
        )}
        <span
          className="rounded-[20px] border px-2 py-0.5 text-[10px] font-extrabold"
          style={{ background: diffStyle.bg, color: diffStyle.text, borderColor: diffStyle.border }}
        >
          {difficulty}
        </span>
        {submitted && (
          <span
            className={`ml-auto flex items-center gap-1 rounded-[20px] border px-2.5 py-1 text-[11.5px] font-bold ${
              skipped
                ? "bg-[#f5f4f1] text-[#6b6966] border-[#e0ddd6]"
                : isCorrect
                  ? "bg-[#f0fdf4] text-[#15803d] border-[#86efac]"
                  : "bg-[#fef2f2] text-[#dc2626] border-[#fca5a5]"
            }`}
          >
            {skipped ? "Skipped" : isCorrect ? "✓ Correct!" : "✗ Incorrect"}
          </span>
        )}
      </div>

      {/* Question */}
      <p className="mb-5 text-[15.5px] font-semibold leading-relaxed text-[#1c1b1f] tracking-tight">
        {renderMixedContent(q.question)}
      </p>

      {/* Options */}
      <div className="mb-4 flex flex-col gap-2">
        {opts.map((opt, oi) => {
          const state = getOptionVisualState({
            optionIndex: oi,
            selectedIndex: submitted ? undefined : selected,
            correctIndex,
            isSubmitted: submitted,
          });
          const visualSelected = !submitted && selected === oi;
          const actualState = visualSelected ? "selected" : state;
          const classes = getOptionClasses(actualState);

          return (
            <button
              key={oi}
              type="button"
              disabled={submitted}
              onClick={() => !submitted && onSelectOption(oi)}
              className={`flex w-full items-center gap-3 rounded-[11px] border-[1.5px] px-4 py-3 text-left text-[13.5px] transition-all duration-150 focus:outline-none focus-visible:ring-2 focus-visible:ring-[#f59207] focus-visible:ring-offset-2 disabled:pointer-events-none disabled:cursor-default hover:border-[#c8b87a] hover:bg-[#fdfcfa] hover:shadow-[0_2px_8px_rgba(0,0,0,0.04)] hover:translate-x-[3px] ${classes.row}`}
              style={{ cursor: submitted ? "default" : "pointer" }}
            >
              <span
                className={`flex h-7 w-7 shrink-0 items-center justify-center rounded-lg border-[1.5px] text-xs font-extrabold ${classes.letter}`}
              >
                {submitted && oi === correctIndex
                  ? "✓"
                  : submitted && oi === selected && oi !== correctIndex
                    ? "✗"
                    : optionLabel(oi)}
              </span>
              <span className={`flex-1 ${classes.text}`}>
                {renderMixedContent(cleanOptionText(opt))}
              </span>
            </button>
          );
        })}
      </div>

      {/* Action buttons — grouped: primary | secondary | tertiary */}
      <div className="flex flex-wrap items-center gap-2">
        {/* Primary actions */}
        {!submitted ? (
          <div className="flex items-center gap-2">
            <button
              type="button"
              disabled={selected === undefined}
              className={`inline-flex items-center gap-1.5 rounded-lg border-[1.5px] px-3.5 py-2 text-xs font-semibold transition-all active:scale-[0.97] disabled:cursor-not-allowed disabled:shadow-none ${
                selected === undefined
                  ? "bg-[#e0ddd6] border-[#e0ddd6] text-[#b8b5ae]"
                  : "bg-[#f59207] border-[#f59207] text-white shadow-[0_2px_6px_rgba(245,146,7,0.16)]"
              }`}
              onClick={onSubmit}
            >
              ✓ Submit
            </button>
            <button
              type="button"
              className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#e0ddd6] bg-white px-3.5 py-2 text-xs font-semibold text-[#6b6966] transition-all hover:bg-[#f5f4f1] active:scale-[0.97]"
              onClick={onSkip}
            >
              Skip
            </button>
          </div>
        ) : (
          <button
            type="button"
            className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#e0ddd6] bg-white px-3.5 py-2 text-xs font-semibold text-[#6b6966] transition-all hover:bg-[#f5f4f1] active:scale-[0.97]"
            onClick={onRetry}
          >
            ↺ Retry
          </button>
        )}

        {/* Spacer pushes secondary actions to the right */}
        <div className="flex-1" />

        {/* Secondary actions */}
        <div className="flex items-center gap-2">
          <button
            type="button"
            className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#fde9b8] bg-[#fffbf0] px-3.5 py-2 text-xs font-semibold text-[#b45309] transition-all hover:bg-[#fef3c7] active:scale-[0.97]"
            onClick={onToggleHint}
          >
            💡 {hintRevealed ? "Hide Hint" : "Hint"}
          </button>
          {submitted && (
            <button
              type="button"
              className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#86efac] bg-[#f0fdf4] px-3.5 py-2 text-xs font-semibold text-[#15803d] transition-all hover:bg-[#dcfce7] active:scale-[0.97]"
              onClick={onToggleExplanation}
            >
              📖 {explanationRevealed ? "Hide" : "Explain"}
            </button>
          )}
          <button
            type="button"
            className="inline-flex items-center gap-1.5 rounded-lg border-[1.5px] border-[#c7d2fe] bg-[#eef2ff] px-3.5 py-2 text-xs font-semibold text-[#4338ca] transition-all hover:bg-[#e0e7ff] active:scale-[0.97]"
            onClick={() => onAskAI?.(buildAskAIMessage(q))}
          >
            🤖 Ask AI
          </button>
        </div>
      </div>

      {/* Hint panel */}
      {hintRevealed && (
        <div className="mt-3 rounded-[10px] border border-[#fde9b8] bg-[#fffbf0] p-3 text-[12.5px] leading-relaxed text-[#78350f] [&_strong]:text-[#1c1b1f]">
          💡 <strong>Hint:</strong> {renderMixedContent(getHintText(q.explanation ?? ""))}
        </div>
      )}

      {/* Explanation panel */}
      {explanationRevealed && (
        <div className="mt-3 rounded-[10px] border border-[#86efac] bg-[#f0fdf4] p-3 text-[12.5px] leading-relaxed text-[#14532d] [&_strong]:text-[#1c1b1f]">
          📖 <strong>Explanation:</strong> {renderMixedContent(q.explanation ?? "")}
        </div>
      )}

      {/* Nudge to AI tutor */}
      {!hintRevealed && !explanationRevealed && (
        <p className="mt-4 text-center text-xs text-[#8b8880]">
          Stuck?{" "}
          <button
            type="button"
            onClick={() => onAskAI?.(buildAskAIStepByStep(q))}
            className="font-semibold text-[#f59207] hover:text-[#e08a00] hover:underline"
          >
            Ask the AI tutor →
          </button>
        </p>
      )}
    </div>
  );
}

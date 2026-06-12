"use client";

import { useState } from "react";
import { Check, X, ChevronRight, RotateCcw, Trophy } from "lucide-react";
import { renderMixedContent } from "@/components/MathRenderer";
import type { SatLearnQuizQuestion } from "@/types/sat-learn";

const NAVY = "#1a365d";
const AMBER = "#f4b400";

/**
 * Embedded concept-check quiz for a SAT-learn lesson. Basic questions that
 * test the topic's concepts — select an option, check it (instant feedback +
 * explanation), advance, then see a score with a retake.
 */
export function SatLearnQuiz({ questions }: { questions: SatLearnQuizQuestion[] }) {
  const [index, setIndex] = useState(0);
  const [selected, setSelected] = useState<string | null>(null);
  const [checked, setChecked] = useState(false);
  const [score, setScore] = useState(0);
  const [done, setDone] = useState(false);

  if (questions.length === 0) {
    return <p className="text-sm text-gray-500">No quiz questions yet.</p>;
  }

  const q = questions[index];
  const total = questions.length;
  const isCorrect = checked && selected === q.correctAnswer;

  const check = () => {
    if (!selected) return;
    setChecked(true);
    if (selected === q.correctAnswer) setScore((s) => s + 1);
  };

  const next = () => {
    if (index < total - 1) {
      setIndex(index + 1);
      setSelected(null);
      setChecked(false);
    } else {
      setDone(true);
    }
  };

  const retake = () => {
    setIndex(0);
    setSelected(null);
    setChecked(false);
    setScore(0);
    setDone(false);
  };

  /* ── Results ──────────────────────────────────────────────────── */
  if (done) {
    const pct = Math.round((score / total) * 100);
    return (
      <div className="mx-auto max-w-md py-6 text-center">
        <div
          className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full"
          style={{ background: "#fef9e7", color: AMBER }}
        >
          <Trophy className="h-8 w-8" />
        </div>
        <h2 className="text-2xl font-bold" style={{ color: NAVY }}>
          {score} / {total} correct
        </h2>
        <p className="mt-1 text-gray-500">{pct}% — concept check complete</p>

        <div className="mt-6 h-3 w-full rounded-full bg-gray-200">
          <div
            className="h-3 rounded-full transition-all"
            style={{ width: `${pct}%`, background: pct >= 70 ? "#16a34a" : AMBER }}
          />
        </div>

        <button
          onClick={retake}
          className="mt-8 inline-flex items-center justify-center gap-2 rounded-xl px-5 py-3 text-sm font-bold"
          style={{ background: NAVY, color: "white" }}
        >
          <RotateCcw className="h-4 w-4" /> Retake quiz
        </button>
      </div>
    );
  }

  /* ── Active question ──────────────────────────────────────────── */
  return (
    <div className="mx-auto max-w-2xl">
      {/* Progress */}
      <div className="mb-4">
        <div className="mb-2 flex items-center justify-between text-sm text-gray-500">
          <span>
            Question {index + 1} of {total}
          </span>
          <span>{score} correct</span>
        </div>
        <div className="h-1.5 w-full rounded-full bg-gray-200">
          <div
            className="h-1.5 rounded-full transition-all"
            style={{ width: `${((index + 1) / total) * 100}%`, background: AMBER }}
          />
        </div>
      </div>

      {/* Question */}
      <div className="text-lg font-medium leading-relaxed" style={{ color: NAVY }}>
        {renderMixedContent(q.question)}
      </div>

      {/* Options */}
      <div className="mt-5 space-y-2.5">
        {q.options.map((opt) => {
          const chosen = selected === opt.id;
          const correct = opt.id === q.correctAnswer;
          let style: React.CSSProperties = { borderColor: "#e5e7eb" };
          if (checked) {
            if (correct) style = { borderColor: "#16a34a", background: "#f0fdf4" };
            else if (chosen) style = { borderColor: "#dc2626", background: "#fef2f2" };
          } else if (chosen) {
            style = { borderColor: NAVY, background: "#eef2f7" };
          }
          return (
            <button
              key={opt.id}
              disabled={checked}
              onClick={() => setSelected(opt.id)}
              className="flex w-full items-center gap-3 rounded-xl border-2 px-4 py-3 text-left text-sm transition-colors disabled:cursor-default"
              style={style}
            >
              <span
                className="flex h-6 w-6 flex-shrink-0 items-center justify-center rounded-full border text-xs font-semibold"
                style={{ borderColor: "#cbd5e1", color: NAVY }}
              >
                {opt.id}
              </span>
              <span className="min-w-0 flex-1 text-gray-700">
                {renderMixedContent(opt.text)}
              </span>
              {checked && correct && <Check className="h-4 w-4 text-green-600" />}
              {checked && chosen && !correct && <X className="h-4 w-4 text-red-600" />}
            </button>
          );
        })}
      </div>

      {/* Explanation */}
      {checked && (
        <div
          className="mt-4 rounded-xl border px-4 py-3 text-sm"
          style={
            isCorrect
              ? { background: "#f0fdf4", borderColor: "#bbf7d0", color: "#166534" }
              : { background: "#fef2f2", borderColor: "#fecaca", color: "#991b1b" }
          }
        >
          <p className="font-semibold">{isCorrect ? "Correct!" : "Not quite."}</p>
          {q.explanation && (
            <p className="mt-1 leading-relaxed">{renderMixedContent(q.explanation)}</p>
          )}
        </div>
      )}

      {/* Action */}
      <div className="mt-5 flex justify-end">
        {!checked ? (
          <button
            onClick={check}
            disabled={!selected}
            className="rounded-xl px-5 py-2.5 text-sm font-bold transition-opacity disabled:opacity-40"
            style={{ background: AMBER, color: NAVY }}
          >
            Check answer
          </button>
        ) : (
          <button
            onClick={next}
            className="inline-flex items-center gap-1 rounded-xl px-5 py-2.5 text-sm font-bold"
            style={{ background: NAVY, color: "white" }}
          >
            {index < total - 1 ? "Next" : "See results"}
            <ChevronRight className="h-4 w-4" />
          </button>
        )}
      </div>
    </div>
  );
}

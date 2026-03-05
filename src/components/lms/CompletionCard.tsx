"use client";

import Link from "next/link";
import { ChevronRight } from "lucide-react";
import { Button } from "@/design-system/components/ui/button";

interface CompletionCardProps {
  scoreCorrect: number;
  quizLength: number;
  skippedCount: number;
  courseSlug: string;
  nextLessonSlug?: string | null;
  onReviewWrong: () => void;
  onAskRecap: () => void;
}

export function CompletionCard({
  scoreCorrect,
  quizLength,
  skippedCount,
  courseSlug,
  nextLessonSlug,
  onReviewWrong,
  onAskRecap,
}: CompletionCardProps) {
  const allCorrect = scoreCorrect === quizLength;
  const wrongCount = quizLength - scoreCorrect - skippedCount;

  const emoji = allCorrect ? "🎉" : scoreCorrect >= Math.ceil(quizLength / 2) ? "👍" : "💪";
  const heading = allCorrect
    ? "Perfect score!"
    : scoreCorrect >= Math.ceil(quizLength / 2)
      ? "Good work!"
      : "Keep going!";

  return (
    <div className="rounded-xl border-2 border-[#86efac] bg-linear-to-br from-[#f0fdf4] to-white p-6 text-center shadow-sm">
      <div className="mb-3 text-4xl">{emoji}</div>
      <h3 className="mb-1 text-lg font-extrabold text-[#15803d]">{heading}</h3>
      <p className="mb-5 text-sm text-[#6b6966]">
        You got <strong className="text-[#1c1b1f]">{scoreCorrect} out of {quizLength}</strong> correct
        {wrongCount > 0 ? ` · ${wrongCount} wrong` : ""}
        {skippedCount > 0 ? ` · ${skippedCount} skipped` : ""}
      </p>
      <div className="flex flex-wrap justify-center gap-2">
        {scoreCorrect < quizLength && (
          <button
            type="button"
            onClick={onReviewWrong}
            className="inline-flex items-center gap-1.5 rounded-lg border-2 border-[#f59207] px-4 py-2 text-xs font-bold text-[#f59207] transition-all hover:bg-[#fff8ee] active:scale-[0.97]"
          >
            ↺ Review wrong answers
          </button>
        )}
        <button
          type="button"
          onClick={onAskRecap}
          className="inline-flex items-center gap-1.5 rounded-lg border-2 border-[#c7d2fe] bg-[#eef2ff] px-4 py-2 text-xs font-bold text-[#4338ca] transition-all hover:bg-[#e0e7ff] active:scale-[0.97]"
        >
          🤖 Ask AI to recap
        </button>
        {nextLessonSlug && (
          <Button size="sm" asChild className="rounded-lg bg-[#f59207] text-white hover:bg-[#e08a00]">
            <Link href={`/learn/${courseSlug}/lesson/${nextLessonSlug}`}>
              Next lesson <ChevronRight className="h-4 w-4 ml-1" />
            </Link>
          </Button>
        )}
      </div>
    </div>
  );
}

"use client";

import { useState } from "react";
import {
  CheckCircle,
  RotateCcw,
  ChevronLeft,
  ChevronRight,
  Layers,
} from "lucide-react";
import { renderMixedContent } from "@/components/MathRenderer";
import type { SatLearnFlashcard } from "@/types/sat-learn";

const NAVY = "#1a365d";
const AMBER = "#f4b400";

/**
 * Self-contained flashcard deck for SAT-learn lessons. 3D flip, Know-It /
 * Review-Again tracking, and a session-complete screen with a review loop.
 * Adapted from the CBSE-10 Science FlashcardView (no global store here).
 */
export function SatLearnFlashcards({ cards }: { cards: SatLearnFlashcard[] }) {
  const [deck, setDeck] = useState(cards);
  const [index, setIndex] = useState(0);
  const [flipped, setFlipped] = useState(false);
  const [known, setKnown] = useState<string[]>([]);
  const [review, setReview] = useState<string[]>([]);
  const [sessionDone, setSessionDone] = useState(false);

  const total = deck.length;
  const card = deck[index];
  const markedCount = known.length + review.length;

  const advance = () => {
    setFlipped(false);
    if (index < total - 1) {
      setTimeout(() => setIndex(index + 1), 150);
    } else {
      setSessionDone(true);
    }
  };

  const handleKnow = () => {
    if (!card) return;
    setKnown((k) => (k.includes(card.id) ? k : [...k, card.id]));
    setReview((r) => r.filter((id) => id !== card.id));
    advance();
  };

  const handleReview = () => {
    if (!card) return;
    setReview((r) => (r.includes(card.id) ? r : [...r, card.id]));
    setKnown((k) => k.filter((id) => id !== card.id));
    advance();
  };

  const goPrev = () => {
    if (index > 0) {
      setFlipped(false);
      setTimeout(() => setIndex(index - 1), 150);
    }
  };

  const restart = (subset?: SatLearnFlashcard[]) => {
    setDeck(subset && subset.length ? subset : cards);
    setIndex(0);
    setKnown([]);
    setReview([]);
    setFlipped(false);
    setSessionDone(false);
  };

  if (cards.length === 0) {
    return <p className="text-sm text-gray-500">No flashcards yet.</p>;
  }

  /* ── Session complete ─────────────────────────────────────────── */
  if (sessionDone) {
    const reviewCards = deck.filter((c) => review.includes(c.id));
    const knownPct = total > 0 ? Math.round((known.length / total) * 100) : 0;
    return (
      <div className="mx-auto max-w-md py-6 text-center">
        <div
          className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full"
          style={{ background: "#eef2f7", color: NAVY }}
        >
          <Layers className="h-8 w-8" />
        </div>
        <h2 className="text-2xl font-bold" style={{ color: NAVY }}>
          Session complete!
        </h2>
        <p className="mt-1 text-gray-500">{total} cards reviewed</p>

        <div className="mt-6 grid grid-cols-2 gap-4">
          <div className="rounded-xl border border-gray-200 bg-white p-4">
            <p className="text-3xl font-bold text-green-600">{known.length}</p>
            <p className="mt-1 text-sm text-gray-500">Know It</p>
          </div>
          <div className="rounded-xl border border-gray-200 bg-white p-4">
            <p className="text-3xl font-bold text-amber-600">{review.length}</p>
            <p className="mt-1 text-sm text-gray-500">Review Again</p>
          </div>
        </div>

        <div className="mt-6 h-3 w-full rounded-full bg-gray-200">
          <div
            className="h-3 rounded-full transition-all"
            style={{ width: `${knownPct}%`, background: NAVY }}
          />
        </div>
        <p className="mt-2 text-sm text-gray-500">{knownPct}% mastered</p>

        <div className="mt-8 space-y-3">
          {reviewCards.length > 0 && (
            <button
              onClick={() => restart(reviewCards)}
              className="inline-flex w-full items-center justify-center gap-2 rounded-xl py-3 font-semibold text-white transition-opacity hover:opacity-90"
              style={{ background: NAVY }}
            >
              <RotateCcw className="h-4 w-4" />
              Review {reviewCards.length} card{reviewCards.length > 1 ? "s" : ""} again
            </button>
          )}
          <button
            onClick={() => restart()}
            className="w-full rounded-xl border-2 py-3 font-semibold transition-colors hover:bg-gray-50"
            style={{ borderColor: "#e5e7eb", color: NAVY }}
          >
            Restart deck
          </button>
        </div>
      </div>
    );
  }

  if (!card) return null;

  /* ── Active card ──────────────────────────────────────────────── */
  return (
    <div className="mx-auto flex max-w-2xl flex-col items-center">
      {/* Progress */}
      <div className="mb-4 w-full">
        <div className="mb-2 flex items-center justify-between text-sm text-gray-500">
          <span>
            Card {index + 1} of {total}
          </span>
          <span>{markedCount} marked</span>
        </div>
        <div className="h-1.5 w-full rounded-full bg-gray-200">
          <div
            className="h-1.5 rounded-full transition-all"
            style={{ width: `${((index + 1) / total) * 100}%`, background: AMBER }}
          />
        </div>
      </div>

      {/* Card */}
      <div
        className="w-full cursor-pointer select-none"
        style={{ perspective: "1200px" }}
        onClick={() => setFlipped((v) => !v)}
      >
        <div
          style={{
            transformStyle: "preserve-3d",
            transition: "transform 0.45s cubic-bezier(0.4, 0, 0.2, 1)",
            transform: flipped ? "rotateY(180deg)" : "rotateY(0deg)",
            position: "relative",
            minHeight: "260px",
          }}
        >
          {/* Front */}
          <div
            className="absolute inset-0 flex flex-col rounded-2xl border-2 border-gray-200 bg-white p-6 shadow-sm"
            style={{ backfaceVisibility: "hidden" }}
          >
            <div className="flex items-center justify-between">
              <span
                className="rounded-full px-2 py-0.5 text-xs font-medium"
                style={{ background: "#eef2f7", color: NAVY }}
              >
                {card.section === "math" ? "Quant" : "English"}
              </span>
              <span className="text-xs text-gray-400">Tap to flip</span>
            </div>
            <div className="flex flex-1 items-center justify-center">
              <div className="text-center text-lg leading-relaxed" style={{ color: NAVY }}>
                {renderMixedContent(card.front)}
              </div>
            </div>
            <div className="text-center">
              <span className="text-xs font-medium uppercase tracking-wide text-gray-400">
                Term
              </span>
            </div>
          </div>

          {/* Back */}
          <div
            className="absolute inset-0 flex flex-col rounded-2xl border-2 p-6 text-white shadow-sm"
            style={{
              backfaceVisibility: "hidden",
              transform: "rotateY(180deg)",
              background: NAVY,
              borderColor: NAVY,
            }}
          >
            <div className="flex items-center justify-between">
              <span className="text-xs font-medium uppercase tracking-wide text-white/60">
                Answer
              </span>
              <span className="text-xs text-white/50">Tap to flip back</span>
            </div>
            <div className="flex flex-1 items-center justify-center">
              <div className="text-center text-lg font-medium leading-relaxed">
                {renderMixedContent(card.back)}
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Know / Review */}
      <div className="mt-6 flex w-full gap-3">
        <button
          onClick={handleReview}
          className="flex flex-1 items-center justify-center gap-2 rounded-xl border-2 border-amber-300 bg-amber-50 py-3 text-sm font-semibold text-amber-700 transition-colors hover:bg-amber-100"
        >
          <RotateCcw className="h-4 w-4" />
          Review Again
        </button>
        <button
          onClick={handleKnow}
          className="flex flex-1 items-center justify-center gap-2 rounded-xl bg-green-600 py-3 text-sm font-semibold text-white transition-colors hover:bg-green-700"
        >
          <CheckCircle className="h-4 w-4" />
          Know It
        </button>
      </div>

      {/* Nav */}
      <div className="mt-3 flex w-full items-center justify-between">
        <button
          onClick={goPrev}
          disabled={index === 0}
          className="inline-flex items-center gap-1.5 px-3 py-2 text-sm text-gray-500 transition-colors hover:text-gray-700 disabled:opacity-30"
        >
          <ChevronLeft className="h-4 w-4" /> Prev
        </button>
        <div className="flex items-center gap-2 text-xs font-medium">
          {known.includes(card.id) && <span className="text-green-600">✓ Known</span>}
          {review.includes(card.id) && <span className="text-amber-600">↻ To review</span>}
        </div>
        <button
          onClick={advance}
          className="inline-flex items-center gap-1.5 px-3 py-2 text-sm text-gray-500 transition-colors hover:text-gray-700"
        >
          Skip <ChevronRight className="h-4 w-4" />
        </button>
      </div>
    </div>
  );
}

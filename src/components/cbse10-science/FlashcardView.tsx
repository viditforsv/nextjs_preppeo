'use client';

import { useState } from 'react';
import { useCBSE10ScienceStore } from '@/stores/useCBSE10ScienceStore';
import { renderMixedContent } from '@/components/MathRenderer';
import { CheckCircle, RotateCcw, ChevronLeft, ChevronRight, Layers, ArrowLeft } from 'lucide-react';

export default function FlashcardView() {
  const {
    flashcardCards,
    flashcardIndex,
    flashcardKnown,
    flashcardReview,
    navigateFlashcard,
    markFlashcardKnown,
    markFlashcardReview,
    goToFlashcardConfig,
    goToLanding,
  } = useCBSE10ScienceStore();

  const [flipped, setFlipped] = useState(false);
  const [sessionDone, setSessionDone] = useState(false);

  const total = flashcardCards.length;
  const card = flashcardCards[flashcardIndex];
  const isKnown = card ? flashcardKnown.includes(card.id) : false;
  const isReview = card ? flashcardReview.includes(card.id) : false;
  const markedCount = flashcardKnown.length + flashcardReview.length;

  const handleKnow = () => {
    if (!card) return;
    markFlashcardKnown(card.id);
    goNext();
  };

  const handleReview = () => {
    if (!card) return;
    markFlashcardReview(card.id);
    goNext();
  };

  const goNext = () => {
    setFlipped(false);
    if (flashcardIndex < total - 1) {
      setTimeout(() => navigateFlashcard(flashcardIndex + 1), 150);
    } else {
      setSessionDone(true);
    }
  };

  const goPrev = () => {
    if (flashcardIndex > 0) {
      setFlipped(false);
      setTimeout(() => navigateFlashcard(flashcardIndex - 1), 150);
    }
  };

  const handleFlip = () => setFlipped((v) => !v);

  // Session complete screen
  if (sessionDone) {
    const reviewAgainCards = flashcardCards.filter((c) => flashcardReview.includes(c.id));
    const knownPct = total > 0 ? Math.round((flashcardKnown.length / total) * 100) : 0;

    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
        <div className="w-full max-w-md text-center">
          <div className="w-16 h-16 bg-violet-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <Layers className="w-8 h-8 text-violet-600" />
          </div>
          <h2 className="text-2xl font-bold text-gray-900 mb-1">Session Complete!</h2>
          <p className="text-gray-500 mb-6">{total} cards reviewed</p>

          <div className="grid grid-cols-2 gap-4 mb-6">
            <div className="bg-white rounded-xl border border-gray-200 p-4">
              <p className="text-3xl font-bold text-green-600">{flashcardKnown.length}</p>
              <p className="text-sm text-gray-500 mt-1">Know It</p>
            </div>
            <div className="bg-white rounded-xl border border-gray-200 p-4">
              <p className="text-3xl font-bold text-amber-600">{flashcardReview.length}</p>
              <p className="text-sm text-gray-500 mt-1">Review Again</p>
            </div>
          </div>

          <div className="w-full bg-gray-200 rounded-full h-3 mb-2">
            <div
              className="h-3 rounded-full bg-violet-600 transition-all"
              style={{ width: `${knownPct}%` }}
            />
          </div>
          <p className="text-sm text-gray-500 mb-8">{knownPct}% mastered</p>

          <div className="space-y-3">
            {reviewAgainCards.length > 0 && (
              <button
                onClick={() => {
                  useCBSE10ScienceStore.setState({
                    flashcardCards: reviewAgainCards,
                    flashcardIndex: 0,
                    flashcardKnown: [],
                    flashcardReview: [],
                  });
                  setSessionDone(false);
                  setFlipped(false);
                }}
                className="w-full py-3 text-white font-semibold rounded-xl bg-violet-600 hover:bg-violet-700 transition-colors inline-flex items-center justify-center gap-2"
              >
                <RotateCcw className="w-4 h-4" />
                Review {reviewAgainCards.length} card{reviewAgainCards.length > 1 ? 's' : ''} again
              </button>
            )}
            <button
              onClick={goToFlashcardConfig}
              className="w-full py-3 font-semibold rounded-xl border-2 border-violet-300 text-violet-700 hover:bg-violet-50 transition-colors"
            >
              New Session
            </button>
            <button
              onClick={goToLanding}
              className="w-full py-3 font-medium rounded-xl text-gray-500 hover:text-gray-700 transition-colors"
            >
              Back to Science Home
            </button>
          </div>
        </div>
      </div>
    );
  }

  if (!card) return null;

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex flex-col">
      {/* Header */}
      <div className="bg-violet-700 text-white px-4 py-3">
        <div className="max-w-2xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Layers className="w-4 h-4 opacity-80" />
            <span className="text-sm font-semibold">Flashcards</span>
            <span className="text-sm opacity-60">·</span>
            <span className="text-sm opacity-80">CBSE 10 Science</span>
          </div>
          <button onClick={goToLanding} className="p-1.5 rounded-lg hover:bg-white/10 transition-colors">
            <ArrowLeft className="w-4 h-4" />
          </button>
        </div>
      </div>

      <div className="flex-1 flex flex-col items-center justify-center p-4">
        {/* Progress */}
        <div className="w-full max-w-2xl mb-4">
          <div className="flex items-center justify-between text-sm text-gray-500 mb-2">
            <span>Card {flashcardIndex + 1} of {total}</span>
            <span>{markedCount} marked</span>
          </div>
          <div className="w-full bg-gray-200 rounded-full h-1.5">
            <div
              className="h-1.5 rounded-full bg-violet-500 transition-all"
              style={{ width: `${((flashcardIndex + 1) / total) * 100}%` }}
            />
          </div>
        </div>

        {/* Card */}
        <div
          className="w-full max-w-2xl cursor-pointer select-none"
          style={{ perspective: '1200px' }}
          onClick={handleFlip}
        >
          <div
            style={{
              transformStyle: 'preserve-3d',
              transition: 'transform 0.45s cubic-bezier(0.4, 0, 0.2, 1)',
              transform: flipped ? 'rotateY(180deg)' : 'rotateY(0deg)',
              position: 'relative',
              minHeight: '280px',
            }}
          >
            {/* Front */}
            <div
              className="absolute inset-0 bg-white rounded-2xl border-2 border-gray-200 shadow-sm p-6 flex flex-col"
              style={{ backfaceVisibility: 'hidden' }}
            >
              <div className="flex items-center justify-between mb-3">
                <div className="flex items-center gap-2">
                  {card.domain && (
                    <span className="px-2 py-0.5 bg-violet-50 text-violet-600 text-xs font-medium rounded-full">
                      {card.domain.replace(/-/g, ' ').replace(/\b\w/g, (c) => c.toUpperCase())}
                    </span>
                  )}
                  <span className={`px-2 py-0.5 text-xs font-medium rounded-full ${
                    card.difficulty === 'easy' ? 'bg-green-50 text-green-600'
                    : card.difficulty === 'medium' ? 'bg-amber-50 text-amber-600'
                    : 'bg-red-50 text-red-600'
                  }`}>
                    {card.difficulty}
                  </span>
                </div>
                <span className="text-xs text-gray-400">Tap to flip</span>
              </div>
              <div className="flex-1 flex items-center justify-center">
                <div className="text-gray-900 text-base leading-relaxed text-center">
                  {renderMixedContent(card.prompt)}
                </div>
              </div>
              <div className="mt-3 text-center">
                <span className="text-xs text-gray-400 font-medium uppercase tracking-wide">Question</span>
              </div>
            </div>

            {/* Back */}
            <div
              className="absolute inset-0 bg-violet-700 rounded-2xl border-2 border-violet-600 shadow-sm p-6 flex flex-col text-white"
              style={{ backfaceVisibility: 'hidden', transform: 'rotateY(180deg)' }}
            >
              <div className="flex items-center justify-between mb-3">
                <span className="text-xs text-violet-200 font-medium uppercase tracking-wide">Answer</span>
                <span className="text-xs text-violet-300">Tap to flip back</span>
              </div>
              <div className="flex-1 flex flex-col gap-3 justify-center">
                <div className="bg-white/20 rounded-xl px-4 py-3 text-center font-semibold text-lg">
                  {renderMixedContent(card.correctAnswer)}
                </div>
                {card.explanation && (
                  <div className="text-sm text-violet-100 leading-relaxed text-center">
                    {renderMixedContent(card.explanation.substring(0, 200))}
                    {card.explanation.length > 200 && '...'}
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>

        {/* Action buttons */}
        <div className="w-full max-w-2xl mt-6 flex gap-3">
          <button
            onClick={handleReview}
            className="flex-1 py-3 text-sm font-semibold rounded-xl border-2 border-amber-300 text-amber-700 bg-amber-50 hover:bg-amber-100 transition-colors flex items-center justify-center gap-2"
          >
            <RotateCcw className="w-4 h-4" />
            Review Again
          </button>
          <button
            onClick={handleKnow}
            className="flex-1 py-3 text-sm font-semibold rounded-xl bg-green-600 text-white hover:bg-green-700 transition-colors flex items-center justify-center gap-2"
          >
            <CheckCircle className="w-4 h-4" />
            Know It
          </button>
        </div>

        {/* Navigation */}
        <div className="w-full max-w-2xl mt-3 flex items-center justify-between">
          <button
            onClick={goPrev}
            disabled={flashcardIndex === 0}
            className="inline-flex items-center gap-1.5 px-3 py-2 text-sm text-gray-500 hover:text-gray-700 disabled:opacity-30 transition-colors"
          >
            <ChevronLeft className="w-4 h-4" />
            Prev
          </button>
          <div className="flex items-center gap-1">
            {isKnown && <span className="text-xs text-green-600 font-medium">✓ Known</span>}
            {isReview && <span className="text-xs text-amber-600 font-medium">↻ To review</span>}
          </div>
          <button
            onClick={() => {
              setFlipped(false);
              setTimeout(() => {
                if (flashcardIndex < total - 1) {
                  navigateFlashcard(flashcardIndex + 1);
                } else {
                  setSessionDone(true);
                }
              }, 150);
            }}
            className="inline-flex items-center gap-1.5 px-3 py-2 text-sm text-gray-500 hover:text-gray-700 transition-colors"
          >
            Skip
            <ChevronRight className="w-4 h-4" />
          </button>
        </div>
      </div>
    </div>
  );
}

'use client';

import { useState, useEffect, useCallback } from 'react';
import { useCBSE10ScienceStore } from '@/stores/useCBSE10ScienceStore';
import { renderMixedContent } from '@/components/MathRenderer';
import { Flag, ChevronLeft, ChevronRight, CheckSquare, AlignJustify, X } from 'lucide-react';

const ACCENT = '#1e40af';

function formatTime(ms: number) {
  const totalSeconds = Math.max(0, Math.ceil(ms / 1000));
  const min = Math.floor(totalSeconds / 60);
  const sec = totalSeconds % 60;
  return `${min}:${sec.toString().padStart(2, '0')}`;
}

export default function TestView() {
  const {
    testQuestions,
    testAnswers,
    testFlags,
    testIndex,
    testStartTime,
    testTimeLimitMs,
    setTestAnswer,
    toggleTestFlag,
    navigateTest,
    finishTest,
  } = useCBSE10ScienceStore();

  const [timeLeft, setTimeLeft] = useState(testTimeLimitMs);
  const [showReview, setShowReview] = useState(false);
  const [showSubmitConfirm, setShowSubmitConfirm] = useState(false);

  const currentQ = testQuestions[testIndex];
  const total = testQuestions.length;

  const handleFinish = useCallback(() => {
    finishTest();
  }, [finishTest]);

  useEffect(() => {
    if (!testStartTime || !testTimeLimitMs) return;
    const tick = () => {
      const elapsed = Date.now() - testStartTime;
      const remaining = Math.max(0, testTimeLimitMs - elapsed);
      setTimeLeft(remaining);
      if (remaining === 0) handleFinish();
    };
    tick();
    const id = setInterval(tick, 1000);
    return () => clearInterval(id);
  }, [testStartTime, testTimeLimitMs, handleFinish]);

  const timerUrgent = timeLeft < 60_000;
  const timerWarn = !timerUrgent && timeLeft < 5 * 60_000;

  const answeredCount = Object.keys(testAnswers).filter((id) =>
    testQuestions.some((q) => q.id === id) && testAnswers[id]?.trim() !== ''
  ).length;
  const unanswered = total - answeredCount;

  if (!currentQ) return null;

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex flex-col">
      {/* Header */}
      <div className="sticky top-0 z-20 bg-[#1e3a8a] text-white px-4 py-3 shadow-md">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-3">
            <span className="text-sm font-semibold opacity-80">CBSE 10 Science Test</span>
            <span className="text-sm opacity-60">·</span>
            <span className="text-sm">
              Q {testIndex + 1} / {total}
            </span>
          </div>
          <div className="flex items-center gap-3">
            <span
              className={`font-mono text-lg font-bold px-3 py-1 rounded-lg ${
                timerUrgent ? 'bg-red-500' : timerWarn ? 'bg-amber-500' : 'bg-white/20'
              }`}
            >
              {formatTime(timeLeft)}
            </span>
            <button
              onClick={() => setShowReview((v) => !v)}
              className="p-2 rounded-lg bg-white/10 hover:bg-white/20 transition-colors"
              title="Review panel"
            >
              <AlignJustify className="w-4 h-4" />
            </button>
          </div>
        </div>
        {/* Progress bar */}
        <div className="max-w-4xl mx-auto mt-2">
          <div className="w-full bg-white/20 rounded-full h-1">
            <div
              className="h-1 rounded-full bg-white transition-all"
              style={{ width: `${((testIndex + 1) / total) * 100}%` }}
            />
          </div>
        </div>
      </div>

      <div className="flex flex-1 max-w-4xl mx-auto w-full">
        {/* Main content */}
        <div className={`flex-1 p-4 md:p-6 transition-all ${showReview ? 'md:mr-64' : ''}`}>
          <div className="bg-white rounded-xl border border-gray-200 p-6 mb-4">
            {/* Question meta */}
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-2">
                {currentQ.domain && (
                  <span className="px-2.5 py-1 bg-blue-50 text-blue-700 text-xs font-medium rounded-full">
                    {currentQ.domain.replace(/-/g, ' ').replace(/\b\w/g, (c) => c.toUpperCase())}
                  </span>
                )}
                <span className={`px-2.5 py-1 text-xs font-medium rounded-full ${
                  currentQ.difficulty === 'easy' ? 'bg-green-50 text-green-700'
                  : currentQ.difficulty === 'medium' ? 'bg-amber-50 text-amber-700'
                  : 'bg-red-50 text-red-700'
                }`}>
                  {currentQ.difficulty.charAt(0).toUpperCase() + currentQ.difficulty.slice(1)}
                </span>
              </div>
              <button
                onClick={() => toggleTestFlag(currentQ.id)}
                className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
                  testFlags[currentQ.id]
                    ? 'bg-amber-100 text-amber-700'
                    : 'bg-gray-100 text-gray-500 hover:bg-gray-200'
                }`}
              >
                <Flag className="w-3.5 h-3.5" />
                {testFlags[currentQ.id] ? 'Flagged' : 'Flag'}
              </button>
            </div>

            {/* Question */}
            <div className="text-gray-900 leading-relaxed mb-6">
              {renderMixedContent(currentQ.prompt)}
            </div>
            {currentQ.imageUrl && (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={currentQ.imageUrl} alt="Question figure" className="max-w-full rounded-lg mb-6 border border-gray-200" />
            )}

            {/* Options */}
            {currentQ.type === 'mcq' && currentQ.options && (
              <div className="space-y-2">
                {currentQ.options.map((opt) => {
                  const selected = testAnswers[currentQ.id] === opt.id;
                  return (
                    <button
                      key={opt.id}
                      onClick={() => setTestAnswer(currentQ.id, opt.id)}
                      className={`w-full text-left px-4 py-3 rounded-xl border-2 transition-all text-sm ${
                        selected
                          ? 'border-[#1e40af] bg-blue-50 text-blue-900 font-medium'
                          : 'border-gray-200 text-gray-700 hover:border-gray-300 hover:bg-gray-50'
                      }`}
                    >
                      <span className={`font-bold mr-2 ${selected ? 'text-[#1e40af]' : 'text-gray-400'}`}>
                        {opt.id})
                      </span>
                      {renderMixedContent(opt.text)}
                    </button>
                  );
                })}
              </div>
            )}

            {/* SPR input */}
            {currentQ.type === 'spr' && (
              <input
                type="text"
                value={testAnswers[currentQ.id] ?? ''}
                onChange={(e) => setTestAnswer(currentQ.id, e.target.value)}
                placeholder="Type your answer..."
                className="w-full px-4 py-3 border-2 border-gray-200 rounded-xl text-sm focus:border-[#1e40af] focus:outline-none"
              />
            )}
          </div>

          {/* Navigation */}
          <div className="flex items-center justify-between">
            <button
              onClick={() => navigateTest(testIndex - 1)}
              disabled={testIndex === 0}
              className="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium text-gray-600 border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40 transition-colors"
            >
              <ChevronLeft className="w-4 h-4" />
              Previous
            </button>

            {testIndex < total - 1 ? (
              <button
                onClick={() => navigateTest(testIndex + 1)}
                className="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium text-white rounded-lg hover:brightness-95 transition-colors"
                style={{ backgroundColor: ACCENT }}
              >
                Next
                <ChevronRight className="w-4 h-4" />
              </button>
            ) : (
              <button
                onClick={() => setShowSubmitConfirm(true)}
                className="inline-flex items-center gap-2 px-5 py-2 text-sm font-semibold text-white bg-green-600 rounded-lg hover:bg-green-700 transition-colors"
              >
                <CheckSquare className="w-4 h-4" />
                Submit Test
              </button>
            )}
          </div>
        </div>

        {/* Review Panel */}
        {showReview && (
          <div className="hidden md:flex flex-col w-64 fixed right-0 top-[72px] bottom-0 bg-white border-l border-gray-200 overflow-y-auto">
            <div className="p-4 border-b border-gray-100 flex items-center justify-between">
              <span className="text-sm font-semibold text-gray-700">Question Review</span>
              <button onClick={() => setShowReview(false)} className="text-gray-400 hover:text-gray-600">
                <X className="w-4 h-4" />
              </button>
            </div>
            <div className="p-3 grid grid-cols-5 gap-1.5">
              {testQuestions.map((q, idx) => {
                const answered = !!testAnswers[q.id]?.trim();
                const flagged = !!testFlags[q.id];
                const isCurrent = idx === testIndex;
                return (
                  <button
                    key={q.id}
                    onClick={() => navigateTest(idx)}
                    className={`w-full aspect-square rounded-lg text-xs font-semibold flex items-center justify-center transition-all ${
                      isCurrent ? 'ring-2 ring-[#1e40af] ring-offset-1' : ''
                    } ${
                      flagged ? 'bg-amber-100 text-amber-700'
                      : answered ? 'bg-blue-600 text-white'
                      : 'bg-gray-100 text-gray-500'
                    }`}
                  >
                    {idx + 1}
                  </button>
                );
              })}
            </div>
            <div className="p-3 border-t border-gray-100 space-y-1.5 text-xs text-gray-500">
              <div className="flex items-center gap-2">
                <span className="w-4 h-4 rounded bg-blue-600 inline-block" />
                Answered ({answeredCount})
              </div>
              <div className="flex items-center gap-2">
                <span className="w-4 h-4 rounded bg-amber-100 inline-block" />
                Flagged ({Object.values(testFlags).filter(Boolean).length})
              </div>
              <div className="flex items-center gap-2">
                <span className="w-4 h-4 rounded bg-gray-100 inline-block" />
                Unanswered ({unanswered})
              </div>
            </div>
            <div className="p-3">
              <button
                onClick={() => setShowSubmitConfirm(true)}
                className="w-full py-2.5 text-sm font-semibold text-white bg-green-600 rounded-lg hover:bg-green-700 transition-colors"
              >
                Submit Test
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Submit confirmation modal */}
      {showSubmitConfirm && (
        <div className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl p-6 max-w-sm w-full shadow-xl">
            <h3 className="text-lg font-bold text-gray-900 mb-2">Submit Test?</h3>
            <p className="text-sm text-gray-600 mb-1">
              You&apos;ve answered <strong>{answeredCount}</strong> of <strong>{total}</strong> questions.
            </p>
            {unanswered > 0 && (
              <p className="text-sm text-amber-600 mb-4">
                {unanswered} question{unanswered > 1 ? 's' : ''} left unanswered.
              </p>
            )}
            <div className="flex gap-3 mt-4">
              <button
                onClick={() => setShowSubmitConfirm(false)}
                className="flex-1 py-2.5 text-sm font-medium text-gray-600 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
              >
                Continue Test
              </button>
              <button
                onClick={handleFinish}
                className="flex-1 py-2.5 text-sm font-semibold text-white bg-green-600 rounded-lg hover:bg-green-700 transition-colors"
              >
                Submit
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

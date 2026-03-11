'use client';

import { useEffect, useState } from 'react';
import { useAshokaTestStore } from '@/stores/useAshokaTestStore';
import { Clock, AlertCircle, EyeOff } from 'lucide-react';

export default function EssayView() {
  const {
    essayPrompts,
    selectedPromptIndex,
    essayText,
    essayTimeLeft,
    timerHidden,
    setEssayText,
    tickEssayTimer,
    submitEssay,
    toggleTimerVisibility,
  } = useAshokaTestStore();

  const [showSubmitConfirm, setShowSubmitConfirm] = useState(false);

  useEffect(() => {
    const interval = setInterval(tickEssayTimer, 1000);
    return () => clearInterval(interval);
  }, [tickEssayTimer]);

  const mins = Math.floor(essayTimeLeft / 60);
  const secs = essayTimeLeft % 60;
  const timeStr = `${mins}:${secs.toString().padStart(2, '0')}`;
  const isTimeLow = essayTimeLeft < 300;
  const isTimeCritical = essayTimeLeft < 60;

  const wordCount = essayText.trim() ? essayText.trim().split(/\s+/).length : 0;
  const prompt = selectedPromptIndex !== null ? essayPrompts[selectedPromptIndex] : '';

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      {/* Top Toolbar */}
      <header className="bg-[#1a365d] text-white px-4 py-2.5 flex items-center justify-between sticky top-0 z-30 shadow-md">
        <div className="flex items-center gap-4">
          <div className="text-sm font-medium">
            <span className="font-bold">Ashoka Aptitude Test</span>
          </div>
          <div className="h-5 w-px bg-white/30" />
          <span className="text-xs opacity-70">Essay Phase</span>
        </div>

        <div className="flex items-center gap-3">
          <button
            onClick={toggleTimerVisibility}
            className="flex items-center gap-1.5 text-sm"
          >
            {timerHidden ? (
              <>
                <EyeOff className="w-4 h-4 opacity-60" />
                <span className="opacity-60">Show Time</span>
              </>
            ) : (
              <span
                className={`font-mono font-bold ${
                  isTimeCritical
                    ? 'text-red-300 animate-pulse'
                    : isTimeLow
                    ? 'text-yellow-300'
                    : ''
                }`}
              >
                <Clock className="w-4 h-4 inline mr-1" />
                {timeStr}
              </span>
            )}
            {isTimeLow && !timerHidden && (
              <AlertCircle className="w-4 h-4 text-yellow-300" />
            )}
          </button>
        </div>
      </header>

      {/* Essay Area */}
      <main className="flex-1 p-6 max-w-4xl mx-auto w-full flex flex-col">
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
          <p className="text-sm font-medium text-blue-800 mb-1">Essay Prompt</p>
          <p className="text-gray-800">{prompt}</p>
        </div>

        <div className="flex-1 flex flex-col">
          <textarea
            value={essayText}
            onChange={(e) => setEssayText(e.target.value)}
            placeholder="Start writing your essay here..."
            className="flex-1 w-full min-h-[400px] p-4 border-2 border-gray-200 rounded-lg text-base leading-relaxed focus:border-[#1a365d] focus:outline-none resize-none"
          />
          <div className="flex items-center justify-between mt-2 text-sm text-gray-500">
            <span>{wordCount} words</span>
          </div>
        </div>
      </main>

      {/* Bottom Bar */}
      <footer className="sticky bottom-0 bg-white border-t border-gray-300 px-4 py-3 z-20">
        <div className="max-w-4xl mx-auto flex items-center justify-end">
          <button
            onClick={() => setShowSubmitConfirm(true)}
            className="px-6 py-2 text-sm font-semibold text-white bg-[#1a365d] rounded-lg hover:bg-[#2a4a7f] transition-colors"
          >
            Submit Essay
          </button>
        </div>
      </footer>

      {/* Submit confirmation */}
      {showSubmitConfirm && (
        <div className="fixed inset-0 z-50 bg-black/50 flex items-center justify-center p-4">
          <div className="bg-white rounded-xl shadow-2xl max-w-sm w-full p-6">
            <h3 className="text-lg font-bold text-gray-900 mb-2">
              Submit Essay?
            </h3>
            <p className="text-sm text-gray-600 mb-2">
              You have written <strong>{wordCount}</strong> words.
            </p>
            {wordCount === 0 && (
              <p className="text-sm text-amber-600 mb-4">
                Your essay is empty. Are you sure you want to submit?
              </p>
            )}
            <div className="flex gap-3 justify-end mt-4">
              <button
                onClick={() => setShowSubmitConfirm(false)}
                className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50"
              >
                Go Back
              </button>
              <button
                onClick={() => {
                  setShowSubmitConfirm(false);
                  submitEssay();
                }}
                className="px-5 py-2 text-sm font-semibold text-white bg-[#1a365d] rounded-lg hover:bg-[#2a4a7f]"
              >
                Confirm Submit
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

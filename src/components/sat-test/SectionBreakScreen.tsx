'use client';

import { useEffect, useState } from 'react';
import { useSATTestStore } from '@/stores/useSATTestStore';
import { Coffee, ArrowRight, CheckCircle, Loader2 } from 'lucide-react';

const BREAK_DURATION = 600; // 10 minutes in seconds

export default function SectionBreakScreen() {
  const { beginMathSection } = useSATTestStore();
  const [secondsLeft, setSecondsLeft] = useState(BREAK_DURATION);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (secondsLeft <= 0) return;
    const id = setInterval(() => setSecondsLeft((s) => s - 1), 1000);
    return () => clearInterval(id);
  }, [secondsLeft]);

  const minutes = Math.floor(Math.max(0, secondsLeft) / 60);
  const seconds = Math.max(0, secondsLeft) % 60;

  const handleContinue = async () => {
    setLoading(true);
    try {
      await beginMathSection();
    } catch {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-lg max-w-lg w-full p-8 text-center">
        <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <CheckCircle className="w-8 h-8 text-green-600" />
        </div>

        <h1 className="text-2xl font-bold text-gray-900 mb-2">
          Reading & Writing Section Complete
        </h1>

        <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 mb-6">
          <div className="flex items-center justify-center gap-2 mb-2">
            <Coffee className="w-5 h-5 text-amber-600" />
            <span className="font-semibold text-amber-800">Break Time</span>
          </div>
          <p className="text-3xl font-mono font-bold text-amber-700">
            {String(minutes).padStart(2, '0')}:{String(seconds).padStart(2, '0')}
          </p>
          <p className="text-xs text-amber-600 mt-1">
            Take a break before the Math section. You can continue early if ready.
          </p>
        </div>

        <p className="text-sm text-gray-500 mb-4">
          Next: <span className="font-semibold">Math Section</span> — 22 questions per module, 35 minutes each
        </p>

        <button
          onClick={handleContinue}
          disabled={loading}
          className="inline-flex items-center gap-2 px-8 py-3 bg-[#0d47a1] text-white rounded-lg font-semibold hover:bg-[#0b3d91] transition-colors disabled:opacity-50"
        >
          {loading ? (
            <>
              <Loader2 className="w-5 h-5 animate-spin" />
              Loading Math Section…
            </>
          ) : (
            <>
              Continue to Math
              <ArrowRight className="w-5 h-5" />
            </>
          )}
        </button>
      </div>
    </div>
  );
}

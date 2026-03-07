'use client';

import { useGRETestStore } from '@/stores/useGRETestStore';
import { Calculator, ClipboardList, BookOpen } from 'lucide-react';

export default function LandingScreen() {
  const startTestMode = useGRETestStore((s) => s.startTestMode);

  const goToPracticeConfig = () => {
    useGRETestStore.setState({ phase: 'practice-config', mode: 'practice' });
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="w-full max-w-3xl">
        {/* Header */}
        <div className="text-center mb-8">
          <div className="inline-flex items-center gap-2 mb-4">
            <div className="w-10 h-10 bg-[#1a365d] rounded-lg flex items-center justify-center">
              <Calculator className="w-5 h-5 text-white" />
            </div>
            <span className="text-2xl font-bold text-[#1a365d] tracking-tight">
              GRE Quantitative
            </span>
          </div>
          <p className="text-gray-600">
            Adaptive practice that mirrors the real GRE experience
          </p>
        </div>

        {/* Mode Cards */}
        <div className="grid md:grid-cols-2 gap-6">
          {/* Test Mode */}
          <button
            onClick={startTestMode}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:border-[#1a365d] hover:shadow-lg transition-all"
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg bg-[#1a365d] flex items-center justify-center group-hover:scale-105 transition-transform">
                <ClipboardList className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Test Mode</h2>
                <p className="text-sm text-gray-500">Timed &amp; Adaptive</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="text-[#1a365d] font-bold mt-0.5">1</span>
                <span>Section 1 — 12 questions, 21 minutes (Medium)</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#1a365d] font-bold mt-0.5">2</span>
                <span>Section 2 — 15 questions, 26 minutes (Adaptive)</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#1a365d] font-bold mt-0.5">→</span>
                <span>Section 2 difficulty adapts based on your Section 1 score</span>
              </li>
            </ul>
            <div className="text-sm font-semibold text-[#1a365d] group-hover:underline">
              Start Full Test →
            </div>
          </button>

          {/* Practice Mode */}
          <button
            onClick={goToPracticeConfig}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:border-emerald-600 hover:shadow-lg transition-all"
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg bg-emerald-600 flex items-center justify-center group-hover:scale-105 transition-transform">
                <BookOpen className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Practice Mode</h2>
                <p className="text-sm text-gray-500">Untimed &amp; Guided</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="text-emerald-600 font-bold mt-0.5">✓</span>
                <span>Choose your difficulty level</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-emerald-600 font-bold mt-0.5">✓</span>
                <span>Instant feedback after each question</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-emerald-600 font-bold mt-0.5">✓</span>
                <span>Detailed explanations included</span>
              </li>
            </ul>
            <div className="text-sm font-semibold text-emerald-600 group-hover:underline">
              Configure Practice →
            </div>
          </button>
        </div>

        {/* Footer info */}
        <p className="text-center text-xs text-gray-400 mt-8">
          Question types: Multiple Choice · Multiple Select · Numeric Entry · Quantitative Comparison
        </p>
      </div>
    </div>
  );
}

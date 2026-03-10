'use client';

import { useState } from 'react';
import { useSATTestStore } from '@/stores/useSATTestStore';
import { ClipboardList, BookOpen, Calculator } from 'lucide-react';
import AccessCodeModal from './AccessCodeModal';

export default function LandingScreen() {
  const startTestMode = useSATTestStore((s) => s.startTestMode);
  const [showCodeModal, setShowCodeModal] = useState(false);

  const goToPracticeConfig = () => {
    useSATTestStore.setState({ phase: 'practice-config', mode: 'practice' });
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      {showCodeModal && (
        <AccessCodeModal
          onSuccess={async (setNumber: number) => {
            setShowCodeModal(false);
            await startTestMode(setNumber);
          }}
          onClose={() => setShowCodeModal(false)}
        />
      )}
      <div className="w-full max-w-3xl">
        {/* Header */}
        <div className="text-center mb-8">
          <div className="inline-flex items-center gap-2 mb-4">
            <div className="w-10 h-10 bg-[#0d47a1] rounded-lg flex items-center justify-center">
              <Calculator className="w-5 h-5 text-white" />
            </div>
            <span className="text-2xl font-bold text-[#0d47a1] tracking-tight">
              Digital SAT Math
            </span>
          </div>
          <p className="text-gray-600">
            Multi-stage adaptive test that mirrors the real Digital SAT experience
          </p>
        </div>

        {/* Mode Cards */}
        <div className="grid md:grid-cols-2 gap-6">
          {/* Test Mode */}
          <button
            onClick={() => setShowCodeModal(true)}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:border-[#0d47a1] hover:shadow-lg transition-all"
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg bg-[#0d47a1] flex items-center justify-center group-hover:scale-105 transition-transform">
                <ClipboardList className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Test Mode</h2>
                <p className="text-sm text-gray-500">Timed &amp; Adaptive</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="text-[#0d47a1] font-bold mt-0.5">1</span>
                <span>Module 1 — 22 questions, 35 minutes (Mixed)</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#0d47a1] font-bold mt-0.5">2</span>
                <span>Module 2 — 22 questions, 35 minutes (Adaptive)</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#0d47a1] font-bold mt-0.5">→</span>
                <span>Module 2 difficulty adapts based on Module 1 performance</span>
              </li>
            </ul>
            <div className="text-sm font-semibold text-[#0d47a1] group-hover:underline">
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
                <span>Desmos graphing calculator included</span>
              </li>
            </ul>
            <div className="text-sm font-semibold text-emerald-600 group-hover:underline">
              Configure Practice →
            </div>
          </button>
        </div>

        {/* Footer info */}
        <p className="text-center text-xs text-gray-400 mt-8">
          Question types: Multiple Choice (MCQ) · Student-Produced Response (SPR)
          <br />
          Domains: Algebra · Advanced Math · Problem Solving &amp; Data Analysis · Geometry &amp; Trigonometry
        </p>
      </div>
    </div>
  );
}

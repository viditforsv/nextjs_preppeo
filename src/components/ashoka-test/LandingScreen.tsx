'use client';

import { useState } from 'react';
import { useAshokaTestStore } from '@/stores/useAshokaTestStore';
import { GraduationCap, ClipboardList } from 'lucide-react';
import AccessCodeModal from './AccessCodeModal';

export default function LandingScreen() {
  const startTest = useAshokaTestStore((s) => s.startTest);
  const [showCodeModal, setShowCodeModal] = useState(false);

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      {showCodeModal && (
        <AccessCodeModal
          onSuccess={async (setNumber: number) => {
            setShowCodeModal(false);
            await startTest(setNumber);
          }}
          onClose={() => setShowCodeModal(false)}
        />
      )}
      <div className="w-full max-w-2xl">
        <div className="text-center mb-8">
          <div className="inline-flex items-center gap-2 mb-4">
            <div className="w-10 h-10 bg-[#1a365d] rounded-lg flex items-center justify-center">
              <GraduationCap className="w-5 h-5 text-white" />
            </div>
            <span className="text-2xl font-bold text-[#1a365d] tracking-tight">
              Ashoka Aptitude Test
            </span>
          </div>
          <p className="text-gray-600">
            A timed mock test that mirrors the real AAT experience
          </p>
        </div>

        <button
          onClick={() => setShowCodeModal(true)}
          className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:border-[#1a365d] hover:shadow-lg transition-all w-full"
        >
          <div className="flex items-center gap-3 mb-4">
            <div className="w-12 h-12 rounded-lg bg-[#1a365d] flex items-center justify-center group-hover:scale-105 transition-transform">
              <ClipboardList className="w-6 h-6 text-white" />
            </div>
            <div>
              <h2 className="text-xl font-bold text-gray-900">Test Mode</h2>
              <p className="text-sm text-gray-500">Timed · 40 MCQs + Essay</p>
            </div>
          </div>
          <ul className="space-y-2 text-sm text-gray-600 mb-4">
            <li className="flex items-start gap-2">
              <span className="text-[#1a365d] font-bold mt-0.5">1</span>
              <span>MCQ Phase — 40 questions, 90 minutes</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="text-[#1a365d] font-bold mt-0.5">2</span>
              <span>Essay Phase — 1 essay prompt, 30 minutes</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="text-[#1a365d] font-bold mt-0.5">→</span>
              <span>Problem Solving + Critical Thinking questions, jumbled order</span>
            </li>
            <li className="flex items-start gap-2">
              <span className="text-[#1a365d] font-bold mt-0.5">→</span>
              <span>No negative marking · No calculator</span>
            </li>
          </ul>
          <div className="text-sm font-semibold text-[#1a365d] group-hover:underline">
            Start Full Test →
          </div>
        </button>

        <p className="text-center text-xs text-gray-400 mt-8">
          All questions are single-choice MCQs · Problem Solving &amp; Critical Thinking
        </p>
      </div>
    </div>
  );
}

'use client';

import { useCBSE10ScienceStore } from '@/stores/useCBSE10ScienceStore';
import { BookOpen, Layers, FlaskConical, ArrowLeft } from 'lucide-react';

const ACCENT = '#059669';

export default function StudyModeSelect() {
  const { goToLanding, goToPracticeConfig, goToFlashcardConfig } = useCBSE10ScienceStore();

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="w-full max-w-3xl">
        <div className="flex items-center justify-between mb-8">
          <div className="inline-flex items-center gap-2">
            <div className="w-10 h-10 rounded-lg flex items-center justify-center" style={{ backgroundColor: ACCENT }}>
              <FlaskConical className="w-5 h-5 text-white" />
            </div>
            <div>
              <span className="text-xl font-bold" style={{ color: '#047857' }}>Study Mode</span>
              <p className="text-xs text-gray-500">CBSE 10 Science</p>
            </div>
          </div>
          <button
            onClick={goToLanding}
            className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm text-gray-600 hover:text-gray-900 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
          >
            <ArrowLeft className="w-3.5 h-3.5" />
            Back
          </button>
        </div>

        <p className="text-center text-gray-500 mb-6 text-sm">Choose how you want to study</p>

        <div className="grid md:grid-cols-2 gap-6">
          {/* Practice Mode */}
          <button
            onClick={goToPracticeConfig}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:shadow-lg transition-all"
            onMouseEnter={(e) => (e.currentTarget.style.borderColor = ACCENT)}
            onMouseLeave={(e) => (e.currentTarget.style.borderColor = '')}
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg flex items-center justify-center group-hover:scale-105 transition-transform" style={{ backgroundColor: ACCENT }}>
                <BookOpen className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Practice</h2>
                <p className="text-sm text-gray-500">Untimed &amp; Guided</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>Answer at your own pace</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>Instant AI-powered explanations</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>Deep-dive theory for each concept</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>Filter by chapter, topic &amp; difficulty</span>
              </li>
            </ul>
            <div className="text-sm font-semibold group-hover:underline" style={{ color: '#047857' }}>
              Configure Practice →
            </div>
          </button>

          {/* Flashcard Study */}
          <button
            onClick={goToFlashcardConfig}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:border-violet-500 hover:shadow-lg transition-all"
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg bg-violet-600 flex items-center justify-center group-hover:scale-105 transition-transform">
                <Layers className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Flashcards</h2>
                <p className="text-sm text-gray-500">Memorize &amp; Retain</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="text-violet-600 font-bold mt-0.5">✓</span>
                <span>Flip cards to test your recall</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-violet-600 font-bold mt-0.5">✓</span>
                <span>Mark cards as known or review again</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-violet-600 font-bold mt-0.5">✓</span>
                <span>See answer &amp; explanation on flip</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-violet-600 font-bold mt-0.5">✓</span>
                <span>Great for quick revision before exams</span>
              </li>
            </ul>
            <div className="text-sm font-semibold text-violet-600 group-hover:underline">
              Start Flashcards →
            </div>
          </button>
        </div>
      </div>
    </div>
  );
}

'use client';

import { useGRETestStore } from '@/stores/useGRETestStore';
import { Clock, FileText, BarChart3 } from 'lucide-react';

export default function SectionIntroScreen() {
  const { currentSectionNumber, section1, section2, section2Tier, beginSection } =
    useGRETestStore();

  const section = currentSectionNumber === 1 ? section1 : section2;
  if (!section) return null;

  const minutes = Math.floor(section.durationSeconds / 60);
  const qCount = section.questions.length;

  const tierLabel =
    section.difficultyTier === 'easy'
      ? 'Easy'
      : section.difficultyTier === 'medium'
      ? 'Medium'
      : 'Hard';

  const tierColor =
    section.difficultyTier === 'easy'
      ? 'text-green-600 bg-green-100'
      : section.difficultyTier === 'medium'
      ? 'text-yellow-700 bg-yellow-100'
      : 'text-red-600 bg-red-100';

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-lg max-w-lg w-full p-8">
        <div className="text-center mb-6">
          <h1 className="text-2xl font-bold text-[#1a365d]">
            Section {currentSectionNumber} of 2
          </h1>
          <p className="text-gray-500 mt-1">Quantitative Reasoning</p>
        </div>

        <div className="space-y-4 mb-8">
          <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
            <Clock className="w-5 h-5 text-[#1a365d]" />
            <div>
              <p className="text-sm font-medium text-gray-800">Time Allotted</p>
              <p className="text-lg font-bold text-[#1a365d]">{minutes} minutes</p>
            </div>
          </div>

          <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
            <FileText className="w-5 h-5 text-[#1a365d]" />
            <div>
              <p className="text-sm font-medium text-gray-800">Questions</p>
              <p className="text-lg font-bold text-[#1a365d]">{qCount}</p>
            </div>
          </div>

          <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
            <BarChart3 className="w-5 h-5 text-[#1a365d]" />
            <div>
              <p className="text-sm font-medium text-gray-800">Difficulty</p>
              <span className={`inline-block text-sm font-semibold px-2.5 py-0.5 rounded-full ${tierColor}`}>
                {tierLabel}
              </span>
            </div>
          </div>
        </div>

        <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 mb-6 text-sm text-amber-800">
          <p className="font-medium mb-1">Instructions:</p>
          <ul className="list-disc ml-4 space-y-1">
            <li>You may use the on-screen calculator</li>
            <li>Flag questions for review and return to them</li>
            <li>The timer will auto-submit when time runs out</li>
            {currentSectionNumber === 1 && (
              <li>Your performance determines Section 2 difficulty</li>
            )}
          </ul>
        </div>

        <button
          onClick={beginSection}
          className="w-full py-3 bg-[#1a365d] text-white font-semibold rounded-lg hover:bg-[#2a4a7f] transition-colors text-lg"
        >
          Begin Section {currentSectionNumber}
        </button>
      </div>
    </div>
  );
}

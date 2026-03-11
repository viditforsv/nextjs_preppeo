'use client';

import { useAshokaTestStore } from '@/stores/useAshokaTestStore';
import { Clock, FileText } from 'lucide-react';

export default function SectionIntroScreen() {
  const { questions, beginTest } = useAshokaTestStore();

  if (!questions.length) return null;

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-lg max-w-lg w-full p-8">
        <div className="text-center mb-6">
          <h1 className="text-2xl font-bold text-[#1a365d]">
            Ashoka Aptitude Test
          </h1>
          <p className="text-gray-500 mt-1">MCQ Phase</p>
        </div>

        <div className="space-y-4 mb-8">
          <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
            <Clock className="w-5 h-5 text-[#1a365d]" />
            <div>
              <p className="text-sm font-medium text-gray-800">Time Allotted</p>
              <p className="text-lg font-bold text-[#1a365d]">90 minutes</p>
            </div>
          </div>

          <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
            <FileText className="w-5 h-5 text-[#1a365d]" />
            <div>
              <p className="text-sm font-medium text-gray-800">Questions</p>
              <p className="text-lg font-bold text-[#1a365d]">{questions.length}</p>
            </div>
          </div>
        </div>

        <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 mb-6 text-sm text-amber-800">
          <p className="font-medium mb-1">Instructions:</p>
          <ul className="list-disc ml-4 space-y-1">
            <li>All questions are single-choice MCQs</li>
            <li>Problem Solving and Critical Thinking questions are mixed</li>
            <li>No negative marking — attempt all questions</li>
            <li>No calculator allowed</li>
            <li>Flag questions for review and return to them</li>
            <li>The timer will auto-submit when time runs out</li>
            <li>An essay phase will follow after the MCQs</li>
          </ul>
        </div>

        <button
          onClick={beginTest}
          className="w-full py-3 bg-[#1a365d] text-white font-semibold rounded-lg hover:bg-[#2a4a7f] transition-colors text-lg"
        >
          Begin Test
        </button>
      </div>
    </div>
  );
}

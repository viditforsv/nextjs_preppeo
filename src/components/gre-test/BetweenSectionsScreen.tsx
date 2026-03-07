'use client';

import { useGRETestStore } from '@/stores/useGRETestStore';
import { CheckCircle, ArrowRight } from 'lucide-react';

export default function BetweenSectionsScreen() {
  const { section1Result, section2Tier, beginSection2 } = useGRETestStore();

  if (!section1Result || !section2Tier) return null;

  const tierLabel =
    section2Tier === 'easy' ? 'Easy' : section2Tier === 'medium' ? 'Medium' : 'Hard';
  const tierColor =
    section2Tier === 'easy'
      ? 'text-green-600'
      : section2Tier === 'medium'
      ? 'text-yellow-700'
      : 'text-red-600';

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-lg max-w-lg w-full p-8 text-center">
        <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <CheckCircle className="w-8 h-8 text-green-600" />
        </div>

        <h1 className="text-2xl font-bold text-gray-900 mb-2">
          Section 1 Complete
        </h1>
        <p className="text-gray-600 mb-6">
          You answered{' '}
          <span className="font-bold text-[#1a365d]">
            {section1Result.correct} of {section1Result.total}
          </span>{' '}
          questions correctly.
        </p>

        <div className="bg-gray-50 rounded-lg p-4 mb-6">
          <p className="text-sm text-gray-500 mb-1">Section 2 Difficulty</p>
          <p className={`text-2xl font-bold ${tierColor}`}>{tierLabel}</p>
          <p className="text-xs text-gray-400 mt-1">15 questions · 26 minutes</p>
        </div>

        <p className="text-sm text-gray-500 mb-6">
          When you are ready, click below to begin Section 2.
        </p>

        <button
          onClick={beginSection2}
          className="w-full py-3 bg-[#1a365d] text-white font-semibold rounded-lg hover:bg-[#2a4a7f] transition-colors text-lg inline-flex items-center justify-center gap-2"
        >
          Begin Section 2
          <ArrowRight className="w-5 h-5" />
        </button>
      </div>
    </div>
  );
}

'use client';

import { useSATTestStore } from '@/stores/useSATTestStore';
import { CheckCircle, ArrowRight, Loader2 } from 'lucide-react';

export default function BetweenModulesScreen() {
  const { module1Result, module2Tier, module2, beginModule2 } = useSATTestStore();

  if (!module1Result || !module2Tier) return null;

  const tierLabel = module2Tier === 'hard' ? 'Higher Difficulty' : 'Lower Difficulty';
  const tierColor = module2Tier === 'hard' ? 'text-red-600' : 'text-green-600';
  const isLoading = !module2;

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-lg max-w-lg w-full p-8 text-center">
        <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <CheckCircle className="w-8 h-8 text-green-600" />
        </div>

        <h1 className="text-2xl font-bold text-gray-900 mb-2">
          Module 1 Complete
        </h1>
        <p className="text-gray-600 mb-6">
          You answered{' '}
          <span className="font-bold text-[#0d47a1]">
            {module1Result.correct} of {module1Result.total}
          </span>{' '}
          questions correctly.
        </p>

        <div className="bg-gray-50 rounded-lg p-4 mb-6">
          <p className="text-sm text-gray-500 mb-1">Module 2 Difficulty</p>
          <p className={`text-2xl font-bold ${tierColor}`}>{tierLabel}</p>
          <p className="text-xs text-gray-400 mt-1">22 questions · 35 minutes</p>
        </div>

        <p className="text-sm text-gray-500 mb-6">
          When you are ready, click below to begin Module 2.
        </p>

        <button
          onClick={beginModule2}
          disabled={isLoading}
          className="w-full py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] disabled:opacity-60 transition-colors text-lg inline-flex items-center justify-center gap-2"
        >
          {isLoading ? (
            <>
              <Loader2 className="w-5 h-5 animate-spin" />
              Loading Module 2...
            </>
          ) : (
            <>
              Begin Module 2
              <ArrowRight className="w-5 h-5" />
            </>
          )}
        </button>
      </div>
    </div>
  );
}

'use client';

import { useSATTestStore } from '@/stores/useSATTestStore';
import { CheckCircle, ArrowRight, Loader2 } from 'lucide-react';

export default function BetweenModulesScreen() {
  const { module1Result, module2Tier, module2, currentSection, beginModule2, module2LoadError, retryModule2Fetch } = useSATTestStore();

  if (!module1Result || !module2Tier) return null;

  const sectionLabel = currentSection === 'rw' ? 'Reading & Writing' : 'Math';
  const isLoading = !module2 && !module2LoadError;
  const qCount = currentSection === 'rw' ? 27 : 22;
  const minutes = currentSection === 'rw' ? 32 : 35;

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-lg max-w-lg w-full p-8 text-center">
        <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <CheckCircle className="w-8 h-8 text-green-600" />
        </div>

        <h1 className="text-2xl font-bold text-gray-900 mb-2">
          {sectionLabel} Module 1 Complete
        </h1>
        <p className="text-gray-600 mb-6">
          You have completed Module 1. Module 2 will begin when you click below.
        </p>

        <div className="bg-gray-50 rounded-lg p-4 mb-6">
          <p className="text-sm text-gray-500 mb-1">{sectionLabel} Module 2</p>
          <p className="text-xs text-gray-400 mt-1">{qCount} questions · {minutes} minutes</p>
        </div>

        {module2LoadError ? (
          <div className="space-y-3">
            <p className="text-red-600 text-sm">{module2LoadError}</p>
            <button
              onClick={retryModule2Fetch}
              className="w-full py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] transition-colors text-lg"
            >
              Try Again
            </button>
          </div>
        ) : (
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
                Begin {sectionLabel} Module 2
                <ArrowRight className="w-5 h-5" />
              </>
            )}
          </button>
        )}
      </div>
    </div>
  );
}

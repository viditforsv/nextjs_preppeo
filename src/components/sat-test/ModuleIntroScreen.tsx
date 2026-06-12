'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { useSATTestStore } from '@/stores/useSATTestStore';
import { Clock, FileText, LogOut } from 'lucide-react';

export default function ModuleIntroScreen() {
  const { currentModuleNumber, currentSection, module1, module2, beginModule, goToLanding } =
    useSATTestStore();
  const router = useRouter();
  const [showExitConfirm, setShowExitConfirm] = useState(false);

  const mod = currentModuleNumber === 1 ? module1 : module2;
  if (!mod) return null;

  const minutes = Math.floor(mod.durationSeconds / 60);
  const qCount = mod.questions.length;
  const sectionLabel = currentSection === 'rw' ? 'Reading & Writing' : 'Math';

  const handleExit = () => {
    goToLanding();
    router.push('/');
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex flex-col">
      <header className="bg-[#0d47a1] text-white px-4 py-2.5 flex items-center shadow-md">
        <button
          onClick={() => setShowExitConfirm(true)}
          className="inline-flex items-center gap-1.5 text-sm opacity-80 hover:opacity-100 transition-opacity"
        >
          <LogOut className="w-4 h-4" />
          <span>Exit</span>
        </button>
      </header>

      <div className="flex-1 flex items-center justify-center p-4">
      <div className="bg-white rounded-xl shadow-lg max-w-lg w-full p-8">
        <div className="text-center mb-6">
          <h1 className="text-2xl font-bold text-[#0d47a1]">
            {sectionLabel} — Module {currentModuleNumber} of 2
          </h1>
          <p className="text-gray-500 mt-1">SAT {sectionLabel} Section</p>
        </div>

        <div className="space-y-4 mb-8">
          <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
            <Clock className="w-5 h-5 text-[#0d47a1]" />
            <div>
              <p className="text-sm font-medium text-gray-800">Time Allotted</p>
              <p className="text-lg font-bold text-[#0d47a1]">{minutes} minutes</p>
            </div>
          </div>

          <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
            <FileText className="w-5 h-5 text-[#0d47a1]" />
            <div>
              <p className="text-sm font-medium text-gray-800">Questions</p>
              <p className="text-lg font-bold text-[#0d47a1]">{qCount}</p>
            </div>
          </div>
        </div>

        <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 mb-6 text-sm text-amber-800">
          <p className="font-medium mb-1">Instructions:</p>
          <ul className="list-disc ml-4 space-y-1">
            {currentSection === 'math' && (
              <li>Desmos graphing calculator is available throughout</li>
            )}
            {currentSection === 'rw' && (
              <li>Read the passage carefully before answering each question</li>
            )}
            <li>No penalty for wrong answers — answer every question</li>
            <li>Flag questions for review and return to them</li>
            <li>The timer will auto-submit when time runs out</li>
          </ul>
        </div>

        <button
          onClick={beginModule}
          className="w-full py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] transition-colors text-lg"
        >
          Begin {sectionLabel} Module {currentModuleNumber}
        </button>
      </div>
      </div>

      {/* Exit confirmation */}
      {showExitConfirm && (
        <div className="fixed inset-0 z-50 bg-black/50 flex items-center justify-center p-4">
          <div className="bg-white rounded-xl shadow-2xl max-w-sm w-full p-6">
            <h3 className="text-lg font-bold text-gray-900 mb-2">Exit test mode?</h3>
            <p className="text-sm text-gray-600 mb-1">
              Your progress on this mock won&apos;t be saved and the attempt
              won&apos;t be recorded.
            </p>
            <p className="text-sm text-amber-600 mb-4">
              You&apos;ll return to the homepage.
            </p>
            <div className="flex gap-3 justify-end mt-4">
              <button
                onClick={() => setShowExitConfirm(false)}
                className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50"
              >
                Keep Testing
              </button>
              <button
                onClick={handleExit}
                className="px-5 py-2 text-sm font-semibold text-white bg-red-600 rounded-lg hover:bg-red-700"
              >
                Exit Test
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

'use client';

import { useRouter } from 'next/navigation';
import { useCBSE10ScienceStore } from '@/stores/useCBSE10ScienceStore';
import { useAuth } from '@/contexts/AuthContext';
import { BookOpen, ClipboardList, FlaskConical, BarChart3 } from 'lucide-react';
import Link from 'next/link';

const ACCENT = '#059669';

export default function LandingScreen() {
  const { goToStudyModeSelect, goToTestConfig, goToAnalytics } = useCBSE10ScienceStore();
  const { user, loading } = useAuth();
  const router = useRouter();

  const requireAuth = (callback: () => void) => {
    if (!user && !loading) {
      router.push('/auth?redirect=/cbse10-science');
      return;
    }
    callback();
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="w-full max-w-3xl">
        <div className="text-center mb-8">
          <div className="inline-flex items-center gap-2 mb-4">
            <div className="w-10 h-10 rounded-lg flex items-center justify-center" style={{ backgroundColor: ACCENT }}>
              <FlaskConical className="w-5 h-5 text-white" />
            </div>
            <span className="text-2xl font-bold tracking-tight" style={{ color: '#047857' }}>
              CBSE 10 Science
            </span>
          </div>
          <p className="text-gray-600">
            13 chapters · Test mode, practice, and flashcard study
          </p>
        </div>

        <div className="grid md:grid-cols-2 gap-6">
          {/* Test Mode Card */}
          <button
            onClick={() => requireAuth(goToTestConfig)}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:border-[#1e40af] hover:shadow-lg transition-all"
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg bg-[#1e40af] flex items-center justify-center group-hover:scale-105 transition-transform">
                <ClipboardList className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Test Mode</h2>
                <p className="text-sm text-gray-500">Timed &amp; Scored</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="text-[#1e40af] font-bold mt-0.5">1</span>
                <span>Choose chapters, difficulty &amp; question count</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#1e40af] font-bold mt-0.5">2</span>
                <span>Timed exam — answer without hints</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#1e40af] font-bold mt-0.5">3</span>
                <span>Score report with chapter &amp; difficulty breakdown</span>
              </li>
            </ul>
            <div className="text-sm font-semibold text-[#1e40af] group-hover:underline">
              Start Test →
            </div>
          </button>

          {/* Study Mode Card */}
          <button
            onClick={() => requireAuth(goToStudyModeSelect)}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:shadow-lg transition-all"
            onMouseEnter={(e) => (e.currentTarget.style.borderColor = ACCENT)}
            onMouseLeave={(e) => (e.currentTarget.style.borderColor = '')}
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg flex items-center justify-center group-hover:scale-105 transition-transform" style={{ backgroundColor: ACCENT }}>
                <BookOpen className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Study Mode</h2>
                <p className="text-sm text-gray-500">Practice &amp; Flashcards</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>Untimed practice with AI explanations &amp; theory</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>Flashcard study — flip cards, memorize concepts</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>Filter by chapter, topic, and difficulty</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>5 free questions daily · Upgrade for unlimited</span>
              </li>
            </ul>
            <div className="text-sm font-semibold group-hover:underline" style={{ color: '#047857' }}>
              Start Studying →
            </div>
          </button>
        </div>

        {user && (
          <div className="text-center mt-6">
            <button
              onClick={goToAnalytics}
              className="inline-flex items-center gap-2 text-sm font-medium text-gray-600 hover:text-gray-900 hover:underline transition-colors"
            >
              <BarChart3 className="w-4 h-4" />
              View My Analytics
            </button>
          </div>
        )}

        <div className="text-center text-xs text-gray-400 mt-8 space-y-1">
          <p>
            <span className="font-medium text-gray-500">Chapters:</span> Chemical Reactions · Acids, Bases &amp; Salts · Metals &amp; Non-metals · Carbon Compounds · Life Processes · Control &amp; Coordination · Reproduction · Heredity · Light · Human Eye · Electricity · Magnetic Effects · Environment
          </p>
          <p className="mt-2">
            <Link href="/" className="text-gray-500 hover:text-gray-700 transition-colors hover:underline">
              ← Back to Home
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}

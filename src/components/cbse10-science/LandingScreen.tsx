'use client';

import { useRouter } from 'next/navigation';
import { useCBSE10ScienceStore } from '@/stores/useCBSE10ScienceStore';
import { useAuth } from '@/contexts/AuthContext';
import { BookOpen, BarChart3, FlaskConical } from 'lucide-react';
import Link from 'next/link';

const ACCENT = '#059669';

export default function LandingScreen() {
  const { goToPracticeConfig, goToAnalytics } = useCBSE10ScienceStore();
  const { user, loading } = useAuth();
  const router = useRouter();

  const handlePractice = () => {
    if (!user && !loading) {
      router.push('/auth?redirect=/cbse10-science');
      return;
    }
    goToPracticeConfig();
  };

  const handleAnalytics = () => {
    if (!user && !loading) {
      router.push('/auth?redirect=/cbse10-science');
      return;
    }
    goToAnalytics();
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
            Practice mode with AI-powered explanations — 13 chapters, all difficulty levels
          </p>
        </div>

        <div className="grid md:grid-cols-2 gap-6">
          <button
            onClick={handlePractice}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:shadow-lg transition-all"
            onMouseEnter={(e) => (e.currentTarget.style.borderColor = ACCENT)}
            onMouseLeave={(e) => (e.currentTarget.style.borderColor = '')}
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg flex items-center justify-center group-hover:scale-105 transition-transform" style={{ backgroundColor: ACCENT }}>
                <BookOpen className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Practice Mode</h2>
                <p className="text-sm text-gray-500">Untimed &amp; Guided</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>5 free questions daily with AI explanations</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>Practice by chapter, topic, and difficulty</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>Deep-dive theory for every question</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: '#047857' }}>✓</span>
                <span>Upgrade for unlimited access</span>
              </li>
            </ul>
            <div className="text-sm font-semibold group-hover:underline" style={{ color: '#047857' }}>
              Configure Practice →
            </div>
          </button>

          <button
            onClick={handleAnalytics}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:shadow-lg transition-all"
            onMouseEnter={(e) => (e.currentTarget.style.borderColor = ACCENT)}
            onMouseLeave={(e) => (e.currentTarget.style.borderColor = '')}
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg bg-gray-800 flex items-center justify-center group-hover:scale-105 transition-transform">
                <BarChart3 className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">My Analytics</h2>
                <p className="text-sm text-gray-500">Strengths &amp; Weaknesses</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5 text-gray-800">✓</span>
                <span>Chapter-wise accuracy breakdown</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5 text-gray-800">✓</span>
                <span>Strongest and weakest areas highlighted</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5 text-gray-800">✓</span>
                <span>Track improvement over time</span>
              </li>
            </ul>
            <div className="text-sm font-semibold text-gray-800 group-hover:underline">
              View Analytics →
            </div>
          </button>
        </div>

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

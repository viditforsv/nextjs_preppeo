'use client';

import { useRouter } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import { BookOpen, BarChart3, GraduationCap } from 'lucide-react';
import Link from 'next/link';
import type { IBDPMathsCourseConfig } from '@/types/ibdp-maths';
import type { IBDPMathsState } from '@/stores/useIBDPMathsStore';

interface Props {
  config: IBDPMathsCourseConfig;
  useStore: () => IBDPMathsState;
}

export default function LandingScreen({ config, useStore }: Props) {
  const { goToPracticeConfig, goToAnalytics } = useStore();
  const { user, loading } = useAuth();
  const router = useRouter();

  const requireAuth = (action: () => void) => {
    if (!user && !loading) {
      router.push(`/auth?redirect=${config.coursePath}`);
      return;
    }
    action();
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      <div className="w-full max-w-3xl">
        <div className="text-center mb-8">
          <div className="inline-flex items-center gap-2 mb-4">
            <div className="w-10 h-10 rounded-lg flex items-center justify-center" style={{ backgroundColor: config.accentColor }}>
              <GraduationCap className="w-5 h-5 text-white" />
            </div>
            <span className="text-2xl font-bold tracking-tight" style={{ color: config.accentColor }}>
              {config.title}
            </span>
          </div>
          <p className="text-gray-600">{config.subtitle}</p>
          <p className="text-sm text-gray-500 mt-1">Practice mode with AI-powered explanations — 5 core topics, all difficulty levels</p>
        </div>

        <div className="grid md:grid-cols-2 gap-6">
          <button
            onClick={() => requireAuth(goToPracticeConfig)}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:shadow-lg transition-all"
            onMouseEnter={(e) => (e.currentTarget.style.borderColor = config.accentColor)}
            onMouseLeave={(e) => (e.currentTarget.style.borderColor = '')}
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg flex items-center justify-center group-hover:scale-105 transition-transform" style={{ backgroundColor: config.accentColor }}>
                <BookOpen className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Practice Mode</h2>
                <p className="text-sm text-gray-500">Untimed &amp; Guided</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: config.accentText }}>✓</span>
                <span>5 free questions daily with AI explanations</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: config.accentText }}>✓</span>
                <span>Filter by topic and difficulty</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: config.accentText }}>✓</span>
                <span>Deep-dive theory for every question</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="font-bold mt-0.5" style={{ color: config.accentText }}>✓</span>
                <span>Upgrade for unlimited access</span>
              </li>
            </ul>
            <div className="text-sm font-semibold group-hover:underline" style={{ color: config.accentText }}>
              Configure Practice →
            </div>
          </button>

          <button
            onClick={() => requireAuth(goToAnalytics)}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:shadow-lg transition-all"
            onMouseEnter={(e) => (e.currentTarget.style.borderColor = config.accentColor)}
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
                <span>Topic-wise accuracy breakdown</span>
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
            <span className="font-medium text-gray-500">Topics:</span> Number &amp; Algebra · Functions · Geometry &amp; Trigonometry · Statistics &amp; Probability · Calculus
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

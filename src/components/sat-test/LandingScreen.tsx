'use client';

import { useState, useEffect } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { useSATTestStore } from '@/stores/useSATTestStore';
import { useAuth } from '@/contexts/AuthContext';
import { ClipboardList, BookOpen, GraduationCap, History, Loader2 } from 'lucide-react';
import Link from 'next/link';
import AccessCodeModal from './AccessCodeModal';

export default function LandingScreen() {
  const startTestMode = useSATTestStore((s) => s.startTestMode);
  const [showCodeModal, setShowCodeModal] = useState(false);
  const [autoStarting, setAutoStarting] = useState(false);
  const { user, loading } = useAuth();
  const router = useRouter();
  const searchParams = useSearchParams();

  // Auto-start when arriving with a ?token= param (from /sat-free claim flow)
  useEffect(() => {
    const tokenParam = searchParams.get('token');
    if (tokenParam && user && !loading) {
      setAutoStarting(true);
      fetch('/api/mocks/verify-token', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ code: tokenParam, examType: 'sat' }),
      })
        .then((res) => res.json())
        .then((data) => {
          if (data.valid) {
            startTestMode(data.setNumber, tokenParam);
          } else {
            setAutoStarting(false);
            setShowCodeModal(true);
          }
        })
        .catch(() => {
          setAutoStarting(false);
          setShowCodeModal(true);
        });
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [searchParams, user, loading]);

  const handleStartTest = () => {
    if (!user && !loading) {
      router.push('/auth?redirect=/sat-test');
      return;
    }
    setShowCodeModal(true);
  };

  const goToPracticeConfig = () => {
    if (!user && !loading) {
      router.push('/auth?redirect=/sat-test');
      return;
    }
    useSATTestStore.setState({ phase: 'practice-config', mode: 'practice' });
  };

  if (autoStarting) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="w-8 h-8 animate-spin text-[#0d47a1] mx-auto mb-4" />
          <p className="text-gray-600 font-medium">Preparing your test...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center p-4">
      {showCodeModal && (
        <AccessCodeModal
          onSuccess={async (setNumber: number, tokenCode: string) => {
            setShowCodeModal(false);
            await startTestMode(setNumber, tokenCode);
          }}
          onClose={() => setShowCodeModal(false)}
        />
      )}
      <div className="w-full max-w-3xl">
        <div className="text-center mb-8">
          <div className="inline-flex items-center gap-2 mb-4">
            <div className="w-10 h-10 bg-[#0d47a1] rounded-lg flex items-center justify-center">
              <GraduationCap className="w-5 h-5 text-white" />
            </div>
            <span className="text-2xl font-bold text-[#0d47a1] tracking-tight">
              Digital SAT
            </span>
          </div>
          <p className="text-gray-600">
            Full-length adaptive test: Reading &amp; Writing + Math — mirrors the real Digital SAT
          </p>
        </div>

        <div className="grid md:grid-cols-2 gap-6">
          <button
            onClick={handleStartTest}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:border-[#0d47a1] hover:shadow-lg transition-all"
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg bg-[#0d47a1] flex items-center justify-center group-hover:scale-105 transition-transform">
                <ClipboardList className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Full Test</h2>
                <p className="text-sm text-gray-500">Timed &amp; Adaptive</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="text-[#0d47a1] font-bold mt-0.5">1</span>
                <span>R&amp;W Module 1 — 27 questions, 32 min</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#0d47a1] font-bold mt-0.5">2</span>
                <span>R&amp;W Module 2 — 27 questions, 32 min (Adaptive)</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-gray-400 font-bold mt-0.5">—</span>
                <span className="text-gray-400">10-minute break</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#0d47a1] font-bold mt-0.5">3</span>
                <span>Math Module 1 — 22 questions, 35 min</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-[#0d47a1] font-bold mt-0.5">4</span>
                <span>Math Module 2 — 22 questions, 35 min (Adaptive)</span>
              </li>
            </ul>
            <div className="text-sm font-semibold text-[#0d47a1] group-hover:underline">
              Start Full Test →
            </div>
          </button>

          <button
            onClick={goToPracticeConfig}
            className="group text-left bg-white border-2 border-gray-200 rounded-xl p-6 hover:border-emerald-600 hover:shadow-lg transition-all"
          >
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-lg bg-emerald-600 flex items-center justify-center group-hover:scale-105 transition-transform">
                <BookOpen className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-gray-900">Practice Mode</h2>
                <p className="text-sm text-gray-500">Untimed &amp; Guided</p>
              </div>
            </div>
            <ul className="space-y-2 text-sm text-gray-600 mb-4">
              <li className="flex items-start gap-2">
                <span className="text-emerald-600 font-bold mt-0.5">✓</span>
                <span>5 free questions daily with AI explanations</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-emerald-600 font-bold mt-0.5">✓</span>
                <span>Practice by topic, domain, and difficulty</span>
              </li>
              <li className="flex items-start gap-2">
                <span className="text-emerald-600 font-bold mt-0.5">✓</span>
                <span>Upgrade for unlimited access to 2500+ questions</span>
              </li>
            </ul>
            <div className="text-sm font-semibold text-emerald-600 group-hover:underline">
              Configure Practice →
            </div>
          </button>
        </div>

        {user && (
          <div className="text-center mt-6">
            <Link
              href="/sat-test/history"
              className="inline-flex items-center gap-2 text-sm font-medium text-[#0d47a1] hover:underline"
            >
              <History className="w-4 h-4" />
              View Score History
            </Link>
          </div>
        )}

        <div className="text-center text-xs text-gray-400 mt-8 space-y-1">
          <p>
            <span className="font-medium text-gray-500">R&amp;W Domains:</span> Craft &amp; Structure · Information &amp; Ideas · Standard English · Expression of Ideas
          </p>
          <p>
            <span className="font-medium text-gray-500">Math Domains:</span> Algebra · Advanced Math · Problem Solving &amp; Data Analysis · Geometry &amp; Trig
          </p>
          <p>Score range: 400–1600 (R&amp;W 200–800 + Math 200–800)</p>
        </div>
      </div>
    </div>
  );
}

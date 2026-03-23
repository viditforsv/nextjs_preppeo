'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import Link from 'next/link';
import {
  GraduationCap,
  History,
  ArrowLeft,
  ChevronRight,
  Loader2,
  ClipboardList,
} from 'lucide-react';

interface AttemptSummary {
  id: string;
  set_number: number;
  estimated_score: number | null;
  total_correct: number;
  total_questions: number;
  score_pct: number;
  section2_tier: string | null;
  completed_at: string;
}

const TIER_LABELS: Record<string, { label: string; color: string }> = {
  hard: { label: 'Hard S2', color: 'bg-red-100 text-red-700' },
  medium: { label: 'Medium S2', color: 'bg-yellow-100 text-yellow-700' },
  easy: { label: 'Easy S2', color: 'bg-green-100 text-green-700' },
};

export default function GREHistoryPage() {
  const { user, loading: authLoading } = useAuth();
  const router = useRouter();
  const [attempts, setAttempts] = useState<AttemptSummary[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (authLoading) return;
    if (!user) {
      router.push('/auth?redirect=/gre-test/history');
      return;
    }

    fetch('/api/gre/attempts')
      .then((r) => r.json())
      .then((data) => {
        if (Array.isArray(data)) setAttempts(data);
      })
      .catch(console.error)
      .finally(() => setLoading(false));
  }, [user, authLoading, router]);

  if (authLoading || (!user && !loading)) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-[#1a365d]" />
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="bg-[#1a365d] text-white px-4 py-4">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <History className="w-5 h-5" />
            <h1 className="text-lg font-bold">GRE Score History</h1>
          </div>
          <Link
            href="/gre-test"
            className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
          >
            <ArrowLeft className="w-3.5 h-3.5" />
            Back to GRE
          </Link>
        </div>
      </div>

      <div className="max-w-4xl mx-auto p-4">
        {loading ? (
          <div className="flex items-center justify-center py-20">
            <Loader2 className="w-8 h-8 animate-spin text-[#1a365d]" />
          </div>
        ) : attempts.length === 0 ? (
          <div className="bg-white rounded-xl border border-gray-200 p-12 text-center">
            <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <ClipboardList className="w-8 h-8 text-gray-400" />
            </div>
            <h2 className="text-lg font-semibold text-gray-900 mb-2">No attempts yet</h2>
            <p className="text-sm text-gray-500 mb-6">
              Take your first GRE mock to see your scores here.
            </p>
            <Link
              href="/gre-test"
              className="inline-flex items-center gap-2 px-5 py-2.5 bg-[#1a365d] text-white rounded-lg font-semibold hover:bg-[#2a4a7f] transition-colors"
            >
              <GraduationCap className="w-4 h-4" />
              Take a Test
            </Link>
          </div>
        ) : (
          <div className="space-y-3">
            {attempts.map((a) => {
              const tierInfo = TIER_LABELS[a.section2_tier ?? ''] ?? TIER_LABELS.medium;
              const date = new Date(a.completed_at).toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'short',
                day: 'numeric',
              });
              const time = new Date(a.completed_at).toLocaleTimeString('en-US', {
                hour: 'numeric',
                minute: '2-digit',
              });

              return (
                <Link
                  key={a.id}
                  href={`/gre-test/history/${a.id}`}
                  className="block bg-white rounded-xl border border-gray-200 hover:border-[#1a365d] hover:shadow-md transition-all p-5"
                >
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-4 flex-1 min-w-0">
                      <div>
                        <div className="flex items-center gap-2 mb-1">
                          <span className={`text-xs font-semibold px-2 py-0.5 rounded-full ${tierInfo.color}`}>
                            {tierInfo.label}
                          </span>
                          <span className="text-xs text-gray-400">Set {a.set_number}</span>
                        </div>
                        <p className="text-sm text-gray-500">
                          {date} at {time}
                        </p>
                      </div>
                    </div>

                    <div className="flex items-center gap-6">
                      <div className="text-center">
                        <p className="text-xs text-gray-400">Quant</p>
                        <p className="text-lg font-bold text-[#1a365d]">
                          {a.estimated_score ?? '—'}
                        </p>
                        <p className="text-[10px] text-gray-400">/ 170</p>
                      </div>

                      <div className="text-center hidden sm:block">
                        <p className="text-xs text-gray-400">Accuracy</p>
                        <p className="text-sm font-bold text-gray-700">
                          {a.total_correct}/{a.total_questions}
                        </p>
                        <p className="text-[10px] text-gray-400">{a.score_pct}%</p>
                      </div>

                      <ChevronRight className="w-5 h-5 text-gray-300" />
                    </div>
                  </div>
                </Link>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}

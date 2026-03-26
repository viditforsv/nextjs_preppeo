'use client';

import { useEffect, useState } from 'react';
import { ArrowLeft, BarChart3, Loader2, TrendingDown, TrendingUp, Target } from 'lucide-react';
import { IBDP_DOMAIN_LABELS } from '@/lib/ibdp-maths-courses';
import type { IBDPMathsCourseConfig, AnalyticsData } from '@/types/ibdp-maths';
import type { IBDPMathsState } from '@/stores/useIBDPMathsStore';

interface Props {
  config: IBDPMathsCourseConfig;
  useStore: () => IBDPMathsState;
}

export default function AnalyticsDashboard({ config, useStore }: Props) {
  const { goToLanding } = useStore();
  const [data, setData] = useState<AnalyticsData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`/api/${config.apiPrefix}/analytics`)
      .then((r) => r.json())
      .then(setData)
      .catch(() => setData(null))
      .finally(() => setLoading(false));
  }, [config.apiPrefix]);

  const overallAccuracy = data && data.totalAttempted > 0
    ? Math.round((data.totalCorrect / data.totalAttempted) * 100)
    : 0;

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="text-white px-4 py-4" style={{ backgroundColor: config.accentColor }}>
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <BarChart3 className="w-5 h-5" />
            <h1 className="text-lg font-bold">Analytics — {config.title}</h1>
          </div>
          <button onClick={goToLanding}
            className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
          >
            <ArrowLeft className="w-3.5 h-3.5" /> Back
          </button>
        </div>
      </div>

      <div className="max-w-4xl mx-auto p-4 space-y-4">
        {loading && (
          <div className="flex items-center justify-center py-16">
            <Loader2 className="w-6 h-6 animate-spin" style={{ color: config.accentColor }} />
          </div>
        )}

        {!loading && (!data || data.totalAttempted === 0) && (
          <div className="bg-white rounded-xl border border-gray-200 p-8 text-center">
            <Target className="w-10 h-10 text-gray-300 mx-auto mb-3" />
            <p className="text-gray-500 font-medium">No practice data yet</p>
            <p className="text-sm text-gray-400 mt-1">Complete some practice questions to see your analytics</p>
          </div>
        )}

        {!loading && data && data.totalAttempted > 0 && (
          <>
            <div className="bg-white rounded-xl border border-gray-200 p-6">
              <div className="text-center mb-4">
                <p className="text-sm text-gray-500 mb-1">Overall Accuracy</p>
                <p className="text-5xl font-bold" style={{ color: config.accentColor }}>{overallAccuracy}%</p>
                <p className="text-gray-500 mt-1">{data.totalCorrect} of {data.totalAttempted} correct</p>
              </div>
            </div>

            {data.strongest.length > 0 && (
              <div className="grid sm:grid-cols-2 gap-4">
                <div className="bg-white rounded-xl border border-gray-200 p-5">
                  <div className="flex items-center gap-2 mb-3">
                    <TrendingUp className="w-4 h-4 text-green-600" />
                    <h3 className="text-sm font-semibold text-gray-700">Strongest Topics</h3>
                  </div>
                  <div className="space-y-2">
                    {data.strongest.map((d) => (
                      <div key={d} className="flex items-center gap-2">
                        <span className="w-2 h-2 bg-green-500 rounded-full shrink-0" />
                        <span className="text-sm text-gray-700">{IBDP_DOMAIN_LABELS[d as keyof typeof IBDP_DOMAIN_LABELS] ?? d}</span>
                      </div>
                    ))}
                  </div>
                </div>
                <div className="bg-white rounded-xl border border-gray-200 p-5">
                  <div className="flex items-center gap-2 mb-3">
                    <TrendingDown className="w-4 h-4 text-red-500" />
                    <h3 className="text-sm font-semibold text-gray-700">Focus Areas</h3>
                  </div>
                  <div className="space-y-2">
                    {data.weakest.map((d) => (
                      <div key={d} className="flex items-center gap-2">
                        <span className="w-2 h-2 bg-red-500 rounded-full shrink-0" />
                        <span className="text-sm text-gray-700">{IBDP_DOMAIN_LABELS[d as keyof typeof IBDP_DOMAIN_LABELS] ?? d}</span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            )}

            <div className="bg-white rounded-xl border border-gray-200 p-6">
              <h3 className="text-sm font-semibold text-gray-700 mb-4">Topic-wise Accuracy</h3>
              <div className="space-y-4">
                {data.chapters.map((ch) => (
                  <div key={ch.domain}>
                    <div className="flex items-center justify-between text-sm mb-1.5">
                      <span className="text-gray-700 font-medium">{ch.label}</span>
                      <span className="text-gray-500">
                        {ch.correct}/{ch.attempted}{' '}
                        <span className={`font-semibold ${
                          ch.accuracy >= 70 ? 'text-green-600' : ch.accuracy >= 40 ? 'text-amber-600' : 'text-red-600'
                        }`}>
                          ({ch.accuracy}%)
                        </span>
                      </span>
                    </div>
                    <div className="w-full bg-gray-100 rounded-full h-2.5">
                      <div
                        className={`h-2.5 rounded-full transition-all ${
                          ch.accuracy >= 70 ? 'bg-green-500' : ch.accuracy >= 40 ? 'bg-amber-500' : 'bg-red-500'
                        }`}
                        style={{ width: `${ch.accuracy}%` }}
                      />
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
}

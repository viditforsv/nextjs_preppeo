'use client';

import type { GREQuestionResponse, SectionResult } from '@/types/gre-test';
import { TrendingUp, TrendingDown, MinusCircle, Flag, Clock } from 'lucide-react';

interface Props {
  section1Result: SectionResult;
  section2Result: SectionResult | null;
  estimatedScore: number | null;
  responses: GREQuestionResponse[];
}

function StatCard({ label, value, sub, icon: Icon }: {
  label: string;
  value: string | number;
  sub?: string;
  icon?: React.ElementType;
}) {
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-4">
      <div className="flex items-center gap-2 mb-1">
        {Icon && <Icon className="w-4 h-4 text-gray-400" />}
        <p className="text-xs font-medium text-gray-500 uppercase tracking-wide">{label}</p>
      </div>
      <p className="text-2xl font-bold text-gray-900">{value}</p>
      {sub && <p className="text-xs text-gray-500 mt-0.5">{sub}</p>}
    </div>
  );
}

function SectionCard({ label, result }: { label: string; result: SectionResult }) {
  const pct = Math.round((result.correct / result.total) * 100);
  const timeMin = Math.floor(result.timeUsed / 60);
  const timeSec = result.timeUsed % 60;
  const tierLabel = result.difficultyTier.charAt(0).toUpperCase() + result.difficultyTier.slice(1);
  const isHarder = result.difficultyTier === 'hard';

  return (
    <div className="bg-white rounded-xl border border-gray-200 p-5 text-center">
      <p className="text-xs font-medium text-gray-500 uppercase tracking-wide mb-1">{label}</p>
      <div className="inline-flex items-end gap-2 mb-2">
        <span className={`text-3xl font-bold ${
          pct >= 70 ? 'text-green-600' : pct >= 40 ? 'text-yellow-600' : 'text-red-600'
        }`}>
          {result.correct}/{result.total}
        </span>
        <span className="text-sm text-gray-500 pb-1">{pct}%</span>
      </div>
      <p className="text-xs text-gray-400">{timeMin}m {timeSec}s used</p>
      {result.sectionNumber === 2 && (
        <div className="mt-2">
          {isHarder ? (
            <span className="inline-flex items-center gap-1 text-xs text-green-700 bg-green-50 px-2 py-0.5 rounded-full font-medium">
              <TrendingUp className="w-3 h-3" /> {tierLabel} S2
            </span>
          ) : (
            <span className="inline-flex items-center gap-1 text-xs text-orange-700 bg-orange-50 px-2 py-0.5 rounded-full font-medium">
              <TrendingDown className="w-3 h-3" /> {tierLabel} S2
            </span>
          )}
        </div>
      )}
    </div>
  );
}

export default function ScoreOverviewTab({
  section1Result,
  section2Result,
  estimatedScore,
  responses,
}: Props) {
  const omitted = responses.filter((r) => r.isOmitted).length;
  const flagged = responses.filter((r) => r.isFlagged).length;
  const totalTimeMs = responses.reduce((sum, r) => sum + r.timeSpentMs, 0);
  const avgTimeSec = responses.length > 0 ? Math.round(totalTimeMs / responses.length / 1000) : 0;
  const totalCorrect = responses.filter((r) => r.isCorrect).length;

  return (
    <div className="space-y-6">
      {estimatedScore !== null && (
        <div className="bg-white rounded-xl border border-gray-200 p-6 text-center">
          <p className="text-sm font-medium text-gray-500 mb-1">Estimated GRE Quant Score</p>
          <div className="inline-flex items-baseline gap-1">
            <span className={`text-6xl font-extrabold ${
              estimatedScore >= 160 ? 'text-green-600'
                : estimatedScore >= 150 ? 'text-yellow-600'
                : 'text-red-600'
            }`}>
              {estimatedScore}
            </span>
            <span className="text-2xl text-gray-400 font-medium">/ 170</span>
          </div>
        </div>
      )}

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <SectionCard label="Section 1 — Medium" result={section1Result} />
        {section2Result && (
          <SectionCard label="Section 2" result={section2Result} />
        )}
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        <StatCard label="Correct" value={totalCorrect} sub={`of ${responses.length}`} />
        <StatCard label="Omitted" value={omitted} icon={MinusCircle} />
        <StatCard label="Flagged" value={flagged} icon={Flag} />
        <StatCard label="Avg Time" value={`${avgTimeSec}s`} sub="per question" icon={Clock} />
      </div>
    </div>
  );
}

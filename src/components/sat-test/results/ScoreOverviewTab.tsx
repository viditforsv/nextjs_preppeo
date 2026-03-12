'use client';

import type { SATModuleResult, SATQuestionResponse } from '@/types/sat-test';
import { TrendingUp, TrendingDown, Flag, MinusCircle, Clock } from 'lucide-react';

interface Props {
  rwModule1Result: SATModuleResult | null;
  rwModule2Result: SATModuleResult | null;
  mathModule1Result: SATModuleResult;
  mathModule2Result: SATModuleResult | null;
  rwEstimatedScore: number | null;
  mathEstimatedScore: number | null;
  totalEstimatedScore: number | null;
  responses: SATQuestionResponse[];
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

function ModuleCard({ label, result, tierLabel }: {
  label: string;
  result: SATModuleResult;
  tierLabel?: string;
}) {
  const pct = Math.round((result.correct / result.total) * 100);
  const timeMin = Math.floor(result.timeUsed / 60);
  const timeSec = result.timeUsed % 60;
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-4">
      <div className="flex items-center justify-between mb-2">
        <p className="text-sm font-semibold text-gray-900">{label}</p>
        {tierLabel && (
          <span className="text-xs px-2 py-0.5 rounded-full bg-blue-50 text-blue-700 font-medium">
            {tierLabel}
          </span>
        )}
      </div>
      <div className="flex items-end gap-3">
        <span className={`text-3xl font-bold ${
          pct >= 70 ? 'text-green-600' : pct >= 40 ? 'text-yellow-600' : 'text-red-600'
        }`}>
          {result.correct}/{result.total}
        </span>
        <span className="text-sm text-gray-500 pb-1">{pct}% correct</span>
      </div>
      <p className="text-xs text-gray-400 mt-1">{timeMin}m {timeSec}s used</p>
    </div>
  );
}

function SectionScoreCard({ label, score, max, tierLabel, gotHarder }: {
  label: string;
  score: number;
  max: number;
  tierLabel?: string;
  gotHarder?: boolean;
}) {
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-5 text-center">
      <p className="text-xs font-medium text-gray-500 uppercase tracking-wide mb-1">{label}</p>
      <div className="inline-flex items-baseline gap-1">
        <span className={`text-4xl font-extrabold ${
          score >= max * 0.75 ? 'text-green-600'
            : score >= max * 0.5 ? 'text-yellow-600'
            : 'text-red-600'
        }`}>
          {score}
        </span>
        <span className="text-lg text-gray-400 font-medium">/ {max}</span>
      </div>
      {tierLabel && (
        <div className="mt-2">
          {gotHarder ? (
            <span className="inline-flex items-center gap-1 text-xs text-green-700 bg-green-50 px-2 py-0.5 rounded-full font-medium">
              <TrendingUp className="w-3 h-3" /> Harder M2
            </span>
          ) : (
            <span className="inline-flex items-center gap-1 text-xs text-orange-700 bg-orange-50 px-2 py-0.5 rounded-full font-medium">
              <TrendingDown className="w-3 h-3" /> Easier M2
            </span>
          )}
        </div>
      )}
    </div>
  );
}

export default function ScoreOverviewTab({
  rwModule1Result, rwModule2Result,
  mathModule1Result, mathModule2Result,
  rwEstimatedScore, mathEstimatedScore, totalEstimatedScore,
  responses,
}: Props) {
  const omitted = responses.filter((r) => r.isOmitted).length;
  const flagged = responses.filter((r) => r.isFlagged).length;
  const totalTimeMs = responses.reduce((sum, r) => sum + r.timeSpentMs, 0);
  const avgTimeSec = responses.length > 0 ? Math.round(totalTimeMs / responses.length / 1000) : 0;
  const totalCorrect = responses.filter((r) => r.isCorrect).length;

  const hasRW = rwModule1Result !== null;
  const rwGotHarder = rwModule2Result?.difficultyTier === 'hard';
  const mathGotHarder = mathModule2Result?.difficultyTier === 'hard';

  return (
    <div className="space-y-6">
      {/* Total score hero */}
      {totalEstimatedScore !== null && hasRW ? (
        <div className="bg-white rounded-xl border border-gray-200 p-6 text-center">
          <p className="text-sm font-medium text-gray-500 mb-1">Estimated SAT Total Score</p>
          <div className="inline-flex items-baseline gap-1">
            <span className={`text-6xl font-extrabold ${
              totalEstimatedScore >= 1200 ? 'text-green-600'
                : totalEstimatedScore >= 900 ? 'text-yellow-600'
                : 'text-red-600'
            }`}>
              {totalEstimatedScore}
            </span>
            <span className="text-2xl text-gray-400 font-medium">/ 1600</span>
          </div>
        </div>
      ) : mathEstimatedScore !== null ? (
        <div className="bg-white rounded-xl border border-gray-200 p-6 text-center">
          <p className="text-sm font-medium text-gray-500 mb-1">Estimated SAT Math Score</p>
          <div className="inline-flex items-baseline gap-1">
            <span className={`text-6xl font-extrabold ${
              mathEstimatedScore >= 600 ? 'text-green-600'
                : mathEstimatedScore >= 450 ? 'text-yellow-600'
                : 'text-red-600'
            }`}>
              {mathEstimatedScore}
            </span>
            <span className="text-2xl text-gray-400 font-medium">/ 800</span>
          </div>
        </div>
      ) : null}

      {/* Section score cards */}
      {hasRW && (
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <SectionScoreCard
            label="Reading & Writing"
            score={rwEstimatedScore ?? 200}
            max={800}
            tierLabel={rwModule2Result?.difficultyTier}
            gotHarder={rwGotHarder}
          />
          <SectionScoreCard
            label="Math"
            score={mathEstimatedScore ?? 200}
            max={800}
            tierLabel={mathModule2Result?.difficultyTier}
            gotHarder={mathGotHarder}
          />
        </div>
      )}

      {/* Module breakdown cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        {hasRW && rwModule1Result && (
          <ModuleCard label="R&W Module 1" result={rwModule1Result} tierLabel="Mixed" />
        )}
        {hasRW && rwModule2Result && (
          <ModuleCard
            label="R&W Module 2"
            result={rwModule2Result}
            tierLabel={rwGotHarder ? 'Higher' : 'Lower'}
          />
        )}
        <ModuleCard label="Math Module 1" result={mathModule1Result} tierLabel="Mixed" />
        {mathModule2Result && (
          <ModuleCard
            label="Math Module 2"
            result={mathModule2Result}
            tierLabel={mathGotHarder ? 'Higher' : 'Lower'}
          />
        )}
      </div>

      {/* Quick stats */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        <StatCard label="Correct" value={totalCorrect} sub={`of ${responses.length}`} />
        <StatCard label="Omitted" value={omitted} icon={MinusCircle} />
        <StatCard label="Flagged" value={flagged} icon={Flag} />
        <StatCard label="Avg Time" value={`${avgTimeSec}s`} sub="per question" icon={Clock} />
      </div>
    </div>
  );
}

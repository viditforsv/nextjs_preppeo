'use client';

import type { GREQuestionResponse, DifficultyTier } from '@/types/gre-test';
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Cell,
} from 'recharts';

const TIER_ORDER: DifficultyTier[] = ['easy', 'medium', 'hard'];
const TIER_LABELS: Record<DifficultyTier, string> = {
  easy: 'Easy',
  medium: 'Medium',
  hard: 'Hard',
};

function getColor(pct: number) {
  if (pct >= 70) return '#16a34a';
  if (pct >= 40) return '#ca8a04';
  return '#dc2626';
}

interface DiffStat {
  tier: DifficultyTier;
  label: string;
  correct: number;
  total: number;
  pct: number;
  avgTimeS: number;
}

function aggregate(responses: GREQuestionResponse[]): DiffStat[] {
  const map: Record<string, { correct: number; total: number; timeMs: number }> = {};
  for (const r of responses) {
    const key = r.difficulty;
    if (!map[key]) map[key] = { correct: 0, total: 0, timeMs: 0 };
    map[key].total++;
    if (r.isCorrect) map[key].correct++;
    map[key].timeMs += r.timeSpentMs;
  }
  return TIER_ORDER
    .filter((t) => map[t])
    .map((t) => {
      const s = map[t];
      return {
        tier: t,
        label: TIER_LABELS[t],
        correct: s.correct,
        total: s.total,
        pct: s.total > 0 ? Math.round((s.correct / s.total) * 100) : 0,
        avgTimeS: s.total > 0 ? Math.round(s.timeMs / s.total / 1000) : 0,
      };
    });
}

function getInsight(stats: DiffStat[]): string | null {
  const hard = stats.find((s) => s.tier === 'hard');
  const easy = stats.find((s) => s.tier === 'easy');
  if (hard && hard.pct < 40) {
    return `You found hard questions challenging (${hard.correct}/${hard.total} correct). Focus practice on harder problems.`;
  }
  if (easy && easy.pct < 70) {
    return `Some easier questions were missed (${easy.correct}/${easy.total}). Review fundamentals to pick up free points.`;
  }
  if (hard && hard.pct >= 70) {
    return `Strong performance on hard questions (${hard.correct}/${hard.total}). Great work!`;
  }
  return null;
}

interface Props {
  responses: GREQuestionResponse[];
}

export default function DifficultyBreakdownTab({ responses }: Props) {
  const stats = aggregate(responses);
  const insight = getInsight(stats);

  if (stats.length === 0) {
    return <p className="text-gray-500 text-center py-8">No difficulty data available.</p>;
  }

  return (
    <div className="space-y-6">
      <div className="bg-white rounded-xl border border-gray-200 p-4">
        <h2 className="text-sm font-semibold text-gray-700 mb-4">Performance by Difficulty</h2>
        <ResponsiveContainer width="100%" height={200}>
          <BarChart data={stats} margin={{ left: 0, right: 24 }}>
            <CartesianGrid strokeDasharray="3 3" vertical={false} />
            <XAxis dataKey="label" />
            <YAxis domain={[0, 100]} tickFormatter={(v) => `${v}%`} />
            <Tooltip formatter={(v: number) => `${v}%`} />
            <Bar dataKey="pct" radius={[4, 4, 0, 0]} barSize={48}>
              {stats.map((s) => (
                <Cell key={s.tier} fill={getColor(s.pct)} />
              ))}
            </Bar>
          </BarChart>
        </ResponsiveContainer>
      </div>

      {insight && (
        <div className="bg-blue-50 border border-blue-200 rounded-xl p-4 text-sm text-blue-800">
          {insight}
        </div>
      )}

      <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="bg-gray-50 text-left text-xs font-semibold text-gray-500 uppercase">
              <th className="px-4 py-3">Difficulty</th>
              <th className="px-4 py-3 text-center">Correct</th>
              <th className="px-4 py-3 text-center">%</th>
              <th className="px-4 py-3 text-center">Avg Time</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100">
            {stats.map((s) => (
              <tr key={s.tier}>
                <td className="px-4 py-3 font-medium text-gray-800">{s.label}</td>
                <td className="px-4 py-3 text-center text-gray-600">{s.correct}/{s.total}</td>
                <td className="px-4 py-3 text-center">
                  <span className={`font-semibold ${
                    s.pct >= 70 ? 'text-green-600' : s.pct >= 40 ? 'text-yellow-600' : 'text-red-600'
                  }`}>
                    {s.pct}%
                  </span>
                </td>
                <td className="px-4 py-3 text-center text-gray-600">{s.avgTimeS}s</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

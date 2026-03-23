'use client';

import type { GREQuestionResponse } from '@/types/gre-test';
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

function getColor(pct: number) {
  if (pct >= 70) return '#16a34a';
  if (pct >= 40) return '#ca8a04';
  return '#dc2626';
}

interface TopicStat {
  topic: string;
  correct: number;
  total: number;
  pct: number;
  avgTimeS: number;
}

function aggregate(responses: GREQuestionResponse[]): TopicStat[] {
  const map: Record<string, { correct: number; total: number; timeMs: number }> = {};
  for (const r of responses) {
    const topics = r.topics.length > 0 ? r.topics : ['Uncategorized'];
    for (const topic of topics) {
      if (!map[topic]) map[topic] = { correct: 0, total: 0, timeMs: 0 };
      map[topic].total++;
      if (r.isCorrect) map[topic].correct++;
      map[topic].timeMs += r.timeSpentMs;
    }
  }
  return Object.entries(map)
    .map(([topic, s]) => ({
      topic,
      correct: s.correct,
      total: s.total,
      pct: s.total > 0 ? Math.round((s.correct / s.total) * 100) : 0,
      avgTimeS: s.total > 0 ? Math.round(s.timeMs / s.total / 1000) : 0,
    }))
    .sort((a, b) => b.total - a.total);
}

interface Props {
  responses: GREQuestionResponse[];
}

export default function TopicBreakdownTab({ responses }: Props) {
  const stats = aggregate(responses);

  if (stats.length === 0) {
    return <p className="text-gray-500 text-center py-8">No topic data available.</p>;
  }

  return (
    <div className="space-y-6">
      <div className="bg-white rounded-xl border border-gray-200 p-4">
        <h2 className="text-sm font-semibold text-gray-700 mb-4">Performance by Topic</h2>
        <ResponsiveContainer width="100%" height={Math.max(220, stats.length * 40)}>
          <BarChart data={stats} layout="vertical" margin={{ left: 0, right: 24 }}>
            <CartesianGrid strokeDasharray="3 3" horizontal={false} />
            <XAxis type="number" domain={[0, 100]} tickFormatter={(v) => `${v}%`} />
            <YAxis type="category" dataKey="topic" width={160} tick={{ fontSize: 12 }} />
            <Tooltip formatter={(v: number) => `${v}%`} />
            <Bar dataKey="pct" radius={[0, 4, 4, 0]} barSize={28}>
              {stats.map((s) => (
                <Cell key={s.topic} fill={getColor(s.pct)} />
              ))}
            </Bar>
          </BarChart>
        </ResponsiveContainer>
      </div>

      <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="bg-gray-50 text-left text-xs font-semibold text-gray-500 uppercase">
              <th className="px-4 py-3">Topic</th>
              <th className="px-4 py-3 text-center">Correct</th>
              <th className="px-4 py-3 text-center">%</th>
              <th className="px-4 py-3 text-center">Avg Time</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100">
            {stats.map((s) => (
              <tr key={s.topic}>
                <td className="px-4 py-3 font-medium text-gray-800">{s.topic}</td>
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

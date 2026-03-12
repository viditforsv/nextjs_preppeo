'use client';

import { useState } from 'react';
import type { SATQuestionResponse, SATDomain } from '@/types/sat-test';
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

const DOMAIN_LABELS: Record<string, string> = {
  algebra: 'Algebra',
  'advanced-math': 'Advanced Math',
  'problem-solving': 'Problem Solving & Data',
  'geometry-trig': 'Geometry & Trig',
  'craft-structure': 'Craft & Structure',
  'information-ideas': 'Information & Ideas',
  'standard-english': 'Standard English',
  'expression-of-ideas': 'Expression of Ideas',
};

const RW_DOMAINS: (SATDomain | 'unknown')[] = [
  'craft-structure',
  'information-ideas',
  'standard-english',
  'expression-of-ideas',
];

const MATH_DOMAINS: (SATDomain | 'unknown')[] = [
  'algebra',
  'advanced-math',
  'problem-solving',
  'geometry-trig',
];

type SectionFilter = 'all' | 'rw' | 'math';

function getColor(pct: number) {
  if (pct >= 70) return '#16a34a';
  if (pct >= 40) return '#ca8a04';
  return '#dc2626';
}

interface DomainStat {
  domain: string;
  label: string;
  correct: number;
  total: number;
  pct: number;
  avgTimeS: number;
}

function aggregate(responses: SATQuestionResponse[], sectionFilter: SectionFilter): DomainStat[] {
  const filtered = sectionFilter === 'all' ? responses : responses.filter((r) => r.section === sectionFilter);
  const order = sectionFilter === 'rw' ? RW_DOMAINS
    : sectionFilter === 'math' ? MATH_DOMAINS
    : [...RW_DOMAINS, ...MATH_DOMAINS];

  const map: Record<string, { correct: number; total: number; timeMs: number }> = {};
  for (const r of filtered) {
    const key = r.domain ?? 'unknown';
    if (!map[key]) map[key] = { correct: 0, total: 0, timeMs: 0 };
    map[key].total++;
    if (r.isCorrect) map[key].correct++;
    map[key].timeMs += r.timeSpentMs;
  }
  return order
    .filter((d) => map[d])
    .map((d) => {
      const s = map[d];
      return {
        domain: d,
        label: DOMAIN_LABELS[d] ?? d,
        correct: s.correct,
        total: s.total,
        pct: s.total > 0 ? Math.round((s.correct / s.total) * 100) : 0,
        avgTimeS: s.total > 0 ? Math.round(s.timeMs / s.total / 1000) : 0,
      };
    });
}

interface Props {
  responses: SATQuestionResponse[];
}

export default function DomainBreakdownTab({ responses }: Props) {
  const hasRW = responses.some((r) => r.section === 'rw');
  const hasMath = responses.some((r) => r.section === 'math');
  const [sectionFilter, setSectionFilter] = useState<SectionFilter>(
    hasRW && hasMath ? 'all' : hasRW ? 'rw' : 'math'
  );

  const stats = aggregate(responses, sectionFilter);

  if (stats.length === 0) {
    return <p className="text-gray-500 text-center py-8">No domain data available.</p>;
  }

  return (
    <div className="space-y-6">
      {/* Section filter */}
      {hasRW && hasMath && (
        <div className="flex gap-2">
          {(['all', 'rw', 'math'] as const).map((f) => (
            <button
              key={f}
              onClick={() => setSectionFilter(f)}
              className={`text-xs font-medium px-3 py-1.5 rounded-full border transition-colors ${
                sectionFilter === f
                  ? 'bg-[#0d47a1] text-white border-[#0d47a1]'
                  : 'bg-white text-gray-600 border-gray-300 hover:border-gray-400'
              }`}
            >
              {f === 'all' ? 'All Domains' : f === 'rw' ? 'R&W' : 'Math'}
            </button>
          ))}
        </div>
      )}

      {/* Chart */}
      <div className="bg-white rounded-xl border border-gray-200 p-4">
        <h2 className="text-sm font-semibold text-gray-700 mb-4">Performance by Domain</h2>
        <ResponsiveContainer width="100%" height={Math.max(220, stats.length * 40)}>
          <BarChart data={stats} layout="vertical" margin={{ left: 0, right: 24 }}>
            <CartesianGrid strokeDasharray="3 3" horizontal={false} />
            <XAxis type="number" domain={[0, 100]} tickFormatter={(v) => `${v}%`} />
            <YAxis type="category" dataKey="label" width={160} tick={{ fontSize: 12 }} />
            <Tooltip formatter={(v: number) => `${v}%`} />
            <Bar dataKey="pct" radius={[0, 4, 4, 0]} barSize={28}>
              {stats.map((s) => (
                <Cell key={s.domain} fill={getColor(s.pct)} />
              ))}
            </Bar>
          </BarChart>
        </ResponsiveContainer>
      </div>

      {/* Table */}
      <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="bg-gray-50 text-left text-xs font-semibold text-gray-500 uppercase">
              <th className="px-4 py-3">Domain</th>
              <th className="px-4 py-3 text-center">Correct</th>
              <th className="px-4 py-3 text-center">%</th>
              <th className="px-4 py-3 text-center">Avg Time</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100">
            {stats.map((s) => (
              <tr key={s.domain}>
                <td className="px-4 py-3 font-medium text-gray-800">{s.label}</td>
                <td className="px-4 py-3 text-center text-gray-600">
                  {s.correct}/{s.total}
                </td>
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

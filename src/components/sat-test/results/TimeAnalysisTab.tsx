'use client';

import type { SATQuestionResponse } from '@/types/sat-test';
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Cell,
  ReferenceLine,
} from 'recharts';
import { AlertTriangle } from 'lucide-react';

interface Props {
  responses: SATQuestionResponse[];
}

export default function TimeAnalysisTab({ responses }: Props) {
  if (responses.length === 0) {
    return <p className="text-gray-500 text-center py-8">No time data available.</p>;
  }

  const chartData = responses.map((r, i) => ({
    name: `Q${i + 1}`,
    seconds: Math.round(r.timeSpentMs / 1000),
    isCorrect: r.isCorrect,
  }));

  const totalTimeS = chartData.reduce((s, d) => s + d.seconds, 0);
  const avgTimeS = Math.round(totalTimeS / chartData.length);
  const sorted = [...chartData].sort((a, b) => b.seconds - a.seconds);
  const slowest = sorted[0];
  const fastest = sorted[sorted.length - 1];
  const timeSinks = chartData.filter((d) => d.seconds > avgTimeS * 2);

  const totalMin = Math.floor(totalTimeS / 60);
  const totalSec = totalTimeS % 60;

  return (
    <div className="space-y-6">
      {/* Summary cards */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <p className="text-xs font-medium text-gray-500 uppercase">Total Time</p>
          <p className="text-2xl font-bold text-gray-900">{totalMin}m {totalSec}s</p>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <p className="text-xs font-medium text-gray-500 uppercase">Avg / Question</p>
          <p className="text-2xl font-bold text-gray-900">{avgTimeS}s</p>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <p className="text-xs font-medium text-gray-500 uppercase">Fastest</p>
          <p className="text-2xl font-bold text-green-600">{fastest.seconds}s</p>
          <p className="text-xs text-gray-400">{fastest.name}</p>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <p className="text-xs font-medium text-gray-500 uppercase">Slowest</p>
          <p className="text-2xl font-bold text-red-600">{slowest.seconds}s</p>
          <p className="text-xs text-gray-400">{slowest.name}</p>
        </div>
      </div>

      {/* Chart */}
      <div className="bg-white rounded-xl border border-gray-200 p-4">
        <h2 className="text-sm font-semibold text-gray-700 mb-4">Time per Question (seconds)</h2>
        <ResponsiveContainer width="100%" height={280}>
          <BarChart data={chartData} margin={{ left: 0, right: 8 }}>
            <CartesianGrid strokeDasharray="3 3" vertical={false} />
            <XAxis dataKey="name" tick={{ fontSize: 10 }} interval={0} angle={-45} textAnchor="end" height={50} />
            <YAxis tickFormatter={(v) => `${v}s`} />
            <Tooltip formatter={(v: number) => `${v}s`} />
            <ReferenceLine y={avgTimeS} stroke="#6b7280" strokeDasharray="4 4" label={{ value: `Avg ${avgTimeS}s`, position: 'right', fontSize: 11, fill: '#6b7280' }} />
            <Bar dataKey="seconds" radius={[3, 3, 0, 0]} barSize={12}>
              {chartData.map((d, i) => (
                <Cell key={i} fill={d.isCorrect ? '#16a34a' : '#dc2626'} />
              ))}
            </Bar>
          </BarChart>
        </ResponsiveContainer>
        <div className="flex items-center gap-4 mt-2 text-xs text-gray-500">
          <span className="flex items-center gap-1"><span className="w-3 h-3 rounded bg-green-600 inline-block" /> Correct</span>
          <span className="flex items-center gap-1"><span className="w-3 h-3 rounded bg-red-600 inline-block" /> Incorrect</span>
          <span className="flex items-center gap-1"><span className="w-6 border-t-2 border-dashed border-gray-400 inline-block" /> Average</span>
        </div>
      </div>

      {/* Time sinks */}
      {timeSinks.length > 0 && (
        <div className="bg-amber-50 border border-amber-200 rounded-xl p-4">
          <div className="flex items-center gap-2 mb-2">
            <AlertTriangle className="w-4 h-4 text-amber-600" />
            <h3 className="text-sm font-semibold text-amber-800">Time Sinks</h3>
          </div>
          <p className="text-sm text-amber-700 mb-2">
            {timeSinks.length} question{timeSinks.length > 1 ? 's' : ''} took more than 2x the average time ({avgTimeS * 2}s+):
          </p>
          <div className="flex flex-wrap gap-2">
            {timeSinks.map((d) => (
              <span key={d.name} className={`text-xs px-2 py-1 rounded-full font-medium ${
                d.isCorrect
                  ? 'bg-green-100 text-green-800'
                  : 'bg-red-100 text-red-800'
              }`}>
                {d.name}: {d.seconds}s
              </span>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

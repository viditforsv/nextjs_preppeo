'use client';

import { useEffect, useMemo, useState } from 'react';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import Link from 'next/link';
import {
  BarChart, Bar, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell, Legend,
} from 'recharts';
import {
  BarChart3, ArrowLeft, Loader2, ClipboardList, Target, Timer, TrendingDown, TrendingUp, BookOpen,
} from 'lucide-react';

interface DomainStat {
  domain: string;
  label: string;
  section: 'math' | 'rw' | 'unknown';
  correct: number;
  total: number;
  pct: number;
  avgTimeS: number | null;
}

interface TierStat { tier: string; correct: number; total: number; pct: number }

interface TopicStat {
  subtopic: string;
  domainLabel: string;
  correct: number;
  total: number;
  pct: number;
  avgTimeS: number | null;
}

interface DaySummary { total: number; correct: number; pct: number; avgTimeS: number | null }
interface TrendDay { date: string; overall: DaySummary; domains: Record<string, DaySummary> }
interface TrendDomain { domain: string; label: string; section: 'math' | 'rw' | 'unknown' }

interface Analytics {
  overall: { total: number; correct: number; pct: number; avgTimeS: number | null; totalTimeMin: number; timedCount: number };
  byDomain: DomainStat[];
  byDifficulty: TierStat[];
  bySection: { section: 'math' | 'rw'; correct: number; total: number; pct: number }[];
  weakestTopics: TopicStat[];
  timeSinks: TopicStat[];
  trend: TrendDay[];
  trendDomains: TrendDomain[];
}

type SectionFilter = 'all' | 'rw' | 'math';

const TIER_LABELS: Record<string, string> = { easy: 'Easy', medium: 'Medium', hard: 'Hard' };

function pctColor(p: number) {
  if (p >= 70) return '#16a34a';
  if (p >= 40) return '#ca8a04';
  return '#dc2626';
}

function pctTextClass(p: number) {
  return p >= 70 ? 'text-green-600' : p >= 40 ? 'text-yellow-600' : 'text-red-600';
}

export default function PracticeAnalyticsPage() {
  const { user, loading: authLoading } = useAuth();
  const router = useRouter();
  const [data, setData] = useState<Analytics | null>(null);
  const [loading, setLoading] = useState(true);
  const [sectionFilter, setSectionFilter] = useState<SectionFilter>('all');
  const [trendDomain, setTrendDomain] = useState<string>('all');

  useEffect(() => {
    if (authLoading) return;
    if (!user) {
      router.push('/auth?redirect=/sat-test/practice-analytics');
      return;
    }
    fetch('/api/sat/practice-analytics')
      .then((r) => r.json())
      .then((d) => { if (!d.error) setData(d); })
      .catch(console.error)
      .finally(() => setLoading(false));
  }, [user, authLoading, router]);

  const hasRW = data?.byDomain.some((d) => d.section === 'rw') ?? false;
  const hasMath = data?.byDomain.some((d) => d.section === 'math') ?? false;

  const domainStats = useMemo(() => {
    if (!data) return [];
    return sectionFilter === 'all'
      ? data.byDomain
      : data.byDomain.filter((d) => d.section === sectionFilter);
  }, [data, sectionFilter]);

  // Build the progress series for the selected domain: each active day's accuracy
  // plus a running cumulative accuracy (the trajectory), and avg time per question.
  const trendSeries = useMemo(() => {
    if (!data) return [];
    let cumCorrect = 0;
    let cumTotal = 0;
    const out: { date: string; label: string; dayPct: number | null; cumPct: number | null; avgTimeS: number | null; total: number }[] = [];
    for (const day of data.trend) {
      const s = trendDomain === 'all' ? day.overall : day.domains[trendDomain];
      const total = s?.total ?? 0;
      if (total === 0) continue; // skip days with no data for this domain
      cumCorrect += s!.correct;
      cumTotal += total;
      out.push({
        date: day.date,
        label: day.date.slice(5).replace('-', '/'), // MM/DD
        dayPct: s!.pct,
        cumPct: cumTotal > 0 ? Math.round((cumCorrect / cumTotal) * 100) : null,
        avgTimeS: s!.avgTimeS,
        total,
      });
    }
    return out;
  }, [data, trendDomain]);

  const hasTimeTrend = trendSeries.some((d) => d.avgTimeS !== null);
  const firstCum = trendSeries[0]?.cumPct ?? null;
  const lastCum = trendSeries[trendSeries.length - 1]?.cumPct ?? null;
  const cumDelta = firstCum !== null && lastCum !== null ? lastCum - firstCum : null;

  if (authLoading || (!user && !loading)) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-[#0d47a1]" />
      </div>
    );
  }

  const empty = !loading && (!data || data.overall.total === 0);

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="bg-[#0d47a1] text-white px-4 py-4">
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <BarChart3 className="w-5 h-5" />
            <h1 className="text-lg font-bold">Practice Analytics</h1>
          </div>
          <Link
            href="/sat-test"
            className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
          >
            <ArrowLeft className="w-3.5 h-3.5" />
            Back to SAT
          </Link>
        </div>
      </div>

      <div className="max-w-4xl mx-auto p-4">
        {loading ? (
          <div className="flex items-center justify-center py-20">
            <Loader2 className="w-8 h-8 animate-spin text-[#0d47a1]" />
          </div>
        ) : empty ? (
          <div className="bg-white rounded-xl border border-gray-200 p-12 text-center">
            <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <ClipboardList className="w-8 h-8 text-gray-400" />
            </div>
            <h2 className="text-lg font-semibold text-gray-900 mb-2">No practice data yet</h2>
            <p className="text-sm text-gray-500 mb-6">
              Answer some practice questions and your performance breakdown will show up here.
            </p>
            <Link
              href="/sat-test"
              className="inline-flex items-center gap-2 px-5 py-2.5 bg-[#0d47a1] text-white rounded-lg font-semibold hover:bg-[#1565c0] transition-colors"
            >
              <BookOpen className="w-4 h-4" />
              Start Practicing
            </Link>
          </div>
        ) : data ? (
          <div className="space-y-6">
            {/* Summary cards */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
              <SummaryCard icon={<ClipboardList className="w-4 h-4" />} label="Questions" value={String(data.overall.total)} />
              <SummaryCard
                icon={<Target className="w-4 h-4" />}
                label="Accuracy"
                value={`${data.overall.pct}%`}
                valueClass={pctTextClass(data.overall.pct)}
                sub={`${data.overall.correct}/${data.overall.total} correct`}
              />
              <SummaryCard
                icon={<Timer className="w-4 h-4" />}
                label="Avg / question"
                value={data.overall.avgTimeS !== null ? `${data.overall.avgTimeS}s` : '—'}
              />
              <SummaryCard
                icon={<Timer className="w-4 h-4" />}
                label="Time practiced"
                value={data.overall.totalTimeMin > 0 ? `${data.overall.totalTimeMin}m` : '—'}
              />
            </div>

            {/* Progress over time — the hero */}
            <div className="bg-white rounded-xl border border-gray-200 p-4">
              <div className="flex items-start justify-between gap-3 mb-1">
                <div>
                  <h2 className="flex items-center gap-2 text-sm font-semibold text-gray-700">
                    <TrendingUp className="w-4 h-4 text-emerald-600" />
                    Progress over time
                  </h2>
                  <p className="text-xs text-gray-500 mt-0.5">
                    Your accuracy as you practice. The bold line is your running average.
                  </p>
                </div>
                {cumDelta !== null && trendSeries.length >= 2 && (
                  <span className={`shrink-0 text-xs font-semibold px-2 py-1 rounded-full ${
                    cumDelta > 0 ? 'bg-emerald-100 text-emerald-700'
                      : cumDelta < 0 ? 'bg-red-100 text-red-700'
                      : 'bg-gray-100 text-gray-600'
                  }`}>
                    {cumDelta > 0 ? '▲' : cumDelta < 0 ? '▼' : ''} {Math.abs(cumDelta)} pts
                  </span>
                )}
              </div>

              {/* Domain picker */}
              {data.trendDomains.length > 0 && (
                <div className="flex flex-wrap gap-2 my-3">
                  <button
                    onClick={() => setTrendDomain('all')}
                    className={`text-xs font-medium px-3 py-1 rounded-full border transition-colors ${
                      trendDomain === 'all'
                        ? 'bg-[#0d47a1] text-white border-[#0d47a1]'
                        : 'bg-white text-gray-600 border-gray-300 hover:border-gray-400'
                    }`}
                  >
                    Overall
                  </button>
                  {data.trendDomains.map((d) => (
                    <button
                      key={d.domain}
                      onClick={() => setTrendDomain(d.domain)}
                      className={`text-xs font-medium px-3 py-1 rounded-full border transition-colors ${
                        trendDomain === d.domain
                          ? 'bg-[#0d47a1] text-white border-[#0d47a1]'
                          : 'bg-white text-gray-600 border-gray-300 hover:border-gray-400'
                      }`}
                    >
                      {d.label}
                    </button>
                  ))}
                </div>
              )}

              {trendSeries.length < 2 ? (
                <p className="text-sm text-gray-400 text-center py-8">
                  Practice on more than one day to see your trajectory{trendDomain !== 'all' ? ' for this domain' : ''}.
                </p>
              ) : (
                <>
                  <ResponsiveContainer width="100%" height={240}>
                    <LineChart data={trendSeries} margin={{ left: -16, right: 12, top: 8 }}>
                      <CartesianGrid strokeDasharray="3 3" vertical={false} />
                      <XAxis dataKey="label" tick={{ fontSize: 11 }} />
                      <YAxis domain={[0, 100]} tickFormatter={(v) => `${v}%`} tick={{ fontSize: 11 }} />
                      <Tooltip formatter={(v: number, name: string) => [`${v}%`, name]} />
                      <Legend wrapperStyle={{ fontSize: 12 }} />
                      <Line type="monotone" dataKey="dayPct" name="That day" stroke="#94a3b8" strokeWidth={1.5} strokeDasharray="4 3" dot={{ r: 2 }} />
                      <Line type="monotone" dataKey="cumPct" name="Running avg" stroke="#16a34a" strokeWidth={2.5} dot={{ r: 3 }} />
                    </LineChart>
                  </ResponsiveContainer>

                  {hasTimeTrend && (
                    <div className="mt-4 pt-4 border-t border-gray-100">
                      <h3 className="flex items-center gap-1.5 text-xs font-semibold text-gray-500 mb-2">
                        <Timer className="w-3.5 h-3.5" />
                        Avg time per question (lower = faster)
                      </h3>
                      <ResponsiveContainer width="100%" height={160}>
                        <LineChart data={trendSeries} margin={{ left: -16, right: 12, top: 4 }}>
                          <CartesianGrid strokeDasharray="3 3" vertical={false} />
                          <XAxis dataKey="label" tick={{ fontSize: 11 }} />
                          <YAxis tickFormatter={(v) => `${v}s`} tick={{ fontSize: 11 }} />
                          <Tooltip formatter={(v: number) => `${v}s`} />
                          <Line type="monotone" dataKey="avgTimeS" name="Avg time" stroke="#d97706" strokeWidth={2} dot={{ r: 3 }} connectNulls />
                        </LineChart>
                      </ResponsiveContainer>
                    </div>
                  )}
                </>
              )}
            </div>

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

            {/* Domain chart */}
            {domainStats.length > 0 && (
              <div className="bg-white rounded-xl border border-gray-200 p-4">
                <h2 className="text-sm font-semibold text-gray-700 mb-4">Accuracy by Domain</h2>
                <ResponsiveContainer width="100%" height={Math.max(220, domainStats.length * 40)}>
                  <BarChart data={domainStats} layout="vertical" margin={{ left: 0, right: 24 }}>
                    <CartesianGrid strokeDasharray="3 3" horizontal={false} />
                    <XAxis type="number" domain={[0, 100]} tickFormatter={(v) => `${v}%`} />
                    <YAxis type="category" dataKey="label" width={160} tick={{ fontSize: 12 }} />
                    <Tooltip formatter={(v: number) => `${v}%`} />
                    <Bar dataKey="pct" radius={[0, 4, 4, 0]} barSize={28}>
                      {domainStats.map((s) => (
                        <Cell key={s.domain} fill={pctColor(s.pct)} />
                      ))}
                    </Bar>
                  </BarChart>
                </ResponsiveContainer>

                <table className="w-full text-sm mt-2">
                  <thead>
                    <tr className="text-left text-xs font-semibold text-gray-500 uppercase border-t border-gray-100">
                      <th className="px-2 py-2">Domain</th>
                      <th className="px-2 py-2 text-center">Correct</th>
                      <th className="px-2 py-2 text-center">%</th>
                      <th className="px-2 py-2 text-center">Avg Time</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-100">
                    {domainStats.map((s) => (
                      <tr key={s.domain}>
                        <td className="px-2 py-2 font-medium text-gray-800">{s.label}</td>
                        <td className="px-2 py-2 text-center text-gray-600">{s.correct}/{s.total}</td>
                        <td className="px-2 py-2 text-center">
                          <span className={`font-semibold ${pctTextClass(s.pct)}`}>{s.pct}%</span>
                        </td>
                        <td className="px-2 py-2 text-center text-gray-600">{s.avgTimeS !== null ? `${s.avgTimeS}s` : '—'}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}

            {/* Difficulty */}
            {data.byDifficulty.length > 0 && (
              <div className="bg-white rounded-xl border border-gray-200 p-4">
                <h2 className="text-sm font-semibold text-gray-700 mb-4">Accuracy by Difficulty</h2>
                <div className="space-y-3">
                  {data.byDifficulty.map((t) => (
                    <div key={t.tier} className="flex items-center gap-3">
                      <span className="w-16 text-xs font-medium text-gray-600">{TIER_LABELS[t.tier] ?? t.tier}</span>
                      <div className="flex-1 h-3 bg-gray-100 rounded-full overflow-hidden">
                        <div className="h-full rounded-full" style={{ width: `${t.pct}%`, backgroundColor: pctColor(t.pct) }} />
                      </div>
                      <span className={`w-24 text-right text-xs font-semibold ${pctTextClass(t.pct)}`}>
                        {t.pct}% <span className="text-gray-400 font-normal">({t.correct}/{t.total})</span>
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* Weakest topics */}
            {data.weakestTopics.length > 0 && (
              <div className="bg-white rounded-xl border border-gray-200 p-4">
                <h2 className="flex items-center gap-2 text-sm font-semibold text-gray-700 mb-1">
                  <TrendingDown className="w-4 h-4 text-red-500" />
                  Topics to improve
                </h2>
                <p className="text-xs text-gray-500 mb-3">Lowest accuracy where you&apos;ve answered at least 3 questions.</p>
                <ul className="divide-y divide-gray-100">
                  {data.weakestTopics.map((s) => (
                    <li key={s.subtopic} className="flex items-center justify-between py-2.5">
                      <div className="min-w-0">
                        <p className="text-sm font-medium text-gray-800 truncate">{s.subtopic}</p>
                        <p className="text-xs text-gray-400">{s.domainLabel}</p>
                      </div>
                      <div className="text-right shrink-0 ml-3">
                        <span className={`text-sm font-semibold ${pctTextClass(s.pct)}`}>{s.pct}%</span>
                        <p className="text-[10px] text-gray-400">{s.correct}/{s.total}</p>
                      </div>
                    </li>
                  ))}
                </ul>
              </div>
            )}

            {/* Time sinks */}
            {data.timeSinks.length > 0 && (
              <div className="bg-white rounded-xl border border-gray-200 p-4">
                <h2 className="flex items-center gap-2 text-sm font-semibold text-gray-700 mb-1">
                  <Timer className="w-4 h-4 text-amber-500" />
                  Biggest time sinks
                </h2>
                <p className="text-xs text-gray-500 mb-3">Where you spend the most time per question (min. 3 attempts).</p>
                <ul className="divide-y divide-gray-100">
                  {data.timeSinks.map((s) => (
                    <li key={s.subtopic} className="flex items-center justify-between py-2.5">
                      <div className="min-w-0">
                        <p className="text-sm font-medium text-gray-800 truncate">{s.subtopic}</p>
                        <p className="text-xs text-gray-400">{s.domainLabel}</p>
                      </div>
                      <div className="text-right shrink-0 ml-3">
                        <span className="text-sm font-semibold text-amber-600">{s.avgTimeS}s</span>
                        <p className="text-[10px] text-gray-400">avg · {s.total} qs</p>
                      </div>
                    </li>
                  ))}
                </ul>
              </div>
            )}
          </div>
        ) : null}
      </div>
    </div>
  );
}

function SummaryCard({
  icon, label, value, sub, valueClass,
}: { icon: React.ReactNode; label: string; value: string; sub?: string; valueClass?: string }) {
  return (
    <div className="bg-white rounded-xl border border-gray-200 p-4">
      <div className="flex items-center gap-1.5 text-gray-400 mb-1">
        {icon}
        <span className="text-xs font-medium">{label}</span>
      </div>
      <p className={`text-2xl font-bold ${valueClass ?? 'text-gray-900'}`}>{value}</p>
      {sub && <p className="text-[11px] text-gray-400 mt-0.5">{sub}</p>}
    </div>
  );
}

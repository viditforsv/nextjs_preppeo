"use client";

import { useMemo, useState } from "react";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
  ReferenceLine,
} from "recharts";
import { Card, CardContent } from "@/design-system/components/ui/card";

export interface ScorePoint {
  date: string;
  total: number | null;
  math: number | null;
  rw: number | null;
}

export interface PracticeRow {
  is_correct: boolean;
  domain: string | null;
  created_at: string;
}

const DOMAIN_LABELS: Record<string, string> = {
  algebra: "Algebra",
  "advanced-math": "Advanced Math",
  "problem-solving": "Problem Solving & Data",
  "geometry-trig": "Geometry & Trig",
  "craft-structure": "Craft & Structure",
  "information-ideas": "Information & Ideas",
  "standard-english": "Standard English",
  "expression-of-ideas": "Expression of Ideas",
};

const labelFor = (domain: string | null) => {
  if (!domain) return "Other";
  return (
    DOMAIN_LABELS[domain] ||
    domain.replace(/-/g, " ").replace(/\b\w/g, (c) => c.toUpperCase())
  );
};

/* ----------------------------- Segmented ----------------------------- */

function Segmented<T extends string>({
  options,
  value,
  onChange,
}: {
  options: { value: T; label: string }[];
  value: T;
  onChange: (v: T) => void;
}) {
  return (
    <div className="inline-flex border rounded-sm overflow-hidden">
      {options.map((opt, i) => (
        <button
          key={opt.value}
          type="button"
          onClick={() => onChange(opt.value)}
          className={`text-sm px-3.5 py-1.5 transition-colors ${
            i > 0 ? "border-l" : ""
          } ${
            value === opt.value
              ? "bg-[#0d47a1] text-white"
              : "bg-background text-foreground hover:bg-muted"
          }`}
        >
          {opt.label}
        </button>
      ))}
    </div>
  );
}

function SectionHead({
  title,
  children,
}: {
  title: string;
  children?: React.ReactNode;
}) {
  return (
    <div className="flex items-center gap-3 mt-8 mb-3.5">
      <h2 className="text-xl font-bold">{title}</h2>
      <div className="flex-1" />
      {children}
    </div>
  );
}

/* --------------------------- Score history --------------------------- */

interface ChartTooltipEntry {
  name: string;
  value: number;
  color: string;
}

function ChartTooltip({
  active,
  payload,
  label,
}: {
  active?: boolean;
  payload?: ChartTooltipEntry[];
  label?: string;
}) {
  if (!active || !payload?.length) return null;
  return (
    <div className="rounded-sm border bg-white px-3 py-2 shadow-sm text-xs">
      <p className="font-medium text-foreground mb-1">{label}</p>
      {payload.map((e) => (
        <p key={e.name} style={{ color: e.color }}>
          {e.name}: <span className="font-semibold">{e.value}</span>
        </p>
      ))}
    </div>
  );
}

function ScoreHistory({
  scorePoints,
  target,
}: {
  scorePoints: ScorePoint[];
  target: number;
}) {
  const [view, setView] = useState<"total" | "section">("section");

  if (scorePoints.length < 2) {
    return (
      <>
        <SectionHead title="Score history" />
        <Card className="rounded-sm">
          <CardContent className="p-10 text-center text-muted-foreground text-sm">
            Complete at least two full mocks to see your score trend.
          </CardContent>
        </Card>
      </>
    );
  }

  return (
    <>
      <SectionHead title="Score history">
        <Segmented
          value={view}
          onChange={setView}
          options={[
            { value: "total", label: "Total" },
            { value: "section", label: "By section" },
          ]}
        />
      </SectionHead>
      <Card className="rounded-sm">
        <CardContent className="p-5">
          <ResponsiveContainer width="100%" height={300}>
            <LineChart
              data={scorePoints}
              margin={{ top: 8, right: 16, left: -8, bottom: 0 }}
            >
              <CartesianGrid
                strokeDasharray="3 3"
                stroke="#e5e7eb"
                vertical={false}
              />
              <XAxis
                dataKey="date"
                tick={{ fontSize: 12, fill: "#6b7280" }}
                tickLine={false}
                axisLine={{ stroke: "#e5e7eb" }}
              />
              {view === "total" ? (
                <YAxis
                  domain={[400, 1600]}
                  ticks={[400, 800, 1200, 1600]}
                  tick={{ fontSize: 12, fill: "#6b7280" }}
                  tickLine={false}
                  axisLine={false}
                  width={44}
                />
              ) : (
                <YAxis
                  domain={[200, 800]}
                  ticks={[200, 400, 600, 800]}
                  tick={{ fontSize: 12, fill: "#6b7280" }}
                  tickLine={false}
                  axisLine={false}
                  width={44}
                />
              )}
              <Tooltip content={<ChartTooltip />} />
              <Legend
                iconType="plainline"
                wrapperStyle={{ fontSize: 12, paddingTop: 8 }}
              />
              {view === "total" ? (
                <>
                  <ReferenceLine
                    y={target}
                    stroke="#6b7280"
                    strokeDasharray="8 6"
                    label={{
                      value: `Target ${target}`,
                      position: "insideTopRight",
                      fontSize: 11,
                      fill: "#6b7280",
                    }}
                  />
                  <Line
                    type="monotone"
                    dataKey="total"
                    name="Total score"
                    stroke="#0d47a1"
                    strokeWidth={3}
                    dot={{ r: 4, fill: "#0d47a1" }}
                    activeDot={{ r: 6 }}
                    connectNulls
                  />
                </>
              ) : (
                <>
                  <Line
                    type="monotone"
                    dataKey="math"
                    name="Math"
                    stroke="#16a34a"
                    strokeWidth={2.5}
                    dot={{ r: 3 }}
                    connectNulls
                  />
                  <Line
                    type="monotone"
                    dataKey="rw"
                    name="Reading & Writing"
                    stroke="#d97706"
                    strokeWidth={2.5}
                    dot={{ r: 3 }}
                    connectNulls
                  />
                </>
              )}
            </LineChart>
          </ResponsiveContainer>
        </CardContent>
      </Card>
    </>
  );
}

/* ------------------------- Practice analytics ------------------------ */

function AccuracyByTopic({ rows }: { rows: PracticeRow[] }) {
  const topics = useMemo(() => {
    const map = new Map<string, { correct: number; total: number }>();
    for (const r of rows) {
      const key = r.domain || "other";
      const cur = map.get(key) || { correct: 0, total: 0 };
      cur.total += 1;
      if (r.is_correct) cur.correct += 1;
      map.set(key, cur);
    }
    return Array.from(map.entries())
      .map(([domain, s]) => ({
        label: labelFor(domain),
        pct: Math.round((s.correct / s.total) * 100),
        total: s.total,
      }))
      .sort((a, b) => a.pct - b.pct); // weakest first
  }, [rows]);

  const barColor = (pct: number) =>
    pct >= 70 ? "#16a34a" : pct >= 40 ? "#d97706" : "#dc2626";

  return (
    <Card className="rounded-sm">
      <CardContent className="p-5">
        <h3 className="text-base font-bold mb-4 flex items-center gap-2">
          Accuracy by topic
          <span className="flex-1" />
          <span className="text-xs font-normal text-muted-foreground">
            weakest first
          </span>
        </h3>
        {topics.length === 0 ? (
          <p className="text-sm text-muted-foreground py-6 text-center">
            No practice attempts in this range yet.
          </p>
        ) : (
          <div className="space-y-3">
            {topics.map((t) => (
              <div
                key={t.label}
                className="grid grid-cols-[120px_1fr_40px] gap-3 items-center text-sm"
              >
                <span className="truncate" title={t.label}>
                  {t.label}
                </span>
                <div className="h-3.5 rounded-full bg-muted overflow-hidden">
                  <div
                    className="h-full rounded-full"
                    style={{
                      width: `${t.pct}%`,
                      backgroundColor: barColor(t.pct),
                    }}
                  />
                </div>
                <span className="text-right text-muted-foreground">
                  {t.pct}%
                </span>
              </div>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  );
}

function QuestionsDonut({ rows }: { rows: PracticeRow[] }) {
  const total = rows.length;
  const correct = rows.filter((r) => r.is_correct).length;
  const incorrect = total - correct;
  const pct = total ? Math.round((correct / total) * 100) : 0;
  // stroke-dasharray on a 100-circumference circle (r ≈ 15.9155).
  const dash = `${pct} ${100 - pct}`;

  return (
    <Card className="rounded-sm">
      <CardContent className="p-5">
        <h3 className="text-base font-bold mb-4">Questions attempted</h3>
        {total === 0 ? (
          <p className="text-sm text-muted-foreground py-6 text-center">
            No practice attempts in this range yet.
          </p>
        ) : (
          <div className="flex items-center gap-6">
            <svg viewBox="0 0 42 42" className="w-32 h-32 flex-none">
              <circle
                cx="21"
                cy="21"
                r="15.9155"
                fill="none"
                stroke="#ececef"
                strokeWidth="5"
              />
              <circle
                cx="21"
                cy="21"
                r="15.9155"
                fill="none"
                stroke="#0d47a1"
                strokeWidth="5"
                strokeDasharray={dash}
                strokeDashoffset="25"
                strokeLinecap="round"
              />
              <text
                x="21"
                y="20"
                textAnchor="middle"
                style={{ fontSize: 7, fontWeight: 700, fill: "#1a1a22" }}
              >
                {total.toLocaleString()}
              </text>
              <text
                x="21"
                y="27"
                textAnchor="middle"
                style={{ fontSize: 3.4, fill: "#6b6b76" }}
              >
                attempted
              </text>
            </svg>
            <div className="flex flex-col gap-3 text-sm">
              <div className="flex items-center gap-2.5">
                <span className="w-3.5 h-3.5 rounded bg-[#0d47a1]" />
                Correct — {pct}% ({correct})
              </div>
              <div className="flex items-center gap-2.5">
                <span className="w-3.5 h-3.5 rounded bg-muted border" />
                Incorrect — {100 - pct}% ({incorrect})
              </div>
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );
}

function ActivityHeatmap({ rows }: { rows: PracticeRow[] }) {
  // Last 28 days (4 weeks) of practice counts, oldest → newest.
  const { cells, activeDays } = useMemo(() => {
    const counts = new Map<string, number>();
    for (const r of rows) {
      const key = new Date(r.created_at).toISOString().slice(0, 10);
      counts.set(key, (counts.get(key) || 0) + 1);
    }
    const today = new Date();
    const out: { key: string; n: number }[] = [];
    for (let i = 27; i >= 0; i--) {
      const d = new Date(today);
      d.setDate(today.getDate() - i);
      const key = d.toISOString().slice(0, 10);
      out.push({ key, n: counts.get(key) || 0 });
    }
    return { cells: out, activeDays: out.filter((c) => c.n > 0).length };
  }, [rows]);

  const level = (n: number) =>
    n === 0
      ? "bg-muted"
      : n < 3
      ? "bg-[#0d47a1]/30"
      : n < 6
      ? "bg-[#0d47a1]/60"
      : "bg-[#0d47a1]";

  return (
    <Card className="rounded-sm">
      <CardContent className="p-5">
        <h3 className="text-base font-bold mb-4 flex items-center gap-2">
          Practice activity
          <span className="flex-1" />
          <span className="text-xs font-normal text-muted-foreground">
            last 4 weeks
          </span>
        </h3>
        <div className="grid grid-cols-[repeat(14,1fr)] gap-1.5">
          {cells.map((c) => (
            <span
              key={c.key}
              title={`${c.key}: ${c.n} question${c.n === 1 ? "" : "s"}`}
              className={`aspect-square rounded ${level(c.n)}`}
            />
          ))}
        </div>
        <div className="flex justify-between text-xs text-muted-foreground mt-2.5">
          <span>Less</span>
          <span>{activeDays} active days</span>
          <span>More</span>
        </div>
      </CardContent>
    </Card>
  );
}

/* ------------------------------- Root -------------------------------- */

export default function ProgressClient({
  scorePoints,
  target,
  practiceRows,
}: {
  scorePoints: ScorePoint[];
  target: number;
  practiceRows: PracticeRow[];
}) {
  const [range, setRange] = useState<"30d" | "all">("all");

  const rangedRows = useMemo(() => {
    if (range === "all") return practiceRows;
    const cutoff = Date.now() - 30 * 24 * 60 * 60 * 1000;
    return practiceRows.filter(
      (r) => new Date(r.created_at).getTime() >= cutoff
    );
  }, [practiceRows, range]);

  return (
    <>
      <ScoreHistory scorePoints={scorePoints} target={target} />

      <SectionHead title="Practice analytics">
        <Segmented
          value={range}
          onChange={setRange}
          options={[
            { value: "30d", label: "Last 30 days" },
            { value: "all", label: "All time" },
          ]}
        />
      </SectionHead>
      <div className="grid grid-cols-1 lg:grid-cols-[1.1fr_1fr] gap-4 items-start">
        <AccuracyByTopic rows={rangedRows} />
        <div className="flex flex-col gap-4">
          <QuestionsDonut rows={rangedRows} />
          <ActivityHeatmap rows={practiceRows} />
        </div>
      </div>
    </>
  );
}

"use client";

import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from "recharts";

export interface ScoreTrendPoint {
  date: string; // formatted label, e.g. "May 17"
  total: number; // 400–1600
  math: number; // 200–800
  rw: number; // 200–800
}

interface TooltipPayloadEntry {
  name: string;
  value: number;
  color: string;
}

function CustomTooltip({
  active,
  payload,
  label,
}: {
  active?: boolean;
  payload?: TooltipPayloadEntry[];
  label?: string;
}) {
  if (!active || !payload?.length) return null;
  return (
    <div className="rounded-sm border bg-white px-3 py-2 shadow-sm text-xs">
      <p className="font-medium text-foreground mb-1">{label}</p>
      {payload.map((entry) => (
        <p key={entry.name} style={{ color: entry.color }}>
          {entry.name}: <span className="font-semibold">{entry.value}</span>
        </p>
      ))}
    </div>
  );
}

export default function ScoreTrendChart({ data }: { data: ScoreTrendPoint[] }) {
  return (
    <ResponsiveContainer width="100%" height={260}>
      <LineChart data={data} margin={{ top: 8, right: 12, left: -8, bottom: 0 }}>
        <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" vertical={false} />
        <XAxis
          dataKey="date"
          tick={{ fontSize: 12, fill: "#6b7280" }}
          tickLine={false}
          axisLine={{ stroke: "#e5e7eb" }}
        />
        <YAxis
          yAxisId="total"
          domain={[400, 1600]}
          ticks={[400, 800, 1200, 1600]}
          tick={{ fontSize: 12, fill: "#6b7280" }}
          tickLine={false}
          axisLine={false}
          width={44}
        />
        <YAxis yAxisId="section" domain={[200, 800]} hide />
        <Tooltip content={<CustomTooltip />} />
        <Legend
          iconType="plainline"
          wrapperStyle={{ fontSize: 12, paddingTop: 8 }}
        />
        <Line
          yAxisId="total"
          type="monotone"
          dataKey="total"
          name="Total"
          stroke="#0d47a1"
          strokeWidth={2.5}
          dot={{ r: 3, fill: "#0d47a1" }}
          activeDot={{ r: 5 }}
        />
        <Line
          yAxisId="section"
          type="monotone"
          dataKey="math"
          name="Math"
          stroke="#16a34a"
          strokeWidth={1.5}
          dot={{ r: 2 }}
          strokeDasharray="4 3"
        />
        <Line
          yAxisId="section"
          type="monotone"
          dataKey="rw"
          name="R&W"
          stroke="#d97706"
          strokeWidth={1.5}
          dot={{ r: 2 }}
          strokeDasharray="4 3"
        />
      </LineChart>
    </ResponsiveContainer>
  );
}

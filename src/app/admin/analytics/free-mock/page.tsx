"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import { AdminOnly } from "@/design-system/components/form-components/RoleGuard";
import {
  Card,
  CardContent,
} from "@/design-system/components/ui/card";
import { Button } from "@/design-system/components/ui/button";
import { Badge } from "@/design-system/components/ui/badge";
import { Breadcrumb } from "@/design-system/components/breadcrumb";
import { Users, Ticket, PlayCircle, CheckCircle, Download } from "lucide-react";

type FunnelState = "signed_up_only" | "claimed" | "started" | "completed";

interface FunnelRow {
  user_id: string;
  email: string | null;
  first_name: string | null;
  last_name: string | null;
  role: string | null;
  signed_up_at: string;
  claimed_at: string | null;
  token_used_at: string | null;
  free_tokens_granted: number | null;
  first_started_at: string | null;
  attempts_count: number | null;
  first_completed_at: string | null;
  best_total_estimated_score: number | null;
  funnel_state: FunnelState;
}

interface Summary {
  totalSignedUp: number;
  totalClaimed: number;
  totalStarted: number;
  totalCompleted: number;
  claimRatePct: number;
  startRatePct: number;
  completionRatePct: number;
  rangeFrom: string;
  rangeTo: string;
}

const STATE_BADGE: Record<FunnelState, { label: string; className: string }> = {
  signed_up_only: { label: "Signed up", className: "bg-slate-200 text-slate-800" },
  claimed: { label: "Claimed", className: "bg-blue-100 text-blue-800" },
  started: { label: "Started", className: "bg-amber-100 text-amber-900" },
  completed: { label: "Completed", className: "bg-green-100 text-green-800" },
};

function toLocalDateInput(d: Date) {
  const tzOffset = d.getTimezoneOffset() * 60_000;
  return new Date(d.getTime() - tzOffset).toISOString().slice(0, 10);
}

function formatTs(ts: string | null) {
  if (!ts) return "—";
  return new Date(ts).toLocaleString();
}

function downloadCsv(filename: string, rows: FunnelRow[]) {
  const header = [
    "user_id", "email", "first_name", "last_name", "role",
    "signed_up_at", "claimed_at", "token_used_at", "free_tokens_granted",
    "first_started_at", "attempts_count", "first_completed_at",
    "best_total_estimated_score", "funnel_state",
  ];
  const escape = (v: unknown) => {
    if (v === null || v === undefined) return "";
    const s = String(v);
    return /[",\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s;
  };
  const csv = [
    header.join(","),
    ...rows.map((r) => header.map((h) => escape(r[h as keyof FunnelRow])).join(",")),
  ].join("\n");
  const blob = new Blob([csv], { type: "text/csv;charset=utf-8" });
  const a = document.createElement("a");
  a.href = URL.createObjectURL(blob);
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  a.remove();
  URL.revokeObjectURL(a.href);
}

export default function FreeMockFunnelPage() {
  const today = useMemo(() => new Date(), []);
  const thirtyDaysAgo = useMemo(() => {
    const d = new Date(today);
    d.setDate(d.getDate() - 30);
    return d;
  }, [today]);

  const [from, setFrom] = useState<string>(toLocalDateInput(thirtyDaysAgo));
  const [to, setTo] = useState<string>(toLocalDateInput(today));
  const [stateFilter, setStateFilter] = useState<FunnelState | "all">("all");
  const [rows, setRows] = useState<FunnelRow[]>([]);
  const [summary, setSummary] = useState<Summary | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchData = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const fromIso = new Date(`${from}T00:00:00`).toISOString();
      const toIso = new Date(`${to}T23:59:59`).toISOString();
      const res = await fetch(
        `/api/admin/analytics/free-mock-funnel?from=${encodeURIComponent(fromIso)}&to=${encodeURIComponent(toIso)}&limit=2000`,
        { cache: "no-store" }
      );
      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        throw new Error(body.error || `HTTP ${res.status}`);
      }
      const json = await res.json();
      setRows(json.rows ?? []);
      setSummary(json.summary ?? null);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Unknown error");
    } finally {
      setLoading(false);
    }
  }, [from, to]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  const filteredRows = useMemo(() => {
    if (stateFilter === "all") return rows;
    return rows.filter((r) => r.funnel_state === stateFilter);
  }, [rows, stateFilter]);

  return (
    <AdminOnly>
      <div className="min-h-screen bg-background">
        <div className="container mx-auto px-4 py-8">
          <div className="mb-6">
            <Breadcrumb
              items={[
                { label: "Home", href: "/" },
                { label: "Admin", href: "/admin/site-administration" },
                { label: "Free Mock Funnel", isActive: true },
              ]}
            />
          </div>

          <div className="mb-8">
            <div className="flex items-center justify-between mb-4">
              <div>
                <h1 className="text-3xl font-bold text-foreground">SAT Free-Mock Funnel</h1>
                <p className="text-muted-foreground mt-2">
                  New signups and how far they progress through the free SAT mock.
                </p>
              </div>
              <Badge variant="secondary" className="text-sm">Admin Dashboard</Badge>
            </div>

            <div className="flex flex-wrap gap-3 items-end">
              <div>
                <label className="block text-xs text-muted-foreground mb-1">From</label>
                <input
                  type="date"
                  value={from}
                  onChange={(e) => setFrom(e.target.value)}
                  className="border rounded-sm px-3 py-2 bg-background"
                />
              </div>
              <div>
                <label className="block text-xs text-muted-foreground mb-1">To</label>
                <input
                  type="date"
                  value={to}
                  onChange={(e) => setTo(e.target.value)}
                  className="border rounded-sm px-3 py-2 bg-background"
                />
              </div>
              <div>
                <label className="block text-xs text-muted-foreground mb-1">Funnel state</label>
                <select
                  value={stateFilter}
                  onChange={(e) => setStateFilter(e.target.value as FunnelState | "all")}
                  className="border rounded-sm px-3 py-2 bg-background"
                >
                  <option value="all">All</option>
                  <option value="signed_up_only">Signed up only</option>
                  <option value="claimed">Claimed</option>
                  <option value="started">Started</option>
                  <option value="completed">Completed</option>
                </select>
              </div>
              <Button onClick={fetchData} className="rounded-sm" disabled={loading}>
                {loading ? "Loading…" : "Refresh"}
              </Button>
              <Button
                variant="outline"
                onClick={() => downloadCsv(`sat-free-mock-funnel_${from}_to_${to}.csv`, filteredRows)}
                className="rounded-sm"
                disabled={!filteredRows.length}
              >
                <Download className="w-4 h-4 mr-2" /> CSV
              </Button>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
            <MetricCard
              icon={<Users className="w-10 h-10 text-orange-600" />}
              label="Signed up"
              value={summary?.totalSignedUp ?? 0}
            />
            <MetricCard
              icon={<Ticket className="w-10 h-10 text-blue-600" />}
              label="Claimed free mock"
              value={summary?.totalClaimed ?? 0}
              sub={summary ? `${summary.claimRatePct}% of signups` : undefined}
            />
            <MetricCard
              icon={<PlayCircle className="w-10 h-10 text-amber-600" />}
              label="Started mock"
              value={summary?.totalStarted ?? 0}
              sub={summary ? `${summary.startRatePct}% of signups` : undefined}
            />
            <MetricCard
              icon={<CheckCircle className="w-10 h-10 text-green-600" />}
              label="Completed mock"
              value={summary?.totalCompleted ?? 0}
              sub={summary ? `${summary.completionRatePct}% of signups` : undefined}
            />
          </div>

          <Card className="rounded-sm">
            <CardContent className="p-0">
              {error ? (
                <div className="p-6 text-red-600 text-sm">Error: {error}</div>
              ) : (
                <div className="overflow-x-auto">
                  <table className="w-full text-sm">
                    <thead className="bg-muted/50 text-left">
                      <tr>
                        <th className="px-4 py-3 font-medium">Email</th>
                        <th className="px-4 py-3 font-medium">Name</th>
                        <th className="px-4 py-3 font-medium">Signed up</th>
                        <th className="px-4 py-3 font-medium">Claimed</th>
                        <th className="px-4 py-3 font-medium">Started</th>
                        <th className="px-4 py-3 font-medium">Completed</th>
                        <th className="px-4 py-3 font-medium">Best score</th>
                        <th className="px-4 py-3 font-medium">State</th>
                      </tr>
                    </thead>
                    <tbody>
                      {filteredRows.length === 0 && !loading ? (
                        <tr>
                          <td colSpan={8} className="px-4 py-8 text-center text-muted-foreground">
                            No signups in this range.
                          </td>
                        </tr>
                      ) : null}
                      {filteredRows.map((r) => {
                        const badge = STATE_BADGE[r.funnel_state];
                        const fullName = [r.first_name, r.last_name].filter(Boolean).join(" ") || "—";
                        return (
                          <tr key={r.user_id} className="border-t">
                            <td className="px-4 py-3 font-mono text-xs">{r.email ?? "—"}</td>
                            <td className="px-4 py-3">{fullName}</td>
                            <td className="px-4 py-3 whitespace-nowrap">{formatTs(r.signed_up_at)}</td>
                            <td className="px-4 py-3 whitespace-nowrap">{formatTs(r.claimed_at)}</td>
                            <td className="px-4 py-3 whitespace-nowrap">{formatTs(r.first_started_at)}</td>
                            <td className="px-4 py-3 whitespace-nowrap">{formatTs(r.first_completed_at)}</td>
                            <td className="px-4 py-3">{r.best_total_estimated_score ?? "—"}</td>
                            <td className="px-4 py-3">
                              <span className={`px-2 py-1 rounded-sm text-xs font-medium ${badge.className}`}>
                                {badge.label}
                              </span>
                            </td>
                          </tr>
                        );
                      })}
                    </tbody>
                  </table>
                </div>
              )}
            </CardContent>
          </Card>

          <p className="text-xs text-muted-foreground mt-4">
            Funnel data is derived from <code>vw_sat_free_mock_funnel</code> on the live database. One row per profile.
          </p>
        </div>
      </div>
    </AdminOnly>
  );
}

function MetricCard({ icon, label, value, sub }: { icon: React.ReactNode; label: string; value: number; sub?: string }) {
  return (
    <Card className="rounded-sm">
      <CardContent className="p-6">
        <div className="flex items-center justify-between">
          <div>
            <p className="text-sm text-muted-foreground">{label}</p>
            <p className="text-3xl font-bold mt-1">{value.toLocaleString()}</p>
            {sub ? <p className="text-xs text-muted-foreground mt-1">{sub}</p> : null}
          </div>
          {icon}
        </div>
      </CardContent>
    </Card>
  );
}

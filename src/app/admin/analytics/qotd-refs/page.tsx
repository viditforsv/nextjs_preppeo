"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import { AdminOnly } from "@/design-system/components/form-components/RoleGuard";
import { Card, CardContent } from "@/design-system/components/ui/card";
import { Button } from "@/design-system/components/ui/button";
import { Badge } from "@/design-system/components/ui/badge";
import { Breadcrumb } from "@/design-system/components/breadcrumb";
import { Users, Link2, MousePointerClick, Download } from "lucide-react";

interface RefRow {
  ref: string;
  signups: number;
  captures: number;
}

interface Summary {
  totalUniqueSignups: number;
  totalCaptures: number;
  refCount: number;
}

function toLocalDateInput(d: Date) {
  const tzOffset = d.getTimezoneOffset() * 60_000;
  return new Date(d.getTime() - tzOffset).toISOString().slice(0, 10);
}

function downloadCsv(filename: string, rows: RefRow[]) {
  const header = ["ref", "signups", "captures"];
  const escape = (v: unknown) => {
    if (v === null || v === undefined) return "";
    const s = String(v);
    return /[",\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s;
  };
  const csv = [
    header.join(","),
    ...rows.map((r) => header.map((h) => escape(r[h as keyof RefRow])).join(",")),
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

export default function QotdRefsPage() {
  const today = useMemo(() => new Date(), []);
  const thirtyDaysAgo = useMemo(() => {
    const d = new Date(today);
    d.setDate(d.getDate() - 30);
    return d;
  }, [today]);

  const [from, setFrom] = useState<string>(toLocalDateInput(thirtyDaysAgo));
  const [to, setTo] = useState<string>(toLocalDateInput(today));
  const [rows, setRows] = useState<RefRow[]>([]);
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
        `/api/admin/analytics/qotd-refs?from=${encodeURIComponent(fromIso)}&to=${encodeURIComponent(toIso)}`,
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

  return (
    <AdminOnly>
      <div className="min-h-screen bg-background">
        <div className="container mx-auto px-4 py-8">
          <div className="mb-6">
            <Breadcrumb
              items={[
                { label: "Home", href: "/" },
                { label: "Admin", href: "/admin/site-administration" },
                { label: "QOTD Referrals", isActive: true },
              ]}
            />
          </div>

          <div className="mb-8">
            <div className="flex items-center justify-between mb-4">
              <div>
                <h1 className="text-3xl font-bold text-foreground">QOTD Referral Signups</h1>
                <p className="text-muted-foreground mt-2">
                  Email signups on the Question of the Day, grouped by referral link
                  (e.g. <code>preppeo.com/qotd?ref=va</code>). <strong>Signups</strong> counts
                  distinct emails — the number to pay bonuses on.
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
              <Button onClick={fetchData} className="rounded-sm" disabled={loading}>
                {loading ? "Loading…" : "Refresh"}
              </Button>
              <Button
                variant="outline"
                onClick={() => downloadCsv(`qotd-refs_${from}_to_${to}.csv`, rows)}
                className="rounded-sm"
                disabled={!rows.length}
              >
                <Download className="w-4 h-4 mr-2" /> CSV
              </Button>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
            <MetricCard
              icon={<Users className="w-10 h-10 text-orange-600" />}
              label="Unique signups"
              value={summary?.totalUniqueSignups ?? 0}
            />
            <MetricCard
              icon={<MousePointerClick className="w-10 h-10 text-blue-600" />}
              label="Total captures"
              value={summary?.totalCaptures ?? 0}
              sub="includes repeat-day unlocks"
            />
            <MetricCard
              icon={<Link2 className="w-10 h-10 text-green-600" />}
              label="Active referrers"
              value={summary?.refCount ?? 0}
              sub="distinct ref values"
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
                        <th className="px-4 py-3 font-medium">Referrer (ref)</th>
                        <th className="px-4 py-3 font-medium">Signups (unique emails)</th>
                        <th className="px-4 py-3 font-medium">Total captures</th>
                      </tr>
                    </thead>
                    <tbody>
                      {rows.length === 0 && !loading ? (
                        <tr>
                          <td colSpan={3} className="px-4 py-8 text-center text-muted-foreground">
                            No signups in this range.
                          </td>
                        </tr>
                      ) : null}
                      {rows.map((r) => (
                        <tr key={r.ref} className="border-t">
                          <td className="px-4 py-3 font-mono text-xs">{r.ref}</td>
                          <td className="px-4 py-3 font-semibold">{r.signups.toLocaleString()}</td>
                          <td className="px-4 py-3">{r.captures.toLocaleString()}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </CardContent>
          </Card>

          <p className="text-xs text-muted-foreground mt-4">
            Attribution is per-capture: each unlock stores the <code>ref</code> from its visit&apos;s
            URL. Share links as <code>preppeo.com/qotd?ref=&lt;name&gt;</code> — the param survives the
            redirect to <code>/question-of-the-day</code>. Captures with no ref show as <code>(direct)</code>.
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

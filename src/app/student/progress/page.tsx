import { redirect } from "next/navigation";
import Link from "next/link";
import { createClient } from "@/lib/supabase/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";
import { Card, CardContent } from "@/design-system/components/ui/card";
import { Breadcrumb } from "@/design-system/components/breadcrumb";
import { TrendingUp, TrendingDown, Minus, ArrowRight } from "lucide-react";
import ProgressClient, {
  type ScorePoint,
  type PracticeRow,
} from "./ProgressClient";

// Authed, cookie-based data fetching → this page is always dynamic.
export const dynamic = "force-dynamic";

// No per-user goal is stored yet, so we anchor progress to a sensible default.
// Bump to a perfect score once a student is already at/above the default.
const DEFAULT_TARGET = 1500;
// Visual scale for the "progress to target" bar.
const BAR_MIN = 1000;
const BAR_MAX = 1600;

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

const formatDate = (d: string) =>
  new Date(d).toLocaleDateString("en-US", { month: "short", day: "numeric" });

const clampPct = (v: number) => Math.max(0, Math.min(100, v));

interface SATAttempt {
  section_type: string;
  estimated_score: number | null;
  rw_estimated_score: number | null;
  total_estimated_score: number | null;
  completed_at: string;
}

export default async function ProgressReportPage() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/auth?redirect=/student/progress");
  }

  const { data: profile } = await supabase
    .from("profiles")
    .select("first_name, role")
    .eq("id", user.id)
    .single();

  if (profile?.role !== "student" && profile?.role !== "admin") {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-red-600 mb-4">Access Denied</h1>
          <p className="text-muted-foreground">
            You need student privileges to access this page.
          </p>
        </div>
      </div>
    );
  }

  const serviceClient = createSupabaseApiClient();
  const [{ data: satData }, { data: practiceData }] = await Promise.all([
    serviceClient
      .from("sat_test_attempts")
      .select(
        "section_type, estimated_score, rw_estimated_score, total_estimated_score, completed_at"
      )
      .eq("user_id", user.id)
      .not("completed_at", "is", null)
      .order("completed_at", { ascending: false }),
    serviceClient
      .from("practice_answers")
      .select("is_correct, domain, created_at")
      .eq("user_id", user.id)
      .order("created_at", { ascending: false }),
  ]);

  const attempts = (satData as SATAttempt[] | null) || [];
  const practiceRows = (practiceData as PracticeRow[] | null) || [];

  // Headline /1600 numbers come from full mocks only.
  const fullAttempts = attempts.filter(
    (a) => a.section_type === "full" && a.total_estimated_score != null
  );
  const latest = fullAttempts[0];
  const first = fullAttempts[fullAttempts.length - 1];
  const latestTotal = latest?.total_estimated_score ?? 0;
  const firstTotal = first?.total_estimated_score ?? 0;
  const bestScore = fullAttempts.reduce(
    (m, a) => Math.max(m, a.total_estimated_score ?? 0),
    0
  );
  const delta =
    latest && first && fullAttempts.length > 1 ? latestTotal - firstTotal : null;
  const mocksTaken = fullAttempts.length;
  const target = latestTotal >= DEFAULT_TARGET ? 1600 : DEFAULT_TARGET;

  // Oldest → newest for the trend.
  const scorePoints: ScorePoint[] = [...fullAttempts].reverse().map((a) => ({
    date: formatDate(a.completed_at),
    total: a.total_estimated_score,
    math: a.estimated_score,
    rw: a.rw_estimated_score,
  }));

  // Practice accuracy (all time).
  const practiceTotal = practiceRows.length;
  const practiceCorrect = practiceRows.filter((r) => r.is_correct).length;
  const practiceAccuracy = practiceTotal
    ? Math.round((practiceCorrect / practiceTotal) * 100)
    : null;

  // Current streak: consecutive days with ≥1 practice answer, ending today/yesterday.
  const activeDays = new Set(
    practiceRows.map((r) => new Date(r.created_at).toISOString().slice(0, 10))
  );
  let streak = 0;
  const cursor = new Date();
  const todayKey = cursor.toISOString().slice(0, 10);
  if (!activeDays.has(todayKey)) cursor.setDate(cursor.getDate() - 1);
  while (activeDays.has(cursor.toISOString().slice(0, 10))) {
    streak += 1;
    cursor.setDate(cursor.getDate() - 1);
  }

  // Weakest two topics (all time) for the coaching CTA.
  const topicAgg = new Map<string, { correct: number; total: number }>();
  for (const r of practiceRows) {
    const key = r.domain || "other";
    const cur = topicAgg.get(key) || { correct: 0, total: 0 };
    cur.total += 1;
    if (r.is_correct) cur.correct += 1;
    topicAgg.set(key, cur);
  }
  const weakest = Array.from(topicAgg.entries())
    .map(([domain, s]) => ({ label: labelFor(domain), pct: s.correct / s.total }))
    .sort((a, b) => a.pct - b.pct)
    .slice(0, 2)
    .map((t) => t.label);

  const gaugePct = clampPct((latestTotal / 1600) * 100);
  const barFill = clampPct(((latestTotal - BAR_MIN) / (BAR_MAX - BAR_MIN)) * 100);
  const barTarget = clampPct(((target - BAR_MIN) / (BAR_MAX - BAR_MIN)) * 100);

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8 max-w-[1080px]">
        <div className="mb-6">
          <Breadcrumb
            items={[
              { label: "Home", href: "/" },
              { label: "Dashboard", href: "/student" },
              { label: "Progress Report", isActive: true },
            ]}
          />
        </div>

        <header className="mb-6">
          <h1 className="text-3xl font-bold mb-1.5">Your score &amp; progress</h1>
          <p className="text-muted-foreground">
            Track every mock, see where practice is moving the needle, and act
            on weak spots.
          </p>
        </header>

        {/* Top row: hero + stats */}
        <div className="grid grid-cols-1 lg:grid-cols-[1.3fr_1fr] gap-4 items-stretch">
          {/* Hero */}
          <Card className="rounded-sm">
            <CardContent className="p-6">
              {latest ? (
                <div className="flex flex-col sm:flex-row gap-6 items-center">
                  <div
                    className="w-[140px] h-[140px] flex-none rounded-full grid place-items-center"
                    style={{
                      background: `conic-gradient(#0d47a1 0 ${gaugePct}%, #ececef ${gaugePct}% 100%)`,
                    }}
                  >
                    <div className="w-[108px] h-[108px] rounded-full bg-background grid place-items-center text-center">
                      <div>
                        <div className="text-[38px] font-bold leading-none text-foreground">
                          {latestTotal}
                        </div>
                        <div className="text-xs text-muted-foreground mt-0.5">
                          / 1600 latest
                        </div>
                      </div>
                    </div>
                  </div>
                  <div className="flex-1 w-full">
                    {delta !== null ? (
                      <div
                        className={`text-2xl font-bold flex items-center gap-1.5 ${
                          delta > 0
                            ? "text-green-600"
                            : delta < 0
                            ? "text-red-600"
                            : "text-muted-foreground"
                        }`}
                      >
                        {delta > 0 ? (
                          <TrendingUp className="w-6 h-6" />
                        ) : delta < 0 ? (
                          <TrendingDown className="w-6 h-6" />
                        ) : (
                          <Minus className="w-6 h-6" />
                        )}
                        {delta > 0 ? `+${delta}` : delta}
                      </div>
                    ) : (
                      <div className="text-2xl font-bold text-muted-foreground">
                        First mock
                      </div>
                    )}
                    <p className="text-sm text-muted-foreground mt-0.5">
                      {delta !== null ? "since first mock · " : ""}
                      Best {bestScore} · First {firstTotal} · {mocksTaken} mock
                      {mocksTaken === 1 ? "" : "s"} taken
                    </p>

                    <div className="mt-4">
                      <div className="flex justify-between text-[13px] text-muted-foreground mb-1.5">
                        <span>Progress to target</span>
                        <span>
                          {latestTotal} → {target}
                        </span>
                      </div>
                      <div className="relative h-3 rounded-full bg-muted overflow-hidden">
                        <div
                          className="h-full rounded-full bg-[#0d47a1]"
                          style={{ width: `${barFill}%` }}
                        />
                        <div
                          className="absolute -top-0.5 -bottom-0.5 w-0.5 bg-foreground"
                          style={{ left: `${barTarget}%` }}
                        />
                      </div>
                      <p className="text-xs text-muted-foreground mt-1.5">
                        Marker shows your goal score.
                      </p>
                    </div>
                  </div>
                </div>
              ) : (
                <div className="text-center py-10">
                  <h2 className="text-xl font-bold mb-1">
                    No mock scores yet
                  </h2>
                  <p className="text-muted-foreground">
                    Take your first full mock to start tracking your progress.
                  </p>
                  <Link
                    href="/sat-test"
                    className="inline-flex items-center gap-1 mt-4 text-sm font-medium text-[#0d47a1] hover:underline"
                  >
                    Start a mock test <ArrowRight className="w-3.5 h-3.5" />
                  </Link>
                </div>
              )}
            </CardContent>
          </Card>

          {/* Stats */}
          <div className="grid grid-cols-2 gap-4">
            <StatCard
              label="Math (latest)"
              value={latest?.estimated_score ?? "—"}
              suffix={latest ? "/800" : undefined}
            />
            <StatCard
              label="Reading & Writing"
              value={latest?.rw_estimated_score ?? "—"}
              suffix={latest ? "/800" : undefined}
            />
            <StatCard
              label="Practice accuracy"
              value={practiceAccuracy ?? "—"}
              suffix={practiceAccuracy !== null ? "%" : undefined}
            />
            <StatCard
              label="Study streak"
              value={streak}
              suffix={streak === 1 ? "day" : "days"}
            />
          </div>
        </div>

        {/* Charts + practice analytics (client) */}
        <ProgressClient
          scorePoints={scorePoints}
          target={target}
          practiceRows={practiceRows}
        />

        {/* 1-on-1 CTA */}
        <Card className="mt-8 rounded-sm bg-muted/50 border-0">
          <CardContent className="p-6 flex flex-col sm:flex-row items-start sm:items-center gap-5">
            <div>
              <b className="text-lg">
                {weakest.length === 2
                  ? `Stuck on ${weakest[0]} and ${weakest[1]}?`
                  : "Want to target your weak spots faster?"}
              </b>
              <div className="text-sm text-muted-foreground mt-0.5">
                Book a personalised session with a coach to target your weakest
                topics.
              </div>
            </div>
            <div className="flex-1" />
            <Link href="/pricing" className="w-full sm:w-auto">
              <button className="w-full rounded-sm bg-[#0d47a1] text-white px-5 py-3 text-[15px] font-semibold hover:bg-[#0d47a1]/90 whitespace-nowrap">
                Book a 1-on-1 session →
              </button>
            </Link>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}

function StatCard({
  label,
  value,
  suffix,
}: {
  label: string;
  value: number | string;
  suffix?: string;
}) {
  return (
    <Card className="rounded-sm">
      <CardContent className="p-4 h-full flex flex-col justify-center">
        <div className="text-[13px] text-muted-foreground">{label}</div>
        <div className="text-[28px] font-bold leading-none mt-1">
          {value}
          {suffix && (
            <span className="text-[13px] font-normal text-muted-foreground ml-0.5">
              {suffix}
            </span>
          )}
        </div>
      </CardContent>
    </Card>
  );
}

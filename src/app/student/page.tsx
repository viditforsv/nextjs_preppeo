import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";
import { Button } from "@/design-system/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/design-system/components/ui/card";
import { Breadcrumb } from "@/design-system/components/breadcrumb";
import {
  TrendingUp,
  TrendingDown,
  Minus,
  ChevronRight,
  GraduationCap,
  PlayCircle,
  Dumbbell,
  Trophy,
  Target,
  ArrowRight,
} from "lucide-react";
import Link from "next/link";
import ScoreTrendChart, { type ScoreTrendPoint } from "./ScoreTrendChart";

// Authed, cookie-based data fetching → this page is always dynamic.
export const dynamic = "force-dynamic";

interface SATAttempt {
  id: string;
  section_type: string;
  set_number: number;
  estimated_score: number | null; // Math (200–800)
  rw_estimated_score: number | null; // R&W (200–800)
  total_estimated_score: number | null; // Total (400–1600)
  total_correct: number;
  total_questions: number;
  score_pct: number;
  completed_at: string;
}

const formatDate = (dateString: string) =>
  new Date(dateString).toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
  });

const formatFullDate = (dateString: string) =>
  new Date(dateString).toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
    year: "numeric",
  });

export default async function StudentDashboard() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  // Middleware already guards /student, but verify defensively.
  if (!user) {
    redirect("/auth?redirect=/student");
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
          <h1 className="text-2xl font-bold text-red-600 mb-4">
            Access Denied
          </h1>
          <p className="text-muted-foreground">
            You need student privileges to access this page.
          </p>
        </div>
      </div>
    );
  }

  // Fetch the dashboard's data on the server, in parallel. SAT attempts come
  // from a separate table behind the service client, so both fire together and
  // the page waits on the single slowest query rather than a chain of round-trips.
  const serviceClient = createSupabaseApiClient();
  const [{ count: questionsPracticed }, { data: satData }] = await Promise.all([
    supabase
      .from("student_performance_log")
      .select("id", { count: "exact", head: true })
      .eq("student_id", user.id),

    serviceClient
      .from("sat_test_attempts")
      .select(
        "id, section_type, set_number, estimated_score, rw_estimated_score, total_estimated_score, total_correct, total_questions, score_pct, completed_at"
      )
      .eq("user_id", user.id)
      .not("completed_at", "is", null)
      .order("completed_at", { ascending: false }),
  ]);

  const attempts = (satData as SATAttempt[] | null) || [];

  // Full mocks carry the headline /1600 score; math-only attempts have a null
  // total. Latest/previous/best and the trend are all derived from full mocks.
  const fullAttempts = attempts.filter(
    (a) => a.section_type === "full" && a.total_estimated_score != null
  );
  const latest = fullAttempts[0];
  const previous = fullAttempts[1];
  const delta =
    latest && previous
      ? (latest.total_estimated_score ?? 0) -
        (previous.total_estimated_score ?? 0)
      : null;
  const bestScore = fullAttempts.reduce(
    (max, a) => Math.max(max, a.total_estimated_score ?? 0),
    0
  );

  // Oldest → newest for a left-to-right trend line.
  const trend: ScoreTrendPoint[] = [...fullAttempts]
    .reverse()
    .map((a) => ({
      date: formatDate(a.completed_at),
      total: a.total_estimated_score ?? 0,
      math: a.estimated_score ?? 0,
      rw: a.rw_estimated_score ?? 0,
    }));

  const mocksCompleted = attempts.length;
  const recentAttempts = attempts.slice(0, 3);

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        {/* Breadcrumbs */}
        <div className="mb-6">
          <Breadcrumb
            items={[
              { label: "Home", href: "/" },
              { label: "Student Dashboard", isActive: true },
            ]}
          />
        </div>

        {/* Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-foreground mb-2">
            Welcome back, {profile?.first_name || "Student"}
          </h1>
          <p className="text-muted-foreground">
            Track your SAT progress and keep pushing toward your target score.
          </p>
        </div>

        {/* Hero: latest score + what's next */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
          {/* Score panel */}
          <Card className="lg:col-span-2 rounded-sm">
            <CardContent className="p-6">
              {latest ? (
                <div className="flex flex-col sm:flex-row sm:items-center gap-6">
                  <div className="flex-1">
                    <p className="text-sm text-muted-foreground mb-1">
                      Latest mock score · Set {latest.set_number} ·{" "}
                      {formatFullDate(latest.completed_at)}
                    </p>
                    <div className="flex items-end gap-3">
                      <span className="text-5xl font-bold text-[#0d47a1] leading-none">
                        {latest.total_estimated_score}
                      </span>
                      <span className="text-lg text-muted-foreground font-medium mb-1">
                        /1600
                      </span>
                      {delta !== null && (
                        <span
                          className={`mb-1.5 inline-flex items-center gap-1 text-sm font-semibold ${
                            delta > 0
                              ? "text-green-600"
                              : delta < 0
                              ? "text-red-600"
                              : "text-muted-foreground"
                          }`}
                        >
                          {delta > 0 ? (
                            <TrendingUp className="w-4 h-4" />
                          ) : delta < 0 ? (
                            <TrendingDown className="w-4 h-4" />
                          ) : (
                            <Minus className="w-4 h-4" />
                          )}
                          {delta > 0 ? `+${delta}` : delta} vs last
                        </span>
                      )}
                    </div>

                    {/* Subscores */}
                    <div className="mt-5 space-y-3 max-w-sm">
                      <ScoreBar
                        label="Math"
                        score={latest.estimated_score}
                        color="#16a34a"
                      />
                      <ScoreBar
                        label="Reading & Writing"
                        score={latest.rw_estimated_score}
                        color="#d97706"
                      />
                    </div>
                  </div>

                  <div className="sm:border-l sm:pl-6 flex sm:flex-col gap-4 sm:gap-2 sm:text-right">
                    <div>
                      <p className="text-xs text-muted-foreground">Best score</p>
                      <p className="text-xl font-bold text-foreground flex items-center sm:justify-end gap-1.5">
                        <Trophy className="w-4 h-4 text-yellow-500" />
                        {bestScore}
                      </p>
                    </div>
                    <div>
                      <p className="text-xs text-muted-foreground">
                        Mocks completed
                      </p>
                      <p className="text-xl font-bold text-foreground">
                        {mocksCompleted}
                      </p>
                    </div>
                  </div>
                </div>
              ) : (
                <div className="flex flex-col items-center text-center py-6">
                  <div className="w-14 h-14 bg-[#0d47a1]/10 rounded-sm flex items-center justify-center mb-4">
                    <GraduationCap className="w-7 h-7 text-[#0d47a1]" />
                  </div>
                  <h2 className="text-xl font-bold text-foreground mb-1">
                    Take your first SAT mock
                  </h2>
                  <p className="text-muted-foreground max-w-md">
                    Sit a full-length, timed mock to get your estimated /1600
                    score and see where to focus next.
                  </p>
                </div>
              )}
            </CardContent>
          </Card>

          {/* What's next — balanced CTAs */}
          <Card className="rounded-sm bg-[#0d47a1] text-white">
            <CardContent className="p-6 flex flex-col h-full">
              <p className="text-sm font-medium text-white/80 mb-4">
                What&apos;s next?
              </p>
              <div className="space-y-3 flex-1">
                <Link href="/sat-test" className="block">
                  <Button className="w-full rounded-sm bg-white text-[#0d47a1] hover:bg-white/90 justify-start">
                    <PlayCircle className="w-4 h-4 mr-2" />
                    {latest ? "Take another mock" : "Start a mock test"}
                  </Button>
                </Link>
                <Link href="/sat-test?mode=practice" className="block">
                  <Button
                    variant="outline"
                    className="w-full rounded-sm border-white/40 bg-transparent text-white hover:bg-white/10 hover:text-white justify-start"
                  >
                    <Dumbbell className="w-4 h-4 mr-2" />
                    Practice questions
                  </Button>
                </Link>
              </div>
              <Link
                href="/sat-test/history"
                className="mt-4 inline-flex items-center gap-1 text-sm text-white/80 hover:text-white"
              >
                View mock history
                <ArrowRight className="w-3.5 h-3.5" />
              </Link>
            </CardContent>
          </Card>
        </div>

        {/* Score trend — needs at least two full mocks to draw a line */}
        {trend.length >= 2 && (
          <Card className="mb-8 rounded-sm">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <TrendingUp className="w-5 h-5 text-[#0d47a1]" />
                Score Trend
              </CardTitle>
              <CardDescription>
                Your total score across full mocks over time
              </CardDescription>
            </CardHeader>
            <CardContent>
              <ScoreTrendChart data={trend} />
            </CardContent>
          </Card>
        )}

        {/* Recent attempts list */}
        {recentAttempts.length > 0 && (
          <Card className="mb-8 rounded-sm">
            <CardHeader>
              <div className="flex items-center justify-between">
                <CardTitle className="flex items-center gap-2">
                  <GraduationCap className="w-5 h-5 text-[#0d47a1]" />
                  Recent Mocks
                </CardTitle>
                <Link
                  href="/sat-test/history"
                  className="text-xs text-primary hover:underline font-medium"
                >
                  View all →
                </Link>
              </div>
            </CardHeader>
            <CardContent>
              <div className="space-y-2">
                {recentAttempts.map((a) => {
                  const score =
                    a.total_estimated_score ?? a.estimated_score ?? null;
                  const label =
                    a.section_type === "full"
                      ? "SAT Full Test"
                      : a.section_type === "rw"
                      ? "SAT R&W"
                      : "SAT Math";
                  const range = a.section_type === "full" ? "/1600" : "/800";
                  return (
                    <Link
                      key={a.id}
                      href={`/sat-test/history/${a.id}`}
                      className="flex items-center justify-between p-3 border rounded-sm hover:bg-primary/5 transition-colors"
                    >
                      <div className="flex items-center gap-3">
                        <div className="w-9 h-9 bg-blue-50 rounded-sm flex items-center justify-center">
                          <GraduationCap className="w-4 h-4 text-[#0d47a1]" />
                        </div>
                        <div>
                          <p className="text-sm font-medium">
                            {label} · Set {a.set_number}
                          </p>
                          <p className="text-xs text-muted-foreground">
                            {formatFullDate(a.completed_at)}
                          </p>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <div className="text-right">
                          <p className="text-lg font-bold text-[#0d47a1]">
                            {score ?? "—"}
                            <span className="text-xs text-muted-foreground font-normal">
                              {range}
                            </span>
                          </p>
                          <p className="text-xs text-muted-foreground">
                            {a.total_correct}/{a.total_questions} correct
                          </p>
                        </div>
                        <ChevronRight className="w-4 h-4 text-muted-foreground" />
                      </div>
                    </Link>
                  );
                })}
              </div>
            </CardContent>
          </Card>
        )}

        {/* Stat strip */}
        <div className="grid grid-cols-3 gap-4">
          <StatCard
            label="Mocks completed"
            value={mocksCompleted}
            icon={<GraduationCap className="w-7 h-7 text-[#0d47a1]" />}
          />
          <StatCard
            label="Best score"
            value={bestScore || "—"}
            suffix={bestScore ? "/1600" : undefined}
            icon={<Trophy className="w-7 h-7 text-yellow-500" />}
          />
          <StatCard
            label="Questions practiced"
            value={questionsPracticed ?? 0}
            icon={<Target className="w-7 h-7 text-green-600" />}
          />
        </div>
      </div>
    </div>
  );
}

function ScoreBar({
  label,
  score,
  color,
}: {
  label: string;
  score: number | null;
  color: string;
}) {
  const pct = score ? ((score - 200) / 600) * 100 : 0;
  return (
    <div>
      <div className="flex items-center justify-between text-sm mb-1">
        <span className="text-muted-foreground">{label}</span>
        <span className="font-semibold text-foreground">
          {score ?? "—"}
          <span className="text-xs text-muted-foreground font-normal">
            /800
          </span>
        </span>
      </div>
      <div className="h-1.5 w-full bg-muted rounded-full overflow-hidden">
        <div
          className="h-full rounded-full"
          style={{ width: `${pct}%`, backgroundColor: color }}
        />
      </div>
    </div>
  );
}

function StatCard({
  label,
  value,
  suffix,
  icon,
}: {
  label: string;
  value: number | string;
  suffix?: string;
  icon: React.ReactNode;
}) {
  return (
    <Card className="rounded-sm">
      <CardContent className="p-6">
        <div className="flex items-center justify-between">
          <div>
            <p className="text-sm text-muted-foreground mb-1">{label}</p>
            <p className="text-2xl font-bold text-foreground">
              {value}
              {suffix && (
                <span className="text-sm text-muted-foreground font-normal">
                  {suffix}
                </span>
              )}
            </p>
          </div>
          {icon}
        </div>
      </CardContent>
    </Card>
  );
}

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
import { Badge } from "@/design-system/components/ui/badge";
import {
  BookOpen,
  FileText,
  TrendingUp,
  Award,
  Clock,
  Target,
  CheckCircle,
  AlertCircle,
  ChevronRight,
  GraduationCap,
} from "lucide-react";
import Link from "next/link";

// Authed, cookie-based data fetching → this page is always dynamic.
export const dynamic = "force-dynamic";

interface SATAttemptSummary {
  id: string;
  section_type: string;
  set_number: number;
  estimated_score: number | null;
  rw_estimated_score: number | null;
  total_estimated_score: number | null;
  total_correct: number;
  total_questions: number;
  score_pct: number;
  completed_at: string;
}

interface DashboardStats {
  totalCourses: number;
  pendingAssignments: number;
  recentActivity: number;
  masteryCounts: {
    red: number;
    yellow: number;
    green: number;
  };
  enrollments: Array<{
    id: string;
    enrolled_at: string;
    courses: {
      id: string;
      title: string;
      slug: string;
      thumbnail_url: string;
      curriculum: string;
      subject: string;
      grade: string;
      courses_templates?: { slug?: string } | null;
    };
  }>;
  assignments: Array<{
    id: string;
    title: string;
    due_date: string;
    status: string;
    courses: {
      id: string;
      title: string;
      slug: string;
    };
  }>;
  recentProgress: Array<{
    id: string;
    created_at: string;
    is_correct: boolean;
    time_taken_seconds: number;
    question_bank: {
      question_text: string;
      total_marks: number;
    };
  }>;
}

const formatDate = (dateString: string) =>
  new Date(dateString).toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
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

  // Fetch everything the dashboard needs on the server, in parallel. The
  // four dashboard datasets are independent, and SAT attempts come from a
  // separate table — all fire together so the page waits on the single
  // slowest query rather than a chain of client round-trips.
  const serviceClient = createSupabaseApiClient();
  const [
    { data: enrollments },
    { data: assignments },
    { data: recentProgress },
    { data: tagMastery },
    { data: satData },
  ] = await Promise.all([
    supabase
      .from("courses_enrollments")
      .select(
        `
        id,
        enrolled_at,
        is_active,
        courses!courses_enrollments_course_id_fkey (
          id,
          title,
          slug,
          thumbnail_url,
          curriculum,
          subject,
          grade,
          status,
          courses_templates (slug)
        )
      `
      )
      .eq("student_id", user.id)
      .eq("is_active", true)
      .order("enrolled_at", { ascending: false }),

    supabase
      .from("assignments")
      .select(
        `
        id,
        title,
        description,
        due_date,
        status,
        graded_at,
        grade,
        courses!assignments_course_id_fkey (
          id,
          title,
          slug
        )
      `
      )
      .eq("student_id", user.id)
      .is("graded_at", null)
      .order("due_date", { ascending: true }),

    supabase
      .from("student_performance_log")
      .select(
        `
        id,
        created_at,
        is_correct,
        time_taken_seconds,
        question_bank!student_performance_log_question_id_fkey (
          question_text,
          total_marks
        )
      `
      )
      .eq("student_id", user.id)
      .order("created_at", { ascending: false })
      .limit(5),

    supabase
      .from("student_tag_mastery")
      .select("mastery_level")
      .eq("student_id", user.id),

    serviceClient
      .from("sat_test_attempts")
      .select(
        "id, section_type, set_number, estimated_score, rw_estimated_score, total_estimated_score, total_correct, total_questions, score_pct, completed_at"
      )
      .eq("user_id", user.id)
      .order("completed_at", { ascending: false }),
  ]);

  const masteryCounts = {
    red: tagMastery?.filter((m) => m.mastery_level === "red").length || 0,
    yellow: tagMastery?.filter((m) => m.mastery_level === "yellow").length || 0,
    green: tagMastery?.filter((m) => m.mastery_level === "green").length || 0,
  };

  const stats: DashboardStats = {
    totalCourses: enrollments?.length || 0,
    pendingAssignments: assignments?.length || 0,
    recentActivity: recentProgress?.length || 0,
    masteryCounts,
    // Supabase types embedded relations as arrays, but these are to-one FKs
    // that return a single object at runtime — exactly what the render expects.
    enrollments:
      (enrollments as unknown as DashboardStats["enrollments"]) || [],
    assignments:
      (assignments as unknown as DashboardStats["assignments"]) || [],
    recentProgress:
      (recentProgress as unknown as DashboardStats["recentProgress"]) || [],
  };

  const satAttempts: SATAttemptSummary[] = (
    (satData as SATAttemptSummary[]) || []
  ).slice(0, 3);

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
            Student Dashboard
          </h1>
          <p className="text-muted-foreground">
            Welcome back, {profile?.first_name || "Student"}. Continue your
            learning journey.
          </p>
        </div>

        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
          <Card className="rounded-sm">
            <CardContent className="p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-muted-foreground mb-1">
                    My Courses
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {stats.totalCourses}
                  </p>
                </div>
                <BookOpen className="w-8 h-8 text-primary" />
              </div>
            </CardContent>
          </Card>

          <Card className="rounded-sm">
            <CardContent className="p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-muted-foreground mb-1">
                    Pending Assignments
                  </p>
                  <p className="text-2xl font-bold text-blue-600">
                    {stats.pendingAssignments}
                  </p>
                </div>
                <FileText className="w-8 h-8 text-blue-600" />
              </div>
            </CardContent>
          </Card>

          <Card className="rounded-sm">
            <CardContent className="p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-muted-foreground mb-1">
                    Concepts Mastered
                  </p>
                  <p className="text-2xl font-bold text-green-600">
                    {stats.masteryCounts.green}
                  </p>
                </div>
                <Award className="w-8 h-8 text-green-600" />
              </div>
            </CardContent>
          </Card>

          <Card className="rounded-sm">
            <CardContent className="p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-muted-foreground mb-1">
                    Recent Activity
                  </p>
                  <p className="text-2xl font-bold text-orange-600">
                    {stats.recentActivity}
                  </p>
                </div>
                <TrendingUp className="w-8 h-8 text-orange-600" />
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Mock Score History */}
        {satAttempts.length > 0 && (
          <Card className="mb-8 rounded-sm">
            <CardHeader>
              <div className="flex items-center justify-between">
                <CardTitle className="flex items-center gap-2">
                  <TrendingUp className="w-5 h-5 text-primary" />
                  Recent Mock Scores
                </CardTitle>
                <Link href="/sat-test/history" className="text-xs text-primary hover:underline font-medium">
                  SAT History →
                </Link>
              </div>
              <CardDescription>Your most recent mock test results</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-2">
                {satAttempts.map((a) => {
                  const score = a.total_estimated_score ?? a.estimated_score ?? null;
                  const label = a.section_type === 'full' ? 'SAT Full Test' : a.section_type === 'rw' ? 'SAT R&W' : 'SAT Math';
                  const range = a.section_type === 'full' ? '/1600' : '/800';
                  const date = new Date(a.completed_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
                  return (
                    <Link key={a.id} href={`/sat-test/history/${a.id}`} className="flex items-center justify-between p-3 border rounded-sm hover:bg-primary/5 transition-colors">
                      <div className="flex items-center gap-3">
                        <div className="w-9 h-9 bg-blue-50 rounded-sm flex items-center justify-center">
                          <GraduationCap className="w-4 h-4 text-[#0d47a1]" />
                        </div>
                        <div>
                          <p className="text-sm font-medium">{label} · Set {a.set_number}</p>
                          <p className="text-xs text-muted-foreground">{date}</p>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <div className="text-right">
                          <p className="text-lg font-bold text-[#0d47a1]">{score ?? '—'}<span className="text-xs text-muted-foreground font-normal">{range}</span></p>
                          <p className="text-xs text-muted-foreground">{a.total_correct}/{a.total_questions} correct</p>
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

        {/* Mastery Status */}
        {(stats.masteryCounts.red > 0 ||
          stats.masteryCounts.yellow > 0 ||
          stats.masteryCounts.green > 0) && (
          <Card className="mb-8 rounded-sm">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Target className="w-5 h-5 text-primary" />
                Concept Mastery
              </CardTitle>
              <CardDescription>
                Your progress across different concepts
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div className="flex items-center gap-3 p-4 bg-red-50 border border-red-200 rounded-sm">
                  <AlertCircle className="w-6 h-6 text-red-600" />
                  <div>
                    <p className="text-sm text-muted-foreground">
                      Needs Practice
                    </p>
                    <p className="text-xl font-bold text-red-600">
                      {stats.masteryCounts.red}
                    </p>
                  </div>
                </div>
                <div className="flex items-center gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-sm">
                  <Clock className="w-6 h-6 text-yellow-600" />
                  <div>
                    <p className="text-sm text-muted-foreground">Developing</p>
                    <p className="text-xl font-bold text-yellow-600">
                      {stats.masteryCounts.yellow}
                    </p>
                  </div>
                </div>
                <div className="flex items-center gap-3 p-4 bg-green-50 border border-green-200 rounded-sm">
                  <CheckCircle className="w-6 h-6 text-green-600" />
                  <div>
                    <p className="text-sm text-muted-foreground">Mastered</p>
                    <p className="text-xl font-bold text-green-600">
                      {stats.masteryCounts.green}
                    </p>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        )}

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Enrolled Courses */}
          <Card className="rounded-sm">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <BookOpen className="w-5 h-5 text-primary" />
                My Enrolled Courses
              </CardTitle>
              <CardDescription>Continue learning</CardDescription>
            </CardHeader>
            <CardContent>
              {stats.enrollments.length === 0 ? (
                <div className="text-center py-8">
                  <BookOpen className="w-12 h-12 text-muted-foreground mx-auto mb-3" />
                  <p className="text-muted-foreground">
                    No courses enrolled yet
                  </p>
                  <Link href="/courses/discover">
                    <Button className="mt-4 rounded-sm">Browse Courses</Button>
                  </Link>
                </div>
              ) : (
                <div className="space-y-3">
                  {stats.enrollments.slice(0, 3).map((enrollment) => (
                    <Link
                      key={enrollment.id}
                      href={
                        enrollment.courses.courses_templates?.slug === "lms-interactive" ||
                        (enrollment.courses.slug && ["sat-quant-learn"].includes(enrollment.courses.slug))
                          ? `/learn/${enrollment.courses.slug}`
                          : `/courses/${enrollment.courses.slug}`
                      }
                    >
                      <div className="flex items-center gap-3 p-3 border rounded-sm hover:bg-primary/10 transition-colors cursor-pointer">
                        <div className="w-12 h-12 bg-[#1a365d]/10 rounded-sm flex items-center justify-center">
                          <BookOpen className="w-6 h-6 text-primary" />
                        </div>
                        <div className="flex-1">
                          <p className="font-medium">
                            {enrollment.courses.title}
                          </p>
                          <p className="text-sm text-muted-foreground">
                            {enrollment.courses.curriculum} • Grade{" "}
                            {enrollment.courses.grade}
                          </p>
                        </div>
                        <ChevronRight className="w-5 h-5 text-muted-foreground" />
                      </div>
                    </Link>
                  ))}
                  {stats.enrollments.length > 3 && (
                    <Link href="/courses/enrolled">
                      <Button
                        variant="outline"
                        className="w-full mt-3 rounded-sm"
                      >
                        View All Courses
                      </Button>
                    </Link>
                  )}
                </div>
              )}
            </CardContent>
          </Card>

          {/* Pending Assignments */}
          <Card className="rounded-sm">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <FileText className="w-5 h-5 text-blue-600" />
                Pending Assignments
              </CardTitle>
              <CardDescription>Submissions awaiting review</CardDescription>
            </CardHeader>
            <CardContent>
              {stats.assignments.length === 0 ? (
                <div className="text-center py-8">
                  <FileText className="w-12 h-12 text-muted-foreground mx-auto mb-3" />
                  <p className="text-muted-foreground">
                    No pending assignments
                  </p>
                </div>
              ) : (
                <div className="space-y-3">
                  {stats.assignments.slice(0, 3).map((assignment) => (
                    <div
                      key={assignment.id}
                      className="flex items-center justify-between p-3 border rounded-sm"
                    >
                      <div className="flex items-center gap-3 flex-1">
                        <div className="w-10 h-10 bg-blue-50 rounded-sm flex items-center justify-center">
                          <FileText className="w-5 h-5 text-blue-600" />
                        </div>
                        <div className="flex-1">
                          <p className="font-medium">{assignment.title}</p>
                          <p className="text-sm text-muted-foreground">
                            {assignment.courses.title}
                          </p>
                        </div>
                      </div>
                      <Badge variant="secondary" className="rounded-sm">
                        {formatDate(assignment.due_date)}
                      </Badge>
                    </div>
                  ))}
                  {stats.assignments.length > 3 && (
                    <Link href="/student/graded-assignments">
                      <Button
                        variant="outline"
                        className="w-full mt-3 rounded-sm"
                      >
                        View All Assignments
                      </Button>
                    </Link>
                  )}
                </div>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}

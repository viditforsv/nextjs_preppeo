"use client";

import { useState, useEffect } from "react";
import { useAuth } from "@/contexts/AuthContext";
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
  Brain,
} from "lucide-react";
import Link from "next/link";

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

interface GREAttemptSummary {
  id: string;
  set_number: number;
  estimated_score: number | null;
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

export default function StudentDashboard() {
  const { user, profile } = useAuth();
  const [stats, setStats] = useState<DashboardStats>({
    totalCourses: 0,
    pendingAssignments: 0,
    recentActivity: 0,
    masteryCounts: { red: 0, yellow: 0, green: 0 },
    enrollments: [],
    assignments: [],
    recentProgress: [],
  });
  const [satAttempts, setSatAttempts] = useState<SATAttemptSummary[]>([]);
  const [greAttempts, setGreAttempts] = useState<GREAttemptSummary[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (user) {
      loadDashboardData();
    }
  }, [user]);

  const loadDashboardData = async () => {
    try {
      setIsLoading(true);
      setError(null);

      const [dashboardRes, satRes, greRes] = await Promise.all([
        fetch("/api/student/dashboard"),
        fetch("/api/sat/attempts"),
        fetch("/api/gre/attempts"),
      ]);

      if (!dashboardRes.ok) throw new Error("Failed to fetch dashboard data");

      const data = await dashboardRes.json();
      setStats(data);

      if (satRes.ok) {
        const satData = await satRes.json();
        if (Array.isArray(satData)) setSatAttempts(satData.slice(0, 3));
      }
      if (greRes.ok) {
        const greData = await greRes.json();
        if (Array.isArray(greData)) setGreAttempts(greData.slice(0, 3));
      }
    } catch (err) {
      console.error("Error loading dashboard:", err);
      setError(err instanceof Error ? err.message : "Failed to load dashboard");
    } finally {
      setIsLoading(false);
    }
  };

  if (!user || (profile?.role !== "student" && profile?.role !== "admin")) {
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

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-[#1a365d] mx-auto mb-4"></div>
          <p className="text-muted-foreground">Loading dashboard...</p>
        </div>
      </div>
    );
  }

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString("en-US", {
      month: "short",
      day: "numeric",
    });
  };

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
        {(satAttempts.length > 0 || greAttempts.length > 0) && (
          <Card className="mb-8 rounded-sm">
            <CardHeader>
              <div className="flex items-center justify-between">
                <CardTitle className="flex items-center gap-2">
                  <TrendingUp className="w-5 h-5 text-primary" />
                  Recent Mock Scores
                </CardTitle>
                <div className="flex gap-2">
                  {satAttempts.length > 0 && (
                    <Link href="/sat-test/history" className="text-xs text-primary hover:underline font-medium">
                      SAT History →
                    </Link>
                  )}
                  {greAttempts.length > 0 && (
                    <Link href="/gre-test/history" className="text-xs text-purple-600 hover:underline font-medium ml-3">
                      GRE History →
                    </Link>
                  )}
                </div>
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
                {greAttempts.map((a) => {
                  const date = new Date(a.completed_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
                  return (
                    <Link key={a.id} href={`/gre-test/history/${a.id}`} className="flex items-center justify-between p-3 border rounded-sm hover:bg-primary/5 transition-colors">
                      <div className="flex items-center gap-3">
                        <div className="w-9 h-9 bg-purple-50 rounded-sm flex items-center justify-center">
                          <Brain className="w-4 h-4 text-purple-600" />
                        </div>
                        <div>
                          <p className="text-sm font-medium">GRE Mock · Set {a.set_number}</p>
                          <p className="text-xs text-muted-foreground">{date}</p>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <div className="text-right">
                          <p className="text-lg font-bold text-purple-600">{a.estimated_score ?? '—'}<span className="text-xs text-muted-foreground font-normal">/170</span></p>
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

        {/* Error Alert */}
        {error && (
          <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-sm text-red-800">
            <strong>Error:</strong> {error}
          </div>
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

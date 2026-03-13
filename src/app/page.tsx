"use client";

import { Button } from "@/design-system/components/ui/button";
import {
  Card,
  CardContent,
} from "@/design-system/components/ui/card";
import {
  BookOpen,
  ArrowRight,
  TrendingUp,
  GraduationCap,
  ClipboardCheck,
  Wrench,
  ExternalLink,
} from "lucide-react";
import { useAuth } from "@/contexts/AuthContext";
import { useRouter } from "next/navigation";
import { useState, useEffect } from "react";
import { createClient } from "@/lib/supabase/client";
import Link from "next/link";

const exams = [
  {
    name: "SAT",
    description: "College admission test covering reading, writing, and math.",
    gradient: "from-indigo-500 to-indigo-600",
    testRoute: "/sat-test",
    courseQuery: "SAT",
    live: true,
  },
  {
    name: "GRE",
    description: "Graduate school entrance exam — verbal, quant, and AWA.",
    gradient: "from-purple-500 to-purple-600",
    testRoute: "/gre-test",
    courseQuery: "GRE",
    live: true,
  },
  {
    name: "Ashoka",
    description: "Ashoka University aptitude test for undergraduate admissions.",
    gradient: "from-teal-500 to-teal-600",
    testRoute: "/ashoka-test",
    courseQuery: "Ashoka",
    live: true,
  },
  {
    name: "GMAT",
    description: "Business school admission test — quant, verbal, and data insights.",
    gradient: "from-red-500 to-red-600",
    testRoute: "/gmat-test",
    courseQuery: "GMAT",
    live: false,
  },
];

function ExamShowcase({ showHeading = true }: { showHeading?: boolean }) {
  return (
    <section className="py-16 bg-white">
      <div className="max-w-6xl mx-auto px-4">
        {showHeading && (
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-foreground mb-3">
              Explore by Exam
            </h2>
            <p className="text-muted-foreground max-w-xl mx-auto">
              Jump straight into a mock test or browse courses for your target exam.
            </p>
          </div>
        )}
        <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-5">
          {exams.map((exam) => (
            <Card
              key={exam.name}
              className="relative overflow-hidden hover:shadow-lg transition-shadow"
            >
              <CardContent className="p-5">
                <div className="flex items-start justify-between mb-3">
                  <div
                    className={`w-10 h-10 rounded-lg bg-linear-to-br ${exam.gradient} flex items-center justify-center`}
                  >
                    <GraduationCap className="w-5 h-5 text-white" />
                  </div>
                  {exam.live ? (
                    <span className="text-[11px] font-medium bg-emerald-100 text-emerald-700 px-2 py-0.5 rounded-full">
                      Live
                    </span>
                  ) : (
                    <span className="text-[11px] font-medium bg-amber-100 text-amber-700 px-2 py-0.5 rounded-full">
                      Coming Soon
                    </span>
                  )}
                </div>
                <h3 className="font-bold text-foreground text-lg mb-1">
                  {exam.name}
                </h3>
                <p className="text-sm text-muted-foreground mb-4 leading-relaxed">
                  {exam.description}
                </p>
                <div className="flex gap-2">
                  {exam.live ? (
                    <Link
                      href={exam.testRoute}
                      className="flex-1 flex items-center justify-center gap-1.5 py-2 bg-primary text-white text-xs font-semibold rounded-md hover:bg-primary/90 transition-colors"
                    >
                      Mock Test <ExternalLink className="w-3 h-3" />
                    </Link>
                  ) : (
                    <span className="flex-1 flex items-center justify-center gap-1.5 py-2 bg-gray-100 text-gray-400 text-xs font-semibold rounded-md cursor-not-allowed">
                      Coming Soon
                    </span>
                  )}
                  <Link
                    href={`/courses/discover?curriculum=${exam.courseQuery}`}
                    className="flex-1 flex items-center justify-center py-2 border border-gray-200 text-xs font-medium text-foreground rounded-md hover:bg-gray-50 transition-colors"
                  >
                    Courses
                  </Link>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
}

export default function Home() {
  const router = useRouter();
  const authContext = useAuth();
  const user = authContext?.user;
  const profile = authContext?.profile;
  const loading = authContext?.loading;

  const [stats, setStats] = useState({
    enrolledCourses: 0,
    completedLessons: 0,
    avgProgress: 0,
    loading: true,
  });

  useEffect(() => {
    const fetchStats = async () => {
      if (!user) return;
      try {
        const supabase = createClient();
        const { count: enrolledCount } = await supabase
          .from("courses_enrollments")
          .select("*", { count: "exact", head: true })
          .eq("student_id", user.id)
          .eq("is_active", true);

        const { data: progressData } = await supabase
          .from("user_progress")
          .select("is_completed, completion_percentage")
          .eq("user_id", user.id);

        const completedCount =
          progressData?.filter((p) => p.is_completed).length || 0;
        const avgProgress =
          progressData && progressData.length > 0
            ? Math.round(
                progressData.reduce(
                  (acc, p) => acc + (p.completion_percentage || 0),
                  0
                ) / progressData.length
              )
            : 0;

        setStats({
          enrolledCourses: enrolledCount || 0,
          completedLessons: completedCount,
          avgProgress,
          loading: false,
        });
      } catch (error) {
        console.error("Error fetching stats:", error);
        setStats((prev) => ({ ...prev, loading: false }));
      }
    };
    fetchStats();
  }, [user]);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-10 w-10 border-2 border-primary border-t-transparent" />
      </div>
    );
  }

  // ── Authenticated ──
  if (user) {
    return (
      <div className="min-h-screen bg-[#f5f5f0]">
        {/* Compact Hero */}
        <section className="bg-white border-b border-gray-100">
          <div className="max-w-6xl mx-auto px-4 py-12">
            <h1 className="text-3xl font-bold text-foreground mb-2">
              Welcome back, {profile?.first_name || profile?.full_name || "Student"}
            </h1>
            <p className="text-muted-foreground mb-6">
              Pick up where you left off or start something new.
            </p>

            {/* Inline Stats */}
            {!stats.loading && (
              <div className="flex flex-wrap gap-6 mb-8">
                <div className="flex items-center gap-2 text-sm">
                  <BookOpen className="w-4 h-4 text-primary" />
                  <span className="font-semibold text-foreground">{stats.enrolledCourses}</span>
                  <span className="text-muted-foreground">courses enrolled</span>
                </div>
                <div className="flex items-center gap-2 text-sm">
                  <ClipboardCheck className="w-4 h-4 text-emerald-600" />
                  <span className="font-semibold text-foreground">{stats.completedLessons}</span>
                  <span className="text-muted-foreground">lessons completed</span>
                </div>
                <div className="flex items-center gap-2 text-sm">
                  <TrendingUp className="w-4 h-4 text-blue-600" />
                  <span className="font-semibold text-foreground">{stats.avgProgress}%</span>
                  <span className="text-muted-foreground">avg progress</span>
                </div>
              </div>
            )}

            <div className="flex gap-3 flex-wrap">
              <Button
                className="bg-primary hover:bg-primary/90 text-white"
                onClick={() => router.push("/courses/enrolled")}
              >
                My Courses
                <ArrowRight className="ml-2 h-4 w-4" />
              </Button>
              <Button
                variant="outline"
                className="border-primary text-primary hover:bg-primary hover:text-white"
                onClick={() => router.push("/tests")}
              >
                Test Hub
              </Button>
            </div>
          </div>
        </section>

        {/* Quick Actions */}
        <section className="py-12">
          <div className="max-w-6xl mx-auto px-4">
            <div className="grid sm:grid-cols-3 gap-4">
              <Link href="/courses/enrolled" className="group">
                <Card className="h-full hover:shadow-md transition-shadow">
                  <CardContent className="p-6 flex items-start gap-4">
                    <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center shrink-0">
                      <BookOpen className="w-5 h-5 text-primary" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-foreground mb-1">My Courses</h3>
                      <p className="text-sm text-muted-foreground">
                        Continue your enrolled courses and track progress.
                      </p>
                    </div>
                  </CardContent>
                </Card>
              </Link>
              <Link href="/tests" className="group">
                <Card className="h-full hover:shadow-md transition-shadow">
                  <CardContent className="p-6 flex items-start gap-4">
                    <div className="w-10 h-10 rounded-lg bg-emerald-50 flex items-center justify-center shrink-0">
                      <ClipboardCheck className="w-5 h-5 text-emerald-600" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-foreground mb-1">Test Hub</h3>
                      <p className="text-sm text-muted-foreground">
                        Take timed mock tests that mirror real exam conditions.
                      </p>
                    </div>
                  </CardContent>
                </Card>
              </Link>
              <Link href="/tools" className="group">
                <Card className="h-full hover:shadow-md transition-shadow">
                  <CardContent className="p-6 flex items-start gap-4">
                    <div className="w-10 h-10 rounded-lg bg-amber-50 flex items-center justify-center shrink-0">
                      <Wrench className="w-5 h-5 text-amber-600" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-foreground mb-1">Free Tools</h3>
                      <p className="text-sm text-muted-foreground">
                        Calculators, flashcards, and other study aids.
                      </p>
                    </div>
                  </CardContent>
                </Card>
              </Link>
            </div>
          </div>
        </section>

        {/* Exam Showcase */}
        <ExamShowcase />
      </div>
    );
  }

  // ── Unauthenticated ──
  return (
    <div className="min-h-screen">
      {/* Hero */}
      <section className="bg-[#f5f5f0] py-20">
        <div className="max-w-3xl mx-auto px-4 text-center">
          <h1 className="text-4xl md:text-5xl font-bold text-foreground mb-5 leading-tight">
            Ace Your Exams with Adaptive Mock Tests &amp; Expert Courses
          </h1>
          <p className="text-lg text-muted-foreground mb-8 max-w-2xl mx-auto leading-relaxed">
            Timed mock tests that mirror real exam conditions, structured courses
            built by experts, and free study tools — for SAT, GRE, GMAT, Ashoka,
            and more.
          </p>
          <div className="flex gap-3 justify-center flex-wrap">
            <Button
              size="lg"
              className="bg-primary hover:bg-primary/90 text-white"
              onClick={() => router.push("/tests")}
            >
              Explore Mock Tests
              <ArrowRight className="ml-2 h-4 w-4" />
            </Button>
            <Button
              size="lg"
              variant="outline"
              className="border-primary text-primary hover:bg-primary hover:text-white"
              onClick={() => router.push("/courses/discover")}
            >
              Browse Courses
            </Button>
          </div>
        </div>
      </section>

      {/* Exam Showcase */}
      <ExamShowcase />

      {/* Three Pillars — What We Offer */}
      <section className="py-16 bg-[#f5f5f0]">
        <div className="max-w-6xl mx-auto px-4">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-foreground mb-3">
              What We Offer
            </h2>
            <p className="text-muted-foreground max-w-xl mx-auto">
              Everything you need to prepare — in one place.
            </p>
          </div>
          <div className="grid md:grid-cols-3 gap-6">
            <Card className="text-center hover:shadow-md transition-shadow">
              <CardContent className="p-8">
                <div className="w-12 h-12 rounded-xl bg-primary/10 flex items-center justify-center mx-auto mb-4">
                  <ClipboardCheck className="w-6 h-6 text-primary" />
                </div>
                <h3 className="font-bold text-foreground text-lg mb-2">Mock Tests</h3>
                <p className="text-sm text-muted-foreground mb-4 leading-relaxed">
                  Timed, section-adaptive tests that replicate the real exam experience.
                  Get detailed score breakdowns after every attempt.
                </p>
                <Link
                  href="/tests"
                  className="text-sm font-medium text-primary hover:underline inline-flex items-center gap-1"
                >
                  Go to Test Hub <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </CardContent>
            </Card>

            <Card className="text-center hover:shadow-md transition-shadow">
              <CardContent className="p-8">
                <div className="w-12 h-12 rounded-xl bg-emerald-50 flex items-center justify-center mx-auto mb-4">
                  <BookOpen className="w-6 h-6 text-emerald-600" />
                </div>
                <h3 className="font-bold text-foreground text-lg mb-2">Courses</h3>
                <p className="text-sm text-muted-foreground mb-4 leading-relaxed">
                  Structured, expert-curated courses with progress tracking, quizzes,
                  and assignments to build deep understanding.
                </p>
                <Link
                  href="/courses/discover"
                  className="text-sm font-medium text-primary hover:underline inline-flex items-center gap-1"
                >
                  Browse Courses <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </CardContent>
            </Card>

            <Card className="text-center hover:shadow-md transition-shadow">
              <CardContent className="p-8">
                <div className="w-12 h-12 rounded-xl bg-amber-50 flex items-center justify-center mx-auto mb-4">
                  <Wrench className="w-6 h-6 text-amber-600" />
                </div>
                <h3 className="font-bold text-foreground text-lg mb-2">Free Tools</h3>
                <p className="text-sm text-muted-foreground mb-4 leading-relaxed">
                  Calculators, vocabulary builders, and practice utilities — completely
                  free, no sign-up required.
                </p>
                <Link
                  href="/tools"
                  className="text-sm font-medium text-primary hover:underline inline-flex items-center gap-1"
                >
                  Explore Tools <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </CardContent>
            </Card>
          </div>
        </div>
      </section>

      {/* How It Works */}
      <section className="py-16 bg-white">
        <div className="max-w-4xl mx-auto px-4">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-foreground mb-3">
              How It Works
            </h2>
          </div>
          <div className="grid md:grid-cols-3 gap-8 text-center">
            <div>
              <div className="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center mx-auto mb-4 text-sm font-bold">
                1
              </div>
              <h3 className="font-semibold text-foreground mb-2">Choose Your Exam</h3>
              <p className="text-sm text-muted-foreground">
                Pick from SAT, GRE, GMAT, Ashoka, and more.
              </p>
            </div>
            <div>
              <div className="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center mx-auto mb-4 text-sm font-bold">
                2
              </div>
              <h3 className="font-semibold text-foreground mb-2">Take a Free Mock Test</h3>
              <p className="text-sm text-muted-foreground">
                Every exam includes a free test token to get started instantly.
              </p>
            </div>
            <div>
              <div className="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center mx-auto mb-4 text-sm font-bold">
                3
              </div>
              <h3 className="font-semibold text-foreground mb-2">Review &amp; Improve</h3>
              <p className="text-sm text-muted-foreground">
                Get detailed results, enroll in courses, and track your progress.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 bg-primary">
        <div className="max-w-2xl mx-auto px-4 text-center">
          <h2 className="text-3xl font-bold text-white mb-4">
            Ready to start preparing?
          </h2>
          <p className="text-white/80 mb-8">
            Every exam comes with a free mock test — no credit card needed.
          </p>
          <Button
            size="lg"
            className="bg-white hover:bg-gray-100 text-primary font-semibold"
            onClick={() => router.push("/auth?tab=signup")}
          >
            Get Started Free
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </section>
    </div>
  );
}

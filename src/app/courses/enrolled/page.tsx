"use client";

import { useState, useEffect } from "react";
import { useAuth } from "@/contexts/AuthContext";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/design-system/components/ui/card";
import { Button } from "@/design-system/components/ui/button";
import { Badge } from "@/design-system/components/ui/badge";
import { Progress } from "@/design-system/components/ui/progress";
import {
  BookOpen,
  Clock,
  Calendar,
  ArrowRight,
  Play,
  CheckCircle2,
  Award,
  Target,
  BarChart3,
  Gift,
  Sparkles,
  Users,
  FileEdit,
  Zap,
} from "lucide-react";
import Link from "next/link";

interface EnrolledCourse {
  id: string;
  title: string;
  description: string | null;
  slug: string | null;
  price: number;
  created_at: string;
  enrollment: {
    id: string;
    enrolled_at: string;
    is_active: boolean;
  };
  // Progress data
  totalLessons?: number;
  completedLessons?: number;
  progressPercentage?: number;
  totalTimeSpent?: number;
}

interface OverallStats {
  totalCourses: number;
  totalLessonsCompleted: number;
  totalTimeSpent: number;
  studyStreak: number;
  averageProgress: number;
}

export default function EnrolledCoursesPage() {
  const { user } = useAuth();
  const [enrolledCourses, setEnrolledCourses] = useState<EnrolledCourse[]>([]);
  const [overallStats, setOverallStats] = useState<OverallStats>({
    totalCourses: 0,
    totalLessonsCompleted: 0,
    totalTimeSpent: 0,
    studyStreak: 0,
    averageProgress: 0,
  });
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    if (!user?.id) {
      setIsLoading(false);
      return;
    }
    setIsLoading(true);
    fetch('/api/courses/enrolled')
      .then((r) => r.json())
      .then((data) => {
        if (data.courses) {
          setEnrolledCourses(data.courses);
          const total: number = data.courses.length;
          const totalLessonsCompleted = data.courses.reduce(
            (s: number, c: EnrolledCourse) => s + (c.completedLessons || 0), 0
          );
          const totalTimeSpent = data.courses.reduce(
            (s: number, c: EnrolledCourse) => s + (c.totalTimeSpent || 0), 0
          );
          const averageProgress = total > 0
            ? Math.round(
                data.courses.reduce(
                  (s: number, c: EnrolledCourse) => s + (c.progressPercentage || 0), 0
                ) / total
              )
            : 0;
          setOverallStats({
            totalCourses: total,
            totalLessonsCompleted,
            totalTimeSpent,
            studyStreak: data.studyStreak ?? 0,
            averageProgress,
          });
        }
      })
      .catch((err) => console.error('Error fetching enrolled courses:', err.message))
      .finally(() => setIsLoading(false));
  }, [user?.id]);

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString("en-US", {
      year: "numeric",
      month: "short",
      day: "numeric",
    });
  };

  const formatTime = (minutes: number) => {
    const hours = Math.floor(minutes / 60);
    const mins = minutes % 60;
    return hours > 0 ? `${hours}h ${mins}m` : `${mins}m`;
  };

  if (!user) {
    return (
      <div className="min-h-screen bg-[#fafaf8] flex items-center justify-center px-4">
        <div className="max-w-md w-full text-center">
          <div className="w-16 h-16 bg-primary/10 rounded-2xl flex items-center justify-center mx-auto mb-6">
            <BookOpen className="w-8 h-8 text-primary" />
          </div>
          <h1 className="text-2xl font-bold text-foreground mb-3">
            Your enrolled courses live here
          </h1>
          <p className="text-muted-foreground mb-8">
            Sign in to access your courses, track progress, and continue where you left off.
          </p>
          <div className="flex gap-3 justify-center">
            <Link href="/auth?tab=signin">
              <Button className="bg-primary hover:bg-primary/90 text-white">
                Sign In
              </Button>
            </Link>
            <Link href="/auth?tab=signup">
              <Button variant="outline" className="border-primary text-primary hover:bg-primary hover:text-white">
                Sign Up
              </Button>
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#fafaf8]">
      <div className="container mx-auto px-4 py-8">
        {/* Page Header */}
        <div className="flex items-start justify-between gap-4 mb-8">
          <div>
            <h1 className="text-4xl font-bold text-foreground mb-2">
              My Dashboard
            </h1>
            <p className="text-lg text-muted-foreground">
              Mock tests, practice, and courses — all in one place
            </p>
          </div>
          <Link
            href="/mocks"
            className="shrink-0 inline-flex items-center gap-2 px-4 py-2.5 rounded-xl border border-[#1a365d]/30 bg-[#1a365d]/5 text-[#1a365d] text-sm font-semibold hover:bg-[#1a365d]/10 transition-colors mt-1"
          >
            <BarChart3 className="w-4 h-4" />
            Score History
          </Link>
        </div>

        {/* Mocks + Practice Quick Actions */}
        {!isLoading && (
          <div className="mb-10">
            <h2 className="text-xl font-bold text-foreground mb-4">Mocks &amp; Practice</h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
              <Link href="/sat-test" className="group">
                <div className="bg-white rounded-xl border border-gray-100 p-5 hover:border-primary/40 hover:shadow-md transition-all h-full">
                  <div className="w-10 h-10 rounded-lg bg-[#1a365d]/10 flex items-center justify-center mb-3 group-hover:bg-[#1a365d]/20 transition-colors">
                    <FileEdit className="w-5 h-5 text-[#1a365d]" />
                  </div>
                  <p className="font-semibold text-foreground mb-1">SAT</p>
                  <p className="text-xs text-muted-foreground">Full adaptive mock + Practice mode</p>
                </div>
              </Link>
              <Link href="/gre-test" className="group">
                <div className="bg-white rounded-xl border border-gray-100 p-5 hover:border-primary/40 hover:shadow-md transition-all h-full">
                  <div className="w-10 h-10 rounded-lg bg-emerald-500/10 flex items-center justify-center mb-3 group-hover:bg-emerald-500/20 transition-colors">
                    <FileEdit className="w-5 h-5 text-emerald-600" />
                  </div>
                  <p className="font-semibold text-foreground mb-1">GRE</p>
                  <p className="text-xs text-muted-foreground">Quant mock + Practice mode</p>
                </div>
              </Link>
              <Link href="/ashoka-test" className="group">
                <div className="bg-white rounded-xl border border-gray-100 p-5 hover:border-primary/40 hover:shadow-md transition-all h-full">
                  <div className="w-10 h-10 rounded-lg bg-amber-500/10 flex items-center justify-center mb-3 group-hover:bg-amber-500/20 transition-colors">
                    <FileEdit className="w-5 h-5 text-amber-600" />
                  </div>
                  <p className="font-semibold text-foreground mb-1">Ashoka AAT</p>
                  <p className="text-xs text-muted-foreground">Full-length aptitude mock</p>
                </div>
              </Link>
              <Link href="/mocks" className="group">
                <div className="bg-white rounded-xl border border-gray-100 p-5 hover:border-primary/40 hover:shadow-md transition-all h-full">
                  <div className="w-10 h-10 rounded-lg bg-violet-500/10 flex items-center justify-center mb-3 group-hover:bg-violet-500/20 transition-colors">
                    <Zap className="w-5 h-5 text-violet-600" />
                  </div>
                  <p className="font-semibold text-foreground mb-1">Mock Hub</p>
                  <p className="text-xs text-muted-foreground">All mocks, tokens &amp; score history</p>
                </div>
              </Link>
            </div>
          </div>
        )}

        {/* Overall Stats */}
        {!isLoading && enrolledCourses.length > 0 && (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
            <Card className="border-0 bg-[#1a365d]/5 hover:-translate-y-1">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-muted-foreground mb-1">
                      Courses Enrolled
                    </p>
                    <p className="text-3xl font-bold text-primary">
                      {overallStats.totalCourses}
                    </p>
                  </div>
                  <div className="w-14 h-14 bg-linear-to-br from-[#1a365d] to-[#2a4a7f] rounded-xl flex items-center justify-center shadow-lg">
                    <BookOpen className="w-7 h-7 text-white" />
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card className="border-0 bg-[#1a365d]/5 hover:-translate-y-1">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-muted-foreground mb-1">
                      Lessons Completed
                    </p>
                    <p className="text-3xl font-bold text-primary">
                      {overallStats.totalLessonsCompleted}
                    </p>
                  </div>
                  <div className="w-14 h-14 bg-linear-to-br from-[#1a365d] to-[#2a4a7f] rounded-xl flex items-center justify-center shadow-lg">
                    <CheckCircle2 className="w-7 h-7 text-white" />
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card className="border-0 bg-linear-to-br from-emerald-50 to-green-50 hover:-translate-y-1">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-muted-foreground mb-1">Time Spent</p>
                    <p className="text-3xl font-bold text-emerald-600">
                      {formatTime(overallStats.totalTimeSpent)}
                    </p>
                  </div>
                  <div className="w-14 h-14 bg-linear-to-br from-emerald-500 to-green-600 rounded-xl flex items-center justify-center shadow-lg">
                    <Clock className="w-7 h-7 text-white" />
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card className="border-0 bg-linear-to-br from-amber-50 to-yellow-50 hover:-translate-y-1">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-muted-foreground mb-1">
                      Study Streak
                    </p>
                    <p className="text-3xl font-bold text-amber-600">
                      {overallStats.studyStreak} days
                    </p>
                  </div>
                  <div className="w-14 h-14 bg-linear-to-br from-amber-500 to-yellow-500 rounded-xl flex items-center justify-center shadow-lg">
                    <Award className="w-7 h-7 text-white" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        )}

        {isLoading && (
          <div className="flex items-center justify-center py-12">
            <div className="text-center">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
              <p className="text-muted-foreground">Loading your courses...</p>
            </div>
          </div>
        )}

        {!isLoading && enrolledCourses.length === 0 && (
          <div className="space-y-5">
            {/* Block A -- Start for Free */}
            <div className="bg-white rounded-xl border border-gray-100 p-6">
              <div className="flex items-center gap-3 mb-4">
                <div className="w-10 h-10 rounded-lg bg-emerald-500/10 flex items-center justify-center">
                  <Sparkles className="w-5 h-5 text-emerald-600" />
                </div>
                <div>
                  <p className="text-lg font-bold text-foreground">Start preparing — for free</p>
                  <p className="text-sm text-muted-foreground">
                    Claim a complimentary SAT mock (worth ₹499) or practice 5 questions daily with AI explanations.
                  </p>
                </div>
              </div>
              <div className="flex flex-wrap gap-3">
                <Link href="/sat-free">
                  <Button size="sm" className="bg-primary hover:bg-primary/90 text-white gap-1.5">
                    <Gift className="w-4 h-4" /> Claim Free SAT Mock
                  </Button>
                </Link>
                <Link href="/sat-test">
                  <Button size="sm" variant="outline" className="gap-1.5">
                    <Play className="w-4 h-4" /> Try Free Practice
                  </Button>
                </Link>
              </div>
            </div>

            {/* Block B -- Browse Courses */}
            <div className="bg-white rounded-xl border border-gray-100 p-6">
              <div className="flex items-center gap-3 mb-4">
                <div className="w-10 h-10 rounded-lg bg-[#1a365d]/10 flex items-center justify-center">
                  <BookOpen className="w-5 h-5 text-[#1a365d]" />
                </div>
                <div>
                  <p className="text-lg font-bold text-foreground">Ready for structured learning?</p>
                  <p className="text-sm text-muted-foreground">Pick your exam and explore our courses.</p>
                </div>
              </div>
              <div className="flex flex-wrap gap-2">
                {[
                  { label: "SAT", value: "SAT" },
                  { label: "GRE", value: "GRE" },
                  { label: "GMAT", value: "GMAT" },
                  { label: "Ashoka", value: "Ashoka" },
                ].map((exam) => (
                  <Link
                    key={exam.value}
                    href={`/courses/discover?curriculum=${exam.value}`}
                    className="inline-flex items-center gap-1.5 px-4 py-2 rounded-full border border-primary/30 text-sm font-medium text-primary bg-primary/5 hover:bg-primary hover:text-white transition-colors"
                  >
                    {exam.label}
                    <ArrowRight className="w-3.5 h-3.5" />
                  </Link>
                ))}
                <Link
                  href="/courses/discover"
                  className="inline-flex items-center gap-1.5 px-4 py-2 rounded-full border border-gray-200 text-sm font-medium text-muted-foreground bg-white hover:bg-gray-50 transition-colors"
                >
                  Browse all
                  <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </div>
            </div>

            {/* Block C -- Refer Friends */}
            <div className="bg-white rounded-xl border border-gray-100 p-6">
              <div className="flex items-center gap-3 mb-4">
                <div className="w-10 h-10 rounded-lg bg-violet-500/10 flex items-center justify-center">
                  <Users className="w-5 h-5 text-violet-600" />
                </div>
                <div>
                  <p className="text-lg font-bold text-foreground">Invite friends, earn free mocks</p>
                  <p className="text-sm text-muted-foreground">
                    Share your referral link — you and your friend both get a bonus mock token.
                  </p>
                </div>
              </div>
              <Link href="/referral">
                <Button size="sm" variant="outline" className="gap-1.5">
                  <Gift className="w-4 h-4" /> Get Your Referral Link
                </Button>
              </Link>
            </div>
          </div>
        )}

        {!isLoading && enrolledCourses.length > 0 && (
          <div>
            <h2 className="text-xl font-bold text-foreground mb-4">My Courses</h2>
            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {enrolledCourses.map((course) => (
              <Card
                key={course.id}
                className=""
              >
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="text-lg mb-2">
                        {course.title}
                      </CardTitle>
                      <CardDescription className="line-clamp-2">
                        {course.description || "No description available"}
                      </CardDescription>
                    </div>
                    <Badge
                      variant={course.price === 0 ? "secondary" : "default"}
                    >
                      {course.price === 0 ? "Free" : `₹${course.price}`}
                    </Badge>
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {/* Progress Section */}
                    <div>
                      <div className="flex items-center justify-between text-sm mb-2">
                        <span className="text-muted-foreground">Progress</span>
                        <span className="font-medium">
                          {course.progressPercentage || 0}%
                        </span>
                      </div>
                      <Progress
                        value={course.progressPercentage || 0}
                        className="h-2"
                      />
                    </div>

                    {/* Course Stats */}
                    <div className="grid grid-cols-2 gap-4 text-sm">
                      <div className="flex items-center gap-2">
                        <Target className="w-4 h-4 text-muted-foreground" />
                        <span>{course.completedLessons || 0} completed</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <BookOpen className="w-4 h-4 text-muted-foreground" />
                        <span>
                          {(course.totalLessons || 0) -
                            (course.completedLessons || 0)}{" "}
                          remaining
                        </span>
                      </div>
                      <div className="flex items-center gap-2">
                        <Clock className="w-4 h-4 text-muted-foreground" />
                        <span>{formatTime(course.totalTimeSpent || 0)}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <Calendar className="w-4 h-4 text-muted-foreground" />
                        <span>
                          Enrolled {formatDate(course.enrollment.enrolled_at)}
                        </span>
                      </div>
                    </div>

                    {/* Action Buttons */}
                    <div className="flex gap-2">
                      <Link
                        href={
                          course.slug && ["sat-quant-learn"].includes(course.slug)
                            ? `/learn/${course.slug || course.id}`
                            : `/courses/${course.slug || course.id}`
                        }
                        className="flex-1"
                      >
                        <Button
                          className="w-full rounded-sm bg-primary hover:bg-primary/90"
                          size="sm"
                        >
                          <Play className="w-4 h-4 mr-2" />
                          Continue Learning
                        </Button>
                      </Link>
                      <Button
                        variant="outline"
                        size="sm"
                        className="rounded-sm"
                      >
                        <BarChart3 className="w-4 h-4" />
                      </Button>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

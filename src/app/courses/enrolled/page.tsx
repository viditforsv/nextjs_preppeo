"use client";

import { useState, useEffect, useMemo } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { createClient } from "@/lib/supabase/client";
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
} from "lucide-react";
import Link from "next/link";

interface EnrolledCourse {
  id: string;
  title: string;
  description: string | null;
  slug: string | null;
  price: number;
  created_at: string;
  courses_templates?: { slug?: string } | null;
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
  const [error, setError] = useState<string | null>(null);

  // Memoize the supabase client to prevent recreation on every render
  const supabase = useMemo(() => createClient(), []);

  useEffect(() => {
    const fetchEnrolledCourses = async () => {
      if (!user?.id) {
        setIsLoading(false);
        return;
      }

      try {
        setIsLoading(true);
        setError(null);

        const { data, error } = await supabase
          .from("courses_enrollments")
          .select(
            `
            *,
            courses (*, courses_templates (slug))
          `
          )
          .eq("student_id", user.id)
          .eq("is_active", true)
          .order("enrolled_at", { ascending: false });

        if (error) {
          throw error;
        }

        // Transform the data and fetch progress for each course
        const coursesWithProgress = await Promise.all(
          (data || []).map(async (item) => {
            const course = item.courses;

            // Get lesson count for this course
            const { count: totalLessons } = await supabase
              .from("courses_lessons")
              .select("*", { count: "exact", head: true })
              .eq("course_id", course.id);

            // Get completed lessons count
            const { count: completedLessons } = await supabase
              .from("user_progress")
              .select("*", { count: "exact", head: true })
              .eq("user_id", user.id)
              .eq("course_id", course.id)
              .eq("completed", true);

            // Get real time spent from user_progress table
            const { data: progressData } = await supabase
              .from("user_progress")
              .select("time_spent_minutes")
              .eq("user_id", user.id)
              .eq("course_id", course.id);

            const timeSpent =
              progressData?.reduce(
                (sum, progress) => sum + (progress.time_spent_minutes || 0),
                0
              ) || 0;

            const progressPercentage = totalLessons
              ? Math.round(((completedLessons || 0) / totalLessons) * 100)
              : 0;

            return {
              ...course,
              enrollment: {
                id: item.id,
                enrolled_at: item.enrolled_at,
                is_active: item.is_active,
              },
              totalLessons: totalLessons || 0,
              completedLessons: completedLessons || 0,
              progressPercentage,
              totalTimeSpent: timeSpent,
            };
          })
        );

        setEnrolledCourses(coursesWithProgress);

        // Calculate overall stats
        const totalLessonsCompleted = coursesWithProgress.reduce(
          (sum, course) => sum + (course.completedLessons || 0),
          0
        );
        const totalTimeSpent = coursesWithProgress.reduce(
          (sum, course) => sum + (course.totalTimeSpent || 0),
          0
        );
        const averageProgress =
          coursesWithProgress.length > 0
            ? Math.round(
                coursesWithProgress.reduce(
                  (sum, course) => sum + (course.progressPercentage || 0),
                  0
                ) / coursesWithProgress.length
              )
            : 0;

        // Calculate study streak from user activity
        const studyStreak = await calculateStudyStreak(user.id, supabase);

        setOverallStats({
          totalCourses: coursesWithProgress.length,
          totalLessonsCompleted,
          totalTimeSpent,
          studyStreak,
          averageProgress,
        });
      } catch (err) {
        console.error("Error fetching enrolled courses:", err);
        setError("Failed to load enrolled courses");
      } finally {
        setIsLoading(false);
      }
    };

    fetchEnrolledCourses();
  }, [user?.id, supabase]);

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

  // Calculate study streak from user activity
  const calculateStudyStreak = async (
    userId: string,
    supabase: ReturnType<typeof createClient>
  ) => {
    try {
      // Get all last_accessed_at dates from user_progress
      const { data: progressData } = await supabase
        .from("user_progress")
        .select("last_accessed_at")
        .eq("user_id", userId)
        .order("last_accessed_at", { ascending: false });

      if (!progressData || progressData.length === 0) return 0;

      interface ProgressItem {
        last_accessed_at: string;
      }

      // Get unique dates (convert to date strings to group by day)
      const uniqueDates = new Set(
        progressData.map((item: ProgressItem) =>
          new Date(item.last_accessed_at).toDateString()
        )
      );

      const sortedDates = Array.from(uniqueDates)
        .map((dateStr) => new Date(dateStr as string))
        .sort((a, b) => b.getTime() - a.getTime());

      // Calculate consecutive days from today backwards
      let streak = 0;
      const today = new Date();
      today.setHours(0, 0, 0, 0);

      for (let i = 0; i < sortedDates.length; i++) {
        const checkDate = new Date(today);
        checkDate.setDate(today.getDate() - i);
        checkDate.setHours(0, 0, 0, 0);

        const hasActivity = sortedDates.some((date) => {
          const activityDate = new Date(date);
          activityDate.setHours(0, 0, 0, 0);
          return activityDate.getTime() === checkDate.getTime();
        });

        if (hasActivity) {
          streak++;
        } else {
          break;
        }
      }

      return streak;
    } catch (error) {
      console.error("Error calculating study streak:", error);
      return 0;
    }
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
        <div className="mb-8">
          <h1 className="text-4xl font-bold text-foreground mb-2">
            My Enrolled Courses
          </h1>
          <p className="text-lg text-muted-foreground">
            Continue your learning journey and track your progress
          </p>
        </div>

        {/* Overall Stats */}
        {!isLoading && !error && enrolledCourses.length > 0 && (
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

        {error && (
          <div className="text-center py-12">
            <p className="text-red-600 mb-4">{error}</p>
            <Button onClick={() => window.location.reload()}>Try Again</Button>
          </div>
        )}

        {!isLoading && !error && enrolledCourses.length === 0 && (
          <div>
            {/* Zero-enrollment banner */}
            <div className="bg-white rounded-xl border border-gray-100 p-8 mb-8">
              <div className="flex items-center gap-3 mb-6">
                <div className="w-10 h-10 rounded-lg bg-gray-100 flex items-center justify-center">
                  <BookOpen className="w-5 h-5 text-gray-400" />
                </div>
                <div>
                  <p className="text-2xl font-bold text-foreground">0 enrolled courses</p>
                  <p className="text-sm text-muted-foreground">You haven&apos;t enrolled in any courses yet.</p>
                </div>
              </div>

              <p className="text-sm font-medium text-foreground mb-3">Which exam are you preparing for?</p>
              <div className="flex flex-wrap gap-2 mb-6">
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
                    {exam.label} courses
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

              <p className="text-xs text-muted-foreground">
                Not ready to enroll? Every exam also includes a{" "}
                <Link href="/tests" className="text-primary hover:underline font-medium">
                  free mock test
                </Link>{" "}
                — no enrollment needed.
              </p>
            </div>
          </div>
        )}

        {!isLoading && !error && enrolledCourses.length > 0 && (
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
                          course.courses_templates?.slug === "lms-interactive" ||
                          (course.slug && ["sat-quant-learn"].includes(course.slug))
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
        )}
      </div>
    </div>
  );
}

"use client";

import Link from "next/link";
import { Play, CheckCircle, BookOpen, FileText, Video } from "lucide-react";
import { Button } from "@/design-system/components/ui/button";
import { Badge } from "@/design-system/components/ui/badge";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/design-system/components/ui/card";
import { UnifiedCourseStructure } from "@/components/UnifiedCourseStructure";

interface LMSCourseOverviewProps {
  course: Record<string, unknown>;
  courseSlug: string;
  lessons: Array<{ id: string; slug: string; title: string; lesson_order: number }>;
  units: Array<{ id: string; unit_name: string; unit_order: number }>;
  chapters: Array<{ id: string; chapter_name: string; chapter_order: number; unit_id: string }>;
  isEnrolled: boolean;
  isAuthenticated: boolean;
  authLoading: boolean;
  continueLessonSlug: string | null;
  onEnroll: () => void;
}

export function LMSCourseOverview({
  course,
  courseSlug,
  lessons,
  isEnrolled,
  isAuthenticated,
  authLoading,
  continueLessonSlug,
  onEnroll,
}: LMSCourseOverviewProps) {
  const title = (course.title as string) || "Course";
  const description = (course.description as string) || "";
  const learningOutcomes = (course.template_data as Record<string, unknown>)?.learningOutcomes as string[] | undefined;
  const outcomes = learningOutcomes?.length ? learningOutcomes : ["Structured lessons", "Practice and quizzes", "Progress tracking"];

  return (
    <div className="min-h-screen bg-background" data-template="lms-interactive">
      <div className="container mx-auto px-4 py-8 max-w-5xl">
        {/* Hero */}
        <section className="mb-10">
          <div className="flex flex-wrap gap-2 mb-4">
            {course.curriculum != null && course.curriculum !== "" && (
              <Badge variant="outline" className="border-primary text-primary">
                {String(course.curriculum)}
              </Badge>
            )}
            {course.subject != null && course.subject !== "" && (
              <Badge variant="outline">{String(course.subject)}</Badge>
            )}
          </div>
          <h1 className="text-4xl font-bold tracking-tight mb-4">{title}</h1>
          <p className="text-xl text-muted-foreground mb-6 max-w-3xl">{description}</p>
          <div className="flex flex-wrap gap-3">
            {isEnrolled && continueLessonSlug ? (
              <Link href={`/learn/${courseSlug}/lesson/${continueLessonSlug}`}>
                <Button className="gap-2 bg-primary text-primary-foreground hover:bg-primary/90">
                  <Play className="w-4 h-4" />
                  Continue Learning
                </Button>
              </Link>
            ) : (
              <Button
                onClick={onEnroll}
                disabled={authLoading || !isAuthenticated}
                className="gap-2 bg-primary text-primary-foreground hover:bg-primary/90"
              >
                {!isAuthenticated ? "Sign in to Enroll" : authLoading ? "Loading..." : "Enroll for Free"}
              </Button>
            )}
          </div>
        </section>

        {/* What you'll learn */}
        <section className="mb-10">
          <h2 className="text-2xl font-semibold mb-4">What you&apos;ll learn</h2>
          <ul className="grid gap-2 sm:grid-cols-2">
            {outcomes.map((outcome, i) => (
              <li key={i} className="flex items-start gap-2">
                <CheckCircle className="w-5 h-5 text-primary shrink-0 mt-0.5" />
                <span className="text-muted-foreground">{outcome}</span>
              </li>
            ))}
          </ul>
        </section>

        {/* Course content */}
        <section className="mb-10">
          <h2 className="text-2xl font-semibold mb-4">Course content</h2>
          <Card>
            <CardHeader>
              <CardTitle>Curriculum</CardTitle>
              <CardDescription>{lessons.length} lessons</CardDescription>
            </CardHeader>
            <CardContent>
              <UnifiedCourseStructure
                courseSlug={courseSlug}
                showTopicNumbers={true}
              />
            </CardContent>
          </Card>
        </section>

        {/* Course includes */}
        <section className="mb-10">
          <h2 className="text-2xl font-semibold mb-4">Course includes</h2>
          <ul className="flex flex-wrap gap-4 text-muted-foreground">
            <li className="flex items-center gap-2">
              <BookOpen className="w-5 h-5 text-primary" />
              {lessons.length} lessons
            </li>
            <li className="flex items-center gap-2">
              <Video className="w-5 h-5 text-primary" />
              Video lectures
            </li>
            <li className="flex items-center gap-2">
              <FileText className="w-5 h-5 text-primary" />
              Notes
            </li>
            <li className="flex items-center gap-2">
              <CheckCircle className="w-5 h-5 text-primary" />
              Quizzes & practice
            </li>
          </ul>
        </section>
      </div>
    </div>
  );
}

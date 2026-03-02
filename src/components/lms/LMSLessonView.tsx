"use client";

import Link from "next/link";
import { ArrowLeft } from "lucide-react";
import { Button } from "@/design-system/components/ui/button";
import { CollapsibleSidebar } from "@/design-system/components/layout-components/collapsible-sidebar";
import { VideoResource } from "@/design-system/components/youtube-video";
import { InteractiveLessonView } from "./InteractiveLessonView";
import type { InteractiveStep, InteractiveQuizItem } from "./InteractiveLessonView";

interface Lesson {
  id: string;
  title: string;
  slug: string;
  lesson_order: number;
  is_preview: boolean;
  video_url?: string | null;
  lesson_type?: string | null;
  chapter?: {
    id: string;
    chapter_name: string;
    chapter_order: number;
    unit?: { id: string; unit_name: string; unit_order: number };
  };
}

interface LMSLessonViewProps {
  courseSlug: string;
  courseId: string;
  courseTitle: string;
  lesson: Lesson;
  allLessons: Lesson[];
  isEnrolled: boolean;
  completedLessonIds: Set<string>;
  interactiveContent: { intro?: string | null; steps: InteractiveStep[]; quiz: InteractiveQuizItem[] } | null;
  onMarkComplete: () => Promise<void>;
}

export function LMSLessonView({
  courseSlug,
  courseId,
  courseTitle,
  lesson,
  allLessons,
  isEnrolled,
  completedLessonIds,
  interactiveContent,
  onMarkComplete,
}: LMSLessonViewProps) {
  const isInteractive =
    lesson.lesson_type === "interactive" &&
    interactiveContent &&
    (interactiveContent.steps?.length > 0 || interactiveContent.quiz?.length > 0);

  return (
    <div className="flex flex-col lg:flex-row min-h-screen bg-background" data-template="lms-interactive">
      {/* Left: course sidebar (units/chapters/lessons) */}
      <CollapsibleSidebar
        currentLessonSlug={lesson.slug}
        courseSlug={courseSlug}
        lessons={allLessons}
        isEnrolled={isEnrolled}
        completedLessonIds={completedLessonIds}
        courseId={courseId}
      />
      {/* Right: main content — two-panel (question left, solution right) for interactive */}
      <main className="flex-1 min-w-0 px-4 md:px-6 py-6">
        <div className="mb-4">
          <Link
            href={`/learn/${courseSlug}`}
            className="inline-flex items-center text-sm text-muted-foreground hover:text-foreground"
          >
            <ArrowLeft className="w-4 h-4 mr-2" />
            Back to {courseTitle}
          </Link>
        </div>

        {isInteractive ? (
          <InteractiveLessonView
            lessonTitle={lesson.title}
            intro={interactiveContent?.intro}
            steps={interactiveContent?.steps ?? []}
            quiz={interactiveContent?.quiz ?? []}
            onComplete={onMarkComplete}
          />
        ) : lesson.video_url ? (
          <div className="max-w-4xl">
            <h1 className="text-2xl font-bold mb-4">{lesson.title}</h1>
            <VideoResource
              resource={{
                id: lesson.id,
                type: "video",
                url: lesson.video_url,
                title: lesson.title,
                thumbnail: undefined,
              }}
              lessonId={lesson.id}
            />
          </div>
        ) : (
          <div className="max-w-2xl">
            <h1 className="text-2xl font-bold mb-4">{lesson.title}</h1>
            <p className="text-muted-foreground">No video for this lesson yet.</p>
          </div>
        )}
      </main>
    </div>
  );
}

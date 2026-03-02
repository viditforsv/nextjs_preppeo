"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import { useAuth } from "@/contexts/AuthContext";
import { createClient } from "@/lib/supabase/client";
import { LMSLessonView } from "@/components/lms/LMSLessonView";
import { CourseChatbot } from "@/components/lms/CourseChatbot";
import { Button } from "@/design-system/components/ui/button";
import type { InteractiveStep, InteractiveQuizItem } from "@/components/lms/InteractiveLessonView";

const LMS_TEMPLATE_SLUG = "lms-interactive";

interface Lesson {
  id: string;
  title: string;
  slug: string;
  lesson_order: number;
  is_preview: boolean;
  video_url?: string | null;
  pdf_url?: string | null;
  lesson_type?: string | null;
  chapter?: {
    id: string;
    chapter_name: string;
    chapter_order: number;
    unit?: { id: string; unit_name: string; unit_order: number };
  };
}

export function LearnLessonPageClient({
  courseSlug,
  lessonSlug,
}: {
  courseSlug: string;
  lessonSlug: string;
}) {
  const { user, loading: authLoading } = useAuth();
  const [course, setCourse] = useState<{ id: string; title: string } | null>(null);
  const [lesson, setLesson] = useState<Lesson | null>(null);
  const [allLessons, setAllLessons] = useState<Lesson[]>([]);
  const [isEnrolled, setIsEnrolled] = useState(false);
  const [completedLessonIds, setCompletedLessonIds] = useState<Set<string>>(new Set());
  const [interactiveContent, setInteractiveContent] = useState<{
    intro?: string | null;
    steps: InteractiveStep[];
    quiz: InteractiveQuizItem[];
  } | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);
  const [chatbotOpen, setChatbotOpen] = useState(false);

  useEffect(() => {
    if (!courseSlug || !lessonSlug) return;

    const load = async () => {
      try {
        setIsLoading(true);
        setNotFound(false);

        const res = await fetch(`/api/courses/${courseSlug}/with-template`);
        if (!res.ok) {
          setNotFound(true);
          return;
        }
        const data = await res.json();
        const template = data.template;
        const courseData = data.course || data.rendered;
        if (!template || template.slug !== LMS_TEMPLATE_SLUG || !courseData) {
          setNotFound(true);
          return;
        }

        setCourse({ id: courseData.id, title: courseData.title });

        const supabase = createClient();
        const courseId = courseData.id;

        if (user) {
          const { data: enrollment } = await supabase
            .from("courses_enrollments")
            .select("id")
            .eq("student_id", user.id)
            .eq("course_id", courseId)
            .eq("is_active", true)
            .maybeSingle();
          setIsEnrolled(!!enrollment);

          const { data: progressList } = await supabase
            .from("user_progress")
            .select("lesson_id")
            .eq("user_id", user.id)
            .eq("course_id", courseId)
            .eq("is_completed", true);
          if (progressList) {
            setCompletedLessonIds(new Set(progressList.map((p) => p.lesson_id)));
          }
        }

        const { data: lessonsData, error: lessonsError } = await supabase
          .from("courses_lessons")
          .select(
            `
            id, title, slug, lesson_order, is_preview, video_url, pdf_url, lesson_type,
            chapter:courses_chapters(id, chapter_name, chapter_order, unit:courses_units(id, unit_name, unit_order))
          `
          )
          .eq("course_id", courseId)
          .order("lesson_order");

        if (lessonsError || !lessonsData?.length) {
          setNotFound(true);
          return;
        }

        const lessons = (lessonsData as unknown) as Lesson[];
        setAllLessons(lessons);

        const current = lessons.find((l) => l.slug === lessonSlug);
        if (!current) {
          setNotFound(true);
          return;
        }
        setLesson(current);

        if (current.lesson_type === "interactive") {
          const icRes = await fetch(`/api/lessons/${current.id}/interactive`);
          if (icRes.ok) {
            const ic = await icRes.json();
            setInteractiveContent({
              intro: ic.intro,
              steps: ic.steps || [],
              quiz: ic.quiz || [],
            });
          }
        }
      } catch {
        setNotFound(true);
      } finally {
        setIsLoading(false);
      }
    };

    load();
  }, [courseSlug, lessonSlug, user?.id]);

  const handleMarkComplete = async () => {
    if (!user || !lesson || !course) return;
    const supabase = createClient();
    const { data: existing } = await supabase
      .from("user_progress")
      .select("id")
      .eq("user_id", user.id)
      .eq("lesson_id", lesson.id)
      .maybeSingle();

    if (existing) {
      await supabase
        .from("user_progress")
        .update({
          completion_percentage: 100,
          is_completed: true,
          completed_at: new Date().toISOString(),
          last_accessed_at: new Date().toISOString(),
          updated_at: new Date().toISOString(),
        })
        .eq("id", existing.id);
    } else {
      await supabase.from("user_progress").insert({
        user_id: user.id,
        course_id: course.id,
        lesson_id: lesson.id,
        lesson_slug: lesson.slug,
        lesson_order: lesson.lesson_order,
        completion_percentage: 100,
        is_completed: true,
        completed_at: new Date().toISOString(),
        last_accessed_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      });
    }
    setCompletedLessonIds((prev) => new Set(prev).add(lesson.id));
  };

  if (authLoading || isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    );
  }

  if (notFound || !course || !lesson) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-4">Lesson not found</h1>
          <Link href={`/learn/${courseSlug}`}>
            <Button>Back to course</Button>
          </Link>
        </div>
      </div>
    );
  }

  return (
    <>
      <LMSLessonView
        courseSlug={courseSlug}
        courseId={course.id}
        courseTitle={course.title}
        lesson={lesson}
        allLessons={allLessons}
        isEnrolled={isEnrolled}
        completedLessonIds={completedLessonIds}
        interactiveContent={interactiveContent}
        onMarkComplete={handleMarkComplete}
      />
      <CourseChatbot
        courseTitle={course.title}
        lessonTitle={lesson.title}
        isOpen={chatbotOpen}
        onToggle={() => setChatbotOpen((o) => !o)}
      />
    </>
  );
}

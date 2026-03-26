"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/contexts/AuthContext";
import { createClient } from "@/lib/supabase/client";
import { LMSCourseOverview } from "@/components/lms/LMSCourseOverview";
import { CourseChatbot } from "@/components/lms/CourseChatbot";
import { Button } from "@/design-system/components/ui/button";
import Link from "next/link";

const LMS_TEMPLATE_SLUG = "lms-interactive";
/** Slugs that use the new learn UI even if template is not lms-interactive */
const LEARN_UI_SLUGS = ["sat-quant-learn"];

interface LearnCoursePageClientProps {
  courseSlug: string;
}

export function LearnCoursePageClient({ courseSlug }: LearnCoursePageClientProps) {
  const router = useRouter();
  const { user, loading: authLoading } = useAuth();
  const [course, setCourse] = useState<Record<string, unknown> | null>(null);
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const [_template, setTemplate] = useState<{ slug?: string } | null>(null);
  const [lessons, setLessons] = useState<Array<{ id: string; slug: string; title: string; lesson_order: number }>>([]);
  const [units, setUnits] = useState<Array<{ id: string; unit_name: string; unit_order: number }>>([]);
  const [chapters, setChapters] = useState<Array<{ id: string; chapter_name: string; chapter_order: number; unit_id: string }>>([]);
  const [isEnrolled, setIsEnrolled] = useState(false);
  const [lastLessonSlug, setLastLessonSlug] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);
  const [chatbotOpen, setChatbotOpen] = useState(false);

  useEffect(() => {
    if (!courseSlug) return;

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
        const courseData = data.course || data.rendered;
        const templateData = data.template;

        if (!courseData) {
          setNotFound(true);
          return;
        }

        const useLearnUI =
          templateData?.slug === LMS_TEMPLATE_SLUG ||
          LEARN_UI_SLUGS.includes(courseSlug);
        if (!useLearnUI) {
          setNotFound(true);
          return;
        }

        setCourse(courseData);
        setTemplate(templateData);

        const courseId = courseData.id as string;
        const supabase = createClient();

        if (user && courseId) {
          const { data: enrollment } = await supabase
            .from("courses_enrollments")
            .select("id")
            .eq("student_id", user.id)
            .eq("course_id", courseId)
            .eq("is_active", true)
            .maybeSingle();
          setIsEnrolled(!!enrollment);

          if (enrollment) {
            const { data: progress } = await supabase
              .from("user_progress")
              .select("lesson_slug")
              .eq("user_id", user.id)
              .eq("course_id", courseId)
              .order("last_accessed_at", { ascending: false })
              .limit(1)
              .maybeSingle();
            if (progress?.lesson_slug) setLastLessonSlug(progress.lesson_slug);
          }
        }

        const [unitsRes, chaptersRes, lessonsRes] = await Promise.all([
          fetch(`/api/courses/units?course_slug=${courseSlug}`),
          fetch(`/api/courses/chapters?course_slug=${courseSlug}`),
          fetch(`/api/lessons?course_slug=${courseSlug}&limit=1000`),
        ]);

        if (unitsRes.ok) {
          const u = await unitsRes.json();
          setUnits(u.units || []);
        }
        if (chaptersRes.ok) {
          const c = await chaptersRes.json();
          setChapters(c.chapters || []);
        }
        if (lessonsRes.ok) {
          const l = await lessonsRes.json();
          const list = (l.lessons || []).map((x: { id: string; slug: string; title: string; lesson_order: number }) => ({
            id: x.id,
            slug: x.slug,
            title: x.title,
            lesson_order: x.lesson_order,
          }));
          setLessons(list);
        }
      } catch {
        setNotFound(true);
      } finally {
        setIsLoading(false);
      }
    };

    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [courseSlug, user?.id]);

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    );
  }

  if (notFound || !course) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold mb-4">Course not found or not available here</h1>
          <p className="text-muted-foreground mb-6">
            This course does not use the Learn experience. Try the main course page.
          </p>
          <Link href={`/courses/${courseSlug}`}>
            <Button>Go to course page</Button>
          </Link>
        </div>
      </div>
    );
  }

  const firstLesson = lessons.length > 0 ? lessons.sort((a, b) => a.lesson_order - b.lesson_order)[0] : null;
  const continueSlug = lastLessonSlug || firstLesson?.slug;

  const courseTitle = (course.title as string) || "Course";

  return (
    <>
      <LMSCourseOverview
        course={course}
        courseSlug={courseSlug}
        lessons={lessons}
        units={units}
        chapters={chapters}
        isEnrolled={isEnrolled}
        isAuthenticated={!!user}
        authLoading={authLoading}
        continueLessonSlug={continueSlug ?? null}
        coursePrice={Number(course.price) || 0}
        onEnroll={async () => {
        if (!user) {
          router.push(`/auth?redirect=${encodeURIComponent(`/learn/${courseSlug}`)}`);
          return;
        }
        const coursePrice = Number(course.price) || 0;
        if (coursePrice > 0) {
          router.push(`/courses/${courseSlug}/payment`);
          return;
        }
        const courseId = course.id as string;
        const supabase = createClient();
        const { error } = await supabase.from("courses_enrollments").insert({
          student_id: user.id,
          course_id: courseId,
          is_active: true,
        });
        if (error) {
          if (error.code === "23505") setIsEnrolled(true);
          else alert("Enrollment failed. Please try again.");
          return;
        }
        setIsEnrolled(true);
        if (firstLesson) router.push(`/learn/${courseSlug}/lesson/${firstLesson.slug}`);
      }}
      />
      <CourseChatbot
        courseTitle={courseTitle}
        isOpen={chatbotOpen}
        onToggle={() => setChatbotOpen((o) => !o)}
      />
    </>
  );
}

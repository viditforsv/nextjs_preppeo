import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

const DIFFICULTY_BANDS = {
  easy: { min: 1, max: 3 },
  medium: { min: 4, max: 6 },
  hard: { min: 7, max: 10 },
} as const;

export type AttemptStatusFilter =
  | "unattempted"
  | "correct"
  | "hint"
  | "wrong"
  | "skipped"
  | "";

export interface PracticeQuestionItem {
  order: number;
  question_id: string | null;
  difficulty: number | null;
  topic: string | null;
  question?: string;
  lastAttempt?: {
    time_taken_seconds: number;
    is_correct: boolean;
    skipped: boolean;
    hint_used: boolean;
  };
}

export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ lessonId: string }> }
) {
  try {
    const { lessonId } = await params;
    if (!lessonId) {
      return NextResponse.json(
        { error: "Lesson ID is required" },
        { status: 400 }
      );
    }

    const supabase = await createClient();
    const { searchParams } = new URL(request.url);

    const difficultyFilter = searchParams.get("difficulty") as
      | "easy"
      | "medium"
      | "hard"
      | null;
    const statusFilter = searchParams.get("status") as AttemptStatusFilter | null;

    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();
    if (authError || !user) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { data: content, error: contentError } = await supabase
      .from("lesson_interactive_content")
      .select("quiz")
      .eq("lesson_id", lessonId)
      .single();

    if (contentError || !content?.quiz) {
      return NextResponse.json(
        { error: "No interactive content for this lesson" },
        { status: 404 }
      );
    }

    const quiz = Array.isArray(content.quiz) ? content.quiz : [];
    const questionIds = quiz
      .map((item: { id?: string }) => item?.id)
      .filter((id): id is string => typeof id === "string" && id.length > 0);

    let questionBankMap: Record<string, { difficulty: number; topic: string | null }> = {};
    if (questionIds.length > 0) {
      const { data: questions } = await supabase
        .from("question_bank")
        .select("id, difficulty, topic")
        .in("id", questionIds);
      if (questions) {
        questionBankMap = questions.reduce(
          (acc, q) => {
            acc[q.id] = {
              difficulty: q.difficulty ?? 0,
              topic: q.topic ?? null,
            };
            return acc;
          },
          {} as Record<string, { difficulty: number; topic: string | null }>
        );
      }
    }

    let attemptsMap: Record<
      string,
      { time_taken_seconds: number; is_correct: boolean; skipped: boolean; hint_used: boolean }
    > = {};
    const { data: attempts } = await supabase
      .from("student_performance_log")
      .select("question_id, time_taken_seconds, is_correct, skipped, hint_used, created_at")
      .eq("student_id", user.id)
      .eq("lesson_id", lessonId)
      .order("created_at", { ascending: false });

    if (attempts) {
      const seen = new Set<string>();
      for (const a of attempts) {
        if (a.question_id && !seen.has(a.question_id)) {
          seen.add(a.question_id);
          attemptsMap[a.question_id] = {
            time_taken_seconds: a.time_taken_seconds ?? 0,
            is_correct: a.is_correct ?? false,
            skipped: a.skipped ?? false,
            hint_used: a.hint_used ?? false,
          };
        }
      }
    }

    const { data: lesson } = await supabase
      .from("courses_lessons")
      .select("course_id, chapter_id")
      .eq("id", lessonId)
      .single();

    let chapterName: string | null = null;
    if (lesson?.chapter_id) {
      const { data: ch } = await supabase
        .from("courses_chapters")
        .select("chapter_name")
        .eq("id", lesson.chapter_id)
        .single();
      chapterName = ch?.chapter_name ?? null;
    }

    const items: PracticeQuestionItem[] = quiz.map(
      (
        item: {
          id?: string;
          question?: string;
          options?: string[];
          answer?: number;
          explanation?: string;
        },
        index: number
      ) => {
        const qId = item?.id ?? null;
        const meta = qId ? questionBankMap[qId] : null;
        const lastAttempt = qId ? attemptsMap[qId] : undefined;
        return {
          order: index + 1,
          question_id: qId,
          difficulty: meta?.difficulty ?? null,
          topic: meta?.topic ?? null,
          question: item?.question,
          lastAttempt,
        };
      }
    );

    let filtered = items;

    if (difficultyFilter && DIFFICULTY_BANDS[difficultyFilter]) {
      const { min, max } = DIFFICULTY_BANDS[difficultyFilter];
      filtered = filtered.filter(
        (i) => i.difficulty !== null && i.difficulty >= min && i.difficulty <= max
      );
    }

    if (statusFilter) {
      filtered = filtered.filter((i) => {
        const a = i.lastAttempt;
        switch (statusFilter) {
          case "unattempted":
            return a === undefined;
          case "correct":
            return a !== undefined && a.is_correct && !a.hint_used;
          case "hint":
            return a !== undefined && a.is_correct && a.hint_used;
          case "wrong":
            return a !== undefined && !a.is_correct && !a.skipped;
          case "skipped":
            return a !== undefined && a.skipped;
          default:
            return true;
        }
      });
    }

    return NextResponse.json({
      lessonId,
      courseId: lesson?.course_id ?? null,
      chapterName,
      questions: filtered,
    });
  } catch (e) {
    console.error("practice-questions GET:", e);
    return NextResponse.json(
      { error: e instanceof Error ? e.message : "Internal server error" },
      { status: 500 }
    );
  }
}

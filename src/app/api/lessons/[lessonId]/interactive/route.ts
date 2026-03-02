import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

export async function GET(
  _request: Request,
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
    const { data, error } = await supabase
      .from("lesson_interactive_content")
      .select("id, lesson_id, intro, steps, quiz")
      .eq("lesson_id", lessonId)
      .single();

    if (error) {
      if (error.code === "PGRST116") {
        return NextResponse.json(
          { error: "No interactive content for this lesson" },
          { status: 404 }
        );
      }
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    return NextResponse.json({
      intro: data?.intro ?? null,
      steps: data?.steps ?? [],
      quiz: data?.quiz ?? [],
    });
  } catch (e) {
    return NextResponse.json(
      { error: e instanceof Error ? e.message : "Failed to fetch" },
      { status: 500 }
    );
  }
}

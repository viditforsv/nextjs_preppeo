// Server-side data layer for the SAT Self-Learn course (/sat/learn).
//
// Content is read with the SERVICE ROLE client (bypasses RLS); the current
// user is resolved from auth cookies. Gating is enforced HERE — gated fields
// (video_url / body / pdf_url / quiz_config) are only returned when the viewer
// is entitled (admin || free-preview item || active course enrollment).

import "server-only";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";
import { createClient } from "@/lib/supabase/server";
import type {
  SatLearnCourse,
  SatLearnCourseDetail,
  SatLearnFlashcard,
  SatLearnItemFull,
  SatLearnItemMeta,
  SatLearnQuizQuestion,
  SatLearnSubject,
  SatLearnTopicWithItems,
} from "@/types/sat-learn";

interface Viewer {
  userId: string | null;
  isAdmin: boolean;
}

/** Resolve the current viewer (id + admin flag) from auth cookies. */
export async function getViewer(): Promise<Viewer> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { userId: null, isAdmin: false };

  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .single();

  return { userId: user.id, isAdmin: profile?.role === "admin" };
}

/* ── Row mappers ──────────────────────────────────────────────── */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
function mapCourse(r: any): SatLearnCourse {
  return {
    id: r.id,
    title: r.title,
    slug: r.slug,
    subject: r.subject as SatLearnSubject,
    tagline: r.tagline,
    description: r.description,
    priceInr: r.price_inr,
    priceUsd: r.price_usd,
    sortOrder: r.sort_order,
    isPublished: r.is_published,
  };
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
function mapItemMeta(r: any, completedIds: Set<string>): SatLearnItemMeta {
  return {
    id: r.id,
    topicId: r.topic_id,
    title: r.title,
    slug: r.slug,
    type: r.type,
    sortOrder: r.sort_order,
    isFreePreview: r.is_free_preview,
    durationSeconds: r.duration_seconds,
    completed: completedIds.has(r.id),
  };
}

/* ── Queries ──────────────────────────────────────────────────── */

/** All published courses, ordered. */
export async function listCourses(): Promise<SatLearnCourse[]> {
  const db = createSupabaseApiClient();
  const { data } = await db
    .from("sat_learn_courses")
    .select("*")
    .eq("is_published", true)
    .order("sort_order");
  return (data ?? []).map(mapCourse);
}

/** Published-topic count per course id (for the landing page). */
export async function topicCountsByCourse(
  courseIds: string[]
): Promise<Record<string, number>> {
  if (courseIds.length === 0) return {};
  const db = createSupabaseApiClient();
  const { data } = await db
    .from("sat_learn_topics")
    .select("course_id")
    .in("course_id", courseIds)
    .eq("is_published", true);
  const counts: Record<string, number> = {};
  for (const r of data ?? []) counts[r.course_id] = (counts[r.course_id] ?? 0) + 1;
  return counts;
}

/** Whether the viewer has an active enrollment in a course. */
async function isEnrolled(userId: string | null, courseId: string): Promise<boolean> {
  if (!userId) return false;
  const db = createSupabaseApiClient();
  const { data } = await db
    .from("sat_learn_enrollments")
    .select("expires_at")
    .eq("user_id", userId)
    .eq("course_id", courseId)
    .maybeSingle();
  if (!data) return false;
  if (!data.expires_at) return true;
  return new Date(data.expires_at).getTime() > Date.now();
}

/** Item ids the viewer has completed, scoped to a set of items. */
async function completedItemIds(
  userId: string | null,
  itemIds: string[]
): Promise<Set<string>> {
  if (!userId || itemIds.length === 0) return new Set();
  const db = createSupabaseApiClient();
  const { data } = await db
    .from("sat_learn_progress")
    .select("item_id")
    .eq("user_id", userId)
    .in("item_id", itemIds);
  return new Set((data ?? []).map((r) => r.item_id));
}

/** Full course curriculum (published topics + items) + viewer access state. */
export async function getCourseDetail(
  slug: string
): Promise<SatLearnCourseDetail | null> {
  const db = createSupabaseApiClient();
  const { data: courseRow } = await db
    .from("sat_learn_courses")
    .select("*")
    .eq("slug", slug)
    .eq("is_published", true)
    .maybeSingle();
  if (!courseRow) return null;
  const course = mapCourse(courseRow);

  const { data: topicRows } = await db
    .from("sat_learn_topics")
    .select("*")
    .eq("course_id", course.id)
    .eq("is_published", true)
    .order("sort_order");

  const topicIds = (topicRows ?? []).map((t) => t.id);
  const { data: itemRows } = topicIds.length
    ? await db
        .from("sat_learn_items")
        .select(
          "id, topic_id, title, slug, type, sort_order, is_free_preview, duration_seconds"
        )
        .in("topic_id", topicIds)
        .eq("is_published", true)
        .order("sort_order")
    : { data: [] };

  const viewer = await getViewer();
  const enrolled = await isEnrolled(viewer.userId, course.id);
  const completed = await completedItemIds(
    viewer.userId,
    (itemRows ?? []).map((i) => i.id)
  );

  const topics: SatLearnTopicWithItems[] = (topicRows ?? []).map((t) => ({
    id: t.id,
    courseId: t.course_id,
    title: t.title,
    slug: t.slug,
    domain: t.domain,
    description: t.description,
    icon: t.icon,
    sortOrder: t.sort_order,
    isPublished: t.is_published,
    items: (itemRows ?? [])
      .filter((i) => i.topic_id === t.id)
      .map((i) => mapItemMeta(i, completed)),
  }));

  return {
    ...course,
    topics,
    isEnrolled: enrolled,
    isAdmin: viewer.isAdmin,
  };
}

/**
 * One item with content, gated. Returns null if not found. When the viewer
 * isn't entitled, gated fields are nulled and `locked` is true.
 */
export async function getItemFull(
  courseSlug: string,
  topicSlug: string,
  itemSlug: string
): Promise<SatLearnItemFull | null> {
  const db = createSupabaseApiClient();

  // Resolve course → topic → item with simple, robust lookups.
  const { data: course } = await db
    .from("sat_learn_courses")
    .select("id")
    .eq("slug", courseSlug)
    .eq("is_published", true)
    .maybeSingle();
  if (!course) return null;

  const { data: topic } = await db
    .from("sat_learn_topics")
    .select("id")
    .eq("course_id", course.id)
    .eq("slug", topicSlug)
    .eq("is_published", true)
    .maybeSingle();
  if (!topic) return null;

  const { data: row } = await db
    .from("sat_learn_items")
    .select("*")
    .eq("topic_id", topic.id)
    .eq("slug", itemSlug)
    .eq("is_published", true)
    .maybeSingle();
  if (!row) return null;

  const courseId = course.id as string;
  const viewer = await getViewer();
  const enrolled = await isEnrolled(viewer.userId, courseId);
  const completed = await completedItemIds(viewer.userId, [row.id]);
  const entitled = viewer.isAdmin || row.is_free_preview || enrolled;

  const meta = mapItemMeta(row, completed);
  return {
    ...meta,
    locked: !entitled,
    videoUrl: entitled ? row.video_url : null,
    videoProvider: row.video_provider,
    body: entitled ? row.body : null,
    pdfUrl: entitled ? row.pdf_url : null,
    quizConfig: entitled ? row.quiz_config : null,
  };
}

/** Flashcards for a flashcard item (only call once entitlement is confirmed). */
export async function getFlashcards(itemId: string): Promise<SatLearnFlashcard[]> {
  const db = createSupabaseApiClient();
  const { data } = await db
    .from("sat_learn_flashcards")
    .select("id, front, back, section")
    .eq("item_id", itemId)
    .order("sort_order");
  return (data ?? []) as SatLearnFlashcard[];
}

/** Concept-check questions for a quiz item (only call once entitled). */
export async function getQuizQuestions(
  itemId: string
): Promise<SatLearnQuizQuestion[]> {
  const db = createSupabaseApiClient();
  const { data } = await db
    .from("sat_learn_quiz_questions")
    .select("id, question, options, correct_answer, explanation")
    .eq("item_id", itemId)
    .order("sort_order");
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return (data ?? []).map((r: any) => ({
    id: r.id,
    question: r.question,
    options: r.options,
    correctAnswer: r.correct_answer,
    explanation: r.explanation,
  }));
}

import { LearnLessonPageClient } from "./LearnLessonPageClient";

export default async function LearnLessonPage({
  params,
}: {
  params: Promise<{ courseSlug: string; lessonSlug: string }>;
}) {
  const { courseSlug, lessonSlug } = await params;
  return (
    <LearnLessonPageClient courseSlug={courseSlug} lessonSlug={lessonSlug} />
  );
}

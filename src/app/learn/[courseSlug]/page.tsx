import { LearnCoursePageClient } from "./LearnCoursePageClient";

export default async function LearnCoursePage({
  params,
}: {
  params: Promise<{ courseSlug: string }>;
}) {
  const { courseSlug } = await params;
  return <LearnCoursePageClient courseSlug={courseSlug} />;
}

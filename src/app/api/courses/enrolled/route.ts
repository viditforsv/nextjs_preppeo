import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function GET() {
  try {
    const supabase = await createClient();
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();

    if (authError || !user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const service = createSupabaseApiClient();

    // Fetch enrollments with course data (service role bypasses RLS)
    const { data, error } = await service
      .from('courses_enrollments')
      .select('*, courses (*)')
      .eq('student_id', user.id)
      .eq('is_active', true)
      .order('enrolled_at', { ascending: false });

    if (error) {
      console.error('Error fetching enrollments:', error.message);
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    // For each course, fetch lesson count + progress in parallel
    const courses = await Promise.all(
      (data || [])
        .filter((item) => !!item.courses)
        .map(async (item) => {
          const course = item.courses;

          const [
            { count: totalLessons },
            { count: completedLessons },
            { data: progressData },
          ] = await Promise.all([
            service
              .from('courses_lessons')
              .select('*', { count: 'exact', head: true })
              .eq('course_id', course.id),
            service
              .from('user_progress')
              .select('*', { count: 'exact', head: true })
              .eq('user_id', user.id)
              .eq('course_id', course.id)
              .eq('completed', true),
            service
              .from('user_progress')
              .select('time_spent_minutes')
              .eq('user_id', user.id)
              .eq('course_id', course.id),
          ]);

          const timeSpent =
            progressData?.reduce((sum, p) => sum + (p.time_spent_minutes || 0), 0) || 0;
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

    // Study streak from user_progress.last_accessed_at
    const { data: streakData } = await service
      .from('user_progress')
      .select('last_accessed_at')
      .eq('user_id', user.id)
      .order('last_accessed_at', { ascending: false });

    const studyStreak = calculateStreak(streakData || []);

    return NextResponse.json({ courses, studyStreak });
  } catch (err) {
    console.error('Error in GET /api/courses/enrolled:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

function calculateStreak(progressData: { last_accessed_at: string }[]): number {
  if (!progressData.length) return 0;

  const uniqueDates = [
    ...new Set(progressData.map((p) => new Date(p.last_accessed_at).toDateString())),
  ]
    .map((d) => new Date(d))
    .sort((a, b) => b.getTime() - a.getTime());

  let streak = 0;
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  for (let i = 0; i < uniqueDates.length; i++) {
    const check = new Date(today);
    check.setDate(today.getDate() - i);
    check.setHours(0, 0, 0, 0);

    const hasActivity = uniqueDates.some((d) => {
      const activityDate = new Date(d);
      activityDate.setHours(0, 0, 0, 0);
      return activityDate.getTime() === check.getTime();
    });

    if (hasActivity) {
      streak++;
    } else {
      break;
    }
  }

  return streak;
}

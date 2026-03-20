import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { sendTransactionalEmail } from '@/lib/email/send';
import { courseEnrollmentEmail } from '@/lib/email/templates';

export async function POST(request: NextRequest) {
  try {
    const authClient = await createClient();
    const { data: { user }, error: authError } = await authClient.auth.getUser();

    if (!user || authError) {
      return NextResponse.json({ error: 'Authentication required' }, { status: 401 });
    }

    const { courseId } = await request.json();
    if (!courseId || typeof courseId !== 'string') {
      return NextResponse.json({ error: 'courseId is required' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();

    const { data: enrollment, error: enrollError } = await supabase
      .from('courses_enrollments')
      .insert({
        student_id: user.id,
        course_id: courseId,
        is_active: true,
      })
      .select()
      .single();

    if (enrollError) {
      if (enrollError.code === '23505') {
        return NextResponse.json({ error: 'Already enrolled in this course' }, { status: 409 });
      }
      console.error('Enrollment insert error:', enrollError);
      return NextResponse.json({ error: 'Failed to enroll' }, { status: 500 });
    }

    try {
      const [profileRes, courseRes] = await Promise.all([
        supabase.from('profiles').select('first_name, email').eq('id', user.id).single(),
        supabase.from('courses').select('title').eq('id', courseId).single(),
      ]);

      const firstName = profileRes.data?.first_name || '';
      const emailAddr = profileRes.data?.email || user.email || '';
      const courseTitle = courseRes.data?.title || 'your course';

      if (emailAddr) {
        const { subject, html } = courseEnrollmentEmail(firstName, courseTitle);
        await sendTransactionalEmail({
          to: emailAddr,
          toName: firstName || undefined,
          subject,
          htmlBody: html,
        });
      }
    } catch (err) {
      console.error('Enrollment email failed (non-blocking):', err);
    }

    return NextResponse.json({ success: true, enrollment });
  } catch (error) {
    console.error('Error in POST /api/enrollments/enroll:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

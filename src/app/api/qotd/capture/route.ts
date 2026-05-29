import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { sendTransactionalEmail } from '@/lib/email/send';
import { QOTD_ROTATION } from '@/lib/qotd/questions';

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL || 'https://preppeo.com';

function welcomeEmailHtml(): string {
  return `
  <div style="font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;max-width:520px;margin:0 auto;color:#1f2937;">
    <div style="background:#0d47a1;padding:24px;border-radius:12px 12px 0 0;">
      <h1 style="color:#fff;margin:0;font-size:20px;">You unlocked today's breakdown 🔓</h1>
    </div>
    <div style="padding:24px;border:1px solid #e5e7eb;border-top:none;border-radius:0 0 12px 12px;">
      <p style="margin:0 0 14px;font-size:15px;line-height:1.6;">
        Nice — the full AI Concept Breakdown is now showing on the page.
        A genuinely brutal SAT Math question drops every day, each with the same
        step-by-step logic explained.
      </p>
      <p style="margin:0 0 20px;font-size:15px;line-height:1.6;">
        Want this for every question type, adapting to where you actually lose points?
        That's what Preppeo's adaptive SAT prep does.
      </p>
      <a href="${SITE_URL}/sat-test"
         style="display:inline-block;background:#0d47a1;color:#fff;text-decoration:none;padding:12px 22px;border-radius:8px;font-weight:600;font-size:15px;">
        Try a full adaptive mock →
      </a>
      <p style="margin:22px 0 0;font-size:13px;color:#6b7280;line-height:1.6;">
        Come back tomorrow for the next one — preppeo.com/question-of-the-day
      </p>
    </div>
  </div>`;
}

/**
 * POST /api/qotd/capture
 * Body: { email: string, questionId: string }
 *
 * Records the email as a QOTD lead (dev/prod table per env), sends a one-time
 * welcome email on the visitor's first-ever capture, and returns the full
 * explanation so the page can reveal the (previously blurred) breakdown.
 *
 * questionId must belong to the current rotation — this endpoint is the gate,
 * so it never returns an explanation for an arbitrary question id.
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json().catch(() => null);
    const email = typeof body?.email === 'string' ? body.email.trim().toLowerCase() : '';
    const questionId = typeof body?.questionId === 'string' ? body.questionId : '';

    if (!EMAIL_RE.test(email) || email.length > 254) {
      return NextResponse.json({ error: 'Please enter a valid email address.' }, { status: 400 });
    }

    const rotationIndex = QOTD_ROTATION.findIndex((q) => q.id === questionId);
    if (rotationIndex === -1) {
      return NextResponse.json({ error: 'Unknown question.' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();

    const { data: questionRow, error: qErr } = await supabase
      .from('sat_questions')
      .select('explanation')
      .eq('id', questionId)
      .eq('is_active', true)
      .maybeSingle();

    if (qErr || !questionRow) {
      console.error('QOTD capture: question lookup failed', qErr);
      return NextResponse.json({ error: 'Question unavailable.' }, { status: 404 });
    }

    // First-ever capture for this email? Decides whether to send the welcome email.
    const { count: priorCount } = await supabase
      .from('qotd_leads')
      .select('id', { count: 'exact', head: true })
      .eq('email', email);

    const isNewLead = (priorCount ?? 0) === 0;

    const { error: insertErr } = await supabase.from('qotd_leads').insert({
      email,
      question_id: questionId,
      rotation_index: rotationIndex,
      source: 'qotd',
      user_agent: request.headers.get('user-agent')?.slice(0, 500) ?? null,
    });

    // Duplicate (same email + question) is fine — they already unlocked it.
    if (insertErr && insertErr.code !== '23505') {
      console.error('QOTD capture: insert failed', insertErr);
      return NextResponse.json({ error: 'Could not save your email. Try again.' }, { status: 500 });
    }

    if (isNewLead) {
      // Awaited so the send completes on serverless before the function returns.
      await sendTransactionalEmail({
        to: email,
        subject: 'Your SAT Question of the Day breakdown is unlocked',
        htmlBody: welcomeEmailHtml(),
      });
    }

    return NextResponse.json({ breakdown: questionRow.explanation ?? '' });
  } catch (err) {
    console.error('Error in POST /api/qotd/capture:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

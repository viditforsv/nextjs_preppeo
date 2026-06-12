import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { sendTransactionalEmail } from '@/lib/email/send';

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

// Marketing attribution: a referral link like /sat-free?ref=va stores ?ref in
// sessionStorage, which the results screen forwards here. Normalise to a safe
// slug so a crafted value can't write junk to the leads table. NULL when absent.
function normaliseRef(raw: unknown): string | null {
  if (typeof raw !== 'string') return null;
  const cleaned = raw.trim().toLowerCase().replace(/[^a-z0-9_-]/g, '').slice(0, 40);
  return cleaned.length > 0 ? cleaned : null;
}

// A score that made it through the client is already an integer in 400–1600 (or
// a per-section 200–800). Clamp defensively and drop anything non-finite.
function toScore(raw: unknown): number | null {
  const n = typeof raw === 'number' ? raw : Number(raw);
  if (!Number.isFinite(n)) return null;
  return Math.max(0, Math.min(1600, Math.round(n)));
}

// Canonical public domain for marketing emails. Hardcoded on purpose: links
// already sitting in someone's inbox can't be fixed by a redeploy, so they must
// not depend on a build-time env var. See DOCS_FOR_AI_AGENT/PRODUCTION_URLS_AND_DOMAINS.md.
const SITE_URL = 'https://preppeo.com';

function reportEmailHtml(totalScore: number | null): string {
  const scoreLine = totalScore
    ? `You scored an estimated <strong>${totalScore}</strong> on your free Digital SAT mock.`
    : `You just finished your free Digital SAT mock.`;
  return `
  <div style="font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;max-width:520px;margin:0 auto;color:#1f2937;">
    <div style="background:#0d47a1;padding:24px;border-radius:12px 12px 0 0;">
      <h1 style="color:#fff;margin:0;font-size:20px;">Your SAT mock report is unlocked 🔓</h1>
    </div>
    <div style="padding:24px;border:1px solid #e5e7eb;border-top:none;border-radius:0 0 12px 12px;">
      <p style="margin:0 0 14px;font-size:15px;line-height:1.6;">
        ${scoreLine} Your full report — domain-by-domain breakdown, difficulty &amp;
        time analysis, and a question-by-question review — is showing on the page now.
      </p>
      <p style="margin:0 0 20px;font-size:15px;line-height:1.6;">
        Create a free account to <strong>save this report</strong>, track your score
        across mocks, and target your weak domains with adaptive practice.
      </p>
      <a href="${SITE_URL}/sat-free"
         style="display:inline-block;background:#0d47a1;color:#fff;text-decoration:none;padding:12px 22px;border-radius:8px;font-weight:600;font-size:15px;">
        Save my progress →
      </a>
      <p style="margin:22px 0 0;font-size:13px;color:#6b7280;line-height:1.6;">
        Students who take 3+ mocks see the biggest score gains — each Preppeo mock
        uses a unique question bank. <a href="${SITE_URL}/pricing" style="color:#0d47a1;text-decoration:none;">See mock packs</a>
      </p>
    </div>
  </div>`;
}

/**
 * POST /api/sat-free/lead
 * Body: { email, ref?, totalScore?, mathScore?, rwScore? }
 *
 * Captures an anonymous free-mock finisher's email so a non-converting visitor
 * is no longer lost. Records the lead (dev/prod table per env) and sends a
 * one-time report email on the first-ever capture for that address.
 *
 * Best-effort by design: the results screen unlocks the report regardless of
 * this call's outcome, so failures here never block the user.
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json().catch(() => null);
    const email = typeof body?.email === 'string' ? body.email.trim().toLowerCase() : '';

    if (!EMAIL_RE.test(email) || email.length > 254) {
      return NextResponse.json({ error: 'Please enter a valid email address.' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();

    // First-ever capture for this email? Decides whether to send the report email.
    const { count: priorCount } = await supabase
      .from('free_mock_leads')
      .select('id', { count: 'exact', head: true })
      .eq('email', email);

    const isNewLead = (priorCount ?? 0) === 0;
    const totalScore = toScore(body?.totalScore);

    const { error: insertErr } = await supabase.from('free_mock_leads').insert({
      email,
      total_score: totalScore,
      math_score: toScore(body?.mathScore),
      rw_score: toScore(body?.rwScore),
      source: 'free_mock',
      ref: normaliseRef(body?.ref),
      user_agent: request.headers.get('user-agent')?.slice(0, 500) ?? null,
    });

    // Duplicate email (unique index) is fine — they already captured before.
    if (insertErr && insertErr.code !== '23505') {
      console.error('Free-mock lead: insert failed', insertErr);
      return NextResponse.json({ error: 'Could not save your email. Try again.' }, { status: 500 });
    }

    if (isNewLead) {
      // Awaited so the send completes on serverless before the function returns.
      await sendTransactionalEmail({
        to: email,
        subject: 'Your free SAT mock report is unlocked',
        htmlBody: reportEmailHtml(totalScore),
      });
    }

    return NextResponse.json({ success: true });
  } catch (err) {
    console.error('Error in POST /api/sat-free/lead:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

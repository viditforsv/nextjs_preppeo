import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { sendTransactionalEmail } from '@/lib/email/send';

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

// Minimum gap between report emails to the same address. Invisible to real
// re-attempts (a full mock runs ~2h) but caps rapid/abusive resends.
const EMAIL_THROTTLE_MS = 10 * 60 * 1000;

// Server-side whitelist of domain keys → labels. The client sends domain keys
// only; anything not in this map is dropped, so no untrusted string is ever
// rendered into the email HTML.
const SAT_DOMAIN_LABELS: Record<string, string> = {
  algebra: 'Algebra',
  'advanced-math': 'Advanced Math',
  'problem-solving': 'Problem Solving & Data',
  'geometry-trig': 'Geometry & Trig',
  'craft-structure': 'Craft & Structure',
  'information-ideas': 'Information & Ideas',
  'standard-english': 'Standard English',
  'expression-of-ideas': 'Expression of Ideas',
};

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

function clampInt(raw: unknown, max: number): number {
  const n = typeof raw === 'number' ? raw : Number(raw);
  if (!Number.isFinite(n)) return 0;
  return Math.max(0, Math.min(max, Math.round(n)));
}

interface Tally { correct: number; total: number }
interface ReportSummary {
  correct: number;
  answered: number;
  sections: { math: Tally; rw: Tally };
  domains: { label: string; section: 'math' | 'rw'; correct: number; total: number }[];
  difficulty: { easy: Tally; medium: Tally; hard: Tally };
}

// The report summary is client-sent and untrusted: clamp every number, cap array
// length, and resolve domain labels server-side from the whitelist above.
function sanitizeReport(raw: unknown): ReportSummary | null {
  if (!raw || typeof raw !== 'object') return null;
  const r = raw as Record<string, unknown>;

  const tally = (o: unknown, max: number): Tally => {
    const t = (o ?? {}) as Record<string, unknown>;
    const total = clampInt(t.total, max);
    return { correct: Math.min(clampInt(t.correct, max), total), total };
  };

  const answered = clampInt(r.answered, 200);
  const correct = Math.min(clampInt(r.correct, 200), answered);

  const sectionsRaw = (r.sections ?? {}) as Record<string, unknown>;
  const diffRaw = (r.difficulty ?? {}) as Record<string, unknown>;

  const domains = (Array.isArray(r.domains) ? r.domains.slice(0, 12) : [])
    .map((d): ReportSummary['domains'][number] | null => {
      const item = (d ?? {}) as Record<string, unknown>;
      const label = SAT_DOMAIN_LABELS[typeof item.key === 'string' ? item.key : ''];
      if (!label) return null;
      const total = clampInt(item.total, 60);
      return {
        label,
        section: item.section === 'math' ? 'math' : 'rw',
        correct: Math.min(clampInt(item.correct, 60), total),
        total,
      };
    })
    .filter((d): d is ReportSummary['domains'][number] => d !== null);

  return {
    correct,
    answered,
    sections: { math: tally(sectionsRaw.math, 100), rw: tally(sectionsRaw.rw, 100) },
    domains,
    difficulty: {
      easy: tally(diffRaw.easy, 200),
      medium: tally(diffRaw.medium, 200),
      hard: tally(diffRaw.hard, 200),
    },
  };
}

function pct(c: number, t: number): number {
  return t > 0 ? Math.round((c / t) * 100) : 0;
}

// Canonical public domain for marketing emails. Hardcoded on purpose: links
// already sitting in someone's inbox can't be fixed by a redeploy, so they must
// not depend on a build-time env var. See DOCS_FOR_AI_AGENT/PRODUCTION_URLS_AND_DOMAINS.md.
const SITE_URL = 'https://preppeo.com';

function row(label: string, correct: number, total: number): string {
  return `
    <tr>
      <td style="padding:8px 12px;border-bottom:1px solid #eef0f3;font-size:14px;color:#374151;">${label}</td>
      <td style="padding:8px 12px;border-bottom:1px solid #eef0f3;font-size:14px;color:#111827;text-align:right;font-weight:600;white-space:nowrap;">${correct}/${total}</td>
      <td style="padding:8px 12px;border-bottom:1px solid #eef0f3;font-size:14px;color:#6b7280;text-align:right;white-space:nowrap;">${pct(correct, total)}%</td>
    </tr>`;
}

function tableBlock(title: string, rows: string): string {
  if (!rows) return '';
  return `
    <p style="margin:20px 0 6px;font-size:12px;font-weight:700;text-transform:uppercase;letter-spacing:.05em;color:#0d47a1;">${title}</p>
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;border:1px solid #eef0f3;border-radius:8px;overflow:hidden;">
      ${rows}
    </table>`;
}

function reportEmailHtml(
  scores: { total: number | null; math: number | null; rw: number | null },
  report: ReportSummary | null,
): string {
  const { total, math, rw } = scores;

  let body = `
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;background:#f0f5fb;border-radius:12px;margin:0 0 8px;">
      <tr><td style="padding:22px;text-align:center;">
        <p style="margin:0 0 4px;font-size:13px;font-weight:600;color:#6b7280;">Your estimated SAT score</p>
        <p style="margin:0 0 6px;font-size:46px;font-weight:800;line-height:1;color:#0d47a1;">${total ?? '—'}</p>
        <p style="margin:0;font-size:14px;color:#374151;">Reading &amp; Writing <strong>${rw ?? '—'}</strong> &nbsp;·&nbsp; Math <strong>${math ?? '—'}</strong></p>
      </td></tr>
    </table>`;

  if (report && report.answered > 0) {
    body += `<p style="margin:6px 0 0;font-size:14px;color:#374151;text-align:center;">Overall: <strong>${report.correct}/${report.answered}</strong> correct (${pct(report.correct, report.answered)}%)</p>`;

    const mathDomains = report.domains.filter((d) => d.section === 'math');
    const rwDomains = report.domains.filter((d) => d.section === 'rw');

    body += tableBlock(
      'Reading &amp; Writing — by domain',
      rwDomains.map((d) => row(d.label, d.correct, d.total)).join(''),
    );
    body += tableBlock(
      'Math — by domain',
      mathDomains.map((d) => row(d.label, d.correct, d.total)).join(''),
    );

    const { easy, medium, hard } = report.difficulty;
    const diffRows =
      (easy.total ? row('Easy', easy.correct, easy.total) : '') +
      (medium.total ? row('Medium', medium.correct, medium.total) : '') +
      (hard.total ? row('Hard', hard.correct, hard.total) : '');
    body += tableBlock('By difficulty', diffRows);
  }

  return `
  <div style="font-family:-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif;max-width:560px;margin:0 auto;color:#1f2937;">
    <div style="background:#0d47a1;padding:24px;border-radius:12px 12px 0 0;">
      <h1 style="color:#fff;margin:0;font-size:20px;">Your SAT mock score report 📊</h1>
    </div>
    <div style="padding:24px;border:1px solid #e5e7eb;border-top:none;border-radius:0 0 12px 12px;">
      ${body}

      <div style="margin:26px 0 6px;padding:18px;background:#f0f5fb;border-radius:10px;">
        <p style="margin:0 0 12px;font-size:14px;line-height:1.6;color:#374151;">
          Want the <strong>question-by-question review</strong> and to track your score across mocks?
          Create a free account to save this report and unlock adaptive practice on your weak domains.
        </p>
        <a href="${SITE_URL}/sat-free"
           style="display:inline-block;background:#0d47a1;color:#fff;text-decoration:none;padding:12px 22px;border-radius:8px;font-weight:600;font-size:15px;">
          Save my report &amp; keep going →
        </a>
      </div>

      <p style="margin:18px 0 0;font-size:13px;color:#6b7280;line-height:1.6;">
        Students who take 3+ mocks see the biggest score gains — each Preppeo mock uses a
        unique question bank. <a href="${SITE_URL}/pricing" style="color:#0d47a1;text-decoration:none;">See mock packs</a>
      </p>
    </div>
  </div>`;
}

/**
 * POST /api/sat-free/lead
 * Body: { email, ref?, totalScore?, mathScore?, rwScore?, report? }
 *
 * Captures an anonymous free-mock finisher's email so a non-converting visitor
 * is no longer lost. Records the lead (dev/prod table per env) and emails the
 * full score-report summary (section + domain + difficulty breakdown). The send
 * is gated by an atomic per-address claim (see below), so a genuine re-attempt
 * lands a fresh report while concurrent/rapid submits can't duplicate it and the
 * public endpoint can't be used to email-bomb an address.
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

    const totalScore = toScore(body?.totalScore);
    const mathScore = toScore(body?.mathScore);
    const rwScore = toScore(body?.rwScore);

    // Ensure the lead row exists. First capture sets the referral attribution and
    // created_at; a returning email is a no-op here (unique index → 23505).
    const { error: insertErr } = await supabase.from('free_mock_leads').insert({
      email,
      total_score: totalScore,
      math_score: mathScore,
      rw_score: rwScore,
      source: 'free_mock',
      ref: normaliseRef(body?.ref),
      user_agent: request.headers.get('user-agent')?.slice(0, 500) ?? null,
    });

    if (insertErr && insertErr.code !== '23505') {
      console.error('Free-mock lead: insert failed', insertErr);
      return NextResponse.json({ error: 'Could not save your email. Try again.' }, { status: 500 });
    }

    // Atomically claim the right to email this address: flip last_emailed_at only
    // when it's unset or older than the throttle window, refreshing scores at the
    // same time. Concurrent/rapid submits re-evaluate this predicate against the
    // just-updated row, so exactly one wins — no duplicate emails — and the same
    // gate throttles abuse of this public endpoint. Genuine re-attempts (mocks run
    // hours apart) clear the window and get a fresh report.
    const threshold = new Date(Date.now() - EMAIL_THROTTLE_MS).toISOString();
    const { data: claimed, error: claimErr } = await supabase
      .from('free_mock_leads')
      .update({
        last_emailed_at: new Date().toISOString(),
        total_score: totalScore,
        math_score: mathScore,
        rw_score: rwScore,
      })
      .eq('email', email)
      .or(`last_emailed_at.is.null,last_emailed_at.lt.${threshold}`)
      .select('id');

    if (claimErr) {
      // Non-fatal: the lead is recorded; we just don't email this time.
      console.error('Free-mock lead: send-claim failed', claimErr);
    }

    // emailed=false means we skipped the send because this address was emailed
    // within the throttle window — the client surfaces that so it never looks
    // like a silent failure.
    const emailed = !!(claimed && claimed.length > 0);
    if (emailed) {
      // Awaited so the send completes on serverless before the function returns.
      await sendTransactionalEmail({
        to: email,
        subject: 'Your SAT mock score report',
        htmlBody: reportEmailHtml(
          { total: totalScore, math: mathScore, rw: rwScore },
          sanitizeReport(body?.report),
        ),
      });
    }

    return NextResponse.json({ success: true, emailed });
  } catch (err) {
    console.error('Error in POST /api/sat-free/lead:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

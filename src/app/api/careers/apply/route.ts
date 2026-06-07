import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { sendTransactionalEmail } from '@/lib/email/send';

function esc(s: string) {
  return s
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { slug, name, email, phone, resumeUrl, coverNote } =
      body as Record<string, string>;
    const portfolioLinks: string[] = Array.isArray(body.portfolioLinks)
      ? body.portfolioLinks
          .filter((l: unknown): l is string => typeof l === 'string')
          .map((l: string) => l.trim())
          .filter(Boolean)
      : [];

    if (!slug || !name || !email || !resumeUrl || !coverNote) {
      return NextResponse.json(
        { error: 'Please fill in all required fields.' },
        { status: 400 }
      );
    }

    // Confirm the role exists and is still open.
    const supabase = createSupabaseApiClient();
    const { data: posting } = await supabase
      .from('job_postings')
      .select('title, is_open')
      .eq('slug', slug)
      .maybeSingle();

    if (!posting || !posting.is_open) {
      return NextResponse.json(
        { error: 'This role is no longer accepting applications.' },
        { status: 404 }
      );
    }

    const teamEmail =
      process.env.CAREERS_EMAIL ||
      process.env.CONTACT_EMAIL ||
      'contact@preppeo.com';

    const row = (label: string, value: string) =>
      value
        ? `<tr><td style="padding:8px 0;font-weight:600;width:140px;vertical-align:top">${label}</td><td>${esc(value)}</td></tr>`
        : '';

    const teamEmailHtml = `
      <div style="font-family:sans-serif;max-width:600px;margin:0 auto">
        <h2 style="color:#0d47a1">New Job Application — ${esc(posting.title)}</h2>
        <table style="width:100%;border-collapse:collapse">
          ${row('Name', name)}
          ${row('Email', email)}
          ${row('Phone', phone)}
          ${row('Resume', resumeUrl)}
          ${portfolioLinks
            .map((link, i) => row(`Profile ${i + 1}`, link))
            .join('')}
        </table>
        <h3 style="margin-top:16px">Why them</h3>
        <p style="white-space:pre-wrap;background:#f5f5f0;padding:12px;border-radius:8px">${esc(coverNote)}</p>
      </div>
    `;

    const confirmationHtml = `
      <div style="font-family:sans-serif;max-width:600px;margin:0 auto">
        <h2 style="color:#0d47a1">We received your application!</h2>
        <p>Hi ${esc(name)},</p>
        <p>Thank you for applying for <strong>${esc(posting.title)}</strong> at Preppeo. We review every application and will get back to you within a few days.</p>
        <p style="margin-top:24px;color:#666">— The Preppeo Team</p>
      </div>
    `;

    const [teamSent] = await Promise.all([
      sendTransactionalEmail({
        to: teamEmail,
        subject: `[Application] ${posting.title} — ${name}`,
        htmlBody: teamEmailHtml,
        replyTo: email,
      }),
      sendTransactionalEmail({
        to: email,
        toName: name,
        subject: `We received your application — Preppeo`,
        htmlBody: confirmationHtml,
      }),
    ]);

    if (!teamSent) {
      return NextResponse.json(
        { error: 'Could not submit your application. Please try again later.' },
        { status: 500 }
      );
    }

    return NextResponse.json({ success: true });
  } catch {
    return NextResponse.json(
      { error: 'Something went wrong. Please try again.' },
      { status: 500 }
    );
  }
}

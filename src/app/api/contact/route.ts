import { NextRequest, NextResponse } from 'next/server';
import { sendTransactionalEmail } from '@/lib/email/send';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { name, email, subject, message } = body as {
      name: string;
      email: string;
      subject: string;
      message: string;
    };

    if (!name || !email || !subject || !message) {
      return NextResponse.json(
        { error: 'All fields are required' },
        { status: 400 }
      );
    }

    const teamEmail = process.env.CONTACT_EMAIL || 'contact@preppeo.com';

    const teamEmailHtml = `
      <div style="font-family:sans-serif;max-width:600px;margin:0 auto">
        <h2 style="color:#0d47a1">New Contact Form Submission</h2>
        <table style="width:100%;border-collapse:collapse">
          <tr><td style="padding:8px 0;font-weight:600;width:100px">Name</td><td>${name}</td></tr>
          <tr><td style="padding:8px 0;font-weight:600">Email</td><td>${email}</td></tr>
          <tr><td style="padding:8px 0;font-weight:600">Subject</td><td>${subject}</td></tr>
        </table>
        <h3 style="margin-top:16px">Message</h3>
        <p style="white-space:pre-wrap;background:#f5f5f0;padding:12px;border-radius:8px">${message}</p>
      </div>
    `;

    const confirmationHtml = `
      <div style="font-family:sans-serif;max-width:600px;margin:0 auto">
        <h2 style="color:#0d47a1">We received your message!</h2>
        <p>Hi ${name},</p>
        <p>Thank you for reaching out. We've received your message regarding <strong>${subject}</strong> and will get back to you within 24 hours.</p>
        <p style="margin-top:24px;color:#666">— The Preppeo Team</p>
      </div>
    `;

    const [teamSent, userSent] = await Promise.all([
      sendTransactionalEmail({
        to: teamEmail,
        subject: `[Contact] ${subject} — from ${name}`,
        htmlBody: teamEmailHtml,
      }),
      sendTransactionalEmail({
        to: email,
        toName: name,
        subject: 'We received your message — Preppeo',
        htmlBody: confirmationHtml,
      }),
    ]);

    if (!teamSent && !userSent) {
      return NextResponse.json(
        { error: 'Email service is currently unavailable. Please try again later.' },
        { status: 503 }
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

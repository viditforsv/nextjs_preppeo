import nodemailer from 'nodemailer';

interface SendEmailParams {
  to: string;
  toName?: string;
  subject: string;
  htmlBody: string;
}

function getTransporter() {
  return nodemailer.createTransport({
    host: process.env.SMTP_HOST || 'smtp.zeptomail.in',
    port: Number(process.env.SMTP_PORT) || 465,
    secure: true,
    auth: {
      user: process.env.SMTP_USER || 'emailapikey',
      pass: process.env.SMTP_PASS,
    },
  });
}

export async function sendTransactionalEmail({
  to,
  toName,
  subject,
  htmlBody,
}: SendEmailParams): Promise<boolean> {
  if (!process.env.SMTP_PASS) {
    console.warn('SMTP_PASS not configured — skipping email send');
    return false;
  }

  const fromEmail = process.env.SMTP_FROM_EMAIL || 'noreply@preppeo.com';
  const fromName = process.env.SMTP_FROM_NAME || 'Preppeo';
  const fromAddress = `"${fromName}" <${fromEmail}>`;
  const toAddress = toName ? `"${toName}" <${to}>` : to;

  try {
    const transporter = getTransporter();
    await transporter.sendMail({
      from: fromAddress,
      to: toAddress,
      subject,
      html: htmlBody,
    });

    console.log(`Email sent to ${to}: "${subject}"`);
    return true;
  } catch (error) {
    console.error('Email send failed:', error);
    return false;
  }
}

interface EmailContent {
  subject: string;
  html: string;
}

function layout(body: string): string {
  return `
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body style="margin:0;padding:0;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;color:#1a1a1a;background:#f5f5f5;">
  <table width="100%" cellpadding="0" cellspacing="0" style="background:#f5f5f5;padding:32px 16px;">
    <tr><td align="center">
      <table width="100%" style="max-width:560px;background:#ffffff;border-radius:8px;overflow:hidden;">
        <tr><td style="background:#0f172a;padding:24px 32px;">
          <span style="font-size:20px;font-weight:700;color:#ffffff;letter-spacing:-0.3px;">Preppeo</span>
        </td></tr>
        <tr><td style="padding:32px;">
          ${body}
        </td></tr>
        <tr><td style="padding:16px 32px;border-top:1px solid #e5e7eb;font-size:12px;color:#6b7280;text-align:center;">
          &copy; ${new Date().getFullYear()} Preppeo &middot; <a href="https://courses.preppeo.com" style="color:#6b7280;">courses.preppeo.com</a>
        </td></tr>
      </table>
    </td></tr>
  </table>
</body>
</html>`.trim();
}

export function welcomeEmail(firstName: string): EmailContent {
  const name = firstName || 'there';
  return {
    subject: 'Welcome to Preppeo!',
    html: layout(`
      <h2 style="margin:0 0 16px;font-size:22px;">Welcome, ${name}!</h2>
      <p style="margin:0 0 12px;line-height:1.6;">Your account has been created successfully. You now have access to our full catalogue of courses, mock tests, and study resources.</p>
      <p style="margin:0 0 24px;line-height:1.6;">Head over to your dashboard to get started:</p>
      <a href="https://courses.preppeo.com/courses" style="display:inline-block;background:#2563eb;color:#ffffff;padding:12px 28px;border-radius:6px;text-decoration:none;font-weight:600;">Browse Courses</a>
      <p style="margin:24px 0 0;line-height:1.6;color:#6b7280;font-size:14px;">If you have any questions, reply to this email — we're happy to help.</p>
    `),
  };
}

export function courseEnrollmentEmail(firstName: string, courseTitle: string): EmailContent {
  const name = firstName || 'there';
  return {
    subject: `You're enrolled in ${courseTitle}`,
    html: layout(`
      <h2 style="margin:0 0 16px;font-size:22px;">You're in, ${name}!</h2>
      <p style="margin:0 0 12px;line-height:1.6;">You've been enrolled in <strong>${courseTitle}</strong>.</p>
      <p style="margin:0 0 24px;line-height:1.6;">Jump in and start learning right away:</p>
      <a href="https://courses.preppeo.com/courses/enrolled" style="display:inline-block;background:#2563eb;color:#ffffff;padding:12px 28px;border-radius:6px;text-decoration:none;font-weight:600;">Go to My Courses</a>
    `),
  };
}

export function coursePurchaseEmail(
  firstName: string,
  courseTitles: string[],
  amount: number,
  currency: string,
): EmailContent {
  const name = firstName || 'there';
  const courseList = courseTitles.length === 1
    ? `<strong>${courseTitles[0]}</strong>`
    : `<ul style="margin:8px 0;padding-left:20px;">${courseTitles.map(t => `<li>${t}</li>`).join('')}</ul>`;
  const formattedAmount = `${currency} ${amount.toLocaleString()}`;

  return {
    subject: `Payment confirmed — ${courseTitles.length === 1 ? courseTitles[0] : `${courseTitles.length} courses`}`,
    html: layout(`
      <h2 style="margin:0 0 16px;font-size:22px;">Payment Confirmed</h2>
      <p style="margin:0 0 12px;line-height:1.6;">Hi ${name}, your payment of <strong>${formattedAmount}</strong> has been received.</p>
      <p style="margin:0 0 4px;line-height:1.6;">You now have access to:</p>
      ${courseList}
      <div style="margin:24px 0;">
        <a href="https://courses.preppeo.com/courses/enrolled" style="display:inline-block;background:#2563eb;color:#ffffff;padding:12px 28px;border-radius:6px;text-decoration:none;font-weight:600;">Start Learning</a>
      </div>
      <p style="margin:0;line-height:1.6;color:#6b7280;font-size:14px;">A receipt for this transaction is available in your account.</p>
    `),
  };
}

export function subscriptionEmail(
  firstName: string,
  planName: string,
  endsAt: string,
  tokenCount: number,
): EmailContent {
  const name = firstName || 'there';
  const endDate = new Date(endsAt).toLocaleDateString('en-IN', {
    day: 'numeric', month: 'long', year: 'numeric',
  });

  return {
    subject: `Subscription activated — ${planName}`,
    html: layout(`
      <h2 style="margin:0 0 16px;font-size:22px;">Subscription Activated</h2>
      <p style="margin:0 0 12px;line-height:1.6;">Hi ${name}, your <strong>${planName}</strong> plan is now active.</p>
      <table style="width:100%;border-collapse:collapse;margin:16px 0;">
        <tr>
          <td style="padding:8px 0;color:#6b7280;font-size:14px;">Valid until</td>
          <td style="padding:8px 0;font-weight:600;text-align:right;">${endDate}</td>
        </tr>
        ${tokenCount > 0 ? `<tr>
          <td style="padding:8px 0;color:#6b7280;font-size:14px;">Mock tokens</td>
          <td style="padding:8px 0;font-weight:600;text-align:right;">${tokenCount} token${tokenCount > 1 ? 's' : ''}</td>
        </tr>` : ''}
      </table>
      <a href="https://courses.preppeo.com/mocks" style="display:inline-block;background:#2563eb;color:#ffffff;padding:12px 28px;border-radius:6px;text-decoration:none;font-weight:600;">View Mock Tests</a>
    `),
  };
}

export function freeTokenEmail(
  firstName: string,
  examType: string,
  tokenCode: string,
): EmailContent {
  const name = firstName || 'there';
  const examLabel = examType.toUpperCase().replace(/_/g, ' ');

  return {
    subject: `Your free ${examLabel} mock token`,
    html: layout(`
      <h2 style="margin:0 0 16px;font-size:22px;">Free Mock Token</h2>
      <p style="margin:0 0 12px;line-height:1.6;">Hi ${name}, here's your free <strong>${examLabel}</strong> mock test token:</p>
      <div style="margin:16px 0;padding:16px;background:#f0f9ff;border:1px solid #bae6fd;border-radius:6px;text-align:center;">
        <span style="font-size:24px;font-weight:700;letter-spacing:2px;color:#0369a1;">${tokenCode}</span>
      </div>
      <p style="margin:0 0 24px;line-height:1.6;">Use this token to take a full-length practice test.</p>
      <a href="https://courses.preppeo.com/mocks" style="display:inline-block;background:#2563eb;color:#ffffff;padding:12px 28px;border-radius:6px;text-decoration:none;font-weight:600;">Take Your Mock Test</a>
    `),
  };
}

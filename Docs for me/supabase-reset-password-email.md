# Supabase "Reset Password" email — branded template + setup

Paste this into **Supabase → Authentication → Email Templates → Reset Password**.
Do it on the **dev branch** (`dxhxpfouzjlzpeazwrqo`) first, test, then repeat on
**prod** (`ootnqmojcqnzfrtvzzec`).

The link uses `{{ .TokenHash }}` (not `{{ .ConfirmationURL }}`) — that's what makes
the `verifyOtp` recovery flow on `/auth/reset-password` work (device-independent,
prefetch-safe). `{{ .SiteURL }}` resolves per-environment, so set Site URL correctly
on each (dev → `https://dev.preppeo.com`, prod → `https://preppeo.com`).

---

## Subject
```
Reset your Preppeo password
```

## Message body (HTML)
```html
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
          <h2 style="margin:0 0 16px;font-size:22px;">Reset your password</h2>
          <p style="margin:0 0 12px;line-height:1.6;">We received a request to reset the password for your Preppeo account. Click the button below to choose a new one.</p>
          <div style="margin:24px 0;">
            <a href="{{ .SiteURL }}/auth/reset-password?token_hash={{ .TokenHash }}&type=recovery" style="display:inline-block;background:#2563eb;color:#ffffff;padding:12px 28px;border-radius:6px;text-decoration:none;font-weight:600;">Reset Password</a>
          </div>
          <p style="margin:0 0 12px;line-height:1.6;color:#6b7280;font-size:14px;">This link can be used once and expires in 1 hour. If the button doesn't work, copy and paste this URL into your browser:</p>
          <p style="margin:0 0 24px;line-height:1.6;font-size:13px;word-break:break-all;"><a href="{{ .SiteURL }}/auth/reset-password?token_hash={{ .TokenHash }}&type=recovery" style="color:#2563eb;">{{ .SiteURL }}/auth/reset-password?token_hash={{ .TokenHash }}&type=recovery</a></p>
          <p style="margin:0;line-height:1.6;color:#6b7280;font-size:14px;">Didn't request this? You can safely ignore this email — your password won't change.</p>
        </td></tr>
        <tr><td style="padding:16px 32px;border-top:1px solid #e5e7eb;font-size:12px;color:#6b7280;text-align:center;">
          Preppeo &middot; <a href="https://preppeo.com" style="color:#6b7280;">preppeo.com</a>
        </td></tr>
      </table>
    </td></tr>
  </table>
</body>
</html>
```

---

## SMTP (branded sender) — Authentication → SMTP Settings → Enable Custom SMTP
| Field | Value |
|-------|-------|
| Host | `smtp.zeptomail.in` |
| Port | `587` |
| Username | your `SMTP_USER` (from `.env.local`) |
| Password | your `SMTP_PASS` (from `.env.local`) |
| Sender email | `noreply@preppeo.com` |
| Sender name | `Preppeo` |

ZeptoMail must have `preppeo.com` verified (SPF/DKIM) — it already is for transactional,
so the same domain works here.

## URL Configuration (same dashboard area)
- **Site URL:** dev → `https://dev.preppeo.com`, prod → `https://preppeo.com`
- **Redirect allowlist:** include `https://dev.preppeo.com/auth/reset-password` (dev)
  and `https://preppeo.com/auth/reset-password` (prod). (Used by the legacy `?code`
  fallback; the token_hash link doesn't strictly need it but keep it for safety.)

## Test
1. Apply template + SMTP on the **dev** branch.
2. Use the live forgot-password form on `dev.preppeo.com`, open the email
   (try a different device/browser to confirm the cross-device fix), click the link.
3. You should land on `/auth/reset-password` already verified → set a new password.
4. Repeat the template + SMTP on prod once dev checks out.

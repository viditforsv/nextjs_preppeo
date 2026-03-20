import { NextRequest, NextResponse } from "next/server";
import { sendTransactionalEmail } from "@/lib/email/send";
import {
  welcomeEmail,
  courseEnrollmentEmail,
  coursePurchaseEmail,
  subscriptionEmail,
  freeTokenEmail,
} from "@/lib/email/templates";

type TemplateKey = "welcome" | "enrollment" | "purchase" | "subscription" | "freeToken";

function isAllowed(request: NextRequest): boolean {
  if (process.env.NODE_ENV === "development") return true;
  const secret = process.env.EMAIL_TEST_SECRET;
  if (!secret) return false;
  return request.headers.get("x-email-test-secret") === secret;
}

/**
 * POST /api/email/test
 * Sends a sample transactional email (ZeptoMail / SMTP must be configured).
 *
 * Local: works in `next dev` without extra config.
 * Staging/prod: set EMAIL_TEST_SECRET and send header x-email-test-secret with the same value.
 *
 * Body: { "to": "you@example.com", "template": "welcome" | "enrollment" | "purchase" | "subscription" | "freeToken" }
 */
export async function POST(request: NextRequest) {
  if (!isAllowed(request)) {
    return NextResponse.json({ error: "Not found" }, { status: 404 });
  }

  try {
    const body = await request.json();
    const to = typeof body.to === "string" ? body.to.trim() : "";
    const template = (body.template as TemplateKey) || "welcome";

    if (!to || !to.includes("@")) {
      return NextResponse.json(
        { error: "Invalid body: { to: string (email), template?: string }" },
        { status: 400 }
      );
    }

    let subject: string;
    let html: string;

    switch (template) {
      case "enrollment": {
        const c = courseEnrollmentEmail("Test", "Sample Course Title");
        subject = c.subject;
        html = c.html;
        break;
      }
      case "purchase": {
        const c = coursePurchaseEmail("Test", ["Course A", "Course B"], 999, "INR");
        subject = c.subject;
        html = c.html;
        break;
      }
      case "subscription": {
        const end = new Date();
        end.setDate(end.getDate() + 30);
        const c = subscriptionEmail("Test", "Sample Plan", end.toISOString(), 3);
        subject = c.subject;
        html = c.html;
        break;
      }
      case "freeToken": {
        const c = freeTokenEmail("Test", "sat", "DEMO-TOKEN-123");
        subject = c.subject;
        html = c.html;
        break;
      }
      case "welcome":
      default: {
        const c = welcomeEmail("Test");
        subject = c.subject;
        html = c.html;
        break;
      }
    }

    const ok = await sendTransactionalEmail({
      to,
      toName: "Test user",
      subject: `[TEST] ${subject}`,
      htmlBody: html,
    });

    if (!ok) {
      return NextResponse.json(
        {
          success: false,
          message:
            "Send skipped or failed (check SMTP_PASS and server logs).",
        },
        { status: 502 }
      );
    }

    return NextResponse.json({
      success: true,
      template,
      to,
      message: "Check inbox (and spam). Subject is prefixed with [TEST].",
    });
  } catch (e) {
    console.error("/api/email/test:", e);
    return NextResponse.json(
      { error: e instanceof Error ? e.message : "Request failed" },
      { status: 500 }
    );
  }
}

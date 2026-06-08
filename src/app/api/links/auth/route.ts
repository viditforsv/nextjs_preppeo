import { NextRequest, NextResponse } from "next/server";
import { LINK_TOOL_COOKIE } from "@/lib/tracked-links";

export const dynamic = "force-dynamic";

// Exchange the shared passcode for a cookie that unlocks the link tool.
export async function POST(req: NextRequest) {
  const passcode = process.env.LINK_TOOL_PASSCODE;
  if (!passcode) {
    return NextResponse.json(
      { error: "Link tool passcode is not configured." },
      { status: 500 }
    );
  }

  const body = await req.json().catch(() => ({}));
  if (String(body.passcode || "") !== passcode) {
    return NextResponse.json({ error: "Wrong passcode." }, { status: 401 });
  }

  const res = NextResponse.json({ ok: true });
  res.cookies.set(LINK_TOOL_COOKIE, passcode, {
    maxAge: 60 * 60 * 24 * 30,
    path: "/",
    sameSite: "lax",
    httpOnly: true,
  });
  return res;
}

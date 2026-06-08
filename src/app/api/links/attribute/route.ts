import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";
import { LINK_REF_COOKIE } from "@/lib/tracked-links";

export const dynamic = "force-dynamic";

// Only attribute users who signed up very recently — this endpoint fires on
// every SIGNED_IN, so this guard stops returning users (who happen to carry a
// pp_ref cookie) from being counted as new signups.
const SIGNUP_WINDOW_MS = 15 * 60 * 1000;

export async function POST(req: NextRequest) {
  const slug = req.cookies.get(LINK_REF_COOKIE)?.value;
  // Always clear the ref cookie so it can't attribute a future login.
  const clearCookie = (res: NextResponse) => {
    res.cookies.set(LINK_REF_COOKIE, "", { maxAge: 0, path: "/" });
    return res;
  };

  if (!slug) return NextResponse.json({ ok: true });

  const authClient = await createClient();
  const {
    data: { user },
  } = await authClient.auth.getUser();
  if (!user) return NextResponse.json({ ok: true });

  // Fresh signup only.
  const createdAt = new Date(user.created_at).getTime();
  if (Date.now() - createdAt > SIGNUP_WINDOW_MS) {
    return clearCookie(NextResponse.json({ ok: true, attributed: false }));
  }

  const supabase = createSupabaseApiClient();
  // Confirm the slug is real before recording.
  const { data: link } = await supabase
    .from("tracked_links")
    .select("slug")
    .eq("slug", slug)
    .maybeSingle();
  if (!link) {
    return clearCookie(NextResponse.json({ ok: true, attributed: false }));
  }

  // One attribution per user (idempotent on the unique user_id).
  await supabase
    .from("link_signups")
    .upsert({ link_slug: slug, user_id: user.id }, { onConflict: "user_id" });

  return clearCookie(NextResponse.json({ ok: true, attributed: true }));
}

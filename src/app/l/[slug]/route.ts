import { NextRequest, NextResponse } from "next/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";
import { LINK_REF_COOKIE, LINK_REF_MAX_AGE } from "@/lib/tracked-links";

export const dynamic = "force-dynamic";

export async function GET(
  req: NextRequest,
  { params }: { params: Promise<{ slug: string }> }
) {
  const { slug } = await params;
  const origin = req.nextUrl.origin;

  const supabase = createSupabaseApiClient();
  const { data: link } = await supabase
    .from("tracked_links")
    .select("slug, destination_path, source, campaign, destination_key")
    .eq("slug", slug)
    .maybeSingle();

  // Unknown code → send to homepage, untracked.
  if (!link) {
    return NextResponse.redirect(`${origin}/`, 302);
  }

  // Count the click. Await it — an unawaited promise often never runs on
  // serverless before the response is sent. The RPC is a single fast UPDATE.
  await supabase.rpc("increment_link_click", { p_slug: slug });

  const dest = new URL(link.destination_path, origin);
  dest.searchParams.set("utm_source", link.source);
  dest.searchParams.set("utm_medium", "community");
  dest.searchParams.set("utm_campaign", link.campaign || link.destination_key);
  dest.searchParams.set("utm_content", slug);

  const res = NextResponse.redirect(dest.toString(), 302);
  // Last-touch attribution cookie, read at signup.
  res.cookies.set(LINK_REF_COOKIE, slug, {
    maxAge: LINK_REF_MAX_AGE,
    path: "/",
    sameSite: "lax",
    httpOnly: false,
  });
  return res;
}

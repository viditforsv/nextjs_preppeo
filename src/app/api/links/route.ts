import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";
import {
  LINK_TOOL_COOKIE,
  LINK_SOURCES,
  destinationForKey,
} from "@/lib/tracked-links";

export const dynamic = "force-dynamic";

// Caller is either a logged-in admin, or someone holding the passcode cookie.
async function authorize(
  req: NextRequest
): Promise<{ ok: boolean; createdBy: "admin" | "va" }> {
  // 1. Admin session?
  try {
    const authClient = await createClient();
    const {
      data: { user },
    } = await authClient.auth.getUser();
    if (user) {
      const svc = createSupabaseApiClient();
      const { data: profile } = await svc
        .from("profiles")
        .select("role")
        .eq("id", user.id)
        .single();
      if (profile?.role === "admin") return { ok: true, createdBy: "admin" };
    }
  } catch {
    // ignore, fall through to passcode
  }

  // 2. Passcode cookie?
  const passcode = process.env.LINK_TOOL_PASSCODE;
  const cookie = req.cookies.get(LINK_TOOL_COOKIE)?.value;
  if (passcode && cookie && cookie === passcode) {
    return { ok: true, createdBy: "va" };
  }

  return { ok: false, createdBy: "va" };
}

function randomSlug(len = 6): string {
  const alphabet = "abcdefghijkmnpqrstuvwxyz23456789"; // no ambiguous chars
  const bytes = new Uint8Array(len);
  crypto.getRandomValues(bytes);
  let out = "";
  for (let i = 0; i < len; i++) out += alphabet[bytes[i] % alphabet.length];
  return out;
}

export async function GET(req: NextRequest) {
  const auth = await authorize(req);
  if (!auth.ok) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const supabase = createSupabaseApiClient();
  const [{ data: links }, { data: signups }] = await Promise.all([
    supabase
      .from("tracked_links")
      .select(
        "slug, destination_key, destination_path, source, label, campaign, click_count, last_clicked_at, created_by, created_at"
      )
      .order("created_at", { ascending: false }),
    supabase.from("link_signups").select("link_slug"),
  ]);

  const signupCounts = new Map<string, number>();
  for (const s of signups ?? []) {
    signupCounts.set(s.link_slug, (signupCounts.get(s.link_slug) ?? 0) + 1);
  }

  const rows = (links ?? []).map((l) => ({
    ...l,
    signup_count: signupCounts.get(l.slug) ?? 0,
  }));

  return NextResponse.json({ links: rows });
}

export async function POST(req: NextRequest) {
  const auth = await authorize(req);
  if (!auth.ok) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const destinationKey = String(body.destinationKey || "");
  const source = String(body.source || "");
  const label = String(body.label || "").trim();

  const dest = destinationForKey(destinationKey);
  if (!dest) {
    return NextResponse.json(
      { error: "Pick a valid destination" },
      { status: 400 }
    );
  }
  if (!LINK_SOURCES.some((s) => s.key === source)) {
    return NextResponse.json({ error: "Pick a valid source" }, { status: 400 });
  }

  const supabase = createSupabaseApiClient();

  // Generate a unique slug (retry on the rare collision).
  let slug = "";
  for (let attempt = 0; attempt < 5; attempt++) {
    const candidate = randomSlug();
    const { data: existing } = await supabase
      .from("tracked_links")
      .select("slug")
      .eq("slug", candidate)
      .maybeSingle();
    if (!existing) {
      slug = candidate;
      break;
    }
  }
  if (!slug) {
    return NextResponse.json(
      { error: "Could not generate a link, try again" },
      { status: 500 }
    );
  }

  const { data, error } = await supabase
    .from("tracked_links")
    .insert({
      slug,
      destination_key: dest.key,
      destination_path: dest.path,
      source,
      label,
      campaign: dest.key,
      created_by: auth.createdBy,
    })
    .select(
      "slug, destination_key, destination_path, source, label, campaign, click_count, last_clicked_at, created_by, created_at"
    )
    .single();

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({ link: { ...data, signup_count: 0 } });
}

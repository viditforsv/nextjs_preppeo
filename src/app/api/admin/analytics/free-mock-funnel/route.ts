import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";

type FunnelState = "signed_up_only" | "claimed" | "started" | "completed";

interface FunnelRow {
  user_id: string;
  email: string | null;
  first_name: string | null;
  last_name: string | null;
  role: string | null;
  signed_up_at: string;
  claimed_at: string | null;
  token_used_at: string | null;
  free_tokens_granted: number | null;
  first_started_at: string | null;
  attempts_count: number | null;
  first_completed_at: string | null;
  best_total_estimated_score: number | null;
  funnel_state: FunnelState;
}

export async function GET(request: NextRequest) {
  const supabase = await createClient();

  const { data: { user }, error: userError } = await supabase.auth.getUser();
  if (userError || !user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { data: profile, error: profileError } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .single();

  if (profileError || !profile || profile.role !== "admin") {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const url = new URL(request.url);
  const fromParam = url.searchParams.get("from");
  const toParam = url.searchParams.get("to");
  const limitParam = url.searchParams.get("limit");

  const from = fromParam ? new Date(fromParam) : new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
  const to = toParam ? new Date(toParam) : new Date();
  const limit = Math.min(Number(limitParam) || 500, 5000);

  if (Number.isNaN(from.getTime()) || Number.isNaN(to.getTime())) {
    return NextResponse.json({ error: "Invalid date range" }, { status: 400 });
  }

  const admin = createSupabaseApiClient();

  const { data: rows, error: queryError } = await admin
    .from("vw_sat_free_mock_funnel")
    .select("*")
    .gte("signed_up_at", from.toISOString())
    .lte("signed_up_at", to.toISOString())
    .order("signed_up_at", { ascending: false })
    .limit(limit)
    .returns<FunnelRow[]>();

  if (queryError) {
    console.error("free-mock-funnel query failed:", queryError);
    return NextResponse.json({ error: "Query failed" }, { status: 500 });
  }

  const data = rows ?? [];
  const counts: Record<FunnelState, number> = {
    signed_up_only: 0,
    claimed: 0,
    started: 0,
    completed: 0,
  };
  for (const r of data) counts[r.funnel_state] += 1;

  const totalSignedUp = data.length;
  const totalClaimed = counts.claimed + counts.started + counts.completed;
  const totalStarted = counts.started + counts.completed;
  const totalCompleted = counts.completed;

  const summary = {
    totalSignedUp,
    totalClaimed,
    totalStarted,
    totalCompleted,
    claimRatePct: totalSignedUp ? +((totalClaimed / totalSignedUp) * 100).toFixed(1) : 0,
    startRatePct: totalSignedUp ? +((totalStarted / totalSignedUp) * 100).toFixed(1) : 0,
    completionRatePct: totalSignedUp ? +((totalCompleted / totalSignedUp) * 100).toFixed(1) : 0,
    rangeFrom: from.toISOString(),
    rangeTo: to.toISOString(),
  };

  return NextResponse.json({ summary, rows: data });
}

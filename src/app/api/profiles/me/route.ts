import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";

export async function GET() {
  try {
    const supabase = await createClient();
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();

    if (authError || !user) {
      return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
    }

    const serviceClient = createSupabaseApiClient();
    const { data, error } = await serviceClient
      .from("profiles")
      .select(
        "id, first_name, last_name, email, role, created_at, updated_at, avatar_url"
      )
      .eq("id", user.id)
      .single();

    if (error) {
      if (error.code === "PGRST116") {
        return NextResponse.json({ error: "Profile not found" }, { status: 404 });
      }
      console.error("Error fetching profile:", error);
      return NextResponse.json(
        { error: "Failed to fetch profile" },
        { status: 500 }
      );
    }

    return NextResponse.json({ profile: data });
  } catch (error) {
    console.error("Error in GET /api/profiles/me:", error);
    return NextResponse.json(
      { error: "Internal server error" },
      { status: 500 }
    );
  }
}

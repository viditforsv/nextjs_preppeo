import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";

// Marks a SAT-learn item complete / incomplete for the current user.
export async function POST(req: NextRequest) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
  }

  const { itemId, completed } = (await req.json()) as {
    itemId?: string;
    completed?: boolean;
  };
  if (!itemId) {
    return NextResponse.json({ error: "itemId required" }, { status: 400 });
  }

  const db = createSupabaseApiClient();
  if (completed === false) {
    await db
      .from("sat_learn_progress")
      .delete()
      .eq("user_id", user.id)
      .eq("item_id", itemId);
  } else {
    await db
      .from("sat_learn_progress")
      .upsert(
        { user_id: user.id, item_id: itemId },
        { onConflict: "user_id,item_id", ignoreDuplicates: true }
      );
  }

  return NextResponse.json({ success: true });
}

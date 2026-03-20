import { NextRequest, NextResponse } from "next/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";
import { sendTransactionalEmail } from "@/lib/email/send";
import { welcomeEmail } from "@/lib/email/templates";

// POST /api/profiles/create - Create user profile (uses service role)
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { userId, email, firstName, lastName, role = "student", avatarUrl } = body;

    if (!userId || !email) {
      return NextResponse.json(
        { error: "userId and email are required" },
        { status: 400 }
      );
    }

    const supabase = createSupabaseApiClient();

    const profileData = {
      id: userId,
      email: email,
      first_name: firstName || null,
      last_name: lastName || null,
      role: role,
      avatar_url: avatarUrl || null,
    };

    console.log("🔵 Creating profile with service role:", profileData);

    // Use service role to bypass RLS
    const { data, error } = await supabase
      .from("profiles")
      .insert(profileData)
      .select()
      .single();

    if (error) {
      // If profile already exists, that's okay
      if (error.code === "23505") {
        console.log("✅ Profile already exists for user:", userId);
        // Try to get existing profile
        const { data: existingProfile } = await supabase
          .from("profiles")
          .select()
          .eq("id", userId)
          .single();
        return NextResponse.json({ profile: existingProfile }, { status: 200 });
      }

      console.error("❌ Error creating profile:", error);
      return NextResponse.json(
        { error: "Failed to create profile", details: error.message },
        { status: 500 }
      );
    }

    console.log("✅ Profile created successfully:", data);

    // Fire-and-forget: send welcome email
    if (email) {
      const { subject, html } = welcomeEmail(firstName || '');
      sendTransactionalEmail({ to: email, toName: firstName || undefined, subject, htmlBody: html })
        .catch((err) => console.error('Welcome email failed (non-blocking):', err));
    }

    return NextResponse.json({ profile: data }, { status: 201 });
  } catch (error) {
    console.error("❌ Error in POST /api/profiles/create:", error);
    return NextResponse.json(
      { error: "Internal server error" },
      { status: 500 }
    );
  }
}


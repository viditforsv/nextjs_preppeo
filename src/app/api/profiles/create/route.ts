import { NextRequest, NextResponse } from "next/server";
import { createSupabaseApiClient } from "@/lib/supabase/api-client";
import { sendTransactionalEmail } from "@/lib/email/send";
import { welcomeEmail } from "@/lib/email/templates";

// POST /api/profiles/create - Create user profile (uses service role)
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const {
      userId,
      email,
      firstName,
      lastName,
      role = "student",
      avatarUrl,
      /** When true, send welcome email even if profile already exists (e.g. Supabase trigger inserted first). */
      sendWelcomeEmail,
    } = body as {
      userId?: string;
      email?: string;
      firstName?: string;
      lastName?: string;
      role?: string;
      avatarUrl?: string | null;
      sendWelcomeEmail?: boolean;
    };

    const welcomeOnDuplicate = sendWelcomeEmail === true;
    const suppressWelcome = sendWelcomeEmail === false;

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
        const { data: existingProfile } = await supabase
          .from("profiles")
          .select()
          .eq("id", userId)
          .single();

        // DB trigger (handle_new_user) often creates the row before this API runs — no insert branch, so welcome must run here when client requests it (registration flow).
        if (welcomeOnDuplicate && existingProfile?.email) {
          try {
            const displayName =
              (existingProfile as { first_name?: string | null }).first_name ||
              firstName ||
              "";
            const { subject, html } = welcomeEmail(displayName);
            await sendTransactionalEmail({
              to: existingProfile.email,
              toName: displayName || undefined,
              subject,
              htmlBody: html,
            });
          } catch (err) {
            console.error("Welcome email failed (duplicate profile path):", err);
          }
        }

        return NextResponse.json({ profile: existingProfile }, { status: 200 });
      }

      console.error("❌ Error creating profile:", error);
      return NextResponse.json(
        { error: "Failed to create profile", details: error.message },
        { status: 500 }
      );
    }

    console.log("✅ Profile created successfully:", data);

    if (email && !suppressWelcome) {
      try {
        const { subject, html } = welcomeEmail(firstName || "");
        await sendTransactionalEmail({
          to: email,
          toName: firstName || undefined,
          subject,
          htmlBody: html,
        });
      } catch (err) {
        console.error("Welcome email failed (non-blocking):", err);
      }
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


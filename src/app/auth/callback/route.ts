import { appendFileSync } from "fs";
import { join } from "path";
import { NextResponse } from "next/server";

function agentDebugLog(payload: Record<string, unknown>) {
  // #region agent log
  try {
    const line =
      JSON.stringify({
        sessionId: "e34cb8",
        timestamp: Date.now(),
        runId: "pre-fix",
        ...payload,
      }) + "\n";
    appendFileSync(join(process.cwd(), ".cursor", "debug-e34cb8.log"), line, {
      flag: "a",
    });
  } catch {
    /* ignore — e.g. Vercel has no project .cursor path */
  }
  // #endregion
}

export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url);
  const code = searchParams.get("code");
  const next = searchParams.get("next") ?? "/courses/enrolled";

  console.log("Auth callback - Origin:", origin);
  console.log("Auth callback - Code:", code ? "present" : "missing");
  console.log("Auth callback - Next:", next);

  if (code) {
    try {
      // For PKCE, we need to let the client handle the session
      // The server-side exchange doesn't work with PKCE flow
      // Instead, we'll redirect to the client with the code

      console.log("Auth callback - Redirecting to client-side handling");
      // Use APP_URL first, then SITE_URL, then fallback to origin
      const baseUrl = 
        process.env.NEXT_PUBLIC_APP_URL || 
        process.env.NEXT_PUBLIC_SITE_URL || 
        origin;

      // #region agent log
      agentDebugLog({
        location: "auth/callback/route.ts:GET",
        message: "oauth callback redirect target",
        hypothesisId: "H1",
        data: {
          origin,
          baseUrl,
          usedEnvAppUrl: Boolean(process.env.NEXT_PUBLIC_APP_URL),
          usedEnvSiteUrl: Boolean(process.env.NEXT_PUBLIC_SITE_URL),
          baseDiffersFromOrigin:
            baseUrl.replace(/\/$/, "") !== origin.replace(/\/$/, ""),
          codePresent: true,
        },
      });
      // #endregion

      // Redirect to the main auth page with the code
      return NextResponse.redirect(`${baseUrl}/auth?code=${code}&next=${next}`);
    } catch (error) {
      console.error("Auth callback - Unexpected error:", error);
      const baseUrl = 
        process.env.NEXT_PUBLIC_APP_URL || 
        process.env.NEXT_PUBLIC_SITE_URL || 
        origin;
      return NextResponse.redirect(
        `${baseUrl}/auth?error=Authentication failed`
      );
    }
  }

  // Return the user to an error page with instructions
  const baseUrl = 
    process.env.NEXT_PUBLIC_APP_URL || 
    process.env.NEXT_PUBLIC_SITE_URL || 
    origin;

  // #region agent log
  agentDebugLog({
    location: "auth/callback/route.ts:GET:no-code",
    message: "oauth callback missing code",
    hypothesisId: "H1",
    data: {
      origin,
      baseUrl,
      usedEnvAppUrl: Boolean(process.env.NEXT_PUBLIC_APP_URL),
    },
  });
  // #endregion

  console.log(
    "Auth callback - No code, redirecting to:",
    `${baseUrl}/auth?error=No authentication code received`
  );
  return NextResponse.redirect(
    `${baseUrl}/auth?error=No authentication code received`
  );
}

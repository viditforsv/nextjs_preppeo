import { createServerClient } from "@supabase/ssr";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { canAccessRoute, getRedirectPath } from "@/lib/access-control";
import { UserRole } from "@/types/auth";
import {
  getSupabaseUrl,
  getSupabaseAnonKey,
  validateSupabaseConfig,
} from "@/lib/supabase/env";

export async function middleware(req: NextRequest) {
  const res = NextResponse.next();
  const { pathname } = req.nextUrl;

  // Fast path: if an anonymous, role-less user can already access this path,
  // there is nothing for middleware to enforce — so skip the auth round-trips
  // entirely. canAccessRoute(pathname, undefined, false) is true for public
  // routes AND for any path with no matching rule, so this collapses every
  // public page to zero network calls. ROUTE_ACCESS stays the single source
  // of truth, so the matcher can never drift out of sync with the rules.
  if (canAccessRoute(pathname, undefined, false)) {
    return res;
  }

  validateSupabaseConfig();
  const supabase = createServerClient(
    getSupabaseUrl(),
    getSupabaseAnonKey(),
    {
      auth: {
        flowType: "pkce",
        persistSession: true,
        autoRefreshToken: true,
        detectSessionInUrl: true,
        // MUST match client.ts and server.ts. Without this, the middleware
        // reads cookies under the default `sb-<ref>-auth-token` name while
        // the browser/server clients write `preppeo-lms-session.*`, so the
        // middleware never sees the session and redirect-loops admin routes.
        storageKey: "preppeo-lms-session",
      },
      cookies: {
        getAll() {
          return req.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value, options }) => {
            res.cookies.set(name, value, {
              ...options,
              secure: process.env.NODE_ENV === "production",
              sameSite: "lax",
            });
          });
        },
      },
    }
  );

  // Verify the session JWT. getClaims() verifies locally (no auth-server
  // round-trip) when the project uses asymmetric signing keys, and falls back
  // to a network getUser() otherwise — never less secure, just faster when
  // available. It still refreshes/persists the session via getSession() under
  // the hood, so cookie refresh keeps working.
  const { data: claimsData } = await supabase.auth.getClaims();
  const claims = claimsData?.claims;
  const userId = claims?.sub;
  const isAuthenticated = !!userId;
  let userRole: UserRole | undefined;

  // Always read role from profiles — JWT/user_metadata can drift out of sync
  // (e.g. a user promoted in profiles still has the old role in the token),
  // which causes auth redirects to be wrong. Profile is the source of truth.
  if (userId) {
    try {
      const { data: profile } = await supabase
        .from("profiles")
        .select("role")
        .eq("id", userId)
        .single();
      userRole = profile?.role as UserRole | undefined;
    } catch (error) {
      console.error("Error fetching user role:", error);
      // Fall back to token metadata only if the profile lookup fails entirely
      userRole = claims?.user_metadata?.role as UserRole | undefined;
    }
  }

  const canAccess = canAccessRoute(pathname, userRole, isAuthenticated);

  if (!canAccess) {
    const redirectPath = getRedirectPath(pathname, userRole, isAuthenticated);
    if (redirectPath) {
      const redirectUrl = new URL(redirectPath, req.url);
      if (redirectPath === "/auth") {
        redirectUrl.searchParams.set("redirect", pathname);
      }
      return NextResponse.redirect(redirectUrl);
    }
  }

  return res;
}

export const config = {
  // Exclude API routes (they authenticate themselves), Next internals, and
  // static assets. Page routes still pass through, where the fast path above
  // skips auth work for anything public.
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico|public/).*)"],
};

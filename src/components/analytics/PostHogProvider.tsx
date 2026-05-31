"use client";

import { useEffect } from "react";
import posthog from "posthog-js";
import { PostHogProvider as PHProvider } from "posthog-js/react";
import {
  getStoredConsent,
  CONSENT_EVENT,
  type ConsentChoice,
} from "@/lib/consent";

export function PostHogProvider({
  requiresConsent,
  children,
}: {
  requiresConsent: boolean;
  children: React.ReactNode;
}) {
  useEffect(() => {
    const key = process.env.NEXT_PUBLIC_POSTHOG_KEY;
    if (!key) return; // no-op when not configured (e.g. local without env)

    const consent = getStoredConsent();
    // In consent-required regions, stay opted out until the user accepts.
    const optOut = requiresConsent && consent !== "accepted";

    posthog.init(key, {
      // Send through our first-party reverse proxy (see next.config rewrites) so
      // events aren't blocked by the site CSP or ad-blockers. ui_host keeps
      // PostHog UI/toolbar links pointing at the real US dashboard.
      api_host: "/ingest",
      ui_host: "https://us.posthog.com",
      // Auto-capture SPA navigations in the App Router (no manual pageview wiring needed).
      capture_pageview: "history_change",
      capture_pageleave: true,
      // We identify users explicitly on login; don't create person profiles for
      // anonymous-only traffic to keep volume (and cost) down.
      person_profiles: "identified_only",
      opt_out_capturing_by_default: optOut,
    });

    if (!optOut) posthog.opt_in_capturing();

    // React to the banner: opt in on "Accept all", opt out on "necessary only".
    const onConsentChange = (e: Event) => {
      const choice = (e as CustomEvent<ConsentChoice>).detail;
      if (choice === "accepted") posthog.opt_in_capturing();
      else posthog.opt_out_capturing();
    };
    window.addEventListener(CONSENT_EVENT, onConsentChange);
    return () => window.removeEventListener(CONSENT_EVENT, onConsentChange);
  }, [requiresConsent]);

  return <PHProvider client={posthog}>{children}</PHProvider>;
}

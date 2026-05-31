"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { Button } from "@/design-system/components/ui/button";
import { getStoredConsent, setConsent, type ConsentChoice } from "@/lib/consent";

/**
 * Cookie-consent banner. The server only renders this for EEA/UK/Swiss
 * visitors, so there's no region check here — it just shows until the visitor
 * makes a choice. Persisting and pushing consent to Google/PostHog lives in
 * `@/lib/consent`.
 */
export function CookieConsentBanner() {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    if (!getStoredConsent()) setVisible(true);
  }, []);

  if (!visible) return null;

  const choose = (choice: ConsentChoice) => {
    setConsent(choice);
    setVisible(false);
  };

  return (
    <div
      role="dialog"
      aria-modal="false"
      aria-label="Cookie consent"
      className="fixed inset-x-0 bottom-0 z-[100] border-t border-border bg-card/95 backdrop-blur-sm shadow-lg"
    >
      <div className="mx-auto flex max-w-6xl flex-col gap-4 px-4 py-4 sm:px-6 md:flex-row md:items-center md:justify-between">
        <p className="text-sm leading-relaxed text-muted-foreground">
          We use cookies to understand how students use Preppeo and to measure our
          ads. You can accept all, or keep only the essentials.{" "}
          <Link
            href="/cookies"
            className="font-medium text-foreground underline underline-offset-2 hover:text-primary"
          >
            Cookie policy
          </Link>
          .
        </p>
        <div className="flex shrink-0 gap-3">
          <Button
            variant="outline"
            size="sm"
            onClick={() => choose("necessary")}
          >
            Accept necessary only
          </Button>
          <Button variant="primary" size="sm" onClick={() => choose("accepted")}>
            Accept all
          </Button>
        </div>
      </div>
    </div>
  );
}

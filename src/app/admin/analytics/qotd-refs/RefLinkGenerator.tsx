"use client";

import { useMemo, useState } from "react";
import { Card, CardContent } from "@/design-system/components/ui/card";
import { Button } from "@/design-system/components/ui/button";
import { Link2, Copy, Check, AlertTriangle } from "lucide-react";

// Same rules the capture API enforces server-side: lowercase, [a-z0-9_-], max 40.
function toSlug(raw: string): string {
  return raw.trim().toLowerCase().replace(/[^a-z0-9_-]/g, "").slice(0, 40);
}

// VAs share the public link; always the canonical production domain (never localhost).
const SHARE_BASE = "https://preppeo.com/qotd?ref=";

export default function RefLinkGenerator({
  existingRefs = [],
  initialName = "",
}: {
  existingRefs?: string[];
  initialName?: string;
}) {
  const [name, setName] = useState(initialName);
  const [copied, setCopied] = useState(false);

  const slug = useMemo(() => toSlug(name), [name]);
  const url = slug ? `${SHARE_BASE}${slug}` : "";
  const isDuplicate = slug.length > 0 && existingRefs.includes(slug);

  async function copy() {
    if (!url) return;
    try {
      await navigator.clipboard.writeText(url);
      setCopied(true);
      setTimeout(() => setCopied(false), 1500);
    } catch {
      /* clipboard blocked — user can still select the text */
    }
  }

  return (
    <Card className="rounded-sm mb-6">
      <CardContent className="p-5">
        <div className="flex items-center gap-2 mb-3">
          <Link2 className="w-4 h-4 text-blue-600" />
          <h2 className="text-sm font-semibold">Generate a VA referral link</h2>
        </div>

        <div className="flex flex-wrap items-end gap-3">
          <div className="flex-1 min-w-[220px]">
            <label className="block text-xs text-muted-foreground mb-1">
              VA name or channel
            </label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="e.g. Anjali, or anjali-reddit"
              className="w-full border rounded-sm px-3 py-2 bg-background"
            />
          </div>

          <div className="flex-[2] min-w-[260px]">
            <label className="block text-xs text-muted-foreground mb-1">Shareable link</label>
            <div className="flex items-center gap-2">
              <code className="flex-1 border rounded-sm px-3 py-2 bg-muted/40 text-xs truncate">
                {url || <span className="text-muted-foreground">enter a name to build the link…</span>}
              </code>
              <Button
                type="button"
                onClick={copy}
                disabled={!url}
                variant="outline"
                className="rounded-sm shrink-0"
              >
                {copied ? <Check className="w-4 h-4 mr-1.5" /> : <Copy className="w-4 h-4 mr-1.5" />}
                {copied ? "Copied" : "Copy"}
              </Button>
            </div>
          </div>
        </div>

        {isDuplicate ? (
          <p className="flex items-center gap-1.5 text-xs text-amber-700 mt-3">
            <AlertTriangle className="w-3.5 h-3.5" />
            <span>
              <code>{slug}</code> already has signups on the dashboard — reuse it only if this is the
              same person, otherwise pick a different name.
            </span>
          </p>
        ) : (
          <p className="text-xs text-muted-foreground mt-3">
            Cleaned to <code>{slug || "—"}</code> (lowercase, letters/numbers/<code>-</code>/<code>_</code>).
            Give this link to the VA; signups they drive appear below under that ref.
          </p>
        )}
      </CardContent>
    </Card>
  );
}

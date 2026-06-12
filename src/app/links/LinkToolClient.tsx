"use client";

import { useCallback, useEffect, useState } from "react";
import { Button } from "@/design-system/components/ui/button";
import { Input } from "@/design-system/components/ui/input";
import { Label } from "@/design-system/components/ui/label";
import {
  LINK_DESTINATIONS,
  LINK_SOURCES,
  destinationForKey,
} from "@/lib/tracked-links";
import {
  Link2,
  Loader2,
  Copy,
  Check,
  Lock,
  MousePointerClick,
  UserPlus,
} from "lucide-react";

interface TrackedLink {
  slug: string;
  destination_key: string;
  source: string;
  label: string;
  click_count: number;
  signup_count: number;
  created_at: string;
}

export default function LinkToolClient() {
  const [authed, setAuthed] = useState<boolean | null>(null);
  const [passcode, setPasscode] = useState("");
  const [authError, setAuthError] = useState("");
  const [links, setLinks] = useState<TrackedLink[]>([]);
  const [origin, setOrigin] = useState("");

  // create form
  const [destinationKey, setDestinationKey] = useState<string>(
    LINK_DESTINATIONS[0].key
  );
  const [source, setSource] = useState<string>(LINK_SOURCES[0].key);
  const [label, setLabel] = useState("");
  const [creating, setCreating] = useState(false);
  const [createError, setCreateError] = useState("");
  const [copied, setCopied] = useState("");

  useEffect(() => {
    setOrigin(window.location.origin);
  }, []);

  const load = useCallback(async () => {
    const res = await fetch("/api/links");
    if (res.status === 401) {
      setAuthed(false);
      return;
    }
    const data = await res.json();
    setLinks(data.links || []);
    setAuthed(true);
  }, []);

  useEffect(() => {
    load();
  }, [load]);

  async function submitPasscode(e: React.FormEvent) {
    e.preventDefault();
    setAuthError("");
    const res = await fetch("/api/links/auth", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ passcode }),
    });
    if (!res.ok) {
      const d = await res.json().catch(() => ({}));
      setAuthError(d.error || "Wrong passcode.");
      return;
    }
    setPasscode("");
    load();
  }

  async function createLink(e: React.FormEvent) {
    e.preventDefault();
    setCreating(true);
    setCreateError("");
    const res = await fetch("/api/links", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ destinationKey, source, label }),
    });
    const data = await res.json();
    if (!res.ok) {
      setCreateError(data.error || "Could not create link");
    } else {
      setLinks((prev) => [data.link, ...prev]);
      setLabel("");
    }
    setCreating(false);
  }

  function shortUrl(slug: string) {
    return `${origin}/l/${slug}`;
  }

  async function copy(slug: string) {
    await navigator.clipboard.writeText(shortUrl(slug));
    setCopied(slug);
    setTimeout(() => setCopied(""), 1500);
  }

  if (authed === null) {
    return (
      <div className="min-h-screen grid place-items-center text-muted-foreground">
        <Loader2 className="w-5 h-5 animate-spin" />
      </div>
    );
  }

  if (authed === false) {
    return (
      <div className="min-h-screen grid place-items-center bg-background px-4">
        <form
          onSubmit={submitPasscode}
          className="w-full max-w-sm bg-card border border-border rounded-2xl p-7 shadow-sm space-y-4"
        >
          <div className="w-11 h-11 rounded-xl bg-[#1a365d]/5 text-[#1a365d] grid place-items-center">
            <Lock className="w-5 h-5" />
          </div>
          <div>
            <h1 className="text-xl font-bold text-foreground">
              Preppeo Link Tool
            </h1>
            <p className="text-sm text-muted-foreground mt-1">
              Enter the passcode to create tracking links.
            </p>
          </div>
          <Input
            type="password"
            value={passcode}
            onChange={(e) => setPasscode(e.target.value)}
            placeholder="Passcode"
            autoFocus
          />
          {authError && <p className="text-sm text-red-600">{authError}</p>}
          <Button
            type="submit"
            className="w-full bg-[#1a365d] hover:bg-[#0f2e4a] text-white"
          >
            Unlock
          </Button>
        </form>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-10 max-w-4xl">
        <div className="flex items-center gap-3 mb-2">
          <div className="w-10 h-10 rounded-xl bg-[#1a365d]/5 text-[#1a365d] grid place-items-center">
            <Link2 className="w-5 h-5" />
          </div>
          <h1 className="text-2xl font-bold text-foreground">
            Community Link Tool
          </h1>
        </div>
        <p className="text-sm text-muted-foreground mb-8">
          Make a fresh link for every post. Each link tracks its own clicks and
          signups, so you can see which posts work.
        </p>

        {/* Maker */}
        <form
          onSubmit={createLink}
          className="bg-card border border-border rounded-2xl p-6 shadow-sm space-y-4 mb-10"
        >
          <div className="grid sm:grid-cols-3 gap-4">
            <div className="space-y-1.5">
              <Label htmlFor="dest">Send people to</Label>
              <select
                id="dest"
                value={destinationKey}
                onChange={(e) => setDestinationKey(e.target.value)}
                className="w-full h-10 rounded-md border border-input bg-background px-3 text-sm"
              >
                {LINK_DESTINATIONS.map((d) => (
                  <option key={d.key} value={d.key}>
                    {d.label}
                  </option>
                ))}
              </select>
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="src">Where you&apos;re posting</Label>
              <select
                id="src"
                value={source}
                onChange={(e) => setSource(e.target.value)}
                className="w-full h-10 rounded-md border border-input bg-background px-3 text-sm"
              >
                {LINK_SOURCES.map((s) => (
                  <option key={s.key} value={s.key}>
                    {s.label}
                  </option>
                ))}
              </select>
            </div>
            <div className="space-y-1.5">
              <Label htmlFor="label">Post note (for you)</Label>
              <Input
                id="label"
                value={label}
                onChange={(e) => setLabel(e.target.value)}
                placeholder="e.g. r/SAT weekly thread"
              />
            </div>
          </div>
          {createError && <p className="text-sm text-red-600">{createError}</p>}
          <Button
            type="submit"
            disabled={creating}
            className="bg-[#1a365d] hover:bg-[#0f2e4a] text-white"
          >
            {creating ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                Creating…
              </>
            ) : (
              "Create link"
            )}
          </Button>
        </form>

        {/* List */}
        <h2 className="text-sm font-bold tracking-widest uppercase text-muted-foreground mb-3">
          Your links
        </h2>
        {links.length === 0 ? (
          <p className="text-muted-foreground text-sm py-8 text-center bg-card border border-border rounded-xl">
            No links yet — create your first one above.
          </p>
        ) : (
          <div className="space-y-3">
            {links.map((l) => {
              const dest = destinationForKey(l.destination_key);
              return (
                <div
                  key={l.slug}
                  className="bg-card border border-border rounded-xl p-4 shadow-sm"
                >
                  <div className="flex flex-wrap items-center gap-3">
                    <code className="text-sm font-semibold text-[#1a365d]">
                      {origin.replace(/^https?:\/\//, "")}/l/{l.slug}
                    </code>
                    <Button
                      type="button"
                      variant="outline"
                      size="sm"
                      onClick={() => copy(l.slug)}
                    >
                      {copied === l.slug ? (
                        <>
                          <Check className="w-3.5 h-3.5 mr-1" /> Copied
                        </>
                      ) : (
                        <>
                          <Copy className="w-3.5 h-3.5 mr-1" /> Copy
                        </>
                      )}
                    </Button>
                    <div className="ml-auto flex items-center gap-4 text-sm">
                      <span
                        className="inline-flex items-center gap-1.5 text-muted-foreground"
                        title="Clicks"
                      >
                        <MousePointerClick className="w-4 h-4" />
                        <b className="text-foreground">{l.click_count}</b>
                      </span>
                      <span
                        className="inline-flex items-center gap-1.5 text-muted-foreground"
                        title="Signups"
                      >
                        <UserPlus className="w-4 h-4" />
                        <b className="text-foreground">{l.signup_count}</b>
                      </span>
                    </div>
                  </div>
                  <div className="flex flex-wrap gap-2 mt-2.5 text-xs">
                    <span className="bg-muted px-2.5 py-1 rounded-full font-medium capitalize">
                      {l.source}
                    </span>
                    <span className="bg-muted px-2.5 py-1 rounded-full font-medium">
                      → {dest?.label ?? l.destination_key}
                    </span>
                    {l.label && (
                      <span className="bg-muted px-2.5 py-1 rounded-full font-medium text-muted-foreground">
                        {l.label}
                      </span>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}

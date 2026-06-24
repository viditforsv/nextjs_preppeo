"use client";

import { useEffect, useMemo, useState } from "react";
import { Card, CardContent } from "@/design-system/components/ui/card";
import { Button } from "@/design-system/components/ui/button";
import { Copy, Check, Save, RotateCcw, Sparkles, AlertTriangle } from "lucide-react";

// Tags promo links for the PostHog dashboard. Nothing is sent anywhere — pure
// client-side string building. Ported from the standalone shrividhya utm-builder.html.

const SOURCES = [
  "whatsapp",
  "instagram",
  "facebook",
  "google",
  "youtube",
  "email",
  "linkedin",
  "referral",
];
const MEDIUMS = [
  "broadcast",
  "bio",
  "story",
  "post",
  "cpc",
  "email",
  "qr",
  "organic-social",
];

const SAVED_KEY = "preppeo_utm_saved";

function kebab(s: string): string {
  return (s || "")
    .toString()
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

function buildUrl(opts: {
  base: string;
  source: string;
  medium: string;
  campaign: string;
  content: string;
  term: string;
}): { ok: boolean; url: string } {
  let base = opts.base.trim();
  const source = opts.source;
  const medium = opts.medium;
  const campaign = kebab(opts.campaign);
  const content = kebab(opts.content);
  const term = kebab(opts.term);

  if (!base || !source || !medium || !campaign) {
    return { ok: false, url: "Fill Destination, source, medium and campaign…" };
  }

  // Split off any existing hash/query, normalise path to end with "/" (trailingSlash).
  let hash = "";
  let query = "";
  const h = base.indexOf("#");
  if (h !== -1) {
    hash = base.slice(h);
    base = base.slice(0, h);
  }
  const q = base.indexOf("?");
  if (q !== -1) {
    query = base.slice(q + 1);
    base = base.slice(0, q);
  }
  if (!/\/$/.test(base)) base += "/";

  const params = new URLSearchParams(query);
  params.set("utm_source", source);
  params.set("utm_medium", medium);
  params.set("utm_campaign", campaign);
  if (content) params.set("utm_content", content);
  else params.delete("utm_content");
  if (term) params.set("utm_term", term);
  else params.delete("utm_term");

  return { ok: true, url: `${base}?${params.toString()}${hash}` };
}

const CUSTOM = "__custom";

export default function UtmBuilderClient() {
  const [base, setBase] = useState("https://preppeo.com/");
  const [source, setSource] = useState("");
  const [sourceCustom, setSourceCustom] = useState("");
  const [medium, setMedium] = useState("");
  const [mediumCustom, setMediumCustom] = useState("");
  const [campaign, setCampaign] = useState("");
  const [content, setContent] = useState("");
  const [term, setTerm] = useState("");

  const [copied, setCopied] = useState(false);
  const [saved, setSaved] = useState<string[]>([]);

  useEffect(() => {
    try {
      setSaved(JSON.parse(localStorage.getItem(SAVED_KEY) || "[]"));
    } catch {
      setSaved([]);
    }
  }, []);

  function persist(next: string[]) {
    setSaved(next);
    localStorage.setItem(SAVED_KEY, JSON.stringify(next));
  }

  const result = useMemo(
    () =>
      buildUrl({
        base,
        source: source === CUSTOM ? kebab(sourceCustom) : source,
        medium: medium === CUSTOM ? kebab(mediumCustom) : medium,
        campaign,
        content,
        term,
      }),
    [base, source, sourceCustom, medium, mediumCustom, campaign, content, term],
  );

  async function copy(text: string, flag = false) {
    try {
      await navigator.clipboard.writeText(text);
      if (flag) {
        setCopied(true);
        setTimeout(() => setCopied(false), 1200);
      }
    } catch {
      /* clipboard blocked — user can still select the text */
    }
  }

  function saveCurrent() {
    if (!result.ok) return;
    if (!saved.includes(result.url)) persist([result.url, ...saved]);
  }

  function reset() {
    setCampaign("");
    setContent("");
    setTerm("");
    setSource("");
    setSourceCustom("");
    setMedium("");
    setMediumCustom("");
  }

  function fillExample() {
    setBase("https://preppeo.com/sat-promo/");
    setSource("instagram");
    setSourceCustom("");
    setMedium("bio");
    setMediumCustom("");
    setCampaign("sat-promo-jun2026");
    setContent("");
    setTerm("");
  }

  const labelCls = "block text-xs font-semibold mb-1.5 mt-3";
  const inputCls =
    "w-full border rounded-sm px-3 py-2 bg-background text-sm focus:outline-none focus:border-primary";

  return (
    <div className="space-y-5">
      {/* Warning banner */}
      <div className="rounded-sm border-l-4 border-amber-400 bg-amber-50 px-4 py-3 text-[13px] text-amber-800">
        Tag <strong>external/promo links only</strong> — never internal site
        navigation, or visitors self-attribute. Keep <code>utm_campaign</code> spelling
        identical across a campaign; a typo creates a new row in the dashboard.
      </div>

      {/* New-to-this helper */}
      <Card className="rounded-sm border-primary/40">
        <CardContent className="p-5">
          <h2 className="text-sm font-semibold mb-2">🟢 New to this? It takes 30 seconds</h2>
          <p className="text-[13px] text-muted-foreground mb-3">
            A UTM link is just your normal link with a little label stuck on the end. The
            label tells the dashboard <em>where a visitor came from</em> — so you can see
            which Instagram post or WhatsApp message actually brought students. Nothing
            breaks; the link still works exactly the same.
          </p>
          <p className="text-[13px] mb-1">
            <strong>When to use it:</strong> any time you share a link somewhere —
            Instagram bio, WhatsApp broadcast, a YouTube description, an ad.
          </p>
          <ol className="list-decimal pl-5 text-[13px] space-y-1 mt-2">
            <li>
              <strong>Where</strong> are you posting it? Pick <em>source</em> (e.g.
              instagram) and <em>medium</em> (e.g. bio).
            </li>
            <li>
              <strong>Which promo</strong> is it? Type a <em>campaign</em> name, e.g.{" "}
              <code>sat-promo-jun2026</code>.
            </li>
            <li>
              Click <strong>Copy link</strong> and paste <em>that</em> instead of your
              plain link. Done.
            </li>
          </ol>
          <Button
            type="button"
            variant="outline"
            className="rounded-sm mt-4"
            onClick={fillExample}
          >
            <Sparkles className="w-4 h-4 mr-1.5" /> Fill an example for me
          </Button>
        </CardContent>
      </Card>

      {/* Builder */}
      <Card className="rounded-sm">
        <CardContent className="p-5">
          <label className={labelCls}>
            Destination URL <span className="text-primary">*</span>
          </label>
          <input
            className={inputCls}
            value={base}
            onChange={(e) => setBase(e.target.value)}
          />
          <div className="flex flex-wrap gap-2 mt-2">
            <button
              type="button"
              className="text-xs border rounded-sm px-2 py-1 bg-muted/40 hover:bg-muted"
              onClick={() => setBase("https://preppeo.com/")}
            >
              preppeo.com
            </button>
            <button
              type="button"
              className="text-xs border rounded-sm px-2 py-1 bg-muted/40 hover:bg-muted"
              onClick={() => setBase("https://shrividhya.in/")}
            >
              shrividhya.in
            </button>
          </div>
          <p className="text-xs text-muted-foreground mt-1.5">
            Trailing slash is added before <code>?</code> automatically.
          </p>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <div>
              <label className={labelCls}>
                utm_source <span className="text-primary">*</span>{" "}
                <span className="font-normal text-muted-foreground">— where</span>
              </label>
              <select
                className={inputCls}
                value={source}
                onChange={(e) => setSource(e.target.value)}
              >
                <option value="">— select —</option>
                {SOURCES.map((s) => (
                  <option key={s} value={s}>
                    {s}
                  </option>
                ))}
                <option value={CUSTOM}>+ custom…</option>
              </select>
              {source === CUSTOM && (
                <input
                  className={`${inputCls} mt-2`}
                  placeholder="custom source (lowercase)"
                  value={sourceCustom}
                  onChange={(e) => setSourceCustom(e.target.value)}
                />
              )}
            </div>
            <div>
              <label className={labelCls}>
                utm_medium <span className="text-primary">*</span>{" "}
                <span className="font-normal text-muted-foreground">— type</span>
              </label>
              <select
                className={inputCls}
                value={medium}
                onChange={(e) => setMedium(e.target.value)}
              >
                <option value="">— select —</option>
                {MEDIUMS.map((m) => (
                  <option key={m} value={m}>
                    {m}
                  </option>
                ))}
                <option value={CUSTOM}>+ custom…</option>
              </select>
              {medium === CUSTOM && (
                <input
                  className={`${inputCls} mt-2`}
                  placeholder="custom medium (lowercase)"
                  value={mediumCustom}
                  onChange={(e) => setMediumCustom(e.target.value)}
                />
              )}
            </div>
          </div>

          <label className={labelCls}>
            utm_campaign <span className="text-primary">*</span>{" "}
            <span className="font-normal text-muted-foreground">— the specific promo</span>
          </label>
          <input
            className={inputCls}
            placeholder="e.g. sat-promo-jun2026"
            value={campaign}
            onChange={(e) => setCampaign(e.target.value)}
          />
          <p className="text-xs text-muted-foreground mt-1.5">
            Auto-formatted to <code>lowercase-kebab-case</code>.
          </p>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <div>
              <label className={labelCls}>
                utm_content{" "}
                <span className="font-normal text-muted-foreground">
                  — optional, creative variant
                </span>
              </label>
              <input
                className={inputCls}
                placeholder="e.g. video-a"
                value={content}
                onChange={(e) => setContent(e.target.value)}
              />
            </div>
            <div>
              <label className={labelCls}>
                utm_term{" "}
                <span className="font-normal text-muted-foreground">
                  — optional, paid keyword
                </span>
              </label>
              <input
                className={inputCls}
                placeholder="e.g. igcse-maths-tutor"
                value={term}
                onChange={(e) => setTerm(e.target.value)}
              />
            </div>
          </div>

          {/* Output */}
          <div
            className={`mt-4 rounded-sm border bg-muted/40 px-3 py-3 font-mono text-[13px] break-all ${
              result.ok ? "text-emerald-700" : "text-amber-700"
            }`}
          >
            {result.url || "—"}
          </div>
          <div className="flex flex-wrap gap-2 mt-3">
            <Button
              type="button"
              className="rounded-sm"
              disabled={!result.ok}
              onClick={() => copy(result.url, true)}
            >
              {copied ? (
                <Check className="w-4 h-4 mr-1.5" />
              ) : (
                <Copy className="w-4 h-4 mr-1.5" />
              )}
              {copied ? "Copied!" : "Copy link"}
            </Button>
            <Button
              type="button"
              variant="outline"
              className="rounded-sm"
              disabled={!result.ok}
              onClick={saveCurrent}
            >
              <Save className="w-4 h-4 mr-1.5" /> Save to list
            </Button>
            <Button type="button" variant="outline" className="rounded-sm" onClick={reset}>
              <RotateCcw className="w-4 h-4 mr-1.5" /> Reset
            </Button>
          </div>
        </CardContent>
      </Card>

      {/* Saved links */}
      <Card className="rounded-sm">
        <CardContent className="p-5">
          <h2 className="text-sm font-semibold mb-3">
            Saved links{" "}
            <span className="font-normal text-muted-foreground">(this browser only)</span>
          </h2>
          {saved.length === 0 ? (
            <p className="text-[13px] text-muted-foreground">No saved links yet.</p>
          ) : (
            <div className="divide-y">
              {saved.map((url, i) => (
                <div key={url} className="flex items-center gap-2 py-2">
                  <span className="flex-1 font-mono text-xs text-muted-foreground break-all">
                    {url}
                  </span>
                  <Button
                    type="button"
                    variant="outline"
                    className="rounded-sm shrink-0 h-8 px-2.5 text-xs"
                    onClick={() => copy(url)}
                  >
                    Copy
                  </Button>
                  <Button
                    type="button"
                    variant="outline"
                    className="rounded-sm shrink-0 h-8 px-2.5 text-xs"
                    onClick={() => persist(saved.filter((_, j) => j !== i))}
                  >
                    ✕
                  </Button>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>

      {/* Convention reference */}
      <Card className="rounded-sm">
        <CardContent className="p-5">
          <h2 className="text-sm font-semibold mb-3">Convention reference</h2>
          <div className="overflow-x-auto">
            <table className="w-full text-[13px]">
              <thead>
                <tr className="text-muted-foreground">
                  <th className="text-left font-semibold py-1.5 pr-3">Param</th>
                  <th className="text-left font-semibold py-1.5 pr-3">Use</th>
                  <th className="text-left font-semibold py-1.5">Allowed values</th>
                </tr>
              </thead>
              <tbody>
                <tr className="border-t">
                  <td className="py-1.5 pr-3">
                    <code>utm_source</code>
                  </td>
                  <td className="py-1.5 pr-3">Where the click came from</td>
                  <td className="py-1.5">{SOURCES.join(" · ")}</td>
                </tr>
                <tr className="border-t">
                  <td className="py-1.5 pr-3">
                    <code>utm_medium</code>
                  </td>
                  <td className="py-1.5 pr-3">Type of placement</td>
                  <td className="py-1.5">{MEDIUMS.join(" · ")}</td>
                </tr>
                <tr className="border-t">
                  <td className="py-1.5 pr-3">
                    <code>utm_campaign</code>
                  </td>
                  <td className="py-1.5 pr-3">The specific promo</td>
                  <td className="py-1.5">
                    <code>sat-promo-jun2026</code>, <code>igcse-maths-launch</code>,{" "}
                    <code>diwali-offer</code>
                  </td>
                </tr>
                <tr className="border-t">
                  <td className="py-1.5 pr-3">
                    <code>utm_content</code>
                  </td>
                  <td className="py-1.5 pr-3">Creative/variant (optional)</td>
                  <td className="py-1.5">
                    <code>video-a</code>, <code>banner-b</code>
                  </td>
                </tr>
                <tr className="border-t">
                  <td className="py-1.5 pr-3">
                    <code>utm_term</code>
                  </td>
                  <td className="py-1.5 pr-3">Paid keyword (optional)</td>
                  <td className="py-1.5">
                    <code>igcse-maths-tutor</code>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <p className="flex items-center gap-1.5 text-xs text-muted-foreground mt-3">
            <AlertTriangle className="w-3.5 h-3.5 shrink-0" />
            Internal tool — links are built in your browser; nothing is sent anywhere.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}

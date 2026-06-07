"use client";

import { useState } from "react";
import { Button } from "@/design-system/components/ui/button";
import { Input } from "@/design-system/components/ui/input";
import { Label } from "@/design-system/components/ui/label";
import { Textarea } from "@/design-system/components/ui/textarea";
import { CheckCircle2, Loader2, Plus, X } from "lucide-react";

interface ApplyFormProps {
  slug: string;
  roleTitle: string;
}

export default function ApplyForm({ slug, roleTitle }: ApplyFormProps) {
  const [form, setForm] = useState({
    name: "",
    email: "",
    phone: "",
    resumeUrl: "",
    coverNote: "",
  });
  const [portfolioLinks, setPortfolioLinks] = useState<string[]>([""]);
  const [status, setStatus] = useState<
    "idle" | "submitting" | "success" | "error"
  >("idle");
  const [errorMsg, setErrorMsg] = useState("");

  const set = (field: keyof typeof form) => (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => setForm((f) => ({ ...f, [field]: e.target.value }));

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setStatus("submitting");
    setErrorMsg("");
    try {
      const res = await fetch("/api/careers/apply", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          slug,
          ...form,
          portfolioLinks: portfolioLinks
            .map((l) => l.trim())
            .filter(Boolean),
        }),
      });
      const data = await res.json();
      if (!res.ok) {
        setErrorMsg(data.error || "Something went wrong. Please try again.");
        setStatus("error");
        return;
      }
      setStatus("success");
    } catch {
      setErrorMsg("Network error. Please try again.");
      setStatus("error");
    }
  }

  if (status === "success") {
    return (
      <div className="flex items-start gap-3 bg-green-50 border border-green-200 rounded-xl p-5">
        <CheckCircle2 className="w-5 h-5 text-green-600 mt-0.5 flex-none" />
        <div>
          <p className="font-semibold text-green-800">
            Application received!
          </p>
          <p className="text-sm text-green-700 mt-1">
            Thanks for applying for {roleTitle}. We&apos;ve emailed you a
            confirmation and will get back to you within a few days.
          </p>
        </div>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      <div className="grid sm:grid-cols-2 gap-5">
        <div className="space-y-1.5">
          <Label htmlFor="name">Full name *</Label>
          <Input
            id="name"
            required
            value={form.name}
            onChange={set("name")}
            placeholder="Your name"
          />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="email">Email *</Label>
          <Input
            id="email"
            type="email"
            required
            value={form.email}
            onChange={set("email")}
            placeholder="you@example.com"
          />
        </div>
      </div>

      <div className="grid sm:grid-cols-2 gap-5">
        <div className="space-y-1.5">
          <Label htmlFor="phone">Phone / WhatsApp</Label>
          <Input
            id="phone"
            type="tel"
            value={form.phone}
            onChange={set("phone")}
            placeholder="+91 ..."
          />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="resumeUrl">Resume link *</Label>
          <Input
            id="resumeUrl"
            type="url"
            required
            value={form.resumeUrl}
            onChange={set("resumeUrl")}
            placeholder="Google Drive / Dropbox link (make sure it's shareable)"
          />
        </div>
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="portfolio-0">
          Profiles / communities you&apos;ve managed
        </Label>
        <p className="text-xs text-muted-foreground">
          Add each link separately — Reddit profile, Discord server, LinkedIn,
          personal site…
        </p>
        <div className="space-y-2">
          {portfolioLinks.map((link, i) => (
            <div key={i} className="flex gap-2">
              <Input
                id={`portfolio-${i}`}
                type="url"
                value={link}
                onChange={(e) =>
                  setPortfolioLinks((links) =>
                    links.map((l, j) => (j === i ? e.target.value : l))
                  )
                }
                placeholder="https://…"
              />
              {portfolioLinks.length > 1 && (
                <Button
                  type="button"
                  variant="outline"
                  size="icon"
                  aria-label="Remove link"
                  onClick={() =>
                    setPortfolioLinks((links) =>
                      links.filter((_, j) => j !== i)
                    )
                  }
                >
                  <X className="w-4 h-4" />
                </Button>
              )}
            </div>
          ))}
        </div>
        <Button
          type="button"
          variant="outline"
          size="sm"
          className="mt-1"
          onClick={() => setPortfolioLinks((links) => [...links, ""])}
        >
          <Plus className="w-4 h-4 mr-1.5" />
          Add another link
        </Button>
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="coverNote">Why you? *</Label>
        <Textarea
          id="coverNote"
          required
          rows={5}
          value={form.coverNote}
          onChange={set("coverNote")}
          placeholder="A short note — what you've done, what you'd do here, and why this role."
        />
      </div>

      {status === "error" && (
        <p className="text-sm text-red-600">{errorMsg}</p>
      )}

      <Button
        type="submit"
        disabled={status === "submitting"}
        className="bg-[#1a365d] hover:bg-[#0f2e4a] text-white px-8"
      >
        {status === "submitting" ? (
          <>
            <Loader2 className="w-4 h-4 mr-2 animate-spin" />
            Submitting…
          </>
        ) : (
          "Submit application"
        )}
      </Button>
    </form>
  );
}

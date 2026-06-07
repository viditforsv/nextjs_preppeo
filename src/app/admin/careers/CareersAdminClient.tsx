"use client";

import { useCallback, useEffect, useState } from "react";
import Link from "next/link";
import { Button } from "@/design-system/components/ui/button";
import { Input } from "@/design-system/components/ui/input";
import { Label } from "@/design-system/components/ui/label";
import { Textarea } from "@/design-system/components/ui/textarea";
import { Badge } from "@/design-system/components/ui/badge";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/design-system/components/ui/card";
import {
  ArrowLeft,
  Plus,
  Loader2,
  ExternalLink,
  ChevronDown,
  ChevronUp,
} from "lucide-react";
import type { JobPosting } from "@/types/careers";

type Draft = {
  slug: string;
  title: string;
  team: string;
  location: string;
  employment_type: string;
  salary_range: string;
  min_duration: string;
  blurb: string;
  about_role: string;
  responsibilities: string; // one per line in the editor
  requirements: string;
  nice_to_have: string;
};

const EMPTY_DRAFT: Draft = {
  slug: "",
  title: "",
  team: "",
  location: "Remote",
  employment_type: "Full-time",
  salary_range: "",
  min_duration: "",
  blurb: "",
  about_role: "",
  responsibilities: "",
  requirements: "",
  nice_to_have: "",
};

function toDraft(p: JobPosting): Draft {
  return {
    slug: p.slug,
    title: p.title,
    team: p.team,
    location: p.location,
    employment_type: p.employment_type,
    salary_range: p.salary_range,
    min_duration: p.min_duration,
    blurb: p.blurb,
    about_role: p.about_role,
    responsibilities: p.responsibilities.join("\n"),
    requirements: p.requirements.join("\n"),
    nice_to_have: p.nice_to_have.join("\n"),
  };
}

function fromDraft(d: Draft) {
  const lines = (s: string) =>
    s
      .split("\n")
      .map((l) => l.trim())
      .filter(Boolean);
  return {
    slug: d.slug.trim(),
    title: d.title.trim(),
    team: d.team.trim(),
    location: d.location.trim(),
    employment_type: d.employment_type.trim(),
    salary_range: d.salary_range.trim(),
    min_duration: d.min_duration.trim(),
    blurb: d.blurb.trim(),
    about_role: d.about_role.trim(),
    responsibilities: lines(d.responsibilities),
    requirements: lines(d.requirements),
    nice_to_have: lines(d.nice_to_have),
  };
}

function slugify(s: string) {
  return s
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

export default function CareersAdminClient() {
  const [postings, setPostings] = useState<JobPosting[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [editingId, setEditingId] = useState<string | null>(null); // posting id or 'new'
  const [draft, setDraft] = useState<Draft>(EMPTY_DRAFT);
  const [saving, setSaving] = useState(false);
  const [togglingId, setTogglingId] = useState<string | null>(null);

  const load = useCallback(async () => {
    setError("");
    const res = await fetch("/api/admin/careers");
    const data = await res.json();
    if (!res.ok) {
      setError(data.error || "Failed to load postings");
    } else {
      setPostings(data.postings);
    }
    setLoading(false);
  }, []);

  useEffect(() => {
    load();
  }, [load]);

  async function toggleOpen(p: JobPosting) {
    setTogglingId(p.id);
    setError("");
    const res = await fetch("/api/admin/careers", {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ id: p.id, is_open: !p.is_open }),
    });
    const data = await res.json();
    if (!res.ok) {
      setError(data.error || "Failed to update");
    } else {
      setPostings((list) =>
        list.map((x) => (x.id === p.id ? data.posting : x))
      );
    }
    setTogglingId(null);
  }

  async function save() {
    setSaving(true);
    setError("");
    const payload = fromDraft(draft);
    const isNew = editingId === "new";
    const res = await fetch("/api/admin/careers", {
      method: isNew ? "POST" : "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(isNew ? payload : { id: editingId, ...payload }),
    });
    const data = await res.json();
    if (!res.ok) {
      setError(data.error || "Failed to save");
    } else {
      setPostings((list) =>
        isNew
          ? [...list, data.posting]
          : list.map((x) => (x.id === editingId ? data.posting : x))
      );
      setEditingId(null);
      setDraft(EMPTY_DRAFT);
    }
    setSaving(false);
  }

  const field = (
    label: string,
    key: keyof Draft,
    opts?: { textarea?: boolean; rows?: number; hint?: string }
  ) => (
    <div className="space-y-1.5">
      <Label htmlFor={`f-${key}`}>{label}</Label>
      {opts?.textarea ? (
        <Textarea
          id={`f-${key}`}
          rows={opts.rows ?? 4}
          value={draft[key]}
          onChange={(e) => setDraft((d) => ({ ...d, [key]: e.target.value }))}
        />
      ) : (
        <Input
          id={`f-${key}`}
          value={draft[key]}
          onChange={(e) => {
            const v = e.target.value;
            setDraft((d) =>
              key === "title" && editingId === "new"
                ? { ...d, title: v, slug: slugify(v) }
                : { ...d, [key]: v }
            );
          }}
        />
      )}
      {opts?.hint && (
        <p className="text-xs text-muted-foreground">{opts.hint}</p>
      )}
    </div>
  );

  const editor = (
    <Card className="border-[#1a365d]/30">
      <CardHeader>
        <CardTitle className="text-lg">
          {editingId === "new" ? "New role" : "Edit role"}
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid sm:grid-cols-2 gap-4">
          {field("Title", "title")}
          {field("Slug (URL)", "slug", { hint: "/careers/<slug>" })}
        </div>
        <div className="grid sm:grid-cols-3 gap-4">
          {field("Team", "team")}
          {field("Location", "location")}
          {field("Employment type", "employment_type")}
        </div>
        <div className="grid sm:grid-cols-2 gap-4">
          {field("Salary (blank = hidden)", "salary_range", {
            hint: "e.g. ₹5,000 fixed + up to ₹5,000 incentives / month",
          })}
          {field("Minimum duration (blank = hidden)", "min_duration", {
            hint: "e.g. 3-month minimum",
          })}
        </div>
        {field("Blurb (listing card one-liner)", "blurb", {
          textarea: true,
          rows: 2,
        })}
        {field("About the role", "about_role", { textarea: true, rows: 4 })}
        {field("Responsibilities", "responsibilities", {
          textarea: true,
          rows: 6,
          hint: "One bullet per line",
        })}
        {field("Requirements", "requirements", {
          textarea: true,
          rows: 5,
          hint: "One bullet per line",
        })}
        {field("Nice to have", "nice_to_have", {
          textarea: true,
          rows: 3,
          hint: "One bullet per line",
        })}
        <div className="flex gap-3 pt-2">
          <Button
            onClick={save}
            disabled={saving}
            className="bg-[#1a365d] hover:bg-[#0f2e4a] text-white"
          >
            {saving && <Loader2 className="w-4 h-4 mr-2 animate-spin" />}
            Save
          </Button>
          <Button
            variant="outline"
            onClick={() => {
              setEditingId(null);
              setDraft(EMPTY_DRAFT);
            }}
          >
            Cancel
          </Button>
        </div>
      </CardContent>
    </Card>
  );

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8 max-w-4xl">
        <Link
          href="/admin/site-administration"
          className="inline-flex items-center text-muted-foreground hover:text-foreground transition-colors text-sm mb-6"
        >
          <ArrowLeft className="w-4 h-4 mr-2" />
          Site Administration
        </Link>

        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-2xl font-bold text-foreground">
              Careers — Job Postings
            </h1>
            <p className="text-sm text-muted-foreground mt-1">
              Open/close roles and edit listings shown on{" "}
              <Link
                href="/careers"
                className="underline inline-flex items-center gap-1"
                target="_blank"
              >
                /careers <ExternalLink className="w-3 h-3" />
              </Link>
            </p>
          </div>
          <Button
            onClick={() => {
              setEditingId("new");
              setDraft(EMPTY_DRAFT);
            }}
            disabled={editingId === "new"}
            className="bg-[#1a365d] hover:bg-[#0f2e4a] text-white"
          >
            <Plus className="w-4 h-4 mr-2" />
            New role
          </Button>
        </div>

        {error && <p className="text-sm text-red-600 mb-4">{error}</p>}

        {editingId === "new" && <div className="mb-6">{editor}</div>}

        {loading ? (
          <div className="flex items-center gap-2 text-muted-foreground py-12 justify-center">
            <Loader2 className="w-4 h-4 animate-spin" /> Loading…
          </div>
        ) : (
          <div className="space-y-4">
            {postings.map((p) => (
              <div key={p.id}>
                <Card className={p.is_open ? "" : "opacity-70"}>
                  <CardContent className="flex flex-wrap items-center gap-4 py-4">
                    <div className="flex-1 min-w-[220px]">
                      <div className="flex items-center gap-2.5 flex-wrap">
                        <span className="font-semibold text-foreground">
                          {p.title}
                        </span>
                        <Badge
                          variant={p.is_open ? "default" : "secondary"}
                          className={
                            p.is_open ? "bg-green-600 hover:bg-green-600" : ""
                          }
                        >
                          {p.is_open ? "Open" : "Closed"}
                        </Badge>
                      </div>
                      <p className="text-xs text-muted-foreground mt-1">
                        {p.team} · {p.location} · {p.employment_type} ·{" "}
                        /careers/{p.slug}
                      </p>
                    </div>
                    <div className="flex gap-2">
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => {
                          if (editingId === p.id) {
                            setEditingId(null);
                          } else {
                            setEditingId(p.id);
                            setDraft(toDraft(p));
                          }
                        }}
                      >
                        {editingId === p.id ? (
                          <>
                            <ChevronUp className="w-4 h-4 mr-1" /> Close
                          </>
                        ) : (
                          <>
                            <ChevronDown className="w-4 h-4 mr-1" /> Edit
                          </>
                        )}
                      </Button>
                      <Button
                        size="sm"
                        variant={p.is_open ? "destructive" : "primary"}
                        disabled={togglingId === p.id}
                        onClick={() => toggleOpen(p)}
                        className={
                          p.is_open
                            ? ""
                            : "bg-green-600 hover:bg-green-700 text-white"
                        }
                      >
                        {togglingId === p.id ? (
                          <Loader2 className="w-4 h-4 animate-spin" />
                        ) : p.is_open ? (
                          "Close role"
                        ) : (
                          "Reopen role"
                        )}
                      </Button>
                    </div>
                  </CardContent>
                </Card>
                {editingId === p.id && <div className="mt-3">{editor}</div>}
              </div>
            ))}
            {postings.length === 0 && (
              <p className="text-center text-muted-foreground py-12">
                No postings yet — create one with “New role”.
              </p>
            )}
          </div>
        )}
      </div>
    </div>
  );
}

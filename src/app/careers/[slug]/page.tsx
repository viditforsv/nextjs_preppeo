import Link from "next/link";
import { notFound } from "next/navigation";
import type { Metadata } from "next";
import { ArrowLeft, MapPin, Clock, CheckCircle2 } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import type { JobPosting } from "@/types/careers";
import ApplyForm from "./ApplyForm";

// RLS hides closed postings, so a closed role 404s automatically.
export const dynamic = "force-dynamic";

async function getPosting(slug: string): Promise<JobPosting | null> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("job_postings")
    .select("*")
    .eq("slug", slug)
    .maybeSingle();
  return data as JobPosting | null;
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const posting = await getPosting(slug);
  if (!posting) return { title: "Role not found | Preppeo Careers" };
  return {
    title: `${posting.title} | Preppeo Careers`,
    description: posting.blurb,
  };
}

function BulletList({ items }: { items: string[] }) {
  return (
    <ul className="space-y-2.5">
      {items.map((item) => (
        <li key={item} className="flex items-start gap-2.5">
          <CheckCircle2 className="w-[18px] h-[18px] text-amber-500 mt-0.5 flex-none" />
          <span className="text-[15px] text-foreground/85 leading-relaxed">
            {item}
          </span>
        </li>
      ))}
    </ul>
  );
}

export default async function RolePage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const posting = await getPosting(slug);
  if (!posting) notFound();

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="bg-gradient-to-br from-[#1a365d]/5 to-white border-b border-primary py-6 relative">
        <div className="container mx-auto px-4">
          <Link
            href="/careers"
            className="inline-flex items-center text-muted-foreground hover:text-foreground transition-colors"
          >
            <ArrowLeft className="w-4 h-4 mr-2" />
            All open roles
          </Link>
        </div>
      </div>

      <div className="container mx-auto px-4 py-10 max-w-3xl">
        {/* Title block */}
        <span className="text-[11px] font-bold tracking-wider uppercase text-[#1a365d] bg-[#1a365d]/5 px-3 py-1.5 rounded-full">
          {posting.team}
        </span>
        <h1 className="text-3xl sm:text-4xl font-extrabold tracking-tight text-foreground mt-4">
          {posting.title}
        </h1>
        <div className="flex flex-wrap gap-2 mt-4">
          <span className="inline-flex items-center gap-1.5 text-xs font-semibold text-muted-foreground bg-muted px-3 py-1.5 rounded-full">
            <MapPin className="w-3 h-3" />
            {posting.location}
          </span>
          <span className="inline-flex items-center gap-1.5 text-xs font-semibold text-muted-foreground bg-muted px-3 py-1.5 rounded-full">
            <Clock className="w-3 h-3" />
            {posting.employment_type}
          </span>
        </div>

        {/* About */}
        {posting.about_role && (
          <section className="mt-10">
            <h2 className="text-xl font-bold text-foreground mb-3">
              About the role
            </h2>
            <p className="text-[15px] text-foreground/85 leading-relaxed whitespace-pre-line">
              {posting.about_role}
            </p>
          </section>
        )}

        {posting.responsibilities.length > 0 && (
          <section className="mt-10">
            <h2 className="text-xl font-bold text-foreground mb-4">
              What you&apos;ll do
            </h2>
            <BulletList items={posting.responsibilities} />
          </section>
        )}

        {posting.requirements.length > 0 && (
          <section className="mt-10">
            <h2 className="text-xl font-bold text-foreground mb-4">
              What we&apos;re looking for
            </h2>
            <BulletList items={posting.requirements} />
          </section>
        )}

        {posting.nice_to_have.length > 0 && (
          <section className="mt-10">
            <h2 className="text-xl font-bold text-foreground mb-4">
              Nice to have
            </h2>
            <BulletList items={posting.nice_to_have} />
          </section>
        )}

        {/* Apply */}
        <section className="mt-14 scroll-mt-24" id="apply">
          <div className="bg-card border border-border rounded-2xl p-6 sm:p-8 shadow-sm">
            <h2 className="text-2xl font-bold text-foreground">
              Apply for this role
            </h2>
            <p className="text-sm text-muted-foreground mt-1.5 mb-6">
              We review every application and reply within a few days.
            </p>
            <ApplyForm slug={posting.slug} roleTitle={posting.title} />
          </div>
        </section>
      </div>
    </div>
  );
}

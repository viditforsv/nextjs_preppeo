import Link from "next/link";
import {
  ArrowLeft,
  ArrowRight,
  MapPin,
  Clock,
  IndianRupee,
  Star,
  TrendingUp,
  Users,
} from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import type { JobPosting } from "@/types/careers";

// Listings are managed in /admin/careers — read fresh so open/close
// toggles show without a redeploy.
export const dynamic = "force-dynamic";

const values = [
  {
    icon: Star,
    title: "Students first, always",
    text: "Every decision starts with one question: does this help a student learn faster or score higher?",
  },
  {
    icon: TrendingUp,
    title: "Ship, measure, learn",
    text: "We launch small, watch the data, and iterate. Real outcomes beat polished opinions.",
  },
  {
    icon: Users,
    title: "Own the outcome",
    text: "You'll have the room to make real calls — and the support to back them up end to end.",
  },
];

export default async function CareersPage() {
  const supabase = await createClient();
  // RLS only exposes postings with is_open = true.
  const { data } = await supabase
    .from("job_postings")
    .select(
      "id, slug, title, team, location, employment_type, salary_range, blurb"
    )
    .order("created_at", { ascending: true });
  const roles = (data ?? []) as Pick<
    JobPosting,
    | "id"
    | "slug"
    | "title"
    | "team"
    | "location"
    | "employment_type"
    | "salary_range"
    | "blurb"
  >[];

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="bg-gradient-to-br from-[#1a365d]/5 to-white border-b border-primary py-6 relative">
        <div className="container mx-auto px-4">
          <Link
            href="/"
            className="inline-flex items-center text-muted-foreground hover:text-foreground transition-colors"
          >
            <ArrowLeft className="w-4 h-4 mr-2" />
            Back to Home
          </Link>
        </div>
      </div>

      <div className="container mx-auto px-4 py-10 max-w-5xl">
        {/* Hero */}
        <section className="bg-[#1a365d] rounded-3xl px-8 py-12 sm:px-14 sm:py-14 relative overflow-hidden">
          <div
            className="absolute -right-24 -top-24 w-80 h-80 rounded-full pointer-events-none"
            style={{
              background:
                "radial-gradient(circle at center, rgba(240,168,29,.22), transparent 70%)",
            }}
          />
          <span className="inline-flex items-center gap-2 text-sm font-semibold text-blue-100 bg-white/10 border border-white/20 px-4 py-1.5 rounded-full mb-6">
            <span className="w-2 h-2 rounded-full bg-amber-400" />
            {roles.length > 0
              ? `We're hiring — ${roles.length} open role${roles.length === 1 ? "" : "s"}`
              : "Careers at Preppeo"}
          </span>
          <h1 className="text-4xl sm:text-5xl font-extrabold tracking-tight text-white leading-tight max-w-xl">
            Help students <span className="text-amber-400">master the SAT.</span>
          </h1>
          <p className="text-lg text-blue-100/90 leading-relaxed max-w-xl mt-5">
            We&apos;re building the prep platform we wish we&apos;d had —
            adaptive practice, real mocks, and human coaching. Come build it
            with us.
          </p>
          <a
            href="#roles"
            className="inline-flex items-center gap-2 mt-8 bg-amber-400 hover:bg-amber-500 text-[#5a3d00] font-semibold px-6 py-3 rounded-xl transition-colors"
          >
            View open roles
            <ArrowRight className="w-4 h-4" />
          </a>
        </section>

        {/* Values */}
        <section className="mt-16">
          <div className="max-w-xl mb-8">
            <div className="text-xs font-bold tracking-widest uppercase text-amber-500 mb-3">
              How we work
            </div>
            <h2 className="text-3xl font-bold tracking-tight text-foreground">
              The principles behind everything we ship.
            </h2>
          </div>
          <div className="grid gap-5 sm:grid-cols-3">
            {values.map((v) => (
              <div
                key={v.title}
                className="bg-card border border-border rounded-2xl p-6 shadow-sm"
              >
                <div className="w-11 h-11 rounded-xl bg-amber-50 text-[#1a365d] grid place-items-center mb-4">
                  <v.icon className="w-5 h-5" />
                </div>
                <h3 className="text-lg font-bold text-foreground mb-1.5">
                  {v.title}
                </h3>
                <p className="text-sm text-muted-foreground leading-relaxed">
                  {v.text}
                </p>
              </div>
            ))}
          </div>
        </section>

        {/* Open roles */}
        <section className="mt-16 scroll-mt-24" id="roles">
          <div className="max-w-xl mb-8">
            <div className="text-xs font-bold tracking-widest uppercase text-amber-500 mb-3">
              Open roles
            </div>
            <h2 className="text-3xl font-bold tracking-tight text-foreground">
              Find your seat.
            </h2>
            <p className="text-muted-foreground mt-2">
              Don&apos;t see your role? We always want to hear from great
              people.
            </p>
          </div>

          {roles.length === 0 ? (
            <div className="text-center text-muted-foreground bg-card border border-border rounded-xl py-12 px-6">
              No open roles right now — check back soon, or introduce yourself
              below.
            </div>
          ) : (
            <div className="flex flex-col gap-3">
              {roles.map((r) => (
                <Link
                  key={r.id}
                  href={`/careers/${r.slug}`}
                  className="group flex flex-wrap items-center gap-5 bg-card border border-border rounded-xl px-6 py-5 shadow-sm hover:border-[#1a365d]/30 hover:shadow-md transition-all"
                >
                  <span className="text-[11px] font-bold tracking-wider uppercase text-[#1a365d] bg-[#1a365d]/5 px-3 py-1.5 rounded-full">
                    {r.team}
                  </span>
                  <div className="flex-1 min-w-[220px]">
                    <div className="text-lg font-bold text-foreground">
                      {r.title}
                    </div>
                    <p className="text-sm text-muted-foreground mt-1">
                      {r.blurb}
                    </p>
                    <div className="flex flex-wrap gap-2 mt-3">
                      <span className="inline-flex items-center gap-1.5 text-xs font-semibold text-muted-foreground bg-muted px-3 py-1 rounded-full">
                        <MapPin className="w-3 h-3" />
                        {r.location}
                      </span>
                      <span className="inline-flex items-center gap-1.5 text-xs font-semibold text-muted-foreground bg-muted px-3 py-1 rounded-full">
                        <Clock className="w-3 h-3" />
                        {r.employment_type}
                      </span>
                      {r.salary_range && (
                        <span className="inline-flex items-center gap-1.5 text-xs font-semibold text-muted-foreground bg-muted px-3 py-1 rounded-full">
                          <IndianRupee className="w-3 h-3" />
                          {r.salary_range}
                        </span>
                      )}
                    </div>
                  </div>
                  <span className="flex-none w-10 h-10 rounded-full grid place-items-center bg-amber-50 text-[#1a365d] group-hover:bg-amber-400 group-hover:text-[#5a3d00] group-hover:translate-x-1 transition-all">
                    <ArrowRight className="w-4 h-4" />
                  </span>
                </Link>
              ))}
            </div>
          )}
        </section>

        {/* CTA */}
        <section className="mt-16 bg-amber-50 border border-amber-200/70 rounded-3xl px-8 py-10 sm:px-12 flex flex-wrap items-center gap-8">
          <div className="flex-1 min-w-[260px]">
            <h2 className="text-2xl font-extrabold tracking-tight text-[#5a3d00]">
              Don&apos;t see the right role?
            </h2>
            <p className="text-[#7a5b1f] leading-relaxed mt-2 max-w-lg">
              We&apos;re growing and always looking for talented people who
              care about education. Send us your story.
            </p>
          </div>
          <Link
            href="/contact?subject=Careers%20—%20General%20Interest"
            className="inline-flex items-center gap-2 bg-[#1a365d] hover:bg-[#0f2e4a] text-white font-semibold px-6 py-3 rounded-xl transition-colors"
          >
            Introduce yourself
            <ArrowRight className="w-4 h-4" />
          </Link>
        </section>
      </div>
    </div>
  );
}

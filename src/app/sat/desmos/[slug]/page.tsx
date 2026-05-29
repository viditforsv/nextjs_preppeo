import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { Calculator, ChevronRight } from "lucide-react";
import {
  getDesmosGuide,
  getPublishedDesmosGuides,
} from "@/lib/seo/desmos-guides";
import DesmosVideo from "./DesmosVideo";

const NAVY = "#1a365d";
const AMBER = "#f4b400";
const TEAL = "#0891b2";

const baseUrl = process.env.NEXT_PUBLIC_APP_URL || "https://preppeo.com";

// Pre-render every published guide at build time.
export function generateStaticParams() {
  return getPublishedDesmosGuides().map((g) => ({ slug: g.slug }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const guide = getDesmosGuide(slug);
  if (!guide) return { title: "Not found | Preppeo" };

  const url = `${baseUrl}/sat/desmos/${guide.slug}`;
  const title = `${guide.title} | Preppeo`;
  return {
    title,
    description: guide.metaDescription,
    alternates: { canonical: url },
    openGraph: {
      title,
      description: guide.metaDescription,
      url,
      type: "article",
    },
  };
}

export default async function DesmosGuidePage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const guide = getDesmosGuide(slug);
  if (!guide) notFound();

  // HowTo structured data — helps this rank as a step-by-step result.
  const howToJsonLd = {
    "@context": "https://schema.org",
    "@type": "HowTo",
    name: guide.title,
    description: guide.metaDescription,
    step: guide.steps.map((s, i) => ({
      "@type": "HowToStep",
      position: i + 1,
      name: s.title,
      text: s.body,
    })),
  };

  return (
    <div className="bg-gray-50 min-h-screen">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(howToJsonLd) }}
      />

      <article className="max-w-2xl mx-auto px-4 py-12 sm:py-16">
        {/* ── Header ─────────────────────────────────────────────── */}
        <div className="flex items-center gap-2 text-xs font-semibold uppercase tracking-wide mb-4" style={{ color: TEAL }}>
          <Calculator className="w-4 h-4" />
          Digital SAT · Desmos Hack
        </div>
        <h1 className="text-3xl sm:text-4xl font-bold leading-tight" style={{ color: NAVY }}>
          {guide.title}
        </h1>
        <p className="text-gray-600 mt-4 text-lg leading-relaxed">{guide.intro}</p>

        {/* ── Demo clip (the hack in action) ─────────────────────── */}
        <div className="mt-8">
          {guide.videoReady ? (
            <DesmosVideo slug={guide.slug} mediaAlt={guide.mediaAlt} />
          ) : (
            <div className="w-full rounded-xl border-2 border-dashed border-gray-300 bg-white px-6 py-12 text-center">
              <Calculator className="w-8 h-8 mx-auto mb-3 text-gray-400" />
              <p className="text-sm font-medium text-gray-500">
                Demo clip coming soon
              </p>
              <p className="text-xs text-gray-400 mt-1">
                A 20-second screen recording of the hack will appear here.
              </p>
            </div>
          )}
        </div>

        {/* ── Steps ──────────────────────────────────────────────── */}
        <h2 className="text-xl font-bold mt-12 mb-6" style={{ color: NAVY }}>
          Step by step
        </h2>
        <ol className="space-y-5">
          {guide.steps.map((step, i) => (
            <li key={i} className="flex gap-4">
              <div
                className="w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-white text-sm font-bold"
                style={{ background: NAVY }}
              >
                {i + 1}
              </div>
              <div>
                <p className="font-semibold" style={{ color: NAVY }}>{step.title}</p>
                <p className="text-sm text-gray-600 mt-1 leading-relaxed">{step.body}</p>
              </div>
            </li>
          ))}
        </ol>

        {/* ── Pro tip ────────────────────────────────────────────── */}
        {guide.proTip && (
          <div
            className="mt-10 rounded-xl p-5 border-l-4"
            style={{ background: "#fffbeb", borderColor: AMBER }}
          >
            <p className="text-sm font-semibold mb-1" style={{ color: NAVY }}>Pro tip</p>
            <p className="text-sm text-gray-700 leading-relaxed">{guide.proTip}</p>
          </div>
        )}

        {/* ── Practice question ──────────────────────────────────── */}
        {guide.practice && (
          <div className="mt-12">
            <h2 className="text-xl font-bold mb-4" style={{ color: NAVY }}>
              Try it yourself
            </h2>
            <div className="rounded-xl border border-gray-200 bg-white p-6">
              <p className="font-medium" style={{ color: NAVY }}>{guide.practice.question}</p>
              <details className="mt-4 group">
                <summary
                  className="cursor-pointer text-sm font-semibold inline-flex items-center gap-1 select-none"
                  style={{ color: TEAL }}
                >
                  Show the answer
                  <ChevronRight className="w-4 h-4 group-open:rotate-90 transition-transform" />
                </summary>
                <div className="mt-3 text-sm text-gray-700 leading-relaxed">
                  <p className="font-bold" style={{ color: NAVY }}>Answer: {guide.practice.answer}</p>
                  <p className="mt-2">{guide.practice.desmosWay}</p>
                </div>
              </details>
            </div>
          </div>
        )}

        {/* ── Bottom CTA ─────────────────────────────────────────── */}
        <section className="mt-14">
          <div
            className="rounded-2xl px-8 py-10 flex flex-col sm:flex-row items-center justify-between gap-6"
            style={{ background: NAVY }}
          >
            <div>
              <p className="text-white font-bold text-xl mb-1">
                Put the trick to work on a real test
              </p>
              <p className="text-white/60 text-sm">
                Full-length adaptive SAT mocks · real Bluebook-style timing · detailed score reports
              </p>
            </div>
            <Link
              href="/sat-test"
              className="inline-flex items-center gap-2 px-6 py-3 rounded-xl text-sm font-bold flex-shrink-0"
              style={{ background: AMBER, color: NAVY }}
            >
              Start Free Mock <ChevronRight className="w-4 h-4" />
            </Link>
          </div>
        </section>
      </article>
    </div>
  );
}

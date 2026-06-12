import type { Metadata } from "next";
import Link from "next/link";
import { Calculator, ChevronRight, ArrowRight, Home } from "lucide-react";
import {
  DESMOS_GUIDES,
  getPublishedDesmosGuides,
} from "@/lib/seo/desmos-guides";

const NAVY = "#1a365d";
const AMBER = "#f4b400";
const TEAL = "#0891b2";

const baseUrl = process.env.NEXT_PUBLIC_APP_URL || "https://preppeo.com";
const url = `${baseUrl}/sat/desmos`;

const title = "SAT Desmos Shortcuts — Calculator Hacks for the Digital SAT";
const description =
  "A growing library of Bluebook Desmos calculator shortcuts for the Digital SAT — solve systems, graph quadratics, find roots, run regressions, and more in seconds. Step-by-step guides with practice questions.";

export const metadata: Metadata = {
  title: `${title} | Preppeo`,
  description,
  alternates: { canonical: url },
  openGraph: {
    title: `${title} | Preppeo`,
    description,
    url,
    type: "website",
  },
};

export default function DesmosHubPage() {
  const published = getPublishedDesmosGuides();
  const publishedSlugs = new Set(published.map((g) => g.slug));
  const comingSoon = DESMOS_GUIDES.filter((g) => !publishedSlugs.has(g.slug));

  // BreadcrumbList structured data — shows the trail in search results.
  const breadcrumbJsonLd = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      { "@type": "ListItem", position: 1, name: "Home", item: baseUrl },
      {
        "@type": "ListItem",
        position: 2,
        name: "SAT Desmos Shortcuts",
        item: url,
      },
    ],
  };

  // ItemList structured data — helps the hub surface its child guides in search.
  const itemListJsonLd = {
    "@context": "https://schema.org",
    "@type": "ItemList",
    name: title,
    description,
    itemListElement: published.map((g, i) => ({
      "@type": "ListItem",
      position: i + 1,
      url: `${baseUrl}/sat/desmos/${g.slug}`,
      name: g.title,
    })),
  };

  return (
    <div className="bg-gray-50 min-h-screen">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }}
      />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(itemListJsonLd) }}
      />

      <div className="max-w-6xl mx-auto px-6 py-10 flex gap-10">
        {/* ── Left nav ───────────────────────────────────────────── */}
        <aside className="hidden lg:block w-48 flex-shrink-0">
          <div className="sticky top-20">
            <nav aria-label="Breadcrumb" className="mb-5">
              <ol className="flex flex-wrap items-center gap-1.5 text-xs text-gray-500">
                <li>
                  <Link
                    href="/"
                    className="inline-flex items-center hover:text-gray-700 transition-colors"
                  >
                    <Home className="w-3.5 h-3.5" />
                    <span className="sr-only">Home</span>
                  </Link>
                </li>
                <ChevronRight className="w-3.5 h-3.5 text-gray-300" />
                <li aria-current="page" className="font-medium text-gray-700">
                  Desmos Shortcuts
                </li>
              </ol>
            </nav>

            <p className="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-3">
              On this page
            </p>
            <nav className="space-y-1">
              <a
                href="#guides"
                className="block px-3 py-2 text-sm text-gray-600 hover:text-gray-900 rounded-lg hover:bg-white transition-colors"
              >
                Guides
              </a>
              {comingSoon.length > 0 && (
                <a
                  href="#coming-soon"
                  className="block px-3 py-2 text-sm text-gray-600 hover:text-gray-900 rounded-lg hover:bg-white transition-colors"
                >
                  Coming soon
                </a>
              )}
            </nav>

            {/* CTA */}
            <div
              className="mt-8 rounded-xl p-4 text-center"
              style={{ background: NAVY }}
            >
              <p className="text-white text-xs font-semibold mb-2">
                Ready to practice?
              </p>
              <Link
                href="/sat-test"
                className="block text-xs font-bold py-2 px-3 rounded-lg"
                style={{ background: AMBER, color: NAVY }}
              >
                Take a Mock SAT
              </Link>
            </div>
          </div>
        </aside>

        {/* ── Main content ───────────────────────────────────────── */}
        <main className="flex-1 min-w-0">
          {/* Header */}
          <div
            className="flex items-center gap-2 text-xs font-semibold uppercase tracking-wide mb-4"
            style={{ color: TEAL }}
          >
            <Calculator className="w-4 h-4" />
            Digital SAT · Desmos Hacks
          </div>
          <h1
            className="text-3xl sm:text-4xl font-bold leading-tight"
            style={{ color: NAVY }}
          >
            SAT Desmos Shortcuts
          </h1>
          <p className="text-gray-600 mt-4 text-lg leading-relaxed">
            The Digital SAT ships with the full Desmos graphing calculator built
            into Bluebook. Used well, it turns whole question types into a
            5-second read. These guides show the exact taps for each one — with a
            short clip and a practice question.
          </p>

          {/* Published guides */}
          <h2
            id="guides"
            className="text-xl font-bold mt-12 mb-5 scroll-mt-24"
            style={{ color: NAVY }}
          >
            Guides
          </h2>
          <ul className="space-y-3">
            {published.map((g) => (
              <li key={g.slug}>
                <Link
                  href={`/sat/desmos/${g.slug}`}
                  className="group flex items-start gap-4 rounded-xl border border-gray-200 bg-white p-5 hover:border-gray-300 hover:shadow-sm transition-all"
                >
                  <div
                    className="w-9 h-9 rounded-lg flex items-center justify-center flex-shrink-0"
                    style={{ background: "#ecfeff", color: TEAL }}
                  >
                    <Calculator className="w-5 h-5" />
                  </div>
                  <div className="min-w-0">
                    <p className="font-semibold" style={{ color: NAVY }}>
                      {g.title}
                    </p>
                    <p className="text-sm text-gray-600 mt-1 leading-relaxed">
                      {g.metaDescription}
                    </p>
                  </div>
                  <ChevronRight className="w-5 h-5 text-gray-300 flex-shrink-0 mt-1 group-hover:translate-x-0.5 transition-transform" />
                </Link>
              </li>
            ))}
          </ul>

          {/* Coming soon */}
          {comingSoon.length > 0 && (
            <>
              <h2
                id="coming-soon"
                className="text-xl font-bold mt-12 mb-2 scroll-mt-24"
                style={{ color: NAVY }}
              >
                More shortcuts coming soon
              </h2>
              <p className="text-sm text-gray-500 mb-5">
                We&apos;re adding these next. Each will get the same step-by-step
                treatment.
              </p>
              <ul className="grid sm:grid-cols-2 gap-3">
                {comingSoon.map((g) => (
                  <li
                    key={g.slug}
                    className="flex items-center gap-2 rounded-lg border border-dashed border-gray-200 bg-white/60 px-4 py-3"
                  >
                    <span className="text-sm text-gray-500">{g.title}</span>
                    <span className="ml-auto flex-shrink-0 rounded bg-gray-100 px-1.5 py-0.5 text-[10px] font-medium uppercase tracking-wide text-gray-400">
                      Soon
                    </span>
                  </li>
                ))}
              </ul>
            </>
          )}

          {/* Bottom CTA */}
          <section className="mt-14">
            <div
              className="rounded-2xl px-8 py-10 flex flex-col sm:flex-row items-center justify-between gap-6"
              style={{ background: NAVY }}
            >
              <div>
                <p className="text-white font-bold text-xl mb-1">
                  Put these tricks to work on a real test
                </p>
                <p className="text-white/60 text-sm">
                  Full-length adaptive SAT mocks · real Bluebook-style timing ·
                  detailed score reports
                </p>
              </div>
              <Link
                href="/sat-test"
                className="inline-flex items-center gap-2 px-6 py-3 rounded-xl text-sm font-bold flex-shrink-0"
                style={{ background: AMBER, color: NAVY }}
              >
                Start Free Mock <ArrowRight className="w-4 h-4" />
              </Link>
            </div>
          </section>
        </main>
      </div>
    </div>
  );
}

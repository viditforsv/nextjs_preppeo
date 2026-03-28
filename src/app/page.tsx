"use client";

import Image from "next/image";
import { useRouter } from "next/navigation";
import Link from "next/link";
import {
  ArrowRight,
  CheckCircle,
  TrendingUp,
  ClipboardCheck,
  GraduationCap,
  Gift,
  Zap,
  X,
} from "lucide-react";
import { Button } from "@/design-system/components/ui/button";

/* ── Palette ──────────────────────────────────────────────────── */
const NAVY  = "#1a365d";
const AMBER = "#f4b400";
const TEAL  = "#0891b2";

/* ── Helpers ──────────────────────────────────────────────────── */
function SectionLabel({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex items-center gap-3 mb-3">
      <div className="h-0.5 w-8" style={{ background: AMBER }} />
      <span className="text-xs font-semibold uppercase tracking-widest" style={{ color: AMBER }}>
        {children}
      </span>
    </div>
  );
}

function TH({ children, center }: { children: React.ReactNode; center?: boolean }) {
  return (
    <th
      className={`px-5 py-3.5 text-sm font-semibold text-white ${center ? "text-center" : "text-left"}`}
      style={{ background: NAVY }}
    >
      {children}
    </th>
  );
}

function Check() {
  return <CheckCircle className="w-5 h-5 text-emerald-500 mx-auto" />;
}
function Cross() {
  return <X className="w-5 h-5 text-gray-300 mx-auto" />;
}


/* ── Adaptive Routing Visual ──────────────────────────────────── */
function AdaptiveRoutingVisual() {
  return (
    <div className="max-w-3xl mx-auto">
      <div className="flex justify-center mb-6">
        <div className="border-2 rounded-xl px-8 py-5 text-center" style={{ borderColor: NAVY }}>
          <p className="text-xs font-semibold uppercase tracking-wider mb-1" style={{ color: AMBER }}>Module 1</p>
          <p className="font-bold text-lg" style={{ color: NAVY }}>Same for Everyone</p>
          <p className="text-sm text-gray-500 mt-1">27 R&amp;W · 22 Math · Balanced difficulty</p>
        </div>
      </div>

      <div className="flex flex-col items-center mb-6">
        <div className="w-px h-6 bg-gray-300" />
        <div className="border border-gray-200 rounded-lg px-6 py-2.5 bg-white shadow-sm text-center">
          <p className="text-xs text-gray-500">Score threshold</p>
          <p className="font-semibold text-sm" style={{ color: NAVY }}>
            R&amp;W ≥ 14/27 &nbsp;·&nbsp; Math ≥ 15/22
          </p>
        </div>
        <div className="w-px h-6 bg-gray-300" />
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div className="border-2 rounded-xl p-5" style={{ borderColor: TEAL }}>
          <p className="text-xs font-semibold uppercase tracking-wider mb-2" style={{ color: TEAL }}>Above threshold</p>
          <p className="font-bold text-lg mb-1" style={{ color: NAVY }}>Hard Module 2</p>
          <p className="text-sm text-gray-600 leading-relaxed">
            Harder questions. Higher ceiling. Full path to 800 per section.
          </p>
          <div className="mt-3 pt-3 border-t border-gray-100">
            <div className="flex items-center justify-between text-xs text-gray-500">
              <span>Difficulty mix</span>
              <span className="font-semibold">4E · 8M · 15H</span>
            </div>
          </div>
        </div>

        <div className="border-2 rounded-xl p-5 border-gray-200">
          <p className="text-xs font-semibold uppercase tracking-wider mb-2 text-gray-400">Below threshold</p>
          <p className="font-bold text-lg mb-1" style={{ color: NAVY }}>Easy Module 2</p>
          <p className="text-sm text-gray-600 leading-relaxed">
            Easier questions. Lower difficulty ceiling. Score cap around 570 per section.
          </p>
          <div className="mt-3 pt-3 border-t border-gray-100">
            <div className="flex items-center justify-between text-xs text-gray-500">
              <span>Difficulty mix</span>
              <span className="font-semibold">12E · 11M · 4H</span>
            </div>
          </div>
        </div>
      </div>

      <p className="text-center text-xs text-gray-400 mt-5">
        Preppeo&apos;s 5 mock sets implement this routing exactly — identical to the real Bluebook.
      </p>
    </div>
  );
}

/* ── Comparison Table ─────────────────────────────────────────── */
function ComparisonTable() {
  const rows: {
    feature: string;
    preppeo: React.ReactNode;
    khan: React.ReactNode;
    bluebook: React.ReactNode;
  }[] = [
    {
      feature: "Full-length adaptive mocks",
      preppeo:  <><Check /><p className="text-xs text-emerald-600 mt-0.5 text-center">5 sets</p></>,
      khan:     <Cross />,
      bluebook: <><Check /><p className="text-xs text-gray-400 mt-0.5 text-center">4 official</p></>,
    },
    {
      feature: "M1 → M2 adaptive routing",
      preppeo:  <Check />,
      khan:     <Cross />,
      bluebook: <Check />,
    },
    {
      feature: "Domain-level score breakdown",
      preppeo:  <Check />,
      khan:     <Cross />,
      bluebook: <Cross />,
    },
    {
      feature: "Difficulty-tier analysis",
      preppeo:  <Check />,
      khan:     <Cross />,
      bluebook: <Cross />,
    },
    {
      feature: "Time per question analysis",
      preppeo:  <Check />,
      khan:     <Cross />,
      bluebook: <Cross />,
    },
    {
      feature: "Practice by topic & difficulty",
      preppeo:  <><Check /><p className="text-xs text-emerald-600 mt-0.5 text-center">2,500+ q</p></>,
      khan:     <><Check /><p className="text-xs text-gray-400 mt-0.5 text-center">limited</p></>,
      bluebook: <Cross />,
    },
    {
      feature: "Question-level review",
      preppeo:  <Check />,
      khan:     <Check />,
      bluebook: <Cross />,
    },
    {
      feature: "400–1600 scaled scoring",
      preppeo:  <Check />,
      khan:     <Cross />,
      bluebook: <Check />,
    },
    {
      feature: "First mock free",
      preppeo:  <Check />,
      khan:     <><Check /><p className="text-xs text-gray-400 mt-0.5 text-center">always free</p></>,
      bluebook: <><Check /><p className="text-xs text-gray-400 mt-0.5 text-center">always free</p></>,
    },
  ];

  return (
    <div className="overflow-x-auto">
      <table className="w-full border-collapse text-sm">
        <thead>
          <tr>
            <TH>Feature</TH>
            <TH center>
              <span className="flex flex-col items-center gap-0.5">
                <span>Preppeo</span>
                <span className="text-[10px] font-normal opacity-70">You&apos;re here</span>
              </span>
            </TH>
            <TH center>Khan Academy</TH>
            <TH center>CB Bluebook</TH>
          </tr>
        </thead>
        <tbody>
          {rows.map((row, i) => (
            <tr key={row.feature} className={i % 2 === 0 ? "bg-white" : "bg-[#f8fafc]"}>
              <td className="px-5 py-3 font-medium text-gray-700 border border-gray-100">{row.feature}</td>
              <td className="px-5 py-3 border border-gray-100 bg-[#fffbeb]">
                <div className="flex flex-col items-center">{row.preppeo}</div>
              </td>
              <td className="px-5 py-3 border border-gray-100 text-center">{row.khan}</td>
              <td className="px-5 py-3 border border-gray-100 text-center">{row.bluebook}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

/* ── Page ─────────────────────────────────────────────────────── */
export default function HomePage() {
  const router = useRouter();

  return (
    <div className="min-h-screen bg-white">

      {/* ══ HERO ══════════════════════════════════════════════ */}
      <section className="bg-white border-b border-gray-100 py-20">
        <div className="max-w-6xl mx-auto px-6 grid lg:grid-cols-2 gap-14 items-center">

          {/* Left */}
          <div>
            <SectionLabel>Digital SAT Mock Platform</SectionLabel>
            <h1 className="text-4xl md:text-5xl font-bold mb-5 leading-tight" style={{ color: NAVY }}>
              Score Higher on<br />the Digital SAT
            </h1>
            <p className="text-lg text-gray-600 mb-8 leading-relaxed max-w-lg">
              Full-length adaptive mocks that mirror real Bluebook routing. After every test,
              get a score report with domain breakdown, difficulty analysis, and question-level
              review — the depth that free alternatives don&apos;t offer.
            </p>
            <div className="flex gap-3 flex-wrap mb-10">
              <Button
                size="lg"
                className="text-white"
                style={{ background: NAVY }}
                onClick={() => router.push("/sat-free")}
              >
                Start with a Free Mock
                <ArrowRight className="ml-2 h-4 w-4" />
              </Button>
              <Button
                size="lg"
                variant="outline"
                style={{ borderColor: NAVY, color: NAVY }}
                onClick={() => router.push("/mocks")}
              >
                Explore All Mocks
              </Button>
            </div>
            <div className="flex flex-wrap gap-x-6 gap-y-2 text-sm text-gray-500">
              {[
                "Adaptive — mirrors real exam",
                "Timed — full-length",
                "400–1600 scale",
                "Domain analytics",
              ].map((t) => (
                <span key={t} className="flex items-center gap-1.5">
                  <CheckCircle className="w-4 h-4 text-emerald-500 shrink-0" /> {t}
                </span>
              ))}
            </div>
          </div>

          {/* Right — score report screenshot */}
          <div className="rounded-2xl overflow-hidden shadow-2xl border border-gray-100">
            <Image
              src="/images/sat_report_1.png"
              alt="SAT Score Report — 1570/1600 with R&W 790 and Math 780"
              width={960}
              height={900}
              className="w-full h-auto"
              priority
            />
          </div>

        </div>
      </section>

      {/* ══ STATS BAR ═════════════════════════════════════════ */}
      <section className="py-10" style={{ background: NAVY }}>
        <div className="max-w-5xl mx-auto px-6">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
            {[
              { num: "2,500+",   label: "Practice Questions" },
              { num: "5",        label: "Full-Length Mock Sets" },
              { num: "400–1600", label: "Score Scale" },
              { num: "100%",     label: "Adaptive Routing" },
            ].map(({ num, label }) => (
              <div key={label}>
                <p className="text-3xl font-bold mb-1" style={{ color: AMBER }}>{num}</p>
                <p className="text-sm text-white/70">{label}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ══ SCORE REPORT ══════════════════════════════════════ */}
      <section className="py-16 bg-white">
        <div className="max-w-5xl mx-auto px-6">
          <SectionLabel>After Every Mock</SectionLabel>
          <h2 className="text-3xl font-bold mb-4" style={{ color: NAVY }}>
            Your Score Report
          </h2>
          <p className="text-gray-600 mb-10 max-w-2xl leading-relaxed">
            Every mock generates a full score report — 400–1600 scaled score, domain-level accuracy,
            difficulty-tier breakdown, and time-per-question analysis. Review every question
            with explanations. No other free platform gives you this depth.
          </p>

          <div className="grid lg:grid-cols-2 gap-10 items-start">
            <div className="rounded-xl overflow-hidden shadow-lg border border-gray-100">
              <Image
                src="/images/sat_report_4.png"
                alt="SAT Score Report — Performance by Domain breakdown"
                width={800}
                height={700}
                className="w-full h-auto"
              />
            </div>

            <div className="space-y-6">
              {[
                {
                  icon: <TrendingUp className="w-5 h-5" style={{ color: NAVY }} />,
                  title: "Domain-level accuracy",
                  body: "See exactly which content domains cost you points — Craft & Structure, Algebra, Advanced Math — not just a single overall score.",
                },
                {
                  icon: <ClipboardCheck className="w-5 h-5" style={{ color: NAVY }} />,
                  title: "Difficulty-tier breakdown",
                  body: "Know whether you're missing Easy, Medium, or Hard questions. Tells you where to focus — cramming Hard questions when Easy ones are slipping is a common mistake.",
                },
                {
                  icon: <Zap className="w-5 h-5" style={{ color: NAVY }} />,
                  title: "Time per question",
                  body: "See which questions you spent too long on. Identify your time traps before test day, not during it.",
                },
                {
                  icon: <GraduationCap className="w-5 h-5" style={{ color: NAVY }} />,
                  title: "Question-level review",
                  body: "Every question, your answer, the correct answer, and the explanation — all in one place after every mock.",
                },
              ].map((f) => (
                <div key={f.title} className="flex gap-4">
                  <div
                    className="w-10 h-10 rounded-lg flex items-center justify-center shrink-0 mt-0.5"
                    style={{ background: `${NAVY}0d` }}
                  >
                    {f.icon}
                  </div>
                  <div>
                    <p className="font-semibold mb-1" style={{ color: NAVY }}>{f.title}</p>
                    <p className="text-sm text-gray-600 leading-relaxed">{f.body}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* ══ ADAPTIVE ROUTING ══════════════════════════════════ */}
      <section className="py-16 bg-[#f8fafc] border-t border-gray-100">
        <div className="max-w-5xl mx-auto px-6">
          <SectionLabel>How It Works</SectionLabel>
          <h2 className="text-3xl font-bold mb-4 text-center" style={{ color: NAVY }}>
            Adaptive Testing — Exactly Like the Real SAT
          </h2>
          <p className="text-gray-600 mb-10 max-w-2xl mx-auto text-center leading-relaxed">
            The Digital SAT uses adaptive routing between modules. Preppeo replicates this
            exactly across 5 full-length mock sets — not a simplified approximation.
          </p>
          <AdaptiveRoutingVisual />
        </div>
      </section>

      {/* ══ COMPARISON TABLE ══════════════════════════════════ */}
      <section className="py-16 bg-white border-t border-gray-100">
        <div className="max-w-5xl mx-auto px-6">
          <SectionLabel>Why Preppeo</SectionLabel>
          <h2 className="text-3xl font-bold mb-4" style={{ color: NAVY }}>
            How We Compare
          </h2>
          <p className="text-gray-600 mb-8 max-w-2xl leading-relaxed">
            Free tools exist — but none combine full adaptive mocks with the analytics depth
            you need to actually improve.
          </p>
          <ComparisonTable />
        </div>
      </section>

      {/* ══ PRICING ═══════════════════════════════════════════ */}
      <section className="py-16 bg-[#f8fafc] border-t border-gray-100">
        <div className="max-w-5xl mx-auto px-6">
          <SectionLabel>Pricing</SectionLabel>
          <h2 className="text-3xl font-bold mb-3" style={{ color: NAVY }}>Simple, Transparent Pricing</h2>
          <p className="text-gray-600 mb-10">Start free. Pay only when you need more mocks or unlimited practice.</p>

          <div className="grid md:grid-cols-2 gap-10">
            {/* Tokens */}
            <div>
              <h3 className="font-bold text-base mb-4 pb-3 border-b border-gray-200 flex items-center gap-2" style={{ color: NAVY }}>
                <ClipboardCheck className="w-4 h-4" /> Mock Tokens
              </h3>
              <div className="space-y-2">
                {[
                  { name: "1 Mock",  price: "₹499",   per: "₹499 / mock", pop: false },
                  { name: "3 Mocks", price: "₹999",   per: "₹333 / mock", pop: true  },
                  { name: "5 Mocks", price: "₹1,499", per: "₹300 / mock", pop: false },
                ].map((p) => (
                  <div
                    key={p.name}
                    className={`flex items-center justify-between px-4 py-3 rounded-lg border ${
                      p.pop ? "bg-[#fffbeb]" : "bg-white border-gray-200"
                    }`}
                    style={p.pop ? { borderColor: AMBER } : {}}
                  >
                    <div>
                      <p className="font-semibold text-gray-800 text-sm">{p.name}</p>
                      <p className="text-xs text-gray-400">{p.per}</p>
                    </div>
                    <div className="flex items-center gap-2">
                      <span className="font-bold" style={{ color: NAVY }}>{p.price}</span>
                      {p.pop && (
                        <span className="text-[10px] font-semibold text-white px-2 py-0.5 rounded-full" style={{ background: AMBER, color: NAVY }}>
                          Popular
                        </span>
                      )}
                    </div>
                  </div>
                ))}
                <Link href="/mocks/tokens" className="text-sm font-semibold hover:underline inline-flex items-center gap-1 mt-2" style={{ color: NAVY }}>
                  Buy tokens <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </div>
            </div>

            {/* Subscriptions */}
            <div>
              <h3 className="font-bold text-base mb-4 pb-3 border-b border-gray-200 flex items-center gap-2" style={{ color: NAVY }}>
                <Zap className="w-4 h-4" /> Practice Subscriptions
              </h3>
              <div className="space-y-2">
                {[
                  { name: "Practice — 1 Month",       price: "₹9,999",  detail: "Unlimited questions",          pop: false },
                  { name: "Practice — 3 Months",      price: "₹14,999", detail: "Unlimited questions",          pop: false },
                  { name: "Complete Prep — 3 Months", price: "₹19,999", detail: "Unlimited practice + 3 mocks", pop: true  },
                ].map((p) => (
                  <div
                    key={p.name}
                    className={`flex items-center justify-between px-4 py-3 rounded-lg border ${
                      p.pop ? "bg-[#fffbeb]" : "bg-white border-gray-200"
                    }`}
                    style={p.pop ? { borderColor: AMBER } : {}}
                  >
                    <div>
                      <p className="font-semibold text-gray-800 text-sm">{p.name}</p>
                      <p className="text-xs text-gray-400">{p.detail}</p>
                    </div>
                    <div className="flex items-center gap-2">
                      <span className="font-bold" style={{ color: NAVY }}>{p.price}</span>
                      {p.pop && (
                        <span className="text-[10px] font-semibold px-2 py-0.5 rounded-full" style={{ background: AMBER, color: NAVY }}>
                          Best Value
                        </span>
                      )}
                    </div>
                  </div>
                ))}
                <Link href="/sat-test" className="text-sm font-semibold hover:underline inline-flex items-center gap-1 mt-2" style={{ color: NAVY }}>
                  Try free practice first <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </div>
            </div>
          </div>
          <p className="text-center text-xs text-gray-400 mt-8">Your first mock is always free. No credit card required.</p>
        </div>
      </section>

      {/* ══ CALLOUTS ══════════════════════════════════════════ */}
      <section className="py-12 bg-white border-t border-gray-100">
        <div className="max-w-5xl mx-auto px-6 grid md:grid-cols-2 gap-6">
          <div className="bg-white border border-emerald-200 rounded-xl p-6 flex items-start gap-5">
            <div className="w-12 h-12 rounded-xl bg-emerald-50 flex items-center justify-center shrink-0">
              <Gift className="w-6 h-6 text-emerald-600" />
            </div>
            <div>
              <h3 className="font-bold text-gray-900 mb-1">Invite Friends, Both Get a Free Mock</h3>
              <p className="text-sm text-gray-600 mb-3 leading-relaxed">
                When a friend signs up with your referral link, you both receive a bonus mock token.
              </p>
              <Link href="/referral" className="text-sm font-semibold text-emerald-700 hover:underline inline-flex items-center gap-1">
                Get your referral link <ArrowRight className="w-3.5 h-3.5" />
              </Link>
            </div>
          </div>
          <div className="bg-white rounded-xl p-6 flex items-start gap-5" style={{ border: `1px solid ${NAVY}33` }}>
            <div className="w-12 h-12 rounded-xl flex items-center justify-center shrink-0" style={{ background: `${NAVY}0d` }}>
              <GraduationCap className="w-6 h-6" style={{ color: NAVY }} />
            </div>
            <div>
              <h3 className="font-bold text-gray-900 mb-1">Are You a Teacher or Institute?</h3>
              <p className="text-sm text-gray-600 mb-3 leading-relaxed">
                Offer Preppeo mocks to your students. Earn commission on every purchase with zero upfront cost.
              </p>
              <Link href="/for-institutes" className="text-sm font-semibold hover:underline inline-flex items-center gap-1" style={{ color: NAVY }}>
                Learn more <ArrowRight className="w-3.5 h-3.5" />
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* ══ FINAL CTA ═════════════════════════════════════════ */}
      <section className="py-16" style={{ background: NAVY }}>
        <div className="max-w-2xl mx-auto px-6 text-center">
          <h2 className="text-3xl font-bold text-white mb-4">Ready to find out your score?</h2>
          <p className="text-white/70 mb-8 leading-relaxed">
            Your first full-length adaptive SAT mock is complimentary — worth ₹499. No credit card needed.
          </p>
          <div className="flex gap-3 justify-center flex-wrap">
            <Button
              size="lg"
              className="font-bold"
              style={{ background: AMBER, color: NAVY }}
              onClick={() => router.push("/sat-free")}
            >
              Start with a Free Mock
              <ArrowRight className="ml-2 h-4 w-4" />
            </Button>
            <Button
              size="lg"
              variant="outline"
              className="border-2 border-white bg-transparent text-white hover:bg-white/10"
              onClick={() => router.push("/mocks")}
            >
              Explore All Mocks
            </Button>
          </div>
        </div>
      </section>

    </div>
  );
}

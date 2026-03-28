"use client";

import Link from "next/link";
import { BookOpen, Calculator, Clock, HelpCircle, TrendingUp, ChevronRight } from "lucide-react";

/* ── Palette ──────────────────────────────────────────────────── */
const NAVY  = "#1a365d";
const AMBER = "#f4b400";
const TEAL  = "#0891b2";

/* ── SVG Donut Chart ──────────────────────────────────────────── */
const R    = 60;
const CIRC = 2 * Math.PI * R;

interface Segment { label: string; value: number; color: string }

function DonutChart({ segments, total, centerLabel }: { segments: Segment[]; total: number; centerLabel: string }) {
  let cumulative = 0;
  const slices = segments.map((s) => {
    const pct = s.value / total;
    const dash = pct * CIRC;
    const offset = -(cumulative / total) * CIRC;
    cumulative += s.value;
    return { ...s, dash, offset };
  });

  return (
    <svg width={160} height={160} viewBox="0 0 160 160" style={{ transform: "rotate(-90deg)" }}>
      {slices.map((s, i) => (
        <circle
          key={i}
          cx={80} cy={80} r={R}
          fill="none"
          stroke={s.color}
          strokeWidth={24}
          strokeDasharray={`${s.dash} ${CIRC - s.dash}`}
          strokeDashoffset={s.offset}
        />
      ))}
      <text
        x={80} y={80}
        textAnchor="middle"
        dominantBaseline="central"
        style={{ transform: "rotate(90deg) translate(0, -160px)", fontSize: 13, fontWeight: 700, fill: NAVY }}
      >
        {centerLabel}
      </text>
    </svg>
  );
}

function ChartLegend({ segments }: { segments: Segment[] }) {
  return (
    <div className="space-y-2 text-sm">
      {segments.map((s) => (
        <div key={s.label} className="flex items-center gap-2">
          <div className="w-3 h-3 rounded-sm flex-shrink-0" style={{ background: s.color }} />
          <span className="text-gray-700">{s.label}</span>
          <span className="ml-auto font-semibold" style={{ color: NAVY }}>{s.value}q</span>
        </div>
      ))}
    </div>
  );
}

/* ── Section header ───────────────────────────────────────────── */
function SectionHeader({ id, icon, title, subtitle }: {
  id: string;
  icon: React.ReactNode;
  title: string;
  subtitle: string;
}) {
  return (
    <div id={id} className="flex items-start gap-4 mb-8 pt-2">
      <div className="w-11 h-11 rounded-xl flex items-center justify-center flex-shrink-0" style={{ background: NAVY }}>
        {icon}
      </div>
      <div>
        <h2 className="text-xl font-bold" style={{ color: NAVY }}>{title}</h2>
        <p className="text-sm text-gray-500 mt-0.5">{subtitle}</p>
      </div>
    </div>
  );
}

/* ── Data ─────────────────────────────────────────────────────── */
const rwSegments: Segment[] = [
  { label: "Craft & Structure",            value: 8,  color: NAVY  },
  { label: "Information & Ideas",          value: 7,  color: TEAL  },
  { label: "Expression of Ideas",          value: 5,  color: AMBER },
  { label: "Standard English Conventions", value: 7,  color: "#6366f1" },
];

const mathSegments: Segment[] = [
  { label: "Algebra",                       value: 8,  color: NAVY  },
  { label: "Advanced Math",                 value: 7,  color: TEAL  },
  { label: "Geometry & Trigonometry",       value: 4,  color: AMBER },
  { label: "Problem-Solving & Data",        value: 3,  color: "#6366f1" },
];

const rwDomainDetails = [
  { domain: "Craft & Structure",            m1: "8 (3E·3M·2H)", m2e: "8 (4E·3M·1H)", m2h: "8 (1E·3M·4H)", focus: "Vocabulary, text structure, purpose, cross-text connections" },
  { domain: "Information & Ideas",          m1: "7 (2E·3M·2H)", m2e: "7 (3E·3M·1H)", m2h: "7 (1E·2M·4H)", focus: "Inference, main idea, command of evidence, data interpretation" },
  { domain: "Expression of Ideas",          m1: "5 (1E·2M·2H)", m2e: "5 (2E·2M·1H)", m2h: "5 (1E·1M·3H)", focus: "Rhetorical synthesis, revision, transitions" },
  { domain: "Standard English Conventions", m1: "7 (2E·2M·3H)", m2e: "7 (3E·3M·1H)", m2h: "7 (1E·2M·4H)", focus: "Boundaries, form, structure, usage" },
];

const mathDomainDetails = [
  { domain: "Algebra",                 m1: "8 (2E·4M·2H)", m2e: "7 easy",   m2h: "7 hard",   focus: "Linear equations, systems, inequalities, functions" },
  { domain: "Advanced Math",           m1: "7 (1E·4M·2H)", m2e: "7 medium", m2h: "8 hard",   focus: "Nonlinear functions, equivalent expressions, quadratics" },
  { domain: "Geometry & Trig",         m1: "4 (1E·2M·1H)", m2e: "4 easy",   m2h: "4 hard",   focus: "Area, volume, Pythagorean theorem, trigonometry, circles" },
  { domain: "Problem-Solving & Data",  m1: "3 (1E·2M)",    m2e: "4 easy",   m2h: "3 hard",   focus: "Ratios, rates, proportions, probability, statistics" },
];

/* ═══════════════════════════════════════════════════════════════ */
export default function SatGuidePage() {
  const sections = [
    { id: "overview",  label: "Overview"   },
    { id: "structure", label: "Structure"  },
    { id: "rw",        label: "R&W"        },
    { id: "math",      label: "Math"       },
    { id: "scoring",   label: "Scoring"    },
    { id: "tips",      label: "Tips"       },
  ];

  return (
    <div className="min-h-screen bg-[#f5f5f0]">

      {/* ── Top bar: test selector ─────────────────────────────── */}
      <div className="border-b border-gray-200 bg-white sticky top-16 z-20 shadow-sm">
        <div className="max-w-6xl mx-auto px-6 flex items-center gap-0 overflow-x-auto">
          {/* Active test tab */}
          <div
            className="flex items-center gap-2 px-5 py-4 text-sm font-bold border-b-2 whitespace-nowrap"
            style={{ borderColor: AMBER, color: NAVY }}
          >
            <BookOpen className="w-4 h-4" style={{ color: AMBER }} />
            SAT
          </div>

          {/* Future tests — greyed */}
          {["ACT", "AP Exams", "GMAT", "GRE"].map((t) => (
            <div
              key={t}
              className="flex items-center gap-1.5 px-5 py-4 text-sm text-gray-300 border-b-2 border-transparent whitespace-nowrap cursor-not-allowed"
            >
              {t}
              <span className="text-[10px] bg-gray-100 text-gray-400 px-1.5 py-0.5 rounded-full font-medium">Soon</span>
            </div>
          ))}
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-6 py-10 flex gap-10">

        {/* ── Left nav ───────────────────────────────────────────── */}
        <aside className="hidden lg:block w-48 flex-shrink-0">
          <div className="sticky top-20">
            <p className="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-3">On this page</p>
            <nav className="space-y-1">
              {sections.map((s) => (
                <a
                  key={s.id}
                  href={`#${s.id}`}
                  className="block px-3 py-2 text-sm text-gray-600 hover:text-gray-900 rounded-lg hover:bg-white transition-colors"
                >
                  {s.label}
                </a>
              ))}
            </nav>

            {/* CTA */}
            <div className="mt-8 rounded-xl p-4 text-center" style={{ background: NAVY }}>
              <p className="text-white text-xs font-semibold mb-2">Ready to practice?</p>
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
        <main className="flex-1 min-w-0 space-y-14">

          {/* ── Overview ──────────────────────────────────────────── */}
          <section>
            <SectionHeader
              id="overview"
              icon={<TrendingUp className="w-5 h-5 text-white" />}
              title="SAT — What You Need to Know"
              subtitle="Digital SAT (dSAT) · Adaptive · 2 hrs 14 min"
            />

            {/* Quick stats strip */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-8">
              {[
                { value: "1600",      label: "Max Score"          },
                { value: "98",        label: "Total Questions"     },
                { value: "2:14",      label: "Total Time (hrs)"   },
                { value: "4 modules", label: "Adaptive Structure"  },
              ].map((s) => (
                <div key={s.label} className="bg-white rounded-xl border border-gray-200 px-5 py-4 text-center">
                  <p className="text-2xl font-extrabold" style={{ color: NAVY }}>{s.value}</p>
                  <p className="text-xs text-gray-500 mt-1">{s.label}</p>
                </div>
              ))}
            </div>

            <div className="bg-white rounded-xl border border-gray-200 p-5 text-sm text-gray-600 leading-relaxed">
              The Digital SAT is a computer-adaptive test administered by College Board. It consists of two sections —
              Reading & Writing and Math — each split into two adaptive modules. Your performance in Module 1
              determines the difficulty of Module 2, directly affecting your final score potential.
              All questions are either multiple choice (4 options) or student-produced response (grid-in for Math).
            </div>
          </section>

          {/* ── Structure ─────────────────────────────────────────── */}
          <section>
            <SectionHeader
              id="structure"
              icon={<Clock className="w-5 h-5 text-white" />}
              title="Test Structure"
              subtitle="Two sections · four modules · fully adaptive"
            />

            <div className="overflow-x-auto rounded-xl border border-gray-200 shadow-sm">
              <table className="w-full text-sm">
                <thead>
                  <tr>
                    <th className="px-5 py-3.5 text-left text-white font-semibold" style={{ background: NAVY }}>Section</th>
                    <th className="px-5 py-3.5 text-center text-white font-semibold" style={{ background: NAVY }}>Module</th>
                    <th className="px-5 py-3.5 text-center text-white font-semibold" style={{ background: NAVY }}>Questions</th>
                    <th className="px-5 py-3.5 text-center text-white font-semibold" style={{ background: NAVY }}>Time</th>
                    <th className="px-5 py-3.5 text-left text-white font-semibold" style={{ background: NAVY }}>Note</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {[
                    { section: "Reading & Writing", mod: "Module 1", q: 27, time: "32 min", note: "Same difficulty for all students" },
                    { section: "Reading & Writing", mod: "Module 2", q: 27, time: "32 min", note: "Easy or Hard track based on M1 score" },
                    { section: "Math",              mod: "Module 1", q: 22, time: "35 min", note: "Same difficulty for all students" },
                    { section: "Math",              mod: "Module 2", q: 22, time: "35 min", note: "Easy or Hard track based on M1 score" },
                  ].map((row, i) => (
                    <tr key={i} className={i % 2 === 0 ? "bg-white" : "bg-gray-50"}>
                      <td className="px-5 py-3.5 font-medium" style={{ color: NAVY }}>{row.section}</td>
                      <td className="px-5 py-3.5 text-center text-gray-700">{row.mod}</td>
                      <td className="px-5 py-3.5 text-center font-bold" style={{ color: NAVY }}>{row.q}</td>
                      <td className="px-5 py-3.5 text-center text-gray-700">{row.time}</td>
                      <td className="px-5 py-3.5 text-gray-500">{row.note}</td>
                    </tr>
                  ))}
                </tbody>
                <tfoot>
                  <tr className="border-t-2 border-gray-200">
                    <td className="px-5 py-3.5 font-bold" style={{ color: NAVY }} colSpan={2}>Total</td>
                    <td className="px-5 py-3.5 text-center font-extrabold text-lg" style={{ color: AMBER }}>98</td>
                    <td className="px-5 py-3.5 text-center font-bold" style={{ color: NAVY }}>134 min</td>
                    <td className="px-5 py-3.5 text-gray-400 text-xs">+10 min break between sections</td>
                  </tr>
                </tfoot>
              </table>
            </div>

            {/* Adaptive routing */}
            <div className="mt-6 bg-white rounded-xl border border-gray-200 p-6">
              <p className="text-xs font-semibold uppercase tracking-widest mb-5" style={{ color: AMBER }}>Adaptive Routing</p>
              <div className="flex flex-col sm:flex-row items-center gap-4 justify-center">
                {/* M1 */}
                <div className="rounded-xl border-2 px-6 py-4 text-center" style={{ borderColor: NAVY }}>
                  <p className="text-xs font-semibold uppercase tracking-wider mb-1" style={{ color: AMBER }}>Module 1</p>
                  <p className="font-bold" style={{ color: NAVY }}>Same for Everyone</p>
                  <p className="text-xs text-gray-400 mt-1">R&W: 27q · Math: 22q</p>
                </div>

                {/* Arrow + threshold */}
                <div className="flex flex-col items-center gap-1 sm:flex-row sm:gap-0">
                  <div className="hidden sm:block w-6 h-0.5 bg-gray-300" />
                  <div className="rounded-lg border border-gray-200 px-4 py-3 text-center bg-gray-50 text-xs">
                    <p className="font-semibold text-gray-700">Threshold</p>
                    <p className="text-gray-500 mt-0.5">R&W ≥ 14/27</p>
                    <p className="text-gray-500">Math ≥ 15/22</p>
                  </div>
                  <div className="hidden sm:block w-6 h-0.5 bg-gray-300" />
                </div>

                {/* M2 branches */}
                <div className="flex flex-col gap-3">
                  <div className="rounded-xl border-2 px-6 py-3 text-center" style={{ borderColor: TEAL }}>
                    <p className="text-xs font-semibold uppercase tracking-wider mb-0.5" style={{ color: TEAL }}>Hard M2</p>
                    <p className="text-sm font-bold text-gray-700">Higher ceiling</p>
                    <p className="text-xs text-gray-400 mt-0.5">Max score ~800 per section</p>
                  </div>
                  <div className="rounded-xl border-2 px-6 py-3 text-center border-gray-300">
                    <p className="text-xs font-semibold uppercase tracking-wider text-gray-400 mb-0.5">Easy M2</p>
                    <p className="text-sm font-bold text-gray-700">Capped ceiling</p>
                    <p className="text-xs text-gray-400 mt-0.5">Max score ~670 per section</p>
                  </div>
                </div>
              </div>
            </div>
          </section>

          {/* ── Reading & Writing ──────────────────────────────────── */}
          <section>
            <SectionHeader
              id="rw"
              icon={<BookOpen className="w-5 h-5 text-white" />}
              title="Reading & Writing"
              subtitle="27 questions per module · 32 minutes · MCQ only"
            />

            <div className="flex flex-col md:flex-row gap-6 mb-6">
              {/* Donut */}
              <div className="bg-white rounded-xl border border-gray-200 p-6 flex flex-col items-center justify-center flex-shrink-0">
                <DonutChart segments={rwSegments} total={27} centerLabel="27q" />
                <div className="mt-4 w-full max-w-[220px]">
                  <ChartLegend segments={rwSegments} />
                </div>
              </div>

              {/* Question type note */}
              <div className="flex-1 flex flex-col gap-4">
                <div className="bg-white rounded-xl border border-gray-200 p-5 flex-1">
                  <p className="text-xs font-semibold uppercase tracking-widest mb-3" style={{ color: AMBER }}>Question Format</p>
                  <div className="space-y-3 text-sm text-gray-600">
                    <div className="flex items-start gap-3">
                      <span className="w-2 h-2 rounded-full mt-1.5 flex-shrink-0" style={{ background: NAVY }} />
                      <p><strong>All MCQ</strong> — four answer choices (A–D). No grid-in questions in R&W.</p>
                    </div>
                    <div className="flex items-start gap-3">
                      <span className="w-2 h-2 rounded-full mt-1.5 flex-shrink-0" style={{ background: TEAL }} />
                      <p>Each question has a short passage or data graphic (50–150 words). Questions are mostly independent, not passage-sets.</p>
                    </div>
                    <div className="flex items-start gap-3">
                      <span className="w-2 h-2 rounded-full mt-1.5 flex-shrink-0" style={{ background: AMBER }} />
                      <p>Approximately <strong>70% text-based</strong> passages, 30% informational graphics (charts/tables).</p>
                    </div>
                  </div>
                </div>

                <div className="bg-white rounded-xl border border-gray-200 p-5">
                  <p className="text-xs font-semibold uppercase tracking-widest mb-3" style={{ color: AMBER }}>Difficulty Mix (M1)</p>
                  <div className="flex gap-3">
                    {[
                      { tier: "Easy",   count: "8q",  pct: 30, color: "#22c55e" },
                      { tier: "Medium", count: "10q", pct: 37, color: AMBER },
                      { tier: "Hard",   count: "9q",  pct: 33, color: "#ef4444" },
                    ].map((d) => (
                      <div key={d.tier} className="flex-1 rounded-lg border border-gray-100 p-3 text-center">
                        <div className="w-3 h-3 rounded-full mx-auto mb-1.5" style={{ background: d.color }} />
                        <p className="text-xs text-gray-500">{d.tier}</p>
                        <p className="text-base font-bold mt-0.5" style={{ color: NAVY }}>{d.count}</p>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>

            {/* R&W domain table */}
            <div className="overflow-x-auto rounded-xl border border-gray-200 shadow-sm">
              <table className="w-full text-sm">
                <thead>
                  <tr>
                    <th className="px-5 py-3.5 text-left text-white font-semibold" style={{ background: NAVY }}>Domain</th>
                    <th className="px-5 py-3.5 text-center text-white font-semibold" style={{ background: NAVY }}>M1</th>
                    <th className="px-5 py-3.5 text-center text-white font-semibold" style={{ background: NAVY }}>M2 Easy track</th>
                    <th className="px-5 py-3.5 text-center text-white font-semibold" style={{ background: NAVY }}>M2 Hard track</th>
                    <th className="px-5 py-3.5 text-left text-white font-semibold" style={{ background: NAVY }}>What it tests</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {rwDomainDetails.map((row, i) => (
                    <tr key={i} className={i % 2 === 0 ? "bg-white" : "bg-gray-50"}>
                      <td className="px-5 py-3.5 font-medium" style={{ color: NAVY }}>{row.domain}</td>
                      <td className="px-5 py-3.5 text-center text-gray-700 font-mono text-xs">{row.m1}</td>
                      <td className="px-5 py-3.5 text-center text-gray-700 font-mono text-xs">{row.m2e}</td>
                      <td className="px-5 py-3.5 text-center text-gray-700 font-mono text-xs">{row.m2h}</td>
                      <td className="px-5 py-3.5 text-gray-500 text-xs">{row.focus}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </section>

          {/* ── Math ──────────────────────────────────────────────── */}
          <section>
            <SectionHeader
              id="math"
              icon={<Calculator className="w-5 h-5 text-white" />}
              title="Math"
              subtitle="22 questions per module · 35 minutes · MCQ + Grid-in"
            />

            <div className="flex flex-col md:flex-row gap-6 mb-6">
              {/* Donut */}
              <div className="bg-white rounded-xl border border-gray-200 p-6 flex flex-col items-center justify-center flex-shrink-0">
                <DonutChart segments={mathSegments} total={22} centerLabel="22q" />
                <div className="mt-4 w-full max-w-[220px]">
                  <ChartLegend segments={mathSegments} />
                </div>
              </div>

              {/* Question type note */}
              <div className="flex-1 flex flex-col gap-4">
                <div className="bg-white rounded-xl border border-gray-200 p-5 flex-1">
                  <p className="text-xs font-semibold uppercase tracking-widest mb-3" style={{ color: AMBER }}>Question Format</p>
                  <div className="space-y-3 text-sm text-gray-600">
                    <div className="flex items-start gap-3">
                      <span className="w-2 h-2 rounded-full mt-1.5 flex-shrink-0" style={{ background: NAVY }} />
                      <p><strong>~17 MCQ</strong> (four choices) and <strong>~5 Grid-in</strong> (student-produced response) per module.</p>
                    </div>
                    <div className="flex items-start gap-3">
                      <span className="w-2 h-2 rounded-full mt-1.5 flex-shrink-0" style={{ background: TEAL }} />
                      <p>Calculator is permitted for the <strong>entire</strong> Math section. Desmos graphing calculator is built in.</p>
                    </div>
                    <div className="flex items-start gap-3">
                      <span className="w-2 h-2 rounded-full mt-1.5 flex-shrink-0" style={{ background: AMBER }} />
                      <p>A reference sheet with geometry formulas is provided within the test interface.</p>
                    </div>
                  </div>
                </div>

                <div className="bg-white rounded-xl border border-gray-200 p-5">
                  <p className="text-xs font-semibold uppercase tracking-widest mb-3" style={{ color: AMBER }}>Difficulty Mix (M1)</p>
                  <div className="flex gap-3">
                    {[
                      { tier: "Easy",   count: "5q",  pct: 23, color: "#22c55e" },
                      { tier: "Medium", count: "12q", pct: 55, color: AMBER },
                      { tier: "Hard",   count: "5q",  pct: 23, color: "#ef4444" },
                    ].map((d) => (
                      <div key={d.tier} className="flex-1 rounded-lg border border-gray-100 p-3 text-center">
                        <div className="w-3 h-3 rounded-full mx-auto mb-1.5" style={{ background: d.color }} />
                        <p className="text-xs text-gray-500">{d.tier}</p>
                        <p className="text-base font-bold mt-0.5" style={{ color: NAVY }}>{d.count}</p>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>

            {/* Math domain table */}
            <div className="overflow-x-auto rounded-xl border border-gray-200 shadow-sm">
              <table className="w-full text-sm">
                <thead>
                  <tr>
                    <th className="px-5 py-3.5 text-left text-white font-semibold" style={{ background: NAVY }}>Domain</th>
                    <th className="px-5 py-3.5 text-center text-white font-semibold" style={{ background: NAVY }}>M1</th>
                    <th className="px-5 py-3.5 text-center text-white font-semibold" style={{ background: NAVY }}>M2 Easy track</th>
                    <th className="px-5 py-3.5 text-center text-white font-semibold" style={{ background: NAVY }}>M2 Hard track</th>
                    <th className="px-5 py-3.5 text-left text-white font-semibold" style={{ background: NAVY }}>Key topics</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {mathDomainDetails.map((row, i) => (
                    <tr key={i} className={i % 2 === 0 ? "bg-white" : "bg-gray-50"}>
                      <td className="px-5 py-3.5 font-medium" style={{ color: NAVY }}>{row.domain}</td>
                      <td className="px-5 py-3.5 text-center text-gray-700 font-mono text-xs">{row.m1}</td>
                      <td className="px-5 py-3.5 text-center text-gray-700 font-mono text-xs">{row.m2e}</td>
                      <td className="px-5 py-3.5 text-center text-gray-700 font-mono text-xs">{row.m2h}</td>
                      <td className="px-5 py-3.5 text-gray-500 text-xs">{row.focus}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </section>

          {/* ── Scoring ───────────────────────────────────────────── */}
          <section>
            <SectionHeader
              id="scoring"
              icon={<TrendingUp className="w-5 h-5 text-white" />}
              title="Scoring"
              subtitle="400–1600 composite · two section scores · no guessing penalty"
            />

            <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
              {[
                { label: "Composite Score Range", value: "400 – 1600", sub: "Sum of two section scores" },
                { label: "R&W Section Score",      value: "200 – 800", sub: "Even numbers only" },
                { label: "Math Section Score",     value: "200 – 800", sub: "Even numbers only" },
              ].map((s) => (
                <div key={s.label} className="bg-white rounded-xl border border-gray-200 px-5 py-5 text-center">
                  <p className="text-xs text-gray-400 mb-1">{s.label}</p>
                  <p className="text-2xl font-extrabold" style={{ color: NAVY }}>{s.value}</p>
                  <p className="text-xs text-gray-400 mt-1">{s.sub}</p>
                </div>
              ))}
            </div>

            <div className="bg-white rounded-xl border border-gray-200 p-5 text-sm text-gray-600 leading-relaxed space-y-3">
              <div className="flex items-start gap-3">
                <span className="w-2 h-2 rounded-full mt-1.5 flex-shrink-0" style={{ background: AMBER }} />
                <p><strong>No guessing penalty.</strong> Your raw score is the number of correct answers. Unanswered and wrong answers both score 0, so always guess if unsure.</p>
              </div>
              <div className="flex items-start gap-3">
                <span className="w-2 h-2 rounded-full mt-1.5 flex-shrink-0" style={{ background: TEAL }} />
                <p><strong>Adaptive scoring.</strong> A student routed to Hard M2 who answers the same number of questions correctly as a student on Easy M2 will score higher, because the Hard track questions are weighted more heavily.</p>
              </div>
              <div className="flex items-start gap-3">
                <span className="w-2 h-2 rounded-full mt-1.5 flex-shrink-0" style={{ background: NAVY }} />
                <p><strong>Results in 2–4 days</strong> for digital testing. Scores include a detailed breakdown by domain, difficulty, and question type.</p>
              </div>
            </div>
          </section>

          {/* ── Tips ──────────────────────────────────────────────── */}
          <section>
            <SectionHeader
              id="tips"
              icon={<HelpCircle className="w-5 h-5 text-white" />}
              title="Test Day Strategy"
              subtitle="Evidence-based tips for both sections"
            />

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {[
                {
                  title: "Module 1 is the most important",
                  body: "Your M1 performance determines your M2 track. Getting routed to Hard M2 is the only path to an 800. Treat M1 with maximum focus.",
                  color: NAVY,
                },
                {
                  title: "Don't skip — always guess",
                  body: "No penalty for wrong answers. If you're stuck, eliminate what you can and pick the best remaining option. Never leave a blank.",
                  color: TEAL,
                },
                {
                  title: "Use the built-in Desmos calculator",
                  body: "The on-screen graphing calculator is powerful. For tricky algebra or geometry, graph the equation rather than solving algebraically.",
                  color: AMBER,
                },
                {
                  title: "Flag and come back",
                  body: "Both sections allow you to flag questions and revisit them. Use this on long passages — mark it, answer what you can, return with fresh eyes.",
                  color: "#6366f1",
                },
                {
                  title: "R&W: read the question first",
                  body: "Most R&W passages are short (50–150 words). Read the question before the passage so you know exactly what you're looking for.",
                  color: NAVY,
                },
                {
                  title: "Math: check units and context",
                  body: "SPR (grid-in) answers often require a specific unit or form. Re-read the question after solving to confirm your answer matches what was asked.",
                  color: TEAL,
                },
              ].map((tip) => (
                <div key={tip.title} className="bg-white rounded-xl border border-gray-200 p-5">
                  <div className="flex items-start gap-3">
                    <div className="w-1.5 h-full min-h-[40px] rounded-full flex-shrink-0 mt-0.5" style={{ background: tip.color }} />
                    <div>
                      <p className="font-semibold text-sm" style={{ color: NAVY }}>{tip.title}</p>
                      <p className="text-sm text-gray-500 mt-1 leading-relaxed">{tip.body}</p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </section>

          {/* ── Bottom CTA ────────────────────────────────────────── */}
          <section>
            <div className="rounded-2xl px-8 py-10 flex flex-col sm:flex-row items-center justify-between gap-6" style={{ background: NAVY }}>
              <div>
                <p className="text-white font-bold text-xl mb-1">Practice with full adaptive mocks</p>
                <p className="text-white/60 text-sm">5 full-length SAT mock tests · real adaptive routing · detailed score reports</p>
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

        </main>
      </div>
    </div>
  );
}

"use client";

import Link from "next/link";
import {
  ClipboardList,
  Variable,
  FunctionSquare,
  BarChart3,
  Shapes,
  ChevronRight,
  Home,
  ArrowRight,
} from "lucide-react";
import { MathRenderer } from "@/components/math/MathAtom";

/* ── Palette ──────────────────────────────────────────────────── */
const NAVY = "#1a365d";
const AMBER = "#f4b400";
const TEAL = "#0891b2";

/* ── Types ────────────────────────────────────────────────────── */
// A formula row: a plain-English label plus either a LaTeX expression
// (rendered with KaTeX) or a short text note for conceptual "formulas".
type Formula = { label: string; latex?: string; note?: string };
type Group = { title: string; formulas: Formula[] };
type Section = {
  id: string;
  navLabel: string;
  title: string;
  subtitle: string;
  icon: React.ReactNode;
  groups: Group[];
};

/* ── Data ─────────────────────────────────────────────────────── */
const SECTIONS: Section[] = [
  {
    id: "given",
    navLabel: "Given on the Test",
    title: "Given on the Test",
    subtitle:
      "The reference sheet shown at the start of every SAT Math module — you don't need to memorise these.",
    icon: <ClipboardList className="w-5 h-5 text-white" />,
    groups: [
      {
        title: "Areas & Perimeter",
        formulas: [
          { label: "Area of a rectangle", latex: "A = \\ell w" },
          { label: "Area of a triangle", latex: "A = \\tfrac{1}{2}bh" },
          { label: "Area of a circle", latex: "A = \\pi r^2" },
          { label: "Circumference of a circle", latex: "C = 2\\pi r" },
        ],
      },
      {
        title: "Right Triangles",
        formulas: [
          { label: "Pythagorean theorem", latex: "c^2 = a^2 + b^2" },
          { label: "45°-45°-90° triangle", latex: "s : s : s\\sqrt{2}" },
          { label: "30°-60°-90° triangle", latex: "x : x\\sqrt{3} : 2x" },
        ],
      },
      {
        title: "Volumes",
        formulas: [
          { label: "Rectangular box", latex: "V = \\ell w h" },
          { label: "Cylinder", latex: "V = \\pi r^2 h" },
          { label: "Sphere", latex: "V = \\tfrac{4}{3}\\pi r^3" },
          { label: "Cone", latex: "V = \\tfrac{1}{3}\\pi r^2 h" },
          { label: "Pyramid", latex: "V = \\tfrac{1}{3}\\ell w h" },
        ],
      },
      {
        title: "Facts",
        formulas: [
          { label: "Degrees in a circle", latex: "360^\\circ" },
          { label: "Radians in a circle", latex: "2\\pi" },
          { label: "Angles in a triangle sum to", latex: "180^\\circ" },
        ],
      },
    ],
  },
  {
    id: "algebra",
    navLabel: "Algebra",
    title: "Algebra",
    subtitle: "Linear equations, systems, inequalities & absolute value.",
    icon: <Variable className="w-5 h-5 text-white" />,
    groups: [
      {
        title: "Linear Equations",
        formulas: [
          { label: "Slope", latex: "m = \\dfrac{y_2 - y_1}{x_2 - x_1}" },
          { label: "Slope-intercept form", latex: "y = mx + b" },
          { label: "Point-slope form", latex: "y - y_1 = m(x - x_1)" },
          { label: "Standard form", latex: "Ax + By = C" },
        ],
      },
      {
        title: "Properties of Lines",
        formulas: [
          { label: "Parallel lines", latex: "m_1 = m_2" },
          { label: "Perpendicular lines", latex: "m_1 \\cdot m_2 = -1" },
          { label: "x-intercept", note: "set y = 0 and solve for x" },
          { label: "y-intercept", note: "set x = 0 → the value b" },
        ],
      },
      {
        title: "Systems of Linear Equations",
        formulas: [
          { label: "One solution", note: "lines have different slopes" },
          {
            label: "No solution",
            note: "same slope, different intercept (parallel)",
          },
          {
            label: "Infinitely many",
            note: "same line — coefficients are proportional",
          },
        ],
      },
      {
        title: "Inequalities & Absolute Value",
        formulas: [
          {
            label: "Flip the sign",
            note: "when multiplying or dividing by a negative",
          },
          { label: "Absolute value equation", latex: "|x| = a \\Rightarrow x = \\pm a" },
          { label: "Less-than", latex: "|x| < a \\Rightarrow -a < x < a" },
          {
            label: "Greater-than",
            latex: "|x| > a \\Rightarrow x < -a \\text{ or } x > a",
          },
        ],
      },
    ],
  },
  {
    id: "advanced",
    navLabel: "Advanced Math",
    title: "Advanced Math",
    subtitle:
      "Exponents, radicals, factoring, quadratics, functions & exponential models.",
    icon: <FunctionSquare className="w-5 h-5 text-white" />,
    groups: [
      {
        title: "Exponent Rules",
        formulas: [
          { label: "Product", latex: "a^m \\cdot a^n = a^{m+n}" },
          { label: "Quotient", latex: "\\dfrac{a^m}{a^n} = a^{m-n}" },
          { label: "Power of a power", latex: "(a^m)^n = a^{mn}" },
          { label: "Power of a product", latex: "(ab)^n = a^n b^n" },
          { label: "Negative exponent", latex: "a^{-n} = \\dfrac{1}{a^n}" },
          { label: "Fractional exponent", latex: "a^{m/n} = \\sqrt[n]{a^m}" },
          { label: "Zero exponent", latex: "a^0 = 1" },
        ],
      },
      {
        title: "Radicals",
        formulas: [
          { label: "Product rule", latex: "\\sqrt{ab} = \\sqrt{a}\\,\\sqrt{b}" },
          { label: "Quotient rule", latex: "\\sqrt{\\tfrac{a}{b}} = \\dfrac{\\sqrt{a}}{\\sqrt{b}}" },
          { label: "Radical to exponent", latex: "\\sqrt[n]{a} = a^{1/n}" },
        ],
      },
      {
        title: "Factoring Patterns",
        formulas: [
          { label: "Difference of squares", latex: "a^2 - b^2 = (a+b)(a-b)" },
          { label: "Perfect square", latex: "a^2 \\pm 2ab + b^2 = (a \\pm b)^2" },
          {
            label: "Trinomial",
            latex: "x^2 + (p+q)x + pq = (x+p)(x+q)",
          },
        ],
      },
      {
        title: "Quadratic Equations",
        formulas: [
          { label: "Standard form", latex: "y = ax^2 + bx + c" },
          {
            label: "Quadratic formula",
            latex: "x = \\dfrac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}",
          },
          { label: "Discriminant", latex: "\\Delta = b^2 - 4ac" },
          {
            label: "Roots from discriminant",
            note: "Δ>0: two real · Δ=0: one · Δ<0: none",
          },
          { label: "Vertex form", latex: "y = a(x-h)^2 + k,\\ \\text{vertex }(h,k)" },
          { label: "Axis of symmetry", latex: "x = -\\dfrac{b}{2a}" },
          { label: "Factored form", latex: "y = a(x - r_1)(x - r_2)" },
          {
            label: "Sum & product of roots",
            latex: "r_1 + r_2 = -\\tfrac{b}{a},\\ \\ r_1 r_2 = \\tfrac{c}{a}",
          },
        ],
      },
      {
        title: "Functions",
        formulas: [
          { label: "Function notation", latex: "y = f(x)" },
          { label: "Vertical shift", latex: "f(x) + k\\ \\ (\\text{up } k)" },
          { label: "Horizontal shift", latex: "f(x + k)\\ \\ (\\text{left } k)" },
          { label: "Reflection over x-axis", latex: "-f(x)" },
        ],
      },
      {
        title: "Exponential Functions & Interest",
        formulas: [
          { label: "Exponential growth", latex: "y = a(1 + r)^t" },
          { label: "Exponential decay", latex: "y = a(1 - r)^t" },
          {
            label: "Compound interest",
            latex: "A = P\\left(1 + \\dfrac{r}{n}\\right)^{nt}",
          },
        ],
      },
      {
        title: "Polynomial Theorems",
        formulas: [
          {
            label: "Remainder theorem",
            latex: "P(x) \\div (x - a)\\ \\text{remainder} = P(a)",
          },
          {
            label: "Factor theorem",
            latex: "(x - a)\\ \\text{is a factor} \\iff P(a) = 0",
          },
        ],
      },
    ],
  },
  {
    id: "psda",
    navLabel: "Problem-Solving & Data",
    title: "Problem-Solving & Data Analysis",
    subtitle:
      "Ratios, percentages, statistics, probability & data interpretation.",
    icon: <BarChart3 className="w-5 h-5 text-white" />,
    groups: [
      {
        title: "Ratios, Rates & Proportions",
        formulas: [
          { label: "Proportion", latex: "\\dfrac{a}{b} = \\dfrac{c}{d}" },
          { label: "Distance", latex: "d = r \\cdot t" },
          { label: "Unit conversion", note: "multiply by a fraction equal to 1" },
        ],
      },
      {
        title: "Percentages",
        formulas: [
          { label: "Percent", latex: "\\% = \\dfrac{\\text{part}}{\\text{whole}} \\times 100" },
          {
            label: "Percent change",
            latex: "\\dfrac{\\text{new} - \\text{old}}{\\text{old}} \\times 100",
          },
          { label: "Percent increase", latex: "\\text{new} = \\text{old}(1 + \\tfrac{p}{100})" },
          { label: "Percent decrease", latex: "\\text{new} = \\text{old}(1 - \\tfrac{p}{100})" },
        ],
      },
      {
        title: "Statistics",
        formulas: [
          { label: "Mean (average)", latex: "\\bar{x} = \\dfrac{\\sum x}{n}" },
          { label: "Median", note: "the middle value when ordered" },
          { label: "Mode", note: "the most frequent value" },
          { label: "Range", latex: "\\text{max} - \\text{min}" },
          {
            label: "Standard deviation",
            note: "spread about the mean — larger = more spread",
          },
        ],
      },
      {
        title: "Probability",
        formulas: [
          {
            label: "Basic probability",
            latex: "P = \\dfrac{\\text{favorable}}{\\text{total}}",
          },
          {
            label: "Either (A or B)",
            latex: "P(A) + P(B) - P(A \\text{ and } B)",
          },
          {
            label: "Both, independent",
            latex: "P(A \\text{ and } B) = P(A) \\cdot P(B)",
          },
        ],
      },
      {
        title: "Scatterplots & Sampling",
        formulas: [
          {
            label: "Line of best fit",
            note: "models the trend; use it to predict / interpolate",
          },
          {
            label: "Positive / negative association",
            note: "best-fit slope is up / down",
          },
          {
            label: "Valid inference",
            note: "needs a random, representative sample",
          },
        ],
      },
    ],
  },
  {
    id: "geometry",
    navLabel: "Geometry & Trig",
    title: "Geometry & Trigonometry",
    subtitle:
      "Angles, triangles, circles, polygons, coordinate & solid geometry.",
    icon: <Shapes className="w-5 h-5 text-white" />,
    groups: [
      {
        title: "Lines & Angles",
        formulas: [
          { label: "Supplementary angles", latex: "a + b = 180^\\circ" },
          { label: "Complementary angles", latex: "a + b = 90^\\circ" },
          { label: "Vertical angles", note: "are equal" },
          {
            label: "Parallel lines cut by a transversal",
            note: "corresponding & alternate angles are equal",
          },
        ],
      },
      {
        title: "Triangles",
        formulas: [
          { label: "Angle sum", latex: "a + b + c = 180^\\circ" },
          {
            label: "Exterior angle",
            latex: "= \\text{sum of remote interior angles}",
          },
          { label: "Area", latex: "A = \\tfrac{1}{2}bh" },
          {
            label: "Similar triangles",
            note: "corresponding sides are proportional",
          },
        ],
      },
      {
        title: "Right Triangles & Trigonometry",
        formulas: [
          { label: "Sine", latex: "\\sin\\theta = \\dfrac{\\text{opp}}{\\text{hyp}}" },
          { label: "Cosine", latex: "\\cos\\theta = \\dfrac{\\text{adj}}{\\text{hyp}}" },
          { label: "Tangent", latex: "\\tan\\theta = \\dfrac{\\text{opp}}{\\text{adj}}" },
          { label: "Cofunction identity", latex: "\\sin\\theta = \\cos(90^\\circ - \\theta)" },
        ],
      },
      {
        title: "Circles",
        formulas: [
          { label: "Equation of a circle", latex: "(x-h)^2 + (y-k)^2 = r^2" },
          {
            label: "Arc length",
            latex: "s = \\dfrac{\\theta}{360^\\circ} \\cdot 2\\pi r = r\\theta_{\\text{rad}}",
          },
          {
            label: "Sector area",
            latex: "A = \\dfrac{\\theta}{360^\\circ} \\cdot \\pi r^2 = \\tfrac{1}{2}r^2\\theta_{\\text{rad}}",
          },
          {
            label: "Inscribed angle",
            latex: "= \\tfrac{1}{2}\\,\\text{central angle}",
          },
          {
            label: "Degrees ↔ radians",
            latex: "\\text{rad} = \\text{deg} \\times \\dfrac{\\pi}{180}",
          },
        ],
      },
      {
        title: "Polygons",
        formulas: [
          { label: "Sum of interior angles", latex: "(n - 2) \\times 180^\\circ" },
          {
            label: "Each interior angle (regular)",
            latex: "\\dfrac{(n - 2) \\times 180^\\circ}{n}",
          },
          { label: "Sum of exterior angles", latex: "360^\\circ" },
        ],
      },
      {
        title: "Coordinate & Solid Geometry",
        formulas: [
          {
            label: "Distance",
            latex: "d = \\sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}",
          },
          {
            label: "Midpoint",
            latex: "\\left(\\dfrac{x_1 + x_2}{2},\\ \\dfrac{y_1 + y_2}{2}\\right)",
          },
          {
            label: "Surface area — box",
            latex: "2(\\ell w + \\ell h + wh)",
          },
          { label: "Surface area — cylinder", latex: "2\\pi r^2 + 2\\pi r h" },
          { label: "Surface area — sphere", latex: "4\\pi r^2" },
        ],
      },
    ],
  },
];

/* ── Section header (matches sat-guide) ───────────────────────── */
function SectionHeader({
  id,
  icon,
  title,
  subtitle,
}: {
  id: string;
  icon: React.ReactNode;
  title: string;
  subtitle: string;
}) {
  return (
    <div id={id} className="flex items-start gap-4 mb-8 pt-2 scroll-mt-24">
      <div
        className="w-11 h-11 rounded-xl flex items-center justify-center flex-shrink-0"
        style={{ background: NAVY }}
      >
        {icon}
      </div>
      <div>
        <h2 className="text-xl font-bold" style={{ color: NAVY }}>
          {title}
        </h2>
        <p className="text-sm text-gray-500 mt-0.5">{subtitle}</p>
      </div>
    </div>
  );
}

/* ── Single formula row ───────────────────────────────────────── */
function FormulaRow({ formula }: { formula: Formula }) {
  return (
    <div className="flex items-center justify-between gap-4 py-2.5 border-b border-gray-100 last:border-0">
      <span className="text-sm text-gray-600 flex-shrink min-w-0">
        {formula.label}
      </span>
      <span className="text-right flex-shrink-0">
        {formula.latex ? (
          <MathRenderer latex={formula.latex} />
        ) : (
          <span className="text-sm italic text-gray-500">{formula.note}</span>
        )}
      </span>
    </div>
  );
}

/* ═══════════════════════════════════════════════════════════════ */
export function FormulasContent() {
  return (
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
                Math Formulas
              </li>
            </ol>
          </nav>

          <p className="text-xs font-semibold uppercase tracking-widest text-gray-400 mb-3">
            On this page
          </p>
          <nav className="space-y-1">
            {SECTIONS.map((s) => (
              <a
                key={s.id}
                href={`#${s.id}`}
                className="block px-3 py-2 text-sm text-gray-600 hover:text-gray-900 rounded-lg hover:bg-white transition-colors"
              >
                {s.navLabel}
              </a>
            ))}
          </nav>

          {/* CTA */}
          <div className="mt-8 rounded-xl p-4 text-center" style={{ background: NAVY }}>
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
        {/* Intro */}
        <div className="mb-12">
          <div
            className="flex items-center gap-2 text-xs font-semibold uppercase tracking-wide mb-3"
            style={{ color: TEAL }}
          >
            <FunctionSquare className="w-4 h-4" />
            Digital SAT · Math Cheat Sheet
          </div>
          <h1
            className="text-3xl sm:text-4xl font-bold leading-tight"
            style={{ color: NAVY }}
          >
            SAT Math Formulas
          </h1>
          <p className="text-gray-600 mt-4 text-lg leading-relaxed max-w-2xl">
            The SAT hands you a short reference sheet — and assumes you already
            know the rest. This is the complete set, organised by the four SAT
            Math domains: the formulas given inside Bluebook, plus the ones
            you&apos;re expected to bring with you.
          </p>
        </div>

        <div className="space-y-16">
          {SECTIONS.map((section) => (
            <section key={section.id}>
              <SectionHeader
                id={section.id}
                icon={section.icon}
                title={section.title}
                subtitle={section.subtitle}
              />
              <div className="grid sm:grid-cols-2 gap-4">
                {section.groups.map((group) => (
                  <div
                    key={group.title}
                    className="bg-white rounded-xl border border-gray-200 p-5"
                  >
                    <p
                      className="text-xs font-semibold uppercase tracking-widest mb-2"
                      style={{ color: AMBER }}
                    >
                      {group.title}
                    </p>
                    <div>
                      {group.formulas.map((f) => (
                        <FormulaRow key={f.label} formula={f} />
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </section>
          ))}

          {/* ── Bottom CTA ───────────────────────────────────────── */}
          <section>
            <div
              className="rounded-2xl px-8 py-10 flex flex-col sm:flex-row items-center justify-between gap-6"
              style={{ background: NAVY }}
            >
              <div>
                <p className="text-white font-bold text-xl mb-1">
                  Know the formulas? Now use them under pressure
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
        </div>
      </main>
    </div>
  );
}

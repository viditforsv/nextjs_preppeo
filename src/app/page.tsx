"use client";

import { Button } from "@/design-system/components/ui/button";
import {
  Card,
  CardContent,
} from "@/design-system/components/ui/card";
import {
  ArrowRight,
  TrendingUp,
  GraduationCap,
  ClipboardCheck,
  ExternalLink,
} from "lucide-react";
import { useAuth } from "@/contexts/AuthContext";
import { useRouter } from "next/navigation";
import Link from "next/link";

const exams = [
  {
    name: "SAT",
    description: "College admission test covering reading, writing, and math.",
    gradient: "from-indigo-500 to-indigo-600",
    testRoute: "/sat-test",
    courseQuery: "SAT",
    live: true,
  },
  {
    name: "GRE",
    description: "Graduate school entrance exam — verbal, quant, and AWA.",
    gradient: "from-purple-500 to-purple-600",
    testRoute: "/gre-test",
    courseQuery: "GRE",
    live: true,
  },
  {
    name: "Ashoka",
    description: "Ashoka University aptitude test for undergraduate admissions.",
    gradient: "from-teal-500 to-teal-600",
    testRoute: "/ashoka-test",
    courseQuery: "Ashoka",
    live: true,
  },
  {
    name: "GMAT",
    description: "Business school admission test — quant, verbal, and data insights.",
    gradient: "from-red-500 to-red-600",
    testRoute: "/gmat-test",
    courseQuery: "GMAT",
    live: false,
  },
];

function ExamShowcase({ showHeading = true }: { showHeading?: boolean }) {
  return (
    <section className="py-16 bg-white">
      <div className="max-w-6xl mx-auto px-4">
        {showHeading && (
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-foreground mb-3">
              Explore by Exam
            </h2>
            <p className="text-muted-foreground max-w-xl mx-auto">
              Jump straight into a full-length adaptive mock for your target exam.
            </p>
          </div>
        )}
        <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-5">
          {exams.map((exam) => (
            <Card
              key={exam.name}
              className="relative overflow-hidden hover:shadow-lg transition-shadow"
            >
              <CardContent className="p-5">
                <div className="flex items-start justify-between mb-3">
                  <div
                    className={`w-10 h-10 rounded-lg bg-linear-to-br ${exam.gradient} flex items-center justify-center`}
                  >
                    <GraduationCap className="w-5 h-5 text-white" />
                  </div>
                  {exam.live ? (
                    <span className="text-[11px] font-medium bg-emerald-100 text-emerald-700 px-2 py-0.5 rounded-full">
                      Live
                    </span>
                  ) : (
                    <span className="text-[11px] font-medium bg-amber-100 text-amber-700 px-2 py-0.5 rounded-full">
                      Coming Soon
                    </span>
                  )}
                </div>
                <h3 className="font-bold text-foreground text-lg mb-1">
                  {exam.name}
                </h3>
                <p className="text-sm text-muted-foreground mb-4 leading-relaxed">
                  {exam.description}
                </p>
                <div>
                  {exam.live ? (
                    <Link
                      href={exam.testRoute}
                      className="w-full flex items-center justify-center gap-1.5 py-2 bg-primary text-white text-xs font-semibold rounded-md hover:bg-primary/90 transition-colors"
                    >
                      Mock Test <ExternalLink className="w-3 h-3" />
                    </Link>
                  ) : (
                    <span className="w-full flex items-center justify-center gap-1.5 py-2 bg-gray-100 text-gray-400 text-xs font-semibold rounded-md cursor-not-allowed">
                      Coming Soon
                    </span>
                  )}
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
}

export default function Home() {
  const router = useRouter();
  const authContext = useAuth();
  const user = authContext?.user;
  const profile = authContext?.profile;
  const loading = authContext?.loading;


  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-10 w-10 border-2 border-primary border-t-transparent" />
      </div>
    );
  }

  // ── Authenticated ──
  if (user) {
    return (
      <div className="min-h-screen bg-[#f5f5f0]">
        {/* Compact Hero */}
        <section className="bg-white border-b border-gray-100">
          <div className="max-w-6xl mx-auto px-4 py-12">
            <h1 className="text-3xl font-bold text-foreground mb-2">
              Welcome back, {profile?.first_name || profile?.full_name || "Student"}
            </h1>
            <p className="text-muted-foreground mb-6">
              Pick up where you left off or start something new.
            </p>

            <div className="flex gap-3 flex-wrap">
              <Button
                className="bg-primary hover:bg-primary/90 text-white"
                onClick={() => router.push("/tests")}
              >
                Mock Tests
                <ArrowRight className="ml-2 h-4 w-4" />
              </Button>
              <Button
                variant="outline"
                className="border-primary text-primary hover:bg-primary hover:text-white"
                onClick={() => router.push("/sat-test/history")}
              >
                Score History
              </Button>
            </div>
          </div>
        </section>

        {/* Quick Actions */}
        <section className="py-12">
          <div className="max-w-6xl mx-auto px-4">
            <div className="grid sm:grid-cols-2 gap-4">
              <Link href="/tests" className="group">
                <Card className="h-full hover:shadow-md transition-shadow">
                  <CardContent className="p-6 flex items-start gap-4">
                    <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center shrink-0">
                      <ClipboardCheck className="w-5 h-5 text-primary" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-foreground mb-1">Mock Tests</h3>
                      <p className="text-sm text-muted-foreground">
                        Take a full-length adaptive test or continue practice mode.
                      </p>
                    </div>
                  </CardContent>
                </Card>
              </Link>
              <Link href="/sat-test/history" className="group">
                <Card className="h-full hover:shadow-md transition-shadow">
                  <CardContent className="p-6 flex items-start gap-4">
                    <div className="w-10 h-10 rounded-lg bg-emerald-50 flex items-center justify-center shrink-0">
                      <TrendingUp className="w-5 h-5 text-emerald-600" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-foreground mb-1">Score History</h3>
                      <p className="text-sm text-muted-foreground">
                        Review past test results, domain breakdown, and progress over time.
                      </p>
                    </div>
                  </CardContent>
                </Card>
              </Link>
            </div>
          </div>
        </section>

        {/* Exam Showcase */}
        <ExamShowcase />
      </div>
    );
  }

  // ── Unauthenticated ──
  return (
    <div className="min-h-screen">
      {/* Hero */}
      <section className="bg-[#f5f5f0] py-20">
        <div className="max-w-3xl mx-auto px-4 text-center">
          <h1 className="text-4xl md:text-5xl font-bold text-foreground mb-5 leading-tight">
            Score Higher on the Digital SAT
          </h1>
          <p className="text-lg text-muted-foreground mb-3 max-w-2xl mx-auto leading-relaxed">
            Full-length adaptive mocks built to push you past 1500.
            Detailed score reports, domain-level analysis, and difficulty breakdowns
            that free alternatives don&apos;t offer.
          </p>
          <p className="text-sm text-muted-foreground mb-8">
            Also available for GRE, GMAT, and Ashoka.
          </p>
          <div className="flex gap-3 justify-center flex-wrap">
            <Button
              size="lg"
              className="bg-primary hover:bg-primary/90 text-white"
              onClick={() => router.push("/sat-free")}
            >
              Start with a Free Mock
              <ArrowRight className="ml-2 h-4 w-4" />
            </Button>
            <Button
              size="lg"
              variant="outline"
              className="border-primary text-primary hover:bg-primary hover:text-white"
              onClick={() => router.push("/tests")}
            >
              Explore All Tests
            </Button>
          </div>
        </div>
      </section>

      {/* Exam Showcase */}
      <ExamShowcase />

      {/* Why Preppeo */}
      <section className="py-16 bg-[#f5f5f0]">
        <div className="max-w-6xl mx-auto px-4">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-foreground mb-3">
              Why Preppeo?
            </h2>
            <p className="text-muted-foreground max-w-xl mx-auto">
              The features that serious scorers need — and free alternatives don&apos;t offer.
            </p>
          </div>
          <div className="grid md:grid-cols-3 gap-6">
            <Card className="text-center hover:shadow-md transition-shadow">
              <CardContent className="p-8">
                <div className="w-12 h-12 rounded-xl bg-primary/10 flex items-center justify-center mx-auto mb-4">
                  <TrendingUp className="w-6 h-6 text-primary" />
                </div>
                <h3 className="font-bold text-foreground text-lg mb-2">Adaptive Testing</h3>
                <p className="text-sm text-muted-foreground mb-4 leading-relaxed">
                  Module 2 adjusts to your Module 1 performance, just like test day.
                  No other free platform does this.
                </p>
                <Link
                  href="/sat-free"
                  className="text-sm font-medium text-primary hover:underline inline-flex items-center gap-1"
                >
                  Try it free <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </CardContent>
            </Card>

            <Card className="text-center hover:shadow-md transition-shadow">
              <CardContent className="p-8">
                <div className="w-12 h-12 rounded-xl bg-emerald-50 flex items-center justify-center mx-auto mb-4">
                  <ClipboardCheck className="w-6 h-6 text-emerald-600" />
                </div>
                <h3 className="font-bold text-foreground text-lg mb-2">Detailed Score Reports</h3>
                <p className="text-sm text-muted-foreground mb-4 leading-relaxed">
                  400–1600 scale with domain breakdown, difficulty analysis,
                  and question-level review after every test.
                </p>
                <Link
                  href="/tests"
                  className="text-sm font-medium text-primary hover:underline inline-flex items-center gap-1"
                >
                  View Test Hub <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </CardContent>
            </Card>

            <Card className="text-center hover:shadow-md transition-shadow">
              <CardContent className="p-8">
                <div className="w-12 h-12 rounded-xl bg-amber-50 flex items-center justify-center mx-auto mb-4">
                  <GraduationCap className="w-6 h-6 text-amber-600" />
                </div>
                <h3 className="font-bold text-foreground text-lg mb-2">Practice Mode</h3>
                <p className="text-sm text-muted-foreground mb-4 leading-relaxed">
                  Not ready for a full test? Practice by topic and difficulty
                  with instant feedback and explanations.
                </p>
                <Link
                  href="/sat-test"
                  className="text-sm font-medium text-primary hover:underline inline-flex items-center gap-1"
                >
                  Start practicing <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </CardContent>
            </Card>
          </div>
        </div>
      </section>

      {/* How It Works */}
      <section className="py-16 bg-white">
        <div className="max-w-4xl mx-auto px-4">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-foreground mb-3">
              How It Works
            </h2>
          </div>
          <div className="grid md:grid-cols-3 gap-8 text-center">
            <div>
              <div className="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center mx-auto mb-4 text-sm font-bold">
                1
              </div>
              <h3 className="font-semibold text-foreground mb-2">Choose Your Exam</h3>
              <p className="text-sm text-muted-foreground">
                Pick from SAT, GRE, GMAT, Ashoka, and more.
              </p>
            </div>
            <div>
              <div className="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center mx-auto mb-4 text-sm font-bold">
                2
              </div>
              <h3 className="font-semibold text-foreground mb-2">Claim Your Complimentary Mock</h3>
              <p className="text-sm text-muted-foreground">
                Your first full-length adaptive mock is on us — worth ₹499.
              </p>
            </div>
            <div>
              <div className="w-10 h-10 rounded-full bg-primary text-white flex items-center justify-center mx-auto mb-4 text-sm font-bold">
                3
              </div>
              <h3 className="font-semibold text-foreground mb-2">Review &amp; Improve</h3>
              <p className="text-sm text-muted-foreground">
                Get detailed results with domain breakdown, difficulty tiers, and question-level review.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 bg-primary">
        <div className="max-w-2xl mx-auto px-4 text-center">
          <h2 className="text-3xl font-bold text-white mb-4">
            Ready to set realistic expectations?
          </h2>
          <p className="text-white/80 mb-8">
            Your first full-length adaptive SAT mock is complimentary — worth ₹499.
          </p>
          <Button
            size="lg"
            className="bg-white hover:bg-gray-100 text-primary font-semibold"
            onClick={() => router.push("/sat-free")}
          >
            Start with a Free Mock
            <ArrowRight className="ml-2 h-4 w-4" />
          </Button>
        </div>
      </section>
    </div>
  );
}

"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import { Button } from "@/design-system/components/ui/button";
import { Card, CardContent } from "@/design-system/components/ui/card";
import {
  ArrowRight,
  CheckCircle,
  BookOpen,
  BarChart3,
  Sparkles,
  Loader2,
} from "lucide-react";
import type { TokenPackWithExam } from "@/types/test-tokens";

function formatINR(n: number) {
  return new Intl.NumberFormat("en-IN", {
    style: "currency",
    currency: "INR",
    maximumFractionDigits: 0,
  }).format(n);
}

const INCLUDED = [
  "Full-length, adaptive Digital SAT mock",
  "Real exam timing and module routing (M1 → M2)",
  "Instant score report with section breakdown",
  "Domain-level analytics to find weak spots",
  "AI concept breakdowns on every question",
];

export default function PricingPage() {
  const [packs, setPacks] = useState<TokenPackWithExam[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const res = await fetch("/api/mocks/packs");
        const json = await res.json();
        if (!active) return;
        const list = (json.data as TokenPackWithExam[] | undefined) ?? [];
        // SAT-only for now — GRE/GMAT pricing comes later.
        setPacks(list.filter((p) => p.is_active && p.exam_type === "sat"));
      } catch {
        if (active) setPacks([]);
      } finally {
        if (active) setLoading(false);
      }
    })();
    return () => {
      active = false;
    };
  }, []);

  return (
    <div className="bg-white">
      {/* Hero */}
      <section className="bg-gradient-to-b from-primary/5 to-white border-b border-gray-200">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24 text-center">
          <span className="inline-flex items-center gap-2 rounded-full bg-primary/10 text-primary px-4 py-1.5 text-sm font-medium mb-6">
            <Sparkles className="w-4 h-4" />
            Simple, pay-as-you-go pricing
          </span>
          <h1 className="text-4xl md:text-5xl font-bold text-foreground tracking-tight">
            Pay per mock. No subscription.
          </h1>
          <p className="mt-5 text-lg text-muted-foreground max-w-2xl mx-auto">
            Buy mock tokens whenever you need them. Each token unlocks one
            full-length adaptive test with a complete score report — no monthly
            fees, no expiry pressure.
          </p>
          <div className="mt-8 flex flex-wrap items-center justify-center gap-3">
            <Link href="/auth">
              <Button size="lg" variant="primary">
                Get started free <ArrowRight className="w-4 h-4 ml-2" />
              </Button>
            </Link>
            <Link href="/mocks">
              <Button size="lg" variant="outline">
                Browse mocks
              </Button>
            </Link>
          </div>
          <p className="mt-4 text-sm text-muted-foreground">
            Start with a free mock — no card required.
          </p>
        </div>
      </section>

      {/* Packs */}
      <section className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div className="text-center mb-10">
          <h2 className="text-2xl md:text-3xl font-bold text-foreground">
            Mock token packs
          </h2>
          <p className="mt-3 text-muted-foreground">
            The more you buy, the less you pay per mock.
          </p>
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-16 text-muted-foreground">
            <Loader2 className="w-6 h-6 animate-spin mr-2" />
            Loading current prices…
          </div>
        ) : packs.length === 0 ? (
          <div className="text-center py-16">
            <p className="text-muted-foreground">
              Pricing is being updated. Please check the store for live packs.
            </p>
            <Link href="/mocks/tokens" className="inline-block mt-4">
              <Button variant="outline">Go to token store</Button>
            </Link>
          </div>
        ) : (
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {packs.map((pack) => {
              const perMock =
                pack.token_count > 0 ? pack.price / pack.token_count : pack.price;
              return (
                <Card
                  key={pack.id}
                  className="flex flex-col hover:shadow-md transition-shadow"
                >
                  <CardContent className="p-6 flex flex-col flex-1">
                    <div className="text-sm font-medium text-primary uppercase tracking-wide">
                      {pack.exam_types?.name ?? "Mock"}
                    </div>
                    <h3 className="mt-1 text-lg font-bold text-foreground">
                      {pack.name}
                    </h3>
                    <div className="mt-4 flex items-baseline gap-1">
                      <span className="text-3xl font-bold text-foreground">
                        {formatINR(pack.price)}
                      </span>
                    </div>
                    <p className="mt-1 text-sm text-muted-foreground">
                      {pack.token_count} mock{pack.token_count > 1 ? "s" : ""} ·{" "}
                      {formatINR(Math.round(perMock))} per mock
                    </p>
                    <div className="mt-auto pt-6">
                      <Link href="/auth" className="block">
                        <Button variant="primary" className="w-full">
                          Choose plan
                        </Button>
                      </Link>
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        )}

        <p className="mt-6 text-center text-sm text-muted-foreground">
          Prices are charged in INR. Already have an account?{" "}
          <Link href="/mocks/tokens" className="text-primary hover:underline">
            Go to the token store
          </Link>
          .
        </p>
      </section>

      {/* What's included */}
      <section className="bg-gray-50 border-y border-gray-200">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
          <div className="grid md:grid-cols-2 gap-10 items-start">
            <div>
              <h2 className="text-2xl md:text-3xl font-bold text-foreground">
                Every mock includes
              </h2>
              <p className="mt-3 text-muted-foreground">
                One token, one complete test experience — built to mirror the real
                Digital SAT.
              </p>
            </div>
            <ul className="space-y-3">
              {INCLUDED.map((item) => (
                <li key={item} className="flex items-start gap-3">
                  <CheckCircle className="w-5 h-5 text-primary shrink-0 mt-0.5" />
                  <span className="text-foreground">{item}</span>
                </li>
              ))}
            </ul>
          </div>
        </div>
      </section>

      {/* Secondary CTAs */}
      <section className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div className="grid md:grid-cols-2 gap-6">
          <Card className="hover:shadow-md transition-shadow">
            <CardContent className="p-6">
              <BookOpen className="w-8 h-8 text-primary" />
              <h3 className="mt-4 font-bold text-foreground text-lg">
                New to the Digital SAT?
              </h3>
              <p className="mt-2 text-sm text-muted-foreground">
                Read our free SAT guide before you spend a rupee.
              </p>
              <Link href="/sat-guide" className="inline-block mt-4">
                <Button variant="outline">Read the SAT Guide</Button>
              </Link>
            </CardContent>
          </Card>
          <Card className="hover:shadow-md transition-shadow">
            <CardContent className="p-6">
              <BarChart3 className="w-8 h-8 text-primary" />
              <h3 className="mt-4 font-bold text-foreground text-lg">
                Running an institute?
              </h3>
              <p className="mt-2 text-sm text-muted-foreground">
                Bulk mock packs and partner commissions for coaching centres.
              </p>
              <Link href="/for-institutes" className="inline-block mt-4">
                <Button variant="outline">For Institutes</Button>
              </Link>
            </CardContent>
          </Card>
        </div>
      </section>
    </div>
  );
}

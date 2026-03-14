"use client";

import { useState } from "react";
import { Button } from "@/design-system/components/ui/button";
import {
  Card,
  CardContent,
} from "@/design-system/components/ui/card";
import {
  ArrowRight,
  Users,
  Wallet,
  GraduationCap,
  CheckCircle,
  Shield,
} from "lucide-react";
import Link from "next/link";

const institutePacks = [
  { mocks: 50, price: 29000, perMock: 580 },
  { mocks: 100, price: 46000, perMock: 460 },
  { mocks: 300, price: 100000, perMock: 333 },
  { mocks: 500, price: 125000, perMock: 250 },
];

function formatINR(n: number) {
  return new Intl.NumberFormat("en-IN", { style: "currency", currency: "INR", maximumFractionDigits: 0 }).format(n);
}

function EarningsCalculator() {
  const [students, setStudents] = useState(50);
  const [mocksPerStudent, setMocksPerStudent] = useState(3);

  const totalMocks = students * mocksPerStudent;
  const pricePerMock = 333;
  const commissionRate = 0.3;
  const totalRevenue = totalMocks * pricePerMock;
  const earnings = Math.round(totalRevenue * commissionRate);

  return (
    <Card className="hover:shadow-md transition-shadow">
      <CardContent className="p-6 md:p-8">
        <h3 className="font-bold text-foreground text-xl mb-6 text-center">Earnings Calculator</h3>

        <div className="grid md:grid-cols-2 gap-8">
          <div className="space-y-6">
            <div>
              <label className="block text-sm font-medium text-foreground mb-2">
                Number of students
              </label>
              <input
                type="range"
                min={10}
                max={500}
                step={10}
                value={students}
                onChange={(e) => setStudents(Number(e.target.value))}
                className="w-full accent-primary"
              />
              <div className="flex justify-between text-xs text-muted-foreground mt-1">
                <span>10</span>
                <span className="font-semibold text-foreground text-sm">{students}</span>
                <span>500</span>
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-foreground mb-2">
                Mocks per student
              </label>
              <input
                type="range"
                min={1}
                max={10}
                step={1}
                value={mocksPerStudent}
                onChange={(e) => setMocksPerStudent(Number(e.target.value))}
                className="w-full accent-primary"
              />
              <div className="flex justify-between text-xs text-muted-foreground mt-1">
                <span>1</span>
                <span className="font-semibold text-foreground text-sm">{mocksPerStudent}</span>
                <span>10</span>
              </div>
            </div>
          </div>

          <div className="flex flex-col items-center justify-center bg-primary/5 rounded-xl p-6">
            <p className="text-sm text-muted-foreground mb-1">Your estimated earnings</p>
            <p className="text-4xl font-bold text-primary mb-2">{formatINR(earnings)}</p>
            <p className="text-xs text-muted-foreground text-center">
              {totalMocks} mocks &times; {formatINR(pricePerMock)} &times; 30% commission
            </p>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}

export default function ForInstitutesPage() {
  return (
    <div className="min-h-screen">
      {/* Hero */}
      <section className="bg-[#f5f5f0] py-20">
        <div className="max-w-3xl mx-auto px-4 text-center">
          <div className="inline-flex items-center gap-2 bg-primary/10 text-primary text-sm font-medium px-4 py-1.5 rounded-full mb-6">
            <GraduationCap className="w-4 h-4" />
            Partner Program
          </div>
          <h1 className="text-4xl md:text-5xl font-bold text-foreground mb-5 leading-tight">
            Offer World-Class SAT Mocks to Your Students
          </h1>
          <p className="text-lg text-muted-foreground mb-8 max-w-2xl mx-auto leading-relaxed">
            Adaptive, timed, and scored — just like the real Digital SAT.
            We handle the tech. You earn commission on every purchase.
          </p>
          <div className="flex gap-3 justify-center flex-wrap">
            <Link href="/contact?subject=partnership">
              <Button size="lg" className="bg-primary hover:bg-primary/90 text-white">
                Become a Partner
                <ArrowRight className="ml-2 h-4 w-4" />
              </Button>
            </Link>
            <Link href="/mocks">
              <Button size="lg" variant="outline" className="border-primary text-primary hover:bg-primary hover:text-white">
                See the Mocks
              </Button>
            </Link>
          </div>
        </div>
      </section>

      {/* Problem / Solution */}
      <section className="py-16 bg-white">
        <div className="max-w-5xl mx-auto px-4">
          <div className="grid md:grid-cols-2 gap-12 items-center">
            <div>
              <h2 className="text-2xl font-bold text-foreground mb-4">The Problem</h2>
              <p className="text-muted-foreground leading-relaxed mb-4">
                Your students need realistic SAT practice, but building an adaptive mock platform
                is expensive and time-consuming. Free alternatives lack accuracy and analytics.
              </p>
              <ul className="space-y-2 text-sm text-muted-foreground">
                <li className="flex items-start gap-2"><span className="text-red-400 mt-0.5">&#x2717;</span> Free mocks aren&apos;t adaptive</li>
                <li className="flex items-start gap-2"><span className="text-red-400 mt-0.5">&#x2717;</span> No domain-level analytics</li>
                <li className="flex items-start gap-2"><span className="text-red-400 mt-0.5">&#x2717;</span> Building your own is 6+ months of dev</li>
              </ul>
            </div>
            <div>
              <h2 className="text-2xl font-bold text-foreground mb-4">The Solution</h2>
              <p className="text-muted-foreground leading-relaxed mb-4">
                Recommend Preppeo to your students. They get exam-realistic mocks with detailed score reports.
                You earn commission on every purchase — zero tech, zero upfront cost.
              </p>
              <ul className="space-y-2 text-sm text-muted-foreground">
                <li className="flex items-start gap-2"><CheckCircle className="w-4 h-4 text-emerald-500 mt-0.5 shrink-0" /> Fully adaptive (Module 2 adjusts to Module 1)</li>
                <li className="flex items-start gap-2"><CheckCircle className="w-4 h-4 text-emerald-500 mt-0.5 shrink-0" /> 400–1600 scoring with domain breakdown</li>
                <li className="flex items-start gap-2"><CheckCircle className="w-4 h-4 text-emerald-500 mt-0.5 shrink-0" /> Ready to use — set up in minutes</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      {/* How It Works */}
      <section className="py-16 bg-[#f5f5f0]">
        <div className="max-w-4xl mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-bold text-foreground mb-3">How It Works</h2>
            <p className="text-muted-foreground">Three steps to start earning</p>
          </div>
          <div className="grid md:grid-cols-3 gap-8">
            <Card className="text-center hover:shadow-md transition-shadow">
              <CardContent className="p-8">
                <div className="w-12 h-12 rounded-xl bg-primary/10 flex items-center justify-center mx-auto mb-4">
                  <Shield className="w-6 h-6 text-primary" />
                </div>
                <div className="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center mx-auto mb-3 text-sm font-bold">1</div>
                <h3 className="font-bold text-foreground mb-2">Get Your Partner Code</h3>
                <p className="text-sm text-muted-foreground">
                  Sign up as a partner. We&apos;ll assign you a unique referral code.
                </p>
              </CardContent>
            </Card>

            <Card className="text-center hover:shadow-md transition-shadow">
              <CardContent className="p-8">
                <div className="w-12 h-12 rounded-xl bg-emerald-50 flex items-center justify-center mx-auto mb-4">
                  <Users className="w-6 h-6 text-emerald-600" />
                </div>
                <div className="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center mx-auto mb-3 text-sm font-bold">2</div>
                <h3 className="font-bold text-foreground mb-2">Share with Students</h3>
                <p className="text-sm text-muted-foreground">
                  Students use your code at checkout and get 10% off. They see higher value from you.
                </p>
              </CardContent>
            </Card>

            <Card className="text-center hover:shadow-md transition-shadow">
              <CardContent className="p-8">
                <div className="w-12 h-12 rounded-xl bg-amber-50 flex items-center justify-center mx-auto mb-4">
                  <Wallet className="w-6 h-6 text-amber-600" />
                </div>
                <div className="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center mx-auto mb-3 text-sm font-bold">3</div>
                <h3 className="font-bold text-foreground mb-2">Earn 30% Commission</h3>
                <p className="text-sm text-muted-foreground">
                  Earn on every purchase your students make. Commissions are tracked and paid out periodically.
                </p>
              </CardContent>
            </Card>
          </div>
        </div>
      </section>

      {/* Institute Bulk Pricing */}
      <section className="py-16 bg-white">
        <div className="max-w-4xl mx-auto px-4">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-foreground mb-3">Institute Bulk Pricing</h2>
            <p className="text-muted-foreground max-w-xl mx-auto">
              Buy mocks in bulk at a lower per-mock cost. Distribute to your students directly.
            </p>
          </div>

          <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-4">
            {institutePacks.map((pack) => (
              <Card key={pack.mocks} className="hover:shadow-md transition-shadow text-center">
                <CardContent className="p-6">
                  <p className="text-3xl font-bold text-foreground mb-1">{pack.mocks}</p>
                  <p className="text-sm text-muted-foreground mb-4">Mocks</p>
                  <p className="text-xl font-bold text-primary mb-1">{formatINR(pack.price)}</p>
                  <p className="text-xs text-muted-foreground">{formatINR(pack.perMock)}/mock</p>
                </CardContent>
              </Card>
            ))}
          </div>

          <p className="text-center text-sm text-muted-foreground mt-6">
            Need a custom pack size? <Link href="/contact" className="text-primary hover:underline">Contact us</Link>.
          </p>
        </div>
      </section>

      {/* Earnings Calculator */}
      <section className="py-16 bg-[#f5f5f0]">
        <div className="max-w-3xl mx-auto px-4">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-foreground mb-3">How Much Can You Earn?</h2>
            <p className="text-muted-foreground">
              Drag the sliders to estimate your commission earnings.
            </p>
          </div>
          <EarningsCalculator />
        </div>
      </section>

      {/* Final CTA */}
      <section className="py-16 bg-primary">
        <div className="max-w-2xl mx-auto px-4 text-center">
          <h2 className="text-3xl font-bold text-white mb-4">
            Ready to Partner with Preppeo?
          </h2>
          <p className="text-white/80 mb-8">
            Zero upfront cost. Zero tech overhead. Start earning from day one.
          </p>
          <div className="flex gap-3 justify-center flex-wrap">
            <Link href="/contact?subject=partnership">
              <Button size="lg" className="bg-white hover:bg-gray-100 text-primary font-semibold">
                Become a Partner
                <ArrowRight className="ml-2 h-4 w-4" />
              </Button>
            </Link>
            <Link href="/mocks">
              <Button size="lg" className="bg-white/20 border-2 border-white text-white hover:bg-white hover:text-primary font-semibold">
                See the Mocks First
              </Button>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}

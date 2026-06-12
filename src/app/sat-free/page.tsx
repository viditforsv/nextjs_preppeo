'use client';

import { useState, useEffect, useCallback } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import {
  GraduationCap,
  Clock,
  BarChart3,
  CheckCircle2,
  Loader2,
  ChevronRight,
  Gift,
  Copy,
  Check,
} from 'lucide-react';

export default function SATFreeMockPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { user, loading: authLoading } = useAuth();

  const refParam = searchParams.get('ref') || '';

  const [phase, setPhase] = useState<'hero' | 'claiming'>('hero');
  const [formError, setFormError] = useState('');

  // Referral share state (for logged-in users)
  const [myReferralCode, setMyReferralCode] = useState('');
  const [copied, setCopied] = useState(false);

  // Persist ref code across OAuth redirect
  useEffect(() => {
    if (refParam) {
      sessionStorage.setItem('sat-free-ref', refParam);
    }
  }, [refParam]);

  // Fetch the logged-in user's own referral code
  useEffect(() => {
    if (user) {
      fetch('/api/referral/student/code')
        .then((r) => r.json())
        .then((d) => { if (d.code) setMyReferralCode(d.code); })
        .catch(() => {});
    }
  }, [user]);

  const getStoredRef = useCallback(() => {
    return refParam || sessionStorage.getItem('sat-free-ref') || '';
  }, [refParam]);

  const claimAndRedirect = useCallback(async () => {
    try {
      const referralCode = getStoredRef();
      const res = await fetch('/api/mocks/claim-free', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ examType: 'sat', ...(referralCode ? { referralCode } : {}) }),
      });
      const data = await res.json();
      sessionStorage.removeItem('sat-free-ref');
      if (data.success) {
        router.push(`/sat-test?token=${encodeURIComponent(data.code)}`);
      } else {
        setFormError(data.error || 'Failed to claim free mock. Please try again.');
        setPhase('hero');
      }
    } catch {
      setFormError('Something went wrong. Please try again.');
      setPhase('hero');
    }
  }, [getStoredRef, router]);

  // If already logged in and they click CTA, go straight to claiming
  useEffect(() => {
    if (phase === 'claiming' && user) {
      void claimAndRedirect();
    }
  }, [phase, user, claimAndRedirect]);

  function copyReferralLink() {
    const link = `${window.location.origin}/sat-free?ref=${myReferralCode}`;
    navigator.clipboard.writeText(link);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  }

  function handleCTAClick() {
    if (user) {
      // Logged in — claim the free token and jump straight into the test.
      setPhase('claiming');
    } else {
      // Anonymous — start the free mock immediately, no account required.
      // Account creation happens at the end to unlock the full report.
      router.push('/sat-test?freemock=1');
    }
  }

  if (phase === 'claiming') {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="w-8 h-8 animate-spin text-[#0d47a1] mx-auto mb-4" />
          <p className="text-gray-600 font-medium">Setting up your free mock test...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      {/* Hero Section */}
      <section className="max-w-5xl mx-auto px-4 pt-16 pb-12">
        <div className="grid lg:grid-cols-2 gap-12 items-center">
          {/* Left — Copy */}
          <div>
            {getStoredRef() && !user && (
              <div className="flex items-center gap-2 bg-emerald-50 border border-emerald-200 text-emerald-800 text-sm font-medium px-4 py-2.5 rounded-lg mb-4">
                <Gift className="w-4 h-4 shrink-0" />
                You were referred by a friend — you&apos;ll both get a bonus mock!
              </div>
            )}

            <div className="inline-flex items-center gap-2 bg-[#0d47a1]/10 text-[#0d47a1] text-sm font-semibold px-3 py-1.5 rounded-full mb-6">
              <GraduationCap className="w-4 h-4" />
              Free Full-Length Mock
            </div>

            <h1 className="text-4xl lg:text-5xl font-bold text-[#1a365d] leading-tight mb-4">
              Your First<br />
              <span className="text-[#0d47a1]">Digital SAT</span><br />
              Mock Is On Us
            </h1>

            <p className="text-lg text-gray-600 mb-2 max-w-md">
              The same adaptive, timed experience our paid users get — yours free to set realistic expectations.
            </p>
            <p className="text-sm text-gray-500 mb-8 max-w-md">
              Go beyond Khan Academy. Our adaptive Module 2, difficulty tiers, and domain-level analysis give you the edge for 1500+.
            </p>

            <ul className="space-y-3 mb-8">
              {[
                '54 questions across Reading & Writing + Math',
                'Adaptive difficulty — mirrors the real Digital SAT',
                'Timed sections with built-in breaks',
                'Instant score report with 400–1600 scale + domain breakdown',
              ].map((item) => (
                <li key={item} className="flex items-start gap-2 text-gray-700">
                  <CheckCircle2 className="w-5 h-5 text-emerald-500 shrink-0 mt-0.5" />
                  <span>{item}</span>
                </li>
              ))}
            </ul>

            <button
              onClick={handleCTAClick}
              disabled={authLoading}
              className="inline-flex items-center gap-2 px-8 py-4 bg-[#0d47a1] text-white text-lg font-semibold rounded-xl hover:bg-[#1565c0] transition-colors shadow-lg hover:shadow-xl"
            >
              Start Your Free Mock
              <ChevronRight className="w-5 h-5" />
            </button>

            {formError && (
              <p className="mt-3 text-sm text-red-600">{formError}</p>
            )}
          </div>

          {/* Right — Referral Card (logged in) or Feature Card */}
          <div>
            {user && myReferralCode ? (
              <div className="bg-white rounded-2xl border border-gray-200 shadow-lg p-8">
                <div className="flex items-center gap-3 mb-4">
                  <div className="w-10 h-10 rounded-lg bg-emerald-100 flex items-center justify-center">
                    <Gift className="w-5 h-5 text-emerald-600" />
                  </div>
                  <div>
                    <h3 className="text-lg font-bold text-[#1a365d]">Refer a Friend</h3>
                    <p className="text-sm text-gray-500">You both get a bonus mock</p>
                  </div>
                </div>
                <div className="bg-gray-50 border border-gray-200 rounded-lg p-3 flex items-center justify-between mb-3">
                  <code className="text-sm font-mono font-semibold text-[#0d47a1]">{myReferralCode}</code>
                  <button
                    onClick={copyReferralLink}
                    className="flex items-center gap-1.5 text-xs font-medium text-gray-600 hover:text-[#0d47a1] transition-colors"
                  >
                    {copied ? <Check className="w-3.5 h-3.5 text-emerald-500" /> : <Copy className="w-3.5 h-3.5" />}
                    {copied ? 'Copied!' : 'Copy Link'}
                  </button>
                </div>
                <p className="text-xs text-gray-500">
                  Share your referral link. When a friend signs up and claims their free mock, you both get an extra mock test.
                </p>
              </div>
            ) : (
              <div className="bg-white rounded-2xl border border-gray-200 shadow-lg p-8">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="text-lg font-bold text-[#1a365d]">What you&apos;ll get</h3>
                  <span className="text-xs font-bold bg-[#0d47a1]/10 text-[#0d47a1] px-2.5 py-1 rounded-full">Free</span>
                </div>
                <div className="space-y-4">
                  {[
                    { icon: Clock, title: '2 hours 14 minutes', desc: 'Full-length timed mock with adaptive sections' },
                    { icon: BarChart3, title: 'Instant Score Report', desc: 'SAT scale (400–1600) with domain breakdown' },
                    { icon: GraduationCap, title: 'Real Exam Experience', desc: 'Same format, difficulty, and interface as test day' },
                  ].map(({ icon: Icon, title, desc }) => (
                    <div key={title} className="flex gap-4 items-start">
                      <div className="w-10 h-10 rounded-lg bg-[#0d47a1]/10 flex items-center justify-center shrink-0">
                        <Icon className="w-5 h-5 text-[#0d47a1]" />
                      </div>
                      <div>
                        <p className="font-semibold text-gray-900">{title}</p>
                        <p className="text-sm text-gray-500">{desc}</p>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="bg-white border-t border-gray-200 py-16">
        <div className="max-w-5xl mx-auto px-4">
          <h2 className="text-2xl font-bold text-[#1a365d] text-center mb-3">
            Beyond what free alternatives offer
          </h2>
          <p className="text-center text-gray-500 text-sm mb-10 max-w-lg mx-auto">
            Khan Academy is a great starting point, but it can&apos;t train you for 1600. Preppeo&apos;s mocks are designed for serious scorers.
          </p>
          <div className="grid sm:grid-cols-3 gap-8">
            {[
              {
                title: 'Adaptive Module 2',
                desc: 'Difficulty adjusts based on your Module 1 performance — the exact mechanism used on test day.',
              },
              {
                title: 'Domain-Level Analytics',
                desc: 'See your performance by domain, difficulty tier, and question type — not just a total score.',
              },
              {
                title: 'Unique Question Sets',
                desc: 'Each paid mock uses a unique question bank. Practice with volume to stabilize your score.',
              },
            ].map(({ title, desc }) => (
              <div key={title} className="text-center">
                <h3 className="font-bold text-gray-900 mb-2">{title}</h3>
                <p className="text-sm text-gray-600 leading-relaxed">{desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}

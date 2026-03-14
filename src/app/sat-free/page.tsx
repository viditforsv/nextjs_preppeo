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
  Mail,
  Lock,
  User,
  ChevronRight,
  Gift,
  Copy,
  Check,
} from 'lucide-react';
const SAT_DATE_OPTIONS = [
  'Within 1 month',
  '1–3 months',
  '3–6 months',
  '6+ months',
  'Just exploring',
] as const;

export default function SATFreeMockPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { user, loading: authLoading, signUp, signInWithGoogle } = useAuth();

  const refParam = searchParams.get('ref') || '';

  const [phase, setPhase] = useState<'hero' | 'signup' | 'claiming'>('hero');
  const [satDate, setSatDate] = useState('');

  // Signup form
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [formError, setFormError] = useState('');
  const [formLoading, setFormLoading] = useState(false);

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

  // If already logged in and they click CTA, go straight to claiming
  useEffect(() => {
    if (phase === 'claiming' && user) {
      claimAndRedirect();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [phase, user]);

  async function claimAndRedirect() {
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
  }

  function copyReferralLink() {
    const link = `${window.location.origin}/sat-free?ref=${myReferralCode}`;
    navigator.clipboard.writeText(link);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  }

  function handleCTAClick() {
    if (user) {
      setPhase('claiming');
    } else {
      setPhase('signup');
    }
  }

  async function handleEmailSignup(e: React.FormEvent) {
    e.preventDefault();
    setFormLoading(true);
    setFormError('');

    try {
      const fullName = `${firstName} ${lastName}`.trim();
      await signUp(email, password, fullName, 'student');
      setPhase('claiming');
    } catch (err) {
      setFormError(err instanceof Error ? err.message : 'Signup failed');
    } finally {
      setFormLoading(false);
    }
  }

  async function handleGoogleSignup() {
    setFormLoading(true);
    setFormError('');
    try {
      sessionStorage.setItem('sat-free-claim', '1');
      await signInWithGoogle('/sat-free');
    } catch (err) {
      setFormError(err instanceof Error ? err.message : 'Google signup failed');
      setFormLoading(false);
    }
  }

  // After Google OAuth redirect, auto-claim if signup was initiated from this page
  useEffect(() => {
    if (!authLoading && user && phase === 'hero') {
      const pending = sessionStorage.getItem('sat-free-claim');
      if (pending) {
        sessionStorage.removeItem('sat-free-claim');
        setPhase('claiming');
      }
    }
  }, [authLoading, user, phase]);

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
              Complimentary Mock — Worth ₹499
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

            {phase === 'hero' && (
              <button
                onClick={handleCTAClick}
                disabled={authLoading}
                className="inline-flex items-center gap-2 px-8 py-4 bg-[#0d47a1] text-white text-lg font-semibold rounded-xl hover:bg-[#1565c0] transition-colors shadow-lg hover:shadow-xl"
              >
                Start Your Free Mock
                <ChevronRight className="w-5 h-5" />
              </button>
            )}

            {formError && phase === 'hero' && (
              <p className="mt-3 text-sm text-red-600">{formError}</p>
            )}
          </div>

          {/* Right — Signup Form or Feature Card */}
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
            ) : phase === 'signup' ? (
              <div className="bg-white rounded-2xl border border-gray-200 shadow-lg p-8">
                <h2 className="text-xl font-bold text-[#1a365d] mb-1">Create your free account</h2>
                <p className="text-sm text-gray-500 mb-6">Sign up to start your SAT mock test</p>

                {/* Google OAuth */}
                <button
                  type="button"
                  onClick={handleGoogleSignup}
                  disabled={formLoading}
                  className="w-full flex items-center justify-center gap-3 px-4 py-3 bg-white border border-gray-200 rounded-lg hover:bg-gray-50 text-gray-700 font-medium transition-colors mb-4"
                >
                  <svg className="h-5 w-5" viewBox="0 0 24 24">
                    <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" />
                    <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" />
                    <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" />
                    <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" />
                  </svg>
                  Continue with Google
                </button>

                <div className="relative my-5">
                  <div className="absolute inset-0 flex items-center">
                    <span className="w-full border-t border-gray-200" />
                  </div>
                  <div className="relative flex justify-center text-xs uppercase">
                    <span className="bg-white px-2 text-gray-400">or sign up with email</span>
                  </div>
                </div>

                <form onSubmit={handleEmailSignup} className="space-y-3">
                  <div className="grid grid-cols-2 gap-3">
                    <div>
                      <label htmlFor="sf-first" className="text-xs font-medium text-gray-600 mb-1 block">First Name</label>
                      <div className="relative">
                        <User className="absolute left-3 top-2.5 h-4 w-4 text-gray-400" />
                        <input
                          id="sf-first"
                          type="text"
                          required
                          value={firstName}
                          onChange={(e) => setFirstName(e.target.value)}
                          placeholder="First name"
                          className="w-full pl-9 pr-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1]"
                        />
                      </div>
                    </div>
                    <div>
                      <label htmlFor="sf-last" className="text-xs font-medium text-gray-600 mb-1 block">Last Name</label>
                      <div className="relative">
                        <User className="absolute left-3 top-2.5 h-4 w-4 text-gray-400" />
                        <input
                          id="sf-last"
                          type="text"
                          required
                          value={lastName}
                          onChange={(e) => setLastName(e.target.value)}
                          placeholder="Last name"
                          className="w-full pl-9 pr-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1]"
                        />
                      </div>
                    </div>
                  </div>

                  <div>
                    <label htmlFor="sf-email" className="text-xs font-medium text-gray-600 mb-1 block">Email</label>
                    <div className="relative">
                      <Mail className="absolute left-3 top-2.5 h-4 w-4 text-gray-400" />
                      <input
                        id="sf-email"
                        type="email"
                        required
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        placeholder="you@example.com"
                        className="w-full pl-9 pr-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1]"
                      />
                    </div>
                  </div>

                  <div>
                    <label htmlFor="sf-pass" className="text-xs font-medium text-gray-600 mb-1 block">Password</label>
                    <div className="relative">
                      <Lock className="absolute left-3 top-2.5 h-4 w-4 text-gray-400" />
                      <input
                        id="sf-pass"
                        type="password"
                        required
                        minLength={6}
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        placeholder="Min. 6 characters"
                        className="w-full pl-9 pr-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1]"
                      />
                    </div>
                  </div>

                  <div>
                    <label htmlFor="sf-date" className="text-xs font-medium text-gray-600 mb-1 block">When are you planning to take the SAT?</label>
                    <select
                      id="sf-date"
                      value={satDate}
                      onChange={(e) => setSatDate(e.target.value)}
                      className="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1] bg-white text-gray-700"
                    >
                      <option value="">Select...</option>
                      {SAT_DATE_OPTIONS.map((opt) => (
                        <option key={opt} value={opt}>{opt}</option>
                      ))}
                    </select>
                  </div>

                  {formError && (
                    <p className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-lg p-2 text-center">{formError}</p>
                  )}

                  <button
                    type="submit"
                    disabled={formLoading}
                    className="w-full flex items-center justify-center gap-2 py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] transition-colors disabled:opacity-50"
                  >
                    {formLoading ? (
                      <Loader2 className="w-4 h-4 animate-spin" />
                    ) : (
                      <>
                        Create Account & Start Mock
                        <ChevronRight className="w-4 h-4" />
                      </>
                    )}
                  </button>

                  <p className="text-xs text-gray-400 text-center">
                    Already have an account?{' '}
                    <a href="/auth?redirect=/sat-free" className="text-[#0d47a1] hover:underline">Sign in</a>
                  </p>
                </form>
              </div>
            ) : (
              <div className="bg-white rounded-2xl border border-gray-200 shadow-lg p-8">
                <div className="flex items-center justify-between mb-4">
                  <h3 className="text-lg font-bold text-[#1a365d]">What you&apos;ll get</h3>
                  <span className="text-xs font-bold bg-[#0d47a1]/10 text-[#0d47a1] px-2.5 py-1 rounded-full">Worth ₹499</span>
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

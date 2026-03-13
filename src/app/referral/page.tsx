'use client';

import { useState, useEffect } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { Gift, Copy, Check, Users, Zap, ArrowRight } from 'lucide-react';
import Link from 'next/link';

export default function ReferralPage() {
  const { user } = useAuth();
  const [referralCode, setReferralCode] = useState('');
  const [copied, setCopied] = useState(false);
  const [referralCount, setReferralCount] = useState<number | null>(null);

  useEffect(() => {
    if (!user) return;

    fetch('/api/referral/student/code')
      .then((r) => r.json())
      .then((d) => {
        if (d.code) setReferralCode(d.code);
      })
      .catch(() => {});

    fetch('/api/referral/student/stats')
      .then((r) => r.json())
      .then((d) => {
        if (typeof d.count === 'number') setReferralCount(d.count);
      })
      .catch(() => {});
  }, [user]);

  function copyLink() {
    const link = `${window.location.origin}/sat-free?ref=${referralCode}`;
    navigator.clipboard.writeText(link);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  }

  if (!user) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center px-4">
        <div className="text-center max-w-md">
          <Gift className="w-12 h-12 text-[#0d47a1] mx-auto mb-4" />
          <h1 className="text-2xl font-bold text-[#1a365d] mb-2">Refer & Earn</h1>
          <p className="text-gray-600 mb-6">Sign in to access your referral code and start earning free mocks.</p>
          <Link
            href="/auth?redirect=/referral"
            className="inline-flex items-center gap-2 px-6 py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] transition-colors"
          >
            Sign In
            <ArrowRight className="w-4 h-4" />
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="max-w-3xl mx-auto px-4 py-12">
        {/* Header */}
        <div className="text-center mb-10">
          <div className="inline-flex items-center justify-center w-14 h-14 rounded-xl bg-emerald-100 mb-4">
            <Gift className="w-7 h-7 text-emerald-600" />
          </div>
          <h1 className="text-3xl font-bold text-[#1a365d] mb-2">Refer & Earn</h1>
          <p className="text-gray-600 max-w-md mx-auto">
            Share Preppeo with friends. When they sign up and claim their free mock, you both get a bonus mock test.
          </p>
        </div>

        {/* Referral Code Card */}
        <div className="bg-white border border-gray-200 rounded-xl p-6 mb-6 shadow-sm">
          <h2 className="text-sm font-semibold text-gray-500 uppercase tracking-wide mb-3">Your Referral Code</h2>
          <div className="flex flex-col sm:flex-row items-start sm:items-center gap-4">
            <div className="bg-[#0d47a1]/5 border border-[#0d47a1]/20 rounded-lg px-5 py-3">
              <code className="text-xl font-mono font-bold text-[#0d47a1] tracking-wider">{referralCode || '...'}</code>
            </div>
            <button
              onClick={copyLink}
              disabled={!referralCode}
              className="inline-flex items-center gap-2 px-5 py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] transition-colors disabled:opacity-50"
            >
              {copied ? <Check className="w-4 h-4" /> : <Copy className="w-4 h-4" />}
              {copied ? 'Link Copied!' : 'Copy Referral Link'}
            </button>
          </div>
          <p className="text-sm text-gray-500 mt-3">
            Your friend can visit this link to sign up and claim their free mock. The referral is tracked automatically.
          </p>
        </div>

        {/* Stats */}
        {referralCount !== null && (
          <div className="bg-white border border-gray-200 rounded-xl p-6 mb-6 shadow-sm">
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 rounded-lg bg-emerald-100 flex items-center justify-center">
                <Users className="w-6 h-6 text-emerald-600" />
              </div>
              <div>
                <p className="text-2xl font-bold text-[#1a365d]">{referralCount}</p>
                <p className="text-sm text-gray-500">
                  {referralCount === 1 ? 'Friend referred' : 'Friends referred'}
                </p>
              </div>
            </div>
          </div>
        )}

        {/* How It Works */}
        <div className="bg-white border border-gray-200 rounded-xl p-6 shadow-sm">
          <h2 className="text-lg font-bold text-[#1a365d] mb-4">How It Works</h2>
          <div className="space-y-4">
            {[
              {
                step: '1',
                title: 'Share your link',
                desc: 'Copy your referral link and send it to a friend preparing for the SAT.',
              },
              {
                step: '2',
                title: 'Friend signs up',
                desc: 'Your friend creates an account and claims their complimentary mock test.',
              },
              {
                step: '3',
                title: 'You both earn a bonus mock',
                desc: 'Once they claim their free mock, you and your friend each get an additional mock test — completely free.',
              },
            ].map(({ step, title, desc }) => (
              <div key={step} className="flex gap-4">
                <div className="w-8 h-8 rounded-full bg-[#0d47a1] text-white flex items-center justify-center text-sm font-bold shrink-0">
                  {step}
                </div>
                <div>
                  <p className="font-semibold text-gray-900">{title}</p>
                  <p className="text-sm text-gray-600">{desc}</p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Bottom CTA */}
        <div className="mt-8 text-center">
          <div className="inline-flex items-center gap-2 text-sm text-gray-500">
            <Zap className="w-4 h-4 text-amber-500" />
            No limit on referrals — the more you share, the more you earn.
          </div>
        </div>
      </div>
    </div>
  );
}

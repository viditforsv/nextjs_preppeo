'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { ArrowRight, Copy, Check, Gift } from 'lucide-react';
import type { ResultsConfig } from './results-types';

interface Props {
  config: ResultsConfig;
}

export default function ResultsShell({ config }: Props) {
  const { title, subtitle, headerColor, accentColor, headerActions, tabs, ctas, referralPath } = config;
  const [activeTab, setActiveTab] = useState(tabs[0]?.id ?? '');
  const [referralCode, setReferralCode] = useState('');
  const [refCopied, setRefCopied] = useState(false);

  useEffect(() => {
    if (!referralPath) return;
    fetch('/api/referral/student/code')
      .then((r) => r.json())
      .then((d) => { if (d.code) setReferralCode(d.code); })
      .catch(() => {});
  }, [referralPath]);

  function copyReferralLink() {
    if (!referralPath) return;
    const link = `${window.location.origin}${referralPath}?ref=${referralCode}`;
    navigator.clipboard.writeText(link);
    setRefCopied(true);
    setTimeout(() => setRefCopied(false), 2000);
  }

  const currentTab = tabs.find((t) => t.id === activeTab);

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      {/* Header */}
      <div className="text-white px-4 py-4" style={{ backgroundColor: headerColor }}>
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div>
              <h1 className="text-lg font-bold">{title}</h1>
              {subtitle && <p className="text-xs text-white/70">{subtitle}</p>}
            </div>
          </div>
          <div className="flex items-center gap-2">
            {headerActions.map((action) => {
              const Icon = action.icon;
              if (action.href) {
                return (
                  <Link
                    key={action.label}
                    href={action.href}
                    className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
                  >
                    <Icon className="w-3.5 h-3.5" />
                    {action.label}
                  </Link>
                );
              }
              return (
                <button
                  key={action.label}
                  onClick={action.onClick}
                  className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
                >
                  <Icon className="w-3.5 h-3.5" />
                  {action.label}
                </button>
              );
            })}
          </div>
        </div>
      </div>

      {/* Tabs */}
      <div className="bg-white border-b border-gray-200 sticky top-0 z-10">
        <div className="max-w-4xl mx-auto flex overflow-x-auto">
          {tabs.map((tab) => {
            const Icon = tab.icon;
            const isActive = activeTab === tab.id;
            return (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`flex items-center gap-1.5 px-4 py-3 text-sm font-medium border-b-2 whitespace-nowrap transition-colors ${
                  isActive
                    ? `text-[${accentColor}]`
                    : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                }`}
                style={isActive ? { borderColor: accentColor, color: accentColor } : undefined}
              >
                <Icon className="w-4 h-4" />
                {tab.label}
              </button>
            );
          })}
        </div>
      </div>

      {/* Content */}
      <div className="max-w-4xl mx-auto p-4">
        {currentTab?.render()}

        {/* CTAs */}
        {ctas?.map((cta, i) => {
          const Icon = cta.icon;
          return (
            <div key={i} className="mt-8 rounded-xl p-6 text-white" style={{ background: cta.gradient }}>
              <div className="flex items-start gap-4">
                <div className="w-10 h-10 rounded-lg bg-white/20 flex items-center justify-center shrink-0">
                  <Icon className="w-5 h-5" />
                </div>
                <div className="flex-1">
                  <h3 className="text-lg font-bold mb-1">{cta.title}</h3>
                  <p className="text-white/80 text-sm mb-4">{cta.description}</p>
                  <Link
                    href={cta.href}
                    className="inline-flex items-center gap-2 px-5 py-2.5 bg-white font-semibold text-sm rounded-lg hover:bg-white/90 transition-colors"
                    style={{ color: headerColor }}
                  >
                    {cta.buttonLabel}
                    <ArrowRight className="w-4 h-4" />
                  </Link>
                </div>
              </div>
            </div>
          );
        })}

        {/* Referral */}
        {referralCode && referralPath && (
          <div className="mt-4 bg-white border border-gray-200 rounded-xl p-6">
            <div className="flex items-start gap-4">
              <div className="w-10 h-10 rounded-lg bg-emerald-100 flex items-center justify-center shrink-0">
                <Gift className="w-5 h-5 text-emerald-600" />
              </div>
              <div className="flex-1">
                <h3 className="text-lg font-bold text-[#1a365d] mb-1">Share with a Friend</h3>
                <p className="text-sm text-gray-600 mb-3">
                  Refer a friend and you both get a bonus mock test — free.
                </p>
                <div className="flex items-center gap-3">
                  <div className="bg-gray-50 border border-gray-200 rounded-lg px-3 py-2 flex items-center gap-2">
                    <code className="text-sm font-mono font-semibold" style={{ color: accentColor }}>{referralCode}</code>
                  </div>
                  <button
                    onClick={copyReferralLink}
                    className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium text-white rounded-lg transition-colors"
                    style={{ backgroundColor: accentColor }}
                  >
                    {refCopied ? <Check className="w-3.5 h-3.5" /> : <Copy className="w-3.5 h-3.5" />}
                    {refCopied ? 'Copied!' : 'Copy Link'}
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

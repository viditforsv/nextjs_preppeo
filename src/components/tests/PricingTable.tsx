'use client';

import { Loader2, Sparkles, BookOpen, ClipboardList, Building2 } from 'lucide-react';
import type { CurrencyCode } from '@/lib/currency';
import { formatPrice } from '@/lib/currency';
import type { TokenPackWithExam } from '@/types/test-tokens';

interface SubscriptionPlan {
  id: string;
  name: string;
  plan_type: 'practice_only' | 'bundle';
  duration_days: number;
  mock_tokens_included: number;
  price: number;
  exam_type: string;
}

type PricingRow =
  | { kind: 'plan'; plan: SubscriptionPlan }
  | { kind: 'pack'; pack: TokenPackWithExam };

interface PricingTableProps {
  plans: SubscriptionPlan[];
  packs: TokenPackWithExam[];
  currency: CurrencyCode;
  referralCode: string | null;
  discountRate: number;
  buyingId: string | null;
  onBuyPlan: (planId: string) => void;
  onBuyPack: (packId: string) => void;
}

function applyDiscount(price: number, rate: number): number {
  return Number((price * (1 - rate / 100)).toFixed(2));
}

export default function PricingTable({
  plans,
  packs,
  currency,
  referralCode,
  discountRate,
  buyingId,
  onBuyPlan,
  onBuyPack,
}: PricingTableProps) {
  const hasDiscount = !!referralCode && discountRate > 0;

  const b2cPacks = packs.filter((p) => p.token_count < 50);
  const b2bPacks = packs.filter((p) => p.token_count >= 50);

  const bundlePlans = plans.filter((p) => p.plan_type === 'bundle');
  const practicePlans = plans.filter((p) => p.plan_type === 'practice_only');

  const rows: (PricingRow | 'separator-mocks' | 'separator-institute')[] = [];

  for (const p of bundlePlans) rows.push({ kind: 'plan', plan: p });
  for (const p of practicePlans) rows.push({ kind: 'plan', plan: p });

  if (b2cPacks.length > 0) {
    if (rows.length > 0) rows.push('separator-mocks');
    for (const p of b2cPacks.sort((a, b) => b.token_count - a.token_count)) {
      rows.push({ kind: 'pack', pack: p });
    }
  }

  if (b2bPacks.length > 0) {
    rows.push('separator-institute');
    for (const p of b2bPacks.sort((a, b) => a.token_count - b.token_count)) {
      rows.push({ kind: 'pack', pack: p });
    }
  }

  return (
    <div className="bg-white border border-gray-200 rounded-xl overflow-hidden">
      {/* Desktop table */}
      <div className="hidden sm:block">
        <table className="w-full text-sm">
          <thead>
            <tr className="border-b border-gray-100 bg-gray-50/50">
              <th className="text-left py-3 px-5 font-semibold text-gray-500 text-xs uppercase tracking-wide">Plan</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-500 text-xs uppercase tracking-wide">Includes</th>
              <th className="text-left py-3 px-4 font-semibold text-gray-500 text-xs uppercase tracking-wide">Duration</th>
              <th className="text-right py-3 px-4 font-semibold text-gray-500 text-xs uppercase tracking-wide">Price</th>
              <th className="py-3 px-5"></th>
            </tr>
          </thead>
          <tbody>
            {rows.map((row, i) => {
              if (row === 'separator-mocks') {
                return (
                  <tr key={`sep-mocks-${i}`}>
                    <td colSpan={5} className="px-5 pt-4 pb-2">
                      <div className="flex items-center gap-2 text-xs font-semibold text-gray-400 uppercase tracking-wide">
                        <ClipboardList className="w-3.5 h-3.5" />
                        Mock Packs
                      </div>
                    </td>
                  </tr>
                );
              }
              if (row === 'separator-institute') {
                return (
                  <tr key={`sep-inst-${i}`}>
                    <td colSpan={5} className="px-5 pt-4 pb-2">
                      <div className="flex items-center gap-2 text-xs font-semibold text-gray-400 uppercase tracking-wide">
                        <Building2 className="w-3.5 h-3.5" />
                        Institute Packs
                      </div>
                    </td>
                  </tr>
                );
              }

              if (row.kind === 'plan') {
                const p = row.plan;
                const isBundle = p.plan_type === 'bundle';
                const months = Math.round(p.duration_days / 30);
                const price = hasDiscount ? applyDiscount(p.price, discountRate) : p.price;
                const isBuying = buyingId === `plan-${p.id}`;

                return (
                  <tr key={p.id} className={`border-b border-gray-50 hover:bg-gray-50/50 transition-colors ${isBundle ? 'bg-[#0d47a1]/2' : ''}`}>
                    <td className="py-3 px-5">
                      <div className="flex items-center gap-2">
                        <span className="font-semibold text-gray-900">{p.name}</span>
                        {isBundle && (
                          <span className="inline-flex items-center gap-1 px-1.5 py-0.5 bg-[#0d47a1]/10 text-[#0d47a1] text-[10px] font-bold rounded">
                            <Sparkles className="w-2.5 h-2.5" />
                            Best Value
                          </span>
                        )}
                      </div>
                    </td>
                    <td className="py-3 px-4">
                      <div className="flex flex-wrap gap-1.5">
                        <span className="inline-flex items-center gap-1 text-xs text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full">
                          <BookOpen className="w-3 h-3" />
                          2500+ Questions
                        </span>
                        {isBundle && p.mock_tokens_included > 0 && (
                          <span className="inline-flex items-center gap-1 text-xs text-[#0d47a1] bg-[#0d47a1]/10 px-2 py-0.5 rounded-full">
                            <ClipboardList className="w-3 h-3" />
                            {p.mock_tokens_included} Mocks
                          </span>
                        )}
                      </div>
                    </td>
                    <td className="py-3 px-4 text-gray-600">{months} month{months > 1 ? 's' : ''}</td>
                    <td className="py-3 px-4 text-right">
                      {hasDiscount && (
                        <div className="text-xs text-gray-400 line-through">{formatPrice(p.price, currency)}</div>
                      )}
                      <div className="font-bold text-gray-900">{formatPrice(price, currency)}</div>
                    </td>
                    <td className="py-3 px-5 text-right">
                      <button
                        onClick={() => onBuyPlan(p.id)}
                        disabled={!!buyingId}
                        className={`px-4 py-1.5 text-xs font-semibold rounded-lg transition-colors disabled:opacity-50 ${
                          isBundle
                            ? 'bg-[#0d47a1] text-white hover:bg-[#1565c0]'
                            : 'bg-emerald-600 text-white hover:bg-emerald-700'
                        }`}
                      >
                        {isBuying ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : 'Buy'}
                      </button>
                    </td>
                  </tr>
                );
              }

              // Pack row
              const pk = row.pack;
              const isBulk = pk.token_count >= 50;
              const price = hasDiscount ? applyDiscount(pk.price, discountRate) : pk.price;
              const perTest = formatPrice(Math.round(price / pk.token_count), currency);
              const isBuying = buyingId === `pack-${pk.id}`;

              return (
                <tr key={pk.id} className="border-b border-gray-50 hover:bg-gray-50/50 transition-colors">
                  <td className="py-3 px-5">
                    <div className="flex items-center gap-2">
                      <span className="font-semibold text-gray-900">{pk.name}</span>
                      {isBulk && (
                        <span className="text-[10px] font-bold uppercase tracking-wider bg-[#0d47a1] text-white px-1.5 py-0.5 rounded">
                          Institute
                        </span>
                      )}
                    </div>
                  </td>
                  <td className="py-3 px-4">
                    <span className="text-xs text-gray-600">
                      {pk.token_count} mock{pk.token_count > 1 ? 's' : ''}
                    </span>
                  </td>
                  <td className="py-3 px-4 text-gray-400">—</td>
                  <td className="py-3 px-4 text-right">
                    {hasDiscount && (
                      <div className="text-xs text-gray-400 line-through">{formatPrice(pk.price, currency)}</div>
                    )}
                    <div className="font-bold text-gray-900">{formatPrice(price, currency)}</div>
                    <div className="text-[10px] text-gray-400">{perTest}/test</div>
                  </td>
                  <td className="py-3 px-5 text-right">
                    <button
                      onClick={() => onBuyPack(pk.id)}
                      disabled={!!buyingId}
                      className="px-4 py-1.5 text-xs font-semibold bg-[#1a365d] text-white rounded-lg hover:bg-[#2a4a7f] transition-colors disabled:opacity-50"
                    >
                      {isBuying ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : 'Buy'}
                    </button>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>

      {/* Mobile stacked cards */}
      <div className="sm:hidden divide-y divide-gray-100">
        {rows.map((row, i) => {
          if (row === 'separator-mocks') {
            return (
              <div key={`sep-m-${i}`} className="px-4 pt-4 pb-2">
                <div className="flex items-center gap-2 text-xs font-semibold text-gray-400 uppercase tracking-wide">
                  <ClipboardList className="w-3.5 h-3.5" />
                  Mock Packs
                </div>
              </div>
            );
          }
          if (row === 'separator-institute') {
            return (
              <div key={`sep-i-${i}`} className="px-4 pt-4 pb-2">
                <div className="flex items-center gap-2 text-xs font-semibold text-gray-400 uppercase tracking-wide">
                  <Building2 className="w-3.5 h-3.5" />
                  Institute Packs
                </div>
              </div>
            );
          }

          if (row.kind === 'plan') {
            const p = row.plan;
            const isBundle = p.plan_type === 'bundle';
            const months = Math.round(p.duration_days / 30);
            const price = hasDiscount ? applyDiscount(p.price, discountRate) : p.price;
            const isBuying = buyingId === `plan-${p.id}`;

            return (
              <div key={p.id} className={`p-4 ${isBundle ? 'bg-[#0d47a1]/2' : ''}`}>
                <div className="flex items-start justify-between mb-2">
                  <div>
                    <div className="flex items-center gap-2">
                      <span className="font-semibold text-gray-900 text-sm">{p.name}</span>
                      {isBundle && (
                        <span className="inline-flex items-center gap-1 px-1.5 py-0.5 bg-[#0d47a1]/10 text-[#0d47a1] text-[10px] font-bold rounded">
                          <Sparkles className="w-2.5 h-2.5" />
                          Best Value
                        </span>
                      )}
                    </div>
                    <p className="text-xs text-gray-500">{months} month{months > 1 ? 's' : ''}</p>
                  </div>
                  <div className="text-right">
                    {hasDiscount && <p className="text-[10px] text-gray-400 line-through">{formatPrice(p.price, currency)}</p>}
                    <p className="font-bold text-gray-900">{formatPrice(price, currency)}</p>
                  </div>
                </div>
                <div className="flex flex-wrap gap-1.5 mb-3">
                  <span className="inline-flex items-center gap-1 text-[10px] text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full">
                    <BookOpen className="w-2.5 h-2.5" /> 2500+ Questions
                  </span>
                  {isBundle && p.mock_tokens_included > 0 && (
                    <span className="inline-flex items-center gap-1 text-[10px] text-[#0d47a1] bg-[#0d47a1]/10 px-2 py-0.5 rounded-full">
                      <ClipboardList className="w-2.5 h-2.5" /> {p.mock_tokens_included} Mocks
                    </span>
                  )}
                </div>
                <button
                  onClick={() => onBuyPlan(p.id)}
                  disabled={!!buyingId}
                  className={`w-full py-2 text-xs font-semibold rounded-lg transition-colors disabled:opacity-50 ${
                    isBundle ? 'bg-[#0d47a1] text-white hover:bg-[#1565c0]' : 'bg-emerald-600 text-white hover:bg-emerald-700'
                  }`}
                >
                  {isBuying ? <Loader2 className="w-3.5 h-3.5 animate-spin mx-auto" /> : 'Buy'}
                </button>
              </div>
            );
          }

          const pk = row.pack;
          const isBulk = pk.token_count >= 50;
          const price = hasDiscount ? applyDiscount(pk.price, discountRate) : pk.price;
          const perTest = formatPrice(Math.round(price / pk.token_count), currency);
          const isBuying = buyingId === `pack-${pk.id}`;

          return (
            <div key={pk.id} className="p-4">
              <div className="flex items-start justify-between mb-2">
                <div>
                  <div className="flex items-center gap-2">
                    <span className="font-semibold text-gray-900 text-sm">{pk.name}</span>
                    {isBulk && (
                      <span className="text-[10px] font-bold uppercase tracking-wider bg-[#0d47a1] text-white px-1.5 py-0.5 rounded">
                        Institute
                      </span>
                    )}
                  </div>
                  <p className="text-xs text-gray-500">{pk.token_count} mock{pk.token_count > 1 ? 's' : ''}</p>
                </div>
                <div className="text-right">
                  {hasDiscount && <p className="text-[10px] text-gray-400 line-through">{formatPrice(pk.price, currency)}</p>}
                  <p className="font-bold text-gray-900">{formatPrice(price, currency)}</p>
                  <p className="text-[10px] text-gray-400">{perTest}/test</p>
                </div>
              </div>
              <button
                onClick={() => onBuyPack(pk.id)}
                disabled={!!buyingId}
                className="w-full py-2 text-xs font-semibold bg-[#1a365d] text-white rounded-lg hover:bg-[#2a4a7f] transition-colors disabled:opacity-50"
              >
                {isBuying ? <Loader2 className="w-3.5 h-3.5 animate-spin mx-auto" /> : 'Buy'}
              </button>
            </div>
          );
        })}
      </div>
    </div>
  );
}

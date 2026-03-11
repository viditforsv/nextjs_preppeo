'use client';

import { useEffect, useState } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import {
  IndianRupee,
  Loader2,
  Users,
  Clock,
  CheckCircle2,
  Copy,
  Check,
  TrendingUp,
} from 'lucide-react';

interface PartnerInfo {
  referral_code: string;
  commission_rate: number;
  discount_rate: number;
  is_active: boolean;
}

interface Stats {
  total_earned: number;
  pending_payout: number;
  total_referrals: number;
}

interface Commission {
  id: string;
  commission_amount: number;
  paid_amount: number;
  original_amount: number;
  status: string;
  created_at: string;
  profiles: { first_name: string | null; last_name: string | null } | null;
}

export default function PartnerDashboardPage() {
  const { user, loading: authLoading } = useAuth();
  const [partner, setPartner] = useState<PartnerInfo | null>(null);
  const [stats, setStats] = useState<Stats | null>(null);
  const [commissions, setCommissions] = useState<Commission[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    if (authLoading || !user) return;

    const fetchDashboard = async () => {
      try {
        const res = await fetch('/api/partner/dashboard');
        if (!res.ok) {
          setError('You do not have partner access.');
          return;
        }
        const data = await res.json();
        setPartner(data.partner);
        setStats(data.stats);
        setCommissions(data.commissions ?? []);
      } catch {
        setError('Failed to load dashboard');
      } finally {
        setLoading(false);
      }
    };

    fetchDashboard();
  }, [user, authLoading]);

  const copyCode = () => {
    if (!partner) return;
    navigator.clipboard.writeText(partner.referral_code);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  if (authLoading || loading) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <Loader2 className="w-6 h-6 animate-spin text-gray-400" />
      </div>
    );
  }

  if (!user) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <p className="text-gray-500">Please sign in to access your partner dashboard.</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center">
        <p className="text-red-600">{error}</p>
      </div>
    );
  }

  if (!partner || !stats) return null;

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="max-w-5xl mx-auto px-4 py-12">
        {/* Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-[#1a365d]">Partner Dashboard</h1>
          <p className="text-gray-600 mt-1">Track your referrals and earnings</p>
        </div>

        {/* Referral Code Card */}
        <div className="mb-8 bg-white border border-gray-200 rounded-xl p-6">
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
            <div>
              <p className="text-sm text-gray-500 mb-1">Your Referral Code</p>
              <div className="flex items-center gap-2">
                <span className="text-2xl font-bold font-mono text-[#1a365d] tracking-wider">
                  {partner.referral_code}
                </span>
                <button
                  onClick={copyCode}
                  className="p-1.5 rounded-md hover:bg-gray-100 transition-colors"
                >
                  {copied ? (
                    <Check className="w-4 h-4 text-emerald-600" />
                  ) : (
                    <Copy className="w-4 h-4 text-gray-400" />
                  )}
                </button>
              </div>
            </div>
            <div className="flex gap-4 text-sm">
              <div className="text-center">
                <p className="text-gray-400">Your Commission</p>
                <p className="font-bold text-[#1a365d]">{partner.commission_rate}%</p>
              </div>
              <div className="text-center">
                <p className="text-gray-400">Student Discount</p>
                <p className="font-bold text-[#1a365d]">{partner.discount_rate}%</p>
              </div>
            </div>
          </div>
        </div>

        {/* Stats Cards */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
          <div className="bg-white border border-gray-200 rounded-xl p-5">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-emerald-50 rounded-lg">
                <IndianRupee className="w-5 h-5 text-emerald-600" />
              </div>
              <div>
                <p className="text-sm text-gray-500">Total Earned</p>
                <p className="text-xl font-bold text-gray-900">₹{stats.total_earned.toFixed(2)}</p>
              </div>
            </div>
          </div>
          <div className="bg-white border border-gray-200 rounded-xl p-5">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-amber-50 rounded-lg">
                <Clock className="w-5 h-5 text-amber-600" />
              </div>
              <div>
                <p className="text-sm text-gray-500">Pending Payout</p>
                <p className="text-xl font-bold text-amber-600">₹{stats.pending_payout.toFixed(2)}</p>
              </div>
            </div>
          </div>
          <div className="bg-white border border-gray-200 rounded-xl p-5">
            <div className="flex items-center gap-3">
              <div className="p-2 bg-blue-50 rounded-lg">
                <Users className="w-5 h-5 text-blue-600" />
              </div>
              <div>
                <p className="text-sm text-gray-500">Total Referrals</p>
                <p className="text-xl font-bold text-gray-900">{stats.total_referrals}</p>
              </div>
            </div>
          </div>
        </div>

        {/* Commissions Table */}
        <div className="bg-white border border-gray-200 rounded-xl overflow-hidden">
          <div className="px-5 py-4 border-b border-gray-100 flex items-center gap-2">
            <TrendingUp className="w-4 h-4 text-gray-400" />
            <h2 className="font-semibold text-gray-900">Commission History</h2>
          </div>

          {commissions.length === 0 ? (
            <p className="text-gray-500 text-center py-12 text-sm">
              No commissions yet. Share your referral code to start earning!
            </p>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead className="bg-gray-50 border-b border-gray-200">
                  <tr>
                    <th className="text-left px-4 py-3 font-semibold text-gray-600">Date</th>
                    <th className="text-left px-4 py-3 font-semibold text-gray-600">Student</th>
                    <th className="text-right px-4 py-3 font-semibold text-gray-600">Sale Amount</th>
                    <th className="text-right px-4 py-3 font-semibold text-gray-600">Your Commission</th>
                    <th className="text-center px-4 py-3 font-semibold text-gray-600">Status</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {commissions.map((c) => {
                    const studentName = c.profiles
                      ? [c.profiles.first_name, c.profiles.last_name].filter(Boolean).join(' ') || 'Student'
                      : 'Student';

                    return (
                      <tr key={c.id} className="hover:bg-gray-50">
                        <td className="px-4 py-3 text-gray-500">
                          {new Date(c.created_at).toLocaleDateString('en-IN', {
                            day: 'numeric',
                            month: 'short',
                            year: 'numeric',
                          })}
                        </td>
                        <td className="px-4 py-3 text-gray-700">{studentName}</td>
                        <td className="px-4 py-3 text-right">₹{Number(c.paid_amount).toFixed(2)}</td>
                        <td className="px-4 py-3 text-right font-semibold text-[#1a365d]">
                          ₹{Number(c.commission_amount).toFixed(2)}
                        </td>
                        <td className="px-4 py-3 text-center">
                          {c.status === 'paid' ? (
                            <span className="inline-flex items-center gap-1 text-xs font-medium text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full">
                              <CheckCircle2 className="w-3 h-3" /> Paid
                            </span>
                          ) : (
                            <span className="inline-flex items-center gap-1 text-xs font-medium text-amber-700 bg-amber-50 px-2 py-0.5 rounded-full">
                              <Clock className="w-3 h-3" /> Pending
                            </span>
                          )}
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

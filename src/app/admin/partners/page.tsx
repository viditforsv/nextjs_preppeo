'use client';

import { useEffect, useState } from 'react';
import { AdminOnly } from '@/design-system/components/form-components/RoleGuard';
import { Breadcrumb } from '@/design-system/components/breadcrumb';
import {
  Users,
  Plus,
  Loader2,
  CheckCircle2,
  IndianRupee,
  Clock,
  Copy,
  Check,
} from 'lucide-react';

interface Partner {
  id: string;
  referral_code: string;
  commission_rate: number;
  discount_rate: number;
  is_active: boolean;
  created_at: string;
  profiles: { first_name: string | null; last_name: string | null; email: string | null } | null;
  total_earned: number;
  pending_payout: number;
  total_referrals: number;
}

interface Commission {
  id: string;
  partner_id: string;
  original_amount: number;
  paid_amount: number;
  commission_amount: number;
  status: string;
  paid_at: string | null;
  created_at: string;
  partners: { referral_code: string; profiles: { first_name: string | null; last_name: string | null; email: string | null } | null } | null;
  profiles: { first_name: string | null; last_name: string | null; email: string | null } | null;
}

export default function AdminPartnersPage() {
  const [tab, setTab] = useState<'partners' | 'commissions'>('partners');
  const [partners, setPartners] = useState<Partner[]>([]);
  const [commissions, setCommissions] = useState<Commission[]>([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [formData, setFormData] = useState({ userId: '', referralCode: '', commissionRate: '30', discountRate: '10' });
  const [formError, setFormError] = useState('');
  const [formLoading, setFormLoading] = useState(false);
  const [copiedCode, setCopiedCode] = useState<string | null>(null);
  const [markingPaid, setMarkingPaid] = useState<Set<string>>(new Set());

  const fetchPartners = async () => {
    try {
      const res = await fetch('/api/admin/partners');
      const data = await res.json();
      if (data.data) setPartners(data.data);
    } catch { /* silent */ }
  };

  const fetchCommissions = async () => {
    try {
      const res = await fetch('/api/admin/commissions');
      const data = await res.json();
      if (data.data) setCommissions(data.data);
    } catch { /* silent */ }
  };

  useEffect(() => {
    Promise.all([fetchPartners(), fetchCommissions()]).finally(() => setLoading(false));
  }, []);

  const handleCreatePartner = async (e: React.FormEvent) => {
    e.preventDefault();
    setFormLoading(true);
    setFormError('');

    try {
      const res = await fetch('/api/admin/partners', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          userId: formData.userId.trim(),
          referralCode: formData.referralCode.trim(),
          commissionRate: Number(formData.commissionRate),
          discountRate: Number(formData.discountRate),
        }),
      });
      const data = await res.json();

      if (!res.ok) {
        setFormError(data.error || 'Failed to create partner');
      } else {
        setShowForm(false);
        setFormData({ userId: '', referralCode: '', commissionRate: '30', discountRate: '10' });
        fetchPartners();
      }
    } catch {
      setFormError('Something went wrong');
    } finally {
      setFormLoading(false);
    }
  };

  const handleMarkPaid = async (commissionId: string) => {
    setMarkingPaid((prev) => new Set(prev).add(commissionId));
    try {
      await fetch('/api/admin/commissions', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ commissionIds: [commissionId] }),
      });
      fetchCommissions();
      fetchPartners();
    } catch { /* silent */ } finally {
      setMarkingPaid((prev) => {
        const next = new Set(prev);
        next.delete(commissionId);
        return next;
      });
    }
  };

  const copyCode = (code: string) => {
    navigator.clipboard.writeText(code);
    setCopiedCode(code);
    setTimeout(() => setCopiedCode(null), 2000);
  };

  const getName = (p: { first_name: string | null; last_name: string | null } | null) =>
    p ? [p.first_name, p.last_name].filter(Boolean).join(' ') || 'Unknown' : 'Unknown';

  if (loading) {
    return (
      <AdminOnly>
        <div className="min-h-screen bg-background flex items-center justify-center">
          <Loader2 className="w-6 h-6 animate-spin text-gray-400" />
        </div>
      </AdminOnly>
    );
  }

  return (
    <AdminOnly>
      <div className="min-h-screen bg-background">
        <div className="container mx-auto px-4 py-8 max-w-6xl">
          <div className="mb-6">
            <Breadcrumb
              items={[
                { label: 'Home', href: '/' },
                { label: 'Admin', href: '/admin' },
                { label: 'Partners', isActive: true },
              ]}
            />
          </div>

          <div className="flex items-center justify-between mb-8">
            <div>
              <h1 className="text-3xl font-bold text-foreground">Partner Management</h1>
              <p className="text-muted-foreground mt-1">Manage channel partners and commissions</p>
            </div>
            <button
              onClick={() => setShowForm(!showForm)}
              className="flex items-center gap-2 px-4 py-2 bg-[#1a365d] text-white text-sm font-semibold rounded-lg hover:bg-[#2a4a7f] transition-colors"
            >
              <Plus className="w-4 h-4" />
              Add Partner
            </button>
          </div>

          {/* Create Partner Form */}
          {showForm && (
            <div className="mb-8 bg-white border border-gray-200 rounded-xl p-6">
              <h3 className="font-semibold text-gray-900 mb-4">Create New Partner</h3>
              <form onSubmit={handleCreatePartner} className="grid sm:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">User ID (UUID)</label>
                  <input
                    type="text"
                    value={formData.userId}
                    onChange={(e) => setFormData({ ...formData, userId: e.target.value })}
                    placeholder="Paste the user's UUID"
                    required
                    className="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#1a365d]/20"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Referral Code</label>
                  <input
                    type="text"
                    value={formData.referralCode}
                    onChange={(e) => setFormData({ ...formData, referralCode: e.target.value.toUpperCase() })}
                    placeholder="e.g. COACHING30"
                    required
                    className="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#1a365d]/20"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Commission Rate (%)</label>
                  <input
                    type="number"
                    value={formData.commissionRate}
                    onChange={(e) => setFormData({ ...formData, commissionRate: e.target.value })}
                    min="0"
                    max="100"
                    className="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#1a365d]/20"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Student Discount (%)</label>
                  <input
                    type="number"
                    value={formData.discountRate}
                    onChange={(e) => setFormData({ ...formData, discountRate: e.target.value })}
                    min="0"
                    max="100"
                    className="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#1a365d]/20"
                  />
                </div>
                <div className="sm:col-span-2 flex items-center gap-3">
                  <button
                    type="submit"
                    disabled={formLoading}
                    className="px-4 py-2 bg-[#1a365d] text-white text-sm font-semibold rounded-lg hover:bg-[#2a4a7f] disabled:opacity-50 transition-colors"
                  >
                    {formLoading ? <Loader2 className="w-4 h-4 animate-spin" /> : 'Create Partner'}
                  </button>
                  <button
                    type="button"
                    onClick={() => setShowForm(false)}
                    className="px-4 py-2 text-sm text-gray-600 hover:text-gray-900"
                  >
                    Cancel
                  </button>
                  {formError && <span className="text-sm text-red-600">{formError}</span>}
                </div>
              </form>
            </div>
          )}

          {/* Tabs */}
          <div className="flex gap-1 bg-white rounded-lg p-1 border border-gray-200 mb-6 w-fit">
            <button
              onClick={() => setTab('partners')}
              className={`px-4 py-2 text-sm font-medium rounded-md transition-colors ${
                tab === 'partners' ? 'bg-[#1a365d] text-white' : 'text-gray-600 hover:text-gray-900'
              }`}
            >
              <Users className="w-4 h-4 inline mr-1.5 -mt-0.5" />
              Partners ({partners.length})
            </button>
            <button
              onClick={() => setTab('commissions')}
              className={`px-4 py-2 text-sm font-medium rounded-md transition-colors ${
                tab === 'commissions' ? 'bg-[#1a365d] text-white' : 'text-gray-600 hover:text-gray-900'
              }`}
            >
              <IndianRupee className="w-4 h-4 inline mr-1.5 -mt-0.5" />
              Commissions ({commissions.length})
            </button>
          </div>

          {/* Partners Table */}
          {tab === 'partners' && (
            <div className="bg-white border border-gray-200 rounded-xl overflow-hidden">
              {partners.length === 0 ? (
                <p className="text-gray-500 text-center py-12">No partners yet. Click &ldquo;Add Partner&rdquo; to get started.</p>
              ) : (
                <div className="overflow-x-auto">
                  <table className="w-full text-sm">
                    <thead className="bg-gray-50 border-b border-gray-200">
                      <tr>
                        <th className="text-left px-4 py-3 font-semibold text-gray-600">Partner</th>
                        <th className="text-left px-4 py-3 font-semibold text-gray-600">Code</th>
                        <th className="text-center px-4 py-3 font-semibold text-gray-600">Commission</th>
                        <th className="text-center px-4 py-3 font-semibold text-gray-600">Discount</th>
                        <th className="text-right px-4 py-3 font-semibold text-gray-600">Referrals</th>
                        <th className="text-right px-4 py-3 font-semibold text-gray-600">Total Earned</th>
                        <th className="text-right px-4 py-3 font-semibold text-gray-600">Pending</th>
                        <th className="text-center px-4 py-3 font-semibold text-gray-600">Status</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-100">
                      {partners.map((p) => (
                        <tr key={p.id} className="hover:bg-gray-50">
                          <td className="px-4 py-3">
                            <div className="font-medium text-gray-900">{getName(p.profiles)}</div>
                            <div className="text-xs text-gray-400">{p.profiles?.email}</div>
                          </td>
                          <td className="px-4 py-3">
                            <button
                              onClick={() => copyCode(p.referral_code)}
                              className="inline-flex items-center gap-1 font-mono text-xs bg-gray-100 px-2 py-1 rounded hover:bg-gray-200 transition-colors"
                            >
                              {p.referral_code}
                              {copiedCode === p.referral_code ? (
                                <Check className="w-3 h-3 text-emerald-600" />
                              ) : (
                                <Copy className="w-3 h-3 text-gray-400" />
                              )}
                            </button>
                          </td>
                          <td className="px-4 py-3 text-center">{p.commission_rate}%</td>
                          <td className="px-4 py-3 text-center">{p.discount_rate}%</td>
                          <td className="px-4 py-3 text-right">{p.total_referrals}</td>
                          <td className="px-4 py-3 text-right font-medium">₹{p.total_earned.toFixed(2)}</td>
                          <td className="px-4 py-3 text-right font-medium text-amber-600">₹{p.pending_payout.toFixed(2)}</td>
                          <td className="px-4 py-3 text-center">
                            <span className={`text-xs font-medium px-2 py-0.5 rounded-full ${
                              p.is_active
                                ? 'bg-emerald-50 text-emerald-700'
                                : 'bg-gray-100 text-gray-500'
                            }`}>
                              {p.is_active ? 'Active' : 'Inactive'}
                            </span>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          )}

          {/* Commissions Table */}
          {tab === 'commissions' && (
            <div className="bg-white border border-gray-200 rounded-xl overflow-hidden">
              {commissions.length === 0 ? (
                <p className="text-gray-500 text-center py-12">No commissions recorded yet.</p>
              ) : (
                <div className="overflow-x-auto">
                  <table className="w-full text-sm">
                    <thead className="bg-gray-50 border-b border-gray-200">
                      <tr>
                        <th className="text-left px-4 py-3 font-semibold text-gray-600">Date</th>
                        <th className="text-left px-4 py-3 font-semibold text-gray-600">Partner</th>
                        <th className="text-left px-4 py-3 font-semibold text-gray-600">Student</th>
                        <th className="text-right px-4 py-3 font-semibold text-gray-600">Original</th>
                        <th className="text-right px-4 py-3 font-semibold text-gray-600">Paid</th>
                        <th className="text-right px-4 py-3 font-semibold text-gray-600">Commission</th>
                        <th className="text-center px-4 py-3 font-semibold text-gray-600">Status</th>
                        <th className="text-center px-4 py-3 font-semibold text-gray-600">Action</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-100">
                      {commissions.map((c) => (
                        <tr key={c.id} className="hover:bg-gray-50">
                          <td className="px-4 py-3 text-gray-500">
                            {new Date(c.created_at).toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' })}
                          </td>
                          <td className="px-4 py-3">
                            <div className="font-medium text-gray-900">
                              {getName(c.partners?.profiles ?? null)}
                            </div>
                            <div className="text-xs text-gray-400">{c.partners?.referral_code}</div>
                          </td>
                          <td className="px-4 py-3 text-gray-700">
                            {getName(c.profiles)}
                          </td>
                          <td className="px-4 py-3 text-right text-gray-500">₹{Number(c.original_amount).toFixed(2)}</td>
                          <td className="px-4 py-3 text-right">₹{Number(c.paid_amount).toFixed(2)}</td>
                          <td className="px-4 py-3 text-right font-semibold text-[#1a365d]">₹{Number(c.commission_amount).toFixed(2)}</td>
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
                          <td className="px-4 py-3 text-center">
                            {c.status === 'pending' && (
                              <button
                                onClick={() => handleMarkPaid(c.id)}
                                disabled={markingPaid.has(c.id)}
                                className="text-xs font-medium text-[#1a365d] hover:underline disabled:opacity-50"
                              >
                                {markingPaid.has(c.id) ? <Loader2 className="w-3 h-3 animate-spin inline" /> : 'Mark Paid'}
                              </button>
                            )}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
    </AdminOnly>
  );
}

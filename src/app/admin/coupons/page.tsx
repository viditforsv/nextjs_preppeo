'use client';

import { useEffect, useState } from 'react';
import { AdminOnly } from '@/design-system/components/form-components/RoleGuard';
import { Breadcrumb } from '@/design-system/components/breadcrumb';
import { Ticket, Plus, Loader2, Copy, Check } from 'lucide-react';

interface Coupon {
  id: string;
  code: string;
  description: string | null;
  terms: string | null;
  discount_percent: number;
  max_redemptions: number;
  redeemed_count: number;
  is_active: boolean;
  is_public: boolean;
  expires_at: string | null;
  created_at: string;
}

export default function AdminCouponsPage() {
  const [coupons, setCoupons] = useState<Coupon[]>([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [form, setForm] = useState({
    code: '',
    description: '',
    terms: '',
    discountPercent: '99',
    maxRedemptions: '100',
    expiresAt: '',
    isPublic: false,
  });
  const [formError, setFormError] = useState('');
  const [formLoading, setFormLoading] = useState(false);
  const [copied, setCopied] = useState<string | null>(null);
  const [toggling, setToggling] = useState<Set<string>>(new Set());

  const fetchCoupons = async () => {
    try {
      const res = await fetch('/api/admin/coupons');
      const data = await res.json();
      if (data.data) setCoupons(data.data);
    } catch {
      /* silent */
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchCoupons();
  }, []);

  const createCoupon = async () => {
    setFormError('');
    setFormLoading(true);
    try {
      const res = await fetch('/api/admin/coupons', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          code: form.code,
          description: form.description,
          terms: form.terms,
          discount_percent: Number(form.discountPercent),
          max_redemptions: Number(form.maxRedemptions),
          expires_at: form.expiresAt ? new Date(form.expiresAt).toISOString() : null,
          is_public: form.isPublic,
        }),
      });
      const data = await res.json();
      if (!res.ok) {
        setFormError(data.error || 'Failed to create coupon');
        return;
      }
      setForm({ code: '', description: '', terms: '', discountPercent: '99', maxRedemptions: '100', expiresAt: '', isPublic: false });
      setShowForm(false);
      fetchCoupons();
    } catch {
      setFormError('Something went wrong');
    } finally {
      setFormLoading(false);
    }
  };

  const toggleActive = async (c: Coupon) => {
    setToggling((s) => new Set(s).add(c.id));
    try {
      await fetch('/api/admin/coupons', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id: c.id, is_active: !c.is_active }),
      });
      setCoupons((prev) => prev.map((x) => (x.id === c.id ? { ...x, is_active: !x.is_active } : x)));
    } catch {
      /* silent */
    } finally {
      setToggling((s) => {
        const next = new Set(s);
        next.delete(c.id);
        return next;
      });
    }
  };

  const togglePublic = async (c: Coupon) => {
    setToggling((s) => new Set(s).add(c.id));
    try {
      await fetch('/api/admin/coupons', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id: c.id, is_public: !c.is_public }),
      });
      setCoupons((prev) => prev.map((x) => (x.id === c.id ? { ...x, is_public: !x.is_public } : x)));
    } catch {
      /* silent */
    } finally {
      setToggling((s) => {
        const next = new Set(s);
        next.delete(c.id);
        return next;
      });
    }
  };

  const copyCode = (code: string) => {
    navigator.clipboard.writeText(code).catch(() => {});
    setCopied(code);
    setTimeout(() => setCopied(null), 1200);
  };

  const inputCls =
    'w-full rounded-sm border px-3 py-2 bg-background text-sm focus:outline-none focus:border-primary';

  return (
    <AdminOnly>
      <div className="min-h-screen bg-background">
        <div className="container mx-auto px-4 py-8 max-w-5xl">
          <div className="mb-6">
            <Breadcrumb
              items={[
                { label: 'Home', href: '/' },
                { label: 'Admin', href: '/admin/site-administration' },
                { label: 'Coupons', isActive: true },
              ]}
            />
          </div>

          <div className="mb-6 flex items-start justify-between gap-4">
            <div>
              <h1 className="text-3xl font-bold text-foreground flex items-center gap-2">
                <Ticket className="w-7 h-7 text-primary" /> Promo Coupons
              </h1>
              <p className="text-muted-foreground mt-2">
                Capped percentage-discount codes applied to the whole cart at checkout. One
                redemption per user; a slot is consumed only on a paid order.
              </p>
            </div>
            <button
              type="button"
              onClick={() => setShowForm((s) => !s)}
              className="shrink-0 inline-flex items-center gap-1.5 rounded-sm bg-primary px-4 py-2 text-sm font-semibold text-white hover:bg-primary/90"
            >
              <Plus className="w-4 h-4" /> New coupon
            </button>
          </div>

          {showForm && (
            <div className="mb-6 rounded-sm border bg-card p-5">
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold mb-1">Code</label>
                  <input
                    className={inputCls}
                    placeholder="PREPPEOSAT99"
                    value={form.code}
                    onChange={(e) => setForm({ ...form, code: e.target.value.toUpperCase() })}
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold mb-1">Description</label>
                  <input
                    className={inputCls}
                    placeholder="Reddit SAT launch"
                    value={form.description}
                    onChange={(e) => setForm({ ...form, description: e.target.value })}
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold mb-1">Discount %</label>
                  <input
                    type="number"
                    min={1}
                    max={100}
                    className={inputCls}
                    value={form.discountPercent}
                    onChange={(e) => setForm({ ...form, discountPercent: e.target.value })}
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold mb-1">Max redemptions</label>
                  <input
                    type="number"
                    min={1}
                    className={inputCls}
                    value={form.maxRedemptions}
                    onChange={(e) => setForm({ ...form, maxRedemptions: e.target.value })}
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold mb-1">
                    Expires <span className="font-normal text-muted-foreground">— optional</span>
                  </label>
                  <input
                    type="date"
                    className={inputCls}
                    value={form.expiresAt}
                    onChange={(e) => setForm({ ...form, expiresAt: e.target.value })}
                  />
                </div>
                <div className="sm:col-span-2">
                  <label className="block text-xs font-semibold mb-1">
                    Terms &amp; conditions{' '}
                    <span className="font-normal text-muted-foreground">
                      — shown to users in the &quot;Terms&quot; modal
                    </span>
                  </label>
                  <textarea
                    rows={3}
                    className={inputCls}
                    placeholder="99% off your entire cart. First 100 students only. One use per account…"
                    value={form.terms}
                    onChange={(e) => setForm({ ...form, terms: e.target.value })}
                  />
                </div>
                <div className="sm:col-span-2">
                  <label className="flex items-center gap-2 text-sm">
                    <input
                      type="checkbox"
                      checked={form.isPublic}
                      onChange={(e) => setForm({ ...form, isPublic: e.target.checked })}
                    />
                    <span>
                      <span className="font-semibold">Show on site</span> — list this code
                      publicly under &quot;Available offers&quot; on /pricing. Leave off for
                      targeted/typed-only codes.
                    </span>
                  </label>
                </div>
              </div>
              {formError && <p className="mt-3 text-xs text-red-600">{formError}</p>}
              <div className="mt-4 flex gap-2">
                <button
                  type="button"
                  onClick={createCoupon}
                  disabled={formLoading || !form.code.trim()}
                  className="inline-flex items-center gap-1.5 rounded-sm bg-primary px-4 py-2 text-sm font-semibold text-white hover:bg-primary/90 disabled:opacity-50"
                >
                  {formLoading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Plus className="w-4 h-4" />}
                  Create
                </button>
                <button
                  type="button"
                  onClick={() => setShowForm(false)}
                  className="rounded-sm border px-4 py-2 text-sm font-semibold hover:bg-muted"
                >
                  Cancel
                </button>
              </div>
            </div>
          )}

          <div className="rounded-sm border bg-card overflow-hidden">
            {loading ? (
              <div className="p-8 text-center text-muted-foreground">
                <Loader2 className="w-5 h-5 animate-spin inline" />
              </div>
            ) : coupons.length === 0 ? (
              <div className="p-8 text-center text-muted-foreground text-sm">No coupons yet.</div>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead className="bg-muted/50 text-left text-muted-foreground">
                    <tr>
                      <th className="px-4 py-3 font-medium">Code</th>
                      <th className="px-4 py-3 font-medium">Discount</th>
                      <th className="px-4 py-3 font-medium">Redeemed</th>
                      <th className="px-4 py-3 font-medium">Expires</th>
                      <th className="px-4 py-3 font-medium">Status</th>
                      <th className="px-4 py-3 font-medium">Listed</th>
                      <th className="px-4 py-3 font-medium text-right">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    {coupons.map((c) => {
                      const full = c.redeemed_count >= c.max_redemptions;
                      return (
                        <tr key={c.id} className="border-t">
                          <td className="px-4 py-3">
                            <button
                              type="button"
                              onClick={() => copyCode(c.code)}
                              className="inline-flex items-center gap-1.5 font-mono font-semibold hover:text-primary"
                            >
                              {c.code}
                              {copied === c.code ? (
                                <Check className="w-3.5 h-3.5 text-emerald-600" />
                              ) : (
                                <Copy className="w-3.5 h-3.5 text-muted-foreground" />
                              )}
                            </button>
                            {c.description && (
                              <p className="text-xs text-muted-foreground mt-0.5">{c.description}</p>
                            )}
                          </td>
                          <td className="px-4 py-3 font-semibold">{Number(c.discount_percent)}%</td>
                          <td className="px-4 py-3">
                            <span className={full ? 'text-amber-700 font-semibold' : ''}>
                              {c.redeemed_count} / {c.max_redemptions}
                            </span>
                          </td>
                          <td className="px-4 py-3 text-muted-foreground">
                            {c.expires_at ? new Date(c.expires_at).toLocaleDateString() : '—'}
                          </td>
                          <td className="px-4 py-3">
                            {!c.is_active ? (
                              <span className="text-xs rounded-full bg-gray-100 text-gray-600 px-2 py-0.5">
                                Inactive
                              </span>
                            ) : full ? (
                              <span className="text-xs rounded-full bg-amber-100 text-amber-700 px-2 py-0.5">
                                Limit reached
                              </span>
                            ) : (
                              <span className="text-xs rounded-full bg-emerald-100 text-emerald-700 px-2 py-0.5">
                                Active
                              </span>
                            )}
                          </td>
                          <td className="px-4 py-3">
                            <button
                              type="button"
                              onClick={() => togglePublic(c)}
                              disabled={toggling.has(c.id)}
                              title={c.is_public ? 'Listed on /pricing — click to hide' : 'Hidden — click to list publicly'}
                              className={`text-xs rounded-full px-2 py-0.5 disabled:opacity-50 ${
                                c.is_public
                                  ? 'bg-blue-100 text-blue-700'
                                  : 'bg-gray-100 text-gray-500'
                              }`}
                            >
                              {c.is_public ? 'Public' : 'Hidden'}
                            </button>
                          </td>
                          <td className="px-4 py-3 text-right">
                            <button
                              type="button"
                              onClick={() => toggleActive(c)}
                              disabled={toggling.has(c.id)}
                              className="rounded-sm border px-3 py-1.5 text-xs font-semibold hover:bg-muted disabled:opacity-50"
                            >
                              {toggling.has(c.id) ? (
                                <Loader2 className="w-3.5 h-3.5 animate-spin" />
                              ) : c.is_active ? (
                                'Deactivate'
                              ) : (
                                'Activate'
                              )}
                            </button>
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
    </AdminOnly>
  );
}

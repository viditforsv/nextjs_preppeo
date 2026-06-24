/**
 * Public list of coupons to surface on /pricing.
 * Returns only admin-flagged (is_public), active, non-expired, under-cap codes.
 * No auth — these are meant to be advertised.
 */
import { NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function GET() {
  const supabase = createSupabaseApiClient();

  const { data, error } = await supabase
    .from('coupons')
    .select('code, description, discount_percent, terms, max_redemptions, redeemed_count, expires_at')
    .eq('is_public', true)
    .eq('is_active', true)
    .order('discount_percent', { ascending: false });

  if (error) {
    return NextResponse.json({ coupons: [] }, { status: 200 });
  }

  const now = Date.now();
  const coupons = (data ?? [])
    .filter((c) => c.redeemed_count < c.max_redemptions)
    .filter((c) => !c.expires_at || new Date(c.expires_at).getTime() > now)
    .map((c) => ({
      code: c.code,
      description: c.description,
      discount_percent: Number(c.discount_percent),
      terms: c.terms,
      remaining: Math.max(0, c.max_redemptions - c.redeemed_count),
    }));

  return NextResponse.json({ coupons });
}

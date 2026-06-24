import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function POST(request: NextRequest) {
  try {
    const { code } = await request.json();

    if (!code || typeof code !== 'string') {
      return NextResponse.json(
        { valid: false, error: 'Referral code is required' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseApiClient();
    const normalized = code.trim().toUpperCase();

    // Partner referral code takes precedence.
    const { data: partner } = await supabase
      .from('partners')
      .select('id, referral_code, discount_rate, profiles(first_name, last_name)')
      .eq('referral_code', normalized)
      .eq('is_active', true)
      .single();

    if (partner) {
      const profile = partner.profiles as unknown as { first_name: string | null; last_name: string | null } | null;
      const partnerName = profile
        ? [profile.first_name, profile.last_name].filter(Boolean).join(' ')
        : 'Partner';

      return NextResponse.json({
        valid: true,
        type: 'partner',
        discount_rate: partner.discount_rate,
        partner_name: partnerName,
      });
    }

    // Otherwise try a promo coupon. The per-user limit is enforced at
    // create-order (which knows the user); here we only gate on cap/expiry.
    const { data: coupon } = await supabase
      .from('coupons')
      .select('discount_percent, max_redemptions, redeemed_count, expires_at')
      .eq('code', normalized)
      .eq('is_active', true)
      .single();

    if (coupon) {
      const expired = coupon.expires_at && new Date(coupon.expires_at) <= new Date();
      const capReached = coupon.redeemed_count >= coupon.max_redemptions;
      if (expired || capReached) {
        return NextResponse.json({ valid: false, error: capReached ? 'This code has reached its limit.' : 'This code has expired.' });
      }
      return NextResponse.json({
        valid: true,
        type: 'coupon',
        discount_rate: Number(coupon.discount_percent),
        partner_name: 'Promo code',
      });
    }

    return NextResponse.json({ valid: false });
  } catch {
    return NextResponse.json(
      { valid: false, error: 'Failed to validate code' },
      { status: 500 }
    );
  }
}

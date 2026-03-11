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

    const { data: partner, error } = await supabase
      .from('partners')
      .select('id, referral_code, discount_rate, profiles(first_name, last_name)')
      .eq('referral_code', code.trim().toUpperCase())
      .eq('is_active', true)
      .single();

    if (error || !partner) {
      return NextResponse.json({ valid: false });
    }

    const profile = partner.profiles as unknown as { first_name: string | null; last_name: string | null } | null;
    const partnerName = profile
      ? [profile.first_name, profile.last_name].filter(Boolean).join(' ')
      : 'Partner';

    return NextResponse.json({
      valid: true,
      discount_rate: partner.discount_rate,
      partner_name: partnerName,
    });
  } catch {
    return NextResponse.json(
      { valid: false, error: 'Failed to validate code' },
      { status: 500 }
    );
  }
}

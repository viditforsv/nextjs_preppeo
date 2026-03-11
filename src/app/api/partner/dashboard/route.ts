import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function GET() {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: 'Authentication required' }, { status: 401 });
    }

    const supabase = createSupabaseApiClient();

    // Verify user is a partner
    const { data: partner, error: partnerError } = await supabase
      .from('partners')
      .select('id, referral_code, commission_rate, discount_rate, is_active')
      .eq('id', user.id)
      .single();

    if (partnerError || !partner) {
      return NextResponse.json({ error: 'Partner account not found' }, { status: 403 });
    }

    // Fetch all commissions for this partner
    const { data: commissions } = await supabase
      .from('partner_commissions')
      .select(`
        id,
        commission_amount,
        paid_amount,
        original_amount,
        status,
        created_at,
        profiles!partner_commissions_student_id_fkey(first_name, last_name)
      `)
      .eq('partner_id', user.id)
      .order('created_at', { ascending: false })
      .limit(50);

    const allCommissions = commissions ?? [];

    const totalEarned = allCommissions.reduce((sum, c) => sum + Number(c.commission_amount), 0);
    const pendingPayout = allCommissions
      .filter((c) => c.status === 'pending')
      .reduce((sum, c) => sum + Number(c.commission_amount), 0);
    const totalReferrals = allCommissions.length;

    return NextResponse.json({
      partner: {
        referral_code: partner.referral_code,
        commission_rate: partner.commission_rate,
        discount_rate: partner.discount_rate,
        is_active: partner.is_active,
      },
      stats: {
        total_earned: totalEarned,
        pending_payout: pendingPayout,
        total_referrals: totalReferrals,
      },
      commissions: allCommissions,
    });
  } catch (error) {
    console.error('Error in GET /api/partner/dashboard:', error);
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'Failed to load dashboard' },
      { status: 500 }
    );
  }
}

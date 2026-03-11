import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

async function requireAdmin() {
  const authClient = await createClient();
  const { data: { user } } = await authClient.auth.getUser();
  if (!user) return null;

  const supabase = createSupabaseApiClient();
  const { data: profile } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', user.id)
    .single();

  if (profile?.role !== 'admin') return null;
  return user;
}

export async function GET() {
  const admin = await requireAdmin();
  if (!admin) {
    return NextResponse.json({ error: 'Admin access required' }, { status: 403 });
  }

  const supabase = createSupabaseApiClient();

  const { data, error } = await supabase
    .from('partners')
    .select(`
      id,
      referral_code,
      commission_rate,
      discount_rate,
      is_active,
      created_at,
      profiles(first_name, last_name, email)
    `)
    .order('created_at', { ascending: false });

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  // Fetch aggregated commission totals per partner
  const { data: commissions } = await supabase
    .from('partner_commissions')
    .select('partner_id, commission_amount, status');

  const commissionMap: Record<string, { total: number; pending: number; referrals: number }> = {};
  for (const c of commissions ?? []) {
    if (!commissionMap[c.partner_id]) {
      commissionMap[c.partner_id] = { total: 0, pending: 0, referrals: 0 };
    }
    commissionMap[c.partner_id].total += Number(c.commission_amount);
    commissionMap[c.partner_id].referrals += 1;
    if (c.status === 'pending') {
      commissionMap[c.partner_id].pending += Number(c.commission_amount);
    }
  }

  const partners = (data ?? []).map((p) => ({
    ...p,
    total_earned: commissionMap[p.id]?.total ?? 0,
    pending_payout: commissionMap[p.id]?.pending ?? 0,
    total_referrals: commissionMap[p.id]?.referrals ?? 0,
  }));

  return NextResponse.json({ data: partners });
}

export async function POST(request: NextRequest) {
  const admin = await requireAdmin();
  if (!admin) {
    return NextResponse.json({ error: 'Admin access required' }, { status: 403 });
  }

  const { userId, referralCode, commissionRate, discountRate } = await request.json();

  if (!userId || !referralCode) {
    return NextResponse.json(
      { error: 'userId and referralCode are required' },
      { status: 400 }
    );
  }

  const supabase = createSupabaseApiClient();

  // Verify user exists
  const { data: profile, error: profileError } = await supabase
    .from('profiles')
    .select('id, role')
    .eq('id', userId)
    .single();

  if (profileError || !profile) {
    return NextResponse.json({ error: 'User not found' }, { status: 404 });
  }

  // Check for duplicate referral code
  const { data: existing } = await supabase
    .from('partners')
    .select('id')
    .eq('referral_code', referralCode.trim().toUpperCase())
    .single();

  if (existing) {
    return NextResponse.json({ error: 'Referral code already in use' }, { status: 409 });
  }

  // Create partner record
  const { data: partner, error: partnerError } = await supabase
    .from('partners')
    .insert({
      id: userId,
      referral_code: referralCode.trim().toUpperCase(),
      commission_rate: commissionRate ?? 30,
      discount_rate: discountRate ?? 10,
    })
    .select()
    .single();

  if (partnerError) {
    return NextResponse.json({ error: partnerError.message }, { status: 500 });
  }

  // Update user role to 'partner' if they're currently a student
  if (profile.role === 'student') {
    await supabase
      .from('profiles')
      .update({ role: 'partner' })
      .eq('id', userId);
  }

  return NextResponse.json({ data: partner });
}

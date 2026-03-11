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

export async function GET(request: NextRequest) {
  const admin = await requireAdmin();
  if (!admin) {
    return NextResponse.json({ error: 'Admin access required' }, { status: 403 });
  }

  const supabase = createSupabaseApiClient();
  const { searchParams } = new URL(request.url);
  const partnerId = searchParams.get('partnerId');
  const status = searchParams.get('status');

  let query = supabase
    .from('partner_commissions')
    .select(`
      id,
      partner_id,
      purchase_id,
      student_id,
      original_amount,
      paid_amount,
      commission_amount,
      status,
      paid_at,
      created_at,
      partners(referral_code, profiles(first_name, last_name, email)),
      profiles!partner_commissions_student_id_fkey(first_name, last_name, email)
    `)
    .order('created_at', { ascending: false })
    .limit(200);

  if (partnerId) query = query.eq('partner_id', partnerId);
  if (status) query = query.eq('status', status);

  const { data, error } = await query;

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({ data: data ?? [] });
}

export async function PATCH(request: NextRequest) {
  const admin = await requireAdmin();
  if (!admin) {
    return NextResponse.json({ error: 'Admin access required' }, { status: 403 });
  }

  const { commissionIds } = await request.json();

  if (!commissionIds || !Array.isArray(commissionIds) || commissionIds.length === 0) {
    return NextResponse.json({ error: 'commissionIds array is required' }, { status: 400 });
  }

  const supabase = createSupabaseApiClient();

  const { error } = await supabase
    .from('partner_commissions')
    .update({ status: 'paid', paid_at: new Date().toISOString() })
    .in('id', commissionIds);

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({ success: true, updated: commissionIds.length });
}

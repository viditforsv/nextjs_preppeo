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
    const { data: profile } = await supabase
      .from('profiles')
      .select('referral_code')
      .eq('id', user.id)
      .single();

    if (!profile?.referral_code) {
      return NextResponse.json({ error: 'Referral code not found' }, { status: 404 });
    }

    return NextResponse.json({ code: profile.referral_code });
  } catch (error) {
    console.error('Error fetching referral code:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

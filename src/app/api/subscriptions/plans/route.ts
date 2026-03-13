import { NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function GET() {
  try {
    const supabase = createSupabaseApiClient();
    const { data, error } = await supabase
      .from('subscription_plans')
      .select('*')
      .eq('is_active', true)
      .order('price', { ascending: true });

    if (error) {
      console.error('Error fetching plans:', error);
      return NextResponse.json({ error: 'Failed to fetch plans' }, { status: 500 });
    }

    return NextResponse.json({ plans: data ?? [] });
  } catch (error) {
    console.error('Error in GET /api/subscriptions/plans:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

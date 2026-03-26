import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { checkPremium, getDailyUsage, buildFreeLimits } from '@/lib/ibdp-maths-api-helpers';

const COURSE = 'ibdp-aa-sl';

export async function GET() {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Authentication required' }, { status: 401 });

    const supabase = createSupabaseApiClient();
    const isPremium = await checkPremium(supabase, user.id);
    if (isPremium) return NextResponse.json({ isPremium: true, remaining: null });

    const { data: expiredSub } = await supabase
      .from('user_subscriptions')
      .select('id')
      .eq('user_id', user.id)
      .eq('is_active', true)
      .lt('ends_at', new Date().toISOString())
      .limit(1)
      .maybeSingle();

    const usage = await getDailyUsage(supabase, user.id, COURSE);
    const remaining = buildFreeLimits(usage);

    return NextResponse.json({ isPremium: false, remaining, recentlyExpired: !!expiredSub });
  } catch (err) {
    console.error(`Error in GET /api/${COURSE}/practice-usage:`, err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

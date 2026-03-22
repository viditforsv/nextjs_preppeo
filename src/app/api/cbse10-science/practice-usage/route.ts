import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

const FREE_LIMITS = { easy: 2, medium: 2, hard: 1 } as const;

export async function GET() {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Authentication required' }, { status: 401 });

    const supabase = createSupabaseApiClient();

    const { data: activeSub } = await supabase
      .from('user_subscriptions')
      .select('id, ends_at')
      .eq('user_id', user.id)
      .eq('is_active', true)
      .gte('ends_at', new Date().toISOString())
      .limit(1)
      .maybeSingle();

    if (activeSub) return NextResponse.json({ isPremium: true, remaining: null });

    const { data: expiredSub } = await supabase
      .from('user_subscriptions')
      .select('id, ends_at')
      .eq('user_id', user.id)
      .eq('is_active', true)
      .lt('ends_at', new Date().toISOString())
      .order('ends_at', { ascending: false })
      .limit(1)
      .maybeSingle();

    const recentlyExpired = !!expiredSub;

    const today = new Date().toISOString().slice(0, 10);
    const { data: usage } = await supabase
      .from('practice_daily_usage')
      .select('easy_used, medium_used, hard_used')
      .eq('user_id', user.id)
      .eq('usage_date', today)
      .eq('course', 'cbse10-science')
      .maybeSingle();

    const remaining = {
      easy: Math.max(0, FREE_LIMITS.easy - (usage?.easy_used ?? 0)),
      medium: Math.max(0, FREE_LIMITS.medium - (usage?.medium_used ?? 0)),
      hard: Math.max(0, FREE_LIMITS.hard - (usage?.hard_used ?? 0)),
    };

    return NextResponse.json({ isPremium: false, remaining, recentlyExpired });
  } catch (error) {
    console.error('Error in GET /api/cbse10-science/practice-usage:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

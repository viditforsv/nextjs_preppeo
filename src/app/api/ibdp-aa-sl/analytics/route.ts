import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { IBDP_DOMAIN_LABELS } from '@/lib/ibdp-maths-courses';

const COURSE = 'ibdp-aa-sl';

export async function GET() {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Authentication required' }, { status: 401 });

    const supabase = createSupabaseApiClient();
    const { data, error } = await supabase
      .from('practice_answers')
      .select('domain, is_correct')
      .eq('user_id', user.id)
      .eq('course', COURSE)
      .not('domain', 'is', null);

    if (error) return NextResponse.json({ error: 'Failed to fetch analytics' }, { status: 500 });

    const rows = data ?? [];
    const domainMap = new Map<string, { correct: number; attempted: number }>();

    for (const row of rows) {
      const d = row.domain as string;
      if (!domainMap.has(d)) domainMap.set(d, { correct: 0, attempted: 0 });
      const entry = domainMap.get(d)!;
      entry.attempted++;
      if (row.is_correct) entry.correct++;
    }

    const chapters = [...domainMap.entries()].map(([domain, stats]) => ({
      domain,
      label: IBDP_DOMAIN_LABELS[domain as keyof typeof IBDP_DOMAIN_LABELS] ?? domain,
      attempted: stats.attempted,
      correct: stats.correct,
      accuracy: stats.attempted > 0 ? Math.round((stats.correct / stats.attempted) * 100) : 0,
    }));

    chapters.sort((a, b) => a.domain.localeCompare(b.domain));

    const attempted = chapters.filter((c) => c.attempted >= 3);
    const sorted = [...attempted].sort((a, b) => b.accuracy - a.accuracy);
    const strongest = sorted.slice(0, 2).filter((c) => c.accuracy >= 60).map((c) => c.domain);
    const weakest = sorted.slice(-2).filter((c) => c.accuracy < 60).map((c) => c.domain).reverse();

    const totalAttempted = rows.length;
    const totalCorrect = rows.filter((r) => r.is_correct).length;

    return NextResponse.json({ chapters, weakest, strongest, totalAttempted, totalCorrect });
  } catch (err) {
    console.error(`Error in GET /api/${COURSE}/analytics:`, err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

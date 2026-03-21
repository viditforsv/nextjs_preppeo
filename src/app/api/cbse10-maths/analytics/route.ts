import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

const DOMAIN_LABELS: Record<string, string> = {
  'real-numbers': 'Real Numbers',
  'polynomials': 'Polynomials',
  'linear-equations': 'Linear Equations',
  'quadratic-equations': 'Quadratic Equations',
  'arithmetic-progressions': 'Arithmetic Progressions',
  'triangles': 'Triangles',
  'coordinate-geometry': 'Coordinate Geometry',
  'trigonometry': 'Trigonometry',
  'applications-of-trig': 'Applications of Trigonometry',
  'circles': 'Circles',
  'areas-related-to-circles': 'Areas Related to Circles',
  'surface-areas-volumes': 'Surface Areas & Volumes',
  'statistics': 'Statistics',
  'probability': 'Probability',
};

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
      .eq('course', 'cbse10-maths');

    if (error) return NextResponse.json({ error: 'Failed to fetch analytics' }, { status: 500 });

    const rows = data ?? [];
    const domainStats = new Map<string, { attempted: number; correct: number }>();

    for (const row of rows) {
      const d = (row.domain as string) ?? 'unknown';
      if (!domainStats.has(d)) domainStats.set(d, { attempted: 0, correct: 0 });
      const s = domainStats.get(d)!;
      s.attempted++;
      if (row.is_correct) s.correct++;
    }

    const chapters = [...domainStats.entries()]
      .map(([domain, stats]) => ({
        domain,
        label: DOMAIN_LABELS[domain] ?? domain,
        attempted: stats.attempted,
        correct: stats.correct,
        accuracy: stats.attempted > 0 ? Math.round((stats.correct / stats.attempted) * 100) : 0,
      }))
      .sort((a, b) => b.attempted - a.attempted);

    const withData = chapters.filter((c) => c.attempted >= 3);
    const sorted = [...withData].sort((a, b) => a.accuracy - b.accuracy);
    const weakest = sorted.slice(0, 3).map((c) => c.domain);
    const strongest = sorted.slice(-3).reverse().map((c) => c.domain);

    const totalAttempted = rows.length;
    const totalCorrect = rows.filter((r) => r.is_correct).length;

    return NextResponse.json({ chapters, weakest, strongest, totalAttempted, totalCorrect });
  } catch (error) {
    console.error('Error in GET /api/cbse10-maths/analytics:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

import { NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

/**
 * GET /api/admin/sat-questions/stats
 * Returns pending QC counts by section (math / rw).
 */
export async function GET() {
  try {
    const supabase = createSupabaseApiClient();

    const [mathResult, rwResult] = await Promise.all([
      supabase
        .from('sat_questions')
        .select('*', { count: 'exact', head: true })
        .eq('is_active', true)
        .eq('qc_done', false)
        .eq('section', 'math'),
      supabase
        .from('sat_questions')
        .select('*', { count: 'exact', head: true })
        .eq('is_active', true)
        .eq('qc_done', false)
        .eq('section', 'rw'),
    ]);

    if (mathResult.error || rwResult.error) {
      console.error('Error fetching SAT QC stats:', mathResult.error ?? rwResult.error);
      return NextResponse.json({ error: 'Failed to fetch stats' }, { status: 500 });
    }

    const math = mathResult.count ?? 0;
    const rw = rwResult.count ?? 0;

    return NextResponse.json({ pending: { math, rw, total: math + rw } });
  } catch (err) {
    console.error('Error in GET /api/admin/sat-questions/stats:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

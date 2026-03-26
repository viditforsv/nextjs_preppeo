import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { applyFilters, shuffle, toQuestion, checkPremium, getDailyUsage } from '@/lib/ibdp-maths-api-helpers';

const TABLE = 'ibdp_aa_sl_questions';
const COURSE = 'ibdp-aa-sl';

export async function GET(request: NextRequest) {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Authentication required' }, { status: 401 });

    const supabase = createSupabaseApiClient();
    const isPremium = await checkPremium(supabase, user.id);
    const dailyUsage = isPremium ? null : await getDailyUsage(supabase, user.id, COURSE);

    const { searchParams } = new URL(request.url);
    const params = {
      count: searchParams.get('count'),
      domains: searchParams.get('domains'),
      chapters: searchParams.get('chapters'),
      subtopics: searchParams.get('subtopics'),
      difficulty: searchParams.get('difficulty'),
    };

    let query = supabase
      .from(TABLE)
      .select('id, type, prompt, options, correct_answer, explanation, domain, difficulty_tier, chapter, subtopic, image_url')
      .eq('is_active', true);

    try {
      query = applyFilters(query, params, isPremium, dailyUsage);
    } catch (err) {
      const msg = err instanceof Error ? err.message : '';
      if (msg === 'daily_limit_reached') {
        return NextResponse.json({ error: 'daily_limit_reached' }, { status: 403 });
      }
      throw err;
    }

    const { data, error } = await query;
    if (error) return NextResponse.json({ error: 'Failed to fetch questions' }, { status: 500 });

    const count = Math.min(parseInt(params.count ?? '10', 10), 50);
    const questions = shuffle(data ?? []).slice(0, count).map(toQuestion);

    return NextResponse.json({ questions });
  } catch (err) {
    console.error(`Error in GET /api/${COURSE}/practice-questions:`, err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

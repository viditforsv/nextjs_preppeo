import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import type { SATQuestion, SATQuestionType, SATSection, DifficultyTier, SATDomain, SATQuestionOption } from '@/types/sat-test';

const FIELDS = 'id, type, prompt, passage, options, correct_answer, explanation, domain, difficulty_tier, image_url, section';

const FREE_LIMITS = { easy: 2, medium: 2, hard: 1 } as const;

function shuffle<T>(arr: T[]): T[] {
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

function toOptions(val: unknown): SATQuestionOption[] | undefined {
  if (!val) return undefined;
  if (Array.isArray(val)) return val as SATQuestionOption[];
  const rec = val as Record<string, string>;
  return Object.entries(rec).map(([id, text]) => ({ id, text }));
}

function toQuestion(row: Record<string, unknown>, fallbackSection: string): SATQuestion {
  return {
    id: row.id as string,
    type: (row.type as string) as SATQuestionType,
    section: ((row.section as string) ?? fallbackSection) as SATSection,
    difficulty: (row.difficulty_tier as string) as DifficultyTier,
    domain: (row.domain as string) as SATDomain | undefined ?? undefined,
    prompt: row.prompt as string,
    passage: (row.passage as string) ?? undefined,
    options: toOptions(row.options),
    correctAnswer: row.correct_answer as string,
    explanation: (row.explanation as string) ?? '',
    imageUrl: (row.image_url as string) ?? undefined,
  };
}

async function checkPremium(supabase: ReturnType<typeof createSupabaseApiClient>, userId: string): Promise<boolean> {
  const { data } = await supabase
    .from('user_subscriptions')
    .select('id')
    .eq('user_id', userId)
    .eq('is_active', true)
    .gte('ends_at', new Date().toISOString())
    .limit(1)
    .maybeSingle();
  return !!data;
}

async function getDailyUsage(supabase: ReturnType<typeof createSupabaseApiClient>, userId: string) {
  const today = new Date().toISOString().slice(0, 10);
  const { data } = await supabase
    .from('practice_daily_usage')
    .select('id, easy_used, medium_used, hard_used')
    .eq('user_id', userId)
    .eq('usage_date', today)
    .maybeSingle();

  return data ?? { id: null, easy_used: 0, medium_used: 0, hard_used: 0 };
}

/**
 * GET /api/sat/practice-questions?section=rw&domains=...&difficulty=medium&count=10
 * Auth required. Freemium users get 5/day (2E+2M+1H). Premium users get unlimited.
 */
export async function GET(request: NextRequest) {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) {
      return NextResponse.json({ error: 'Authentication required' }, { status: 401 });
    }

    const { searchParams } = new URL(request.url);
    const section = searchParams.get('section');
    const domainsParam = searchParams.get('domains');
    const difficulty = searchParams.get('difficulty') ?? 'mixed';
    const count = Math.min(parseInt(searchParams.get('count') ?? '10', 10) || 10, 30);

    if (!section || !['math', 'rw'].includes(section)) {
      return NextResponse.json(
        { error: 'section is required and must be "math" or "rw"' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseApiClient();
    const isPremium = await checkPremium(supabase, user.id);

    if (isPremium) {
      return handlePremium(supabase, section, domainsParam, difficulty, count);
    }

    return handleFreemium(supabase, user.id, section, domainsParam);
  } catch (error) {
    console.error('Error in GET /api/sat/practice-questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

async function handlePremium(
  supabase: ReturnType<typeof createSupabaseApiClient>,
  section: string,
  domainsParam: string | null,
  difficulty: string,
  count: number,
) {
  let query = supabase.from('sat_questions').select(FIELDS).eq('section', section).eq('is_active', true);

  if (domainsParam) {
    const domains = domainsParam.split(',').filter(Boolean);
    if (domains.length > 0) query = query.in('domain', domains);
  }
  if (difficulty && difficulty !== 'mixed') {
    query = query.eq('difficulty_tier', difficulty);
  }

  const { data, error } = await query;
  if (error) return NextResponse.json({ error: 'Failed to fetch questions' }, { status: 500 });
  if (!data?.length) return NextResponse.json({ error: 'No questions found for these filters' }, { status: 404 });

  const selected = shuffle(data).slice(0, count);
  return NextResponse.json({ questions: selected.map((r) => toQuestion(r, section)), isPremium: true });
}

async function handleFreemium(
  supabase: ReturnType<typeof createSupabaseApiClient>,
  userId: string,
  section: string,
  domainsParam: string | null,
) {
  const usage = await getDailyUsage(supabase, userId);
  const remaining = {
    easy: Math.max(0, FREE_LIMITS.easy - usage.easy_used),
    medium: Math.max(0, FREE_LIMITS.medium - usage.medium_used),
    hard: Math.max(0, FREE_LIMITS.hard - usage.hard_used),
  };

  const totalRemaining = remaining.easy + remaining.medium + remaining.hard;
  if (totalRemaining === 0) {
    return NextResponse.json(
      { error: 'daily_limit_reached', remaining: { easy: 0, medium: 0, hard: 0 } },
      { status: 403 }
    );
  }

  let baseQuery = supabase.from('sat_questions').select(FIELDS).eq('section', section).eq('is_active', true);
  if (domainsParam) {
    const domains = domainsParam.split(',').filter(Boolean);
    if (domains.length > 0) baseQuery = baseQuery.in('domain', domains);
  }

  const questions: SATQuestion[] = [];

  for (const tier of ['easy', 'medium', 'hard'] as const) {
    const need = remaining[tier];
    if (need <= 0) continue;

    const { data } = await supabase
      .from('sat_questions')
      .select(FIELDS)
      .eq('section', section)
      .eq('is_active', true)
      .eq('difficulty_tier', tier)
      .then((res) => {
        if (domainsParam) {
          const domains = domainsParam.split(',').filter(Boolean);
          if (domains.length && res.data) {
            return { ...res, data: res.data.filter((q) => domains.includes(q.domain as string)) };
          }
        }
        return res;
      });

    if (data?.length) {
      shuffle(data).slice(0, need).forEach((r) => questions.push(toQuestion(r, section)));
    }
  }

  if (questions.length === 0) {
    return NextResponse.json({ error: 'No questions found for these filters' }, { status: 404 });
  }

  // Update daily usage
  const today = new Date().toISOString().slice(0, 10);
  const served = { easy: 0, medium: 0, hard: 0 };
  questions.forEach((q) => {
    const d = q.difficulty as 'easy' | 'medium' | 'hard';
    if (d in served) served[d]++;
  });

  if (usage.id) {
    await supabase
      .from('practice_daily_usage')
      .update({
        easy_used: usage.easy_used + served.easy,
        medium_used: usage.medium_used + served.medium,
        hard_used: usage.hard_used + served.hard,
      })
      .eq('id', usage.id);
  } else {
    await supabase.from('practice_daily_usage').insert({
      user_id: userId,
      usage_date: today,
      easy_used: served.easy,
      medium_used: served.medium,
      hard_used: served.hard,
    });
  }

  const newRemaining = {
    easy: remaining.easy - served.easy,
    medium: remaining.medium - served.medium,
    hard: remaining.hard - served.hard,
  };

  return NextResponse.json({
    questions: shuffle(questions),
    isPremium: false,
    remaining: newRemaining,
  });
}

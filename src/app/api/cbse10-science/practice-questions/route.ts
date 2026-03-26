import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import type { CBSE10ScienceQuestion, QuestionType, CBSE10ScienceDomain, DifficultyTier, QuestionOption } from '@/types/cbse10-science';

const TABLE = 'cbse10_science_questions';
const FIELDS = 'id, type, prompt, options, correct_answer, explanation, domain, difficulty_tier, image_url, chapter, subtopic, is_pyq, pyq_year, correct_answer_b';
const FREE_LIMITS = { easy: 2, medium: 2, hard: 1 } as const;
const GRACE_MS = 30 * 60 * 1000;

function applyFilters<T extends { in(column: string, values: readonly string[]): T }>(
  query: T,
  domainsParam: string | null,
  chaptersParam: string | null,
  subtopicsParam: string | null,
): T {
  let q = query;
  if (domainsParam) {
    const domains = domainsParam.split(',').filter(Boolean);
    if (domains.length > 0) q = q.in('domain', domains);
  }
  if (chaptersParam) {
    const chapters = chaptersParam.split(',').filter(Boolean);
    if (chapters.length > 0) q = q.in('chapter', chapters);
  }
  if (subtopicsParam) {
    const subtopics = subtopicsParam.split(',').filter(Boolean);
    if (subtopics.length > 0) q = q.in('subtopic', subtopics);
  }
  return q;
}

function shuffle<T>(arr: T[]): T[] {
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

function toOptions(val: unknown): QuestionOption[] | undefined {
  if (!val) return undefined;
  if (Array.isArray(val)) return val as QuestionOption[];
  const rec = val as Record<string, string>;
  return Object.entries(rec).map(([id, text]) => ({ id, text }));
}

function toQuestion(row: Record<string, unknown>): CBSE10ScienceQuestion {
  return {
    id: row.id as string,
    type: row.type as QuestionType,
    difficulty: row.difficulty_tier as DifficultyTier,
    domain: (row.domain as CBSE10ScienceDomain) ?? undefined,
    chapter: (row.chapter as string) ?? undefined,
    subtopic: (row.subtopic as string) ?? undefined,
    prompt: row.prompt as string,
    options: toOptions(row.options),
    correctAnswer: row.correct_answer as string,
    correctAnswerB: (row.correct_answer_b as string) ?? undefined,
    explanation: (row.explanation as string) ?? '',
    imageUrl: (row.image_url as string) ?? undefined,
    isPyq: (row.is_pyq as boolean) ?? false,
    pyqYear: (row.pyq_year as string) ?? undefined,
  };
}

async function checkFullAccess(supabase: ReturnType<typeof createSupabaseApiClient>, userId: string): Promise<boolean> {
  const [{ data: sub }, { data: profile }] = await Promise.all([
    supabase
      .from('user_subscriptions')
      .select('id')
      .eq('user_id', userId)
      .gte('ends_at', new Date(Date.now() - GRACE_MS).toISOString())
      .eq('is_active', true)
      .limit(1)
      .maybeSingle(),
    supabase.from('profiles').select('role').eq('id', userId).maybeSingle(),
  ]);
  return !!sub || profile?.role === 'admin';
}

export async function GET(request: NextRequest) {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Authentication required' }, { status: 401 });

    const { searchParams } = new URL(request.url);
    const domainsParam = searchParams.get('domains');
    const chaptersParam = searchParams.get('chapters');
    const subtopicsParam = searchParams.get('subtopics');
    const difficulty = searchParams.get('difficulty') ?? 'mixed';
    const count = Math.min(parseInt(searchParams.get('count') ?? '10', 10) || 10, 30);

    const supabase = createSupabaseApiClient();
    const isPremium = await checkFullAccess(supabase, user.id);

    if (isPremium) {
      let query = supabase.from(TABLE).select(FIELDS).eq('is_active', true).eq('is_flashcard', false);
      query = applyFilters(query, domainsParam, chaptersParam, subtopicsParam);
      if (difficulty && difficulty !== 'mixed') query = query.eq('difficulty_tier', difficulty);

      const { data, error } = await query;
      if (error) return NextResponse.json({ error: 'Failed to fetch questions' }, { status: 500 });
      if (!data?.length) return NextResponse.json({ error: 'No questions found for these filters' }, { status: 404 });

      return NextResponse.json({ questions: shuffle(data).slice(0, count).map(toQuestion), isPremium: true });
    }

    const today = new Date().toISOString().slice(0, 10);
    const { data: usage } = await supabase
      .from('practice_daily_usage')
      .select('easy_used, medium_used, hard_used')
      .eq('user_id', user.id)
      .eq('usage_date', today)
      .eq('course', 'cbse10-science')
      .maybeSingle();

    const u = usage ?? { easy_used: 0, medium_used: 0, hard_used: 0 };
    const wantEasy = Math.max(0, FREE_LIMITS.easy - u.easy_used);
    const wantMedium = Math.max(0, FREE_LIMITS.medium - u.medium_used);
    const wantHard = Math.max(0, FREE_LIMITS.hard - u.hard_used);

    if (wantEasy + wantMedium + wantHard === 0) {
      return NextResponse.json({ error: 'daily_limit_reached', remaining: { easy: 0, medium: 0, hard: 0 } }, { status: 403 });
    }

    const questions: CBSE10ScienceQuestion[] = [];
    const served = { easy: 0, medium: 0, hard: 0 };

    for (const [tier, need] of [['easy', wantEasy], ['medium', wantMedium], ['hard', wantHard]] as const) {
      if (need <= 0) continue;
      let tierQuery = supabase.from(TABLE).select(FIELDS).eq('is_active', true).eq('is_flashcard', false).eq('difficulty_tier', tier);
      tierQuery = applyFilters(tierQuery, domainsParam, chaptersParam, subtopicsParam);
      const { data } = await tierQuery;
      if (data?.length) {
        const picked = shuffle(data).slice(0, need);
        picked.forEach((r) => questions.push(toQuestion(r)));
        served[tier] = picked.length;
      }
    }

    if (questions.length === 0) return NextResponse.json({ error: 'No questions found for these filters' }, { status: 404 });

    const { data: claimResult } = await supabase.rpc('claim_practice_usage', {
      p_user_id: user.id, p_date: today, p_easy: served.easy, p_medium: served.medium, p_hard: served.hard, p_course: 'cbse10-science',
    });

    const claim = Array.isArray(claimResult) ? claimResult[0] : claimResult;
    if (!claim?.ok) {
      return NextResponse.json({ error: 'daily_limit_reached', remaining: { easy: 0, medium: 0, hard: 0 } }, { status: 403 });
    }

    const newRemaining = {
      easy: Math.max(0, FREE_LIMITS.easy - ((claim.prev_easy ?? 0) + served.easy)),
      medium: Math.max(0, FREE_LIMITS.medium - ((claim.prev_medium ?? 0) + served.medium)),
      hard: Math.max(0, FREE_LIMITS.hard - ((claim.prev_hard ?? 0) + served.hard)),
    };

    return NextResponse.json({ questions: shuffle(questions), isPremium: false, remaining: newRemaining });
  } catch (error) {
    console.error('Error in GET /api/cbse10-science/practice-questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

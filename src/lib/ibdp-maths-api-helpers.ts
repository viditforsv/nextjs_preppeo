import type { SupabaseClient } from '@supabase/supabase-js';
import type { IBDPMathsQuestion } from '@/types/ibdp-maths';

const FREE_LIMITS = { easy: 2, medium: 2, hard: 1 } as const;

export interface PracticeQueryParams {
  count?: string | null;
  domains?: string | null;
  chapters?: string | null;
  subtopics?: string | null;
  difficulty?: string | null;
}

export function applyFilters(
  // eslint-disable-next-line @typescript-eslint/no-explicit-any -- PostgrestFilterBuilder row type differs per IBDP table
  query: any,
  params: PracticeQueryParams,
  isPremium: boolean,
  dailyUsage: { easy_used: number; medium_used: number; hard_used: number } | null
) {
  if (params.domains) {
    query = query.in('domain', params.domains.split(','));
  }
  if (params.chapters) {
    query = query.in('chapter', params.chapters.split(','));
  }
  if (params.subtopics) {
    query = query.in('subtopic', params.subtopics.split(','));
  }

  if (!isPremium) {
    const used = dailyUsage ?? { easy_used: 0, medium_used: 0, hard_used: 0 };
    const remaining = {
      easy: Math.max(0, FREE_LIMITS.easy - used.easy_used),
      medium: Math.max(0, FREE_LIMITS.medium - used.medium_used),
      hard: Math.max(0, FREE_LIMITS.hard - used.hard_used),
    };
    const totalRemaining = remaining.easy + remaining.medium + remaining.hard;
    if (totalRemaining === 0) {
      throw new Error('daily_limit_reached');
    }
    const allowedTiers: string[] = [];
    if (remaining.easy > 0) allowedTiers.push('easy');
    if (remaining.medium > 0) allowedTiers.push('medium');
    if (remaining.hard > 0) allowedTiers.push('hard');
    query = query.in('difficulty_tier', allowedTiers);
  } else if (params.difficulty && params.difficulty !== 'mixed') {
    query = query.eq('difficulty_tier', params.difficulty);
  }

  return query;
}

export function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

export function toQuestion(row: Record<string, unknown>): IBDPMathsQuestion {
  return {
    id: row.id as string,
    type: row.type as IBDPMathsQuestion['type'],
    difficulty: row.difficulty_tier as IBDPMathsQuestion['difficulty'],
    domain: (row.domain as IBDPMathsQuestion['domain']) ?? undefined,
    chapter: (row.chapter as string) ?? undefined,
    subtopic: (row.subtopic as string) ?? undefined,
    prompt: row.prompt as string,
    options: (row.options as IBDPMathsQuestion['options']) ?? undefined,
    correctAnswer: row.correct_answer as string,
    explanation: (row.explanation as string) ?? '',
    imageUrl: (row.image_url as string) ?? undefined,
  };
}

export async function checkPremium(
  supabase: SupabaseClient,
  userId: string
): Promise<boolean> {
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

export async function getDailyUsage(
  supabase: SupabaseClient,
  userId: string,
  course: string
) {
  const today = new Date().toISOString().slice(0, 10);
  const { data } = await supabase
    .from('practice_daily_usage')
    .select('easy_used, medium_used, hard_used')
    .eq('user_id', userId)
    .eq('usage_date', today)
    .eq('course', course)
    .maybeSingle();
  return data;
}

export function buildFreeLimits(
  usage: { easy_used: number; medium_used: number; hard_used: number } | null
) {
  const used = usage ?? { easy_used: 0, medium_used: 0, hard_used: 0 };
  return {
    easy: Math.max(0, FREE_LIMITS.easy - used.easy_used),
    medium: Math.max(0, FREE_LIMITS.medium - used.medium_used),
    hard: Math.max(0, FREE_LIMITS.hard - used.hard_used),
  };
}

import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import type { CBSE10ScienceQuestion, QuestionType, CBSE10ScienceDomain, DifficultyTier, QuestionOption } from '@/types/cbse10-science';

const TABLE = 'cbse10_science_questions';
const FIELDS = 'id, type, prompt, options, correct_answer, explanation, domain, difficulty_tier, image_url, chapter, subtopic, is_pyq, pyq_year, correct_answer_b';

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

export async function GET(request: NextRequest) {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Authentication required' }, { status: 401 });

    const { searchParams } = new URL(request.url);
    const domainsParam = searchParams.get('domains');
    const chaptersParam = searchParams.get('chapters');
    const count = Math.min(parseInt(searchParams.get('count') ?? '15', 10) || 15, 50);

    const supabase = createSupabaseApiClient();

    let query = supabase
      .from(TABLE)
      .select(FIELDS)
      .eq('is_active', true)
      .eq('is_flashcard', true);

    if (domainsParam) {
      const domains = domainsParam.split(',').filter(Boolean);
      if (domains.length > 0) query = query.in('domain', domains);
    }
    if (chaptersParam) {
      const chapters = chaptersParam.split(',').filter(Boolean);
      if (chapters.length > 0) query = query.in('chapter', chapters);
    }

    const { data, error } = await query;
    if (error) return NextResponse.json({ error: 'Failed to fetch flashcards' }, { status: 500 });
    if (!data?.length) return NextResponse.json({ error: 'No flashcards found for these filters' }, { status: 404 });

    const cards = shuffle(data).slice(0, count).map(toQuestion);
    return NextResponse.json({ cards });
  } catch (error) {
    console.error('Error in GET /api/cbse10-science/flashcards:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

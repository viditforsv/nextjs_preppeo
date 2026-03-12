import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import type { SATQuestion } from '@/types/sat-test';

/**
 * GET /api/sat/practice-questions?section=rw&domains=craft-structure,information-ideas&difficulty=medium&count=10
 */
export async function GET(request: NextRequest) {
  try {
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

    let query = supabase
      .from('sat_questions')
      .select('id, type, prompt, passage, options, correct_answer, explanation, domain, difficulty_tier, image_url, section')
      .eq('section', section)
      .eq('is_active', true);

    if (domainsParam) {
      const domains = domainsParam.split(',').filter(Boolean);
      if (domains.length > 0) {
        query = query.in('domain', domains);
      }
    }

    if (difficulty && difficulty !== 'mixed') {
      query = query.eq('difficulty_tier', difficulty);
    }

    const { data, error } = await query;

    if (error) {
      console.error('Error fetching practice questions:', error);
      return NextResponse.json({ error: 'Failed to fetch questions' }, { status: 500 });
    }

    if (!data || data.length === 0) {
      return NextResponse.json({ error: 'No questions found for these filters' }, { status: 404 });
    }

    // Shuffle and take `count`
    for (let i = data.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [data[i], data[j]] = [data[j], data[i]];
    }

    const selected = data.slice(0, count);

    const questions: SATQuestion[] = selected.map((row) => ({
      id: row.id,
      type: row.type,
      section: row.section ?? section,
      difficulty: row.difficulty_tier,
      domain: row.domain ?? undefined,
      prompt: row.prompt,
      passage: row.passage ?? undefined,
      options: row.options ?? undefined,
      correctAnswer: row.correct_answer,
      explanation: row.explanation ?? '',
      imageUrl: row.image_url ?? undefined,
    }));

    return NextResponse.json({ questions });
  } catch (error) {
    console.error('Error in GET /api/sat/practice-questions:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

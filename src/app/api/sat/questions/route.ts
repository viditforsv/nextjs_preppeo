import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import type { SATQuestion } from '@/types/sat-test';

/**
 * GET /api/sat/questions?section=math&module=1&set=1
 * GET /api/sat/questions?section=rw&module=2&set=1&difficulty=hard
 */
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const section = searchParams.get('section');
    const mod = searchParams.get('module');
    const set = searchParams.get('set');
    const difficulty = searchParams.get('difficulty');

    if (!section || !mod || !set) {
      return NextResponse.json(
        { error: 'section, module, and set are required query parameters' },
        { status: 400 }
      );
    }

    if (!['math', 'rw'].includes(section)) {
      return NextResponse.json(
        { error: 'section must be "math" or "rw"' },
        { status: 400 }
      );
    }

    const moduleNum = parseInt(mod, 10);
    const setNum = parseInt(set, 10);

    if (![1, 2].includes(moduleNum) || isNaN(setNum)) {
      return NextResponse.json(
        { error: 'Invalid module or set value' },
        { status: 400 }
      );
    }

    if (moduleNum === 2 && !difficulty) {
      return NextResponse.json(
        { error: 'difficulty is required for module 2' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseApiClient();

    let query = supabase
      .from('sat_questions')
      .select('id, type, prompt, passage, options, correct_answer, explanation, domain, difficulty_tier, image_url, section')
      .eq('section', section)
      .eq('module_number', moduleNum)
      .eq('set_number', setNum)
      .eq('is_active', true);

    if (moduleNum === 2) {
      query = query.eq('difficulty_tier', difficulty!);
    }

    const { data, error } = await query;

    if (error) {
      console.error('Error fetching SAT questions:', error);
      return NextResponse.json(
        { error: 'Failed to fetch questions' },
        { status: 500 }
      );
    }

    if (!data || data.length === 0) {
      return NextResponse.json(
        { error: 'No questions found for this section/set' },
        { status: 404 }
      );
    }

    const questions: SATQuestion[] = data.map((row) => ({
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
    console.error('Error in GET /api/sat/questions:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import type { SATQuestion } from '@/types/sat-test';

/**
 * GET /api/sat/questions?module=1&set=1
 * GET /api/sat/questions?module=2&set=1&difficulty=hard
 */
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const mod = searchParams.get('module');
    const set = searchParams.get('set');
    const difficulty = searchParams.get('difficulty');

    if (!mod || !set) {
      return NextResponse.json(
        { error: 'module and set are required query parameters' },
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
      .select('id, type, prompt, options, correct_answer, explanation, domain, difficulty_tier, image_url')
      .eq('module_number', moduleNum)
      .eq('set_number', setNum)
      .eq('is_active', true);

    // Module 2 filters by adaptive difficulty
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
        { error: 'No questions found for this set' },
        { status: 404 }
      );
    }

    const questions: SATQuestion[] = data.map((row) => ({
      id: row.id,
      type: row.type,
      difficulty: row.difficulty_tier,
      domain: row.domain ?? undefined,
      prompt: row.prompt,
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

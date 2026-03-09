import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { GREQuestion } from '@/types/gre-test';

/**
 * GET /api/gre/questions?section=1&set=2
 * GET /api/gre/questions?section=2&set=2&difficulty=hard
 */
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const section = searchParams.get('section');
    const set = searchParams.get('set');
    const difficulty = searchParams.get('difficulty');

    if (!section || !set) {
      return NextResponse.json(
        { error: 'section and set are required query parameters' },
        { status: 400 }
      );
    }

    const sectionNum = parseInt(section, 10);
    const setNum = parseInt(set, 10);

    if (![1, 2].includes(sectionNum) || isNaN(setNum)) {
      return NextResponse.json(
        { error: 'Invalid section or set value' },
        { status: 400 }
      );
    }

    if (sectionNum === 2 && !difficulty) {
      return NextResponse.json(
        { error: 'difficulty is required for section 2' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseApiClient();

    let query = supabase
      .from('gre_questions')
      .select('id, type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, topics, image_url')
      .eq('section_number', sectionNum)
      .eq('set_number', setNum)
      .eq('is_active', true);

    if (sectionNum === 1) {
      query = query.eq('difficulty_tier', 'medium');
    } else {
      query = query.eq('difficulty_tier', difficulty!);
    }

    const { data, error } = await query;

    if (error) {
      console.error('Error fetching GRE questions:', error);
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

    const questions: GREQuestion[] = data.map((row) => ({
      id: row.id,
      type: row.type,
      difficulty: row.difficulty_tier,
      prompt: row.prompt,
      options: row.options ?? undefined,
      quantityA: row.quantity_a ?? undefined,
      quantityB: row.quantity_b ?? undefined,
      quantityInfo: row.quantity_info ?? undefined,
      correctAnswer: row.correct_answer,
      explanation: row.explanation ?? '',
      topics: row.topics ?? undefined,
      imageUrl: row.image_url ?? undefined,
    }));

    return NextResponse.json({ questions });
  } catch (error) {
    console.error('Error in GET /api/gre/questions:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

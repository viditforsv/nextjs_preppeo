import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { AshokaQuestion } from '@/types/ashoka-test';

/**
 * GET /api/ashoka/questions?set=1
 */
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const set = searchParams.get('set');

    if (!set) {
      return NextResponse.json(
        { error: 'set is a required query parameter' },
        { status: 400 }
      );
    }

    const setNum = parseInt(set, 10);
    if (isNaN(setNum)) {
      return NextResponse.json(
        { error: 'Invalid set value' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseApiClient();

    const { data, error } = await supabase
      .from('ashoka_questions')
      .select('id, type, section_type, prompt, options, correct_answer, explanation')
      .eq('set_number', setNum)
      .eq('is_active', true);

    if (error) {
      console.error('Error fetching Ashoka questions:', error);
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

    const questions: AshokaQuestion[] = data.map((row) => ({
      id: row.id,
      type: row.type,
      sectionType: row.section_type,
      prompt: row.prompt,
      options: row.options ?? [],
      correctAnswer: row.correct_answer,
      explanation: row.explanation ?? '',
    }));

    return NextResponse.json({ questions });
  } catch (error) {
    console.error('Error in GET /api/ashoka/questions:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

import { NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function GET() {
  try {
    const supabase = createSupabaseApiClient();

    const { data, error } = await supabase
      .from('gre_questions')
      .select(
        'id, type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, topics, section_number, set_number, image_url'
      )
      .eq('is_active', true)
      .order('section_number')
      .order('set_number')
      .order('difficulty_tier');

    if (error) {
      console.error('Error fetching GRE questions:', error);
      return NextResponse.json(
        { error: 'Failed to fetch questions' },
        { status: 500 }
      );
    }

    const questions = (data ?? []).map((row) => ({
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
      sectionNumber: row.section_number,
      setNumber: row.set_number,
    }));

    return NextResponse.json({ questions });
  } catch (err) {
    console.error('Error in GET /api/admin/gre-questions:', err);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

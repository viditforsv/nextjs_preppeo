import { NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function GET() {
  try {
    const supabase = createSupabaseApiClient();

    const { data, error } = await supabase
      .from('sat_questions')
      .select(
        'id, type, section, prompt, passage, options, correct_answer, explanation, domain, difficulty_tier, module_number, set_number, image_url'
      )
      .eq('is_active', true)
      .order('section')
      .order('module_number')
      .order('set_number')
      .order('difficulty_tier');

    if (error) {
      console.error('Error fetching SAT questions:', error);
      return NextResponse.json({ error: 'Failed to fetch questions' }, { status: 500 });
    }

    const questions = (data ?? []).map((row) => ({
      id: row.id,
      type: row.type,
      section: row.section,
      difficulty: row.difficulty_tier,
      domain: row.domain ?? undefined,
      prompt: row.prompt,
      passage: row.passage ?? undefined,
      options: row.options ?? undefined,
      correctAnswer: row.correct_answer,
      explanation: row.explanation ?? '',
      imageUrl: row.image_url ?? undefined,
      moduleNumber: row.module_number,
      setNumber: row.set_number,
    }));

    return NextResponse.json({ questions });
  } catch (err) {
    console.error('Error in GET /api/admin/sat-questions:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

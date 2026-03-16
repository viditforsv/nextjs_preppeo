import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function GET() {
  try {
    const supabase = createSupabaseApiClient();

    const { data, error } = await supabase
      .from('sat_questions')
      .select(
        'id, type, section, prompt, passage, options, correct_answer, explanation, domain, difficulty_tier, module_number, set_number, image_url, ai_explanation, ai_theory, qc_done'
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
      aiExplanation: row.ai_explanation ?? undefined,
      aiTheory: row.ai_theory ?? undefined,
      qcDone: row.qc_done ?? false,
    }));

    return NextResponse.json({ questions });
  } catch (err) {
    console.error('Error in GET /api/admin/sat-questions:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

const ALLOWED_FIELDS: Record<string, string> = {
  prompt: 'prompt',
  passage: 'passage',
  explanation: 'explanation',
  correctAnswer: 'correct_answer',
  section: 'section',
  domain: 'domain',
  difficulty: 'difficulty_tier',
  type: 'type',
  moduleNumber: 'module_number',
  setNumber: 'set_number',
  aiExplanation: 'ai_explanation',
  aiTheory: 'ai_theory',
  qcDone: 'qc_done',
};

export async function PATCH(request: NextRequest) {
  try {
    const body = await request.json();
    const { questionId, ...fields } = body;

    if (!questionId) {
      return NextResponse.json({ error: 'questionId is required' }, { status: 400 });
    }

    const updateData: Record<string, unknown> = {};
    for (const [key, value] of Object.entries(fields)) {
      const dbCol = ALLOWED_FIELDS[key];
      if (dbCol) {
        updateData[dbCol] = value === '' ? null : value;
      }
    }

    if (Object.keys(updateData).length === 0) {
      return NextResponse.json({ error: 'No valid fields to update' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();
    const { error } = await supabase
      .from('sat_questions')
      .update(updateData)
      .eq('id', questionId);

    if (error) {
      console.error('Error updating SAT question:', error);
      return NextResponse.json({ error: 'Failed to update question' }, { status: 500 });
    }

    return NextResponse.json({ success: true });
  } catch (err) {
    console.error('Error in PATCH /api/admin/sat-questions:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

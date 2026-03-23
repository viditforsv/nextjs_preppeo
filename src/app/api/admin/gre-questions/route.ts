import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { getCurrentEnvironment } from '@/lib/supabase/env';

const PROD_WRITE_ERROR = NextResponse.json(
  { error: 'Editing is disabled in production. Use Dev for QC.' },
  { status: 403 }
);

export async function GET() {
  try {
    const supabase = createSupabaseApiClient();

    const { data, error } = await supabase
      .from('gre_questions')
      .select(
        'id, type, prompt, options, correct_answer, explanation, quantity_a, quantity_b, quantity_info, difficulty_tier, topics, section_number, set_number, image_url, ai_explanation, ai_theory, qc_done'
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
      correctAnswer: row.type === 'multi-select'
        ? JSON.parse(row.correct_answer)
        : row.correct_answer,
      explanation: row.explanation ?? '',
      topics: row.topics ?? undefined,
      imageUrl: row.image_url ?? undefined,
      sectionNumber: row.section_number,
      setNumber: row.set_number,
      aiExplanation: row.ai_explanation ?? undefined,
      aiTheory: row.ai_theory ?? undefined,
      qcDone: row.qc_done ?? false,
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

const ALLOWED_FIELDS: Record<string, string> = {
  prompt: 'prompt',
  explanation: 'explanation',
  correctAnswer: 'correct_answer',
  options: 'options',
  difficulty: 'difficulty_tier',
  type: 'type',
  sectionNumber: 'section_number',
  setNumber: 'set_number',
  quantityA: 'quantity_a',
  quantityB: 'quantity_b',
  quantityInfo: 'quantity_info',
  topics: 'topics',
  aiExplanation: 'ai_explanation',
  aiTheory: 'ai_theory',
  qcDone: 'qc_done',
};

export async function PATCH(request: NextRequest) {
  if (getCurrentEnvironment() === 'prod') return PROD_WRITE_ERROR;
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
      .from('gre_questions')
      .update(updateData)
      .eq('id', questionId);

    if (error) {
      console.error('Error updating GRE question:', error);
      return NextResponse.json({ error: 'Failed to update question' }, { status: 500 });
    }

    return NextResponse.json({ success: true });
  } catch (err) {
    console.error('Error in PATCH /api/admin/gre-questions:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

export async function DELETE(request: NextRequest) {
  if (getCurrentEnvironment() === 'prod') return PROD_WRITE_ERROR;
  try {
    const body = await request.json();
    const { questionId } = body;

    if (!questionId) {
      return NextResponse.json({ error: 'questionId is required' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();
    const { error } = await supabase
      .from('gre_questions')
      .update({ is_active: false })
      .eq('id', questionId);

    if (error) {
      console.error('Error deleting GRE question:', error);
      return NextResponse.json({ error: 'Failed to delete question' }, { status: 500 });
    }

    return NextResponse.json({ success: true });
  } catch (err) {
    console.error('Error in DELETE /api/admin/gre-questions:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

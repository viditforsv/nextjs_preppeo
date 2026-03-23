import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function GET() {
  try {
    const supabase = await createClient();
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();

    if (authError || !user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const serviceClient = createSupabaseApiClient();
    const { data, error } = await serviceClient
      .from('gre_test_attempts')
      .select(
        'id, set_number, estimated_score, total_correct, total_questions, score_pct, section2_tier, completed_at'
      )
      .eq('user_id', user.id)
      .order('completed_at', { ascending: false });

    if (error) {
      console.error('Error fetching GRE attempts:', error);
      return NextResponse.json({ error: 'Failed to fetch attempts' }, { status: 500 });
    }

    return NextResponse.json(data);
  } catch (error) {
    console.error('Error in GET /api/gre/attempts:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

export async function POST(request: NextRequest) {
  try {
    const supabase = await createClient();
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();

    if (authError || !user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const body = await request.json();
    const {
      setNumber,
      section1Correct,
      section1Total,
      section1TimeUsed,
      section2Tier,
      section2Correct,
      section2Total,
      section2TimeUsed,
      totalCorrect,
      totalQuestions,
      scorePct,
      estimatedScore,
      questionResponses,
    } = body;

    if (
      setNumber === undefined ||
      section1Correct === undefined ||
      section1Total === undefined ||
      section1TimeUsed === undefined
    ) {
      return NextResponse.json(
        { error: 'Missing required section 1 fields' },
        { status: 400 }
      );
    }

    const serviceClient = createSupabaseApiClient();
    const { data, error } = await serviceClient
      .from('gre_test_attempts')
      .insert({
        user_id: user.id,
        set_number: setNumber,
        section1_correct: section1Correct,
        section1_total: section1Total,
        section1_time_used: section1TimeUsed,
        section2_tier: section2Tier ?? null,
        section2_correct: section2Correct ?? null,
        section2_total: section2Total ?? null,
        section2_time_used: section2TimeUsed ?? null,
        total_correct: totalCorrect,
        total_questions: totalQuestions,
        score_pct: scorePct,
        estimated_score: estimatedScore ?? null,
        question_responses: questionResponses ?? [],
      })
      .select('id')
      .single();

    if (error) {
      console.error('Error inserting GRE attempt:', error);
      return NextResponse.json({ error: 'Failed to save attempt' }, { status: 500 });
    }

    return NextResponse.json({ success: true, attemptId: data.id });
  } catch (error) {
    console.error('Error in POST /api/gre/attempts:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

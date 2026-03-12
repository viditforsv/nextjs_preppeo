import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';

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

    const { data, error } = await supabase
      .from('sat_test_attempts')
      .select(
        'id, section_type, set_number, estimated_score, rw_estimated_score, total_estimated_score, total_correct, total_questions, score_pct, completed_at'
      )
      .eq('user_id', user.id)
      .order('completed_at', { ascending: false });

    if (error) {
      console.error('Error fetching SAT attempts:', error);
      return NextResponse.json({ error: 'Failed to fetch attempts' }, { status: 500 });
    }

    return NextResponse.json(data);
  } catch (error) {
    console.error('Error in GET /api/sat/attempts:', error);
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
      tokenCode,
      setNumber,
      sectionType,
      // Math fields (also used for math-only backward compat)
      module1Correct,
      module1Total,
      module1TimeUsed,
      module2Tier,
      module2Correct,
      module2Total,
      module2TimeUsed,
      answersJson,
      estimatedScore,
      questionResponses,
      // R&W fields (for full test)
      rwModule1Correct,
      rwModule1Total,
      rwModule1TimeUsed,
      rwModule2Tier,
      rwModule2Correct,
      rwModule2Total,
      rwModule2TimeUsed,
      rwEstimatedScore,
      rwQuestionResponses,
      // Combined
      totalEstimatedScore,
    } = body;

    if (
      setNumber === undefined ||
      module1Correct === undefined ||
      module1Total === undefined ||
      module1TimeUsed === undefined
    ) {
      return NextResponse.json(
        { error: 'Missing required math module 1 fields' },
        { status: 400 }
      );
    }

    const mathCorrect = module1Correct + (module2Correct ?? 0);
    const rwCorrect = (rwModule1Correct ?? 0) + (rwModule2Correct ?? 0);
    const mathTotal = module1Total + (module2Total ?? 0);
    const rwTotal = (rwModule1Total ?? 0) + (rwModule2Total ?? 0);
    const totalCorrect = mathCorrect + rwCorrect;
    const totalQuestions = mathTotal + rwTotal;
    const scorePct = totalQuestions > 0 ? Math.round((totalCorrect / totalQuestions) * 10000) / 100 : 0;

    const { data, error } = await supabase
      .from('sat_test_attempts')
      .insert({
        user_id: user.id,
        token_code: tokenCode ?? null,
        set_number: setNumber,
        section_type: sectionType ?? 'math',
        // Math
        module1_correct: module1Correct,
        module1_total: module1Total,
        module1_time_used: module1TimeUsed,
        module2_tier: module2Tier ?? null,
        module2_correct: module2Correct ?? null,
        module2_total: module2Total ?? null,
        module2_time_used: module2TimeUsed ?? null,
        // R&W
        rw_module1_correct: rwModule1Correct ?? null,
        rw_module1_total: rwModule1Total ?? null,
        rw_module1_time_used: rwModule1TimeUsed ?? null,
        rw_module2_tier: rwModule2Tier ?? null,
        rw_module2_correct: rwModule2Correct ?? null,
        rw_module2_total: rwModule2Total ?? null,
        rw_module2_time_used: rwModule2TimeUsed ?? null,
        rw_estimated_score: rwEstimatedScore ?? null,
        rw_question_responses: rwQuestionResponses ?? [],
        // Totals
        total_correct: totalCorrect,
        total_questions: totalQuestions,
        score_pct: scorePct,
        answers_json: answersJson ?? {},
        estimated_score: estimatedScore ?? null,
        question_responses: questionResponses ?? [],
        total_estimated_score: totalEstimatedScore ?? null,
      })
      .select('id')
      .single();

    if (error) {
      console.error('Error inserting SAT attempt:', error);
      return NextResponse.json(
        { error: 'Failed to save attempt' },
        { status: 500 }
      );
    }

    return NextResponse.json({ success: true, attemptId: data.id });
  } catch (error) {
    console.error('Error in POST /api/sat/attempts:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

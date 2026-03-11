import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';

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
      module1Correct,
      module1Total,
      module1TimeUsed,
      module2Tier,
      module2Correct,
      module2Total,
      module2TimeUsed,
      answersJson,
    } = body;

    if (
      setNumber === undefined ||
      module1Correct === undefined ||
      module1Total === undefined ||
      module1TimeUsed === undefined
    ) {
      return NextResponse.json(
        { error: 'Missing required module 1 fields' },
        { status: 400 }
      );
    }

    const totalCorrect = module1Correct + (module2Correct ?? 0);
    const totalQuestions = module1Total + (module2Total ?? 0);
    const scorePct = totalQuestions > 0 ? Math.round((totalCorrect / totalQuestions) * 10000) / 100 : 0;

    const { data, error } = await supabase
      .from('sat_test_attempts')
      .insert({
        user_id: user.id,
        token_code: tokenCode ?? null,
        set_number: setNumber,
        module1_correct: module1Correct,
        module1_total: module1Total,
        module1_time_used: module1TimeUsed,
        module2_tier: module2Tier ?? null,
        module2_correct: module2Correct ?? null,
        module2_total: module2Total ?? null,
        module2_time_used: module2TimeUsed ?? null,
        total_correct: totalCorrect,
        total_questions: totalQuestions,
        score_pct: scorePct,
        answers_json: answersJson ?? {},
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

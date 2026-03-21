import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function POST(request: NextRequest) {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Authentication required' }, { status: 401 });

    const body = await request.json();
    const { questionId, bankItemId, answerGiven, isCorrect, domain, chapter, subtopic, difficultyTier, timeSpentMs } = body;

    if (!questionId || isCorrect === undefined) {
      return NextResponse.json({ error: 'Missing required fields' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();
    const { error } = await supabase.from('practice_answers').insert({
      user_id: user.id,
      course: 'sat',
      question_id: questionId,
      bank_item_id: bankItemId ?? null,
      answer_given: answerGiven ?? null,
      is_correct: isCorrect,
      domain: domain ?? null,
      chapter: chapter ?? null,
      subtopic: subtopic ?? null,
      difficulty_tier: difficultyTier ?? null,
      time_spent_ms: timeSpentMs ?? null,
    });

    if (error) {
      console.error('Error recording SAT answer:', error);
      return NextResponse.json({ error: 'Failed to record answer' }, { status: 500 });
    }

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Error in POST /api/sat/record-answer:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

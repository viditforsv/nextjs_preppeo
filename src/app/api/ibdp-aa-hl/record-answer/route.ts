import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

const COURSE = 'ibdp-aa-hl';

export async function POST(request: NextRequest) {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) return NextResponse.json({ error: 'Authentication required' }, { status: 401 });

    const body = await request.json();
    const { questionId, answerGiven, isCorrect, domain, chapter, subtopic, difficultyTier, timeSpentMs } = body;

    if (!questionId || isCorrect === undefined) {
      return NextResponse.json({ error: 'Missing required fields' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();
    const { error } = await supabase.from('practice_answers').insert({
      user_id: user.id,
      course: COURSE,
      question_id: questionId,
      answer_given: answerGiven ?? null,
      is_correct: isCorrect,
      domain: domain ?? null,
      chapter: chapter ?? null,
      subtopic: subtopic ?? null,
      difficulty_tier: difficultyTier ?? null,
      time_spent_ms: timeSpentMs ?? null,
    });

    if (error) {
      console.error('Error recording answer:', error);
      return NextResponse.json({ error: 'Failed to record answer' }, { status: 500 });
    }

    return NextResponse.json({ success: true });
  } catch (err) {
    console.error(`Error in POST /api/${COURSE}/record-answer:`, err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

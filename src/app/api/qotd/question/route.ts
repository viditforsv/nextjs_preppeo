import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import type { SATQuestionOption } from '@/types/sat-test';
import {
  QOTD_ROTATION,
  rotationIndexForDay,
  utcDayIndex,
} from '@/lib/qotd/questions';

function mapSatOptions(val: unknown): SATQuestionOption[] | undefined {
  if (!Array.isArray(val)) return undefined;
  return val.map((o) => {
    const rec = o as Record<string, unknown>;
    return {
      id: String(rec.id),
      text: String(rec.text ?? ''),
      imageUrl:
        (typeof rec.image_url === 'string' ? rec.image_url : undefined) ??
        (typeof rec.imageUrl === 'string' ? rec.imageUrl : undefined),
    };
  });
}

/**
 * GET /api/qotd/question
 * Returns today's Question of the Day, chosen by the UTC date so every visitor
 * worldwide sees the same question and it rolls over at 00:00 GMT.
 *
 * The full `explanation` (the AI Concept Breakdown) is intentionally NOT returned
 * here — it is the gated reward unlocked via POST /api/qotd/capture. We do return
 * `correctAnswer` so the page can grade the attempt instantly without a round-trip.
 *
 * Dev only: `?dayOffset=N` shifts the rotation by N days to test the rollover.
 */
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);

    let dayIndex = utcDayIndex();
    if (process.env.NODE_ENV !== 'production') {
      const offset = parseInt(searchParams.get('dayOffset') ?? '', 10);
      if (!isNaN(offset)) dayIndex += offset;
    }

    const rotationIndex = rotationIndexForDay(dayIndex);
    const entry = QOTD_ROTATION[rotationIndex];

    const supabase = createSupabaseApiClient();
    const { data, error } = await supabase
      .from('sat_questions')
      .select(
        'id, type, prompt, passage, options, correct_answer, domain, image_url, image_urls, section'
      )
      .eq('id', entry.id)
      .eq('is_active', true)
      .maybeSingle();

    if (error) {
      console.error('QOTD question fetch error:', error);
      return NextResponse.json({ error: 'Failed to load question' }, { status: 500 });
    }

    if (!data) {
      console.error(`QOTD question ${entry.id} not found / inactive`);
      return NextResponse.json({ error: 'Question unavailable' }, { status: 404 });
    }

    const question = {
      id: data.id,
      type: data.type,
      section: data.section ?? 'math',
      domain: data.domain ?? undefined,
      prompt: data.prompt,
      passage: data.passage ?? undefined,
      options: mapSatOptions(data.options),
      correctAnswer: data.correct_answer,
      imageUrl: data.image_url ?? undefined,
      imageUrls:
        Array.isArray(data.image_urls) && data.image_urls.length > 0
          ? data.image_urls
          : undefined,
    };

    return NextResponse.json({
      rotationIndex,
      topic: entry.topic,
      question,
    });
  } catch (err) {
    console.error('Error in GET /api/qotd/question:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

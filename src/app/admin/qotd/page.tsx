import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { getCurrentEnvironment } from '@/lib/supabase/env';
import { QOTD_ROTATION } from '@/lib/qotd/questions';
import type { SATQuestionOption } from '@/types/sat-test';
import QotdAdminClient, { type QotdAdminQuestion } from './QotdAdminClient';

// Read the questions fresh on every request so edits show on refresh.
export const dynamic = 'force-dynamic';

function mapSatOptions(val: unknown): SATQuestionOption[] {
  if (!Array.isArray(val)) return [];
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

export default async function QotdAdminPage() {
  const supabase = createSupabaseApiClient();
  const ids = QOTD_ROTATION.map((e) => e.id);

  const { data } = await supabase
    .from('sat_questions')
    .select(
      'id, type, prompt, passage, options, correct_answer, explanation, domain, image_url, image_urls'
    )
    .in('id', ids);

  const byId = new Map((data ?? []).map((row) => [row.id, row]));

  // Keep rotation order (0-6); flag any id that didn't resolve.
  const questions: QotdAdminQuestion[] = QOTD_ROTATION.map((entry, dayIndex) => {
    const row = byId.get(entry.id);
    return {
      dayIndex,
      topic: entry.topic,
      id: entry.id,
      found: Boolean(row),
      type: row?.type ?? 'mcq',
      domain: row?.domain ?? '',
      prompt: row?.prompt ?? '',
      passage: row?.passage ?? '',
      options: mapSatOptions(row?.options),
      correctAnswer: row?.correct_answer ?? '',
      explanation: row?.explanation ?? '',
      imageUrls:
        Array.isArray(row?.image_urls) && row!.image_urls.length > 0
          ? (row!.image_urls as string[])
          : row?.image_url
            ? [row.image_url as string]
            : [],
    };
  });

  return <QotdAdminClient questions={questions} environment={getCurrentEnvironment()} />;
}

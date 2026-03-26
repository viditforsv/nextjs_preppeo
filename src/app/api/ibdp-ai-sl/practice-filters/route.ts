import { NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

const TABLE = 'ibdp_ai_sl_questions';

interface FilterRow { domain: string; chapter: string | null; subtopic: string | null }

export async function GET() {
  try {
    const supabase = createSupabaseApiClient();
    const { data, error } = await supabase
      .from(TABLE)
      .select('domain, chapter, subtopic')
      .eq('is_active', true);

    if (error) return NextResponse.json({ error: 'Failed to fetch filters' }, { status: 500 });

    const rows = (data ?? []) as FilterRow[];
    const domainMap = new Map<string, Map<string, Set<string>>>();

    for (const row of rows) {
      if (!row.domain) continue;
      if (!domainMap.has(row.domain)) domainMap.set(row.domain, new Map());
      const chapterMap = domainMap.get(row.domain)!;
      const ch = row.chapter ?? '_none_';
      if (!chapterMap.has(ch)) chapterMap.set(ch, new Set());
      if (row.subtopic) chapterMap.get(ch)!.add(row.subtopic);
    }

    const domains = [...domainMap.entries()]
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([domainId, chapterMap]) => ({
        id: domainId,
        chapters: [...chapterMap.entries()]
          .filter(([ch]) => ch !== '_none_')
          .sort(([a], [b]) => a.localeCompare(b))
          .map(([name, subtopics]) => ({ name, subtopics: [...subtopics].sort() })),
      }));

    return NextResponse.json({ domains });
  } catch {
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

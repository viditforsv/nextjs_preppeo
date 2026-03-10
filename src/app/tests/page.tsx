import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import ExamCard from '@/components/tests/ExamCard';
import Link from 'next/link';
import { Ticket } from 'lucide-react';
import type { ExamType, TestToken } from '@/types/test-tokens';

export const metadata = {
  title: 'Test Hub | Preppeo',
  description: 'Computer-based test practice for GRE, SAT, GMAT, and more.',
};

export default async function TestsHubPage() {
  const supabase = createSupabaseApiClient();

  const { data: exams } = await supabase
    .from('exam_types')
    .select('*')
    .eq('is_active', true)
    .order('name');

  const { data: freeTokens } = await supabase
    .from('test_tokens')
    .select('code, exam_type')
    .eq('is_free', true)
    .eq('is_active', true);

  const freeTokenMap: Record<string, string> = {};
  for (const t of (freeTokens as TestToken[] | null) ?? []) {
    freeTokenMap[t.exam_type] = t.code;
  }

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="max-w-6xl mx-auto px-4 py-12">
        {/* Header */}
        <div className="text-center mb-10">
          <h1 className="text-3xl font-bold text-[#1a365d] mb-2">Test Hub</h1>
          <p className="text-gray-600 max-w-xl mx-auto">
            Practice with adaptive, timed mock tests that mirror the real exam experience.
            Every exam includes a free test — use the token below to get started.
          </p>
          <Link
            href="/tests/tokens"
            className="inline-flex items-center gap-2 mt-4 text-sm font-medium text-[#1a365d] hover:underline"
          >
            <Ticket className="w-4 h-4" />
            Buy more tokens
          </Link>
        </div>

        {/* Exam grid */}
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {((exams as ExamType[] | null) ?? []).map((exam) => (
            <ExamCard
              key={exam.id}
              exam={exam}
              freeCode={freeTokenMap[exam.id] ?? `${exam.id.toUpperCase()}-FREE-SET1`}
            />
          ))}
        </div>
      </div>
    </div>
  );
}

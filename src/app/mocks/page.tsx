import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import ExamCard from '@/components/tests/ExamCard';
import { Button } from '@/design-system/components/ui/button';
import Link from 'next/link';
import { Ticket, BookOpen, ArrowRight, Sparkles } from 'lucide-react';
import type { ExamType, TestToken } from '@/types/test-tokens';

export const metadata = {
  title: 'Mock Hub | Preppeo',
  description: 'Full-length adaptive mock tests for SAT, GRE, GMAT, and more.',
};

export default async function TestsHubPage() {
  const supabase = createSupabaseApiClient();

  const displayOrder = ['sat', 'gre', 'gmat', 'ashoka', 'flames', 'krea'];

  const { data: rawExams } = await supabase
    .from('exam_types')
    .select('*')
    .eq('is_active', true);

  const exams = ((rawExams as ExamType[] | null) ?? []).sort((a, b) => {
    const ai = displayOrder.indexOf(a.id.toLowerCase());
    const bi = displayOrder.indexOf(b.id.toLowerCase());
    return (ai === -1 ? 999 : ai) - (bi === -1 ? 999 : bi);
  });

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
          <h1 className="text-3xl font-bold text-[#1a365d] mb-2">Mock Hub</h1>
          <p className="text-gray-600 max-w-xl mx-auto">
            Premium adaptive mocks with detailed score reports.
            Your first mock is complimentary — claim it below to set realistic expectations.
          </p>
          <Link href="/mocks/tokens" className="inline-block mt-6">
            <Button
              size="lg"
              className="bg-[#1a365d] hover:bg-[#2a4a7f] text-white shadow-md gap-2"
            >
              <Ticket className="w-4 h-4" />
              Get More Mock Packs
            </Button>
          </Link>
        </div>

        {/* Practice Mode CTA */}
        <div className="mb-10 bg-white border border-gray-200 rounded-xl p-6">
          <div className="flex flex-col sm:flex-row items-start sm:items-center gap-4">
            <div className="w-12 h-12 rounded-lg bg-emerald-100 flex items-center justify-center shrink-0">
              <BookOpen className="w-6 h-6 text-emerald-600" />
            </div>
            <div className="flex-1">
              <h2 className="text-lg font-bold text-[#1a365d]">Practice Mode</h2>
              <p className="text-sm text-gray-600">
                5 free questions daily with AI explanations. Practice by topic and difficulty, then upgrade for unlimited access.
              </p>
            </div>
            <div className="flex gap-3 shrink-0">
              <Link
                href="/sat-test"
                className="inline-flex items-center gap-1.5 px-4 py-2.5 bg-emerald-600 text-white text-sm font-semibold rounded-lg hover:bg-emerald-700 transition-colors"
              >
                <BookOpen className="w-4 h-4" />
                Try Free Practice
              </Link>
              <Link
                href="/mocks/tokens"
                className="inline-flex items-center gap-1.5 px-4 py-2.5 border border-[#0d47a1] text-[#0d47a1] text-sm font-semibold rounded-lg hover:bg-[#0d47a1]/5 transition-colors"
              >
                <Sparkles className="w-4 h-4" />
                Upgrade
              </Link>
            </div>
          </div>
        </div>

        {/* Exam grid */}
        <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {exams.map((exam) => (
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

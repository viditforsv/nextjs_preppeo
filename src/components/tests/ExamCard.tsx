import Link from 'next/link';
import { ExternalLink, Gift, KeyRound } from 'lucide-react';
import type { ExamType } from '@/types/test-tokens';

interface ExamCardProps {
  exam: ExamType;
}

export default function ExamCard({ exam }: ExamCardProps) {
  const isReady = exam.id === 'sat';

  // Each user gets their own complimentary token via the claim flow; the hub
  // never displays a raw code (which would be either a broken shared code or
  // another user's personal token). /sat-free is idempotent — it returns the
  // user's existing free token or mints one, then drops them into the test.
  const claimHref = exam.id === 'sat' ? '/sat-free' : exam.test_route;

  return (
    <div className="bg-white border border-gray-200 rounded-xl overflow-hidden hover:shadow-lg transition-shadow">
      <div className="p-6">
        <div className="flex items-start justify-between mb-3">
          <h3 className="text-xl font-bold text-gray-900">{exam.name}</h3>
          {isReady ? (
            <span className="text-xs font-medium bg-emerald-100 text-emerald-700 px-2 py-1 rounded-full">
              Live
            </span>
          ) : (
            <span className="text-xs font-medium bg-amber-100 text-amber-700 px-2 py-1 rounded-full">
              Coming Soon
            </span>
          )}
        </div>

        <p className="text-sm text-gray-600 mb-4 leading-relaxed">{exam.description}</p>

        <div className="text-xs text-gray-500 mb-4">
          {exam.total_sets} mock {exam.total_sets === 1 ? 'set' : 'sets'} available
        </div>

        {/* Complimentary mock */}
        <div className="bg-[#0d47a1]/5 border border-[#0d47a1]/20 rounded-lg p-3 mb-4">
          <div className="flex items-center gap-2">
            <Gift className="w-4 h-4 text-[#1a365d]" />
            <span className="text-xs font-medium text-gray-700">
              Your first mock is completely free
            </span>
          </div>
        </div>

        {/* Actions */}
        <div className="flex flex-col gap-2">
          {isReady ? (
            <>
              <Link
                href={claimHref}
                className="flex items-center justify-center gap-2 py-2.5 bg-[#1a365d] text-white text-sm font-semibold rounded-lg hover:bg-[#2a4a7f] transition-colors"
              >
                Start Free Mock <ExternalLink className="w-3.5 h-3.5" />
              </Link>
              <div className="flex gap-2">
                <Link
                  href="/sat-test?enterCode=1"
                  className="flex-1 flex items-center justify-center gap-2 py-2.5 border border-[#1a365d] text-[#1a365d] text-sm font-semibold rounded-lg hover:bg-[#1a365d]/5 transition-colors"
                >
                  <KeyRound className="w-3.5 h-3.5" /> Enter Access Code
                </Link>
                <Link
                  href="/pricing"
                  className="px-4 py-2.5 border border-gray-200 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-50 transition-colors"
                >
                  Buy Packs
                </Link>
              </div>
            </>
          ) : (
            <div className="flex gap-2">
              <div className="flex-1 flex items-center justify-center gap-2 py-2.5 bg-gray-100 text-gray-400 text-sm font-semibold rounded-lg cursor-not-allowed">
                Coming Soon
              </div>
              <div className="px-4 py-2.5 border border-gray-200 text-sm font-medium text-gray-400 rounded-lg cursor-not-allowed bg-gray-50">
                Buy Packs
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

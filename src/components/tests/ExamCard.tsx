'use client';

import { useState } from 'react';
import Link from 'next/link';
import { Copy, Check, ExternalLink, Ticket } from 'lucide-react';
import type { ExamType } from '@/types/test-tokens';

interface ExamCardProps {
  exam: ExamType;
  freeCode: string;
}

export default function ExamCard({ exam, freeCode }: ExamCardProps) {
  const [copied, setCopied] = useState(false);

  const copyCode = async () => {
    await navigator.clipboard.writeText(freeCode);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  const isReady = exam.id === 'gre' || exam.id === 'sat' || exam.id === 'ashoka';

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
          {exam.total_sets} test {exam.total_sets === 1 ? 'set' : 'sets'} available
        </div>

        {/* Free token */}
        <div className="bg-gray-50 border border-dashed border-gray-300 rounded-lg p-3 mb-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Ticket className="w-4 h-4 text-[#1a365d]" />
              <span className="text-xs font-medium text-gray-700">Free Token (Set 1)</span>
            </div>
            <button
              onClick={copyCode}
              className="flex items-center gap-1 text-xs text-[#1a365d] hover:underline"
            >
              {copied ? <Check className="w-3 h-3" /> : <Copy className="w-3 h-3" />}
              {copied ? 'Copied' : 'Copy'}
            </button>
          </div>
          <code className="block mt-1 text-sm font-mono font-semibold text-[#1a365d] tracking-wider">
            {freeCode}
          </code>
        </div>

        {/* Actions */}
        <div className="flex gap-2">
          {isReady ? (
            <Link
              href={exam.test_route}
              className="flex-1 flex items-center justify-center gap-2 py-2.5 bg-[#1a365d] text-white text-sm font-semibold rounded-lg hover:bg-[#2a4a7f] transition-colors"
            >
              Go to Test <ExternalLink className="w-3.5 h-3.5" />
            </Link>
          ) : (
            <div className="flex-1 flex items-center justify-center gap-2 py-2.5 bg-gray-100 text-gray-400 text-sm font-semibold rounded-lg cursor-not-allowed">
              Coming Soon
            </div>
          )}
          <Link
            href={`/tests/tokens?exam=${exam.id}`}
            className="px-4 py-2.5 border border-gray-200 text-sm font-medium text-gray-700 rounded-lg hover:bg-gray-50 transition-colors"
          >
            Buy Tokens
          </Link>
        </div>
      </div>
    </div>
  );
}

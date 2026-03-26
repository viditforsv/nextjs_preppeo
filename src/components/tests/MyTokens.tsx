'use client';

import { useState, useEffect, useCallback } from 'react';
import { Copy, Check, ExternalLink, Loader2, Download } from 'lucide-react';
import Link from 'next/link';

interface TokenItem {
  id: string;
  code: string;
  exam_type: string;
  set_number: number;
  is_free: boolean;
  is_used: boolean;
  used_at: string | null;
  expires_at: string | null;
}

interface TokenGroup {
  examName: string;
  testRoute: string;
  tokens: TokenItem[];
}

export default function MyTokens() {
  const [tokensByExam, setTokensByExam] = useState<Record<string, TokenGroup>>({});
  const [loading, setLoading] = useState(true);
  const [copiedCode, setCopiedCode] = useState<string | null>(null);

  const fetchTokens = useCallback(async () => {
    try {
      const res = await fetch('/api/mocks/my-tokens');
      const data = await res.json();
      if (data.success) {
        setTokensByExam(data.tokensByExam);
      }
    } catch {
      // silent fail
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchTokens();
  }, [fetchTokens]);

  const copyCode = async (code: string) => {
    await navigator.clipboard.writeText(code);
    setCopiedCode(code);
    setTimeout(() => setCopiedCode(null), 2000);
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center py-8">
        <Loader2 className="w-5 h-5 animate-spin text-gray-400" />
      </div>
    );
  }

  const groups = Object.entries(tokensByExam);

  if (groups.length === 0) {
    return (
      <p className="text-sm text-gray-500 text-center py-6">
        No tokens purchased yet.
      </p>
    );
  }

  function isExpired(token: TokenItem) {
    return !token.is_free && token.expires_at && new Date(token.expires_at) < new Date();
  }

  function formatExpiry(expiresAt: string) {
    return new Date(expiresAt).toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' });
  }

  function downloadCSV(examType: string, group: TokenGroup) {
    const rows = [
      ['Code', 'Mock Test', 'Status', 'Expires', 'Used At'],
      ...group.tokens.map((t) => [
        t.code,
        `Mock Test #${t.set_number}`,
        t.is_used ? 'Used' : (isExpired(t) ? 'Expired' : 'Available'),
        t.expires_at ? formatExpiry(t.expires_at) : '',
        t.used_at ?? '',
      ]),
    ];
    const csv = rows.map((r) => r.join(',')).join('\n');
    const blob = new Blob([csv], { type: 'text/csv' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `${examType}-tokens.csv`;
    a.click();
    URL.revokeObjectURL(url);
  }

  return (
    <div className="space-y-6">
      {groups.map(([examType, group]) => (
        <div key={examType}>
          <div className="flex items-center justify-between mb-2">
            <h4 className="font-semibold text-gray-900">{group.examName}</h4>
            <div className="flex items-center gap-3">
              {group.tokens.length >= 10 && (
                <button
                  onClick={() => downloadCSV(examType, group)}
                  className="text-xs text-gray-500 hover:text-[#1a365d] flex items-center gap-1 transition-colors"
                >
                  <Download className="w-3 h-3" />
                  Download CSV
                </button>
              )}
              <Link
                href={group.testRoute}
                className="text-xs text-[#1a365d] hover:underline flex items-center gap-1"
              >
                Go to mock <ExternalLink className="w-3 h-3" />
              </Link>
            </div>
          </div>
          <div className="space-y-2">
            {group.tokens.map((token) => {
              const expired = isExpired(token);
              const unavailable = token.is_used || !!expired;
              return (
                <div
                  key={token.id}
                  className={`flex items-center justify-between p-3 rounded-lg border text-sm ${
                    unavailable
                      ? 'bg-gray-50 border-gray-200 opacity-60'
                      : 'bg-white border-gray-200'
                  }`}
                >
                  <div className="flex flex-col gap-0.5">
                    <div className="flex items-center gap-3">
                      <code className="font-mono font-semibold tracking-wider text-[#1a365d]">
                        {token.code}
                      </code>
                      <span className="text-xs text-gray-400">Mock Test #{token.set_number}</span>
                      {token.is_used && (
                        <span className="text-xs bg-gray-200 text-gray-500 px-2 py-0.5 rounded-full">
                          Used
                        </span>
                      )}
                      {!token.is_used && expired && (
                        <span className="text-xs bg-red-100 text-red-500 px-2 py-0.5 rounded-full">
                          Expired
                        </span>
                      )}
                    </div>
                    {!token.is_free && token.expires_at && (
                      <span className={`text-xs ${expired ? 'text-red-400' : 'text-gray-400'}`}>
                        {expired ? 'Expired' : 'Valid until'} {formatExpiry(token.expires_at)}
                      </span>
                    )}
                  </div>
                  {!unavailable && (
                    <button
                      onClick={() => copyCode(token.code)}
                      className="text-gray-400 hover:text-[#1a365d] transition-colors"
                      title="Copy token"
                    >
                      {copiedCode === token.code ? (
                        <Check className="w-4 h-4 text-emerald-500" />
                      ) : (
                        <Copy className="w-4 h-4" />
                      )}
                    </button>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      ))}
    </div>
  );
}

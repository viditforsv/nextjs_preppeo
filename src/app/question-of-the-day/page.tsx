'use client';

import { useEffect, useMemo, useState } from 'react';
import {
  Lock,
  CheckCircle2,
  XCircle,
  Mail,
  Loader2,
  Sparkles,
  ArrowRight,
  CalendarDays,
} from 'lucide-react';
import QuestionRenderer from '@/components/sat-test/question-types/QuestionRenderer';
import { renderMixedContent } from '@/components/MathRenderer';
import { satPromptImageUrls } from '@/lib/sat-prompt-images';
import type { SATQuestion } from '@/types/sat-test';

interface QotdResponse {
  rotationIndex: number;
  topic: string;
  question: SATQuestion;
}

export default function QuestionOfTheDayPage() {
  const [data, setData] = useState<QotdResponse | null>(null);
  const [loadError, setLoadError] = useState(false);

  const [selected, setSelected] = useState<string | null>(null);
  const [checked, setChecked] = useState(false);

  const [email, setEmail] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [captureError, setCaptureError] = useState('');
  const [breakdown, setBreakdown] = useState<string | null>(null);

  // Marketing attribution: capture ?ref=<channel> (e.g. /qotd?ref=va) so the
  // resulting signup is credited to whoever shared the link. Read from
  // window.location (not useSearchParams) to avoid needing a Suspense boundary.
  const [ref, setRef] = useState<string | null>(null);
  useEffect(() => {
    const raw = new URLSearchParams(window.location.search).get('ref') ?? '';
    const cleaned = raw.trim().toLowerCase().replace(/[^a-z0-9_-]/g, '').slice(0, 40);
    if (cleaned) setRef(cleaned);
  }, []);

  useEffect(() => {
    let cancelled = false;
    fetch('/api/qotd/question')
      .then((r) => (r.ok ? r.json() : Promise.reject(new Error('load'))))
      .then((d: QotdResponse) => {
        if (!cancelled) setData(d);
      })
      .catch(() => {
        if (!cancelled) setLoadError(true);
      });
    return () => {
      cancelled = true;
    };
  }, []);

  const todayLabel = useMemo(
    () =>
      new Date().toLocaleDateString('en-US', {
        weekday: 'long',
        month: 'long',
        day: 'numeric',
        timeZone: 'UTC',
      }),
    []
  );

  const question = data?.question ?? null;
  const isCorrect = checked && question != null && selected === question.correctAnswer;
  const unlocked = breakdown !== null;

  async function handleUnlock(e: React.FormEvent) {
    e.preventDefault();
    if (!question) return;
    setCaptureError('');
    setSubmitting(true);
    try {
      const res = await fetch('/api/qotd/capture', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, questionId: question.id, ref }),
      });
      const body = await res.json();
      if (!res.ok) {
        setCaptureError(body.error || 'Something went wrong. Try again.');
        return;
      }
      setBreakdown(body.breakdown || 'Breakdown unavailable.');
    } catch {
      setCaptureError('Network error. Please try again.');
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      {/* Header */}
      <header className="bg-[#0d47a1] text-white">
        <div className="max-w-2xl mx-auto px-4 py-4 sm:py-5">
          <div className="flex items-center gap-2 text-xs sm:text-sm font-medium text-blue-100">
            <CalendarDays className="w-4 h-4" />
            <span>{todayLabel}</span>
          </div>
          <h1 className="mt-1 text-xl sm:text-2xl font-bold tracking-tight">
            SAT Math · Question of the Day
          </h1>
          <p className="mt-1 text-sm text-blue-100">
            One genuinely hard question, daily. Free to solve — no account needed.
          </p>
        </div>
      </header>

      <main className="max-w-2xl mx-auto px-4 py-6 pb-16">
        {loadError && (
          <div className="bg-white rounded-xl border border-gray-200 p-6 text-center text-gray-600">
            Couldn&apos;t load today&apos;s question. Please refresh in a moment.
          </div>
        )}

        {!loadError && !question && (
          <div className="flex items-center justify-center py-20 text-gray-500">
            <Loader2 className="w-6 h-6 animate-spin" />
          </div>
        )}

        {question && (
          <>
            {/* Question card */}
            <section className="bg-white rounded-xl border border-gray-200 shadow-sm p-5 sm:p-6">
              {question.passage && (
                <div className="mb-5 pb-5 border-b border-gray-200">
                  <p className="text-xs font-semibold uppercase text-gray-400 mb-2 tracking-wider">
                    Passage
                  </p>
                  <div className="text-base text-gray-700 leading-[1.7] whitespace-pre-line font-[family-name:var(--font-lora)]">
                    {renderMixedContent(question.passage)}
                  </div>
                </div>
              )}

              <div className="mb-5 text-base text-gray-800 leading-[1.65] font-[family-name:var(--font-lora)]">
                {renderMixedContent(question.prompt)}
              </div>

              {satPromptImageUrls(question).map((url, i) => (
                <div key={`${url}-${i}`} className="mb-5">
                  {/* eslint-disable-next-line @next/next/no-img-element */}
                  <img
                    src={url}
                    alt={`Question figure ${i + 1}`}
                    className="max-w-full rounded-lg border border-gray-200"
                  />
                </div>
              ))}

              <QuestionRenderer
                question={question}
                answer={selected}
                onAnswer={setSelected}
                disabled={checked}
                showCorrect={checked}
              />

              {!checked ? (
                <button
                  onClick={() => setChecked(true)}
                  disabled={selected === null}
                  className="mt-5 w-full sm:w-auto px-6 py-3 text-sm font-semibold text-white bg-[#0d47a1] rounded-lg hover:bg-[#1565c0] transition-colors disabled:opacity-40 disabled:cursor-not-allowed"
                >
                  Check answer
                </button>
              ) : (
                <div
                  className={`mt-5 flex items-center gap-2 rounded-lg px-4 py-3 text-sm font-medium ${
                    isCorrect
                      ? 'bg-green-50 text-green-700 border border-green-200'
                      : 'bg-red-50 text-red-700 border border-red-200'
                  }`}
                >
                  {isCorrect ? (
                    <>
                      <CheckCircle2 className="w-5 h-5" />
                      Correct — nicely done. This one trips up most people.
                    </>
                  ) : (
                    <>
                      <XCircle className="w-5 h-5" />
                      Not quite. The correct answer is highlighted above.
                    </>
                  )}
                </div>
              )}
            </section>

            {/* AI Concept Breakdown */}
            <section className="mt-6 bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
              <div className="flex items-center gap-2 px-5 sm:px-6 pt-5 pb-3 border-b border-gray-100">
                <Sparkles className="w-5 h-5 text-[#0d47a1]" />
                <h2 className="text-base font-bold text-gray-900">AI Concept Breakdown</h2>
              </div>

              {unlocked ? (
                <div className="p-5 sm:p-6">
                  <div className="text-[15px] text-gray-800 leading-[1.7] font-[family-name:var(--font-lora)]">
                    {renderMixedContent(breakdown!)}
                  </div>
                  <div className="mt-6 rounded-lg bg-[#f5f5f0] border border-gray-200 p-4">
                    <p className="text-sm font-semibold text-gray-900">
                      Unlocked. Come back tomorrow for the next one.
                    </p>
                    <p className="mt-1 text-sm text-gray-600">
                      Want this depth on every question, adapting to where you lose points?
                    </p>
                    <a
                      href="/sat-test"
                      className="mt-3 inline-flex items-center gap-1.5 text-sm font-semibold text-[#0d47a1] hover:underline"
                    >
                      Try a full adaptive mock <ArrowRight className="w-4 h-4" />
                    </a>
                  </div>
                </div>
              ) : (
                <div className="relative">
                  {/* Blurred skeleton teaser */}
                  <div className="p-5 sm:p-6 space-y-3 select-none blur-[6px] pointer-events-none" aria-hidden="true">
                    <div className="h-3.5 rounded bg-gray-200 w-full" />
                    <div className="h-3.5 rounded bg-gray-200 w-[92%]" />
                    <div className="h-3.5 rounded bg-gray-200 w-[80%]" />
                    <div className="h-3.5 rounded bg-gray-200 w-[88%]" />
                    <div className="h-3.5 rounded bg-gray-200 w-[60%]" />
                  </div>

                  {/* Overlay */}
                  <div className="absolute inset-0 flex items-center justify-center p-5">
                    <div className="w-full max-w-sm rounded-xl bg-white/95 backdrop-blur-sm border border-gray-200 shadow-lg p-5 text-center">
                      <div className="mx-auto w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center">
                        <Lock className="w-5 h-5 text-[#0d47a1]" />
                      </div>
                      {!checked ? (
                        <p className="mt-3 text-sm text-gray-600">
                          Solve the question above to unlock the full step-by-step breakdown.
                        </p>
                      ) : (
                        <>
                          <p className="mt-3 text-sm font-semibold text-gray-900">
                            See exactly why — and the fastest path to the answer.
                          </p>
                          <p className="mt-1 text-xs text-gray-500">
                            Enter your email to unlock today&apos;s breakdown.
                          </p>
                          <form onSubmit={handleUnlock} className="mt-4 space-y-2">
                            <div className="relative">
                              <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                              <input
                                type="email"
                                required
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                placeholder="you@email.com"
                                className="w-full pl-9 pr-3 py-2.5 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/40 focus:border-[#0d47a1]"
                              />
                            </div>
                            <button
                              type="submit"
                              disabled={submitting}
                              className="w-full inline-flex items-center justify-center gap-2 px-4 py-2.5 text-sm font-semibold text-white bg-[#0d47a1] rounded-lg hover:bg-[#1565c0] transition-colors disabled:opacity-60"
                            >
                              {submitting ? (
                                <Loader2 className="w-4 h-4 animate-spin" />
                              ) : (
                                <>Unlock the breakdown</>
                              )}
                            </button>
                            {captureError && (
                              <p className="text-xs text-red-600">{captureError}</p>
                            )}
                            <p className="text-[11px] text-gray-400">
                              No spam — one daily question, unsubscribe anytime.
                            </p>
                          </form>
                        </>
                      )}
                    </div>
                  </div>
                </div>
              )}
            </section>
          </>
        )}
      </main>
    </div>
  );
}

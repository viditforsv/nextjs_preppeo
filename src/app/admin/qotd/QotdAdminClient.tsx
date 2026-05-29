'use client';

import { useState } from 'react';
import { renderMixedContent } from '@/components/MathRenderer';
import { CheckCircle2, Loader2, AlertTriangle, Save } from 'lucide-react';

export interface QotdAdminQuestion {
  dayIndex: number;
  topic: string;
  id: string;
  found: boolean;
  type: string;
  domain: string;
  prompt: string;
  passage: string;
  options: { id: string; text: string; imageUrl?: string }[];
  correctAnswer: string;
  explanation: string;
  imageUrls: string[];
}

export default function QotdAdminClient({
  questions,
  environment,
}: {
  questions: QotdAdminQuestion[];
  environment: 'dev' | 'prod';
}) {
  const readOnly = environment === 'prod';

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-[#0d47a1] text-white px-4 py-4">
        <div className="max-w-3xl mx-auto">
          <h1 className="text-xl font-bold">Question of the Day — Review &amp; Edit</h1>
          <p className="mt-1 text-sm text-blue-100">
            All 7 rotation questions, no email gate. Editing the breakdown saves to{' '}
            <span className="font-semibold">{environment}</span>.
            {readOnly && ' Prod is read-only here — edit on dev, then promote.'}
          </p>
        </div>
      </header>

      <main className="max-w-3xl mx-auto px-4 py-6 space-y-6">
        {questions.map((q) => (
          <QuestionCard key={q.id} q={q} readOnly={readOnly} />
        ))}
      </main>
    </div>
  );
}

function QuestionCard({ q, readOnly }: { q: QotdAdminQuestion; readOnly: boolean }) {
  const [text, setText] = useState(q.explanation);
  const [status, setStatus] = useState<'idle' | 'saving' | 'saved' | 'error'>('idle');
  const [errorMsg, setErrorMsg] = useState('');
  const dirty = text !== q.explanation;

  async function save() {
    setStatus('saving');
    setErrorMsg('');
    try {
      const res = await fetch('/api/admin/sat-questions', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ questionId: q.id, explanation: text }),
      });
      const body = await res.json().catch(() => ({}));
      if (!res.ok) {
        setStatus('error');
        setErrorMsg(body.error || `Save failed (${res.status})`);
        return;
      }
      // Reflect the saved value as the new baseline so `dirty` resets.
      q.explanation = text;
      setStatus('saved');
    } catch {
      setStatus('error');
      setErrorMsg('Network error');
    }
  }

  return (
    <section className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
      <div className="flex flex-wrap items-center gap-2 px-5 py-3 border-b border-gray-100 bg-gray-50">
        <span className="text-xs font-bold text-white bg-[#0d47a1] rounded px-2 py-0.5">
          Day {q.dayIndex}
        </span>
        <span className="text-sm font-semibold text-gray-900">{q.topic}</span>
        {q.domain && (
          <span className="text-xs text-gray-500 bg-gray-100 rounded px-2 py-0.5">{q.domain}</span>
        )}
        {!q.found && (
          <span className="inline-flex items-center gap-1 text-xs font-semibold text-red-600">
            <AlertTriangle className="w-3.5 h-3.5" /> not found in this DB
          </span>
        )}
        <span className="ml-auto text-[11px] text-gray-400 font-mono">{q.id}</span>
      </div>

      <div className="p-5">
        {/* Prompt */}
        {q.passage && (
          <div className="mb-3 pb-3 border-b border-gray-100 text-sm text-gray-700 leading-relaxed">
            {renderMixedContent(q.passage)}
          </div>
        )}
        <div className="text-[15px] text-gray-800 leading-[1.6] font-[family-name:var(--font-lora)]">
          {renderMixedContent(q.prompt)}
        </div>
        {q.imageUrls.map((url, i) => (
          <div key={`${url}-${i}`} className="mt-3">
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img src={url} alt={`Figure ${i + 1}`} className="max-w-full rounded border border-gray-200" />
          </div>
        ))}

        {/* Options */}
        <ul className="mt-4 space-y-1.5">
          {q.options.map((opt, idx) => {
            const letter = String.fromCharCode(65 + idx);
            const correct = opt.id === q.correctAnswer;
            return (
              <li
                key={opt.id}
                className={`flex items-start gap-2 text-sm rounded px-2 py-1 ${
                  correct ? 'bg-green-50 text-green-800 font-medium' : 'text-gray-700'
                }`}
              >
                <span className="shrink-0 w-5">{letter}.</span>
                <span className="flex-1">{opt.text ? renderMixedContent(opt.text) : '—'}</span>
                {correct && <CheckCircle2 className="w-4 h-4 text-green-600 shrink-0" />}
              </li>
            );
          })}
        </ul>

        {/* Explanation editor + preview */}
        <div className="mt-5 border-t border-gray-100 pt-4">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm font-semibold text-gray-900">AI Concept Breakdown</h3>
            {!readOnly && (
              <button
                onClick={save}
                disabled={!dirty || status === 'saving'}
                className="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-semibold text-white bg-[#0d47a1] rounded-lg hover:bg-[#1565c0] disabled:opacity-40 disabled:cursor-not-allowed"
              >
                {status === 'saving' ? (
                  <Loader2 className="w-3.5 h-3.5 animate-spin" />
                ) : (
                  <Save className="w-3.5 h-3.5" />
                )}
                {status === 'saving' ? 'Saving…' : dirty ? 'Save' : 'Saved'}
              </button>
            )}
          </div>

          <div className="grid md:grid-cols-2 gap-3">
            <textarea
              value={text}
              onChange={(e) => {
                setText(e.target.value);
                if (status !== 'idle') setStatus('idle');
              }}
              readOnly={readOnly}
              spellCheck={false}
              rows={10}
              className="w-full text-xs font-mono border border-gray-300 rounded-lg p-3 leading-relaxed focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/30 read-only:bg-gray-50"
            />
            <div className="text-sm text-gray-800 leading-[1.7] font-[family-name:var(--font-lora)] border border-gray-100 rounded-lg p-3 bg-gray-50/50 overflow-x-auto">
              {text ? renderMixedContent(text) : <span className="text-gray-400">No explanation</span>}
            </div>
          </div>

          {status === 'saved' && (
            <p className="mt-2 text-xs text-green-600 inline-flex items-center gap-1">
              <CheckCircle2 className="w-3.5 h-3.5" /> Saved to the database.
            </p>
          )}
          {status === 'error' && <p className="mt-2 text-xs text-red-600">{errorMsg}</p>}
        </div>
      </div>
    </section>
  );
}

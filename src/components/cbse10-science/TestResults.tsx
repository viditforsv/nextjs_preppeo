'use client';

import { useState } from 'react';
import { useCBSE10ScienceStore } from '@/stores/useCBSE10ScienceStore';
import { renderMixedContent } from '@/components/MathRenderer';
import {
  BarChart3, CheckCircle, XCircle, MinusCircle, Flag,
  ChevronDown, ChevronUp, RotateCcw, ArrowLeft,
} from 'lucide-react';

const DOMAIN_LABELS: Record<string, string> = {
  'chemical-reactions': 'Chemical Reactions',
  'acids-bases-salts': 'Acids, Bases & Salts',
  'metals-non-metals': 'Metals & Non-metals',
  'carbon-compounds': 'Carbon Compounds',
  'life-processes': 'Life Processes',
  'control-coordination': 'Control & Coordination',
  'reproduction': 'Reproduction',
  'heredity-evolution': 'Heredity & Evolution',
  'light': 'Light',
  'human-eye': 'Human Eye',
  'electricity': 'Electricity',
  'magnetic-effects': 'Magnetic Effects',
  'our-environment': 'Our Environment',
};

type Tab = 'score' | 'chapters' | 'difficulty' | 'review';

export default function TestResults() {
  const {
    testQuestions,
    testAnswers,
    testFlags,
    testStartTime,
    testTimeLimitMs,
    testConfig,
    goToLanding,
    goToTestConfig,
  } = useCBSE10ScienceStore();

  const [activeTab, setActiveTab] = useState<Tab>('score');
  const [expandedId, setExpandedId] = useState<string | null>(null);

  const total = testQuestions.length;
  const results = testQuestions.map((q) => {
    const ans = testAnswers[q.id] ?? '';
    const attempted = ans.trim() !== '';
    const isCorrect = attempted && ans.trim().toLowerCase() === q.correctAnswer.trim().toLowerCase();
    const flagged = !!testFlags[q.id];
    return { question: q, answer: ans, isCorrect, attempted, flagged };
  });

  const correct = results.filter((r) => r.isCorrect).length;
  const incorrect = results.filter((r) => r.attempted && !r.isCorrect).length;
  const omitted = results.filter((r) => !r.attempted).length;
  const flagged = results.filter((r) => r.flagged).length;
  const pct = total > 0 ? Math.round((correct / total) * 100) : 0;

  const elapsedMs = testStartTime ? Math.min(Date.now() - testStartTime, testTimeLimitMs) : testTimeLimitMs;
  const elapsedMin = Math.floor(elapsedMs / 60000);
  const elapsedSec = Math.floor((elapsedMs % 60000) / 1000);
  const avgTimeSec = total > 0 ? Math.round(elapsedMs / total / 1000) : 0;

  // Chapter breakdown
  const domainMap = new Map<string, { correct: number; total: number }>();
  for (const r of results) {
    const d = r.question.domain ?? 'unknown';
    if (!domainMap.has(d)) domainMap.set(d, { correct: 0, total: 0 });
    const entry = domainMap.get(d)!;
    entry.total++;
    if (r.isCorrect) entry.correct++;
  }

  // Difficulty breakdown
  const diffMap = new Map<string, { correct: number; total: number }>();
  for (const r of results) {
    const d = r.question.difficulty;
    if (!diffMap.has(d)) diffMap.set(d, { correct: 0, total: 0 });
    const entry = diffMap.get(d)!;
    entry.total++;
    if (r.isCorrect) entry.correct++;
  }

  const TABS: { id: Tab; label: string }[] = [
    { id: 'score', label: 'Score' },
    { id: 'chapters', label: 'Chapters' },
    { id: 'difficulty', label: 'Difficulty' },
    { id: 'review', label: 'Review' },
  ];

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      {/* Header */}
      <div className="text-white px-4 py-4" style={{ backgroundColor: '#1e3a8a' }}>
        <div className="max-w-4xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <BarChart3 className="w-5 h-5" />
            <h1 className="text-lg font-bold">Test Results</h1>
            <span className="text-sm opacity-70 ml-1">— CBSE 10 Science</span>
          </div>
          <div className="flex items-center gap-2">
            <button
              onClick={goToTestConfig}
              className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
            >
              <RotateCcw className="w-3.5 h-3.5" />
              New Test
            </button>
            <button
              onClick={goToLanding}
              className="inline-flex items-center gap-1.5 px-3 py-1.5 text-sm bg-white/10 hover:bg-white/20 rounded-lg transition-colors"
            >
              <ArrowLeft className="w-3.5 h-3.5" />
              Back to Science
            </button>
          </div>
        </div>
      </div>

      {/* Tabs */}
      <div className="sticky top-0 z-10 bg-white border-b border-gray-200 shadow-sm">
        <div className="max-w-4xl mx-auto px-4">
          <div className="flex overflow-x-auto">
            {TABS.map((tab) => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`px-4 py-3 text-sm font-semibold border-b-2 whitespace-nowrap transition-colors ${
                  activeTab === tab.id
                    ? 'border-[#1e40af] text-[#1e40af]'
                    : 'border-transparent text-gray-500 hover:text-gray-700'
                }`}
              >
                {tab.label}
              </button>
            ))}
          </div>
        </div>
      </div>

      <div className="max-w-4xl mx-auto p-4 space-y-4">
        {/* ── Score Tab ── */}
        {activeTab === 'score' && (
          <>
            <div className="bg-white rounded-xl border border-gray-200 p-6">
              <div className="text-center mb-6">
                <p className="text-sm text-gray-500 mb-1">
                  {testConfig?.domains.length === 0 ? 'All Chapters' : testConfig?.domains.join(', ')} · {total} questions
                </p>
                <p className={`text-6xl font-bold ${pct >= 70 ? 'text-green-600' : pct >= 40 ? 'text-amber-600' : 'text-red-600'}`}>
                  {pct}%
                </p>
                <p className="text-gray-500 mt-1">{correct} of {total} correct</p>
              </div>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-3 text-center">
                <div className="bg-green-50 rounded-lg p-3">
                  <CheckCircle className="w-4 h-4 text-green-600 mx-auto mb-1" />
                  <p className="text-xl font-bold text-green-700">{correct}</p>
                  <p className="text-xs text-green-600">Correct</p>
                </div>
                <div className="bg-red-50 rounded-lg p-3">
                  <XCircle className="w-4 h-4 text-red-600 mx-auto mb-1" />
                  <p className="text-xl font-bold text-red-700">{incorrect}</p>
                  <p className="text-xs text-red-600">Incorrect</p>
                </div>
                <div className="bg-gray-50 rounded-lg p-3">
                  <MinusCircle className="w-4 h-4 text-gray-400 mx-auto mb-1" />
                  <p className="text-xl font-bold text-gray-600">{omitted}</p>
                  <p className="text-xs text-gray-500">Skipped</p>
                </div>
                <div className="bg-amber-50 rounded-lg p-3">
                  <Flag className="w-4 h-4 text-amber-500 mx-auto mb-1" />
                  <p className="text-xl font-bold text-amber-700">{flagged}</p>
                  <p className="text-xs text-amber-600">Flagged</p>
                </div>
              </div>
            </div>
            <div className="bg-white rounded-xl border border-gray-200 p-4">
              <h3 className="text-sm font-semibold text-gray-600 mb-3">Time</h3>
              <div className="grid grid-cols-2 gap-4 text-sm">
                <div>
                  <span className="text-gray-400">Total used</span>
                  <p className="font-semibold text-gray-800 mt-0.5">{elapsedMin}m {elapsedSec}s</p>
                </div>
                <div>
                  <span className="text-gray-400">Avg per question</span>
                  <p className="font-semibold text-gray-800 mt-0.5">{avgTimeSec}s</p>
                </div>
              </div>
            </div>
          </>
        )}

        {/* ── Chapters Tab ── */}
        {activeTab === 'chapters' && (
          <div className="bg-white rounded-xl border border-gray-200 p-6">
            <h3 className="text-sm font-semibold text-gray-700 mb-4">Chapter Breakdown</h3>
            <div className="space-y-4">
              {[...domainMap.entries()].sort((a, b) => b[1].total - a[1].total).map(([domain, stats]) => {
                const domPct = stats.total > 0 ? Math.round((stats.correct / stats.total) * 100) : 0;
                const barColor = domPct >= 70 ? '#16a34a' : domPct >= 40 ? '#d97706' : '#dc2626';
                return (
                  <div key={domain}>
                    <div className="flex items-center justify-between text-sm mb-1">
                      <span className="text-gray-700 font-medium">{DOMAIN_LABELS[domain] ?? domain}</span>
                      <span className="font-semibold text-gray-800">{stats.correct}/{stats.total} ({domPct}%)</span>
                    </div>
                    <div className="w-full bg-gray-100 rounded-full h-2.5">
                      <div className="h-2.5 rounded-full transition-all" style={{ width: `${domPct}%`, backgroundColor: barColor }} />
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        )}

        {/* ── Difficulty Tab ── */}
        {activeTab === 'difficulty' && (
          <div className="bg-white rounded-xl border border-gray-200 p-6">
            <h3 className="text-sm font-semibold text-gray-700 mb-4">Difficulty Breakdown</h3>
            <div className="space-y-4">
              {(['easy', 'medium', 'hard'] as const).map((tier) => {
                const stats = diffMap.get(tier);
                if (!stats) return null;
                const tierPct = stats.total > 0 ? Math.round((stats.correct / stats.total) * 100) : 0;
                const barColor = tier === 'easy' ? '#16a34a' : tier === 'medium' ? '#d97706' : '#dc2626';
                const bgColor = tier === 'easy' ? 'bg-green-50' : tier === 'medium' ? 'bg-amber-50' : 'bg-red-50';
                const textColor = tier === 'easy' ? 'text-green-700' : tier === 'medium' ? 'text-amber-700' : 'text-red-700';
                return (
                  <div key={tier} className={`${bgColor} rounded-xl p-4`}>
                    <div className="flex items-center justify-between mb-2">
                      <span className={`font-semibold capitalize ${textColor}`}>{tier}</span>
                      <span className={`text-sm font-bold ${textColor}`}>{stats.correct}/{stats.total} ({tierPct}%)</span>
                    </div>
                    <div className="w-full bg-white/60 rounded-full h-2">
                      <div className="h-2 rounded-full" style={{ width: `${tierPct}%`, backgroundColor: barColor }} />
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        )}

        {/* ── Review Tab ── */}
        {activeTab === 'review' && (
          <div className="bg-white rounded-xl border border-gray-200 p-6">
            <h3 className="text-sm font-semibold text-gray-700 mb-4">Question Review</h3>
            <div className="space-y-2">
              {results.map((r, idx) => {
                const isExpanded = expandedId === r.question.id;
                return (
                  <div key={r.question.id} className="border border-gray-200 rounded-lg overflow-hidden">
                    <button
                      onClick={() => setExpandedId(isExpanded ? null : r.question.id)}
                      className="w-full flex items-center gap-3 p-3 text-left hover:bg-gray-50 transition-colors"
                    >
                      <span className={`w-6 h-6 rounded-full flex items-center justify-center shrink-0 ${
                        !r.attempted ? 'bg-gray-100 text-gray-400'
                        : r.isCorrect ? 'bg-green-100 text-green-600'
                        : 'bg-red-100 text-red-600'
                      }`}>
                        {!r.attempted
                          ? <MinusCircle className="w-3.5 h-3.5" />
                          : r.isCorrect ? <CheckCircle className="w-3.5 h-3.5" />
                          : <XCircle className="w-3.5 h-3.5" />}
                      </span>
                      {r.flagged && <Flag className="w-3.5 h-3.5 text-amber-500 shrink-0" />}
                      <span className="flex-1 text-sm text-gray-700 truncate">
                        Q{idx + 1}: {r.question.prompt.substring(0, 80)}...
                      </span>
                      {isExpanded ? <ChevronUp className="w-4 h-4 text-gray-400 shrink-0" /> : <ChevronDown className="w-4 h-4 text-gray-400 shrink-0" />}
                    </button>

                    {isExpanded && (
                      <div className="px-4 pb-4 border-t border-gray-100">
                        <div className="mt-3 text-sm text-gray-700 leading-relaxed">
                          {renderMixedContent(r.question.prompt)}
                        </div>
                        {r.question.options && (
                          <div className="mt-3 space-y-1">
                            {r.question.options.map((opt) => (
                              <div
                                key={opt.id}
                                className={`text-sm px-3 py-1.5 rounded ${
                                  opt.id === r.question.correctAnswer ? 'bg-green-50 text-green-700 font-medium'
                                  : opt.id === r.answer && opt.id !== r.question.correctAnswer ? 'bg-red-50 text-red-700'
                                  : 'text-gray-600'
                                }`}
                              >
                                <strong>{opt.id})</strong> {opt.text}
                                {opt.id === r.question.correctAnswer && ' ✓'}
                                {opt.id === r.answer && opt.id !== r.question.correctAnswer && ' (your answer)'}
                              </div>
                            ))}
                          </div>
                        )}
                        {r.question.type === 'spr' && (
                          <div className="mt-3 space-y-1 text-sm">
                            <div className="px-3 py-1.5 rounded bg-green-50 text-green-700 font-medium">
                              Correct: {r.question.correctAnswer}
                            </div>
                            {r.answer && r.answer !== r.question.correctAnswer && (
                              <div className="px-3 py-1.5 rounded bg-red-50 text-red-700">
                                Your answer: {r.answer}
                              </div>
                            )}
                          </div>
                        )}
                        {r.question.explanation && (
                          <div className="mt-3 p-3 bg-gray-50 rounded-lg">
                            <p className="text-xs font-semibold text-gray-500 mb-1">Explanation</p>
                            <div className="text-sm text-gray-700 leading-relaxed">
                              {renderMixedContent(r.question.explanation)}
                            </div>
                          </div>
                        )}
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
          </div>
        )}
      </div>

      {/* Bottom CTA */}
      <div className="max-w-4xl mx-auto px-4 pb-8">
        <div className="bg-white rounded-xl border border-gray-200 p-4 flex items-center justify-between">
          <p className="text-sm text-gray-600">
            Want targeted practice on weak chapters?
          </p>
          <button
            onClick={() => useCBSE10ScienceStore.setState({ phase: 'study-mode-select' })}
            className="px-4 py-2 text-sm font-semibold text-white rounded-lg hover:brightness-95 transition-all"
            style={{ backgroundColor: '#059669' }}
          >
            Go to Study Mode
          </button>
        </div>
      </div>
    </div>
  );
}

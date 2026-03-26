'use client';

import QCPageTemplate from '@/components/admin/QCPageTemplate';
import type { QCPageConfig, QCQuestion } from '@/components/admin/qc-types';
import { Badge } from '@/design-system/components/ui/badge';
import { renderMixedContent } from '@/components/MathRenderer';
import { IBDP_DOMAIN_LABELS } from '@/lib/ibdp-maths-courses';

type IBDPQCQuestion = QCQuestion & { domain?: string; chapter?: string; subtopic?: string };

const DIFFICULTY_COLORS: Record<string, string> = {
  easy: 'bg-green-100 text-green-800',
  medium: 'bg-yellow-100 text-yellow-800',
  hard: 'bg-red-100 text-red-800',
};

const IBDP_DOMAIN_OPTIONS = Object.entries(IBDP_DOMAIN_LABELS).map(([value, label]) => ({ value, label }));

const config: QCPageConfig<IBDPQCQuestion> = {
  title: 'IB AI SL Questions QC',
  breadcrumbLabel: 'IB AI SL QC',
  subtitle: 'Review and edit all IB Mathematics Applications & Interpretation SL questions.',
  apiBase: '/api/admin/ibdp-ai-sl-questions',
  hasImageUpload: true,
  hasAIRegenerate: true,
  hasPassage: false,
  filters: [
    { key: 'domain', label: 'Topic', options: [{ value: 'all', label: 'All' }, ...IBDP_DOMAIN_OPTIONS] },
    { key: 'difficulty', label: 'Difficulty', options: [{ value: 'all', label: 'All' }, { value: 'easy', label: 'Easy' }, { value: 'medium', label: 'Medium' }, { value: 'hard', label: 'Hard' }] },
    { key: 'qc', label: 'QC', options: [{ value: 'all', label: 'All' }, { value: 'pending', label: 'Pending' }, { value: 'done', label: 'Done' }] },
  ],
  filterFn: (q, filters) => {
    if (filters.domain !== 'all' && q.domain !== filters.domain) return false;
    if (filters.difficulty !== 'all' && q.difficulty !== filters.difficulty) return false;
    if (filters.qc === 'done' && !q.qcDone) return false;
    if (filters.qc === 'pending' && q.qcDone) return false;
    return true;
  },
  sortFn: (a, b) => {
    const domOrder = (d: string | undefined) => Object.keys(IBDP_DOMAIN_LABELS).indexOf(d ?? '');
    const diffOrder = (d: string) => ({ easy: 0, medium: 1, hard: 2 }[d] ?? 0);
    if (domOrder(a.domain) !== domOrder(b.domain)) return domOrder(a.domain) - domOrder(b.domain);
    return diffOrder(a.difficulty) - diffOrder(b.difficulty);
  },
  getResetFilters: () => ({ domain: 'all', difficulty: 'all', qc: 'all' }),
  metadataBadges: [
    { key: 'domain', render: (q) => q.domain ? <Badge className="bg-cyan-100 text-cyan-800 text-xs">{IBDP_DOMAIN_LABELS[q.domain as keyof typeof IBDP_DOMAIN_LABELS] ?? q.domain}</Badge> : null },
    { key: 'difficulty', render: (q) => <Badge className={DIFFICULTY_COLORS[q.difficulty] ?? 'bg-gray-100 text-gray-700'}>{q.difficulty.charAt(0).toUpperCase() + q.difficulty.slice(1)}</Badge> },
    { key: 'type', render: (q) => <Badge variant="outline" className="text-xs">{q.type.toUpperCase()}</Badge> },
    { key: 'chapter', render: (q) => q.chapter ? <span className="text-xs text-gray-500">{q.chapter}{q.subtopic ? ` › ${q.subtopic}` : ''}</span> : null },
    { key: 'qcDone', render: (q) => <Badge className={q.qcDone ? 'bg-emerald-100 text-emerald-800' : 'bg-gray-100 text-gray-500'}>{q.qcDone ? 'QC Done' : 'QC Pending'}</Badge> },
    { key: 'id', render: (q) => <span className="text-xs text-gray-400 ml-auto font-mono">{q.id}</span> },
  ],
  editFields: [
    { key: 'domain', label: 'Topic', type: 'select', options: IBDP_DOMAIN_OPTIONS },
    { key: 'difficulty', label: 'Difficulty', type: 'select', options: [{ value: 'easy', label: 'Easy' }, { value: 'medium', label: 'Medium' }, { value: 'hard', label: 'Hard' }] },
    { key: 'type', label: 'Type', type: 'select', options: [{ value: 'mcq', label: 'MCQ' }, { value: 'spr', label: 'SPR' }] },
    { key: 'chapter' as keyof IBDPQCQuestion & string, label: 'Chapter', type: 'text' },
    { key: 'subtopic' as keyof IBDPQCQuestion & string, label: 'Subtopic', type: 'text' },
    { key: 'correctAnswer', label: 'Correct Answer', type: 'text', colSpan: 3 },
    { key: 'prompt', label: 'Prompt', type: 'textarea', rows: 4, colSpan: 3 },
    { key: 'options' as keyof IBDPQCQuestion & string, label: 'Options (JSON)', type: 'json', rows: 6, colSpan: 3 },
    { key: 'explanation', label: 'Explanation', type: 'textarea', rows: 4, colSpan: 3 },
  ],
  renderQuestion: (q) => (
    <>
      {q.prompt && <div className="prose prose-sm max-w-none text-gray-800">{renderMixedContent(q.prompt)}</div>}
      {q.options && (
        <div className="mt-3 space-y-1">
          {q.options.map((opt) => (
            <div key={opt.id} className={`text-sm px-3 py-1.5 rounded ${opt.id === q.correctAnswer ? 'bg-green-50 text-green-700 font-medium' : 'text-gray-600'}`}>
              <strong>{opt.id})</strong> {renderMixedContent(opt.text)}{opt.id === q.correctAnswer && ' ✓'}
            </div>
          ))}
        </div>
      )}
      {q.explanation && (
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 text-sm text-blue-800 mt-3">
          <p className="font-medium mb-1">Explanation:</p>
          <div>{renderMixedContent(q.explanation)}</div>
        </div>
      )}
    </>
  ),
};

export default function IBDPAISLQCPage() {
  return <QCPageTemplate config={config} />;
}

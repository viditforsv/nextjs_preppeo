'use client';

import QCPageTemplate from '@/components/admin/QCPageTemplate';
import type { QCPageConfig, QCQuestion } from '@/components/admin/qc-types';
import { Badge } from '@/design-system/components/ui/badge';
import type { DifficultyTier } from '@/types/gre-test';
import QuestionRenderer from '@/components/gre-test/question-types/QuestionRenderer';
import { renderMixedContent } from '@/components/MathRenderer';

type GREQCQuestion = QCQuestion & {
  sectionNumber: number;
  setNumber: number;
  topics?: string[];
  quantityA?: string;
  quantityB?: string;
  quantityInfo?: string;
};

const DIFFICULTY_COLORS: Record<DifficultyTier, string> = {
  easy: 'bg-green-100 text-green-800',
  medium: 'bg-yellow-100 text-yellow-800',
  hard: 'bg-red-100 text-red-800',
};

const TYPE_LABELS: Record<string, string> = {
  'single-choice': 'Single Choice',
  'multi-select': 'Multi-Select',
  'numeric-entry': 'Numeric Entry',
  'quantitative-comparison': 'Quant Comparison',
};

const DIFF_ORDER: Record<DifficultyTier, number> = { easy: 0, medium: 1, hard: 2 };

const config: QCPageConfig<GREQCQuestion> = {
  title: 'GRE Questions QC',
  breadcrumbLabel: 'GRE Questions QC',
  subtitle: 'Review and edit all GRE questions.',
  apiBase: '/api/admin/gre-questions',
  hasImageUpload: true,
  hasAIRegenerate: true,
  hasPassage: false,

  filters: [
    {
      key: 'section',
      label: 'Section',
      options: [
        { value: 'all', label: 'All' },
        { value: '1', label: 'Section 1' },
        { value: '2', label: 'Section 2' },
      ],
    },
    {
      key: 'difficulty',
      label: 'Difficulty',
      options: [
        { value: 'all', label: 'All' },
        { value: 'easy', label: 'Easy' },
        { value: 'medium', label: 'Medium' },
        { value: 'hard', label: 'Hard' },
      ],
    },
    {
      key: 'set',
      label: 'Set',
      options: 'dynamic',
      deriveOptions: (questions) => {
        const sets = Array.from(new Set(questions.map((q) => (q as GREQCQuestion).setNumber))).sort((a, b) => a - b);
        return [
          { value: 'all', label: 'All' },
          ...sets.map((s) => ({ value: String(s), label: `Set ${s}` })),
        ];
      },
    },
    {
      key: 'type',
      label: 'Type',
      options: [
        { value: 'all', label: 'All' },
        { value: 'single-choice', label: 'Single Choice' },
        { value: 'multi-select', label: 'Multi-Select' },
        { value: 'numeric-entry', label: 'Numeric Entry' },
        { value: 'quantitative-comparison', label: 'Quant Comparison' },
      ],
    },
    {
      key: 'qc',
      label: 'QC',
      options: [
        { value: 'all', label: 'All' },
        { value: 'pending', label: 'Pending' },
        { value: 'done', label: 'Done' },
      ],
    },
  ],

  filterFn: (q, filters) => {
    if (filters.section !== 'all' && q.sectionNumber !== Number(filters.section)) return false;
    if (filters.difficulty !== 'all' && q.difficulty !== filters.difficulty) return false;
    if (filters.set !== 'all' && q.setNumber !== Number(filters.set)) return false;
    if (filters.type !== 'all' && q.type !== filters.type) return false;
    if (filters.qc === 'done' && !q.qcDone) return false;
    if (filters.qc === 'pending' && q.qcDone) return false;
    return true;
  },

  sortFn: (a, b) => {
    if (a.sectionNumber !== b.sectionNumber) return a.sectionNumber - b.sectionNumber;
    if (a.setNumber !== b.setNumber) return a.setNumber - b.setNumber;
    if (a.difficulty !== b.difficulty) return DIFF_ORDER[a.difficulty as DifficultyTier] - DIFF_ORDER[b.difficulty as DifficultyTier];
    return 0;
  },

  getResetFilters: () => ({
    section: 'all',
    difficulty: 'all',
    set: 'all',
    type: 'all',
    qc: 'all',
  }),

  metadataBadges: [
    {
      key: 'section',
      render: (q) => (
        <span className="text-sm font-medium text-gray-600">
          Section {q.sectionNumber} / Set {q.setNumber}
        </span>
      ),
    },
    {
      key: 'difficulty',
      render: (q) => (
        <Badge className={DIFFICULTY_COLORS[q.difficulty as DifficultyTier]}>
          {q.difficulty.charAt(0).toUpperCase() + q.difficulty.slice(1)}
        </Badge>
      ),
    },
    {
      key: 'type',
      render: (q) => (
        <Badge variant="outline" className="text-xs">
          {TYPE_LABELS[q.type] ?? q.type}
        </Badge>
      ),
    },
    {
      key: 'topics',
      render: (q) =>
        q.topics?.map((t) => (
          <Badge key={t} variant="secondary" className="text-xs">
            {t}
          </Badge>
        )) ?? null,
    },
    {
      key: 'qcDone',
      render: (q) => (
        <Badge className={q.qcDone ? 'bg-emerald-100 text-emerald-800' : 'bg-gray-100 text-gray-500'}>
          {q.qcDone ? 'QC Done' : 'QC Pending'}
        </Badge>
      ),
    },
    {
      key: 'id',
      render: (q) => <span className="text-xs text-gray-400 ml-auto font-mono">{q.id}</span>,
    },
  ],

  editFields: [
    {
      key: 'type',
      label: 'Type',
      type: 'select',
      options: [
        { value: 'single-choice', label: 'Single Choice' },
        { value: 'multi-select', label: 'Multi-Select' },
        { value: 'numeric-entry', label: 'Numeric Entry' },
        { value: 'quantitative-comparison', label: 'Quant Comparison' },
      ],
    },
    {
      key: 'difficulty',
      label: 'Difficulty',
      type: 'select',
      options: [
        { value: 'easy', label: 'Easy' },
        { value: 'medium', label: 'Medium' },
        { value: 'hard', label: 'Hard' },
      ],
    },
    {
      key: 'sectionNumber' as keyof GREQCQuestion & string,
      label: 'Section',
      type: 'number',
    },
    {
      key: 'setNumber' as keyof GREQCQuestion & string,
      label: 'Set',
      type: 'number',
    },
    {
      key: 'correctAnswer',
      label: 'Correct Answer',
      type: 'text',
      colSpan: 2,
    },
    // Content fields
    {
      key: 'prompt',
      label: 'Prompt',
      type: 'textarea',
      rows: 4,
      colSpan: 3,
    },
    {
      key: 'options' as keyof GREQCQuestion & string,
      label: 'Options (JSON)',
      type: 'json',
      rows: 6,
      colSpan: 3,
    },
    {
      key: 'quantityA' as keyof GREQCQuestion & string,
      label: 'Quantity A',
      type: 'textarea',
      rows: 2,
      colSpan: 3,
    },
    {
      key: 'quantityB' as keyof GREQCQuestion & string,
      label: 'Quantity B',
      type: 'textarea',
      rows: 2,
      colSpan: 3,
    },
    {
      key: 'quantityInfo' as keyof GREQCQuestion & string,
      label: 'Quantity Info',
      type: 'textarea',
      rows: 2,
      colSpan: 3,
    },
    {
      key: 'explanation',
      label: 'Explanation',
      type: 'textarea',
      rows: 4,
      colSpan: 3,
    },
  ],

  renderQuestion: (q) => (
    <>
      {q.prompt && (
        <div className="prose prose-sm max-w-none text-gray-800">{renderMixedContent(q.prompt)}</div>
      )}
      {q.imageUrl && (
        <div>
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img src={q.imageUrl} alt="Question figure" className="max-w-full rounded-lg border border-gray-200" />
        </div>
      )}
      <QuestionRenderer
        question={q as Parameters<typeof QuestionRenderer>[0]['question']}
        answer={q.correctAnswer}
        onAnswer={() => {}}
        disabled
        showCorrect
      />
      {q.explanation && (
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 text-sm text-blue-800">
          <p className="font-medium mb-1">Explanation:</p>
          <div>{renderMixedContent(q.explanation)}</div>
        </div>
      )}
    </>
  ),
};

export default function GREQuestionsQCPage() {
  return <QCPageTemplate config={config} />;
}

'use client';

import QCPageTemplate from '@/components/admin/QCPageTemplate';
import type { QCPageConfig, QCQuestion } from '@/components/admin/qc-types';
import { Badge } from '@/design-system/components/ui/badge';
import type { CBSE10ScienceDomain, DifficultyTier } from '@/types/cbse10-science';
import { renderMixedContent } from '@/components/MathRenderer';

type ScienceQCQuestion = QCQuestion & {
  domain?: string;
  chapter?: string;
  subtopic?: string;
  bankItemId?: string;
};

const DIFFICULTY_COLORS: Record<DifficultyTier, string> = {
  easy: 'bg-green-100 text-green-800',
  medium: 'bg-yellow-100 text-yellow-800',
  hard: 'bg-red-100 text-red-800',
};

const DOMAIN_LABELS: Record<string, string> = {
  'chemical-reactions': 'Chemical Reactions & Equations',
  'acids-bases-salts': 'Acids, Bases & Salts',
  'metals-non-metals': 'Metals & Non-metals',
  'carbon-compounds': 'Carbon & its Compounds',
  'life-processes': 'Life Processes',
  'control-coordination': 'Control & Coordination',
  reproduction: 'How do Organisms Reproduce',
  'heredity-evolution': 'Heredity & Evolution',
  light: 'Light – Reflection & Refraction',
  'human-eye': 'Human Eye & Colourful World',
  electricity: 'Electricity',
  'magnetic-effects': 'Magnetic Effects of Current',
  'our-environment': 'Our Environment',
};

const ALL_DOMAINS: CBSE10ScienceDomain[] = [
  'chemical-reactions', 'acids-bases-salts', 'metals-non-metals', 'carbon-compounds',
  'life-processes', 'control-coordination', 'reproduction', 'heredity-evolution',
  'light', 'human-eye', 'electricity', 'magnetic-effects', 'our-environment',
];

const DIFF_ORDER: Record<DifficultyTier, number> = { easy: 0, medium: 1, hard: 2 };

const config: QCPageConfig<ScienceQCQuestion> = {
  title: 'CBSE 10 Science QC',
  breadcrumbLabel: 'CBSE 10 Science QC',
  subtitle: 'Review and edit CBSE Class 10 Science questions.',
  apiBase: '/api/admin/cbse10-science-questions',
  hasImageUpload: true,
  hasAIRegenerate: true,
  hasPassage: false,

  matchUuid: (q, uuid) => q.id === uuid || q.bankItemId === uuid,

  filters: [
    {
      key: 'domain',
      label: 'Chapter',
      options: [
        { value: 'all', label: 'All Chapters' },
        ...ALL_DOMAINS.map((d) => ({ value: d, label: DOMAIN_LABELS[d] ?? d })),
      ],
      onChangeSideEffect: (_v, setFilters) => {
        setFilters((f) => ({ ...f, chapter: 'all', subtopic: 'all' }));
      },
    },
    {
      key: 'chapter',
      label: 'Topic',
      options: 'dynamic',
      deriveOptions: (questions) => {
        const chapters = Array.from(
          new Set(questions.map((q) => (q as ScienceQCQuestion).chapter).filter(Boolean) as string[])
        ).sort();
        return [{ value: 'all', label: 'All Topics' }, ...chapters.map((c) => ({ value: c, label: c }))];
      },
      onChangeSideEffect: (_v, setFilters) => {
        setFilters((f) => ({ ...f, subtopic: 'all' }));
      },
    },
    {
      key: 'subtopic',
      label: 'Subtopic',
      options: 'dynamic',
      deriveOptions: (questions) => {
        const subtopics = Array.from(
          new Set(questions.map((q) => (q as ScienceQCQuestion).subtopic).filter(Boolean) as string[])
        ).sort();
        return [{ value: 'all', label: 'All Subtopics' }, ...subtopics.map((s) => ({ value: s, label: s }))];
      },
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
    if (filters.domain !== 'all' && q.domain !== filters.domain) return false;
    if (filters.chapter !== 'all' && q.chapter !== filters.chapter) return false;
    if (filters.subtopic !== 'all' && q.subtopic !== filters.subtopic) return false;
    if (filters.difficulty !== 'all' && q.difficulty !== filters.difficulty) return false;
    if (filters.qc === 'done' && !q.qcDone) return false;
    if (filters.qc === 'pending' && q.qcDone) return false;
    return true;
  },

  sortFn: (a, b) => {
    const dA = a.domain ?? '';
    const dB = b.domain ?? '';
    if (dA !== dB) return dA.localeCompare(dB);
    if (a.difficulty !== b.difficulty) return DIFF_ORDER[a.difficulty as DifficultyTier] - DIFF_ORDER[b.difficulty as DifficultyTier];
    return 0;
  },

  getResetFilters: () => ({
    domain: 'all',
    chapter: 'all',
    subtopic: 'all',
    difficulty: 'all',
    qc: 'all',
  }),

  metadataBadges: [
    {
      key: 'domain',
      render: (q) =>
        q.domain ? (
          <Badge variant="secondary" className="text-xs">
            {DOMAIN_LABELS[q.domain] ?? q.domain}
          </Badge>
        ) : null,
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
          {q.type.toUpperCase()}
        </Badge>
      ),
    },
    {
      key: 'chapter',
      render: (q) =>
        q.chapter ? (
          <Badge variant="secondary" className="text-xs bg-blue-50 text-blue-700">
            {q.chapter}
          </Badge>
        ) : null,
    },
    {
      key: 'subtopic',
      render: (q) =>
        q.subtopic ? (
          <Badge variant="secondary" className="text-xs bg-violet-50 text-violet-700">
            {q.subtopic}
          </Badge>
        ) : null,
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
      render: (q) => <span className="text-xs text-gray-400 ml-auto font-mono">{q.bankItemId ?? q.id}</span>,
    },
  ],

  editFields: [
    {
      key: 'domain' as keyof ScienceQCQuestion & string,
      label: 'Chapter (Domain)',
      type: 'select',
      options: ALL_DOMAINS.map((d) => ({ value: d, label: DOMAIN_LABELS[d] ?? d })),
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
      key: 'type',
      label: 'Type',
      type: 'select',
      options: [
        { value: 'mcq', label: 'MCQ' },
        { value: 'spr', label: 'SPR' },
      ],
    },
    {
      key: 'chapter' as keyof ScienceQCQuestion & string,
      label: 'Topic (chapter)',
      type: 'text',
    },
    {
      key: 'subtopic' as keyof ScienceQCQuestion & string,
      label: 'Subtopic',
      type: 'text',
    },
    {
      key: 'correctAnswer',
      label: 'Correct Answer',
      type: 'text',
      colSpan: 3,
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
      key: 'options' as keyof ScienceQCQuestion & string,
      label: 'Options (JSON)',
      type: 'json',
      rows: 6,
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
      {q.options && q.options.length > 0 && (
        <div className="space-y-2">
          {q.options.map((opt) => {
            const isCorrect = opt.id === q.correctAnswer;
            return (
              <div
                key={opt.id}
                className={`flex items-start gap-3 p-3 rounded-lg border-2 ${
                  isCorrect ? 'border-green-400 bg-green-50' : 'border-gray-200'
                }`}
              >
                <span
                  className={`w-7 h-7 rounded-full border-2 flex items-center justify-center text-xs font-bold shrink-0 mt-0.5 ${
                    isCorrect ? 'border-green-500 bg-green-500 text-white' : 'border-gray-300 text-gray-500'
                  }`}
                >
                  {opt.id}
                </span>
                <span className="text-sm text-gray-800 leading-relaxed pt-0.5">
                  {renderMixedContent(opt.text)}
                </span>
              </div>
            );
          })}
        </div>
      )}
      {q.type === 'spr' && (
        <div className="text-sm text-gray-600">
          Correct answer (SPR): <strong className="font-mono">{q.correctAnswer}</strong>
        </div>
      )}
      {q.explanation && (
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 text-sm text-blue-800">
          <p className="font-medium mb-1">Explanation:</p>
          <div>{renderMixedContent(q.explanation)}</div>
        </div>
      )}
    </>
  ),
};

export default function CBSE10ScienceQCPage() {
  return <QCPageTemplate config={config} />;
}

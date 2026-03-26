'use client';

import QCPageTemplate from '@/components/admin/QCPageTemplate';
import type { QCPageConfig, QCQuestion } from '@/components/admin/qc-types';
import { Badge } from '@/design-system/components/ui/badge';
import type { SATSection, SATDomain, DifficultyTier, SATQuestion } from '@/types/sat-test';
import QuestionRenderer from '@/components/sat-test/question-types/QuestionRenderer';
import { renderMixedContent } from '@/components/MathRenderer';
import { satPromptImageUrls } from '@/lib/sat-prompt-images';

type SATQCQuestion = QCQuestion & SATQuestion & {
  section?: SATSection;
  domain?: SATDomain;
  passage?: string;
  moduleNumber: number;
  setNumber: number;
};

const DIFFICULTY_COLORS: Record<DifficultyTier, string> = {
  easy: 'bg-green-100 text-green-800',
  medium: 'bg-yellow-100 text-yellow-800',
  hard: 'bg-red-100 text-red-800',
};

const DOMAIN_LABELS: Record<string, string> = {
  algebra: 'Algebra',
  'advanced-math': 'Advanced Math',
  'problem-solving': 'Problem Solving',
  'geometry-trig': 'Geometry & Trig',
  'craft-structure': 'Craft & Structure',
  'information-ideas': 'Information & Ideas',
  'standard-english': 'Standard English',
  'expression-of-ideas': 'Expression of Ideas',
};

const MATH_DOMAINS: SATDomain[] = ['algebra', 'advanced-math', 'problem-solving', 'geometry-trig'];
const RW_DOMAINS: SATDomain[] = ['craft-structure', 'information-ideas', 'standard-english', 'expression-of-ideas'];
const ALL_DOMAINS: SATDomain[] = [...RW_DOMAINS, ...MATH_DOMAINS];

const DIFF_ORDER: Record<DifficultyTier, number> = { easy: 0, medium: 1, hard: 2 };

const config: QCPageConfig<SATQCQuestion> = {
  title: 'SAT Questions QC',
  breadcrumbLabel: 'SAT Questions QC',
  subtitle: 'Review and edit all SAT questions.',
  apiBase: '/api/admin/sat-questions',
  hasImageUpload: true,
  hasAIRegenerate: true,
  hasPassage: true,

  filters: [
    {
      key: 'section',
      label: 'Section',
      options: [
        { value: 'all', label: 'All' },
        { value: 'rw', label: 'Reading & Writing' },
        { value: 'math', label: 'Math' },
      ],
      onChangeSideEffect: (value, setFilters) => {
        setFilters((f) => ({ ...f, domain: 'all' }));
      },
    },
    {
      key: 'pool',
      label: 'Pool',
      options: [
        { value: 'all', label: 'All' },
        { value: 'test', label: 'Test Only' },
        { value: 'practice', label: 'Practice Only' },
      ],
    },
    {
      key: 'domain',
      label: 'Domain',
      options: 'dynamic',
      deriveOptions: () => {
        return [
          { value: 'all', label: 'All' },
          ...ALL_DOMAINS.map((d) => ({ value: d, label: DOMAIN_LABELS[d] ?? d })),
        ];
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
      key: 'module',
      label: 'Module',
      options: 'dynamic',
      deriveOptions: (questions) => {
        const mods = Array.from(new Set(questions.map((q) => (q as SATQCQuestion).moduleNumber))).sort((a, b) => a - b);
        return [
          { value: 'all', label: 'All' },
          ...mods.map((m) => ({ value: String(m), label: m === 0 ? 'Practice (0)' : `Module ${m}` })),
        ];
      },
    },
    {
      key: 'set',
      label: 'Set',
      options: 'dynamic',
      deriveOptions: (questions) => {
        const sets = Array.from(new Set(questions.map((q) => (q as SATQCQuestion).setNumber))).sort((a, b) => a - b);
        return [
          { value: 'all', label: 'All' },
          ...sets.map((s) => ({ value: String(s), label: s === 0 ? 'Practice (0)' : `Set ${s}` })),
        ];
      },
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
    if (filters.section !== 'all' && q.section !== filters.section) return false;
    if (filters.pool === 'test' && q.moduleNumber === 0) return false;
    if (filters.pool === 'practice' && q.moduleNumber !== 0) return false;
    if (filters.domain !== 'all' && q.domain !== filters.domain) return false;
    if (filters.difficulty !== 'all' && q.difficulty !== filters.difficulty) return false;
    if (filters.set !== 'all' && q.setNumber !== Number(filters.set)) return false;
    if (filters.module !== 'all' && q.moduleNumber !== Number(filters.module)) return false;
    if (filters.qc === 'done' && !q.qcDone) return false;
    if (filters.qc === 'pending' && q.qcDone) return false;
    return true;
  },

  sortFn: (a, b) => {
    const secOrder = (s: string | undefined) => (s === 'rw' ? 0 : 1);
    if (secOrder(a.section) !== secOrder(b.section)) return secOrder(a.section) - secOrder(b.section);
    if (a.moduleNumber !== b.moduleNumber) return a.moduleNumber - b.moduleNumber;
    if (a.setNumber !== b.setNumber) return a.setNumber - b.setNumber;
    if (a.difficulty !== b.difficulty) return DIFF_ORDER[a.difficulty as DifficultyTier] - DIFF_ORDER[b.difficulty as DifficultyTier];
    return 0;
  },

  getResetFilters: () => ({
    section: 'all',
    pool: 'all',
    domain: 'all',
    difficulty: 'all',
    module: 'all',
    set: 'all',
    qc: 'all',
  }),

  metadataBadges: [
    {
      key: 'section',
      render: (q) => (
        <Badge className={q.section === 'rw' ? 'bg-blue-100 text-blue-800' : 'bg-purple-100 text-purple-800'}>
          {q.section === 'rw' ? 'R&W' : 'Math'}
        </Badge>
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
          {q.type.toUpperCase()}
        </Badge>
      ),
    },
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
      key: 'module-set',
      render: (q) => (
        <span className="text-sm text-gray-500">
          {q.moduleNumber === 0 ? 'Practice' : `Module ${q.moduleNumber} / Set ${q.setNumber}`}
        </span>
      ),
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
      key: 'section' as keyof SATQCQuestion & string,
      label: 'Section',
      type: 'select',
      options: [
        { value: 'rw', label: 'R&W' },
        { value: 'math', label: 'Math' },
      ],
    },
    {
      key: 'domain' as keyof SATQCQuestion & string,
      label: 'Domain',
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
      key: 'moduleNumber' as keyof SATQCQuestion & string,
      label: 'Module',
      type: 'number',
    },
    {
      key: 'setNumber' as keyof SATQCQuestion & string,
      label: 'Set',
      type: 'number',
    },
    {
      key: 'correctAnswer',
      label: 'Correct Answer',
      type: 'text',
      colSpan: 3,
    },
    // Content fields
    {
      key: 'passage' as keyof SATQCQuestion & string,
      label: 'Passage',
      type: 'textarea',
      rows: 6,
      colSpan: 3,
      placeholder: 'No passage',
    },
    {
      key: 'prompt',
      label: 'Prompt',
      type: 'textarea',
      rows: 4,
      colSpan: 3,
    },
    {
      key: 'options' as keyof SATQCQuestion & string,
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
      {q.passage && (
        <div className="pb-4 border-b border-gray-200">
          <p className="text-xs font-semibold uppercase text-gray-400 mb-2 tracking-wider">Passage</p>
          <div className="prose prose-sm max-w-none text-gray-700 whitespace-pre-line">
            {renderMixedContent(q.passage)}
          </div>
        </div>
      )}
      {q.prompt && (
        <div className="prose prose-sm max-w-none text-gray-800">{renderMixedContent(q.prompt)}</div>
      )}
      {satPromptImageUrls(q).map((url, i) => (
        <div key={`${url}-${i}`}>
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={url}
            alt={`Question figure ${i + 1}`}
            className="max-w-full rounded-lg border border-gray-200 mb-2"
          />
        </div>
      ))}
      <QuestionRenderer question={q} answer={q.correctAnswer} onAnswer={() => {}} disabled showCorrect />
      {q.explanation && (
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 text-sm text-blue-800">
          <p className="font-medium mb-1">Explanation:</p>
          <div>{renderMixedContent(q.explanation)}</div>
        </div>
      )}
    </>
  ),
};

export default function SATQuestionsQCPage() {
  return <QCPageTemplate config={config} />;
}

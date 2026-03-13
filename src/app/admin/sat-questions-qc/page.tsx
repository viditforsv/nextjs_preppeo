'use client';

import { useEffect, useState, useMemo, useCallback, useRef } from 'react';
import { AdminOnly } from '@/design-system/components/form-components/RoleGuard';
import { Breadcrumb } from '@/design-system/components/breadcrumb';
import { Badge } from '@/design-system/components/ui/badge';
import type { SATSection, SATDomain, DifficultyTier, SATQuestion } from '@/types/sat-test';

type SATQuestionQC = SATQuestion & {
  moduleNumber?: number;
  setNumber?: number;
  aiExplanation?: string;
  aiTheory?: string;
};
import QuestionRenderer from '@/components/sat-test/question-types/QuestionRenderer';
import { renderMixedContent } from '@/components/MathRenderer';
import {
  ChevronLeft,
  ChevronRight,
  Loader2,
  Upload,
  ImageIcon,
  X,
  Save,
  RotateCcw,
  Sparkles,
  Eye,
  Pencil,
} from 'lucide-react';

interface SATQCQuestion {
  id: string;
  type: string;
  section?: SATSection;
  difficulty: DifficultyTier;
  domain?: SATDomain;
  prompt: string;
  passage?: string;
  options?: { id: string; text: string }[];
  correctAnswer: string;
  explanation: string;
  imageUrl?: string;
  moduleNumber: number;
  setNumber: number;
  aiExplanation?: string;
  aiTheory?: string;
}

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

type SectionFilter = 'all' | SATSection;
type PoolFilter = 'all' | 'test' | 'practice';
type DifficultyFilter = 'all' | DifficultyTier;

export default function SATQuestionsQCPage() {
  const [questions, setQuestions] = useState<SATQCQuestion[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [currentIndex, setCurrentIndex] = useState(0);

  const [sectionFilter, setSectionFilter] = useState<SectionFilter>('all');
  const [poolFilter, setPoolFilter] = useState<PoolFilter>('all');
  const [domainFilter, setDomainFilter] = useState<string>('all');
  const [difficultyFilter, setDifficultyFilter] = useState<DifficultyFilter>('all');
  const [setFilter, setSetFilter] = useState<string>('all');
  const [moduleFilter, setModuleFilter] = useState<string>('all');

  const [editMode, setEditMode] = useState(false);
  const [saving, setSaving] = useState(false);
  const [saveMsg, setSaveMsg] = useState<string | null>(null);
  const [regenLoading, setRegenLoading] = useState<'answer' | 'theory' | null>(null);

  // Draft state for editable fields
  const [draft, setDraft] = useState<Partial<SATQCQuestion>>({});

  useEffect(() => {
    (async () => {
      try {
        const res = await fetch('/api/admin/sat-questions');
        if (!res.ok) throw new Error('Failed to fetch questions');
        const data = await res.json();
        setQuestions(data.questions ?? []);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Unknown error');
      } finally {
        setLoading(false);
      }
    })();
  }, []);

  const availableDomains = useMemo(() => {
    if (sectionFilter === 'math') return MATH_DOMAINS;
    if (sectionFilter === 'rw') return RW_DOMAINS;
    return ALL_DOMAINS;
  }, [sectionFilter]);

  const availableSets = useMemo(() => {
    const sets = new Set(questions.map((q) => q.setNumber));
    return Array.from(sets).sort((a, b) => a - b);
  }, [questions]);

  const availableModules = useMemo(() => {
    const mods = new Set(questions.map((q) => q.moduleNumber));
    return Array.from(mods).sort((a, b) => a - b);
  }, [questions]);

  const filtered = useMemo(() => {
    return questions
      .filter((q) => {
        if (sectionFilter !== 'all' && q.section !== sectionFilter) return false;
        if (poolFilter === 'test' && q.moduleNumber === 0) return false;
        if (poolFilter === 'practice' && q.moduleNumber !== 0) return false;
        if (domainFilter !== 'all' && q.domain !== domainFilter) return false;
        if (difficultyFilter !== 'all' && q.difficulty !== difficultyFilter) return false;
        if (setFilter !== 'all' && q.setNumber !== Number(setFilter)) return false;
        if (moduleFilter !== 'all' && q.moduleNumber !== Number(moduleFilter)) return false;
        return true;
      })
      .sort((a, b) => {
        const secOrder = (s: string | undefined) => (s === 'rw' ? 0 : 1);
        if (secOrder(a.section) !== secOrder(b.section)) return secOrder(a.section) - secOrder(b.section);
        if (a.moduleNumber !== b.moduleNumber) return a.moduleNumber - b.moduleNumber;
        if (a.setNumber !== b.setNumber) return a.setNumber - b.setNumber;
        if (a.difficulty !== b.difficulty) return DIFF_ORDER[a.difficulty] - DIFF_ORDER[b.difficulty];
        return 0;
      });
  }, [questions, sectionFilter, poolFilter, domainFilter, difficultyFilter, setFilter, moduleFilter]);

  useEffect(() => {
    setCurrentIndex(0);
  }, [sectionFilter, poolFilter, domainFilter, difficultyFilter, setFilter, moduleFilter]);

  useEffect(() => {
    if (domainFilter !== 'all' && !availableDomains.includes(domainFilter as SATDomain)) {
      setDomainFilter('all');
    }
  }, [sectionFilter, domainFilter, availableDomains]);

  const current = filtered[currentIndex] ?? null;

  // Sync draft when question changes or edit mode enters
  useEffect(() => {
    if (current) {
      setDraft({});
    }
    setEditMode(false);
    setSaveMsg(null);
  }, [current?.id]);

  const merged = useMemo(() => {
    if (!current) return null;
    return { ...current, ...draft } as SATQuestionQC;
  }, [current, draft]);

  const goNext = useCallback(() => {
    setCurrentIndex((i) => Math.min(i + 1, filtered.length - 1));
  }, [filtered.length]);

  const goPrev = useCallback(() => {
    setCurrentIndex((i) => Math.max(i - 1, 0));
  }, []);

  useEffect(() => {
    const handleKey = (e: KeyboardEvent) => {
      if (editMode) return;
      if (e.key === 'ArrowRight') goNext();
      if (e.key === 'ArrowLeft') goPrev();
    };
    window.addEventListener('keydown', handleKey);
    return () => window.removeEventListener('keydown', handleKey);
  }, [goNext, goPrev, editMode]);

  // Image upload
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [uploading, setUploading] = useState(false);

  const handleImageUpload = useCallback(
    async (file: File) => {
      const q = filtered[currentIndex];
      if (!q) return;
      setUploading(true);
      try {
        const form = new FormData();
        form.append('file', file);
        form.append('questionId', q.id);
        const res = await fetch('/api/admin/sat-questions/upload-image', { method: 'POST', body: form });
        if (!res.ok) {
          const data = await res.json();
          alert(data.error ?? 'Upload failed');
          return;
        }
        const { url } = await res.json();
        setQuestions((prev) => prev.map((qn) => (qn.id === q.id ? { ...qn, imageUrl: url } : qn)));
      } catch (err) {
        alert(err instanceof Error ? err.message : 'Upload failed');
      } finally {
        setUploading(false);
        if (fileInputRef.current) fileInputRef.current.value = '';
      }
    },
    [currentIndex, filtered]
  );

  const removeImage = useCallback(async () => {
    const q = filtered[currentIndex];
    if (!q || !q.imageUrl) return;
    if (!confirm('Remove image from this question?')) return;
    setUploading(true);
    try {
      const res = await fetch('/api/admin/sat-questions/upload-image', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ questionId: q.id }),
      });
      if (res.ok) {
        setQuestions((prev) => prev.map((qn) => (qn.id === q.id ? { ...qn, imageUrl: undefined } : qn)));
      }
    } finally {
      setUploading(false);
    }
  }, [currentIndex, filtered]);

  // Save edits
  const handleSave = useCallback(async () => {
    if (!current || Object.keys(draft).length === 0) return;
    setSaving(true);
    setSaveMsg(null);
    try {
      const res = await fetch('/api/admin/sat-questions', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ questionId: current.id, ...draft }),
      });
      if (!res.ok) {
        const d = await res.json();
        setSaveMsg(`Error: ${d.error}`);
        return;
      }
      setQuestions((prev) => prev.map((q) => (q.id === current.id ? { ...q, ...draft } : q)));
      setDraft({});
      setEditMode(false);
      setSaveMsg('Saved!');
      setTimeout(() => setSaveMsg(null), 2000);
    } catch {
      setSaveMsg('Save failed');
    } finally {
      setSaving(false);
    }
  }, [current, draft]);

  const handleDiscard = useCallback(() => {
    setDraft({});
    setEditMode(false);
    setSaveMsg(null);
  }, []);

  // AI Regeneration
  const handleRegenerate = useCallback(
    async (mode: 'answer' | 'theory') => {
      if (!current) return;
      setRegenLoading(mode);
      try {
        const res = await fetch('/api/admin/sat-questions/regenerate-ai', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ questionId: current.id, mode }),
        });
        const data = await res.json();
        if (!res.ok) {
          alert(data.error ?? 'Regeneration failed');
          return;
        }
        const field = mode === 'theory' ? 'aiTheory' : 'aiExplanation';
        setQuestions((prev) => prev.map((q) => (q.id === current.id ? { ...q, [field]: data.text } : q)));
        setDraft((d) => ({ ...d, [field]: data.text }));
      } catch {
        alert('Regeneration failed');
      } finally {
        setRegenLoading(null);
      }
    },
    [current]
  );

  const updateDraft = (key: keyof SATQCQuestion, value: unknown) => {
    setDraft((d) => ({ ...d, [key]: value }));
  };

  return (
    <AdminOnly>
      <div className="min-h-screen bg-background pb-20">
        <div className="container mx-auto px-4 py-8">
          <div className="mb-6">
            <Breadcrumb
              items={[
                { label: 'Home', href: '/' },
                { label: 'Site Administration', href: '/admin/site-administration' },
                { label: 'SAT Questions QC', isActive: true },
              ]}
            />
          </div>

          <div className="mb-6 flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground">SAT Questions QC</h1>
              <p className="text-muted-foreground mt-1">
                Review and edit all SAT questions. {editMode ? 'Edit mode active.' : 'Arrow keys to navigate.'}
              </p>
            </div>
            {current && (
              <button
                onClick={() => {
                  if (editMode && Object.keys(draft).length > 0) {
                    if (!confirm('Discard unsaved changes?')) return;
                  }
                  if (editMode) handleDiscard();
                  else setEditMode(true);
                }}
                className={`inline-flex items-center gap-2 px-4 py-2 text-sm font-medium rounded-lg transition-colors ${
                  editMode
                    ? 'bg-gray-200 text-gray-700 hover:bg-gray-300'
                    : 'bg-blue-600 text-white hover:bg-blue-700'
                }`}
              >
                {editMode ? (
                  <>
                    <Eye className="w-4 h-4" /> View Mode
                  </>
                ) : (
                  <>
                    <Pencil className="w-4 h-4" /> Edit Mode
                  </>
                )}
              </button>
            )}
          </div>

          {/* Filters */}
          <div className="flex flex-wrap items-center gap-4 mb-6 p-4 bg-gray-50 rounded-xl border border-gray-200">
            <FilterSelect
              label="Section"
              value={sectionFilter}
              onChange={(v) => setSectionFilter(v as SectionFilter)}
              options={[
                { value: 'all', label: 'All' },
                { value: 'rw', label: 'Reading & Writing' },
                { value: 'math', label: 'Math' },
              ]}
            />
            <FilterSelect
              label="Pool"
              value={poolFilter}
              onChange={(v) => setPoolFilter(v as PoolFilter)}
              options={[
                { value: 'all', label: 'All' },
                { value: 'test', label: 'Test Only' },
                { value: 'practice', label: 'Practice Only' },
              ]}
            />
            <FilterSelect
              label="Domain"
              value={domainFilter}
              onChange={setDomainFilter}
              options={[
                { value: 'all', label: 'All' },
                ...availableDomains.map((d) => ({ value: d, label: DOMAIN_LABELS[d] ?? d })),
              ]}
            />
            <FilterSelect
              label="Difficulty"
              value={difficultyFilter}
              onChange={(v) => setDifficultyFilter(v as DifficultyFilter)}
              options={[
                { value: 'all', label: 'All' },
                { value: 'easy', label: 'Easy' },
                { value: 'medium', label: 'Medium' },
                { value: 'hard', label: 'Hard' },
              ]}
            />
            <FilterSelect
              label="Module"
              value={moduleFilter}
              onChange={setModuleFilter}
              options={[
                { value: 'all', label: 'All' },
                ...availableModules.map((m) => ({ value: String(m), label: m === 0 ? 'Practice (0)' : `Module ${m}` })),
              ]}
            />
            <FilterSelect
              label="Set"
              value={setFilter}
              onChange={setSetFilter}
              options={[
                { value: 'all', label: 'All' },
                ...availableSets.map((s) => ({ value: String(s), label: s === 0 ? 'Practice (0)' : `Set ${s}` })),
              ]}
            />
            <div className="ml-auto text-sm text-gray-500">
              {filtered.length} question{filtered.length !== 1 ? 's' : ''}
            </div>
          </div>

          {/* Content */}
          {loading && (
            <div className="flex items-center justify-center py-20">
              <Loader2 className="w-8 h-8 animate-spin text-gray-400" />
            </div>
          )}

          {error && (
            <div className="bg-red-50 border border-red-200 rounded-lg p-4 text-red-700">{error}</div>
          )}

          {!loading && !error && filtered.length === 0 && (
            <div className="text-center py-20 text-gray-500">No questions match the current filters.</div>
          )}

          {!loading && !error && merged && current && (
            <div className="max-w-3xl mx-auto space-y-4">
              {/* Metadata bar (view) / Metadata editor (edit) */}
              {!editMode ? (
                <div className="flex items-center gap-2 flex-wrap">
                  <Badge className={merged.section === 'rw' ? 'bg-blue-100 text-blue-800' : 'bg-purple-100 text-purple-800'}>
                    {merged.section === 'rw' ? 'R&W' : 'Math'}
                  </Badge>
                  <Badge className={DIFFICULTY_COLORS[merged.difficulty]}>
                    {merged.difficulty.charAt(0).toUpperCase() + merged.difficulty.slice(1)}
                  </Badge>
                  <Badge variant="outline" className="text-xs">
                    {merged.type.toUpperCase()}
                  </Badge>
                  {merged.domain && (
                    <Badge variant="secondary" className="text-xs">
                      {DOMAIN_LABELS[merged.domain] ?? merged.domain}
                    </Badge>
                  )}
                  <span className="text-sm text-gray-500">
                    {merged.moduleNumber === 0 ? 'Practice' : `Module ${merged.moduleNumber} / Set ${merged.setNumber}`}
                  </span>
                  <span className="text-xs text-gray-400 ml-auto font-mono">{merged.id}</span>
                </div>
              ) : (
                <div className="bg-gray-50 border border-gray-200 rounded-xl p-4 space-y-3">
                  <p className="text-xs font-semibold text-gray-500 uppercase tracking-wider">Metadata</p>
                  <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
                    <EditSelect
                      label="Section"
                      value={(draft.section ?? current.section) || 'math'}
                      onChange={(v) => updateDraft('section', v)}
                      options={[
                        { value: 'rw', label: 'R&W' },
                        { value: 'math', label: 'Math' },
                      ]}
                    />
                    <EditSelect
                      label="Domain"
                      value={(draft.domain ?? current.domain) || ''}
                      onChange={(v) => updateDraft('domain', v)}
                      options={ALL_DOMAINS.map((d) => ({ value: d, label: DOMAIN_LABELS[d] ?? d }))}
                    />
                    <EditSelect
                      label="Difficulty"
                      value={draft.difficulty ?? current.difficulty}
                      onChange={(v) => updateDraft('difficulty', v)}
                      options={[
                        { value: 'easy', label: 'Easy' },
                        { value: 'medium', label: 'Medium' },
                        { value: 'hard', label: 'Hard' },
                      ]}
                    />
                    <EditSelect
                      label="Type"
                      value={draft.type ?? current.type}
                      onChange={(v) => updateDraft('type', v)}
                      options={[
                        { value: 'mcq', label: 'MCQ' },
                        { value: 'spr', label: 'SPR' },
                      ]}
                    />
                    <div>
                      <label className="text-xs font-medium text-gray-600">Module</label>
                      <input
                        type="number"
                        min={0}
                        value={draft.moduleNumber ?? current.moduleNumber}
                        onChange={(e) => updateDraft('moduleNumber', Number(e.target.value))}
                        className="w-full border border-gray-300 rounded-md px-2 py-1 text-sm"
                      />
                    </div>
                    <div>
                      <label className="text-xs font-medium text-gray-600">Set</label>
                      <input
                        type="number"
                        min={0}
                        value={draft.setNumber ?? current.setNumber}
                        onChange={(e) => updateDraft('setNumber', Number(e.target.value))}
                        className="w-full border border-gray-300 rounded-md px-2 py-1 text-sm"
                      />
                    </div>
                  </div>
                  <div>
                    <label className="text-xs font-medium text-gray-600">Correct Answer</label>
                    <input
                      type="text"
                      value={draft.correctAnswer ?? current.correctAnswer}
                      onChange={(e) => updateDraft('correctAnswer', e.target.value)}
                      className="w-full border border-gray-300 rounded-md px-2 py-1 text-sm font-mono"
                    />
                  </div>
                  <p className="text-xs text-gray-400 font-mono">ID: {current.id}</p>
                </div>
              )}

              {/* Question card */}
              <div className="bg-white border border-gray-200 rounded-xl p-6 space-y-5">
                {/* Passage */}
                {editMode ? (
                  <div>
                    <label className="text-xs font-semibold uppercase text-gray-400 tracking-wider">Passage</label>
                    <textarea
                      value={draft.passage ?? current.passage ?? ''}
                      onChange={(e) => updateDraft('passage', e.target.value)}
                      rows={6}
                      className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm mt-1 font-mono"
                      placeholder="No passage"
                    />
                  </div>
                ) : (
                  merged.passage && (
                    <div className="pb-4 border-b border-gray-200">
                      <p className="text-xs font-semibold uppercase text-gray-400 mb-2 tracking-wider">Passage</p>
                      <div className="prose prose-sm max-w-none text-gray-700 whitespace-pre-line">
                        {renderMixedContent(merged.passage)}
                      </div>
                    </div>
                  )
                )}

                {/* Prompt */}
                {editMode ? (
                  <div>
                    <label className="text-xs font-semibold uppercase text-gray-400 tracking-wider">Prompt</label>
                    <textarea
                      value={draft.prompt ?? current.prompt}
                      onChange={(e) => updateDraft('prompt', e.target.value)}
                      rows={4}
                      className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm mt-1 font-mono"
                    />
                  </div>
                ) : (
                  merged.prompt && (
                    <div className="prose prose-sm max-w-none text-gray-800">
                      {renderMixedContent(merged.prompt)}
                    </div>
                  )
                )}

                {/* Image */}
                {merged.imageUrl && !editMode && (
                  <div>
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    <img
                      src={merged.imageUrl}
                      alt="Question figure"
                      className="max-w-full rounded-lg border border-gray-200"
                    />
                  </div>
                )}

                {/* Answer options */}
                {editMode ? (
                  <div>
                    <label className="text-xs font-semibold uppercase text-gray-400 tracking-wider">Options (JSON)</label>
                    <textarea
                      value={JSON.stringify(draft.options ?? current.options ?? [], null, 2)}
                      onChange={(e) => {
                        try {
                          const parsed = JSON.parse(e.target.value);
                          updateDraft('options', parsed);
                        } catch {
                          // let user keep typing
                        }
                      }}
                      rows={6}
                      className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm mt-1 font-mono"
                    />
                  </div>
                ) : (
                  <QuestionRenderer
                    question={merged}
                    answer={merged.correctAnswer}
                    onAnswer={() => {}}
                    disabled
                    showCorrect
                  />
                )}

                {/* Explanation */}
                {editMode ? (
                  <div>
                    <label className="text-xs font-semibold uppercase text-gray-400 tracking-wider">Explanation</label>
                    <textarea
                      value={draft.explanation ?? current.explanation ?? ''}
                      onChange={(e) => updateDraft('explanation', e.target.value)}
                      rows={4}
                      className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm mt-1 font-mono"
                    />
                  </div>
                ) : (
                  merged.explanation && (
                    <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 text-sm text-blue-800">
                      <p className="font-medium mb-1">Explanation:</p>
                      <div>{renderMixedContent(merged.explanation)}</div>
                    </div>
                  )
                )}
              </div>

              {/* AI Explanation & Theory section */}
              <div className="bg-white border border-gray-200 rounded-xl p-6 space-y-5">
                <p className="text-xs font-semibold uppercase text-gray-400 tracking-wider flex items-center gap-1.5">
                  <Sparkles className="w-3.5 h-3.5" /> AI-Generated Content
                </p>

                {/* AI Explanation */}
                <div>
                  <div className="flex items-center justify-between mb-1">
                    <label className="text-xs font-medium text-gray-600">AI Explanation</label>
                    <button
                      onClick={() => handleRegenerate('answer')}
                      disabled={regenLoading !== null}
                      className="inline-flex items-center gap-1 text-xs font-medium text-blue-600 hover:text-blue-800 disabled:opacity-50"
                    >
                      {regenLoading === 'answer' ? (
                        <Loader2 className="w-3 h-3 animate-spin" />
                      ) : (
                        <RotateCcw className="w-3 h-3" />
                      )}
                      Regenerate
                    </button>
                  </div>
                  {editMode ? (
                    <textarea
                      value={draft.aiExplanation ?? current.aiExplanation ?? ''}
                      onChange={(e) => updateDraft('aiExplanation', e.target.value)}
                      rows={5}
                      className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm font-mono"
                      placeholder="No AI explanation cached. Click Regenerate or type manually."
                    />
                  ) : (
                    <div className="bg-green-50 border border-green-200 rounded-lg p-3 text-sm text-green-800 whitespace-pre-wrap">
                      {merged.aiExplanation || <span className="italic text-gray-400">No AI explanation cached.</span>}
                    </div>
                  )}
                </div>

                {/* AI Theory */}
                <div>
                  <div className="flex items-center justify-between mb-1">
                    <label className="text-xs font-medium text-gray-600">AI Theory</label>
                    <button
                      onClick={() => handleRegenerate('theory')}
                      disabled={regenLoading !== null}
                      className="inline-flex items-center gap-1 text-xs font-medium text-indigo-600 hover:text-indigo-800 disabled:opacity-50"
                    >
                      {regenLoading === 'theory' ? (
                        <Loader2 className="w-3 h-3 animate-spin" />
                      ) : (
                        <RotateCcw className="w-3 h-3" />
                      )}
                      Regenerate
                    </button>
                  </div>
                  {editMode ? (
                    <textarea
                      value={draft.aiTheory ?? current.aiTheory ?? ''}
                      onChange={(e) => updateDraft('aiTheory', e.target.value)}
                      rows={5}
                      className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm font-mono"
                      placeholder="No AI theory cached. Click Regenerate or type manually."
                    />
                  ) : (
                    <div className="bg-indigo-50 border border-indigo-200 rounded-lg p-3 text-sm text-indigo-800 whitespace-pre-wrap">
                      {merged.aiTheory || <span className="italic text-gray-400">No AI theory cached.</span>}
                    </div>
                  )}
                </div>
              </div>

              {/* Image management */}
              <div className="bg-white border border-gray-200 rounded-xl p-4 flex items-center gap-3">
                {current.imageUrl ? (
                  <div className="relative inline-block">
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    <img
                      src={current.imageUrl}
                      alt="Question diagram"
                      className="max-w-full h-auto rounded-lg border border-gray-200"
                      style={{ maxHeight: 300 }}
                    />
                    <button
                      onClick={removeImage}
                      disabled={uploading}
                      className="absolute top-2 right-2 p-1 bg-red-500 text-white rounded-full hover:bg-red-600 transition-colors"
                      title="Remove image"
                    >
                      <X className="w-4 h-4" />
                    </button>
                  </div>
                ) : (
                  <div className="flex items-center gap-2 text-sm text-gray-400">
                    <ImageIcon className="w-4 h-4" />
                    No image attached
                  </div>
                )}
                <input
                  ref={fileInputRef}
                  type="file"
                  accept="image/*"
                  className="hidden"
                  onChange={(e) => {
                    const f = e.target.files?.[0];
                    if (f) handleImageUpload(f);
                  }}
                />
                <button
                  onClick={() => fileInputRef.current?.click()}
                  disabled={uploading}
                  className="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-medium rounded-md border border-gray-300 bg-white hover:bg-gray-50 disabled:opacity-50 transition-colors"
                >
                  {uploading ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <Upload className="w-3.5 h-3.5" />}
                  {current.imageUrl ? 'Replace' : 'Upload'} Image
                </button>
              </div>

              {/* Save bar (edit mode) */}
              {editMode && (
                <div className="flex items-center gap-3 bg-yellow-50 border border-yellow-200 rounded-xl p-4">
                  <button
                    onClick={handleSave}
                    disabled={saving || Object.keys(draft).length === 0}
                    className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg bg-green-600 text-white hover:bg-green-700 disabled:opacity-50 transition-colors"
                  >
                    {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                    Save Changes
                  </button>
                  <button
                    onClick={handleDiscard}
                    className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg border border-gray-300 bg-white hover:bg-gray-50 transition-colors"
                  >
                    Discard
                  </button>
                  {saveMsg && (
                    <span className={`text-sm font-medium ${saveMsg.startsWith('Error') ? 'text-red-600' : 'text-green-600'}`}>
                      {saveMsg}
                    </span>
                  )}
                  {Object.keys(draft).length > 0 && (
                    <span className="text-xs text-yellow-700 ml-auto">
                      {Object.keys(draft).length} field{Object.keys(draft).length !== 1 ? 's' : ''} changed
                    </span>
                  )}
                </div>
              )}

              {/* Navigation */}
              <div className="flex items-center justify-between">
                <button
                  onClick={goPrev}
                  disabled={currentIndex === 0}
                  className="inline-flex items-center gap-1.5 px-5 py-2.5 text-sm font-medium rounded-lg border border-gray-300 bg-white hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
                >
                  <ChevronLeft className="w-4 h-4" />
                  Previous
                </button>
                <span className="text-sm font-semibold text-gray-700 tabular-nums">
                  {currentIndex + 1} / {filtered.length}
                </span>
                <button
                  onClick={goNext}
                  disabled={currentIndex === filtered.length - 1}
                  className="inline-flex items-center gap-1.5 px-5 py-2.5 text-sm font-medium rounded-lg border border-gray-300 bg-white hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
                >
                  Next
                  <ChevronRight className="w-4 h-4" />
                </button>
              </div>
            </div>
          )}
        </div>

        {/* Sticky bottom nav */}
        {!loading && !error && filtered.length > 0 && (
          <div className="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 shadow-lg z-50">
            <div className="max-w-3xl mx-auto flex items-center justify-between px-4 py-3">
              <button
                onClick={goPrev}
                disabled={currentIndex === 0}
                className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg border border-gray-300 bg-white hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
              >
                <ChevronLeft className="w-4 h-4" />
                Previous
              </button>
              <span className="text-sm font-semibold text-gray-700 tabular-nums">
                {currentIndex + 1} / {filtered.length}
              </span>
              <button
                onClick={goNext}
                disabled={currentIndex === filtered.length - 1}
                className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg border border-gray-300 bg-white hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
              >
                Next
                <ChevronRight className="w-4 h-4" />
              </button>
            </div>
          </div>
        )}
      </div>
    </AdminOnly>
  );
}

function FilterSelect({
  label,
  value,
  onChange,
  options,
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
  options: { value: string; label: string }[];
}) {
  return (
    <div className="flex items-center gap-2">
      <label className="text-sm font-medium text-gray-700">{label}:</label>
      <select
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className="border border-gray-300 rounded-md px-3 py-1.5 text-sm bg-white"
      >
        {options.map((o) => (
          <option key={o.value} value={o.value}>
            {o.label}
          </option>
        ))}
      </select>
    </div>
  );
}

function EditSelect({
  label,
  value,
  onChange,
  options,
}: {
  label: string;
  value: string;
  onChange: (v: string) => void;
  options: { value: string; label: string }[];
}) {
  return (
    <div>
      <label className="text-xs font-medium text-gray-600">{label}</label>
      <select
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className="w-full border border-gray-300 rounded-md px-2 py-1 text-sm"
      >
        {options.map((o) => (
          <option key={o.value} value={o.value}>
            {o.label}
          </option>
        ))}
      </select>
    </div>
  );
}

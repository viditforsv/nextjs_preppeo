'use client';

import { useEffect, useState, useMemo, useCallback, useRef } from 'react';
import { AdminOnly } from '@/design-system/components/form-components/RoleGuard';
import { Breadcrumb } from '@/design-system/components/breadcrumb';
import { Badge } from '@/design-system/components/ui/badge';
import type { CBSE10MathsDomain, DifficultyTier } from '@/types/cbse10-maths';
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
  CheckCircle2,
  Trash2,
} from 'lucide-react';

interface CBSE10QCQuestion {
  id: string;
  type: string;
  difficulty: DifficultyTier;
  domain?: string;
  chapter?: string;
  subtopic?: string;
  prompt: string;
  options?: { id: string; text: string }[];
  correctAnswer: string;
  explanation: string;
  imageUrl?: string;
  bankItemId?: string;
  aiExplanation?: string;
  aiTheory?: string;
  qcDone?: boolean;
}

const DIFFICULTY_COLORS: Record<DifficultyTier, string> = {
  easy: 'bg-green-100 text-green-800',
  medium: 'bg-yellow-100 text-yellow-800',
  hard: 'bg-red-100 text-red-800',
};

const DOMAIN_LABELS: Record<string, string> = {
  'real-numbers': 'Real Numbers',
  'polynomials': 'Polynomials',
  'linear-equations': 'Linear Equations',
  'quadratic-equations': 'Quadratic Equations',
  'arithmetic-progressions': 'Arithmetic Progressions',
  'triangles': 'Triangles',
  'coordinate-geometry': 'Coordinate Geometry',
  'trigonometry': 'Trigonometry',
  'applications-of-trig': 'Applications of Trig',
  'circles': 'Circles',
  'areas-related-to-circles': 'Areas Related to Circles',
  'surface-areas-volumes': 'Surface Areas & Volumes',
  'statistics': 'Statistics',
  'probability': 'Probability',
};

const ALL_DOMAINS: CBSE10MathsDomain[] = [
  'real-numbers', 'polynomials', 'linear-equations', 'quadratic-equations',
  'arithmetic-progressions', 'triangles', 'coordinate-geometry', 'trigonometry',
  'applications-of-trig', 'circles', 'areas-related-to-circles',
  'surface-areas-volumes', 'statistics', 'probability',
];

const DIFF_ORDER: Record<DifficultyTier, number> = { easy: 0, medium: 1, hard: 2 };

type DifficultyFilter = 'all' | DifficultyTier;
type QCFilter = 'all' | 'done' | 'pending';

export default function CBSE10MathsQCPage() {
  const [questions, setQuestions] = useState<CBSE10QCQuestion[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [currentIndex, setCurrentIndex] = useState(0);

  const [domainFilter, setDomainFilter] = useState<string>('all');
  const [chapterFilter, setChapterFilter] = useState<string>('all');
  const [subtopicFilter, setSubtopicFilter] = useState<string>('all');
  const [difficultyFilter, setDifficultyFilter] = useState<DifficultyFilter>('all');
  const [qcFilter, setQCFilter] = useState<QCFilter>('all');

  const [editMode, setEditMode] = useState(false);
  const [saving, setSaving] = useState(false);
  const [saveMsg, setSaveMsg] = useState<string | null>(null);
  const [regenLoading, setRegenLoading] = useState<'answer' | 'theory' | null>(null);

  const [draft, setDraft] = useState<Partial<CBSE10QCQuestion>>({});
  const [optionsJsonStr, setOptionsJsonStr] = useState('[]');
  const [optionsJsonValid, setOptionsJsonValid] = useState(true);
  const [uuidSearch, setUuidSearch] = useState('');
  const pendingUuidRef = useRef<string | null>(null);
  const handleSaveRef = useRef<() => void>(() => {});

  useEffect(() => {
    (async () => {
      try {
        const res = await fetch('/api/admin/cbse10-maths-questions');
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

  const availableChapters = useMemo(() => {
    const set = new Set(questions.map((q) => q.chapter).filter(Boolean) as string[]);
    return Array.from(set).sort();
  }, [questions]);

  const availableSubtopics = useMemo(() => {
    const set = new Set(questions.map((q) => q.subtopic).filter(Boolean) as string[]);
    return Array.from(set).sort();
  }, [questions]);

  const filtered = useMemo(() => {
    return questions
      .filter((q) => {
        if (domainFilter !== 'all' && q.domain !== domainFilter) return false;
        if (chapterFilter !== 'all' && q.chapter !== chapterFilter) return false;
        if (subtopicFilter !== 'all' && q.subtopic !== subtopicFilter) return false;
        if (difficultyFilter !== 'all' && q.difficulty !== difficultyFilter) return false;
        if (qcFilter === 'done' && !q.qcDone) return false;
        if (qcFilter === 'pending' && q.qcDone) return false;
        return true;
      })
      .sort((a, b) => {
        const dA = a.domain ?? '';
        const dB = b.domain ?? '';
        if (dA !== dB) return dA.localeCompare(dB);
        if (a.difficulty !== b.difficulty) return DIFF_ORDER[a.difficulty] - DIFF_ORDER[b.difficulty];
        return 0;
      });
  }, [questions, domainFilter, chapterFilter, subtopicFilter, difficultyFilter, qcFilter]);

  useEffect(() => {
    setCurrentIndex(0);
  }, [domainFilter, chapterFilter, subtopicFilter, difficultyFilter, qcFilter]);

  useEffect(() => {
    const uuid = pendingUuidRef.current;
    if (!uuid) return;
    const idx = filtered.findIndex((q) => q.id === uuid || q.bankItemId === uuid);
    if (idx !== -1) {
      setCurrentIndex(idx);
      pendingUuidRef.current = null;
    }
  }, [filtered]);

  const jumpToUUID = useCallback((uuid: string) => {
    const trimmed = uuid.trim();
    if (!trimmed) return;
    const idx = filtered.findIndex((q) => q.id === trimmed || q.bankItemId === trimmed);
    if (idx !== -1) {
      setCurrentIndex(idx);
      setUuidSearch('');
      return;
    }
    if (!questions.some((q) => q.id === trimmed || q.bankItemId === trimmed)) {
      setSaveMsg('Question UUID not found');
      setTimeout(() => setSaveMsg(null), 3000);
      return;
    }
    pendingUuidRef.current = trimmed;
    setDomainFilter('all');
    setChapterFilter('all');
    setSubtopicFilter('all');
    setDifficultyFilter('all');
    setQCFilter('all');
    setUuidSearch('');
  }, [filtered, questions]);

  const current = filtered[currentIndex] ?? null;

  useEffect(() => {
    if (current) {
      setDraft({});
      setOptionsJsonStr(JSON.stringify(current.options ?? [], null, 2));
      setOptionsJsonValid(true);
    }
    setEditMode(false);
    setSaveMsg(null);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [current?.id]);

  const merged = useMemo(() => {
    if (!current) return null;
    return { ...current, ...draft } as CBSE10QCQuestion;
  }, [current, draft]);

  const goNext = useCallback(() => {
    setCurrentIndex((i) => Math.min(i + 1, filtered.length - 1));
  }, [filtered.length]);

  const goPrev = useCallback(() => {
    setCurrentIndex((i) => Math.max(i - 1, 0));
  }, []);

  useEffect(() => {
    const handleKey = (e: KeyboardEvent) => {
      const tag = (e.target as HTMLElement)?.tagName;
      const isInput = tag === 'INPUT' || tag === 'TEXTAREA' || tag === 'SELECT';

      if (editMode) {
        if ((e.metaKey || e.ctrlKey) && e.key === 'Enter') {
          e.preventDefault();
          handleSaveRef.current();
        }
        return;
      }

      if (!isInput && e.key.toLowerCase() === 'e' && current) {
        e.preventDefault();
        setEditMode(true);
      }
      if (e.key === 'ArrowRight') goNext();
      if (e.key === 'ArrowLeft') goPrev();
    };
    window.addEventListener('keydown', handleKey);
    return () => window.removeEventListener('keydown', handleKey);
  }, [goNext, goPrev, editMode, current]);

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
        const res = await fetch('/api/admin/cbse10-maths-questions/upload-image', { method: 'POST', body: form });
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
      const res = await fetch('/api/admin/cbse10-maths-questions/upload-image', {
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

  const handleSave = useCallback(async () => {
    if (!current || Object.keys(draft).length === 0) return;
    setSaving(true);
    setSaveMsg(null);
    try {
      const res = await fetch('/api/admin/cbse10-maths-questions', {
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
  handleSaveRef.current = handleSave;

  const handleDiscard = useCallback(() => {
    setDraft({});
    setEditMode(false);
    setSaveMsg(null);
  }, []);

  const [deleting, setDeleting] = useState(false);
  const handleDelete = useCallback(async () => {
    if (!current) return;
    if (!confirm(`Delete this question? (${current.id})\nThis will soft-delete it (mark inactive).`)) return;
    setDeleting(true);
    try {
      const res = await fetch('/api/admin/cbse10-maths-questions', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ questionId: current.id }),
      });
      if (!res.ok) {
        const d = await res.json();
        alert(d.error ?? 'Delete failed');
        return;
      }
      setQuestions((prev) => prev.filter((q) => q.id !== current.id));
      setDraft({});
      setEditMode(false);
      setSaveMsg('Deleted');
      setTimeout(() => setSaveMsg(null), 2000);
    } catch {
      alert('Delete failed');
    } finally {
      setDeleting(false);
    }
  }, [current]);

  const [togglingQC, setTogglingQC] = useState(false);
  const handleToggleQC = useCallback(async () => {
    if (!current) return;
    const newVal = !current.qcDone;
    setTogglingQC(true);
    try {
      const res = await fetch('/api/admin/cbse10-maths-questions', {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ questionId: current.id, qcDone: newVal }),
      });
      if (res.ok) {
        setQuestions((prev) => prev.map((q) => (q.id === current.id ? { ...q, qcDone: newVal } : q)));
      }
    } finally {
      setTogglingQC(false);
    }
  }, [current]);

  const handleRegenerate = useCallback(
    async (mode: 'answer' | 'theory') => {
      if (!current) return;
      setRegenLoading(mode);
      try {
        const res = await fetch('/api/admin/cbse10-maths-questions/regenerate-ai', {
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

  const updateDraft = (key: keyof CBSE10QCQuestion, value: unknown) => {
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
                { label: 'CBSE 10 Maths QC', isActive: true },
              ]}
            />
          </div>

          <div className="mb-6 flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground">CBSE 10 Maths QC</h1>
              <p className="text-muted-foreground mt-1">
                Review and edit CBSE Class 10 Mathematics questions.{' '}
                {editMode ? (
                  <span>Edit mode active. <kbd className="px-1.5 py-0.5 bg-gray-200 rounded text-xs font-mono">⌘/Ctrl+Enter</kbd> to save.</span>
                ) : (
                  <span><kbd className="px-1.5 py-0.5 bg-gray-200 rounded text-xs font-mono">←→</kbd> navigate · <kbd className="px-1.5 py-0.5 bg-gray-200 rounded text-xs font-mono">E</kbd> edit</span>
                )}
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
                {editMode ? (<><Eye className="w-4 h-4" /> View Mode</>) : (<><Pencil className="w-4 h-4" /> Edit Mode</>)}
              </button>
            )}
          </div>

          {/* Filters */}
          <div className="flex flex-wrap items-center gap-4 mb-6 p-4 bg-gray-50 rounded-xl border border-gray-200">
            <FilterSelect
              label="Chapter"
              value={domainFilter}
              onChange={(v) => { setDomainFilter(v); setChapterFilter('all'); setSubtopicFilter('all'); }}
              options={[
                { value: 'all', label: 'All Chapters' },
                ...ALL_DOMAINS.map((d) => ({ value: d, label: DOMAIN_LABELS[d] ?? d })),
              ]}
            />
            <FilterSelect
              label="Topic"
              value={chapterFilter}
              onChange={(v) => { setChapterFilter(v); setSubtopicFilter('all'); }}
              options={[
                { value: 'all', label: 'All Topics' },
                ...availableChapters.map((c) => ({ value: c, label: c })),
              ]}
            />
            <FilterSelect
              label="Subtopic"
              value={subtopicFilter}
              onChange={setSubtopicFilter}
              options={[
                { value: 'all', label: 'All Subtopics' },
                ...availableSubtopics.map((s) => ({ value: s, label: s })),
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
              label="QC"
              value={qcFilter}
              onChange={(v) => setQCFilter(v as QCFilter)}
              options={[
                { value: 'all', label: 'All' },
                { value: 'pending', label: 'Pending' },
                { value: 'done', label: 'Done' },
              ]}
            />
            <div className="flex items-center gap-2 ml-auto">
              <div className="flex items-center gap-1">
                <label className="text-xs font-medium text-gray-600 whitespace-nowrap">UUID</label>
                <input
                  type="text"
                  placeholder="Paste question ID…"
                  value={uuidSearch}
                  onChange={(e) => setUuidSearch(e.target.value)}
                  onKeyDown={(e) => { if (e.key === 'Enter') jumpToUUID(uuidSearch); }}
                  className="w-48 border border-gray-300 rounded-md px-2 py-1 text-xs font-mono"
                />
                <button
                  onClick={() => jumpToUUID(uuidSearch)}
                  className="px-2 py-1 text-xs bg-gray-800 text-white rounded-md hover:bg-gray-700"
                >
                  Go
                </button>
              </div>
              <span className="text-sm text-gray-500">
                {filtered.length} question{filtered.length !== 1 ? 's' : ''}
              </span>
            </div>
          </div>

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
                  {merged.domain && (
                    <Badge variant="secondary" className="text-xs">
                      {DOMAIN_LABELS[merged.domain] ?? merged.domain}
                    </Badge>
                  )}
                  <Badge className={DIFFICULTY_COLORS[merged.difficulty]}>
                    {merged.difficulty.charAt(0).toUpperCase() + merged.difficulty.slice(1)}
                  </Badge>
                  <Badge variant="outline" className="text-xs">
                    {merged.type.toUpperCase()}
                  </Badge>
                  {merged.chapter && (
                    <Badge variant="secondary" className="text-xs bg-blue-50 text-blue-700">
                      {merged.chapter}
                    </Badge>
                  )}
                  {merged.subtopic && (
                    <Badge variant="secondary" className="text-xs bg-violet-50 text-violet-700">
                      {merged.subtopic}
                    </Badge>
                  )}
                  <Badge className={merged.qcDone ? 'bg-emerald-100 text-emerald-800' : 'bg-gray-100 text-gray-500'}>
                    {merged.qcDone ? 'QC Done' : 'QC Pending'}
                  </Badge>
                  <span className="text-xs text-gray-400 ml-auto font-mono">{merged.bankItemId ?? merged.id}</span>
                </div>
              ) : (
                <div className="bg-gray-50 border border-gray-200 rounded-xl p-4 space-y-3">
                  <p className="text-xs font-semibold text-gray-500 uppercase tracking-wider">Metadata</p>
                  <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
                    <EditSelect
                      label="Chapter (Domain)"
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
                  </div>
                  <div className="grid grid-cols-2 gap-3">
                    <div>
                      <label className="text-xs font-medium text-gray-600">Topic (chapter)</label>
                      <input
                        type="text"
                        value={draft.chapter ?? current.chapter ?? ''}
                        onChange={(e) => updateDraft('chapter', e.target.value)}
                        className="w-full border border-gray-300 rounded-md px-2 py-1 text-sm"
                      />
                    </div>
                    <div>
                      <label className="text-xs font-medium text-gray-600">Subtopic</label>
                      <input
                        type="text"
                        value={draft.subtopic ?? current.subtopic ?? ''}
                        onChange={(e) => updateDraft('subtopic', e.target.value)}
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
                  <p className="text-xs text-gray-400 font-mono">ID: {current.id}{current.bankItemId ? ` · ${current.bankItemId}` : ''}</p>
                </div>
              )}

              {/* Question card */}
              <div className="bg-white border border-gray-200 rounded-xl p-6 space-y-5">
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

                {merged.imageUrl && !editMode && (
                  <div>
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    <img src={merged.imageUrl} alt="Question figure" className="max-w-full rounded-lg border border-gray-200" />
                  </div>
                )}

                {editMode ? (
                  <div>
                    <label className="text-xs font-semibold uppercase text-gray-400 tracking-wider">Options (JSON)</label>
                    <textarea
                      value={optionsJsonStr}
                      onChange={(e) => {
                        const val = e.target.value;
                        setOptionsJsonStr(val);
                        try {
                          updateDraft('options', JSON.parse(val));
                          setOptionsJsonValid(true);
                        } catch {
                          setOptionsJsonValid(false);
                        }
                      }}
                      rows={6}
                      className={`w-full border rounded-md px-3 py-2 text-sm mt-1 font-mono ${optionsJsonValid ? 'border-gray-300' : 'border-red-500 bg-red-50'}`}
                    />
                    {!optionsJsonValid && <p className="text-xs text-red-500 mt-1">Invalid JSON</p>}
                  </div>
                ) : (
                  merged.options && merged.options.length > 0 && (
                    <div className="space-y-2">
                      {merged.options.map((opt) => {
                        const isCorrect = opt.id === merged.correctAnswer;
                        return (
                          <div
                            key={opt.id}
                            className={`flex items-start gap-3 p-3 rounded-lg border-2 ${
                              isCorrect ? 'border-green-400 bg-green-50' : 'border-gray-200'
                            }`}
                          >
                            <span className={`w-7 h-7 rounded-full border-2 flex items-center justify-center text-xs font-bold shrink-0 mt-0.5 ${
                              isCorrect ? 'border-green-500 bg-green-500 text-white' : 'border-gray-300 text-gray-500'
                            }`}>
                              {opt.id}
                            </span>
                            <span className="text-sm text-gray-800 leading-relaxed pt-0.5">
                              {renderMixedContent(opt.text)}
                            </span>
                          </div>
                        );
                      })}
                    </div>
                  )
                )}

                {merged.type === 'spr' && !editMode && (
                  <div className="text-sm text-gray-600">
                    Correct answer (SPR): <strong className="font-mono">{merged.correctAnswer}</strong>
                  </div>
                )}

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

              {/* AI section */}
              <div className="bg-white border border-gray-200 rounded-xl p-6 space-y-5">
                <p className="text-xs font-semibold uppercase text-gray-400 tracking-wider flex items-center gap-1.5">
                  <Sparkles className="w-3.5 h-3.5" /> AI-Generated Content
                </p>

                <div>
                  <div className="flex items-center justify-between mb-1">
                    <label className="text-xs font-medium text-gray-600">AI Explanation</label>
                    <button
                      onClick={() => handleRegenerate('answer')}
                      disabled={regenLoading !== null}
                      className="inline-flex items-center gap-1 text-xs font-medium text-blue-600 hover:text-blue-800 disabled:opacity-50"
                    >
                      {regenLoading === 'answer' ? <Loader2 className="w-3 h-3 animate-spin" /> : <RotateCcw className="w-3 h-3" />}
                      Regenerate
                    </button>
                  </div>
                  {editMode ? (
                    <textarea
                      value={draft.aiExplanation ?? current.aiExplanation ?? ''}
                      onChange={(e) => updateDraft('aiExplanation', e.target.value)}
                      rows={5}
                      className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm font-mono"
                      placeholder="No AI explanation cached."
                    />
                  ) : (
                    <div className="bg-green-50 border border-green-200 rounded-lg p-3 text-sm text-green-800 whitespace-pre-wrap">
                      {merged.aiExplanation || <span className="italic text-gray-400">No AI explanation cached.</span>}
                    </div>
                  )}
                </div>

                <div>
                  <div className="flex items-center justify-between mb-1">
                    <label className="text-xs font-medium text-gray-600">AI Theory</label>
                    <button
                      onClick={() => handleRegenerate('theory')}
                      disabled={regenLoading !== null}
                      className="inline-flex items-center gap-1 text-xs font-medium text-indigo-600 hover:text-indigo-800 disabled:opacity-50"
                    >
                      {regenLoading === 'theory' ? <Loader2 className="w-3 h-3 animate-spin" /> : <RotateCcw className="w-3 h-3" />}
                      Regenerate
                    </button>
                  </div>
                  {editMode ? (
                    <textarea
                      value={draft.aiTheory ?? current.aiTheory ?? ''}
                      onChange={(e) => updateDraft('aiTheory', e.target.value)}
                      rows={5}
                      className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm font-mono"
                      placeholder="No AI theory cached."
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
                    <img src={current.imageUrl} alt="Question diagram" className="max-w-full h-auto rounded-lg border border-gray-200" style={{ maxHeight: 300 }} />
                    <button onClick={removeImage} disabled={uploading} className="absolute top-2 right-2 p-1 bg-red-500 text-white rounded-full hover:bg-red-600 transition-colors" title="Remove image">
                      <X className="w-4 h-4" />
                    </button>
                  </div>
                ) : (
                  <div className="flex items-center gap-2 text-sm text-gray-400">
                    <ImageIcon className="w-4 h-4" /> No image attached
                  </div>
                )}
                <input ref={fileInputRef} type="file" accept="image/*" className="hidden" onChange={(e) => { const f = e.target.files?.[0]; if (f) handleImageUpload(f); }} />
                <button onClick={() => fileInputRef.current?.click()} disabled={uploading}
                  className="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-medium rounded-md border border-gray-300 bg-white hover:bg-gray-50 disabled:opacity-50 transition-colors"
                >
                  {uploading ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <Upload className="w-3.5 h-3.5" />}
                  {current.imageUrl ? 'Replace' : 'Upload'} Image
                </button>
              </div>

              {/* Save bar */}
              {editMode && (
                <div className="flex items-center gap-3 bg-yellow-50 border border-yellow-200 rounded-xl p-4">
                  <button onClick={handleSave} disabled={saving || Object.keys(draft).length === 0}
                    className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg bg-green-600 text-white hover:bg-green-700 disabled:opacity-50 transition-colors"
                  >
                    {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                    Save Changes
                  </button>
                  <button onClick={handleDiscard}
                    className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg border border-gray-300 bg-white hover:bg-gray-50 transition-colors"
                  >
                    Discard
                  </button>
                  <button onClick={handleDelete} disabled={deleting}
                    className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 disabled:opacity-50 transition-colors ml-auto"
                  >
                    {deleting ? <Loader2 className="w-4 h-4 animate-spin" /> : <Trash2 className="w-4 h-4" />}
                    Delete
                  </button>
                  {saveMsg && (
                    <span className={`text-sm font-medium ${saveMsg.startsWith('Error') || saveMsg === 'Deleted' ? 'text-red-600' : 'text-green-600'}`}>{saveMsg}</span>
                  )}
                  {Object.keys(draft).length > 0 && (
                    <span className="text-xs text-yellow-700">{Object.keys(draft).length} field{Object.keys(draft).length !== 1 ? 's' : ''} changed</span>
                  )}
                </div>
              )}

              {/* Navigation */}
              <div className="flex items-center justify-between">
                <button onClick={goPrev} disabled={currentIndex === 0}
                  className="inline-flex items-center gap-1.5 px-5 py-2.5 text-sm font-medium rounded-lg border border-gray-300 bg-white hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
                >
                  <ChevronLeft className="w-4 h-4" /> Previous
                </button>
                <span className="text-sm font-semibold text-gray-700 tabular-nums">{currentIndex + 1} / {filtered.length}</span>
                <button onClick={goNext} disabled={currentIndex === filtered.length - 1}
                  className="inline-flex items-center gap-1.5 px-5 py-2.5 text-sm font-medium rounded-lg border border-gray-300 bg-white hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
                >
                  Next <ChevronRight className="w-4 h-4" />
                </button>
              </div>
            </div>
          )}
        </div>

        {/* Sticky bottom nav */}
        {!loading && !error && filtered.length > 0 && (
          <div className="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 shadow-lg z-50">
            <div className="max-w-3xl mx-auto flex items-center justify-between px-4 py-3">
              <button onClick={goPrev} disabled={currentIndex === 0}
                className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg border border-gray-300 bg-white hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
              >
                <ChevronLeft className="w-4 h-4" /> Previous
              </button>
              <div className="flex items-center gap-3">
                <button onClick={handleToggleQC} disabled={togglingQC}
                  className={`inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg transition-colors disabled:opacity-50 ${
                    current?.qcDone
                      ? 'bg-emerald-100 text-emerald-700 border border-emerald-300 hover:bg-emerald-200'
                      : 'bg-gray-100 text-gray-700 border border-gray-300 hover:bg-gray-200'
                  }`}
                >
                  {togglingQC ? <Loader2 className="w-4 h-4 animate-spin" /> : <CheckCircle2 className="w-4 h-4" />}
                  {current?.qcDone ? 'QC Done' : 'Mark QC Done'}
                </button>
                <span className="text-sm font-semibold text-gray-700 tabular-nums">{currentIndex + 1} / {filtered.length}</span>
              </div>
              <button onClick={goNext} disabled={currentIndex === filtered.length - 1}
                className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg border border-gray-300 bg-white hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
              >
                Next <ChevronRight className="w-4 h-4" />
              </button>
            </div>
          </div>
        )}
      </div>
    </AdminOnly>
  );
}

function FilterSelect({ label, value, onChange, options }: {
  label: string; value: string; onChange: (v: string) => void; options: { value: string; label: string }[];
}) {
  return (
    <div className="flex items-center gap-2">
      <label className="text-sm font-medium text-gray-700">{label}:</label>
      <select value={value} onChange={(e) => onChange(e.target.value)} className="border border-gray-300 rounded-md px-3 py-1.5 text-sm bg-white">
        {options.map((o) => (<option key={o.value} value={o.value}>{o.label}</option>))}
      </select>
    </div>
  );
}

function EditSelect({ label, value, onChange, options }: {
  label: string; value: string; onChange: (v: string) => void; options: { value: string; label: string }[];
}) {
  return (
    <div>
      <label className="text-xs font-medium text-gray-600">{label}</label>
      <select value={value} onChange={(e) => onChange(e.target.value)} className="w-full border border-gray-300 rounded-md px-2 py-1 text-sm">
        {options.map((o) => (<option key={o.value} value={o.value}>{o.label}</option>))}
      </select>
    </div>
  );
}

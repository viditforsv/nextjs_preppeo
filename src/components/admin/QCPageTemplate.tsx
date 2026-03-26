'use client';

import { useEffect, useState, useMemo, useCallback, useRef } from 'react';
import { AdminOnly } from '@/design-system/components/form-components/RoleGuard';
import { Breadcrumb } from '@/design-system/components/breadcrumb';
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
import type { QCPageConfig, QCQuestion, FilterDef, FilterOption, EditFieldDef } from './qc-types';

interface QCPageTemplateProps<Q extends QCQuestion> {
  config: QCPageConfig<Q>;
}

export default function QCPageTemplate<Q extends QCQuestion>({ config }: QCPageTemplateProps<Q>) {
  const isProd = process.env.NEXT_PUBLIC_ENVIRONMENT === 'prod' || process.env.NEXT_PUBLIC_ENVIRONMENT === 'production';

  const [questions, setQuestions] = useState<Q[]>([]);
  const [loading, setLoading] = useState(!config.fetchOnApply);
  const [error, setError] = useState<string | null>(null);
  const [hasFetched, setHasFetched] = useState(false);
  const [stats, setStats] = useState<Record<string, number> | null>(null);
  const [currentIndex, setCurrentIndex] = useState(0);

  const initialFilters = config.getResetFilters();
  const [filters, setFilters] = useState<Record<string, string>>(initialFilters);

  const [editMode, setEditMode] = useState(false);
  const [saving, setSaving] = useState(false);
  const [saveMsg, setSaveMsg] = useState<string | null>(null);
  const [regenLoading, setRegenLoading] = useState<'answer' | 'theory' | null>(null);

  const [uuidSearch, setUuidSearch] = useState('');
  const pendingUuidRef = useRef<string | null>(null);

  const [draft, setDraft] = useState<Partial<Q>>({});
  const [optionsJsonStr, setOptionsJsonStr] = useState('[]');
  const [optionsJsonValid, setOptionsJsonValid] = useState(true);

  const handleSaveRef = useRef<() => void>(() => {});

  const fetchQuestions = useCallback(async (serverParams?: Record<string, string>) => {
    setLoading(true);
    setError(null);
    setCurrentIndex(0);
    try {
      let url = config.apiBase;
      if (serverParams) {
        const qs = new URLSearchParams(
          Object.entries(serverParams).filter(([, v]) => v && v !== 'all')
        ).toString();
        if (qs) url = `${url}?${qs}`;
      }
      const res = await fetch(url);
      if (!res.ok) throw new Error('Failed to fetch questions');
      const data = await res.json();
      setQuestions(data.questions ?? []);
      setHasFetched(true);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
    } finally {
      setLoading(false);
    }
  }, [config.apiBase]);

  // Auto-fetch on mount unless fetchOnApply mode is enabled
  useEffect(() => {
    if (!config.fetchOnApply) {
      fetchQuestions();
    }
    if (config.statsUrl) {
      fetch(config.statsUrl)
        .then((r) => r.json())
        .then((d) => setStats(d.pending ?? null))
        .catch(() => {});
    }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Derive dynamic filter options from the questions
  const dynamicOptions = useMemo(() => {
    const result: Record<string, FilterOption[]> = {};
    for (const fd of config.filters) {
      if (fd.options === 'dynamic' && fd.deriveOptions) {
        result[fd.key] = fd.deriveOptions(questions);
      }
    }
    return result;
  }, [questions, config.filters]);

  const filtered = useMemo(() => {
    return questions.filter((q) => config.filterFn(q, filters)).sort(config.sortFn);
  }, [questions, filters, config]);

  // Reset index when filters change
  useEffect(() => {
    setCurrentIndex(0);
  }, [filters]);

  // Resolve pending UUID jump
  useEffect(() => {
    const uuid = pendingUuidRef.current;
    if (!uuid) return;
    const matcher = config.matchUuid ?? ((q: Q, u: string) => q.id === u);
    const idx = filtered.findIndex((q) => matcher(q, uuid));
    if (idx !== -1) {
      setCurrentIndex(idx);
      pendingUuidRef.current = null;
    }
  }, [filtered, config]);

  const jumpToUUID = useCallback(
    (uuid: string) => {
      const trimmed = uuid.trim();
      if (!trimmed) return;
      const matcher = config.matchUuid ?? ((q: Q, u: string) => q.id === u);
      const idx = filtered.findIndex((q) => matcher(q, trimmed));
      if (idx !== -1) {
        setCurrentIndex(idx);
        setUuidSearch('');
        return;
      }
      if (!questions.some((q) => matcher(q, trimmed))) {
        setSaveMsg('Question UUID not found');
        setTimeout(() => setSaveMsg(null), 3000);
        return;
      }
      pendingUuidRef.current = trimmed;
      setFilters(config.getResetFilters());
      setUuidSearch('');
    },
    [filtered, questions, config]
  );

  const current = filtered[currentIndex] ?? null;

  // Sync draft when question changes
  useEffect(() => {
    if (current) {
      setDraft({});
      setOptionsJsonStr(JSON.stringify(current.options ?? [], null, 2));
      setOptionsJsonValid(true);
    }
    setEditMode(false);
    setSaveMsg(null);
  }, [current]);

  const merged = useMemo(() => {
    if (!current) return null;
    return { ...current, ...draft } as Q;
  }, [current, draft]);

  const goNext = useCallback(() => {
    setCurrentIndex((i) => Math.min(i + 1, filtered.length - 1));
  }, [filtered.length]);

  const goPrev = useCallback(() => {
    setCurrentIndex((i) => Math.max(i - 1, 0));
  }, []);

  // Keyboard shortcuts
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

      if (!isInput && e.key.toLowerCase() === 'e' && current && !isProd) {
        e.preventDefault();
        setEditMode(true);
      }
      if (e.key === 'ArrowRight') goNext();
      if (e.key === 'ArrowLeft') goPrev();
    };
    window.addEventListener('keydown', handleKey);
    return () => window.removeEventListener('keydown', handleKey);
  }, [goNext, goPrev, editMode, current, isProd]);

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
        const res = await fetch(`${config.apiBase}/upload-image`, { method: 'POST', body: form });
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
    [currentIndex, filtered, config.apiBase]
  );

  const removeImage = useCallback(async () => {
    const q = filtered[currentIndex];
    if (!q || !q.imageUrl) return;
    if (!confirm('Remove image from this question?')) return;
    setUploading(true);
    try {
      const res = await fetch(`${config.apiBase}/upload-image`, {
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
  }, [currentIndex, filtered, config.apiBase]);

  // Save edits
  const handleSave = useCallback(async () => {
    if (!current || Object.keys(draft).length === 0) return;
    setSaving(true);
    setSaveMsg(null);
    try {
      const res = await fetch(config.apiBase, {
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
  }, [current, draft, config.apiBase]);
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
      const res = await fetch(config.apiBase, {
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
  }, [current, config.apiBase]);

  const [togglingQC, setTogglingQC] = useState(false);
  const handleToggleQC = useCallback(async () => {
    if (!current) return;
    const newVal = !current.qcDone;
    setTogglingQC(true);
    try {
      const res = await fetch(config.apiBase, {
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
  }, [current, config.apiBase]);

  // AI Regeneration
  const handleRegenerate = useCallback(
    async (mode: 'answer' | 'theory') => {
      if (!current) return;
      setRegenLoading(mode);
      try {
        const res = await fetch(`${config.apiBase}/regenerate-ai`, {
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
        setDraft((d) => ({ ...d, [field]: data.text } as Partial<Q>));
      } catch {
        alert('Regeneration failed');
      } finally {
        setRegenLoading(null);
      }
    },
    [current, config.apiBase]
  );

  const updateDraft = (key: string, value: unknown) => {
    setDraft((d) => ({ ...d, [key]: value }));
  };

  const getFilterOptions = (fd: FilterDef): FilterOption[] => {
    if (fd.options === 'dynamic') {
      return dynamicOptions[fd.key] ?? [];
    }
    return fd.options;
  };

  const renderEditField = (field: EditFieldDef<Q>) => {
    const currentVal = (draft as Record<string, unknown>)[field.key] ?? (current as Record<string, unknown>)?.[field.key];

    switch (field.type) {
      case 'select':
        return (
          <div key={field.key}>
            <label className="text-xs font-medium text-gray-600">{field.label}</label>
            <select
              value={(currentVal as string) ?? ''}
              onChange={(e) => updateDraft(field.key, e.target.value)}
              className="w-full border border-gray-300 rounded-md px-2 py-1 text-sm"
            >
              {field.options?.map((o) => (
                <option key={o.value} value={o.value}>
                  {o.label}
                </option>
              ))}
            </select>
          </div>
        );
      case 'number':
        return (
          <div key={field.key}>
            <label className="text-xs font-medium text-gray-600">{field.label}</label>
            <input
              type="number"
              min={0}
              value={(currentVal as number) ?? 0}
              onChange={(e) => updateDraft(field.key, Number(e.target.value))}
              className="w-full border border-gray-300 rounded-md px-2 py-1 text-sm"
            />
          </div>
        );
      case 'text':
        return (
          <div key={field.key} className={field.colSpan === 2 ? 'col-span-2' : field.colSpan === 3 ? 'col-span-3' : ''}>
            <label className="text-xs font-medium text-gray-600">{field.label}</label>
            <input
              type="text"
              value={(currentVal as string) ?? ''}
              onChange={(e) => updateDraft(field.key, e.target.value)}
              className="w-full border border-gray-300 rounded-md px-2 py-1 text-sm font-mono"
              placeholder={field.placeholder}
            />
          </div>
        );
      case 'textarea':
        return (
          <div key={field.key} className={field.colSpan === 2 ? 'col-span-2' : field.colSpan === 3 ? 'col-span-3' : ''}>
            <label className="text-xs font-semibold uppercase text-gray-400 tracking-wider">{field.label}</label>
            <textarea
              value={(currentVal as string) ?? ''}
              onChange={(e) => updateDraft(field.key, e.target.value)}
              rows={field.rows ?? 4}
              className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm mt-1 font-mono"
              placeholder={field.placeholder}
            />
          </div>
        );
      case 'json':
        return (
          <div key={field.key} className={field.colSpan === 2 ? 'col-span-2' : field.colSpan === 3 ? 'col-span-3' : ''}>
            <label className="text-xs font-semibold uppercase text-gray-400 tracking-wider">{field.label}</label>
            <textarea
              value={optionsJsonStr}
              onChange={(e) => {
                const val = e.target.value;
                setOptionsJsonStr(val);
                try {
                  updateDraft(field.key, JSON.parse(val));
                  setOptionsJsonValid(true);
                } catch {
                  setOptionsJsonValid(false);
                }
              }}
              rows={field.rows ?? 6}
              className={`w-full border rounded-md px-3 py-2 text-sm mt-1 font-mono ${optionsJsonValid ? 'border-gray-300' : 'border-red-500 bg-red-50'}`}
            />
            {!optionsJsonValid && <p className="text-xs text-red-500 mt-1">Invalid JSON</p>}
          </div>
        );
      default:
        return null;
    }
  };

  // Separate edit fields into metadata (select/number/text) and content (textarea/json)
  const metadataEditFields = config.editFields.filter((f) => f.type === 'select' || f.type === 'number' || f.type === 'text');
  const contentEditFields = config.editFields.filter((f) => f.type === 'textarea' || f.type === 'json');

  return (
    <AdminOnly>
      <div className="min-h-screen bg-background pb-20">
        <div className="container mx-auto px-4 py-8">
          <div className="mb-6">
            <Breadcrumb
              items={[
                { label: 'Home', href: '/' },
                { label: 'Site Administration', href: '/admin/site-administration' },
                { label: config.breadcrumbLabel, isActive: true },
              ]}
            />
          </div>

          <div className="mb-6 flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground">{config.title}</h1>
              <p className="text-muted-foreground mt-1">
                {config.subtitle}{' '}
                {editMode ? (
                  <span>
                    Edit mode active.{' '}
                    <kbd className="px-1.5 py-0.5 bg-gray-200 rounded text-xs font-mono">⌘/Ctrl+Enter</kbd> to save.
                  </span>
                ) : (
                  <span>
                    <kbd className="px-1.5 py-0.5 bg-gray-200 rounded text-xs font-mono">←→</kbd> navigate ·{' '}
                    <kbd className="px-1.5 py-0.5 bg-gray-200 rounded text-xs font-mono">E</kbd> edit
                  </span>
                )}
              </p>
            </div>
            {current && !isProd && (
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

          {/* Stats banner */}
          {stats && (
            <div className="flex gap-3 mb-4 text-sm flex-wrap">
              <div className="bg-yellow-50 border border-yellow-200 rounded-lg px-4 py-2 flex gap-3 items-center flex-wrap">
                <span className="font-semibold text-yellow-800">Pending QC</span>
                {Object.entries(stats).map(([key, val]) => (
                  <span key={key} className="text-yellow-700">
                    {key.charAt(0).toUpperCase() + key.slice(1)}: <strong>{val}</strong>
                  </span>
                ))}
              </div>
            </div>
          )}

          {/* Filters */}
          <div className="flex flex-wrap items-center gap-4 mb-6 p-4 bg-gray-50 rounded-xl border border-gray-200">
            {config.filters.map((fd) => (
              <FilterSelect
                key={fd.key}
                label={fd.label}
                value={filters[fd.key] ?? 'all'}
                onChange={(v) => {
                  setFilters((f) => ({ ...f, [fd.key]: v }));
                  fd.onChangeSideEffect?.(v, setFilters);
                }}
                options={getFilterOptions(fd)}
              />
            ))}
            <div className="flex items-center gap-2 ml-auto">
              {config.fetchOnApply && (
                <button
                  onClick={() => fetchQuestions(config.buildServerParams?.(filters))}
                  disabled={loading}
                  className="px-3 py-1.5 text-xs font-semibold bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50 flex items-center gap-1"
                >
                  {loading ? <Loader2 className="w-3 h-3 animate-spin" /> : null}
                  Apply Filters
                </button>
              )}
              <div className="flex items-center gap-1">
                <label className="text-xs font-medium text-gray-600 whitespace-nowrap">UUID</label>
                <input
                  type="text"
                  placeholder="Paste question ID…"
                  value={uuidSearch}
                  onChange={(e) => setUuidSearch(e.target.value)}
                  onKeyDown={(e) => {
                    if (e.key === 'Enter') jumpToUUID(uuidSearch);
                  }}
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

          {isProd && (
            <div className="mb-6 bg-amber-50 border border-amber-300 rounded-lg px-4 py-3 text-sm text-amber-800 font-medium">
              Production is read-only. QC editing is only available on Dev.
            </div>
          )}

          {/* Content */}
          {loading && (
            <div className="flex items-center justify-center py-20">
              <Loader2 className="w-8 h-8 animate-spin text-gray-400" />
            </div>
          )}

          {error && <div className="bg-red-50 border border-red-200 rounded-lg p-4 text-red-700">{error}</div>}

          {!loading && !error && filtered.length === 0 && (
            <div className="text-center py-20 text-gray-500">
              {config.fetchOnApply && !hasFetched
                ? 'Set filters above and click "Apply Filters" to load questions.'
                : 'No questions match the current filters.'}
            </div>
          )}

          {!loading && !error && merged && current && (
            <div className="max-w-3xl mx-auto space-y-4">
              {/* Metadata bar (view) / Metadata editor (edit) */}
              {!editMode ? (
                <div className="flex items-center gap-2 flex-wrap">
                  {config.metadataBadges.map((badge) => (
                    <span key={badge.key}>{badge.render(merged)}</span>
                  ))}
                </div>
              ) : (
                <div className="bg-gray-50 border border-gray-200 rounded-xl p-4 space-y-3">
                  <p className="text-xs font-semibold text-gray-500 uppercase tracking-wider">Metadata</p>
                  <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
                    {metadataEditFields.map((field) => renderEditField(field))}
                  </div>
                  <p className="text-xs text-gray-400 font-mono">ID: {current.id}</p>
                </div>
              )}

              {/* Question card */}
              <div className="bg-white border border-gray-200 rounded-xl p-6 space-y-5">
                {editMode ? (
                  <>{contentEditFields.map((field) => renderEditField(field))}</>
                ) : (
                  config.renderQuestion(merged)
                )}
              </div>

              {/* AI Explanation & Theory section */}
              {config.hasAIRegenerate && (
                <div className="bg-white border border-gray-200 rounded-xl p-6 space-y-5">
                  <p className="text-xs font-semibold uppercase text-gray-400 tracking-wider flex items-center gap-1.5">
                    <Sparkles className="w-3.5 h-3.5" /> AI-Generated Content
                  </p>

                  {/* AI Explanation */}
                  <div>
                    <div className="flex items-center justify-between mb-1">
                      <label className="text-xs font-medium text-gray-600">AI Explanation</label>
                      {!isProd && (
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
                      )}
                    </div>
                    {editMode ? (
                      <textarea
                        value={((draft as Record<string, unknown>).aiExplanation as string) ?? current.aiExplanation ?? ''}
                        onChange={(e) => updateDraft('aiExplanation', e.target.value)}
                        rows={5}
                        className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm font-mono"
                        placeholder="No AI explanation cached. Click Regenerate or type manually."
                      />
                    ) : (
                      <div className="bg-green-50 border border-green-200 rounded-lg p-3 text-sm text-green-800 whitespace-pre-wrap">
                        {merged.aiExplanation ? (
                          renderMixedContent(merged.aiExplanation)
                        ) : (
                          <span className="italic text-gray-400">No AI explanation cached.</span>
                        )}
                      </div>
                    )}
                  </div>

                  {/* AI Theory */}
                  <div>
                    <div className="flex items-center justify-between mb-1">
                      <label className="text-xs font-medium text-gray-600">AI Theory</label>
                      {!isProd && (
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
                      )}
                    </div>
                    {editMode ? (
                      <textarea
                        value={((draft as Record<string, unknown>).aiTheory as string) ?? current.aiTheory ?? ''}
                        onChange={(e) => updateDraft('aiTheory', e.target.value)}
                        rows={5}
                        className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm font-mono"
                        placeholder="No AI theory cached. Click Regenerate or type manually."
                      />
                    ) : (
                      <div className="bg-indigo-50 border border-indigo-200 rounded-lg p-3 text-sm text-indigo-800 whitespace-pre-wrap">
                        {merged.aiTheory ? (
                          renderMixedContent(merged.aiTheory)
                        ) : (
                          <span className="italic text-gray-400">No AI theory cached.</span>
                        )}
                      </div>
                    )}
                  </div>
                </div>
              )}

              {/* Image management */}
              {config.hasImageUpload && (
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
                      {!isProd && (
                        <button
                          onClick={removeImage}
                          disabled={uploading}
                          className="absolute top-2 right-2 p-1 bg-red-500 text-white rounded-full hover:bg-red-600 transition-colors"
                          title="Remove image"
                        >
                          <X className="w-4 h-4" />
                        </button>
                      )}
                    </div>
                  ) : (
                    <div className="flex items-center gap-2 text-sm text-gray-400">
                      <ImageIcon className="w-4 h-4" />
                      No image attached
                    </div>
                  )}
                  {!isProd && (
                    <>
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
                    </>
                  )}
                </div>
              )}

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
                  <button
                    onClick={handleDelete}
                    disabled={deleting}
                    className="inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg bg-red-600 text-white hover:bg-red-700 disabled:opacity-50 transition-colors ml-auto"
                  >
                    {deleting ? <Loader2 className="w-4 h-4 animate-spin" /> : <Trash2 className="w-4 h-4" />}
                    Delete
                  </button>
                  {saveMsg && (
                    <span
                      className={`text-sm font-medium ${
                        saveMsg.startsWith('Error') || saveMsg === 'Deleted' ? 'text-red-600' : 'text-green-600'
                      }`}
                    >
                      {saveMsg}
                    </span>
                  )}
                  {Object.keys(draft).length > 0 && (
                    <span className="text-xs text-yellow-700">
                      {Object.keys(draft).length} field{Object.keys(draft).length !== 1 ? 's' : ''} changed
                    </span>
                  )}
                </div>
              )}

              {/* Inline navigation */}
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
              <div className="flex items-center gap-3">
                {!isProd && (
                  <button
                    onClick={handleToggleQC}
                    disabled={togglingQC}
                    className={`inline-flex items-center gap-1.5 px-4 py-2 text-sm font-medium rounded-lg transition-colors disabled:opacity-50 ${
                      current?.qcDone
                        ? 'bg-emerald-100 text-emerald-700 border border-emerald-300 hover:bg-emerald-200'
                        : 'bg-gray-100 text-gray-700 border border-gray-300 hover:bg-gray-200'
                    }`}
                  >
                    {togglingQC ? <Loader2 className="w-4 h-4 animate-spin" /> : <CheckCircle2 className="w-4 h-4" />}
                    {current?.qcDone ? 'QC Done' : 'Mark QC Done'}
                  </button>
                )}
                {isProd && current?.qcDone && (
                  <span className="inline-flex items-center gap-1.5 px-3 py-1.5 text-xs font-medium rounded-lg bg-emerald-100 text-emerald-700 border border-emerald-300">
                    <CheckCircle2 className="w-3.5 h-3.5" /> QC Done
                  </span>
                )}
                <span className="text-sm font-semibold text-gray-700 tabular-nums">
                  {currentIndex + 1} / {filtered.length}
                </span>
              </div>
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
  options: FilterOption[];
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

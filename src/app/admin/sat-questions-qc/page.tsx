'use client';

import { useEffect, useState, useMemo, useCallback, useRef } from 'react';
import { AdminOnly } from '@/design-system/components/form-components/RoleGuard';
import { Breadcrumb } from '@/design-system/components/breadcrumb';
import { Badge } from '@/design-system/components/ui/badge';
import type { SATQuestion, SATSection, SATDomain, DifficultyTier } from '@/types/sat-test';
import QuestionRenderer from '@/components/sat-test/question-types/QuestionRenderer';
import { renderMixedContent } from '@/components/MathRenderer';
import { ChevronLeft, ChevronRight, Loader2, Upload, ImageIcon, X } from 'lucide-react';

interface SATQCQuestion extends SATQuestion {
  moduleNumber: number;
  setNumber: number;
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
    return [...RW_DOMAINS, ...MATH_DOMAINS];
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

  // Reset domain filter when section changes if it's no longer valid
  useEffect(() => {
    if (domainFilter !== 'all' && !availableDomains.includes(domainFilter as SATDomain)) {
      setDomainFilter('all');
    }
  }, [sectionFilter, domainFilter, availableDomains]);

  const goNext = useCallback(() => {
    setCurrentIndex((i) => Math.min(i + 1, filtered.length - 1));
  }, [filtered.length]);

  const goPrev = useCallback(() => {
    setCurrentIndex((i) => Math.max(i - 1, 0));
  }, []);

  useEffect(() => {
    const handleKey = (e: KeyboardEvent) => {
      if (e.key === 'ArrowRight') goNext();
      if (e.key === 'ArrowLeft') goPrev();
    };
    window.addEventListener('keydown', handleKey);
    return () => window.removeEventListener('keydown', handleKey);
  }, [goNext, goPrev]);

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
        const res = await fetch('/api/admin/sat-questions/upload-image', {
          method: 'POST',
          body: form,
        });
        if (!res.ok) {
          const data = await res.json();
          alert(data.error ?? 'Upload failed');
          return;
        }
        const { url } = await res.json();
        setQuestions((prev) =>
          prev.map((qn) => (qn.id === q.id ? { ...qn, imageUrl: url } : qn))
        );
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
        setQuestions((prev) =>
          prev.map((qn) => (qn.id === q.id ? { ...qn, imageUrl: undefined } : qn))
        );
      }
    } finally {
      setUploading(false);
    }
  }, [currentIndex, filtered]);

  const current = filtered[currentIndex] ?? null;

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

          <div className="mb-6">
            <h1 className="text-3xl font-bold text-foreground">SAT Questions QC</h1>
            <p className="text-muted-foreground mt-1">
              Review all SAT questions (Math + R&W, test + practice) as they appear to students. Arrow keys to navigate.
            </p>
          </div>

          {/* Filters */}
          <div className="flex flex-wrap items-center gap-4 mb-6 p-4 bg-gray-50 rounded-xl border border-gray-200">
            <div className="flex items-center gap-2">
              <label className="text-sm font-medium text-gray-700">Section:</label>
              <select
                value={sectionFilter}
                onChange={(e) => setSectionFilter(e.target.value as SectionFilter)}
                className="border border-gray-300 rounded-md px-3 py-1.5 text-sm bg-white"
              >
                <option value="all">All</option>
                <option value="rw">Reading & Writing</option>
                <option value="math">Math</option>
              </select>
            </div>

            <div className="flex items-center gap-2">
              <label className="text-sm font-medium text-gray-700">Pool:</label>
              <select
                value={poolFilter}
                onChange={(e) => setPoolFilter(e.target.value as PoolFilter)}
                className="border border-gray-300 rounded-md px-3 py-1.5 text-sm bg-white"
              >
                <option value="all">All</option>
                <option value="test">Test Only</option>
                <option value="practice">Practice Only</option>
              </select>
            </div>

            <div className="flex items-center gap-2">
              <label className="text-sm font-medium text-gray-700">Domain:</label>
              <select
                value={domainFilter}
                onChange={(e) => setDomainFilter(e.target.value)}
                className="border border-gray-300 rounded-md px-3 py-1.5 text-sm bg-white"
              >
                <option value="all">All</option>
                {availableDomains.map((d) => (
                  <option key={d} value={d}>
                    {DOMAIN_LABELS[d] ?? d}
                  </option>
                ))}
              </select>
            </div>

            <div className="flex items-center gap-2">
              <label className="text-sm font-medium text-gray-700">Difficulty:</label>
              <select
                value={difficultyFilter}
                onChange={(e) => setDifficultyFilter(e.target.value as DifficultyFilter)}
                className="border border-gray-300 rounded-md px-3 py-1.5 text-sm bg-white"
              >
                <option value="all">All</option>
                <option value="easy">Easy</option>
                <option value="medium">Medium</option>
                <option value="hard">Hard</option>
              </select>
            </div>

            <div className="flex items-center gap-2">
              <label className="text-sm font-medium text-gray-700">Module:</label>
              <select
                value={moduleFilter}
                onChange={(e) => setModuleFilter(e.target.value)}
                className="border border-gray-300 rounded-md px-3 py-1.5 text-sm bg-white"
              >
                <option value="all">All</option>
                {availableModules.map((m) => (
                  <option key={m} value={String(m)}>
                    {m === 0 ? 'Practice (0)' : `Module ${m}`}
                  </option>
                ))}
              </select>
            </div>

            <div className="flex items-center gap-2">
              <label className="text-sm font-medium text-gray-700">Set:</label>
              <select
                value={setFilter}
                onChange={(e) => setSetFilter(e.target.value)}
                className="border border-gray-300 rounded-md px-3 py-1.5 text-sm bg-white"
              >
                <option value="all">All</option>
                {availableSets.map((s) => (
                  <option key={s} value={String(s)}>
                    {s === 0 ? 'Practice (0)' : `Set ${s}`}
                  </option>
                ))}
              </select>
            </div>

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
            <div className="bg-red-50 border border-red-200 rounded-lg p-4 text-red-700">
              {error}
            </div>
          )}

          {!loading && !error && filtered.length === 0 && (
            <div className="text-center py-20 text-gray-500">
              No questions match the current filters.
            </div>
          )}

          {!loading && !error && current && (
            <div className="max-w-3xl mx-auto">
              {/* Metadata bar */}
              <div className="flex items-center gap-2 flex-wrap mb-4">
                <Badge className={current.section === 'rw' ? 'bg-blue-100 text-blue-800' : 'bg-purple-100 text-purple-800'}>
                  {current.section === 'rw' ? 'R&W' : 'Math'}
                </Badge>
                <Badge className={DIFFICULTY_COLORS[current.difficulty]}>
                  {current.difficulty.charAt(0).toUpperCase() + current.difficulty.slice(1)}
                </Badge>
                <Badge variant="outline" className="text-xs">
                  {current.type.toUpperCase()}
                </Badge>
                {current.domain && (
                  <Badge variant="secondary" className="text-xs">
                    {DOMAIN_LABELS[current.domain] ?? current.domain}
                  </Badge>
                )}
                <span className="text-sm text-gray-500">
                  {current.moduleNumber === 0
                    ? 'Practice'
                    : `Module ${current.moduleNumber} / Set ${current.setNumber}`}
                </span>
              </div>

              {/* Question card */}
              <div className="bg-white border border-gray-200 rounded-xl p-6 space-y-5">
                {/* Passage (R&W) */}
                {current.passage && (
                  <div className="pb-4 border-b border-gray-200">
                    <p className="text-xs font-semibold uppercase text-gray-400 mb-2 tracking-wider">Passage</p>
                    <div className="prose prose-sm max-w-none text-gray-700 whitespace-pre-line">
                      {renderMixedContent(current.passage)}
                    </div>
                  </div>
                )}

                {/* Prompt */}
                {current.prompt && (
                  <div className="prose prose-sm max-w-none text-gray-800">
                    {renderMixedContent(current.prompt)}
                  </div>
                )}

                {/* Image (rendered same as TestQuestionView) */}
                {current.imageUrl && (
                  <div>
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    <img
                      src={current.imageUrl}
                      alt="Question figure"
                      className="max-w-full rounded-lg border border-gray-200"
                    />
                  </div>
                )}

                {/* Answer options via SAT QuestionRenderer */}
                <QuestionRenderer
                  question={current}
                  answer={current.correctAnswer}
                  onAnswer={() => {}}
                  disabled
                  showCorrect
                />

                {/* Explanation */}
                {current.explanation && (
                  <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 text-sm text-blue-800">
                    <p className="font-medium mb-1">Explanation:</p>
                    <div>{renderMixedContent(current.explanation)}</div>
                  </div>
                )}
              </div>

              {/* Image management */}
              <div className="bg-white border border-gray-200 rounded-xl p-4 mt-4 flex items-center gap-3">
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
                  {uploading ? (
                    <Loader2 className="w-3.5 h-3.5 animate-spin" />
                  ) : (
                    <Upload className="w-3.5 h-3.5" />
                  )}
                  {current.imageUrl ? 'Replace' : 'Upload'} Image
                </button>
              </div>

              {/* Inline navigation */}
              <div className="flex items-center justify-between mt-6">
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

'use client';

import { useEffect, useState } from 'react';
import { useRouter, usePathname, useSearchParams } from 'next/navigation';
import { useSATTestStore } from '@/stores/useSATTestStore';
import { AlertTriangle } from 'lucide-react';

// Phases where a mock has been started but not yet submitted. `results` and
// `landing` are deliberately excluded — there is nothing to lose there.
const ACTIVE_MOCK_PHASES = [
  'module-intro',
  'in-module',
  'between-modules',
  'section-break',
] as const;

/**
 * Always mounted on /sat-test. Two jobs:
 *
 * 1. Practice intent — when the user arrives with `?mode=practice` (from the
 *    Mock Hub / results screen) while a mock is mid-flight, ask before
 *    abandoning it instead of silently resuming the mock. With no mock in
 *    progress, it just drops them into practice config.
 * 2. Unload guard — warn on browser reload / tab close during an active mock.
 *
 * Walking away never submits the attempt and never consumes a token (free or
 * paid). Free tokens stay reusable; paid tokens were already spent at entry.
 */
export default function MockGuard() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const phase = useSATTestStore((s) => s.phase);
  const mode = useSATTestStore((s) => s.mode);
  const hasModule = useSATTestStore((s) => !!s.module1);

  const [showConfirm, setShowConfirm] = useState(false);

  const mockInProgress =
    mode === 'test' &&
    (ACTIVE_MOCK_PHASES as readonly string[]).includes(phase) &&
    hasModule;

  // 2. Warn on browser-level exit (reload / close) during an active mock.
  useEffect(() => {
    if (!mockInProgress) return;
    const handler = (e: BeforeUnloadEvent) => {
      e.preventDefault();
      e.returnValue = '';
    };
    window.addEventListener('beforeunload', handler);
    return () => window.removeEventListener('beforeunload', handler);
  }, [mockInProgress]);

  // 1. Handle ?mode=practice intent. The store rehydrates synchronously from
  // localStorage before this runs, so mockInProgress is accurate on first pass.
  useEffect(() => {
    if (searchParams.get('mode') !== 'practice') return;
    if (mockInProgress) {
      setShowConfirm(true);
    } else {
      useSATTestStore.setState({ phase: 'practice-config', mode: 'practice' });
      router.replace(pathname);
    }
    // mockInProgress intentionally omitted — we want the value as of arrival.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [searchParams]);

  if (!showConfirm) return null;

  const resumeMock = () => {
    setShowConfirm(false);
    router.replace(pathname);
  };

  const discardAndPractice = () => {
    useSATTestStore.getState().discardMock();
    useSATTestStore.setState({ phase: 'practice-config', mode: 'practice' });
    setShowConfirm(false);
    router.replace(pathname);
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
      <div className="w-full max-w-md bg-white rounded-xl shadow-2xl">
        <div className="flex items-center gap-2 border-b px-6 py-4">
          <AlertTriangle className="w-5 h-5 text-amber-500" />
          <h2 className="text-lg font-semibold text-gray-900">Mock in progress</h2>
        </div>

        <div className="p-6 space-y-4">
          <p className="text-sm text-gray-600">
            You have a mock test that hasn&apos;t been submitted yet. Switching to
            Practice will end it without recording a score.
          </p>
          <p className="text-sm text-gray-500">
            Your access code is preserved — you can retake this mock anytime.
          </p>

          <div className="flex flex-col sm:flex-row gap-3 pt-1">
            <button
              onClick={resumeMock}
              className="flex-1 py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] transition-colors"
            >
              Resume Mock
            </button>
            <button
              onClick={discardAndPractice}
              className="flex-1 py-3 border-2 border-gray-200 text-gray-700 font-semibold rounded-lg hover:bg-gray-50 transition-colors"
            >
              Discard &amp; Practice
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

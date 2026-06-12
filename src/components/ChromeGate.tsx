'use client';

import { usePathname } from 'next/navigation';
import { useSATTestStore } from '@/stores/useSATTestStore';

// The exam runner (/sat-test) renders its own full-bleed, distraction-free UI
// during these phases — the global site chrome (header, footer, floating
// widget) must be hidden so only the exam is on screen. Other phases (landing,
// results, practice config/summary) keep the chrome for site navigation.
const EXAM_PHASES = new Set([
  'module-intro',
  'in-module',
  'between-modules',
  'section-break',
  'in-practice',
]);

/** Renders its children everywhere except during an active exam. */
export default function ChromeGate({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const phase = useSATTestStore((s) => s.phase);

  // Only the exam runner page itself — not subpages like /sat-test/history.
  if (pathname === '/sat-test' && EXAM_PHASES.has(phase)) return null;

  return <>{children}</>;
}

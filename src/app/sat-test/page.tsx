'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { useAuth } from '@/contexts/AuthContext';
import { useSATTestStore } from '@/stores/useSATTestStore';
import MockGuard from '@/components/sat-test/MockGuard';
import LandingScreen from '@/components/sat-test/LandingScreen';
import ModuleIntroScreen from '@/components/sat-test/ModuleIntroScreen';
import TestQuestionView from '@/components/sat-test/TestQuestionView';
import BetweenModulesScreen from '@/components/sat-test/BetweenModulesScreen';
import SectionBreakScreen from '@/components/sat-test/SectionBreakScreen';
import ResultsScreen from '@/components/sat-test/ResultsScreen';
import PracticeConfigScreen from '@/components/sat-test/PracticeConfigScreen';
import PracticeView from '@/components/sat-test/PracticeView';
import PracticeSummary from '@/components/sat-test/PracticeSummary';

function PhaseScreen() {
  const phase = useSATTestStore((s) => s.phase);

  switch (phase) {
    case 'landing':
      return <LandingScreen />;
    case 'module-intro':
      return <ModuleIntroScreen />;
    case 'in-module':
      return <TestQuestionView />;
    case 'between-modules':
      return <BetweenModulesScreen />;
    case 'section-break':
      return <SectionBreakScreen />;
    case 'results':
      return <ResultsScreen />;
    case 'practice-config':
      return <PracticeConfigScreen />;
    case 'in-practice':
      return <PracticeView />;
    case 'practice-summary':
      return <PracticeSummary />;
    default:
      return <LandingScreen />;
  }
}

export default function SATTestPage() {
  const { user, loading } = useAuth();
  const router = useRouter();

  // Deep link: /sat-test?mode=practice jumps straight to the practice config
  // screen (used by the "Practice" nav item). Only hijack a fresh landing — never
  // an in-progress mock/practice session. Guests are sent to log in first.
  useEffect(() => {
    if (typeof window === 'undefined') return;
    if (new URLSearchParams(window.location.search).get('mode') !== 'practice') return;
    if (useSATTestStore.getState().phase !== 'landing') return;
    if (!user) {
      if (!loading) router.replace('/auth?redirect=' + encodeURIComponent('/sat-test?mode=practice'));
      return;
    }
    useSATTestStore.setState({ phase: 'practice-config', mode: 'practice' });
  }, [user, loading, router]);

  return (
    <>
      <MockGuard />
      <PhaseScreen />
    </>
  );
}

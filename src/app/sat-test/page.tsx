'use client';

import { useSATTestStore } from '@/stores/useSATTestStore';
import LandingScreen from '@/components/sat-test/LandingScreen';
import ModuleIntroScreen from '@/components/sat-test/ModuleIntroScreen';
import TestQuestionView from '@/components/sat-test/TestQuestionView';
import BetweenModulesScreen from '@/components/sat-test/BetweenModulesScreen';
import SectionBreakScreen from '@/components/sat-test/SectionBreakScreen';
import ResultsScreen from '@/components/sat-test/ResultsScreen';
import PracticeConfigScreen from '@/components/sat-test/PracticeConfigScreen';
import PracticeView from '@/components/sat-test/PracticeView';
import PracticeSummary from '@/components/sat-test/PracticeSummary';

export default function SATTestPage() {
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

'use client';

import { useSATTestStore } from '@/stores/useSATTestStore';
import LandingScreen from '@/components/sat-test/LandingScreen';
import ModuleIntroScreen from '@/components/sat-test/ModuleIntroScreen';
import TestQuestionView from '@/components/sat-test/TestQuestionView';
import BetweenModulesScreen from '@/components/sat-test/BetweenModulesScreen';
import ResultsScreen from '@/components/sat-test/ResultsScreen';

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
    case 'results':
      return <ResultsScreen />;
    case 'practice-config':
    case 'in-practice':
    case 'practice-summary':
      // Practice mode placeholder — will be built when practice content is ready
      return <LandingScreen />;
    default:
      return <LandingScreen />;
  }
}

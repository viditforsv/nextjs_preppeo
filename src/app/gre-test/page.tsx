'use client';

import { useGRETestStore } from '@/stores/useGRETestStore';
import LandingScreen from '@/components/gre-test/LandingScreen';
import SectionIntroScreen from '@/components/gre-test/SectionIntroScreen';
import BetweenSectionsScreen from '@/components/gre-test/BetweenSectionsScreen';
import TestQuestionView from '@/components/gre-test/TestQuestionView';
import ResultsScreen from '@/components/gre-test/ResultsScreen';
import PracticeConfigScreen from '@/components/gre-test/PracticeConfigScreen';
import PracticeView from '@/components/gre-test/PracticeView';
import PracticeSummary from '@/components/gre-test/PracticeSummary';

export default function GRETestPage() {
  const phase = useGRETestStore((s) => s.phase);

  switch (phase) {
    case 'landing':
      return <LandingScreen />;
    case 'section-intro':
      return <SectionIntroScreen />;
    case 'in-section':
      return <TestQuestionView />;
    case 'between-sections':
      return <BetweenSectionsScreen />;
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

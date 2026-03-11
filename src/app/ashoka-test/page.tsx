'use client';

import { useAshokaTestStore } from '@/stores/useAshokaTestStore';
import LandingScreen from '@/components/ashoka-test/LandingScreen';
import SectionIntroScreen from '@/components/ashoka-test/SectionIntroScreen';
import TestQuestionView from '@/components/ashoka-test/TestQuestionView';
import EssayIntroScreen from '@/components/ashoka-test/EssayIntroScreen';
import EssayView from '@/components/ashoka-test/EssayView';
import ResultsScreen from '@/components/ashoka-test/ResultsScreen';

export default function AshokaTestPage() {
  const phase = useAshokaTestStore((s) => s.phase);

  switch (phase) {
    case 'landing':
      return <LandingScreen />;
    case 'section-intro':
      return <SectionIntroScreen />;
    case 'in-test':
      return <TestQuestionView />;
    case 'essay-intro':
      return <EssayIntroScreen />;
    case 'in-essay':
      return <EssayView />;
    case 'results':
      return <ResultsScreen />;
    default:
      return <LandingScreen />;
  }
}

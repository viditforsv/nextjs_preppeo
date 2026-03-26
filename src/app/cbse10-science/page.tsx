'use client';

import { useCBSE10ScienceStore } from '@/stores/useCBSE10ScienceStore';
import LandingScreen from '@/components/cbse10-science/LandingScreen';
import StudyModeSelect from '@/components/cbse10-science/StudyModeSelect';
import PracticeConfigScreen from '@/components/cbse10-science/PracticeConfigScreen';
import PracticeView from '@/components/cbse10-science/PracticeView';
import PracticeSummary from '@/components/cbse10-science/PracticeSummary';
import AnalyticsDashboard from '@/components/cbse10-science/AnalyticsDashboard';
import TestModeConfig from '@/components/cbse10-science/TestModeConfig';
import TestView from '@/components/cbse10-science/TestView';
import TestResults from '@/components/cbse10-science/TestResults';
import FlashcardConfig from '@/components/cbse10-science/FlashcardConfig';
import FlashcardView from '@/components/cbse10-science/FlashcardView';

export default function CBSE10SciencePage() {
  const phase = useCBSE10ScienceStore((s) => s.phase);

  switch (phase) {
    case 'landing':
      return <LandingScreen />;
    case 'study-mode-select':
      return <StudyModeSelect />;
    case 'practice-config':
      return <PracticeConfigScreen />;
    case 'in-practice':
      return <PracticeView />;
    case 'practice-summary':
      return <PracticeSummary />;
    case 'analytics':
      return <AnalyticsDashboard />;
    case 'test-config':
      return <TestModeConfig />;
    case 'in-test':
      return <TestView />;
    case 'test-results':
      return <TestResults />;
    case 'flashcard-config':
      return <FlashcardConfig />;
    case 'in-flashcards':
      return <FlashcardView />;
    default:
      return <LandingScreen />;
  }
}

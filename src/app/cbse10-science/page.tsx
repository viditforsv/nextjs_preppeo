'use client';

import { useCBSE10ScienceStore } from '@/stores/useCBSE10ScienceStore';
import LandingScreen from '@/components/cbse10-science/LandingScreen';
import PracticeConfigScreen from '@/components/cbse10-science/PracticeConfigScreen';
import PracticeView from '@/components/cbse10-science/PracticeView';
import PracticeSummary from '@/components/cbse10-science/PracticeSummary';
import AnalyticsDashboard from '@/components/cbse10-science/AnalyticsDashboard';

export default function CBSE10SciencePage() {
  const phase = useCBSE10ScienceStore((s) => s.phase);

  switch (phase) {
    case 'landing':
      return <LandingScreen />;
    case 'practice-config':
      return <PracticeConfigScreen />;
    case 'in-practice':
      return <PracticeView />;
    case 'practice-summary':
      return <PracticeSummary />;
    case 'analytics':
      return <AnalyticsDashboard />;
    default:
      return <LandingScreen />;
  }
}

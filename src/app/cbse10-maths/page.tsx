'use client';

import { useCBSE10MathsStore } from '@/stores/useCBSE10MathsStore';
import LandingScreen from '@/components/cbse10-maths/LandingScreen';
import PracticeConfigScreen from '@/components/cbse10-maths/PracticeConfigScreen';
import PracticeView from '@/components/cbse10-maths/PracticeView';
import PracticeSummary from '@/components/cbse10-maths/PracticeSummary';
import AnalyticsDashboard from '@/components/cbse10-maths/AnalyticsDashboard';

export default function CBSE10MathsPage() {
  const phase = useCBSE10MathsStore((s) => s.phase);

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

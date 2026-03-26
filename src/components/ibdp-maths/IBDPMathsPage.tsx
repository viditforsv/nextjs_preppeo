'use client';

import type { IBDPMathsCourseConfig } from '@/types/ibdp-maths';
import type { IBDPMathsState } from '@/stores/useIBDPMathsStore';
import LandingScreen from './LandingScreen';
import PracticeConfigScreen from './PracticeConfigScreen';
import PracticeView from './PracticeView';
import PracticeSummary from './PracticeSummary';
import AnalyticsDashboard from './AnalyticsDashboard';

interface Props {
  config: IBDPMathsCourseConfig;
  useStore: () => IBDPMathsState;
}

export default function IBDPMathsPage({ config, useStore }: Props) {
  const { phase } = useStore();

  switch (phase) {
    case 'landing':
      return <LandingScreen config={config} useStore={useStore} />;
    case 'practice-config':
      return <PracticeConfigScreen config={config} useStore={useStore} />;
    case 'in-practice':
      return <PracticeView config={config} useStore={useStore} />;
    case 'practice-summary':
      return <PracticeSummary config={config} useStore={useStore} />;
    case 'analytics':
      return <AnalyticsDashboard config={config} useStore={useStore} />;
    default:
      return <LandingScreen config={config} useStore={useStore} />;
  }
}

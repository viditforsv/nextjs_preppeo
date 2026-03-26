'use client';

import IBDPMathsPage from '@/components/ibdp-maths/IBDPMathsPage';
import { useIBDPAIHLStore } from '@/stores/useIBDPAIHLStore';
import { IBDP_AI_HL } from '@/lib/ibdp-maths-courses';

export default function IBDPAIHLPage() {
  return <IBDPMathsPage config={IBDP_AI_HL} useStore={useIBDPAIHLStore} />;
}

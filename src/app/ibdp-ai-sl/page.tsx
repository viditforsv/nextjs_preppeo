'use client';

import IBDPMathsPage from '@/components/ibdp-maths/IBDPMathsPage';
import { useIBDPAISLStore } from '@/stores/useIBDPAISLStore';
import { IBDP_AI_SL } from '@/lib/ibdp-maths-courses';

export default function IBDPAISLPage() {
  return <IBDPMathsPage config={IBDP_AI_SL} useStore={useIBDPAISLStore} />;
}

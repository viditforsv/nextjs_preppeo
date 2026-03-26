'use client';

import IBDPMathsPage from '@/components/ibdp-maths/IBDPMathsPage';
import { useIBDPAASLStore } from '@/stores/useIBDPAASLStore';
import { IBDP_AA_SL } from '@/lib/ibdp-maths-courses';

export default function IBDPAASLPage() {
  return <IBDPMathsPage config={IBDP_AA_SL} useStore={useIBDPAASLStore} />;
}

'use client';

import IBDPMathsPage from '@/components/ibdp-maths/IBDPMathsPage';
import { useIBDPAAHLStore } from '@/stores/useIBDPAAHLStore';
import { IBDP_AA_HL } from '@/lib/ibdp-maths-courses';

export default function IBDPAAHLPage() {
  return <IBDPMathsPage config={IBDP_AA_HL} useStore={useIBDPAAHLStore} />;
}

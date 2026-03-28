import type { Metadata } from 'next';
import { ComingSoon } from "@/components/ComingSoon";

export const metadata: Metadata = { robots: { index: false, follow: false } };

export default function AdmissionsPage() {
  return (
    <ComingSoon
      title="Admissions Consulting"
      description="Our admissions consulting service is coming soon. Stay tuned!"
    />
  );
}

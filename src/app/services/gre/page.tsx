import type { Metadata } from 'next';
import { ComingSoon } from "@/components/ComingSoon";

export const metadata: Metadata = { robots: { index: false, follow: false } };

export default function GREPage() {
  return (
    <ComingSoon
      title="GRE Preparation"
      description="Our GRE preparation program is coming soon. Stay tuned!"
    />
  );
}

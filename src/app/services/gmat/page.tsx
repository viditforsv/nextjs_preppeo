import type { Metadata } from 'next';
import { ComingSoon } from "@/components/ComingSoon";

export const metadata: Metadata = { robots: { index: false, follow: false } };

export default function GMATPage() {
  return (
    <ComingSoon
      title="GMAT Preparation"
      description="Our GMAT preparation program is coming soon. Stay tuned!"
    />
  );
}

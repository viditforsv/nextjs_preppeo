import type { Metadata } from 'next';
import { ComingSoon } from "@/components/ComingSoon";

export const metadata: Metadata = {
  title: 'SAT Prep Services | Preppeo',
  description:
    "Preppeo's Digital SAT prep program: full-length mock tests, expert question bank, adaptive scoring, and domain-level performance analytics.",
};

export default function SATPage() {
  return (
    <ComingSoon
      title="SAT Preparation"
      description="Our comprehensive SAT preparation program is coming soon. Stay tuned!"
    />
  );
}

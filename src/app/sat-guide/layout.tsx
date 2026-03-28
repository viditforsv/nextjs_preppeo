import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Digital SAT Guide: Structure, Domains & Scoring | Preppeo',
  description:
    'Complete guide to the Digital SAT. Learn the adaptive test structure, R&W and Math domain breakdowns, 400–1600 scoring, and proven test-day strategies.',
  openGraph: {
    title: 'Digital SAT Guide: Structure, Domains & Scoring | Preppeo',
    description:
      'Complete guide to the Digital SAT. Learn the adaptive test structure, R&W and Math domain breakdowns, 400–1600 scoring, and proven test-day strategies.',
  },
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}

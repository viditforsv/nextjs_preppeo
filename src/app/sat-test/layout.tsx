import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Digital SAT Mock Test | Preppeo',
  description:
    'Full-length adaptive Digital SAT mock tests on Preppeo. Real question difficulty, module-adaptive routing, built-in Desmos calculator, and detailed domain-level score reports.',
  openGraph: {
    title: 'Digital SAT Mock Test | Preppeo',
    description:
      'Full-length adaptive Digital SAT mock tests on Preppeo. Real question difficulty, module-adaptive routing, built-in Desmos calculator, and detailed domain-level score reports.',
  },
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}

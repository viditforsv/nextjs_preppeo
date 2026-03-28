import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'FAQ | Preppeo SAT Prep Platform',
  description:
    'Frequently asked questions about Preppeo — Digital SAT mock tests, adaptive scoring, tokens, pricing, and platform features.',
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}

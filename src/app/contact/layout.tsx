import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Contact Preppeo | SAT Prep Support',
  description:
    'Get in touch with the Preppeo team for questions about our Digital SAT mock tests, tokens, scoring, or institutional partnerships.',
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}

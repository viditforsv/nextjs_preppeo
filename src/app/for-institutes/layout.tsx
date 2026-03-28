import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'SAT Prep for Schools & Institutes | Preppeo',
  description:
    'Partner with Preppeo to give your students full-length Digital SAT mock tests, domain analytics, and adaptive scoring. Built for schools, tutoring centers, and prep institutes.',
  openGraph: {
    title: 'SAT Prep for Schools & Institutes | Preppeo',
    description:
      'Partner with Preppeo to give your students full-length Digital SAT mock tests, domain analytics, and adaptive scoring. Built for schools, tutoring centers, and prep institutes.',
  },
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}

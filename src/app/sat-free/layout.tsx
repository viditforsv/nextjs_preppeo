import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Free Full-Length Digital SAT Practice Test | Preppeo',
  description:
    'Take a free full-length Digital SAT mock test. Fully adaptive modules, real MCQ and grid-in question types, Desmos calculator, and instant score report.',
  openGraph: {
    title: 'Free Full-Length Digital SAT Practice Test | Preppeo',
    description:
      'Take a free full-length Digital SAT mock test. Fully adaptive modules, real MCQ and grid-in question types, Desmos calculator, and instant score report.',
  },
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}

import type { Metadata } from 'next';

const title = 'SAT Math Question of the Day | Preppeo';
const description =
  'One genuinely brutal SAT Math question every day. Solve it free, no account needed, then unlock a step-by-step AI concept breakdown of why the trap answers fail.';

export const metadata: Metadata = {
  title,
  description,
  alternates: { canonical: '/question-of-the-day' },
  openGraph: {
    title,
    description,
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title,
    description,
  },
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}

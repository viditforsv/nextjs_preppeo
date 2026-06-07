import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Careers | Preppeo SAT Prep Platform',
  description:
    'Join the Preppeo team — help students master the Digital SAT. View open roles and apply.',
};

export default function Layout({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}

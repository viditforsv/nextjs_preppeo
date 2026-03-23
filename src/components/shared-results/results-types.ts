import type { ReactNode } from 'react';
import type { LucideIcon } from 'lucide-react';

export interface AnalyticsTabDef {
  id: string;
  label: string;
  icon: LucideIcon;
  render: () => ReactNode;
}

export interface ResultsHeaderAction {
  label: string;
  icon: LucideIcon;
  href?: string;
  onClick?: () => void;
}

export interface ResultsCTA {
  icon: LucideIcon;
  title: string;
  description: string;
  buttonLabel: string;
  href: string;
  gradient: string;
}

export interface ResultsConfig {
  title: string;
  subtitle?: string;
  headerColor: string;
  accentColor: string;
  headerActions: ResultsHeaderAction[];
  tabs: AnalyticsTabDef[];
  ctas?: ResultsCTA[];
  referralPath?: string;
}

export interface RecommendationInput {
  topic: string;
  correct: number;
  total: number;
}

export interface NormalizedResponse {
  isCorrect: boolean;
  isOmitted: boolean;
  timeSpentMs: number;
  difficulty: string;
  topic: string;
}

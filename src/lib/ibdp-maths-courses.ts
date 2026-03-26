import type { IBDPMathsCourseConfig, IBDPMathsDomain } from '@/types/ibdp-maths';

export const IBDP_DOMAIN_LABELS: Record<IBDPMathsDomain, string> = {
  'number-algebra': 'Number & Algebra',
  'functions': 'Functions',
  'geometry-trigonometry': 'Geometry & Trigonometry',
  'statistics-probability': 'Statistics & Probability',
  'calculus': 'Calculus',
};

export const IBDP_DOMAINS: { id: IBDPMathsDomain; label: string }[] = [
  { id: 'number-algebra', label: 'Number & Algebra' },
  { id: 'functions', label: 'Functions' },
  { id: 'geometry-trigonometry', label: 'Geometry & Trigonometry' },
  { id: 'statistics-probability', label: 'Statistics & Probability' },
  { id: 'calculus', label: 'Calculus' },
];

export const IBDP_AA_HL: IBDPMathsCourseConfig = {
  slug: 'ibdp-aa-hl',
  title: 'IB Maths: AA HL',
  subtitle: 'Analysis & Approaches — Higher Level',
  accentColor: '#1e3a8a',
  accentLight: '#dbeafe',
  accentText: '#1e40af',
  table: 'ibdp_aa_hl_questions',
  apiPrefix: 'ibdp-aa-hl',
  coursePath: '/ibdp-aa-hl',
};

export const IBDP_AA_SL: IBDPMathsCourseConfig = {
  slug: 'ibdp-aa-sl',
  title: 'IB Maths: AA SL',
  subtitle: 'Analysis & Approaches — Standard Level',
  accentColor: '#312e81',
  accentLight: '#e0e7ff',
  accentText: '#3730a3',
  table: 'ibdp_aa_sl_questions',
  apiPrefix: 'ibdp-aa-sl',
  coursePath: '/ibdp-aa-sl',
};

export const IBDP_AI_HL: IBDPMathsCourseConfig = {
  slug: 'ibdp-ai-hl',
  title: 'IB Maths: AI HL',
  subtitle: 'Applications & Interpretation — Higher Level',
  accentColor: '#134e4a',
  accentLight: '#ccfbf1',
  accentText: '#0f766e',
  table: 'ibdp_ai_hl_questions',
  apiPrefix: 'ibdp-ai-hl',
  coursePath: '/ibdp-ai-hl',
};

export const IBDP_AI_SL: IBDPMathsCourseConfig = {
  slug: 'ibdp-ai-sl',
  title: 'IB Maths: AI SL',
  subtitle: 'Applications & Interpretation — Standard Level',
  accentColor: '#164e63',
  accentLight: '#cffafe',
  accentText: '#0e7490',
  table: 'ibdp_ai_sl_questions',
  apiPrefix: 'ibdp-ai-sl',
  coursePath: '/ibdp-ai-sl',
};

export const ALL_IBDP_COURSES: IBDPMathsCourseConfig[] = [
  IBDP_AA_HL,
  IBDP_AA_SL,
  IBDP_AI_HL,
  IBDP_AI_SL,
];

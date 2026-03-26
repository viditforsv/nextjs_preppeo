export type IBDPMathsDomain =
  | 'number-algebra'
  | 'functions'
  | 'geometry-trigonometry'
  | 'statistics-probability'
  | 'calculus';

export type DifficultyTier = 'easy' | 'medium' | 'hard';

export type QuestionType = 'mcq' | 'spr';

export interface QuestionOption {
  id: string;
  text: string;
}

export interface IBDPMathsQuestion {
  id: string;
  type: QuestionType;
  difficulty: DifficultyTier;
  domain?: IBDPMathsDomain;
  chapter?: string;
  subtopic?: string;
  prompt: string;
  options?: QuestionOption[];
  correctAnswer: string;
  explanation: string;
  imageUrl?: string;
}

export interface IBDPMathsPracticeConfig {
  domains: IBDPMathsDomain[];
  chapters: string[];
  subtopics: string[];
  difficulty: DifficultyTier | 'mixed';
  questionCount: number;
}

export type IBDPPracticePhase =
  | 'landing'
  | 'practice-config'
  | 'in-practice'
  | 'practice-summary'
  | 'analytics';

export interface IBDPMathsCourseConfig {
  slug: string;
  title: string;
  subtitle: string;
  /** Dark color used for icon/header backgrounds */
  accentColor: string;
  /** Light tint used for selected button backgrounds */
  accentLight: string;
  /** Text color on accentLight */
  accentText: string;
  table: string;
  /** URL segment, e.g. 'ibdp-aa-hl' */
  apiPrefix: string;
  /** Full page path, e.g. '/ibdp-aa-hl' */
  coursePath: string;
}

export interface ChapterAnalytics {
  domain: string;
  label: string;
  attempted: number;
  correct: number;
  accuracy: number;
}

export interface AnalyticsData {
  chapters: ChapterAnalytics[];
  weakest: string[];
  strongest: string[];
  totalAttempted: number;
  totalCorrect: number;
}

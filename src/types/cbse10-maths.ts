export type CBSE10MathsDomain =
  | 'real-numbers'
  | 'polynomials'
  | 'linear-equations'
  | 'quadratic-equations'
  | 'arithmetic-progressions'
  | 'triangles'
  | 'coordinate-geometry'
  | 'trigonometry'
  | 'applications-of-trig'
  | 'circles'
  | 'areas-related-to-circles'
  | 'surface-areas-volumes'
  | 'statistics'
  | 'probability';

export type DifficultyTier = 'easy' | 'medium' | 'hard';

export type QuestionType = 'mcq' | 'spr';

export interface QuestionOption {
  id: string;
  text: string;
}

export interface CBSE10MathsQuestion {
  id: string;
  type: QuestionType;
  difficulty: DifficultyTier;
  domain?: CBSE10MathsDomain;
  chapter?: string;
  subtopic?: string;
  prompt: string;
  options?: QuestionOption[];
  correctAnswer: string;
  explanation: string;
  imageUrl?: string;
}

export interface CBSE10MathsPracticeConfig {
  domains: CBSE10MathsDomain[];
  chapters: string[];
  subtopics: string[];
  difficulty: DifficultyTier | 'mixed';
  questionCount: number;
}

export type CBSE10PracticePhase =
  | 'landing'
  | 'practice-config'
  | 'in-practice'
  | 'practice-summary'
  | 'analytics';

export interface PracticeAnswer {
  questionId: string;
  bankItemId?: string;
  answerGiven: string;
  isCorrect: boolean;
  domain?: string;
  chapter?: string;
  subtopic?: string;
  difficultyTier?: string;
  timeSpentMs?: number;
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

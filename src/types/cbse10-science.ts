export type CBSE10ScienceDomain =
  | 'chemical-reactions'
  | 'acids-bases-salts'
  | 'metals-non-metals'
  | 'carbon-compounds'
  | 'life-processes'
  | 'control-coordination'
  | 'reproduction'
  | 'heredity-evolution'
  | 'light'
  | 'human-eye'
  | 'electricity'
  | 'magnetic-effects'
  | 'our-environment';

export type DifficultyTier = 'easy' | 'medium' | 'hard';

export type QuestionType = 'mcq' | 'spr';

export interface QuestionOption {
  id: string;
  text: string;
}

export interface CBSE10ScienceQuestion {
  id: string;
  type: QuestionType;
  difficulty: DifficultyTier;
  domain?: CBSE10ScienceDomain;
  chapter?: string;
  subtopic?: string;
  prompt: string;
  options?: QuestionOption[];
  correctAnswer: string;
  explanation: string;
  imageUrl?: string;
}

export interface CBSE10SciencePracticeConfig {
  domains: CBSE10ScienceDomain[];
  chapters: string[];
  subtopics: string[];
  difficulty: DifficultyTier | 'mixed';
  questionCount: number;
}

export type CBSE10SciencePracticePhase =
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

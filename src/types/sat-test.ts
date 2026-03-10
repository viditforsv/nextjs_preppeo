export type SATQuestionType = 'mcq' | 'spr';

export type SATDomain =
  | 'algebra'
  | 'advanced-math'
  | 'problem-solving'
  | 'geometry-trig';

export type DifficultyTier = 'easy' | 'medium' | 'hard';

export interface SATQuestionOption {
  id: string;
  text: string;
}

export interface SATQuestion {
  id: string;
  type: SATQuestionType;
  difficulty: DifficultyTier;
  domain?: SATDomain;
  prompt: string;
  options?: SATQuestionOption[];
  correctAnswer: string;
  explanation: string;
  imageUrl?: string;
}

export interface SATModule {
  moduleNumber: 1 | 2;
  difficultyTier: DifficultyTier | 'mixed';
  durationSeconds: number;
  questions: SATQuestion[];
}

export interface SATModuleResult {
  moduleNumber: 1 | 2;
  difficultyTier: DifficultyTier | 'mixed';
  correct: number;
  total: number;
  answers: Record<string, string | null>;
  timeUsed: number;
}

export type SATTestPhase =
  | 'landing'
  | 'module-intro'
  | 'in-module'
  | 'between-modules'
  | 'results';

export type SATPracticePhase =
  | 'landing'
  | 'practice-config'
  | 'in-practice'
  | 'practice-summary';

export type SATAppPhase = SATTestPhase | SATPracticePhase;

export interface SATPracticeConfig {
  difficulty: DifficultyTier | 'mixed';
  questionCount: number;
}

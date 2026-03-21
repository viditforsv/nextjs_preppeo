export type SATQuestionType = 'mcq' | 'spr';

export type SATSection = 'rw' | 'math';

export type SATMathDomain =
  | 'algebra'
  | 'advanced-math'
  | 'problem-solving'
  | 'geometry-trig';

export type SATRWDomain =
  | 'craft-structure'
  | 'information-ideas'
  | 'standard-english'
  | 'expression-of-ideas';

export type SATDomain = SATMathDomain | SATRWDomain;

export type DifficultyTier = 'easy' | 'medium' | 'hard';

export interface SATQuestionOption {
  id: string;
  text: string;
}

export interface SATQuestion {
  id: string;
  type: SATQuestionType;
  section?: SATSection;
  difficulty: DifficultyTier;
  domain?: SATDomain;
  chapter?: string;
  subtopic?: string;
  prompt: string;
  passage?: string;
  options?: SATQuestionOption[];
  correctAnswer: string;
  explanation: string;
  imageUrl?: string;
}

export interface SATModule {
  moduleNumber: 1 | 2;
  section: SATSection;
  difficultyTier: DifficultyTier | 'mixed';
  durationSeconds: number;
  questions: SATQuestion[];
}

export interface SATModuleResult {
  moduleNumber: 1 | 2;
  section: SATSection;
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
  | 'section-break'
  | 'results';

export type SATPracticePhase =
  | 'landing'
  | 'practice-config'
  | 'in-practice'
  | 'practice-summary';

export type SATAppPhase = SATTestPhase | SATPracticePhase;

export interface SATPracticeConfig {
  section: SATSection;
  domains: SATDomain[];
  chapters: string[];
  subtopics: string[];
  difficulty: DifficultyTier | 'mixed';
  questionCount: number;
}

export interface SATQuestionResponse {
  questionId: string;
  section: SATSection;
  answer: string | null;
  isCorrect: boolean;
  isOmitted: boolean;
  isFlagged: boolean;
  timeSpentMs: number;
  visitCount: number;
  domain: SATDomain | null;
  difficulty: DifficultyTier;
  questionType: SATQuestionType;
}

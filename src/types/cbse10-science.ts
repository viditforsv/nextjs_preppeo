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
  correctAnswerB?: string;
  explanation: string;
  imageUrl?: string;
  isPyq?: boolean;
  pyqYear?: string;
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
  | 'study-mode-select'
  | 'practice-config'
  | 'in-practice'
  | 'practice-summary'
  | 'analytics'
  | 'test-config'
  | 'in-test'
  | 'test-results'
  | 'flashcard-config'
  | 'in-flashcards';

export interface CBSE10ScienceTestConfig {
  domains: CBSE10ScienceDomain[];
  chapters: string[];
  subtopics: string[];
  difficulty: DifficultyTier | 'mixed';
  questionCount: number;
  timeLimitMinutes: number;
}

export interface CBSE10ScienceFlashcardConfig {
  domains: CBSE10ScienceDomain[];
  chapters: string[];
  cardCount: number;
}

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

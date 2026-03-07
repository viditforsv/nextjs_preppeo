// ── Legacy types (kept for backward compat with gre-study & chatbot) ────────

export type QuestionType = 'single-choice' | 'multi-select' | 'numeric-entry' | 'text-select';

export interface Question {
  id: string;
  type: QuestionType;
  prompt: string;
  passageId?: string;
  options?: { id: string; text: string }[];
  correctAnswer: string | string[];
  explanation?: string;
  topics?: string[];
  hints?: string[];
}

export interface Passage {
  id: string;
  content: string;
}

export interface SectionRouting {
  nextSectionId: string;
  condition: {
    minScore?: number;
    maxScore?: number;
    default?: boolean;
  };
}

export interface TestSection {
  id: string;
  title: string;
  sectionType: 'verbal' | 'quantitative';
  durationSeconds: number;
  questions: Question[];
  passages: Passage[];
  routingRules: SectionRouting[];
}

export interface GRETest {
  id: string;
  title: string;
  sections: TestSection[];
  startingSectionId: string;
}

// ── New GRE Maths Types ────────────────────────────────────────────────────

export type GREQuestionType =
  | 'single-choice'
  | 'multi-select'
  | 'numeric-entry'
  | 'quantitative-comparison';

export type DifficultyTier = 'easy' | 'medium' | 'hard';

export interface GREQuestionOption {
  id: string;
  text: string;
}

export interface GREQuestion {
  id: string;
  type: GREQuestionType;
  difficulty: DifficultyTier;
  prompt: string;
  options?: GREQuestionOption[];
  /** For quantitative-comparison, the two quantities to compare */
  quantityA?: string;
  quantityB?: string;
  /** Extra info shown above the quantities in QC problems */
  quantityInfo?: string;
  /**
   * Correct answer:
   * - single-choice / quant-comp: option id string
   * - multi-select: array of option ids
   * - numeric-entry: numeric string (e.g. "42" or "3/4")
   */
  correctAnswer: string | string[];
  explanation: string;
  topics?: string[];
}

// ── Section / Test Structure ────────────────────────────────────────────────

export interface GRESection {
  sectionNumber: 1 | 2;
  difficultyTier: DifficultyTier;
  durationSeconds: number;
  questions: GREQuestion[];
}

export interface GRETestConfig {
  section1QuestionCount: 12;
  section2QuestionCount: 15;
  section1Duration: 1260; // 21 min
  section2Duration: 1560; // 26 min
}

// ── Session Tracking ────────────────────────────────────────────────────────

export type TestPhase =
  | 'landing'
  | 'section-intro'
  | 'in-section'
  | 'between-sections'
  | 'results';

export type PracticePhase =
  | 'landing'
  | 'practice-config'
  | 'in-practice'
  | 'practice-summary';

export type AppPhase = TestPhase | PracticePhase;

export interface SectionResult {
  sectionNumber: 1 | 2;
  difficultyTier: DifficultyTier;
  correct: number;
  total: number;
  answers: Record<string, string | string[] | null>;
  timeUsed: number;
}

export interface GRETestSession {
  mode: 'test';
  section1: GRESection;
  section2: GRESection | null;
  section1Result: SectionResult | null;
  section2Result: SectionResult | null;
  section2Tier: DifficultyTier | null;
}

export interface PracticeConfig {
  difficulty: DifficultyTier | 'mixed';
  questionCount: number;
}

export interface PracticeSession {
  mode: 'practice';
  config: PracticeConfig;
  questions: GREQuestion[];
  answers: Record<string, string | string[] | null>;
  revealed: Record<string, boolean>;
}

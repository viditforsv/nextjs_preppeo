export interface AshokaQuestionOption {
  id: string;
  text: string;
}

export interface AshokaQuestion {
  id: string;
  type: 'single-choice';
  sectionType: 'problem-solving' | 'critical-thinking';
  prompt: string;
  options: AshokaQuestionOption[];
  correctAnswer: string;
  explanation: string;
}

export type AshokaPhase =
  | 'landing'
  | 'section-intro'
  | 'in-test'
  | 'essay-intro'
  | 'in-essay'
  | 'results';

export interface AshokaTestResult {
  correct: number;
  total: number;
  psSectionCorrect: number;
  psSectionTotal: number;
  ctSectionCorrect: number;
  ctSectionTotal: number;
  answers: Record<string, string | null>;
  timeUsed: number;
  essayPrompt: string;
  essayText: string;
  essayTimeUsed: number;
}

// Types for the standalone SAT Self-Learn course (/sat/learn).
// Mirrors the sat_learn_* tables; field names are camelCased.

export type SatLearnSubject = "math" | "english";
export type SatLearnItemType = "video" | "reading" | "flashcard" | "quiz" | "pdf";

export interface SatLearnCourse {
  id: string;
  title: string;
  slug: string;
  subject: SatLearnSubject;
  tagline: string | null;
  description: string | null;
  priceInr: number | null;
  priceUsd: number | null;
  sortOrder: number;
  isPublished: boolean;
}

export interface SatLearnTopic {
  id: string;
  courseId: string;
  title: string;
  slug: string;
  domain: string | null;
  description: string | null;
  icon: string | null;
  sortOrder: number;
  isPublished: boolean;
}

/** Filter into the sat_questions practice pool (set_number=0, module_number=0). */
export interface SatLearnQuizConfig {
  section: "math" | "rw";
  domains: string[];
  subtopics: string[];
  difficulty: "easy" | "medium" | "hard" | "mixed";
  count: number;
}

/** Item metadata — always safe to expose (no gated content fields). */
export interface SatLearnItemMeta {
  id: string;
  topicId: string;
  title: string;
  slug: string;
  type: SatLearnItemType;
  sortOrder: number;
  isFreePreview: boolean;
  durationSeconds: number | null;
  /** Per-user completion (only set when a user context is available). */
  completed: boolean;
}

/** Full item — gated fields are null + `locked=true` when the user isn't entitled. */
export interface SatLearnItemFull extends SatLearnItemMeta {
  videoUrl: string | null;
  videoProvider: string | null;
  body: string | null;
  pdfUrl: string | null;
  quizConfig: SatLearnQuizConfig | null;
  /** True when content is withheld because the user lacks access. */
  locked: boolean;
}

export interface SatLearnQuizOption {
  id: string;
  text: string;
}

/** A basic concept-check question shown inside a quiz lesson (not exam-style). */
export interface SatLearnQuizQuestion {
  id: string;
  question: string;
  options: SatLearnQuizOption[];
  correctAnswer: string;
  explanation: string | null;
}

export interface SatLearnFlashcard {
  id: string;
  front: string;
  back: string;
  section: SatLearnSubject;
}

/** A topic plus its item list — used to render the curriculum tree. */
export interface SatLearnTopicWithItems extends SatLearnTopic {
  items: SatLearnItemMeta[];
}

/** A course plus its full curriculum + the viewer's access state. */
export interface SatLearnCourseDetail extends SatLearnCourse {
  topics: SatLearnTopicWithItems[];
  isEnrolled: boolean;
  isAdmin: boolean;
}

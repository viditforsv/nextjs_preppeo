// Shared types for lesson components

export interface LessonContent {
  id: string;
  content_type: "concepts" | "formulas";
  title: string;
  content: string;
  order_index: number;
}

export interface Lesson {
  id: string;
  title: string;
  slug: string;
  description?: string;
  topic_number?: string;
  lesson_order?: number;
  is_preview?: boolean;
  video_url?: string;
  video_thumbnail_url?: string;
  topic_badge?: string;
  pdf_url?: string;
  solution_url?: string;
  quiz_id?: string;
  content?: string;
  concept_title?: string;
  concept_content?: string;
  formula_title?: string;
  formula_content?: string;
  course_lesson_content?: LessonContent[];
  chapter?: {
    id: string;
    chapter_name: string;
    chapter_order: number;
    unit?: {
      id: string;
      unit_name: string;
      unit_order: number;
    };
  };
}

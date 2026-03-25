"use client";

import { Button } from "@/design-system/components/ui/button";
import { ArrowLeft, ArrowRight } from "lucide-react";
import type { Lesson } from "./types";

interface LessonNavigationProps {
  lesson: Lesson;
  allLessons: Lesson[];
  onNavigateLesson: (direction: "prev" | "next") => void;
}

export function LessonNavigation({
  lesson,
  allLessons,
  onNavigateLesson,
}: LessonNavigationProps) {
  if (allLessons.length === 0) return null;

  return (
    <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between mt-4 gap-3">
      <Button
        variant="outline"
        className="rounded-sm w-full sm:w-auto"
        onClick={() => onNavigateLesson("prev")}
        disabled={
          !allLessons.find(
            (l) => l.lesson_order === (lesson.lesson_order || 0) - 1
          )
        }
      >
        <ArrowLeft className="w-4 h-4 mr-2" />
        Previous Lesson
      </Button>
      <Button
        className="bg-[#1a365d] hover:bg-[#1a365d]/90 rounded-sm w-full sm:w-auto"
        onClick={() => onNavigateLesson("next")}
        disabled={
          !allLessons.find(
            (l) => l.lesson_order === (lesson.lesson_order || 0) + 1
          )
        }
      >
        Next Lesson
        <ArrowRight className="w-4 h-4 ml-2" />
      </Button>
    </div>
  );
}

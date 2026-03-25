"use client";

import { useState } from "react";
import type { Lesson } from "@/components/lesson/types";

interface UseEditableFieldParams {
  lesson: Lesson;
  isAdmin: boolean;
  onLessonUpdate?: (updatedLesson: Partial<Lesson>) => void;
}

export function useEditableField({
  lesson,
  isAdmin,
  onLessonUpdate,
}: UseEditableFieldParams) {
  const [editingField, setEditingField] = useState<string | null>(null);
  const [editValues, setEditValues] = useState<Record<string, unknown>>({});
  const [saving, setSaving] = useState(false);

  const handleStartEdit = (field: string) => {
    if (!isAdmin || !lesson) return;
    setEditingField(field);
    setEditValues({ [field]: lesson[field as keyof Lesson] || "" });
  };

  const handleCancelEdit = () => {
    setEditingField(null);
    setEditValues({});
  };

  const handleValueChange = (field: string, value: unknown) => {
    setEditValues((prev) => ({ ...prev, [field]: value }));
  };

  const handleSaveField = async (field: string) => {
    if (!isAdmin || !lesson?.id) return;

    setSaving(true);
    try {
      const response = await fetch(`/api/lessons/${lesson.id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ [field]: editValues[field] }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || "Failed to update lesson");
      }

      const { lesson: updatedLesson } = await response.json();
      if (onLessonUpdate) onLessonUpdate(updatedLesson);

      setEditingField(null);
      setEditValues({});
      window.location.reload();
    } catch (err) {
      console.error("Error saving field:", err);
      alert(
        err instanceof Error
          ? err.message
          : "Failed to save changes. Please try again."
      );
    } finally {
      setSaving(false);
    }
  };

  return {
    editingField,
    editValues,
    saving,
    handleStartEdit,
    handleCancelEdit,
    handleValueChange,
    handleSaveField,
  };
}

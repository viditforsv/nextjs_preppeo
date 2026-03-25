"use client";

import { Button } from "@/design-system/components/ui/button";
import { Input } from "@/design-system/components/ui/input";
import { Edit, Save, X, Loader2 } from "lucide-react";
import type { Lesson } from "./types";
import type { useEditableField } from "@/hooks/useEditableField";

type EditableFieldState = ReturnType<typeof useEditableField>;

interface LessonHeaderProps {
  lesson: Lesson;
  showTopicNumber: boolean;
  isAdmin: boolean;
  editable: EditableFieldState;
}

export function LessonHeader({
  lesson,
  showTopicNumber,
  isAdmin,
  editable,
}: LessonHeaderProps) {
  const {
    editingField,
    editValues,
    saving,
    handleStartEdit,
    handleCancelEdit,
    handleValueChange,
    handleSaveField,
  } = editable;

  return (
    <div className="mb-4 md:mb-6">
      {/* Title row */}
      {editingField === "title" ? (
        <div className="flex items-center gap-2 mb-2">
          <input
            type="text"
            value={(editValues.title as string) || ""}
            onChange={(e) => handleValueChange("title", e.target.value)}
            className="text-2xl md:text-3xl font-bold text-[#1e293b] border-2 border-[#1a365d] rounded-sm px-3 py-2 flex-1"
            autoFocus
          />
          <Button
            size="sm"
            onClick={() => handleSaveField("title")}
            disabled={saving}
            className="rounded-sm bg-green-600 hover:bg-green-700"
          >
            {saving ? (
              <Loader2 className="w-4 h-4 animate-spin" />
            ) : (
              <Save className="w-4 h-4" />
            )}
          </Button>
          <Button
            size="sm"
            onClick={handleCancelEdit}
            disabled={saving}
            variant="outline"
            className="rounded-sm"
          >
            <X className="w-4 h-4" />
          </Button>
        </div>
      ) : (
        <>
          <div className="flex items-center gap-2 mb-2">
            <h1 className="text-2xl md:text-3xl font-bold text-[#1e293b]">
              {lesson.title}
            </h1>
            {isAdmin && (
              <button
                onClick={() => handleStartEdit("title")}
                className="p-2 hover:bg-gray-100 rounded-sm transition-colors border border-gray-300 bg-white shadow-sm"
                title="Edit title"
              >
                <Edit className="w-4 h-4 text-[#1a365d]" />
              </button>
            )}
          </div>
          {lesson.chapter?.unit?.unit_name && lesson.chapter?.chapter_name && (
            <div className="mb-4">
              <p className="text-sm text-muted-foreground">
                {lesson.chapter.unit.unit_name} →{" "}
                {lesson.chapter.chapter_name}
              </p>
            </div>
          )}
        </>
      )}

      {/* Topic badge row */}
      {editingField === "topic_badge" ? (
        <div className="flex items-center gap-2">
          <Input
            type="text"
            value={(editValues.topic_badge as string) || ""}
            onChange={(e) => handleValueChange("topic_badge", e.target.value)}
            className="text-muted-foreground border-2 border-[#1a365d] rounded-sm px-3 py-2 flex-1 max-w-xs"
            placeholder={`Topic ${lesson.topic_number || ""}`}
            autoFocus
          />
          <Button
            size="sm"
            onClick={() => handleSaveField("topic_badge")}
            disabled={saving}
            className="rounded-sm bg-green-600 hover:bg-green-700"
          >
            {saving ? (
              <Loader2 className="w-4 h-4 animate-spin" />
            ) : (
              <Save className="w-4 h-4" />
            )}
          </Button>
          <Button
            size="sm"
            onClick={handleCancelEdit}
            disabled={saving}
            variant="outline"
            className="rounded-sm"
          >
            <X className="w-4 h-4" />
          </Button>
        </div>
      ) : (
        showTopicNumber &&
        lesson.topic_number && (
          <div className="flex items-center gap-2">
            <p className="text-muted-foreground">
              {lesson.topic_badge || `Topic ${lesson.topic_number}`}
            </p>
            {isAdmin && (
              <button
                onClick={() => handleStartEdit("topic_badge")}
                className="p-1 hover:bg-gray-100 rounded-sm transition-colors border border-gray-300 bg-white shadow-sm"
                title="Edit topic badge"
              >
                <Edit className="w-3 h-3 text-[#1a365d]" />
              </button>
            )}
          </div>
        )
      )}
    </div>
  );
}

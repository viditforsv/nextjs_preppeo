"use client";

import { useState, useRef } from "react";
import type { Lesson } from "@/components/lesson/types";

interface UseFeedbackFormParams {
  lesson: Lesson;
  courseSlug: string;
}

export function useFeedbackForm({ lesson, courseSlug }: UseFeedbackFormParams) {
  const [showFeedbackModal, setShowFeedbackModal] = useState(false);
  const [feedbackType, setFeedbackType] = useState<
    "mistake" | "suggestion" | null
  >(null);
  const [feedbackMessage, setFeedbackMessage] = useState("");
  const [submittingFeedback, setSubmittingFeedback] = useState(false);
  const [feedbackImage, setFeedbackImage] = useState<File | null>(null);
  const [feedbackImagePreview, setFeedbackImagePreview] = useState<
    string | null
  >(null);
  const [uploadingImage, setUploadingImage] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const openFeedbackModal = () => setShowFeedbackModal(true);

  const closeFeedbackModal = () => {
    setShowFeedbackModal(false);
    setFeedbackMessage("");
    setFeedbackType(null);
    setFeedbackImage(null);
    setFeedbackImagePreview(null);
    if (fileInputRef.current) fileInputRef.current.value = "";
  };

  const handleImageSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    if (!file.type.startsWith("image/")) {
      alert("Please select an image file");
      return;
    }

    if (file.size > 10 * 1024 * 1024) {
      alert("Image size must be less than 10MB");
      return;
    }

    setFeedbackImage(file);

    const reader = new FileReader();
    reader.onloadend = () => {
      setFeedbackImagePreview(reader.result as string);
    };
    reader.readAsDataURL(file);
  };

  const handleRemoveImage = () => {
    setFeedbackImage(null);
    setFeedbackImagePreview(null);
    if (fileInputRef.current) fileInputRef.current.value = "";
  };

  const handleSubmitFeedback = async () => {
    if (!feedbackType || !feedbackMessage.trim()) return;

    setSubmittingFeedback(true);
    let imageUrl: string | null = null;

    try {
      if (feedbackImage) {
        setUploadingImage(true);

        const formData = new FormData();
        formData.append("file", feedbackImage);
        formData.append("type", "feedback-image");
        formData.append("title", `Feedback Image - ${feedbackImage.name}`);

        const authToken = localStorage.getItem("supabase.auth.token");
        const uploadResponse = await fetch("/api/upload", {
          method: "POST",
          body: formData,
          headers: authToken ? { Authorization: `Bearer ${authToken}` } : {},
        });

        if (uploadResponse.ok) {
          const uploadData = await uploadResponse.json();
          if (uploadData.success && uploadData.url) {
            imageUrl = uploadData.url;
          }
        } else {
          const errorData = await uploadResponse.json();
          throw new Error(errorData.error || "Image upload failed");
        }
        setUploadingImage(false);
      }

      const response = await fetch("/api/lesson-feedback", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          lesson_id: lesson.id,
          lesson_slug: lesson.slug,
          course_slug: courseSlug,
          feedback_type: feedbackType,
          message: feedbackMessage,
          image_url: imageUrl,
        }),
      });

      if (response.ok) {
        closeFeedbackModal();
        alert("Thank you for your feedback! We'll review it soon.");
      } else {
        const data = await response.json();
        alert(`Error: ${data.error || "Failed to submit feedback"}`);
      }
    } catch (error) {
      console.error("Error submitting feedback:", error);
      alert(
        `Failed to submit feedback: ${
          error instanceof Error ? error.message : "Unknown error"
        }`
      );
    } finally {
      setSubmittingFeedback(false);
      setUploadingImage(false);
    }
  };

  return {
    showFeedbackModal,
    feedbackType,
    feedbackMessage,
    feedbackImage,
    feedbackImagePreview,
    submittingFeedback,
    uploadingImage,
    fileInputRef,
    openFeedbackModal,
    closeFeedbackModal,
    setFeedbackType,
    setFeedbackMessage,
    handleImageSelect,
    handleRemoveImage,
    handleSubmitFeedback,
  };
}

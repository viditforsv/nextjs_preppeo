"use client";

import Image from "next/image";
import { Button } from "@/design-system/components/ui/button";
import { Textarea } from "@/design-system/components/textarea";
import { Label } from "@/design-system/components/ui/label";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/design-system/components/dialog";
import {
  Flag,
  AlertCircle,
  Upload,
  Send,
  Loader2,
  X,
  Image as ImageIcon,
} from "lucide-react";
import type { useFeedbackForm } from "@/hooks/useFeedbackForm";

type FeedbackModalProps = ReturnType<typeof useFeedbackForm> & {
  lessonTitle: string;
  courseSlug: string;
};

export function FeedbackModal({
  lessonTitle,
  courseSlug,
  showFeedbackModal,
  feedbackType,
  feedbackMessage,
  feedbackImage,
  feedbackImagePreview,
  submittingFeedback,
  uploadingImage,
  fileInputRef,
  closeFeedbackModal,
  setFeedbackType,
  setFeedbackMessage,
  handleImageSelect,
  handleRemoveImage,
  handleSubmitFeedback,
}: FeedbackModalProps) {
  return (
    <Dialog open={showFeedbackModal} onOpenChange={closeFeedbackModal}>
      <DialogContent className="rounded-sm max-w-md">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <Flag className="w-5 h-5 text-[#1a365d]" />
            Report an Issue or Suggest Changes
          </DialogTitle>
          <DialogDescription>
            Help us improve this lesson by reporting mistakes or suggesting
            improvements.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4 py-4">
          {/* Feedback Type */}
          <div>
            <Label className="mb-2 block">
              What would you like to report?
            </Label>
            <div className="grid grid-cols-2 gap-3">
              <Button
                variant={feedbackType === "mistake" ? "primary" : "outline"}
                className={`rounded-sm ${
                  feedbackType === "mistake"
                    ? "bg-red-600 hover:bg-red-700 text-white"
                    : ""
                }`}
                onClick={() => setFeedbackType("mistake")}
              >
                <AlertCircle className="w-4 h-4 mr-2" />
                Found a Mistake
              </Button>
              <Button
                variant={feedbackType === "suggestion" ? "primary" : "outline"}
                className="rounded-sm"
                onClick={() => setFeedbackType("suggestion")}
              >
                <Flag className="w-4 h-4 mr-2" />
                Suggest Changes
              </Button>
            </div>
          </div>

          {/* Message */}
          <div>
            <Label htmlFor="feedback-message" className="mb-2 block">
              Your feedback *
            </Label>
            <Textarea
              id="feedback-message"
              value={feedbackMessage}
              onChange={(e) => setFeedbackMessage(e.target.value)}
              placeholder="Describe the mistake or your suggestion in detail..."
              className="min-h-[120px] rounded-sm"
              rows={5}
            />
          </div>

          {/* Image Attachment */}
          <div>
            <Label className="mb-2 block">Attach an image (optional)</Label>
            {!feedbackImagePreview ? (
              <div className="border-2 border-dashed border-gray-300 rounded-sm p-4">
                <div className="flex flex-col items-center justify-center space-y-3">
                  <div className="p-2 bg-gray-100 rounded-sm">
                    <ImageIcon className="w-6 h-6 text-gray-500" />
                  </div>
                  <div className="text-center">
                    <p className="text-sm text-gray-600 mb-1">
                      Upload a screenshot or image to help explain your feedback
                    </p>
                    <p className="text-xs text-gray-400">Max size: 10MB</p>
                  </div>
                  <Button
                    type="button"
                    variant="outline"
                    className="rounded-sm"
                    onClick={() => fileInputRef.current?.click()}
                    disabled={uploadingImage}
                  >
                    <Upload className="w-4 h-4 mr-2" />
                    Select Image
                  </Button>
                  <input
                    ref={fileInputRef}
                    type="file"
                    accept="image/*"
                    onChange={handleImageSelect}
                    className="hidden"
                  />
                </div>
              </div>
            ) : (
              <div className="space-y-2">
                <div className="relative border rounded-sm overflow-hidden">
                  <Image
                    src={feedbackImagePreview}
                    alt="Feedback preview"
                    width={800}
                    height={192}
                    className="w-full h-48 object-contain bg-gray-50"
                  />
                  <Button
                    type="button"
                    variant="destructive"
                    size="sm"
                    className="absolute top-2 right-2 rounded-sm"
                    onClick={handleRemoveImage}
                  >
                    <X className="w-4 h-4" />
                  </Button>
                </div>
                <p className="text-xs text-muted-foreground">
                  {feedbackImage?.name}
                </p>
              </div>
            )}
          </div>

          <p className="text-xs text-muted-foreground">
            Lesson: <strong>{lessonTitle}</strong>
            <br />
            Course: <strong>{courseSlug}</strong>
          </p>
        </div>

        <DialogFooter>
          <Button
            variant="outline"
            onClick={closeFeedbackModal}
            className="rounded-sm"
            disabled={submittingFeedback}
          >
            Cancel
          </Button>
          <Button
            onClick={handleSubmitFeedback}
            disabled={
              !feedbackType || !feedbackMessage.trim() || submittingFeedback
            }
            className="bg-[#1a365d] hover:bg-[#1a365d]/90 rounded-sm"
          >
            {submittingFeedback ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                Submitting...
              </>
            ) : (
              <>
                <Send className="w-4 h-4 mr-2" />
                Submit Feedback
              </>
            )}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

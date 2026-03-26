"use client";

import { useState, useEffect, useMemo } from "react";
import { fetchWithRetry } from "@/lib/fetch-with-retry";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/design-system/components/ui/card";
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@/design-system/components/tabs";
import {
  BookOpen,
  FileText,
  Video,
  FileCheck,
  CheckCircle2,
  CheckCircle,
  Upload,
  Lightbulb,
  Calculator,
  Loader2,
  AlertCircle,
  Flag,
  Save,
  X,
  Edit,
} from "lucide-react";
import { Input } from "@/design-system/components/ui/input";
import { Textarea } from "@/design-system/components/textarea";
import { Badge } from "@/design-system/components/ui/badge";
import { Button } from "@/design-system/components/ui/button";
import { VideoResource } from "@/design-system/components/youtube-video";
import { renderMixedContent } from "@/components/MathRenderer";
import { Switch } from "@/design-system/components/switch";
import { Label } from "@/design-system/components/ui/label";
import { IBDPQuestionSession } from "@/components/IBDPMathTemplate/IBDPQuestionSession";
import { QuizPlayer } from "@/components/QuizPlayer";
import { useScreenshotPrevention } from "@/hooks/useScreenshotPrevention";
import { useEditableField } from "@/hooks/useEditableField";
import { useAITutor } from "@/hooks/useAITutor";
import { useFeedbackForm } from "@/hooks/useFeedbackForm";
import { LessonHeader } from "./lesson/LessonHeader";
import { LessonNavigation } from "./lesson/LessonNavigation";
import { ChatInterface } from "./lesson/ChatInterface";
import { FeedbackModal } from "./lesson/FeedbackModal";
import type { Lesson, LessonContent } from "./lesson/types";

export type { Lesson };

interface UnifiedLessonPageProps {
  lesson: Lesson;
  courseSlug: string;
  showTopicNumber?: boolean;
  onMarkComplete?: () => void;
  onFileUpload?: (event: React.ChangeEvent<HTMLInputElement>) => void;
  isCompleted?: boolean;
  isMarkingComplete?: boolean;
  uploadedFile?: File | null;
  submissionStatus?: "idle" | "uploading" | "success" | "error";
  submissionError?: string;
  allLessons?: Lesson[];
  onNavigateLesson?: (direction: "prev" | "next") => void;
  isAdmin?: boolean;
  onLessonUpdate?: (updatedLesson: Partial<Lesson>) => void;
}

// Extract YouTube video ID from URL
function extractYouTubeId(url: string): string | null {
  if (!url) return null;
  const patterns = [
    /(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/|youtube\.com\/v\/)([^#&?]{11})/,
    /^([a-zA-Z0-9_-]{11})$/,
  ];
  for (const pattern of patterns) {
    const match = url.match(pattern);
    if (match && match[1] && match[1].length === 11) return match[1];
  }
  return null;
}

export function UnifiedLessonPage({
  lesson,
  courseSlug,
  showTopicNumber = true,
  onMarkComplete,
  onFileUpload,
  isCompleted = false,
  isMarkingComplete = false,
  uploadedFile = null,
  submissionStatus = "idle",
  submissionError = "",
  allLessons = [],
  onNavigateLesson,
  isAdmin = false,
  onLessonUpdate,
}: UnifiedLessonPageProps) {
  const [lessonContent, setLessonContent] = useState<LessonContent[]>([]);
  const [loadingContent, setLoadingContent] = useState(true);
  const [activeTab, setActiveTab] = useState<string>("");
  const [questions, setQuestions] = useState<
    Array<{
      id: string;
      question_text: string;
      tags: string[];
      marks: number;
      solution?: string;
      difficulty?: number;
    }>
  >([]);
  const [loadingQuestions, setLoadingQuestions] = useState(false);
  const [isAssignmentTabActive, setIsAssignmentTabActive] = useState(false);

  // Hooks
  const editable = useEditableField({ lesson, isAdmin, onLessonUpdate });
  const aiTutor = useAITutor(lesson.title);
  const feedback = useFeedbackForm({ lesson, courseSlug });

  // Screenshot prevention for PDF viewer
  const pdfContainerRef = useScreenshotPrevention(
    !!lesson.pdf_url && isAssignmentTabActive
  );

  // Fetch lesson content (concepts/formulas)
  useEffect(() => {
    if (!lesson.id) return;
    const fetchLessonContent = async () => {
      try {
        setLoadingContent(true);
        const response = await fetchWithRetry(`/api/lessons/${lesson.id}/content`);
        if (response.ok) {
          const data = await response.json();
          setLessonContent(data.content || []);
        }
      } catch (error) {
        console.error("Error fetching lesson content:", error);
      } finally {
        setLoadingContent(false);
      }
    };
    fetchLessonContent();
  }, [lesson.id]);

  // Fetch questions for the lesson
  useEffect(() => {
    if (!lesson.id) return;
    const fetchQuestions = async () => {
      try {
        setLoadingQuestions(true);
        const response = await fetchWithRetry(`/api/lessons/${lesson.id}/questions`);
        if (response.ok) {
          const data = await response.json();
          setQuestions(data.questions || []);
        }
      } catch (error) {
        console.error("Error fetching questions:", error);
      } finally {
        setLoadingQuestions(false);
      }
    };
    fetchQuestions();
  }, [lesson.id]);

  // Tab availability
  const hasConcepts = lessonContent.some((c) => c.content_type === "concepts");
  const hasFormulas = lessonContent.some((c) => c.content_type === "formulas");
  const hasVideo = !!lesson.video_url;
  const hasPDFAssignment = !!lesson.pdf_url;
  const hasPDFSolution = !!lesson.solution_url;
  const hasQuiz = !!lesson.quiz_id;
  const hasQuestions = questions.length > 0;
  const hasNotes = !!(
    lesson.content ||
    lesson.concept_title ||
    lesson.concept_content ||
    lesson.formula_title ||
    lesson.formula_content
  );

  interface TabItem {
    id: string;
    label: string;
    icon: React.ComponentType<{ className?: string }>;
  }
  const availableTabs: TabItem[] = useMemo(() => {
    const tabs: TabItem[] = [];
    if (hasQuestions) tabs.push({ id: "questions", label: "Questions", icon: FileCheck });
    if (hasConcepts || hasFormulas) tabs.push({ id: "content", label: "Concepts & Formulas", icon: BookOpen });
    if (hasVideo) tabs.push({ id: "video", label: "Video", icon: Video });
    if (hasNotes) tabs.push({ id: "notes", label: "Concepts", icon: FileText });
    if (hasPDFAssignment) tabs.push({ id: "assignment", label: "Assignment", icon: FileText });
    if (hasPDFSolution) tabs.push({ id: "solution", label: "Solution", icon: CheckCircle2 });
    if (hasQuiz) tabs.push({ id: "quiz", label: "Quiz", icon: FileCheck });
    return tabs;
  }, [hasQuestions, hasConcepts, hasFormulas, hasVideo, hasNotes, hasPDFAssignment, hasPDFSolution, hasQuiz]);

  const defaultTab = availableTabs[0]?.id || "content";

  useEffect(() => {
    console.log("UnifiedLessonPage - Lesson data:", { id: lesson.id, title: lesson.title, quiz_id: lesson.quiz_id, hasQuiz });
  }, [lesson, hasQuiz]);

  useEffect(() => {
    console.log("UnifiedLessonPage - Available tabs:", availableTabs.map((t) => t.id));
    console.log("UnifiedLessonPage - Default tab:", defaultTab);
  }, [availableTabs, defaultTab]);

  useEffect(() => {
    const currentTab = activeTab || defaultTab;
    setIsAssignmentTabActive(currentTab === "assignment");
  }, [activeTab, defaultTab]);

  useEffect(() => {
    if (!activeTab && availableTabs.length > 0) setActiveTab(defaultTab);
  }, [activeTab, availableTabs.length, defaultTab]);

  const tabsGridClass = availableTabs.length === 1
    ? "grid-cols-1"
    : availableTabs.length === 2
    ? "grid-cols-2"
    : availableTabs.length === 3
    ? "grid-cols-3"
    : availableTabs.length === 4
    ? "grid-cols-2 md:grid-cols-4"
    : availableTabs.length === 5
    ? "grid-cols-3 md:grid-cols-5"
    : availableTabs.length === 6
    ? "grid-cols-3 md:grid-cols-6"
    : "grid-cols-3 md:grid-cols-7";

  const { editingField, editValues, saving, handleStartEdit, handleCancelEdit, handleValueChange, handleSaveField } = editable;

  // Helper: inline edit row (URL field)
  const EditableURLField = ({
    field,
    label,
    placeholder,
  }: {
    field: string;
    label: string;
    placeholder: string;
  }) => (
    <div className="mb-6 space-y-4">
      <div>
        <label className="text-sm font-medium mb-2 block">{label}</label>
        <div className="flex gap-2">
          <Input
            type="url"
            value={(editValues[field] as string) || ""}
            onChange={(e) => handleValueChange(field, e.target.value)}
            placeholder={placeholder}
            className="flex-1"
          />
          <Button size="sm" onClick={() => handleSaveField(field)} disabled={saving}
            className="rounded-sm bg-green-600 hover:bg-green-700">
            {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
          </Button>
          <Button size="sm" onClick={handleCancelEdit} disabled={saving}
            variant="outline" className="rounded-sm">
            <X className="w-4 h-4" />
          </Button>
        </div>
      </div>
    </div>
  );

  return (
    <div>
      <LessonHeader
        lesson={lesson}
        showTopicNumber={showTopicNumber}
        isAdmin={isAdmin}
        editable={editable}
      />

      {availableTabs.length > 0 ? (
        <Tabs
          value={activeTab || defaultTab}
          onValueChange={(value) => {
            setActiveTab(value);
            setIsAssignmentTabActive(value === "assignment");
          }}
          className="w-full"
        >
          <TabsList className={`grid w-full rounded-sm bg-gray-100 p-1 shadow-sm border border-gray-200 overflow-x-auto ${tabsGridClass}`}>
            {availableTabs.map((tab) => (
              <TabsTrigger
                key={tab.id}
                value={tab.id}
                className="rounded-sm data-[state=active]:bg-primary data-[state=active]:text-white data-[state=active]:shadow-sm font-medium transition-all duration-200 text-xs md:text-sm"
              >
                <tab.icon className="w-4 h-4 md:mr-2" />
                <span className="hidden md:inline">{tab.label}</span>
              </TabsTrigger>
            ))}
          </TabsList>

          {/* Questions Tab */}
          {hasQuestions && (
            <TabsContent value="questions" className="mt-6 space-y-4">
              {loadingQuestions ? (
                <Card>
                  <CardContent className="py-12 text-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-[#1a365d] mx-auto mb-4"></div>
                    <p className="text-muted-foreground">Loading questions...</p>
                  </CardContent>
                </Card>
              ) : (
                <IBDPQuestionSession
                  questions={questions}
                  onSessionComplete={(results) => {
                    console.log("Question session completed:", results);
                  }}
                />
              )}
            </TabsContent>
          )}

          {/* Concepts & Formulas Tab */}
          {(hasConcepts || hasFormulas) && (
            <TabsContent value="content" className="mt-6 space-y-4">
              <Card>
                <CardHeader>
                  <CardTitle>Concepts & Formulas</CardTitle>
                </CardHeader>
                <CardContent>
                  {loadingContent ? (
                    <div className="text-center py-8">
                      <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-[#1a365d] mx-auto"></div>
                    </div>
                  ) : lessonContent.length > 0 ? (
                    <div className="space-y-6">
                      {lessonContent
                        .sort((a, b) => a.order_index - b.order_index)
                        .map((content) => (
                          <div key={content.id} className="border rounded-sm p-4">
                            <h3 className="font-semibold mb-2 flex items-center space-x-2">
                              <Badge variant="secondary" className="capitalize">
                                {content.content_type}
                              </Badge>
                              <span>{content.title}</span>
                            </h3>
                            <div
                              className="prose max-w-none"
                              dangerouslySetInnerHTML={{ __html: content.content || "" }}
                            />
                          </div>
                        ))}
                    </div>
                  ) : (
                    <p className="text-muted-foreground text-center py-8">
                      No content available yet.
                    </p>
                  )}
                </CardContent>
              </Card>
            </TabsContent>
          )}

          {/* Assignment Tab */}
          {hasPDFAssignment && (
            <TabsContent value="assignment" className="mt-6 space-y-4">
              <Card className="rounded-sm">
                <CardHeader>
                  <div className="flex items-center justify-between">
                    <div>
                      <CardTitle className="flex items-center space-x-2">
                        <FileText className="w-5 h-5 text-[#1a365d]" />
                        <span>Assignment</span>
                      </CardTitle>
                      <CardDescription>
                        Complete this assignment to test your understanding
                      </CardDescription>
                    </div>
                    {isAdmin && (
                      <button onClick={() => handleStartEdit("pdf_url")}
                        className="p-2 hover:bg-gray-100 rounded-sm transition-colors border border-gray-300 bg-white shadow-sm"
                        title="Edit PDF URL">
                        <Edit className="w-4 h-4 text-[#1a365d]" />
                      </button>
                    )}
                  </div>
                </CardHeader>
                <CardContent>
                  {editingField === "pdf_url" ? (
                    <EditableURLField field="pdf_url" label="Assignment PDF URL" placeholder="https://..." />
                  ) : lesson.pdf_url ? (
                    <div className="space-y-4">
                      <div
                        ref={pdfContainerRef}
                        className="w-full h-[500px] md:h-[800px] border-2 border-[#1a365d]/10 rounded-sm overflow-hidden bg-gray-50"
                      >
                        {isAssignmentTabActive ? (
                          <iframe
                            key={`assignment-${lesson.id}-${lesson.pdf_url}`}
                            src={lesson.pdf_url}
                            className="w-full h-full"
                            title={`${lesson.title} - Assignment`}
                            allow="autoplay; fullscreen"
                            sandbox="allow-same-origin allow-scripts allow-popups allow-forms"
                          />
                        ) : (
                          <div className="w-full h-full flex items-center justify-center">
                            <p className="text-muted-foreground">Loading PDF...</p>
                          </div>
                        )}
                      </div>

                      {(onFileUpload || onMarkComplete) && (
                        <div className="border-t pt-4 mt-4">
                          <h3 className="text-lg font-semibold mb-3">Submit Your Work</h3>
                          <div className="space-y-4">
                            {onFileUpload && (
                              <div>
                                <label htmlFor="assignment-file" className="block text-sm font-medium mb-2">
                                  Upload your completed assignment (PDF only, max 5MB)
                                </label>
                                <div className="flex items-center gap-3">
                                  <input id="assignment-file" type="file" accept=".pdf"
                                    onChange={onFileUpload} className="hidden"
                                    disabled={submissionStatus === "uploading"} />
                                  <label htmlFor="assignment-file"
                                    className="flex items-center gap-2 px-4 py-2 border rounded-sm cursor-pointer hover:bg-gray-50 transition-colors">
                                    <Upload className="w-4 h-4" />
                                    Choose PDF File
                                  </label>
                                  {uploadedFile && (
                                    <span className="text-sm text-muted-foreground">
                                      Selected: {uploadedFile.name}
                                    </span>
                                  )}
                                </div>
                                {submissionError && (
                                  <p className="text-sm text-red-600 mt-2">{submissionError}</p>
                                )}
                                {submissionStatus === "success" && (
                                  <p className="text-sm text-green-600 mt-2">
                                    Assignment submitted successfully! Your teacher will review it.
                                  </p>
                                )}
                                {submissionStatus === "uploading" && (
                                  <p className="text-sm text-blue-600 mt-2">Uploading...</p>
                                )}
                              </div>
                            )}
                          </div>
                        </div>
                      )}

                      <div className="flex flex-col md:flex-row items-stretch md:items-center justify-between mt-4 gap-3">
                        <Button variant="outline" className="rounded-sm w-full md:w-auto"
                          onClick={() => window.open(lesson.pdf_url, "_blank")}>
                          <FileText className="w-4 h-4 mr-2" />
                          Open in New Tab
                        </Button>
                        <div className="flex flex-col sm:flex-row items-stretch sm:items-center space-y-2 sm:space-y-0 sm:space-x-3">
                          {hasPDFSolution && (
                            <Button variant="outline" className="rounded-sm w-full sm:w-auto"
                              onClick={() => { setActiveTab("solution"); setIsAssignmentTabActive(false); }}>
                              <CheckCircle className="w-4 h-4 mr-2" />
                              View Solution
                            </Button>
                          )}
                          {onMarkComplete && (
                            <div className="flex items-center justify-between sm:justify-start space-x-3 p-3 sm:p-0 border sm:border-0 rounded-sm">
                              <Label htmlFor="complete-toggle" className="text-sm font-medium">
                                {isCompleted ? "Completed" : "Mark as Complete"}
                              </Label>
                              <div className="relative">
                                <Switch
                                  id="complete-toggle"
                                  checked={isCompleted}
                                  onCheckedChange={(checked) => {
                                    if (!isMarkingComplete && onMarkComplete && checked !== isCompleted) {
                                      onMarkComplete();
                                    }
                                  }}
                                  disabled={isMarkingComplete}
                                  className="data-[state=checked]:bg-green-600"
                                />
                                {isMarkingComplete && (
                                  <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
                                    <Loader2 className="w-3 h-3 animate-spin text-white" />
                                  </div>
                                )}
                              </div>
                            </div>
                          )}
                        </div>
                      </div>
                    </div>
                  ) : (
                    <div className="text-center py-12 text-muted-foreground">
                      <FileText className="w-16 h-16 mx-auto mb-4 opacity-50" />
                      <p className="text-lg mb-2">Assignment not available</p>
                      <p className="text-sm">The assignment for this lesson will be available soon</p>
                    </div>
                  )}
                </CardContent>
              </Card>
            </TabsContent>
          )}

          {/* Solution Tab */}
          {hasPDFSolution && (
            <TabsContent value="solution" className="mt-6 space-y-4">
              <Card className="rounded-sm">
                <CardHeader>
                  <div className="flex items-center justify-between">
                    <div>
                      <CardTitle className="flex items-center space-x-2">
                        <CheckCircle className="w-5 h-5 text-green-600" />
                        <span>Solution</span>
                      </CardTitle>
                      <CardDescription>Check your answers with the complete solution</CardDescription>
                    </div>
                    {isAdmin && (
                      <button onClick={() => handleStartEdit("solution_url")}
                        className="p-2 hover:bg-gray-100 rounded-sm transition-colors border border-gray-300 bg-white shadow-sm"
                        title="Edit Solution URL">
                        <Edit className="w-4 h-4 text-[#1a365d]" />
                      </button>
                    )}
                  </div>
                </CardHeader>
                <CardContent>
                  {editingField === "solution_url" ? (
                    <EditableURLField field="solution_url" label="Solution PDF URL" placeholder="https://..." />
                  ) : lesson.solution_url ? (
                    <div className="space-y-4">
                      <div className="w-full h-[500px] md:h-[800px] border-2 border-green-100 rounded-sm overflow-hidden bg-gray-50">
                        <iframe src={lesson.solution_url} className="w-full h-full"
                          title={`${lesson.title} - Solution`} allow="autoplay; fullscreen"
                          sandbox="allow-same-origin allow-scripts allow-popups allow-forms" />
                      </div>
                      <div className="flex flex-col md:flex-row items-stretch md:items-center justify-between gap-3">
                        <Button variant="outline" className="rounded-sm w-full md:w-auto"
                          onClick={() => window.open(lesson.solution_url, "_blank")}>
                          <FileText className="w-4 h-4 mr-2" />
                          Open in New Tab
                        </Button>
                        <div className="flex flex-col sm:flex-row items-stretch sm:items-center space-y-2 sm:space-y-0 sm:space-x-3">
                          {hasPDFAssignment && (
                            <Button variant="outline" className="rounded-sm w-full sm:w-auto"
                              onClick={() => { setActiveTab("assignment"); setIsAssignmentTabActive(true); }}>
                              <FileText className="w-4 h-4 mr-2" />
                              Back to Assignment
                            </Button>
                          )}
                          {onMarkComplete && (
                            <Button
                              className={`rounded-sm w-full sm:w-auto ${isCompleted ? "bg-green-600 hover:bg-green-700" : "bg-[#1a365d] hover:bg-[#1a365d]/90"}`}
                              onClick={onMarkComplete}
                              disabled={isMarkingComplete}
                            >
                              {isMarkingComplete ? (
                                <><Loader2 className="w-4 h-4 mr-2 animate-spin" />Saving...</>
                              ) : isCompleted ? (
                                <><CheckCircle className="w-4 h-4 mr-2" />Mark as Incomplete</>
                              ) : (
                                <><CheckCircle className="w-4 h-4 mr-2" />Mark as Complete</>
                              )}
                            </Button>
                          )}
                        </div>
                      </div>
                    </div>
                  ) : (
                    <div className="text-center py-12 text-muted-foreground">
                      <CheckCircle className="w-16 h-16 mx-auto mb-4 opacity-50" />
                      <p className="text-lg mb-2">Solution not available</p>
                      <p className="text-sm">The solution for this lesson will be available soon</p>
                    </div>
                  )}
                </CardContent>
              </Card>
            </TabsContent>
          )}

          {/* Video Tab */}
          {hasVideo && (
            <TabsContent value="video" className="mt-6 space-y-4">
              <Card className="rounded-sm">
                <CardHeader>
                  <div className="flex items-center justify-between">
                    <div>
                      <CardTitle className="flex items-center space-x-2">
                        <Video className="w-5 h-5 text-[#1a365d]" />
                        <span>Video Lesson</span>
                      </CardTitle>
                      <CardDescription>
                        Watch the complete lesson video with explanations and examples
                      </CardDescription>
                    </div>
                    {isAdmin && (
                      <button onClick={() => handleStartEdit("video_url")}
                        className="p-2 hover:bg-gray-100 rounded-sm transition-colors border border-gray-300 bg-white shadow-sm"
                        title="Edit video URL">
                        <Edit className="w-4 h-4 text-[#1a365d]" />
                      </button>
                    )}
                  </div>
                </CardHeader>
                <CardContent>
                  {editingField === "video_url" ? (
                    <EditableURLField
                      field="video_url"
                      label="Video URL"
                      placeholder="https://www.youtube.com/watch?v=..."
                    />
                  ) : lesson.video_url ? (
                    <div className="mb-6">
                      <VideoResource
                        resource={{
                          id: lesson.id,
                          type: "video",
                          url: lesson.video_url,
                          title: lesson.title,
                          description: lesson.description || "",
                          duration: 0,
                          isYouTube:
                            lesson.video_url.includes("youtube.com") ||
                            lesson.video_url.includes("youtu.be"),
                          youtubeId: extractYouTubeId(lesson.video_url) || undefined,
                          thumbnail: lesson.video_thumbnail_url || undefined,
                        }}
                        lessonId={lesson.id}
                        courseSlug={courseSlug}
                        onProgressUpdate={(progress) => {
                          console.log("Video progress:", progress);
                        }}
                      />
                    </div>
                  ) : (
                    <p className="text-muted-foreground text-center py-8">Video not available.</p>
                  )}
                </CardContent>
              </Card>
            </TabsContent>
          )}

          {/* Notes / Concepts / AI Tutor Tab */}
          {hasNotes && (
            <TabsContent value="notes" className="mt-6 space-y-4">
              <div className="flex items-center gap-2 text-sm text-muted-foreground mb-4">
                <BookOpen className="w-4 h-4" />
                <span>{lesson.title}</span>
              </div>

              {(() => {
                const hasConceptTab = lesson.concept_title || lesson.concept_content;
                const hasFormulaTab = lesson.formula_title || lesson.formula_content;
                const hasNotesTab = lesson.content;
                const nestedTabCount =
                  (hasConceptTab ? 1 : 0) +
                  (hasFormulaTab ? 1 : 0) +
                  (hasNotesTab ? 1 : 0) +
                  1; // AI Tutor always shows

                const nestedGridClass =
                  nestedTabCount === 1 ? "grid-cols-1"
                  : nestedTabCount === 2 ? "grid-cols-2"
                  : nestedTabCount === 3 ? "grid-cols-3"
                  : "grid-cols-2 md:grid-cols-4";

                const nestedTriggerClass =
                  "rounded-sm data-[state=active]:bg-primary data-[state=active]:text-white data-[state=active]:shadow-sm font-medium transition-all duration-200 hover:bg-gray-100 data-[state=inactive]:text-gray-700 data-[state=inactive]:bg-gray-50 data-[state=inactive]:border data-[state=inactive]:border-gray-200 text-xs md:text-sm";

                return (
                  <Tabs
                    defaultValue={
                      hasConceptTab ? "concepts"
                      : hasFormulaTab ? "formulas"
                      : hasNotesTab ? "notes"
                      : "ai-tutor"
                    }
                    className="w-full"
                  >
                    <TabsList className={`grid w-full rounded-sm bg-white p-1 shadow-sm border border-gray-200 gap-1 ${nestedGridClass}`}>
                      {hasConceptTab && <TabsTrigger value="concepts" className={nestedTriggerClass}>Concepts</TabsTrigger>}
                      {hasFormulaTab && <TabsTrigger value="formulas" className={nestedTriggerClass}>Formulas</TabsTrigger>}
                      {hasNotesTab && <TabsTrigger value="notes" className={nestedTriggerClass}>Notes</TabsTrigger>}
                      <TabsTrigger value="ai-tutor" className={nestedTriggerClass}>AI Tutor</TabsTrigger>
                    </TabsList>

                    {/* Concepts */}
                    {(lesson.concept_title || lesson.concept_content || isAdmin) && (
                      <TabsContent value="concepts" className="space-y-4 mt-6">
                        <Card className="rounded-sm">
                          <CardHeader>
                            <div className="flex items-center justify-between">
                              <div>
                                {editingField === "concept_title" ? (
                                  <div className="flex items-center gap-2">
                                    <Lightbulb className="w-5 h-5 text-[#1a365d]" />
                                    <Input
                                      type="text"
                                      value={(editValues.concept_title as string) || ""}
                                      onChange={(e) => handleValueChange("concept_title", e.target.value)}
                                      className="flex-1" placeholder="Concept title" autoFocus
                                    />
                                    <Button size="sm" onClick={() => handleSaveField("concept_title")} disabled={saving}
                                      className="rounded-sm bg-green-600 hover:bg-green-700">
                                      {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                                    </Button>
                                    <Button size="sm" onClick={handleCancelEdit} disabled={saving}
                                      variant="outline" className="rounded-sm">
                                      <X className="w-4 h-4" />
                                    </Button>
                                  </div>
                                ) : (
                                  <CardTitle className="flex items-center gap-2">
                                    <Lightbulb className="w-5 h-5 text-[#1a365d]" />
                                    {lesson.concept_title || "Understanding Concepts"}
                                    {isAdmin && (
                                      <button onClick={() => handleStartEdit("concept_title")}
                                        className="ml-2 p-1 hover:bg-gray-100 rounded-sm transition-colors border border-gray-300 bg-white shadow-sm"
                                        title="Edit concept title">
                                        <Edit className="w-3 h-3 text-[#1a365d]" />
                                      </button>
                                    )}
                                  </CardTitle>
                                )}
                                <CardDescription>Key concepts and principles for this lesson</CardDescription>
                              </div>
                            </div>
                          </CardHeader>
                          <CardContent className="space-y-4">
                            {editingField === "concept_content" ? (
                              <div className="space-y-2">
                                <Textarea
                                  value={(editValues.concept_content as string) || ""}
                                  onChange={(e) => handleValueChange("concept_content", e.target.value)}
                                  placeholder="Enter concept content (HTML or markdown supported)"
                                  className="min-h-[300px] font-mono text-sm" autoFocus
                                />
                                <div className="flex gap-2 justify-end">
                                  <Button size="sm" onClick={() => handleSaveField("concept_content")} disabled={saving}
                                    className="rounded-sm bg-green-600 hover:bg-green-700">
                                    {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                                  </Button>
                                  <Button size="sm" onClick={handleCancelEdit} disabled={saving}
                                    variant="outline" className="rounded-sm">
                                    <X className="w-4 h-4" />
                                  </Button>
                                </div>
                              </div>
                            ) : lesson.concept_content ? (
                              <div className="relative group">
                                <div className="text-base leading-relaxed text-gray-700 prose prose-sm max-w-none">
                                  <div dangerouslySetInnerHTML={{ __html: lesson.concept_content }} />
                                </div>
                                {isAdmin && (
                                  <button onClick={() => handleStartEdit("concept_content")}
                                    className="absolute top-0 right-0 p-2 hover:bg-gray-100 rounded-sm transition-colors border border-gray-300 bg-white shadow-sm opacity-0 group-hover:opacity-100"
                                    title="Edit concept content">
                                    <Edit className="w-4 h-4 text-[#1a365d]" />
                                  </button>
                                )}
                              </div>
                            ) : (
                              <div className="text-center py-8 text-muted-foreground relative">
                                <Lightbulb className="w-12 h-12 mx-auto mb-4 opacity-50" />
                                <p>Concept content will be available soon</p>
                                {isAdmin && (
                                  <Button size="sm" onClick={() => handleStartEdit("concept_content")}
                                    className="mt-4 rounded-sm" variant="outline">
                                    <Edit className="w-4 h-4 mr-2" />Add Content
                                  </Button>
                                )}
                              </div>
                            )}
                          </CardContent>
                        </Card>
                      </TabsContent>
                    )}

                    {/* Formulas */}
                    {(lesson.formula_title || lesson.formula_content || isAdmin) && (
                      <TabsContent value="formulas" className="space-y-4 mt-6">
                        <Card className="rounded-sm">
                          <CardHeader>
                            <div className="flex items-center justify-between">
                              <div>
                                {editingField === "formula_title" ? (
                                  <div className="flex items-center gap-2">
                                    <Calculator className="w-5 h-5 text-[#1a365d]" />
                                    <Input
                                      type="text"
                                      value={(editValues.formula_title as string) || ""}
                                      onChange={(e) => handleValueChange("formula_title", e.target.value)}
                                      className="flex-1" placeholder="Formula title" autoFocus
                                    />
                                    <Button size="sm" onClick={() => handleSaveField("formula_title")} disabled={saving}
                                      className="rounded-sm bg-green-600 hover:bg-green-700">
                                      {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                                    </Button>
                                    <Button size="sm" onClick={handleCancelEdit} disabled={saving}
                                      variant="outline" className="rounded-sm">
                                      <X className="w-4 h-4" />
                                    </Button>
                                  </div>
                                ) : (
                                  <CardTitle className="flex items-center gap-2">
                                    <Calculator className="w-5 h-5 text-[#1a365d]" />
                                    {lesson.formula_title || "Key Formulas"}
                                    {isAdmin && (
                                      <button onClick={() => handleStartEdit("formula_title")}
                                        className="ml-2 p-1 hover:bg-gray-100 rounded-sm transition-colors border border-gray-300 bg-white shadow-sm"
                                        title="Edit formula title">
                                        <Edit className="w-3 h-3 text-[#1a365d]" />
                                      </button>
                                    )}
                                  </CardTitle>
                                )}
                                <CardDescription>Essential formulas for this lesson</CardDescription>
                              </div>
                            </div>
                          </CardHeader>
                          <CardContent className="space-y-3">
                            {editingField === "formula_content" ? (
                              <div className="space-y-2">
                                <Textarea
                                  value={(editValues.formula_content as string) || ""}
                                  onChange={(e) => handleValueChange("formula_content", e.target.value)}
                                  placeholder="Enter formula content (HTML or markdown supported)"
                                  className="min-h-[300px] font-mono text-sm" autoFocus
                                />
                                <div className="flex gap-2 justify-end">
                                  <Button size="sm" onClick={() => handleSaveField("formula_content")} disabled={saving}
                                    className="rounded-sm bg-green-600 hover:bg-green-700">
                                    {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                                  </Button>
                                  <Button size="sm" onClick={handleCancelEdit} disabled={saving}
                                    variant="outline" className="rounded-sm">
                                    <X className="w-4 h-4" />
                                  </Button>
                                </div>
                              </div>
                            ) : lesson.formula_content ? (
                              <div className="relative group">
                                <div className="p-4 bg-gray-50 rounded-sm border border-gray-200">
                                  <div className="text-xl prose prose-sm max-w-none">
                                    <div dangerouslySetInnerHTML={{ __html: lesson.formula_content }} />
                                  </div>
                                </div>
                                {isAdmin && (
                                  <button onClick={() => handleStartEdit("formula_content")}
                                    className="absolute top-2 right-2 p-2 hover:bg-gray-100 rounded-sm transition-colors border border-gray-300 bg-white shadow-sm opacity-0 group-hover:opacity-100"
                                    title="Edit formula content">
                                    <Edit className="w-4 h-4 text-[#1a365d]" />
                                  </button>
                                )}
                              </div>
                            ) : (
                              <div className="text-center py-8 text-muted-foreground relative">
                                <Calculator className="w-12 h-12 mx-auto mb-3 opacity-30" />
                                <p>No formulas available for this lesson yet.</p>
                                {isAdmin && (
                                  <Button size="sm" onClick={() => handleStartEdit("formula_content")}
                                    className="mt-4 rounded-sm" variant="outline">
                                    <Edit className="w-4 h-4 mr-2" />Add Content
                                  </Button>
                                )}
                              </div>
                            )}
                          </CardContent>
                        </Card>
                      </TabsContent>
                    )}

                    {/* Notes */}
                    {(lesson.content || isAdmin) && (
                      <TabsContent value="notes" className="space-y-4 mt-6">
                        <Card className="rounded-sm">
                          <CardHeader>
                            <div className="flex items-center justify-between">
                              <div>
                                <CardTitle className="flex items-center gap-2">
                                  <FileText className="w-5 h-5 text-[#1a365d]" />
                                  Lesson Notes
                                </CardTitle>
                                <CardDescription>Comprehensive notes from this lesson</CardDescription>
                              </div>
                              {!editingField && isAdmin && (
                                <button
                                  onClick={() => { handleStartEdit("content"); }}
                                  className="p-2 hover:bg-gray-100 rounded-sm transition-colors border border-gray-300 bg-white shadow-sm"
                                  title="Edit notes">
                                  <Edit className="w-4 h-4 text-[#1a365d]" />
                                </button>
                              )}
                            </div>
                          </CardHeader>
                          <CardContent>
                            {editingField === "content" ? (
                              <div className="space-y-2">
                                <Textarea
                                  value={(editValues.content as string) || ""}
                                  onChange={(e) => handleValueChange("content", e.target.value)}
                                  placeholder="Enter lesson notes (LaTeX supported: use $ for inline math, $$ for display math)"
                                  className="min-h-[400px] font-mono text-sm" autoFocus
                                />
                                <div className="flex gap-2 justify-end">
                                  <Button size="sm" onClick={() => handleSaveField("content")} disabled={saving}
                                    className="rounded-sm bg-green-600 hover:bg-green-700">
                                    {saving ? <Loader2 className="w-4 h-4 animate-spin" /> : <Save className="w-4 h-4" />}
                                  </Button>
                                  <Button size="sm" onClick={handleCancelEdit} disabled={saving}
                                    variant="outline" className="rounded-sm">
                                    <X className="w-4 h-4" />
                                  </Button>
                                </div>
                              </div>
                            ) : lesson.content ? (
                              <div className="prose prose-sm max-w-none leading-relaxed">
                                {renderMixedContent(lesson.content)}
                              </div>
                            ) : (
                              <div className="text-center py-8 text-muted-foreground relative">
                                <FileText className="w-12 h-12 mx-auto mb-3 opacity-30" />
                                <p>No notes available for this lesson yet.</p>
                                {isAdmin && (
                                  <Button size="sm" onClick={() => handleStartEdit("content")}
                                    className="mt-4 rounded-sm" variant="outline">
                                    <Edit className="w-4 h-4 mr-2" />Add Notes
                                  </Button>
                                )}
                              </div>
                            )}
                          </CardContent>
                        </Card>
                      </TabsContent>
                    )}

                    {/* AI Tutor */}
                    <TabsContent value="ai-tutor" className="space-y-4 mt-6">
                      <ChatInterface lessonTitle={lesson.title} {...aiTutor} />
                    </TabsContent>
                  </Tabs>
                );
              })()}
            </TabsContent>
          )}

          {/* Quiz Tab */}
          {hasQuiz && (
            <TabsContent value="quiz" className="mt-6 space-y-4">
              {lesson.quiz_id ? (
                <QuizPlayer quizId={lesson.quiz_id} />
              ) : (
                <Card>
                  <CardHeader>
                    <CardTitle>Quiz</CardTitle>
                    <CardDescription>Test your understanding with this quiz</CardDescription>
                  </CardHeader>
                  <CardContent>
                    <p className="text-muted-foreground text-center py-8">
                      No quiz available for this lesson yet.
                    </p>
                  </CardContent>
                </Card>
              )}
            </TabsContent>
          )}
        </Tabs>
      ) : (
        <Card>
          <CardContent className="text-center py-8 text-muted-foreground">
            <p>No lesson content available yet.</p>
          </CardContent>
        </Card>
      )}

      {/* Feedback section */}
      <div className="mt-6 md:mt-8 mb-6">
        <Card className="rounded-sm border-2 border-dashed border-gray-300 bg-gray-50/50">
          <CardContent className="p-4">
            <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3">
              <div className="flex items-center space-x-3">
                <div className="p-2 bg-[#1a365d]/10 rounded-sm flex-shrink-0">
                  <AlertCircle className="w-5 h-5 text-[#1a365d]" />
                </div>
                <div>
                  <h4 className="font-semibold text-[#1e293b] text-sm md:text-base">Found an issue?</h4>
                  <p className="text-xs md:text-sm text-muted-foreground">
                    Help us improve by reporting mistakes or suggesting changes
                  </p>
                </div>
              </div>
              <Button
                variant="outline"
                className="rounded-sm border-[#1a365d] text-[#1a365d] hover:bg-[#1a365d]/5 w-full sm:w-auto text-sm"
                onClick={feedback.openFeedbackModal}
              >
                <Flag className="w-4 h-4 mr-2" />
                Report Issue
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Navigation */}
      {onNavigateLesson && (
        <LessonNavigation
          lesson={lesson}
          allLessons={allLessons}
          onNavigateLesson={onNavigateLesson}
        />
      )}

      {/* Feedback Modal */}
      <FeedbackModal
        lessonTitle={lesson.title}
        courseSlug={courseSlug}
        {...feedback}
      />
    </div>
  );
}

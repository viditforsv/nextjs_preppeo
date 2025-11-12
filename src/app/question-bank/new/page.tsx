"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/app/components-demo/ui/ui-components/button";
import { Input } from "@/app/components-demo/ui/ui-components/input";
import { Textarea } from "@/app/components-demo/ui/textarea";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/app/components-demo/ui/ui-components/card";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/app/components-demo/ui/select";
import { ArrowLeft, Save, Plus, Trash2, FileQuestion, CheckSquare, HelpCircle, Type } from "lucide-react";
import { Label } from "@/app/components-demo/ui/ui-components/label";
import { Switch } from "@/app/components-demo/ui/switch";
import ImageUpload from "@/components/ImageUpload";

interface QuestionForm {
  question_number: string;
  question_text: string;
  total_marks: number;
  difficulty: number;
  tags: string[];
  subject: string;
  boards: string[]; // Changed from board (text) to boards (jsonb array)
  course_types: string[]; // jsonb array
  levels: string[]; // jsonb array
  grade: string;
  topic: string;
  subtopic: string;
  question_type: string;
  is_pyq: boolean;
  pyq_year: number;
  month: string;
  paper_number: number;
  "Time Zone": string;
  explanation: string;
  correct_answer: string;
  calculator: string;
  solution_steps: string[];
  solution_image: string;
  image_url: string;
  mark_allocation: Record<string, unknown> | null;
  options: Record<string, unknown>[];
  source: string;
  paper_type: string;
  year: number;
}

export default function NewQuestionPage() {
  const router = useRouter();
  const [saving, setSaving] = useState(false);
  const [step, setStep] = useState<"select-type" | "create">("select-type");
  const [formData, setFormData] = useState<QuestionForm>({
    question_number: "",
    question_text: "",
    total_marks: 1,
    difficulty: 5,
    tags: [],
    subject: "IBDP Mathematics AA HL",
    boards: ["IBDP"], // Changed to array
    course_types: ["AA"], // Added
    levels: ["Grade 12"], // Added
    grade: "12",
    topic: "",
    subtopic: "",
    question_type: "subjective",
    is_pyq: false,
    pyq_year: new Date().getFullYear(),
    month: "",
    paper_number: 1,
    "Time Zone": "",
    explanation: "",
    correct_answer: "",
    calculator: "",
    solution_steps: [],
    solution_image: "",
    image_url: "",
    mark_allocation: null,
    options: [],
    source: "IBDP",
    paper_type: "",
    year: new Date().getFullYear(),
  });

  const [saveError, setSaveError] = useState<string | null>(null);

  const handleSave = async () => {
    setSaving(true);
    setSaveError(null);

    try {
      const response = await fetch("/api/question-bank", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      if (response.ok) {
        const newQuestion = await response.json();
        router.push(`/question-bank/${newQuestion.id}`);
      } else {
        const errorData = await response.json();
        const errorMessage = errorData.error || errorData.message || "Failed to create question";
        console.error("API Error:", errorMessage, errorData);
        setSaveError(errorMessage);
        alert(`Error: ${errorMessage}`);
      }
    } catch (error) {
      console.error("Error creating question:", error);
      setSaveError(error instanceof Error ? error.message : "Unknown error occurred");
      alert("Error creating question. Check console for details.");
    } finally {
      setSaving(false);
    }
  };

  const handleInputChange = (
    field: keyof QuestionForm,
    value:
      | string
      | number
      | boolean
      | string[]
      | Record<string, unknown>[]
      | Record<string, unknown>
      | null
  ) => {
    setFormData((prev) => ({ ...prev, [field]: value }));
  };

  const handleTagsChange = (value: string) => {
    const tags = value
      .split(",")
      .map((tag) => tag.trim())
      .filter((tag) => tag);
    setFormData((prev) => ({ ...prev, tags }));
  };

  // MCQ Options Management
  const addOption = () => {
    const newOption = {
      value: String.fromCharCode(65 + formData.options.length), // A, B, C, D...
      label: "",
    };
    setFormData((prev) => ({
      ...prev,
      options: [...prev.options, newOption],
    }));
  };

  const removeOption = (index: number) => {
    setFormData((prev) => ({
      ...prev,
      options: prev.options.filter((_, i) => i !== index),
    }));
  };

  const updateOption = (index: number, field: string, value: string) => {
    setFormData((prev) => ({
      ...prev,
      options: prev.options.map((opt, i) =>
        i === index ? { ...opt, [field]: value } : opt
      ),
    }));
  };

  const questionTypes = [
    {
      value: "mcq",
      label: "Multiple Choice Question",
      icon: CheckSquare,
      description: "Question with multiple options where one is correct",
      color: "from-blue-500 to-blue-600",
    },
    {
      value: "subjective",
      label: "Subjective Question",
      icon: FileQuestion,
      description: "Open-ended question requiring detailed written answer",
      color: "from-purple-500 to-purple-600",
    },
    {
      value: "true_false",
      label: "True or False",
      icon: HelpCircle,
      description: "Binary choice question with True or False answers",
      color: "from-green-500 to-green-600",
    },
    {
      value: "fill_blank",
      label: "Fill in the Blank",
      icon: Type,
      description: "Question with missing word or phrase to be filled",
      color: "from-amber-500 to-amber-600",
    },
  ];

  const handleSelectType = (type: string) => {
    setFormData((prev) => ({ ...prev, question_type: type }));
    setStep("create");
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-white via-green-50 to-emerald-50">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8">
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center space-x-4">
              <Button
                variant="outline"
                onClick={() => {
                  if (step === "create") {
                    setStep("select-type");
                  } else {
                    router.push("/question-bank");
                  }
                }}
              >
                <ArrowLeft className="w-4 h-4 mr-2" />
                Back
              </Button>
              <div>
                <h1 className="text-3xl font-bold text-foreground">
                  {step === "select-type" ? "Select Question Type" : "Create New Question"}
                </h1>
                <p className="text-muted-foreground mt-1">
                  {step === "select-type"
                    ? "Choose the type of question you want to create"
                    : `Creating a ${questionTypes.find(t => t.value === formData.question_type)?.label}`}
                </p>
              </div>
            </div>

            {step === "create" && (
              <Button onClick={handleSave} disabled={saving} className="bg-primary hover:bg-primary/90">
                <Save className="w-4 h-4 mr-2" />
                {saving ? "Creating..." : "Create Question"}
              </Button>
            )}
          </div>

          {/* Breadcrumbs */}
          <nav className="flex items-center space-x-2 text-sm text-muted-foreground">
            <span>Dashboard</span>
            <span>/</span>
            <button
              onClick={() => router.push("/question-bank")}
              className="hover:text-foreground"
            >
              Question Bank
            </button>
            <span>/</span>
            <span className="text-foreground font-medium">New Question</span>
          </nav>
        </div>

        {/* Error Display */}
        {saveError && (
          <div className="mb-6 p-4 bg-red-50 border-l-4 border-red-500 rounded-lg">
            <p className="text-red-700 font-medium">Error: {saveError}</p>
            <button
              onClick={() => setSaveError(null)}
              className="text-red-600 hover:text-red-800 text-sm mt-2"
            >
              Dismiss
            </button>
          </div>
        )}

        {/* Step 1: Select Question Type */}
        {step === "select-type" && (
          <div className="max-w-5xl mx-auto">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {questionTypes.map((type) => (
                <Card
                  key={type.value}
                  className="cursor-pointer hover:shadow-xl transition-all duration-300 hover:-translate-y-1 border-0 bg-white/80 backdrop-blur-sm overflow-hidden group"
                  onClick={() => handleSelectType(type.value)}
                >
                  <CardContent className="p-8">
                    <div className="flex flex-col items-center text-center">
                      <div className={`w-20 h-20 bg-gradient-to-br ${type.color} rounded-2xl flex items-center justify-center mb-6 shadow-lg group-hover:scale-110 transition-transform`}>
                        <type.icon className="w-10 h-10 text-white" />
                      </div>
                      <h3 className="text-xl font-bold text-foreground mb-3">
                        {type.label}
                      </h3>
                      <p className="text-muted-foreground text-sm">
                        {type.description}
                      </p>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          </div>
        )}

        {/* Step 2: Create Question Form */}
        {step === "create" && (

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Main Content */}
        <div className="lg:col-span-2 space-y-6">
          {/* Question Text */}
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                {questionTypes.find(t => t.value === formData.question_type)?.icon && (
                  <div className={`w-8 h-8 bg-gradient-to-br ${questionTypes.find(t => t.value === formData.question_type)?.color} rounded-lg flex items-center justify-center`}>
                    {(() => {
                      const Icon = questionTypes.find(t => t.value === formData.question_type)?.icon;
                      return Icon ? <Icon className="w-4 h-4 text-white" /> : null;
                    })()}
                  </div>
                )}
                Question Content
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <Label htmlFor="question_text">
                  Question Text * 
                  {formData.question_type === "fill_blank" && (
                    <span className="text-xs text-muted-foreground ml-2">
                      (Use _____ to indicate blanks)
                    </span>
                  )}
                </Label>
                <Textarea
                  id="question_text"
                  value={formData.question_text}
                  onChange={(e) =>
                    handleInputChange("question_text", e.target.value)
                  }
                  className="min-h-[200px]"
                  placeholder={
                    formData.question_type === "mcq"
                      ? "Enter the question stem (e.g., What is the value of x in the equation $2x + 5 = 15$?)"
                      : formData.question_type === "true_false"
                      ? "Enter a statement (e.g., The sum of angles in a triangle is 180°)"
                      : formData.question_type === "fill_blank"
                      ? "Enter the question with _____ for blanks (e.g., The derivative of $x^2$ is _____)"
                      : "Enter the question text with LaTeX math notation..."
                  }
                />
              </div>

              <div>
                <Label htmlFor="explanation">Solution/Explanation</Label>
                <Textarea
                  id="explanation"
                  value={formData.explanation}
                  onChange={(e) =>
                    handleInputChange("explanation", e.target.value)
                  }
                  className="min-h-[150px]"
                  placeholder="Enter the solution or explanation..."
                />
              </div>

              <div>
                <Label htmlFor="correct_answer">
                  Correct Answer *
                  {formData.question_type === "mcq" && (
                    <span className="text-xs text-muted-foreground ml-2">
                      (Enter the option value that is correct)
                    </span>
                  )}
                </Label>
                <Input
                  id="correct_answer"
                  value={formData.correct_answer}
                  onChange={(e) =>
                    handleInputChange("correct_answer", e.target.value)
                  }
                  placeholder={
                    formData.question_type === "mcq"
                      ? "e.g., A or B or C"
                      : formData.question_type === "true_false"
                      ? "True or False"
                      : formData.question_type === "fill_blank"
                      ? "e.g., 2x"
                      : "Enter the correct answer..."
                  }
                />
              </div>
            </CardContent>
          </Card>

          {/* MCQ Options - Only show for MCQ type */}
          {formData.question_type === "mcq" && (
            <Card className="border-2 border-blue-200 bg-blue-50/30">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="flex items-center gap-2">
                    <CheckSquare className="w-5 h-5 text-blue-600" />
                    MCQ Options
                  </CardTitle>
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={addOption}
                    className="border-blue-300 text-blue-700 hover:bg-blue-100"
                  >
                    <Plus className="w-4 h-4 mr-2" />
                    Add Option
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-4">
                {formData.options.length === 0 ? (
                  <div className="text-center py-8 bg-white rounded-lg border-2 border-dashed border-blue-200">
                    <CheckSquare className="w-12 h-12 mx-auto mb-4 text-blue-400" />
                    <p className="text-muted-foreground mb-4">No options added yet</p>
                    <Button onClick={addOption} className="bg-blue-600 hover:bg-blue-700">
                      <Plus className="w-4 h-4 mr-2" />
                      Add First Option
                    </Button>
                  </div>
                ) : (
                  <div className="space-y-3">
                    {formData.options.map((option: any, index) => (
                      <div
                        key={index}
                        className="flex gap-2 items-start p-4 bg-white border-2 border-blue-100 rounded-lg hover:border-blue-300 transition-colors"
                      >
                        <div className="flex-1 space-y-3">
                          <div className="grid grid-cols-4 gap-2">
                            <div className="col-span-1">
                              <Label className="text-xs font-semibold">Value</Label>
                              <Input
                                value={option.value || ""}
                                onChange={(e) =>
                                  updateOption(index, "value", e.target.value)
                                }
                                placeholder="A"
                                className="h-9 font-bold text-center"
                              />
                            </div>
                            <div className="col-span-3">
                              <Label className="text-xs font-semibold">Option Text (LaTeX supported)</Label>
                              <Textarea
                                value={option.label || ""}
                                onChange={(e) =>
                                  updateOption(index, "label", e.target.value)
                                }
                                placeholder="e.g., $x = 5$ or Option text here"
                                className="min-h-[60px] resize-none"
                              />
                            </div>
                          </div>
                        </div>
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => removeOption(index)}
                          className="text-red-600 hover:text-red-700 hover:bg-red-50"
                        >
                          <Trash2 className="w-4 h-4" />
                        </Button>
                      </div>
                    ))}
                  </div>
                )}
                <div className="bg-blue-50 border border-blue-200 rounded-lg p-3">
                  <p className="text-xs text-blue-800 font-medium">
                    💡 Tip: After adding all options, set the "Correct Answer" field above to the value of the correct option (e.g., if Option A is correct, enter "A")
                  </p>
                </div>
              </CardContent>
            </Card>
          )}

          {/* True/False Helper - Only show for True/False type */}
          {formData.question_type === "true_false" && (
            <Card className="border-2 border-green-200 bg-green-50/30">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <HelpCircle className="w-5 h-5 text-green-600" />
                  True/False Question
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="bg-green-50 border border-green-200 rounded-lg p-4">
                  <p className="text-sm text-green-800 mb-3">
                    <strong>Instructions:</strong>
                  </p>
                  <ul className="text-xs text-green-700 space-y-1 ml-4 list-disc">
                    <li>Write a clear statement in the Question Text field</li>
                    <li>Enter "True" or "False" in the Correct Answer field</li>
                    <li>No need to add options - they are automatically "True" and "False"</li>
                  </ul>
                </div>
              </CardContent>
            </Card>
          )}

          {/* Fill in the Blank Helper - Only show for Fill Blank type */}
          {formData.question_type === "fill_blank" && (
            <Card className="border-2 border-amber-200 bg-amber-50/30">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Type className="w-5 h-5 text-amber-600" />
                  Fill in the Blank Question
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="bg-amber-50 border border-amber-200 rounded-lg p-4">
                  <p className="text-sm text-amber-800 mb-3">
                    <strong>Instructions:</strong>
                  </p>
                  <ul className="text-xs text-amber-700 space-y-1 ml-4 list-disc">
                    <li>Use underscores (_____ ) in the Question Text to indicate blanks</li>
                    <li>Example: "The derivative of $x^2$ is _____"</li>
                    <li>Enter the correct answer in the Correct Answer field (e.g., "2x")</li>
                  </ul>
                </div>
              </CardContent>
            </Card>
          )}

          {/* Subjective Helper - Only show for Subjective type */}
          {formData.question_type === "subjective" && (
            <Card className="border-2 border-purple-200 bg-purple-50/30">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <FileQuestion className="w-5 h-5 text-purple-600" />
                  Subjective Question
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="bg-purple-50 border border-purple-200 rounded-lg p-4">
                  <p className="text-sm text-purple-800 mb-3">
                    <strong>Instructions:</strong>
                  </p>
                  <ul className="text-xs text-purple-700 space-y-1 ml-4 list-disc">
                    <li>Write your question with clear instructions</li>
                    <li>Can include multiple parts (a, b, c) for complex questions</li>
                    <li>LaTeX math notation is supported ($...$ for inline, $$...$$ for block)</li>
                    <li>Correct Answer is optional (for reference/grading rubric)</li>
                  </ul>
                </div>
              </CardContent>
            </Card>
          )}
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Question Details */}
          <Card>
            <CardHeader>
              <CardTitle>Question Details</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <Label htmlFor="question_number">Question Number</Label>
                <Input
                  id="question_number"
                  value={formData.question_number}
                  onChange={(e) =>
                    handleInputChange("question_number", e.target.value)
                  }
                  placeholder="e.g., 1, 2a, 3b"
                />
              </div>

              <div>
                <Label htmlFor="total_marks">Total Marks</Label>
                <Input
                  id="total_marks"
                  type="number"
                  min="1"
                  value={formData.total_marks}
                  onChange={(e) =>
                    handleInputChange("total_marks", parseInt(e.target.value))
                  }
                />
              </div>

              <div>
                <Label htmlFor="difficulty">Difficulty (1-10)</Label>
                <Input
                  id="difficulty"
                  type="number"
                  min="1"
                  max="10"
                  value={formData.difficulty}
                  onChange={(e) =>
                    handleInputChange("difficulty", parseInt(e.target.value))
                  }
                />
              </div>

              <div>
                <Label>Question Type</Label>
                <div className="flex items-center gap-2 p-3 bg-gray-50 rounded-lg border">
                  {(() => {
                    const selectedType = questionTypes.find(t => t.value === formData.question_type);
                    const Icon = selectedType?.icon;
                    return (
                      <>
                        {Icon && <Icon className="w-4 h-4 text-primary" />}
                        <span className="font-medium">{selectedType?.label}</span>
                      </>
                    );
                  })()}
                </div>
                <p className="text-xs text-muted-foreground mt-1">
                  Selected in step 1. Go back to change.
                </p>
              </div>

              <div>
                <Label htmlFor="boards">Boards (comma-separated)</Label>
                <Input
                  id="boards"
                  value={formData.boards.join(", ")}
                  onChange={(e) => {
                    const boards = e.target.value
                      .split(",")
                      .map((b) => b.trim())
                      .filter((b) => b);
                    handleInputChange("boards", boards);
                  }}
                  placeholder="e.g., CBSE, IBDP, ICSE"
                />
              </div>

              <div>
                <Label htmlFor="course_types">Course Types (comma-separated)</Label>
                <Input
                  id="course_types"
                  value={formData.course_types.join(", ")}
                  onChange={(e) => {
                    const types = e.target.value
                      .split(",")
                      .map((t) => t.trim())
                      .filter((t) => t);
                    handleInputChange("course_types", types);
                  }}
                  placeholder="e.g., AA, HL, SL"
                />
              </div>

              <div>
                <Label htmlFor="levels">Levels (comma-separated)</Label>
                <Input
                  id="levels"
                  value={formData.levels.join(", ")}
                  onChange={(e) => {
                    const levels = e.target.value
                      .split(",")
                      .map((l) => l.trim())
                      .filter((l) => l);
                    handleInputChange("levels", levels);
                  }}
                  placeholder="e.g., Grade 9, Grade 10, Grade 11"
                />
              </div>

              <div>
                <Label htmlFor="topic">Topic</Label>
                <Input
                  id="topic"
                  value={formData.topic}
                  onChange={(e) => handleInputChange("topic", e.target.value)}
                  placeholder="e.g., Calculus, Algebra"
                />
              </div>

              <div>
                <Label htmlFor="subtopic">Subtopic</Label>
                <Input
                  id="subtopic"
                  value={formData.subtopic}
                  onChange={(e) =>
                    handleInputChange("subtopic", e.target.value)
                  }
                  placeholder="e.g., Derivatives, Integration"
                />
              </div>

              <div>
                <Label htmlFor="tags">Tags (comma-separated)</Label>
                <Input
                  id="tags"
                  value={formData.tags.join(", ")}
                  onChange={(e) => handleTagsChange(e.target.value)}
                  placeholder="e.g., calculus, derivatives, limits"
                />
              </div>
            </CardContent>
          </Card>

          {/* Past Year Question Settings */}
          <Card>
            <CardHeader>
              <CardTitle>Past Year Question Settings</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-center space-x-2">
                <Switch
                  id="is_pyq"
                  checked={formData.is_pyq}
                  onCheckedChange={(checked) =>
                    handleInputChange("is_pyq", checked)
                  }
                />
                <Label htmlFor="is_pyq">This is a Past Year Question</Label>
              </div>

              {formData.is_pyq && (
                <>
                  <div>
                    <Label htmlFor="pyq_year">PYQ Year</Label>
                    <Input
                      id="pyq_year"
                      type="number"
                      value={formData.pyq_year}
                      onChange={(e) =>
                        handleInputChange("pyq_year", parseInt(e.target.value))
                      }
                    />
                  </div>

                  <div>
                    <Label htmlFor="month">Month</Label>
                    <Select
                      value={formData.month}
                      onValueChange={(value) =>
                        handleInputChange("month", value)
                      }
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Select month" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="May">May</SelectItem>
                        <SelectItem value="Nov">November</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>

                  <div>
                    <Label htmlFor="paper_number">Paper Number</Label>
                    <Select
                      value={formData.paper_number.toString()}
                      onValueChange={(value) =>
                        handleInputChange("paper_number", parseInt(value))
                      }
                    >
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="1">Paper 1</SelectItem>
                        <SelectItem value="2">Paper 2</SelectItem>
                        <SelectItem value="3">Paper 3</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>

                  <div>
                    <Label htmlFor="time_zone">Time Zone</Label>
                    <Select
                      value={formData["Time Zone"]}
                      onValueChange={(value) =>
                        handleInputChange("Time Zone", value)
                      }
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Select time zone" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="TZ0">TZ0</SelectItem>
                        <SelectItem value="TZ1">TZ1</SelectItem>
                        <SelectItem value="TZ2">TZ2</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </>
              )}
            </CardContent>
          </Card>

          {/* Additional Settings */}
          <Card>
            <CardHeader>
              <CardTitle>Additional Settings</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <Label htmlFor="calculator">Calculator Policy</Label>
                <Select
                  value={formData.calculator}
                  onValueChange={(value) =>
                    handleInputChange("calculator", value)
                  }
                >
                  <SelectTrigger>
                    <SelectValue placeholder="Select calculator policy" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Calculator Allowed">
                      Calculator Allowed
                    </SelectItem>
                    <SelectItem value="Calculator Not Allowed">
                      Calculator Not Allowed
                    </SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <ImageUpload
                label="Question Image"
                value={formData.image_url}
                onChange={(url) => handleInputChange("image_url", url)}
                placeholder="Upload an image for the question"
              />

              <ImageUpload
                label="Solution Image"
                value={formData.solution_image}
                onChange={(url) => handleInputChange("solution_image", url)}
                placeholder="Upload an image for the solution"
              />
            </CardContent>
          </Card>
        </div>
      </div>
        )}
      </div>
    </div>
  );
}

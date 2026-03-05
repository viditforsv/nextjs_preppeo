import type { InteractiveQuizItem } from "./InteractiveLessonView";

export const DIFF = {
  Easy: { text: "#15803d", bg: "#f0fdf4", border: "#86efac" },
  Medium: { text: "#b45309", bg: "#fffbeb", border: "#fcd34d" },
  Hard: { text: "#dc2626", bg: "#fef2f2", border: "#fca5a5" },
} as const;
export type DiffKey = keyof typeof DIFF;

export function renderSimpleMd(text: string) {
  return text
    .replace(/\*\*(.+?)\*\*/g, "<strong>$1</strong>")
    .replace(/\n/g, "<br/>");
}

export function optionLabel(index: number) {
  return String.fromCharCode(65 + index);
}

export function cleanOptionText(opt: string) {
  return /^[A-D]\)\s*/.test(opt) ? opt.replace(/^[A-D]\)\s*/, "") : opt;
}

export function getHintText(explanation: string) {
  const match = explanation.match(/^[^.!?]+[.!?]/);
  return match ? match[0].trim() : explanation;
}

export function formatOptionsText(q: InteractiveQuizItem) {
  const opts = q.options?.length ? q.options : [];
  return opts.map((o, i) => `${optionLabel(i)}) ${cleanOptionText(o)}`).join(", ");
}

export function buildAskAIMessage(q: InteractiveQuizItem) {
  return `Walk me through this SAT question:\n"${q.question}"\nOptions: ${formatOptionsText(q)}`;
}

export function buildAskAIStepByStep(q: InteractiveQuizItem) {
  return `Can you walk me through this problem step by step?\n\n"${q.question}"\n\nOptions: ${formatOptionsText(q)}`;
}

export function buildRecapMessage(
  lessonTitle: string,
  quiz: InteractiveQuizItem[],
  submittedQuestions: Record<number, boolean>,
  skippedQuestions: Record<number, boolean>,
  scoreCorrect: number,
) {
  const summary = quiz
    .map((qq, qi) => {
      const correct = submittedQuestions[qi] === true;
      const skipped = !!skippedQuestions[qi];
      return `Q${qi + 1}: ${correct ? "✓" : skipped ? "–" : "✗"} ${qq.question}`;
    })
    .join("\n");
  return `I just finished the practice questions for "${lessonTitle}". Score: ${scoreCorrect}/${quiz.length}. Can you give me a quick recap of the key concepts?\n\n${summary}`;
}

export type OptionVisualState = "default" | "selected" | "correct" | "wrong" | "dimmed";

export function getOptionVisualState(params: {
  optionIndex: number;
  selectedIndex: number | undefined;
  correctIndex: number;
  isSubmitted: boolean;
}): OptionVisualState {
  const { optionIndex, selectedIndex, correctIndex, isSubmitted } = params;
  if (!isSubmitted && selectedIndex === optionIndex) return "selected";
  if (isSubmitted && optionIndex === correctIndex) return "correct";
  if (isSubmitted && optionIndex === selectedIndex && optionIndex !== correctIndex) return "wrong";
  if (isSubmitted && optionIndex !== correctIndex && optionIndex !== selectedIndex) return "dimmed";
  return "default";
}

const OPTION_STYLES: Record<OptionVisualState, { row: string; letter: string; text: string }> = {
  default: {
    row: "bg-white border-[#e0ddd6] shadow-[0_0_0_transparent]",
    letter: "bg-[#f5f4f1] text-[#6b6966] border-[#e0ddd6]",
    text: "text-[#2c2a28] font-medium",
  },
  selected: {
    row: "bg-[#fffbf0] border-[#f59207] shadow-[0_0_0_3px_rgba(245,146,7,0.08)]",
    letter: "bg-[#f59207] text-white border-[#f59207]",
    text: "text-[#92400e] font-semibold",
  },
  correct: {
    row: "bg-[#f0fdf4] border-[#22c55e] shadow-[0_0_0_3px_rgba(34,197,94,0.09)]",
    letter: "bg-[#22c55e] text-white border-[#22c55e]",
    text: "text-[#15803d] font-semibold",
  },
  wrong: {
    row: "bg-[#fef2f2] border-[#ef4444] shadow-[0_0_0_3px_rgba(239,68,68,0.09)]",
    letter: "bg-[#ef4444] text-white border-[#ef4444]",
    text: "text-[#dc2626] font-semibold",
  },
  dimmed: {
    row: "bg-white border-[#e0ddd6] shadow-[0_0_0_transparent] opacity-45",
    letter: "bg-[#f5f4f1] text-[#6b6966] border-[#e0ddd6]",
    text: "text-[#2c2a28] font-medium",
  },
};

export function getOptionClasses(state: OptionVisualState) {
  return OPTION_STYLES[state];
}

export function resetQuestionState(
  index: number,
  setters: {
    setSubmittedQuestions: React.Dispatch<React.SetStateAction<Record<number, boolean>>>;
    setSkippedQuestions: React.Dispatch<React.SetStateAction<Record<number, boolean>>>;
    setSelectedOptions: React.Dispatch<React.SetStateAction<Record<number, number>>>;
    setRevealedExplanations: React.Dispatch<React.SetStateAction<Record<number, boolean>>>;
    setRevealedHints: React.Dispatch<React.SetStateAction<Record<number, boolean>>>;
  },
) {
  const deleteKey = <T,>(prev: Record<number, T>) => {
    const next = { ...prev };
    delete next[index];
    return next;
  };
  setters.setSubmittedQuestions(deleteKey);
  setters.setSkippedQuestions(deleteKey);
  setters.setSelectedOptions(deleteKey);
  setters.setRevealedExplanations(deleteKey);
  setters.setRevealedHints(deleteKey);
}

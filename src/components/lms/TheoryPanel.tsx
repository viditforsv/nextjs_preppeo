"use client";

import { useState, useEffect, useMemo } from "react";
import { ChevronRight, Lightbulb, ListChecks, Calculator } from "lucide-react";
import { VideoResource } from "@/design-system/components/youtube-video";
import type { InteractiveStep } from "./InteractiveLessonView";
import { renderSimpleMd } from "./practiceHelpers";

type TheoryTab = "concept" | "method" | "example";

interface TheoryPanelProps {
  lessonId: string;
  lessonTitle: string;
  conceptTitle: string;
  conceptHtml: string;
  steps: InteractiveStep[];
  formulaTitle?: string | null;
  formulaContent?: string | null;
  videoUrl?: string | null;
  isInteractive: boolean;
  hasQuiz: boolean;
  onSwitchToQuestions: () => void;
}

const TAB_META: Record<TheoryTab, { icon: React.ReactNode; label: string; accent: string; activeClasses: string; inactiveClasses: string }> = {
  concept: {
    icon: <Lightbulb className="h-3.5 w-3.5" />,
    label: "Concept",
    accent: "border-[#6366f1]",
    activeClasses: "border-b-2 border-[#6366f1] text-[#4338ca]",
    inactiveClasses: "text-[#8b8880] hover:text-[#4338ca] hover:bg-[#f5f4ff]",
  },
  method: {
    icon: <ListChecks className="h-3.5 w-3.5" />,
    label: "Method",
    accent: "border-[#f59207]",
    activeClasses: "border-b-2 border-[#f59207] text-[#b45309]",
    inactiveClasses: "text-[#8b8880] hover:text-[#b45309] hover:bg-[#fffbf0]",
  },
  example: {
    icon: <Calculator className="h-3.5 w-3.5" />,
    label: "Worked Example",
    accent: "border-[#d97706]",
    activeClasses: "border-b-2 border-[#d97706] text-[#92400e]",
    inactiveClasses: "text-[#8b8880] hover:text-[#92400e] hover:bg-[#fffbeb]",
  },
};

export function TheoryPanel({
  lessonId,
  lessonTitle,
  conceptTitle,
  conceptHtml,
  steps,
  formulaTitle,
  formulaContent,
  videoUrl,
  isInteractive,
  hasQuiz,
  onSwitchToQuestions,
}: TheoryPanelProps) {
  const [stepsDone, setStepsDone] = useState<Record<number, boolean>>({});

  const hasConcept = !!conceptHtml;
  const hasMethod = steps.length > 0;
  const hasExample = !!(formulaTitle || formulaContent);

  const availableTabs = useMemo<TheoryTab[]>(
    () => [
      ...(hasConcept ? ["concept" as const] : []),
      ...(hasMethod ? ["method" as const] : []),
      ...(hasExample ? ["example" as const] : []),
    ],
    [hasConcept, hasMethod, hasExample],
  );

  const [activeTab, setActiveTab] = useState<TheoryTab>(availableTabs[0] ?? "concept");

  useEffect(() => {
    setStepsDone({});
    setActiveTab(availableTabs[0] ?? "concept");
  }, [lessonId, availableTabs]);

  const hasContent = hasConcept || hasMethod || hasExample || videoUrl;
  const allStepsDone = hasMethod && steps.every((_, i) => stepsDone[i]);
  const showTabs = availableTabs.length > 1;

  return (
    <div className="flex flex-col gap-4">
      {/* Title */}
      <h1 className="text-xl font-extrabold text-[#1a1a2e] tracking-tight">{conceptTitle}</h1>

      {/* Sub-tabs — only when there are 2+ sections */}
      {showTabs && (
        <div className="flex gap-1 border-b border-[#eae8e2]">
          {availableTabs.map((tab) => {
            const meta = TAB_META[tab];
            const isActive = activeTab === tab;
            return (
              <button
                key={tab}
                type="button"
                onClick={() => setActiveTab(tab)}
                className={`inline-flex items-center gap-1.5 px-4 py-2.5 text-xs font-semibold transition-colors ${
                  isActive ? meta.activeClasses : meta.inactiveClasses
                }`}
              >
                {meta.icon}
                {meta.label}
                {tab === "method" && allStepsDone && (
                  <span className="ml-1 text-[10px] text-[#15803d]">✓</span>
                )}
              </button>
            );
          })}
        </div>
      )}

      {/* ── Concept ── */}
      {activeTab === "concept" && hasConcept && (
        <div className="rounded-xl border border-[#ddd8f3] bg-white shadow-sm overflow-hidden">
          <div className="border-l-[3px] border-[#6366f1] px-5 py-5">
            <div
              className="text-[14px] leading-[1.75] text-[#3a3840] [&_strong]:text-[#1a1a2e] [&_strong]:font-semibold"
              dangerouslySetInnerHTML={{ __html: renderSimpleMd(conceptHtml) }}
            />
          </div>
        </div>
      )}

      {/* ── Method ── */}
      {activeTab === "method" && hasMethod && (
        <div className="rounded-xl border border-[#fde9b8] bg-white shadow-sm overflow-hidden">
          <div className="border-l-[3px] border-[#f59207] px-5 py-5">
            {allStepsDone && (
              <p className="mb-3 text-[11px] font-bold text-[#15803d]">All steps done ✓</p>
            )}
            <div className="flex flex-col gap-2.5">
              {steps.map((s, i) => (
                <div
                  key={i}
                  className={`flex items-start gap-3 rounded-lg border p-3.5 transition-all duration-200 ${
                    stepsDone[i]
                      ? "border-[#86efac] bg-[#f0fdf4]"
                      : "border-[#f0ede6] bg-[#fdfcfa] hover:border-[#fde9b8] hover:shadow-[0_1px_4px_rgba(0,0,0,0.04)]"
                  }`}
                >
                  <div
                    className={`flex h-7 w-7 shrink-0 items-center justify-center rounded-full text-xs font-extrabold text-white transition-colors ${
                      stepsDone[i] ? "bg-[#22c55e]" : "bg-[#f59207]"
                    }`}
                  >
                    {stepsDone[i] ? "✓" : i + 1}
                  </div>
                  <div className="flex-1 min-w-0">
                    <h4 className="text-[13px] font-bold text-[#1a1a2e] mb-0.5">{s.title}</h4>
                    <p className="text-[12px] leading-relaxed text-[#6b6870]">{s.content}</p>
                    {s.equation && (
                      <code className="mt-1.5 inline-block rounded-md bg-[#f5f4f1] border border-[#eae8e2] px-2 py-1 text-[11.5px] font-mono text-[#4338ca]">
                        {s.equation}
                      </code>
                    )}
                  </div>
                  <button
                    type="button"
                    onClick={() => setStepsDone((d) => ({ ...d, [i]: !d[i] }))}
                    className={`shrink-0 rounded-md border px-2.5 py-1 text-[10px] font-semibold transition-colors ${
                      stepsDone[i]
                        ? "border-[#86efac] bg-[#f0fdf4] text-[#15803d] hover:border-[#e0ddd6] hover:bg-white hover:text-[#9a9690]"
                        : "border-[#eae8e2] bg-white text-[#9a9690] hover:border-[#86efac] hover:bg-[#f0fdf4] hover:text-[#15803d]"
                    }`}
                  >
                    {stepsDone[i] ? "Undo" : "Got it ✓"}
                  </button>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* ── Worked Example ── */}
      {activeTab === "example" && hasExample && (
        <div className="rounded-xl border border-[#fcd34d] bg-white shadow-sm overflow-hidden">
          <div className="border-l-[3px] border-[#d97706] px-5 py-5">
            <div className="font-mono text-[13.5px] leading-[1.9] text-[#3a3840] whitespace-pre-wrap rounded-lg border border-[#f0ede6] bg-[#fdfcfa] p-4">
              {formulaContent}
            </div>
          </div>
        </div>
      )}

      {/* Video (always visible, not tabbed) */}
      {videoUrl && !isInteractive && (
        <div className="rounded-xl border border-[#eae8e2] bg-white shadow-sm overflow-hidden p-1">
          <VideoResource
            resource={{
              id: lessonId,
              type: "video",
              url: videoUrl,
              title: lessonTitle,
              thumbnail: undefined,
            }}
            lessonId={lessonId}
          />
        </div>
      )}

      {/* Empty state */}
      {!hasContent && (
        <div className="rounded-xl border border-dashed border-[#e0ddd6] bg-[#fdfcfa] p-8 text-center">
          <p className="text-sm text-[#8b8880]">No theory content for this lesson yet.</p>
        </div>
      )}

      {/* CTA */}
      {hasQuiz && (
        <div className="flex justify-end pt-2">
          <button
            type="button"
            onClick={onSwitchToQuestions}
            className="inline-flex items-center gap-2 rounded-xl border-2 border-[#f59207] bg-[#f59207] px-5 py-2.5 text-sm font-bold text-white shadow-sm transition-all hover:bg-[#e08a00] hover:shadow-md active:scale-[0.97]"
          >
            Ready to practice <ChevronRight className="h-4 w-4" />
          </button>
        </div>
      )}
    </div>
  );
}

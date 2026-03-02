"use client";

import { useState, useRef, useEffect } from "react";
import { Button } from "@/design-system/components/ui/button";
import { Input } from "@/design-system/components/ui/input";
import { MessageCircle, X, Send, ChevronRight } from "lucide-react";

interface ChatMessage {
  role: "user" | "assistant";
  content: string;
  timestamp: Date;
}

interface CourseChatbotProps {
  courseTitle: string;
  lessonTitle?: string;
  isOpen: boolean;
  onToggle: () => void;
  /** When true, render inline (e.g. in a side panel) with no FAB or fixed positioning. */
  embedded?: boolean;
  /** When set, send this message and then call onMessageSent. Used e.g. for "Ask AI" from practice. */
  messageToSend?: string | null;
  onMessageSent?: () => void;
  /** comm.md: show "Help with Q{N}" chip when in practice; on click parent should set messageToSend. */
  activePracticeLabel?: string;
  onAskAboutPractice?: () => void;
  /** When set, collapse the AI panel to icon strip. */
  onCollapsePanel?: () => void;
}

function renderSimpleMd(text: string) {
  return text
    .replace(/\*\*(.+?)\*\*/g, "<strong>$1</strong>")
    .replace(/`(.+?)`/g, "<code class=\"rounded bg-[#f0ede6] px-1 text-[11px]\">$1</code>")
    .replace(/^(\d+)\.\s+/gm, "<span class=\"font-semibold text-[#f59207]\">$1.</span> ")
    .replace(/^[-•]\s+/gm, "• ")
    .replace(/\n/g, "<br/>");
}

export function CourseChatbot({
  courseTitle,
  lessonTitle,
  isOpen,
  onToggle,
  embedded = false,
  messageToSend,
  onMessageSent,
  activePracticeLabel,
  onAskAboutPractice,
  onCollapsePanel,
}: CourseChatbotProps) {
  const [messages, setMessages] = useState<ChatMessage[]>([
    {
      role: "assistant",
      content: `Hi! I'm your AI tutor for "${courseTitle}". Ask me anything about this course${lessonTitle ? ` or the current lesson: ${lessonTitle}` : ""}.`,
      timestamp: new Date(),
    },
  ]);
  const [currentMessage, setCurrentMessage] = useState("");
  const [isAITyping, setIsAITyping] = useState(false);
  const messagesEndRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  const sendText = async (text: string) => {
    if (!text.trim()) return;
    const userMsg: ChatMessage = {
      role: "user",
      content: text.trim(),
      timestamp: new Date(),
    };
    setMessages((prev) => [...prev, userMsg]);
    setIsAITyping(true);
    try {
      const res = await fetch("/api/courses/chatbot", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          message: text.trim(),
          course_title: courseTitle,
          lesson_title: lessonTitle || undefined,
        }),
      });
      const data = await res.json();
      const content =
        data.response ||
        "I couldn't generate a response. Please try again.";
      setMessages((prev) => [
        ...prev,
        { role: "assistant", content, timestamp: new Date() },
      ]);
    } catch {
      setMessages((prev) => [
        ...prev,
        {
          role: "assistant",
          content: "Something went wrong. Please try again.",
          timestamp: new Date(),
        },
      ]);
    } finally {
      setIsAITyping(false);
    }
  };

  const handleSend = async () => {
    if (!currentMessage.trim()) return;
    const text = currentMessage;
    setCurrentMessage("");
    await sendText(text);
  };

  useEffect(() => {
    if (messageToSend?.trim()) {
      sendText(messageToSend).then(() => onMessageSent?.());
    }
  }, [messageToSend]);

  if (!embedded && !isOpen) {
    return (
      <Button
        onClick={onToggle}
        className="fixed bottom-6 right-6 rounded-full w-14 h-14 shadow-lg z-50 bg-primary text-primary-foreground hover:bg-primary/90"
        size="lg"
        aria-label="Open AI tutor"
      >
        <MessageCircle className="w-6 h-6" />
      </Button>
    );
  }

  const panelClass = embedded
    ? "flex-1 min-w-0 min-h-0 flex flex-col border-l border-[#eae8e2] h-full bg-[#faf9f6]"
    : "fixed bottom-6 right-6 w-[380px] max-w-[calc(100vw-2rem)] h-[480px] max-h-[70vh] flex flex-col bg-background border rounded-lg shadow-xl z-50";

  const quickPrompts = lessonTitle
    ? [
        { icon: "📖", label: "Explain this" },
        { icon: "💡", label: "Give a tip" },
        { icon: "📐", label: "The formula?" },
      ]
    : [
        { icon: "📖", label: "Summarize this course" },
        { icon: "💡", label: "What will I learn?" },
        { icon: "✏️", label: "Give me a practice question" },
      ];
  const showQuickPrompts = embedded && messages.length <= 1 && !isAITyping;
  const showPracticeChip = embedded && activePracticeLabel && onAskAboutPractice;

  return (
    <div className={panelClass}>
      <header className="flex shrink-0 items-center justify-between border-b border-[#eae8e2] bg-white px-4 py-3">
        <div className="flex items-center gap-2">
          <span className="font-semibold text-sm text-[#1a1a2e]">AI Tutor</span>
          {embedded && lessonTitle && (
            <span className="text-xs text-[#8b8880] truncate max-w-[120px]" title={lessonTitle}>
              · {lessonTitle}
            </span>
          )}
        </div>
        <div className="flex items-center gap-1">
          {embedded && onCollapsePanel && (
            <button
              type="button"
              onClick={onCollapsePanel}
              title="Collapse AI panel"
              className="rounded-md p-1 text-[#8b8880] hover:bg-[#f5f4f1] hover:text-[#1a1a2e] transition-colors"
              aria-label="Collapse AI panel"
            >
              <ChevronRight className="w-4 h-4" />
            </button>
          )}
          {!embedded && (
            <Button variant="outline" size="sm" onClick={onToggle} aria-label="Close">
              <X className="w-4 h-4" />
            </Button>
          )}
        </div>
      </header>
      <div className="min-h-0 flex-1 overflow-y-auto p-3 space-y-3">
        {messages.map((m, i) => (
          <div
            key={i}
            className={`flex ${m.role === "user" ? "justify-end" : "justify-start"}`}
          >
            <div
              className={`max-w-[85%] rounded-xl px-3.5 py-2.5 text-sm shadow-sm ${
                m.role === "user"
                  ? "bg-[#f59207] text-white"
                  : "bg-white border border-[#eae8e2] text-[#1a1a2e] [&_strong]:font-bold [&_code]:font-mono"
              }`}
            >
              {m.role === "assistant" ? (
                <span
                  dangerouslySetInnerHTML={{ __html: renderSimpleMd(m.content) }}
                />
              ) : (
                m.content
              )}
            </div>
          </div>
        ))}
        {isAITyping && (
          <div className="flex justify-start">
            <div className="rounded-xl px-3.5 py-2.5 bg-white border border-[#eae8e2] text-sm text-[#8b8880] shadow-sm">
              Thinking...
            </div>
          </div>
        )}
        {showQuickPrompts && (
          <div className="flex flex-wrap gap-1.5 pt-2 border-t border-[#f0ede6] px-2 pt-2">
            {quickPrompts.map((p) => (
              <button
                key={p.label}
                type="button"
                onClick={() => sendText(p.label)}
                className="inline-flex items-center gap-1 rounded-[20px] border border-[#e0ddd6] bg-[#fdfcfa] px-2 py-1 text-[10.5px] font-semibold text-[#6b6966] transition-colors hover:border-[#fde9b8] hover:bg-[#fffbf0] hover:text-[#b45309]"
              >
                {p.icon} {p.label}
              </button>
            ))}
            {showPracticeChip && (
              <button
                type="button"
                onClick={onAskAboutPractice}
                className="inline-flex items-center gap-1 rounded-[20px] border border-[#e0ddd6] bg-[#fdfcfa] px-2 py-1 text-[10.5px] font-semibold text-[#6b6966] transition-colors hover:border-[#fde9b8] hover:bg-[#fffbf0] hover:text-[#b45309]"
              >
                ✏️ {activePracticeLabel}
              </button>
            )}
          </div>
        )}
        <div ref={messagesEndRef} />
      </div>
      <div className="flex shrink-0 flex-wrap items-end gap-2 border-t border-[#eae8e2] bg-white p-3">
        <Input
          placeholder={embedded && lessonTitle ? "Ask about this lesson…" : "Ask about the course…"}
          value={currentMessage}
          onChange={(e) => setCurrentMessage(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && !e.shiftKey && handleSend()}
          disabled={isAITyping}
          className="min-w-0 flex-1"
        />
        <Button
          size="icon"
          onClick={handleSend}
          disabled={!currentMessage.trim() || isAITyping}
          className="shrink-0 bg-primary text-primary-foreground hover:bg-primary/90"
        >
          <Send className="w-4 h-4" />
        </Button>
      </div>
    </div>
  );
}

"use client";

import { useState, useRef, useEffect } from "react";
import { Button } from "@/design-system/components/ui/button";
import { Input } from "@/design-system/components/ui/input";
import { MessageCircle, X, Send } from "lucide-react";

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
}

export function CourseChatbot({
  courseTitle,
  lessonTitle,
  isOpen,
  onToggle,
  embedded = false,
  messageToSend,
  onMessageSent,
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
    ? "flex-1 min-w-0 min-h-0 flex flex-col bg-background border-l border-border h-full"
    : "fixed bottom-6 right-6 w-[380px] max-w-[calc(100vw-2rem)] h-[480px] max-h-[70vh] flex flex-col bg-background border rounded-lg shadow-xl z-50";

  return (
    <div className={panelClass}>
      <header className="flex shrink-0 items-center justify-between border-b p-3">
        <span className="font-semibold text-sm">AI Tutor</span>
        {!embedded && (
          <Button variant="outline" size="sm" onClick={onToggle} aria-label="Close">
            <X className="w-4 h-4" />
          </Button>
        )}
      </header>
      <div className="min-h-0 flex-1 overflow-y-auto p-3 space-y-3">
        {messages.map((m, i) => (
          <div
            key={i}
            className={`flex ${m.role === "user" ? "justify-end" : "justify-start"}`}
          >
            <div
              className={`max-w-[85%] rounded-lg px-3 py-2 text-sm ${
                m.role === "user"
                  ? "bg-primary text-primary-foreground"
                  : "bg-muted"
              }`}
            >
              {m.content}
            </div>
          </div>
        ))}
        {isAITyping && (
          <div className="flex justify-start">
            <div className="rounded-lg px-3 py-2 bg-muted text-sm text-muted-foreground">
              Thinking...
            </div>
          </div>
        )}
        <div ref={messagesEndRef} />
      </div>
      <div className="flex shrink-0 flex-wrap items-end gap-2 border-t bg-background p-3">
        <Input
          placeholder="Ask about the course..."
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

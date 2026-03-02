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
}

export function CourseChatbot({
  courseTitle,
  lessonTitle,
  isOpen,
  onToggle,
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

  const handleSend = async () => {
    if (!currentMessage.trim()) return;

    const userMsg: ChatMessage = {
      role: "user",
      content: currentMessage,
      timestamp: new Date(),
    };
    setMessages((prev) => [...prev, userMsg]);
    const text = currentMessage;
    setCurrentMessage("");
    setIsAITyping(true);

    try {
      const res = await fetch("/api/courses/chatbot", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          message: text,
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

  if (!isOpen) {
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

  return (
    <div className="fixed bottom-6 right-6 w-[380px] max-w-[calc(100vw-2rem)] h-[480px] max-h-[70vh] flex flex-col bg-background border rounded-lg shadow-xl z-50">
      <div className="flex items-center justify-between p-3 border-b">
        <span className="font-semibold text-sm">AI Tutor</span>
        <Button variant="outline" size="sm" onClick={onToggle} aria-label="Close">
          <X className="w-4 h-4" />
        </Button>
      </div>
      <div className="flex-1 overflow-y-auto p-3 space-y-3">
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
      <div className="p-3 border-t flex gap-2">
        <Input
          placeholder="Ask about the course..."
          value={currentMessage}
          onChange={(e) => setCurrentMessage(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && !e.shiftKey && handleSend()}
          disabled={isAITyping}
          className="flex-1"
        />
        <Button
          size="icon"
          onClick={handleSend}
          disabled={!currentMessage.trim() || isAITyping}
          className="bg-primary text-primary-foreground hover:bg-primary/90"
        >
          <Send className="w-4 h-4" />
        </Button>
      </div>
    </div>
  );
}

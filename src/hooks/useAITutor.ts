"use client";

import { useState } from "react";

interface ChatMessage {
  role: "user" | "assistant";
  content: string;
  timestamp: Date;
}

export function useAITutor(lessonTitle: string) {
  const [chatMessages, setChatMessages] = useState<ChatMessage[]>([
    {
      role: "assistant",
      content: `Hello! I'm your AI tutor. I'm here to help you with "${lessonTitle}". Ask me questions about this lesson or request practice problems!`,
      timestamp: new Date(),
    },
  ]);
  const [currentMessage, setCurrentMessage] = useState("");
  const [isAITyping, setIsAITyping] = useState(false);

  const handleSendMessage = async () => {
    if (!currentMessage.trim()) return;

    const userMessage: ChatMessage = {
      role: "user",
      content: currentMessage,
      timestamp: new Date(),
    };

    setChatMessages((prev) => [...prev, userMessage]);
    const messageText = currentMessage;
    setCurrentMessage("");
    setIsAITyping(true);

    // Placeholder — replace with real API call when AI service is ready
    setTimeout(() => {
      const aiMessage: ChatMessage = {
        role: "assistant",
        content: `I understand you're asking about "${messageText}". This is related to ${lessonTitle}. Here's a helpful explanation... [AI response would go here. This is a placeholder - integrate with your AI service when ready.]`,
        timestamp: new Date(),
      };
      setChatMessages((prev) => [...prev, aiMessage]);
      setIsAITyping(false);
    }, 1500);
  };

  return {
    chatMessages,
    currentMessage,
    isAITyping,
    setCurrentMessage,
    handleSendMessage,
  };
}

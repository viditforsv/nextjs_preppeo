"use client";

import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  CardDescription,
} from "@/design-system/components/ui/card";
import { Button } from "@/design-system/components/ui/button";
import { Input } from "@/design-system/components/ui/input";
import { MessageCircle, Send } from "lucide-react";
import type { useAITutor } from "@/hooks/useAITutor";

type ChatInterfaceProps = ReturnType<typeof useAITutor> & {
  lessonTitle: string;
};

export function ChatInterface({
  lessonTitle,
  chatMessages,
  currentMessage,
  isAITyping,
  setCurrentMessage,
  handleSendMessage,
}: ChatInterfaceProps) {
  return (
    <Card className="rounded-sm">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <MessageCircle className="w-5 h-5 text-[#1a365d]" />
          AI Tutor
        </CardTitle>
        <CardDescription>
          Ask questions about {lessonTitle} or request practice problems
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* Messages */}
        <div className="h-96 overflow-y-auto space-y-3 p-4 bg-gray-50 rounded-sm border border-gray-200">
          {chatMessages.map((message, index) => (
            <div
              key={index}
              className={`flex ${
                message.role === "user" ? "justify-end" : "justify-start"
              }`}
            >
              <div
                className={`max-w-[80%] p-3 rounded-sm ${
                  message.role === "user"
                    ? "bg-[#1a365d] text-white"
                    : "bg-white border border-gray-200 text-gray-800"
                }`}
              >
                <p className="text-sm leading-relaxed">{message.content}</p>
                <p
                  className={`text-xs mt-1 ${
                    message.role === "user" ? "text-white/70" : "text-gray-400"
                  }`}
                >
                  {message.timestamp.toLocaleTimeString()}
                </p>
              </div>
            </div>
          ))}
          {isAITyping && (
            <div className="flex justify-start">
              <div className="bg-white border border-gray-200 p-3 rounded-sm">
                <p className="text-sm text-gray-500">AI is typing...</p>
              </div>
            </div>
          )}
        </div>

        {/* Input */}
        <div className="flex gap-2">
          <Input
            placeholder="Ask a question about this lesson..."
            value={currentMessage}
            onChange={(e) => setCurrentMessage(e.target.value)}
            onKeyPress={(e) => e.key === "Enter" && handleSendMessage()}
            className="rounded-sm"
          />
          <Button
            onClick={handleSendMessage}
            disabled={!currentMessage.trim() || isAITyping}
            className="rounded-sm bg-[#1a365d] hover:bg-[#1a365d]/90"
          >
            <Send className="w-4 h-4" />
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}

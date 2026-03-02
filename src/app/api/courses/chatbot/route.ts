import { NextRequest, NextResponse } from "next/server";

interface CourseChatbotBody {
  message: string;
  course_id?: string;
  course_slug?: string;
  course_title?: string;
  lesson_id?: string;
  lesson_title?: string;
  lesson_content?: string;
}

export async function POST(request: NextRequest) {
  let body: CourseChatbotBody;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json(
      { error: "Invalid JSON body" },
      { status: 400 }
    );
  }

  const {
    message,
    course_title = "this course",
    lesson_title,
    lesson_content,
  } = body;

  if (!message || typeof message !== "string") {
    return NextResponse.json(
      { error: "Message is required" },
      { status: 400 }
    );
  }

  const apiKey = process.env.GOOGLE_GEMINI_API_KEY;
  if (!apiKey) {
    return NextResponse.json({
      response: `I'm your course assistant for ${course_title}. (AI is not configured; add GOOGLE_GEMINI_API_KEY to enable.) You asked: ${message}`,
      success: true,
      warning: "Mock response - API key not set",
    });
  }

  const contextParts = [
    `Course: ${course_title}`,
    lesson_title ? `Current lesson: ${lesson_title}` : "",
    lesson_content ? `Lesson content (summary): ${String(lesson_content).slice(0, 800)}` : "",
  ].filter(Boolean);

  const systemInstruction = `You are a helpful tutor AI for students taking an online course. Your role is to answer questions about the course material, explain concepts, and help with the current lesson when provided.

Context:
${contextParts.join("\n")}

Guidelines:
1. Be clear and educational.
2. Use LaTeX for math when needed (e.g. $x^2$, $$\\frac{a}{b}$$).
3. Keep responses concise but thorough.
4. If the user asks about the current lesson, use the context above.`;

  try {
    const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${apiKey}`;
    const geminiResponse = await fetch(geminiUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        contents: [
          {
            parts: [{ text: `${systemInstruction}\n\nUser: ${message}` }],
          },
        ],
        generationConfig: {
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 1024,
        },
      }),
    });

    if (!geminiResponse.ok) {
      const errText = await geminiResponse.text();
      console.error("Gemini API error:", errText);
      return NextResponse.json({
        response: `Sorry, I couldn't process that right now. Please try again. (Error: ${geminiResponse.status})`,
        success: true,
      });
    }

    const geminiData = await geminiResponse.json();
    const responseText =
      geminiData.candidates?.[0]?.content?.parts?.[0]?.text;

    if (!responseText) {
      return NextResponse.json({
        response: "I didn't get a valid response. Please rephrase your question.",
        success: true,
      });
    }

    return NextResponse.json({
      response: responseText,
      success: true,
    });
  } catch (error) {
    console.error("Course chatbot error:", error);
    return NextResponse.json({
      response: "Something went wrong. Please try again.",
      success: true,
    });
  }
}

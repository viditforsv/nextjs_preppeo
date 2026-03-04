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

  const openaiKey = process.env.OPENAI_API_KEY;
  const anthropicKey = process.env.ANTHROPIC_API_KEY;
  const geminiKey = process.env.GOOGLE_GEMINI_API_KEY;

  if (!openaiKey && !anthropicKey && !geminiKey) {
    return NextResponse.json({
      response: `I'm your course assistant for ${course_title}. (AI is not configured; add OPENAI_API_KEY, ANTHROPIC_API_KEY, or GOOGLE_GEMINI_API_KEY to enable.) You asked: ${message}`,
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
1. Keep answers SHORT: 2-4 sentences or one brief paragraph. No long essays.
2. For math, use plain text and simple symbols only: write "x squared", "square root of 2", or use Unicode (², √, ×, ÷, ≠, ≈). Do NOT use LaTeX ($...$ or $$...$$).
3. Be clear and direct. If the user asks about the current lesson, use the context above.`;

  if (openaiKey) {
    try {
      const openaiRes = await fetch("https://api.openai.com/v1/chat/completions", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${openaiKey}`,
        },
        body: JSON.stringify({
          model: "gpt-4o-mini",
          max_tokens: 400,
          messages: [
            { role: "system", content: systemInstruction },
            { role: "user", content: message },
          ],
        }),
      });

      if (openaiRes.status === 429) {
        return NextResponse.json({
          response: "The AI is getting a lot of requests right now. Please wait a minute and try again.",
          success: true,
        });
      }

      if (openaiRes.ok) {
        const data = await openaiRes.json();
        const text = data.choices?.[0]?.message?.content;
        if (text) {
          return NextResponse.json({ response: text, success: true });
        }
      }

      const errText = await openaiRes.text();
      console.error("OpenAI API error:", openaiRes.status, errText);
      return NextResponse.json({
        response: `Sorry, I couldn't process that right now. Please try again. (Error: ${openaiRes.status})`,
        success: true,
      });
    } catch (err) {
      console.error("Course chatbot OpenAI error:", err);
      return NextResponse.json({
        response: "Something went wrong. Please try again.",
        success: true,
      });
    }
  }

  if (anthropicKey) {
    try {
      const claudeRes = await fetch("https://api.anthropic.com/v1/messages", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "x-api-key": anthropicKey,
          "anthropic-version": "2023-06-01",
        },
        body: JSON.stringify({
          model: "claude-3-5-sonnet-20241022",
          max_tokens: 400,
          system: systemInstruction,
          messages: [{ role: "user", content: message }],
        }),
      });

      if (claudeRes.status === 429) {
        return NextResponse.json({
          response: "The AI is getting a lot of requests right now. Please wait a minute and try again.",
          success: true,
        });
      }

      if (claudeRes.ok) {
        const data = await claudeRes.json();
        const text = data.content?.[0]?.text;
        if (text) {
          return NextResponse.json({ response: text, success: true });
        }
      }

      const errText = await claudeRes.text();
      console.error("Claude API error:", claudeRes.status, errText);
      return NextResponse.json({
        response: `Sorry, I couldn't process that right now. Please try again. (Error: ${claudeRes.status})`,
        success: true,
      });
    } catch (err) {
      console.error("Course chatbot Claude error:", err);
      return NextResponse.json({
        response: "Something went wrong. Please try again.",
        success: true,
      });
    }
  }

  const payload = {
    contents: [
      {
        parts: [{ text: `${systemInstruction}\n\nUser: ${message}` }],
      },
    ],
    generationConfig: {
      temperature: 0.7,
      topK: 40,
      topP: 0.95,
      maxOutputTokens: 400,
    },
  };

  const modelsToTry: { model: string; version?: string }[] = [
    { model: "gemini-2.0-flash" },
    { model: "gemini-2.0-flash", version: "v1" },
    { model: "gemini-1.5-flash" },
    { model: "gemini-1.5-pro" },
  ];
  let lastStatus = 0;
  let lastError = "";

  const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

  try {
    for (const { model, version = "v1beta" } of modelsToTry) {
      const geminiUrl = `https://generativelanguage.googleapis.com/${version}/models/${model}:generateContent?key=${geminiKey}`;

      let geminiResponse = await fetch(geminiUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });

      if (geminiResponse.status === 429) {
        await sleep(2500);
        geminiResponse = await fetch(geminiUrl, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
      }

      lastStatus = geminiResponse.status;
      lastError = await geminiResponse.text();

      if (geminiResponse.ok) {
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
      }

      if (geminiResponse.status === 429) {
        console.warn("Gemini rate limit (429) after retry");
        return NextResponse.json({
          response: "The AI is getting a lot of requests right now. Please wait a minute and try again.",
          success: true,
        });
      }

      if (geminiResponse.status !== 404) {
        break;
      }
      console.warn(`Gemini ${version}/${model} returned 404, trying next.`);
    }

    const isRateLimit = lastStatus === 429;
    console.error("Gemini API error (all models failed):", lastError);
    return NextResponse.json({
      response: isRateLimit
        ? "The AI is rate-limited. Please wait a minute and try again."
        : `Sorry, I couldn't process that right now. Please try again. (Error: ${lastStatus})`,
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

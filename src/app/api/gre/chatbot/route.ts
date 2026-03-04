import { NextRequest, NextResponse } from 'next/server';
import { Question } from '@/types/gre-test';

interface ChatbotContext {
  question?: Question;
  sectionType?: 'verbal' | 'quantitative';
  userAnswer?: string | number | string[] | null;
  questionPrompt?: string;
  correctAnswer?: string | string[];
}

interface ChatbotRequestBody {
  message: string;
  context?: ChatbotContext;
}

/**
 * POST /api/gre/chatbot
 * AI chatbot endpoint for Study Mode
 * Provides context-aware explanations and help for GRE questions using Google Gemini
 */
export async function POST(request: NextRequest) {
  let body: ChatbotRequestBody;
  let message: string = '';
  let context: ChatbotContext | undefined;
  
  try {
    body = await request.json();
    message = body.message;
    context = body.context;

    if (!message || typeof message !== 'string') {
      return NextResponse.json(
        { error: 'Message is required' },
        { status: 400 }
      );
    }

    const openaiKey = process.env.OPENAI_API_KEY;
    const anthropicKey = process.env.ANTHROPIC_API_KEY;
    const geminiKey = process.env.GOOGLE_GEMINI_API_KEY;

    if (!openaiKey && !anthropicKey && !geminiKey) {
      const mockResponse = generateMockResponse(message, context);
      return NextResponse.json({
        response: mockResponse,
        success: true,
        warning: 'Using mock response - OPENAI_API_KEY, ANTHROPIC_API_KEY, or GOOGLE_GEMINI_API_KEY not set'
      });
    }

    // Extract context
    const {
      sectionType,
      userAnswer,
      questionPrompt,
      correctAnswer
    } = context || {};

    // Build system instruction with context
    const systemInstruction = `You are a helpful GRE tutor AI assistant. Your role is to help students understand GRE questions and improve their test-taking skills.

Context:
- Section Type: ${sectionType || 'Unknown'}
- Current Question: ${questionPrompt ? questionPrompt.substring(0, 1000) : 'Not available'}
- Correct Answer: ${correctAnswer || 'Not available'}
- User's Answer: ${userAnswer !== null && userAnswer !== undefined ? userAnswer : 'Not answered yet'}

Guidelines:
1. Keep answers SHORT: 2-5 sentences or one brief paragraph. No long step-by-step unless the user asks for it.
2. For math, use plain text and simple symbols only: "x squared", "square root of 2", or Unicode (², √, ×, ÷, ≠, ≈). Do NOT use LaTeX ($...$ or $$...$$).
3. Be clear, direct, and encouraging. Reference the question only when relevant.`;

    if (openaiKey) {
      try {
        const openaiRes = await fetch('https://api.openai.com/v1/chat/completions', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${openaiKey}`,
          },
          body: JSON.stringify({
            model: 'gpt-4o-mini',
            max_tokens: 400,
            messages: [
              { role: 'system', content: systemInstruction },
              { role: 'user', content: message },
            ],
          }),
        });

        if (openaiRes.status === 429) {
          return NextResponse.json({
            response: 'The AI is getting a lot of requests right now. Please wait a minute and try again.',
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
        console.error('OpenAI API error:', openaiRes.status, errText);
        return NextResponse.json({
          response: `Sorry, I couldn't process that right now. Please try again. (Error: ${openaiRes.status})`,
          success: true,
        });
      } catch (err) {
        console.error('GRE chatbot OpenAI error:', err);
        return NextResponse.json({
          response: 'Something went wrong. Please try again.',
          success: true,
        });
      }
    }

    if (anthropicKey) {
      try {
        const claudeRes = await fetch('https://api.anthropic.com/v1/messages', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': anthropicKey,
            'anthropic-version': '2023-06-01',
          },
          body: JSON.stringify({
            model: 'claude-3-5-sonnet-20241022',
            max_tokens: 400,
            system: systemInstruction,
            messages: [{ role: 'user', content: message }],
          }),
        });

        if (claudeRes.status === 429) {
          return NextResponse.json({
            response: 'The AI is getting a lot of requests right now. Please wait a minute and try again.',
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
        console.error('Claude API error:', claudeRes.status, errText);
        return NextResponse.json({
          response: `Sorry, I couldn't process that right now. Please try again. (Error: ${claudeRes.status})`,
          success: true,
        });
      } catch (err) {
        console.error('GRE chatbot Claude error:', err);
        return NextResponse.json({
          response: 'Something went wrong. Please try again.',
          success: true,
        });
      }
    }

    const payload = {
      contents: [{
        parts: [{ text: `${systemInstruction}\n\nUser's question: ${message}` }],
      }],
      generationConfig: {
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 400,
      },
    };

    const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));
    const modelsToTry = ['gemini-2.0-flash', 'gemini-1.5-flash', 'gemini-1.5-pro'];

    for (const model of modelsToTry) {
      const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${geminiKey}`;
      let geminiResponse = await fetch(geminiUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });

      if (geminiResponse.status === 429) {
        await sleep(2500);
        geminiResponse = await fetch(geminiUrl, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload),
        });
      }

      if (geminiResponse.ok) {
        const geminiData = await geminiResponse.json();
        const responseText = geminiData.candidates?.[0]?.content?.parts?.[0]?.text;
        if (responseText) {
          return NextResponse.json({ response: responseText, success: true });
        }
      }
      if (geminiResponse.status === 429) {
        return NextResponse.json({
          response: 'The AI is getting a lot of requests right now. Please wait a minute and try again.',
          success: true,
        });
      }
      if (geminiResponse.status !== 404) {
        const errorData = await geminiResponse.text();
        console.error(`Gemini API error (${model}):`, errorData);
        throw new Error(`Gemini API error: ${geminiResponse.status}`);
      }
    }

    const mockResponse = generateMockResponse(message, context);
    return NextResponse.json({
      response: mockResponse,
      success: true,
      warning: 'All Gemini models returned 404 - using mock response',
    });
  } catch (error) {
    console.error('Error in chatbot API:', error);
    
    // Fallback to mock response on error
    if (message) {
      const mockResponse = generateMockResponse(message, context);
      return NextResponse.json({
        response: mockResponse,
        success: true,
        warning: 'Using mock response due to API error'
      });
    }
    
    return NextResponse.json(
      {
        error: error instanceof Error ? error.message : 'Internal server error',
        success: false
      },
      { status: 500 }
    );
  }
}

/**
 * Generate a mock AI response based on the user's message and context
 * This should be replaced with actual AI service integration
 */
function generateMockResponse(message: string, context?: ChatbotContext): string {
  const lowerMessage = message.toLowerCase();
  const { question, sectionType, userAnswer, correctAnswer } = context || {};

  // Check if asking about the current question
  if (lowerMessage.includes('explain') || lowerMessage.includes('why') || lowerMessage.includes('how')) {
    if (sectionType === 'quantitative') {
      return `To solve this quantitative question, let's break it down step by step:

1. **Understand the problem**: ${question?.prompt ? question.prompt.substring(0, 200) + '...' : 'Review the question carefully'}

2. **Identify what's being asked**: Look for key mathematical concepts and relationships.

3. **Apply the appropriate method**: 
   - For algebra problems, set up equations
   - For geometry, use formulas and properties
   - For data interpretation, analyze the given information

4. **Check your work**: Verify that your answer makes sense in context.

The correct answer is: ${correctAnswer || 'Not available'}

Would you like me to explain any specific step in more detail?`;
    } else {
      return `For this verbal reasoning question, here's how to approach it:

1. **Read carefully**: Pay attention to the passage and question details.

2. **Identify key information**: Look for main ideas, supporting details, and relationships.

3. **Eliminate wrong answers**: Cross out options that don't match the passage or question.

4. **Choose the best answer**: Select the option that most accurately answers the question.

The correct answer is: ${correctAnswer || 'Not available'}

${userAnswer && userAnswer !== correctAnswer 
  ? `Your answer was: ${userAnswer}. Let me explain why the correct answer is better...` 
  : 'Would you like me to explain any specific part of the question or passage?'}`;
    }
  }

  // General GRE strategy questions
  if (lowerMessage.includes('strategy') || lowerMessage.includes('tip') || lowerMessage.includes('advice')) {
    return `Here are some effective GRE strategies:

**Time Management:**
- Allocate about 1.5-2 minutes per question
- Don't spend too long on any single question
- Flag difficult questions and return to them

**Quantitative Reasoning:**
- Show your work step by step
- Check your calculations
- Use the calculator for complex arithmetic

**Verbal Reasoning:**
- Read passages actively, looking for main ideas
- Pay attention to transition words
- Eliminate obviously wrong answers first

**General Tips:**
- Practice regularly to build familiarity
- Review your mistakes to learn from them
- Stay calm and focused during the test

Is there a specific area you'd like more help with?`;
  }

  // Default response
  return `I understand you're asking: "${message}"

${question 
  ? `I can help you with the current question. Would you like me to:
- Explain why the correct answer is right?
- Show you step-by-step how to solve it?
- Help you understand any confusing parts?

Just let me know what you need!`
  : 'I\'m here to help you with GRE questions, explanations, and strategies. What would you like to know?'}`;
}


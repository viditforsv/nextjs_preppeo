import { NextRequest, NextResponse } from 'next/server';

interface ExplainRequestBody {
  prompt: string;
  passage?: string;
  options?: { id: string; text: string }[];
  userAnswer: string;
  correctAnswer: string;
  section: 'math' | 'rw';
  domain?: string;
  difficulty?: string;
  explanation?: string;
}

export async function POST(request: NextRequest) {
  try {
    const body: ExplainRequestBody = await request.json();
    const { prompt, passage, options, userAnswer, correctAnswer, section, domain, difficulty, explanation } = body;

    if (!prompt || !correctAnswer || !section) {
      return NextResponse.json({ error: 'Missing required fields' }, { status: 400 });
    }

    const geminiKey = process.env.GOOGLE_GEMINI_API_KEY;

    if (!geminiKey) {
      return NextResponse.json({
        explanation: explanation || 'AI explanations are not configured. Please set the GOOGLE_GEMINI_API_KEY environment variable.',
        success: true,
        fallback: true,
      });
    }

    const isCorrect = userAnswer === correctAnswer;
    const sectionLabel = section === 'rw' ? 'Reading & Writing' : 'Math';
    const optionsText = options?.map((o) => `${o.id}) ${o.text}`).join('\n') ?? '';

    const systemPrompt = `You are an expert SAT tutor. A student just answered a Digital SAT ${sectionLabel} question.

Question domain: ${domain ?? 'Unknown'}
Difficulty: ${difficulty ?? 'Unknown'}
${passage ? `\nPassage:\n${passage}\n` : ''}
Question: ${prompt}

${optionsText ? `Options:\n${optionsText}\n` : ''}
Correct answer: ${correctAnswer}
Student's answer: ${userAnswer ?? 'No answer'}
Result: ${isCorrect ? 'CORRECT' : 'INCORRECT'}
${explanation ? `\nOriginal explanation:\n${explanation}\n` : ''}

Provide a clear, concise explanation (3-6 sentences):
1. ${isCorrect ? 'Congratulate briefly, then explain WHY the answer is correct.' : 'State the correct answer, then explain WHY it is correct and why their choice was wrong.'}
2. ${section === 'rw' ? 'Reference the passage when relevant.' : 'Show the key step(s) to solve it.'}
3. End with a brief tip or strategy for similar questions.

Use plain text. For math, use Unicode symbols (², √, ×, ÷) instead of LaTeX. Keep it conversational and encouraging.`;

    const payload = {
      contents: [{ role: 'user', parts: [{ text: systemPrompt }] }],
      generationConfig: { temperature: 0.3, maxOutputTokens: 500 },
    };

    const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));
    const models = ['gemini-2.0-flash', 'gemini-1.5-flash'];

    for (const model of models) {
      const url = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${geminiKey}`;
      let res = await fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });

      if (res.status === 429) {
        await sleep(2000);
        res = await fetch(url, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(payload),
        });
      }

      if (res.ok) {
        const data = await res.json();
        const text = data.candidates?.[0]?.content?.parts?.[0]?.text;
        if (text) {
          return NextResponse.json({ explanation: text, success: true });
        }
      }

      if (res.status === 429) {
        return NextResponse.json({
          explanation: explanation || 'The AI is busy right now. Please try again in a moment.',
          success: true,
          fallback: true,
        });
      }

      if (res.status !== 404) break;
    }

    return NextResponse.json({
      explanation: explanation || 'Unable to generate AI explanation at this time.',
      success: true,
      fallback: true,
    });
  } catch (error) {
    console.error('Error in POST /api/sat/explain:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

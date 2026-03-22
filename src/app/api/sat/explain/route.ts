import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

interface ExplainRequestBody {
  questionId: string;
  prompt: string;
  passage?: string;
  options?: { id: string; text: string }[];
  userAnswer: string;
  correctAnswer: string;
  section: 'math' | 'rw';
  domain?: string;
  difficulty?: string;
  explanation?: string;
  mode?: 'answer' | 'theory';
  course?: string;
}

const COURSE_TABLE: Record<string, string> = {
  sat: 'sat_questions',
  'cbse10-maths': 'cbse10_maths_questions',
  'cbse10-science': 'cbse10_science_questions',
};

// In-memory rate limit: userId -> { count, resetAt }
const rateLimits = new Map<string, { count: number; resetAt: number }>();
const RATE_LIMIT = 60; // requests per window
const RATE_WINDOW_MS = 60 * 60 * 1000; // 1 hour

function checkRateLimit(userId: string): boolean {
  const now = Date.now();
  const entry = rateLimits.get(userId);

  if (!entry || now > entry.resetAt) {
    rateLimits.set(userId, { count: 1, resetAt: now + RATE_WINDOW_MS });
    return true;
  }

  if (entry.count >= RATE_LIMIT) return false;
  entry.count++;
  return true;
}

function buildPrompt(body: ExplainRequestBody): { systemPrompt: string; maxTokens: number } {
  const { prompt, passage, options, userAnswer, correctAnswer, section, domain, difficulty, explanation, mode = 'answer' } = body;
  const isCorrect = userAnswer === correctAnswer;
  const sectionLabel = section === 'rw' ? 'Reading & Writing' : 'Math';
  const optionsText = options?.map((o) => `${o.id}) ${o.text}`).join('\n') ?? '';

  const questionContext = `Question domain: ${domain ?? 'Unknown'}
Difficulty: ${difficulty ?? 'Unknown'}
${passage ? `\nPassage:\n${passage}\n` : ''}
Question: ${prompt}
${optionsText ? `\nOptions:\n${optionsText}` : ''}
Correct answer: ${correctAnswer}`;

  if (mode === 'theory') {
    return {
      systemPrompt: `You are an expert SAT tutor. A student needs to understand the underlying theory behind a Digital SAT ${sectionLabel} question.

${questionContext}

Provide a focused theory explanation (2-3 paragraphs):
1. Name and explain the specific concept, rule, or skill this question tests.
2. ${section === 'rw' ? 'Cover the relevant grammar rule, reading strategy, or rhetoric principle with examples beyond this question.' : 'Explain the mathematical concept with the general formula or method, showing how it applies broadly.'}
3. Give a clear, reusable strategy for tackling similar questions on test day.

Use plain text. For math, use Unicode symbols (², √, ×, ÷) instead of LaTeX. Be thorough but concise.`,
      maxTokens: 800,
    };
  }

  return {
    systemPrompt: `You are an expert SAT tutor. A student just answered a Digital SAT ${sectionLabel} question.

${questionContext}
Student's answer: ${userAnswer ?? 'No answer'}
Result: ${isCorrect ? 'CORRECT' : 'INCORRECT'}
${explanation ? `\nOriginal explanation:\n${explanation}\n` : ''}

Provide a clear, concise explanation (3-6 sentences):
1. ${isCorrect ? 'Congratulate briefly, then explain WHY the answer is correct.' : 'State the correct answer, then explain WHY it is correct and why their choice was wrong.'}
2. ${section === 'rw' ? 'Reference the passage when relevant.' : 'Show the key step(s) to solve it.'}
3. End with a brief tip or strategy for similar questions.

Use plain text. For math, use Unicode symbols (², √, ×, ÷) instead of LaTeX. Keep it conversational and encouraging.`,
    maxTokens: 500,
  };
}

async function callOpenAI(apiKey: string, systemPrompt: string, maxTokens: number, model: string): Promise<string | null> {
  try {
    const res = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        model,
        max_tokens: maxTokens,
        temperature: 0.3,
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: 'Please provide the explanation as described above.' },
        ],
      }),
    });

    if (res.ok) {
      const data = await res.json();
      return data.choices?.[0]?.message?.content ?? null;
    }

    console.error(`OpenAI ${model} error:`, res.status, await res.text());
    return null;
  } catch (err) {
    console.error('OpenAI fetch error:', err);
    return null;
  }
}

async function generateExplanation(systemPrompt: string, maxTokens: number): Promise<string | null> {
  const openaiKey = process.env.OPENAI_API_KEY;
  const geminiKey = process.env.GOOGLE_GEMINI_API_KEY;

  // Best quality first: gpt-4o, then gpt-4o-mini as fallback
  if (openaiKey) {
    const text = await callOpenAI(openaiKey, systemPrompt, maxTokens, 'gpt-4o');
    if (text) return text;

    const fallback = await callOpenAI(openaiKey, systemPrompt, maxTokens, 'gpt-4o-mini');
    if (fallback) return fallback;
  }

  // Gemini as last resort
  if (geminiKey) {
    const payload = {
      contents: [{ role: 'user', parts: [{ text: systemPrompt }] }],
      generationConfig: { temperature: 0.3, maxOutputTokens: maxTokens },
    };
    for (const model of ['gemini-2.0-flash', 'gemini-1.5-flash']) {
      try {
        const res = await fetch(
          `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${geminiKey}`,
          { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(payload) }
        );
        if (res.ok) {
          const data = await res.json();
          const text = data.candidates?.[0]?.content?.parts?.[0]?.text;
          if (text) return text;
        }
        if (res.status !== 404) break;
      } catch { /* try next */ }
    }
  }

  return null;
}

export async function POST(request: NextRequest) {
  try {
    // Auth check
    const supabase = await createClient();
    const { data: { user }, error: authError } = await supabase.auth.getUser();
    if (authError || !user) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    }

    // Rate limit
    if (!checkRateLimit(user.id)) {
      return NextResponse.json({
        explanation: 'You have reached the explanation limit. Please try again later.',
        success: true,
        fallback: true,
      });
    }

    const body: ExplainRequestBody = await request.json();
    if (!body.prompt || !body.correctAnswer || !body.section) {
      return NextResponse.json({ error: 'Missing required fields' }, { status: 400 });
    }

    const mode = body.mode ?? 'answer';
    const cacheCol = mode === 'theory' ? 'ai_theory' : 'ai_explanation';
    const tableName = COURSE_TABLE[body.course ?? 'sat'] ?? 'sat_questions';

    // Check cache if questionId provided
    if (body.questionId) {
      const adminSupabase = createSupabaseApiClient();
      const { data: cached } = await adminSupabase
        .from(tableName)
        .select(cacheCol)
        .eq('id', body.questionId)
        .single();

      const cachedText = cached?.[cacheCol as keyof typeof cached];
      if (cachedText) {
        return NextResponse.json({ explanation: cachedText, success: true, cached: true });
      }
    }

    // Generate fresh
    const openaiKey = process.env.OPENAI_API_KEY;
    const geminiKey = process.env.GOOGLE_GEMINI_API_KEY;
    if (!openaiKey && !geminiKey) {
      return NextResponse.json({
        explanation: body.explanation || 'AI explanations are not configured.',
        success: true,
        fallback: true,
      });
    }

    const { systemPrompt, maxTokens } = buildPrompt(body);
    const text = await generateExplanation(systemPrompt, maxTokens);

    if (text) {
      // Cache the result
      if (body.questionId) {
        const adminSupabase = createSupabaseApiClient();
        await adminSupabase
          .from(tableName)
          .update({ [cacheCol]: text })
          .eq('id', body.questionId)
          .then(({ error }) => {
            if (error) console.error('Cache write error:', error);
          });
      }

      return NextResponse.json({ explanation: text, success: true });
    }

    return NextResponse.json({
      explanation: body.explanation || 'Unable to generate AI explanation at this time.',
      success: true,
      fallback: true,
    });
  } catch (error) {
    console.error('Error in POST /api/sat/explain:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

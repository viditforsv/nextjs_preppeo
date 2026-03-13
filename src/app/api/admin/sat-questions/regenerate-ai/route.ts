import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

interface RegenRequest {
  questionId: string;
  mode: 'answer' | 'theory';
}

async function callOpenAI(apiKey: string, systemPrompt: string, maxTokens: number, model: string): Promise<string | null> {
  try {
    const res = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${apiKey}` },
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

export async function POST(request: NextRequest) {
  try {
    const { questionId, mode }: RegenRequest = await request.json();
    if (!questionId || !mode) {
      return NextResponse.json({ error: 'questionId and mode are required' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();
    const { data: q, error: fetchErr } = await supabase
      .from('sat_questions')
      .select('id, prompt, passage, options, correct_answer, section, domain, difficulty_tier, explanation')
      .eq('id', questionId)
      .single();

    if (fetchErr || !q) {
      return NextResponse.json({ error: 'Question not found' }, { status: 404 });
    }

    const sectionLabel = q.section === 'rw' ? 'Reading & Writing' : 'Math';
    const optionsText = q.options?.map((o: { id: string; text: string }) => `${o.id}) ${o.text}`).join('\n') ?? '';
    const questionContext = `Question domain: ${q.domain ?? 'Unknown'}
Difficulty: ${q.difficulty_tier ?? 'Unknown'}
${q.passage ? `\nPassage:\n${q.passage}\n` : ''}
Question: ${q.prompt}
${optionsText ? `\nOptions:\n${optionsText}` : ''}
Correct answer: ${q.correct_answer}`;

    let systemPrompt: string;
    let maxTokens: number;

    if (mode === 'theory') {
      systemPrompt = `You are an expert SAT tutor. Provide the underlying theory behind a Digital SAT ${sectionLabel} question.

${questionContext}

Provide a focused theory explanation (2-3 paragraphs):
1. Name and explain the specific concept, rule, or skill this question tests.
2. ${q.section === 'rw' ? 'Cover the relevant grammar rule, reading strategy, or rhetoric principle with examples beyond this question.' : 'Explain the mathematical concept with the general formula or method, showing how it applies broadly.'}
3. Give a clear, reusable strategy for tackling similar questions on test day.

Use plain text. For math, use Unicode symbols (², √, ×, ÷) instead of LaTeX. Be thorough but concise.`;
      maxTokens = 800;
    } else {
      systemPrompt = `You are an expert SAT tutor. Explain a Digital SAT ${sectionLabel} question.

${questionContext}
${q.explanation ? `\nOriginal explanation:\n${q.explanation}\n` : ''}

Provide a clear, concise explanation (3-6 sentences):
1. Explain WHY the correct answer is correct.
2. ${q.section === 'rw' ? 'Reference the passage when relevant.' : 'Show the key step(s) to solve it.'}
3. End with a brief tip or strategy for similar questions.

Use plain text. For math, use Unicode symbols (², √, ×, ÷) instead of LaTeX. Keep it conversational and encouraging.`;
      maxTokens = 500;
    }

    const openaiKey = process.env.OPENAI_API_KEY;
    if (!openaiKey) {
      return NextResponse.json({ error: 'No AI API key configured' }, { status: 500 });
    }

    let text = await callOpenAI(openaiKey, systemPrompt, maxTokens, 'gpt-4o');
    if (!text) text = await callOpenAI(openaiKey, systemPrompt, maxTokens, 'gpt-4o-mini');
    if (!text) {
      return NextResponse.json({ error: 'AI generation failed' }, { status: 500 });
    }

    const cacheCol = mode === 'theory' ? 'ai_theory' : 'ai_explanation';
    await supabase.from('sat_questions').update({ [cacheCol]: text }).eq('id', questionId);

    return NextResponse.json({ text, success: true });
  } catch (err) {
    console.error('Error in POST /api/admin/sat-questions/regenerate-ai:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

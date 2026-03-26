import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

const TABLE = 'ibdp_aa_sl_questions';
const COURSE_LABEL = 'IB Mathematics Analysis & Approaches SL';

interface RegenRequest { questionId: string; mode: 'answer' | 'theory' }

async function callOpenAI(apiKey: string, systemPrompt: string, maxTokens: number, model: string): Promise<string | null> {
  try {
    const res = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${apiKey}` },
      body: JSON.stringify({ model, max_tokens: maxTokens, temperature: 0.3,
        messages: [{ role: 'system', content: systemPrompt }, { role: 'user', content: 'Please provide the explanation as described above.' }] }),
    });
    if (res.ok) { const data = await res.json(); return data.choices?.[0]?.message?.content ?? null; }
    return null;
  } catch { return null; }
}

export async function POST(request: NextRequest) {
  try {
    const { questionId, mode }: RegenRequest = await request.json();
    if (!questionId || !mode) return NextResponse.json({ error: 'questionId and mode are required' }, { status: 400 });
    const supabase = createSupabaseApiClient();
    const { data: q, error: fetchErr } = await supabase.from(TABLE)
      .select('id, prompt, options, correct_answer, domain, difficulty_tier, chapter, subtopic, explanation')
      .eq('id', questionId).single();
    if (fetchErr || !q) return NextResponse.json({ error: 'Question not found' }, { status: 404 });
    const optionsText = q.options?.map((o: { id: string; text: string }) => `${o.id}) ${o.text}`).join('\n') ?? '';
    const questionContext = `Topic: ${q.chapter ?? q.domain ?? 'Unknown'}\nSubtopic: ${q.subtopic ?? 'Unknown'}\nDifficulty: ${q.difficulty_tier ?? 'Unknown'}\n\nQuestion: ${q.prompt}\n${optionsText ? `\nOptions:\n${optionsText}` : ''}\nCorrect answer: ${q.correct_answer}`;
    const systemPrompt = mode === 'theory'
      ? `You are an expert ${COURSE_LABEL} tutor. Provide the underlying theory (2-3 paragraphs) behind this question. Use plain text with Unicode math symbols.\n\n${questionContext}`
      : `You are an expert ${COURSE_LABEL} tutor. Explain this question step by step (3-6 sentences). Use plain text with Unicode math symbols.\n\n${questionContext}${q.explanation ? `\n\nOriginal explanation:\n${q.explanation}` : ''}`;
    const maxTokens = mode === 'theory' ? 800 : 500;
    const openaiKey = process.env.OPENAI_API_KEY;
    if (!openaiKey) return NextResponse.json({ error: 'No AI API key configured' }, { status: 500 });
    let text = await callOpenAI(openaiKey, systemPrompt, maxTokens, 'gpt-4o');
    if (!text) text = await callOpenAI(openaiKey, systemPrompt, maxTokens, 'gpt-4o-mini');
    if (!text) return NextResponse.json({ error: 'AI generation failed' }, { status: 500 });
    const cacheCol = mode === 'theory' ? 'ai_theory' : 'ai_explanation';
    await supabase.from(TABLE).update({ [cacheCol]: text }).eq('id', questionId);
    return NextResponse.json({ text, success: true });
  } catch (err) {
    console.error(`Error in POST /api/admin/${TABLE}/regenerate-ai:`, err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

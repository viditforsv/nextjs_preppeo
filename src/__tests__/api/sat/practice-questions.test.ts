import { describe, it, expect, vi, beforeEach } from 'vitest';
import { makeRequest } from '../../helpers/request-factory';
import { createMockSupabase, createMockAuthClient } from '../../helpers/supabase-mock';

const mockSupabase = createMockSupabase();
const mockAuthClient = createMockAuthClient({ id: 'user-1' });

vi.mock('@/lib/supabase/server', () => ({
  createClient: vi.fn().mockImplementation(() => Promise.resolve(mockAuthClient)),
}));
vi.mock('@/lib/supabase/api-client', () => ({
  createSupabaseApiClient: vi.fn(() => mockSupabase),
}));

import { GET } from '@/app/api/sat/practice-questions/route';

function makeQuestion(overrides: Record<string, unknown> = {}) {
  return {
    id: `q-${Math.random().toString(36).slice(2, 6)}`,
    type: 'mcq',
    prompt: 'Test prompt',
    passage: null,
    options: [{ id: 'A', text: 'a' }],
    correct_answer: 'A',
    explanation: 'Because.',
    domain: 'algebra',
    difficulty_tier: 'easy',
    image_url: null,
    image_urls: null,
    section: 'math',
    ...overrides,
  };
}

beforeEach(() => {
  vi.clearAllMocks();
  mockAuthClient.auth.getUser.mockResolvedValue({ data: { user: { id: 'user-1' } }, error: null });
  mockSupabase.mockTable('user_subscriptions', null);
  mockSupabase.mockTable('practice_daily_usage', null);
  mockSupabase.mockTable('sat_questions', []);
});

describe('GET /api/sat/practice-questions', () => {
  it('returns 401 when unauthenticated', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const res = await GET(makeRequest('/api/sat/practice-questions', { searchParams: { section: 'math' } }));
    expect(res.status).toBe(401);
  });

  it('returns 400 for invalid section', async () => {
    const res = await GET(makeRequest('/api/sat/practice-questions', { searchParams: { section: 'science' } }));
    expect(res.status).toBe(400);
  });

  it('returns 400 when section missing', async () => {
    const res = await GET(makeRequest('/api/sat/practice-questions'));
    expect(res.status).toBe(400);
  });

  it('premium user gets questions without daily limit', async () => {
    mockSupabase.mockTable('user_subscriptions', { id: 'sub-1' });

    const questions = Array.from({ length: 10 }, () => makeQuestion());
    // For premium path, the chain uses .then() after the query
    const qChain = mockSupabase.getTable('sat_questions') as { mockResult: (d: unknown, e?: unknown) => unknown };
    qChain.mockResult(questions);

    const res = await GET(makeRequest('/api/sat/practice-questions', { searchParams: { section: 'math', count: '5' } }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.isPremium).toBe(true);
    expect(json.questions.length).toBeGreaterThan(0);
    expect(json.questions.length).toBeLessThanOrEqual(5);
  });

  it('free user gets distribution capped by daily limits', async () => {
    const subChain = mockSupabase.getTable('user_subscriptions');
    (subChain.maybeSingle as ReturnType<typeof vi.fn>).mockResolvedValue({ data: null, error: null });

    mockSupabase.mockTable('practice_daily_usage', { id: null, easy_used: 0, medium_used: 0, hard_used: 0 });

    const easyQs = Array.from({ length: 5 }, () => makeQuestion({ difficulty_tier: 'easy' }));
    const medQs = Array.from({ length: 5 }, () => makeQuestion({ difficulty_tier: 'medium' }));
    const hardQs = Array.from({ length: 3 }, () => makeQuestion({ difficulty_tier: 'hard' }));

    // The freemium path fetches per-tier and uses .then() to filter
    const qChain = mockSupabase.getTable('sat_questions');
    // Each call to .then() will resolve with the chain result
    // We override to return different data per tier call
    (qChain.then as ReturnType<typeof vi.fn>)
      .mockImplementationOnce((resolve: (v: { data: unknown[] }) => void) => resolve({ data: easyQs }))
      .mockImplementationOnce((resolve: (v: { data: unknown[] }) => void) => resolve({ data: medQs }))
      .mockImplementationOnce((resolve: (v: { data: unknown[] }) => void) => resolve({ data: hardQs }));

    // Mock RPC to succeed
    mockSupabase.rpc.mockResolvedValue({ data: { ok: true, prev_easy: 0, prev_medium: 0, prev_hard: 0 }, error: null });

    const res = await GET(makeRequest('/api/sat/practice-questions', { searchParams: { section: 'math' } }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.isPremium).toBe(false);
    // 2 easy + 2 medium + 1 hard = 5
    expect(json.questions.length).toBe(5);
  });

  it('returns 403 when daily limit exhausted', async () => {
    const subChain = mockSupabase.getTable('user_subscriptions');
    (subChain.maybeSingle as ReturnType<typeof vi.fn>).mockResolvedValue({ data: null, error: null });

    mockSupabase.mockTable('practice_daily_usage', { id: 'u-1', easy_used: 2, medium_used: 2, hard_used: 1 });

    const res = await GET(makeRequest('/api/sat/practice-questions', { searchParams: { section: 'math' } }));
    const json = await res.json();
    expect(res.status).toBe(403);
    expect(json.error).toBe('daily_limit_reached');
    expect(json.remaining).toEqual({ easy: 0, medium: 0, hard: 0 });
  });

  it('returns 403 when claim_practice_usage RPC fails', async () => {
    const subChain = mockSupabase.getTable('user_subscriptions');
    (subChain.maybeSingle as ReturnType<typeof vi.fn>).mockResolvedValue({ data: null, error: null });

    mockSupabase.mockTable('practice_daily_usage', { id: null, easy_used: 0, medium_used: 0, hard_used: 0 });

    const easyQs = Array.from({ length: 5 }, () => makeQuestion({ difficulty_tier: 'easy' }));
    const qChain = mockSupabase.getTable('sat_questions');
    (qChain.then as ReturnType<typeof vi.fn>)
      .mockImplementationOnce((resolve: (v: { data: unknown[] }) => void) => resolve({ data: easyQs }))
      .mockImplementationOnce((resolve: (v: { data: unknown[] }) => void) => resolve({ data: [] }))
      .mockImplementationOnce((resolve: (v: { data: unknown[] }) => void) => resolve({ data: [] }));

    mockSupabase.rpc.mockResolvedValue({ data: { ok: false, prev_easy: 2, prev_medium: 2, prev_hard: 1 }, error: null });

    const res = await GET(makeRequest('/api/sat/practice-questions', { searchParams: { section: 'math' } }));
    expect(res.status).toBe(403);
  });
});

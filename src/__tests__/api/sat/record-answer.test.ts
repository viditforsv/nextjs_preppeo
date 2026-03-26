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

import { POST } from '@/app/api/sat/record-answer/route';

beforeEach(() => {
  vi.clearAllMocks();
  mockAuthClient.auth.getUser.mockResolvedValue({ data: { user: { id: 'user-1' } }, error: null });
  mockSupabase.mockTable('practice_answers', { id: 'pa-1' });
});

const validBody = {
  questionId: 'q-123',
  bankItemId: 'bank-456',
  answerGiven: 'A',
  isCorrect: true,
  domain: 'algebra',
  chapter: 'Linear Equations',
  subtopic: 'Slope',
  difficultyTier: 'medium',
  timeSpentMs: 12000,
};

describe('POST /api/sat/record-answer', () => {
  it('returns 401 when unauthenticated', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const req = makeRequest('/api/sat/record-answer', { method: 'POST', body: validBody });
    const res = await POST(req);
    expect(res.status).toBe(401);
  });

  it('returns 400 when questionId is missing', async () => {
    const req = makeRequest('/api/sat/record-answer', {
      method: 'POST',
      body: { ...validBody, questionId: undefined },
    });
    const res = await POST(req);
    expect(res.status).toBe(400);
  });

  it('returns 400 when isCorrect is missing', async () => {
    const req = makeRequest('/api/sat/record-answer', {
      method: 'POST',
      body: { questionId: 'q-1' },
    });
    const res = await POST(req);
    expect(res.status).toBe(400);
  });

  it('returns 200 and success on valid request', async () => {
    const req = makeRequest('/api/sat/record-answer', { method: 'POST', body: validBody });
    const res = await POST(req);
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.success).toBe(true);
  });

  it('returns 500 when supabase insert fails', async () => {
    mockSupabase.mockTable('practice_answers', null, { message: 'DB error' });
    const req = makeRequest('/api/sat/record-answer', { method: 'POST', body: validBody });
    const res = await POST(req);
    expect(res.status).toBe(500);
  });
});

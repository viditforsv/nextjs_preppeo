import { describe, it, expect, vi, beforeEach } from 'vitest';
import { createMockSupabase, createMockAuthClient } from '../../helpers/supabase-mock';

const mockSupabase = createMockSupabase();
const mockAuthClient = createMockAuthClient({ id: 'user-1' });

vi.mock('@/lib/supabase/server', () => ({
  createClient: vi.fn().mockImplementation(() => Promise.resolve(mockAuthClient)),
}));
vi.mock('@/lib/supabase/api-client', () => ({
  createSupabaseApiClient: vi.fn(() => mockSupabase),
}));

import { GET } from '@/app/api/sat/practice-usage/route';

beforeEach(() => {
  vi.clearAllMocks();
  mockAuthClient.auth.getUser.mockResolvedValue({ data: { user: { id: 'user-1' } }, error: null });
  mockSupabase.mockTable('user_subscriptions', null);
  mockSupabase.mockTable('practice_daily_usage', null);
});

describe('GET /api/sat/practice-usage', () => {
  it('returns 401 when unauthenticated', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const res = await GET();
    expect(res.status).toBe(401);
  });

  it('returns isPremium true for active subscriber', async () => {
    mockSupabase.mockTable('user_subscriptions', { id: 'sub-1', ends_at: new Date(Date.now() + 86400000).toISOString() });

    const res = await GET();
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.isPremium).toBe(true);
    expect(json.remaining).toBeNull();
  });

  it('returns correct remaining counts for free user with partial usage', async () => {
    // First call (active sub) returns null, second call (expired sub) returns null
    const subChain = mockSupabase.getTable('user_subscriptions');
    (subChain.maybeSingle as ReturnType<typeof vi.fn>)
      .mockResolvedValueOnce({ data: null, error: null })
      .mockResolvedValueOnce({ data: null, error: null });

    mockSupabase.mockTable('practice_daily_usage', { easy_used: 1, medium_used: 2, hard_used: 0 });

    const res = await GET();
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.isPremium).toBe(false);
    expect(json.remaining).toEqual({ easy: 1, medium: 0, hard: 1 });
  });

  it('returns full limits for free user with no usage today', async () => {
    const subChain = mockSupabase.getTable('user_subscriptions');
    (subChain.maybeSingle as ReturnType<typeof vi.fn>)
      .mockResolvedValueOnce({ data: null, error: null })
      .mockResolvedValueOnce({ data: null, error: null });

    mockSupabase.mockTable('practice_daily_usage', null);

    const res = await GET();
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.remaining).toEqual({ easy: 2, medium: 2, hard: 1 });
  });

  it('returns recentlyExpired true for lapsed subscriber', async () => {
    const subChain = mockSupabase.getTable('user_subscriptions');
    (subChain.maybeSingle as ReturnType<typeof vi.fn>)
      .mockResolvedValueOnce({ data: null, error: null })  // active sub check
      .mockResolvedValueOnce({ data: { id: 'old', ends_at: new Date(Date.now() - 3600000).toISOString() }, error: null }); // expired sub check

    mockSupabase.mockTable('practice_daily_usage', null);

    const res = await GET();
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.recentlyExpired).toBe(true);
  });
});

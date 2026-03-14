import { describe, it, expect, vi, beforeEach } from 'vitest';
import { makeRequest } from '../../helpers/request-factory';
import { createMockSupabase, createMockAuthClient } from '../../helpers/supabase-mock';

const mockSupabase = createMockSupabase();
const mockAuthClient = createMockAuthClient({ id: 'user-1', email: 'a@b.com' });

vi.mock('@/lib/supabase/server', () => ({
  createClient: vi.fn().mockImplementation(() => Promise.resolve(mockAuthClient)),
}));
vi.mock('@/lib/supabase/api-client', () => ({
  createSupabaseApiClient: vi.fn(() => mockSupabase),
}));
vi.mock('@/lib/tokens/generate', () => ({
  generateTokenCode: vi.fn(() => 'SAT-AAAA-BBBB'),
}));

import { POST } from '@/app/api/mocks/claim-free/route';

beforeEach(() => {
  vi.clearAllMocks();
  mockAuthClient.auth.getUser.mockResolvedValue({ data: { user: { id: 'user-1', email: 'a@b.com' } }, error: null });

  // Default: no existing token, exam exists, insert succeeds
  mockSupabase.mockTable('test_tokens', null);
  mockSupabase.mockTable('exam_types', { id: 'sat' });

  // Override insert chain to succeed
  const tokensChain = mockSupabase.getTable('test_tokens');
  (tokensChain.insert as ReturnType<typeof vi.fn>).mockReturnValue({
    select: vi.fn().mockReturnValue({
      single: vi.fn().mockResolvedValue({ data: { id: 'token-1' }, error: null }),
    }),
  });
});

describe('POST /api/mocks/claim-free', () => {
  it('returns 401 when unauthenticated', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const res = await POST(makeRequest('/api/mocks/claim-free', { method: 'POST', body: { examType: 'sat' } }));
    expect(res.status).toBe(401);
  });

  it('returns 400 when examType missing', async () => {
    const res = await POST(makeRequest('/api/mocks/claim-free', { method: 'POST', body: {} }));
    expect(res.status).toBe(400);
    expect((await res.json()).error).toMatch(/examType/i);
  });

  it('returns existing token on duplicate claim (idempotent)', async () => {
    mockSupabase.mockTable('test_tokens', { id: 'existing', code: 'SAT-OLD', set_number: 1 });

    const res = await POST(makeRequest('/api/mocks/claim-free', { method: 'POST', body: { examType: 'sat' } }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.alreadyClaimed).toBe(true);
    expect(json.code).toBe('SAT-OLD');
  });

  it('returns 400 for invalid exam type', async () => {
    mockSupabase.mockTable('test_tokens', null);
    mockSupabase.mockTable('exam_types', null);

    const res = await POST(makeRequest('/api/mocks/claim-free', { method: 'POST', body: { examType: 'invalid-exam' } }));
    expect(res.status).toBe(400);
  });

  it('creates new free token with set_number 1', async () => {
    mockSupabase.mockTable('test_tokens', null);
    mockSupabase.mockTable('exam_types', { id: 'sat' });

    const res = await POST(makeRequest('/api/mocks/claim-free', { method: 'POST', body: { examType: 'sat' } }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.alreadyClaimed).toBe(false);
    expect(json.setNumber).toBe(1);
    expect(json.code).toBe('SAT-AAAA-BBBB');
  });

  it('processes referral bonus when valid code provided', async () => {
    mockSupabase.mockTable('test_tokens', null);
    mockSupabase.mockTable('exam_types', { id: 'sat' });
    mockSupabase.mockTable('profiles', { id: 'referrer-1' });
    mockSupabase.mockTable('student_referrals', null);

    // Referral insert chain
    const referralsChain = mockSupabase.getTable('student_referrals');
    (referralsChain.insert as ReturnType<typeof vi.fn>).mockReturnValue(Promise.resolve({ data: null, error: null }));

    const res = await POST(makeRequest('/api/mocks/claim-free', { method: 'POST', body: { examType: 'sat', referralCode: 'REF123' } }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.bonusAwarded).toBe(true);
  });

  it('skips referral on self-referral', async () => {
    mockSupabase.mockTable('test_tokens', null);
    mockSupabase.mockTable('exam_types', { id: 'sat' });
    mockSupabase.mockTable('profiles', { id: 'user-1' }); // same as authenticated user

    const res = await POST(makeRequest('/api/mocks/claim-free', { method: 'POST', body: { examType: 'sat', referralCode: 'SELF' } }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.bonusAwarded).toBe(false);
  });

  it('skips referral when pair already exists', async () => {
    mockSupabase.mockTable('test_tokens', null);
    mockSupabase.mockTable('exam_types', { id: 'sat' });
    mockSupabase.mockTable('profiles', { id: 'referrer-1' });
    mockSupabase.mockTable('student_referrals', { id: 'existing-ref' });

    const res = await POST(makeRequest('/api/mocks/claim-free', { method: 'POST', body: { examType: 'sat', referralCode: 'REF123' } }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.bonusAwarded).toBe(false);
  });

  it('main claim succeeds even when referral processing throws', async () => {
    mockSupabase.mockTable('test_tokens', null);
    mockSupabase.mockTable('exam_types', { id: 'sat' });
    mockSupabase.mockTable('profiles', null); // profile lookup fails => processReferralBonus returns false

    const res = await POST(makeRequest('/api/mocks/claim-free', { method: 'POST', body: { examType: 'sat', referralCode: 'BAD' } }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.success).toBe(true);
    expect(json.bonusAwarded).toBe(false);
  });
});

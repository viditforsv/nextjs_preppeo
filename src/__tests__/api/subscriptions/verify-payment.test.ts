import { describe, it, expect, vi, beforeEach } from 'vitest';
import nodeCrypto from 'crypto';
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
vi.mock('@/lib/tokens/generate', () => ({
  generateBulkTokenCodes: vi.fn((_exam: string, count: number) =>
    Array.from({ length: count }, (_, i) => `SUB-TOK-${i}`),
  ),
}));

import { POST } from '@/app/api/subscriptions/verify-payment/route';

const SECRET = 'sub_test_secret';
function validSignature(orderId: string, paymentId: string) {
  return nodeCrypto.createHmac('sha256', SECRET).update(`${orderId}|${paymentId}`).digest('hex');
}

const basePurchase = {
  id: 'purchase-1', user_id: 'user-1', status: 'pending', amount: 999, partner_id: null, discount_applied: 0,
};
const basePlan = {
  id: 'plan-1', name: 'Monthly', price: 999, plan_type: 'practice', duration_days: 30, exam_type: 'sat', mock_tokens_included: 0,
};

beforeEach(() => {
  vi.clearAllMocks();
  process.env.RAZORPAY_KEY_SECRET = SECRET;
  mockAuthClient.auth.getUser.mockResolvedValue({ data: { user: { id: 'user-1' } }, error: null });

  mockSupabase.mockTable('token_purchases', { ...basePurchase });
  mockSupabase.mockTable('subscription_plans', { ...basePlan });

  const subChain = mockSupabase.getTable('user_subscriptions');
  (subChain.insert as ReturnType<typeof vi.fn>).mockResolvedValue({ data: null, error: null });

  const purchaseChain = mockSupabase.getTable('token_purchases');
  (purchaseChain.update as ReturnType<typeof vi.fn>).mockReturnValue({
    eq: vi.fn().mockResolvedValue({ data: null, error: null }),
  });
});

describe('POST /api/subscriptions/verify-payment', () => {
  it('returns 400 when required fields missing', async () => {
    const res = await POST(makeRequest('/api/subscriptions/verify-payment', { method: 'POST', body: { orderId: 'o1' } }));
    expect(res.status).toBe(400);
  });

  it('returns 400 on invalid signature', async () => {
    const res = await POST(makeRequest('/api/subscriptions/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: 'wrong', purchaseId: 'purchase-1', planId: 'plan-1' },
    }));
    expect(res.status).toBe(400);
  });

  it('returns 401 when unauthenticated', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const sig = validSignature('o1', 'p1');
    const res = await POST(makeRequest('/api/subscriptions/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1', planId: 'plan-1' },
    }));
    expect(res.status).toBe(401);
  });

  it('returns 409 when already completed', async () => {
    mockSupabase.mockTable('token_purchases', { ...basePurchase, status: 'completed' });
    const sig = validSignature('o1', 'p1');
    const res = await POST(makeRequest('/api/subscriptions/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1', planId: 'plan-1' },
    }));
    expect(res.status).toBe(409);
  });

  it('creates subscription with correct dates', async () => {
    const sig = validSignature('o1', 'p1');
    const before = Date.now();
    const res = await POST(makeRequest('/api/subscriptions/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1', planId: 'plan-1' },
    }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.success).toBe(true);
    expect(json.planName).toBe('Monthly');

    const endsAt = new Date(json.endsAt).getTime();
    expect(endsAt).toBeGreaterThan(before + 29 * 24 * 60 * 60 * 1000);
    expect(endsAt).toBeLessThanOrEqual(before + 31 * 24 * 60 * 60 * 1000);
  });

  it('generates mock tokens for bundle plan', async () => {
    mockSupabase.mockTable('subscription_plans', { ...basePlan, plan_type: 'bundle', mock_tokens_included: 5 });
    mockSupabase.mockTable('exam_types', { total_sets: 4 });

    const tokensChain = mockSupabase.getTable('test_tokens');
    (tokensChain.insert as ReturnType<typeof vi.fn>).mockResolvedValue({ data: null, error: null });

    const sig = validSignature('o1', 'p1');
    const res = await POST(makeRequest('/api/subscriptions/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1', planId: 'plan-1' },
    }));
    const json = await res.json();
    expect(json.tokens).toHaveLength(5);
  });

  it('records partner commission when referral was used', async () => {
    mockSupabase.mockTable('token_purchases', { ...basePurchase, partner_id: 'partner-1' });
    mockSupabase.mockTable('partners', { commission_rate: 25 });

    const commChain = mockSupabase.getTable('partner_commissions');
    (commChain.insert as ReturnType<typeof vi.fn>).mockResolvedValue({ data: null, error: null });

    const sig = validSignature('o1', 'p1');
    await POST(makeRequest('/api/subscriptions/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1', planId: 'plan-1' },
    }));

    expect((commChain.insert as ReturnType<typeof vi.fn>)).toHaveBeenCalledWith(
      expect.objectContaining({ partner_id: 'partner-1', status: 'pending' }),
    );
  });
});

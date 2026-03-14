import { describe, it, expect, vi, beforeEach } from 'vitest';
import nodeCrypto from 'crypto';
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
  generateBulkTokenCodes: vi.fn((_exam: string, count: number) =>
    Array.from({ length: count }, (_, i) => `TOK-${i}`),
  ),
}));
vi.mock('@/lib/email/send', () => ({
  sendTransactionalEmail: vi.fn().mockResolvedValue(undefined),
}));

import { POST } from '@/app/api/mocks/verify-payment/route';

const SECRET = 'test_secret_key';
function validSignature(orderId: string, paymentId: string) {
  return nodeCrypto.createHmac('sha256', SECRET).update(`${orderId}|${paymentId}`).digest('hex');
}

const basePurchase = {
  id: 'purchase-1',
  user_id: 'user-1',
  pack_id: 'pack-1',
  status: 'pending',
  amount: 499,
  partner_id: null,
  discount_applied: 0,
  token_packs: { exam_type: 'sat', token_count: 3, name: 'SAT 3-Pack', price: 499 },
};

beforeEach(() => {
  vi.clearAllMocks();
  process.env.RAZORPAY_KEY_SECRET = SECRET;
  mockAuthClient.auth.getUser.mockResolvedValue({ data: { user: { id: 'user-1', email: 'a@b.com' } }, error: null });

  mockSupabase.mockTable('token_purchases', { ...basePurchase });
  mockSupabase.mockTable('exam_types', { total_sets: 4 });

  const tokensChain = mockSupabase.getTable('test_tokens');
  (tokensChain.insert as ReturnType<typeof vi.fn>).mockResolvedValue({ data: null, error: null });

  const purchaseChain = mockSupabase.getTable('token_purchases');
  (purchaseChain.update as ReturnType<typeof vi.fn>).mockReturnValue({
    eq: vi.fn().mockResolvedValue({ data: null, error: null }),
  });
});

describe('POST /api/mocks/verify-payment', () => {
  it('returns 400 when required fields missing', async () => {
    const res = await POST(makeRequest('/api/mocks/verify-payment', { method: 'POST', body: { orderId: 'o1' } }));
    expect(res.status).toBe(400);
  });

  it('returns 400 on invalid HMAC signature', async () => {
    const res = await POST(makeRequest('/api/mocks/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: 'bad', purchaseId: 'purchase-1' },
    }));
    expect(res.status).toBe(400);
    expect((await res.json()).error).toMatch(/signature/i);
  });

  it('returns 401 when unauthenticated', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const sig = validSignature('o1', 'p1');
    const res = await POST(makeRequest('/api/mocks/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1' },
    }));
    expect(res.status).toBe(401);
  });

  it('returns 403 when purchase belongs to different user', async () => {
    mockSupabase.mockTable('token_purchases', { ...basePurchase, user_id: 'other-user' });
    const sig = validSignature('o1', 'p1');
    const res = await POST(makeRequest('/api/mocks/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1' },
    }));
    expect(res.status).toBe(403);
  });

  it('returns 409 when purchase already completed', async () => {
    mockSupabase.mockTable('token_purchases', { ...basePurchase, status: 'completed' });
    const sig = validSignature('o1', 'p1');
    const res = await POST(makeRequest('/api/mocks/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1' },
    }));
    expect(res.status).toBe(409);
  });

  it('generates correct number of tokens on valid signature', async () => {
    const sig = validSignature('o1', 'p1');
    const res = await POST(makeRequest('/api/mocks/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1' },
    }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.success).toBe(true);
    expect(json.tokens).toHaveLength(3);
    expect(json.count).toBe(3);
  });

  it('creates partner commission when referral used', async () => {
    mockSupabase.mockTable('token_purchases', { ...basePurchase, partner_id: 'partner-1' });
    mockSupabase.mockTable('partners', { commission_rate: 30 });

    const commChain = mockSupabase.getTable('partner_commissions');
    (commChain.insert as ReturnType<typeof vi.fn>).mockResolvedValue({ data: null, error: null });

    const sig = validSignature('o1', 'p1');
    await POST(makeRequest('/api/mocks/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1' },
    }));

    expect((commChain.insert as ReturnType<typeof vi.fn>)).toHaveBeenCalledWith(
      expect.objectContaining({
        partner_id: 'partner-1',
        purchase_id: 'purchase-1',
        status: 'pending',
      }),
    );
  });

  it('updates purchase status to completed', async () => {
    const sig = validSignature('o1', 'p1');
    await POST(makeRequest('/api/mocks/verify-payment', {
      method: 'POST',
      body: { orderId: 'o1', paymentId: 'p1', signature: sig, purchaseId: 'purchase-1' },
    }));

    const updateFn = mockSupabase.getTable('token_purchases').update as ReturnType<typeof vi.fn>;
    expect(updateFn).toHaveBeenCalledWith(
      expect.objectContaining({ status: 'completed', razorpay_payment_id: 'p1' }),
    );
  });
});

import { describe, it, expect, vi, beforeEach } from 'vitest';
import { makeRequest } from '../../helpers/request-factory';
import { createMockSupabase, createMockAuthClient } from '../../helpers/supabase-mock';
import crypto from 'crypto';

const mockSupabase = createMockSupabase();
const mockAuthClient = createMockAuthClient({ id: 'user-1', email: 'test@example.com' });

vi.mock('@/lib/supabase/server', () => ({
  createClient: vi.fn().mockImplementation(() => Promise.resolve(mockAuthClient)),
}));
vi.mock('@/lib/supabase/api-client', () => ({
  createSupabaseApiClient: vi.fn(() => mockSupabase),
}));

const mockPaymentFetch = vi.fn().mockResolvedValue({ status: 'captured', amount: 99900, currency: 'INR' });
vi.mock('razorpay', () => ({
  default: vi.fn().mockImplementation(() => ({
    payments: { fetch: mockPaymentFetch },
  })),
}));

const KEY_SECRET = 'test_secret';

function makeSignature(orderId: string, paymentId: string): string {
  return crypto.createHmac('sha256', KEY_SECRET).update(`${orderId}|${paymentId}`).digest('hex');
}

beforeEach(() => {
  vi.clearAllMocks();
  mockAuthClient.auth.getUser.mockResolvedValue({
    data: { user: { id: 'user-1', email: 'test@example.com' } },
    error: null,
  });
  mockPaymentFetch.mockResolvedValue({ status: 'captured', amount: 99900, currency: 'INR' });
  mockSupabase.mockTable('courses_enrollments', { id: 'enr-1' });
  mockSupabase.mockTable('payments', { id: 'pay-1' });
  process.env.RAZORPAY_KEY_SECRET = KEY_SECRET;
  process.env.RAZORPAY_KEY_ID = 'rzp_test_key';
});

import { POST } from '@/app/api/payments/verify-razorpay/route';

describe('POST /api/payments/verify-razorpay', () => {
  it('returns 400 when required fields are missing', async () => {
    const req = makeRequest('/api/payments/verify-razorpay', {
      method: 'POST',
      body: { orderId: 'ord_1' },
    });
    const res = await POST(req);
    expect(res.status).toBe(400);
  });

  it('returns 400 when signature is invalid', async () => {
    const req = makeRequest('/api/payments/verify-razorpay', {
      method: 'POST',
      body: { orderId: 'ord_1', paymentId: 'pay_1', signature: 'bad_signature', courseId: 'course-1' },
    });
    const res = await POST(req);
    expect(res.status).toBe(400);
    const json = await res.json();
    expect(json.error).toMatch(/signature/i);
  });

  it('returns 400 when payment status is not captured', async () => {
    mockPaymentFetch.mockResolvedValueOnce({ status: 'failed', amount: 99900, currency: 'INR' });
    const orderId = 'ord_1';
    const paymentId = 'pay_1';
    const sig = makeSignature(orderId, paymentId);
    const req = makeRequest('/api/payments/verify-razorpay', {
      method: 'POST',
      body: { orderId, paymentId, signature: sig, courseId: 'course-1' },
    });
    const res = await POST(req);
    expect(res.status).toBe(400);
    const json = await res.json();
    expect(json.error).toMatch(/not completed/i);
  });

  it('returns 200 and creates enrollment on valid captured payment', async () => {
    const orderId = 'ord_1';
    const paymentId = 'pay_1';
    const sig = makeSignature(orderId, paymentId);
    const req = makeRequest('/api/payments/verify-razorpay', {
      method: 'POST',
      body: { orderId, paymentId, signature: sig, courseId: 'course-1' },
    });
    const res = await POST(req);
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.success).toBe(true);
    expect(json.paymentId).toBe(paymentId);
  });
});

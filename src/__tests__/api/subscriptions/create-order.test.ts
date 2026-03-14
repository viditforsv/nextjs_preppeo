import { describe, it, expect, vi, beforeEach } from 'vitest';
import { makeRequest } from '../../helpers/request-factory';
import { createMockSupabase, createMockAuthClient } from '../../helpers/supabase-mock';

const mockSupabase = createMockSupabase();
const mockAuthClient = createMockAuthClient({ id: 'user-1' });

const mockRazorpayCreate = vi.fn();
vi.mock('razorpay', () => ({
  default: vi.fn().mockImplementation(() => ({
    orders: { create: mockRazorpayCreate },
  })),
}));

vi.mock('@/lib/supabase/server', () => ({
  createClient: vi.fn().mockImplementation(() => Promise.resolve(mockAuthClient)),
}));
vi.mock('@/lib/supabase/api-client', () => ({
  createSupabaseApiClient: vi.fn(() => mockSupabase),
}));

import { POST } from '@/app/api/subscriptions/create-order/route';

beforeEach(() => {
  vi.clearAllMocks();
  process.env.RAZORPAY_KEY_ID = 'rzp_test_key';
  process.env.RAZORPAY_KEY_SECRET = 'rzp_test_secret';
  mockAuthClient.auth.getUser.mockResolvedValue({ data: { user: { id: 'user-1' } }, error: null });

  mockSupabase.mockTable('subscription_plans', {
    id: 'plan-1', name: 'Monthly', price: 999, is_active: true, plan_type: 'practice', duration_days: 30,
  });

  const purchaseChain = mockSupabase.getTable('token_purchases');
  (purchaseChain.insert as ReturnType<typeof vi.fn>).mockReturnValue({
    select: vi.fn().mockReturnValue({
      single: vi.fn().mockResolvedValue({ data: { id: 'purchase-1' }, error: null }),
    }),
  });
  (purchaseChain.update as ReturnType<typeof vi.fn>).mockReturnValue({
    eq: vi.fn().mockResolvedValue({ data: null, error: null }),
  });

  mockRazorpayCreate.mockResolvedValue({ id: 'order_rzp_sub_1' });
});

describe('POST /api/subscriptions/create-order', () => {
  it('returns 400 when planId missing', async () => {
    const res = await POST(makeRequest('/api/subscriptions/create-order', { method: 'POST', body: {} }));
    expect(res.status).toBe(400);
  });

  it('returns 401 when unauthenticated', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const res = await POST(makeRequest('/api/subscriptions/create-order', { method: 'POST', body: { planId: 'plan-1' } }));
    expect(res.status).toBe(401);
  });

  it('returns 404 when plan not found', async () => {
    mockSupabase.mockTable('subscription_plans', null);
    const res = await POST(makeRequest('/api/subscriptions/create-order', { method: 'POST', body: { planId: 'bad' } }));
    expect(res.status).toBe(404);
  });

  it('creates Razorpay order and returns success', async () => {
    const res = await POST(makeRequest('/api/subscriptions/create-order', { method: 'POST', body: { planId: 'plan-1' } }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.success).toBe(true);
    expect(json.orderId).toBe('order_rzp_sub_1');
    expect(json.amount).toBe(999);
    expect(mockRazorpayCreate).toHaveBeenCalledWith(
      expect.objectContaining({ amount: 99900, currency: 'INR' }),
    );
  });

  it('applies referral discount correctly', async () => {
    mockSupabase.mockTable('partners', { id: 'partner-1', discount_rate: 20 });
    const res = await POST(makeRequest('/api/subscriptions/create-order', {
      method: 'POST',
      body: { planId: 'plan-1', referralCode: 'DISC20' },
    }));
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.discountApplied).toBeCloseTo(199.8);
    expect(json.amount).toBeCloseTo(799.2);
  });

  it('handles Razorpay failure gracefully', async () => {
    mockRazorpayCreate.mockRejectedValueOnce(new Error('Gateway timeout'));
    const res = await POST(makeRequest('/api/subscriptions/create-order', { method: 'POST', body: { planId: 'plan-1' } }));
    expect(res.status).toBe(500);
  });
});

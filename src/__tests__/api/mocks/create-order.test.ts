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

import { POST } from '@/app/api/mocks/create-order/route';

beforeEach(() => {
  vi.clearAllMocks();
  process.env.RAZORPAY_KEY_ID = 'rzp_test_key';
  process.env.RAZORPAY_KEY_SECRET = 'rzp_test_secret';

  mockAuthClient.auth.getUser.mockResolvedValue({ data: { user: { id: 'user-1' } }, error: null });

  mockSupabase.mockTable('token_packs', {
    id: 'pack-1', exam_type: 'sat', name: 'SAT 3-Pack', token_count: 3, price: 499, is_active: true,
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

  mockRazorpayCreate.mockResolvedValue({ id: 'order_rzp_123' });
});

describe('POST /api/mocks/create-order', () => {
  it('returns 400 when packId missing', async () => {
    const res = await POST(makeRequest('/api/mocks/create-order', { method: 'POST', body: {} }));
    expect(res.status).toBe(400);
  });

  it('returns 401 when unauthenticated', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const res = await POST(makeRequest('/api/mocks/create-order', { method: 'POST', body: { packId: 'pack-1' } }));
    expect(res.status).toBe(401);
  });

  it('returns 404 when pack not found', async () => {
    mockSupabase.mockTable('token_packs', null);

    const res = await POST(makeRequest('/api/mocks/create-order', { method: 'POST', body: { packId: 'nonexistent' } }));
    expect(res.status).toBe(404);
  });

  it('creates Razorpay order with correct amount in paise', async () => {
    const res = await POST(makeRequest('/api/mocks/create-order', { method: 'POST', body: { packId: 'pack-1' } }));
    const json = await res.json();

    expect(res.status).toBe(200);
    expect(json.success).toBe(true);
    expect(json.orderId).toBe('order_rzp_123');
    expect(json.amount).toBe(499);
    expect(mockRazorpayCreate).toHaveBeenCalledWith(
      expect.objectContaining({ amount: 49900, currency: 'INR' }),
    );
  });

  it('applies referral discount correctly', async () => {
    mockSupabase.mockTable('partners', { id: 'partner-1', discount_rate: 10 });

    const res = await POST(makeRequest('/api/mocks/create-order', {
      method: 'POST',
      body: { packId: 'pack-1', referralCode: 'PARTNER10' },
    }));
    const json = await res.json();

    expect(res.status).toBe(200);
    expect(json.discountApplied).toBeCloseTo(49.9);
    expect(json.amount).toBeCloseTo(449.1);
  });

  it('handles Razorpay API failure gracefully', async () => {
    mockRazorpayCreate.mockRejectedValueOnce(new Error('Razorpay down'));

    const res = await POST(makeRequest('/api/mocks/create-order', { method: 'POST', body: { packId: 'pack-1' } }));
    expect(res.status).toBe(500);
    const json = await res.json();
    expect(json.error).toMatch(/Razorpay down/);
  });

  it('inserts token_purchases row with pending status', async () => {
    await POST(makeRequest('/api/mocks/create-order', { method: 'POST', body: { packId: 'pack-1' } }));

    const insertFn = mockSupabase.getTable('token_purchases').insert as ReturnType<typeof vi.fn>;
    expect(insertFn).toHaveBeenCalledWith(
      expect.objectContaining({ user_id: 'user-1', status: 'pending' }),
    );
  });
});

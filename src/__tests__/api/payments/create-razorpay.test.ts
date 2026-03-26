import { describe, it, expect, vi, beforeEach } from 'vitest';
import { makeRequest } from '../../helpers/request-factory';
import { createMockAuthClient } from '../../helpers/supabase-mock';

const mockAuthClient = createMockAuthClient({ id: 'user-1', email: 'test@example.com' });

vi.mock('@/lib/supabase/server', () => ({
  createClient: vi.fn().mockImplementation(() => Promise.resolve(mockAuthClient)),
}));

// Mock Razorpay constructor
const mockOrderCreate = vi.fn().mockResolvedValue({ id: 'order_test123' });
vi.mock('razorpay', () => ({
  default: vi.fn().mockImplementation(() => ({
    orders: { create: mockOrderCreate },
  })),
}));

import { POST } from '@/app/api/payments/create-razorpay/route';

beforeEach(() => {
  vi.clearAllMocks();
  mockAuthClient.auth.getUser.mockResolvedValue({
    data: { user: { id: 'user-1', email: 'test@example.com' } },
    error: null,
  });
  mockOrderCreate.mockResolvedValue({ id: 'order_test123' });
  process.env.RAZORPAY_KEY_ID = 'rzp_test_key';
  process.env.RAZORPAY_KEY_SECRET = 'test_secret';
});

describe('POST /api/payments/create-razorpay', () => {
  it('returns 400 when required fields are missing', async () => {
    const req = makeRequest('/api/payments/create-razorpay', {
      method: 'POST',
      body: { currency: 'INR' },
    });
    const res = await POST(req);
    expect(res.status).toBe(400);
  });

  it('returns 400 when amount is negative', async () => {
    const req = makeRequest('/api/payments/create-razorpay', {
      method: 'POST',
      body: { amount: -100, currency: 'INR', courseId: 'course-1' },
    });
    const res = await POST(req);
    expect(res.status).toBe(400);
    const json = await res.json();
    expect(json.error).toMatch(/invalid amount/i);
  });

  it('returns 400 when currency format is invalid', async () => {
    const req = makeRequest('/api/payments/create-razorpay', {
      method: 'POST',
      body: { amount: 999, currency: 'inr', courseId: 'course-1' },
    });
    const res = await POST(req);
    expect(res.status).toBe(400);
    const json = await res.json();
    expect(json.error).toMatch(/invalid currency/i);
  });

  it('returns 200 with orderId on valid request', async () => {
    const req = makeRequest('/api/payments/create-razorpay', {
      method: 'POST',
      body: { amount: 999, currency: 'INR', courseId: 'course-1', courseName: 'SAT Prep' },
    });
    const res = await POST(req);
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.success).toBe(true);
    expect(json.orderId).toBe('order_test123');
  });

  it('returns 500 when Razorpay credentials are not configured', async () => {
    delete process.env.RAZORPAY_KEY_ID;
    delete process.env.RAZORPAY_KEY_SECRET;
    const req = makeRequest('/api/payments/create-razorpay', {
      method: 'POST',
      body: { amount: 999, currency: 'INR', courseId: 'course-1' },
    });
    const res = await POST(req);
    expect(res.status).toBe(500);
  });
});

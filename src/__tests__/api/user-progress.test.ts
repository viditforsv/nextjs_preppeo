import { describe, it, expect, vi, beforeEach } from 'vitest';
import { makeRequest } from '../helpers/request-factory';
import { createMockSupabase, createMockAuthClient } from '../helpers/supabase-mock';

const mockSupabase = createMockSupabase();
const mockAuthClient = createMockAuthClient({ id: 'user-1' });

vi.mock('@/lib/supabase/server', () => ({
  createClient: vi.fn().mockImplementation(() => Promise.resolve({
    ...mockAuthClient,
    from: mockSupabase.from,
  })),
}));

import { GET, POST, PUT } from '@/app/api/user-progress/route';

beforeEach(() => {
  vi.clearAllMocks();
  mockAuthClient.auth.getUser.mockResolvedValue({ data: { user: { id: 'user-1' } }, error: null });
  mockSupabase.mockTable('profiles', { role: 'student' });
  mockSupabase.mockTable('user_progress', []);
  mockSupabase.mockTable('courses', { id: 'course-1', price: 0 });
  mockSupabase.mockTable('courses_enrollments', null);
});

describe('GET /api/user-progress', () => {
  it('returns empty progress for unauthenticated user', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const req = makeRequest('/api/user-progress');
    const res = await GET(req);
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.progress).toEqual([]);
  });

  it('returns progress array for authenticated user', async () => {
    const progressRows = [{ id: 'p-1', is_completed: true }];
    mockSupabase.mockTable('user_progress', progressRows);
    const req = makeRequest('/api/user-progress');
    const res = await GET(req);
    const json = await res.json();
    expect(res.status).toBe(200);
    expect(json.progress).toEqual(progressRows);
  });
});

describe('POST /api/user-progress', () => {
  it('returns 400 when lesson_id or course_id is missing', async () => {
    const req = makeRequest('/api/user-progress', {
      method: 'POST',
      body: { completion_percentage: 50 },
    });
    const res = await POST(req);
    expect(res.status).toBe(400);
  });

  it('returns 401 when unauthenticated', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const req = makeRequest('/api/user-progress', {
      method: 'POST',
      body: { lesson_id: 'l-1', course_id: 'c-1' },
    });
    const res = await POST(req);
    expect(res.status).toBe(401);
  });

  it('returns 404 when course is not found', async () => {
    mockSupabase.mockTable('courses', null);
    const req = makeRequest('/api/user-progress', {
      method: 'POST',
      body: { lesson_id: 'l-1', course_id: 'c-1' },
    });
    const res = await POST(req);
    expect(res.status).toBe(404);
  });

  it('returns 403 for paid course when user is not enrolled', async () => {
    mockSupabase.mockTable('courses', { id: 'c-1', price: 999 });
    mockSupabase.mockTable('courses_enrollments', null); // no enrollment
    const req = makeRequest('/api/user-progress', {
      method: 'POST',
      body: { lesson_id: 'l-1', course_id: 'c-1' },
    });
    const res = await POST(req);
    expect(res.status).toBe(403);
  });
});

describe('PUT /api/user-progress', () => {
  it('returns 400 when id is missing', async () => {
    const req = makeRequest('/api/user-progress', {
      method: 'PUT',
      body: { completion_percentage: 100 },
    });
    const res = await PUT(req);
    expect(res.status).toBe(400);
  });

  it('returns 401 when unauthenticated', async () => {
    mockAuthClient.auth.getUser.mockResolvedValueOnce({ data: { user: null }, error: { message: 'No session' } });
    const req = makeRequest('/api/user-progress', {
      method: 'PUT',
      body: { id: 'p-1', completion_percentage: 100 },
    });
    const res = await PUT(req);
    expect(res.status).toBe(401);
  });

  it('returns 404 when progress record is not found', async () => {
    mockSupabase.mockTable('user_progress', null);
    const req = makeRequest('/api/user-progress', {
      method: 'PUT',
      body: { id: 'p-nonexistent', completion_percentage: 100 },
    });
    const res = await PUT(req);
    expect(res.status).toBe(404);
  });

  it('returns 403 when user does not own the progress record', async () => {
    mockSupabase.mockTable('user_progress', { user_id: 'other-user' });
    const req = makeRequest('/api/user-progress', {
      method: 'PUT',
      body: { id: 'p-1', completion_percentage: 100 },
    });
    const res = await PUT(req);
    expect(res.status).toBe(403);
  });
});

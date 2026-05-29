import { describe, it, expect } from 'vitest';
import { canAccessRoute, getRedirectPath, ROUTE_ACCESS } from '@/lib/access-control';

// Regression guard for the 2026-04 admin redirect loop (commit 497e58d): an
// authenticated user was treated as anonymous and bounced to /auth, which sent
// them back to the protected route → infinite loop. The invariant below holds
// for ANY protected route, so it auto-covers routes added to ROUTE_ACCESS later.
describe('getRedirectPath — anti-loop invariant: an authenticated user is NEVER sent to /auth', () => {
  // The role that legitimately satisfies each access level.
  const roleFor = { student: 'student', admin: 'admin', authenticated: 'student' } as const;

  const protectedRoutes = ROUTE_ACCESS.filter((r) => r.accessLevel !== 'public');

  for (const route of protectedRoutes) {
    const role = (roleFor as Record<string, string>)[route.accessLevel] ?? route.requiredRole;
    it(`does not redirect an authenticated ${role ?? 'user'} on ${route.path} to /auth`, () => {
      expect(getRedirectPath(route.path, role as never, true)).not.toBe('/auth');
    });
  }

  it('only ever sends ANONYMOUS users to /auth', () => {
    for (const route of protectedRoutes) {
      // Anonymous → /auth is correct; authenticated → /auth is the loop bug.
      expect(getRedirectPath(route.path, undefined, false)).toBe('/auth');
    }
  });
});

describe('canAccessRoute — public routes', () => {
  it('allows anonymous access to home', () => {
    expect(canAccessRoute('/', undefined, false)).toBe(true);
  });

  it('allows anonymous access to /sat-free landing', () => {
    expect(canAccessRoute('/sat-free', undefined, false)).toBe(true);
  });

  it('allows anonymous access to /auth', () => {
    expect(canAccessRoute('/auth', undefined, false)).toBe(true);
  });

  it('allows anonymous access to /courses (catalogue)', () => {
    expect(canAccessRoute('/courses', undefined, false)).toBe(true);
  });

  it('allows access to an unmatched path (no rule = allow)', () => {
    expect(canAccessRoute('/some-random-page', undefined, false)).toBe(true);
  });
});

describe('canAccessRoute — authenticated routes', () => {
  it('blocks anonymous access to /profile', () => {
    expect(canAccessRoute('/profile', undefined, false)).toBe(false);
  });

  it('blocks anonymous access to /courses/enrolled', () => {
    expect(canAccessRoute('/courses/enrolled', undefined, false)).toBe(false);
  });

  it('allows any logged-in user to /profile', () => {
    expect(canAccessRoute('/profile', 'student', true)).toBe(true);
    expect(canAccessRoute('/profile', 'admin', true)).toBe(true);
  });

  it('allows logged-in user to /courses/enrolled regardless of role', () => {
    expect(canAccessRoute('/courses/enrolled', 'student', true)).toBe(true);
    expect(canAccessRoute('/courses/enrolled', 'admin', true)).toBe(true);
  });
});

describe('canAccessRoute — admin routes', () => {
  it('blocks anonymous access to /admin', () => {
    expect(canAccessRoute('/admin', undefined, false)).toBe(false);
  });

  it('blocks anonymous access to /admin/site-administration', () => {
    expect(canAccessRoute('/admin/site-administration', undefined, false)).toBe(false);
  });

  it('blocks signed-in non-admin from /admin', () => {
    expect(canAccessRoute('/admin', 'student', true)).toBe(false);
  });

  it('allows signed-in admin into /admin', () => {
    expect(canAccessRoute('/admin', 'admin', true)).toBe(true);
  });

  it('allows admin into /admin/site-administration', () => {
    expect(canAccessRoute('/admin/site-administration', 'admin', true)).toBe(true);
  });
});

describe('canAccessRoute — student routes', () => {
  it('blocks anonymous access to /student', () => {
    expect(canAccessRoute('/student', undefined, false)).toBe(false);
  });

  it('blocks signed-in admin from /student (student-only)', () => {
    expect(canAccessRoute('/student', 'admin', true)).toBe(false);
  });

  it('allows signed-in student into /student', () => {
    expect(canAccessRoute('/student', 'student', true)).toBe(true);
  });
});

describe('getRedirectPath — anonymous user hits a protected route', () => {
  it('redirects anon from /profile to /auth', () => {
    expect(getRedirectPath('/profile', undefined, false)).toBe('/auth');
  });

  it('redirects anon from /admin to /auth', () => {
    expect(getRedirectPath('/admin', undefined, false)).toBe('/auth');
  });

  it('redirects anon from /admin/site-administration to /auth', () => {
    expect(getRedirectPath('/admin/site-administration', undefined, false)).toBe('/auth');
  });

  it('redirects anon from /student to /auth', () => {
    expect(getRedirectPath('/student', undefined, false)).toBe('/auth');
  });
});

describe('getRedirectPath — wrong role hits a role-restricted route', () => {
  it('redirects signed-in non-admin away from /admin to /courses/enrolled', () => {
    expect(getRedirectPath('/admin', 'student', true)).toBe('/courses/enrolled');
  });

  it('redirects signed-in non-student away from /student to /courses/enrolled', () => {
    expect(getRedirectPath('/student', 'admin', true)).toBe('/courses/enrolled');
  });
});

describe('getRedirectPath — happy path returns null (no redirect)', () => {
  it('returns null for a public route, no auth', () => {
    expect(getRedirectPath('/', undefined, false)).toBeNull();
  });

  it('returns null for /profile when authenticated', () => {
    expect(getRedirectPath('/profile', 'student', true)).toBeNull();
  });

  it('returns null for /admin when admin', () => {
    expect(getRedirectPath('/admin', 'admin', true)).toBeNull();
  });

  it('returns null for /student when student', () => {
    expect(getRedirectPath('/student', 'student', true)).toBeNull();
  });

  it('returns null for an unmatched path', () => {
    expect(getRedirectPath('/some-random-page', undefined, false)).toBeNull();
  });
});

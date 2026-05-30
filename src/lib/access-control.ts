import { UserRole } from "@/types/auth";

// Define access levels
export type AccessLevel = "public" | "authenticated" | "student" | "admin";

// Course access types
export type CourseAccess = "free" | "paid" | "enrolled";

// Route access configuration
export interface RouteAccess {
  path: string;
  accessLevel: AccessLevel;
  requiredRole?: UserRole;
  requiredPermission?: string;
  redirectTo?: string;
}

// Course access configuration
export interface CourseAccessConfig {
  courseId: string;
  accessType: CourseAccess;
  requiredRole?: UserRole;
  previewAvailable: boolean;
}

// Define all route access rules
export const ROUTE_ACCESS: RouteAccess[] = [
  // Public routes (accessible to everyone)
  { path: "/", accessLevel: "public" },
  { path: "/courses", accessLevel: "public" },
  { path: "/courses/discover", accessLevel: "public" },
  { path: "/courses/free", accessLevel: "public" },
  { path: "/courses/cbse-mathematics-class-10", accessLevel: "public" },
  { path: "/courses/cbse", accessLevel: "public" },
  { path: "/courses/ibdp", accessLevel: "public" },
  { path: "/courses/icse", accessLevel: "public" },
  { path: "/courses/igcse", accessLevel: "public" },
  { path: "/courses/isc", accessLevel: "public" },
  { path: "/contact", accessLevel: "public" },
  { path: "/auth", accessLevel: "public" },
  { path: "/auth/callback", accessLevel: "public" },
  { path: "/login", accessLevel: "public" },
  { path: "/signup", accessLevel: "public" },
  { path: "/password-reset", accessLevel: "public" },
  { path: "/auth/forgot-password", accessLevel: "public" },
  { path: "/auth/reset-password", accessLevel: "public" },
  { path: "/sat-free", accessLevel: "public" },
  { path: "/faq", accessLevel: "public" },
  { path: "/refund-policy", accessLevel: "public" },
  { path: "/privacy-policy", accessLevel: "public" },
  { path: "/terms-of-use", accessLevel: "public" },
  { path: "/support", accessLevel: "public" },
  { path: "/services/sat", accessLevel: "public" },
  { path: "/services/gmat", accessLevel: "public" },
  { path: "/services/gre", accessLevel: "public" },
  { path: "/services/admissions", accessLevel: "public" },
  { path: "/resources", accessLevel: "public" },
  { path: "/careers", accessLevel: "public" },
  { path: "/cookies", accessLevel: "public" },

  // Authenticated routes (require login)
  { path: "/referral", accessLevel: "authenticated" },
  { path: "/profile", accessLevel: "authenticated" },
  { path: "/courses/enrolled", accessLevel: "authenticated" },
  { path: "/onboarding", accessLevel: "authenticated" },

  // Student-only routes
  { path: "/student", accessLevel: "student", requiredRole: "student" },

  // Teacher-only routes
  { path: "/teacher", accessLevel: "authenticated", requiredRole: "teacher" },

  // Admin-only routes
  { path: "/admin", accessLevel: "admin", requiredRole: "admin" },
  {
    path: "/admin/site-administration",
    accessLevel: "admin",
    requiredRole: "admin",
  },
  {
    path: "/admin/course-templates",
    accessLevel: "admin",
    requiredRole: "admin",
  },

  // Question Bank Routes (Content Manager + Admin)
  {
    path: "/question-bank",
    accessLevel: "authenticated",
    requiredRole: "content_manager",
  },
  {
    path: "/question-bank/new",
    accessLevel: "authenticated",
    requiredRole: "content_manager",
  },
  {
    path: "/question-bank/new/[type]",
    accessLevel: "authenticated",
    requiredRole: "content_manager",
  },
  {
    path: "/question-bank/[id]",
    accessLevel: "authenticated",
    requiredRole: "content_manager",
  },
  {
    path: "/question-bank/[id]/edit",
    accessLevel: "authenticated",
    requiredRole: "content_manager",
  },

  // Question Assignment Routes (Content Manager + Admin)
  {
    path: "/admin/question-assignments",
    accessLevel: "authenticated",
    requiredRole: "content_manager",
  },

  // Admin-only Question Bank Routes
  { path: "/question-bank/admin", accessLevel: "admin", requiredRole: "admin" },
  {
    path: "/question-bank/analytics",
    accessLevel: "admin",
    requiredRole: "admin",
  },
  {
    path: "/question-bank/settings",
    accessLevel: "admin",
    requiredRole: "admin",
  },

  // Partner routes
  { path: "/partner", accessLevel: "authenticated", requiredRole: "partner" },

  // Development/Test routes (admin only)
  { path: "/components-test", accessLevel: "admin", requiredRole: "admin" },
  { path: "/test-auth", accessLevel: "admin", requiredRole: "admin" },
  { path: "/debug-auth", accessLevel: "admin", requiredRole: "admin" },
  { path: "/templates", accessLevel: "admin", requiredRole: "admin" },
];

// Define course access rules
export const COURSE_ACCESS: Record<string, CourseAccessConfig> = {
  // CBSE Courses
  "cbse-math-9": {
    courseId: "cbse-math-9",
    accessType: "free",
    previewAvailable: true,
  },
  "cbse-mathematics-class-9": {
    courseId: "cbse-mathematics-class-9",
    accessType: "free",
    previewAvailable: true,
  },
  "cbse-math-10": {
    courseId: "cbse-math-10",
    accessType: "free",
    previewAvailable: true,
  },
  "cbse-mathematics-class-10": {
    courseId: "cbse-mathematics-class-10",
    accessType: "free",
    previewAvailable: true,
  },
  "cbse-math-11": {
    courseId: "cbse-math-11",
    accessType: "paid",
    previewAvailable: true,
  },
  "cbse-math-12": {
    courseId: "cbse-math-12",
    accessType: "paid",
    previewAvailable: true,
  },

  // IBDP Courses
  "ibdp-math-hl": {
    courseId: "ibdp-math-hl",
    accessType: "paid",
    previewAvailable: true,
  },
  "ibdp-math-sl": {
    courseId: "ibdp-math-sl",
    accessType: "paid",
    previewAvailable: true,
  },

  // ICSE Courses
  "icse-math-9": {
    courseId: "icse-math-9",
    accessType: "free",
    previewAvailable: true,
  },
  "icse-math-10": {
    courseId: "icse-math-10",
    accessType: "paid",
    previewAvailable: true,
  },
};

// Sorted copy of ROUTE_ACCESS — longest paths first so the most specific
// rule wins (longest-prefix match). Without this, `/` matches every URL
// because every URL starts with "/", which silently makes every protected
// route public.
const SORTED_ROUTES = [...ROUTE_ACCESS].sort(
  (a, b) => b.path.length - a.path.length
);

// Match a path against a route entry. We require either an exact match or
// a "path/" prefix so that `/admin` matches `/admin` and `/admin/foo` but
// not `/administrator`.
function matchesRoute(pathname: string, routePath: string): boolean {
  if (pathname === routePath) return true;
  if (routePath === "/") return false; // handled by the exact-match above
  return pathname.startsWith(routePath + "/");
}

function findMatchingRoute(pathname: string): RouteAccess | undefined {
  return SORTED_ROUTES.find((r) => matchesRoute(pathname, r.path));
}

// Helper functions to check access
export function canAccessRoute(
  pathname: string,
  userRole?: UserRole,
  isAuthenticated?: boolean
): boolean {
  const route = findMatchingRoute(pathname);

  if (!route) {
    // If no specific rule, allow access (you might want to default to restricted)
    return true;
  }

  switch (route.accessLevel) {
    case "public":
      return true;
    case "authenticated":
      return isAuthenticated === true;
    case "student":
      return isAuthenticated === true && userRole === "student";
    case "admin":
      return isAuthenticated === true && userRole === "admin";
    default:
      return false;
  }
}

export function canAccessCourse(
  courseId: string,
  userRole?: UserRole,
  isEnrolled?: boolean,
  price?: number
): boolean {
  // Admins can access everything
  if (userRole === "admin") {
    return true;
  }

  // Check if course is free (price = 0)
  const isFree = price === 0;

  // For free courses, users must be enrolled (even though it's free)
  // This ensures proper access tracking
  if (isFree) {
    return isEnrolled === true;
  }

  // Paid courses require enrollment
  return isEnrolled === true;
}

export function getCourseAccessType(
  courseId: string
): CourseAccessConfig | null {
  return COURSE_ACCESS[courseId] || null;
}

export function getRedirectPath(
  pathname: string,
  userRole?: UserRole,
  isAuthenticated?: boolean
): string | null {
  const route = findMatchingRoute(pathname);

  if (!route) return null;

  // If route has specific redirect, use it
  if (route.redirectTo) {
    return route.redirectTo;
  }

  // Default redirects based on access level
  switch (route.accessLevel) {
    case "authenticated":
      return isAuthenticated ? null : "/auth";
    case "student":
      if (!isAuthenticated) return "/auth";
      if (userRole !== "student") return "/courses/enrolled";
      return null;
    case "admin":
      if (!isAuthenticated) return "/auth";
      if (userRole !== "admin") return "/courses/enrolled";
      return null;
    default:
      return null;
  }
}

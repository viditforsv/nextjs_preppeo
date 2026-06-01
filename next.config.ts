import type { NextConfig } from "next";
import path from "path";
import { fileURLToPath } from "url";
import { withSentryConfig } from "@sentry/nextjs";

/** Directory containing this config = app root (avoids wrong root when a lockfile exists above the repo, e.g. ~/package-lock.json). */
const projectRoot = path.dirname(fileURLToPath(import.meta.url));

const nextConfig: NextConfig = {
  // Pin Turbopack/workspace root to this app (silences “multiple lockfiles” when parent dirs have package-lock.json)
  turbopack: {
    root: projectRoot,
  },

  // Strip console.* from production bundles (1000+ calls across the app add
  // runtime cost and leak internals). Keep console.error so real failures
  // still surface to Sentry/logs. Dev keeps all logging.
  compiler: {
    removeConsole:
      process.env.NODE_ENV === "production" ? { exclude: ["error"] } : false,
  },

  // Handle environment variables during build
  env: {
    NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL,
    NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
  },

  // Ensure proper handling of environment variables
  typescript: {
    ignoreBuildErrors: false,
  },

  // PostHog capture endpoints break under Next's automatic trailing-slash
  // redirect — disable it so the /ingest reverse proxy (below) works.
  skipTrailingSlashRedirect: true,

  // Configure image domains for Next.js Image component
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "**.supabase.co",
      },
      {
        protocol: "https",
        hostname: "shrividhyaclasses.b-cdn.net",
      },
      {
        protocol: "https",
        hostname: "**.supabase.in",
      },
      {
        protocol: "http",
        hostname: "localhost",
      },
    ],
    // Allow any image source (for development)
    unoptimized: process.env.NODE_ENV === "development",
  },

  // Short, shareable QOTD link (Discord/Reddit) -> canonical SEO slug.
  async redirects() {
    return [
      {
        source: "/qotd",
        destination: "/question-of-the-day",
        permanent: true,
      },
      {
        source: "/sat-desmos-shortcuts",
        destination: "/sat/desmos",
        permanent: true,
      },
    ];
  },

  // PostHog reverse proxy (US cloud). Routes analytics through a first-party
  // path (preppeo.com/ingest/*) so it's same-origin: this satisfies the CSP
  // `connect-src 'self'` AND dodges ad-blockers that block us.i.posthog.com.
  // Order matters — the /static rule must come before the catch-all.
  async rewrites() {
    return [
      {
        source: "/ingest/static/:path*",
        destination: "https://us-assets.i.posthog.com/static/:path*",
      },
      {
        source: "/ingest/:path*",
        destination: "https://us.i.posthog.com/:path*",
      },
      {
        source: "/ingest/flags",
        destination: "https://us.i.posthog.com/flags",
      },
    ];
  },

  // Add headers to fix CSP issues with PDF embedding and CDN content
  async headers() {
    return [
      {
        source: "/(.*)",
        headers: [
          {
            key: "Content-Security-Policy",
            value: [
              "default-src 'self'",
              "script-src 'self' 'unsafe-eval' 'unsafe-inline' blob: https://checkout.razorpay.com https://www.desmos.com",
              "worker-src 'self' blob:",
              "style-src 'self' 'unsafe-inline'",
              "img-src 'self' data: blob: https:",
              "font-src 'self' data: https://www.desmos.com",
              "connect-src 'self' https://*.supabase.co https://shrividhyaclasses.b-cdn.net https://acrobatservices.adobe.com https://api.razorpay.com https://www.desmos.com https://*.ingest.de.sentry.io",
              "frame-src 'self' https: data:",
              "frame-ancestors 'self' https:",
              "object-src 'self' data:",
              "media-src 'self' https: data:",
            ].join("; "),
          },
        ],
      },
    ];
  },
};

export default withSentryConfig(nextConfig, {
  org: "preppeo",
  project: "nextjs-preppeo",
  silent: !process.env.CI,
  // Upload source maps to Sentry during build (requires SENTRY_AUTH_TOKEN in env)
  widenClientFileUpload: true,
  disableLogger: true,
  automaticVercelMonitors: false,
});

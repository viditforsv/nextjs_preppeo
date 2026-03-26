import * as Sentry from "@sentry/nextjs";

Sentry.init({
  dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
  environment: process.env.NEXT_PUBLIC_ENVIRONMENT ?? "development",

  // Capture 100% of transactions in dev, 10% in prod to control volume
  tracesSampleRate: process.env.NEXT_PUBLIC_ENVIRONMENT === "prod" ? 0.1 : 1.0,

  // Only replay sessions that include an error (saves quota)
  replaysOnErrorSampleRate: 1.0,
  replaysSessionSampleRate: 0,

  integrations: [
    Sentry.replayIntegration({
      maskAllText: false,
      blockAllMedia: false,
    }),
  ],

  // Don't print debug output in production
  debug: false,
});

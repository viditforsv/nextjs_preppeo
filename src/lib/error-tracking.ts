import * as Sentry from "@sentry/nextjs";

export interface ErrorContext {
  componentStack?: string;
  userId?: string;
  route?: string;
  extra?: Record<string, unknown>;
}

export function captureError(error: unknown, context?: ErrorContext): void {
  Sentry.captureException(error, {
    extra: context as Record<string, unknown>,
  });
}

export function captureMessage(
  message: string,
  level: "info" | "warning" | "error" = "info",
  context?: ErrorContext
): void {
  Sentry.captureMessage(message, {
    level,
    extra: context as Record<string, unknown>,
  });
}

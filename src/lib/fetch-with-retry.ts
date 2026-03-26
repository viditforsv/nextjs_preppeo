/**
 * fetch wrapper with exponential backoff retry.
 * Only retries on network errors or 5xx responses.
 * Never retries 4xx (client errors) — those won't improve with retrying.
 */

export async function fetchWithRetry(
  url: string,
  options?: Parameters<typeof fetch>[1],
  retries = 3,
  backoffMs = 500
): Promise<Response> {
  let lastError: unknown;

  for (let attempt = 0; attempt < retries; attempt++) {
    try {
      const res = await fetch(url, options);

      // Don't retry client errors
      if (res.status < 500) return res;

      // 5xx — worth retrying
      lastError = new Error(`HTTP ${res.status} from ${url}`);
    } catch (err) {
      // Network error — worth retrying
      lastError = err;
    }

    if (attempt < retries - 1) {
      await new Promise((resolve) =>
        setTimeout(resolve, backoffMs * 2 ** attempt)
      );
    }
  }

  throw lastError;
}

import { NextRequest } from 'next/server';

const BASE_URL = 'http://localhost:3000';

interface RequestOptions {
  method?: string;
  body?: Record<string, unknown>;
  searchParams?: Record<string, string>;
  headers?: Record<string, string>;
}

export function makeRequest(path: string, opts: RequestOptions = {}): NextRequest {
  const { method = 'GET', body, searchParams, headers = {} } = opts;

  const url = new URL(path, BASE_URL);
  if (searchParams) {
    for (const [k, v] of Object.entries(searchParams)) {
      url.searchParams.set(k, v);
    }
  }

  type NextRequestInit = ConstructorParameters<typeof NextRequest>[1];
  const init: NextRequestInit = { method, headers: { 'content-type': 'application/json', ...headers } };
  if (body && method !== 'GET') {
    init.body = JSON.stringify(body);
  }
  return new NextRequest(url, init);
}

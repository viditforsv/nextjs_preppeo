import { vi } from 'vitest';

type ChainResult = { data: unknown; error: unknown };

/**
 * Chainable mock that mimics Supabase's query builder API.
 * Call `.mockResult(data, error?)` at any point to set the terminal value.
 */
export function createChain(defaultResult: ChainResult = { data: null, error: null }) {
  let result: ChainResult = { ...defaultResult };

  const chain: Record<string, unknown> = {};
  const passthrough = [
    'from', 'select', 'insert', 'update', 'upsert', 'delete',
    'eq', 'neq', 'gt', 'gte', 'lt', 'lte', 'in', 'is',
    'order', 'limit', 'range', 'filter',
  ];

  for (const method of passthrough) {
    chain[method] = vi.fn().mockReturnValue(chain);
  }

  chain.single = vi.fn().mockImplementation(() => Promise.resolve(result));
  chain.maybeSingle = vi.fn().mockImplementation(() => Promise.resolve(result));
  chain.then = vi.fn().mockImplementation((resolve: (v: ChainResult) => void) => resolve(result));

  chain.rpc = vi.fn().mockImplementation(() => Promise.resolve(result));

  chain.mockResult = (data: unknown, error: unknown = null) => {
    result = { data, error };
    return chain;
  };

  return chain as typeof chain & { mockResult: (data: unknown, error?: unknown) => typeof chain };
}

/**
 * Creates a mock supabase client where `.from(table)` returns independent
 * chainable builders. Register per-table results with `.mockTable(name, data, error?)`.
 */
export function createMockSupabase() {
  const tables = new Map<string, ReturnType<typeof createChain>>();

  const getTable = (name: string) => {
    if (!tables.has(name)) tables.set(name, createChain());
    return tables.get(name)!;
  };

  const supabase = {
    from: vi.fn().mockImplementation((table: string) => getTable(table)),
    rpc: vi.fn().mockImplementation(() =>
      Promise.resolve({ data: null, error: null }),
    ),

    mockTable(name: string, data: unknown, error: unknown = null) {
      (getTable(name) as { mockResult: (d: unknown, e?: unknown) => unknown }).mockResult(data, error);
      return supabase;
    },

    mockRpc(data: unknown, error: unknown = null) {
      supabase.rpc.mockImplementation(() => Promise.resolve({ data, error }));
      return supabase;
    },

    getTable,
  };

  return supabase;
}

/**
 * Creates a mock auth client that resolves `.auth.getUser()` to the given user or null.
 */
export function createMockAuthClient(user: { id: string; email?: string } | null = null) {
  return {
    auth: {
      getUser: vi.fn().mockResolvedValue({
        data: { user },
        error: user ? null : { message: 'Not authenticated' },
      }),
    },
  };
}

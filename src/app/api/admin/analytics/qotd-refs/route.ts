import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

/**
 * GET /api/admin/analytics/qotd-refs
 * Query: from?=ISODate, to?=ISODate
 *
 * Admin-only. Aggregates Question-of-the-Day email captures by `ref`
 * (the attribution channel from links like /qotd?ref=va), so each VA /
 * channel's contribution is visible. Returns, per ref:
 *   - signups: distinct emails (the payable number — same person can unlock
 *     on multiple days, which would otherwise double-count)
 *   - captures: total rows (every unlock event)
 * Captures with no ref are bucketed as "(direct)".
 *
 * Reads via the service-role client because qotd_leads is RLS-locked with no
 * public read policy (writes happen only through /api/qotd/capture).
 */

const DIRECT = '(direct)';

interface RefRow {
  ref: string;
  signups: number;
  captures: number;
}

export async function GET(request: NextRequest) {
  const supabase = await createClient();

  const { data: { user }, error: userError } = await supabase.auth.getUser();
  if (userError || !user) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  const { data: profile, error: profileError } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', user.id)
    .single();

  if (profileError || !profile || profile.role !== 'admin') {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 });
  }

  const url = new URL(request.url);
  const fromParam = url.searchParams.get('from');
  const toParam = url.searchParams.get('to');

  const admin = createSupabaseApiClient();
  let query = admin
    .from('qotd_leads')
    .select('ref, email, created_at')
    .order('created_at', { ascending: false })
    .limit(50000);

  if (fromParam) query = query.gte('created_at', fromParam);
  // `to` is treated as inclusive of the whole day if a bare date is passed.
  if (toParam) {
    const to = /^\d{4}-\d{2}-\d{2}$/.test(toParam) ? `${toParam}T23:59:59.999Z` : toParam;
    query = query.lte('created_at', to);
  }

  const { data, error } = await query;
  if (error) {
    console.error('qotd-refs analytics: query failed', error);
    return NextResponse.json({ error: 'Query failed' }, { status: 500 });
  }

  // Aggregate per ref: distinct emails (signups) + total rows (captures).
  const emailsByRef = new Map<string, Set<string>>();
  const capturesByRef = new Map<string, number>();
  for (const row of data ?? []) {
    const key = row.ref ?? DIRECT;
    capturesByRef.set(key, (capturesByRef.get(key) ?? 0) + 1);
    if (!emailsByRef.has(key)) emailsByRef.set(key, new Set());
    if (row.email) emailsByRef.get(key)!.add(row.email);
  }

  const rows: RefRow[] = [...capturesByRef.keys()]
    .map((ref) => ({
      ref,
      signups: emailsByRef.get(ref)?.size ?? 0,
      captures: capturesByRef.get(ref) ?? 0,
    }))
    // Direct last, then by signups desc.
    .sort((a, b) => {
      if (a.ref === DIRECT) return 1;
      if (b.ref === DIRECT) return -1;
      return b.signups - a.signups;
    });

  const totalCaptures = data?.length ?? 0;
  const totalUniqueSignups = new Set((data ?? []).map((r) => r.email).filter(Boolean)).size;

  return NextResponse.json({
    summary: { totalUniqueSignups, totalCaptures, refCount: rows.filter((r) => r.ref !== DIRECT).length },
    rows,
  });
}

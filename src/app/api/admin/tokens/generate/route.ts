import { NextRequest, NextResponse } from 'next/server';
import crypto from 'crypto';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { generateBulkTokenCodes } from '@/lib/tokens/generate';

async function requireAdmin() {
  const authClient = await createClient();
  const { data: { user } } = await authClient.auth.getUser();
  if (!user) return null;

  const supabase = createSupabaseApiClient();
  const { data: profile } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', user.id)
    .single();

  if (profile?.role !== 'admin') return null;
  return user;
}

/**
 * POST /api/admin/tokens/generate
 * Body: { examType, setNumber?, count, isFree? }
 * Generates N crypto-random tokens grouped under a batch_id.
 * Returns the codes and batch_id.
 */
export async function POST(request: NextRequest) {
  const admin = await requireAdmin();
  if (!admin) {
    return NextResponse.json({ error: 'Admin access required' }, { status: 403 });
  }

  try {
    const { examType, setNumber, count, isFree } = await request.json();

    if (!examType || typeof examType !== 'string') {
      return NextResponse.json({ error: 'examType is required' }, { status: 400 });
    }
    if (!count || typeof count !== 'number' || count < 1 || count > 1000) {
      return NextResponse.json({ error: 'count must be 1-1000' }, { status: 400 });
    }

    const supabase = createSupabaseApiClient();

    const { data: exam } = await supabase
      .from('exam_types')
      .select('id, total_sets')
      .eq('id', examType)
      .single();

    if (!exam) {
      return NextResponse.json({ error: 'Invalid exam type' }, { status: 400 });
    }

    const batchId = crypto.randomUUID();
    const codes = generateBulkTokenCodes(examType, count);
    const totalSets = exam.total_sets ?? 1;

    const tokenRows = codes.map((code, i) => ({
      code,
      exam_type: examType,
      set_number: setNumber ?? (i % totalSets) + 1,
      is_free: isFree ?? false,
      owner_id: null,
      batch_id: batchId,
      is_active: true,
    }));

    const { error: insertError } = await supabase
      .from('test_tokens')
      .insert(tokenRows);

    if (insertError) {
      console.error('Failed to insert tokens:', insertError);
      return NextResponse.json({ error: 'Failed to generate tokens' }, { status: 500 });
    }

    return NextResponse.json({
      success: true,
      batchId,
      examType,
      count: codes.length,
      codes,
    });
  } catch (error) {
    console.error('Error in POST /api/admin/tokens/generate:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

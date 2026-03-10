import { NextRequest, NextResponse } from 'next/server';
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

// GET: list exam types, packs, tokens, or purchases
export async function GET(request: NextRequest) {
  const admin = await requireAdmin();
  if (!admin) {
    return NextResponse.json({ error: 'Admin access required' }, { status: 403 });
  }

  const supabase = createSupabaseApiClient();
  const { searchParams } = new URL(request.url);
  const resource = searchParams.get('resource') ?? 'exam_types';

  switch (resource) {
    case 'exam_types': {
      const { data, error } = await supabase.from('exam_types').select('*').order('name');
      if (error) return NextResponse.json({ error: error.message }, { status: 500 });
      return NextResponse.json({ data });
    }
    case 'token_packs': {
      const { data, error } = await supabase
        .from('token_packs')
        .select('*, exam_types(name)')
        .order('exam_type')
        .order('price');
      if (error) return NextResponse.json({ error: error.message }, { status: 500 });
      return NextResponse.json({ data });
    }
    case 'tokens': {
      const examType = searchParams.get('examType');
      let query = supabase
        .from('test_tokens')
        .select('*, exam_types(name)')
        .order('created_at', { ascending: false })
        .limit(100);
      if (examType) query = query.eq('exam_type', examType);
      const { data, error } = await query;
      if (error) return NextResponse.json({ error: error.message }, { status: 500 });
      return NextResponse.json({ data });
    }
    case 'purchases': {
      const { data, error } = await supabase
        .from('token_purchases')
        .select('*, token_packs(name, exam_type)')
        .order('created_at', { ascending: false })
        .limit(100);
      if (error) return NextResponse.json({ error: error.message }, { status: 500 });
      return NextResponse.json({ data });
    }
    default:
      return NextResponse.json({ error: 'Invalid resource' }, { status: 400 });
  }
}

// POST: create exam types, packs, or generate manual tokens
export async function POST(request: NextRequest) {
  const admin = await requireAdmin();
  if (!admin) {
    return NextResponse.json({ error: 'Admin access required' }, { status: 403 });
  }

  const supabase = createSupabaseApiClient();
  const body = await request.json();
  const { action } = body;

  switch (action) {
    case 'create_exam_type': {
      const { id, name, description, test_route, total_sets } = body;
      if (!id || !name || !test_route) {
        return NextResponse.json({ error: 'id, name, and test_route are required' }, { status: 400 });
      }
      const { data, error } = await supabase
        .from('exam_types')
        .insert({ id, name, description, test_route, total_sets: total_sets ?? 1 })
        .select()
        .single();
      if (error) return NextResponse.json({ error: error.message }, { status: 500 });

      // Auto-create free token for set 1
      await supabase.from('test_tokens').insert({
        code: `${id.toUpperCase()}-FREE-SET1`,
        exam_type: id,
        set_number: 1,
        is_free: true,
        is_active: true,
      });

      return NextResponse.json({ data });
    }

    case 'create_pack': {
      const { exam_type, name, token_count, price } = body;
      if (!exam_type || !name || !token_count || price == null) {
        return NextResponse.json({ error: 'exam_type, name, token_count, and price are required' }, { status: 400 });
      }
      const { data, error } = await supabase
        .from('token_packs')
        .insert({ exam_type, name, token_count, price })
        .select()
        .single();
      if (error) return NextResponse.json({ error: error.message }, { status: 500 });
      return NextResponse.json({ data });
    }

    case 'generate_tokens': {
      const { exam_type, count, set_number, owner_id } = body;
      if (!exam_type || !count) {
        return NextResponse.json({ error: 'exam_type and count are required' }, { status: 400 });
      }
      const codes = generateBulkTokenCodes(exam_type, count);
      const rows = codes.map((code) => ({
        code,
        exam_type,
        set_number: set_number ?? 1,
        is_free: false,
        owner_id: owner_id ?? null,
        is_active: true,
      }));
      const { data, error } = await supabase.from('test_tokens').insert(rows).select();
      if (error) return NextResponse.json({ error: error.message }, { status: 500 });
      return NextResponse.json({ data, codes });
    }

    default:
      return NextResponse.json({ error: 'Invalid action' }, { status: 400 });
  }
}

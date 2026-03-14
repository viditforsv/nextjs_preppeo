import { NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function GET() {
  try {
    const supabase = createSupabaseApiClient();

    const { data, error } = await supabase
      .from('token_packs')
      .select('*, exam_types(name)')
      .eq('is_active', true)
      .order('exam_type')
      .order('price');

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    return NextResponse.json({ data });
  } catch (error) {
    console.error('Error in GET /api/mocks/packs:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

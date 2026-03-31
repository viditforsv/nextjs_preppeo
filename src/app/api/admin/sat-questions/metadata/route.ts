import { NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

/**
 * GET /api/admin/sat-questions/metadata
 * Returns distinct filterable values for populating filter dropdowns before any data fetch.
 */
export async function GET() {
  try {
    const supabase = createSupabaseApiClient();

    const [sectionsRes, domainsRes, difficultiesRes, modulesRes, setsRes] = await Promise.all([
      supabase.from('sat_questions').select('section').eq('is_active', true),
      supabase.from('sat_questions').select('domain').eq('is_active', true),
      supabase.from('sat_questions').select('difficulty_tier').eq('is_active', true),
      supabase.from('sat_questions').select('module_number').eq('is_active', true),
      supabase.from('sat_questions').select('set_number').eq('is_active', true),
    ]);

    return NextResponse.json({
      sections:     [...new Set(sectionsRes.data?.map((r) => r.section).filter(Boolean))].sort(),
      domains:      [...new Set(domainsRes.data?.map((r) => r.domain).filter(Boolean))].sort(),
      difficulties: [...new Set(difficultiesRes.data?.map((r) => r.difficulty_tier).filter(Boolean))].sort(),
      modules:      [...new Set(modulesRes.data?.map((r) => r.module_number))].sort((a, b) => a - b),
      sets:         [...new Set(setsRes.data?.map((r) => r.set_number))].sort((a, b) => a - b),
    });
  } catch (err) {
    console.error('Error in GET /api/admin/sat-questions/metadata:', err);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}

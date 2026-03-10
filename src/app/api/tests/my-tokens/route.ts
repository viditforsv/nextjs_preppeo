import { NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function GET() {
  try {
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();

    if (!user) {
      return NextResponse.json(
        { success: false, error: 'Authentication required' },
        { status: 401 }
      );
    }

    const supabase = createSupabaseApiClient();

    const { data: tokens, error } = await supabase
      .from('test_tokens')
      .select('id, code, exam_type, set_number, is_used, used_at, created_at, exam_types(name, test_route)')
      .eq('owner_id', user.id)
      .eq('is_active', true)
      .order('created_at', { ascending: false });

    if (error) {
      console.error('Error fetching tokens:', error);
      return NextResponse.json(
        { success: false, error: 'Failed to fetch tokens' },
        { status: 500 }
      );
    }

    // Group by exam type
    const grouped: Record<string, { examName: string; testRoute: string; tokens: typeof tokens }> = {};
    for (const token of tokens ?? []) {
      const exam = token.exam_types as unknown as { name: string; test_route: string } | null;
      if (!grouped[token.exam_type]) {
        grouped[token.exam_type] = {
          examName: exam?.name ?? token.exam_type,
          testRoute: exam?.test_route ?? '/',
          tokens: [],
        };
      }
      grouped[token.exam_type].tokens.push(token);
    }

    return NextResponse.json({ success: true, tokensByExam: grouped });
  } catch (error) {
    console.error('Error in GET /api/tests/my-tokens:', error);
    return NextResponse.json(
      { success: false, error: 'Internal server error' },
      { status: 500 }
    );
  }
}

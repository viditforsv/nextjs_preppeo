import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { createClient } from '@/lib/supabase/server';

export async function POST(request: NextRequest) {
  try {
    const { code, examType } = await request.json();

    if (!code || typeof code !== 'string') {
      return NextResponse.json(
        { valid: false, message: 'Access code is required' },
        { status: 400 }
      );
    }
    if (!examType || typeof examType !== 'string') {
      return NextResponse.json(
        { valid: false, message: 'Exam type is required' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseApiClient();

    const { data: token, error } = await supabase
      .from('test_tokens')
      .select('id, code, exam_type, set_number, is_free, is_used, owner_id, is_active')
      .eq('code', code.trim().toUpperCase())
      .eq('exam_type', examType)
      .eq('is_active', true)
      .maybeSingle();

    if (error) {
      console.error('Error verifying token:', error);
      return NextResponse.json(
        { valid: false, message: 'Something went wrong. Please try again.' },
        { status: 500 }
      );
    }

    if (!token) {
      return NextResponse.json({ valid: false, message: 'Invalid or expired access code' });
    }

    // Free tokens are perpetually reusable
    if (token.is_free) {
      return NextResponse.json({ valid: true, setNumber: token.set_number });
    }

    if (token.is_used) {
      return NextResponse.json({ valid: false, message: 'This token has already been used' });
    }

    // Tokens are transferable — anyone with the code can redeem it.
    // owner_id tracks who purchased; used_by tracks who redeemed.
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    const userId = user?.id ?? null;

    await supabase
      .from('test_tokens')
      .update({ is_used: true, used_at: new Date().toISOString(), used_by: userId })
      .eq('id', token.id);

    return NextResponse.json({ valid: true, setNumber: token.set_number });
  } catch (error) {
    console.error('Error in POST /api/mocks/verify-token:', error);
    return NextResponse.json(
      { valid: false, message: 'Internal server error' },
      { status: 500 }
    );
  }
}

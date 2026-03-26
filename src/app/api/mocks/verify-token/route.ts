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

    // Get the authenticated user first — needed for same-user retry check
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    const userId = user?.id ?? null;

    const { data: token, error } = await supabase
      .from('test_tokens')
      .select('id, code, exam_type, set_number, is_free, is_used, owner_id, used_by, is_active, expires_at')
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

    // Check expiry for paid tokens
    if (token.expires_at && new Date(token.expires_at) < new Date()) {
      return NextResponse.json({ valid: false, message: 'This token has expired' });
    }

    if (token.is_used) {
      // Allow the original user to re-enter their own test (e.g. after a page refresh)
      if (userId && token.used_by === userId) {
        return NextResponse.json({ valid: true, setNumber: token.set_number, resumed: true });
      }
      return NextResponse.json({ valid: false, message: 'This token has already been used' });
    }

    // Tokens are transferable — anyone with the code can redeem it.
    // owner_id tracks who purchased; used_by tracks who redeemed.
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

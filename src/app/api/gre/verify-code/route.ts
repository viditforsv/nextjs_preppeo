import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { code } = body;

    if (!code || typeof code !== 'string') {
      return NextResponse.json(
        { valid: false, message: 'Access code is required' },
        { status: 400 }
      );
    }

    const supabase = createSupabaseApiClient();

    const { data, error } = await supabase
      .from('gre_access_codes')
      .select('code, is_active, set_number')
      .eq('code', code.trim())
      .eq('is_active', true)
      .maybeSingle();

    if (error) {
      console.error('Error verifying access code:', error);
      return NextResponse.json(
        { valid: false, message: 'Something went wrong. Please try again.' },
        { status: 500 }
      );
    }

    if (!data) {
      return NextResponse.json({ valid: false, message: 'Invalid or expired access code' });
    }

    await supabase
      .from('gre_access_codes')
      .update({ used_at: new Date().toISOString() })
      .eq('code', data.code);

    return NextResponse.json({ valid: true, setNumber: data.set_number });
  } catch (error) {
    console.error('Error in POST /api/gre/verify-code:', error);
    return NextResponse.json(
      { valid: false, message: 'Internal server error' },
      { status: 500 }
    );
  }
}

import { NextRequest, NextResponse } from 'next/server';
import crypto from 'crypto';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { generateBulkTokenCodes } from '@/lib/tokens/generate';

export async function POST(request: NextRequest) {
  try {
    const { orderId, paymentId, signature, purchaseId } = await request.json();

    if (!orderId || !paymentId || !signature || !purchaseId) {
      return NextResponse.json(
        { success: false, error: 'Missing required fields' },
        { status: 400 }
      );
    }

    if (!process.env.RAZORPAY_KEY_SECRET) {
      return NextResponse.json(
        { success: false, error: 'Payment verification not configured' },
        { status: 500 }
      );
    }

    // Verify signature
    const generatedSignature = crypto
      .createHmac('sha256', process.env.RAZORPAY_KEY_SECRET)
      .update(`${orderId}|${paymentId}`)
      .digest('hex');

    if (generatedSignature !== signature) {
      return NextResponse.json(
        { success: false, error: 'Invalid payment signature' },
        { status: 400 }
      );
    }

    // Auth required
    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) {
      return NextResponse.json(
        { success: false, error: 'Authentication required' },
        { status: 401 }
      );
    }

    const supabase = createSupabaseApiClient();

    // Fetch purchase + pack details
    const { data: purchase, error: purchaseError } = await supabase
      .from('token_purchases')
      .select('id, user_id, pack_id, status, token_packs(exam_type, token_count, name)')
      .eq('id', purchaseId)
      .single();

    if (purchaseError || !purchase) {
      return NextResponse.json(
        { success: false, error: 'Purchase record not found' },
        { status: 404 }
      );
    }

    if (purchase.user_id !== user.id) {
      return NextResponse.json(
        { success: false, error: 'Purchase does not belong to this user' },
        { status: 403 }
      );
    }

    if (purchase.status === 'completed') {
      return NextResponse.json(
        { success: false, error: 'Payment already processed' },
        { status: 409 }
      );
    }

    const pack = purchase.token_packs as unknown as { exam_type: string; token_count: number; name: string };

    // Generate token codes
    const codes = generateBulkTokenCodes(pack.exam_type, pack.token_count);

    // Assign set numbers round-robin across available sets
    const { data: examType } = await supabase
      .from('exam_types')
      .select('total_sets')
      .eq('id', pack.exam_type)
      .single();

    const totalSets = examType?.total_sets ?? 1;

    const tokenRows = codes.map((code, i) => ({
      code,
      exam_type: pack.exam_type,
      set_number: (i % totalSets) + 2, // Start from set 2 (set 1 is free)
      is_free: false,
      owner_id: user.id,
      purchase_id: purchase.id,
      is_active: true,
    }));

    const { error: insertError } = await supabase
      .from('test_tokens')
      .insert(tokenRows);

    if (insertError) {
      console.error('Failed to insert tokens:', insertError);
      return NextResponse.json(
        { success: false, error: 'Failed to generate tokens' },
        { status: 500 }
      );
    }

    // Update purchase record
    await supabase
      .from('token_purchases')
      .update({
        razorpay_payment_id: paymentId,
        status: 'completed',
        tokens_generated: pack.token_count,
      })
      .eq('id', purchase.id);

    return NextResponse.json({
      success: true,
      message: 'Payment verified and tokens generated',
      tokens: codes,
      examType: pack.exam_type,
      count: pack.token_count,
    });
  } catch (error) {
    console.error('Error in POST /api/tests/verify-payment:', error);
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Verification failed' },
      { status: 500 }
    );
  }
}

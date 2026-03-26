import { NextRequest, NextResponse } from 'next/server';
import nodeCrypto from 'crypto';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { fulfillTokenPurchase } from '@/lib/tokens/fulfill-purchase';

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

    // Verify Razorpay signature
    const generatedSignature = nodeCrypto
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

    // Verify purchase belongs to this user
    const supabase = createSupabaseApiClient();
    const { data: purchase } = await supabase
      .from('token_purchases')
      .select('user_id, status')
      .eq('id', purchaseId)
      .single();

    if (!purchase || purchase.user_id !== user.id) {
      return NextResponse.json(
        { success: false, error: 'Purchase not found or does not belong to this user' },
        { status: 403 }
      );
    }

    if (purchase.status === 'completed') {
      return NextResponse.json(
        { success: false, error: 'Payment already processed' },
        { status: 409 }
      );
    }

    const result = await fulfillTokenPurchase(purchaseId, paymentId);

    return NextResponse.json({
      success: true,
      message: 'Payment verified and tokens generated',
      tokens: result.codes,
      examType: result.examType,
      count: result.count,
    });
  } catch (error) {
    console.error('Error in POST /api/mocks/verify-payment:', error);
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Verification failed' },
      { status: 500 }
    );
  }
}

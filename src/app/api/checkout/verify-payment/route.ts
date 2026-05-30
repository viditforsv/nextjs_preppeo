/**
 * Verify a unified bundle payment and fulfill every product in the order.
 * Body: { orderId, paymentId, signature, purchaseId }
 */
import { NextRequest, NextResponse } from 'next/server';
import nodeCrypto from 'crypto';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { fulfillCartPurchase } from '@/lib/checkout/fulfill-cart';

export async function POST(request: NextRequest) {
  try {
    const { orderId, paymentId, signature, purchaseId } = await request.json();

    if (!orderId || !paymentId || !signature || !purchaseId) {
      return NextResponse.json({ success: false, error: 'Missing required fields' }, { status: 400 });
    }

    if (!process.env.RAZORPAY_KEY_SECRET) {
      return NextResponse.json({ success: false, error: 'Payment verification not configured' }, { status: 500 });
    }

    const generatedSignature = nodeCrypto
      .createHmac('sha256', process.env.RAZORPAY_KEY_SECRET)
      .update(`${orderId}|${paymentId}`)
      .digest('hex');

    if (generatedSignature !== signature) {
      return NextResponse.json({ success: false, error: 'Invalid payment signature' }, { status: 400 });
    }

    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) {
      return NextResponse.json({ success: false, error: 'Authentication required' }, { status: 401 });
    }

    const supabase = createSupabaseApiClient();
    const { data: purchase } = await supabase
      .from('token_purchases')
      .select('id, user_id, status')
      .eq('id', purchaseId)
      .single();

    if (!purchase || purchase.user_id !== user.id) {
      return NextResponse.json({ success: false, error: 'Purchase not found' }, { status: 404 });
    }
    if (purchase.status === 'completed') {
      return NextResponse.json({ success: false, error: 'Payment already processed' }, { status: 409 });
    }

    const result = await fulfillCartPurchase(purchase.id, paymentId);

    return NextResponse.json({
      success: true,
      tokens: result.tokens,
      subscriptions: result.subscriptions,
    });
  } catch (error) {
    console.error('Error in POST /api/checkout/verify-payment:', error);
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Verification failed' },
      { status: 500 },
    );
  }
}

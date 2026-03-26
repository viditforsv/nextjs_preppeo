import { NextRequest, NextResponse } from 'next/server';
import nodeCrypto from 'crypto';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { fulfillTokenPurchase } from '@/lib/tokens/fulfill-purchase';

export async function POST(request: NextRequest) {
  try {
    const rawBody = await request.text();
    const signature = request.headers.get('x-razorpay-signature');

    if (!signature) {
      return NextResponse.json({ error: 'Missing signature' }, { status: 400 });
    }

    if (!process.env.RAZORPAY_WEBHOOK_SECRET) {
      console.error('RAZORPAY_WEBHOOK_SECRET not configured');
      return NextResponse.json({ error: 'Webhook not configured' }, { status: 500 });
    }

    // Verify webhook signature
    const expectedSignature = nodeCrypto
      .createHmac('sha256', process.env.RAZORPAY_WEBHOOK_SECRET)
      .update(rawBody)
      .digest('hex');

    if (expectedSignature !== signature) {
      return NextResponse.json({ error: 'Invalid signature' }, { status: 400 });
    }

    const payload = JSON.parse(rawBody);

    // Only handle payment.captured events
    if (payload.event !== 'payment.captured') {
      return NextResponse.json({ received: true });
    }

    const payment = payload.payload?.payment?.entity;
    if (!payment?.order_id || !payment?.id) {
      console.error('Webhook: missing order_id or payment id in payload');
      return NextResponse.json({ error: 'Invalid payload structure' }, { status: 400 });
    }

    const orderId = payment.order_id as string;
    const paymentId = payment.id as string;

    // Find purchase by razorpay_order_id
    const supabase = createSupabaseApiClient();
    const { data: purchase, error } = await supabase
      .from('token_purchases')
      .select('id, status')
      .eq('razorpay_order_id', orderId)
      .single();

    if (error || !purchase) {
      console.error('Webhook: purchase not found for order', orderId);
      // Return 200 so Razorpay doesn't retry — we can't recover from a missing purchase
      return NextResponse.json({ received: true });
    }

    if (purchase.status === 'completed') {
      // Already fulfilled (e.g. client-side verify-payment ran first)
      return NextResponse.json({ received: true });
    }

    await fulfillTokenPurchase(purchase.id, paymentId);

    return NextResponse.json({ received: true });
  } catch (error) {
    console.error('Error in POST /api/mocks/razorpay-webhook:', error);
    // Return 500 so Razorpay retries
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'Webhook processing failed' },
      { status: 500 }
    );
  }
}

import { NextRequest, NextResponse } from 'next/server';
import Razorpay from 'razorpay';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function POST(request: NextRequest) {
  try {
    const { planId } = await request.json();

    if (!planId) {
      return NextResponse.json({ success: false, error: 'Missing required field: planId' }, { status: 400 });
    }

    if (!process.env.RAZORPAY_KEY_ID || !process.env.RAZORPAY_KEY_SECRET) {
      return NextResponse.json({ success: false, error: 'Payment system not configured.' }, { status: 500 });
    }

    const authClient = await createClient();
    const { data: { user } } = await authClient.auth.getUser();
    if (!user) {
      return NextResponse.json({ success: false, error: 'Authentication required' }, { status: 401 });
    }

    const supabase = createSupabaseApiClient();

    const { data: plan, error: planError } = await supabase
      .from('subscription_plans')
      .select('*')
      .eq('id', planId)
      .eq('is_active', true)
      .single();

    if (planError || !plan) {
      return NextResponse.json({ success: false, error: 'Plan not found or unavailable' }, { status: 404 });
    }

    // Reuse token_purchases table for payment tracking
    const { data: purchase, error: purchaseError } = await supabase
      .from('token_purchases')
      .insert({
        user_id: user.id,
        pack_id: null,
        amount: plan.price,
        currency: 'INR',
        status: 'pending',
      })
      .select('id')
      .single();

    if (purchaseError || !purchase) {
      console.error('Failed to create purchase record:', purchaseError);
      return NextResponse.json({ success: false, error: 'Failed to initiate purchase' }, { status: 500 });
    }

    const razorpay = new Razorpay({
      key_id: process.env.RAZORPAY_KEY_ID,
      key_secret: process.env.RAZORPAY_KEY_SECRET,
    });

    const order = await razorpay.orders.create({
      amount: Math.round(plan.price * 100),
      currency: 'INR',
      receipt: `sub_${purchase.id.slice(0, 16)}`,
      notes: {
        purchaseId: purchase.id,
        planId: plan.id,
        planType: plan.plan_type,
        userId: user.id,
      },
    });

    await supabase
      .from('token_purchases')
      .update({ razorpay_order_id: order.id })
      .eq('id', purchase.id);

    return NextResponse.json({
      success: true,
      orderId: order.id,
      purchaseId: purchase.id,
      planId: plan.id,
      amount: plan.price,
      currency: 'INR',
      planName: plan.name,
    });
  } catch (error) {
    console.error('Error in POST /api/subscriptions/create-order:', error);
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Failed to create order' },
      { status: 500 }
    );
  }
}

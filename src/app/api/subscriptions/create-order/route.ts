import { NextRequest, NextResponse } from 'next/server';
import Razorpay from 'razorpay';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function POST(request: NextRequest) {
  try {
    const { planId, referralCode } = await request.json();

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

    // Resolve referral discount
    let finalPrice = plan.price;
    let discountApplied = 0;
    let partnerId: string | null = null;
    let resolvedCode: string | null = null;

    if (referralCode && typeof referralCode === 'string') {
      const code = referralCode.trim().toUpperCase();
      const { data: partner } = await supabase
        .from('partners')
        .select('id, discount_rate')
        .eq('referral_code', code)
        .eq('is_active', true)
        .single();

      if (partner) {
        discountApplied = Number(((plan.price * partner.discount_rate) / 100).toFixed(2));
        finalPrice = plan.price - discountApplied;
        partnerId = partner.id;
        resolvedCode = code;
      }
    }

    // Reuse token_purchases table for payment tracking
    const { data: purchase, error: purchaseError } = await supabase
      .from('token_purchases')
      .insert({
        user_id: user.id,
        pack_id: null,
        amount: finalPrice,
        currency: 'INR',
        status: 'pending',
        referral_code: resolvedCode,
        partner_id: partnerId,
        discount_applied: discountApplied,
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
      amount: Math.round(finalPrice * 100),
      currency: 'INR',
      receipt: `sub_${purchase.id.slice(0, 16)}`,
      notes: {
        purchaseId: purchase.id,
        planId: plan.id,
        planType: plan.plan_type,
        userId: user.id,
        ...(partnerId ? { partnerId } : {}),
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
      amount: finalPrice,
      originalAmount: plan.price,
      discountApplied,
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

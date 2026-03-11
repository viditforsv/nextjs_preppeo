import { NextRequest, NextResponse } from 'next/server';
import Razorpay from 'razorpay';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

export async function POST(request: NextRequest) {
  try {
    const { packId, referralCode } = await request.json();

    if (!packId) {
      return NextResponse.json(
        { success: false, error: 'Missing required field: packId' },
        { status: 400 }
      );
    }

    if (!process.env.RAZORPAY_KEY_ID || !process.env.RAZORPAY_KEY_SECRET) {
      return NextResponse.json(
        { success: false, error: 'Payment system not configured.' },
        { status: 500 }
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

    // Fetch pack details
    const supabase = createSupabaseApiClient();
    const { data: pack, error: packError } = await supabase
      .from('token_packs')
      .select('id, exam_type, name, token_count, price, is_active')
      .eq('id', packId)
      .eq('is_active', true)
      .single();

    if (packError || !pack) {
      return NextResponse.json(
        { success: false, error: 'Token pack not found or unavailable' },
        { status: 404 }
      );
    }

    // Resolve referral discount
    let finalPrice = pack.price;
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
        discountApplied = Number(((pack.price * partner.discount_rate) / 100).toFixed(2));
        finalPrice = pack.price - discountApplied;
        partnerId = partner.id;
        resolvedCode = code;
      }
    }

    // Create purchase record
    const { data: purchase, error: purchaseError } = await supabase
      .from('token_purchases')
      .insert({
        user_id: user.id,
        pack_id: pack.id,
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
      return NextResponse.json(
        { success: false, error: 'Failed to initiate purchase' },
        { status: 500 }
      );
    }

    // Create Razorpay order
    const razorpay = new Razorpay({
      key_id: process.env.RAZORPAY_KEY_ID,
      key_secret: process.env.RAZORPAY_KEY_SECRET,
    });

    const order = await razorpay.orders.create({
      amount: Math.round(finalPrice * 100),
      currency: 'INR',
      receipt: `tok_${purchase.id.slice(0, 16)}`,
      notes: {
        purchaseId: purchase.id,
        packId: pack.id,
        examType: pack.exam_type,
        userId: user.id,
        ...(partnerId ? { partnerId } : {}),
      },
    });

    // Store order id on purchase
    await supabase
      .from('token_purchases')
      .update({ razorpay_order_id: order.id })
      .eq('id', purchase.id);

    return NextResponse.json({
      success: true,
      orderId: order.id,
      purchaseId: purchase.id,
      amount: finalPrice,
      originalAmount: pack.price,
      discountApplied,
      currency: 'INR',
      packName: pack.name,
      tokenCount: pack.token_count,
    });
  } catch (error) {
    console.error('Error in POST /api/tests/create-order:', error);
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Failed to create order' },
      { status: 500 }
    );
  }
}

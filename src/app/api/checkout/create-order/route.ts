/**
 * Unified bundle checkout — create one Razorpay order for a mixed cart of
 * paid products (mock packs + practice subscriptions). Prices are ALWAYS
 * recomputed server-side from the DB; the client total is never trusted.
 *
 * Body: { items: Array<{ type: 'mock' | 'practice', id: string }>, referralCode?: string }
 */
import { NextRequest, NextResponse } from 'next/server';
import Razorpay from 'razorpay';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';

interface CartItemInput {
  type: 'mock' | 'practice';
  id: string;
}

interface ResolvedItem {
  item_type: 'mock' | 'practice';
  ref_id: string;
  unit_price: number;
  metadata: Record<string, unknown>;
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const items = body.items as CartItemInput[] | undefined;
    const referralCode = body.referralCode as string | undefined;

    if (!Array.isArray(items) || items.length === 0) {
      return NextResponse.json({ success: false, error: 'Cart is empty' }, { status: 400 });
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

    // Resolve & price every item server-side.
    const resolved: ResolvedItem[] = [];
    for (const item of items) {
      if (!item || (item.type !== 'mock' && item.type !== 'practice') || !item.id) {
        return NextResponse.json({ success: false, error: 'Invalid cart item' }, { status: 400 });
      }

      if (item.type === 'mock') {
        const { data: pack } = await supabase
          .from('token_packs')
          .select('id, exam_type, name, token_count, price, is_active')
          .eq('id', item.id)
          .eq('is_active', true)
          .single();

        if (!pack) {
          return NextResponse.json({ success: false, error: 'A mock pack in your cart is unavailable' }, { status: 404 });
        }

        const { data: examType } = await supabase
          .from('exam_types')
          .select('total_sets')
          .eq('id', pack.exam_type)
          .single();

        const totalSets = examType?.total_sets ?? 1;
        if (pack.token_count > totalSets) {
          return NextResponse.json(
            { success: false, error: `The ${pack.name} pack exceeds the ${totalSets} available test sets. Contact us for bulk purchases.` },
            { status: 400 },
          );
        }

        resolved.push({
          item_type: 'mock',
          ref_id: pack.id,
          unit_price: Number(pack.price),
          metadata: { name: pack.name, token_count: pack.token_count, exam_type: pack.exam_type },
        });
      } else {
        const { data: plan } = await supabase
          .from('subscription_plans')
          .select('id, name, price, duration_days, is_active')
          .eq('id', item.id)
          .eq('is_active', true)
          .single();

        if (!plan) {
          return NextResponse.json({ success: false, error: 'A plan in your cart is unavailable' }, { status: 404 });
        }

        resolved.push({
          item_type: 'practice',
          ref_id: plan.id,
          unit_price: Number(plan.price),
          metadata: { name: plan.name, duration_days: plan.duration_days },
        });
      }
    }

    const subtotal = resolved.reduce((sum, it) => sum + it.unit_price, 0);

    // Resolve a discount on the bundle total. The single code field accepts
    // either a partner referral code or a promo coupon — partner takes
    // precedence, then coupon. They never stack (one code field).
    let discountApplied = 0;
    let partnerId: string | null = null;
    let resolvedCode: string | null = null;
    let couponId: string | null = null;
    let couponCode: string | null = null;

    if (referralCode && typeof referralCode === 'string') {
      const code = referralCode.trim().toUpperCase();
      const { data: partner } = await supabase
        .from('partners')
        .select('id, discount_rate')
        .eq('referral_code', code)
        .eq('is_active', true)
        .single();

      if (partner) {
        discountApplied = Number(((subtotal * partner.discount_rate) / 100).toFixed(2));
        partnerId = partner.id;
        resolvedCode = code;
      } else {
        // Not a partner — try a promo coupon.
        const { data: coupon } = await supabase
          .from('coupons')
          .select('id, code, discount_percent, max_redemptions, redeemed_count, expires_at')
          .eq('code', code)
          .eq('is_active', true)
          .single();

        if (coupon) {
          const expired = coupon.expires_at && new Date(coupon.expires_at) <= new Date();
          const capReached = coupon.redeemed_count >= coupon.max_redemptions;
          const { data: prior } = await supabase
            .from('coupon_redemptions')
            .select('id')
            .eq('coupon_id', coupon.id)
            .eq('user_id', user.id)
            .maybeSingle();

          if (expired) {
            return NextResponse.json({ success: false, error: 'This code has expired.' }, { status: 400 });
          }
          if (prior) {
            return NextResponse.json({ success: false, error: 'You have already used this code.' }, { status: 400 });
          }
          if (capReached) {
            return NextResponse.json({ success: false, error: 'This code has reached its redemption limit.' }, { status: 400 });
          }

          discountApplied = Number(((subtotal * Number(coupon.discount_percent)) / 100).toFixed(2));
          couponId = coupon.id;
          couponCode = coupon.code;
        }
        // Unknown code → silently no discount (treat like a stale referral code).
      }
    }

    // Razorpay rejects orders below ₹1 (100 paise); a near-total discount must
    // still leave a payable minimum.
    const finalTotal = Math.max(Number((subtotal - discountApplied).toFixed(2)), 1);
    if (subtotal <= 0) {
      return NextResponse.json({ success: false, error: 'Invalid order total' }, { status: 400 });
    }

    // Parent purchase row (no single pack_id — line items live in purchase_items).
    const { data: purchase, error: purchaseError } = await supabase
      .from('token_purchases')
      .insert({
        user_id: user.id,
        pack_id: null,
        amount: finalTotal,
        currency: 'INR',
        status: 'pending',
        referral_code: resolvedCode,
        partner_id: partnerId,
        discount_applied: discountApplied,
        coupon_id: couponId,
        coupon_code: couponCode,
      })
      .select('id')
      .single();

    if (purchaseError || !purchase) {
      console.error('Failed to create bundle purchase:', purchaseError);
      return NextResponse.json({ success: false, error: 'Failed to initiate purchase' }, { status: 500 });
    }

    // Line items
    const { error: itemsError } = await supabase.from('purchase_items').insert(
      resolved.map((it) => ({
        purchase_id: purchase.id,
        item_type: it.item_type,
        ref_id: it.ref_id,
        unit_price: it.unit_price,
        quantity: 1,
        metadata: it.metadata,
      })),
    );

    if (itemsError) {
      console.error('Failed to create purchase items:', itemsError);
      return NextResponse.json({ success: false, error: 'Failed to initiate purchase' }, { status: 500 });
    }

    // Single Razorpay order for the whole bundle.
    const razorpay = new Razorpay({
      key_id: process.env.RAZORPAY_KEY_ID,
      key_secret: process.env.RAZORPAY_KEY_SECRET,
    });

    const order = await razorpay.orders.create({
      amount: Math.round(finalTotal * 100),
      currency: 'INR',
      receipt: `bdl_${purchase.id.slice(0, 16)}`,
      notes: {
        purchaseId: purchase.id,
        userId: user.id,
        itemCount: String(resolved.length),
        ...(partnerId ? { partnerId } : {}),
        ...(couponCode ? { couponCode } : {}),
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
      amount: finalTotal,
      subtotal,
      discountApplied,
      currency: 'INR',
    });
  } catch (error) {
    console.error('Error in POST /api/checkout/create-order:', error);
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Failed to create order' },
      { status: 500 },
    );
  }
}

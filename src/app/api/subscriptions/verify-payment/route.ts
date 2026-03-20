import { NextRequest, NextResponse } from 'next/server';
import nodeCrypto from 'crypto';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { generateBulkTokenCodes } from '@/lib/tokens/generate';
import { sendTransactionalEmail } from '@/lib/email/send';
import { subscriptionEmail } from '@/lib/email/templates';

export async function POST(request: NextRequest) {
  try {
    const { orderId, paymentId, signature, purchaseId, planId } = await request.json();

    if (!orderId || !paymentId || !signature || !purchaseId || !planId) {
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

    // Fetch purchase (include partner columns)
    const { data: purchase } = await supabase
      .from('token_purchases')
      .select('id, user_id, status, amount, partner_id, discount_applied')
      .eq('id', purchaseId)
      .single();

    if (!purchase || purchase.user_id !== user.id) {
      return NextResponse.json({ success: false, error: 'Purchase not found' }, { status: 404 });
    }
    if (purchase.status === 'completed') {
      return NextResponse.json({ success: false, error: 'Payment already processed' }, { status: 409 });
    }

    // Fetch plan
    const { data: plan } = await supabase
      .from('subscription_plans')
      .select('*')
      .eq('id', planId)
      .single();

    if (!plan) {
      return NextResponse.json({ success: false, error: 'Plan not found' }, { status: 404 });
    }

    // Create subscription
    const startsAt = new Date();
    const endsAt = new Date(startsAt.getTime() + plan.duration_days * 24 * 60 * 60 * 1000);

    await supabase.from('user_subscriptions').insert({
      user_id: user.id,
      plan_id: plan.id,
      starts_at: startsAt.toISOString(),
      ends_at: endsAt.toISOString(),
      is_active: true,
      purchase_id: purchase.id,
    });

    // If bundle, generate mock tokens
    let tokens: string[] = [];
    if (plan.plan_type === 'bundle' && plan.mock_tokens_included > 0) {
      const codes = generateBulkTokenCodes(plan.exam_type, plan.mock_tokens_included);

      const { data: examType } = await supabase
        .from('exam_types')
        .select('total_sets')
        .eq('id', plan.exam_type)
        .single();

      const totalSets = examType?.total_sets ?? 1;
      const batchId = nodeCrypto.randomUUID();

      const tokenRows = codes.map((code, i) => ({
        code,
        exam_type: plan.exam_type,
        set_number: (i % totalSets) + 2,
        is_free: false,
        owner_id: user.id,
        purchase_id: purchase.id,
        batch_id: batchId,
        is_active: true,
      }));

      await supabase.from('test_tokens').insert(tokenRows);
      tokens = codes;
    }

    // Mark purchase completed
    await supabase
      .from('token_purchases')
      .update({
        razorpay_payment_id: paymentId,
        status: 'completed',
        tokens_generated: tokens.length,
      })
      .eq('id', purchase.id);

    // Record partner commission if referral was used
    if (purchase.partner_id) {
      const paidAmount = Number(purchase.amount);
      const { data: partner } = await supabase
        .from('partners')
        .select('commission_rate')
        .eq('id', purchase.partner_id)
        .single();

      const commissionRate = partner?.commission_rate ?? 30;
      const commissionAmount = Number(((paidAmount * commissionRate) / 100).toFixed(2));

      await supabase.from('partner_commissions').insert({
        partner_id: purchase.partner_id,
        purchase_id: purchase.id,
        student_id: user.id,
        original_amount: plan.price,
        paid_amount: paidAmount,
        commission_amount: commissionAmount,
        status: 'pending',
      });
    }

    try {
      const { data: profile } = await supabase
        .from('profiles')
        .select('first_name, email')
        .eq('id', user.id)
        .single();

      const emailAddr = profile?.email || user.email || '';
      const firstName = profile?.first_name || '';

      if (emailAddr) {
        const { subject, html } = subscriptionEmail(
          firstName,
          plan.name,
          endsAt.toISOString(),
          tokens.length,
        );
        await sendTransactionalEmail({
          to: emailAddr,
          toName: firstName || undefined,
          subject,
          htmlBody: html,
        });
      }
    } catch (err) {
      console.error('Subscription email failed (non-blocking):', err);
    }

    return NextResponse.json({
      success: true,
      message: 'Subscription activated',
      planName: plan.name,
      endsAt: endsAt.toISOString(),
      tokens,
    });
  } catch (error) {
    console.error('Error in POST /api/subscriptions/verify-payment:', error);
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Verification failed' },
      { status: 500 }
    );
  }
}

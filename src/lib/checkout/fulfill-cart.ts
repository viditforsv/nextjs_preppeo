/**
 * Shared fulfillment for a unified bundle checkout (mocks + practice in one order).
 * Used by both:
 *   - /api/checkout/verify-payment    (client-initiated, user present)
 *   - /api/mocks/razorpay-webhook     (server-side fallback; cart-aware)
 *
 * Idempotent: returns early if the purchase is already completed.
 * Each product in the bundle is a row in `purchase_items` (item_type 'mock' | 'practice').
 */
import crypto from 'crypto';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { generateBulkTokenCodes } from '@/lib/tokens/generate';
import { sendTransactionalEmail } from '@/lib/email/send';

export interface FulfillCartResult {
  alreadyProcessed: boolean;
  tokens: string[];
  subscriptions: string[]; // names of activated plans
}

interface PurchaseItemRow {
  id: string;
  item_type: 'mock' | 'practice';
  ref_id: string;
  quantity: number;
}

export async function fulfillCartPurchase(
  purchaseId: string,
  razorpayPaymentId: string,
): Promise<FulfillCartResult> {
  const supabase = createSupabaseApiClient();

  // Parent purchase
  const { data: purchase, error: purchaseError } = await supabase
    .from('token_purchases')
    .select('id, user_id, status, amount, partner_id, coupon_id')
    .eq('id', purchaseId)
    .single();

  if (purchaseError || !purchase) {
    throw new Error('Purchase record not found');
  }

  // Idempotency
  if (purchase.status === 'completed') {
    return { alreadyProcessed: true, tokens: [], subscriptions: [] };
  }

  // Line items
  const { data: items, error: itemsError } = await supabase
    .from('purchase_items')
    .select('id, item_type, ref_id, quantity')
    .eq('purchase_id', purchase.id);

  if (itemsError) {
    throw new Error(`Failed to load purchase items: ${itemsError.message}`);
  }
  if (!items || items.length === 0) {
    throw new Error('No purchase items found for this order');
  }

  const allTokens: string[] = [];
  const activatedPlans: string[] = [];

  for (const item of items as PurchaseItemRow[]) {
    if (item.item_type === 'mock') {
      const codes = await fulfillMockItem(supabase, item, purchase.id, purchase.user_id);
      allTokens.push(...codes);
    } else if (item.item_type === 'practice') {
      const planName = await fulfillPracticeItem(supabase, item, purchase.id, purchase.user_id);
      if (planName) activatedPlans.push(planName);
    }
  }

  // Mark parent purchase completed
  await supabase
    .from('token_purchases')
    .update({
      razorpay_payment_id: razorpayPaymentId,
      status: 'completed',
      tokens_generated: allTokens.length,
    })
    .eq('id', purchase.id);

  // Claim the coupon slot — atomic + idempotent (unique coupon_id/user_id).
  // Runs only here, on a paid+completed order, so abandoned carts never
  // consume a slot. A false return (cap hit at the boundary, or re-fulfillment)
  // is harmless — the purchase is already honored.
  if (purchase.coupon_id) {
    const { error: redeemError } = await supabase.rpc('redeem_coupon', {
      p_coupon_id: purchase.coupon_id,
      p_user_id: purchase.user_id,
      p_purchase_id: purchase.id,
    });
    if (redeemError) {
      console.error('Coupon redemption claim failed (non-blocking):', redeemError);
    }
  }

  // Partner commission on the full bundle amount
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
      student_id: purchase.user_id,
      original_amount: paidAmount,
      paid_amount: paidAmount,
      commission_amount: commissionAmount,
      status: 'pending',
    });
  }

  // Confirmation email (non-blocking)
  await sendBundleEmail(supabase, purchase.user_id, allTokens, activatedPlans);

  return { alreadyProcessed: false, tokens: allTokens, subscriptions: activatedPlans };
}

// ── Mock item → generate tokens ────────────────────────────────────────────
async function fulfillMockItem(
  supabase: ReturnType<typeof createSupabaseApiClient>,
  item: PurchaseItemRow,
  purchaseId: string,
  userId: string,
): Promise<string[]> {
  const { data: pack } = await supabase
    .from('token_packs')
    .select('exam_type, token_count')
    .eq('id', item.ref_id)
    .single();

  if (!pack) throw new Error('Token pack not found during fulfillment');

  const { data: examType } = await supabase
    .from('exam_types')
    .select('total_sets')
    .eq('id', pack.exam_type)
    .single();

  const totalSets = examType?.total_sets ?? 1;
  const codes = generateBulkTokenCodes(pack.exam_type, pack.token_count);

  const expiresAt = new Date();
  expiresAt.setMonth(expiresAt.getMonth() + 6);

  const batchId = crypto.randomUUID();
  // Same set-assignment formula as src/lib/tokens/fulfill-purchase.ts.
  const tokenRows = codes.map((code, i) => ({
    code,
    exam_type: pack.exam_type,
    set_number: ((i + 1) % totalSets) + 1,
    is_free: false,
    owner_id: userId,
    purchase_id: purchaseId,
    batch_id: batchId,
    is_active: true,
    expires_at: expiresAt.toISOString(),
  }));

  const { error: insertError } = await supabase.from('test_tokens').insert(tokenRows);
  if (insertError) throw new Error(`Failed to insert tokens: ${insertError.message}`);

  await supabase.from('purchase_items').update({ fulfilled: true }).eq('id', item.id);
  return codes;
}

// ── Practice item → activate subscription ──────────────────────────────────
async function fulfillPracticeItem(
  supabase: ReturnType<typeof createSupabaseApiClient>,
  item: PurchaseItemRow,
  purchaseId: string,
  userId: string,
): Promise<string | null> {
  const { data: plan } = await supabase
    .from('subscription_plans')
    .select('id, name, duration_days')
    .eq('id', item.ref_id)
    .single();

  if (!plan) throw new Error('Subscription plan not found during fulfillment');

  const startsAt = new Date();
  const endsAt = new Date(startsAt.getTime() + plan.duration_days * 24 * 60 * 60 * 1000);

  await supabase.from('user_subscriptions').insert({
    user_id: userId,
    plan_id: plan.id,
    starts_at: startsAt.toISOString(),
    ends_at: endsAt.toISOString(),
    is_active: true,
    purchase_id: purchaseId,
  });

  await supabase.from('purchase_items').update({ fulfilled: true }).eq('id', item.id);
  return plan.name;
}

// ── Confirmation email ─────────────────────────────────────────────────────
async function sendBundleEmail(
  supabase: ReturnType<typeof createSupabaseApiClient>,
  userId: string,
  tokens: string[],
  plans: string[],
): Promise<void> {
  try {
    const { data: profile } = await supabase
      .from('profiles')
      .select('email, first_name')
      .eq('id', userId)
      .single();

    if (!profile?.email) return;

    const appUrl = process.env.NEXT_PUBLIC_APP_URL || 'https://preppeo.com';
    const greeting = profile.first_name ? `Hi ${profile.first_name},` : 'Hi,';

    const tokenSection = tokens.length
      ? `<h3 style="color:#0d47a1;margin-top:20px">Your ${tokens.length} mock access code${tokens.length > 1 ? 's' : ''}</h3>
         <ul style="list-style:none;padding:0;margin:12px 0">
           ${tokens
             .map(
               (c) =>
                 `<li style="padding:8px 0;border-bottom:1px solid #eee"><span style="font-family:monospace;font-size:16px;font-weight:600;letter-spacing:1px">${c}</span></li>`,
             )
             .join('')}
         </ul>
         <p style="font-size:13px;color:#666">Each code unlocks one full-length mock and is valid for 6 months.</p>`
      : '';

    const planSection = plans.length
      ? `<h3 style="color:#0d47a1;margin-top:20px">Practice access activated</h3>
         <p>${plans.join(', ')} — you now have unlimited practice access. Head to your SAT dashboard to start.</p>`
      : '';

    await sendTransactionalEmail({
      to: profile.email,
      toName: profile.first_name || undefined,
      subject: 'Your Preppeo purchase is confirmed',
      htmlBody: `
        <div style="font-family:sans-serif;max-width:600px;margin:0 auto">
          <h2 style="color:#0d47a1">Thank you for your purchase!</h2>
          <p>${greeting}</p>
          <p>Your plan is ready. Here's what you got:</p>
          ${tokenSection}
          ${planSection}
          <p style="margin-top:24px">
            <a href="${appUrl}/mocks" style="display:inline-block;padding:12px 24px;background:#0d47a1;color:#fff;text-decoration:none;border-radius:8px;font-weight:600">Go to your dashboard</a>
          </p>
          <p style="color:#999;font-size:12px;margin-top:24px">Manage everything anytime from <a href="${appUrl}/profile" style="color:#0d47a1">your profile</a>.</p>
        </div>
      `,
    });
  } catch (err) {
    console.error('Bundle confirmation email failed (non-blocking):', err);
  }
}

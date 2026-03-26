/**
 * Shared token fulfillment logic used by both:
 *  - /api/mocks/verify-payment  (client-initiated, user present)
 *  - /api/mocks/razorpay-webhook (server-side fallback)
 *
 * Idempotent: returns early if the purchase is already completed.
 */
import crypto from 'crypto';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { generateBulkTokenCodes } from '@/lib/tokens/generate';
import { sendTransactionalEmail } from '@/lib/email/send';

export interface FulfillResult {
  alreadyProcessed: boolean;
  codes: string[];
  examType: string;
  count: number;
}

export async function fulfillTokenPurchase(
  purchaseId: string,
  razorpayPaymentId: string,
): Promise<FulfillResult> {
  const supabase = createSupabaseApiClient();

  // Fetch purchase + pack details
  const { data: purchase, error: purchaseError } = await supabase
    .from('token_purchases')
    .select('id, user_id, pack_id, status, amount, partner_id, token_packs(exam_type, token_count, name, price)')
    .eq('id', purchaseId)
    .single();

  if (purchaseError || !purchase) {
    throw new Error('Purchase record not found');
  }

  // Idempotency: already fulfilled
  if (purchase.status === 'completed') {
    return { alreadyProcessed: true, codes: [], examType: '', count: 0 };
  }

  const pack = purchase.token_packs as unknown as {
    exam_type: string;
    token_count: number;
    name: string;
    price: number;
  };

  // Fetch exam metadata
  const { data: examType } = await supabase
    .from('exam_types')
    .select('total_sets, test_route, name')
    .eq('id', pack.exam_type)
    .single();

  const totalSets = examType?.total_sets ?? 1;
  const testRoute = examType?.test_route ?? '/mocks';

  // Generate codes
  const codes = generateBulkTokenCodes(pack.exam_type, pack.token_count);

  // expires_at = 6 months from now
  const expiresAt = new Date();
  expiresAt.setMonth(expiresAt.getMonth() + 6);

  // Set assignment: paid tokens start at set 2, wrap back to 1 last.
  // Formula: ((i + 1) % totalSets) + 1
  // e.g. totalSets=3 → 2, 3, 1  (set 2 first, no duplicates within a purchase)
  const batchId = crypto.randomUUID();
  const tokenRows = codes.map((code, i) => ({
    code,
    exam_type: pack.exam_type,
    set_number: ((i + 1) % totalSets) + 1,
    is_free: false,
    owner_id: purchase.user_id,
    purchase_id: purchase.id,
    batch_id: batchId,
    is_active: true,
    expires_at: expiresAt.toISOString(),
  }));

  const { error: insertError } = await supabase.from('test_tokens').insert(tokenRows);
  if (insertError) {
    throw new Error(`Failed to insert tokens: ${insertError.message}`);
  }

  // Mark purchase completed
  await supabase
    .from('token_purchases')
    .update({
      razorpay_payment_id: razorpayPaymentId,
      status: 'completed',
      tokens_generated: pack.token_count,
    })
    .eq('id', purchase.id);

  // Record partner commission
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
      original_amount: pack.price,
      paid_amount: paidAmount,
      commission_amount: commissionAmount,
      status: 'pending',
    });
  }

  // Fetch user email
  const { data: profile } = await supabase
    .from('profiles')
    .select('email')
    .eq('id', purchase.user_id)
    .single();

  if (profile?.email) {
    try {
      const appUrl = process.env.NEXT_PUBLIC_APP_URL || 'https://courses.preppeo.com';
      const examLabel = pack.exam_type.toUpperCase();
      const mockTestUrl = `${appUrl}${testRoute}`;
      const expiryStr = expiresAt.toLocaleDateString('en-IN', { day: 'numeric', month: 'long', year: 'numeric' });

      const tokenListHtml = codes
        .map((c, i) => `
          <li style="padding:8px 0;border-bottom:1px solid #eee">
            <span style="font-size:11px;color:#888;display:block;margin-bottom:2px">Mock Test #${((i + 1) % totalSets) + 1}</span>
            <span style="font-family:monospace;font-size:16px;font-weight:600;letter-spacing:1px">${c}</span>
          </li>`)
        .join('');

      await sendTransactionalEmail({
        to: profile.email,
        subject: `Your ${examLabel} Mock Access Codes`,
        htmlBody: `
          <div style="font-family:sans-serif;max-width:600px;margin:0 auto">
            <h2 style="color:#0d47a1">Your ${examLabel} Mock Tests</h2>
            <p>Thank you for your purchase! Here are your <strong>${codes.length}</strong> access code${codes.length > 1 ? 's' : ''}. Each code gives access to one full-length mock test.</p>
            <ul style="list-style:none;padding:0;margin:16px 0">${tokenListHtml}</ul>
            <p style="font-size:13px;color:#666">Codes are valid until <strong>${expiryStr}</strong>. They are transferable — each works once regardless of who uses it.</p>
            <p style="margin-top:20px">
              <a href="${mockTestUrl}" style="display:inline-block;padding:12px 24px;background:#0d47a1;color:#fff;text-decoration:none;border-radius:8px;font-weight:600">
                Start Your Mock Test
              </a>
            </p>
            <p style="color:#999;font-size:12px;margin-top:24px">
              Can't find your codes? Visit <a href="${appUrl}/profile" style="color:#0d47a1">your profile</a> anytime to view them.
            </p>
          </div>
        `,
      });
    } catch (err) {
      console.error('Token email failed:', err);
    }
  }

  return { alreadyProcessed: false, codes, examType: pack.exam_type, count: pack.token_count };
}

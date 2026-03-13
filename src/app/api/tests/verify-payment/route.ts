import { NextRequest, NextResponse } from 'next/server';
import nodeCrypto from 'crypto';
import { createClient } from '@/lib/supabase/server';
import { createSupabaseApiClient } from '@/lib/supabase/api-client';
import { generateBulkTokenCodes } from '@/lib/tokens/generate';
import { sendTransactionalEmail } from '@/lib/email/send';

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

    // Verify signature
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

    const supabase = createSupabaseApiClient();

    // Fetch purchase + pack details (include partner columns)
    const { data: purchase, error: purchaseError } = await supabase
      .from('token_purchases')
      .select('id, user_id, pack_id, status, amount, partner_id, discount_applied, token_packs(exam_type, token_count, name, price)')
      .eq('id', purchaseId)
      .single();

    if (purchaseError || !purchase) {
      return NextResponse.json(
        { success: false, error: 'Purchase record not found' },
        { status: 404 }
      );
    }

    if (purchase.user_id !== user.id) {
      return NextResponse.json(
        { success: false, error: 'Purchase does not belong to this user' },
        { status: 403 }
      );
    }

    if (purchase.status === 'completed') {
      return NextResponse.json(
        { success: false, error: 'Payment already processed' },
        { status: 409 }
      );
    }

    const pack = purchase.token_packs as unknown as { exam_type: string; token_count: number; name: string; price: number };

    // Generate token codes
    const codes = generateBulkTokenCodes(pack.exam_type, pack.token_count);

    // Assign set numbers round-robin across available sets
    const { data: examType } = await supabase
      .from('exam_types')
      .select('total_sets')
      .eq('id', pack.exam_type)
      .single();

    const totalSets = examType?.total_sets ?? 1;

    const batchId = nodeCrypto.randomUUID();
    const tokenRows = codes.map((code, i) => ({
      code,
      exam_type: pack.exam_type,
      set_number: (i % totalSets) + 2,
      is_free: false,
      owner_id: user.id,
      purchase_id: purchase.id,
      batch_id: batchId,
      is_active: true,
    }));

    const { error: insertError } = await supabase
      .from('test_tokens')
      .insert(tokenRows);

    if (insertError) {
      console.error('Failed to insert tokens:', insertError);
      return NextResponse.json(
        { success: false, error: 'Failed to generate tokens' },
        { status: 500 }
      );
    }

    // Update purchase record
    await supabase
      .from('token_purchases')
      .update({
        razorpay_payment_id: paymentId,
        status: 'completed',
        tokens_generated: pack.token_count,
      })
      .eq('id', purchase.id);

    // Record partner commission if referral was used
    if (purchase.partner_id) {
      const paidAmount = Number(purchase.amount);
      const originalAmount = pack.price;

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
        original_amount: originalAmount,
        paid_amount: paidAmount,
        commission_amount: commissionAmount,
        status: 'pending',
      });
    }

    // Email tokens to the buyer (non-blocking)
    if (user.email) {
      const appUrl = process.env.NEXT_PUBLIC_APP_URL || 'https://courses.preppeo.com';
      const examLabel = pack.exam_type.toUpperCase();
      const tokenListHtml = codes
        .map((c) => `<li style="font-family:monospace;font-size:16px;padding:4px 0">${c}</li>`)
        .join('');

      sendTransactionalEmail({
        to: user.email,
        subject: `Your ${examLabel} Test Access Codes`,
        htmlBody: `
          <div style="font-family:sans-serif;max-width:600px;margin:0 auto">
            <h2 style="color:#0d47a1">Your ${examLabel} Access Codes</h2>
            <p>Thank you for your purchase! Here are your <strong>${codes.length}</strong> access code${codes.length > 1 ? 's' : ''}:</p>
            <ul style="list-style:none;padding:0">${tokenListHtml}</ul>
            <p style="margin-top:16px">
              <a href="${appUrl}/sat-test" style="display:inline-block;padding:12px 24px;background:#0d47a1;color:#fff;text-decoration:none;border-radius:8px;font-weight:600">
                Start Your Test
              </a>
            </p>
            <p style="color:#666;font-size:13px;margin-top:24px">
              You can share these codes with others — each code works once regardless of who uses it.
            </p>
          </div>
        `,
      }).catch((err) => console.error('Token email failed:', err));
    }

    return NextResponse.json({
      success: true,
      message: 'Payment verified and tokens generated',
      tokens: codes,
      examType: pack.exam_type,
      count: pack.token_count,
    });
  } catch (error) {
    console.error('Error in POST /api/tests/verify-payment:', error);
    return NextResponse.json(
      { success: false, error: error instanceof Error ? error.message : 'Verification failed' },
      { status: 500 }
    );
  }
}
